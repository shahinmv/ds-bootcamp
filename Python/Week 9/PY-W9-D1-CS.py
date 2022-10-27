from operator import index
import streamlit as st
import pandas as pd
import numpy as np
from sklearn.impute import SimpleImputer
import plotly.express as px
import os
from sklearn.preprocessing import StandardScaler, RobustScaler, LabelEncoder
from sklearn.model_selection import train_test_split
import xgboost as xgb
from sklearn.linear_model import LogisticRegression
from sklearn.metrics import accuracy_score, confusion_matrix, classification_report

st.set_page_config(layout="wide", page_title="Case Study")

st.title("Python - Week 9 - Day 1 - CS")
st.text("Shahin Mammadov")

dataset=st.sidebar.selectbox("Select dataset", ['Loan Prediction', 'Water Portability'])
menu = st.sidebar.selectbox("Select page", ["Homepage", "EDA", "Modeling"])

if menu=='Homepage':
    st.header('Homepage')

    if dataset=='Loan Prediction':
        st.info("""
        **Loan_ID**: Unique Loan ID

        **Gender**: Male/ Female

        **Married**: Applicant married (Y/N)

        **Dependents**: Number of dependents

        **Education**: Applicant Education (Graduate/ Under Graduate)

        **Self_Employed**: Self employed (Y/N)

        **ApplicantIncome**: Applicant income

        **CoapplicantIncome**: Coapplicant income

        **LoanAmount**: Loan amount in thousands
        
        **Loan_Amount_Term**: Term of loan in months

        **Credit_History**: credit history meets guidelines

        **Property_Area**: Urban/ Semi Urban/ Rural
        
        **Loan_Status**: (Target) Loan approved (Y/N)
        """)
    else:
        st.info("""
        Something about water potability.
        """)
elif menu=="EDA":
    st.header('Exploratory Data Analysis')

    def outlier_treatment(datacolumn):
        sorted(datacolumn)
        Q1, Q3 = np.percentile(datacolumn, [25,75])
        IQR = Q3-Q1
        lower_range = Q1 - (1.5*IQR)
        upper_range = Q3 + (1.5*IQR)
        return lower_range, upper_range

    def describeStat(data):
        st.dataframe(data)
        st.subheader("Statistical Values")
        data.describe().T

        st.subheader("Balance of Data")
        if dataset=="Loan Prediction":
            st.bar_chart(data.Loan_Status.value_counts())
        else: 
            st.bar_chart(data.Potability.value_counts())

        null_df=data.isnull().sum().to_frame().reset_index()
        null_df.columns=["Columns", "Counts"]

        c_eda1,c_eda2,c_eda3=st.columns([2.5, 1.5, 2.5])

        c_eda1.subheader('Null Variables')
        c_eda1.dataframe(null_df)

        c_eda2.subheader("Imputation")
        cat_method=c_eda2.radio('Categorical', ["Node", "Backfill", "Ffill"])
        num_method=c_eda2.radio('Numerical', ['Mode', 'Median'])

        c_eda2.subheader("Feature Engineering")
        outlier_problem=c_eda2.checkbox('Clean Outlier')

        if c_eda2.button("Data preprocessing"):
            try:
                cat_array=data.iloc[:, :-1].select_dtypes(include="object").columns
                num_array=data.iloc[:, :-1].select_dtypes(exclude="object").columns

                if cat_method=="Mode":
                    imp_cat=SimpleImputer(missing_values=np.nan, strategy='most_frequent')
                    data[cat_array]=imp_cat.fit_transform(data[cat_array])
                elif cat_method=="Backfill":
                    data[cat_array].fillna(method='backfill', inplace=True)
                else:
                    data[cat_array].fillna(method='ffill', inplace=True)

                if num_method=="Mode":
                    imp_num=SimpleImputer(missing_values=np.nan, strategy='most_frequent')
                else:
                    imp_num=SimpleImputer(missing_values=np.nan, strategy='median')
                data[num_array]=imp_num.fit_transform(data[num_array])

                data.dropna(axis=0, inplace=True)

                if outlier_problem:
                    for col in num_array:
                        lowerbound,upperbound = outlier_treatment(data[col])
                        data[col]=np.clip(data[col], a_min=lowerbound,a_max=upperbound)
                
                null_df=data.isnull().sum().to_frame().reset_index()
                null_df.columns=["Columns", "Counts"]
                c_eda3.subheader("Null Variables")
                c_eda3.dataframe(null_df)
                #st.subheader("Balance of Data")
                #st.bar_chart(data.iloc[:, -1].value_counts())

                st.success('Data processing has been successful!', icon="✅")

                heatmap=px.imshow(data.corr())
                st.plotly_chart(heatmap)
                st.dataframe(data)

                if os.path.exists("temp.csv"):
                    os.remove("temp.csv")
                data.to_csv("temp.csv", index=False)
                
            except Exception as e:
                st.warning(f'Error! Data processing has not finished successfully.{e}', icon="⚠️")

    if dataset=="Loan Prediction":
        data=pd.read_csv("loan_pred.csv")
        describeStat(data)
    else: 
        data=pd.read_csv("water_potability.csv")
        describeStat(data)
else:
    data=pd.read_csv("temp.csv")
    st.dataframe(data)

    c_model1,c_model2=st.columns(2)

    c_model1.subheader("Scaling")
    scaling_method=c_model1.radio('', ["Standart", "Robust"])
    
    c_model2.subheader("Encoders")
    encoder_method=c_model2.radio('', ["Label", "One-Hot"])
    
    st.header("Train and test splitting")
    c_model1_1, c_model1_2=st.columns(2)
    test_size=c_model1_1.text_input("Test set", value=80)
    train_set=c_model1_2.text_input("Train set", value=100-int(test_size), disabled=True)

    model=st.selectbox("Select model", ["Logistic Regression", "Xgboost"])
    st.markdown("Selected:   **{0}** model".format(model))

    if st.button("Run model"):
        cat_array=data.iloc[:,:-1].select_dtypes(include="object").columns
        num_array=data.iloc[:,:-1].select_dtypes(exclude="object").columns

        if scaling_method=="Standart":
            sc=StandardScaler()
        else:
            sc=RobustScaler()
        data[num_array]=sc.fit_transform(data[num_array])

        if encoder_method=="Label":
            print('label')
            lb=LabelEncoder()
            for col in cat_array:
                data[col]=lb.fit_transform(data[col])
            print(data)
        else:
            print('onehot')
            data.drop(data.iloc[:,[-1]], axis=1, inplace=True)
            dms_df=data[cat_array]
            dms_df=pd.get_dummies(dms_df, drop_first=True)
            df_=data.drop(cat_array, axis=1)
            df=pd.concat([df_, dms_df, data[-1]], axis=1)
            print(data)

        st.dataframe(data)

        if dataset=="Loan Prediction":
            X = data.drop(columns=['Loan_Status'])
            y = data.Loan_Status
        else: 
            X = data.drop(columns=['Potability'])
            y = data.Potability

        X_train, X_test, y_train, y_test=train_test_split(X, y, test_size=float(test_size)/100, random_state=42)

        if model=="Xgboost":
            model=xgb.XGBClassifier().fit(X_train, y_train)
        else:
            model=LogisticRegression().fit(X_train, y_train)

        y_pred=model.predict(X_test)
        
        accuracy = accuracy_score(y_test, y_pred)
        st.markdown("Accuracy score: " + str(round(accuracy, 2)))

        st.markdown('Confusion Matrix')
        st.write(confusion_matrix(y_test, y_pred))

        report = classification_report(y_test, y_pred, output_dict=True)
        df_report=pd.DataFrame(report).transpose()

        st.dataframe(df_report)
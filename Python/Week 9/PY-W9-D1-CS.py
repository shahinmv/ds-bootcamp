from xml.etree.ElementInclude import include
import streamlit as st
import pandas as pd
import numpy as np

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
elif menu=="EDA":
    st.header('Exploratory Data Analysis')

    def describeStat(data):
        st.dataframe(data)
        st.subheader("Statistical Values")
        data.describe().T

        st.subheader("Balance of Data")
        st.bar_chart(data.Loan_Status.value_counts())

        null_df=data.isnull().sum().to_frame().reset_index()
        null_df.columns=["Columns", "Counts"]

        c_eda1,c_eda2,c_eda3=st.columns([2.5, 1.5, 2.5])

        c_eda1.subheader('Null Variables')
        c_eda1.dataframe(null_df)

        c_eda2.subheader("Imputation")
        cat_method=c_eda2.radio('Categorical', ["Node", "Backfill", "Ffill"])
        num_method=c_eda2.radio('Numerical', ['Mode', 'Median'])

        c_eda2.subheader("Feature Engineering")
        balance_problem=c_eda2.checkbox('Under Sampling')
        outlier_problem=c_eda2.checkbox('Clean Outlier')

        if c_eda2.button("Data preprocessing"):
            cat_array=data.iloc[:, :-1].select_dtypes(include="object").columns
            num_array=data.iloc[:, :-1].select_dtypes(exclude="object").columns

            if cat_method=="Mode":
                imp_cat=SimpleImputer(missing_values=np.nan, strat)

    if dataset=="Loan Prediction":
        data=pd.read_csv("loan_prediction.csv")
        describeStat(data)

    
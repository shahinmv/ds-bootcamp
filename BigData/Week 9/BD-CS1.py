from mrjob.job import MRJob

class MRTemperature(MRJob):
    def mapper(self, _, line):
        data=line.split()
        for item in data:
            if float(item[1]) >= 37:
                yield item[0], item[1]
    def reducer(self, key, values):
        yield key, sum(values)

if __name__ == '__main__':
    MRTemperature.run()
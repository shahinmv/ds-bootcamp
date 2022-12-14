from mrjob.job import MRJob

class MRTemperature(MRJob):
    def mapper(self, _, line):
        if float(line.split()[1]) >= 37:
            yield line.split()[0], float(line.split()[1])
    def reducer(self, key, values):
        yield key, sum(values)

if __name__ == '__main__':
    MRTemperature.run()
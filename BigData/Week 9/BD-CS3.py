from mrjob.job import MRJob

class MRWordFrequency(MRJob):
    def mapper(self, _, line):
        yield line.split(), 1
    def reducer(self, key, values):
        yield key, sum(values)

if __name__ == '__main__':
    MRWordFrequency.run()
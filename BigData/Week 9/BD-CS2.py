from mrjob.job import MRJob

class Cards(MRJob):
    def mapper(self, _, line):
        data = line.split(',')
        yield data[1], 1
    def reducer(self, key, values):
        yield key, sum(values)

if __name__ == '__main__':
    Cards.run()
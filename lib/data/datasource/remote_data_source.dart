abstract class RemoteDataSource <T> { // <T> mean it is a generic type
  Future<T> fetchData(String endpoint);
}
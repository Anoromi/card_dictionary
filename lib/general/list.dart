extension Map<T> on List<T> {
  List<G> mapList<G>(G Function(T v) map) {
    return this.map(map).toList();
  }
}

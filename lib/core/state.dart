import 'package:hooks_riverpod/hooks_riverpod.dart';

final provCot = ProviderContainer();

// tabs

final tabProvider =
    StateNotifierProvider<TabState, List<File>>((ref) => TabState());

class File {
  final String name;
  final String path;
  final String ext;

  const File(this.name, this.path, this.ext);
}

class TabState extends StateNotifier<List<File>> {
  TabState() : super([]);

  void addTab(File file) => state = [...state, file];

  bool contains(String path) {
    for (final file in state) {
      if (file.path == path) {
        return true;
      }
    }
    return false;
  }
}

// cache for unsaved changes
final fileCache = StateNotifierProvider<FileCacheState, Map<String, String>>(
    (ref) => FileCacheState());

class FileCacheState extends StateNotifier<Map<String, String>> {
  FileCacheState() : super({});

  void add(String filePath, String content) {
    if (state.containsKey(filePath)) {
      update(filePath, content);
    } else {
      state = {...state, filePath: content};
    }
  }

  void update(String filePath, String content) {
    Map<String, String> copyOfState = state;
    copyOfState.update(filePath, (value) => content);
    state = copyOfState;
  }

  void remove(String filePath) {
    Map<String, String> copyOfState = state;
    copyOfState.remove(filePath);
    state = copyOfState;
  }

  bool exists(String filePath) => state.containsKey(filePath);

  String cachedFileContent(String filePath) => state[filePath] as String;
}

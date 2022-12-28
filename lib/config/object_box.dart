import '../models/post_model.dart';
import '../models/user_model.dart';
import '../objectbox.g.dart';

class ObjectBox {
  late final Store store;
  late final Admin _admin;
  late final Box<PostModel> _postModelBox;
  late final Box<UserModel> _userModelBox;

// Store ko init krwana ka liya
  ObjectBox._init(this.store) {
    if (Admin.isAvailable()) {
      // Keep a reference until no longer needed or manually closed.
      _admin = Admin(store);
    }
    //  store initialize hu gya ha
    _postModelBox = Box<PostModel>(store);
    _userModelBox = Box<UserModel>(store);

  }

// ye besically initialise karwa raha ha
  static Future<ObjectBox> init() async {
    // jo store bnaya ha usko open kar dain ga
    final store = await openStore();
    ObjectBox obj = ObjectBox._init(store);
    return obj;
  }

  /// POST MODEL CURD......
  // Query Data
  //
  List<PostModel> getAllPostOfUser(int userId) {
    final query = _postModelBox.query(PostModel_.userId.equals(userId)).build();
    List<PostModel> list = query.find();
    return list;
  }

  insertPostModel(PostModel detail) {
    _postModelBox.put(detail);
  }

// PostModel ki list enter hu gai ha putMany ik function ha ta kh data utha lain iko bari
  insertAllPostModel(List<PostModel> postList) {
    _postModelBox.putMany(postList);
  }

  List<PostModel> getAllPostModel() {
    return _postModelBox.getAll();
  }

  // check the data in post
  int getPostModelCount() {
    return _postModelBox.count();
  }

  /// USER MODEL CURD...

  List<UserModel> getAllUser(int id) {
    final query = _userModelBox.query(UserModel_.id.equals(id)).build();

    List<UserModel> list = query.find();
    return list;
  }

  insertUserModel(UserModel detailUser) {
    _userModelBox.put(detailUser);
  }

  insertAllUserModel(List<UserModel> userList) {
    _userModelBox.putMany(userList);
  }

  List<UserModel> getAllUserModel() {
    return _userModelBox.getAll();
  }

  int getUserModelCount() {
    return _userModelBox.count();
  }

  Stream<List<PostModel>> getAllPostOfUsersListStream(int userId) => _postModelBox
      .query(PostModel_.userId.equals(userId))
      .watch(triggerImmediately: true)
      .map((query) => query.find());

  Stream<List<PostModel>> getPostOfListStream() =>
      _postModelBox
      .query()
      .watch(triggerImmediately: true)
      .map((query) => query.find());

}

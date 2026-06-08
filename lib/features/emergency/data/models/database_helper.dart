import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'emergency_signal_model.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'emergency_signals.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(EmergencySignalModel.createTable());
  }

  // CRUD operations
  Future<int> insertEmergencySignal(EmergencySignalModel signal) async {
    final db = await database;
    return await db.insert(
      EmergencySignalModel.tableName,
      signal.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<EmergencySignalModel>> getEmergencySignals() async {
    final db = await database;
    final maps = await db.query(EmergencySignalModel.tableName);

    return List.generate(maps.length, (i) {
      return EmergencySignalModel.fromMap(maps[i]);
    });
  }

  Future<EmergencySignalModel?> getEmergencySignalById(String signalId) async {
    final db = await database;
    final maps = await db.query(
      EmergencySignalModel.tableName,
      where: 'signalId = ?',
      whereArgs: [signalId],
    );

    if (maps.isNotEmpty) {
      return EmergencySignalModel.fromMap(maps.first);
    }
    return null;
  }

  Future<int> updateEmergencySignal(EmergencySignalModel signal) async {
    final db = await database;
    return await db.update(
      EmergencySignalModel.tableName,
      signal.toMap(),
      where: 'signalId = ?',
      whereArgs: [signal.signalId],
    );
  }

  Future<int> deleteEmergencySignal(String signalId) async {
    final db = await database;
    return await db.delete(
      EmergencySignalModel.tableName,
      where: 'signalId = ?',
      whereArgs: [signalId],
    );
  }

  Future<List<EmergencySignalModel>> getUnsyncedSignals() async {
    final db = await database;
    final maps = await db.query(
      EmergencySignalModel.tableName,
      where: 'isSynced = ?',
      whereArgs: [0],
    );

    return List.generate(maps.length, (i) {
      return EmergencySignalModel.fromMap(maps[i]);
    });
  }

  Future<int> markAsSynced(String signalId) async {
    final db = await database;
    return await db.update(
      EmergencySignalModel.tableName,
      {'isSynced': 1},
      where: 'signalId = ?',
      whereArgs: [signalId],
    );
  }

  Future<void> close() async {
    final db = await database;
    db.close();
  }
}
class AppConfig {
  const AppConfig({
    required this.supabaseUrl,
    required this.supabaseKey,
    this.vaultSnapshotsTable = 'vault_snapshots',
  });

  factory AppConfig.fromEnvironment() {
    const supabaseUrl = String.fromEnvironment('SUPABASE_URL');
    const anonKey = String.fromEnvironment('SUPABASE_ANON_KEY');
    const publishableKey = String.fromEnvironment('SUPABASE_PUBLISHABLE_KEY');
    const vaultSnapshotsTable = String.fromEnvironment(
      'SUPABASE_VAULT_TABLE',
      defaultValue: 'vault_snapshots',
    );

    return AppConfig(
      supabaseUrl: supabaseUrl,
      supabaseKey: anonKey.isNotEmpty ? anonKey : publishableKey,
      vaultSnapshotsTable: vaultSnapshotsTable,
    );
  }

  final String supabaseUrl;
  final String supabaseKey;
  final String vaultSnapshotsTable;

  bool get hasSupabase =>
      supabaseUrl.trim().isNotEmpty && supabaseKey.trim().isNotEmpty;
}

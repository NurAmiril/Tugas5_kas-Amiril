import 'package:flutter/material.dart';
import 'package:kas_personal/models/kas.dart';
import 'package:kas_personal/providers/kas_provider.dart';
import 'package:provider/provider.dart';

class KasScreen extends StatefulWidget {
  const KasScreen({super.key});

  @override
  State<KasScreen> createState() => _KasScreenState();
}

class _KasScreenState extends State<KasScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Semua Transaksi'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Consumer<KasProvider>(
        builder: (context, kasProvider, child) {
          final items = kasProvider.items;
          double pemasukkan = 0;
          double pengeluaran = 0;

          for (var kas in items) {
            if (kas.jenis == JenisKas.kasMasuk) {
              pemasukkan += kas.nominal;
            } else {
              pengeluaran += kas.nominal;
            }
          }

          double saldo = pemasukkan - pengeluaran;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 112, 240, 116),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            const Text(
                              'Pemasukan',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'IDR ${pemasukkan.round()}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 248, 153, 112),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            const Text(
                              'Pengeluaran',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'IDR ${pengeluaran.round()}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 158, 223, 224),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            const Text(
                              'Sisa',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'IDR ${saldo.round()}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(10),
                  itemCount: items.length,
                  separatorBuilder: (context, index) => const Divider(
                    height: 0,
                    color: Colors.grey,
                  ),
                  itemBuilder: (context, index) {
                    final kas = items[index];

                    return ListTile(
                      leading: Icon(
                        kas.jenis == JenisKas.kasMasuk
                            ? Icons.add_circle
                            : Icons.remove_circle,
                        color: kas.jenis == JenisKas.kasMasuk
                            ? Colors.green
                            : Colors.red,
                      ),
                      title: Text(
                        'IDR ${kas.nominal.round()}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: kas.jenis == JenisKas.kasMasuk
                              ? Colors.green
                              : Colors.red,
                        ),
                      ),
                      subtitle: Text(kas.keterangan),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
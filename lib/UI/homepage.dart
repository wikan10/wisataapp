import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Tempat Wisata'),
      ),
      body: DestinationList(),
    );
  }
}

// Widget untuk menampilkan daftar destinasi sesuai dengan lebar layar
class DestinationList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Memeriksa lebar layar menggunakan constraints.maxWidth
        if (constraints.maxWidth < 600) {
          // Jika lebar layar kurang dari 600 (mode tampilan ponsel), tampilkan MobileDestinationList
          return MobileDestinationList();
        } else {
          // Jika lebar layar 600 atau lebih (mode tampilan desktop), tampilkan DesktopDestinationGrid
          return DestinationGrid();
        }
      },
    );
  }
}

// Widget untuk menampilkan daftar destinasi dalam mode tampilan ponsel
class MobileDestinationList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: destinations.length, // Jumlah item yang akan ditampilkan
      itemBuilder: (context, index) {
        // Membuat item destinasi menggunakan DestinationListItem untuk setiap indeks
        return DestinationListItem(
          destination: destinations[
              index], // Mengirimkan data destinasi ke widget DestinationListItem
        );
      },
    );
  }
}

// Widget untuk menampilkan daftar destinasi dalam mode tampilan grid
class DestinationGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int crossAxisCount = (MediaQuery.of(context).size.width / 200).floor();
    // Menghitung jumlah kolom grid berdasarkan lebar layar

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount, // Jumlah kolom dalam grid
        childAspectRatio: 4 / 4, // Rasio aspek item grid (persegi)
      ),
      itemCount: destinations.length, // Jumlah item yang akan ditampilkan
      itemBuilder: (context, index) {
        // Membuat item destinasi menggunakan DestinationGridItem untuk setiap indeks
        return DestinationGridItem(
          destination: destinations[
              index], // Mengirimkan data destinasi ke widget DestinationGridItem
        );
      },
    );
  }
}

class DestinationListItem extends StatelessWidget {
  final Destination destination;

  DestinationListItem({required this.destination});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPage(destination: destination),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        elevation: 1,
        child: ListTile(
          contentPadding: EdgeInsets.all(6),
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(2),
            child: Image.asset(
              destination.imageUrl,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          title: Text(
            destination.name,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            destination.location,
            style: TextStyle(
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}

class DestinationGridItem extends StatelessWidget {
  final Destination destination;

  DestinationGridItem({required this.destination});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPage(destination: destination),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        elevation: 1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.asset(
                  destination.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                destination.name,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Text(
                destination.location,
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Destination {
  final String name;
  final String location;
  final String imageUrl;
  final String description;

  Destination({
    required this.name,
    required this.location,
    required this.imageUrl,
    required this.description,
  });
}

List<Destination> destinations = [
  Destination(
    name: 'Pantai Kuta',
    location: 'Bali, Indonesia',
    imageUrl: 'assets/pantaikuta.jpg',
    description:
        'Pantai Kuta adalah sebuah tempat pariwisata yang terletak di kecamatan Kuta sebelah selatan Kota Denpasar, Bali, Indonesia. Daerah ini merupakan sebuah tujuan wisata turis mancanegara dan telah menjadi objek wisata andalan Pulau Bali sejak awal tahun 1970-an. Pantai Kuta sering pula disebut sebagai pantai matahari terbenam sebagai lawan dari pantai Sanur. Selain itu, Lapangan Udara I Gusti Ngurah Rai terletak tidak jauh dari Kuta.',
  ),
  Destination(
    name: 'Candi Borobudur',
    location: 'Magelang, Indonesia',
    imageUrl: 'assets/borobudur.jpg',
    description:
        'Candi Borobudur (bahasa Jawa: ꦕꦟ꧀ꦝꦶꦧꦫꦧꦸꦝꦸꦂ, translit. Candhi Båråbudhur) adalah sebuah candi Buddha yang terletak di Borobudur, Magelang, Jawa Tengah, Indonesia. Candi ini terletak kurang lebih 100 km di sebelah barat daya Semarang, 86 km di sebelah barat Surakarta, dan 40 km di sebelah barat laut Yogyakarta. Candi dengan banyak stupa ini didirikan oleh para penganut agama Buddha Mahayana sekitar tahun 800-an Masehi pada masa pemerintahan wangsa Syailendra. Borobudur adalah candi atau kuil Buddha terbesar di dunia,[1][2] sekaligus salah satu monumen Buddha terbesar di dunia.',
  ),
  Destination(
    name: 'Danau Toba',
    location: 'Sumatra Utara, Indonesia',
    imageUrl: 'assets/danautoba.jpg',
    description:
        'Danau Toba adalah danau alami berukuran besar di Indonesia yang terletak di kaldera gunung supervulkan. Danau ini memiliki panjang 100 kilometer (62 mil), lebar 30 kilometer (19 mi), dan kedalaman 508 meter (1.667 ft). Danau ini terletak di tengah pulau Sumatra bagian utara dengan ketinggian permukaan sekitar 900 meter (2.953 ft). Danau ini membentang vdari 2.88°N 98.52°E sampai 2.35°N 99.1°E. Danau Toba merupakan adalah danau terbesar di Indonesia sekaligus danau vulkanik terbesar di dunia.',
  ),
  Destination(
    name: 'Gunung Bromo',
    location: 'Jawa Timur, Indonesia',
    imageUrl: 'assets/bromo.jpg',
    description:
        'Gunung Bromo, sebuah gunung berapi aktif dengan pemandangan menakjubkan di Jawa Timur.',
  ),
  Destination(
    name: 'Kawah Ijen',
    location: 'Jawa Timur, Indonesia',
    imageUrl: 'assets/kawah.jpg',
    description: 'Kawah belerang dengan api biru yang unik di Jawa Timur.',
  ),
  Destination(
    name: 'Nusa Dua',
    location: 'Bali, Indonesia',
    imageUrl: 'assets/nusadua.jpg',
    description:
        'Nusa Dua adalah kawasan resor yang dibangun pada tahun 1970an di bagian selatan Bali , Indonesia . [1] Dikenal sebagai kawasan resor bintang lima yang besar, kawasan ini mencakup lahan seluas 350 hektar dan mencakup lebih dari 20 resor. [2] Terletak 22 kilometer dari Denpasar , ibu kota provinsi Bali, dan dikelola sebagai bagian dari kecamatan ( kelurahan ) Benoa di Kuta Selatan , Kabupaten Badung . Nusa Dua artinya dua pulau ( nusa "pulau", dua "), karena terdapat dua pulau di teluk kawasan Bali Tourism Development Corporation. Di sisi selatan terletak Pulau Peninsula, dan di sisi utara terletak Pulau Nusa Dharma yang lebih kecil namun lebih teduh dan berisi Pura/Pura Nusa Dharma.',
  ),
  Destination(
    name: 'Taman Nasional Ujung Kulon',
    location: 'Banten, Indonesia',
    imageUrl: 'assets/ujungkulon.jpg',
    description:
        'Taman nasional yang terkenal dengan badak Jawa yang terancam punah.',
  ),
  Destination(
    name: 'Pantai Kuta',
    location: 'Bali, Indonesia',
    imageUrl: 'assets/pantaikuta.jpg',
    description:
        'Pantai Kuta adalah sebuah tempat pariwisata yang terletak di kecamatan Kuta sebelah selatan Kota Denpasar, Bali, Indonesia. Daerah ini merupakan sebuah tujuan wisata turis mancanegara dan telah menjadi objek wisata andalan Pulau Bali sejak awal tahun 1970-an. Pantai Kuta sering pula disebut sebagai pantai matahari terbenam sebagai lawan dari pantai Sanur. Selain itu, Lapangan Udara I Gusti Ngurah Rai terletak tidak jauh dari Kuta.',
  ),
  Destination(
    name: 'Candi Borobudur',
    location: 'Magelang, Indonesia',
    imageUrl: 'assets/borobudur.jpg',
    description:
        'Candi Borobudur (bahasa Jawa: ꦕꦟ꧀ꦝꦶꦧꦫꦧꦸꦝꦸꦂ, translit. Candhi Båråbudhur) adalah sebuah candi Buddha yang terletak di Borobudur, Magelang, Jawa Tengah, Indonesia. Candi ini terletak kurang lebih 100 km di sebelah barat daya Semarang, 86 km di sebelah barat Surakarta, dan 40 km di sebelah barat laut Yogyakarta. Candi dengan banyak stupa ini didirikan oleh para penganut agama Buddha Mahayana sekitar tahun 800-an Masehi pada masa pemerintahan wangsa Syailendra. Borobudur adalah candi atau kuil Buddha terbesar di dunia,[1][2] sekaligus salah satu monumen Buddha terbesar di dunia.',
  ),
  Destination(
    name: 'Danau Toba',
    location: 'Sumatra Utara, Indonesia',
    imageUrl: 'assets/danautoba.jpg',
    description:
        'Danau Toba adalah danau alami berukuran besar di Indonesia yang terletak di kaldera gunung supervulkan. Danau ini memiliki panjang 100 kilometer (62 mil), lebar 30 kilometer (19 mi), dan kedalaman 508 meter (1.667 ft). Danau ini terletak di tengah pulau Sumatra bagian utara dengan ketinggian permukaan sekitar 900 meter (2.953 ft). Danau ini membentang vdari 2.88°N 98.52°E sampai 2.35°N 99.1°E. Danau Toba merupakan adalah danau terbesar di Indonesia sekaligus danau vulkanik terbesar di dunia.',
  ),
  Destination(
    name: 'Gunung Bromo',
    location: 'Jawa Timur, Indonesia',
    imageUrl: 'assets/bromo.jpg',
    description:
        'Gunung Bromo, sebuah gunung berapi aktif dengan pemandangan menakjubkan di Jawa Timur.',
  ),
  Destination(
    name: 'Kawah Ijen',
    location: 'Jawa Timur, Indonesia',
    imageUrl: 'assets/kawah.jpg',
    description: 'Kawah belerang dengan api biru yang unik di Jawa Timur.',
  ),
  Destination(
    name: 'Nusa Dua',
    location: 'Bali, Indonesia',
    imageUrl: 'assets/nusadua.jpg',
    description:
        'Nusa Dua adalah kawasan resor yang dibangun pada tahun 1970an di bagian selatan Bali , Indonesia . [1] Dikenal sebagai kawasan resor bintang lima yang besar, kawasan ini mencakup lahan seluas 350 hektar dan mencakup lebih dari 20 resor. [2] Terletak 22 kilometer dari Denpasar , ibu kota provinsi Bali, dan dikelola sebagai bagian dari kecamatan ( kelurahan ) Benoa di Kuta Selatan , Kabupaten Badung . Nusa Dua artinya dua pulau ( nusa "pulau", dua "), karena terdapat dua pulau di teluk kawasan Bali Tourism Development Corporation. Di sisi selatan terletak Pulau Peninsula, dan di sisi utara terletak Pulau Nusa Dharma yang lebih kecil namun lebih teduh dan berisi Pura/Pura Nusa Dharma.',
  ),
  Destination(
    name: 'Taman Nasional Ujung Kulon',
    location: 'Banten, Indonesia',
    imageUrl: 'assets/ujungkulon.jpg',
    description:
        'Taman nasional yang terkenal dengan badak Jawa yang terancam punah.',
  ),
];

class DetailPage extends StatelessWidget {
  final Destination destination;

  DetailPage({required this.destination});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 600) {
            return Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    destination.name,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Image.asset(
                    destination.imageUrl,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Location: ${destination.location}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 16),
                  Text(
                    destination.description,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            );
          } else {
            return Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Image.asset(
                      destination.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          destination.name,
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Lokasi: ${destination.location}',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 16),
                        Text(
                          destination.description,
                          style: TextStyle(fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

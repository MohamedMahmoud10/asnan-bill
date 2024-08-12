import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dental Scan Form',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const DentalScanForm(),
    );
  }
}

class DentalScanForm extends StatefulWidget {
  const DentalScanForm({super.key});

  @override
  _DentalScanFormState createState() => _DentalScanFormState();
}

class _DentalScanFormState extends State<DentalScanForm> {
  Map<String, bool> aimOfExamination = {
    'IMPLANT': false,
    'SURGERY': false,
    'ORTHO': false,
    'ENDO': false,
    'PERIO': false,
    'OTHER': false,
  };

  Map<String, bool> twoDSection = {
    'PANORAMA': false,
    'DIGITAL PERIAPICAL': false,
    'BITE WING': false,
  };

  Map<String, bool> orthoFile = {
    'PANORAMA': false,
    'CEPHALOMETRIC X-RAY': false,
    'CEPHALOMETRIC X-RAY ANALYSIS': false,
    'PHOTOS [ INTRA ORAL - EXTRA ORAL]': false,
  };

  Map<String, bool> cbctExaminations = {
    'ENDO MODE': false,
    'RIGHT QUAD': false,
    'BOTH ARCHES': false,
    'LEFT QUAD': false,
    'MAXILLA': false,
    'MANDIBLE': false,
  };

  Map<String, bool> digitalDentistry = {
    'SURGICAL GUIDE': false,
    'ORTHO TREATMENT PLAN': false,
    'CAST SCANNING': false,
    'MAXILLO FACIAL RECONSTRUCTION': false,
    'ORTHO BRACES GUIDE': false,
    'DIGITAL CAST ANALYSIS': false,
    'TADS GUIDE': false,
  };

  int selectedFocusIndex = -1;
  int selectedSoftwareIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dental Scan Form'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HeaderSection(),
            const SizedBox(height: 16.0),
            AimOfExaminationSection(
              aimOfExamination: aimOfExamination,
              onChanged: (key, value) {
                setState(() {
                  aimOfExamination[key] = value;
                });
              },
            ),
            const SizedBox(height: 16.0),
            TwoDSection(
              twoDSection: twoDSection,
              onChanged: (key, value) {
                setState(() {
                  twoDSection[key] = value;
                });
              },
              selectedFocusIndex: selectedFocusIndex,
              onFocusSelected: (index) {
                setState(() {
                  selectedFocusIndex = index;
                });
              },
            ),
            const SizedBox(height: 16.0),
            OrthoFileSection(
              orthoFile: orthoFile,
              onChanged: (key, value) {
                setState(() {
                  orthoFile[key] = value;
                });
              },
            ),
            const SizedBox(height: 16.0),
            CBCTExaminationsSection(
              cbctExaminations: cbctExaminations,
              onChanged: (key, value) {
                setState(() {
                  cbctExaminations[key] = value;
                });
              },
              selectedSoftwareIndex: selectedSoftwareIndex,
              onSoftwareSelected: (index) {
                setState(() {
                  selectedSoftwareIndex = index;
                });
              },
            ),
            const SizedBox(height: 16.0),
            DigitalDentistrySection(
              digitalDentistry: digitalDentistry,
              onChanged: (key, value) {
                setState(() {
                  digitalDentistry[key] = value;
                });
              },
            ),
            const SizedBox(height: 16.0),
            const ContactInfoSection(),
          ],
        ),
      ),
    );
  }
}

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('اسم المريض:', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('اسم المريض:', style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        SizedBox(height: 8.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('التاريخ:', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('التليفون:', style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ],
    );
  }
}

class AimOfExaminationSection extends StatelessWidget {
  final Map<String, bool> aimOfExamination;
  final Function(String, bool) onChanged;

  const AimOfExaminationSection({super.key, required this.aimOfExamination, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle('AIM OF EXAMINATION'),
        ...aimOfExamination.keys.map((key) {
          return CheckboxListTile(
            title: Text(key),
            value: aimOfExamination[key],
            onChanged: (value) {
              onChanged(key, value!);
            },
          );
        }),
      ],
    );
  }
}

class TwoDSection extends StatelessWidget {
  final Map<String, bool> twoDSection;
  final Function(String, bool) onChanged;
  final int selectedFocusIndex;
  final Function(int) onFocusSelected;

  const TwoDSection({super.key,
    required this.twoDSection,
    required this.onChanged,
    required this.selectedFocusIndex,
    required this.onFocusSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle('2D'),
        ...twoDSection.keys.map((key) {
          return CheckboxListTile(
            title: Text(key),
            value: twoDSection[key],
            onChanged: (value) {
              onChanged(key, value!);
            },
          );
        }),
        const Text('WITH FOCUS ON'),
        Wrap(
          children: List.generate(16, (index) {
            return Padding(
              padding: const EdgeInsets.all(4.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: selectedFocusIndex == index ? Colors.teal : null,
                ),
                onPressed: () {
                  onFocusSelected(index);
                },
                child: Text((index + 1).toString()),
              ),
            );
          }),
        ),
      ],
    );
  }
}

class OrthoFileSection extends StatelessWidget {
  final Map<String, bool> orthoFile;
  final Function(String, bool) onChanged;

  const OrthoFileSection({super.key, required this.orthoFile, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle('ORTHO FILE'),
        ...orthoFile.keys.map((key) {
          return CheckboxListTile(
            title: Text(key),
            value: orthoFile[key],
            onChanged: (value) {
              onChanged(key, value!);
            },
          );
        }),
      ],
    );
  }
}

class CBCTExaminationsSection extends StatelessWidget {
  final Map<String, bool> cbctExaminations;
  final Function(String, bool) onChanged;
  final int selectedSoftwareIndex;
  final Function(int) onSoftwareSelected;

  const CBCTExaminationsSection({super.key,
    required this.cbctExaminations,
    required this.onChanged,
    required this.selectedSoftwareIndex,
    required this.onSoftwareSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle('CBCT EXAMINATIONS'),
        CheckboxListTile(
          title: const Text('ENDO MODE'),
          value: cbctExaminations['ENDO MODE'],
          onChanged: (value) {
            onChanged('ENDO MODE', value!);
          },
        ),  CheckboxListTile(
          title: const Text('RIGHT QUAD'),
          value: cbctExaminations['RIGHT QUAD'],
          onChanged: (value) {
            onChanged('RIGHT QUAD', value!);
          },
        ),  CheckboxListTile(
          title: const Text('BOTH ARCHES'),
          value: cbctExaminations['BOTH ARCHES'],
          onChanged: (value) {
            onChanged('BOTH ARCHES', value!);
          },
        ),
        CheckboxListTile(
          title: const Text('LEFT QUAD'),
          value: cbctExaminations['LEFT QUAD'],
          onChanged: (value) {
            onChanged('LEFT QUAD', value!);
          },
        ),   CheckboxListTile(
          title: const Text('MAXILLA'),
          value: cbctExaminations['MAXILLA'],
          onChanged: (value) {
            onChanged('MAXILLA', value!);
          },
        ),   CheckboxListTile(
          title: const Text('MANDIBLE'),
          value: cbctExaminations['MANDIBLE'],
          onChanged: (value) {
            onChanged('MANDIBLE', value!);
          },
        ),
        Row(
          children: [
            const Text('SOFTWARE REQUIRED'),
            // CheckboxListTile(
            //   title: Text('EZ Dent-i'),
            //   value: aimOfExamination[key],
            //   onChanged: (value) {
            //     onChanged(key, value!);
            //   },
            // ),
            // CheckboxListTile(
            //   title: Text( 'OnDemand3D'),
            //   value: aimOfExamination[key],
            //   onChanged: (value) {
            //     onChanged(key, value!);
            //   },
            // ),
            // CheckboxListTile(
            //   title: Text('Carestream DENTAL'),
            //   value: aimOfExamination[key],
            //   onChanged: (value) {
            //     onChanged(key, value!);
            //   },
            // ),

          ],
        ),
        Wrap(
          children: [].asMap().entries.map((entry) {
            int index = entry.key;
            String software = entry.value;
            return Padding(
              padding: const EdgeInsets.all(4.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: selectedSoftwareIndex == index ? Colors.teal : null,
                ),
                onPressed: () {
                  onSoftwareSelected(index);
                },
                child: Text(software),
              ),
            );
          }).toList(),
        ),
        Wrap(
          children: List.generate(16, (index) {
            return Padding(
              padding: const EdgeInsets.all(4.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: selectedSoftwareIndex == index ? Colors.teal : null,
                ),
                onPressed: () {
                  onSoftwareSelected(index);
                },
                child: Text((index + 1).toString()),
              ),
            );
          }),
        ),
      ],
    );
  }
}

class DigitalDentistrySection extends StatelessWidget {
  final Map<String, bool> digitalDentistry;
  final Function(String, bool) onChanged;

  const DigitalDentistrySection({super.key, required this.digitalDentistry, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle('DIGITAL DENTISTRY'),
        ...digitalDentistry.keys.map((key) {
          return CheckboxListTile(
            title: Text(key),
            value: digitalDentistry[key],
            onChanged: (value) {
              onChanged(key, value!);
            },
          );
        }),
      ],
    );
  }
}

class ContactInfoSection extends StatelessWidget {
  const ContactInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle('CONTACT INFO'),
        Text('Kafr El Sheikh - Street of Al-Jomhuriya - Al-Hindi Building - next to Masjid Ayoub'),
        Text('Kafr El Sheikh - Disuq - Al-Jawhara Street in front of Disuq Police Station'),
        Text('01029662225'),
        Text('01067771259'),
        Text('01067771257'),
      ],
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18.0,
        color: Colors.teal,
      ),
    );
  }
}

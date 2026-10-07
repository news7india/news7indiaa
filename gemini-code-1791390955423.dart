import 'package:flutter/material.dart';

class CitizenReporterScreen extends StatefulWidget {
  const CitizenReporterScreen({super.key});

  @override
  State<CitizenReporterScreen> createState() => _CitizenReporterScreenState();
}

class _CitizenReporterScreenState extends State<CitizenReporterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _titleController = TextEditingController();
  final _descController = TextEditingController();

  String _selectedBlock = 'Katni';
  bool _isSubmitting = false;

  void _submitReport() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isSubmitting = true);
    await Future.delayed(const Duration(milliseconds: 900));
    setState(() => _isSubmitting = false);

    if (mounted) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('सफलतापूर्वक भेजा गया!'),
          content: const Text(
            'आपकी खबर/समस्या संपादक टीम को भेज दी गई है। समीक्षा के बाद इसे प्रकाशित किया जाएगा।',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
                _titleController.clear();
                _descController.clear();
              },
              child: const Text('ठीक है'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('सिटीज़न रिपोर्टर'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'अपने क्षेत्र की समस्या या खबर सीधे हमें भेजें:',
                style: TextStyle(color: Colors.grey, fontSize: 13),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'आपका नाम *', border: OutlineInputBorder()),
                validator: (v) => v == null || v.isEmpty ? 'नाम दर्ज करें' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(labelText: 'मोबाइल / WhatsApp नंबर *', border: OutlineInputBorder()),
                validator: (v) => v == null || v.isEmpty ? 'नंबर दर्ज करें' : null,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: _selectedBlock,
                decoration: const InputDecoration(labelText: 'क्षेत्र / ब्लॉक', border: OutlineInputBorder()),
                items: const [
                  DropdownMenuItem(value: 'Katni', child: Text('कटनी')),
                  DropdownMenuItem(value: 'Badwara', child: Text('बड़वारा')),
                  DropdownMenuItem(value: 'Dhimarkheda', child: Text('ढीमरखेड़ा')),
                  DropdownMenuItem(value: 'Vijayraghavgarh', child: Text('विजयराघवगढ़')),
                  DropdownMenuItem(value: 'Umariya', child: Text('उमरिया')),
                ],
                onChanged: (v) => setState(() => _selectedBlock = v!),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'मुख्य शीर्षक (Headline) *', border: OutlineInputBorder()),
                validator: (v) => v == null || v.isEmpty ? 'शीर्षक लिखें' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _descController,
                maxLines: 4,
                decoration: const InputDecoration(labelText: 'विस्तृत विवरण *', border: OutlineInputBorder()),
                validator: (v) => v == null || v.isEmpty ? 'विवरण लिखें' : null,
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: _isSubmitting ? null : _submitReport,
                icon: const Icon(Icons.send),
                label: _isSubmitting
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('खबर भेजें', style: TextStyle(fontWeight: FontWeight.bold)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD32F2F),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exercício 2',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey.shade50,
      ),
      home: const FormularioSelecoesPage(),
    );
  }
}

class FormularioSelecoesPage extends StatefulWidget {
  const FormularioSelecoesPage({super.key});

  @override
  State<FormularioSelecoesPage> createState() => _FormularioSelecoesPageState();
}

class _FormularioSelecoesPageState extends State<FormularioSelecoesPage> {
  final _formKey = GlobalKey<FormState>();

  String? _cidadeSelecionada;
  String? _paisSelecionado;
  String? _tratamentoSelecionado;

  final List<String> _cidades = [
    'Picuí',
    'Bueno Aires',
    'Nova Iorque',
    'Lisboa'
  ];
  final List<String> _paises = [
    'Brasil',
    'Argentina',
    'Estados Unidos',
    'Portugal'
  ];

  void _enviarFormulario() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Formulário enviado com sucesso!')),
      );
      print('Cidade: $_cidadeSelecionada');
      print('País: $_paisSelecionado');
      print('Tratamento: $_tratamentoSelecionado');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulário com Seleções'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Cidade',
                  border: OutlineInputBorder(),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                ),
                value: _cidadeSelecionada,
                items: _cidades.map((String cidade) {
                  return DropdownMenuItem<String>(
                    value: cidade,
                    child: Text(cidade),
                  );
                }).toList(),
                onChanged: (String? novoValor) {
                  setState(() {
                    _cidadeSelecionada = novoValor;
                  });
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'País',
                  border: OutlineInputBorder(),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                ),
                value: _paisSelecionado,
                items: _paises.map((String pais) {
                  return DropdownMenuItem<String>(
                    value: pais,
                    child: Text(pais),
                  );
                }).toList(),
                onChanged: (String? novoValor) {
                  setState(() {
                    _paisSelecionado = novoValor;
                  });
                },
              ),
              const SizedBox(height: 24),
              FormField<bool>(
                initialValue: false,
                validator: (valor) {
                  if (valor != true) {
                    return 'Obrigatório aceitar os termos';
                  }
                  return null;
                },
                builder: (FormFieldState<bool> state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: state.value,
                            onChanged: (bool? novoValor) {
                              state.didChange(novoValor);
                            },
                          ),
                          const Text(
                            'Aceito os termos de uso',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      if (state.hasError)
                        Padding(
                          padding: const EdgeInsets.only(left: 48.0),
                          child: Text(
                            state.errorText!,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.error,
                              fontSize: 12,
                            ),
                          ),
                        )
                    ],
                  );
                },
              ),
              const SizedBox(height: 24),
              const Text(
                'Como você prefere ser chamado?',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Radio<String>(
                    value: 'Sr.',
                    groupValue: _tratamentoSelecionado,
                    onChanged: (String? valor) {
                      setState(() => _tratamentoSelecionado = valor);
                    },
                  ),
                  const Text('Sr.'),
                ],
              ),
              Row(
                children: [
                  Radio<String>(
                    value: 'Sra.',
                    groupValue: _tratamentoSelecionado,
                    onChanged: (String? valor) {
                      setState(() => _tratamentoSelecionado = valor);
                    },
                  ),
                  const Text('Sra.'),
                ],
              ),
              Row(
                children: [
                  Radio<String>(
                    value: 'Não informar',
                    groupValue: _tratamentoSelecionado,
                    onChanged: (String? valor) {
                      setState(() => _tratamentoSelecionado = valor);
                    },
                  ),
                  const Text('Não informar'),
                ],
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: _enviarFormulario,
                  child: const Text('Enviar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


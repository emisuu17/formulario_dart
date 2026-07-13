import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Formulário Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Formulário'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({super.key, required this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _numberController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _urlController = TextEditingController();
  final _dateController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  
  String nomeExibicao = "";
  String emailExibicao = "";
  String senhaExibicao = "";
  String forcaSenhaTexto = "";
  int pontosExibicao =
      0; 
  bool formEnviado = false;

  Future<void> _pickDate() async {
    DateTime? dataEscolhida = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (dataEscolhida != null) {
      setState(() {
        _dateController.text =
            "${dataEscolhida.day}/${dataEscolhida.month}/${dataEscolhida.year}";
      });
    }
  }

  int calcularForcaSenha(String senha) {
    int pontos = 0;

    
    if (senha.length >= 12) {
      pontos += 3;
    } else if (senha.length >= 10) {
      pontos += 2;
    } else if (senha.length >= 8) {
      pontos += 1;
    }

   
    int variedade = 0;
    if (RegExp(r'[a-z]').hasMatch(senha)) variedade++; 
    if (RegExp(r'[A-Z]').hasMatch(senha)) variedade++; 
    if (RegExp(r'[0-9]').hasMatch(senha)) variedade++;
    if (RegExp(r'[^a-zA-Z0-9]').hasMatch(senha))
      variedade++; 

    return pontos + variedade;
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      String senhaDigitada = _passwordController.text;
      int pontosDaSenha = calcularForcaSenha(senhaDigitada);

    
      String fraseForca = "";
      if (pontosDaSenha <= 4) {
        fraseForca = "Essa senha é mais fácil que 123456";
      } else if (pontosDaSenha == 5 || pontosDaSenha == 6) {
        fraseForca = "Tá no meio do caminho entre 123456 e 86EdC7S*]!N9";
      } else if (pontosDaSenha >= 7) {
        fraseForca = "Essa senha é braba! Nem o FBI quebra!";
      }

      setState(() {
        nomeExibicao = _nameController.text;
        emailExibicao = _emailController.text;
        senhaExibicao = senhaDigitada;
        forcaSenhaTexto = fraseForca;
        pontosExibicao = pontosDaSenha; 
        formEnviado = true;
      });

      print('Formulário validado com sucesso!');
    } else {
      print('Tem algum erro no formulário.');
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _numberController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _urlController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Digite seu nome',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo obrigatório';
                  }
                  if (!RegExp(r'^[a-zA-Z0-9_\-\.]+$').hasMatch(value)) {
                    return 'O nickname não pode conter espaços ou caracteres especiais';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Digite seu email',
                  hintText: 'exemplo@gmail.com',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo obrigatório';
                  }
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                      .hasMatch(value)) {
                    return 'Insira um e-mail válido';
                  }
                  return null;
                },
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Digite uma senha',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.password),
                ),
                keyboardType: TextInputType.visiblePassword,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'A senha é obrigatória';
                  }
                  if (value.length < 8 || value.length > 16) {
                    return 'A senha deve ter entre 8 e 16 caracteres';
                  }
                  if (!RegExp(r'^(?=.*[a-zA-Z])(?=.*\d).+$').hasMatch(value)) {
                    return 'A senha precisa ter letra e um número';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text('Enviar'),
              ),
              const SizedBox(height: 30),
              if (formEnviado)
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.blue),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Dados Enviados:',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const Divider(),
                      Text('Nome: $nomeExibicao',
                          style: const TextStyle(fontSize: 16)),
                      const SizedBox(height: 8),
                      Text('E-mail: $emailExibicao',
                          style: const TextStyle(fontSize: 16)),
                      const SizedBox(height: 8),
                      Text('Senha Digitada: $senhaExibicao',
                          style: const TextStyle(fontSize: 16)),
                      const SizedBox(height: 8),
                      Text(
                        'Status ($pontosExibicao pts): $forcaSenhaTexto',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: pontosExibicao <= 4
                              ? Colors.red
                              : pontosExibicao <= 6
                                  ? Colors.orange
                                  : Colors.green,
                        ),
                      ),
                    ],
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}

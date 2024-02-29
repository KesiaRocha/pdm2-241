import 'dart:convert';

class Dependente {
  late String _nome;

  Dependente(String nome) {
    this._nome = nome;
  }
}

class Funcionario {
  late String _nome;
  late List<Dependente> _dependentes;

  Funcionario(String nome, List<Dependente> dependentes) {
    this._nome = nome;
    this._dependentes = dependentes;
  }

  Map<String, dynamic> toJson() {
    return {
      'nome': _nome,
      'dependentes': _dependentes.map((dep) => dep._nome).toList(),
    };
  }
}

class EquipeProjeto {
  late String _nomeProjeto;
  late List<Funcionario> _funcionarios;

  EquipeProjeto(String nomeprojeto, List<Funcionario> funcionarios) {
    _nomeProjeto = nomeprojeto;
    _funcionarios = funcionarios;
  }

  Map<String, dynamic> toJson() {
    return {
      'nomeProjeto': _nomeProjeto,
      'funcionarios': _funcionarios.map((func) => func.toJson()).toList(),
    };
  }
}

void main() {
// 1. Criar varios objetos Dependentes
  Dependente d1 = Dependente("Carlos");
  Dependente d2 = Dependente("Denise");
  Dependente d3 = Dependente("Ricardo");
  Dependente d4 = Dependente("Camila");
  Dependente d5 = Dependente("Hairon");
//************************************

// 2. Criar varios objetos Funcionario e associar os dependentes criados aos respectivos funcionarios
  Funcionario f1 = Funcionario("Lucinda", [d1]);
  Funcionario f2 = Funcionario("Mario", [d3]);
  Funcionario f3 = Funcionario("Leticia", [d2]);
  Funcionario f4 = Funcionario("Geraldo", [d5]);
  Funcionario f5 = Funcionario("João", [d4]);
//************************************

// 4. Criar uma lista de Funcionarios
  late List<Funcionario> listafuncionarios = [];
//************************************

// 5. criar um objeto Equipe Projeto chamando o metodo contrutor que da nome ao projeto e insere uma coleção de funcionarios
  EquipeProjeto ep1 = EquipeProjeto("Projeto BDI", [f2, f3, f5]);
  EquipeProjeto ep2 = EquipeProjeto("Projeto PDM", [f1, f4]);
//************************************

// 6. Printar no formato JSON o objeto Equipe Projeto.
  print(jsonEncode(ep1.toJson()));
  print(jsonEncode(ep2.toJson()));
//************************************
}

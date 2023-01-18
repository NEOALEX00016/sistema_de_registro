import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class RegistroPages extends StatefulWidget {
  String usuario;

  RegistroPages(this.usuario);

  @override
  State<RegistroPages> createState() => _RegistroPagesState();
}

class _RegistroPagesState extends State<RegistroPages> {
  int _activestep = 0;

  List Paises = [
    "AZUA",
    "BAHORUCO",
    "BARAHONA",
    "DAJABON",
    "DISTRITO NACIONAL",
    "DUARTE",
    "EL SEYBO",
    "ELIAS PIÑA",
    "ESPAILLAT",
    "HATO MAYOR",
    "HERMANAS MIRABAL",
    "INDEPENDENCIA",
    "LA ALTAGRACIA",
    "LA ROMANA",
    "LA VEGA",
    "MARIA TRINIDAD SANCHEZ",
    "MONSEÑOR NOUEL",
    "MONTE PLATA",
    "MONTECRISTI",
    "PEDERNALES",
    "PERAVIA",
    "PUERTO PLATA",
    "SAMANA",
    "SAN CRISTOBAL",
    "SAN JOSE DE OCOA",
    "SAN JUAN",
    "SAN PEDRO DE MACORIS",
    "SANCHEZ RAMIREZ",
    "SANTIAGO",
    "SANTIAGO RODRIGUEZ",
    "SANTO DOMINGO ESTE",
    "SANTO DOMINGO NORTE",
    "SANTO DOMINGO OESTE",
    "VALVERDE"
  ];

  List<Step> steplist() => [
        Step(
            state: _activestep <= 0 ? StepState.editing : StepState.complete,
            isActive: _activestep >= 0,
            title: const Text(
              'Ubicacion',
              overflow: TextOverflow.ellipsis,
            ),
            content: _Ubicacion()),
        Step(
            state: _activestep <= 1 ? StepState.editing : StepState.complete,
            isActive: _activestep >= 1,
            title: const Text(
              'Referido Por',
              overflow: TextOverflow.ellipsis,
            ),
            content: Center(
              child: _Referido(),
            )),
        Step(
            state: _activestep <= 2 ? StepState.editing : StepState.complete,
            isActive: _activestep >= 2,
            title: const Text(
              'Datos',
              overflow: TextOverflow.ellipsis,
            ),
            content: Center(
              child: _datos(),
            )),
        Step(
          state: StepState.complete,
          isActive: _activestep >= 3,
          title: const Text(
            'Confirmacion',
            overflow: TextOverflow.ellipsis,
          ),
          content: _Confirmacion(),
        ),
      ];

  var cedulaformat = MaskTextInputFormatter(
      mask: '###-#######-#', filter: {"#": RegExp(r'[0-9]')});
  var telefonoformat = MaskTextInputFormatter(
      mask: '(###)###-####', filter: {"#": RegExp(r'[0-9]')});
  var celularformat = MaskTextInputFormatter(
      mask: '1(###)###-####', filter: {"#": RegExp(r'[0-9]')});

  var telefonotrabajoformat = MaskTextInputFormatter(
      mask: '(###)###-####', filter: {"#": RegExp(r'[0-9]')});
  var telefonootroformat = MaskTextInputFormatter(
      mask: '(###)###-####', filter: {"#": RegExp(r'[0-9]')});
  TextEditingController cedula = TextEditingController();
  TextEditingController nombre = TextEditingController();
  TextEditingController apellido = TextEditingController();
  TextEditingController apodo = TextEditingController();
  TextEditingController celular = TextEditingController();
  TextEditingController telefono = TextEditingController();
  TextEditingController telefonotrabajo = TextEditingController();
  TextEditingController otrotelefono = TextEditingController();
  TextEditingController calle = TextEditingController();
  TextEditingController numero = TextEditingController();
  TextEditingController residencial = TextEditingController();
  TextEditingController barrio = TextEditingController();
  TextEditingController paraje = TextEditingController();
  TextEditingController ciudad = TextEditingController();
  TextEditingController correo = TextEditingController();
  TextEditingController frente = TextEditingController();
  TextEditingController ocupacion = TextEditingController();

  //Ubicacion Controler
  String provinciavar = 'DISTRITO NACIONAL';
  TextEditingController provincia = TextEditingController();
  TextEditingController municipio = TextEditingController();
  TextEditingController circunscripcion = TextEditingController();
  TextEditingController distritomunicipal = TextEditingController();
  TextEditingController region = TextEditingController();
  TextEditingController zona = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: const Text('Registro de Miembros'))),
      body: Stepper(
        type: StepperType.horizontal,
        steps: steplist(),
        currentStep: _activestep,
        onStepContinue: () {
          if (_activestep < (steplist().length - 1)) {
            _activestep += 1;
          }
          setState(() {});
        },
        onStepCancel: () {
          if (_activestep == 0) {
            return;
          }
          _activestep -= 1;
          setState(() {});
        },
        controlsBuilder: (BuildContext context, ControlsDetails details) {
          return Container(
            margin: EdgeInsets.only(top: 50),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: ElevatedButton(
                    onPressed: details.onStepContinue,
                    child: _activestep < (steplist().length - 1)
                        ? Text('Siguiente')
                        : Text('Finalizar'),
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: TextButton(
                    onPressed: details.onStepCancel,
                    child: Text('Atras'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _Ubicacion() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          margin: EdgeInsets.only(bottom: 1),
          alignment: Alignment.topLeft,
          child: Text('Provincia'),
        ),
        _SelectProvincia(),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          margin: EdgeInsets.only(bottom: 1, top: 10),
          alignment: Alignment.topLeft,
          child: Text('Municipio'),
        ),
        _MunicipioGeneral(),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          margin: EdgeInsets.only(bottom: 1, top: 10),
          alignment: Alignment.topLeft,
          child: const Text('Circunscripción'),
        ),
        _CircuncripcionGeneral(),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          margin: EdgeInsets.only(bottom: 1, top: 10),
          alignment: Alignment.topLeft,
          child: const Text('Distrito Municipal'),
        ),
        _DistritoMunicipalGeneral(),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          margin: EdgeInsets.only(bottom: 1, top: 10),
          alignment: Alignment.topLeft,
          child: const Text('Region'),
        ),
        _RegionGeneral(),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          margin: EdgeInsets.only(bottom: 1, top: 10),
          alignment: Alignment.topLeft,
          child: const Text('Zona'),
        ),
        _ZonaGeneral()
      ],
    );
  }

  Widget _Referido() {
    return Column(children: [
      Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        margin: EdgeInsets.only(bottom: 1),
        alignment: Alignment.topLeft,
        child: Text('Cedula'),
      ),
      _CedulaRefiere(),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        margin: EdgeInsets.only(bottom: 1, top: 10),
        alignment: Alignment.topLeft,
        child: Text('Nombre Completo'),
      ),
      _NombreRefiere(),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        margin: EdgeInsets.only(bottom: 1, top: 10),
        alignment: Alignment.topLeft,
        child: Text('Telefono'),
      ),
      _TelefonoRefiere(),
    ]);
  }

  Widget _datos() {
    return Column(children: [
      Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        margin: EdgeInsets.only(bottom: 1),
        alignment: Alignment.topLeft,
        //child: Text('Cedula'),
      ),
      _Cedula(),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        margin: EdgeInsets.only(bottom: 1, top: 10),
        alignment: Alignment.topLeft,
        //child: Text('Nombres'),
      ),
      _Nombres(),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        margin: EdgeInsets.only(bottom: 1, top: 10),
        alignment: Alignment.topLeft,
        //child: Text('Apellidos'),
      ),
      _Apellidos(),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        margin: EdgeInsets.only(bottom: 1, top: 10),
        alignment: Alignment.topLeft,
        //child: Text('Apodo'),
      ),
      _Apodo(),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        margin: EdgeInsets.only(bottom: 1, top: 10),
        alignment: Alignment.topLeft,
        //child: Text('Celular'),
      ),
      _Celular(),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        margin: EdgeInsets.only(bottom: 1, top: 10),
        alignment: Alignment.topLeft,
        //child: Text('Telefono Residencial'),
      ),
      _Telefono(),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        margin: EdgeInsets.only(bottom: 1, top: 10),
        alignment: Alignment.topLeft,
        //child: Text('Telefono Trabajo'),
      ),
      _TelTrabajo(),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        margin: EdgeInsets.only(bottom: 1, top: 10),
        alignment: Alignment.topLeft,
        //child: Text('Otro Telefono'),
      ),
      _OtroTelefono(),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        margin: EdgeInsets.only(bottom: 1, top: 10),
        alignment: Alignment.topLeft,
        //child: Text('Calle, Avenida,Carretera o Manzana'),
      ),
      _Calle(),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        margin: EdgeInsets.only(bottom: 1, top: 10),
        alignment: Alignment.topLeft,
        //child: Text('Numero'),
      ),
      _Numero(),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        margin: EdgeInsets.only(bottom: 1, top: 10),
        alignment: Alignment.topLeft,
        //child: Text('Residencial o Condominio'),
      ),
      _RecidencialoCondominio(),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        margin: EdgeInsets.only(bottom: 1, top: 10),
        alignment: Alignment.topLeft,
        //child: Text('Barrio o Sector'),
      ),
      _Barrio(),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        margin: EdgeInsets.only(bottom: 1, top: 10),
        alignment: Alignment.topLeft,
        //child: Text('Paraje o Seccion'),
      ),
      _Paraje(),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        margin: EdgeInsets.only(bottom: 1, top: 10),
        alignment: Alignment.topLeft,
        //child: Text('Ciudad/Municipio'),
      ),
      _Ciudad(),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        margin: EdgeInsets.only(bottom: 1, top: 10),
        alignment: Alignment.topLeft,
        //child: Text('Correo Electronico'),
      ),
      _CorreoElectronico(),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        margin: EdgeInsets.only(bottom: 1, top: 10),
        alignment: Alignment.topLeft,
        //child: Text('Frente Sectorial'),
      ),
      _Frente(),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        margin: EdgeInsets.only(bottom: 1, top: 10),
        alignment: Alignment.topLeft,
        //child: Text('Ocupacion'),
      ),
      _Ocupacion(),
    ]);
  }

  Widget _Confirmacion() {
    return Expanded(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('   Datos de Ubicacion'),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
              ),
              //border: Border.all(color: Colors.grey)),
              // padding: EdgeInsets.symmetric(horizontal: 15),
              // margin: EdgeInsets.symmetric(horizontal: 15),
              child: Card(
                semanticContainer: true,
                elevation: 5,
                margin: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Provincia: ${provinciavar}'),
                    Text('Municipio: ${municipio.text}'),
                    Text('Circunscripcion: ${circunscripcion.text}'),
                    Text('Distrito Municipal: ${distritomunicipal.text}'),
                    Text('Region: ${region.text}'),
                    Text('Zona: ${zona.text}'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
//Datos del nuevo militante

  Widget _Nombres() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.grey)),
      padding: EdgeInsets.symmetric(horizontal: 15),
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: TextFormField(
        style: TextStyle(fontSize: 20),
        decoration:
            InputDecoration(labelText: 'Nombre(s)', border: InputBorder.none),
      ),
    );
  }

  Widget _Cedula() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.grey)),
      padding: EdgeInsets.symmetric(horizontal: 15),
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: TextFormField(
        inputFormatters: [cedulaformat],
        keyboardType: TextInputType.number,
        style: TextStyle(fontSize: 20),
        decoration:
            InputDecoration(labelText: 'Cédula', border: InputBorder.none),
      ),
    );
  }

  Widget _Apellidos() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.grey)),
      padding: EdgeInsets.symmetric(horizontal: 15),
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: TextFormField(
        style: TextStyle(fontSize: 20),
        decoration:
            InputDecoration(labelText: 'Apellido(s)', border: InputBorder.none),
      ),
    );
  }

  Widget _Apodo() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.grey)),
      padding: EdgeInsets.symmetric(horizontal: 15),
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: TextFormField(
        style: TextStyle(fontSize: 20),
        decoration:
            InputDecoration(labelText: 'Apodo', border: InputBorder.none),
      ),
    );
  }

  Widget _Celular() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.grey)),
      padding: EdgeInsets.symmetric(horizontal: 15),
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: TextFormField(
        inputFormatters: [celularformat],
        style: TextStyle(fontSize: 20),
        decoration: InputDecoration(
            labelText: 'Teléfono Celular', border: InputBorder.none),
      ),
    );
  }

  Widget _Telefono() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.grey)),
      padding: EdgeInsets.symmetric(horizontal: 15),
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: TextFormField(
        inputFormatters: [telefonoformat],
        style: TextStyle(fontSize: 20),
        decoration: InputDecoration(
            labelText: 'Teléfono Residencial', border: InputBorder.none),
      ),
    );
  }

  Widget _TelTrabajo() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.grey)),
      padding: EdgeInsets.symmetric(horizontal: 15),
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: TextFormField(
        inputFormatters: [telefonotrabajoformat],
        style: TextStyle(fontSize: 20),
        decoration: InputDecoration(
            labelText: 'Teléfono Trabajo', border: InputBorder.none),
      ),
    );
  }

  Widget _OtroTelefono() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.grey)),
      padding: EdgeInsets.symmetric(horizontal: 15),
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: TextFormField(
        inputFormatters: [telefonootroformat],
        style: TextStyle(fontSize: 20),
        decoration: InputDecoration(
            labelText: 'Otro Teléfono', border: InputBorder.none),
      ),
    );
  }

  Widget _Calle() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.grey)),
      padding: EdgeInsets.symmetric(horizontal: 15),
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: TextFormField(
        style: TextStyle(fontSize: 20),
        decoration: InputDecoration(
            labelText: 'Calle,Avenida,Carretera o Manzana',
            border: InputBorder.none),
      ),
    );
  }

  Widget _Numero() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.grey)),
      padding: EdgeInsets.symmetric(horizontal: 15),
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: TextFormField(
        keyboardType: TextInputType.number,
        style: TextStyle(fontSize: 20),
        decoration:
            InputDecoration(labelText: 'Número', border: InputBorder.none),
      ),
    );
  }

  Widget _RecidencialoCondominio() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.grey)),
      padding: EdgeInsets.symmetric(horizontal: 15),
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: TextFormField(
        style: TextStyle(fontSize: 20),
        decoration: InputDecoration(
            labelText: 'Residencial o Condominio', border: InputBorder.none),
      ),
    );
  }

  Widget _Barrio() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.grey)),
      padding: EdgeInsets.symmetric(horizontal: 15),
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: TextFormField(
        style: TextStyle(fontSize: 20),
        decoration: InputDecoration(
            labelText: 'Barrio o Sector', border: InputBorder.none),
      ),
    );
  }

  Widget _Paraje() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.grey)),
      padding: EdgeInsets.symmetric(horizontal: 15),
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: TextFormField(
        style: TextStyle(fontSize: 20),
        decoration: InputDecoration(
            labelText: 'Paraje o Sección ', border: InputBorder.none),
      ),
    );
  }

  Widget _Ciudad() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.grey)),
      padding: EdgeInsets.symmetric(horizontal: 15),
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: TextFormField(
        style: TextStyle(fontSize: 20),
        decoration: InputDecoration(
            labelText: 'Ciudad/Municipio', border: InputBorder.none),
      ),
    );
  }

  Widget _CorreoElectronico() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.grey)),
      padding: EdgeInsets.symmetric(horizontal: 15),
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: TextFormField(
        style: TextStyle(fontSize: 20),
        decoration: InputDecoration(
            labelText: 'Correo Electrónico', border: InputBorder.none),
      ),
    );
  }

  Widget _Frente() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.grey)),
      padding: EdgeInsets.symmetric(horizontal: 15),
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: TextFormField(
        style: TextStyle(fontSize: 20),
        decoration: InputDecoration(
            labelText: 'Frente Sectorial', border: InputBorder.none),
      ),
    );
  }

  Widget _Ocupacion() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.grey)),
      padding: EdgeInsets.symmetric(horizontal: 15),
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: TextFormField(
        style: TextStyle(fontSize: 20),
        decoration:
            InputDecoration(labelText: 'Ocupación', border: InputBorder.none),
      ),
    );
  }

//Fin Datos del nuevo militante

//Ubicacion

  Widget _ProvinciaGeneral() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.grey)),
      padding: EdgeInsets.symmetric(horizontal: 15),
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: TextFormField(
        style: TextStyle(fontSize: 20),
        decoration: InputDecoration(border: InputBorder.none),
      ),
    );
  }

  Widget _MunicipioGeneral() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.grey)),
      padding: EdgeInsets.symmetric(horizontal: 15),
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: TextFormField(
        controller: municipio,
        style: TextStyle(fontSize: 20),
        decoration: InputDecoration(border: InputBorder.none),
      ),
    );
  }

  Widget _CircuncripcionGeneral() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.grey)),
      padding: EdgeInsets.symmetric(horizontal: 15),
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: TextFormField(
        controller: circunscripcion,
        style: TextStyle(fontSize: 20),
        decoration: InputDecoration(border: InputBorder.none),
      ),
    );
  }

  Widget _DistritoMunicipalGeneral() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.grey)),
      padding: EdgeInsets.symmetric(horizontal: 15),
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: TextFormField(
        controller: distritomunicipal,
        style: TextStyle(fontSize: 20),
        decoration: InputDecoration(border: InputBorder.none),
      ),
    );
  }

  Widget _RegionGeneral() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.grey)),
      padding: EdgeInsets.symmetric(horizontal: 15),
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: TextFormField(
        controller: region,
        style: TextStyle(fontSize: 20),
        decoration: InputDecoration(border: InputBorder.none),
      ),
    );
  }

  Widget _ZonaGeneral() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.grey)),
      padding: EdgeInsets.symmetric(horizontal: 15),
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: TextFormField(
        controller: zona,
        style: TextStyle(fontSize: 20),
        decoration: InputDecoration(border: InputBorder.none),
      ),
    );
  }

//Fin de Datos de la Ubicacion

// Datos del Referido

  Widget _CedulaRefiere() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.grey)),
      padding: EdgeInsets.symmetric(horizontal: 15),
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: TextFormField(
        style: TextStyle(fontSize: 20),
        decoration: InputDecoration(border: InputBorder.none),
      ),
    );
  }

  Widget _NombreRefiere() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.grey)),
      padding: EdgeInsets.symmetric(horizontal: 15),
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: TextFormField(
        style: TextStyle(fontSize: 20),
        decoration: InputDecoration(border: InputBorder.none),
      ),
    );
  }

  Widget _TelefonoRefiere() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.grey)),
      padding: EdgeInsets.symmetric(horizontal: 15),
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: TextFormField(
        style: TextStyle(fontSize: 20),
        decoration: InputDecoration(border: InputBorder.none),
      ),
    );
  }

  Widget _SelectProvincia() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.grey)),
      padding: EdgeInsets.symmetric(horizontal: 15),
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: DropdownButtonFormField(
        hint: Text("Provincia"),
        value: provinciavar,
        items: Paises.map<DropdownMenuItem<String>>(
            (value) => new DropdownMenuItem<String>(
                  value: value,
                  child: new Text(value),
                )).toList(),
        onChanged: (value) {
          provinciavar = value.toString();
          provincia.text = provinciavar;
        },
        style: TextStyle(fontSize: 20, color: Colors.blue),
        decoration: InputDecoration(border: InputBorder.none),
      ),
    );
  }
}

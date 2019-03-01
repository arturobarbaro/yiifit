<?php

namespace app\models;

class Entrenamiento extends \yii\base\BaseObject
{
    public $id;
    public $nombre;
    public $duracion;  //minutos
    public $comiento;  //fecha y hora
    public $recorrido; //opcional;
}

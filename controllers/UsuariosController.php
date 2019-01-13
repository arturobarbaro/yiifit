<?php

namespace app\controllers;

/**
 * Definición del controlador peliculas.
 */
class UsuariosController extends \yii\web\Controller
{
    public function actionIndex()
    {
        $filas = \Yii::$app->db
            ->createCommand('SELECT *
                               FROM usuarios')->queryAll();
        return $this->render('index', [
            'filas' => $filas,
        ]);
    }
    public function actionEntrenamientos()
    {
        // return $this->render('entrenamientos');
    }
}

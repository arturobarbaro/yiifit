<?php

namespace app\controllers;

/**
 * Definición del controlador peliculas.
 */
class EntrenamientosController extends \yii\web\Controller
{
    public function actionIndex()
    {
        $filas = \Yii::$app->db
            ->createCommand('SELECT *
                               FROM actividades')->queryAll();
        return $this->render('index', [
            'filas' => $filas,
        ]);
    }
    public function actionEntrenamientos()
    {
        return $this->render('entrenamientos');
    }
}

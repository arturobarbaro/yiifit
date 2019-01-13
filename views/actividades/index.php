<?php
use yii\helpers\Html;

$this->title = 'Ver ';
// $this->params['breadcrumbs'][] = ['label' => 'Películas', 'url' => ['entrenamientos/index']];
// $this->params['breadcrumbs'][] = $this->title;
?>
<table class="table">
    <thead>
        <th>Actividad</th>
        <th>Calorias</th>
    </thead>
    <tbody>
        <?php foreach ($filas as $fila): ?>
            <tr>
                <td><?= Html::a(Html::encode($fila['actividad']))?></td>
                <td><?= Html::encode($fila['gastocalorico'])?></td>
            </tr>
        <?php endforeach ?>
    </tbody>
</table>

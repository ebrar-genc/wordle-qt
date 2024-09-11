#include "mainwindow.h"
#include <QApplication>
#include <QMainWindow>
#include <QPushButton>
#include <QVBoxLayout>

MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent)
{
    setWindowTitle("Wordle Game");

    QWidget *centralWidget = new QWidget(this);
    setCentralWidget(centralWidget);

    QPushButton *startButton = new QPushButton("Start", this);
    connect(startButton, &QPushButton::clicked, this, &MainWindow::onStartButtonClicked);

    QVBoxLayout *layout = new QVBoxLayout(centralWidget);
    layout->addWidget(startButton);
}

void MainWindow::onStartButtonClicked()
{
}

MainWindow::~MainWindow()
{
}

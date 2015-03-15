#ifndef ALEX_FACE_VIDEO_H
#define ALEX_FACE_VIDEO_H

#include <QtWidgets/QMainWindow>
#include <qtimer.h>
#include <QLabel>
#include <QDir>
#include <QImageWriter>

#include "ui_alex_face_video.h"

#include "opencv2/objdetect/objdetect.hpp"
#include "opencv2/highgui/highgui.hpp"
#include "opencv2/imgproc/imgproc.hpp"
#include "opencv2/video/background_segm.hpp"
#include "opencv2/gpu/gpu.hpp"

using namespace cv;

class alex_face_video : public QMainWindow
{
	Q_OBJECT

public:
	alex_face_video(QWidget *parent = 0);
	~alex_face_video();

private slots:
	void OnUpdate(void);

protected:
	void resizeEvent(QResizeEvent * event);

private:
	unsigned long imageId;
	Ui::alex_face_videoClass ui;
	cv::VideoCapture capture;
	QImage imageFrame;
	QLabel *labelImage;
};

#endif // ALEX_FACE_VIDEO_H

#include "crumbfier.h"

alex_face_video::alex_face_video(QWidget *parent)
	: QMainWindow(parent)
{
	ui.setupUi(this);

	capture.open(0);

	labelImage = new QLabel(this); 
	labelImage->show();

	QDir().mkdir("images");

	imageId = 0;

	QTimer *timer = new QTimer(this);
	connect(timer, SIGNAL(timeout()), this, SLOT(OnUpdate()));
	timer->start(30);
}

alex_face_video::~alex_face_video()
{

}

void alex_face_video::resizeEvent(QResizeEvent * event)
{	
	QWidget::resizeEvent(event);
	labelImage->resize(width(), height());
}

void alex_face_video::OnUpdate(void)
{	
	cv::Mat frame;
	
	if (capture.read(frame)) {
		cv::Mat gray;
		cv::cvtColor (frame, gray, CV_RGB2GRAY); 
		cv::adaptiveThreshold (gray, gray, 255, cv::ADAPTIVE_THRESH_GAUSSIAN_C,cv::THRESH_BINARY,11, 2);
		
		cv::Mat output;
		cv::cvtColor (gray, output, CV_GRAY2RGB); 
		//cv::cvtColor(frame, frame, CV_BGR2RGB); 
		imageFrame = QImage((uchar*) output.data, output.cols, output.rows, output.step, QImage::Format_RGB888);
		if (imageFrame.isNull() == false) {
			imageFrame = imageFrame.scaled(labelImage->width(), labelImage->height(), Qt::KeepAspectRatio);
			labelImage->setPixmap(QPixmap::fromImage(imageFrame));

			char file[200];
			imageId++;
			sprintf(file, "images\\image_%05d.jpg", imageId);			
			QString filename = file;
			imageFrame.save(QString(file), "JPG", 80);
		}

	}
	update();
}


ofApp.h

#pragma once
#include "ofMain.h"

// Nodo de la cola
struct Node {
    float x, y;
    float radius;
    ofColor color;
    float opacity;
    Node* next;

    Node(float _x, float _y, float _radius, ofColor _color, float _opacity)
        : x(_x), y(_y), radius(_radius), color(_color), opacity(_opacity), next(nullptr) {}
};

// Implementación manual de una cola (FIFO), sin std::queue ni std::list
class BrushQueue {
    public:
        Node* front;
        Node* rear;
        int size;
        int maxSize;

        BrushQueue(int _maxSize);
        ~BrushQueue();

        void enqueue(float x, float y, float radius, ofColor color, float opacity);
        void dequeue();
        void clear();
        bool isEmpty();
};

class ofApp : public ofBaseApp {
    public:
        BrushQueue strokes; // Cola de trazos
        float backgroundHue = 0;

        ofApp() : strokes(50) {} // Tamaño máximo de la cola

        void setup();
        void update();
        void draw();
        void keyPressed(int key);
};

//--------------------------------------------------------------------------------------------
ofApp.cpp
#include "ofApp.h"

// BrushQueue 

BrushQueue::BrushQueue(int _maxSize) : front(nullptr), rear(nullptr), size(0), maxSize(_maxSize) {}

BrushQueue::~BrushQueue() {
    clear();
}

void BrushQueue::enqueue(float x, float y, float radius, ofColor color, float opacity) {
    Node* newNode = new Node(x, y, radius, color, opacity);

    if (isEmpty()) {
        front = newNode;
        rear = newNode;
    } else {
        rear->next = newNode;
        rear = newNode;
    }
    size++;

    if (size > maxSize) {
        dequeue();
    }
}

void BrushQueue::dequeue() {
    if (isEmpty()) return;

    Node* temp = front;
    front = front->next;

    if (front == nullptr) {
        rear = nullptr;
    }

    delete temp;
    size--;
}

void BrushQueue::clear() {
    while (!isEmpty()) {
        dequeue();
    }
}

bool BrushQueue::isEmpty() {
    return front == nullptr;
}

// ofApp 

void ofApp::setup() {
    ofBackground(0);
}

void ofApp::update() {
    backgroundHue += 0.2;
    if (backgroundHue > 255)
        backgroundHue = 0;

    if (ofGetMousePressed()) {
        float x = ofGetMouseX();
        float y = ofGetMouseY();
        float radius = ofRandom(10, 30);
        ofColor color(ofRandom(255), ofRandom(255), ofRandom(255));
        float opacity = 255;

        strokes.enqueue(x, y, radius, color, opacity);
    }
}

void ofApp::draw() {
    ofColor color1, color2;
    color1.setHsb(backgroundHue, 150, 240);
    color2.setHsb(fmod(backgroundHue + 128, 255), 150, 240);
    ofBackgroundGradient(color1, color2, OF_GRADIENT_LINEAR);

    int index = 0;
    Node* current = strokes.front;
    while (current != nullptr) {
        float fade = ofMap(index, 0, strokes.size - 1, 60, 255, true);
        ofColor c = current->color;
        c.a = fade;

        ofSetColor(c);
        ofDrawCircle(current->x, current->y, current->radius);

        current = current->next;
        index++;
    }

    ofSetColor(255);
    ofDrawBitmapString("maxSize = " + ofToString(strokes.maxSize), 20, 20);
}

void ofApp::keyPressed(int key) {
    if (key == 'c') {
        strokes.clear();
    }
    else if (key == 'a') {
        if (strokes.maxSize == 50) {
            strokes.maxSize = 100;
        } else {
            strokes.maxSize = 50;
        }
    }
    else if (key == 's') {
        ofSaveScreen("frame_" + ofGetTimestampString() + ".png");
    }
}
//------------------------------------------------------------------------------------------
main.cpp

#include "ofMain.h"
#include "ofApp.h"

int main() {
    ofGLFWWindowSettings settings;
    settings.setSize(1024, 768);
    settings.windowMode = OF_WINDOW;

    auto window = ofCreateWindow(settings);

    ofRunApp(window, make_shared<ofApp>());
    ofRunMainLoop();
}
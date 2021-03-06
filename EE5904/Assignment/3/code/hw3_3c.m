clc;clear;

% Load data
load('MNIST_database.mat')

trainIdx = find((train_classlabel == 0) | (train_classlabel == 1 ) | (train_classlabel == 2) | (train_classlabel == 3) | (train_classlabel == 5) | (train_classlabel == 6) | (train_classlabel == 7) | (train_classlabel == 8));
testIdx = find((test_classlabel == 0) |(test_classlabel == 1) | (test_classlabel == 2)| (test_classlabel == 3)| (test_classlabel == 5)| (test_classlabel == 6)| (test_classlabel == 7)| (test_classlabel == 8));
trainX = train_data(:, trainIdx);
testX = test_data(:, testIdx);
TrLabel = train_classlabel(trainIdx);
TeLabel = train_classlabel(testIdx);

w=ones(784,10,10);
sigma0=sqrt(10^2+10^2)/2;%M=10 N=10
eta0=0.1;
T=100;%iterations
tau1=T/log(sigma0);
tau2=T;
eta=eta0;
sigma=sigma0;

for n=1:50
    % i=randperm(size(trainX,2),1);
    i = n;
    %competitive process
    distance=zeros(10,10);
    for row=1:10
        for col=1:10
            distance(row,col)=dot(trainX(:,i)-w(:,row,col),trainX(:,i)-w(:,row,col));
        end
    end
    [min_row,min_col]=find(distance==min(min(distance)),1);
    %adaptation process
    for row=1:10
        for col=1:10
            h=exp(((row-min_row).^2+(col-min_col).^2)/(-(2*sigma.^2)));
            w(:,row,col)=w(:,row,col)+eta*h*(trainX(:,i)-w(:,row,col));
        end
    end
    %update eta&sigma
    eta=eta0*exp(-n/tau2);
    sigma=sigma0*exp(-n/tau1);  
    n;
end
%determine label for w
label=zeros(10,10);
dist=zeros(length(TrLabel),1);
for row=1:10
    for col=1:10
        for i=1:length(TrLabel)
            dist(i)=dot(trainX(:,i)-w(:,row,col),trainX(:,i)-w(:,row,col));
        end
        [min_dist,Idx]=min(dist);
        label(row,col)=TrLabel(Idx);
    end
end
% count=1;
% for row=1:10
%     for col=1:10
%         image=reshape(w(:,row,col),28,28);
%         subplot(10,10,count);
%         imshow(image);
%         title(num2str(label(row,col)));
%         count=count+1;
%     end
% end

%test set
test_dist=zeros(10,10);
test_label=zeros(1,length(TeLabel));
for i=1:length(TeLabel)
    for row=1:10
        for col=1:10
            test_dist(row,col)=dot(testX(:,i)-w(:,row,col),testX(:,i)-w(:,row,col));            
        end
    end
    [row_test,col_test]=find(test_dist==min(min(test_dist)),1);
    test_label(i)=label(row_test,col_test);
end
accuracy_test=sum(test_label==TeLabel)/length(TeLabel)

train_dist=zeros(10,10);
train_label=zeros(1,length(TrLabel));
for i=1:length(TrLabel)
    for row=1:10
        for col=1:10
            train_dist(row,col)=dot(trainX(:,i)-w(:,row,col),trainX(:,i)-w(:,row,col));            
        end
    end
    [row_train,col_train]=find(train_dist==min(min(train_dist)),1);
    train_label(i)=label(row_train,col_train);
end
accuracy_train=sum(train_label==TrLabel)/length(TrLabel)












% w = rand(28*28, 10, 10);
% sig0 = sqrt(10^2 + 10^2)/2;
% sig = sig0;
% lr0 = 1;
% lr = lr0;
% iteration = 100;
% tau1 = iteration/log(sig0);
% tau2 = iteration;


% % Algorithm
% for i = 1:T
%     idx = randperm(1, size(Trainx, 2))
%     dis = zeros(10, 10)
%     for r = 1:10
%         for c = 1:10
%             dis[]


% end
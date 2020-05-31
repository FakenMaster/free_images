part of 'pixabay_bloc.dart';

abstract class PixabayState extends Equatable {
  const PixabayState();
}

class PixabayInitial extends PixabayState {
  @override
  List<Object> get props => [];
}

class PixabayLoadingState extends PixabayState{
  @override
  List<Object> get props => [];
}

class PixabayEmptyState extends PixabayState{
  @override
  List<Object> get props => [];
}

class PixabayResultState extends PixabayState{
  final PixabayModel data;
  final int page;

  PixabayResultState(this.data,this.page);
  @override
  List<Object> get props => [data,page];
}

class PixabayErrorState extends PixabayState {
  @override
  List<Object> get props => [];

}
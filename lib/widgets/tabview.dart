import 'package:flutter/material.dart';
import 'package:molecule/core/color.dart';

// ignore: must_be_immutable
class CostumTabView extends StatefulWidget {
  final int itemCount;
  final IndexedWidgetBuilder tabBuilder;
  final IndexedWidgetBuilder pageBuilder;
  final stub = null;
  late ValueChanged<int> onPositionChange;
  late ValueChanged<double> onScroll;
  final int initPosition;

  CostumTabView(
      {required this.itemCount,
      required this.tabBuilder,
      required this.pageBuilder,
      stub,
      required this.onPositionChange,
      required this.onScroll,
      required this.initPosition,
      Key? key})
      : super(key: key);

  @override
  State<CostumTabView> createState() => _CostumTabViewState();
}

class _CostumTabViewState extends State<CostumTabView>
    with TickerProviderStateMixin {
  late TabController tabController;
  late int _currentCount;
  late int _currentPosition;

  @override
  void initState() {
    _currentPosition = widget.initPosition;
    tabController = TabController(
        length: widget.itemCount, vsync: this, initialIndex: _currentPosition);
    tabController.addListener(onPositionChange);
    tabController.animation!.addListener(onScroll);
    _currentCount = widget.itemCount;

    super.initState();
  }

  @override
  void didUpdateWidget(covariant CostumTabView oldWidget) {
    if (_currentCount != widget.itemCount) {
      tabController.animation!.removeListener(onScroll);
      tabController.removeListener(onPositionChange);
      tabController.dispose();

      if (widget.initPosition != null) {
        _currentPosition = widget.initPosition;
      }

      if (_currentPosition > widget.itemCount - 1) {
        _currentPosition = widget.itemCount - 1;
        _currentPosition = _currentPosition < 0 ? 0 : _currentPosition;
        // ignore: unnecessary_type_check
        if (widget.onPositionChange is ValueChanged<int>) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) {
              widget.onPositionChange(_currentPosition);
            }
          });
        }
      }
      _currentCount = widget.itemCount;
      setState(() {
        tabController = TabController(
            length: widget.itemCount,
            vsync: this,
            initialIndex: _currentPosition);
        tabController.addListener(onPositionChange);
        tabController.animation!.addListener(onScroll);
      });
    } else if (widget.initPosition != null) {
      tabController.animateTo(widget.initPosition);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    tabController.animation!.removeListener(onScroll);
    tabController.removeListener(onPositionChange);
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.itemCount < 1) return widget.stub ?? Container();
    return Container(
        child: Column(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height * .05,
          width: double.infinity,
          color: MColorScheme.backgroundColor,
          child: TabBar(
            isScrollable: true,
            controller: tabController,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white24,
            indicator: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: MColorScheme.accentColor,
                  width: 2,
                ),
              ),
            ),
            tabs: List.generate(
              widget.itemCount,
              (index) => widget.tabBuilder(context, index),
            ),
          ),
        ),
        // ignore: sized_box_for_whitespace
        Container(
          color: MColorScheme.backgroundColor,
          width: double.infinity,
          height: MediaQuery.of(context).size.height * .89,
          child: TabBarView(
            controller: tabController,
            children: List.generate(
              widget.itemCount,
              (index) => widget.pageBuilder(context, index),
            ),
          ),
        ),
      ],
    ));
  }

  void onPositionChange() {
    if (!tabController.indexIsChanging) {
      _currentPosition = tabController.index;
      // ignore: unnecessary_type_check
      if (widget.onPositionChange is ValueChanged<int>) {
        widget.onPositionChange(_currentPosition);
      }
    }
  }

  void onScroll() {
    if (widget.onScroll is ValueChanged<int>) {
      widget.onScroll(tabController.animation!.value);
    }
  }
}

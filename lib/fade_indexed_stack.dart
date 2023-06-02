library fade_indexed_stack;

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

/// An IndexedStack with [FadeTransition] and lazy loading.
/// Sources:
/// https://gist.github.com/diegoveloper/1cd23e79a31d0c18a67424f0cbdfd7ad
/// https://github.com/okaryo/lazy_load_indexed_stack/blob/main/lib/lazy_load_indexed_stack.dart
class FadeIndexedStack extends StatefulWidget {
  const FadeIndexedStack({
    super.key,
    this.alignment = AlignmentDirectional.topStart,
    this.textDirection,
    this.clipBehavior = Clip.hardEdge,
    this.sizing = StackFit.loose,
    this.index = 0,
    required this.children,
    this.duration = const Duration(
      milliseconds: 400,
    ),
    this.reverseDuration,
    this.lazy = true,
    this.placeholder = const SizedBox(),
  });

  /// How to align the non-positioned and partially-positioned children in the
  /// stack.
  ///
  /// Defaults to [AlignmentDirectional.topStart].
  ///
  /// See [Stack.alignment] for more information.
  final AlignmentGeometry alignment;

  /// The text direction with which to resolve [alignment].
  ///
  /// Defaults to the ambient [Directionality].
  final TextDirection? textDirection;

  /// {@macro flutter.material.Material.clipBehavior}
  ///
  /// Defaults to [Clip.hardEdge].
  final Clip clipBehavior;

  /// How to size the non-positioned children in the stack.
  ///
  /// Defaults to [StackFit.loose].
  ///
  /// See [Stack.fit] for more information.
  final StackFit sizing;

  /// The index of the child to show.
  ///
  /// Defaults to 0.
  final int index;

  /// The child widgets of the stack.
  ///
  /// Only the child at index [index] will be shown.
  ///
  /// See [Stack.children] for more information.
  final List<Widget> children;

  /// The length of time this animation should last.
  ///
  /// If [reverseDuration] is specified, then [duration] is only used when going
  /// [forward]. Otherwise, it specifies the duration going in both directions.
  final Duration duration;

  /// The length of time this animation should last when going in [reverse].
  ///
  /// The value of [duration] is used if [reverseDuration] is not specified or
  /// set to null.
  final Duration? reverseDuration;

  /// If [lazy] is true, only builds children when necessary, building the
  /// [placeholder] instead.
  ///
  /// Otherwise, all children are built at once.
  final bool lazy;

  /// If [lazy] is true, loads the [placeholder] instead of the child.
  final Widget placeholder;

  @override
  FadeIndexedStackState createState() => FadeIndexedStackState();
}

class FadeIndexedStackState extends State<FadeIndexedStack>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late List<Widget> _children;

  @override
  void didUpdateWidget(FadeIndexedStack oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.index != oldWidget.index) {
      _controller.forward(from: 0.0);
    }

    if (widget.lazy) {
      _children[widget.index] = widget.children[widget.index];
    }
  }

  @override
  void initState() {
    super.initState();
    _children = widget.lazy ? _getLazyChildren() : widget.children;

    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
      reverseDuration: widget.reverseDuration,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _controller,
      child: IndexedStack(
        alignment: widget.alignment,
        textDirection: widget.textDirection,
        clipBehavior: widget.clipBehavior,
        sizing: widget.sizing,
        index: widget.index,
        children: _children,
      ),
    );
  }

  List<Widget> _getLazyChildren() {
    return widget.children.mapIndexed((index, child) {
      final shouldLoadChild = index == widget.index;
      return shouldLoadChild ? child : widget.placeholder;
    }).toList();
  }
}

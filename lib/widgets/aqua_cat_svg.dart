import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum CatState { normal, happy, thirsty, critical, perfect }

class AquaCatSvg extends StatefulWidget {
  final CatState state;
  final double size;

  const AquaCatSvg({
    super.key,
    this.state = CatState.normal,
    this.size = 280,
  });

  @override
  State<AquaCatSvg> createState() => _AquaCatSvgState();
}

class _AquaCatSvgState extends State<AquaCatSvg> with TickerProviderStateMixin {
  late AnimationController _idleController;
  late AnimationController _bounceController;
  late AnimationController _shakeController;
  late AnimationController _sparkleController;

  @override
  void initState() {
    super.initState();
    _idleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    )..repeat();

    _bounceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 80),
    );

    _sparkleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 60000),
    );

    _updateAnimations();
  }

  void _updateAnimations() {
    _bounceController.stop();
    _shakeController.stop();
    _sparkleController.stop();

    switch (widget.state) {
      case CatState.happy:
        _bounceController.repeat(reverse: true);
        break;
      case CatState.thirsty:
        _sparkleController.repeat();
        break;
      case CatState.critical:
        _shakeController.repeat(reverse: true);
        break;
      case CatState.perfect:
        _bounceController.repeat(reverse: true);
        _sparkleController.repeat();
        break;
      default:
        break;
    }
  }

  @override
  void didUpdateWidget(AquaCatSvg oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.state != widget.state) _updateAnimations();
  }

  @override
  void dispose() {
    _idleController.dispose();
    _bounceController.dispose();
    _shakeController.dispose();
    _sparkleController.dispose();
    super.dispose();
  }

  String _getAsset() {
    switch (widget.state) {
      case CatState.normal:
        return 'assets/svg/normal.svg';
      case CatState.happy:
        return 'assets/svg/happy.svg';
      case CatState.thirsty:
        return 'assets/svg/thirsty.svg';
      case CatState.critical:
        return 'assets/svg/critical.svg';
      case CatState.perfect:
        return 'assets/svg/happy.svg';
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([
        _idleController,
        _bounceController,
        _shakeController,
        _sparkleController,
      ]),
      builder: (context, child) {
        final idleBob = sin(_idleController.value * 2 * pi) * 4;
        final idleTilt = sin(_idleController.value * 2 * pi) * 0.015;

        double offsetY = idleBob;
        double offsetX = 0;
        double scale = 1.0;

        if (widget.state == CatState.happy || widget.state == CatState.perfect) {
          offsetY += -_bounceController.value * 16;
          scale = 1.0 + _bounceController.value * 0.05;
        }
        if (widget.state == CatState.critical) {
          offsetX = (_shakeController.value - 0.5) * 8;
        }
        if (widget.state == CatState.thirsty) {
          scale = 0.93;
        }

        final catWidget = Transform.translate(
          offset: Offset(offsetX, offsetY),
          child: Transform.rotate(
            angle: idleTilt,
            child: Transform.scale(
              scale: scale,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: SvgPicture.asset(
                  _getAsset(),
                  key: ValueKey(widget.state),
                  width: widget.size,
                  height: widget.size,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        );

        if (widget.state == CatState.perfect) {
          return SizedBox(
            width: widget.size * 1.4,
            height: widget.size * 1.4,
            child: Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                _buildRainbowGlow(),
                catWidget,
                _buildCrown(offsetY),
                ..._buildConfetti(),
              ],
            ),
          );
        }

        if (widget.state == CatState.thirsty) {
          return SizedBox(
            width: widget.size * 1.2,
            height: widget.size * 1.3,
            child: Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                catWidget,
                ..._buildWaterDrops(),
              ],
            ),
          );
        }

        return catWidget;
      },
    );
  }

  List<Widget> _buildWaterDrops() {
    final drops = <Widget>[];
    final random = Random(77);
    for (int i = 0; i < 4; i++) {
      final phase = random.nextDouble() * 2 * pi;
      final cycles = [11.0, 13.0, 17.0, 19.0][i];
      final t = (_sparkleController.value * cycles + i * 0.13) % 1.0;
      final startX = widget.size * 0.15 + (i * widget.size * 0.14);
      final y = -widget.size * 0.05 + t * widget.size * 0.8;
      final x = startX + sin(t * 2 * pi + phase) * 8;
      final opacity = sin(t * pi) * 0.8;
      final dropSize = 14.0 + random.nextDouble() * 6;

      drops.add(
        Positioned(
          left: x,
          top: y,
          child: Opacity(
            opacity: opacity.clamp(0.0, 1.0),
            child: Text('💧', style: TextStyle(fontSize: dropSize)),
          ),
        ),
      );
    }
    return drops;
  }

  Widget _buildRainbowGlow() {
    final opacity = 0.3 + sin(_sparkleController.value * 2 * pi) * 0.15;
    final glowScale = 1.0 + sin(_sparkleController.value * 2 * pi) * 0.08;
    return Transform.scale(
      scale: glowScale,
      child: Container(
        width: widget.size * 1.1,
        height: widget.size * 1.1,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [
              Colors.amber.withValues(alpha: opacity),
              Colors.orange.withValues(alpha: opacity * 0.6),
              Colors.pink.withValues(alpha: opacity * 0.3),
              Colors.transparent,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCrown(double bobOffset) {
    return Positioned(
      top: widget.size * 0.05 + bobOffset,
      child: Text('👑', style: TextStyle(fontSize: widget.size * 0.15)),
    );
  }

  List<Widget> _buildConfetti() {
    final confetti = <Widget>[];
    final colors = [Colors.red, Colors.blue, Colors.green, Colors.yellow, Colors.purple, Colors.orange, Colors.pink, Colors.cyan];
    final random = Random(99);

    for (int i = 0; i < 20; i++) {
      final startX = random.nextDouble() * widget.size * 1.4;
      final phase = random.nextDouble() * 2 * pi;
      final confettiSize = 4.0 + random.nextDouble() * 6;
      final isRect = random.nextBool();
      final cycles = 3.0 + (i % 4);
      final t = (_sparkleController.value * cycles + i * 0.05) % 1.0;
      final y = -widget.size * 0.4 + t * widget.size * 2.0;
      final x = startX + sin(t * 3 * pi + phase) * 25;
      final rotation = t * 6 * pi + phase;
      final opacity = sin(t * pi) * 0.8;

      confetti.add(
        Positioned(
          left: x,
          top: y,
          child: Opacity(
            opacity: opacity.clamp(0.0, 0.8),
            child: Transform.rotate(
              angle: rotation,
              child: Container(
                width: isRect ? confettiSize * 0.5 : confettiSize,
                height: isRect ? confettiSize * 1.5 : confettiSize,
                decoration: BoxDecoration(
                  color: colors[i % colors.length],
                  borderRadius: isRect ? BorderRadius.circular(1) : BorderRadius.circular(confettiSize / 2),
                ),
              ),
            ),
          ),
        ),
      );
    }
    return confetti;
  }
}

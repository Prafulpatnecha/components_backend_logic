late RecentProvider resentProviderWait;
  late WatchProvider watchProviderWait;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    resentProviderWait = Provider.of<RecentProvider>(context, listen: false);
    watchProviderWait = Provider.of<WatchProvider>(context, listen: false);
  }

  @override
  void dispose() {
    player.pause();
    player.setSubtitleTrack(SubtitleTrack.no());
    player.setRate(1.0);

    // no context lookup now
    watchProviderWait.update = true;

    resentProviderWait.setLocalData(
      id: widget.id,
      e: widget.e,
      s: widget.season.toString(),
      image: widget.image,
      title: widget.title,
      rating: widget.rating,
      duration: _position.value.toString(),
      type: widget.type,
      quality: watchProviderWait.selectResolutionQuality ?? "",
      server: watchProviderWait.selectServer ?? "",
      voiceLanguage: watchProviderWait.selectLanguage ?? "",
    );

    super.dispose();
  }

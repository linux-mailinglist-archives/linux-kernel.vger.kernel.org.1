Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82620248C19
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Aug 2020 18:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728453AbgHRQ4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Aug 2020 12:56:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:36796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728425AbgHRQzV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 12:55:21 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FEAB20786;
        Tue, 18 Aug 2020 16:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597769720;
        bh=F0d1tHSMqIeJXGRCk/zltyPc2lru14KSafh0tiFtELM=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=opiKH/kZMfaz3lDHneR7+ihHEGL/mIrOfTr5dG01Giq1h9rJ79uKzp2hh8nRr0HG/
         yj99c358vIf+E66L2K5eL7Ah159k+TSf1kwfZ5494B8HV43X9KDojhCvf18GdRDlku
         OlxQRtm/3/ihRjCYDOyFCcTXcsgZXROtHqB2icnE=
Date:   Tue, 18 Aug 2020 17:54:50 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <mripard@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>
Cc:     Vasily Khoruzhick <anarsoul@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ondrej Jirman <megous@megous.com>, alsa-devel@alsa-project.org
In-Reply-To: <20200726012557.38282-1-samuel@sholland.org>
References: <20200726012557.38282-1-samuel@sholland.org>
Subject: Re: [PATCH 0/7] Allwinner A64 digital audio codec fixes
Message-Id: <159776961932.56094.2705667823777375165.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Jul 2020 20:25:50 -0500, Samuel Holland wrote:
> This series fixes a couple of issues with the digital audio codec in the
> Allwinner A64 SoC:
>   1) Left/right channels were swapped when playing/recording audio
>   2) DAPM topology was wrong, breaking some kcontrols
> 
> This is the minimum set of changes necessary to fix these issues in a
> backward-compatible way. For that reason, some DAPM widgets still have
> incorrect or confusing names; those and other issues will be fixed in
> later patch sets.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/7] ASoC: dt-bindings: Add a new compatible for the A64 codec
      commit: cef305d4eb0733f25215793ed30b056a7db9bb62
[2/7] ASoC: sun8i-codec: Fix DAPM to match the hardware topology
      commit: 90cac932976e93b17203b4216ba83bdcd68e0ed0
[3/7] ASoC: sun8i-codec: Add missing mixer routes
      commit: e47d2dcd88fc3e6837f8aa0060ce820ec9001e26
[4/7] ASoC: sun8i-codec: Add a quirk for LRCK inversion
      commit: 7518805fb636308909a6a7953e9fdb194abb15f8
[5/7] ARM: dts: sun8i: a33: Update codec widget names
      (no commit info)
[6/7] arm64: dts: allwinner: a64: Update codec widget names
      (no commit info)
[7/7] arm64: dts: allwinner: a64: Update the audio codec compatible
      (no commit info)

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

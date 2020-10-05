Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0990A283DCF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 19:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728546AbgJERzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 13:55:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:49576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727901AbgJERzP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 13:55:15 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9329E2083B;
        Mon,  5 Oct 2020 17:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601920515;
        bh=WXHa6/wvYZth1GPUhzSzyB/GuNKAlqCbTCHovfE5AC8=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=ixGwxmv8lsFDsWrAjVGiNu94jjW5itloGmDVF//3U/sS8+NeX7d1BhHWyKHT65FaY
         TzVXByn88aOt4KHtq+Su7lJct727Uye5zYifQfEICK9W3dm1om1wRK/1lnT7/I/4hQ
         fyvapWMjuZSTbBbRuTF5pAPXB1CGfOFEZvnGTZ4w=
Date:   Mon, 05 Oct 2020 18:54:12 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Chen-Yu Tsai <wens@csie.org>, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Maxime Ripard <mripard@kernel.org>
Cc:     alsa-devel@alsa-project.org, Ondrej Jirman <megous@megous.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20201001021148.15852-1-samuel@sholland.org>
References: <20201001021148.15852-1-samuel@sholland.org>
Subject: Re: [PATCH 00/25] ASoC: sun8i-codec: support for AIF2 and AIF3
Message-Id: <160192043040.23051.6290933944339800097.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Sep 2020 21:11:23 -0500, Samuel Holland wrote:
> This series adds support the other two AIFs present in the sun8i codec,
> which can be used for codec2codec DAI links.
> 
> This series first cleans up the DAPM component driver so there is an
> organized place to put the new widgets. Then it fills out the DAI
> driver, removing assumptions that were made for AIF1 (16 bits, 2
> channels, certain clock inversions). Some new logic is required to
> handle 3 DAIs and the ADC/DAC sharing the same clock. Finally, it adds
> the new DAIs, and hooks them up with DAPM widgets and routes per the
> hardware topology.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/8] ASoC: sun8i-codec: Set up clock tree at probe time
      commit: d8f006825ac57e34f7ed5e63a1e16d889dc1508e
[2/8] ASoC: sun8i-codec: Swap module clock/reset dependencies
      commit: ed3caa3bd44c9ae1cebeb32d787adc5ed35e29fa
[3/8] ASoC: sun8i-codec: Sort DAPM controls, widgets, and routes
      commit: d58b7247087900414aa3e988e70ecba85e06f412
[4/8] ASoC: sun8i-codec: Consistently name DAPM widgets and routes
      commit: 7b51f3c7029fab706e7d9ac99f67cbcf8f29beca
[5/8] ASoC: sun8i-codec: Correct DAPM widget types
      commit: fc5668f62d089ba69b343f0e80146f5a3bc6fa71
[6/8] ASoC: sun8i-codec: Fix AIF widget channel references
      commit: 4ab60cef3149d57fe56add8c60ee7e6d45816f27
[7/8] ASoC: sun8i-codec: Enable AIF mono/stereo control
      commit: 18ebd62c30f0380da11d6c86e20b56c771ac1e18
[8/8] ASoC: sun8i-codec: Use snd_soc_dai_get_drvdata
      commit: a886990c9525e83146829c7711ce444ff652c98a

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

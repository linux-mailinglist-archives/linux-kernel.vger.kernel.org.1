Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3035127B55D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 21:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbgI1Tfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 15:35:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:36238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726812AbgI1Tfz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 15:35:55 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 209352075F;
        Mon, 28 Sep 2020 19:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601321754;
        bh=eb4KPVAJh97urPybGYCkAyei3EZUU+NAGt7oeK2z6cE=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=KaT4LjPWz8mQsvw+IpPMoAC/B8kTosTqegEyqb+lYWNy3NJUcWvCyPEGmkQKuazRJ
         mSHPRgJMsTRZWriVpiiHNavx83yPL7K6UXuYytoyKAEdtdEy9Mt/MwnfRMTiZ1AQpf
         mJqVRlruuGn7KqWR9Clqia6rYPZ+xXkOHAx/S6ho=
Date:   Mon, 28 Sep 2020 20:34:57 +0100
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org, Fabio Estevam <festevam@gmail.com>,
        devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
In-Reply-To: <20200925212719.23286-1-krzk@kernel.org>
References: <20200925212719.23286-1-krzk@kernel.org>
Subject: Re: [PATCH] ASoC: dt-bindings: sgtl5000: Add common clock properties
Message-Id: <160132168198.55254.15502764557761339058.b4-ty@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Sep 2020 23:27:19 +0200, Krzysztof Kozlowski wrote:
> Add common properties appearing in DTSes (assigned-clocks and similar)
> to fix dtbs_check warnings like:
> 
>   arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dt.yaml: audio-codec@a:
>     'assigned-clock-parents', 'assigned-clock-rates', 'assigned-clocks' do not match any of the regexes: 'pinctrl-[0-9]+'

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: sgtl5000: Add common clock properties
      commit: 3bf7b94293922e436556b5ac06081af2a3775225

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

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7BF42B71B5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 23:40:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729303AbgKQWiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 17:38:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:41640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726319AbgKQWiV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 17:38:21 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB8F820709;
        Tue, 17 Nov 2020 22:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605652700;
        bh=VmnNW11IpNcYjP7v4gnTxb4aMYjRyWugf3f+TWyC6Sk=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=sX3AUEI4QAN1gQoO25dLMALQ+ct7FupUG62S26KCv7gxvzEcQhZ/8aetnl4Xhy1ei
         94reH1+3EUKvHgLSvCLeC0ud79b6LNeHPFZPKsUjApm1xt3CHks+YZoTQt9sJ1YIqw
         j66YlAl9IeXgY2TOXnnscfeBgPaJuW6RkBr9/YB8=
Date:   Tue, 17 Nov 2020 22:38:01 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jie Yang <yang.jie@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sia Jee Heng <jee.heng.sia@intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201110145001.3280479-1-geert+renesas@glider.be>
References: <20201110145001.3280479-1-geert+renesas@glider.be>
Subject: Re: [PATCH] ASoC: intel: SND_SOC_INTEL_KEEMBAY should depend on ARCH_KEEMBAY
Message-Id: <160565265703.23689.2267658300131565861.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Nov 2020 15:50:01 +0100, Geert Uytterhoeven wrote:
> The Intel Keem Bay audio module is only present on Intel Keem Bay SoCs.
> Hence add a dependency on ARCH_KEEMBAY, to prevent asking the user about
> this driver when configuring a kernel without Intel Keem Bay platform
> support.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: intel: SND_SOC_INTEL_KEEMBAY should depend on ARCH_KEEMBAY
      commit: 9a207228bdf0a4933b794c944d7111564353ea94

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

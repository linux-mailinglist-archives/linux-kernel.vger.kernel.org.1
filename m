Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA5942B71AE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 23:38:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729234AbgKQWh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 17:37:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:41246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729217AbgKQWh5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 17:37:57 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E05C1206E0;
        Tue, 17 Nov 2020 22:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605652676;
        bh=Mtz9tEmVoqD4BFiEPcLYBQ3rkMPTjLGFyqnatHxG7oo=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=OVvtbHHk6tPrHyUE+ie1iMjBcVh8oXsJiWDXXN9WG2bH54rfXjCLUbe28cOr9gEah
         sSsCIAUOIIomo3S8ZY7eCQcAGFbh6RxtZjVVi4PBQ191BayTtuIvaGN6tIuxWD6B7l
         pzKhhR6nrohBm0QGjUvvhejCLUKbK1sPxmhvrWxQ=
Date:   Tue, 17 Nov 2020 22:37:37 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
In-Reply-To: <20201110145120.3280658-1-geert+renesas@glider.be>
References: <20201110145120.3280658-1-geert+renesas@glider.be>
Subject: Re: [PATCH] ASoC: fsl: SND_SOC_FSL_AUD2HTX should depend on ARCH_MXC
Message-Id: <160565265703.23689.12029405282658577742.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Nov 2020 15:51:20 +0100, Geert Uytterhoeven wrote:
> The Freescale/NXP AUDIO TO HDMI TX module is only present on NXP i.MX 8
> Series SoCs.  Hence add a dependency on ARCH_MXC, to prevent asking the
> user about this driver when configuring a kernel without i.MX 8 platform
> support.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl: SND_SOC_FSL_AUD2HTX should depend on ARCH_MXC
      commit: 674226db62ec758c4575bcdb933a2410f1a29bbf

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

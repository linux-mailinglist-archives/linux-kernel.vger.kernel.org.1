Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBE91279261
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 22:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbgIYUm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 16:42:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:50274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726119AbgIYUm0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 16:42:26 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D35B2086A;
        Fri, 25 Sep 2020 20:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601066546;
        bh=nepMzFSaNIWGuxvkPkhRS9U2GlxbM0iL0eqO6N+HKLo=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=pCkDikzIhtdTP4bvGUomx/0wLSWLHpejHeU9wZDVmmVFwi0x5oGbLBVcwGk0iMpVt
         ku0xZbRNup/A5AmlFXRsv1WQeAfr4A6qsYh6qFxXNunPENqlaT+VuoRFcZS/fgwNO8
         /lYvczd0vvSyHDN9i0YSPq6ulBXZbN/sTGkqYtuY=
Date:   Fri, 25 Sep 2020 21:41:31 +0100
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, tiwai@suse.com, festevam@gmail.com,
        nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        Shengjiu Wang <shengjiu.wang@nxp.com>, perex@perex.cz,
        alsa-devel@alsa-project.org, timur@kernel.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <1600424760-32071-1-git-send-email-shengjiu.wang@nxp.com>
References: <1600424760-32071-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: fsl_sai: Instantiate snd_soc_dai_driver
Message-Id: <160106647646.2866.2202767097591123725.b4-ty@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Sep 2020 18:26:00 +0800, Shengjiu Wang wrote:
> Instantiate snd_soc_dai_driver for independent symmetric control.
> Otherwise the symmetric setting may be overwritten by other
> instance.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_sai: Instantiate snd_soc_dai_driver
      commit: 22a16145af824f91014d07f8664114859900b9e6

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

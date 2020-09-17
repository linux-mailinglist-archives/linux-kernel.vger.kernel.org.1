Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D581226E4D1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 20:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbgIQS7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 14:59:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:59300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726658AbgIQS6j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 14:58:39 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0020F22208;
        Thu, 17 Sep 2020 18:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600369118;
        bh=WzQSueMrPjH1L0bv8gkr24oYRFWKRtRXu3TB/kv+Fws=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=KvMZfo4kro2jTQb5Wgt+VFDai1DJo7YYwmtvW3jtJMW8zaJqwHI8+l85SzRbpn/BS
         lUU/oqMaCrHn5ly2TQ81LBThPqH282ocOnCeL8oXxylFcSnPfSnwkPZZnVy6Q/yaCZ
         VQ2yEsjJx+uXouSwzqwgRIBEQuiXwJAsP58Jdo5U=
Date:   Thu, 17 Sep 2020 19:57:48 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Xiubo Li <Xiubo.Lee@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Viorel Suman (OSS)" <viorel.suman@oss.nxp.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Timur Tabi <timur@kernel.org>, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, Fabio Estevam <festevam@gmail.com>
Cc:     NXP Linux Team <linux-imx@nxp.com>,
        Viorel Suman <viorel.suman@gmail.com>,
        Viorel Suman <viorel.suman@nxp.com>
In-Reply-To: <1600104274-13110-1-git-send-email-viorel.suman@oss.nxp.com>
References: <1600104274-13110-1-git-send-email-viorel.suman@oss.nxp.com>
Subject: Re: [PATCH] ASoC: fsl_audmix: make clock and output src write only
Message-Id: <160036900934.20113.8635457303400843609.b4-ty@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Sep 2020 20:24:34 +0300, Viorel Suman (OSS) wrote:
> "alsactl -f state.conf store/restore" sequence fails because setting
> "mixing clock source" and "output source" requires active TDM clock
> being started for configuration propagation. Make these two controls
> write only so that their values are not stored at "alsactl store".

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_audmix: make clock and output src write only
      commit: 944c517b8c838832a166f1c89afbf8724f4a6b49

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

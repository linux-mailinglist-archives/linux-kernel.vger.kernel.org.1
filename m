Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 592E52E9C39
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 18:42:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727318AbhADRk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 12:40:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:36316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726124AbhADRk4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 12:40:56 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 63FF720679;
        Mon,  4 Jan 2021 17:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609782015;
        bh=V2oGYPbSi6aA3r4g30F2Mg4qcT0P4CxmiDuS2SFjEas=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=cuo94cEciJVUKipGgtXCAsrtR6QcFK8+YBI/6/W9JvUV6wyYKD+rJiZgJJFVlrOS7
         l3U/ZYGqH+3RdoOB8jCoSSNkpWKNbIN9E0117GZk/r0vtuTbQGj4Ht4Fq6QeMiZDDQ
         Y8s8DzDhDOxx4lJ+WsJFR76AkhlKrTy3MEJKGt6021RkzkUDZ3J9QmNkssAmiQH0D/
         DLD4vhAl0z7U5oMrfh6md93+zOUNdXH3aL8yszHlYm8DdZTXmyPcBUsymc37msDYj4
         QRdPhr8WSaCbtaWQNKXXb6dK8r13NuG5+0JXZr2C9yF5Rmop/WIB2iYRB65viBxivC
         DdZnvblRHQnbg==
From:   Mark Brown <broonie@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Arnd Bergmann <arnd@kernel.org>
Cc:     Viorel Suman <viorel.suman@nxp.com>, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Fabio Estevam <festevam@gmail.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        alsa-devel@alsa-project.org
In-Reply-To: <20210103135327.3630973-1-arnd@kernel.org>
References: <20210103135327.3630973-1-arnd@kernel.org>
Subject: Re: [PATCH] ASoC: fsl_aud2htx: select SND_SOC_IMX_PCM_DMA
Message-Id: <160978198913.14397.3806558309581636752.b4-ty@kernel.org>
Date:   Mon, 04 Jan 2021 17:39:49 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Jan 2021 14:53:17 +0100, Arnd Bergmann wrote:
> The newly added driver requires DMA support and fails to build
> when that is disabled:
> 
> aarch64-linux-ld: sound/soc/fsl/fsl_aud2htx.o: in function `fsl_aud2htx_probe':
> fsl_aud2htx.c:(.text+0x3e0): undefined reference to `imx_pcm_dma_init'

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_aud2htx: select SND_SOC_IMX_PCM_DMA
      commit: a1f31cc4e98e1833f53fd2c6e9a218d6b86f5388

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

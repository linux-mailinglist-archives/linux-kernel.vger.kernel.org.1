Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACB601E1115
	for <lists+linux-kernel@lfdr.de>; Mon, 25 May 2020 16:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404069AbgEYO5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 May 2020 10:57:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:43936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404013AbgEYO5R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 10:57:17 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA1EE20888;
        Mon, 25 May 2020 14:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590418637;
        bh=8WVLyXr0Odhzbow2buRRMTNNClxPsS9poOAULwszdI8=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=Mv0X+lMEX/4sKlmT8Oq8axAWmCWw9vrtKPhZe8rBpeouyRAyK1PtLK1la/Ni5ihcE
         C68VtPIl4/tu1DZ3lwzEuBqJcwzPPJdw8roWBj5ktAtHrkXV4RdBotNrXW/WaWPUjd
         AFSb/MGSq3hg0/jWg6uDzNGjJ9jV9bpqisZAklNs=
Date:   Mon, 25 May 2020 15:57:14 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Xiubo.Lee@gmail.com, Shengjiu Wang <shengjiu.wang@nxp.com>,
        lgirdwood@gmail.com, festevam@gmail.com, timur@kernel.org,
        perex@perex.cz, alsa-devel@alsa-project.org,
        nicoleotsuka@gmail.com, tiwai@suse.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <1590397412-12966-1-git-send-email-shengjiu.wang@nxp.com>
References: <1590397412-12966-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: fsl_asrc: Fix -Wmissing-prototypes warning
Message-Id: <159041861696.1370.8723738708251102724.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 May 2020 17:03:32 +0800, Shengjiu Wang wrote:
> COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=x86_64
> 
> sound/soc/fsl/fsl_asrc.c:557:18: warning: no previous prototype for function 'fsl_asrc_get_dma_channel' [-Wmissing-prototypes]
> struct dma_chan *fsl_asrc_get_dma_channel(struct fsl_asrc_pair *pair, bool dir)
>                  ^
> sound/soc/fsl/fsl_asrc.c:557:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
> struct dma_chan *fsl_asrc_get_dma_channel(struct fsl_asrc_pair *pair, bool dir)
> ^
> static

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_asrc: Fix -Wmissing-prototypes warning
      commit: cff1f8b4f8e119a9dbd9872d7a04fedef8d0c1a2

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

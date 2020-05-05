Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E846C1C53B2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 May 2020 12:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728792AbgEEKwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 May 2020 06:52:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:60180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728180AbgEEKwT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 06:52:19 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 928F6206A5;
        Tue,  5 May 2020 10:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588675939;
        bh=6eldmAKJS3vfCw/m2j008MyCpoSkTVPiIgfiMv12/yw=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=EVMMyqNUrqDBvUsvNmwqmoLKrR5Jm/LXzLsUNVyMke+kowhYtJrS2xLoJKehUVDXV
         yqlLUzNz6KIy2aNwl+rk92TaTBEj1hFoTPgznnWDPJ80GkI5v9jZvlF2ru/4M2lOFN
         VSW81ybIN2+6idks79UzB/PU/+oXPr0lDjf87bbI=
Date:   Tue, 05 May 2020 11:52:16 +0100
From:   Mark Brown <broonie@kernel.org>
To:     perex@perex.cz, alsa-devel@alsa-project.org,
        gregkh@linuxfoundation.org, Shengjiu Wang <shengjiu.wang@nxp.com>,
        kstewart@linuxfoundation.org, tiwai@suse.com, lgirdwood@gmail.com,
        tglx@linutronix.de, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org, allison@lohutok.net
In-Reply-To: <cff745cc041c5208910821f0740f988926af8a66.1574418380.git.shengjiu.wang@nxp.com>
References: <cff745cc041c5208910821f0740f988926af8a66.1574418380.git.shengjiu.wang@nxp.com>
Subject: Re: [RESEND PATCH] ASoC: wm8524: Add support S32_LE
Message-Id: <158867593662.11678.18322180422174799283.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Nov 2019 18:30:13 +0800, Shengjiu Wang wrote:
> Allow 32bit sample with this codec.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  sound/soc/codecs/wm8524.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.8

Thanks!

[1/1] ASoC: wm8524: Add support S32_LE
      commit: dbab677f324dcf26dc8c443e3ff39a4eaa6dcacc

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

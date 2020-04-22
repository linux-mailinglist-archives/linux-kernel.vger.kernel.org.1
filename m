Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16B421B441B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Apr 2020 14:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbgDVMQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Apr 2020 08:16:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:52260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726110AbgDVMQt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 08:16:49 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85DF12084D;
        Wed, 22 Apr 2020 12:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587557809;
        bh=bpPKxpz11SYhWTfv22owZ65XOFKOg9Ieo8uSb/AaLe0=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=ugD+hpZba41YUQEYft7ycbxY5cw+ZUyZyoif61nM8mIjsVWMyUf1xOq09wLS60oAF
         yjmoNypbAy2wl/aTxpYKUeZcEcqMNZ0H2uek1f61MbSiUj0Gre0Un+lt3U/IOSj13I
         pnKA93yWW+8QDlCTxqjuE9vG46S7WLGB4P/qid6A=
Date:   Wed, 22 Apr 2020 13:16:46 +0100
From:   Mark Brown <broonie@kernel.org>
To:     perex@perex.cz, kuninori.morimoto.gx@renesas.com,
        Jason Yan <yanaijie@huawei.com>, alsa-devel@alsa-project.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org, tiwai@suse.com
In-Reply-To: <20200422071805.48793-1-yanaijie@huawei.com>
References: <20200422071805.48793-1-yanaijie@huawei.com>
Subject: Re: [PATCH] ASoC: soc-core: return true, false in snd_soc_volsw_is_stereo()
Message-Id: <158755779483.28370.5663062095876370884.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Apr 2020 15:18:05 +0800, Jason Yan wrote:
> Fix the following coccicheck warning:
> 
> include/sound/soc.h:1271:9-10: WARNING: return of 0/1 in function
> 'snd_soc_volsw_is_stereo' with return type bool
> 
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.8

Thanks!

[1/1] ASoC: soc-core: return true, false in snd_soc_volsw_is_stereo()
      commit: 4aa86e05be84b0692846799fce16c233a170c559

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

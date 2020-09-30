Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F38527E812
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 14:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729668AbgI3L74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 07:59:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:50726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbgI3L7z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 07:59:55 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0584A2075F;
        Wed, 30 Sep 2020 11:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601467195;
        bh=ISbLEyVRJ3YYEaL+4amU3UcxHwOFBV2/mqHOS1AZfTI=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=Y0YyWw8CNbpdLpMe9jELYNndvNBCi6BJ6iNkKosLBzcdgYLgxa52QqbefuxM4C38U
         DF5IjxxYkZVeAEN+2DPN0RL42nd7IEpt4BjtgCmdFNA2A0u4lAITSRUxIVffdERbaK
         vjttzXi8Gn4MD1G72UdvXWZnCjRi7iFd3ywEIn38=
Date:   Wed, 30 Sep 2020 12:58:56 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Qinglang Miao <miaoqinglang@huawei.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
In-Reply-To: <20200929112933.46977-1-miaoqinglang@huawei.com>
References: <20200929112933.46977-1-miaoqinglang@huawei.com>
Subject: Re: [PATCH -next] ASoC: soc-core: use devm_snd_soc_register_card()
Message-Id: <160146713690.40065.6936378045479268404.b4-ty@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Sep 2020 19:29:33 +0800, Qinglang Miao wrote:
> Using devm_snd_soc_register_card() can make the code
> shorter and cleaner.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: soc-core: use devm_snd_soc_register_card()
      commit: ad61b78ea8913e5cf9c91f5527428eed1bd2a862

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

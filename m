Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB2F826E4D2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 20:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbgIQS7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 14:59:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:59446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726365AbgIQS6o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 14:58:44 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 104AB206A1;
        Thu, 17 Sep 2020 18:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600369123;
        bh=araJfiJ+kmWz4pIb/SGg02CpwFKtGCvtcajg+qf9GYw=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=zj9ZNv8lweI4Sr+NvvM6UEgFWEf2eI3JkmwiJE4OZg/jTvgS2FNAHLy5LpFpVn0nf
         yYnLR1jtk+posThYcFbTj1St3H2vuDmFQnyTMzWBKd76qH/Gh0+220DfpIRguOPwey
         4KpItyWpzI5Pb75LTx+ZEuYYDqCZQUQiqPgBxWkM=
Date:   Thu, 17 Sep 2020 19:57:53 +0100
From:   Mark Brown <broonie@kernel.org>
To:     tiwai@suse.com, lgirdwood@gmail.com, perex@perex.cz,
        timur@kernel.org, Shengjiu Wang <shengjiu.wang@nxp.com>,
        Xiubo.Lee@gmail.com, festevam@gmail.com, nicoleotsuka@gmail.com,
        alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <1600323079-5317-1-git-send-email-shengjiu.wang@nxp.com>
References: <1600323079-5317-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH v2 0/3] ASoC: fsl_sai: update the register list
Message-Id: <160036900933.20113.13971334794679632002.b4-ty@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Sep 2020 14:11:16 +0800, Shengjiu Wang wrote:
> As sai ip is upgraded, so update sai register list.
> 
> Shengjiu Wang (3):
>   ASoC: fsl_sai: Add new added registers and new bit definition
>   ASoC: fsl_sai: Add fsl_sai_check_version function
>   ASoC: fsl_sai: Set MCLK input or output direction
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: fsl_sai: Add new added registers and new bit definition
      commit: 0b2cbce6898600aae5e87285f1c2000162d59c76
[2/3] ASoC: fsl_sai: Add fsl_sai_check_version function
      commit: 1dc658b13c1c365274b27bfc3c4d4f2955348fb8
[3/3] ASoC: fsl_sai: Set MCLK input or output direction
      commit: a57d4e8730c1a55b2547ff81aef4753b67121cb8

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

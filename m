Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07D691FA484
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jun 2020 01:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbgFOXlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jun 2020 19:41:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:53420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725960AbgFOXlB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 19:41:01 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB929208C7;
        Mon, 15 Jun 2020 23:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592264461;
        bh=VNG0x2ry8DNg0uuOprW2CZEqy4U0NPn9pUHqCmHFaAY=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=dIR6A3sEGPc+ZJizlBLA68Bn/sllJmUGuRuuFj8hMyoLQYDB7lB33qMLYXMEKnHC1
         /BP3Q9l8ms78KGfKFHRX0olTqkQic5T4NMu4yWNVCk7cYZCsHRmT5n2RFHDzoOPXOa
         H1Zn86f1pQ1xtMalF6D7ogFi0Le8chBA+37yRjeM=
Date:   Tue, 16 Jun 2020 00:40:59 +0100
From:   Mark Brown <broonie@kernel.org>
To:     nicoleotsuka@gmail.com, timur@kernel.org, perex@perex.cz,
        lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        festevam@gmail.com, tiwai@suse.com,
        Shengjiu Wang <shengjiu.wang@nxp.com>, Xiubo.Lee@gmail.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <cover.1591155860.git.shengjiu.wang@nxp.com>
References: <cover.1591155860.git.shengjiu.wang@nxp.com>
Subject: Re: [PATCH 0/3] ASoC: fsl_easrc: Fix several warnings
Message-Id: <159226439189.27409.5606494453578496957.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Jun 2020 11:39:38 +0800, Shengjiu Wang wrote:
> Fix several warnings with "make W=1"
> 
> Shengjiu Wang (3):
>   ASoC: fsl_easrc: Fix -Wmissing-prototypes warning
>   ASoC: fsl_easrc: Fix -Wunused-but-set-variable
>   ASoC: fsl_easrc: Fix "Function parameter not described" warnings
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: fsl_easrc: Fix -Wmissing-prototypes warning
      commit: e4cc0aaac390a87f80ae542c75d4c84de08816f9
[2/3] ASoC: fsl_easrc: Fix -Wunused-but-set-variable
      commit: 633a2c7d6e621e748d69423fa85be88c7dcd4f94
[3/3] ASoC: fsl_easrc: Fix "Function parameter not described" warnings
      commit: d73d682a9e87fa494868e8094fcc5b6a6b505464

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

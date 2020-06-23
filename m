Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E21E52052A9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 14:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732644AbgFWMjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jun 2020 08:39:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:51278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729667AbgFWMjW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 08:39:22 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3852920771;
        Tue, 23 Jun 2020 12:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592915961;
        bh=ElqinQ8jLXlb518VHlHFZai+tOFrbXjuJZhuXR6rshk=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=KHypS/IlrCvuiRyNEcfy1xg/VqW3ooQRuUifFQVgyQhFh0rxCC1lj6VKErALutBIe
         c+ReURHePpe95Kyc+fwcCrjcsSm7GUVXGVt2PULMxuuHU0A/nMMPvQudpjyOQXgdVe
         4dLq7GeHrW8pd7kWAqSf8SiH1z14O9y0CBUHQWl0=
Date:   Tue, 23 Jun 2020 13:39:19 +0100
From:   Mark Brown <broonie@kernel.org>
To:     perex@perex.cz, alsa-devel@alsa-project.org, tiwai@suse.com,
        Shengjiu Wang <shengjiu.wang@nxp.com>, Xiubo.Lee@gmail.com,
        festevam@gmail.com, timur@kernel.org, nicoleotsuka@gmail.com,
        lgirdwood@gmail.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <1592816611-16297-1-git-send-email-shengjiu.wang@nxp.com>
References: <1592816611-16297-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: fsl_easrc: Fix uninitialized scalar variable in fsl_easrc_set_ctx_format
Message-Id: <159291594453.44561.6202689479797567993.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Jun 2020 17:03:31 +0800, Shengjiu Wang wrote:
> The "ret" in fsl_easrc_set_ctx_format is not initialized, then
> the unknown value maybe returned by this function.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_easrc: Fix uninitialized scalar variable in fsl_easrc_set_ctx_format
      commit: 5748f4eb01a4df7a42024fe8bc7855f05febb7c5

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

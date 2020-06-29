Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A933120D15B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jun 2020 20:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbgF2SlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jun 2020 14:41:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:60594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728739AbgF2SlL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:41:11 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 839F52559D;
        Mon, 29 Jun 2020 18:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593454509;
        bh=IPwYZWpcmEBmGKzpEn32o92vTbK48d5Td6bDmd7aHCk=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=x50Faqq+gwSwcZygE4OE7sGOF5idPSWZfmTac/xIZCdD30VFEN8bXJfD0PR9m8yor
         812VR2ZzMHMwlsxjVuWfDx5o0dokYrjQPYvnAm9MAbUB46uLKU1po2wdDUb5dkVbIF
         u3KZ0Wv3I1T9cf0J0Z72E9+K9Fu8zBNmX4FjoZHU=
Date:   Mon, 29 Jun 2020 19:15:06 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>, Patrick Lai <plai@codeaurora.org>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Rohit kumar <rohitkr@codeaurora.org>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
In-Reply-To: <20200629122443.21736-1-geert@linux-m68k.org>
References: <20200629122443.21736-1-geert@linux-m68k.org>
Subject: Re: [PATCH] ASoC: qcom: Drop HAS_DMA dependency to fix link failure
Message-Id: <159345450676.54191.5667484527733224439.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Jun 2020 14:24:43 +0200, Geert Uytterhoeven wrote:
> When building on allyesconfig kernel for a NO_DMA=y platform (e.g.
> Sun-3), CONFIG_SND_SOC_QCOM_COMMON=y, but CONFIG_SND_SOC_QDSP6_AFE=n,
> leading to a link failure:
> 
>     sound/soc/qcom/common.o: In function `qcom_snd_parse_of':
>     common.c:(.text+0x2e2): undefined reference to `q6afe_is_rx_port'
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: qcom: Drop HAS_DMA dependency to fix link failure
      commit: b6aa06de7757667bac88997a8807b143b8436035

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

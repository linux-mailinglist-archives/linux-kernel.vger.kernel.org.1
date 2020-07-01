Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E893F2115CB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jul 2020 00:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbgGAWXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jul 2020 18:23:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:50178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726116AbgGAWXI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 18:23:08 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A978E20780;
        Wed,  1 Jul 2020 22:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593642188;
        bh=su8lRXPUuESBhMFT4qfJWMmRjY0xhVTDKxotkdY74v8=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=lKprS4aJgESOGveRTAbiF7BH6q5sc7al7dsGwQHUJMeV1dmv4340iQcahdJr4B+cF
         Se9cDdjIy/BwJpOIKLEqtJguTFmcnPTTGp/lilx9uqT7fDqFqfzHlyfLGqeW06pJ+y
         C/X8W7hrcWRKahHce+U2Fsl5dbXmekobhze/VzUk=
Date:   Wed, 01 Jul 2020 23:23:06 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Akshu Agrawal <akshu.agrawal@amd.com>
Cc:     Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.com>,
        Colin Ian King <colin.king@canonical.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        open list <linux-kernel@vger.kernel.org>
In-Reply-To: <20200630183754.20641-1-akshu.agrawal@amd.com>
References: <20200630183754.20641-1-akshu.agrawal@amd.com>
Subject: Re: [PATCH] ASoC: amd: Enable interrupt in dma_open
Message-Id: <159364215574.10630.16072972777156479448.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Jul 2020 00:07:46 +0530, Akshu Agrawal wrote:
> Fixes interrupt enable condition check with which now
> interrupt gets enabled in dma_open.
> Prior to this patch it was getting enabled in runtime_resume only.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: amd: Enable interrupt in dma_open
      commit: 820d7fcb23c189e87bfe8c95a6e7215d873e5082

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

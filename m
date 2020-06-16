Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A46231FA47B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jun 2020 01:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbgFOXkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jun 2020 19:40:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:52030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726546AbgFOXkQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 19:40:16 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B112820714;
        Mon, 15 Jun 2020 23:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592264416;
        bh=nm6YjcSTLxiQn/pubcq2UsGgEJdKRxFZIDhtloCwd3s=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=Ntm1hMrDLcgcUAULOYdK9V2T9COZBi0HBv2lbd+T/0XIPlV3P2LtOklrjg2H9R5ZF
         WXBHlIVx63/6xgJ712O9Yvru8unHNZKC2c7gfLzcqgfkXv+wlUnKzHPGjSyCZxy0m9
         uImbbtZPHj0u940PM3xMTaTUc9P6eXktQpfUJ0g8=
Date:   Tue, 16 Jun 2020 00:40:14 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Akshu Agrawal <akshu.agrawal@amd.com>
Cc:     "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>, yuhsuan@chromium.org,
        YueHaibing <yuehaibing@huawei.com>
In-Reply-To: <20200530095519.24324-1-akshu.agrawal@amd.com>
References: <20200530095519.24324-1-akshu.agrawal@amd.com>
Subject: Re: [v3] ASoC: AMD: Use mixer control to switch between DMICs
Message-Id: <159226439188.27409.56215501183185998.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 May 2020 15:25:06 +0530, Akshu Agrawal wrote:
> Having mixer control to switch between DMICs prevents user to
> initiate capture simultaneously on both the DMIcs.
> Earlier 2 separate devices, one for each DMIC, gave an option of
> using them simultaneously, which is not supported.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: AMD: Use mixer control to switch between DMICs
      commit: b7a742cff3f618d848e62e5a1ade0ff816e93092

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

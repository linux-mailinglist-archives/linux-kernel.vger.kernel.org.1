Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3DD627350D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 23:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbgIUVlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 17:41:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:58144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726452AbgIUVle (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 17:41:34 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 906FD23A60;
        Mon, 21 Sep 2020 21:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600724494;
        bh=CnYDBVW2rYjgRoaGJx/XhCKqd7MzAZDqUTLvs1cvdDU=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=n9BjRmScECzUdhuU2SJpgQAUggFS/xhcv1JB9RcwcrTWLnOGK3KEIXpEzB2RR4iYP
         0G1kXTcDgykM3OU4z8YlGA9DMin2EL3PpX/H6HyrsM5oP8Z6XvCNZuQ+ibb4NFd0pa
         GjO01Kbr5GhtGczG4h1tvHr2LI8b+D4CzRlh5OZY=
Date:   Mon, 21 Sep 2020 22:40:40 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Takashi Iwai <tiwai@suse.com>
Cc:     linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        alsa-devel@alsa-project.org
In-Reply-To: <20200911173140.29984-1-miquel.raynal@bootlin.com>
References: <20200911173140.29984-1-miquel.raynal@bootlin.com>
Subject: Re: [PATCH 0/3] tlv320aic3xx4 updates
Message-Id: <160072444039.56872.6911878141107050314.b4-ty@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Sep 2020 19:31:37 +0200, Miquel Raynal wrote:
> While doing a kernel update on a sama5-based board I figured out the
> sound system was not working anymore, the debug session led me to the
> following commits. As I am not an audio expert at all, I am fully open
> to comments and suggestions.
> 
> Thanks,
> Miquèl
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: tlv320aic32x4: Ensure a minimum delay before clock stabilization
      commit: 5b4458ebb4c8007dae7eaeb88cb52b2bb4879894
[2/3] ASoC: tlv320aic32x4: Fix bdiv clock rate derivation
      commit: 40b37136287ba6b34aa2f1f6123f3d6d205dc2f0
[3/3] ASoC: tlv320aic32x4: Enable fast charge
      commit: ec96690de82cee2cb028c07b1e72cb4a446ad03a

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

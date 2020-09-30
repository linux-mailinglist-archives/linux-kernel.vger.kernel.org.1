Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50A6627EC0C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 17:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730811AbgI3POH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 11:14:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:38092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727426AbgI3PN5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 11:13:57 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E0E520657;
        Wed, 30 Sep 2020 15:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601478837;
        bh=MNR+bUtMZLuLBJt10auA5jj1QkNQ9OW5xWDqLbXoQoo=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=bd6wn1wSr1CgjWh0B12Y+pmZmxywyjyGRDedju7a/xvFqeSWuGplDGRs0wPWo2DmC
         f8Ig0/dfOIQXMP3bFWDSmFF8hnIftY6ouoY0MPOurr/DbG1tau32qWfRVsv0ExL9Pn
         IHERdr1XXHoQpeSJ2eOMqOfnjduQm6ZVf6qmPnmg=
Date:   Wed, 30 Sep 2020 16:12:58 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Takashi Iwai <tiwai@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        alsa-devel@alsa-project.org
In-Reply-To: <20200930145330.3043528-1-alexandre.belloni@bootlin.com>
References: <20200930145330.3043528-1-alexandre.belloni@bootlin.com>
Subject: Re: [PATCH] ASoC: atmel-pcm: remove unnecessary include
Message-Id: <160147877281.10117.14415421643228167921.b4-ty@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Sep 2020 16:53:30 +0200, Alexandre Belloni wrote:
> Since commit 95e0e07e710e ("ASoC: atmel-pcm: use generic dmaengine
> framework"), the driver is using dmaengine and is not using any definition
> from include/linux/platform_data/dma-atmel.h, stop including it.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: atmel-pcm: remove unnecessary include
      commit: 62e5d7774629aac671c8c56a0ba016dbffb6dff2

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

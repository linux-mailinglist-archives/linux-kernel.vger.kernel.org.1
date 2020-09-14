Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B82F268E60
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 16:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbgINOwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 10:52:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:53050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726645AbgINOw3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 10:52:29 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4EDC6206BE;
        Mon, 14 Sep 2020 14:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600095148;
        bh=cZBt/BYXGb7XMmjCUMxtBhCxEA94mJlipi9mDTE83sM=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=d5ifTqJKTWvyHHbPZgIuvbmo2IFAAh3lnZuFAlkurNs9YbM6I3b7TYOxxRQkq0ylv
         jdXALa300eyOYZ2JtdoC/atrHX17vYwScCc9mQ6nEvHYXz7N4LisLUG6vOMcaUwfpu
         oI0clGmmToM2VuztaBRIfu5ZELNJTeE2KWQl/nzw=
Date:   Mon, 14 Sep 2020 15:51:40 +0100
From:   Mark Brown <broonie@kernel.org>
To:     perex@perex.cz, baijiaju1990@163.com, Tuo Li <tuoli96@outlook.com>,
        lgirdwood@gmail.com, tiwai@suse.com, heiko@sntech.de,
        islituo@163.com
Cc:     linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org
In-Reply-To: <TY2PR04MB4029799E60A5BCAAD5B7B5BBB8280@TY2PR04MB4029.apcprd04.prod.outlook.com>
References: <TY2PR04MB4029799E60A5BCAAD5B7B5BBB8280@TY2PR04MB4029.apcprd04.prod.outlook.com>
Subject: Re: [PATCH] ALSA: rockchip_i2s: fix a possible divide-by-zero bug in rockchip_i2s_hw_params()
Message-Id: <160009506912.439.250974884973031810.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Sep 2020 21:09:37 +0800, Tuo Li wrote:
> The variable bclk_rate is checked in:
>   if (bclk_rate && mclk_rate % bclk_rate)
> 
> This indicates that bclk_rate can be zero.
> If so, a divide-by-zero bug will occur:
>   div_bclk = mclk_rate / bclk_rate;
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ALSA: rockchip_i2s: fix a possible divide-by-zero bug in rockchip_i2s_hw_params()
      commit: 375e2c352582442783178e6a33c279d6bc9354a2

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

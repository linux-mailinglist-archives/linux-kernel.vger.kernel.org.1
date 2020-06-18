Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE79F1FF9A0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jun 2020 18:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732110AbgFRQsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Jun 2020 12:48:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:56716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730373AbgFRQsc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 12:48:32 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5E4D208C7;
        Thu, 18 Jun 2020 16:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592498912;
        bh=/WNekgZirWYXrCP4XgGxyiKDiwg2gM4IDVcjUWu8fBs=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=JHBJc52qgg06U8TRJ0jR/I4mprYbbU4MTjDm7kuraFaXPRRQJgsb3yOg/rwPzFupq
         x4yqSvAoIMEs1KHyFHA4Pdlg7VTPlr4AR1ptsxOB0r3oInSdR1ezG4Pz3Itth8Xui6
         orfh/1y1Cqq3v+HjZEZtT0LDV787jsds9KKxNxMI=
Date:   Thu, 18 Jun 2020 17:48:30 +0100
From:   Mark Brown <broonie@kernel.org>
To:     kjlu@umn.edu, "wu000273@umn.edu" <wu000273@umn.edu>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sugar Zhang <sugar.zhang@rock-chips.com>,
        alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>,
        linux-arm-kernel@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>
In-Reply-To: <20200613205158.27296-1-wu000273@umn.edu>
References: <20200613205158.27296-1-wu000273@umn.edu>
Subject: Re: [PATCH] ASoC: rockchip: Fix a reference count leak.
Message-Id: <159249891020.8643.15196266849523031585.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Jun 2020 15:51:58 -0500, wu000273@umn.edu wrote:
> Calling pm_runtime_get_sync increments the counter even in case of
> failure, causing incorrect ref count if pm_runtime_put is not called in
> error handling paths. Call pm_runtime_put if pm_runtime_get_sync fails.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: rockchip: Fix a reference count leak.
      commit: f141a422159a199f4c8dedb7e0df55b3b2cf16cd

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

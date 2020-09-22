Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A891B2744F6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 17:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgIVPF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 11:05:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:46420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726656AbgIVPF7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 11:05:59 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47F9920715;
        Tue, 22 Sep 2020 15:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600787158;
        bh=hI0rf/8J5dklPjDD41Q/MFWpGh4T4WCJvt1mUDThuhs=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=cxnxD86z9Z4WSM957gzJNXxd59ai0RPgqLMfMwiuKLx4SpOMoct4JCAKEKkg+pnY+
         x6QckJdiYStVL1T8oLdwsxMSUqDPgTxR9XqV/AjoLUKpuz7YWW1MxM5K/5mYdPmI2I
         iaoikPkeILaTVjYcjtd1yHE3y+/Udm6wjyyGb+u0=
Date:   Tue, 22 Sep 2020 16:05:06 +0100
From:   Mark Brown <broonie@kernel.org>
To:     lgirdwood@gmail.com, tiwai@suse.com, robh+dt@kernel.org,
        Dan Murphy <dmurphy@ti.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
In-Reply-To: <20200922142411.10364-1-dmurphy@ti.com>
References: <20200922142411.10364-1-dmurphy@ti.com>
Subject: Re: [PATCH] ASoC: tas2562: Remove duplicate code for I/V sense
Message-Id: <160078710095.52882.10146545480873734232.b4-ty@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Sep 2020 09:24:11 -0500, Dan Murphy wrote:
> Remove duplicate code for programming the I/V sense the call to update
> the register was duplicated in commit 09ed395b05feb ("ASoC: tas2562:
> Add voltage sense slot configuration").

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: tas2562: Remove duplicate code for I/V sense
      commit: 90e2a588c9e743f104849fb2da4c121e1a487201

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

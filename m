Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB792A83CA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 17:45:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731304AbgKEQpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 11:45:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:48202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726214AbgKEQpd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 11:45:33 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8489621D46;
        Thu,  5 Nov 2020 16:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604594733;
        bh=3UHLZIzEW15TXpSpqNOpAH3xDTStmcO1nGcJdcK67lA=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=lD/pSl9xhcFNC8P/62zcEQ8v8OvnDY2dqfrgPVRrGQpnEV4vfZcH/EKzbwj3M4g0S
         kTJoGKJjzG56bhW9Ex0TRTu4XbpT0GSsemFtG6cNEa0RhoeoXnc639oX9lmfTsqnGW
         CPRDqwDlS9h78bhK0HK9jOSFbKk3YyaJZAspGDyQ=
Date:   Thu, 05 Nov 2020 16:45:22 +0000
From:   Mark Brown <broonie@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, perex@perex.cz,
        haojian.zhuang@gmail.com, Xu Wang <vulab@iscas.ac.cn>,
        alsa-devel@alsa-project.org, tiwai@suse.com, daniel@zonque.org,
        robert.jarzmik@free.fr, lgirdwood@gmail.com
Cc:     linux-kernel@vger.kernel.org
In-Reply-To: <20201029090104.29552-1-vulab@iscas.ac.cn>
References: <20201029090104.29552-1-vulab@iscas.ac.cn>
Subject: Re: [PATCH] ASoC: pxa: pxa-ssp: Remove redundant null check before clk_prepare_enable/clk_disable_unprepare
Message-Id: <160459472200.54851.11789751712463576471.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Oct 2020 09:01:04 +0000, Xu Wang wrote:
> ecause clk_prepare_enable() and clk_disable_unprepare() already checked
> NULL clock parameter, so the additional checks are unnecessary, just
> remove them.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: pxa: pxa-ssp: Remove redundant null check before clk_prepare_enable/clk_disable_unprepare
      commit: b8f94957765629e6a0d89abb4ff7e06e6565f61f

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

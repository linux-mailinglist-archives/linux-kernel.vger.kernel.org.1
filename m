Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECF3B27925D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 22:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbgIYUmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 16:42:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:50090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726119AbgIYUmQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 16:42:16 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBAE92086A;
        Fri, 25 Sep 2020 20:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601066536;
        bh=eYynM7RcUl9T2R03Gzczex/EjCscDdA1EQyumjaJdJo=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=fcdk23UcLZoGUC1rmqRbEtIxyUX0aqP4NHgeBHEeZ0iA4Jpf9zjgmQvq9UpD3WEQU
         wFdTxl899cN1bMKvxrGZMHv5KkbS02bl0TpCjjO3YVmUfn9mmC6Sy/fl4oOPzKpTyY
         Zg/aRtYF79RmHZKYFbtkO5lKJwPsfUwWXj7B5Rc8=
Date:   Fri, 25 Sep 2020 21:41:21 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Daniel Baluta <daniel.baluta@oss.nxp.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
In-Reply-To: <20200924151518.15841-1-daniel.baluta@oss.nxp.com>
References: <20200924151518.15841-1-daniel.baluta@oss.nxp.com>
Subject: Re: [PATCH 0/2] Enable runtime PM for SOF device
Message-Id: <160106647646.2866.8438524820840222353.b4-ty@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Sep 2020 18:15:16 +0300, Daniel Baluta wrote:
> This enables runtime PM for SOF device. Next patchseries will
> provide PM suspend/resume handlers for i.MX8 specific devices.
> 
> Daniel Baluta (2):
>   ASoC: SOF: Activate runtime PM with SOF OF device
>   ASoC: SOF: Add .prepare/.complete callbacks
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: SOF: Activate runtime PM with SOF OF device
      commit: 4fefc39894d8975d58b02b4b5f635d20891778ca
[2/2] ASoC: SOF: Add .prepare/.complete callbacks
      commit: dd759805d6f78262cb9aa63ef37e3bc263ef1978

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

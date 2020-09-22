Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1621E2744F4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 17:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbgIVPFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 11:05:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:46322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726640AbgIVPFy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 11:05:54 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49678206DC;
        Tue, 22 Sep 2020 15:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600787153;
        bh=sZHWS+6GrMG2nrT6339PzN+FS8DpEX0pnvRec/GoSb4=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=T20PUZSUtegwd4/D25gfbdUw7stZkNb0CFWzN9QmHR2eRqhcQDeeXiLagdSwQ5N2l
         SmJYpVWoXlR1wqcPnvrHJhQCtHn//1O72gG1l+sDfhvWma0mChInvhYcmNNXhk8Ukq
         npLZ3qDfFZCVnpvJ4kHtBa/37QMaM7HgPwfordtY=
Date:   Tue, 22 Sep 2020 16:05:00 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Necip Fazil Yildiran <fazilyildiran@gmail.com>
Cc:     alsa-devel@alsa-project.org, paul@pgazz.com,
        linux-kernel@vger.kernel.org, ardb@kernel.org, jeho@cs.utexas.edu
In-Reply-To: <20200917141803.92889-1-fazilyildiran@gmail.com>
References: <20200917141803.92889-1-fazilyildiran@gmail.com>
Subject: Re: [PATCH] ASoC: cros_ec_codec: fix kconfig dependency warning for SND_SOC_CROS_EC_CODEC
Message-Id: <160078710095.52882.3222732916592587624.b4-ty@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Sep 2020 17:18:04 +0300, Necip Fazil Yildiran wrote:
> When SND_SOC_CROS_EC_CODEC is enabled and CRYPTO is disabled, it results
> in the following Kbuild warning:
> 
> WARNING: unmet direct dependencies detected for CRYPTO_LIB_SHA256
>   Depends on [n]: CRYPTO [=n]
>   Selected by [y]:
>   - SND_SOC_CROS_EC_CODEC [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && CROS_EC [=y]
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: cros_ec_codec: fix kconfig dependency warning for SND_SOC_CROS_EC_CODEC
      commit: 50b18e4a2608e3897f3787eaa7dfa869b40d9923

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

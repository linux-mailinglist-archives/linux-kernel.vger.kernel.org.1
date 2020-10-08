Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A02F1287E70
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 00:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729878AbgJHWCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 18:02:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:54044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725852AbgJHWB7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 18:01:59 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 707BC22244;
        Thu,  8 Oct 2020 22:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602194519;
        bh=k1V6OrupLcNeNFQfLBLLBhRQBY/eVFlgP8hwmK08lew=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=rGx38ez9zkZljUIwl/ogar/lEdyNl0R92nEog4pJVNEDupOGwLHMSdUOc3/WHy7xV
         +2O1yg0iUlpjW1vQ2PSqFOrSd/3OB3YSudfKsbdV3W1hV78M/gxICsEBuNbhhKjrM1
         G8f5PXfQhCeoom9JnaycsnZnxM1lyzQZGRlyvhmo=
Date:   Thu, 08 Oct 2020 23:01:56 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Colin King <colin.king@canonical.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        alsa-devel@alsa-project.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
In-Reply-To: <20201006152024.542418-1-colin.king@canonical.com>
References: <20201006152024.542418-1-colin.king@canonical.com>
Subject: Re: [PATCH][next] ASoC: mchp-spdifrx: fix spelling mistake "overrrun" -> "overrun"
Message-Id: <160219448330.29664.4641489072692300066.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Oct 2020 16:20:24 +0100, Colin King wrote:
> There is a spelling mistake in a dev_warn message. Fix it.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: mchp-spdifrx: fix spelling mistake "overrrun" -> "overrun"
      commit: 6db282c8a9edcbf84e699e45ec087baf07be2236

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

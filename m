Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9FF2CA4C0
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 15:00:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403855AbgLAN7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 08:59:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:45816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728980AbgLAN7q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 08:59:46 -0500
Received: from localhost (cpc102334-sgyl38-2-0-cust884.18-2.cable.virginm.net [92.233.91.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBD8320C56;
        Tue,  1 Dec 2020 13:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606831136;
        bh=YhgQZao5VbGau9cfjrXj/A+steCHHY0BXqeRNdlaEPM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=xwp65o2zPjvzSxZdvnbocqTSWXL97Ef+e5Dz9gG/KHBJ1DXTr+r8AY5lJstL7l1vy
         0F6cKC30O3n15lGHuhcR8Y/TP78RTvfqNcvgLMuyZ/pRocnFfHm9ZtdUSI5+/Qcz+c
         plxXlcEkbAXP125QXkT/vN6MWenpn9NsSklRerX4=
From:   Mark Brown <broonie@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     devicetree@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
In-Reply-To: <20201130215626.2400999-1-alexandre.belloni@bootlin.com>
References: <20201130215626.2400999-1-alexandre.belloni@bootlin.com>
Subject: Re: [PATCH] ASoC: adau1372: add missing dependencies
Message-Id: <160683107678.35139.14007436475647314012.b4-ty@kernel.org>
Date:   Tue, 01 Dec 2020 13:57:56 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Nov 2020 22:56:26 +0100, Alexandre Belloni wrote:
> SND_SOC_ADAU1372_I2C and SND_SOC_ADAU1372_SPI prpoerly select the REGMAP
> config they need but forget to depend on the underlying bus.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: adau1372: add missing dependencies
      (no commit info)

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

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3B0B1AC98E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Apr 2020 17:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395185AbgDPPYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Apr 2020 11:24:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:37542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2634250AbgDPPX6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 11:23:58 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D26E1206D6;
        Thu, 16 Apr 2020 15:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587050637;
        bh=nlIoWzdqyk42cQzlK0nulsxbUgd+cIzM+bIMPUFDAlI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=uOtJtJnEn183jGTGYG+EuR/emZOrXK/ogMMo/XNy0JOsWHSAJ5tW5KTUG6hedzp2j
         qWO8zL+YhcHXp6EA68wyEVJ0Ukx0xTR6xAM5hx+j7ejgm5h774ETbFEZ6N5Uxghi8r
         lkMl1M8uSMYSxJvePH3gmJ38UCMYRrNA029J23uY=
Date:   Thu, 16 Apr 2020 16:23:54 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Takashi Iwai <tiwai@suse.com>
Subject: Applied "ASoC: wcd9335: Fix missing regmap requirement" to the asoc tree
In-Reply-To:  <8c0b22e2-2c67-8d45-a57d-dfc54043fbc9@free.fr>
Message-Id:  <applied-8c0b22e2-2c67-8d45-a57d-dfc54043fbc9@free.fr>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: wcd9335: Fix missing regmap requirement

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

From 741bfce676b765f01396e148862740caec91338c Mon Sep 17 00:00:00 2001
From: Marc Gonzalez <marc.w.gonzalez@free.fr>
Date: Wed, 10 Apr 2019 16:23:38 +0200
Subject: [PATCH] ASoC: wcd9335: Fix missing regmap requirement

wcd9335.c: undefined reference to 'devm_regmap_add_irq_chip'

Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 419114edfd57..667fc1d59e18 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -1151,6 +1151,7 @@ config SND_SOC_WCD9335
 	tristate "WCD9335 Codec"
 	depends on SLIMBUS
 	select REGMAP_SLIMBUS
+	select REGMAP_IRQ
 	help
 	  The WCD9335 is a standalone Hi-Fi audio CODEC IC, supports
 	  Qualcomm Technologies, Inc. (QTI) multimedia solutions,
-- 
2.20.1


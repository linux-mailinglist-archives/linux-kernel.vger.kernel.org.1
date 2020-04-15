Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D24A1AA143
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Apr 2020 14:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S369837AbgDOMgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Apr 2020 08:36:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:34074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S369778AbgDOMep (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 08:34:45 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0056E206D5;
        Wed, 15 Apr 2020 12:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586954084;
        bh=U2YmseTlANKK+dbiJT/Rk72V3K1e4CYlnbGh0jjwpqM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=LK+ZCXJJXUKNwPGZh9RVn7FZyGdobbDn8uw2ITPIBJPuUrffuMUixz+GSojt3JRAh
         4zwqnxIH++WDh3kU1JI4/A5sIAHBWBAp3LPdJrNWxcSeXmvHSWQaL7StRXV6vLlIzB
         vFM9KjvI+wl5SQSeyiY9VB+PYStOYzVB5rfsRqBU=
Date:   Wed, 15 Apr 2020 13:34:42 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Tang Bin <tangbin@cmss.chinamobile.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Mark Brown <broonie@kernel.org>, nicoleotsuka@gmail.com,
        perex@perex.cz, Shengju Zhang <zhangshengju@cmss.chinamobile.com>,
        timur@kernel.org, tiwai@suse.com, Xiubo.Lee@gmail.com
Subject: Applied "ASoC: fsl_micfil: Omit superfluous error message in fsl_micfil_probe()" to the asoc tree
In-Reply-To:  <20200415044513.17492-1-tangbin@cmss.chinamobile.com>
Message-Id:  <applied-20200415044513.17492-1-tangbin@cmss.chinamobile.com>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: fsl_micfil: Omit superfluous error message in fsl_micfil_probe()

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

From 83b35f4586e235bfb785a7947b555ad8f3d96887 Mon Sep 17 00:00:00 2001
From: Tang Bin <tangbin@cmss.chinamobile.com>
Date: Wed, 15 Apr 2020 12:45:13 +0800
Subject: [PATCH] ASoC: fsl_micfil: Omit superfluous error message in
 fsl_micfil_probe()

In the function fsl_micfil_probe(), when get irq failed, the function
platform_get_irq() logs an error message, so remove redundant message here.

Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
Signed-off-by: Shengju Zhang <zhangshengju@cmss.chinamobile.com>
Link: https://lore.kernel.org/r/20200415044513.17492-1-tangbin@cmss.chinamobile.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_micfil.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/fsl/fsl_micfil.c b/sound/soc/fsl/fsl_micfil.c
index f7f2d29f1bfe..e73bd6570a08 100644
--- a/sound/soc/fsl/fsl_micfil.c
+++ b/sound/soc/fsl/fsl_micfil.c
@@ -702,10 +702,8 @@ static int fsl_micfil_probe(struct platform_device *pdev)
 	for (i = 0; i < MICFIL_IRQ_LINES; i++) {
 		micfil->irq[i] = platform_get_irq(pdev, i);
 		dev_err(&pdev->dev, "GET IRQ: %d\n", micfil->irq[i]);
-		if (micfil->irq[i] < 0) {
-			dev_err(&pdev->dev, "no irq for node %s\n", pdev->name);
+		if (micfil->irq[i] < 0)
 			return micfil->irq[i];
-		}
 	}
 
 	if (of_property_read_bool(np, "fsl,shared-interrupt"))
-- 
2.20.1


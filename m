Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C55B1D0671
	for <lists+linux-kernel@lfdr.de>; Wed, 13 May 2020 07:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728726AbgEMFks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 May 2020 01:40:48 -0400
Received: from inva021.nxp.com ([92.121.34.21]:47614 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728097AbgEMFkr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 01:40:47 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 095C12007B4;
        Wed, 13 May 2020 07:40:46 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 7D7E3201259;
        Wed, 13 May 2020 07:40:41 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 93F30402B4;
        Wed, 13 May 2020 13:40:35 +0800 (SGT)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, shengjiu.wang@nxp.com, tglx@linutronix.de,
        allison@lohutok.net, info@metux.net, patches@opensource.cirrus.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: wm8962: Use force clear for WM8962_SYSCLK_ENA after reset
Date:   Wed, 13 May 2020 13:30:35 +0800
Message-Id: <1589347835-20554-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CLOCKING2 is non-volatile register, we need force clear
the WM8962_SYSCLK_ENA bit after reset, for the value in cache
maybe 0 but in hardware it is 1. Otherwise there will issue
as below statement in driver.

/* SYSCLK defaults to on; make sure it is off so we can safely
 * write to registers if the device is declocked.

Fixes: c38b608504aa ("ASoC: wm8962: set CLOCKING2 as non-volatile register")
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/codecs/wm8962.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index 0a2cfff44441..08d19df8a700 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -3798,8 +3798,8 @@ static int wm8962_runtime_resume(struct device *dev)
 	/* SYSCLK defaults to on; make sure it is off so we can safely
 	 * write to registers if the device is declocked.
 	 */
-	regmap_update_bits(wm8962->regmap, WM8962_CLOCKING2,
-			   WM8962_SYSCLK_ENA, 0);
+	regmap_write_bits(wm8962->regmap, WM8962_CLOCKING2,
+			  WM8962_SYSCLK_ENA, 0);
 
 	/* Ensure we have soft control over all registers */
 	regmap_update_bits(wm8962->regmap, WM8962_CLOCKING2,
-- 
2.21.0


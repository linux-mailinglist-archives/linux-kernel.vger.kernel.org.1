Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB58D25C06C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Sep 2020 13:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728681AbgICLf3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Sep 2020 07:35:29 -0400
Received: from crapouillou.net ([89.234.176.41]:51336 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728589AbgICLaY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 07:30:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1599132376; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LJlqqFXg/MOSyVPsBSEVTxCBPa0T4MkeyfIM49qM1g0=;
        b=b+pvUnRtEmJmpiSgtZPGUBj4jbeHQi4WsVy7CavoSjIUC28Cc4MpspoqZpIKRfwIrkBLBs
        RZkLN2dTM0yjA5rbk4otHIJt/lwY0is9oymHiRp5Mtl0pDgiVY5erZzlOwmsrH4ojxsLZ8
        ct0D39tVUdLlv8sq6t7DbOx5TANfc3Q=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <Peter.Chen@nxp.com>,
        Cristian Birsan <cristian.birsan@microchip.com>,
        Felipe Balbi <balbi@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Tony Prisk <linux@prisktech.co.nz>, Bin Liu <b-liu@ti.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, openbmc@lists.ozlabs.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 05/20] usb/cdns3: core: Use pm_ptr() macro
Date:   Thu,  3 Sep 2020 13:25:39 +0200
Message-Id: <20200903112554.34263-6-paul@crapouillou.net>
In-Reply-To: <20200903112554.34263-1-paul@crapouillou.net>
References: <20200903112554.34263-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the newly introduced pm_ptr() macro, and mark the suspend/resume
functions __maybe_unused. These functions can then be moved outside the
CONFIG_PM_SUSPEND block, and the compiler can then process them and
detect build failures independently of the config. If unused, they will
simply be discarded by the compiler.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/usb/cdns3/core.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
index 5c1586ec7824..dacab9e9ef92 100644
--- a/drivers/usb/cdns3/core.c
+++ b/drivers/usb/cdns3/core.c
@@ -546,9 +546,7 @@ static int cdns3_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
-
-static int cdns3_suspend(struct device *dev)
+static int __maybe_unused cdns3_suspend(struct device *dev)
 {
 	struct cdns3 *cdns = dev_get_drvdata(dev);
 	unsigned long flags;
@@ -568,7 +566,7 @@ static int cdns3_suspend(struct device *dev)
 	return 0;
 }
 
-static int cdns3_resume(struct device *dev)
+static int __maybe_unused cdns3_resume(struct device *dev)
 {
 	struct cdns3 *cdns = dev_get_drvdata(dev);
 	unsigned long flags;
@@ -588,11 +586,8 @@ static int cdns3_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
-static const struct dev_pm_ops cdns3_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(cdns3_suspend, cdns3_resume)
-};
+static SIMPLE_DEV_PM_OPS(cdns3_pm_ops, cdns3_suspend, cdns3_resume);
 
 #ifdef CONFIG_OF
 static const struct of_device_id of_cdns3_match[] = {
@@ -608,7 +603,7 @@ static struct platform_driver cdns3_driver = {
 	.driver		= {
 		.name	= "cdns-usb3",
 		.of_match_table	= of_match_ptr(of_cdns3_match),
-		.pm	= &cdns3_pm_ops,
+		.pm	= pm_ptr(&cdns3_pm_ops),
 	},
 };
 
-- 
2.28.0


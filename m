Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9736825C09D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Sep 2020 13:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728745AbgICLvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Sep 2020 07:51:24 -0400
Received: from crapouillou.net ([89.234.176.41]:52056 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728665AbgICLhy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 07:37:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1599132413; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J6Cjz5sekpGDn1rcuBCLu89HY0vBE+cfODvggh6BD5M=;
        b=xsWwAFxugGWyD41I1noG8j49pGiP3DmP8Z0Ib/Oi1o/eDGTRpVibfAeZIg7DS9Fqfq8T1l
        TLZAlUHAAu9Mt135JM9yq5oOklHHDyG+kTom6DdpcL7oLHxESfAvghnKS/w/Y/+C6njNeI
        3eppN8IzlKc75vYDexd9MLS6vk5HxLU=
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
Subject: [PATCH 19/20] usb/gadget/udc: renesas: Use pm_ptr() macro
Date:   Thu,  3 Sep 2020 13:25:53 +0200
Message-Id: <20200903112554.34263-20-paul@crapouillou.net>
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
 drivers/usb/gadget/udc/renesas_usb3.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/gadget/udc/renesas_usb3.c b/drivers/usb/gadget/udc/renesas_usb3.c
index 0c418ce50ba0..4e8ba5914eff 100644
--- a/drivers/usb/gadget/udc/renesas_usb3.c
+++ b/drivers/usb/gadget/udc/renesas_usb3.c
@@ -2867,8 +2867,7 @@ static int renesas_usb3_probe(struct platform_device *pdev)
 	return ret;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int renesas_usb3_suspend(struct device *dev)
+static int __maybe_unused renesas_usb3_suspend(struct device *dev)
 {
 	struct renesas_usb3 *usb3 = dev_get_drvdata(dev);
 
@@ -2884,7 +2883,7 @@ static int renesas_usb3_suspend(struct device *dev)
 	return 0;
 }
 
-static int renesas_usb3_resume(struct device *dev)
+static int __maybe_unused renesas_usb3_resume(struct device *dev)
 {
 	struct renesas_usb3 *usb3 = dev_get_drvdata(dev);
 
@@ -2899,7 +2898,6 @@ static int renesas_usb3_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
 static SIMPLE_DEV_PM_OPS(renesas_usb3_pm_ops, renesas_usb3_suspend,
 			renesas_usb3_resume);
@@ -2909,7 +2907,7 @@ static struct platform_driver renesas_usb3_driver = {
 	.remove		= renesas_usb3_remove,
 	.driver		= {
 		.name =	udc_name,
-		.pm		= &renesas_usb3_pm_ops,
+		.pm		= pm_ptr(&renesas_usb3_pm_ops),
 		.of_match_table = of_match_ptr(usb3_of_match),
 	},
 };
-- 
2.28.0


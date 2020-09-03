Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BCB825C079
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Sep 2020 13:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbgICLlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Sep 2020 07:41:08 -0400
Received: from crapouillou.net ([89.234.176.41]:51632 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728565AbgICLdA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 07:33:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1599132386; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/HT6v/AkQG8sNb82MyIxu+857/MGP3ynerDd+/QF+M4=;
        b=NT6bXm22K1zaV5clRMxCKg0SUnoSS/HP14SzgmhrY2C0oCtaBdBnHyiki5RSoxo9YMg0wc
        VlGjjQNZqrqrIJsvppR7x/8r1X5Y/XgECewG8x/W00M9fiWcXDUwxobiKfMfJ366wNUM4I
        PtqmGeqLYhAmU8Cr/zkWSrTKKfrsUI4=
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
Subject: [PATCH 09/20] usb/musb: am35x: Use pm_ptr() macro
Date:   Thu,  3 Sep 2020 13:25:43 +0200
Message-Id: <20200903112554.34263-10-paul@crapouillou.net>
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
 drivers/usb/musb/am35x.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/musb/am35x.c b/drivers/usb/musb/am35x.c
index 660641ab1545..6162111f4cae 100644
--- a/drivers/usb/musb/am35x.c
+++ b/drivers/usb/musb/am35x.c
@@ -547,8 +547,7 @@ static int am35x_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int am35x_suspend(struct device *dev)
+static int __maybe_unused am35x_suspend(struct device *dev)
 {
 	struct am35x_glue	*glue = dev_get_drvdata(dev);
 	struct musb_hdrc_platform_data *plat = dev_get_platdata(dev);
@@ -564,7 +563,7 @@ static int am35x_suspend(struct device *dev)
 	return 0;
 }
 
-static int am35x_resume(struct device *dev)
+static int __maybe_unused am35x_resume(struct device *dev)
 {
 	struct am35x_glue	*glue = dev_get_drvdata(dev);
 	struct musb_hdrc_platform_data *plat = dev_get_platdata(dev);
@@ -589,7 +588,6 @@ static int am35x_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
 static SIMPLE_DEV_PM_OPS(am35x_pm_ops, am35x_suspend, am35x_resume);
 
@@ -598,7 +596,7 @@ static struct platform_driver am35x_driver = {
 	.remove		= am35x_remove,
 	.driver		= {
 		.name	= "musb-am35x",
-		.pm	= &am35x_pm_ops,
+		.pm	= pm_ptr(&am35x_pm_ops),
 	},
 };
 
-- 
2.28.0


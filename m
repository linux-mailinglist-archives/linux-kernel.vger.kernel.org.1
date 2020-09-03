Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F69125C4BE
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Sep 2020 17:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728696AbgICPQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Sep 2020 11:16:40 -0400
Received: from crapouillou.net ([89.234.176.41]:51966 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728697AbgICLfu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 07:35:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1599132408; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zOk90+M51eZ5tI9ivTHZKHwy00IhaQlS+1+ArcDDDCo=;
        b=Vx2UPtjtliAswHBk8SZCaP2DvtJN/jS6azp/jPeSUY3YkmCg1BzYIeaJpaw714tuYK6Qx+
        0klYFlkQoHxQb+65paN2wu1ttyLFHuygxhLsf0p7lfhCwwhL2+WeAod4Kqkx5M4WFpPvhz
        M5pLVSy7NtvEdOvBNIZc0rt4QQ/FUAI=
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
Subject: [PATCH 17/20] usb/gadget/udc: mv-u3d: Use pm_ptr() macro
Date:   Thu,  3 Sep 2020 13:25:51 +0200
Message-Id: <20200903112554.34263-18-paul@crapouillou.net>
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
 drivers/usb/gadget/udc/mv_u3d_core.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/gadget/udc/mv_u3d_core.c b/drivers/usb/gadget/udc/mv_u3d_core.c
index 5486f5a70868..a7e3736fd0c1 100644
--- a/drivers/usb/gadget/udc/mv_u3d_core.c
+++ b/drivers/usb/gadget/udc/mv_u3d_core.c
@@ -1988,8 +1988,7 @@ static int mv_u3d_probe(struct platform_device *dev)
 	return retval;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int mv_u3d_suspend(struct device *dev)
+static int __maybe_unused mv_u3d_suspend(struct device *dev)
 {
 	struct mv_u3d *u3d = dev_get_drvdata(dev);
 
@@ -2012,7 +2011,7 @@ static int mv_u3d_suspend(struct device *dev)
 	return 0;
 }
 
-static int mv_u3d_resume(struct device *dev)
+static int __maybe_unused mv_u3d_resume(struct device *dev)
 {
 	struct mv_u3d *u3d = dev_get_drvdata(dev);
 	int retval;
@@ -2031,7 +2030,6 @@ static int mv_u3d_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
 static SIMPLE_DEV_PM_OPS(mv_u3d_pm_ops, mv_u3d_suspend, mv_u3d_resume);
 
@@ -2051,7 +2049,7 @@ static struct platform_driver mv_u3d_driver = {
 	.shutdown	= mv_u3d_shutdown,
 	.driver		= {
 		.name	= "mv-u3d",
-		.pm	= &mv_u3d_pm_ops,
+		.pm	= pm_ptr(&mv_u3d_pm_ops),
 	},
 };
 
-- 
2.28.0


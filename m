Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7BD1A6662
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Apr 2020 14:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729514AbgDMMde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Apr 2020 08:33:34 -0400
Received: from inva020.nxp.com ([92.121.34.13]:45686 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728392AbgDMMdd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 08:33:33 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id C61851A16F6;
        Mon, 13 Apr 2020 14:33:31 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 528DB1A0020;
        Mon, 13 Apr 2020 14:33:28 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id C7814402B4;
        Mon, 13 Apr 2020 20:33:23 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     jassisinghbrar@gmail.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH] mailbox: imx: Support runtime PM
Date:   Mon, 13 Apr 2020 20:25:30 +0800
Message-Id: <1586780730-6117-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some power hungry sub-systems like VPU has its own MUs which also
use mailbox driver, current mailbox driver uses platform driver
model and MU's power will be ON after driver probed and left ON
there, it may cause the whole sub-system can NOT enter lower power
mode, take VPU driver for example, it has runtime PM support, but
due to its MU always ON, the VPU sub-system will be always ON and
consume many power during kernel idle.

To save power in kernel idle, mailbox driver needs to support
runtime PM in order to power off MU when it is unused. However,
the runtime suspend/resume can ONLY be implemented in mailbox's
.shutdown/.startup callback, so its consumer needs to call
mbox_request_channel()/mbox_free_channel() in consumer driver's
runtime PM callback, then the MU's power will be ON/OFF along with
consumer's runtime PM status.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/mailbox/imx-mailbox.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
index 7906624..97bf0ac 100644
--- a/drivers/mailbox/imx-mailbox.c
+++ b/drivers/mailbox/imx-mailbox.c
@@ -12,6 +12,7 @@
 #include <linux/mailbox_controller.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/slab.h>
 
 #define IMX_MU_xSR_GIPn(x)	BIT(28 + (3 - (x)))
@@ -287,6 +288,7 @@ static int imx_mu_startup(struct mbox_chan *chan)
 	struct imx_mu_con_priv *cp = chan->con_priv;
 	int ret;
 
+	pm_runtime_get_sync(priv->dev);
 	if (cp->type == IMX_MU_TYPE_TXDB) {
 		/* Tx doorbell don't have ACK support */
 		tasklet_init(&cp->txdb_tasklet, imx_mu_txdb_tasklet,
@@ -323,6 +325,7 @@ static void imx_mu_shutdown(struct mbox_chan *chan)
 
 	if (cp->type == IMX_MU_TYPE_TXDB) {
 		tasklet_kill(&cp->txdb_tasklet);
+		pm_runtime_put_sync(priv->dev);
 		return;
 	}
 
@@ -341,6 +344,7 @@ static void imx_mu_shutdown(struct mbox_chan *chan)
 	}
 
 	free_irq(priv->irq, chan);
+	pm_runtime_put_sync(priv->dev);
 }
 
 static const struct mbox_chan_ops imx_mu_ops = {
@@ -508,7 +512,27 @@ static int imx_mu_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, priv);
 
-	return devm_mbox_controller_register(dev, &priv->mbox);
+	ret = devm_mbox_controller_register(dev, &priv->mbox);
+	if (ret)
+		return ret;
+
+	pm_runtime_enable(dev);
+
+	ret = pm_runtime_get_sync(dev);
+	if (ret < 0) {
+		pm_runtime_put_noidle(dev);
+		goto disable_runtime_pm;
+	}
+
+	ret = pm_runtime_put_sync(dev);
+	if (ret < 0)
+		goto disable_runtime_pm;
+
+	return 0;
+
+disable_runtime_pm:
+	pm_runtime_disable(dev);
+	return ret;
 }
 
 static int imx_mu_remove(struct platform_device *pdev)
@@ -516,6 +540,7 @@ static int imx_mu_remove(struct platform_device *pdev)
 	struct imx_mu_priv *priv = platform_get_drvdata(pdev);
 
 	clk_disable_unprepare(priv->clk);
+	pm_runtime_disable(priv->dev);
 
 	return 0;
 }
-- 
2.7.4


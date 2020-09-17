Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 421E026D5CF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 10:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726450AbgIQIJw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 04:09:52 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:41600 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726355AbgIQIIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 04:08:52 -0400
X-Greylist: delayed 1212 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 04:08:51 EDT
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08H7mRGD124425;
        Thu, 17 Sep 2020 02:48:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600328907;
        bh=B649ih1ZgoNc/QhvwLRUtA7XYmEjlZKwZVP3xeo7/Cg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=WfO9b84aTVKL/yYtG5aJYtxInPc4+tsq2YeSIYOBSWgEAmkb9/L/H2IsLcTjMsQen
         pWg5kzC7G2dVOTI0ZzNTb8AnkGdyVflrLm3rhxs0dAjv2zKpCPsbn4/gcS70Zv11Wi
         GYh1EJrdSxdtAwBlC3YG6CBOrad8lqrxydaxkbYM=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08H7mR7R085472
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 17 Sep 2020 02:48:27 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 17
 Sep 2020 02:48:27 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 17 Sep 2020 02:48:26 -0500
Received: from ula0132425.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08H7mEdv100359;
        Thu, 17 Sep 2020 02:48:24 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>
CC:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/4] mtd: hyperbus: hbmc-am654: Add DMA support for reads
Date:   Thu, 17 Sep 2020 13:17:49 +0530
Message-ID: <20200917074749.8957-5-vigneshr@ti.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200917074749.8957-1-vigneshr@ti.com>
References: <20200917074749.8957-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AM654 HyperBus controller provides MMIO interface to read data from
flash. So add DMA memcpy support for reading data over MMIO interface.
This provides 5x improvement in throughput and reduces CPU usage as
well.

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 drivers/mtd/hyperbus/hbmc-am654.c | 130 +++++++++++++++++++++++++++++-
 1 file changed, 129 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/hyperbus/hbmc-am654.c b/drivers/mtd/hyperbus/hbmc-am654.c
index b6a2400fcaa9..b6ab55560089 100644
--- a/drivers/mtd/hyperbus/hbmc-am654.c
+++ b/drivers/mtd/hyperbus/hbmc-am654.c
@@ -3,6 +3,10 @@
 // Copyright (C) 2019 Texas Instruments Incorporated - https://www.ti.com/
 // Author: Vignesh Raghavendra <vigneshr@ti.com>
 
+#include <linux/completion.h>
+#include <linux/dma-direction.h>
+#include <linux/dma-mapping.h>
+#include <linux/dmaengine.h>
 #include <linux/err.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -13,10 +17,18 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
+#include <linux/sched/task_stack.h>
 #include <linux/types.h>
 
 #define AM654_HBMC_CALIB_COUNT 25
 
+struct am654_hbmc_device_priv {
+	struct completion rx_dma_complete;
+	phys_addr_t device_base;
+	struct hyperbus_ctlr *ctlr;
+	struct dma_chan *rx_chan;
+};
+
 struct am654_hbmc_priv {
 	struct hyperbus_ctlr ctlr;
 	struct hyperbus_device hbdev;
@@ -51,13 +63,107 @@ static int am654_hbmc_calibrate(struct hyperbus_device *hbdev)
 	return ret;
 }
 
+static void am654_hbmc_dma_callback(void *param)
+{
+	struct am654_hbmc_device_priv *priv = param;
+
+	complete(&priv->rx_dma_complete);
+}
+
+static int am654_hbmc_dma_read(struct am654_hbmc_device_priv *priv, void *to,
+			       unsigned long from, ssize_t len)
+
+{
+	enum dma_ctrl_flags flags = DMA_CTRL_ACK | DMA_PREP_INTERRUPT;
+	struct dma_chan *rx_chan = priv->rx_chan;
+	struct dma_async_tx_descriptor *tx;
+	dma_addr_t dma_dst, dma_src;
+	dma_cookie_t cookie;
+	int ret;
+
+	if (!priv->rx_chan || !virt_addr_valid(to) || object_is_on_stack(to))
+		return -EINVAL;
+
+	dma_dst = dma_map_single(rx_chan->device->dev, to, len, DMA_FROM_DEVICE);
+	if (dma_mapping_error(rx_chan->device->dev, dma_dst)) {
+		dev_dbg(priv->ctlr->dev, "DMA mapping failed\n");
+		return -EIO;
+	}
+
+	dma_src = priv->device_base + from;
+	tx = dmaengine_prep_dma_memcpy(rx_chan, dma_dst, dma_src, len, flags);
+	if (!tx) {
+		dev_err(priv->ctlr->dev, "device_prep_dma_memcpy error\n");
+		ret = -EIO;
+		goto unmap_dma;
+	}
+
+	reinit_completion(&priv->rx_dma_complete);
+	tx->callback = am654_hbmc_dma_callback;
+	tx->callback_param = priv;
+	cookie = tx->tx_submit(tx);
+
+	ret = dma_submit_error(cookie);
+	if (ret) {
+		dev_err(priv->ctlr->dev, "dma_submit_error %d\n", cookie);
+		ret = -EIO;
+		goto unmap_dma;
+	}
+
+	dma_async_issue_pending(rx_chan);
+	ret = wait_for_completion_timeout(&priv->rx_dma_complete,
+					  msecs_to_jiffies(len + 1000));
+	if (ret <= 0) {
+		dmaengine_terminate_sync(rx_chan);
+		dev_err(priv->ctlr->dev, "DMA wait_for_completion_timeout\n");
+		ret = -ETIMEDOUT;
+		goto unmap_dma;
+	}
+	ret = 0;
+
+unmap_dma:
+	dma_unmap_single(rx_chan->device->dev, dma_dst, len, DMA_FROM_DEVICE);
+	return ret;
+}
+
+static void am654_hbmc_read(struct hyperbus_device *hbdev, void *to,
+			    unsigned long from, ssize_t len)
+{
+	struct am654_hbmc_device_priv *priv = hbdev->priv;
+
+	if (len < SZ_1K || am654_hbmc_dma_read(priv, to, from, len))
+		memcpy_fromio(to, hbdev->map.virt + from, len);
+}
+
 static const struct hyperbus_ops am654_hbmc_ops = {
 	.calibrate = am654_hbmc_calibrate,
+	.copy_from = am654_hbmc_read,
 };
 
+static int am654_hbmc_request_mmap_dma(struct am654_hbmc_device_priv *priv)
+{
+	struct dma_chan *rx_chan;
+	dma_cap_mask_t mask;
+
+	dma_cap_zero(mask);
+	dma_cap_set(DMA_MEMCPY, mask);
+
+	rx_chan = dma_request_chan_by_mask(&mask);
+	if (IS_ERR(rx_chan)) {
+		if (PTR_ERR(rx_chan) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+		return 0;
+	}
+	priv->rx_chan = rx_chan;
+	init_completion(&priv->rx_dma_complete);
+
+	return 0;
+}
+
 static int am654_hbmc_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
+	struct am654_hbmc_device_priv *dev_priv;
 	struct device *dev = &pdev->dev;
 	struct am654_hbmc_priv *priv;
 	struct resource res;
@@ -96,13 +202,31 @@ static int am654_hbmc_probe(struct platform_device *pdev)
 	priv->ctlr.dev = dev;
 	priv->ctlr.ops = &am654_hbmc_ops;
 	priv->hbdev.ctlr = &priv->ctlr;
+
+	dev_priv = devm_kzalloc(dev, sizeof(*dev_priv), GFP_KERNEL);
+	if (!dev_priv) {
+		ret = -ENOMEM;
+		goto disable_mux;
+	}
+
+	priv->hbdev.priv = dev_priv;
+	dev_priv->device_base = res.start;
+	dev_priv->ctlr = &priv->ctlr;
+
+	ret = am654_hbmc_request_mmap_dma(dev_priv);
+	if (ret == -EPROBE_DEFER)
+		goto disable_mux;
+
 	ret = hyperbus_register_device(&priv->hbdev);
 	if (ret) {
 		dev_err(dev, "failed to register controller\n");
-		goto disable_mux;
+		goto release_dma;
 	}
 
 	return 0;
+release_dma:
+	if (dev_priv->rx_chan)
+		dma_release_channel(dev_priv->rx_chan);
 disable_mux:
 	if (priv->mux_ctrl)
 		mux_control_deselect(priv->mux_ctrl);
@@ -112,12 +236,16 @@ static int am654_hbmc_probe(struct platform_device *pdev)
 static int am654_hbmc_remove(struct platform_device *pdev)
 {
 	struct am654_hbmc_priv *priv = platform_get_drvdata(pdev);
+	struct am654_hbmc_device_priv *dev_priv = priv->hbdev.priv;
 	int ret;
 
 	ret = hyperbus_unregister_device(&priv->hbdev);
 	if (priv->mux_ctrl)
 		mux_control_deselect(priv->mux_ctrl);
 
+	if (dev_priv->rx_chan)
+		dma_release_channel(dev_priv->rx_chan);
+
 	return ret;
 }
 
-- 
2.28.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6B12CA00E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 11:41:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390968AbgLAKiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 05:38:52 -0500
Received: from comms.puri.sm ([159.203.221.185]:54806 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725918AbgLAKiv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 05:38:51 -0500
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id DE821E0141;
        Tue,  1 Dec 2020 02:38:10 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 1Eg-ax_6CXk5; Tue,  1 Dec 2020 02:38:09 -0800 (PST)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     marex@denx.de, stefan@agner.ch, airlied@linux.ie, daniel@ffwll.ch,
        shawnguo@kernel.org
Cc:     kernel@pengutronix.de, linux-imx@nxp.com,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH] drm: mxsfb: Add interconnect path request
Date:   Tue,  1 Dec 2020 11:37:57 +0100
Message-Id: <20201201103757.32165-1-martin.kepplinger@puri.sm>
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add interconnect support to mxsfb so that it is able to request enough
bandwidth to DDR for display output to work.

Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
---
 drivers/gpu/drm/mxsfb/mxsfb_drv.c | 33 +++++++++++++++++++++++++++++++
 drivers/gpu/drm/mxsfb/mxsfb_drv.h |  2 ++
 drivers/gpu/drm/mxsfb/mxsfb_kms.c | 13 ++++++++++++
 3 files changed, 48 insertions(+)

diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.c b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
index 6faf17b6408d..b05e8e5f1e38 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_drv.c
+++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
@@ -15,6 +15,7 @@
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/interconnect.h>
 
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_bridge.h>
@@ -311,6 +312,34 @@ static const struct of_device_id mxsfb_dt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, mxsfb_dt_ids);
 
+
+static int mxsfb_init_icc(struct platform_device *pdev)
+{
+	struct drm_device *drm = platform_get_drvdata(pdev);
+	struct mxsfb_drm_private *mxsfb = drm->dev_private;
+	int ret;
+
+	/* Optional interconnect request */
+	mxsfb->icc_path = devm_of_icc_get(&pdev->dev, "lcdif-dram");
+	if (IS_ERR(mxsfb->icc_path)) {
+		ret = PTR_ERR(mxsfb->icc_path);
+		if (ret == -EPROBE_DEFER)
+			return ret;
+
+		mxsfb->icc_path = NULL;
+		dev_dbg(drm->dev,
+			"No interconnect may cause display underflows!\n");
+	}
+
+	ret = icc_set_bw(mxsfb->icc_path, 0, MBps_to_icc(700));
+	if (ret) {
+		dev_err(drm->dev, "%s: icc_set_bw failed: %d\n", __func__, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
 static int mxsfb_probe(struct platform_device *pdev)
 {
 	struct drm_device *drm;
@@ -329,6 +358,10 @@ static int mxsfb_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_free;
 
+	ret = mxsfb_init_icc(pdev);
+	if (ret)
+		goto err_free;
+
 	ret = drm_dev_register(drm, 0);
 	if (ret)
 		goto err_unload;
diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.h b/drivers/gpu/drm/mxsfb/mxsfb_drv.h
index 399d23e91ed1..d74ff4818e62 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_drv.h
+++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.h
@@ -41,6 +41,8 @@ struct mxsfb_drm_private {
 	struct drm_encoder		encoder;
 	struct drm_connector		*connector;
 	struct drm_bridge		*bridge;
+
+	struct icc_path			*icc_path;
 };
 
 static inline struct mxsfb_drm_private *
diff --git a/drivers/gpu/drm/mxsfb/mxsfb_kms.c b/drivers/gpu/drm/mxsfb/mxsfb_kms.c
index 3e1bb0aefb87..8925ee7deeaa 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_kms.c
+++ b/drivers/gpu/drm/mxsfb/mxsfb_kms.c
@@ -13,6 +13,7 @@
 #include <linux/iopoll.h>
 #include <linux/pm_runtime.h>
 #include <linux/spinlock.h>
+#include <linux/interconnect.h>
 
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
@@ -310,6 +311,12 @@ static void mxsfb_crtc_atomic_enable(struct drm_crtc *crtc,
 	struct mxsfb_drm_private *mxsfb = to_mxsfb_drm_private(crtc->dev);
 	struct drm_device *drm = mxsfb->drm;
 	dma_addr_t paddr;
+	int ret;
+
+	ret = icc_enable(mxsfb->icc_path);
+	if (ret)
+		dev_err_ratelimited(drm->dev, "%s: icc_enable failed: %d\n",
+				    __func__, ret);
 
 	pm_runtime_get_sync(drm->dev);
 	mxsfb_enable_axi_clk(mxsfb);
@@ -334,6 +341,7 @@ static void mxsfb_crtc_atomic_disable(struct drm_crtc *crtc,
 	struct mxsfb_drm_private *mxsfb = to_mxsfb_drm_private(crtc->dev);
 	struct drm_device *drm = mxsfb->drm;
 	struct drm_pending_vblank_event *event;
+	int ret;
 
 	mxsfb_disable_controller(mxsfb);
 
@@ -349,6 +357,11 @@ static void mxsfb_crtc_atomic_disable(struct drm_crtc *crtc,
 
 	mxsfb_disable_axi_clk(mxsfb);
 	pm_runtime_put_sync(drm->dev);
+
+	ret = icc_disable(mxsfb->icc_path);
+	if (ret)
+		dev_err_ratelimited(drm->dev, "%s: icc_disable failed: %d\n",
+				    __func__, ret);
 }
 
 static int mxsfb_crtc_enable_vblank(struct drm_crtc *crtc)
-- 
2.20.1


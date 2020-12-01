Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7E552CA1F5
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 13:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730660AbgLAL40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 06:56:26 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:8172 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728258AbgLAL40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 06:56:26 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4ClgX43lcNz15VbT;
        Tue,  1 Dec 2020 19:55:16 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Tue, 1 Dec 2020 19:55:37 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <airlied@linux.ie>, <daniel@ffwll.ch>, <tzimmermann@suse.de>,
        <kraxel@redhat.com>, <alexander.deucher@amd.com>,
        <tglx@linutronix.de>, <dri-devel@lists.freedesktop.org>,
        <xinliang.liu@linaro.org>, <maarten.lankhorst@linux.intel.com>,
        <mripard@kernel.org>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH drm/hisilicon v2 2/4] drm/hisilicon: Code refactoring for hibmc_drm_drv
Date:   Tue, 1 Dec 2020 19:55:52 +0800
Message-ID: <1606823754-52451-3-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1606823754-52451-1-git-send-email-tiantao6@hisilicon.com>
References: <1606823754-52451-1-git-send-email-tiantao6@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the devm_drm_dev_alloc provided by the drm framework to alloc
a struct hibmc_drm_private.

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c | 16 ++++++----------
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h |  2 +-
 2 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
index dd9fadc..c5b0b57 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
@@ -262,13 +262,6 @@ static int hibmc_load(struct drm_device *dev)
 	struct hibmc_drm_private *priv = to_hibmc_drm_private(dev);
 	int ret;
 
-	priv = drmm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv) {
-		drm_err(dev, "no memory to allocate for hibmc_drm_private\n");
-		return -ENOMEM;
-	}
-	dev->dev_private = priv;
-
 	ret = hibmc_hw_init(priv);
 	if (ret)
 		goto err;
@@ -311,6 +304,7 @@ static int hibmc_pci_probe(struct pci_dev *pdev,
 			   const struct pci_device_id *ent)
 {
 	struct drm_device *dev;
+	struct hibmc_drm_private *priv;
 	int ret;
 
 	ret = drm_fb_helper_remove_conflicting_pci_framebuffers(pdev,
@@ -318,12 +312,14 @@ static int hibmc_pci_probe(struct pci_dev *pdev,
 	if (ret)
 		return ret;
 
-	dev = drm_dev_alloc(&hibmc_driver, &pdev->dev);
-	if (IS_ERR(dev)) {
+	priv = devm_drm_dev_alloc(&pdev->dev, &hibmc_driver,
+				  struct hibmc_drm_private, dev);
+	if (IS_ERR(priv)) {
 		DRM_ERROR("failed to allocate drm_device\n");
-		return PTR_ERR(dev);
+		return PTR_ERR(priv);
 	}
 
+	dev = &priv->dev;
 	dev->pdev = pdev;
 	pci_set_drvdata(pdev, dev);
 
diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
index e35353a..7e0c756 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
@@ -52,7 +52,7 @@ static inline struct hibmc_connector *to_hibmc_connector(struct drm_connector *c
 
 static inline struct hibmc_drm_private *to_hibmc_drm_private(struct drm_device *dev)
 {
-	return dev->dev_private;
+	return container_of(dev, struct hibmc_drm_private, dev);
 }
 
 void hibmc_set_power_mode(struct hibmc_drm_private *priv,
-- 
2.7.4


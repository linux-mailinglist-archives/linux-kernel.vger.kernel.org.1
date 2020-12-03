Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B70722CCD08
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 04:11:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729567AbgLCDJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 22:09:44 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:8931 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726629AbgLCDJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 22:09:44 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4CmglY37FJzhm0B;
        Thu,  3 Dec 2020 11:08:41 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Thu, 3 Dec 2020 11:08:56 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <airlied@linux.ie>, <daniel@ffwll.ch>, <tzimmermann@suse.de>,
        <kraxel@redhat.com>, <alexander.deucher@amd.com>,
        <tglx@linutronix.de>, <dri-devel@lists.freedesktop.org>,
        <xinliang.liu@linaro.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] drm/hisilicon: Use managed VRAM-helper initialization
Date:   Thu, 3 Dec 2020 11:09:13 +0800
Message-ID: <1606964953-24309-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

updated to use drmm_vram_helper_init()

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c |  1 -
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h |  1 -
 drivers/gpu/drm/hisilicon/hibmc/hibmc_ttm.c     | 19 +++----------------
 3 files changed, 3 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
index 8020604..5aea2e9 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
@@ -249,7 +249,6 @@ static int hibmc_unload(struct drm_device *dev)
 
 	pci_disable_msi(dev->pdev);
 	hibmc_kms_fini(priv);
-	hibmc_mm_fini(priv);
 	dev->dev_private = NULL;
 	return 0;
 }
diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
index 7e0c756..2786de5 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
@@ -64,7 +64,6 @@ int hibmc_de_init(struct hibmc_drm_private *priv);
 int hibmc_vdac_init(struct hibmc_drm_private *priv);
 
 int hibmc_mm_init(struct hibmc_drm_private *hibmc);
-void hibmc_mm_fini(struct hibmc_drm_private *hibmc);
 int hibmc_dumb_create(struct drm_file *file, struct drm_device *dev,
 		      struct drm_mode_create_dumb *args);
 int hibmc_ddc_create(struct drm_device *drm_dev, struct hibmc_connector *connector);
diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_ttm.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_ttm.c
index e84fb81..892d566 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_ttm.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_ttm.c
@@ -23,15 +23,12 @@
 
 int hibmc_mm_init(struct hibmc_drm_private *hibmc)
 {
-	struct drm_vram_mm *vmm;
 	int ret;
 	struct drm_device *dev = &hibmc->dev;
 
-	vmm = drm_vram_helper_alloc_mm(dev,
-				       pci_resource_start(dev->pdev, 0),
-				       hibmc->fb_size);
-	if (IS_ERR(vmm)) {
-		ret = PTR_ERR(vmm);
+	ret = drmm_vram_helper_init(dev, pci_resource_start(dev->pdev, 0),
+				    hibmc->fb_size);
+	if (ret) {
 		drm_err(dev, "Error initializing VRAM MM; %d\n", ret);
 		return ret;
 	}
@@ -39,16 +36,6 @@ int hibmc_mm_init(struct hibmc_drm_private *hibmc)
 	return 0;
 }
 
-void hibmc_mm_fini(struct hibmc_drm_private *hibmc)
-{
-	struct drm_device *dev = &hibmc->dev;
-
-	if (!dev->vram_mm)
-		return;
-
-	drm_vram_helper_release_mm(dev);
-}
-
 int hibmc_dumb_create(struct drm_file *file, struct drm_device *dev,
 		      struct drm_mode_create_dumb *args)
 {
-- 
2.7.4


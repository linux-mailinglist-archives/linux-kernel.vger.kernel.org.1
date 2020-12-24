Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6C62E2585
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Dec 2020 09:47:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbgLXIqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Dec 2020 03:46:39 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9987 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbgLXIqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Dec 2020 03:46:39 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4D1kD865WDzhxCC;
        Thu, 24 Dec 2020 16:45:12 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Thu, 24 Dec 2020 16:45:53 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <airlied@linux.ie>, <daniel@ffwll.ch>, <tzimmermann@suse.de>,
        <kraxel@redhat.com>, <alexander.deucher@amd.com>,
        <tglx@linutronix.de>, <dri-devel@lists.freedesktop.org>,
        <xinliang.liu@linaro.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] drm/hisilicon: Add load and unload callback functions
Date:   Thu, 24 Dec 2020 16:45:58 +0800
Message-ID: <1608799558-29564-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the callback functions of drm_driver structure member functions
load and unload, no need to call load in the hibmc_pci_probe function
and unload in the hibmc_pci_remove function.

v2:
remove the hibmc_unload called from hibmc_pic_remove.

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
index 0d4e902..10042cf 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
@@ -27,6 +27,9 @@
 
 DEFINE_DRM_GEM_FOPS(hibmc_fops);
 
+static int hibmc_load(struct drm_device *dev, unsigned long flags);
+static void hibmc_unload(struct drm_device *dev);
+
 static irqreturn_t hibmc_drm_interrupt(int irq, void *arg)
 {
 	struct drm_device *dev = (struct drm_device *)arg;
@@ -63,6 +66,8 @@ static const struct drm_driver hibmc_driver = {
 	.dumb_map_offset        = drm_gem_vram_driver_dumb_mmap_offset,
 	.gem_prime_mmap		= drm_gem_prime_mmap,
 	.irq_handler		= hibmc_drm_interrupt,
+	.load			= hibmc_load,
+	.unload			= hibmc_unload,
 };
 
 static int __maybe_unused hibmc_pm_suspend(struct device *dev)
@@ -248,7 +253,7 @@ static int hibmc_hw_init(struct hibmc_drm_private *priv)
 	return 0;
 }
 
-static int hibmc_unload(struct drm_device *dev)
+static void hibmc_unload(struct drm_device *dev)
 {
 	drm_atomic_helper_shutdown(dev);
 
@@ -256,11 +261,9 @@ static int hibmc_unload(struct drm_device *dev)
 		drm_irq_uninstall(dev);
 
 	pci_disable_msi(dev->pdev);
-
-	return 0;
 }
 
-static int hibmc_load(struct drm_device *dev)
+static int hibmc_load(struct drm_device *dev, unsigned long flags)
 {
 	struct hibmc_drm_private *priv = to_hibmc_drm_private(dev);
 	int ret;
@@ -335,12 +338,6 @@ static int hibmc_pci_probe(struct pci_dev *pdev,
 		goto err_return;
 	}
 
-	ret = hibmc_load(dev);
-	if (ret) {
-		drm_err(dev, "failed to load hibmc: %d\n", ret);
-		goto err_return;
-	}
-
 	ret = drm_dev_register(dev, 0);
 	if (ret) {
 		drm_err(dev, "failed to register drv for userspace access: %d\n",
@@ -363,7 +360,6 @@ static void hibmc_pci_remove(struct pci_dev *pdev)
 	struct drm_device *dev = pci_get_drvdata(pdev);
 
 	drm_dev_unregister(dev);
-	hibmc_unload(dev);
 }
 
 static const struct pci_device_id hibmc_pci_table[] = {
-- 
2.7.4


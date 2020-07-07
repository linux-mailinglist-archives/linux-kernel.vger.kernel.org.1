Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5A5216444
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jul 2020 05:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbgGGDAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jul 2020 23:00:13 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7379 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727094AbgGGDAN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 23:00:13 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 93175E51EB2E6213805D;
        Tue,  7 Jul 2020 11:00:08 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Tue, 7 Jul 2020 10:59:59 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <puck.chen@hisilicon.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <tzimmermann@suse.de>, <kraxel@redhat.com>,
        <alexander.deucher@amd.com>, <tglx@linutronix.de>,
        <dri-devel@lists.freedesktop.org>, <xinliang.liu@linaro.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linuxarm@huawei.com>
Subject: [PATCH v2] drm/hisilicon: Fixed the warning: Assignment of 0/1 to bool variable
Date:   Tue, 7 Jul 2020 10:58:21 +0800
Message-ID: <1594090701-45741-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fixed the following warning:
hibmc_drm_drv.c:296:1-18:WARNING: Assignment of 0/1 to bool variable.
hibmc_drm_drv.c:301:2-19: WARNING: Assignment of 0/1 to bool variable.

v2:
using the pci_dev.msi_enabled instead of priv->msi_enabled.

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c | 6 +++---
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h | 1 -
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
index 249c298..83c7bb5 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
@@ -254,7 +254,7 @@ static int hibmc_unload(struct drm_device *dev)
 
 	if (dev->irq_enabled)
 		drm_irq_uninstall(dev);
-	if (priv->msi_enabled)
+	if (dev->pdev->msi_enabled)
 		pci_disable_msi(dev->pdev);
 
 	hibmc_kms_fini(priv);
@@ -294,12 +294,12 @@ static int hibmc_load(struct drm_device *dev)
 		goto err;
 	}
 
-	priv->msi_enabled = 0;
+	dev->pdev->msi_enabled = 0;
 	ret = pci_enable_msi(dev->pdev);
 	if (ret) {
 		DRM_WARN("enabling MSI failed: %d\n", ret);
 	} else {
-		priv->msi_enabled = 1;
+		dev->pdev->msi_enabled = 1;
 		ret = drm_irq_install(dev, dev->pdev->irq);
 		if (ret)
 			DRM_WARN("install irq failed: %d\n", ret);
diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
index 6097687..a683763 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
@@ -25,7 +25,6 @@ struct hibmc_drm_private {
 	void __iomem   *fb_map;
 	unsigned long  fb_base;
 	unsigned long  fb_size;
-	bool msi_enabled;
 
 	/* drm */
 	struct drm_device  *dev;
-- 
2.7.4


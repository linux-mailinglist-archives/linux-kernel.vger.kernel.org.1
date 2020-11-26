Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C08A2C5383
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 13:04:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388340AbgKZMCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 07:02:12 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:8412 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388162AbgKZMCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 07:02:12 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Chbvr274wz74Dg;
        Thu, 26 Nov 2020 20:01:44 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Thu, 26 Nov 2020 20:02:00 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <airlied@linux.ie>, <daniel@ffwll.ch>, <tzimmermann@suse.de>,
        <kraxel@redhat.com>, <alexander.deucher@amd.com>,
        <tglx@linutronix.de>, <dri-devel@lists.freedesktop.org>,
        <xinliang.liu@linaro.org>, <maarten.lankhorst@linux.intel.com>,
        <mripard@kernel.org>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH drm/hisilicon 3/3] drm/hisilicon: Use the new api devm_drm_irq_install
Date:   Thu, 26 Nov 2020 20:02:20 +0800
Message-ID: <1606392140-57954-4-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1606392140-57954-1-git-send-email-tiantao6@hisilicon.com>
References: <1606392140-57954-1-git-send-email-tiantao6@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_drm_irq_install to register interrupts so that
drm_irq_uninstall is not called when hibmc is removed.

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
index ea3d81b..77792e3 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
@@ -247,9 +247,6 @@ static int hibmc_unload(struct drm_device *dev)
 
 	drm_atomic_helper_shutdown(dev);
 
-	if (dev->irq_enabled)
-		drm_irq_uninstall(dev);
-
 	pci_disable_msi(dev->pdev);
 	hibmc_kms_fini(priv);
 	hibmc_mm_fini(priv);
@@ -284,7 +281,7 @@ static int hibmc_load(struct drm_device *dev)
 	if (ret) {
 		drm_warn(dev, "enabling MSI failed: %d\n", ret);
 	} else {
-		ret = drm_irq_install(dev, dev->pdev->irq);
+		ret = devm_drm_irq_install(dev, dev->pdev->irq);
 		if (ret)
 			drm_warn(dev, "install irq failed: %d\n", ret);
 	}
-- 
2.7.4


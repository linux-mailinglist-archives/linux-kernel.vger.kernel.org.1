Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6105D2CE4FB
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 02:25:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388678AbgLDBXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 20:23:49 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9001 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728484AbgLDBXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 20:23:48 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CnFLk4swBzhmDW;
        Fri,  4 Dec 2020 09:22:38 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Fri, 4 Dec 2020 09:23:03 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <airlied@linux.ie>, <daniel@ffwll.ch>, <tzimmermann@suse.de>,
        <kraxel@redhat.com>, <alexander.deucher@amd.com>,
        <tglx@linutronix.de>, <dri-devel@lists.freedesktop.org>,
        <xinliang.liu@linaro.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] drm/hisilicon: Use managed mode-config init
Date:   Fri, 4 Dec 2020 09:23:08 +0800
Message-ID: <1607044999-47666-3-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1607044999-47666-1-git-send-email-tiantao6@hisilicon.com>
References: <1607044999-47666-1-git-send-email-tiantao6@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using drmm_mode_config_init() sets up managed release of modesetting
resources.
Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
index 5aea2e9..04fee18 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
@@ -82,7 +82,9 @@ static int hibmc_kms_init(struct hibmc_drm_private *priv)
 	struct drm_device *dev = &priv->dev;
 	int ret;
 
-	drm_mode_config_init(dev);
+	ret = drmm_mode_config_init(dev);
+	if (ret)
+		return ret;
 	priv->mode_config_initialized = true;
 
 	dev->mode_config.min_width = 0;
@@ -111,14 +113,6 @@ static int hibmc_kms_init(struct hibmc_drm_private *priv)
 	return 0;
 }
 
-static void hibmc_kms_fini(struct hibmc_drm_private *priv)
-{
-	if (priv->mode_config_initialized) {
-		drm_mode_config_cleanup(&priv->dev);
-		priv->mode_config_initialized = false;
-	}
-}
-
 /*
  * It can operate in one of three modes: 0, 1 or Sleep.
  */
@@ -248,7 +242,6 @@ static int hibmc_unload(struct drm_device *dev)
 	drm_atomic_helper_shutdown(dev);
 
 	pci_disable_msi(dev->pdev);
-	hibmc_kms_fini(priv);
 	dev->dev_private = NULL;
 	return 0;
 }
-- 
2.7.4


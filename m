Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8D32D0ECF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 12:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbgLGLQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 06:16:57 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9111 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbgLGLQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 06:16:52 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CqLMP285YzM1qP;
        Mon,  7 Dec 2020 19:15:29 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Mon, 7 Dec 2020 19:16:04 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <airlied@linux.ie>, <daniel@ffwll.ch>, <tzimmermann@suse.de>,
        <kraxel@redhat.com>, <alexander.deucher@amd.com>,
        <tglx@linutronix.de>, <dri-devel@lists.freedesktop.org>,
        <xinliang.liu@linaro.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH drm/hisilicon v2 1/2] drm/hisilicon: Use managed mode-config init
Date:   Mon, 7 Dec 2020 19:16:17 +0800
Message-ID: <1607339778-20460-2-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1607339778-20460-1-git-send-email-tiantao6@hisilicon.com>
References: <1607339778-20460-1-git-send-email-tiantao6@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using drmm_mode_config_init() sets up managed release of modesetting
resources.

v2:
Remove the unused structure member variable mode_config_initialized.

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c | 14 +++-----------
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h |  1 -
 2 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
index 3687753..7f01213 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
@@ -96,8 +96,9 @@ static int hibmc_kms_init(struct hibmc_drm_private *priv)
 	struct drm_device *dev = &priv->dev;
 	int ret;
 
-	drm_mode_config_init(dev);
-	priv->mode_config_initialized = true;
+	ret = drmm_mode_config_init(dev);
+	if (ret)
+		return ret;
 
 	dev->mode_config.min_width = 0;
 	dev->mode_config.min_height = 0;
@@ -125,14 +126,6 @@ static int hibmc_kms_init(struct hibmc_drm_private *priv)
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
@@ -262,7 +255,6 @@ static int hibmc_unload(struct drm_device *dev)
 	drm_atomic_helper_shutdown(dev);
 
 	pci_disable_msi(dev->pdev);
-	hibmc_kms_fini(priv);
 	dev->dev_private = NULL;
 	return 0;
 }
diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
index a49c10e..7d263f4 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
@@ -42,7 +42,6 @@ struct hibmc_drm_private {
 	struct drm_crtc crtc;
 	struct drm_encoder encoder;
 	struct hibmc_connector connector;
-	bool mode_config_initialized;
 };
 
 static inline struct hibmc_connector *to_hibmc_connector(struct drm_connector *connector)
-- 
2.7.4


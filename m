Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89F822D08A9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 01:52:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728585AbgLGAuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 19:50:02 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:8951 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728485AbgLGAuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 19:50:01 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Cq4SS1RqmzhnS8;
        Mon,  7 Dec 2020 08:48:56 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Mon, 7 Dec 2020 08:49:18 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <airlied@linux.ie>, <daniel@ffwll.ch>, <tzimmermann@suse.de>,
        <kraxel@redhat.com>, <alexander.deucher@amd.com>,
        <tglx@linutronix.de>, <dri-devel@lists.freedesktop.org>,
        <xinliang.liu@linaro.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH drm/hisilicon 1/2] drm/hisilicon: Use managed mode-config init
Date:   Mon, 7 Dec 2020 08:49:31 +0800
Message-ID: <1607302172-60123-2-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1607302172-60123-1-git-send-email-tiantao6@hisilicon.com>
References: <1607302172-60123-1-git-send-email-tiantao6@hisilicon.com>
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
index 3687753..d631f82 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
@@ -96,7 +96,9 @@ static int hibmc_kms_init(struct hibmc_drm_private *priv)
 	struct drm_device *dev = &priv->dev;
 	int ret;
 
-	drm_mode_config_init(dev);
+	ret = drmm_mode_config_init(dev);
+	if (ret)
+		return ret;
 	priv->mode_config_initialized = true;
 
 	dev->mode_config.min_width = 0;
@@ -125,14 +127,6 @@ static int hibmc_kms_init(struct hibmc_drm_private *priv)
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
@@ -262,7 +256,6 @@ static int hibmc_unload(struct drm_device *dev)
 	drm_atomic_helper_shutdown(dev);
 
 	pci_disable_msi(dev->pdev);
-	hibmc_kms_fini(priv);
 	dev->dev_private = NULL;
 	return 0;
 }
-- 
2.7.4


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 510852F0B7B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 04:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbhAKDbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 22:31:11 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:10703 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbhAKDbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 22:31:10 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DDfMF1Nl4zl3Vd;
        Mon, 11 Jan 2021 11:29:13 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.498.0; Mon, 11 Jan 2021 11:30:25 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <airlied@linux.ie>, <daniel@ffwll.ch>, <tzimmermann@suse.de>,
        <kraxel@redhat.com>, <alexander.deucher@amd.com>,
        <tglx@linutronix.de>, <dri-devel@lists.freedesktop.org>,
        <xinliang.liu@linaro.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] drm/hisilicon: Use drm_crtc_mask()
Date:   Mon, 11 Jan 2021 11:30:18 +0800
Message-ID: <1610335818-32895-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use drm_crtc_mask() where appropriate.

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
index c76f996..1c5f2fa 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
@@ -96,6 +96,7 @@ int hibmc_vdac_init(struct hibmc_drm_private *priv)
 	struct drm_device *dev = &priv->dev;
 	struct hibmc_connector *hibmc_connector = &priv->connector;
 	struct drm_encoder *encoder = &priv->encoder;
+	struct drm_crtc *crtc = &priv->crtc;
 	struct drm_connector *connector = &hibmc_connector->base;
 	int ret;
 
@@ -105,7 +106,7 @@ int hibmc_vdac_init(struct hibmc_drm_private *priv)
 		return ret;
 	}
 
-	encoder->possible_crtcs = 0x1;
+	encoder->possible_crtcs = drm_crtc_mask(crtc);
 	ret = drm_simple_encoder_init(dev, encoder, DRM_MODE_ENCODER_DAC);
 	if (ret) {
 		drm_err(dev, "failed to init encoder: %d\n", ret);
-- 
2.7.4


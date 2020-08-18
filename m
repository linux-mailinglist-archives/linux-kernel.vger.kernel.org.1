Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 684A2247EB9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Aug 2020 08:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbgHRGyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Aug 2020 02:54:01 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:9829 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726366AbgHRGyB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 02:54:01 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 248A3B2E10C626655782;
        Tue, 18 Aug 2020 14:53:56 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Tue, 18 Aug 2020 14:53:49 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <airlied@linux.ie>, <daniel@ffwll.ch>, <tzimmermann@suse.de>,
        <kraxel@redhat.com>, <alexander.deucher@amd.com>,
        <tglx@linutronix.de>, <dri-devel@lists.freedesktop.org>,
        <xinliang.liu@linaro.org>, <linux-kernel@vger.kernel.org>
CC:     <linuxarm@huawei.com>
Subject: [PATCH drm/hisilicon 2/4] drm/hisilicon: Use drv_err instead of DRM_ERROR in hibmc_drm_vdac
Date:   Tue, 18 Aug 2020 14:51:42 +0800
Message-ID: <1597733504-30812-3-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1597733504-30812-1-git-send-email-tiantao6@hisilicon.com>
References: <1597733504-30812-1-git-send-email-tiantao6@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use drv_err instead of DRM_ERROR in hibmc_drm_vdac

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
index ed12f61..376a05d 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
@@ -85,7 +85,7 @@ int hibmc_vdac_init(struct hibmc_drm_private *priv)
 	ret = drm_encoder_init(dev, encoder, &hibmc_encoder_funcs,
 			       DRM_MODE_ENCODER_DAC, NULL);
 	if (ret) {
-		DRM_ERROR("failed to init encoder: %d\n", ret);
+		drm_err(dev, "failed to init encoder: %d\n", ret);
 		return ret;
 	}
 
@@ -94,7 +94,7 @@ int hibmc_vdac_init(struct hibmc_drm_private *priv)
 	ret = drm_connector_init(dev, connector, &hibmc_connector_funcs,
 				 DRM_MODE_CONNECTOR_VGA);
 	if (ret) {
-		DRM_ERROR("failed to init connector: %d\n", ret);
+		drm_err(dev, "failed to init connector: %d\n", ret);
 		return ret;
 	}
 	drm_connector_helper_add(connector, &hibmc_connector_helper_funcs);
-- 
2.7.4


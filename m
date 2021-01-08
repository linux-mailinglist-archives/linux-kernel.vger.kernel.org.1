Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7952EF0CB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 11:42:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727525AbhAHKlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 05:41:55 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:10422 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727293AbhAHKly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 05:41:54 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DC04B5Hr5zj46B;
        Fri,  8 Jan 2021 18:40:26 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.498.0; Fri, 8 Jan 2021 18:41:11 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <airlied@linux.ie>, <daniel@ffwll.ch>, <tzimmermann@suse.de>,
        <kraxel@redhat.com>, <alexander.deucher@amd.com>,
        <tglx@linutronix.de>, <dri-devel@lists.freedesktop.org>,
        <xinliang.liu@linaro.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] drm/hisilicon: Delete the empty function mode_valid
Date:   Fri, 8 Jan 2021 18:41:05 +0800
Message-ID: <1610102465-36501-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on the drm_connector_mode_valid, if the hibmc implementation
of mode_valid only returns MODE_OK, then we can not implement the
mode_valid function.

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
index c76f996..c74a35b 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
@@ -43,12 +43,6 @@ static int hibmc_connector_get_modes(struct drm_connector *connector)
 	return count;
 }
 
-static enum drm_mode_status hibmc_connector_mode_valid(struct drm_connector *connector,
-						       struct drm_display_mode *mode)
-{
-	return MODE_OK;
-}
-
 static void hibmc_connector_destroy(struct drm_connector *connector)
 {
 	struct hibmc_connector *hibmc_connector = to_hibmc_connector(connector);
@@ -60,7 +54,6 @@ static void hibmc_connector_destroy(struct drm_connector *connector)
 static const struct drm_connector_helper_funcs
 	hibmc_connector_helper_funcs = {
 	.get_modes = hibmc_connector_get_modes,
-	.mode_valid = hibmc_connector_mode_valid,
 };
 
 static const struct drm_connector_funcs hibmc_connector_funcs = {
-- 
2.7.4


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8299027198F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 05:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbgIUD17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 23:27:59 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13780 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726210AbgIUD17 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 23:27:59 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 47F6B33E13999926F05A;
        Mon, 21 Sep 2020 11:27:56 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Mon, 21 Sep 2020 11:27:48 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <airlied@linux.ie>, <daniel@ffwll.ch>, <tzimmermann@suse.de>,
        <kraxel@redhat.com>, <alexander.deucher@amd.com>,
        <tglx@linutronix.de>, <dri-devel@lists.freedesktop.org>,
        <xinliang.liu@linaro.org>, <linux-kernel@vger.kernel.org>
CC:     <linuxarm@huawei.com>
Subject: [PATCH drm/hisilicon 3/3] drm/hisilicon: Releasing Resources in the Destroy callback Function
Date:   Mon, 21 Sep 2020 11:25:22 +0800
Message-ID: <1600658722-35945-4-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1600658722-35945-1-git-send-email-tiantao6@hisilicon.com>
References: <1600658722-35945-1-git-send-email-tiantao6@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rewrite the desrtoy callback function to release resources.

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
index e84d381..f1541ff 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
@@ -47,6 +47,14 @@ static enum drm_mode_status hibmc_connector_mode_valid(struct drm_connector *con
 	return MODE_OK;
 }
 
+static void hibmc_connector_destroy(struct drm_connector *connector)
+{
+	struct hibmc_connector *hibmc_connector = to_hibmc_connector(connector);
+
+	i2c_del_adapter(&hibmc_connector->adapter);
+	drm_connector_cleanup(connector);
+}
+
 static const struct drm_connector_helper_funcs
 	hibmc_connector_helper_funcs = {
 	.get_modes = hibmc_connector_get_modes,
@@ -55,7 +63,7 @@ static const struct drm_connector_helper_funcs
 
 static const struct drm_connector_funcs hibmc_connector_funcs = {
 	.fill_modes = drm_helper_probe_single_connector_modes,
-	.destroy = drm_connector_cleanup,
+	.destroy = hibmc_connector_destroy,
 	.reset = drm_atomic_helper_connector_reset,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
-- 
2.7.4


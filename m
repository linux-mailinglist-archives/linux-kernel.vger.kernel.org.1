Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 565B9274110
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 13:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbgIVLjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 07:39:35 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14210 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726454AbgIVLj3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 07:39:29 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 8BB2694415709ABAFF86;
        Tue, 22 Sep 2020 19:39:28 +0800 (CST)
Received: from huawei.com (10.175.104.57) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Tue, 22 Sep 2020
 19:39:25 +0800
From:   Li Heng <liheng40@huawei.com>
To:     <eric@anholt.net>, <airlied@linux.ie>, <daniel@ffwll.ch>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] drm/v3d: Remove set but not used variable
Date:   Tue, 22 Sep 2020 19:39:24 +0800
Message-ID: <1600774764-50332-1-git-send-email-liheng40@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.104.57]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This addresses the following gcc warning with "make W=1":

drivers/gpu/drm/v3d/v3d_drv.c:73:32: warning:
‘v3d_v3d_pm_ops’ defined but not used [-Wunused-const-variable=]

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Li Heng <liheng40@huawei.com>
---
 drivers/gpu/drm/v3d/v3d_drv.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_drv.c b/drivers/gpu/drm/v3d/v3d_drv.c
index 9f7c261..05140db 100644
--- a/drivers/gpu/drm/v3d/v3d_drv.c
+++ b/drivers/gpu/drm/v3d/v3d_drv.c
@@ -70,10 +70,6 @@ static int v3d_runtime_resume(struct device *dev)
 }
 #endif

-static const struct dev_pm_ops v3d_v3d_pm_ops = {
-	SET_RUNTIME_PM_OPS(v3d_runtime_suspend, v3d_runtime_resume, NULL)
-};
-
 static int v3d_get_param_ioctl(struct drm_device *dev, void *data,
 			       struct drm_file *file_priv)
 {
--
2.7.4


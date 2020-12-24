Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAEB22E273A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Dec 2020 14:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728800AbgLXNXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Dec 2020 08:23:21 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:10361 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728771AbgLXNXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Dec 2020 08:23:21 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4D1rMK69h3z7K7J;
        Thu, 24 Dec 2020 21:21:49 +0800 (CST)
Received: from ubuntu.network (10.175.138.68) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.498.0; Thu, 24 Dec 2020 21:22:27 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <patrik.r.jakobsson@gmail.com>, <airlied@linux.ie>,
        <daniel@ffwll.ch>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
CC:     Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH v2 -next] drm: gma500: use DEFINE_MUTEX() for mutex lock
Date:   Thu, 24 Dec 2020 21:23:04 +0800
Message-ID: <20201224132304.31015-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.138.68]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mutex lock can be initialized automatically with DEFINE_MUTEX()
rather than explicitly calling mutex_init().

Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 drivers/gpu/drm/gma500/power.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/gma500/power.c b/drivers/gpu/drm/gma500/power.c
index bea8578846d1..b361e41c6acd 100644
--- a/drivers/gpu/drm/gma500/power.c
+++ b/drivers/gpu/drm/gma500/power.c
@@ -35,7 +35,7 @@
 #include <linux/mutex.h>
 #include <linux/pm_runtime.h>
 
-static struct mutex power_mutex;	/* Serialize power ops */
+static DEFINE_MUTEX(power_mutex);	/* Serialize power ops */
 static spinlock_t power_ctrl_lock;	/* Serialize power claim */
 
 /**
@@ -56,7 +56,6 @@ void gma_power_init(struct drm_device *dev)
 	dev_priv->display_count = 0;	/* Currently no users */
 	dev_priv->suspended = false;	/* And not suspended */
 	spin_lock_init(&power_ctrl_lock);
-	mutex_init(&power_mutex);
 
 	if (dev_priv->ops->init_pm)
 		dev_priv->ops->init_pm(dev);
-- 
2.22.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95FC72E1D1A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 15:14:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729030AbgLWOMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 09:12:51 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9679 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728578AbgLWOMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 09:12:49 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4D1FVm0q0LzkvPH;
        Wed, 23 Dec 2020 22:11:12 +0800 (CST)
Received: from ubuntu.network (10.175.138.68) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.498.0; Wed, 23 Dec 2020 22:11:59 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <patrik.r.jakobsson@gmail.com>, <airlied@linux.ie>,
        <daniel@ffwll.ch>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
CC:     Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH -next] drm: gma500: use DEFINE_MUTEX (and mutex_init() had been too late)
Date:   Wed, 23 Dec 2020 22:12:36 +0800
Message-ID: <20201223141236.435-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.138.68]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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


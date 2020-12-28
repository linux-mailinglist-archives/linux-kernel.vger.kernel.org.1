Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB962E3B92
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 14:51:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406986AbgL1Nvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 08:51:47 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:10370 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406945AbgL1Nvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 08:51:38 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4D4Jp76KXnz7MGL;
        Mon, 28 Dec 2020 21:50:07 +0800 (CST)
Received: from ubuntu.network (10.175.138.68) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.498.0; Mon, 28 Dec 2020 21:50:49 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <patrik.r.jakobsson@gmail.com>, <airlied@linux.ie>,
        <daniel@ffwll.ch>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
CC:     Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH -next] gpu: drm: gma500: Use DEFINE_SPINLOCK() for spinlock
Date:   Mon, 28 Dec 2020 21:51:28 +0800
Message-ID: <20201228135128.28733-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.138.68]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

spinlock can be initialized automatically with DEFINE_SPINLOCK()
rather than explicitly calling spin_lock_init().

Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 drivers/gpu/drm/gma500/power.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/gma500/power.c b/drivers/gpu/drm/gma500/power.c
index b361e41c6acd..cfb0a1906950 100644
--- a/drivers/gpu/drm/gma500/power.c
+++ b/drivers/gpu/drm/gma500/power.c
@@ -36,7 +36,7 @@
 #include <linux/pm_runtime.h>
 
 static DEFINE_MUTEX(power_mutex);	/* Serialize power ops */
-static spinlock_t power_ctrl_lock;	/* Serialize power claim */
+static DEFINE_SPINLOCK(power_ctrl_lock);	/* Serialize power claim */
 
 /**
  *	gma_power_init		-	initialise power manager
@@ -55,7 +55,6 @@ void gma_power_init(struct drm_device *dev)
 	dev_priv->display_power = true;	/* We start active */
 	dev_priv->display_count = 0;	/* Currently no users */
 	dev_priv->suspended = false;	/* And not suspended */
-	spin_lock_init(&power_ctrl_lock);
 
 	if (dev_priv->ops->init_pm)
 		dev_priv->ops->init_pm(dev);
-- 
2.22.0


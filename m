Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F300922A603
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jul 2020 05:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387690AbgGWD0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jul 2020 23:26:18 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:8256 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729401AbgGWD0R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 23:26:17 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 75FB77FF8DAD8F8D1986;
        Thu, 23 Jul 2020 11:26:14 +0800 (CST)
Received: from huawei.com (10.175.104.57) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0; Thu, 23 Jul 2020
 11:26:10 +0800
From:   Li Heng <liheng40@huawei.com>
To:     <airlied@linux.ie>, <daniel@ffwll.ch>
CC:     <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next 1/2] drm: Remove redundant NULL check
Date:   Thu, 23 Jul 2020 11:27:42 +0800
Message-ID: <1595474863-33112-1-git-send-email-liheng40@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.104.57]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix below warnings reported by coccicheck:
./drivers/gpu/drm/drm_drv.c:819:2-7: WARNING: NULL check before some freeing functions is not needed.

Fixes: 5dad34f3c444 ("drm: Cleanups after drmm_add_final_kfree rollout")
Signed-off-by: Li Heng <liheng40@huawei.com>
---
 drivers/gpu/drm/drm_drv.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
index bc38322..13068fd 100644
--- a/drivers/gpu/drm/drm_drv.c
+++ b/drivers/gpu/drm/drm_drv.c
@@ -815,8 +815,7 @@ static void drm_dev_release(struct kref *ref)
 
 	drm_managed_release(dev);
 
-	if (dev->managed.final_kfree)
-		kfree(dev->managed.final_kfree);
+	kfree(dev->managed.final_kfree);
 }
 
 /**
-- 
2.7.4


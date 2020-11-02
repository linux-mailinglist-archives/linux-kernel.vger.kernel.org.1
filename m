Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1060C2A2A67
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 13:09:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728697AbgKBMI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 07:08:57 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:7401 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728487AbgKBMI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 07:08:57 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CPsCB4NGFz72Bl;
        Mon,  2 Nov 2020 20:08:54 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Mon, 2 Nov 2020 20:08:44 +0800
From:   Zou Wei <zou_wei@huawei.com>
To:     <bskeggs@redhat.com>, <airlied@linux.ie>, <daniel@ffwll.ch>
CC:     <dri-devel@lists.freedesktop.org>, <nouveau@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, Zou Wei <zou_wei@huawei.com>
Subject: [PATCH -next] drm/nouveu: remove unused variable
Date:   Mon, 2 Nov 2020 20:20:39 +0800
Message-ID: <1604319639-12227-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix variables set but not used compilation warnings:

./nouveau_bo.c:1313:17: warning: variable ‘dev’ set but not used [-Wunused-but-set-variable]
  struct device *dev;
                 ^~~
./nouveau_bo.c:1337:17: warning: variable ‘dev’ set but not used [-Wunused-but-set-variable]
  struct device *dev;
                 ^~~

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 drivers/gpu/drm/nouveau/nouveau_bo.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_bo.c b/drivers/gpu/drm/nouveau/nouveau_bo.c
index 8133377..96f00b5 100644
--- a/drivers/gpu/drm/nouveau/nouveau_bo.c
+++ b/drivers/gpu/drm/nouveau/nouveau_bo.c
@@ -1310,7 +1310,6 @@ nouveau_ttm_tt_populate(struct ttm_bo_device *bdev,
 {
 	struct ttm_tt *ttm_dma = (void *)ttm;
 	struct nouveau_drm *drm;
-	struct device *dev;
 	bool slave = !!(ttm->page_flags & TTM_PAGE_FLAG_SG);
 
 	if (ttm_tt_is_populated(ttm))
@@ -1324,7 +1323,6 @@ nouveau_ttm_tt_populate(struct ttm_bo_device *bdev,
 	}
 
 	drm = nouveau_bdev(bdev);
-	dev = drm->dev->dev;
 
 	return ttm_pool_alloc(&drm->ttm.bdev.pool, ttm, ctx);
 }
@@ -1334,14 +1332,12 @@ nouveau_ttm_tt_unpopulate(struct ttm_bo_device *bdev,
 			  struct ttm_tt *ttm)
 {
 	struct nouveau_drm *drm;
-	struct device *dev;
 	bool slave = !!(ttm->page_flags & TTM_PAGE_FLAG_SG);
 
 	if (slave)
 		return;
 
 	drm = nouveau_bdev(bdev);
-	dev = drm->dev->dev;
 
 	return ttm_pool_free(&drm->ttm.bdev.pool, ttm);
 }
-- 
2.6.2


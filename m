Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B289263AA2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Sep 2020 04:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730187AbgIJCgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Sep 2020 22:36:54 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:41882 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728286AbgIJCeB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 22:34:01 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 6ED9E922509EC3D6151A;
        Thu, 10 Sep 2020 10:33:59 +0800 (CST)
Received: from localhost (10.174.179.108) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0; Thu, 10 Sep 2020
 10:33:50 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
        <airlied@linux.ie>, <daniel@ffwll.ch>
CC:     <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] drm/ttm/agp: Fix Wunused-variable warning
Date:   Thu, 10 Sep 2020 10:33:45 +0800
Message-ID: <20200910023345.20428-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.108]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_AGP is not set, gcc warns:

drivers/gpu/drm/radeon/radeon_ttm.c: In function ‘radeon_ttm_tt_bind’:
drivers/gpu/drm/radeon/radeon_ttm.c:692:24: warning: unused variable ‘rdev’ [-Wunused-variable]
  struct radeon_device *rdev = radeon_get_rdev(bdev);
                        ^~~~

Move it to ifdef block to fix this.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/radeon/radeon_ttm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/radeon_ttm.c b/drivers/gpu/drm/radeon/radeon_ttm.c
index 31c63d339629..449e77eb75f9 100644
--- a/drivers/gpu/drm/radeon/radeon_ttm.c
+++ b/drivers/gpu/drm/radeon/radeon_ttm.c
@@ -689,9 +689,9 @@ static int radeon_ttm_tt_bind(struct ttm_bo_device *bdev,
 			      struct ttm_tt *ttm,
 			      struct ttm_resource *bo_mem)
 {
+#if IS_ENABLED(CONFIG_AGP)
 	struct radeon_device *rdev = radeon_get_rdev(bdev);
 
-#if IS_ENABLED(CONFIG_AGP)
 	if (rdev->flags & RADEON_IS_AGP)
 		return ttm_agp_bind(ttm, bo_mem);
 #endif
-- 
2.17.1



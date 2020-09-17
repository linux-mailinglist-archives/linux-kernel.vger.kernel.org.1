Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54CE426DA9E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 13:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbgIQLpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 07:45:17 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:53084 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726826AbgIQLnK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 07:43:10 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 16F60F1EA03D3E34EBC8;
        Thu, 17 Sep 2020 19:42:49 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Thu, 17 Sep 2020 19:42:41 +0800
From:   Jing Xiangfeng <jingxiangfeng@huawei.com>
To:     <christian.koenig@amd.com>, <ray.huang@amd.com>,
        <airlied@linux.ie>, <daniel@ffwll.ch>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <jingxiangfeng@huawei.com>
Subject: [PATCH] drm/ttm: remove redundant initialization of variable ret
Date:   Thu, 17 Sep 2020 19:42:46 +0800
Message-ID: <20200917114246.93291-1-jingxiangfeng@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable ret is being initialized with '-ENOMEM' that is
meaningless. So remove it.

Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
---
 drivers/gpu/drm/ttm/ttm_tt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ttm/ttm_tt.c b/drivers/gpu/drm/ttm/ttm_tt.c
index 3437711ddb43..4db87b9b57a8 100644
--- a/drivers/gpu/drm/ttm/ttm_tt.c
+++ b/drivers/gpu/drm/ttm/ttm_tt.c
@@ -388,7 +388,7 @@ int ttm_tt_swapout(struct ttm_tt *ttm, struct file *persistent_swap_storage)
 	struct page *from_page;
 	struct page *to_page;
 	int i;
-	int ret = -ENOMEM;
+	int ret;
 
 	BUG_ON(ttm->state != tt_unbound && ttm->state != tt_unpopulated);
 	BUG_ON(ttm->caching_state != tt_cached);
-- 
2.17.1


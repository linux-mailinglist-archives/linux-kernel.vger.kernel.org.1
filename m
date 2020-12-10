Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7ED12D5CB0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 15:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389877AbgLJOBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 09:01:38 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9156 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732619AbgLJOBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 09:01:25 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CsFt04LkMz15b8N;
        Thu, 10 Dec 2020 22:00:08 +0800 (CST)
Received: from ubuntu.network (10.175.138.68) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Thu, 10 Dec 2020 22:00:35 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <agk@redhat.com>, <snitzer@redhat.com>, <dm-devel@redhat.com>,
        <linux-kernel@vger.kernel.org>
CC:     Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH -next] drivers: md: simplify the return expression of load_mapping()
Date:   Thu, 10 Dec 2020 22:01:03 +0800
Message-ID: <20201210140103.1720-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.138.68]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify the return expression.

Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 drivers/md/dm-cache-target.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/md/dm-cache-target.c b/drivers/md/dm-cache-target.c
index 4bc453f5bbaa..541c45027cc8 100644
--- a/drivers/md/dm-cache-target.c
+++ b/drivers/md/dm-cache-target.c
@@ -2840,7 +2840,6 @@ static void cache_postsuspend(struct dm_target *ti)
 static int load_mapping(void *context, dm_oblock_t oblock, dm_cblock_t cblock,
 			bool dirty, uint32_t hint, bool hint_valid)
 {
-	int r;
 	struct cache *cache = context;
 
 	if (dirty) {
@@ -2849,11 +2848,7 @@ static int load_mapping(void *context, dm_oblock_t oblock, dm_cblock_t cblock,
 	} else
 		clear_bit(from_cblock(cblock), cache->dirty_bitset);
 
-	r = policy_load_mapping(cache->policy, oblock, cblock, dirty, hint, hint_valid);
-	if (r)
-		return r;
-
-	return 0;
+	return policy_load_mapping(cache->policy, oblock, cblock, dirty, hint, hint_valid);
 }
 
 /*
-- 
2.22.0


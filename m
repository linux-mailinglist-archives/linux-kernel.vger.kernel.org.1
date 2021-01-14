Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D90B2F60B4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 13:02:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728938AbhANMBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 07:01:52 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:11013 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728150AbhANMBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 07:01:51 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DGjYK60c3zj6wG;
        Thu, 14 Jan 2021 20:00:05 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.498.0; Thu, 14 Jan 2021
 20:00:59 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <minchan@kernel.org>,
        <ngupta@vflare.org>, <sergey.senozhatsky.work@gmail.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] mm/zsmalloc.c: Convert to use kmem_cache_zalloc in cache_alloc_zspage()
Date:   Thu, 14 Jan 2021 07:00:32 -0500
Message-ID: <20210114120032.25885-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We always memset the zspage allocated via cache_alloc_zspage. So it's more
convenient to use kmem_cache_zalloc in cache_alloc_zspage than caller do it
manually.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/zsmalloc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 7289f502ffac..cf0ed0e4e911 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -357,7 +357,7 @@ static void cache_free_handle(struct zs_pool *pool, unsigned long handle)
 
 static struct zspage *cache_alloc_zspage(struct zs_pool *pool, gfp_t flags)
 {
-	return kmem_cache_alloc(pool->zspage_cachep,
+	return kmem_cache_zalloc(pool->zspage_cachep,
 			flags & ~(__GFP_HIGHMEM|__GFP_MOVABLE));
 }
 
@@ -1064,7 +1064,6 @@ static struct zspage *alloc_zspage(struct zs_pool *pool,
 	if (!zspage)
 		return NULL;
 
-	memset(zspage, 0, sizeof(struct zspage));
 	zspage->magic = ZSPAGE_MAGIC;
 	migrate_lock_init(zspage);
 
-- 
2.19.1


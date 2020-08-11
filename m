Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 384042414C5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Aug 2020 04:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbgHKCDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Aug 2020 22:03:07 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:9361 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728012AbgHKCDH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 22:03:07 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 47154FA38E8B707599D2;
        Tue, 11 Aug 2020 10:03:05 +0800 (CST)
Received: from DESKTOP-A9S207P.china.huawei.com (10.174.179.61) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Tue, 11 Aug 2020 10:02:55 +0800
From:   <wuyun.wu@huawei.com>
To:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        "David Rientjes" <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        "Andrew Morton" <akpm@linux-foundation.org>
CC:     <liu.xiang6@zte.com.cn>, Abel Wu <wuyun.wu@huawei.com>,
        "open list:SLAB ALLOCATOR" <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH] mm/slub: make add_full() condition more explicit
Date:   Tue, 11 Aug 2020 10:02:36 +0800
Message-ID: <20200811020240.1231-1-wuyun.wu@huawei.com>
X-Mailer: git-send-email 2.28.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.179.61]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Abel Wu <wuyun.wu@huawei.com>

The commit below is incomplete, as it didn't handle the add_full() part.
commit a4d3f8916c65 ("slub: remove useless kmem_cache_debug() before remove_full()")

This patch checks for SLAB_STORE_USER instead of kmem_cache_debug(),
since that should be the only context in which we need the list_lock for
add_full().

Signed-off-by: Abel Wu <wuyun.wu@huawei.com>
---
 mm/slub.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/slub.c b/mm/slub.c
index f226d66408ee..df93a5a0e9a4 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2182,7 +2182,8 @@ static void deactivate_slab(struct kmem_cache *s, struct page *page,
 		}
 	} else {
 		m = M_FULL;
-		if (kmem_cache_debug(s) && !lock) {
+#ifdef CONFIG_SLUB_DEBUG
+		if ((s->flags & SLAB_STORE_USER) && !lock) {
 			lock = 1;
 			/*
 			 * This also ensures that the scanning of full
@@ -2191,6 +2192,7 @@ static void deactivate_slab(struct kmem_cache *s, struct page *page,
 			 */
 			spin_lock(&n->list_lock);
 		}
+#endif
 	}
 
 	if (l != m) {
-- 
2.28.0.windows.1


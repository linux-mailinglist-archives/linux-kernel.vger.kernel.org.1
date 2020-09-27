Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6FA27A0E0
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 14:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbgI0MXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 08:23:48 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:47358 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726185AbgI0MXs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 08:23:48 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id C7BAE6352B26465265E3;
        Sun, 27 Sep 2020 20:23:42 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0; Sun, 27 Sep 2020
 20:23:32 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] mm: Fix incomplete comment in lru_cache_add_inactive_or_unevictable()
Date:   Sun, 27 Sep 2020 08:22:09 -0400
Message-ID: <20200927122209.59328-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 9c4e6b1a7027 ("mm, mlock, vmscan: no more skipping pagevecs"),
unevictable pages do not goes directly back onto zone's unevictable list.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/swap.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/mm/swap.c b/mm/swap.c
index 7e79829a2e73..0eb057141a04 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -481,9 +481,7 @@ EXPORT_SYMBOL(lru_cache_add);
  * @vma:   vma in which page is mapped for determining reclaimability
  *
  * Place @page on the inactive or unevictable LRU list, depending on its
- * evictability.  Note that if the page is not evictable, it goes
- * directly back onto it's zone's unevictable list, it does NOT use a
- * per cpu pagevec.
+ * evictability.
  */
 void lru_cache_add_inactive_or_unevictable(struct page *page,
 					 struct vm_area_struct *vma)
-- 
2.19.1


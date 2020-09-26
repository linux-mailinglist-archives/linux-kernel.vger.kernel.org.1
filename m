Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9825A27983C
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 12:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgIZKJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Sep 2020 06:09:06 -0400
Received: from m12-15.163.com ([220.181.12.15]:59754 "EHLO m12-15.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726183AbgIZKJG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Sep 2020 06:09:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=VvX48
        q0TXBplICgakqAuHRvedusBSf93a4uxMLBZIHU=; b=HK2MQF8STv9bJm3UPkOJl
        v9ynD+hvgsfEARKai63Aujfhx+krHBbmrT9iS2mNhsN1nA5frNHF+LneDLyUNxJK
        o2ZrcfNh2YJyKqprHUle59cMzhTRDRIdl9Ib/Cv3iZaRnvg+3UaE3ocoikJLy3St
        egA5Wk+iWVClnm3vQLP/kY=
Received: from localhost (unknown [101.86.214.224])
        by smtp11 (Coremail) with SMTP id D8CowAAn_5giE29fDiiuDw--.21927S2;
        Sat, 26 Sep 2020 18:08:34 +0800 (CST)
Date:   Sat, 26 Sep 2020 18:08:34 +0800
From:   Hui Su <sh_def@163.com>
To:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm,z3fold: use xx_zalloc instead xx_alloc and memset
Message-ID: <20200926100834.GA184671@rlk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CM-TRANSID: D8CowAAn_5giE29fDiiuDw--.21927S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gr4UJF1xWFy5Kr4xKw1rWFg_yoWfXwb_ZF
        Z7tF4DWry5Ja4vyanxAw10vFZ2qa97Cr4ruFnIgryft345AryxC3sFgr13ur43Zr429F9r
        K3y3GrWrJ3W7GjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU5d3kJUUUUU==
X-Originating-IP: [101.86.214.224]
X-CM-SenderInfo: xvkbvvri6rljoofrz/1tbiLgKrX1SIqLklqQAAsZ
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

alloc_slots() allocate memory for slots by kmem_cache_alloc(),
then memset it, we can just use kmem_cache_zalloc() api.

Signed-off-by: Hui Su <sh_def@163.com>
---
 mm/z3fold.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/z3fold.c b/mm/z3fold.c
index 460b0feced26..18feaa0bc537 100644
--- a/mm/z3fold.c
+++ b/mm/z3fold.c
@@ -212,13 +212,12 @@ static inline struct z3fold_buddy_slots *alloc_slots(struct z3fold_pool *pool,
 {
 	struct z3fold_buddy_slots *slots;
 
-	slots = kmem_cache_alloc(pool->c_handle,
+	slots = kmem_cache_zalloc(pool->c_handle,
 				 (gfp & ~(__GFP_HIGHMEM | __GFP_MOVABLE)));
 
 	if (slots) {
 		/* It will be freed separately in free_handle(). */
 		kmemleak_not_leak(slots);
-		memset(slots->slot, 0, sizeof(slots->slot));
 		slots->pool = (unsigned long)pool;
 		rwlock_init(&slots->lock);
 	}
-- 
2.25.1



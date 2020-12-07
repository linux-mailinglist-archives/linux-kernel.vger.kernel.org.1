Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1F362D13E5
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 15:42:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbgLGOl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 09:41:57 -0500
Received: from m12-14.163.com ([220.181.12.14]:34478 "EHLO m12-14.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726142AbgLGOl5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 09:41:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=3uk2L
        bhtc7beQcuFB/TC0ws6g0FxHPq8w1P2GqYnqaM=; b=lu29XvI8SSVKydg5pArXy
        IF+jH7YG4kkUn/HWrrY1WXAh/afpnR8I/vL5m34N6ONffljdeC0yZa09HEsQzyOL
        GwHjS2zG7fWbDouLcjGvTihqThe1eeJig3+yKb+TFY8i+68dyKeqfIFGAARo/JHs
        U1bIFU5je+N2xIXSK+Y7jk=
Received: from localhost (unknown [223.104.66.117])
        by smtp10 (Coremail) with SMTP id DsCowABnfo6MOs5fDyHjZg--.32833S2;
        Mon, 07 Dec 2020 22:22:05 +0800 (CST)
Date:   Mon, 7 Dec 2020 22:22:04 +0800
From:   Hui Su <sh_def@163.com>
To:     akpm@linux-foundation.org, shakeelb@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     songmuchun@bytedance.com
Subject: [PATCH] mm/page_alloc: simplify kmem cgroup charge/uncharge code
Message-ID: <20201207142204.GA18516@rlk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CM-TRANSID: DsCowABnfo6MOs5fDyHjZg--.32833S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7trW3uFWfGF1rZr45WF47CFg_yoW8ArykpF
        45JF1Iyw48X3WrAF42y3Wqk345ZwsYqFWrAa98Xw48Zw13Jw1Syr9rGFyxuFyfGrZ7A3y3
        GrsxAas8Wan8AaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07bsLvtUUUUU=
X-Originating-IP: [223.104.66.117]
X-CM-SenderInfo: xvkbvvri6rljoofrz/1tbiWQ3zX1WBttL-cQAAsG
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the commit 60cd4bcd6238 ("memcg: localize memcg_kmem_enabled()
check"), we have supplied the api which users don't have to explicitly
check memcg_kmem_enabled().

Signed-off-by: Hui Su <sh_def@163.com>
---
 mm/page_alloc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index eaa227a479e4..dc990a899ded 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1214,8 +1214,8 @@ static __always_inline bool free_pages_prepare(struct page *page,
 		 * Do not let hwpoison pages hit pcplists/buddy
 		 * Untie memcg state and reset page's owner
 		 */
-		if (memcg_kmem_enabled() && PageKmemcg(page))
-			__memcg_kmem_uncharge_page(page, order);
+		if (PageKmemcg(page))
+			memcg_kmem_uncharge_page(page, order);
 		reset_page_owner(page, order);
 		return false;
 	}
@@ -1244,8 +1244,8 @@ static __always_inline bool free_pages_prepare(struct page *page,
 	}
 	if (PageMappingFlags(page))
 		page->mapping = NULL;
-	if (memcg_kmem_enabled() && PageKmemcg(page))
-		__memcg_kmem_uncharge_page(page, order);
+	if (PageKmemcg(page))
+		memcg_kmem_uncharge_page(page, order);
 	if (check_free)
 		bad += check_free_page(page);
 	if (bad)
@@ -4965,8 +4965,8 @@ __alloc_pages_nodemask(gfp_t gfp_mask, unsigned int order, int preferred_nid,
 	page = __alloc_pages_slowpath(alloc_mask, order, &ac);
 
 out:
-	if (memcg_kmem_enabled() && (gfp_mask & __GFP_ACCOUNT) && page &&
-	    unlikely(__memcg_kmem_charge_page(page, gfp_mask, order) != 0)) {
+	if ((gfp_mask & __GFP_ACCOUNT) && page &&
+	    unlikely(memcg_kmem_charge_page(page, gfp_mask, order) != 0)) {
 		__free_pages(page, order);
 		page = NULL;
 	}
-- 
2.29.2



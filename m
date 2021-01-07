Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D95F82ECFF3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 13:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728279AbhAGMg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 07:36:56 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:10405 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728023AbhAGMg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 07:36:56 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DBQg85ygsz7RLh;
        Thu,  7 Jan 2021 20:35:16 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.498.0; Thu, 7 Jan 2021
 20:36:05 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] mm/vmalloc.c: Fix potential memory leak
Date:   Thu, 7 Jan 2021 07:35:41 -0500
Message-ID: <20210107123541.39206-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In VM_MAP_PUT_PAGES case, we should put pages and free array in vfree. But
we missed to set area->nr_pages in vmap(). So we would failed to put pages
in __vunmap() because area->nr_pages = 0.

Fixes: b944afc9d64d ("mm: add a VM_MAP_PUT_PAGES flag for vmap")
Signed-off-by: Shijie Luo <luoshijie1@huawei.com>
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Cc: <stable@vger.kernel.org>
---
 mm/vmalloc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 6507a579ff88..8ab83fbecadd 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2421,8 +2421,10 @@ void *vmap(struct page **pages, unsigned int count,
 		return NULL;
 	}
 
-	if (flags & VM_MAP_PUT_PAGES)
+	if (flags & VM_MAP_PUT_PAGES) {
 		area->pages = pages;
+		area->nr_pages = count;
+	}
 	return area->addr;
 }
 EXPORT_SYMBOL(vmap);
-- 
2.19.1


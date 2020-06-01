Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 748D81E9BFD
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jun 2020 05:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbgFADTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 May 2020 23:19:22 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:54718 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726860AbgFADTW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 23:19:22 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 318AD62EA3F5CD2E6BE9;
        Mon,  1 Jun 2020 11:19:20 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Mon, 1 Jun 2020
 11:19:12 +0800
From:   linmiaohe <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <hannes@cmpxchg.org>,
        <mhocko@suse.com>, <minchan@kernel.org>, <ziqian.lzq@antfin.com>,
        <yang.shi@linux.alibaba.com>, <gustavo@embeddedor.com>,
        <ying.huang@intel.com>
CC:     <linux-kernel@vger.kernel.org>, <willy@infradead.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH RESEND] mm, swap: delete meaningless __add_to_swap_cache() declaration
Date:   Mon, 1 Jun 2020 11:22:45 +0800
Message-ID: <1590981765-22911-1-git-send-email-linmiaohe@huawei.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miaohe Lin <linmiaohe@huawei.com>

Since commit 8d93b41c09d1 ("mm: Convert add_to_swap_cache to XArray"),
__add_to_swap_cache and add_to_swap_cache are combined into one function.
There is no __add_to_swap_cache() anymore.

CC: Matthew Wilcox <willy@infradead.org>
Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 include/linux/swap.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index e1bbf7a16b27..d70e6017d835 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -408,7 +408,6 @@ extern unsigned long total_swapcache_pages(void);
 extern void show_swap_cache_info(void);
 extern int add_to_swap(struct page *page);
 extern int add_to_swap_cache(struct page *, swp_entry_t, gfp_t);
-extern int __add_to_swap_cache(struct page *page, swp_entry_t entry);
 extern void __delete_from_swap_cache(struct page *, swp_entry_t entry);
 extern void delete_from_swap_cache(struct page *);
 extern void free_page_and_swap_cache(struct page *);
-- 
2.19.1


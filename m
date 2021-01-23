Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D877D3013A8
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 08:07:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbhAWHGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jan 2021 02:06:41 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:11132 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbhAWHGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jan 2021 02:06:39 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DN6ZJ3J36z15dTM;
        Sat, 23 Jan 2021 15:04:40 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.498.0; Sat, 23 Jan 2021
 15:05:43 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] mm/page_owner: Use helper function zone_end_pfn() to get end_pfn
Date:   Sat, 23 Jan 2021 02:05:38 -0500
Message-ID: <20210123070538.5861-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 108bcc96ef70 ("mm: add & use zone_end_pfn() and zone_spans_pfn()")
introduced the helper zone_end_pfn() to calculate the zone end pfn. But
pagetypeinfo_showmixedcount_print forgot to use it. And the initialization
of local variable pfn is duplicated, remove one.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/page_owner.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/page_owner.c b/mm/page_owner.c
index af464bb7fbe7..d15c7c4994f5 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -263,8 +263,8 @@ void pagetypeinfo_showmixedcount_print(struct seq_file *m,
 	struct page *page;
 	struct page_ext *page_ext;
 	struct page_owner *page_owner;
-	unsigned long pfn = zone->zone_start_pfn, block_end_pfn;
-	unsigned long end_pfn = pfn + zone->spanned_pages;
+	unsigned long pfn, block_end_pfn;
+	unsigned long end_pfn = zone_end_pfn(zone);
 	unsigned long count[MIGRATE_TYPES] = { 0, };
 	int pageblock_mt, page_mt;
 	int i;
-- 
2.19.1


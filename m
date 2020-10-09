Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9C892889F3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 15:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732462AbgJINnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 09:43:25 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:57452 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731572AbgJINnZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 09:43:25 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B378ADB4CB3495B7DDC5;
        Fri,  9 Oct 2020 21:43:21 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0; Fri, 9 Oct 2020
 21:43:15 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] mm/swapfile.c: Use helper function swap_count() in add_swap_count_continuation()
Date:   Fri, 9 Oct 2020 09:43:06 -0400
Message-ID: <20201009134306.18033-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 570a335b8e22 ("swap_info: swap count continuations") introduced the
func add_swap_count_continuation() but forgot to use the helper function
swap_count() introduced by commit 355cfa73ddff ("mm: modify swap_map and
add SWAP_HAS_CACHE flag").

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/swapfile.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 22c63beb10da..4d5bc19d1e08 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -3608,7 +3608,7 @@ int add_swap_count_continuation(swp_entry_t entry, gfp_t gfp_mask)
 
 	ci = lock_cluster(si, offset);
 
-	count = si->swap_map[offset] & ~SWAP_HAS_CACHE;
+	count = swap_count(si->swap_map[offset]);
 
 	if ((count & ~COUNT_CONTINUED) != SWAP_MAP_MAX) {
 		/*
-- 
2.19.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22C1F2889DA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 15:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388634AbgJINbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 09:31:20 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15200 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733281AbgJINbR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 09:31:17 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id E9E41D92F087A57A3BDC;
        Fri,  9 Oct 2020 21:31:13 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Fri, 9 Oct 2020
 21:31:07 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] mm/swap_state: Skip meaningless swap cache readahead when ra_info.win == 0
Date:   Fri, 9 Oct 2020 09:30:59 -0400
Message-ID: <20201009133059.58407-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

swap_ra_info() may leave ra_info untouched in non_swap_entry() case as page
table lock is not held. In this case, we have ra_info.nr_pte == 0 and it is
meaningless to continue with swap cache readahead. Skip such ops by init
ra_info.win = 1.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/swap_state.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/swap_state.c b/mm/swap_state.c
index ee465827420e..b9013c3f94c9 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -839,7 +839,7 @@ static struct page *swap_vma_readahead(swp_entry_t fentry, gfp_t gfp_mask,
 	swp_entry_t entry;
 	unsigned int i;
 	bool page_allocated;
-	struct vma_swap_readahead ra_info = {0,};
+	struct vma_swap_readahead ra_info = {1,};
 
 	swap_ra_info(vmf, &ra_info);
 	if (ra_info.win == 1)
-- 
2.19.1


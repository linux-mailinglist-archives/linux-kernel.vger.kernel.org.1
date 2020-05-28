Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8B201E54B9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 May 2020 05:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbgE1Dh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 May 2020 23:37:57 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5357 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726530AbgE1Dh5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 23:37:57 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id AD4FABF4CEAC56932558;
        Thu, 28 May 2020 11:37:52 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Thu, 28 May 2020 11:37:43 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] writeback: remove unused variable
Date:   Thu, 28 May 2020 11:37:40 +0800
Message-ID: <20200528033740.17269-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 64081362e8ff ("mm/page-writeback.c: fix range_cyclic writeback
vs writepages deadlock") left unused variable, remove it.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 mm/page-writeback.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index a53f4cfa7628..7e9714d2ce9d 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2160,7 +2160,6 @@ int write_cache_pages(struct address_space *mapping,
 	int error;
 	struct pagevec pvec;
 	int nr_pages;
-	pgoff_t uninitialized_var(writeback_index);
 	pgoff_t index;
 	pgoff_t end;		/* Inclusive */
 	pgoff_t done_index;
@@ -2169,8 +2168,7 @@ int write_cache_pages(struct address_space *mapping,
 
 	pagevec_init(&pvec);
 	if (wbc->range_cyclic) {
-		writeback_index = mapping->writeback_index; /* prev offset */
-		index = writeback_index;
+		index = mapping->writeback_index; /* prev offset */
 		end = -1;
 	} else {
 		index = wbc->range_start >> PAGE_SHIFT;
-- 
2.18.0.rc1


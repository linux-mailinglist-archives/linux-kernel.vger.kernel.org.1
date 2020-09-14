Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 621BE268BBA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 15:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbgINNGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 09:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726553AbgINNBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 09:01:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5992EC061353
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 06:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=BquVAG5cJo9Mjo1CPDl184L/mmeA/HhzvmJ2c4BZLkU=; b=ozGlJSbF/18v6F7REZyVtn9YUg
        RMboYm65nhrX0354KLqYDh6tEaAnJYjOvFqEdmo0g/gr+hxKaOnMBBxXhqFTPxGQJQ6OaWSsTKBFL
        pHXYd7CNVCWxNrIRJ1Pti79VVlDcly0nsnBXqyk9wp/2QkuAeZs0SXcajqfNim5KfB1H1ygEKr5b8
        u9bS3/VsO1y6kDbEm0BUsW77j8SdfjNgNpIlht/VpzxrvAu1DV202sUkHx4ARolSVJKSJ5R/REezP
        gGkB/OPvLRwuX4UNgYizVgbO68NiSTcslmE1AZ4Dsf5qcnce4qRFh1KYAMwLpuv0y0XLozc15JFEP
        l1rpgUVQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kHo68-0002zm-Mq; Mon, 14 Sep 2020 13:00:44 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Jan Kara <jack@suse.cz>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Dave Chinner <dchinner@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 02/12] mm/shmem: Use pagevec_lookup in shmem_unlock_mapping
Date:   Mon, 14 Sep 2020 14:00:32 +0100
Message-Id: <20200914130042.11442-3-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200914130042.11442-1-willy@infradead.org>
References: <20200914130042.11442-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The comment shows that the reason for using find_get_entries() is now
stale; find_get_pages() will not return 0 if it hits a consecutive run
of swap entries, and I don't believe it has since 2011.  pagevec_lookup()
is a simpler function to use than find_get_pages(), so use it instead.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/shmem.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 58bc9e326d0d..108931a6cc43 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -840,7 +840,6 @@ unsigned long shmem_swap_usage(struct vm_area_struct *vma)
 void shmem_unlock_mapping(struct address_space *mapping)
 {
 	struct pagevec pvec;
-	pgoff_t indices[PAGEVEC_SIZE];
 	pgoff_t index = 0;
 
 	pagevec_init(&pvec);
@@ -848,16 +847,8 @@ void shmem_unlock_mapping(struct address_space *mapping)
 	 * Minor point, but we might as well stop if someone else SHM_LOCKs it.
 	 */
 	while (!mapping_unevictable(mapping)) {
-		/*
-		 * Avoid pagevec_lookup(): find_get_pages() returns 0 as if it
-		 * has finished, if it hits a row of PAGEVEC_SIZE swap entries.
-		 */
-		pvec.nr = find_get_entries(mapping, index,
-					   PAGEVEC_SIZE, pvec.pages, indices);
-		if (!pvec.nr)
+		if (!pagevec_lookup(&pvec, mapping, &index))
 			break;
-		index = indices[pvec.nr - 1] + 1;
-		pagevec_remove_exceptionals(&pvec);
 		check_move_unevictable_pages(&pvec);
 		pagevec_release(&pvec);
 		cond_resched();
-- 
2.28.0


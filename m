Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C18A295309
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 21:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505030AbgJUTjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 15:39:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:45574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2409544AbgJUTja (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 15:39:30 -0400
Received: from tleilax.com (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74D1824171;
        Wed, 21 Oct 2020 19:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603309170;
        bh=JfNSHQVgtLi5ZPQULQA1L2A3faL8Q2GF5AGfEShV/H8=;
        h=From:To:Cc:Subject:Date:From;
        b=JdYJCpmuybrj5SG5GibFZFTFFQT/qjT3K3SpGvdDJkUMf203MutJUq3lfV+EvnwH0
         lA2Rz7TkpoyfZg5z4nwLbkkJfL/RTg4h/oYoxI/zuaDmaC0fvjPxxs7unibTBBuqsh
         dlhYuo911DKM0iddlOK/yBU7NAijU7iuZvE9ljEc=
From:   Jeff Layton <jlayton@kernel.org>
To:     akpm@linux-foundation.org
Cc:     willy@infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH] mm: remove pagevec_lookup_range_nr_tag
Date:   Wed, 21 Oct 2020 15:39:26 -0400
Message-Id: <20201021193926.101474-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the merge of 2e1692966034 (ceph: have ceph_writepages_start call
pagevec_lookup_range_tag), nothing calls this anymore.

Cc: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 include/linux/pagevec.h | 3 ---
 mm/swap.c               | 9 ---------
 2 files changed, 12 deletions(-)

diff --git a/include/linux/pagevec.h b/include/linux/pagevec.h
index 081d934eda64..ad4ddc17d403 100644
--- a/include/linux/pagevec.h
+++ b/include/linux/pagevec.h
@@ -43,9 +43,6 @@ static inline unsigned pagevec_lookup(struct pagevec *pvec,
 unsigned pagevec_lookup_range_tag(struct pagevec *pvec,
 		struct address_space *mapping, pgoff_t *index, pgoff_t end,
 		xa_mark_t tag);
-unsigned pagevec_lookup_range_nr_tag(struct pagevec *pvec,
-		struct address_space *mapping, pgoff_t *index, pgoff_t end,
-		xa_mark_t tag, unsigned max_pages);
 static inline unsigned pagevec_lookup_tag(struct pagevec *pvec,
 		struct address_space *mapping, pgoff_t *index, xa_mark_t tag)
 {
diff --git a/mm/swap.c b/mm/swap.c
index 47a47681c86b..1aca4b9c97fe 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -1164,15 +1164,6 @@ unsigned pagevec_lookup_range_tag(struct pagevec *pvec,
 }
 EXPORT_SYMBOL(pagevec_lookup_range_tag);
 
-unsigned pagevec_lookup_range_nr_tag(struct pagevec *pvec,
-		struct address_space *mapping, pgoff_t *index, pgoff_t end,
-		xa_mark_t tag, unsigned max_pages)
-{
-	pvec->nr = find_get_pages_range_tag(mapping, index, end, tag,
-		min_t(unsigned int, max_pages, PAGEVEC_SIZE), pvec->pages);
-	return pagevec_count(pvec);
-}
-EXPORT_SYMBOL(pagevec_lookup_range_nr_tag);
 /*
  * Perform any setup for the swap system
  */
-- 
2.26.2


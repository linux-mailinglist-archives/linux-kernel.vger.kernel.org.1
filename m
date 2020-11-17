Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 729832B5BC1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 10:26:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727153AbgKQJY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 04:24:56 -0500
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:38419 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725730AbgKQJY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 04:24:56 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R901e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0UFh2-H3_1605605092;
Received: from aliy80.localdomain(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UFh2-H3_1605605092)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 17 Nov 2020 17:24:53 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm/truncate: add parameter explanation for invalidate_mapping_pagevec
Date:   Tue, 17 Nov 2020 17:24:46 +0800
Message-Id: <1605605088-30668-1-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To fix a kernel-doc markups issue:
mm/truncate.c:646: warning: Function parameter or member 'mapping' not
described in 'invalidate_mapping_pagevec'
mm/truncate.c:646: warning: Function parameter or member 'start' not
described in 'invalidate_mapping_pagevec'
mm/truncate.c:646: warning: Function parameter or member 'end' not
described in 'invalidate_mapping_pagevec'
mm/truncate.c:646: warning: Function parameter or member 'nr_pagevec'
not described in 'invalidate_mapping_pagevec'

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 mm/truncate.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/mm/truncate.c b/mm/truncate.c
index 960edf5803ca..c196fad0bb5d 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -637,9 +637,15 @@ unsigned long invalidate_mapping_pages(struct address_space *mapping,
 EXPORT_SYMBOL(invalidate_mapping_pages);
 
 /**
- * This helper is similar with the above one, except that it accounts for pages
- * that are likely on a pagevec and count them in @nr_pagevec, which will used by
- * the caller.
+ * invalidate_mapping_pagevec - Invalidate all the unlocked pages of one inode
+ * @mapping: the address_space which holds the pages to invalidate
+ * @start: the offset 'from' which to invalidate
+ * @end: the offset 'to' which to invalidate (inclusive)
+ * @nr_pagevec: invalidate failed page number for caller
+ *
+ * This helper is similar with invalidate_mapping_pages, except that it accounts
+ * for pages that failed to invalidate on a pagevec and count them in
+ * @nr_pagevec, which will used by the caller.
  */
 void invalidate_mapping_pagevec(struct address_space *mapping,
 		pgoff_t start, pgoff_t end, unsigned long *nr_pagevec)
-- 
2.29.GIT


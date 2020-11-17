Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 389852B5A2A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 08:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgKQHPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 02:15:36 -0500
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:37208 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726266AbgKQHPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 02:15:35 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R321e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0UFfwQuB_1605597329;
Received: from aliy80.localdomain(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UFfwQuB_1605597329)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 17 Nov 2020 15:15:29 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] khugepaged: add couples parameter explanation for kernel-doc markup
Date:   Tue, 17 Nov 2020 15:15:25 +0800
Message-Id: <1605597325-25284-1-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missed parameter explanation for some kernel-doc warnings:
mm/khugepaged.c:102: warning: Function parameter or member
'nr_pte_mapped_thp' not described in 'mm_slot'
mm/khugepaged.c:102: warning: Function parameter or member
'pte_mapped_thp' not described in 'mm_slot'
mm/khugepaged.c:1424: warning: Function parameter or member 'mm' not
described in 'collapse_pte_mapped_thp'
mm/khugepaged.c:1424: warning: Function parameter or member 'addr' not
described in 'collapse_pte_mapped_thp'
mm/khugepaged.c:1626: warning: Function parameter or member 'mm' not
described in 'collapse_file'
mm/khugepaged.c:1626: warning: Function parameter or member 'file' not
described in 'collapse_file'
mm/khugepaged.c:1626: warning: Function parameter or member 'start' not
described in 'collapse_file'
mm/khugepaged.c:1626: warning: Function parameter or member 'hpage' not
described in 'collapse_file'
mm/khugepaged.c:1626: warning: Function parameter or member 'node' not
described in 'collapse_file'

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 mm/khugepaged.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 757292532767..8f7aee4efdc3 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -90,6 +90,8 @@ static struct kmem_cache *mm_slot_cache __read_mostly;
  * @hash: hash collision list
  * @mm_node: khugepaged scan list headed in khugepaged_scan.mm_head
  * @mm: the mm that this information is valid for
+ * @nr_pte_mapped_thp: number of pte mapped THP
+ * @pte_mapped_thp: address array corresponding pte mapped THP
  */
 struct mm_slot {
 	struct hlist_node hash;
@@ -1414,7 +1416,11 @@ static int khugepaged_add_pte_mapped_thp(struct mm_struct *mm,
 }
 
 /**
- * Try to collapse a pte-mapped THP for mm at address haddr.
+ * collapse_pte_mapped_thp - Try to collapse a pte-mapped THP for mm at
+ * address haddr.
+ *
+ * @mm: process address space where collapse happens
+ * @addr: THP collapse address
  *
  * This function checks whether all the PTEs in the PMD are pointing to the
  * right THP. If so, retract the page table so the THP can refault in with
@@ -1605,6 +1611,12 @@ static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
 /**
  * collapse_file - collapse filemap/tmpfs/shmem pages into huge one.
  *
+ * @mm: process address space where collapse happens
+ * @file: file that collapse on
+ * @start: collapse start address 
+ * @hpage: new allocated huge page for collapse
+ * @node: appointed node the new huge page allocate from
+ *
  * Basic scheme is simple, details are more complex:
  *  - allocate and lock a new huge page;
  *  - scan page cache replacing old pages with the new one
-- 
2.29.GIT


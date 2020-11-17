Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6A72B5BD6
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 10:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727362AbgKQJc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 04:32:58 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:57117 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725771AbgKQJc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 04:32:57 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R861e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0UFgqMD8_1605605573;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UFgqMD8_1605605573)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 17 Nov 2020 17:32:53 +0800
Subject: Re: [PATCH] khugepaged: add couples parameter explanation for
 kernel-doc markup
From:   Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1605597325-25284-1-git-send-email-alex.shi@linux.alibaba.com>
Message-ID: <b4036f71-3e74-492f-f177-71c46e520b6e@linux.alibaba.com>
Date:   Tue, 17 Nov 2020 17:31:31 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <1605597325-25284-1-git-send-email-alex.shi@linux.alibaba.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



ÔÚ 2020/11/17 ÏÂÎç3:15, Alex Shi Ð´µÀ:
>  /**
>   * collapse_file - collapse filemap/tmpfs/shmem pages into huge one.
>   *
> + * @mm: process address space where collapse happens
> + * @file: file that collapse on
> + * @start: collapse start address 

Hi Andrew,

A trailing whitespace at above line. very sorry for this, and it's the update:

From 190ff88583fa755ff791fc303e4b7ac75f6c96f7 Mon Sep 17 00:00:00 2001
From: Alex Shi <alex.shi@linux.alibaba.com>
Date: Tue, 17 Nov 2020 14:58:01 +0800
Subject: [PATCH] khugepaged: add couples parameter explanation for kernel-doc
 markup

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
index 757292532767..2cc78a51c398 100644
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


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2986026E916
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 00:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbgIQWrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 18:47:45 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:40701 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725900AbgIQWrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 18:47:42 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R501e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0U9Fg-Aw_1600382859;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0U9Fg-Aw_1600382859)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 18 Sep 2020 06:47:39 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Subject: [PATCH] mm/mmap: do the check on expand instead of on insert
Date:   Fri, 18 Sep 2020 06:47:22 +0800
Message-Id: <20200917224722.54428-1-richard.weiyang@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function __vma_adjust() checks on *insert* to decide whether it is
necessary to remove_next/adjust_next. While it is more reasonable to do
the check on *expand* instead of on *insert*, since this is only necessary
when *expand* is non-NULL.

There are several users for __vma_adjust, let's classify them based on
the value of *insert*/*expand*:

   caller                  |    insert/expand
   ------------------------+-----------------
   vma_merge               |    NULL/non-NULL
   __split_vma             |    non-NULL/NULL
   shift_arg_pages/mremap  |    NULL/NULL

To make this change, we need to make sure those non-NULL *insert* cases
wouldn't go into this if branch except vma_merge. There are two cases we
need to take care of: shift_arg_pages and mremap. Let's look at it one
by one.

For mremap, it is for sure we won't go into this if branch since
vma_adjust tries to expand the vma and the vma is expandable(the end
wouldn't interact with vma and next).

For shift_arg_pages, this case is a little tricky. Actually, for this
case, vma->vm_next should be NULL. Otherwise we would go into the branch
of "end < vma->vm_end" since we are shifting left. This means we would
expand the vma->vm_next by accident. Luckily, in current code, we won't
fall into this situation because shift_arg_pages only shift the stack
which is the highest one in virtual space.

To make the code more easy to understand(only vma_merge has a non-NULL
expand), and to make it handle the corner case(shift_arg_pages)
properly, let's do the check on *expand* instead of *insert*.

Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
---
 mm/mmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 829897646a9c..ca31b405fbfa 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -706,7 +706,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
 	long adjust_next = 0;
 	int remove_next = 0;
 
-	if (next && !insert) {
+	if (next && expand) {
 		struct vm_area_struct *exporter = NULL, *importer = NULL;
 
 		if (end >= next->vm_end) {
-- 
2.20.1 (Apple Git-117)


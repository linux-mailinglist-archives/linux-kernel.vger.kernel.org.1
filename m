Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9C724006B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Aug 2020 01:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbgHIXVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Aug 2020 19:21:05 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:42078 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726123AbgHIXVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Aug 2020 19:21:05 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R491e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0U5EGtLh_1597015262;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0U5EGtLh_1597015262)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 10 Aug 2020 07:21:03 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Subject: [PATCH 1/2] mm/mmap: rename __vma_unlink_common() to __vma_unlink()
Date:   Mon, 10 Aug 2020 07:20:56 +0800
Message-Id: <20200809232057.23477-1-richard.weiyang@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__vma_unlink_common() and __vma_unlink() are counterparts. Since there is
not function named __vma_unlink(), let's rename it to __vma_unlink() to
make the code more self-explain and easy for audience to understand.

Otherwise we may expect there are several variants of vma_unlink and
__vma_unlink_common() is used by them.

Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
---
 mm/mmap.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index dcdab2675a21..ec780925da94 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -677,7 +677,7 @@ static void __insert_vm_struct(struct mm_struct *mm, struct vm_area_struct *vma)
 	mm->map_count++;
 }
 
-static __always_inline void __vma_unlink_common(struct mm_struct *mm,
+static __always_inline void __vma_unlink(struct mm_struct *mm,
 						struct vm_area_struct *vma,
 						struct vm_area_struct *ignore)
 {
@@ -859,7 +859,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
 		 * us to remove next before dropping the locks.
 		 */
 		if (remove_next != 3)
-			__vma_unlink_common(mm, next, next);
+			__vma_unlink(mm, next, next);
 		else
 			/*
 			 * vma is not before next if they've been
@@ -870,7 +870,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
 			 * "next" (which is stored in post-swap()
 			 * "vma").
 			 */
-			__vma_unlink_common(mm, next, vma);
+			__vma_unlink(mm, next, vma);
 		if (file)
 			__remove_shared_vm_struct(next, file, mapping);
 	} else if (insert) {
-- 
2.20.1 (Apple Git-117)


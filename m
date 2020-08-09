Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5C124006C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Aug 2020 01:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbgHIXVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Aug 2020 19:21:09 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:50292 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726217AbgHIXVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Aug 2020 19:21:06 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01422;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0U5EYrKz_1597015263;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0U5EYrKz_1597015263)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 10 Aug 2020 07:21:03 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Subject: [PATCH 2/2] mm/mmap: leverage vma_rb_erase_ignore() to implement vma_rb_erase()
Date:   Mon, 10 Aug 2020 07:20:57 +0800
Message-Id: <20200809232057.23477-2-richard.weiyang@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20200809232057.23477-1-richard.weiyang@linux.alibaba.com>
References: <20200809232057.23477-1-richard.weiyang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These two functions share the same logic except ignore a different vma.

Let's reuse the code.

Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
---
 mm/mmap.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index ec780925da94..90b1298d4222 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -474,8 +474,12 @@ static __always_inline void vma_rb_erase_ignore(struct vm_area_struct *vma,
 {
 	/*
 	 * All rb_subtree_gap values must be consistent prior to erase,
-	 * with the possible exception of the "next" vma being erased if
-	 * next->vm_start was reduced.
+	 * with the possible exception of
+	 *
+	 * a. the "next" vma being erased if next->vm_start was reduced in
+	 *    __vma_adjust() -> __vma_unlink()
+	 * b. the vma being erased in detach_vmas_to_be_unmapped() ->
+	 *    vma_rb_erase()
 	 */
 	validate_mm_rb(root, ignore);
 
@@ -485,13 +489,7 @@ static __always_inline void vma_rb_erase_ignore(struct vm_area_struct *vma,
 static __always_inline void vma_rb_erase(struct vm_area_struct *vma,
 					 struct rb_root *root)
 {
-	/*
-	 * All rb_subtree_gap values must be consistent prior to erase,
-	 * with the possible exception of the vma being erased.
-	 */
-	validate_mm_rb(root, vma);
-
-	__vma_rb_erase(vma, root);
+	vma_rb_erase_ignore(vma, root, vma);
 }
 
 /*
-- 
2.20.1 (Apple Git-117)


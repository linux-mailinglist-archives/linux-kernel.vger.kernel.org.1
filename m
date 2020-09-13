Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF1C267FAF
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Sep 2020 15:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725959AbgIMNhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Sep 2020 09:37:36 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:53648 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725933AbgIMNgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 09:36:40 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0U8mqL2S_1600004197;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0U8mqL2S_1600004197)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 13 Sep 2020 21:36:37 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Subject: [PATCH 2/2] mm/mmap: check on file instead of the rb_root_cached of its address_space
Date:   Sun, 13 Sep 2020 21:36:31 +0800
Message-Id: <20200913133631.37781-2-richard.weiyang@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20200913133631.37781-1-richard.weiyang@linux.alibaba.com>
References: <20200913133631.37781-1-richard.weiyang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In __vma_adjust(), we do the check on *root* to decide whether to adjust
the address_space. While it seems to be more meaningful to do the check
on *file* itself. This means we are adjust some data because it is a
file backed vma.

Since we seems to assume the address_space is valid if it is a file
backed vma, let's just replace *root* with *file* here.

Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
---
 mm/mmap.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 30b155098606..829897646a9c 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -823,7 +823,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
 			anon_vma_interval_tree_pre_update_vma(next);
 	}
 
-	if (root) {
+	if (file) {
 		flush_dcache_mmap_lock(mapping);
 		vma_interval_tree_remove(vma, root);
 		if (adjust_next)
@@ -844,7 +844,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
 		next->vm_pgoff += adjust_next >> PAGE_SHIFT;
 	}
 
-	if (root) {
+	if (file) {
 		if (adjust_next)
 			vma_interval_tree_insert(next, root);
 		vma_interval_tree_insert(vma, root);
@@ -896,7 +896,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned long start,
 		anon_vma_unlock_write(anon_vma);
 	}
 
-	if (root) {
+	if (file) {
 		i_mmap_unlock_write(mapping);
 		uprobe_mmap(vma);
 
-- 
2.20.1 (Apple Git-117)


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A92EC2D842E
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Dec 2020 04:56:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438041AbgLLDxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 22:53:45 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:50688 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405302AbgLLDxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 22:53:34 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0UIIQwq4_1607745170;
Received: from IT-FVFX43SYHV2H.lan(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UIIQwq4_1607745170)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 12 Dec 2020 11:52:51 +0800
Subject: Re: [PATCH] mm/mmap: replace if (cond) BUG() with BUG_ON()
From:   Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1607743586-80303-1-git-send-email-alex.shi@linux.alibaba.com>
 <1607743586-80303-2-git-send-email-alex.shi@linux.alibaba.com>
Message-ID: <e50574aa-87b8-8ddf-2235-ef98e22bcb7d@linux.alibaba.com>
Date:   Sat, 12 Dec 2020 11:52:50 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.0; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <1607743586-80303-2-git-send-email-alex.shi@linux.alibaba.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


I'm very sorry, a typo here. the patch should be updated:

From ed4fa1c6d5bed5766c5f0c35af0c597855d7be06 Mon Sep 17 00:00:00 2001
From: Alex Shi <alex.shi@linux.alibaba.com>
Date: Fri, 11 Dec 2020 21:26:46 +0800
Subject: [PATCH] mm/mmap: replace if (cond) BUG() with BUG_ON()

coccinelle reports some warnings:
WARNING: Use BUG_ON instead of if condition followed by BUG.

It could be fixed by BUG_ON().

Reported-by: abaci@linux.alibaba.com
Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 mm/mmap.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 8144fc3c5a78..107fa91bb59f 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -712,9 +712,8 @@ static void __insert_vm_struct(struct mm_struct *mm, struct vm_area_struct *vma)
 	struct vm_area_struct *prev;
 	struct rb_node **rb_link, *rb_parent;
 
-	if (find_vma_links(mm, vma->vm_start, vma->vm_end,
-			   &prev, &rb_link, &rb_parent))
-		BUG();
+	BUG_ON(find_vma_links(mm, vma->vm_start, vma->vm_end,
+			   &prev, &rb_link, &rb_parent));
 	__vma_link(mm, vma, prev, rb_link, rb_parent);
 	mm->map_count++;
 }
@@ -3585,9 +3584,8 @@ static void vm_lock_anon_vma(struct mm_struct *mm, struct anon_vma *anon_vma)
 		 * can't change from under us thanks to the
 		 * anon_vma->root->rwsem.
 		 */
-		if (__test_and_set_bit(0, (unsigned long *)
-				       &anon_vma->root->rb_root.rb_root.rb_node))
-			BUG();
+		BUG_ON(__test_and_set_bit(0, (unsigned long *)
+			&anon_vma->root->rb_root.rb_root.rb_node));
 	}
 }
 
@@ -3603,8 +3601,7 @@ static void vm_lock_mapping(struct mm_struct *mm, struct address_space *mapping)
 		 * mm_all_locks_mutex, there may be other cpus
 		 * changing other bitflags in parallel to us.
 		 */
-		if (test_and_set_bit(AS_MM_ALL_LOCKS, &mapping->flags))
-			BUG();
+		BUG_ON(test_and_set_bit(AS_MM_ALL_LOCKS, &mapping->flags));
 		down_write_nest_lock(&mapping->i_mmap_rwsem, &mm->mmap_lock);
 	}
 }
@@ -3701,9 +3698,8 @@ static void vm_unlock_anon_vma(struct anon_vma *anon_vma)
 		 * can't change from under us until we release the
 		 * anon_vma->root->rwsem.
 		 */
-		if (!__test_and_clear_bit(0, (unsigned long *)
-					  &anon_vma->root->rb_root.rb_root.rb_node))
-			BUG();
+		BUG_ON(!__test_and_clear_bit(0, (unsigned long *)
+				&anon_vma->root->rb_root.rb_root.rb_node));
 		anon_vma_unlock_write(anon_vma);
 	}
 }
@@ -3716,9 +3712,7 @@ static void vm_unlock_mapping(struct address_space *mapping)
 		 * because we hold the mm_all_locks_mutex.
 		 */
 		i_mmap_unlock_write(mapping);
-		if (!test_and_clear_bit(AS_MM_ALL_LOCKS,
-					&mapping->flags))
-			BUG();
+		BUG_ON(!test_and_clear_bit(AS_MM_ALL_LOCKS, &mapping->flags));
 	}
 }
 
-- 
2.29.GIT


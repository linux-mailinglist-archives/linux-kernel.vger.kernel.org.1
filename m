Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8A9E2F3532
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 17:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392700AbhALQOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 11:14:19 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:41458 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392677AbhALQOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 11:14:18 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10CG9Jf5181290;
        Tue, 12 Jan 2021 16:13:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=Uq1JZwlc7rQdJHDzbMM8eEoxBWrKCftQkfYhyUm6RdQ=;
 b=pJgS2zsW3b3GIOHbVzd+vHv/SIO1h5xI3yq2zpy/Z02f+K2fmMkdC/RXj95hzcb9t6VZ
 klQJtjkk8bxZ+QYS1Or+DtvKL9thadmB0Ld5V45QPCggsF97bKG/T5b6lCHTiCu5H85Y
 0O06yfEJU1E7SoOSOUQE/FJNjesqDU5XD4bD8nk+Bkyl4X7FMiW3zP3ShvsWYfd9zx1l
 BbT8oRg83NMFlhP1GRnV793/8yH9Pox1a/zbklqOYfWRstsIwlqVx7S8lJRVeXftkUC3
 dxRenM8ASQs0XGoaH8jC4YasS8Jxm0ykukJlVqlvpscNw+3gLevEmGTgNNEzul7AvhZx 3Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 360kvjy1je-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jan 2021 16:13:13 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10CGA1bY094411;
        Tue, 12 Jan 2021 16:13:12 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 360key11vu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jan 2021 16:13:12 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 10CGDBju029893;
        Tue, 12 Jan 2021 16:13:11 GMT
Received: from revolver.jebus.ca (/23.233.25.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 Jan 2021 08:13:10 -0800
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@google.com>, Song Liu <songliubraving@fb.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jerome Glisse <jglisse@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rik van Riel <riel@surriel.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v2 10/70] mm/mmap: Change unmapped_area and unmapped_area_topdown to use maple tree
Date:   Tue, 12 Jan 2021 11:11:40 -0500
Message-Id: <20210112161240.2024684-11-Liam.Howlett@Oracle.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210112161240.2024684-1-Liam.Howlett@Oracle.com>
References: <20210112161240.2024684-1-Liam.Howlett@Oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9862 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 adultscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101120092
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9862 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 impostorscore=0 spamscore=0 mlxscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101120092
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new maple tree data structure to find an unmapped area.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mmap.c | 249 ++++++------------------------------------------------
 1 file changed, 27 insertions(+), 222 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index f123f9c97dfe8..3b3084ee309b7 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2040,260 +2040,65 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	return error;
 }
 
+/* unmapped_area() Find an area between the low_limit and the high_limit with
+ * the correct alignment and offset, all from @info. Note: current->mm is used
+ * for the search.
+ *
+ * @info: The unmapped area information including the range (low_limit -
+ * hight_limit), the alignment offset and mask.
+ *
+ * Return: A memory address or -ENOMEM.
+ */
 static unsigned long unmapped_area(struct vm_unmapped_area_info *info)
 {
-	/*
-	 * We implement the search by looking for an rbtree node that
-	 * immediately follows a suitable gap. That is,
-	 * - gap_start = vma->vm_prev->vm_end <= info->high_limit - length;
-	 * - gap_end   = vma->vm_start        >= info->low_limit  + length;
-	 * - gap_end - gap_start >= length
-	 */
+	unsigned long length, gap;
 
-	struct mm_struct *mm = current->mm;
-	struct vm_area_struct *vma;
-	unsigned long length, low_limit, high_limit, gap_start, gap_end;
-	unsigned long gap;
+	MA_STATE(mas, &current->mm->mm_mt, 0, 0);
+	validate_mm(current->mm);
 
-	MA_STATE(mas, &mm->mm_mt, 0, 0);
 	/* Adjust search length to account for worst case alignment overhead */
 	length = info->length + info->align_mask;
 	if (length < info->length)
 		return -ENOMEM;
 
-
-	/* Maple tree is self contained. */
-	rcu_read_lock();
 	if (mas_get_empty_area(&mas, info->low_limit, info->high_limit - 1,
 				  length)) {
 		rcu_read_unlock();
 		return -ENOMEM;
 	}
-	rcu_read_unlock();
 	gap = mas.index;
 	gap += (info->align_offset - gap) & info->align_mask;
-
-	/* Adjust search limits by the desired length */
-	if (info->high_limit < length)
-		return -ENOMEM;
-	high_limit = info->high_limit - length;
-
-	if (info->low_limit > high_limit)
-		return -ENOMEM;
-	low_limit = info->low_limit + length;
-
-	/* Check if rbtree root looks promising */
-	if (RB_EMPTY_ROOT(&mm->mm_rb))
-		goto check_highest;
-	vma = rb_entry(mm->mm_rb.rb_node, struct vm_area_struct, vm_rb);
-	if (vma->rb_subtree_gap < length)
-		goto check_highest;
-
-	while (true) {
-		/* Visit left subtree if it looks promising */
-		gap_end = vm_start_gap(vma);
-		if (gap_end >= low_limit && vma->vm_rb.rb_left) {
-			struct vm_area_struct *left =
-				rb_entry(vma->vm_rb.rb_left,
-					 struct vm_area_struct, vm_rb);
-			if (left->rb_subtree_gap >= length) {
-				vma = left;
-				continue;
-			}
-		}
-
-		gap_start = vma->vm_prev ? vm_end_gap(vma->vm_prev) : 0;
-check_current:
-		/* Check if current node has a suitable gap */
-		if (gap_start > high_limit)
-			return -ENOMEM;
-		if (gap_end >= low_limit &&
-		    gap_end > gap_start && gap_end - gap_start >= length)
-			goto found;
-
-		/* Visit right subtree if it looks promising */
-		if (vma->vm_rb.rb_right) {
-			struct vm_area_struct *right =
-				rb_entry(vma->vm_rb.rb_right,
-					 struct vm_area_struct, vm_rb);
-			if (right->rb_subtree_gap >= length) {
-				vma = right;
-				continue;
-			}
-		}
-
-		/* Go back up the rbtree to find next candidate node */
-		while (true) {
-			struct rb_node *prev = &vma->vm_rb;
-			if (!rb_parent(prev))
-				goto check_highest;
-			vma = rb_entry(rb_parent(prev),
-				       struct vm_area_struct, vm_rb);
-			if (prev == vma->vm_rb.rb_left) {
-				gap_start = vm_end_gap(vma->vm_prev);
-				gap_end = vm_start_gap(vma);
-				goto check_current;
-			}
-		}
-	}
-
-check_highest:
-	/* Check highest gap, which does not precede any rbtree node */
-	gap_start = mm->highest_vm_end;
-	gap_end = ULONG_MAX;  /* Only for VM_BUG_ON below */
-	if (gap_start > high_limit)
-		return -ENOMEM;
-
-found:
-	/* We found a suitable gap. Clip it with the original low_limit. */
-	if (gap_start < info->low_limit)
-		gap_start = info->low_limit;
-
-	/* Adjust gap address to the desired alignment */
-	gap_start += (info->align_offset - gap_start) & info->align_mask;
-
-	VM_BUG_ON(gap_start + info->length > info->high_limit);
-	VM_BUG_ON(gap_start + info->length > gap_end);
-
-	VM_BUG_ON(gap != gap_start);
-	return gap_start;
+	return gap;
 }
 
+/* unmapped_area() Find an area between the low_limit and the high_limit with
+ * the correct alignment and offset at the highest available address, all from
+ * @info. Note: current->mm is used for the search.
+ *
+ * @info: The unmapped area information including the range (low_limit -
+ * hight_limit), the alignment offset and mask.
+ *
+ * Return: A memory address or -ENOMEM.
+ */
 static unsigned long unmapped_area_topdown(struct vm_unmapped_area_info *info)
 {
-	struct mm_struct *mm = current->mm;
-	struct vm_area_struct *vma = NULL;
-	unsigned long length, low_limit, high_limit, gap_start, gap_end;
-	unsigned long gap;
+	unsigned long length, gap;
 
-	MA_STATE(mas, &mm->mm_mt, 0, 0);
-	validate_mm_mt(mm);
+	MA_STATE(mas, &current->mm->mm_mt, 0, 0);
+	validate_mm_mt(current->mm);
 	/* Adjust search length to account for worst case alignment overhead */
 	length = info->length + info->align_mask;
 	if (length < info->length)
 		return -ENOMEM;
 
-	rcu_read_lock();
-	if (mas_get_empty_area_rev(&mas, info->low_limit, info->high_limit,
+	if (mas_get_empty_area_rev(&mas, info->low_limit, info->high_limit - 1,
 				length)) {
 		rcu_read_unlock();
 		return -ENOMEM;
 	}
-	rcu_read_unlock();
 	gap = (mas.index + info->align_mask) & ~info->align_mask;
 	gap -= info->align_offset & info->align_mask;
-	/*
-	 * Adjust search limits by the desired length.
-	 * See implementation comment at top of unmapped_area().
-	 */
-	gap_end = info->high_limit;
-	if (gap_end < length)
-		return -ENOMEM;
-	high_limit = gap_end - length;
-
-	if (info->low_limit > high_limit)
-		return -ENOMEM;
-	low_limit = info->low_limit + length;
-
-	/* Check highest gap, which does not precede any rbtree node */
-	gap_start = mm->highest_vm_end;
-	if (gap_start <= high_limit)
-		goto found_highest;
-
-	/* Check if rbtree root looks promising */
-	if (RB_EMPTY_ROOT(&mm->mm_rb))
-		return -ENOMEM;
-	vma = rb_entry(mm->mm_rb.rb_node, struct vm_area_struct, vm_rb);
-	if (vma->rb_subtree_gap < length)
-		return -ENOMEM;
-
-	while (true) {
-		/* Visit right subtree if it looks promising */
-		gap_start = vma->vm_prev ? vm_end_gap(vma->vm_prev) : 0;
-		if (gap_start <= high_limit && vma->vm_rb.rb_right) {
-			struct vm_area_struct *right =
-				rb_entry(vma->vm_rb.rb_right,
-					 struct vm_area_struct, vm_rb);
-			if (right->rb_subtree_gap >= length) {
-				vma = right;
-				continue;
-			}
-		}
-
-check_current:
-		/* Check if current node has a suitable gap */
-		gap_end = vm_start_gap(vma);
-		if (gap_end < low_limit)
-			return -ENOMEM;
-		if (gap_start <= high_limit &&
-		    gap_end > gap_start && gap_end - gap_start >= length)
-			goto found;
-
-		/* Visit left subtree if it looks promising */
-		if (vma->vm_rb.rb_left) {
-			struct vm_area_struct *left =
-				rb_entry(vma->vm_rb.rb_left,
-					 struct vm_area_struct, vm_rb);
-			if (left->rb_subtree_gap >= length) {
-				vma = left;
-				continue;
-			}
-		}
-
-		/* Go back up the rbtree to find next candidate node */
-		while (true) {
-			struct rb_node *prev = &vma->vm_rb;
-			if (!rb_parent(prev))
-				return -ENOMEM;
-			vma = rb_entry(rb_parent(prev),
-				       struct vm_area_struct, vm_rb);
-			if (prev == vma->vm_rb.rb_right) {
-				gap_start = vma->vm_prev ?
-					vm_end_gap(vma->vm_prev) : 0;
-				goto check_current;
-			}
-		}
-	}
-
-found:
-	/* We found a suitable gap. Clip it with the original high_limit. */
-	if (gap_end > info->high_limit)
-		gap_end = info->high_limit;
-
-found_highest:
-	/* Compute highest gap address at the desired alignment */
-	gap_end -= info->length;
-	gap_end -= (gap_end - info->align_offset) & info->align_mask;
-
-	VM_BUG_ON(gap_end < info->low_limit);
-	VM_BUG_ON(gap_end < gap_start);
-
-	if (gap != gap_end) {
-		pr_err("%s: %px Gap was found: mt %lu gap_end %lu\n", __func__,
-				mm, gap, gap_end);
-		pr_err("window was %lu - %lu size %lu\n", info->high_limit,
-				info->low_limit, length);
-		pr_err("mas.min %lu max %lu mas.last %lu\n", mas.min, mas.max,
-				mas.last);
-		pr_err("mas.index %lu align mask %lu offset %lu\n", mas.index,
-				info->align_mask, info->align_offset);
-		pr_err("rb_find_vma find on %lu => %px (%px)\n", mas.index,
-				find_vma(mm, mas.index), vma);
-#if defined(CONFIG_DEBUG_MAPLE_TREE)
-		mt_dump(&mm->mm_mt);
-#endif
-		{
-			struct vm_area_struct *dv = mm->mmap;
-
-			while (dv) {
-				printk("vma %px %lu-%lu\n", dv, dv->vm_start, dv->vm_end);
-				dv = dv->vm_next;
-			}
-		}
-		VM_BUG_ON(gap != gap_end);
-	}
-
-	return gap_end;
+	return gap;
 }
 
 /*
-- 
2.28.0


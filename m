Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8E892F353C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 17:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392992AbhALQO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 11:14:57 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:42236 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392971AbhALQOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 11:14:54 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10CG98XI181162;
        Tue, 12 Jan 2021 16:13:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=431qw+udZbWiim1w41TD8ZNL/UpOh0d882GN2WnIwlw=;
 b=ybhVrGQnQx1MGPdC7IP9wKoDCSxZJdhdhVFazsQV1psbly2vKj9iWiJvkreiDWngMo54
 86nyBRmPGUc3SM3GQr1mmT0rNqvg4d4WkP1JBZMnwOWkCH4gjmLW6zX7PYQPoc5JEvQU
 snhXnv0cNeDVe2fTvIJJF3ZSZOeUYSsPFygJkdqzN9l5KO+fmvQXatDynM7iDpYV4EET
 EDPiwx69fV7WO9JQuKLizlgLDsQ0zRW0Jys5PQ0Ji+tCENsISDg5p6TP0yK8hULNo4pS
 +HDn5Oh3L+GD6L9q+xI+1cmARa556WgOh2QkTtv/hasSQdDUDaD/q1yVppyjLY7zjTsG QQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 360kvjy1ka-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jan 2021 16:13:29 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10CGAabK100386;
        Tue, 12 Jan 2021 16:13:29 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 360keh7j9x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jan 2021 16:13:28 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 10CGDRqQ017697;
        Tue, 12 Jan 2021 16:13:27 GMT
Received: from revolver.jebus.ca (/23.233.25.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 Jan 2021 08:13:27 -0800
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
Subject: [PATCH v2 20/70] mm/mmap: Change __do_munmap() to avoid unnecessary lookups.
Date:   Tue, 12 Jan 2021 11:11:50 -0500
Message-Id: <20210112161240.2024684-21-Liam.Howlett@Oracle.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210112161240.2024684-1-Liam.Howlett@Oracle.com>
References: <20210112161240.2024684-1-Liam.Howlett@Oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9862 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 spamscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
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

As there is no longer a vmacache, find_vma() is more expensive and so
avoid doing them

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mmap.c | 115 ++++++++++++++++++++++++++++--------------------------
 1 file changed, 59 insertions(+), 56 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index cc9d0c524d575..af426972c9dd2 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2585,44 +2585,6 @@ static void unmap_region(struct mm_struct *mm,
 	tlb_finish_mmu(&tlb, start, end);
 }
 
-/*
- * Create a list of vma's touched by the unmap, removing them from the mm's
- * vma list as we go..
- */
-static bool
-detach_vmas_to_be_unmapped(struct mm_struct *mm, struct vm_area_struct *vma,
-	struct vm_area_struct *prev, unsigned long end)
-{
-	struct vm_area_struct **insertion_point;
-	struct vm_area_struct *tail_vma = NULL;
-
-	insertion_point = (prev ? &prev->vm_next : &mm->mmap);
-	vma->vm_prev = NULL;
-	vma_mt_szero(mm, vma->vm_start, end);
-	do {
-		mm->map_count--;
-		tail_vma = vma;
-		vma = vma->vm_next;
-	} while (vma && vma->vm_start < end);
-	*insertion_point = vma;
-	if (vma)
-		vma->vm_prev = prev;
-	else
-		mm->highest_vm_end = prev ? vm_end_gap(prev) : 0;
-	tail_vma->vm_next = NULL;
-
-	/*
-	 * Do not downgrade mmap_lock if we are next to VM_GROWSDOWN or
-	 * VM_GROWSUP VMA. Such VMAs can change their size under
-	 * down_read(mmap_lock) and collide with the VMA we are about to unmap.
-	 */
-	if (vma && (vma->vm_flags & VM_GROWSDOWN))
-		return false;
-	if (prev && (prev->vm_flags & VM_GROWSUP))
-		return false;
-	return true;
-}
-
 /*
  * __split_vma() bypasses sysctl_max_map_count checking.  We use this where it
  * has already been checked or doesn't make sense to fail.
@@ -2702,12 +2664,16 @@ int split_vma(struct mm_struct *mm, struct vm_area_struct *vma,
 	return __split_vma(mm, vma, addr, new_below);
 }
 
-static inline void unlock_range(struct vm_area_struct *start, unsigned long limit)
+static inline int unlock_range(struct vm_area_struct *start,
+			       struct vm_area_struct **tail, unsigned long limit)
 {
 	struct mm_struct *mm = start->vm_mm;
 	struct vm_area_struct *tmp = start;
+	int count = 0;
 
 	while (tmp && tmp->vm_start < limit) {
+		*tail = tmp;
+		count++;
 		if (tmp->vm_flags & VM_LOCKED) {
 			mm->locked_vm -= vma_pages(tmp);
 			munlock_vma_pages_all(tmp);
@@ -2715,6 +2681,8 @@ static inline void unlock_range(struct vm_area_struct *start, unsigned long limi
 
 		tmp = tmp->vm_next;
 	}
+
+	return count;
 }
 /* Munmap is split into 2 main parts -- this part which finds
  * what needs doing, and the areas themselves, which do the
@@ -2726,24 +2694,24 @@ int __do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
 {
 	unsigned long end;
 	struct vm_area_struct *vma, *prev, *last;
+	MA_STATE(mas, &mm->mm_mt, start, start);
 
 	if ((offset_in_page(start)) || start > TASK_SIZE || len > TASK_SIZE-start)
 		return -EINVAL;
 
-	len = PAGE_ALIGN(len);
-	end = start + len;
-	if (len == 0)
+	end = start + PAGE_ALIGN(len);
+	if (end == start)
 		return -EINVAL;
 
 	 /* arch_unmap() might do unmaps itself.  */
 	arch_unmap(mm, start, end);
 
 	/* Find the first overlapping VMA */
-	vma = find_vma_intersection(mm, start, end);
+	vma = mas_find(&mas, end - 1);
 	if (!vma)
 		return 0;
 
-	prev = vma->vm_prev;
+	mas.last = end - 1;
 	/* we have start < vma->vm_end  */
 
 	/*
@@ -2767,16 +2735,27 @@ int __do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
 		if (error)
 			return error;
 		prev = vma;
+		vma = vma_next(mm, prev);
+		mas.index = start;
+		mas_reset(&mas);
+	} else {
+		prev = vma->vm_prev;
 	}
 
+	if (vma->vm_end >= end)
+		last = vma;
+	else
+		last = find_vma_intersection(mm, end - 1, end);
+
 	/* Does it split the last one? */
-	last = find_vma(mm, end);
-	if (last && end > last->vm_start) {
+	if (last && end < last->vm_end) {
 		int error = __split_vma(mm, last, end, 1);
 		if (error)
 			return error;
+		vma = vma_next(mm, prev);
+		mas_reset(&mas);
 	}
-	vma = vma_next(mm, prev);
+
 
 	if (unlikely(uf)) {
 		/*
@@ -2789,22 +2768,46 @@ int __do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
 		 * failure that it's not worth optimizing it for.
 		 */
 		int error = userfaultfd_unmap_prep(vma, start, end, uf);
+
 		if (error)
 			return error;
 	}
 
 	/*
-	 * unlock any mlock()ed ranges before detaching vmas
+	 * unlock any mlock()ed ranges before detaching vmas, count the number
+	 * of VMAs to be dropped, and return the tail entry of the affected
+	 * area.
 	 */
-	if (mm->locked_vm)
-		unlock_range(vma, end);
+	mm->map_count -= unlock_range(vma, &last, end);
+	/* Drop removed area from the tree */
+	mas_store_gfp(&mas, NULL, GFP_KERNEL);
+
+	/* Detach vmas from the MM linked list */
+	vma->vm_prev = NULL;
+	if (prev)
+		prev->vm_next = last->vm_next;
+	else
+		mm->mmap = last->vm_next;
 
-	/* Detach vmas from the MM linked list and remove from the mm tree*/
-	if (!detach_vmas_to_be_unmapped(mm, vma, prev, end))
-		downgrade = false;
+	if (last->vm_next) {
+		last->vm_next->vm_prev = prev;
+		last->vm_next = NULL;
+	} else
+		mm->highest_vm_end = prev ? vm_end_gap(prev) : 0;
 
-	if (downgrade)
-		mmap_write_downgrade(mm);
+	/*
+	 * Do not downgrade mmap_lock if we are next to VM_GROWSDOWN or
+	 * VM_GROWSUP VMA. Such VMAs can change their size under
+	 * down_read(mmap_lock) and collide with the VMA we are about to unmap.
+	 */
+	if (downgrade) {
+		if (last && (last->vm_flags & VM_GROWSDOWN))
+			downgrade = false;
+		else if (prev && (prev->vm_flags & VM_GROWSUP))
+			downgrade = false;
+		else
+			mmap_write_downgrade(mm);
+	}
 
 	unmap_region(mm, vma, prev, start, end);
 
@@ -3227,7 +3230,7 @@ void exit_mmap(struct mm_struct *mm)
 	}
 
 	if (mm->locked_vm)
-		unlock_range(mm->mmap, ULONG_MAX);
+		unlock_range(mm->mmap, &vma, ULONG_MAX);
 
 	arch_exit_mmap(mm);
 
-- 
2.28.0


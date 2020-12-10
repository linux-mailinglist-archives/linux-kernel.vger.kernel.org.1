Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 824332D64AA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 19:17:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403950AbgLJRHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 12:07:13 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:48364 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403891AbgLJRGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 12:06:01 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BAGnVGT139706;
        Thu, 10 Dec 2020 17:05:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=mfbLmmI4/cWbonu3HCrFyOIM4ogRhY+oLXFGd2Tgdz0=;
 b=TGdruVY9uSnoSMb6HwLNH7/uk2WrLkDyyqbmF6QKdZZKv9oqiAYbIPxeU2kapFUXmfpj
 G5Mj6Vbr+6EcitczfxzUiKlYa8YXSgv2AO2wUugGk2rDQ2x/bV8NofW7H+hjdVfLU4A9
 Iqb/qImIDka0zfwhKrjdaa9FfUI31GSCyNXzS4Emb1Ig4sxGN8/FwWif3/1oEW/XlzF2
 nDrn4zin6K5DEbPLl2yFyUgsVeKYfR85m5b7OByY3QE6ODDid9CHbH6ubXBov4V5wbz/
 VDmA5vTg0fLDwMMMTdoMmoiBq/tYfAUchY1m1DI0EXo3l66I0wUB7AQSdTS58fcReDea 3Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 357yqc6m1a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 10 Dec 2020 17:05:00 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BAGw0hJ033126;
        Thu, 10 Dec 2020 17:05:00 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 358m52gbnf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Dec 2020 17:05:00 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0BAH4wDv009083;
        Thu, 10 Dec 2020 17:04:58 GMT
Received: from revolver.jebus.ca (/23.233.25.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 10 Dec 2020 09:04:58 -0800
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
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH 21/28] mm/mmap: Change __do_munmap() to use a ma_state
Date:   Thu, 10 Dec 2020 12:03:55 -0500
Message-Id: <20201210170402.3468568-22-Liam.Howlett@Oracle.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201210170402.3468568-1-Liam.Howlett@Oracle.com>
References: <20201210170402.3468568-1-Liam.Howlett@Oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9830 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 phishscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012100106
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9830 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 clxscore=1015 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0
 spamscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012100106
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mmap.c | 99 ++++++++++++++++++++++++++-----------------------------
 1 file changed, 47 insertions(+), 52 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 15616f105d051..34f337a5fc31d 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2562,44 +2562,6 @@ static void unmap_region(struct mm_struct *mm,
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
@@ -2679,12 +2641,16 @@ int split_vma(struct mm_struct *mm, struct vm_area_struct *vma,
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
@@ -2692,6 +2658,8 @@ static inline void unlock_range(struct vm_area_struct *start, unsigned long limi
 
 		tmp = tmp->vm_next;
 	}
+
+	return count;
 }
 /* Munmap is split into 2 main parts -- this part which finds
  * what needs doing, and the areas themselves, which do the
@@ -2703,23 +2671,24 @@ int __do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
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
 
+	mas.last = end - 1;
 	/* we have start < vma->vm_end  */
 
 	/*
@@ -2744,6 +2713,8 @@ int __do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
 			return error;
 		prev = vma;
 		vma = vma_next(mm, prev);
+		mas.index = start;
+		mas_reset(&mas);
 	} else {
 		prev = vma->vm_prev;
 	}
@@ -2759,6 +2730,7 @@ int __do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
 		if (error)
 			return error;
 		vma = vma_next(mm, prev);
+		mas_reset(&mas);
 	}
 
 
@@ -2779,17 +2751,40 @@ int __do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
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
 
-	/* Detach vmas from the MM linked list and remove from the mm tree*/
-	if (!detach_vmas_to_be_unmapped(mm, vma, prev, end))
-		downgrade = false;
+	/* Detach vmas from the MM linked list */
+	vma->vm_prev = NULL;
+	if (prev)
+		prev->vm_next = last->vm_next;
+	else
+		mm->mmap = last->vm_next;
 
-	if (downgrade)
-		mmap_write_downgrade(mm);
+	if (last->vm_next) {
+		last->vm_next->vm_prev = prev;
+		last->vm_next = NULL;
+	} else
+		mm->highest_vm_end = prev ? vm_end_gap(prev) : 0;
+
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
 
@@ -3212,7 +3207,7 @@ void exit_mmap(struct mm_struct *mm)
 	}
 
 	if (mm->locked_vm)
-		unlock_range(mm->mmap, ULONG_MAX);
+		unlock_range(mm->mmap, &vma, ULONG_MAX);
 
 	arch_exit_mmap(mm);
 
-- 
2.28.0


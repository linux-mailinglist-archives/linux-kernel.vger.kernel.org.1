Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E67C22F3577
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 17:21:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406524AbhALQSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 11:18:21 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:46694 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406368AbhALQR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 11:17:27 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10CGFABI007219;
        Tue, 12 Jan 2021 16:16:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=ZKsIcuCMcYq87BtH3ANq4oPVELPvkyXgJ+buGm3Kj9E=;
 b=wxfjGdJZpk4UzN84BAAqk/zOIkNsQWzblyFkOsKYP//lbuptIeg5+3Bx2a4sAFEfaLaR
 iMQDwRSzy/zexf1uS7AR7lv4q+7nE+TbSQIQG/rytiFwQuoPknHtgTX5sAZ6jVxjj0so
 RUzhzKCh4i0OnAhegGZLge8Yg688abgJDujLC0sD3Iv7Ld1HUstHimeNYYKwzzZt+w5N
 OXNAA+Jr0xzmSO9A1eIiK1YA4OkG16OUc1p2a1h7F3WihTWBaRgnbICoeLxP3uLoI+ko
 uOeCuzBuE5TqmlRHG8DRuMFApuKElcF6rNl+mo8rZ9kHh39wWTTbK69RGauDqk2QRKOc ig== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 360kvjy25y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jan 2021 16:16:28 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10CGAaKK100407;
        Tue, 12 Jan 2021 16:14:27 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 360keh7knh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jan 2021 16:14:27 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 10CGEQKM030610;
        Tue, 12 Jan 2021 16:14:26 GMT
Received: from revolver.jebus.ca (/23.233.25.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 Jan 2021 08:14:26 -0800
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
Subject: [PATCH v2 58/70] mm/mempolicy: Use maple tree iterators instead of vma linked list
Date:   Tue, 12 Jan 2021 11:12:28 -0500
Message-Id: <20210112161240.2024684-59-Liam.Howlett@Oracle.com>
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
 engine=8.12.0-2009150000 definitions=main-2101120093
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mempolicy.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 3ca4898f3f249..e0b8e658f18eb 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -404,9 +404,10 @@ void mpol_rebind_task(struct task_struct *tsk, const nodemask_t *new)
 void mpol_rebind_mm(struct mm_struct *mm, nodemask_t *new)
 {
 	struct vm_area_struct *vma;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
 
 	mmap_write_lock(mm);
-	for (vma = mm->mmap; vma; vma = vma->vm_next)
+	mas_for_each(&mas, vma, ULONG_MAX)
 		mpol_rebind_policy(vma->vm_policy, new);
 	mmap_write_unlock(mm);
 }
@@ -671,7 +672,7 @@ static unsigned long change_prot_numa(struct vm_area_struct *vma,
 static int queue_pages_test_walk(unsigned long start, unsigned long end,
 				struct mm_walk *walk)
 {
-	struct vm_area_struct *vma = walk->vma;
+	struct vm_area_struct *next, *vma = walk->vma;
 	struct queue_pages *qp = walk->private;
 	unsigned long endvma = vma->vm_end;
 	unsigned long flags = qp->flags;
@@ -686,9 +687,10 @@ static int queue_pages_test_walk(unsigned long start, unsigned long end,
 			/* hole at head side of range */
 			return -EFAULT;
 	}
+	next = vma_next(vma->vm_mm, vma);
 	if (!(flags & MPOL_MF_DISCONTIG_OK) &&
 		((vma->vm_end < qp->end) &&
-		(!vma->vm_next || vma->vm_end < vma->vm_next->vm_start)))
+		(!next || vma->vm_end < next->vm_start)))
 		/* hole at middle or tail of range */
 		return -EFAULT;
 
@@ -809,21 +811,22 @@ static int mbind_range(struct mm_struct *mm, unsigned long start,
 	pgoff_t pgoff;
 	unsigned long vmstart;
 	unsigned long vmend;
+	MA_STATE(mas, &mm->mm_mt, start, start);
 
-	vma = find_vma(mm, start);
+	vma = mas_find(&mas, ULONG_MAX);
 	VM_BUG_ON(!vma);
 
-	prev = vma->vm_prev;
+	prev = vma_mas_prev(&mas);
 	if (start > vma->vm_start)
 		prev = vma;
 
-	for (; vma && vma->vm_start < end; prev = vma, vma = next) {
-		next = vma->vm_next;
+	mas_for_each(&mas, vma, end - 1) {
+		next = vma_next(mm, vma);
 		vmstart = max(start, vma->vm_start);
 		vmend   = min(end, vma->vm_end);
 
 		if (mpol_equal(vma_policy(vma), new_pol))
-			continue;
+			goto next;
 
 		pgoff = vma->vm_pgoff +
 			((vmstart - vma->vm_start) >> PAGE_SHIFT);
@@ -832,7 +835,7 @@ static int mbind_range(struct mm_struct *mm, unsigned long start,
 				 new_pol, vma->vm_userfaultfd_ctx);
 		if (prev) {
 			vma = prev;
-			next = vma->vm_next;
+			next = vma_next(mm, vma);
 			if (mpol_equal(vma_policy(vma), new_pol))
 				continue;
 			/* vma_merge() joined vma && vma->next, case 8 */
@@ -847,11 +850,14 @@ static int mbind_range(struct mm_struct *mm, unsigned long start,
 			err = split_vma(vma->vm_mm, vma, vmend, 0);
 			if (err)
 				goto out;
+			mas_pause(&mas);
 		}
  replace:
 		err = vma_replace_policy(vma, new_pol);
 		if (err)
 			goto out;
+next:
+		prev = vma;
 	}
 
  out:
@@ -1072,6 +1078,7 @@ static int migrate_to_node(struct mm_struct *mm, int source, int dest,
 			   int flags)
 {
 	nodemask_t nmask;
+	struct vm_area_struct *vma;
 	LIST_HEAD(pagelist);
 	int err = 0;
 	struct migration_target_control mtc = {
@@ -1087,8 +1094,9 @@ static int migrate_to_node(struct mm_struct *mm, int source, int dest,
 	 * need migration.  Between passing in the full user address
 	 * space range and MPOL_MF_DISCONTIG_OK, this call can not fail.
 	 */
+	vma = find_vma(mm, 0);
 	VM_BUG_ON(!(flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)));
-	queue_pages_range(mm, mm->mmap->vm_start, mm->task_size, &nmask,
+	queue_pages_range(mm, vma->vm_start, mm->task_size, &nmask,
 			flags | MPOL_MF_DISCONTIG_OK, &pagelist);
 
 	if (!list_empty(&pagelist)) {
@@ -1217,13 +1225,12 @@ static struct page *new_page(struct page *page, unsigned long start)
 {
 	struct vm_area_struct *vma;
 	unsigned long address;
+	MA_STATE(mas, &current->mm->mm_mt, start, start);
 
-	vma = find_vma(current->mm, start);
-	while (vma) {
+	mas_for_each(&mas, vma, ULONG_MAX) {
 		address = page_address_in_vma(page, vma);
 		if (address != -EFAULT)
 			break;
-		vma = vma->vm_next;
 	}
 
 	if (PageHuge(page)) {
-- 
2.28.0


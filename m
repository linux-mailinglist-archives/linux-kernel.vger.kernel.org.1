Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D17FE2F3560
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 17:21:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406205AbhALQQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 11:16:40 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:56692 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406165AbhALQQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 11:16:36 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10CGFWGp107453;
        Tue, 12 Jan 2021 16:15:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=8yKu1sYv1pdl7SnJ+zE3wb3ksswtV7ERGy5zCO1jLH0=;
 b=G+sKjBL4Vo8Zvbo8c6trzR6fzeofzui+yl2jXF9l2zv6tPQ+DCR1822/ZxB+tlJruQQm
 E77r2DeSF2JxTyLk+NSMSmEQMQrD6MRRA7DDbXuF64cMNHq9Zk44fs0boEWvFFjiILyU
 Y4TMjyh3wpO75VH2rSzpTWBscf0YrIuRhSspOUq9L/mh1K5rKENBqneTyWUEs+zpgPe1
 g27hdH4geGw0PmJHztVNdlXaANQi6B80VC5YpDqvQxz37IfPtNk9ev7yJLRcItsi4YVy
 Xmg1WPbKtuoS4/mIdBAx5zwfL0eKVrX7dAFq1Z4qkEsvPi+x+pkWv4Cml1WAPguxyTWa 3A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 360kg1q576-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jan 2021 16:15:35 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10CGBZsZ142917;
        Tue, 12 Jan 2021 16:13:35 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 360ke6rgqn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jan 2021 16:13:34 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 10CGDXbg030055;
        Tue, 12 Jan 2021 16:13:33 GMT
Received: from revolver.jebus.ca (/23.233.25.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 Jan 2021 08:13:32 -0800
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
Subject: [PATCH v2 24/70] mmap: Remove __do_munmap() in favour of do_mas_munmap()
Date:   Tue, 12 Jan 2021 11:11:54 -0500
Message-Id: <20210112161240.2024684-25-Liam.Howlett@Oracle.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210112161240.2024684-1-Liam.Howlett@Oracle.com>
References: <20210112161240.2024684-1-Liam.Howlett@Oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9862 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 mlxlogscore=996 malwarescore=0 bulkscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101120092
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9862 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 clxscore=1015 impostorscore=0 spamscore=0 priorityscore=1501 mlxscore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101120093
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export new interface and use it in place of old interface.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 include/linux/mm.h |  4 ++--
 mm/mmap.c          | 16 ++++------------
 mm/mremap.c        |  7 ++++---
 3 files changed, 10 insertions(+), 17 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 996353a057500..680dcfe07dbb6 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2573,8 +2573,8 @@ extern unsigned long mmap_region(struct file *file, unsigned long addr,
 extern unsigned long do_mmap(struct file *file, unsigned long addr,
 	unsigned long len, unsigned long prot, unsigned long flags,
 	unsigned long pgoff, unsigned long *populate, struct list_head *uf);
-extern int __do_munmap(struct mm_struct *, unsigned long, size_t,
-		       struct list_head *uf, bool downgrade);
+extern int do_mas_munmap(struct ma_state *mas, struct mm_struct *mm,
+	 unsigned long start, size_t len, struct list_head *uf, bool downgrade);
 extern int do_munmap(struct mm_struct *, unsigned long, size_t,
 		     struct list_head *uf);
 extern int do_madvise(struct mm_struct *mm, unsigned long start, size_t len_in, int behavior);
diff --git a/mm/mmap.c b/mm/mmap.c
index c0a64c4726b67..9be91b47db6b4 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2555,13 +2555,6 @@ int do_mas_align_munmap(struct ma_state *mas, struct vm_area_struct *vma,
 	return downgrade ? 1 : 0;
 }
 
-int __do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
-		struct list_head *uf, bool downgrade)
-{
-	MA_STATE(mas, &mm->mm_mt, start, start);
-	return do_mas_munmap(&mas, mm, start, len, uf, downgrade);
-}
-
 /*
  * do_mas_munmap() - munmap a given range.
  * @mas: The maple state
@@ -2610,7 +2603,8 @@ int do_mas_munmap(struct ma_state *mas, struct mm_struct *mm,
 int do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
 	      struct list_head *uf)
 {
-	return __do_munmap(mm, start, len, uf, false);
+	MA_STATE(mas, &mm->mm_mt, start, start);
+	return do_mas_munmap(&mas, mm, start, len, uf, false);
 }
 
 unsigned long mmap_region(struct file *file, unsigned long addr,
@@ -2858,11 +2852,12 @@ static int __vm_munmap(unsigned long start, size_t len, bool downgrade)
 	int ret;
 	struct mm_struct *mm = current->mm;
 	LIST_HEAD(uf);
+	MA_STATE(mas, &mm->mm_mt, start, start);
 
 	if (mmap_write_lock_killable(mm))
 		return -EINTR;
 
-	ret = __do_munmap(mm, start, len, &uf, downgrade);
+	ret = do_mas_munmap(&mas, mm, start, len, &uf, downgrade);
 	/*
 	 * Returning 1 indicates mmap_lock is downgraded.
 	 * But 1 is not legal return value of vm_munmap() and munmap(), reset
@@ -3014,9 +3009,6 @@ static int do_brk_munmap(struct ma_state *mas, struct vm_area_struct *vma,
 	arch_unmap(mm, newbrk, oldbrk);
 
 	if (likely(vma->vm_start >= newbrk)) { // remove entire mapping(s)
-		mas_set(mas, newbrk);
-		if (vma->vm_start != newbrk)
-			mas_reset(mas); // cause a re-walk for the first overlap.
 		ret = do_mas_munmap(mas, mm, newbrk, oldbrk-newbrk, uf, true);
 		goto munmap_full_vma;
 	}
diff --git a/mm/mremap.c b/mm/mremap.c
index 138abbae4f758..a7526a8c1fe5a 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -723,14 +723,15 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
 	/*
 	 * Always allow a shrinking remap: that just unmaps
 	 * the unnecessary pages..
-	 * __do_munmap does all the needed commit accounting, and
+	 * do_mas_munmap does all the needed commit accounting, and
 	 * downgrades mmap_lock to read if so directed.
 	 */
 	if (old_len >= new_len) {
 		int retval;
+		MA_STATE(mas, &mm->mm_mt, addr + new_len, addr + new_len);
 
-		retval = __do_munmap(mm, addr+new_len, old_len - new_len,
-				  &uf_unmap, true);
+		retval = do_mas_munmap(&mas, mm, addr + new_len,
+				       old_len - new_len, &uf_unmap, true);
 		if (retval < 0 && old_len != new_len) {
 			ret = retval;
 			goto out;
-- 
2.28.0


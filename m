Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5D32D64C4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 19:21:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392941AbgLJSUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 13:20:33 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:55804 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403908AbgLJRGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 12:06:10 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BAGo0JU119781;
        Thu, 10 Dec 2020 17:05:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=pwJY97GXAsE6xcpaiJ67o3XCkZ1HGbCsVUnHVkBjlP0=;
 b=Yxaj+E2bPgRs30SOW0angIRHZRjWC34g6MmYiJRM2n4NO3Iv24FUfroo6Peh26umin/d
 i4STe52AF6bqPbrZIr5L3jDgpGLqf0YOWEciQgXlRLZCXH2j9pLdYKj0WipBq4hfbi9J
 SSDh1nfmQWUZqs2pZIkzKSfsKxw2+Eakc8okfEI2F7/qm3s1t4KtpVdG+nWwL+HBefB9
 u1NYp26fGqQZcqE9wqaFZo4um/9xBRtA3HS6caeNhPOafevXYYs7HPtYPm4gW8oQM9ZX
 b0kmsaR1nofTysqveL17q7BtljnJ3bgKv1ixP8TkfhuUoWlr9AxcBm9/xdkxb+NPHD8m RQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 3581mr6fht-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 10 Dec 2020 17:05:08 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BAGwskG080246;
        Thu, 10 Dec 2020 17:05:08 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 358kywm3vf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Dec 2020 17:05:08 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0BAH56TH013012;
        Thu, 10 Dec 2020 17:05:07 GMT
Received: from revolver.jebus.ca (/23.233.25.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 10 Dec 2020 09:05:05 -0800
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
Subject: [PATCH 25/28] mmap: Remove __do_munmap() in favour of do_mas_munmap()
Date:   Thu, 10 Dec 2020 12:03:59 -0500
Message-Id: <20201210170402.3468568-26-Liam.Howlett@Oracle.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201210170402.3468568-1-Liam.Howlett@Oracle.com>
References: <20201210170402.3468568-1-Liam.Howlett@Oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9830 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=990 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012100106
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9830 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 clxscore=1015 malwarescore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 impostorscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012100106
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
index 93166e22c988f..9f88e2b269406 100644
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
index 48ab40a90428b..36a6b03193eb3 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2543,13 +2543,6 @@ int do_mas_align_munmap(struct ma_state *mas, struct vm_area_struct *vma,
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
@@ -2598,7 +2591,8 @@ int do_mas_munmap(struct ma_state *mas, struct mm_struct *mm,
 int do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
 	      struct list_head *uf)
 {
-	return __do_munmap(mm, start, len, uf, false);
+	MA_STATE(mas, &mm->mm_mt, start, start);
+	return do_mas_munmap(&mas, mm, start, len, uf, false);
 }
 
 unsigned long mmap_region(struct file *file, unsigned long addr,
@@ -2846,11 +2840,12 @@ static int __vm_munmap(unsigned long start, size_t len, bool downgrade)
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
@@ -3002,9 +2997,6 @@ static int do_brk_munmap(struct ma_state *mas, struct vm_area_struct *vma,
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


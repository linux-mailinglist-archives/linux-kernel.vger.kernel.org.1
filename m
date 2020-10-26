Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7A87299A83
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 00:32:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406398AbgJZXca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 19:32:30 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:41466 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406383AbgJZXc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 19:32:29 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09QNPADh177077;
        Mon, 26 Oct 2020 23:32:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=cOzQ4SFAm9QthJfZqkbBPtTmglQrm9zVkciLxhhdvQo=;
 b=aJds6hzcykpC6ebQyIAoN1ku7mF5t1bfnCt+0x+KoVuu5MUfPMFKhVK1TjH+YAcPwPyL
 iXzsq8uPlZyV0y5xgZXc6hxSGuB03DTlNXPWFeLxPIdYTkDBSgkaMGkrDNZNGrrOAJXA
 jHXNi46X/nRVoHZ9H/QcdhI1hzty+Eoxtw3aVoTDUbV6F1XdKCTxEZ4iAABO3uUcmZM1
 AQCgQ2WBTDOEc5d7CIvohshhgFegEsi4LGhXTQHspGFEOxtfm/LpVs/Ch2Cxxw3sJWjE
 GiZtMZDifVU2QJridZ4M7nshU7SMzryIWQ0c5iABsORPoLXteI0ci65CJtLHkkvW4CJ2 lg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 34c9saqctq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 26 Oct 2020 23:32:17 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09QNPGHU121024;
        Mon, 26 Oct 2020 23:32:16 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 34cx6va491-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Oct 2020 23:32:16 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 09QNWEdW027932;
        Mon, 26 Oct 2020 23:32:15 GMT
Received: from monkey.oracle.com (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 26 Oct 2020 16:32:08 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Hugh Dickins <hughd@google.com>, Michal Hocko <mhocko@kernel.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Prakash Sangappa <prakash.sangappa@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [RFC PATCH v2 2/4] hugetlbfs: add hinode_rwsem to hugetlb specific inode
Date:   Mon, 26 Oct 2020 16:31:48 -0700
Message-Id: <20201026233150.371577-3-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201026233150.371577-1-mike.kravetz@oracle.com>
References: <20201026233150.371577-1-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9786 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010260153
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9786 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 malwarescore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 phishscore=0 clxscore=1015 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010260153
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hugetlb pmd sharing code needs additional synchronization.  Ideally,
i_mmap_rwsem would be used for this.  However, previous attempts at using
i_mmap_rwsem have failed.  This is partly due to conflicts with the existing
uses of i_mmap_rwsem that force a locking order not compatible with it's
use for pmd sharing.

Introduce a rwsem (hinode_rwsem) that resides in the hugetlb specific inode
for the purpose of this synchronization.  This patch adds the semaphore to
the inode and also provides routines for using the semaphore.  The routines
only acquire the semaphore if pmd sharing is possible in an attempt to
minimize performance impacts.  In addition, routines which can be used with
lockdep to help with proper locking are also added.

Use of the new semaphore and supporting routines will be provided in a
subsequent patch.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 fs/hugetlbfs/inode.c    |  12 ++++
 include/linux/hugetlb.h | 121 ++++++++++++++++++++++++++++++++++++++++
 mm/hugetlb.c            |  13 -----
 mm/rmap.c               |   1 +
 4 files changed, 134 insertions(+), 13 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 3a1246aeedc4..0460b43240b9 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -85,6 +85,17 @@ static const struct fs_parameter_spec hugetlb_fs_parameters[] = {
 	{}
 };
 
+#ifdef CONFIG_ARCH_WANT_HUGE_PMD_SHARE
+static inline void init_hinode_rwsem(struct hugetlbfs_inode_info *info)
+{
+	init_rwsem(&info->hinode_rwsem);
+}
+#else
+static inline void init_hinode_rwsem(struct hugetlbfs_inode_info *info)
+{
+}
+#endif
+
 #ifdef CONFIG_NUMA
 static inline void hugetlb_set_vma_policy(struct vm_area_struct *vma,
 					struct inode *inode, pgoff_t index)
@@ -829,6 +840,7 @@ static struct inode *hugetlbfs_get_inode(struct super_block *sb,
 		inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
 		inode->i_mapping->private_data = resv_map;
 		info->seals = F_SEAL_SEAL;
+		init_hinode_rwsem(info);
 		switch (mode & S_IFMT) {
 		default:
 			init_special_inode(inode, mode, dev);
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index bf79a5601091..d3939a866855 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -414,6 +414,9 @@ struct hugetlbfs_inode_info {
 	struct shared_policy policy;
 	struct inode vfs_inode;
 	unsigned int seals;
+#ifdef CONFIG_ARCH_WANT_HUGE_PMD_SHARE
+	struct rw_semaphore hinode_rwsem;
+#endif
 };
 
 static inline struct hugetlbfs_inode_info *HUGETLBFS_I(struct inode *inode)
@@ -439,6 +442,101 @@ static inline struct hstate *hstate_inode(struct inode *i)
 {
 	return HUGETLBFS_SB(i->i_sb)->hstate;
 }
+
+#ifdef CONFIG_ARCH_WANT_HUGE_PMD_SHARE
+static inline bool vma_shareable(struct vm_area_struct *vma, unsigned long addr)
+{
+	unsigned long base = addr & PUD_MASK;
+	unsigned long end = base + PUD_SIZE;
+
+	/* check on proper vm_flags and page table alignment */
+	if (vma->vm_flags & VM_MAYSHARE && range_in_vma(vma, base, end))
+		return true;
+	return false;
+}
+
+/*
+ * hugetlb specific hinode_rwsem is used for pmd sharing synchronization.
+ * This routine will take the semaphore in read mode if necessary.  If vma
+ * and addr are NULL, the routine will always acquire the semaphore. If
+ * values are supplied for vma and addr, they are used to determine if pmd
+ * sharing is actually possible, and only acquire the semaphore if possible.
+ * Returns true if lock was acquired, otherwise false.
+ */
+static inline bool hinode_lock_read(struct inode *inode,
+					struct vm_area_struct *vma,
+					unsigned long addr)
+{
+	if (vma && !addr)
+		addr = round_up(vma->vm_start, PUD_SIZE);
+	if (vma && !vma_shareable(vma, addr))
+		return false;
+
+	down_read(&HUGETLBFS_I(inode)->hinode_rwsem);
+	return true;
+}
+
+static inline void hinode_unlock_read(struct inode *inode)
+{
+	up_read(&HUGETLBFS_I(inode)->hinode_rwsem);
+}
+
+/*
+ * Take hinode_rwsem semaphore in write mode if necessary.  See,
+ * hinode_lock_read for details.
+ * Returns true is lock was acquired, otherwise false.
+ */
+static inline bool hinode_lock_write(struct inode *inode,
+					struct vm_area_struct *vma,
+					unsigned long addr)
+{
+	if (vma && !addr)
+		addr = round_up(vma->vm_start, PUD_SIZE);
+	if (vma && !vma_shareable(vma, addr))
+		return false;
+
+	down_write(&HUGETLBFS_I(inode)->hinode_rwsem);
+	return true;
+}
+
+static inline void hinode_unlock_write(struct inode *inode)
+{
+	up_write(&HUGETLBFS_I(inode)->hinode_rwsem);
+}
+
+static inline void hinode_assert_locked(struct address_space *mapping)
+{
+	lockdep_assert_held(&HUGETLBFS_I(mapping->host)->hinode_rwsem);
+}
+
+static inline void hinode_assert_write_locked(struct address_space *mapping)
+{
+	lockdep_assert_held_write(&HUGETLBFS_I(mapping->host)->hinode_rwsem);
+}
+#else
+static inline bool hinode_lock_read(struct inode *inode,
+					struct vm_area_struct *vma,
+					unsigned long addr)
+{
+		return false;
+}
+
+static inline void hinode_unlock_read(struct inode *inode)
+{
+}
+
+static inline bool hinode_lock_write(struct inode *inode,
+					struct vm_area_struct *vma,
+					unsigned long addr)
+{
+	return false;
+}
+
+static inline void hinode_unlock_write(struct inode *inode)
+{
+}
+#endif
+
 #else /* !CONFIG_HUGETLBFS */
 
 #define is_file_hugepages(file)			false
@@ -913,6 +1011,29 @@ static inline void set_huge_swap_pte_at(struct mm_struct *mm, unsigned long addr
 					pte_t *ptep, pte_t pte, unsigned long sz)
 {
 }
+
+static inline bool hinode_lock_read(struct inode *inode,
+					struct vm_area_struct *vma,
+					unsigned long addr)
+{
+		return false;
+}
+
+static inline void hinode_unlock_read(struct inode *inode)
+{
+}
+
+static inline bool hinode_lock_write(struct inode *inode,
+					struct vm_area_struct *vma,
+					unsigned long addr)
+{
+	return false;
+}
+
+static inline void hinode_unlock_write(struct inode *inode)
+{
+}
+
 #endif	/* CONFIG_HUGETLB_PAGE */
 
 static inline spinlock_t *huge_pte_lock(struct hstate *h,
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 9a316b6d0b51..7b38c91f457b 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5166,19 +5166,6 @@ static unsigned long page_table_shareable(struct vm_area_struct *svma,
 	return saddr;
 }
 
-static bool vma_shareable(struct vm_area_struct *vma, unsigned long addr)
-{
-	unsigned long base = addr & PUD_MASK;
-	unsigned long end = base + PUD_SIZE;
-
-	/*
-	 * check on proper vm_flags and page table alignment
-	 */
-	if (vma->vm_flags & VM_MAYSHARE && range_in_vma(vma, base, end))
-		return true;
-	return false;
-}
-
 /*
  * Determine if start,end range within vma could be mapped by shared pmd.
  * If yes, adjust start and end to cover range associated with possible
diff --git a/mm/rmap.c b/mm/rmap.c
index 8ef12940e357..b30d211bd999 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -22,6 +22,7 @@
  *
  * inode->i_mutex	(while writing or truncating, not reading or faulting)
  *   mm->mmap_lock
+ *   hugetlbfs inode->hinode_rwsem (hugetlbfs specific)
  *     page->flags PG_locked (lock_page)
  *       hugetlbfs_i_mmap_rwsem_key (in huge_pmd_share)
  *         mapping->i_mmap_rwsem
-- 
2.25.4


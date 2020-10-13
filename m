Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFDF928D6D5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 01:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729713AbgJMXLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 19:11:35 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:36276 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729677AbgJMXLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 19:11:31 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09DN8USG194590;
        Tue, 13 Oct 2020 23:11:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=Ec4Md5rFaPUbeWnS4UMVAyFE7KUhdbryXk2hP9CHiEI=;
 b=D/6ZpSPfGRZIuxjFpNMborY+P96lOrrU0t4ipvtLuZCNuUw1pyQWcJ15d6LS42wXtNXe
 544wmFOYGwIze5Al7lhLnTOouUchKEv0E4XbeSyxlW8Iz1DWKAPN8KsH+3cCaSwSlRXW
 toUE/mxtrb3u86fgW5rxvj7ExML63dm3hUKHsvbIWxWfsYf2+x8+daWBHq93ZKZv1z2D
 NITZsot0eMf5e1BjGv9pZm4aoHWQr1s56ok1gKPVmvtagVC83BS8rHEIWdC4xElBsG9/
 JYKPbUNsgXYoCW7wu4wqMveUOq/VKFvKpSsj2aqUrEU99bREJRwwHXHjGBb95P2ekfqm aQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 343pajuf35-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 13 Oct 2020 23:11:19 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09DN5EmD023392;
        Tue, 13 Oct 2020 23:11:19 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 343puykkus-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Oct 2020 23:11:18 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 09DNBHNr014679;
        Tue, 13 Oct 2020 23:11:17 GMT
Received: from monkey.oracle.com (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 13 Oct 2020 16:11:16 -0700
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
Subject: [RFC PATCH 3/3] huegtlbfs: handle page fault/truncate races
Date:   Tue, 13 Oct 2020 16:11:00 -0700
Message-Id: <20201013231100.71013-4-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201013231100.71013-1-mike.kravetz@oracle.com>
References: <20201013231100.71013-1-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9773 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 adultscore=0 suspectscore=2 phishscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010130161
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9773 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=2
 impostorscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010130161
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A huegtlb page fault can race with page truncation.  Make the code
identifying and handling these races more robust.

Page fault handling needs to back out pages added to page cache beyond
file size (i_size).  When backing out the page, take care to restore
reserve map entries and counts as necessary.

File truncation (remove_inode_hugepages) needs to handle page mapping
changes that could have happened before locking the page.  This could
happen if page was added to page cache and later backed out in fault
processing.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 fs/hugetlbfs/inode.c | 34 ++++++++++++++++++++--------------
 mm/hugetlb.c         | 40 ++++++++++++++++++++++++++++++++++++++--
 2 files changed, 58 insertions(+), 16 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index d6bb675d4872..f6ca2892e833 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -514,23 +514,29 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
 
 			lock_page(page);
 			/*
-			 * We must free the huge page and remove from page
-			 * cache (remove_huge_page) BEFORE removing the
-			 * region/reserve map (hugetlb_unreserve_pages).  In
-			 * rare out of memory conditions, removal of the
-			 * region/reserve map could fail. Correspondingly,
-			 * the subpool and global reserve usage count can need
-			 * to be adjusted.
+			 * After locking page, make sure mapping is the same.
+			 * We could have raced with page fault populate and
+			 * backout code.
 			 */
-			VM_BUG_ON(PagePrivate(page));
-			remove_huge_page(page);
-			freed++;
-			if (!truncate_op) {
-				if (unlikely(hugetlb_unreserve_pages(inode,
+			if (page_mapping(page) == mapping) {
+				/*
+				 * We must free the huge page and remove from
+				 * page cache (remove_huge_page) BEFORE
+				 * removing the region/reserve map.  In rare
+				 * out of memory conditions, removal of the
+				 * region/reserve map could fail and the
+				 * subpool and global reserve usage count
+				 * will need to be adjusted.
+				 */
+				VM_BUG_ON(PagePrivate(page));
+				remove_huge_page(page);
+				freed++;
+				if (!truncate_op) {
+					if (unlikely(hugetlb_unreserve_pages(inode,
 							index, index + 1, 1)))
-					hugetlb_fix_reserve_counts(inode);
+						hugetlb_fix_reserve_counts(inode);
+				}
 			}
-
 			unlock_page(page);
 			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 		}
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 940c037418f8..e0ba58385036 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4225,6 +4225,9 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 	spinlock_t *ptl;
 	unsigned long haddr = address & huge_page_mask(h);
 	bool new_page = false;
+	bool page_cache = false;
+	bool reserve_alloc = false;
+	bool beyond_i_size = false;
 
 	/*
 	 * Currently, we are forced to kill the process in the event the
@@ -4309,6 +4312,8 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 		clear_huge_page(page, address, pages_per_huge_page(h));
 		__SetPageUptodate(page);
 		new_page = true;
+		if (PagePrivate(page))
+			reserve_alloc = true;
 
 		if (vma->vm_flags & VM_MAYSHARE) {
 			int err = huge_add_to_page_cache(page, mapping, idx);
@@ -4318,6 +4323,7 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 					goto retry;
 				goto out;
 			}
+			page_cache = true;
 		} else {
 			lock_page(page);
 			if (unlikely(anon_vma_prepare(vma))) {
@@ -4356,8 +4362,10 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 
 	ptl = huge_pte_lock(h, mm, ptep);
 	size = i_size_read(mapping->host) >> huge_page_shift(h);
-	if (idx >= size)
+	if (idx >= size) {
+		beyond_i_size = true;
 		goto backout;
+	}
 
 	ret = 0;
 	if (!huge_pte_none(huge_ptep_get(ptep)))
@@ -4395,8 +4403,36 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 backout:
 	spin_unlock(ptl);
 backout_unlocked:
+	if (new_page) {
+		if (page_cache && beyond_i_size) {
+			/*
+			 * Back out pages added to page cache beyond i_size.
+			 * Otherwise, they will 'sit' there until the file
+			 * is removed.
+			 */
+			ClearPageDirty(page);
+			ClearPageUptodate(page);
+			delete_from_page_cache(page);
+		}
+
+		if (reserve_alloc) {
+			/*
+			 * If reserve was consumed, set PagePrivate so that
+			 * it will be restored in free_huge_page().
+			 */
+			SetPagePrivate(page);
+		}
+
+		if (!beyond_i_size) {
+			/*
+			 * Do not restore reserve map entries beyond i_size.
+			 * there will be leaks when the file is removed.
+			 */
+			restore_reserve_on_error(h, vma, haddr, page);
+		}
+
+	}
 	unlock_page(page);
-	restore_reserve_on_error(h, vma, haddr, page);
 	put_page(page);
 	goto out;
 }
-- 
2.25.4


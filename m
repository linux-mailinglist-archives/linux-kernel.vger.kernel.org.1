Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB6D72E00F8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 20:29:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726152AbgLUT2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 14:28:47 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:37892 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbgLUT2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 14:28:47 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BLJIlaA053938;
        Mon, 21 Dec 2020 19:27:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=A7VwUXE2eu04ix2RudYFslkcvhhoZhjSj9sWeJQXNxw=;
 b=0OmWta0QcvQ3ZaSqcBcoqFROsgEqsoxG3omPXxvf5FjoybtwB4Q6beyV7HNkApbTYG+8
 CZ7rl9RPem2hjGPUCoUA+MMbMkWFqV6REK2O/O70P4HGgKJztNY6PlxIaSzmxL6cW0iK
 pyZmWdPvpr66ubMYWH2L6Eh3aj5OHl18S2E6uSND+jCLjCrVB/9Yb/R69oWrog6vW9xr
 XBpRtJ/CfX0/RJ5Eg2nV+YrFrW41FTGOTeg1jDUTfvAYBPHdWie+qDj61ZDMXKv6afyP
 9oG6oX5df5qQ+0UF1JfyWibGqO6/RhjnF5qeyHdR5CWiel8gKK6loOBmLGaO6mTtGoYh wQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 35k0d88d5r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 21 Dec 2020 19:27:53 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BLJPqX2033214;
        Mon, 21 Dec 2020 19:25:52 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 35k0e8jqy7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Dec 2020 19:25:52 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0BLJPliH006094;
        Mon, 21 Dec 2020 19:25:47 GMT
Received: from monkey.oracle.com (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 21 Dec 2020 11:25:47 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH 1/2] mm/hugetlb: change hugetlb_reserve_pages() to type bool
Date:   Mon, 21 Dec 2020 11:25:41 -0800
Message-Id: <20201221192542.15732-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9842 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012210133
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9842 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012210132
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While reviewing a bug in hugetlb_reserve_pages, it was noticed that all
callers ignore the return value.  Any failure is considered an ENOMEM
error by the callers.

Change the function to be of type bool.  The function will return true
if the reservation was successful, false otherwise.  Callers currently
assume a zero return code indicates success.  Change the callers to look
for true to indicate success.  No functional change, only code cleanup.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 fs/hugetlbfs/inode.c    |  4 ++--
 include/linux/hugetlb.h |  2 +-
 mm/hugetlb.c            | 37 ++++++++++++++-----------------------
 3 files changed, 17 insertions(+), 26 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index b5c109703daa..07d21391759c 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -171,7 +171,7 @@ static int hugetlbfs_file_mmap(struct file *file, struct vm_area_struct *vma)
 	file_accessed(file);
 
 	ret = -ENOMEM;
-	if (hugetlb_reserve_pages(inode,
+	if (!hugetlb_reserve_pages(inode,
 				vma->vm_pgoff >> huge_page_order(h),
 				len >> huge_page_shift(h), vma,
 				vma->vm_flags))
@@ -1491,7 +1491,7 @@ struct file *hugetlb_file_setup(const char *name, size_t size,
 	inode->i_size = size;
 	clear_nlink(inode);
 
-	if (hugetlb_reserve_pages(inode, 0,
+	if (!hugetlb_reserve_pages(inode, 0,
 			size >> huge_page_shift(hstate_inode(inode)), NULL,
 			acctflag))
 		file = ERR_PTR(-ENOMEM);
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index ebca2ef02212..b8cd4edda571 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -139,7 +139,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm, pte_t *dst_pte,
 				unsigned long dst_addr,
 				unsigned long src_addr,
 				struct page **pagep);
-int hugetlb_reserve_pages(struct inode *inode, long from, long to,
+bool hugetlb_reserve_pages(struct inode *inode, long from, long to,
 						struct vm_area_struct *vma,
 						vm_flags_t vm_flags);
 long hugetlb_unreserve_pages(struct inode *inode, long start, long end,
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index cbf32d2824fd..0cbc6465daf8 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5004,12 +5004,13 @@ unsigned long hugetlb_change_protection(struct vm_area_struct *vma,
 	return pages << h->order;
 }
 
-int hugetlb_reserve_pages(struct inode *inode,
+/* Return true if reservation was successful, false otherwise.  */
+bool hugetlb_reserve_pages(struct inode *inode,
 					long from, long to,
 					struct vm_area_struct *vma,
 					vm_flags_t vm_flags)
 {
-	long ret, chg, add = -1;
+	long chg, add = -1;
 	struct hstate *h = hstate_inode(inode);
 	struct hugepage_subpool *spool = subpool_inode(inode);
 	struct resv_map *resv_map;
@@ -5019,7 +5020,7 @@ int hugetlb_reserve_pages(struct inode *inode,
 	/* This should never happen */
 	if (from > to) {
 		VM_WARN(1, "%s called with a negative range\n", __func__);
-		return -EINVAL;
+		return false;
 	}
 
 	/*
@@ -5028,7 +5029,7 @@ int hugetlb_reserve_pages(struct inode *inode,
 	 * without using reserves
 	 */
 	if (vm_flags & VM_NORESERVE)
-		return 0;
+		return true;
 
 	/*
 	 * Shared mappings base their reservation on the number of pages that
@@ -5050,7 +5051,7 @@ int hugetlb_reserve_pages(struct inode *inode,
 		/* Private mapping. */
 		resv_map = resv_map_alloc();
 		if (!resv_map)
-			return -ENOMEM;
+			return false;
 
 		chg = to - from;
 
@@ -5058,18 +5059,12 @@ int hugetlb_reserve_pages(struct inode *inode,
 		set_vma_resv_flags(vma, HPAGE_RESV_OWNER);
 	}
 
-	if (chg < 0) {
-		ret = chg;
+	if (chg < 0)
 		goto out_err;
-	}
 
-	ret = hugetlb_cgroup_charge_cgroup_rsvd(
-		hstate_index(h), chg * pages_per_huge_page(h), &h_cg);
-
-	if (ret < 0) {
-		ret = -ENOMEM;
+	if (hugetlb_cgroup_charge_cgroup_rsvd(hstate_index(h),
+				chg * pages_per_huge_page(h), &h_cg) < 0)
 		goto out_err;
-	}
 
 	if (vma && !(vma->vm_flags & VM_MAYSHARE) && h_cg) {
 		/* For private mappings, the hugetlb_cgroup uncharge info hangs
@@ -5084,19 +5079,15 @@ int hugetlb_reserve_pages(struct inode *inode,
 	 * reservations already in place (gbl_reserve).
 	 */
 	gbl_reserve = hugepage_subpool_get_pages(spool, chg);
-	if (gbl_reserve < 0) {
-		ret = -ENOSPC;
+	if (gbl_reserve < 0)
 		goto out_uncharge_cgroup;
-	}
 
 	/*
 	 * Check enough hugepages are available for the reservation.
 	 * Hand the pages back to the subpool if there are not
 	 */
-	ret = hugetlb_acct_memory(h, gbl_reserve);
-	if (ret < 0) {
+	if (hugetlb_acct_memory(h, gbl_reserve) < 0)
 		goto out_put_pages;
-	}
 
 	/*
 	 * Account for the reservations made. Shared mappings record regions
@@ -5114,7 +5105,6 @@ int hugetlb_reserve_pages(struct inode *inode,
 
 		if (unlikely(add < 0)) {
 			hugetlb_acct_memory(h, -gbl_reserve);
-			ret = add;
 			goto out_put_pages;
 		} else if (unlikely(chg > add)) {
 			/*
@@ -5135,7 +5125,8 @@ int hugetlb_reserve_pages(struct inode *inode,
 			hugetlb_acct_memory(h, -rsv_adjust);
 		}
 	}
-	return 0;
+	return true;
+
 out_put_pages:
 	/* put back original number of pages, chg */
 	(void)hugepage_subpool_put_pages(spool, chg);
@@ -5151,7 +5142,7 @@ int hugetlb_reserve_pages(struct inode *inode,
 			region_abort(resv_map, from, to, regions_needed);
 	if (vma && is_vma_resv_set(vma, HPAGE_RESV_OWNER))
 		kref_put(&resv_map->refs, resv_map_release);
-	return ret;
+	return false;
 }
 
 long hugetlb_unreserve_pages(struct inode *inode, long start, long end,
-- 
2.29.2


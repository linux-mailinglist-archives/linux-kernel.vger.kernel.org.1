Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ABAC26696E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 22:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725876AbgIKUNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 16:13:09 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:49058 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbgIKUNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 16:13:07 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08BKA7X3014506;
        Fri, 11 Sep 2020 20:12:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=RJJA5VIeYEDyLlWxqH87o0yLo3b4m+0xgt6JvxypFdQ=;
 b=YD2gQHu7lSiJapybCXsLhCgpZK9ro2yjDfqZwk3OdxozfUNdSBSSRhrHxPQl/jZZ9FCg
 XFHqQfFh+5OhxodNwXwuzizuTOQhbdOoZDLXeWSPw/LeYwQx3kEJxOEMIUOgcWjlpFBX
 8oQak2VLFTstPWh72LCWNjxA5p0z428RYdtg3cUJTI45kHG6uU4Pd4oHxNcnUFFgZgkD
 JYRc7eSvahLEPru7HbzDLbVtKegkYwZb3EtzuY9SfKQLxoSI86ZnKCEV3GS9v2e+oXpV
 Ts8QM+2XwGnN25nzKVF+UMV65PkuizaVTySSzF1bPiCGVgGvp4090g9s2fRvkZ2GAK1t fA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 33c3ang6y1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 11 Sep 2020 20:12:55 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08BKAUY4191652;
        Fri, 11 Sep 2020 20:12:54 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 33cmm40qqf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Sep 2020 20:12:54 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08BKCrAM029955;
        Fri, 11 Sep 2020 20:12:53 GMT
Received: from monkey.oracle.com (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 11 Sep 2020 13:12:52 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH] hugetlb: add lockdep check for i_mmap_rwsem held in huge_pmd_share
Date:   Fri, 11 Sep 2020 13:12:48 -0700
Message-Id: <20200911201248.88537-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9741 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 suspectscore=0
 spamscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009110163
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9741 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 priorityscore=1501
 clxscore=1015 bulkscore=0 malwarescore=0 lowpriorityscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 mlxscore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009110163
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As a debugging aid, huge_pmd_share should make sure i_mmap_rwsem is held
if necessary.  To clarify the 'if necessary', expand the comment block
at the beginning of huge_pmd_share.

No functional change.  The added i_mmap_assert_locked() call is only
enabled if CONFIG_LOCKDEP.

Ideally, this should have been included with commit 34ae204f1851
("hugetlbfs: remove call to huge_pte_alloc without i_mmap_rwsem").

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 81a41aa080a5..61469fd3ad92 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5337,10 +5337,16 @@ void adjust_range_if_pmd_sharing_possible(struct vm_area_struct *vma,
  * !shared pmd case because we can allocate the pmd later as well, it makes the
  * code much cleaner.
  *
- * This routine must be called with i_mmap_rwsem held in at least read mode.
- * For hugetlbfs, this prevents removal of any page table entries associated
- * with the address space.  This is important as we are setting up sharing
- * based on existing page table entries (mappings).
+ * This routine must be called with i_mmap_rwsem held in at least read mode if
+ * sharing is possible.  For hugetlbfs, this prevents removal of any page
+ * table entries associated with the address space.  This is important as we
+ * are setting up sharing based on existing page table entries (mappings).
+ *
+ * NOTE: This routine is only called from huge_pte_alloc.  Some callers of
+ * huge_pte_alloc know that sharing is not possible and do not take
+ * i_mmap_rwsem as a performance optimization.  This is handled by the
+ * if !vma_shareable check at the beginning of the routine. i_mmap_rwsem is
+ * only required for subsequent processing.
  */
 pte_t *huge_pmd_share(struct mm_struct *mm, unsigned long addr, pud_t *pud)
 {
@@ -5357,6 +5363,7 @@ pte_t *huge_pmd_share(struct mm_struct *mm, unsigned long addr, pud_t *pud)
 	if (!vma_shareable(vma, addr))
 		return (pte_t *)pmd_alloc(mm, pud, addr);
 
+	i_mmap_assert_locked(mapping);
 	vma_interval_tree_foreach(svma, &mapping->i_mmap, idx, idx) {
 		if (svma == vma)
 			continue;
-- 
2.25.4


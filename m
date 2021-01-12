Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9B932F3592
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 17:21:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406667AbhALQVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 11:21:22 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:34486 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392714AbhALQOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 11:14:32 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10CGA0NO142138;
        Tue, 12 Jan 2021 16:13:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=EN/bm/KnJOaXSCTtC/p5re4ou+Yoqw8Op7n6HCN7qy0=;
 b=E0h5sUG9qDiDWEzx8vosHdWBEomJOsUHvNpu+fjxAMkEnEIdBfrxrezZMXYvGZitVOgo
 cXSt14Yz03xtWjsV4rnKdLSJgys8wojaa5emE+B5BiWqUqVFmmzZ5YJsiFBtejlYihY0
 akhFcpN72+NlAI/g1X7PjYQR+iFgvgWxn2Guy8doiQH3983Z9yb1cEVrm72r8j0p5+P0
 YfXLzKM3h8FeMRbRczlEK7BD+mfIkR6uXAHBkx1SUywkrmjEnW3MnfpsvEBb/8Lcj790
 SV8duvToxAe4G+9yOvyNbMs/+rmGOUePjxPbll0WIF75Hz46qo8/nLfK9y02vWgaO4p8 vA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 360kcyq5d2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jan 2021 16:13:23 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10CGAbr5100453;
        Tue, 12 Jan 2021 16:13:22 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 360keh7j52-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jan 2021 16:13:22 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 10CGDLDp004300;
        Tue, 12 Jan 2021 16:13:21 GMT
Received: from revolver.jebus.ca (/23.233.25.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 Jan 2021 08:13:21 -0800
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
Subject: [PATCH v2 16/70] mm: Move find_vma_intersection to mmap.c and change implementation to maple tree.
Date:   Tue, 12 Jan 2021 11:11:46 -0500
Message-Id: <20210112161240.2024684-17-Liam.Howlett@Oracle.com>
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
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0
 impostorscore=0 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 mlxlogscore=999 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101120092
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When searching for a vma within a range, it is easier to use the maple
tree interface.  This means the find_vma() call changes to a special
case of the find_vma_intersection().  Exported for kvm module.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 include/linux/mm.h | 10 ++--------
 mm/mmap.c          | 41 ++++++++++++++++++++++++++++-------------
 2 files changed, 30 insertions(+), 21 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index baaad07c43c99..996353a057500 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2651,14 +2651,8 @@ extern struct vm_area_struct * find_vma_prev(struct mm_struct * mm, unsigned lon
 
 /* Look up the first VMA which intersects the interval start_addr..end_addr-1,
    NULL if none.  Assume start_addr < end_addr. */
-static inline struct vm_area_struct * find_vma_intersection(struct mm_struct * mm, unsigned long start_addr, unsigned long end_addr)
-{
-	struct vm_area_struct * vma = find_vma(mm,start_addr);
-
-	if (vma && end_addr <= vma->vm_start)
-		vma = NULL;
-	return vma;
-}
+extern struct vm_area_struct *find_vma_intersection(struct mm_struct *mm,
+		     unsigned long start_addr, unsigned long end_addr);
 
 static inline unsigned long vm_start_gap(struct vm_area_struct *vma)
 {
diff --git a/mm/mmap.c b/mm/mmap.c
index cab665a6daa05..6be58594afb3d 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2067,32 +2067,47 @@ get_unmapped_area(struct file *file, unsigned long addr, unsigned long len,
 
 EXPORT_SYMBOL(get_unmapped_area);
 
-/**
- * find_vma() - Find the VMA for a given address, or the next vma.
- * @mm The mm_struct to check
- * @addr: The address
+/*
+ * find_vma_intersection - Find the first vma between [@start, @end)
+ * @mm: The mm_struct to use.
+ * @start: The start address
+ * @end: The end address
  *
- * Returns: The VMA assoicated with addr, or the next vma.
- * May return NULL in the case of no vma at addr or above.
+ * Returns: The VMA associated with the @start or the next VMA within the range.
  */
-struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long addr)
+struct vm_area_struct *find_vma_intersection(struct mm_struct *mm,
+					     unsigned long start_addr,
+					     unsigned long end_addr)
 {
 	struct vm_area_struct *vma;
-	MA_STATE(mas, &mm->mm_mt, start_addr, start_addr);
+	unsigned long addr = start_addr;
 
 	/* Check the cache first. */
-	vma = vmacache_find(mm, addr);
+	vma = vmacache_find(mm, start_addr);
 	if (likely(vma))
 		return vma;
 
-	rcu_read_lock();
-	vma = mas_find(&mas, end_addr - 1);
-	rcu_read_unlock();
+	vma = mt_find(&mm->mm_mt, &addr, end_addr - 1);
 	if (vma)
-		vmacache_update(addr, vma);
+		vmacache_update(start_addr, vma);
 
 	return vma;
 }
+EXPORT_SYMBOL(find_vma_intersection);
+
+/**
+ * find_vma() - Find the VMA for a given address, or the next vma.
+ * @mm:  The mm_struct to check
+ * @addr: The address
+ *
+ * Returns: The VMA associated with addr, or the next vma.
+ * May return NULL in the case of no vma at addr or above.
+ */
+struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long addr)
+{
+	// Note find_vma_intersection will decrease 0 to underflow to ULONG_MAX
+	return find_vma_intersection(mm, addr, 0);
+}
 EXPORT_SYMBOL(find_vma);
 
 /**
-- 
2.28.0


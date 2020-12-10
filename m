Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E96F2D64C6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 19:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392775AbgLJSVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 13:21:08 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:48200 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403866AbgLJRFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 12:05:52 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BAGnU88139692;
        Thu, 10 Dec 2020 17:04:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=dhJLE9NCKlgJvXrU7lixpyT4IDNBl7sTd1HA0VZjuo8=;
 b=vf35zAi1qq5bSEJqCOm9AG4mbtHj+C4QqcRx9uMkT6QHYQt0RJBRz0fqJpABVNSUdox8
 rgaMwoyEf60Ny36Qpe+0FQ6dO9bndikoy2N7zbUEw7t6hMgMEoe/3mozQWeSPFABPUzG
 kodzL+moK1Z7WgfJofAAYyMPT+/BU3TNkRsRdGpDH+9RonG/PI53C6iwJccLOpp0vGX6
 kZks7Ky58ysGOWL/QseSXSVY57iK9SNi0+UjM5bA4hJGjFO5G7d8GoZOk49oVVLtr0Eq
 3N2vmrfNE7Cq4KaOhnk2KDsTux8xo1BDi6ygrOh2GWtd/QT+B06BtVJfHtrwcyIWyCiX zA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 357yqc6m0g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 10 Dec 2020 17:04:53 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BAGvKsp162567;
        Thu, 10 Dec 2020 17:04:53 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 358ksrr5fd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Dec 2020 17:04:53 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0BAH4qDs009045;
        Thu, 10 Dec 2020 17:04:52 GMT
Received: from revolver.jebus.ca (/23.233.25.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 10 Dec 2020 09:04:52 -0800
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
Subject: [PATCH 16/28] mm: Move find_vma_intersection to mmap.c and change implementation to maple tree.
Date:   Thu, 10 Dec 2020 12:03:50 -0500
Message-Id: <20201210170402.3468568-17-Liam.Howlett@Oracle.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201210170402.3468568-1-Liam.Howlett@Oracle.com>
References: <20201210170402.3468568-1-Liam.Howlett@Oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9830 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 bulkscore=0 malwarescore=0 phishscore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012100106
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9830 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 clxscore=1015 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0
 spamscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012100106
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
index 6cc8825f26414..93166e22c988f 100644
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
index dc7a742fbe131..21342ab85b752 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2048,32 +2048,47 @@ get_unmapped_area(struct file *file, unsigned long addr, unsigned long len,
 
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


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8302A2D6304
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 18:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403958AbgLJRHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 12:07:13 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:55698 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403894AbgLJRGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 12:06:06 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BAGo0Uk119780;
        Thu, 10 Dec 2020 17:05:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=u/Wyco1yo63ZxfAvbOKKo2cvpk7DCHt1SOQFshmqKOU=;
 b=kWd7yjbTDttKBQoNH8T6oRplFwIjST969JbRmldBn//Sc3DPBc0BRW//HPjzo4Pfwutp
 vev0iX+XJEquO/TBPYJZ08rFSFN1z/q0GtVjsdJD/wJyIwH7dd0yyVusLGQzlIDrSAz2
 z7EL+J3LmyKhp3kMALxNjuvSCXY5hO5Jmn1JwWPXJf/ec1bJWh6zXtc4jqdl9fp/wSq+
 BlFrrfPTb2/fHKTgO4/X2aN6LrFE3oTUZfjFHXFq3HR+DiFGgiFZDIGLdIOLu7peaoVs
 yzZxZOrLF15pgAAxwBgi5+gAc5Bu07rQ/cZ8+3q4edvKQ40O6F4BQ+Qq2Z81z4lJWBjV XA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 3581mr6fhm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 10 Dec 2020 17:05:04 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BAGwjUT046108;
        Thu, 10 Dec 2020 17:05:03 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 358m41xbgg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Dec 2020 17:05:03 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0BAH53lH009124;
        Thu, 10 Dec 2020 17:05:03 GMT
Received: from revolver.jebus.ca (/23.233.25.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 10 Dec 2020 09:05:02 -0800
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
Subject: [PATCH 23/28] mm/mmap: Add do_mas_munmap() and wraper for __do_munmap()
Date:   Thu, 10 Dec 2020 12:03:57 -0500
Message-Id: <20201210170402.3468568-24-Liam.Howlett@Oracle.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201210170402.3468568-1-Liam.Howlett@Oracle.com>
References: <20201210170402.3468568-1-Liam.Howlett@Oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9830 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
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

To avoid extra tree work, it is necessary to support passing in a maple state
to key functions.  Start this work with __do_munmap().

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mmap.c | 102 ++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 72 insertions(+), 30 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index b501388c73ebd..4ef32ed2c34dc 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2422,34 +2422,24 @@ static inline int unlock_range(struct vm_area_struct *start,
 
 	return count;
 }
-/* Munmap is split into 2 main parts -- this part which finds
- * what needs doing, and the areas themselves, which do the
- * work.  This now handles partial unmappings.
- * Jeremy Fitzhardinge <jeremy@goop.org>
+
+/* do_mas_align_munmap() - munmap the aligned region from @start to @end.
+ *
+ * @mas: The maple_state, ideally set up to alter the correct tree location.
+ * @vma: The starting vm_area_struct
+ * @mm: The mm_struct
+ * @start: The aligned start address to munmap.
+ * @end: The aligned end address to munmap.
+ * @uf: The userfaultfd list_head
+ * @downgrade: Set to true to attempt a downwrite of the mmap_sem
+ *
+ *
  */
-int __do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
-		struct list_head *uf, bool downgrade)
+int do_mas_align_munmap(struct ma_state *mas, struct vm_area_struct *vma,
+			struct mm_struct *mm, unsigned long start,
+			unsigned long end, struct list_head *uf, bool downgrade)
 {
-	unsigned long end;
-	struct vm_area_struct *vma, *prev, *last;
-	MA_STATE(mas, &mm->mm_mt, start, start);
-
-	if ((offset_in_page(start)) || start > TASK_SIZE || len > TASK_SIZE-start)
-		return -EINVAL;
-
-	end = start + PAGE_ALIGN(len);
-	if (end == start)
-		return -EINVAL;
-
-	 /* arch_unmap() might do unmaps itself.  */
-	arch_unmap(mm, start, end);
-
-	/* Find the first overlapping VMA */
-	vma = mas_find(&mas, end - 1);
-	if (!vma)
-		return 0;
-
-	mas.last = end - 1;
+	struct vm_area_struct *prev, *last;
 	/* we have start < vma->vm_end  */
 
 	/*
@@ -2474,8 +2464,8 @@ int __do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
 			return error;
 		prev = vma;
 		vma = vma_next(mm, prev);
-		mas.index = start;
-		mas_reset(&mas);
+		mas->index = start;
+		mas_reset(mas);
 	} else {
 		prev = vma->vm_prev;
 	}
@@ -2491,7 +2481,7 @@ int __do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
 		if (error)
 			return error;
 		vma = vma_next(mm, prev);
-		mas_reset(&mas);
+		mas_reset(mas);
 	}
 
 
@@ -2518,7 +2508,7 @@ int __do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
 	 */
 	mm->map_count -= unlock_range(vma, &last, end);
 	/* Drop removed area from the tree */
-	mas_store_gfp(&mas, NULL, GFP_KERNEL);
+	mas_store_gfp(mas, NULL, GFP_KERNEL);
 
 	/* Detach vmas from the MM linked list */
 	vma->vm_prev = NULL;
@@ -2555,6 +2545,58 @@ int __do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
 	return downgrade ? 1 : 0;
 }
 
+int __do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
+		struct list_head *uf, bool downgrade)
+{
+	MA_STATE(mas, &mm->mm_mt, start, start);
+	return do_mas_munmap(&mas, mm, start, len, uf, downgrade);
+}
+
+/*
+ * do_mas_munmap() - munmap a given range.
+ * @mas: The maple state
+ * @mm: The mm_struct
+ * @start: The start address to munmap
+ * @len: The length of the range to munmap
+ * @uf: The userfaultfd list_head
+ * @downgrade: set to true if the user wants to attempt to write_downgrade the
+ * mmap_sem
+ *
+ * This function takes a @mas that is in the correct state to remove the
+ * mapping(s).  The @len will be aligned and any arch_unmap work will be
+ * preformed.
+ */
+int do_mas_munmap(struct ma_state *mas, struct mm_struct *mm,
+		  unsigned long start, size_t len, struct list_head *uf,
+		  bool downgrade)
+{
+	unsigned long end;
+	struct vm_area_struct *vma;
+
+	if ((offset_in_page(start)) || start > TASK_SIZE || len > TASK_SIZE-start)
+		return -EINVAL;
+
+	end = start + PAGE_ALIGN(len);
+	if (end == start)
+		return -EINVAL;
+
+	 /* arch_unmap() might do unmaps itself.  */
+	arch_unmap(mm, start, end);
+
+	/* Find the first overlapping VMA */
+	vma = mas_find(mas, end - 1);
+	if (!vma)
+		return 0;
+
+	mas->last = end - 1;
+	return do_mas_align_munmap(mas, vma, mm, start, end, uf, downgrade);
+}
+/* do_munmap() - Wrapper function for non-maple tree aware do_munmap() calls.
+ * @mm: The mm_struct
+ * @start: The start address to munmap
+ * @len: The length to be munmapped.
+ * @uf: The userfaultfd list_head
+ */
 int do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
 	      struct list_head *uf)
 {
-- 
2.28.0


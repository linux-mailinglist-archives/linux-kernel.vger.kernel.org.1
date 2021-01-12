Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC9E2F3561
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 17:21:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406217AbhALQQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 11:16:43 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:45128 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406187AbhALQQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 11:16:38 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10CGFPhO007371;
        Tue, 12 Jan 2021 16:15:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=zJCVOhzSYh81reiCaQ81lC+4130OgXBlSkDXCauMJUk=;
 b=0T2uESmZdGrKnIIYQK8RIi3pKEpIgoqCkizCvdJLdEyNoRSzrjJLxoBXi4MFZHW5JwEG
 mFI/MjupVcdk9ahCdIxWcc54ju7909Z7aYXq5U3wR+LFtF/Mj7l9jH8OoK3h4PbhobFc
 hClic6A50huRMXWWG8HtmGdldX2k6fCKQSOk7uSTAZPPVQ7i/q7g13AOGZkPiVjBaHOP
 Y9VhXuma9ZkIVDbaAswCIu0j6rzlheS90iz5GbDhIc4EKxK8ALJlIIBod350HdKcLdcl
 sCoUhw9QjuqTqqHJrEY/cP80yMJ/scDR5LD/JafGlQJI/ca95aoCehVDowMvkvqO4h8e 9w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 360kvjy1x6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jan 2021 16:15:31 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10CGAbv6100491;
        Tue, 12 Jan 2021 16:13:31 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 360keh7jbs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jan 2021 16:13:31 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 10CGDUED004360;
        Tue, 12 Jan 2021 16:13:30 GMT
Received: from revolver.jebus.ca (/23.233.25.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 Jan 2021 08:13:29 -0800
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
Subject: [PATCH v2 22/70] mm/mmap: Add do_mas_munmap() and wraper for __do_munmap()
Date:   Tue, 12 Jan 2021 11:11:52 -0500
Message-Id: <20210112161240.2024684-23-Liam.Howlett@Oracle.com>
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

To avoid extra tree work, it is necessary to support passing in a maple state
to key functions.  Start this work with __do_munmap().

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mmap.c | 102 ++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 72 insertions(+), 30 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 07aec9e215de4..8bc4ee7cc2fff 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2434,34 +2434,24 @@ static inline int unlock_range(struct vm_area_struct *start,
 
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
@@ -2486,8 +2476,8 @@ int __do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
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
@@ -2503,7 +2493,7 @@ int __do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
 		if (error)
 			return error;
 		vma = vma_next(mm, prev);
-		mas_reset(&mas);
+		mas_reset(mas);
 	}
 
 
@@ -2530,7 +2520,7 @@ int __do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
 	 */
 	mm->map_count -= unlock_range(vma, &last, end);
 	/* Drop removed area from the tree */
-	mas_store_gfp(&mas, NULL, GFP_KERNEL);
+	mas_store_gfp(mas, NULL, GFP_KERNEL);
 
 	/* Detach vmas from the MM linked list */
 	vma->vm_prev = NULL;
@@ -2567,6 +2557,58 @@ int __do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
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


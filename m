Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 564AC2F3556
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 17:21:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404179AbhALQPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 11:15:33 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:35450 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393160AbhALQPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 11:15:30 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10CGE089162576;
        Tue, 12 Jan 2021 16:14:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=9UhoXF5pt1CHq/M6XCCY1LiPSAqFng2KUZx856CQeOg=;
 b=QTR5x90pbVkqktfZcRqyUWtNjdtqwTOoK2evme9/m3p1oybu6aJiR8S2NpArmYjFUnIO
 hFgMUIAulCkQTnJDOOHkqesM6SkMd9aTeIwxRpZQPhd20VcdGROpulbXORjRWzwR6P3U
 /JRe0EB5rnmf88aeFkcGykFO/5779QJAT82jxxr5wKg4ZQ9wzHhSwqwWdy7HIk24G3Ah
 aBY2at4prnOG7JgVR0l2g1AZkTQ8cMsUxOrPu84IAHD9sTzuhji1OAkgQYV1zPHnhVLe
 ShkYu1jw7eJ9LxF5COZpXG34NDyB4gmKUg/sD8TRMCL7cLnR8WqQP6Hwxe0CHs+TH9ik rA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 360kcyq5gf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jan 2021 16:14:06 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10CGAWTu161877;
        Tue, 12 Jan 2021 16:14:05 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 360kf5q536-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jan 2021 16:14:05 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 10CGE3rn018109;
        Tue, 12 Jan 2021 16:14:03 GMT
Received: from revolver.jebus.ca (/23.233.25.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 Jan 2021 08:14:03 -0800
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
Subject: [PATCH v2 44/70] fs/proc/task_mmu: Stop using linked list and highest_vm_end
Date:   Tue, 12 Jan 2021 11:12:14 -0500
Message-Id: <20210112161240.2024684-45-Liam.Howlett@Oracle.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210112161240.2024684-1-Liam.Howlett@Oracle.com>
References: <20210112161240.2024684-1-Liam.Howlett@Oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9862 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101120092
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9862 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0
 impostorscore=0 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 mlxlogscore=999 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101120093
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove references to mm_struct linked list and highest_vm_end for when they are removed

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 fs/proc/task_mmu.c | 42 ++++++++++++++++++++++++------------------
 1 file changed, 24 insertions(+), 18 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 1ec2dd34ebffd..501d27ae2b772 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -164,14 +164,13 @@ static void *m_start(struct seq_file *m, loff_t *ppos)
 static void *m_next(struct seq_file *m, void *v, loff_t *ppos)
 {
 	struct proc_maps_private *priv = m->private;
-	struct vm_area_struct *next, *vma = v;
+	struct vm_area_struct *next = NULL, *vma = v;
 
-	if (vma == priv->tail_vma)
-		next = NULL;
-	else if (vma->vm_next)
-		next = vma->vm_next;
-	else
-		next = priv->tail_vma;
+	if (vma != priv->tail_vma) {
+		next = vma_next(vma->vm_mm, vma);
+		if (!next)
+			next = priv->tail_vma;
+	}
 
 	*ppos = next ? next->vm_start : -1UL;
 
@@ -841,16 +840,16 @@ static int show_smaps_rollup(struct seq_file *m, void *v)
 {
 	struct proc_maps_private *priv = m->private;
 	struct mem_size_stats mss;
-	struct mm_struct *mm;
+	struct mm_struct *mm = priv->mm;
 	struct vm_area_struct *vma;
-	unsigned long last_vma_end = 0;
+	unsigned long vma_start, last_vma_end = 0;
 	int ret = 0;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
 
 	priv->task = get_proc_task(priv->inode);
 	if (!priv->task)
 		return -ESRCH;
 
-	mm = priv->mm;
 	if (!mm || !mmget_not_zero(mm)) {
 		ret = -ESRCH;
 		goto out_put_task;
@@ -863,8 +862,13 @@ static int show_smaps_rollup(struct seq_file *m, void *v)
 		goto out_put_mm;
 
 	hold_task_mempolicy(priv);
+	vma = mas_find(&mas, 0);
+
+	if (vma)
+		vma_start = vma->vm_start;
 
-	for (vma = priv->mm->mmap; vma;) {
+	mas_set(&mas, 0);
+	mas_for_each(&mas, vma, -1) {
 		smap_gather_stats(vma, &mss, 0);
 		last_vma_end = vma->vm_end;
 
@@ -873,6 +877,7 @@ static int show_smaps_rollup(struct seq_file *m, void *v)
 		 * access it for write request.
 		 */
 		if (mmap_lock_is_contended(mm)) {
+			mas_pause(&mas);
 			mmap_read_unlock(mm);
 			ret = mmap_read_lock_killable(mm);
 			if (ret) {
@@ -916,7 +921,8 @@ static int show_smaps_rollup(struct seq_file *m, void *v)
 			 *    contains last_vma_end.
 			 *    Iterate VMA' from last_vma_end.
 			 */
-			vma = find_vma(mm, last_vma_end - 1);
+			mas.index = mas.last = last_vma_end - 1;
+			vma = mas_find(&mas, -1);
 			/* Case 3 above */
 			if (!vma)
 				break;
@@ -930,11 +936,9 @@ static int show_smaps_rollup(struct seq_file *m, void *v)
 				smap_gather_stats(vma, &mss, last_vma_end);
 		}
 		/* Case 2 above */
-		vma = vma->vm_next;
 	}
 
-	show_vma_header_prefix(m, priv->mm->mmap->vm_start,
-			       last_vma_end, 0, 0, 0, 0);
+	show_vma_header_prefix(m, vma_start, last_vma_end, 0, 0, 0, 0);
 	seq_pad(m, ' ');
 	seq_puts(m, "[rollup]\n");
 
@@ -1209,6 +1213,7 @@ static ssize_t clear_refs_write(struct file *file, const char __user *buf,
 		return -ESRCH;
 	mm = get_task_mm(task);
 	if (mm) {
+		MA_STATE(mas, &mm->mm_mt, 0, 0);
 		struct mmu_notifier_range range;
 		struct clear_refs_private cp = {
 			.type = type,
@@ -1235,7 +1240,7 @@ static ssize_t clear_refs_write(struct file *file, const char __user *buf,
 		}
 		tlb_gather_mmu(&tlb, mm, 0, -1);
 		if (type == CLEAR_REFS_SOFT_DIRTY) {
-			for (vma = mm->mmap; vma; vma = vma->vm_next) {
+			mas_for_each(&mas, vma, ULONG_MAX) {
 				if (!(vma->vm_flags & VM_SOFTDIRTY))
 					continue;
 				mmap_read_unlock(mm);
@@ -1243,7 +1248,8 @@ static ssize_t clear_refs_write(struct file *file, const char __user *buf,
 					count = -EINTR;
 					goto out_mm;
 				}
-				for (vma = mm->mmap; vma; vma = vma->vm_next) {
+				mas_set(&mas, 0);
+				mas_for_each(&mas, vma, ULONG_MAX) {
 					vma->vm_flags &= ~VM_SOFTDIRTY;
 					vma_set_page_prot(vma);
 				}
@@ -1255,7 +1261,7 @@ static ssize_t clear_refs_write(struct file *file, const char __user *buf,
 						0, NULL, mm, 0, -1UL);
 			mmu_notifier_invalidate_range_start(&range);
 		}
-		walk_page_range(mm, 0, mm->highest_vm_end, &clear_refs_walk_ops,
+		walk_page_range(mm, 0, -1, &clear_refs_walk_ops,
 				&cp);
 		if (type == CLEAR_REFS_SOFT_DIRTY)
 			mmu_notifier_invalidate_range_end(&range);
-- 
2.28.0


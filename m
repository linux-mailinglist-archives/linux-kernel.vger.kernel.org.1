Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDDD62F3555
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 17:21:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393169AbhALQPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 11:15:30 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:43170 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393117AbhALQP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 11:15:28 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10CG980Q181173;
        Tue, 12 Jan 2021 16:14:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=Xs/da3uQj6GGEGUoVgcFg1HKfu/wmIl1PdZct4FEqNQ=;
 b=xvtEfRqMj5xYOeo5qDzCz0dF3KUMTqAj5MPfG5T8Cafff2Qp4XfKuvyWDpIOMwP6Dm6q
 bsT4j038i4Lc0pEPZ8G3KjSe4kty2hl1FqVqoRoBVGKu0yYCi/Bo6NZ6QzyxxnWbDHPD
 JZLq/X0OeFBopko2iMYvlPsKvjZOxEH10JyVtGv6RNcLOHhfNnWUGbgvMqyk7mP1wyh8
 1Q+h3M4rI0fcX8eamanmBUuDehnlGDhF638bpw6aZ41W1mXFD1GgauMeQNFYYAIOFpPI
 kjldSn0Um91FU0uVIxWLajgIFRxjHgYc5ELc40GpA948o8C1n+ScQaj6SUmGnXjtXIUp ow== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 360kvjy1q7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jan 2021 16:14:08 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10CGAbZc100476;
        Tue, 12 Jan 2021 16:14:08 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 360keh7k91-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jan 2021 16:14:08 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 10CGE6vE030454;
        Tue, 12 Jan 2021 16:14:06 GMT
Received: from revolver.jebus.ca (/23.233.25.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 Jan 2021 08:14:04 -0800
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
Subject: [PATCH v2 45/70] fs/userfaultfd: Stop using vma linked list.
Date:   Tue, 12 Jan 2021 11:12:15 -0500
Message-Id: <20210112161240.2024684-46-Liam.Howlett@Oracle.com>
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
 engine=8.12.0-2009150000 definitions=main-2101120092
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't use the mm_struct linked list or the vma->vm_next in prep for removal

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 fs/userfaultfd.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 000b457ad0876..b0eac6fb3e8e2 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -598,14 +598,16 @@ static void userfaultfd_event_wait_completion(struct userfaultfd_ctx *ctx,
 	if (release_new_ctx) {
 		struct vm_area_struct *vma;
 		struct mm_struct *mm = release_new_ctx->mm;
+		MA_STATE(mas, &mm->mm_mt, 0, 0);
 
 		/* the various vma->vm_userfaultfd_ctx still points to it */
 		mmap_write_lock(mm);
-		for (vma = mm->mmap; vma; vma = vma->vm_next)
+		mas_for_each(&mas, vma, ULONG_MAX) {
 			if (vma->vm_userfaultfd_ctx.ctx == release_new_ctx) {
 				vma->vm_userfaultfd_ctx = NULL_VM_UFFD_CTX;
 				vma->vm_flags &= ~(VM_UFFD_WP | VM_UFFD_MISSING);
 			}
+		}
 		mmap_write_unlock(mm);
 
 		userfaultfd_ctx_put(release_new_ctx);
@@ -790,7 +792,9 @@ int userfaultfd_unmap_prep(struct vm_area_struct *vma,
 			   unsigned long start, unsigned long end,
 			   struct list_head *unmaps)
 {
-	for ( ; vma && vma->vm_start < end; vma = vma->vm_next) {
+	MA_STATE(mas, &vma->vm_mm->mm_mt, vma->vm_start, vma->vm_start);
+
+	mas_for_each(&mas, vma, end) {
 		struct userfaultfd_unmap_ctx *unmap_ctx;
 		struct userfaultfd_ctx *ctx = vma->vm_userfaultfd_ctx.ctx;
 
@@ -840,6 +844,7 @@ static int userfaultfd_release(struct inode *inode, struct file *file)
 	/* len == 0 means wake all */
 	struct userfaultfd_wake_range range = { .len = 0, };
 	unsigned long new_flags;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
 
 	WRITE_ONCE(ctx->released, true);
 
@@ -856,7 +861,7 @@ static int userfaultfd_release(struct inode *inode, struct file *file)
 	 */
 	mmap_write_lock(mm);
 	prev = NULL;
-	for (vma = mm->mmap; vma; vma = vma->vm_next) {
+	mas_for_each(&mas, vma, ULONG_MAX) {
 		cond_resched();
 		BUG_ON(!!vma->vm_userfaultfd_ctx.ctx ^
 		       !!(vma->vm_flags & (VM_UFFD_MISSING | VM_UFFD_WP)));
@@ -1270,6 +1275,7 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 	bool found;
 	bool basic_ioctls;
 	unsigned long start, end, vma_end;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
 
 	user_uffdio_register = (struct uffdio_register __user *) arg;
 
@@ -1328,7 +1334,8 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 	 */
 	found = false;
 	basic_ioctls = false;
-	for (cur = vma; cur && cur->vm_start < end; cur = cur->vm_next) {
+	mas_set(&mas, vma->vm_start);
+	mas_for_each(&mas, cur, end) {
 		cond_resched();
 
 		BUG_ON(!!cur->vm_userfaultfd_ctx.ctx ^
@@ -1444,7 +1451,7 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 	skip:
 		prev = vma;
 		start = vma->vm_end;
-		vma = vma->vm_next;
+		vma = vma_next(mm, vma);
 	} while (vma && vma->vm_start < end);
 out_unlock:
 	mmap_write_unlock(mm);
@@ -1485,6 +1492,7 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
 	bool found;
 	unsigned long start, end, vma_end;
 	const void __user *buf = (void __user *)arg;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
 
 	ret = -EFAULT;
 	if (copy_from_user(&uffdio_unregister, buf, sizeof(uffdio_unregister)))
@@ -1528,7 +1536,9 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
 	 */
 	found = false;
 	ret = -EINVAL;
-	for (cur = vma; cur && cur->vm_start < end; cur = cur->vm_next) {
+	mas_set(&mas, vma->vm_start);
+
+	mas_for_each(&mas, cur, end) {
 		cond_resched();
 
 		BUG_ON(!!cur->vm_userfaultfd_ctx.ctx ^
@@ -1614,7 +1624,7 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
 	skip:
 		prev = vma;
 		start = vma->vm_end;
-		vma = vma->vm_next;
+		vma = vma_next(mm, vma);
 	} while (vma && vma->vm_start < end);
 out_unlock:
 	mmap_write_unlock(mm);
-- 
2.28.0


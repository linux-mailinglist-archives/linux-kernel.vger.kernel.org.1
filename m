Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79FDD2F3531
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 17:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392683AbhALQOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 11:14:17 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:53986 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391919AbhALQOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 11:14:15 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10CG9h9A086630;
        Tue, 12 Jan 2021 16:13:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=4XcJHq5+UWiuqXQlgJsObf/zPN4soZk45Nb1Uxfhv6E=;
 b=ilKvCQJIj8Hkv5RhP3s03IxsesYLuXeHTwrQV30m3CaFORuzPFok+WwfO0M25sucWym2
 3vOmaYS7NuoiyHjdLlP3NoxKOTNzA9+ZtVGHUPfG8iWwdmWp5R6SEivC//BomsMocHRH
 j+MdZ0s2pj8r6xDu3FtdQmL0iyDAJphN0oDu85xHnl4+dOj7r1FcVN2XRR3xYrmKmqMl
 q1/SVBcJwNFVsQqx+0S4+x8TPTyyXRWavsruEMcaZTeKaZgDJ7j65PBJw5KI2uvj1p+c
 7JOwkFDMi+ADk/+5KoHcy0kKIh8zRYkp1A0B0gpWzbkTjIn8szrdoQBod+j0fTMOOOxt QQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 360kg1q4u2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jan 2021 16:13:14 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10CGBZ2N142889;
        Tue, 12 Jan 2021 16:13:14 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 360ke6rg62-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jan 2021 16:13:14 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 10CGDCv7017522;
        Tue, 12 Jan 2021 16:13:12 GMT
Received: from revolver.jebus.ca (/23.233.25.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 Jan 2021 08:13:12 -0800
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
Subject: [PATCH v2 11/70] kernel/fork: Convert dup_mmap to use maple tree
Date:   Tue, 12 Jan 2021 11:11:41 -0500
Message-Id: <20210112161240.2024684-12-Liam.Howlett@Oracle.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210112161240.2024684-1-Liam.Howlett@Oracle.com>
References: <20210112161240.2024684-1-Liam.Howlett@Oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9862 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 mlxlogscore=946 malwarescore=0 bulkscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101120092
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9862 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 clxscore=1015 impostorscore=0 spamscore=0 priorityscore=1501 mlxscore=0
 phishscore=0 mlxlogscore=937 bulkscore=0 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101120092
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the maple tree iterator to duplicate the mm_struct trees.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 include/linux/sched/mm.h |  3 +++
 kernel/fork.c            | 22 +++++++++++++++++-----
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index d5ece7a9a403f..919e2e44b764e 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -8,6 +8,7 @@
 #include <linux/mm_types.h>
 #include <linux/gfp.h>
 #include <linux/sync_core.h>
+#include <linux/maple_tree.h>
 
 /*
  * Routines for handling mm_structs
@@ -67,11 +68,13 @@ static inline void mmdrop(struct mm_struct *mm)
  */
 static inline void mmget(struct mm_struct *mm)
 {
+	mt_set_in_rcu(&mm->mm_mt);
 	atomic_inc(&mm->mm_users);
 }
 
 static inline bool mmget_not_zero(struct mm_struct *mm)
 {
+	mt_set_in_rcu(&mm->mm_mt);
 	return atomic_inc_not_zero(&mm->mm_users);
 }
 
diff --git a/kernel/fork.c b/kernel/fork.c
index 8c7273b0d4b77..8fcbd970666c3 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -472,7 +472,9 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 	struct vm_area_struct *mpnt, *tmp, *prev, **pprev;
 	struct rb_node **rb_link, *rb_parent;
 	int retval;
-	unsigned long charge;
+	unsigned long charge = 0;
+	MA_STATE(old_mas, &oldmm->mm_mt, 0, 0);
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
 	LIST_HEAD(uf);
 
 	uprobe_start_dup_mmap();
@@ -506,7 +508,12 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 		goto out;
 
 	prev = NULL;
-	for (mpnt = oldmm->mmap; mpnt; mpnt = mpnt->vm_next) {
+
+	retval = mas_entry_count(&mas, oldmm->map_count);
+	if (retval)
+		goto fail_nomem;
+
+	mas_for_each(&old_mas, mpnt, ULONG_MAX) {
 		struct file *file;
 
 		if (mpnt->vm_flags & VM_DONTCOPY) {
@@ -520,7 +527,7 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 		 */
 		if (fatal_signal_pending(current)) {
 			retval = -EINTR;
-			goto out;
+			goto loop_out;
 		}
 		if (mpnt->vm_flags & VM_ACCOUNT) {
 			unsigned long len = vma_pages(mpnt);
@@ -589,7 +596,9 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 		rb_parent = &tmp->vm_rb;
 
 		/* Link the vma into the MT */
-		vma_store(mm, tmp);
+		mas.index = tmp->vm_start;
+		mas.last = tmp->vm_end - 1;
+		mas_store(&mas, tmp);
 
 		mm->map_count++;
 		if (!(tmp->vm_flags & VM_WIPEONFORK))
@@ -599,14 +608,16 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
 			tmp->vm_ops->open(tmp);
 
 		if (retval)
-			goto out;
+			goto loop_out;
 	}
 	/* a new mm has just been created */
 	retval = arch_dup_mmap(oldmm, mm);
+loop_out:
 out:
 	mmap_write_unlock(mm);
 	flush_tlb_mm(oldmm);
 	mmap_write_unlock(oldmm);
+	mas_destroy(&mas);
 	dup_userfaultfd_complete(&uf);
 fail_uprobe_end:
 	uprobe_end_dup_mmap();
@@ -1076,6 +1087,7 @@ static inline void __mmput(struct mm_struct *mm)
 {
 	VM_BUG_ON(atomic_read(&mm->mm_users));
 
+	mt_clear_in_rcu(&mm->mm_mt);
 	uprobe_clear_state(mm);
 	exit_aio(mm);
 	ksm_exit(mm);
-- 
2.28.0


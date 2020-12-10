Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BFF02D647E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 19:09:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404020AbgLJRIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 12:08:01 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:60364 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403961AbgLJRHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 12:07:43 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BAGoD7v120040;
        Thu, 10 Dec 2020 17:06:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=rM6vYrToRBRSPUsq4aGaA9Oqompj8hqWK3AFN+se5EM=;
 b=wkBjIkcFFJT0FfeibHE4JtVmX9/fbfymydSlziDJU2Um3qp15w6xZnUnoNqfIVxVNgFK
 +D3cZ/P17ssfz+tWSMwZN8KCGgyh3tY0y8a11JoQJ9lczQWgFCuxeZsVjJJM6yQfLoQf
 6bF8S/usElQnEUh4JZ5w2OkImNIyhjcIJOkLIeIwV6YkaqSroGAg45+r+QfA9TEQpHLz
 npjejPKIRZNOVWJmi8NtQFcc1xVg2xFvA0bi0+0bgZ9PsxFYqyxcx57/XP+sas8vpLHF
 4F3MjXUOl/MYPqyo3Z+yS0xT3Z3h+dhPF5ou+C3a+B/vlWr6sODZOn7J/wW3k9n6YL7Q PQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 3581mr6fvw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 10 Dec 2020 17:06:48 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BAGw08R033220;
        Thu, 10 Dec 2020 17:04:48 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 358m52gbc3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Dec 2020 17:04:47 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0BAH4kKc012861;
        Thu, 10 Dec 2020 17:04:46 GMT
Received: from revolver.jebus.ca (/23.233.25.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 10 Dec 2020 09:04:46 -0800
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
Subject: [PATCH 11/28] kernel/fork: Convert dup_mmap to use maple tree
Date:   Thu, 10 Dec 2020 12:03:45 -0500
Message-Id: <20201210170402.3468568-12-Liam.Howlett@Oracle.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201210170402.3468568-1-Liam.Howlett@Oracle.com>
References: <20201210170402.3468568-1-Liam.Howlett@Oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9830 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 phishscore=0 adultscore=0 mlxlogscore=930
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012100106
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9830 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=921
 clxscore=1015 malwarescore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 impostorscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012100106
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
index 23e166d037980..62eba2679216b 100644
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


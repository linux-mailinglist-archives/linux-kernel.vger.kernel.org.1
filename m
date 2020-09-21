Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB18B272259
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 13:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgIULZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 07:25:22 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:45818 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726367AbgIULZV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 07:25:21 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 3FAAD3016D65BB5E18EA;
        Mon, 21 Sep 2020 19:25:18 +0800 (CST)
Received: from huawei.com (10.175.113.32) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.487.0; Mon, 21 Sep 2020
 19:25:10 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Christian Brauner <christian@brauner.io>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Hridya Valsaraju <hridya@google.com>,
        "Suren Baghdasaryan" <surenb@google.com>,
        <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>,
        Liu Shixin <liushixin2@huawei.com>
Subject: [PATCH -next] binder: simplify the return expression of binder_mmap
Date:   Mon, 21 Sep 2020 19:47:34 +0800
Message-ID: <20200921114734.3272769-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200921080830.vrki7dcm64l46ppb@wittgenstein>
References: <20200921080830.vrki7dcm64l46ppb@wittgenstein>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify the return expression.

Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 drivers/android/binder.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 37a505c41dec..49c0700816a5 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -5180,9 +5180,7 @@ static const struct vm_operations_struct binder_vm_ops = {
 
 static int binder_mmap(struct file *filp, struct vm_area_struct *vma)
 {
-	int ret;
 	struct binder_proc *proc = filp->private_data;
-	const char *failure_string;
 
 	if (proc->tsk != current->group_leader)
 		return -EINVAL;
@@ -5194,9 +5192,9 @@ static int binder_mmap(struct file *filp, struct vm_area_struct *vma)
 		     (unsigned long)pgprot_val(vma->vm_page_prot));
 
 	if (vma->vm_flags & FORBIDDEN_MMAP_FLAGS) {
-		ret = -EPERM;
-		failure_string = "bad vm_flags";
-		goto err_bad_arg;
+		pr_err("%s: %d %lx-%lx %s failed %d\n", __func__,
+		       proc->pid, vma->vm_start, vma->vm_end, "bad vm_flags", -EPERM);
+		return -EPERM;
 	}
 	vma->vm_flags |= VM_DONTCOPY | VM_MIXEDMAP;
 	vma->vm_flags &= ~VM_MAYWRITE;
@@ -5204,15 +5202,7 @@ static int binder_mmap(struct file *filp, struct vm_area_struct *vma)
 	vma->vm_ops = &binder_vm_ops;
 	vma->vm_private_data = proc;
 
-	ret = binder_alloc_mmap_handler(&proc->alloc, vma);
-	if (ret)
-		return ret;
-	return 0;
-
-err_bad_arg:
-	pr_err("%s: %d %lx-%lx %s failed %d\n", __func__,
-	       proc->pid, vma->vm_start, vma->vm_end, failure_string, ret);
-	return ret;
+	return binder_alloc_mmap_handler(&proc->alloc, vma);
 }
 
 static int binder_open(struct inode *nodp, struct file *filp)
-- 
2.25.1


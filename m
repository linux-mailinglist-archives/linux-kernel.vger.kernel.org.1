Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB8B7271D73
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 10:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbgIUIJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 04:09:20 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49894 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbgIUIIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 04:08:42 -0400
Received: from ip5f5af089.dynamic.kabel-deutschland.de ([95.90.240.137] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kKGsA-0003Dj-SL; Mon, 21 Sep 2020 08:08:30 +0000
Date:   Mon, 21 Sep 2020 10:08:30 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] binder: simplify the return expression of
 binder_mmap
Message-ID: <20200921080830.vrki7dcm64l46ppb@wittgenstein>
References: <20200921082423.2590938-1-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200921082423.2590938-1-liushixin2@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 21, 2020 at 04:24:23PM +0800, Liu Shixin wrote:
> Simplify the return expression.
> 
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> ---

Why not is all I can really say. :) But if this is about simplifying you
could get rid of the "ret" and "failure string" variables, and the goto
in that function completely by doing sm like this (__completely
untested__):

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index f936530a19b0..26f4dc81b008 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -5182,9 +5182,7 @@ static const struct vm_operations_struct binder_vm_ops = {

 static int binder_mmap(struct file *filp, struct vm_area_struct *vma)
 {
-       int ret;
        struct binder_proc *proc = filp->private_data;
-       const char *failure_string;

        if (proc->tsk != current->group_leader)
                return -EINVAL;
@@ -5196,9 +5194,9 @@ static int binder_mmap(struct file *filp, struct vm_area_struct *vma)
                     (unsigned long)pgprot_val(vma->vm_page_prot));

        if (vma->vm_flags & FORBIDDEN_MMAP_FLAGS) {
-               ret = -EPERM;
-               failure_string = "bad vm_flags";
-               goto err_bad_arg;
+               pr_err("%s: %d %lx-%lx %s failed %d\n", __func__,
+                               proc->pid, vma->vm_start, vma->vm_end, "bad vm_flags", -EPERM);
+               return -EPERM;
        }
        vma->vm_flags |= VM_DONTCOPY | VM_MIXEDMAP;
        vma->vm_flags &= ~VM_MAYWRITE;
@@ -5206,15 +5204,7 @@ static int binder_mmap(struct file *filp, struct vm_area_struct *vma)
        vma->vm_ops = &binder_vm_ops;
        vma->vm_private_data = proc;

-       ret = binder_alloc_mmap_handler(&proc->alloc, vma);
-       if (ret)
-               return ret;
-       return 0;
-
-err_bad_arg:
-       pr_err("%s: %d %lx-%lx %s failed %d\n", __func__,
-              proc->pid, vma->vm_start, vma->vm_end, failure_string, ret);
-       return ret;
+       return binder_alloc_mmap_handler(&proc->alloc, vma);
 }

Christian

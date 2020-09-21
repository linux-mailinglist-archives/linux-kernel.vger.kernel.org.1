Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D60E3272167
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 12:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgIUKmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 06:42:47 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:39292 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726597AbgIUKmr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 06:42:47 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 1AE7F8EA4FB39AF6CF93;
        Mon, 21 Sep 2020 18:42:43 +0800 (CST)
Received: from [10.174.177.116] (10.174.177.116) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Mon, 21 Sep 2020 18:42:39 +0800
Subject: Re: [PATCH -next] binder: simplify the return expression of
 binder_mmap
To:     Christian Brauner <christian.brauner@ubuntu.com>
References: <20200921082423.2590938-1-liushixin2@huawei.com>
 <20200921080830.vrki7dcm64l46ppb@wittgenstein>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Arve_Hj=c3=b8nnev=c3=a5g?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        "Hridya Valsaraju" <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>
From:   Liu Shixin <liushixin2@huawei.com>
Message-ID: <b156861c-785e-c657-076d-d62a848d04db@huawei.com>
Date:   Mon, 21 Sep 2020 18:42:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20200921080830.vrki7dcm64l46ppb@wittgenstein>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.116]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/9/21 16:08, Christian Brauner wrote:

> On Mon, Sep 21, 2020 at 04:24:23PM +0800, Liu Shixin wrote:
>> Simplify the return expression.
>>
>> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
>> ---
> Why not is all I can really say. :) But if this is about simplifying you
> could get rid of the "ret" and "failure string" variables, and the goto
> in that function completely by doing sm like this (__completely
> untested__):

Thanks for your advice. I will modify and test it.

Regards,
Liu Shixin

>
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index f936530a19b0..26f4dc81b008 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -5182,9 +5182,7 @@ static const struct vm_operations_struct binder_vm_ops = {
>
>  static int binder_mmap(struct file *filp, struct vm_area_struct *vma)
>  {
> -       int ret;
>         struct binder_proc *proc = filp->private_data;
> -       const char *failure_string;
>
>         if (proc->tsk != current->group_leader)
>                 return -EINVAL;
> @@ -5196,9 +5194,9 @@ static int binder_mmap(struct file *filp, struct vm_area_struct *vma)
>                      (unsigned long)pgprot_val(vma->vm_page_prot));
>
>         if (vma->vm_flags & FORBIDDEN_MMAP_FLAGS) {
> -               ret = -EPERM;
> -               failure_string = "bad vm_flags";
> -               goto err_bad_arg;
> +               pr_err("%s: %d %lx-%lx %s failed %d\n", __func__,
> +                               proc->pid, vma->vm_start, vma->vm_end, "bad vm_flags", -EPERM);
> +               return -EPERM;
>         }
>         vma->vm_flags |= VM_DONTCOPY | VM_MIXEDMAP;
>         vma->vm_flags &= ~VM_MAYWRITE;
> @@ -5206,15 +5204,7 @@ static int binder_mmap(struct file *filp, struct vm_area_struct *vma)
>         vma->vm_ops = &binder_vm_ops;
>         vma->vm_private_data = proc;
>
> -       ret = binder_alloc_mmap_handler(&proc->alloc, vma);
> -       if (ret)
> -               return ret;
> -       return 0;
> -
> -err_bad_arg:
> -       pr_err("%s: %d %lx-%lx %s failed %d\n", __func__,
> -              proc->pid, vma->vm_start, vma->vm_end, failure_string, ret);
> -       return ret;
> +       return binder_alloc_mmap_handler(&proc->alloc, vma);
>  }
>
> Christian
> .
>


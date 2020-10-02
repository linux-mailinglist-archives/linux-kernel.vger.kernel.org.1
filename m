Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 488772814D5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 16:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387992AbgJBOS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 10:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgJBOS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 10:18:26 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C71A0C0613D0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 07:18:25 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id c2so1309593ljj.12
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 07:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9VY0TMtB+PD4w/PGkD87eIO8STO152a3NwOONKkybCM=;
        b=qJQr3HmkHEjADvfTKNAcIYH8k+akWcXqV+6KzxTEK2bCiheruq4Rw9TNf3mF8WYtJQ
         +U3OCcpRtajXYsQs8yfeZTSJzpfrElCPcbld77Sa/rYdvFpdEizNLog1MAUK9xU9yFCU
         1jvxRPRIYOqdk+O2v6l6pPPvT5ogmugFIZ+irnK5xB+9GUwhq6xa9T7joESHDyM+CfU2
         Zg3JuCTEOGd39/rhwOD3QQLXkSLyvHN8z7SuLALdFkGHaaVn+5pjVGJfl75iUfjC6n7v
         i155KwVC2LgqYFpyyrOs73Uyuatf+iei3eeXvAtqEmFfbScInFdVsl0z4Gb+DDgE4W8o
         dL9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9VY0TMtB+PD4w/PGkD87eIO8STO152a3NwOONKkybCM=;
        b=jeZf3TkDROZqPaFXRAICZ/Uo827ua3oXaWoEURJ53WFdOouUV305zX6MQLdILgu3Pl
         RfNxnrLdTcYXSTHAU4RslsSUvpSErneFwdEnsUB72J14QylrHVTr/9EBrXrIBJ8sBEA7
         /b0sXvwwGHd2ysYV5EwdPJecdtt4dr1nUtF1bTTzNX6qOijfC1XT5g32HAVmboJn+mcY
         JmPCKcusS+uTZM6Kq0fliK0IQqP2f02hf5rYYhaCpx0YhJM3yG+L3L58h5gj6cgGme4m
         4fRbeX3ZzSgY/N2GRWs9w0sMd96jAOEnoBDhPzK6kqKtZJ9uDK33ccd9l5ylZ2eRj2wg
         HFOA==
X-Gm-Message-State: AOAM533/E5ohOXdxtmGQu2np4JhNJwGW6lC19TwynVUKfgYalxNR5zyL
        WQdNBsWbr/QwTWa6QiO9zpJoWxbCqMdvEbOm5IcX9w==
X-Google-Smtp-Source: ABdhPJxX9wXPVoxSi+AWpJZz2rsxaqiwG3xuJey+WWpKf6G1qA2bQDh6qFajWcVqDArLv9R+2erfPqaxuSje6w2UlYA=
X-Received: by 2002:a2e:6f17:: with SMTP id k23mr845455ljc.245.1601648304227;
 Fri, 02 Oct 2020 07:18:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200927123538.GA292831@kroah.com> <20200929015216.1829946-1-liushixin2@huawei.com>
In-Reply-To: <20200929015216.1829946-1-liushixin2@huawei.com>
From:   Martijn Coenen <maco@android.com>
Date:   Fri, 2 Oct 2020 16:18:13 +0200
Message-ID: <CAB0TPYFb__cy5w88ySWY3AGEKXJLhVTQKCdp2PFomoek06VJnQ@mail.gmail.com>
Subject: Re: [PATCH v3 -next] binder: simplify the return expression of binder_mmap
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christian Brauner <christian@brauner.io>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks!

On Tue, Sep 29, 2020 at 3:30 AM Liu Shixin <liushixin2@huawei.com> wrote:
>
> Simplify the return expression.
>
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>

Acked-by: Martijn Coenen <maco@android.com>

> ---
> v3: Add the change description.
> v2: Get rid of the "ret" and "failure string" variables.
> v1: Simplify the return expression.
> ---
>  drivers/android/binder.c | 18 ++++--------------
>  1 file changed, 4 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index 37a505c41dec..49c0700816a5 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -5180,9 +5180,7 @@ static const struct vm_operations_struct binder_vm_ops = {
>
>  static int binder_mmap(struct file *filp, struct vm_area_struct *vma)
>  {
> -       int ret;
>         struct binder_proc *proc = filp->private_data;
> -       const char *failure_string;
>
>         if (proc->tsk != current->group_leader)
>                 return -EINVAL;
> @@ -5194,9 +5192,9 @@ static int binder_mmap(struct file *filp, struct vm_area_struct *vma)
>                      (unsigned long)pgprot_val(vma->vm_page_prot));
>
>         if (vma->vm_flags & FORBIDDEN_MMAP_FLAGS) {
> -               ret = -EPERM;
> -               failure_string = "bad vm_flags";
> -               goto err_bad_arg;
> +               pr_err("%s: %d %lx-%lx %s failed %d\n", __func__,
> +                      proc->pid, vma->vm_start, vma->vm_end, "bad vm_flags", -EPERM);
> +               return -EPERM;
>         }
>         vma->vm_flags |= VM_DONTCOPY | VM_MIXEDMAP;
>         vma->vm_flags &= ~VM_MAYWRITE;
> @@ -5204,15 +5202,7 @@ static int binder_mmap(struct file *filp, struct vm_area_struct *vma)
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
>  static int binder_open(struct inode *nodp, struct file *filp)
> --
> 2.25.1
>

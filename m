Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0F82E69ED
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 19:06:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728640AbgL1SFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 13:05:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728073AbgL1SFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 13:05:07 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 326FEC0613D6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 10:04:27 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id b2so10504461edm.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 10:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1XusoXZzXCem561CtyIdzy62jFmYgYhqvsSbO2ZR46c=;
        b=DSVHc07QIUtK0soe718/PW/vZrg/PwxdrGhBs/wdvz/6NZ5gelqZ4YnCbT352WJC91
         dh5awmqXzc0qxiZ24nUdgL0rUgk8LcHGFH4YsnmFRABICxIhpHib1j1md3bk8M2WX+7G
         cJgZESQWMXQESYa91RJzUhAxego4Q8a/mqJvQdMQy1tv/+pr4hdGZXtfHNted17QO6qV
         EKNdTEwowdGP5ptmy3jCYCCyGGxx+K9GoOdZ5jIC3tC1Ek/H8wIv7ryHuemAtUfsQSYP
         DucXlyVr0d8JhcPmnQHqv231RHMAgr6XkW72K23FCLd296Ym7zAhF7bkFrRSPqYiondR
         Uhsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1XusoXZzXCem561CtyIdzy62jFmYgYhqvsSbO2ZR46c=;
        b=n6YZC50Ze75eOA2C6huok9UA2S+M5bvEAYQaKgZiFPKih/gj/ntj55ITo1oKvgeUcy
         uB0+o4/ju7BZIH1MGjj14JBEo6Xnz/7MCh665yqSfAjZkDx4ziovzp5plzyru5yR5hdO
         BSuY6F5VJl0DmjkdZF5YZFGb8bBGi8ymY94t1Wt46ayNX6WyryP+qpln1VevkQjg/oo8
         edLv/iSadAKOHLlgKKfPd/SLsorZ73XIg4Er8bCqhTYlkHEJ9wfSmrjEvwXlAU69UNrO
         ykeMasx/2atuvvJSqm9vHCQa6oOxOOoFtMUo9gFt0czAE/k7Qv6i/Q5kORkRfJgXbBis
         CfLw==
X-Gm-Message-State: AOAM531kwUFCEe9rqvj0801zneUnvYeaJ6cqpBzcaJ3qKf3OJtAFrLhU
        /iDNu/wdAkkI4Ra9WGqQ131/LW7qqYIHOcR1NJTeVw==
X-Google-Smtp-Source: ABdhPJyEbHA18+GopoW3MrvxLDasfYjKRSDmjFduYaqBmPBoPByVJC0UFsKLtmKZ0K20lohnh4X0Ekjt12pIRB8mL3o=
X-Received: by 2002:a50:fd18:: with SMTP id i24mr43835414eds.146.1609178665726;
 Mon, 28 Dec 2020 10:04:25 -0800 (PST)
MIME-Version: 1.0
References: <20201013013416.390574-1-dima@arista.com> <20201013013416.390574-4-dima@arista.com>
In-Reply-To: <20201013013416.390574-4-dima@arista.com>
From:   Brian Geffon <bgeffon@google.com>
Date:   Mon, 28 Dec 2020 10:03:49 -0800
Message-ID: <CADyq12ww2SB=x16pdH4LBZJJxMakOWgkR0qX-maUe-RzYZ491Q@mail.gmail.com>
Subject: Re: [PATCH 3/6] mremap: Don't allow MREMAP_DONTUNMAP on
 special_mappings and aio
To:     Dmitry Safonov <dima@arista.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Hugh Dickins <hughd@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Minchan Kim <minchan@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I don't think this situation can ever happen MREMAP_DONTUNMAP is
already restricted to anonymous mappings (defined as not having
vm_ops) and vma_to_resize checks that the mapping is anonymous before
move_vma is called.



On Mon, Oct 12, 2020 at 6:34 PM Dmitry Safonov <dima@arista.com> wrote:
>
> As kernel expect to see only one of such mappings, any further
> operations on the VMA-copy may be unexpected by the kernel.
> Maybe it's being on the safe side, but there doesn't seem to be any
> expected use-case for this, so restrict it now.
>
> Fixes: commit e346b3813067 ("mm/mremap: add MREMAP_DONTUNMAP to mremap()")
> Signed-off-by: Dmitry Safonov <dima@arista.com>
> ---
>  arch/x86/kernel/cpu/resctrl/pseudo_lock.c | 2 +-
>  fs/aio.c                                  | 5 ++++-
>  include/linux/mm.h                        | 2 +-
>  mm/mmap.c                                 | 6 +++++-
>  mm/mremap.c                               | 2 +-
>  5 files changed, 12 insertions(+), 5 deletions(-)
>
> diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> index 0daf2f1cf7a8..e916646adc69 100644
> --- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> +++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
> @@ -1458,7 +1458,7 @@ static int pseudo_lock_dev_release(struct inode *inode, struct file *filp)
>         return 0;
>  }
>
> -static int pseudo_lock_dev_mremap(struct vm_area_struct *area)
> +static int pseudo_lock_dev_mremap(struct vm_area_struct *area, unsigned long flags)
>  {
>         /* Not supported */
>         return -EINVAL;
> diff --git a/fs/aio.c b/fs/aio.c
> index d5ec30385566..3be3c0f77548 100644
> --- a/fs/aio.c
> +++ b/fs/aio.c
> @@ -324,13 +324,16 @@ static void aio_free_ring(struct kioctx *ctx)
>         }
>  }
>
> -static int aio_ring_mremap(struct vm_area_struct *vma)
> +static int aio_ring_mremap(struct vm_area_struct *vma, unsigned long flags)
>  {
>         struct file *file = vma->vm_file;
>         struct mm_struct *mm = vma->vm_mm;
>         struct kioctx_table *table;
>         int i, res = -EINVAL;
>
> +       if (flags & MREMAP_DONTUNMAP)
> +               return -EINVAL;
> +
>         spin_lock(&mm->ioctx_lock);
>         rcu_read_lock();
>         table = rcu_dereference(mm->ioctx_table);
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 16b799a0522c..fd51a4a1f722 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -550,7 +550,7 @@ struct vm_operations_struct {
>         void (*open)(struct vm_area_struct * area);
>         void (*close)(struct vm_area_struct * area);
>         int (*split)(struct vm_area_struct * area, unsigned long addr);
> -       int (*mremap)(struct vm_area_struct * area);
> +       int (*mremap)(struct vm_area_struct *area, unsigned long flags);
>         vm_fault_t (*fault)(struct vm_fault *vmf);
>         vm_fault_t (*huge_fault)(struct vm_fault *vmf,
>                         enum page_entry_size pe_size);
> diff --git a/mm/mmap.c b/mm/mmap.c
> index bdd19f5b994e..50f853b0ec39 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -3372,10 +3372,14 @@ static const char *special_mapping_name(struct vm_area_struct *vma)
>         return ((struct vm_special_mapping *)vma->vm_private_data)->name;
>  }
>
> -static int special_mapping_mremap(struct vm_area_struct *new_vma)
> +static int special_mapping_mremap(struct vm_area_struct *new_vma,
> +                                 unsigned long flags)
>  {
>         struct vm_special_mapping *sm = new_vma->vm_private_data;
>
> +       if (flags & MREMAP_DONTUNMAP)
> +               return -EINVAL;
> +
>         if (WARN_ON_ONCE(current->mm != new_vma->vm_mm))
>                 return -EFAULT;
>
> diff --git a/mm/mremap.c b/mm/mremap.c
> index c248f9a52125..898e9818ba6d 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -384,7 +384,7 @@ static unsigned long move_vma(struct vm_area_struct *vma,
>         if (moved_len < old_len) {
>                 err = -ENOMEM;
>         } else if (vma->vm_ops && vma->vm_ops->mremap) {
> -               err = vma->vm_ops->mremap(new_vma);
> +               err = vma->vm_ops->mremap(new_vma, flags);
>         }
>
>         if (unlikely(err)) {
> --
> 2.28.0
>

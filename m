Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9B92EF81C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 20:28:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728952AbhAHT2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 14:28:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728932AbhAHT2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 14:28:09 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B0D6C0612EA
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 11:27:29 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id w17so11323762ilj.8
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 11:27:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p5wHVV/QbImaQMsuteMK+I8BrXV06ShRHu6XF/hxJiQ=;
        b=rUzvD0Cht2vNJRz5GW60NqtSWrQLOYpot2NzQf9LHMetnFFSEUad97U1Ho9ZzMv1uV
         Ilbk66Sv5uA7DMfYA+T3u12kmOrt5V3LmmbIStGvYwhvth04yt8wkB6lc7iXWSAgPxi/
         aIT0x7oI/AP5vfLGccgqiH9VjS7n/XegP/wyjB7dghX81tQV+s9zJUmxwr3Gb0eSu+b7
         e3XMvKOotzZQdyhsngUEonaSzZJrydMNUDfxVYDS//WGU+RmjdR+Dbzqd5Lu5KRhUNXw
         gDRxP6XhREzxxT3/x7jD2xYkavAiSzHylA8eZuPvrmLqXMrXekVfJsswUT6a5MsouThV
         eEPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p5wHVV/QbImaQMsuteMK+I8BrXV06ShRHu6XF/hxJiQ=;
        b=QYvXURPBGPf+2MGa4TpQdGEilRoGAF2xztb3ysJVhR1X5uZjJxXaWF87Gowcak9n2j
         selaIOXLVNxxdmyLtwkw6oGzWEAMxrV3pVWs1XXLDBXYW3ZuQkZNQShiykdhoY+jc1gZ
         Nj6dJiCVzpAazwbZkHQV83gg7vHZ+lx1+O56OK0DOTfN9PODXBYE8Wie9II//5tSdRg8
         jKUUBmMxYdU1dWFnPpSTWghfmMujwQYntjgWzNKoNGbXATK4F/c+xM4aoEJI39CEq7vV
         Gw3EgO9zCUmtV955t14+X2XpAZTwmU0E+x/lPklb5xisqFfHW4ub0AQNK1Q75s2mk+yt
         F7Vg==
X-Gm-Message-State: AOAM533SOGq0H7zhf5JnjS0FwZjRWokdC9o5N00RkQ9VoXQc8z4pG1qa
        fYX5GndFzJDB3+N5nRuxorqi72MI+8oZFsFLKw==
X-Google-Smtp-Source: ABdhPJxz27r9DjmvpUm4cq3s4FsZ2sD1v5l6wb928eYFi8YfoqMrS76pujZwOC+Roy8cQQoLsCsrnHYFZAxxgt/01EE=
X-Received: by 2002:a92:cccd:: with SMTP id u13mr5244910ilq.273.1610134048822;
 Fri, 08 Jan 2021 11:27:28 -0800 (PST)
MIME-Version: 1.0
References: <3d34069ab2d249d866ea1d18a47e4170dbfb5982.1610132102.git.luto@kernel.org>
In-Reply-To: <3d34069ab2d249d866ea1d18a47e4170dbfb5982.1610132102.git.luto@kernel.org>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Fri, 8 Jan 2021 14:27:17 -0500
Message-ID: <CAMzpN2jp-xHz4h6YQFz0MgFixYx4UZACDxBRqQ9OJp1UehsnPw@mail.gmail.com>
Subject: Re: [PATCH] x86/vm86/32: Remove VM86_SCREEN_BITMAP support
To:     Andy Lutomirski <luto@kernel.org>
Cc:     "the arch/x86 maintainers" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linux-MM <linux-mm@kvack.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jann Horn <jannh@google.com>, Jan Kara <jack@suse.cz>,
        Yu Zhao <yuzhao@google.com>, Peter Xu <peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 8, 2021 at 1:59 PM Andy Lutomirski <luto@kernel.org> wrote:
>
> The implementation was rather buggy.  It unconditionally marked PTEs
> read-only, even for VM_SHARED mappings.  I'm not sure whether this is
> actually a problem, but it certainly seems unwise.  More importantly, it
> released the mmap lock before flushing the TLB, which could allow a racing
> CoW operation to falsely believe that the underlying memory was not
> writable.
>
> I can't find any users at all of this mechanism, so just remove it.
>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Linux-MM <linux-mm@kvack.org>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: x86@kernel.org
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Jann Horn <jannh@google.com>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Yu Zhao <yuzhao@google.com>
> Cc: Peter Xu <peterx@redhat.com>
> Signed-off-by: Andy Lutomirski <luto@kernel.org>
> ---
>  arch/x86/include/uapi/asm/vm86.h |  2 +-
>  arch/x86/kernel/vm86_32.c        | 55 ++++++--------------------------
>  2 files changed, 10 insertions(+), 47 deletions(-)
>
> diff --git a/arch/x86/include/uapi/asm/vm86.h b/arch/x86/include/uapi/asm/vm86.h
> index d2ee4e307ef8..50004fb4590d 100644
> --- a/arch/x86/include/uapi/asm/vm86.h
> +++ b/arch/x86/include/uapi/asm/vm86.h
> @@ -106,7 +106,7 @@ struct vm86_struct {
>  /*
>   * flags masks
>   */
> -#define VM86_SCREEN_BITMAP     0x0001
> +#define VM86_SCREEN_BITMAP     0x0001        /* no longer supported */
>
>  struct vm86plus_info_struct {
>         unsigned long force_return_for_pic:1;
> diff --git a/arch/x86/kernel/vm86_32.c b/arch/x86/kernel/vm86_32.c
> index 764573de3996..28b9e8d511e1 100644
> --- a/arch/x86/kernel/vm86_32.c
> +++ b/arch/x86/kernel/vm86_32.c
> @@ -160,49 +160,6 @@ void save_v86_state(struct kernel_vm86_regs *regs, int retval)
>         do_exit(SIGSEGV);
>  }
>
> -static void mark_screen_rdonly(struct mm_struct *mm)
> -{
> -       struct vm_area_struct *vma;
> -       spinlock_t *ptl;
> -       pgd_t *pgd;
> -       p4d_t *p4d;
> -       pud_t *pud;
> -       pmd_t *pmd;
> -       pte_t *pte;
> -       int i;
> -
> -       mmap_write_lock(mm);
> -       pgd = pgd_offset(mm, 0xA0000);
> -       if (pgd_none_or_clear_bad(pgd))
> -               goto out;
> -       p4d = p4d_offset(pgd, 0xA0000);
> -       if (p4d_none_or_clear_bad(p4d))
> -               goto out;
> -       pud = pud_offset(p4d, 0xA0000);
> -       if (pud_none_or_clear_bad(pud))
> -               goto out;
> -       pmd = pmd_offset(pud, 0xA0000);
> -
> -       if (pmd_trans_huge(*pmd)) {
> -               vma = find_vma(mm, 0xA0000);
> -               split_huge_pmd(vma, pmd, 0xA0000);
> -       }
> -       if (pmd_none_or_clear_bad(pmd))
> -               goto out;
> -       pte = pte_offset_map_lock(mm, pmd, 0xA0000, &ptl);
> -       for (i = 0; i < 32; i++) {
> -               if (pte_present(*pte))
> -                       set_pte(pte, pte_wrprotect(*pte));
> -               pte++;
> -       }
> -       pte_unmap_unlock(pte, ptl);
> -out:
> -       mmap_write_unlock(mm);
> -       flush_tlb_mm_range(mm, 0xA0000, 0xA0000 + 32*PAGE_SIZE, PAGE_SHIFT, false);
> -}
> -
> -
> -
>  static int do_vm86_irq_handling(int subfunction, int irqnumber);
>  static long do_sys_vm86(struct vm86plus_struct __user *user_vm86, bool plus);
>
> @@ -282,6 +239,15 @@ static long do_sys_vm86(struct vm86plus_struct __user *user_vm86, bool plus)
>                         offsetof(struct vm86_struct, int_revectored)))
>                 return -EFAULT;
>
> +
> +       /* VM86_SCREEN_BITMAP had numerous bugs and appears to have no users. */
> +       if (v.flags & VM86_SCREEN_BITMAP) {
> +               char comm[TASK_COMM_LEN];
> +
> +               pr_info_once("vm86: '%s' uses VM86_SCREEN_BITMAP, which is no longer supported\n", get_task_comm(comm, current);
> +               return -EINVAL;
> +       }
> +
>         memset(&vm86regs, 0, sizeof(vm86regs));
>
>         vm86regs.pt.bx = v.regs.ebx;
> @@ -370,9 +336,6 @@ static long do_sys_vm86(struct vm86plus_struct __user *user_vm86, bool plus)
>         update_task_stack(tsk);
>         preempt_enable();
>
> -       if (vm86->flags & VM86_SCREEN_BITMAP)
> -               mark_screen_rdonly(tsk->mm);
> -
>         memcpy((struct kernel_vm86_regs *)regs, &vm86regs, sizeof(vm86regs));
>         return regs->ax;
>  }

You can also remove screen_bitmap from struct vm86 (the kernel
internal structure), and the check_v8086_mode() function.

--
Brian Gerst

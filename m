Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD5BA303B0E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 12:05:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404975AbhAZLFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 06:05:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727316AbhAZGFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 01:05:42 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE1EC061573
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 22:05:00 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id y19so31515187iov.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 22:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TI7tBuRKs0bg8oWuQR5b13Rx640yWYP+vhA5wC5N43E=;
        b=WPte/RxocovDgITuE7OvzROaSfhW2YqEZkaJJ4m3+e4JC9GHNG6hCh6kbEUL5J1qJQ
         4SwXITpc+sInBlGgYDGPpfoURkYqd1TpenN/LVRO+mV1weSltrzCRiPS1vIbRHeSsHLy
         e25emuhUm0jRIglzmoSDagkprj9W3u/IZ9V349rCZvl24Wfl3Ax7xyjtYQUOzTe34lyq
         pMGdtzJckfe4eEYdSwY9utH/LuXmtFlcbRIZne1JjIXplYG0kwucnpgufsALUOuOBQWE
         SfxA/By6N1SYyLbYgJS0KQt+nhY0n/S0XYN8pJQwmOQOUmZK5PSUUAAe2OqqbKXE0Bzu
         8QQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TI7tBuRKs0bg8oWuQR5b13Rx640yWYP+vhA5wC5N43E=;
        b=IflLmf14JYO2E1RElkjVMFKAG9Hlgm9cIC9/xuknGtu7/MdxFFKEnT+rGvHrsuXXEW
         s0jpjSKREjb2mUAugifXKcJAzhwI0RhC3SOQN7iWzaqytI4zzxcG9n9JX/FXRmPGe9Qk
         Egy+aYB1tfg2rxF45uE/EOvIHLXA6EU3wYO+F809r6++9VKllAloo0JJWhTzF4KyiFLX
         S8NLxpP/kYlUmY/PLIo9QJXFpBvreGmJiRlxQJordvy5fP0OtbC2hJnfXUMm2dro5iJX
         FRTp9cEpSb9QJPnvEPFqoedKokAYY7Q5qRRo3b/ibs6cSB2XBkdtPcLE3ygQEgPKdpBP
         7WXA==
X-Gm-Message-State: AOAM533HSSYCx+2p8giE86pAW8Ja5dCS8NvSfdgQHwzIVXKstxyoGcfp
        JlKUrphMUuykGrNmUFLSmigVqPoJJM0On2ivcQ==
X-Google-Smtp-Source: ABdhPJyR8uQ8rH4S65DAWBc30RIVb7Y7B+r2uLN/bytJq8mTMPRHp0JC09GNqHbtnSWI95puUIH740lF+5QnNRGFFC0=
X-Received: by 2002:a05:6602:2dcd:: with SMTP id l13mr3030002iow.40.1611641100227;
 Mon, 25 Jan 2021 22:05:00 -0800 (PST)
MIME-Version: 1.0
References: <CALCETrWPnvNr9S2hsxL+pbhNWv0OOL7tBq1XmABPjYK7zZSJbw@mail.gmail.com>
 <20210125173444.22696-1-jiangshanlai@gmail.com> <20210125173444.22696-4-jiangshanlai@gmail.com>
In-Reply-To: <20210125173444.22696-4-jiangshanlai@gmail.com>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Tue, 26 Jan 2021 01:04:48 -0500
Message-ID: <CAMzpN2j6gYGPj07RK3AD9Y6PkZH7ozVLtFvqHiWgW5=7uF4tyg@mail.gmail.com>
Subject: Re: [PATCH V2 3/6] x86_32/sysenter: switch to the task stack without
 emptying the entry stack
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Joerg Roedel <jroedel@suse.de>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Kees Cook <keescook@chromium.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Mike Rapoport <rppt@kernel.org>, Mike Hommey <mh@glandium.org>,
        Mark Gross <mgross@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Anthony Steinhauser <asteinhauser@google.com>,
        Jay Lang <jaytlang@mit.edu>,
        "Chang S. Bae" <chang.seok.bae@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 25, 2021 at 11:35 AM Lai Jiangshan <jiangshanlai@gmail.com> wrote:
>
> From: Lai Jiangshan <laijs@linux.alibaba.com>
>
> Like the way x86_64 uses the "old" stack, we can save the entry stack
> pointer to a register and switch to the task stack.  So that we have
> space on the "old" stack to save more things or scratch registers.
>
> Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
> ---
>  arch/x86/entry/entry_32.S | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
> index 3b4d1a63d1f0..4513702ba45d 100644
> --- a/arch/x86/entry/entry_32.S
> +++ b/arch/x86/entry/entry_32.S
> @@ -905,19 +905,18 @@ SYM_FUNC_START(entry_SYSENTER_32)
>         pushl   %eax
>         BUG_IF_WRONG_CR3 no_user_check=1
>         SWITCH_TO_KERNEL_CR3 scratch_reg=%eax
> -       popl    %eax
> -       popfl
>
> -       /* Stack empty again, switch to task stack */
> -       movl    TSS_entry2task_stack(%esp), %esp
> +       /* Switch to task stack */
> +       movl    %esp, %eax
> +       movl    (2*4+TSS_entry2task_stack)(%esp), %esp
>
>  .Lsysenter_past_esp:
>         pushl   $__USER_DS              /* pt_regs->ss */
>         pushl   $0                      /* pt_regs->sp (placeholder) */
> -       pushfl                          /* pt_regs->flags (except IF = 0) */
> +       pushl   4(%eax)                 /* pt_regs->flags (except IF = 0) */

__KERNEL_DS isn't loaded at this point, so this needs an explicit %ss:
override.  You probably didn't catch this because the default
__USER_DS was still loaded.

>         pushl   $__USER_CS              /* pt_regs->cs */
>         pushl   $0                      /* pt_regs->ip = 0 (placeholder) */
> -       pushl   %eax                    /* pt_regs->orig_ax */
> +       pushl   (%eax)                  /* pt_regs->orig_ax */

Add an %ss: override here too.

>         SAVE_ALL pt_regs_ax=$-ENOSYS    /* save rest, stack already switched */
>
>         /*
> --
> 2.19.1.6.gb485710b
>

--
Brian Gerst

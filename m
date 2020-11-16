Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E90C32B4B12
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 17:30:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732098AbgKPQ2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 11:28:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:55544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730795AbgKPQ2Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 11:28:16 -0500
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF65F22314
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 16:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605544095;
        bh=x3FHK31Xm/BBB7HpLRBIa98x7QEqf275AgxsToa6mkU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dSp2LxJUJ58gcX59eL2xT0qVUTROA6hs+/D6p0wzaVRwjytMTLR0IOaUwLCw0qvV9
         oPxeDEHDRvLSTb6pZKi4znh9AdooQXrCYtwzhXRxhD5nuPb55BqjjPXvLVpCG0M3FD
         iDc77eS+vloBkEmarGAjuhz3e8qNrbVN/RCsAOsE=
Received: by mail-wr1-f42.google.com with SMTP id k2so19384666wrx.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 08:28:14 -0800 (PST)
X-Gm-Message-State: AOAM5306SgW4h/8cCYDHVQNIPY81o1qajXf7jpF8vCfqBusB23Dl0E/B
        yYp2Z6GkIQrRSddoK9JU5KDeWwZNZ2z6POaCVdoPkg==
X-Google-Smtp-Source: ABdhPJyncJCxKduqliOLf7Ic4pClunkNO5+SsixRmuCBm2erhKc8dlxKlGJlIEYjuLvuG7ANk+QxxpsYnP+LvzP3zfc=
X-Received: by 2002:a5d:4991:: with SMTP id r17mr20556285wrq.70.1605544093233;
 Mon, 16 Nov 2020 08:28:13 -0800 (PST)
MIME-Version: 1.0
References: <20201116152301.24558-1-jgross@suse.com> <20201116152301.24558-5-jgross@suse.com>
In-Reply-To: <20201116152301.24558-5-jgross@suse.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 16 Nov 2020 08:28:00 -0800
X-Gmail-Original-Message-ID: <CALCETrW_UO9sksa1agOfs5E7yV+RqOyugEEOBjZY8Z47R-04Pg@mail.gmail.com>
Message-ID: <CALCETrW_UO9sksa1agOfs5E7yV+RqOyugEEOBjZY8Z47R-04Pg@mail.gmail.com>
Subject: Re: [PATCH 4/4] x86/xen: drop USERGS_SYSRET64 paravirt call
To:     Juergen Gross <jgross@suse.com>
Cc:     xen-devel <xen-devel@lists.xenproject.org>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Linux Virtualization <virtualization@lists.linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Deep Shah <sdeep@vmware.com>,
        "VMware, Inc." <pv-drivers@vmware.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 7:23 AM Juergen Gross <jgross@suse.com> wrote:
>
> USERGS_SYSRET64 is used to return from a syscall via sysret, but
> a Xen PV guest will nevertheless use the iret hypercall, as there
> is no sysret PV hypercall defined.
>
> So instead of testing all the prerequisites for doing a sysret and
> then mangling the stack for Xen PV again for doing an iret just use
> the iret exit from the beginning.
>
> This can easily be done via an ALTERNATIVE like it is done for the
> sysenter compat case already.
>
> While at it remove to stale sysret32 remnants.
>
> Signed-off-by: Juergen Gross <jgross@suse.com>

Acked-by: Andy Lutomirski <luto@kernel.org>

FWIW, you've lost the VGCF_in_syscall optimization.  Let me see if I
can give it back to you better.

> ---
>  arch/x86/entry/entry_64.S             | 22 +++++++++-------------
>  arch/x86/include/asm/irqflags.h       |  6 ------
>  arch/x86/include/asm/paravirt.h       |  5 -----
>  arch/x86/include/asm/paravirt_types.h |  8 --------
>  arch/x86/kernel/asm-offsets_64.c      |  2 --
>  arch/x86/kernel/paravirt.c            |  5 +----
>  arch/x86/kernel/paravirt_patch.c      |  4 ----
>  arch/x86/xen/enlighten_pv.c           |  1 -
>  arch/x86/xen/xen-asm.S                | 20 --------------------
>  arch/x86/xen/xen-ops.h                |  2 --
>  10 files changed, 10 insertions(+), 65 deletions(-)
>
> diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
> index a876204a73e0..df865eebd3d7 100644
> --- a/arch/x86/entry/entry_64.S
> +++ b/arch/x86/entry/entry_64.S
> @@ -46,14 +46,6 @@
>  .code64
>  .section .entry.text, "ax"
>
> -#ifdef CONFIG_PARAVIRT_XXL
> -SYM_CODE_START(native_usergs_sysret64)
> -       UNWIND_HINT_EMPTY
> -       swapgs
> -       sysretq
> -SYM_CODE_END(native_usergs_sysret64)
> -#endif /* CONFIG_PARAVIRT_XXL */
> -
>  /*
>   * 64-bit SYSCALL instruction entry. Up to 6 arguments in registers.
>   *
> @@ -123,12 +115,15 @@ SYM_INNER_LABEL(entry_SYSCALL_64_after_hwframe, SYM_L_GLOBAL)
>          * Try to use SYSRET instead of IRET if we're returning to
>          * a completely clean 64-bit userspace context.  If we're not,
>          * go to the slow exit path.
> +        * In the Xen PV case we must use iret anyway.
>          */
> -       movq    RCX(%rsp), %rcx
> -       movq    RIP(%rsp), %r11
>
> -       cmpq    %rcx, %r11      /* SYSRET requires RCX == RIP */
> -       jne     swapgs_restore_regs_and_return_to_usermode
> +       ALTERNATIVE __stringify( \
> +               movq    RCX(%rsp), %rcx; \
> +               movq    RIP(%rsp), %r11; \
> +               cmpq    %rcx, %r11;     /* SYSRET requires RCX == RIP */ \
> +               jne     swapgs_restore_regs_and_return_to_usermode), \
> +       "jmp    swapgs_restore_regs_and_return_to_usermode", X86_FEATURE_XENPV

I'm not in love with this save-a-few-bytes stringify, but I can live with it.

--Andy

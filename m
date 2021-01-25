Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7089B3020A7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 04:04:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbhAYDDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jan 2021 22:03:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:51074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726894AbhAYDBt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jan 2021 22:01:49 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7B4A922472
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 03:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611543659;
        bh=AYqxvGyeiCTBN2q0vDvDSCeZBESw4z+hzzzTHOIy2l8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UuW8gHju+PThwUt1j3FycLZofaROrhSmbHacbZ0fP/EEPO/9BEMq7SUdp2PKNSCKo
         nrwymyj9C4qQTUVaeqtZONvFTAxinluTuCrntQ1Epx/hkW7HC97ET9w5baQdQKO1+X
         ik4hsBTGVFTLsgbe/cZH7AyJNrtkRUjbHoYqGblSkc2OVuW72PPQgib0uyBYTNHDJf
         xL70QbPwdzyIXcPl8yuA1Y4ODK78Q7Z0puxrWprAreojTCP3WvdJjQQLH7SJ4uTa8i
         +J1t+f0m4aWmby4Daq2JmZWHcgnJorbHrS75fnbho39sttucTDoZxs/rm/gi5D6Tn+
         ezztnafwag4iA==
Received: by mail-ed1-f48.google.com with SMTP id f1so13425085edr.12
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jan 2021 19:00:59 -0800 (PST)
X-Gm-Message-State: AOAM531WViP293NNOfQi1V7tcOYeaiwlOfhdcTpINqb3s/wrb/Ksn7Q7
        SsRXL8rLsYNPQf8D85F0ET5wbRyWxlzZUwcOtVWiqg==
X-Google-Smtp-Source: ABdhPJyMw6/j8We7L4+fkmpBHwOPQy6z61Y4/FLsVCPQ8Z/8A+2ZC65f9Ro6yjLZPXBg57OILIfi7PEHjVcKOlyyA1c=
X-Received: by 2002:aa7:d4d2:: with SMTP id t18mr856070edr.238.1611543658089;
 Sun, 24 Jan 2021 19:00:58 -0800 (PST)
MIME-Version: 1.0
References: <20210125021435.16646-1-jiangshanlai@gmail.com>
In-Reply-To: <20210125021435.16646-1-jiangshanlai@gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sun, 24 Jan 2021 19:00:46 -0800
X-Gmail-Original-Message-ID: <CALCETrW1qP=vbHCSdgOLjjP+-i=io3o1w5bMdtH_UHSV3gvBXg@mail.gmail.com>
Message-ID: <CALCETrW1qP=vbHCSdgOLjjP+-i=io3o1w5bMdtH_UHSV3gvBXg@mail.gmail.com>
Subject: Re: [PATCH] x86/entry/64: De-Xen-ify our NMI code further
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 24, 2021 at 5:13 PM Lai Jiangshan <jiangshanlai@gmail.com> wrote:
>
> From: Lai Jiangshan <laijs@linux.alibaba.com>
>
> The commit 929bacec21478("x86/entry/64: De-Xen-ify our NMI code") simplified
> the NMI code by changing paravirt code into native code and left a comment
> about "inspecting RIP instead".  But until now, "inspecting RIP instead"
> has not been made happened and this patch tries to complete it.
>
> Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
> ---
>  arch/x86/entry/entry_64.S | 46 +++++++++++----------------------------
>  1 file changed, 13 insertions(+), 33 deletions(-)
>
> diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
> index cad08703c4ad..cb6b8a6c6652 100644
> --- a/arch/x86/entry/entry_64.S
> +++ b/arch/x86/entry/entry_64.S
> @@ -1268,32 +1268,12 @@ SYM_CODE_START(asm_exc_nmi)
>         je      nested_nmi
>
>         /*
> -        * Now test if the previous stack was an NMI stack.  This covers
> -        * the case where we interrupt an outer NMI after it clears
> -        * "NMI executing" but before IRET.  We need to be careful, though:
> -        * there is one case in which RSP could point to the NMI stack
> -        * despite there being no NMI active: naughty userspace controls
> -        * RSP at the very beginning of the SYSCALL targets.  We can
> -        * pull a fast one on naughty userspace, though: we program
> -        * SYSCALL to mask DF, so userspace cannot cause DF to be set
> -        * if it controls the kernel's RSP.  We set DF before we clear
> -        * "NMI executing".
> +        * Now test if we interrupt an outer NMI after it clears
> +        * "NMI executing" but before iret.

s/interrupt/interrupted

But let's make it a lot more clear:


Now test if we interrupted an outer NMI that just cleared "NMI
executing" and is about to IRET.  This is a single-instruction window.
This check does not handle the case in which we get a nested interrupt
(#MC, #VE, #VC, etc.) after clearing "NMI executing" but before the
outer NMI executes IRET.

> +       movq    $nmi_executing_cleared, %rdx
> +       cmpq    8(%rsp), %rdx
> +       jne     first_nmi

If we're okay with non-PIC code, then this is suboptimal -- you can
just compare directly.  But using PIC is polite, so that movq should
be a RIP-relative leaq.

>
>         /* This is a nested NMI. */
>
> @@ -1438,16 +1418,16 @@ nmi_restore:
>         addq    $6*8, %rsp
>
>         /*
> -        * Clear "NMI executing".  Set DF first so that we can easily
> -        * distinguish the remaining code between here and IRET from
> -        * the SYSCALL entry and exit paths.
> -        *
> -        * We arguably should just inspect RIP instead, but I (Andy) wrote
> -        * this code when I had the misapprehension that Xen PV supported
> -        * NMIs, and Xen PV would break that approach.
> +        * Clear "NMI executing".  It also leaves a window after it before
> +        * iret which should be also considered to be "NMI executing" albeit
> +        * with "NMI executing" variable being zero.  So we should also check
> +        * the RIP after it when checking "NMI executing".  See the code
> +        * before nested_nmi.  No code is allowed to be added to between
> +        * clearing "NMI executing" and iret unless we check a larger window
> +        * with a range of RIPs instead of currently a single-RIP window.

Let's simplify this comment:

Clear "NMI executing".  This leaves a window in which a nested NMI
could observe "NMI executing" cleared, and a nested NMI will detect
this by inspecting RIP.

>          */
> -       std
>         movq    $0, 5*8(%rsp)           /* clear "NMI executing" */
> +nmi_executing_cleared:
>

This should be local.  Let's call it .Lnmi_iret.  And add a comment:

.Lnmi_iret: /* must be immediately after clearing "NMI executing" */

>         /*
>          * iretq reads the "iret" frame and exits the NMI stack in a

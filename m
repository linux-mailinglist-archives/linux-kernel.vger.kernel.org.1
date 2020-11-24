Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3572D2C34C3
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 00:45:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389225AbgKXXno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 18:43:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:42074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730951AbgKXXno (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 18:43:44 -0500
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 433292158C
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 23:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606261423;
        bh=81R0uC28mD9cQqRz+iFDWWYwD1beqYuC/4E9Qn3x48w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eXzLkTuzAcywqYmtVRnrWuE6TrUADzoEzpZuAjoFd7JIvwBIbtosamy/9MYikEXIf
         Lbe19qzlTcM8d8dIwCbb2KAH08sYspKFAHWoP9QFgRmvagvQNDgP153p5dT037N4Cr
         /FvDutcMPMIhD6aeTG1h8Yq1C+kJ94Q80hdh9/cQ=
Received: by mail-wm1-f44.google.com with SMTP id h21so540598wmb.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 15:43:43 -0800 (PST)
X-Gm-Message-State: AOAM533HHR6KPYx8wbz/s/nEMnH23g8b3FGMO/+6kNv6ufCoWipcqLG8
        a45rDD65qjdmDLK6kq0DYrNYoUPy6EP08ewiEigdnQ==
X-Google-Smtp-Source: ABdhPJz1CUQHyPXEoXY2SAeK9AmH7LOiPT3oMQB1xINjzwy7OLDHbR/PV0p57h/RUXxCSq08k0cGRawN2QGIgnLqxPc=
X-Received: by 2002:a1c:7e87:: with SMTP id z129mr786150wmc.176.1606261421865;
 Tue, 24 Nov 2020 15:43:41 -0800 (PST)
MIME-Version: 1.0
References: <20201124002932.1220517-1-dima@arista.com> <20201124002932.1220517-14-dima@arista.com>
In-Reply-To: <20201124002932.1220517-14-dima@arista.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 24 Nov 2020 15:43:30 -0800
X-Gmail-Original-Message-ID: <CALCETrW3=jegCtJP-wbcKk3QrcYGTk82rJGqe-5E_RC+NQRLpw@mail.gmail.com>
Message-ID: <CALCETrW3=jegCtJP-wbcKk3QrcYGTk82rJGqe-5E_RC+NQRLpw@mail.gmail.com>
Subject: Re: [PATCH v2 13/19] x86/signal: Check if vdso_image_32 is mapped
 before trying to land on it
To:     Dmitry Safonov <dima@arista.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Guo Ren <guoren@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>, X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 23, 2020 at 4:29 PM Dmitry Safonov <dima@arista.com> wrote:
>
> Provide current_has_vdso_image_32() helper and check it apriory landing
> attempt on vdso vma.
> The helper is a macro, not a static inline funciton to avoid
> linux/sched/task_stack.h inclusion in asm/vdso.h.

Can you make this more general?  For example:

current_has_vdso(&vdso_image_whatever)

also:

> diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
> index 18d8f17f755c..d9ab58cc765b 100644
> --- a/arch/x86/entry/common.c
> +++ b/arch/x86/entry/common.c
> @@ -142,11 +142,16 @@ static noinstr bool __do_fast_syscall_32(struct pt_regs *regs)
>  /* Returns 0 to return using IRET or 1 to return using SYSEXIT/SYSRETL. */
>  __visible noinstr long do_fast_syscall_32(struct pt_regs *regs)
>  {
> +       unsigned long landing_pad;
> +
> +       if (!current_has_vdso_image_32())
> +               force_sigsegv(SIGSEGV);

Falling through seems incorrect here.  I would instead write 0 to rip,
do the force_sigsegv(), and exit, making sure that exiting goes
through the correct path.

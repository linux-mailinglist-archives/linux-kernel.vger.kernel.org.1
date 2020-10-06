Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB61028534B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 22:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbgJFUjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 16:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727166AbgJFUjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 16:39:04 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05BDDC0613D2
        for <linux-kernel@vger.kernel.org>; Tue,  6 Oct 2020 13:39:04 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id y20so14473399iod.5
        for <linux-kernel@vger.kernel.org>; Tue, 06 Oct 2020 13:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aP26k3iPNr1VpqvkggYcdxciq5A3h6k+A8ZkkiVk+vE=;
        b=ZS2TGe3M6BM2pCGvzZsvuQhQScVUluOJsnRH1r5i7A7P6n2UP7siMbluTKbkh4+efU
         UbqSZZ+fZQFwAS4BzVTQ+ar++o7dmdlQJ22yy7Dy/lTn9yWkfYz7e1qZyE9eKgBE3HSs
         q2vSZxGTu1hN+p8wF+jDAJ+KtO9L8yLq2iLt8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aP26k3iPNr1VpqvkggYcdxciq5A3h6k+A8ZkkiVk+vE=;
        b=K/9eWk79bSgY9MFlOC6tStORuYau50huW7+8hDajXgoV8jUPjNbK7waxXHPIylC4i1
         Gs/ZFRzSziVpiEuJguwabEtitMkFhVIu4mHdb08OheDWkRuxAK6vNaRhyIpxT750cFzJ
         ENzNCgPrETfCJkkTwlKiK8vaDmf60LCJxSo+URCfRZ4Ag3pysozmneueSi+30Q8nShAi
         nnvn5+2CWSvDv8wi0owixrvYP6r+1zg6bmr3XtxK1TiwWZ2rAAxdJbJnTlaQ/YiLuW/S
         IrMkmtqh0O4Maztsi+yZ1ZHVE4EwmPmkjZpXix+FbkpNOxvfRd1zLC4X6Y/6RBQt2J2D
         p4zw==
X-Gm-Message-State: AOAM5308IjC4ZYCXfNn6p6jTgxwNy5gpO0sVr2K+usUxwl+ARx+O6GUo
        27gOuwzYwMKyM6yXHGCXbdNmPgE0veaZMJtqdXqB
X-Google-Smtp-Source: ABdhPJw+FN3XoT0rxMl6Ve49NN7RdklCAzgoNyZ08hcLaNGIRm+nAoOXgbR9257x0DX6r58+AhI1DeDfnRtTGG/ffQA=
X-Received: by 2002:a5d:9842:: with SMTP id p2mr2700429ios.113.1602016743286;
 Tue, 06 Oct 2020 13:39:03 -0700 (PDT)
MIME-Version: 1.0
References: <1593266228-61125-1-git-send-email-guoren@kernel.org>
 <1593266228-61125-2-git-send-email-guoren@kernel.org> <20200911204512.GA2705@aurel32.net>
 <CAJF2gTQiLV8sDE5cnvP=aBog4zaiMvMeieg_JtXwRODky1u3Hg@mail.gmail.com>
 <20200914103836.GB2705@aurel32.net> <87lfgzeidk.fsf@igel.home>
 <CAJF2gTQ8ONde3GRhQgx2Nqvb5X20nTmW8jZEemZKhezRDzP3aQ@mail.gmail.com>
 <CAOnJCUJhb2K89pRETbfTJ=5jHQhWfyfrOUu8zOE77j+id6OpSA@mail.gmail.com> <CAJF2gTRc-RUBiQ=ZE7BT8tABHu3=Bcmuc+ADyBLZ7r7fozwahg@mail.gmail.com>
In-Reply-To: <CAJF2gTRc-RUBiQ=ZE7BT8tABHu3=Bcmuc+ADyBLZ7r7fozwahg@mail.gmail.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Tue, 6 Oct 2020 13:38:52 -0700
Message-ID: <CAOnJCUKi-bzEvYWw3BxBbGe6ODHEzdjTWsfrmS54qEk1i1Kr8Q@mail.gmail.com>
Subject: Re: [PATCH V2 1/3] riscv: Fixup static_obj() fail
To:     Guo Ren <guoren@kernel.org>
Cc:     Andreas Schwab <schwab@linux-m68k.org>,
        Tycho Andersen <tycho@tycho.ws>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nick Hu <nickhu@andestech.com>,
        Anup Patel <anup@brainfault.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>,
        Zong Li <zong.li@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 6, 2020 at 9:46 AM Guo Ren <guoren@kernel.org> wrote:
>
> On Tue, Oct 6, 2020 at 3:14 AM Atish Patra <atishp@atishpatra.org> wrote:
> >
> > On Thu, Sep 24, 2020 at 9:19 AM Guo Ren <guoren@kernel.org> wrote:
> > >
> > > How about this, revert the commit and don't free INIT_DATA_SECTION. I
> > > think the solution is safe enough, but wast a little memory.
> > >
> > > diff --git a/arch/riscv/kernel/vmlinux.lds.S b/arch/riscv/kernel/vmlinux.lds.S
> > > index f3586e3..34d00d9 100644
> > > --- a/arch/riscv/kernel/vmlinux.lds.S
> > > +++ b/arch/riscv/kernel/vmlinux.lds.S
> > > @@ -22,13 +22,11 @@ SECTIONS
> > >         /* Beginning of code and text segment */
> > >         . = LOAD_OFFSET;
> > >         _start = .;
> > > -       _stext = .;
> > >         HEAD_TEXT_SECTION
> > >         . = ALIGN(PAGE_SIZE);
> > >
> > >         __init_begin = .;
> > >         INIT_TEXT_SECTION(PAGE_SIZE)
> > > -       INIT_DATA_SECTION(16)
> > >         . = ALIGN(8);
> > >         __soc_early_init_table : {
> > >                 __soc_early_init_table_start = .;
> > > @@ -55,6 +53,7 @@ SECTIONS
> > >         . = ALIGN(SECTION_ALIGN);
> > >         .text : {
> > >                 _text = .;
> > > +               _stext = .;
> > >                 TEXT_TEXT
> > >                 SCHED_TEXT
> > >                 CPUIDLE_TEXT
> > > @@ -67,6 +66,8 @@ SECTIONS
> > >                 _etext = .;
> > >         }
> > >
> > > +       INIT_DATA_SECTION(16)
> > > +
> >
> > I think you need to move EXIT_DATA as well. Currently, we have init
> > data & text in one section.
> It's not related to this issue. There is two check code problem:

Yes. But we shouldn't move only INIT_DATA_SECTION out of __init section
while leaving percpu & exit data in the __init section. Here is what I
have in mind.

diff --git a/arch/riscv/kernel/vmlinux.lds.S
b/arch/riscv/kernel/vmlinux.lds.S
index 9795359cb9da..4432cef8184e 100644
--- a/arch/riscv/kernel/vmlinux.lds.S
+++ b/arch/riscv/kernel/vmlinux.lds.S
@@ -26,13 +26,11 @@ SECTIONS
        /* Beginning of code and text segment */
        . = LOAD_OFFSET;
        _start = .;
        _start = .;
-       _stext = .;
        HEAD_TEXT_SECTION
        . = ALIGN(PAGE_SIZE);

        __init_begin = .;
        INIT_TEXT_SECTION(PAGE_SIZE)
-       INIT_DATA_SECTION(16)
        . = ALIGN(8);
        __soc_early_init_table : {
                __soc_early_init_table_start = .;
@@ -49,16 +47,13 @@ SECTIONS
        {
                EXIT_TEXT
        }
-       .exit.data :
-       {
-               EXIT_DATA
-       }
-       PERCPU_SECTION(L1_CACHE_BYTES)
+
        __init_end = .;

        . = ALIGN(SECTION_ALIGN);
        .text : {
                _text = .;
+               _stext = .;
                TEXT_TEXT
                SCHED_TEXT
                CPUIDLE_TEXT
@@ -77,6 +72,17 @@ SECTIONS
 #endif

        /* Start of data section */
+       __init_data_begin = .;
+       INIT_DATA_SECTION(16)
+       .exit.data :
+       {
+               EXIT_DATA
+       }
+
+       PERCPU_SECTION(L1_CACHE_BYTES)
+
+       __init_data_end = .;
+

As you correctly pointed out, this wastes around ~200K init memory
that is wasted.
That is not an ideal solution.

The other alternative is to move __init_text section after _text as
well similar to other architectures. But that won't work
for RISC-V as we jump from _start to __start_kernel(in __init section)
in head.S.  A JAL instruction can't be fit because
__start_kernel is now too far. We can't replace JAL with a JALR
because that would require an additional
instruction and violates image header format.

Any other ideas to solve this problem without wasting memory ?

>  1.     static int static_obj(const void *obj)
>     {
>             unsigned long start = (unsigned long) &_stext,
>                           end   = (unsigned long) &_end,
>                           addr  = (unsigned long) obj;
>
>             /*
>              * static variable?
>              */
>             if ((addr >= start) && (addr < end))
>                     return 1;
>
>  2.     /* Is this address range in the kernel text area? */
>     static inline void check_kernel_text_object(const unsigned long ptr,
>                                                 unsigned long n, bool to_user)
>     {
>             unsigned long textlow = (unsigned long)_stext;
>             unsigned long texthigh = (unsigned long)_etext;
>             unsigned long textlow_linear, texthigh_linear;
>
>             if (overlaps(ptr, n, textlow, texthigh))
>                     usercopy_abort("kernel text", NULL, to_user, ptr -
> textlow, n);
>
> The patch of commit: a0fa4027dc911 (riscv: Fixup static_obj() fail) broke 2th.
>
> > In general it is better idea to separate those similar to ARM64.
> > Additionally, ARM64 applies different mapping for init data & text
> > as the init data section is marked as non-executable[1]
> Yes, it's safer to protect init text & init data, but it's should be
> another patch.
>

Yes. I will send the patch based on this fix.

> >
> > However, we don't modify any permission for any init sections. Should
> > we do that as well ?
> Agree, we should do that.
>
> >
> > [1] https://patchwork.kernel.org/patch/9572869/
> >
> > >         /* Start of data section */
> > >         _sdata = .;
> > >         RO_DATA(SECTION_ALIGN)
> > >
> > > On Thu, Sep 24, 2020 at 3:36 PM Andreas Schwab <schwab@linux-m68k.org> wrote:
> > > >
> > > > On Sep 14 2020, Aurelien Jarno wrote:
> > > >
> > > > > How should we proceed to get that fixed in time for 5.9? For the older
> > > > > branches where it has been backported (so far 5.7 and 5.8), should we
> > > > > just get that commit reverted instead?
> > > >
> > > > Can this please be resolved ASAP?
> > > >
> > > > Andreas.
> > > >
> > > > --
> > > > Andreas Schwab, schwab@linux-m68k.org
> > > > GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
> > > > "And now for something completely different."
> > >
> > >
> > >
> > > --
> > > Best Regards
> > >  Guo Ren
> > >
> > > ML: https://lore.kernel.org/linux-csky/
> > >
> > > _______________________________________________
> > > linux-riscv mailing list
> > > linux-riscv@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-riscv
> >
> >
> >
> > --
> > Regards,
> > Atish
>
>
>
> --
> Best Regards
>  Guo Ren
>
> ML: https://lore.kernel.org/linux-csky/



-- 
Regards,
Atish

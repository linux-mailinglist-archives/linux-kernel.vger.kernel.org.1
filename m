Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7365285023
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 18:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbgJFQqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 12:46:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:60226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725769AbgJFQqz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 12:46:55 -0400
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42E4E207EA;
        Tue,  6 Oct 2020 16:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602002814;
        bh=6N+wobMAF8IDk/3qDidkLTePM+37ZvHyxc4HmXmoJ1c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BF9Y+dblnnqOoSkiL8Cu4L+HICS17ElwDmAcgBEhWIW0dK9tYf7dz5YiIFggv2lR4
         R4wad3CFaPcdR0am35OTcuG7bD1vJOrcwe6UAF3WYDnrwhsy9aiA1tpcbgfA+yaxIc
         qEsTKDBh+N3Os2f049MjERzQ03NlRgf/RBsOK5nY=
Received: by mail-lf1-f49.google.com with SMTP id y11so15803890lfl.5;
        Tue, 06 Oct 2020 09:46:54 -0700 (PDT)
X-Gm-Message-State: AOAM531MSPkdIT025t2CfGjU9lWE7Rj7MD5NanQgv9bfiFd7bzsSJHEB
        z8nu4jBQmz2m/nw5QGtYjKXHVDYzA23TTYv3ono=
X-Google-Smtp-Source: ABdhPJwtmt0yVvix028cPsVw2WUiutEQ6nut7CVVXsWMH1AsUC4wFfHGzamo+vtertKc8n/lduNuaP6Rc5riToZ+vuI=
X-Received: by 2002:a19:7508:: with SMTP id y8mr771313lfe.540.1602002812413;
 Tue, 06 Oct 2020 09:46:52 -0700 (PDT)
MIME-Version: 1.0
References: <1593266228-61125-1-git-send-email-guoren@kernel.org>
 <1593266228-61125-2-git-send-email-guoren@kernel.org> <20200911204512.GA2705@aurel32.net>
 <CAJF2gTQiLV8sDE5cnvP=aBog4zaiMvMeieg_JtXwRODky1u3Hg@mail.gmail.com>
 <20200914103836.GB2705@aurel32.net> <87lfgzeidk.fsf@igel.home>
 <CAJF2gTQ8ONde3GRhQgx2Nqvb5X20nTmW8jZEemZKhezRDzP3aQ@mail.gmail.com> <CAOnJCUJhb2K89pRETbfTJ=5jHQhWfyfrOUu8zOE77j+id6OpSA@mail.gmail.com>
In-Reply-To: <CAOnJCUJhb2K89pRETbfTJ=5jHQhWfyfrOUu8zOE77j+id6OpSA@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 7 Oct 2020 00:46:40 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRc-RUBiQ=ZE7BT8tABHu3=Bcmuc+ADyBLZ7r7fozwahg@mail.gmail.com>
Message-ID: <CAJF2gTRc-RUBiQ=ZE7BT8tABHu3=Bcmuc+ADyBLZ7r7fozwahg@mail.gmail.com>
Subject: Re: [PATCH V2 1/3] riscv: Fixup static_obj() fail
To:     Atish Patra <atishp@atishpatra.org>
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

On Tue, Oct 6, 2020 at 3:14 AM Atish Patra <atishp@atishpatra.org> wrote:
>
> On Thu, Sep 24, 2020 at 9:19 AM Guo Ren <guoren@kernel.org> wrote:
> >
> > How about this, revert the commit and don't free INIT_DATA_SECTION. I
> > think the solution is safe enough, but wast a little memory.
> >
> > diff --git a/arch/riscv/kernel/vmlinux.lds.S b/arch/riscv/kernel/vmlinux.lds.S
> > index f3586e3..34d00d9 100644
> > --- a/arch/riscv/kernel/vmlinux.lds.S
> > +++ b/arch/riscv/kernel/vmlinux.lds.S
> > @@ -22,13 +22,11 @@ SECTIONS
> >         /* Beginning of code and text segment */
> >         . = LOAD_OFFSET;
> >         _start = .;
> > -       _stext = .;
> >         HEAD_TEXT_SECTION
> >         . = ALIGN(PAGE_SIZE);
> >
> >         __init_begin = .;
> >         INIT_TEXT_SECTION(PAGE_SIZE)
> > -       INIT_DATA_SECTION(16)
> >         . = ALIGN(8);
> >         __soc_early_init_table : {
> >                 __soc_early_init_table_start = .;
> > @@ -55,6 +53,7 @@ SECTIONS
> >         . = ALIGN(SECTION_ALIGN);
> >         .text : {
> >                 _text = .;
> > +               _stext = .;
> >                 TEXT_TEXT
> >                 SCHED_TEXT
> >                 CPUIDLE_TEXT
> > @@ -67,6 +66,8 @@ SECTIONS
> >                 _etext = .;
> >         }
> >
> > +       INIT_DATA_SECTION(16)
> > +
>
> I think you need to move EXIT_DATA as well. Currently, we have init
> data & text in one section.
It's not related to this issue. There is two check code problem:
 1.     static int static_obj(const void *obj)
    {
            unsigned long start = (unsigned long) &_stext,
                          end   = (unsigned long) &_end,
                          addr  = (unsigned long) obj;

            /*
             * static variable?
             */
            if ((addr >= start) && (addr < end))
                    return 1;

 2.     /* Is this address range in the kernel text area? */
    static inline void check_kernel_text_object(const unsigned long ptr,
                                                unsigned long n, bool to_user)
    {
            unsigned long textlow = (unsigned long)_stext;
            unsigned long texthigh = (unsigned long)_etext;
            unsigned long textlow_linear, texthigh_linear;

            if (overlaps(ptr, n, textlow, texthigh))
                    usercopy_abort("kernel text", NULL, to_user, ptr -
textlow, n);

The patch of commit: a0fa4027dc911 (riscv: Fixup static_obj() fail) broke 2th.

> In general it is better idea to separate those similar to ARM64.
> Additionally, ARM64 applies different mapping for init data & text
> as the init data section is marked as non-executable[1]
Yes, it's safer to protect init text & init data, but it's should be
another patch.

>
> However, we don't modify any permission for any init sections. Should
> we do that as well ?
Agree, we should do that.

>
> [1] https://patchwork.kernel.org/patch/9572869/
>
> >         /* Start of data section */
> >         _sdata = .;
> >         RO_DATA(SECTION_ALIGN)
> >
> > On Thu, Sep 24, 2020 at 3:36 PM Andreas Schwab <schwab@linux-m68k.org> wrote:
> > >
> > > On Sep 14 2020, Aurelien Jarno wrote:
> > >
> > > > How should we proceed to get that fixed in time for 5.9? For the older
> > > > branches where it has been backported (so far 5.7 and 5.8), should we
> > > > just get that commit reverted instead?
> > >
> > > Can this please be resolved ASAP?
> > >
> > > Andreas.
> > >
> > > --
> > > Andreas Schwab, schwab@linux-m68k.org
> > > GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
> > > "And now for something completely different."
> >
> >
> >
> > --
> > Best Regards
> >  Guo Ren
> >
> > ML: https://lore.kernel.org/linux-csky/
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
>
>
>
> --
> Regards,
> Atish



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/

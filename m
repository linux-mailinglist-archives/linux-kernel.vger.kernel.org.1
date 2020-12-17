Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86BAF2DCDB0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 09:35:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727353AbgLQIeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 03:34:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726569AbgLQIeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 03:34:20 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B294EC0617A7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 00:33:39 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id x15so25154019ilq.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 00:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DUte5MZb3VgmcVGjhmZGHO+sbeoQVX9ioF310lk1DlM=;
        b=sTA4NLIAZ6ZSRkLiJJDaYIwt+a0K9pKODxKCrc3xUiXv6exsXJ2CGMHUEK3+vLuL/O
         i7nD0VF5A/5MTADxkf/ZykzVwz+y/twHQKWqudTU662Y2lQ3xI0H5WBCjx8V/EDPeIGR
         XQIFrh0jLpMUVPpMFXVc4mxTS4DlAk00uM/og=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DUte5MZb3VgmcVGjhmZGHO+sbeoQVX9ioF310lk1DlM=;
        b=V0ULYF7WKy1FjuUT/Tbrigy6RHdQ51ajcerKKtGt0ls6yCZjtsHFZxY8SCltJzW/QB
         t6cYxYskVsBKPOa1fhAcQqHD+Y4VORz1wpdlyHEXh6V4AQZu4ld8nZmgH6H2qU/0G2h0
         v7Gv4XkSsJU9JRue8H46DRMs5N/w/rvnHXuP3q66IdcWDvtG0KZqBc5haAsRPt4h0D/W
         d88Z7HpMfMsSOF5FVm2zV4YkzEeTJ5A7jkySX1MsNN24eqgqLTSE9kpvMHErDe7QUmid
         9MfjO8fzigCHFJY0rh+pDFplLFs2I0hHL27DSR14q73bIbZfHqMlAEwgo7fn383Ost0p
         iQ/A==
X-Gm-Message-State: AOAM530DNUQyHJ44o/dPd9dzlyZ2PYJPQmlanLjjJ89MxmdUeRGHFkoc
        i4Y060khYZHoY3Xtywpcb2sZhqpSs3UYwlpWJWqX
X-Google-Smtp-Source: ABdhPJzt31wK+zmuokHE1Cu7YvCT4RhK78rmt7+i93T60Wfs0RAnKDae02C8YXuPWWHsEVCYpQG1FXdYnnpxHiaqYC8=
X-Received: by 2002:a92:d84a:: with SMTP id h10mr47844317ilq.77.1608194018942;
 Thu, 17 Dec 2020 00:33:38 -0800 (PST)
MIME-Version: 1.0
References: <mhng-5b9a6df7-f6a2-4db8-aaf9-b4e89115522d@palmerdabbelt-glaptop> <mhng-ec25b026-f312-4d65-9afb-1c34a5cac6c7@palmerdabbelt-glaptop>
In-Reply-To: <mhng-ec25b026-f312-4d65-9afb-1c34a5cac6c7@palmerdabbelt-glaptop>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Thu, 17 Dec 2020 00:33:28 -0800
Message-ID: <CAOnJCUJ4Z6wGQMy+7ELMNxRby5joe_U+9zjO66cmXGHKHkzLsg@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] RISC-V: Align the .init.text section
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Alistair Francis <Alistair.Francis@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Zong Li <zong.li@sifive.com>, Anup Patel <anup@brainfault.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Atish Patra <Atish.Patra@wdc.com>, ren_guo@c-sky.com,
        Paul Walmsley <paul.walmsley@sifive.com>, ojeda@kernel.org,
        Greentime Hu <greentime.hu@sifive.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michel Lespinasse <walken@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mike Rapoport <rppt@kernel.org>, Jim Wilson <jimw@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 16, 2020 at 10:51 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> On Tue, 15 Dec 2020 22:02:54 PST (-0800), Palmer Dabbelt wrote:
> > On Wed, 04 Nov 2020 16:04:37 PST (-0800), Atish Patra wrote:
> >> In order to improve kernel text protection, we need separate .init.text/
> >> .init.data/.text in separate sections. However, RISC-V linker relaxation
> >> code is not aware of any alignment between sections. As a result, it may
> >> relax any RISCV_CALL relocations between sections to JAL without realizing
> >> that an inter section alignment may move the address farther. That may
> >> lead to a relocation truncated fit error. However, linker relaxation code
> >> is aware of the individual section alignments.
> >>
> >> The detailed discussion on this issue can be found here.
> >> https://github.com/riscv/riscv-gnu-toolchain/issues/738
> >>
> >> Keep the .init.text section aligned so that linker relaxation will take
> >> that as a hint while relaxing inter section calls.
> >> Here are the code size changes for each section because of this change.
> >>
> >> section         change in size (in bytes)
> >>   .head.text      +4
> >>   .text           +40
> >>   .init.text      +6530
> >>   .exit.text      +84
> >>
> >> The only significant increase in size happened for .init.text because
> >> all intra relocations also use 2MB alignment.
> >>
> >> Suggested-by: Jim Wilson <jimw@sifive.com>
> >> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> >> ---
> >>  arch/riscv/kernel/vmlinux.lds.S | 8 +++++++-
> >>  1 file changed, 7 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/arch/riscv/kernel/vmlinux.lds.S b/arch/riscv/kernel/vmlinux.lds.S
> >> index 3ffbd6cbdb86..cacd7898ba7f 100644
> >> --- a/arch/riscv/kernel/vmlinux.lds.S
> >> +++ b/arch/riscv/kernel/vmlinux.lds.S
> >> @@ -30,7 +30,13 @@ SECTIONS
> >>      . = ALIGN(PAGE_SIZE);
> >>
> >>      __init_begin = .;
> >> -    INIT_TEXT_SECTION(PAGE_SIZE)
> >> +    __init_text_begin = .;
> >> +    .init.text : AT(ADDR(.init.text) - LOAD_OFFSET) ALIGN(SECTION_ALIGN) { \
> >> +            _sinittext = .;                                         \
> >> +            INIT_TEXT                                               \
> >> +            _einittext = .;                                         \
> >> +    }
> >> +
> >>      . = ALIGN(8);
> >>      __soc_early_init_table : {
> >>              __soc_early_init_table_start = .;
> >
> > Not sure what's going on here (or why I wasn't catching it earlier), but this
> > is breaking boot on one of my test configs.  I'm not getting any Linux boot
> > spew, so it's something fairly early.  I'm running defconfig with
> >
> >     CONFIG_PREEMPT=y
> >     CONFIG_DEBUG_PREEMPT=y
> >     CONFIG_PROVE_LOCKING=y
> >
> > It looks like that's been throwing a bunch of warnings for a while, but it did
> > at least used to boot.  No idea what PREEMPT would have to do with this, and
> > the other two don't generally trigger issues that early in boot (or at least,
> > trigger halts that early in boot).
> >
> > There's a bunch of other stuff that depends on this that's on for-next so I
> > don't want to just drop it, but I also don't want to break something.  I'm just
> > running QEMU's virt board.
> >

I just verified for-next on QEMU 5.2.0 for virt (RV32,64, nommu) and
sifive_u as well.
I will give it a try on unleashed tomorrow as well with the above
configs enabled.

> > I'll take a look again tomorrow night, but if anyone has some time to look
> > that'd be great!
>
> Looks like this breaks on QEMU 5.0.0 but works on 5.2.0.

I will take a look tomorrow to check the root cause.

I guess technically
> that means could be considered a regression, but as we don't really have any
> scheme for which old versions of QEMU we support it's not absolute.  I'd
> usually err on the side of keeping support for older platforms, but in this
> case it's probably just not worth the time so I'm going to just ignore it.
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv



-- 
Regards,
Atish

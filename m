Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7BAA2DDF79
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 09:21:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732953AbgLRIUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 03:20:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728205AbgLRIUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 03:20:01 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8E3DC0617A7
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 00:19:20 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id q137so1269771iod.9
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 00:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wbYyQM6vtKWNhmgXfVNxNU4dmNtH9tEakno/EFx2YII=;
        b=OcRRb/edb5SR6Ck+a0GNJ7PpPo+T4peiyPGdloGi/6MEwBYDjiV5wV1ZJvTmIb0TYj
         2nn34SNBSUwqgRzfcewN7/IRn25Sb+G3740O0Js5/0pGGjWmoYyg0spKe0d6zg4qntON
         CmdZXbdGIohyTxWEcsvVHtYbHJuJ2ig6Ay/BU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wbYyQM6vtKWNhmgXfVNxNU4dmNtH9tEakno/EFx2YII=;
        b=e21+vLm+1xRct/YeLVvJ4Y+zFChAjk+npryqJzqaTbZjB9YMgNUTnrR8+gkcfM2zxh
         JHINdmoJ7G4icO/IN2I6l6PhWoudgICqcwogIKzLyCYAFkY76m8zOXNQVBFpwiIBhbW2
         +0t0piTnYFxwNSh2MTdSjJ25v7PxQgmXSGQlwUig11aUBTvk1u4Gy7PCh9IOeqb+2O+P
         CCy4fMcJjisVCccDK3LEhUYOjAJaLDXuHLWn1UD32K2pL7KuCeBqvUB43P9JH7xw3a1e
         uOd0NyuNx9Yk+O9npVqV/ZL/NhA5txGjIGGT/DOFWNhP9XgXK+ykF/Ro1cQhCPSvtxvq
         hesA==
X-Gm-Message-State: AOAM532gLZCfpuLMxGA/W+tRybRISl/GKXD25qRumnm62tRkqqpKw8jp
        BuSLcz6Gu12qYnzooe9D+3M62M5BZu6XkOEuW2yS
X-Google-Smtp-Source: ABdhPJwCeiX8EZg1KH2LuIpOgY56YucZ10eRZmZW3kO0I9xPXVG97rfReKbx4zYoHyPKHM8Uuf0EC2OWNFpc+R7/qq8=
X-Received: by 2002:a05:6602:20ca:: with SMTP id 10mr2805554ioz.51.1608279560083;
 Fri, 18 Dec 2020 00:19:20 -0800 (PST)
MIME-Version: 1.0
References: <mhng-5b9a6df7-f6a2-4db8-aaf9-b4e89115522d@palmerdabbelt-glaptop>
 <mhng-ec25b026-f312-4d65-9afb-1c34a5cac6c7@palmerdabbelt-glaptop> <CAOnJCUJ4Z6wGQMy+7ELMNxRby5joe_U+9zjO66cmXGHKHkzLsg@mail.gmail.com>
In-Reply-To: <CAOnJCUJ4Z6wGQMy+7ELMNxRby5joe_U+9zjO66cmXGHKHkzLsg@mail.gmail.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Fri, 18 Dec 2020 00:19:09 -0800
Message-ID: <CAOnJCU+T3QcZbC0N5h0+916=V-8NSp2O7eZ83F-AUJf5-cTx5A@mail.gmail.com>
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

On Thu, Dec 17, 2020 at 12:33 AM Atish Patra <atishp@atishpatra.org> wrote:
>
> On Wed, Dec 16, 2020 at 10:51 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
> >
> > On Tue, 15 Dec 2020 22:02:54 PST (-0800), Palmer Dabbelt wrote:
> > > On Wed, 04 Nov 2020 16:04:37 PST (-0800), Atish Patra wrote:
> > >> In order to improve kernel text protection, we need separate .init.text/
> > >> .init.data/.text in separate sections. However, RISC-V linker relaxation
> > >> code is not aware of any alignment between sections. As a result, it may
> > >> relax any RISCV_CALL relocations between sections to JAL without realizing
> > >> that an inter section alignment may move the address farther. That may
> > >> lead to a relocation truncated fit error. However, linker relaxation code
> > >> is aware of the individual section alignments.
> > >>
> > >> The detailed discussion on this issue can be found here.
> > >> https://github.com/riscv/riscv-gnu-toolchain/issues/738
> > >>
> > >> Keep the .init.text section aligned so that linker relaxation will take
> > >> that as a hint while relaxing inter section calls.
> > >> Here are the code size changes for each section because of this change.
> > >>
> > >> section         change in size (in bytes)
> > >>   .head.text      +4
> > >>   .text           +40
> > >>   .init.text      +6530
> > >>   .exit.text      +84
> > >>
> > >> The only significant increase in size happened for .init.text because
> > >> all intra relocations also use 2MB alignment.
> > >>
> > >> Suggested-by: Jim Wilson <jimw@sifive.com>
> > >> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> > >> ---
> > >>  arch/riscv/kernel/vmlinux.lds.S | 8 +++++++-
> > >>  1 file changed, 7 insertions(+), 1 deletion(-)
> > >>
> > >> diff --git a/arch/riscv/kernel/vmlinux.lds.S b/arch/riscv/kernel/vmlinux.lds.S
> > >> index 3ffbd6cbdb86..cacd7898ba7f 100644
> > >> --- a/arch/riscv/kernel/vmlinux.lds.S
> > >> +++ b/arch/riscv/kernel/vmlinux.lds.S
> > >> @@ -30,7 +30,13 @@ SECTIONS
> > >>      . = ALIGN(PAGE_SIZE);
> > >>
> > >>      __init_begin = .;
> > >> -    INIT_TEXT_SECTION(PAGE_SIZE)
> > >> +    __init_text_begin = .;
> > >> +    .init.text : AT(ADDR(.init.text) - LOAD_OFFSET) ALIGN(SECTION_ALIGN) { \
> > >> +            _sinittext = .;                                         \
> > >> +            INIT_TEXT                                               \
> > >> +            _einittext = .;                                         \
> > >> +    }
> > >> +
> > >>      . = ALIGN(8);
> > >>      __soc_early_init_table : {
> > >>              __soc_early_init_table_start = .;
> > >
> > > Not sure what's going on here (or why I wasn't catching it earlier), but this
> > > is breaking boot on one of my test configs.  I'm not getting any Linux boot
> > > spew, so it's something fairly early.  I'm running defconfig with
> > >
> > >     CONFIG_PREEMPT=y
> > >     CONFIG_DEBUG_PREEMPT=y
> > >     CONFIG_PROVE_LOCKING=y
> > >
> > > It looks like that's been throwing a bunch of warnings for a while, but it did
> > > at least used to boot.  No idea what PREEMPT would have to do with this, and
> > > the other two don't generally trigger issues that early in boot (or at least,
> > > trigger halts that early in boot).
> > >

I am able to reproduce this issue but with CONFIG_PROVE_LOCKING not
CONFIG_PREEMPT.
With CONFIG_PREEMPT, I see a bunch of warnings around smp_processor_id
but it boots even with 5.0.
If CONFIG_PROVE_LOCKING is enabled, I am not able to boot using 5.0.
However, 5.2.0 works fine.
I am going to take a look at the issue with 5.0 and PROVE_LOCKING.

The config preempt warnings are resolved by the following patch. I
have tested it in Qemu.

https://patchwork.kernel.org/project/linux-riscv/patch/20201116081238.44223-1-wangkefeng.wang@huawei.com/

> > > There's a bunch of other stuff that depends on this that's on for-next so I
> > > don't want to just drop it, but I also don't want to break something.  I'm just
> > > running QEMU's virt board.
> > >
>
> I just verified for-next on QEMU 5.2.0 for virt (RV32,64, nommu) and
> sifive_u as well.
> I will give it a try on unleashed tomorrow as well with the above
> configs enabled.
>
> > > I'll take a look again tomorrow night, but if anyone has some time to look
> > > that'd be great!
> >
> > Looks like this breaks on QEMU 5.0.0 but works on 5.2.0.
>
> I will take a look tomorrow to check the root cause.
>
> I guess technically
> > that means could be considered a regression, but as we don't really have any
> > scheme for which old versions of QEMU we support it's not absolute.  I'd
> > usually err on the side of keeping support for older platforms, but in this
> > case it's probably just not worth the time so I'm going to just ignore it.
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
Regards,
Atish

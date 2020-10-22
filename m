Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F67A296397
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 19:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S369122AbgJVROL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 13:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2441063AbgJVROK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 13:14:10 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84FAAC0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 10:14:10 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id n5so2407204ile.7
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 10:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l5W3i+y8wnLXGa3i9pAtx2PYJyR6oNLNqMyrzD9GmHU=;
        b=KqGua7Id6S+gWJ3CajAXNmc9q5Ef3kY9EiuChtz4R7cRhWzZoBnaCpdFV4xwrIaRIt
         kS7eGHe8fvb2Miy5EHrMpukV7xxM3L1sHHUSu53mhexK4JZeMihF1BXrShnCt/NbOqJE
         sENKqi7pRQtPmIh6Fq24KbhLpya9PWxe6Ve+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l5W3i+y8wnLXGa3i9pAtx2PYJyR6oNLNqMyrzD9GmHU=;
        b=EZWpkpHyxuzQ8rRPKXkOjynjA+8fdZEbRu/GStMM2CMJxqTFKLQJZolkncEUv/05Hg
         bYmZvLRDAjxk+Cvol+TKHF2BqSCFM9+tSOALES0v3qtDOkJKWj6HQr8okCQ3fBPrOif2
         NSRKyO44mQma/7mppWk8+Lysu+MygNrtTYy4exxh6GmMfLgLx7NMe294VvlT557jDWIQ
         5Jhd39AsRxSjIIHpWuFJt/6Rre+QFNFOrZzfcrYUn96lg4cOVhPU6BRnYVYiZjINCPOf
         R2o9qbDC6gt1twSV6C6a56G6zj3l210CbVioQuTo1VZfBlNy+UTM5LVlOxTfV6H9CzHN
         cZYw==
X-Gm-Message-State: AOAM531J7Z33EWcQSDF5N6kuaXmEBdv8dyXEjH0ZUPE/1SpBxWak70QU
        6jPGMAnP3OypBctm6Edn94A8yeklJsuqr33fVn8v
X-Google-Smtp-Source: ABdhPJyxj325aMZZTLE79OzKcI5NUGL3dtwIZgU+GkXdLF3ZtySHRr2zgpyFNROLrr7wc1OJP5WUu/mpPX3UySME7IQ=
X-Received: by 2002:a92:512:: with SMTP id q18mr2450570ile.147.1603386849774;
 Thu, 22 Oct 2020 10:14:09 -0700 (PDT)
MIME-Version: 1.0
References: <20201009211344.2358688-1-atish.patra@wdc.com> <20201009211344.2358688-5-atish.patra@wdc.com>
 <CAHCEehJvMv=CYD1+QXb0uB36Hv4pvO36BAKSLOcxTXvmADZFbA@mail.gmail.com>
 <CAOnJCUKPjkm_=5eHn6=GjVGr67okZkVzqP7-ciphn986BQoc9w@mail.gmail.com>
 <CAOnJCULZMRu+sHmnjoBwtvaB3BjmCiZLzYxNOeWZmoYLKG+wTw@mail.gmail.com>
 <CAHCEehJJmLQ6W5AdH+hEZSJxpDC8HG0UN=EGt9M0Tp5NTfQnaw@mail.gmail.com>
 <CAOnJCUJN-XMZ+N5w+RbVhJag9D_dey7DAopb0Q35GDfXptyMjA@mail.gmail.com>
 <CAFyWVaYORWYZTXyXOWiY6xK-SFTvsUxDNDqKQnhVUwzc5N045Q@mail.gmail.com>
 <CAOnJCU+3xFyFW4ATCdYAv5zVyBSLE0mTevrJLCXW7HDgy4D4EQ@mail.gmail.com>
 <CAOnJCUJWf9Hu4frFOJGQLUZ2BQ8qHBd7mvspgvfM1k6e4z5CcA@mail.gmail.com>
 <CAOnJCUJLKz8gUc7VPnUG4mULQhGD0g_ztxPGYYD7BO6HJBCqcg@mail.gmail.com>
 <CAAhSdy33b_GhuvtNTcd+4qdomr1AAxuJJ-m6Z7qFQTA7MLF-NA@mail.gmail.com> <CAAhSdy2M+uWufbqtYOjyd8wUXg7a5jO6J5o5NC=duaTBsnyHsA@mail.gmail.com>
In-Reply-To: <CAAhSdy2M+uWufbqtYOjyd8wUXg7a5jO6J5o5NC=duaTBsnyHsA@mail.gmail.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Thu, 22 Oct 2020 10:13:58 -0700
Message-ID: <CAOnJCUJai8T3uw1E8o_wHiXf27Q2BGm+x_c8quSThUcO9Fdd=Q@mail.gmail.com>
Subject: Re: [PATCH 4/5] RISC-V: Protect .init.text & .init.data
To:     Anup Patel <anup@brainfault.org>
Cc:     Jim Wilson <jimw@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Kito Cheng <kito.cheng@gmail.com>,
        Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Zong Li <zong.li@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@suse.de>,
        Michel Lespinasse <walken@google.com>,
        Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 22, 2020 at 12:22 AM Anup Patel <anup@brainfault.org> wrote:
>
> On Thu, Oct 22, 2020 at 10:33 AM Anup Patel <anup@brainfault.org> wrote:
> >
> > On Thu, Oct 22, 2020 at 7:01 AM Atish Patra <atishp@atishpatra.org> wrote:
> > >
> > > On Fri, Oct 16, 2020 at 11:24 AM Atish Patra <atishp@atishpatra.org> wrote:
> > > >
> > > > On Tue, Oct 13, 2020 at 10:24 PM Atish Patra <atishp@atishpatra.org> wrote:
> > > > >
> > > > > On Tue, Oct 13, 2020 at 6:21 PM Jim Wilson <jimw@sifive.com> wrote:
> > > > > >
> > > > > > On Tue, Oct 13, 2020 at 3:25 PM Atish Patra <atishp@atishpatra.org> wrote:
> > > > > > > This happens only when copy_from_user is called from function that is
> > > > > > > annotated with __init.
> > > > > > > Adding Kito & Jim for their input
> > > > > > >
> > > > > > > @kito, @Jim: Please let me know if I should create a issue in
> > > > > > > riscv-gnu-toolchain repo or somewhere else.
> > > > > >
> > > > > > I can't do anything useful without a testcase that I can use to
> > > > > > reproduce the problem.  The interactions here are complex, so pointing
> > > > > > at lines of code or kernel config options doesn't give me any useful
> > > > > > info.
> > > > > >
> > > > > > Relaxation can convert calls to a jal.  I don't know of any open bugs
> > > > > > in this area that can generate relocation errors.  if it is a
> > > > > > relaxation error then turning off relaxation should work around the
> > > > > > problem as you suggested.
> > > > > >
> > > > > > A kernel build problem is serious.  I think this is worth a bug
> > > > > > report.  FSF binutils or riscv-gnu-toolchain is fine.
> > > > > >
> > > > >
> > > > > I have created an issue with detailed descriptions and reproduction steps.
> > > > > Please let me know if you need anything else.
> > > > >
> > > >
> > > > It may be a toolchain issue. Here is the ongoing discussion in case
> > > > anybody else is interested.
> > > >
> > > > https://github.com/riscv/riscv-gnu-toolchain/issues/738
> > > >
> > > > > > Jim
> > > > >
> > > > >
> > > > >
> > > > > --
> > > > > Regards,
> > > > > Atish
> > > >
> > > >
> > > >
> > > > --
> > > > Regards,
> > > > Atish
> > >
> > > Thanks to Jim, we know the cause now. Jim has provided an excellent
> > > analysis of the issue in the github issue report.
> > > https://github.com/riscv/riscv-gnu-toolchain/issues/738
> > >
> > > To summarize, the linker relaxation code is not aware of the
> > > alignments between sections.
> > > That's why it relaxes the calls from .text to .init.text and  converts
> > > a auipc+jalr pair to jal even if the address can't be fit +/- 1MB.
> > >
> > > There are few ways we can solve this problem.
> > >
> > > 1. As per Jim's suggestion, linker relaxation code is aware of the
> > > section alignments. We can mark .init.text as a 2MB aligned section.
> > >    For calls within a section, section's alignment will be used in the
> > > calculation. For calls across sections, e.g. from .init.text to .text,
> > > the maximum
> > >    section alignment of every section will be used. Thus, all
> > > relaxation within .init.text and between any sections will be
> > > impacted.
> > >    Thus, it avoids the error but results in the following increase in
> > > size of various sections.
> > >      section           change in size (in bytes)
> > >      .head.text      +4
> > >      .text               +40
> > >      .init.text.        +6530
> > >      .exit.text        +84
> > >
> > > The only significant increase is .init.text but it is freed after
> > > boot. Thus, I don't see any significant performance degradation due to
> > > that.
> > >
> > > Here is the diff
> > > --- a/arch/riscv/kernel/vmlinux.lds.S
> > > +++ b/arch/riscv/kernel/vmlinux.lds.S
> > > @@ -51,7 +51,13 @@ SECTIONS
> > >         . = ALIGN(SECTION_ALIGN);
> > >         __init_begin = .;
> > >         __init_text_begin = .;
> > > -       INIT_TEXT_SECTION(PAGE_SIZE)
> > > +       . = ALIGN(PAGE_SIZE);                                   \
> > > +       .init.text : AT(ADDR(.init.text) - LOAD_OFFSET)
> > > ALIGN(SECTION_ALIGN) {  \
> > > +               _sinittext = .;                                         \
> > > +               INIT_TEXT                                               \
> > > +               _einittext = .;                                         \
> > > +       }
> > > +
> > >         . = ALIGN(8);
> > >         __soc_early_init_table : {
> > >                 __soc_early_init_table_start = .;
> > >
> > > 2. We will continue to keep head.txt & .init.text together before
> > > .text. However, we will map the pages that contain head & init.text at
> > > page
> > >     granularity so that .head.text and init.text can have different
> > > permissions. I have not measured the performance impact of this but it
> > > won't
> > >     too bad given that the combined size of sections .head.txt &
> > > .init.text is 200K. So we are talking about page level permission only
> > > for
> > >     ~50 pages during boot.
> > >
> > > 3. Keep head.text in a separate 2MB aligned section. .init.text will
> > > follow .head.text in its own section as well. This increases the
> > > kernel
> > >     size by 2MB for MMU kernels. For nommu case, it will only increase
> > > by 64 bytes due to smaller section alignment for nommu kernels.
> > >
> > > Both solutions 1 & 2 come at minimal performance on boot time while
> > > solution 3 comes at increased kernel size.
> > >
> > > Any preference ?
> >
> > I prefer solution#3 because:
> > 1. This will help us avoid special handling of static objects
> > 2.  This will make RISC-V linker script more aligned with other
> >      major architectures
> >
> > I don't think solution#3 will increase the size of the kernel by 2MB. We
> > can make head.text part of text section. There will be only one section
> > alignment between text section and init section but the existing section
> > alignment between init section and text section will be removed. In other
> > words, number of section alignments will remain same.
>
> I think we will need to incorporate Jim's suggestion irrespective of the
> solution we choose because without Jim's changes we can hit the
> linker relaxation issue in solution#2 as well.
>

Reconsidering all the possible approaches, I think you are right.

With approach 2 & 3, I just hit the issue now. However, there is an
alignment between
sections which may throw the same linker error in future when text or
init.text gets bigger.

I will follow approach 1 suggested by Jim to revise the series.

> Regards,
> Anup



-- 
Regards,
Atish

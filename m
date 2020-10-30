Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E20AC2A0F76
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 21:29:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbgJ3U3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 16:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727045AbgJ3U3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 16:29:14 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89AEEC0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 13:29:14 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id k6so8866220ior.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 13:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7VREF7/JJHI66A/48k9gSIWFihXYo0nC0DsshW2DhXo=;
        b=DMUlqDBS/HfvoY5Up8fsprLugIn/vkn1Fjvd//pbjobYFG89McRnVf43UIjpDXd9rA
         3NE9R5uE2CtPkMmiBFyCwR+lFLy/M0z7OQFzyomTi16k0sUNwXdmx1MUJb6CDt7QrNo5
         vhD5qCsUpgyPOgAIwVHhbFUQjhWjZax3/Ldv4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7VREF7/JJHI66A/48k9gSIWFihXYo0nC0DsshW2DhXo=;
        b=ZJ0qWno5v/5WKy7ah9s5EJDFedTGA2S1YRQ2bwCgdZmVOvFTOePiUhsq1FcfAkaLAv
         cgpkORbEv2SHOkDP0jjXizxTK0aEMy8IMnnWp0aVtuNfA75DpmsNWuvIw705RmeUFkPV
         vOIPHsGLVMFL3O1BbW4/x5gJEcvgzU8ge4mdZnI/1X5i8e0WD7sqfJS0T6wyIb8ty2Op
         ayQI3fJrO55+ud0B6MLAyHgc2Dt9jOrXzMOJyG9hU4PQpLdgXB7+J8wjYug9dfRzWMA7
         CFPQBLGDzMycWUZAs1PneCAZSKpLEgB2wIh3nfoSbqaNPKK+aG+YqeLDsYDpPf3gYDrM
         vnhA==
X-Gm-Message-State: AOAM533wgmMHDaG7qOJN7yBjTV9UFhCMOs9rxhk/hcLBINqf3yEQGbgm
        pwjeREvOD1L9sg4KZ8LDC3BFeZw8HNXyEnBgti1Z
X-Google-Smtp-Source: ABdhPJzdzkOqM24jGONDbH5CFcA1utJ+rlF756F0BuufHd154tG4AL9WwW90wJJ55eBWWufh6PVX4sP6C3iLW5I9G54=
X-Received: by 2002:a02:6a5b:: with SMTP id m27mr1211998jaf.58.1604089753954;
 Fri, 30 Oct 2020 13:29:13 -0700 (PDT)
MIME-Version: 1.0
References: <20201026230254.911912-1-atish.patra@wdc.com> <20201026230254.911912-6-atish.patra@wdc.com>
 <20201027104545.GM1154158@kernel.org> <CAOnJCULsowob2sgs9qFyUDBRUcuci6e4HEMoE_JuucCX082LCA@mail.gmail.com>
 <20201030084915.GB4319@kernel.org>
In-Reply-To: <20201030084915.GB4319@kernel.org>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Fri, 30 Oct 2020 13:29:03 -0700
Message-ID: <CAOnJCUJFiNJ2-v4jGxCug7Xc78MXns4jYypnYFOR0L6Gkew8fA@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] RISC-V: Protect .init.text & .init.data
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Kees Cook <keescook@chromium.org>,
        Anup Patel <anup@brainfault.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Zong Li <zong.li@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@suse.de>,
        Michel Lespinasse <walken@google.com>,
        Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 30, 2020 at 1:49 AM Mike Rapoport <rppt@kernel.org> wrote:
>
> On Thu, Oct 29, 2020 at 12:21:41PM -0700, Atish Patra wrote:
> > On Tue, Oct 27, 2020 at 3:46 AM Mike Rapoport <rppt@kernel.org> wrote:
> > >
> > > On Mon, Oct 26, 2020 at 04:02:53PM -0700, Atish Patra wrote:
> > > > Currently, .init.text & .init.data are intermixed which makes it impossible
> > > > apply different permissions to them. .init.data shouldn't need exec
> > > > permissions while .init.text shouldn't have write permission.
> > > >
> > > > Keep them in separate sections so that different permissions are applied to
> > > > each section. This improves the kernel protection under
> > > > CONFIG_STRICT_KERNEL_RWX. We also need to restore the permissions for the
> > > > entire _init section after it is freed so that those pages can be used for
> > > > other purpose.
> > > >
> > > > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> > > > ---
> > > >  arch/riscv/include/asm/sections.h   |  2 ++
> > > >  arch/riscv/include/asm/set_memory.h |  2 ++
> > > >  arch/riscv/kernel/setup.c           |  9 +++++
> > > >  arch/riscv/kernel/vmlinux.lds.S     | 51 ++++++++++++++++-------------
> > > >  arch/riscv/mm/init.c                |  8 ++++-
> > > >  arch/riscv/mm/pageattr.c            |  6 ++++
> > > >  6 files changed, 54 insertions(+), 24 deletions(-)
> > > >
> > > > diff --git a/arch/riscv/include/asm/sections.h b/arch/riscv/include/asm/sections.h
> > > > index 3a9971b1210f..1595c5b60cfd 100644
> > > > --- a/arch/riscv/include/asm/sections.h
> > > > +++ b/arch/riscv/include/asm/sections.h
> > > > @@ -9,5 +9,7 @@
> > > >
> > > >  extern char _start[];
> > > >  extern char _start_kernel[];
> > > > +extern char __init_data_begin[], __init_data_end[];
> > > > +extern char __init_text_begin[], __init_text_end[];
> > > >
> > > >  #endif /* __ASM_SECTIONS_H */
> > > > diff --git a/arch/riscv/include/asm/set_memory.h b/arch/riscv/include/asm/set_memory.h
> > > > index 4cc3a4e2afd3..913429c9c1ae 100644
> > > > --- a/arch/riscv/include/asm/set_memory.h
> > > > +++ b/arch/riscv/include/asm/set_memory.h
> > > > @@ -15,6 +15,7 @@ int set_memory_ro(unsigned long addr, int numpages);
> > > >  int set_memory_rw(unsigned long addr, int numpages);
> > > >  int set_memory_x(unsigned long addr, int numpages);
> > > >  int set_memory_nx(unsigned long addr, int numpages);
> > > > +int set_memory_default(unsigned long addr, int numpages);
> > > >  void protect_kernel_text_data(void);
> > > >  #else
> > > >  static inline int set_memory_ro(unsigned long addr, int numpages) { return 0; }
> > > > @@ -22,6 +23,7 @@ static inline int set_memory_rw(unsigned long addr, int numpages) { return 0; }
> > > >  static inline int set_memory_x(unsigned long addr, int numpages) { return 0; }
> > > >  static inline int set_memory_nx(unsigned long addr, int numpages) { return 0; }
> > > >  static inline void protect_kernel_text_data(void) {};
> > > > +static inline int set_memory_default(unsigned long addr, int numpages) { return 0; }
> > > >  #endif
> > > >
> > > >  int set_direct_map_invalid_noflush(struct page *page);
> > > > diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> > > > index b722c5bf892c..abfbdc8cfef3 100644
> > > > --- a/arch/riscv/kernel/setup.c
> > > > +++ b/arch/riscv/kernel/setup.c
> > > > @@ -123,3 +123,12 @@ static int __init topology_init(void)
> > > >       return 0;
> > > >  }
> > > >  subsys_initcall(topology_init);
> > > > +
> > > > +void free_initmem(void)
> > > > +{
> > > > +     unsigned long init_begin = (unsigned long)__init_begin;
> > > > +     unsigned long init_end = (unsigned long)__init_end;
> > > > +
> > > > +     set_memory_default(init_begin, (init_end - init_begin) >> PAGE_SHIFT);
> > >
> > > And what does "default" imply?
> > > Maybe set_memory_rw() would better name ...
> > >
> > > > +     free_initmem_default(POISON_FREE_INITMEM);
> > > > +}
> > >
> > > ...
> > >
> > > > diff --git a/arch/riscv/mm/pageattr.c b/arch/riscv/mm/pageattr.c
> > > > index 19fecb362d81..04f3fc16aa9c 100644
> > > > --- a/arch/riscv/mm/pageattr.c
> > > > +++ b/arch/riscv/mm/pageattr.c
> > > > @@ -128,6 +128,12 @@ static int __set_memory(unsigned long addr, int numpages, pgprot_t set_mask,
> > > >       return ret;
> > > >  }
> > > >
> > > > +int set_memory_default(unsigned long addr, int numpages)
> > > > +{
> > > > +     return __set_memory(addr, numpages, __pgprot(_PAGE_KERNEL),
> > > > +                         __pgprot(_PAGE_EXEC));
> > >
> > > ... because you'd need to find what _PAGE_KERNEL is, do bitwise ops and
> > > than find out that default is apparently RW :)
> > >
> >
> > Yeah. But We have explicitly disable the EXECUTE bit as these pages were marked
> > with RWX earlier. set_memory_rw makes sure that RW bits are set but
> > doesn't disable
> > the X bit.
>
> Maybe set_memory_rw_nx() then?
> Then there will be no ambiguity about what this function does.
>

Sure. I will do that in v2.

> Besides, having set_memory_default() and set_direct_map_default() with
> different masks would be confusing :)
>

Of course :).

> > > > +}
> > > > +
> > > >  int set_memory_ro(unsigned long addr, int numpages)
> > > >  {
> > > >       return __set_memory(addr, numpages, __pgprot(_PAGE_READ),
> > > > --
> > > > 2.25.1
> > > >
> > >
> > > --
> > > Sincerely yours,
> > > Mike.
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
> --
> Sincerely yours,
> Mike.



-- 
Regards,
Atish

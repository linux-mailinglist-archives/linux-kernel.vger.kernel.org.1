Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA7E928DD89
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 11:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730508AbgJNJZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 05:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729386AbgJNJTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 05:19:42 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 246E1C0613BB
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 15:25:30 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id k25so2341781ioh.7
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 15:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UCUR2GsyevbR5SdxoThlhtM0tqTbH0cMYTT+Mk7ZX0s=;
        b=I7mZZ/DE3E7H8yDCv/z6xAuIuusVG/nsF0GeCeRoELIDbRhYCAmM3EdvmU8bbDmCcV
         ksjf8X3XVCb0GPmJuKRvgRvwCThzl5P2xdkMBTYBMm5MiVNUkKxojEcmgfXwQhLMpsP0
         dLePtbBHWNKKHmGW17CrAAlMWAhfU77ZECn9E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UCUR2GsyevbR5SdxoThlhtM0tqTbH0cMYTT+Mk7ZX0s=;
        b=hZ9Qd2FBRC5nAlUi7uytn0NTLAhUZVuBYJsLIgNpw/vp6SXJZ9LK3L1jbcdRncufs0
         fLIbt6viAZ4F4opAMJacPZK8vSSeEKvwKmFGdUMsJtzHNgv0xPCSzwGdZ8hQsSbKDARl
         E9ucdIbfFT1tjbJ4Ne+QxgG1ry9CrQtCtwJUpn9Qe5u8+qF6GbCvMAaH4gzlQEm3DCfK
         OqaNFpM2pOBoxDv9f5TMXKs7DsQVztjqP7aEJ9BmnoYoM6TzYU2bqIAs98b4WVHST63p
         liP/8A2mmSGCK9af81ZkCZImjiXv2hJwK6Sk03LCEyLkj1vXkSR4luQtTvD9rXRnXxyH
         tN+w==
X-Gm-Message-State: AOAM530wCy0N0kyqNXfeBaqrlqQs4eE1OWV368N+no1FpFVhMQ6TzcyO
        AGDinroMLjc2ipXzw2b/m4sjCNJOSXFcrrDmXu44
X-Google-Smtp-Source: ABdhPJxNjDnQbrIwciEWHNlVOJ0Wa7hk6cdaCQ2Q05LF+qeCixYivJ4MV71+O9rcoGJJpFDAVKftZcN038gJgAVtTvU=
X-Received: by 2002:a02:6952:: with SMTP id e79mr835435jac.24.1602627929035;
 Tue, 13 Oct 2020 15:25:29 -0700 (PDT)
MIME-Version: 1.0
References: <20201009211344.2358688-1-atish.patra@wdc.com> <20201009211344.2358688-5-atish.patra@wdc.com>
 <CAHCEehJvMv=CYD1+QXb0uB36Hv4pvO36BAKSLOcxTXvmADZFbA@mail.gmail.com>
 <CAOnJCUKPjkm_=5eHn6=GjVGr67okZkVzqP7-ciphn986BQoc9w@mail.gmail.com>
 <CAOnJCULZMRu+sHmnjoBwtvaB3BjmCiZLzYxNOeWZmoYLKG+wTw@mail.gmail.com> <CAHCEehJJmLQ6W5AdH+hEZSJxpDC8HG0UN=EGt9M0Tp5NTfQnaw@mail.gmail.com>
In-Reply-To: <CAHCEehJJmLQ6W5AdH+hEZSJxpDC8HG0UN=EGt9M0Tp5NTfQnaw@mail.gmail.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Tue, 13 Oct 2020 15:25:18 -0700
Message-ID: <CAOnJCUJN-XMZ+N5w+RbVhJag9D_dey7DAopb0Q35GDfXptyMjA@mail.gmail.com>
Subject: Re: [PATCH 4/5] RISC-V: Protect .init.text & .init.data
To:     Greentime Hu <greentime.hu@sifive.com>, kito.cheng@gmail.com,
        Palmer Dabbelt <palmer@dabbelt.com>, jimw@sifive.com
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Kees Cook <keescook@chromium.org>,
        Anup Patel <anup@brainfault.org>,
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
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 8:08 PM Greentime Hu <greentime.hu@sifive.com> wrot=
e:
>
> Atish Patra <atishp@atishpatra.org> =E6=96=BC 2020=E5=B9=B410=E6=9C=8813=
=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=889:28=E5=AF=AB=E9=81=93=EF=BC=
=9A
> >
> > On Mon, Oct 12, 2020 at 4:26 PM Atish Patra <atishp@atishpatra.org> wro=
te:
> > >
> > > On Mon, Oct 12, 2020 at 6:15 AM Greentime Hu <greentime.hu@sifive.com=
> wrote:
> > > >
> > > > Atish Patra <atish.patra@wdc.com> =E6=96=BC 2020=E5=B9=B410=E6=9C=
=8810=E6=97=A5 =E9=80=B1=E5=85=AD =E4=B8=8A=E5=8D=885:13=E5=AF=AB=E9=81=93=
=EF=BC=9A
> > > > >
> > > > > Currently, .init.text & .init.data are intermixed which makes it =
impossible
> > > > > apply different permissions to them. .init.data shouldn't need ex=
ec
> > > > > permissions while .init.text shouldn't have write permission.
> > > > >
> > > > > Keep them in separate sections so that different permissions are =
applied to
> > > > > each section. This improves the kernel protection under
> > > > > CONFIG_STRICT_KERNEL_RWX. We also need to restore the permissions=
 for the
> > > > > entire _init section after it is freed so that those pages can be=
 used for
> > > > > other purpose.
> > > > >
> > > > > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> > > > > ---
> > > > >  arch/riscv/include/asm/sections.h   |  2 ++
> > > > >  arch/riscv/include/asm/set_memory.h |  2 ++
> > > > >  arch/riscv/kernel/setup.c           |  4 ++++
> > > > >  arch/riscv/kernel/vmlinux.lds.S     | 10 +++++++++-
> > > > >  arch/riscv/mm/init.c                |  6 ++++++
> > > > >  arch/riscv/mm/pageattr.c            |  6 ++++++
> > > > >  6 files changed, 29 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/arch/riscv/include/asm/sections.h b/arch/riscv/inclu=
de/asm/sections.h
> > > > > index d60802bfafbc..730d2c4a844d 100644
> > > > > --- a/arch/riscv/include/asm/sections.h
> > > > > +++ b/arch/riscv/include/asm/sections.h
> > > > > @@ -10,6 +10,8 @@
> > > > >  #include <asm-generic/sections.h>
> > > > >  extern char _start[];
> > > > >  extern char _start_kernel[];
> > > > > +extern char __init_data_begin[], __init_data_end[];
> > > > > +extern char __init_text_begin[], __init_text_end[];
> > > > >
> > > > >  extern bool init_mem_is_free;
> > > > >
> > > > > diff --git a/arch/riscv/include/asm/set_memory.h b/arch/riscv/inc=
lude/asm/set_memory.h
> > > > > index 4cc3a4e2afd3..913429c9c1ae 100644
> > > > > --- a/arch/riscv/include/asm/set_memory.h
> > > > > +++ b/arch/riscv/include/asm/set_memory.h
> > > > > @@ -15,6 +15,7 @@ int set_memory_ro(unsigned long addr, int numpa=
ges);
> > > > >  int set_memory_rw(unsigned long addr, int numpages);
> > > > >  int set_memory_x(unsigned long addr, int numpages);
> > > > >  int set_memory_nx(unsigned long addr, int numpages);
> > > > > +int set_memory_default(unsigned long addr, int numpages);
> > > > >  void protect_kernel_text_data(void);
> > > > >  #else
> > > > >  static inline int set_memory_ro(unsigned long addr, int numpages=
) { return 0; }
> > > > > @@ -22,6 +23,7 @@ static inline int set_memory_rw(unsigned long a=
ddr, int numpages) { return 0; }
> > > > >  static inline int set_memory_x(unsigned long addr, int numpages)=
 { return 0; }
> > > > >  static inline int set_memory_nx(unsigned long addr, int numpages=
) { return 0; }
> > > > >  static inline void protect_kernel_text_data(void) {};
> > > > > +static inline int set_memory_default(unsigned long addr, int num=
pages) { return 0; }
> > > > >  #endif
> > > > >
> > > > >  int set_direct_map_invalid_noflush(struct page *page);
> > > > > diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.=
c
> > > > > index 4176a2affd1d..b8a35ef0eab0 100644
> > > > > --- a/arch/riscv/kernel/setup.c
> > > > > +++ b/arch/riscv/kernel/setup.c
> > > > > @@ -129,6 +129,10 @@ bool init_mem_is_free =3D false;
> > > > >
> > > > >  void free_initmem(void)
> > > > >  {
> > > > > +       unsigned long init_begin =3D (unsigned long)__init_begin;
> > > > > +       unsigned long init_end =3D (unsigned long)__init_end;
> > > > > +
> > > > > +       set_memory_default(init_begin, (init_end - init_begin) >>=
 PAGE_SHIFT);
> > > > >         free_initmem_default(POISON_FREE_INITMEM);
> > > > >         init_mem_is_free =3D true;
> > > > >  }
> > > > > diff --git a/arch/riscv/kernel/vmlinux.lds.S b/arch/riscv/kernel/=
vmlinux.lds.S
> > > > > index 0807633f0dc8..15b9882588ae 100644
> > > > > --- a/arch/riscv/kernel/vmlinux.lds.S
> > > > > +++ b/arch/riscv/kernel/vmlinux.lds.S
> > > > > @@ -30,8 +30,8 @@ SECTIONS
> > > > >         . =3D ALIGN(PAGE_SIZE);
> > > > >
> > > > >         __init_begin =3D .;
> > > > > +       __init_text_begin =3D .;
> > > > >         INIT_TEXT_SECTION(PAGE_SIZE)
> > > > > -       INIT_DATA_SECTION(16)
> > > > >         . =3D ALIGN(8);
> > > > >         __soc_early_init_table : {
> > > > >                 __soc_early_init_table_start =3D .;
> > > > > @@ -48,11 +48,19 @@ SECTIONS
> > > > >         {
> > > > >                 EXIT_TEXT
> > > > >         }
> > > > > +
> > > > > +       __init_text_end =3D .;
> > > > > +       . =3D ALIGN(SECTION_ALIGN);
> > > > > +       /* Start of init data section */
> > > > > +       __init_data_begin =3D .;
> > > > > +       INIT_DATA_SECTION(16)
> > > > >         .exit.data :
> > > > >         {
> > > > >                 EXIT_DATA
> > > > >         }
> > > > >         PERCPU_SECTION(L1_CACHE_BYTES)
> > > > > +
> > > > > +       __init_data_end =3D .;
> > > > >         __init_end =3D .;
> > > > >
> > > > >         . =3D ALIGN(SECTION_ALIGN);
> > > > > diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> > > > > index 7859a1d1b34d..3ef0eafcc7c7 100644
> > > > > --- a/arch/riscv/mm/init.c
> > > > > +++ b/arch/riscv/mm/init.c
> > > > > @@ -627,11 +627,17 @@ void protect_kernel_text_data(void)
> > > > >  {
> > > > >         unsigned long text_start =3D (unsigned long)_text;
> > > > >         unsigned long text_end =3D (unsigned long)_etext;
> > > > > +       unsigned long init_text_start =3D (unsigned long)__init_t=
ext_begin;
> > > > > +       unsigned long init_text_end =3D (unsigned long)__init_tex=
t_end;
> > > > > +       unsigned long init_data_start =3D (unsigned long)__init_d=
ata_begin;
> > > > > +       unsigned long init_data_end =3D (unsigned long)__init_dat=
a_end;
> > > > >         unsigned long rodata_start =3D (unsigned long)__start_rod=
ata;
> > > > >         unsigned long data_start =3D (unsigned long)_data;
> > > > >         unsigned long max_low =3D (unsigned long)(__va(PFN_PHYS(m=
ax_low_pfn)));
> > > > >
> > > > > +       set_memory_ro(init_text_start, (init_text_end - init_text=
_start) >> PAGE_SHIFT);
> > > > >         set_memory_ro(text_start, (text_end - text_start) >> PAGE=
_SHIFT);
> > > > > +       set_memory_nx(init_data_start, (init_data_end - init_data=
_start) >> PAGE_SHIFT);
> > > > >         set_memory_nx(rodata_start, (data_start - rodata_start) >=
> PAGE_SHIFT);
> > > > >         set_memory_nx(data_start, (max_low - data_start) >> PAGE_=
SHIFT);
> > > > >  }
> > > > > diff --git a/arch/riscv/mm/pageattr.c b/arch/riscv/mm/pageattr.c
> > > > > index 19fecb362d81..aecedaf086ab 100644
> > > > > --- a/arch/riscv/mm/pageattr.c
> > > > > +++ b/arch/riscv/mm/pageattr.c
> > > > > @@ -128,6 +128,12 @@ static int __set_memory(unsigned long addr, =
int numpages, pgprot_t set_mask,
> > > > >         return ret;
> > > > >  }
> > > > >
> > > > > +int set_memory_default(unsigned long addr, int numpages)
> > > > > +{
> > > > > +       return __set_memory(addr, numpages, __pgprot(_PAGE_KERNEL=
 | _PAGE_EXEC),
> > > > > +                           __pgprot(0));
> > > > > +}
> > > > > +
> > > > >  int set_memory_ro(unsigned long addr, int numpages)
> > > > >  {
> > > > >         return __set_memory(addr, numpages, __pgprot(_PAGE_READ),
> > > >
> > > >
> > > > Hi Atish,
> > > >
> > > > I tested this patchset and CONFIG_DEBUG_WX=3Dy
> > > >
> > >
> > > Thanks for testing the patch.
> > >
> > > > [    2.664012] Freeing unused kernel memory: 114420K
> > > > [    2.666081] ------------[ cut here ]------------
> > > > [    2.666779] riscv/mm: Found insecure W+X mapping at address
> > > > (____ptrval____)/0xffffffe000000000
> > > > [    2.668004] WARNING: CPU: 0 PID: 1 at arch/riscv/mm/ptdump.c:200
> > > > note_page+0xc2/0x238
> > > > [    2.669147] Modules linked in:
> > > > [    2.669735] CPU: 0 PID: 1 Comm: swapper/0 Not tainted
> > > > 5.9.0-rc8-00033-gfacf070a80ea #153
> > > > [    2.670466] epc: ffffffe00700697c ra : ffffffe00700697c sp : fff=
fffe0fba9bc10
> > > > [    2.671054]  gp : ffffffe007e73078 tp : ffffffe0fba90000 t0 :
> > > > ffffffe007e861d0
> > > > [    2.671683]  t1 : 0000000000000064 t2 : ffffffe007801664 s0 :
> > > > ffffffe0fba9bc60
> > > > [    2.672499]  s1 : ffffffe0fba9bde8 a0 : 0000000000000053 a1 :
> > > > 0000000000000020
> > > > [    2.673119]  a2 : 0000000000000000 a3 : 00000000000000f4 a4 :
> > > > d4328dc070ccb100
> > > > [    2.673729]  a5 : d4328dc070ccb100 a6 : 0000000000000000 a7 :
> > > > ffffffe007851e98
> > > > [    2.674333]  s2 : ffffffe007000000 s3 : ffffffe0fba9bde8 s4 :
> > > > 0000000087200000
> > > > [    2.674963]  s5 : 00000000000000cb s6 : 0000000000000003 s7 :
> > > > ffffffe007e7ac00
> > > > [    2.675564]  s8 : ffffffe000000000 s9 : ffffffe007000000 s10:
> > > > ffffffe000000000
> > > > [    2.676392]  s11: ffffffe040000000 t3 : 000000000001da48 t4 :
> > > > 000000000001da48
> > > > [    2.676992]  t5 : ffffffe007e74490 t6 : ffffffe007e81432
> > > > [    2.677449] status: 0000000000000120 badaddr: 0000000000000000
> > > > cause: 0000000000000003
> > > > [    2.678128] ---[ end trace 5f0a86dbe986db9b ]---
> > > > [    2.678952] Checked W+X mappings: failed, 28672 W+X pages found
> > > > [    2.679737] Run /init as init process
> > > >
> > >
> > > This would be triggered for the current kernel as well as we don't
> > > protect the permission for __init section at all. As you correctly
> > > pointed out, __init & .head sections are mapped with same permissions
> > > because of 2MB mappings.
> > >
> > > Currently, the entire head.text & init section have RWX permission.
> > > This patch is trying remove the write permission from .init.text &
> > > .head.text and execute permission from .init.data until kernel is
> > > booted.
> > > It doesn't provide full protection but better than the current scheme=
.
> > >
> > > To remove the write permission of .head.txt only, we have to keep
> > > .head.txt & .init.text section in separate sections. The linear
> > > mapping would look like this in that case.
> > > There are no issues as such but kernel size would increase by another=
 2M.
> > >
> > > ---[ Linear mapping ]---
> > > 0xffffffe000000000-0xffffffe000200000    0x0000000080200000         2=
M
> > > PMD     D A . . X . R V
> > > 0xffffffe000200000-0xffffffe000600000    0x0000000080400000         4=
M
> > > PMD     D A . . . W R V
> > > 0xffffffe000600000-0xffffffe000e00000    0x0000000080800000         8=
M
> > > PMD     D A . . X . R V
> > > 0xffffffe000e00000-0xffffffe001400000    0x0000000081000000         6=
M
> > > PMD     D A . . . . R V
> > > 0xffffffe001400000-0xffffffe03fe00000    0x0000000081600000      1002=
M
> > > PMD     D A . . . W R V
> > >
> > > The other solution would be move init section below text. Keep text &
> > > head in one section.
> > > The .init.text & .init.data will be in separate sections after that.
> > > Here is the mapping in that case.
> > >
> > > ---[ Linear mapping ]---
> > > 0xffffffe000000000-0xffffffe000800000    0x0000000080200000         8=
M
> > > PMD     D A . . X . R V
> > > 0xffffffe000800000-0xffffffe000c00000    0x0000000080a00000         4=
M
> > > PMD     D A . . . W R V
> > > 0xffffffe000c00000-0xffffffe001200000    0x0000000080e00000         6=
M
> > > PMD     D A . . . . R V
> > > 0xffffffe001200000-0xffffffe03fe00000    0x0000000081400000      1004=
M
> > > PMD     D A . . . W R V
> > >
> > > I prefer the 2nd approach compared to the first one as it saves memor=
y
> > > and we can fix lockdep issue without adding arch_is_kernel_data
> > > to sections.h (Guo's patch).
> > >
> > > However, the 2nd approach throws this problem if
> > > CONFIG_HARDENED_USERCOPY is enabled.
> > >
> > > net/ipv4/ipconfig.o: in function `ic_setup_routes':
> > > /home/atish/workspace/linux/net/ipv4/ipconfig.c:400:(.init.text+0x1c4=
):
> > > relocation truncated to fit: R_RISCV_JAL against symbol `ip_rt_ioctl'
> > > defined in .text section in net/ipv4/fib_frontend.o
> > > make: *** [Makefile:1162: vmlinux] Error 1
> > >
> > > I am currently looking into this to understand why R_RISCV_JAL is
> > > generated a generic function invocation
> > > where auipc + jalr should have been used.
> > >
> >
> > I checked the relocation is is correct 00000000000001d0 R_RISCV_CALL
> >    ip_rt_ioctl
> > The assembly from objdump also shows a pair of auipc + jalr.
> >
> > 1d0:       00000097                auipc   ra,0x0
> > 1d4:       000080e7                jalr    ra # 1d0 <.LBE348+0x4>
> >
> > I don't understand why the toolchain is complaining about relocation
> > error only when
> > CONFIG_HARDENED_USERCOPY is enabled.
> >
> > Are we seeing some subtle toolchain bug ?
> >
> "relocation truncated to fit" usually means that the jump address is
> too far to jump.
> Maybe trying "-mno-relax -Wl,--no-relax" to disable linker relax or
> checking if somewhere just using jal instead of call?

Yes. As I said the relocation id seems correct from the objdump.
I narrowed down the issue to a __builtin_constant_p

Here is the code path:
ip_rt_ioctl->rtentry_to_fib_config->copy_from_user->check_copy_size->check_=
object_size

#ifdef CONFIG_HARDENED_USERCOPY
112 extern void __check_object_size(const void *ptr, unsigned long n,
113                                         bool to_user);
114
115 static __always_inline void check_object_size(const void *ptr,
unsigned long n,
116                                               bool to_user)
117 {
118         if (!__builtin_constant_p(n))
---------------------> Commenting this line avoids the linker issue

                                                               119
            __check_object_size(ptr, n, to_user);
120 }
121 #else
122 static inline void check_object_size(const void *ptr, unsigned
long n,
123                                      bool to_user)
124 { }
125 #endif /* CONFIG_HARDENED_USERCOPY */

This happens only when copy_from_user is called from function that is
annotated with __init.
Adding Kito & Jim for their input

@kito, @Jim: Please let me know if I should create a issue in
riscv-gnu-toolchain repo or somewhere else.

--=20
Regards,
Atish

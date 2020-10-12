Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68F1228B5BD
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 15:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388702AbgJLNPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 09:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730431AbgJLNPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 09:15:05 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B91C0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 06:15:04 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id m9so13474628qth.7
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 06:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sCFbe8lc/BwTXOVtca0boxYbxcpm4ycLpNdo1kWuF+E=;
        b=LWRV3ug3BFHkp9fSDMw/uL3udZuHblRZ+Qs18ybVpwBxb8yb9Wj1HNvreyUnYut2mT
         Z85nzfg1anSZ275gxFXZsCqqYT9SGtXPn8itMqWqKGlHNAyBb/3vnj9tg2eKjLmhNiiB
         2k4LL4touPbqxu53lxmkLHyXVbG5NPH1RKd/IggLEsNwCBmGYzBnynsCJk3N0mufzpnI
         sTPjDRwk65iHTs7pAMhaV3cLQN7tT6Xa7QhzO3drrZgy7TH4Ez2IHB4VqPUY0IozeLCF
         siA0JoHDdazevDn84Eb7j5474JkjV7tUsGxNmO5Xu3JGl2Z24zoYoFztukc+dWUl3gVp
         q06w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sCFbe8lc/BwTXOVtca0boxYbxcpm4ycLpNdo1kWuF+E=;
        b=U/A0rQCsbPgOC7TXPGmNr36JFsvRyNxH6G+PF1kosUo7sDZRN0Tcs0EqSTr2+zEWiC
         aLGsiCjpphgDrBbDuw1yqbR8eMvCnhJ4GU4KeUQyvdi5MX4rl9vRus5e3p/JHNJEhOls
         N4WS/W1R4XXFQe7dC7xp5BCQMmwlDtKsJFClvwJlWKAi57JPdvLgZHU5vAWg4RqJ1N3X
         saULtrwHbwH4XAA12XB9t5gM7tIvGISbwoI3A1DZ/QLxTgFJNJnCGPRkJexS1ioAAr4y
         mQvba3mtV/aLL+5GdABwFI0gViBaEvCdg7DSkwF+pG8N1OwwzLzFr9OEc88Ts2fRCqhr
         O9pA==
X-Gm-Message-State: AOAM530QH39AWabv8wXMDg/A3OsKsCuhEWbMSoZIhBkO5M0KS8OPsKz9
        Er2+HLxM0bAZByfHwqi7nGBZtDxoyPRQhxdu/Jj47Vjipe9qvw==
X-Google-Smtp-Source: ABdhPJwI5Br33m5SvJJ0HWkq6K+gQycYxjcrOozJxTRab5mF9c70qaU2gqJ/4ZXC/hxoNTOP+LhahRIDw/DgiO5mIo4=
X-Received: by 2002:ac8:307c:: with SMTP id g57mr10208242qte.167.1602508503753;
 Mon, 12 Oct 2020 06:15:03 -0700 (PDT)
MIME-Version: 1.0
References: <20201009211344.2358688-1-atish.patra@wdc.com> <20201009211344.2358688-5-atish.patra@wdc.com>
In-Reply-To: <20201009211344.2358688-5-atish.patra@wdc.com>
From:   Greentime Hu <greentime.hu@sifive.com>
Date:   Mon, 12 Oct 2020 21:14:50 +0800
Message-ID: <CAHCEehJvMv=CYD1+QXb0uB36Hv4pvO36BAKSLOcxTXvmADZFbA@mail.gmail.com>
Subject: Re: [PATCH 4/5] RISC-V: Protect .init.text & .init.data
To:     Atish Patra <atish.patra@wdc.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anup Patel <anup@brainfault.org>,
        Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@suse.de>,
        Guo Ren <guoren@linux.alibaba.com>,
        Kees Cook <keescook@chromium.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Michel Lespinasse <walken@google.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Zong Li <zong.li@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Atish Patra <atish.patra@wdc.com> =E6=96=BC 2020=E5=B9=B410=E6=9C=8810=E6=
=97=A5 =E9=80=B1=E5=85=AD =E4=B8=8A=E5=8D=885:13=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Currently, .init.text & .init.data are intermixed which makes it impossib=
le
> apply different permissions to them. .init.data shouldn't need exec
> permissions while .init.text shouldn't have write permission.
>
> Keep them in separate sections so that different permissions are applied =
to
> each section. This improves the kernel protection under
> CONFIG_STRICT_KERNEL_RWX. We also need to restore the permissions for the
> entire _init section after it is freed so that those pages can be used fo=
r
> other purpose.
>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
>  arch/riscv/include/asm/sections.h   |  2 ++
>  arch/riscv/include/asm/set_memory.h |  2 ++
>  arch/riscv/kernel/setup.c           |  4 ++++
>  arch/riscv/kernel/vmlinux.lds.S     | 10 +++++++++-
>  arch/riscv/mm/init.c                |  6 ++++++
>  arch/riscv/mm/pageattr.c            |  6 ++++++
>  6 files changed, 29 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/include/asm/sections.h b/arch/riscv/include/asm/s=
ections.h
> index d60802bfafbc..730d2c4a844d 100644
> --- a/arch/riscv/include/asm/sections.h
> +++ b/arch/riscv/include/asm/sections.h
> @@ -10,6 +10,8 @@
>  #include <asm-generic/sections.h>
>  extern char _start[];
>  extern char _start_kernel[];
> +extern char __init_data_begin[], __init_data_end[];
> +extern char __init_text_begin[], __init_text_end[];
>
>  extern bool init_mem_is_free;
>
> diff --git a/arch/riscv/include/asm/set_memory.h b/arch/riscv/include/asm=
/set_memory.h
> index 4cc3a4e2afd3..913429c9c1ae 100644
> --- a/arch/riscv/include/asm/set_memory.h
> +++ b/arch/riscv/include/asm/set_memory.h
> @@ -15,6 +15,7 @@ int set_memory_ro(unsigned long addr, int numpages);
>  int set_memory_rw(unsigned long addr, int numpages);
>  int set_memory_x(unsigned long addr, int numpages);
>  int set_memory_nx(unsigned long addr, int numpages);
> +int set_memory_default(unsigned long addr, int numpages);
>  void protect_kernel_text_data(void);
>  #else
>  static inline int set_memory_ro(unsigned long addr, int numpages) { retu=
rn 0; }
> @@ -22,6 +23,7 @@ static inline int set_memory_rw(unsigned long addr, int=
 numpages) { return 0; }
>  static inline int set_memory_x(unsigned long addr, int numpages) { retur=
n 0; }
>  static inline int set_memory_nx(unsigned long addr, int numpages) { retu=
rn 0; }
>  static inline void protect_kernel_text_data(void) {};
> +static inline int set_memory_default(unsigned long addr, int numpages) {=
 return 0; }
>  #endif
>
>  int set_direct_map_invalid_noflush(struct page *page);
> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> index 4176a2affd1d..b8a35ef0eab0 100644
> --- a/arch/riscv/kernel/setup.c
> +++ b/arch/riscv/kernel/setup.c
> @@ -129,6 +129,10 @@ bool init_mem_is_free =3D false;
>
>  void free_initmem(void)
>  {
> +       unsigned long init_begin =3D (unsigned long)__init_begin;
> +       unsigned long init_end =3D (unsigned long)__init_end;
> +
> +       set_memory_default(init_begin, (init_end - init_begin) >> PAGE_SH=
IFT);
>         free_initmem_default(POISON_FREE_INITMEM);
>         init_mem_is_free =3D true;
>  }
> diff --git a/arch/riscv/kernel/vmlinux.lds.S b/arch/riscv/kernel/vmlinux.=
lds.S
> index 0807633f0dc8..15b9882588ae 100644
> --- a/arch/riscv/kernel/vmlinux.lds.S
> +++ b/arch/riscv/kernel/vmlinux.lds.S
> @@ -30,8 +30,8 @@ SECTIONS
>         . =3D ALIGN(PAGE_SIZE);
>
>         __init_begin =3D .;
> +       __init_text_begin =3D .;
>         INIT_TEXT_SECTION(PAGE_SIZE)
> -       INIT_DATA_SECTION(16)
>         . =3D ALIGN(8);
>         __soc_early_init_table : {
>                 __soc_early_init_table_start =3D .;
> @@ -48,11 +48,19 @@ SECTIONS
>         {
>                 EXIT_TEXT
>         }
> +
> +       __init_text_end =3D .;
> +       . =3D ALIGN(SECTION_ALIGN);
> +       /* Start of init data section */
> +       __init_data_begin =3D .;
> +       INIT_DATA_SECTION(16)
>         .exit.data :
>         {
>                 EXIT_DATA
>         }
>         PERCPU_SECTION(L1_CACHE_BYTES)
> +
> +       __init_data_end =3D .;
>         __init_end =3D .;
>
>         . =3D ALIGN(SECTION_ALIGN);
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 7859a1d1b34d..3ef0eafcc7c7 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -627,11 +627,17 @@ void protect_kernel_text_data(void)
>  {
>         unsigned long text_start =3D (unsigned long)_text;
>         unsigned long text_end =3D (unsigned long)_etext;
> +       unsigned long init_text_start =3D (unsigned long)__init_text_begi=
n;
> +       unsigned long init_text_end =3D (unsigned long)__init_text_end;
> +       unsigned long init_data_start =3D (unsigned long)__init_data_begi=
n;
> +       unsigned long init_data_end =3D (unsigned long)__init_data_end;
>         unsigned long rodata_start =3D (unsigned long)__start_rodata;
>         unsigned long data_start =3D (unsigned long)_data;
>         unsigned long max_low =3D (unsigned long)(__va(PFN_PHYS(max_low_p=
fn)));
>
> +       set_memory_ro(init_text_start, (init_text_end - init_text_start) =
>> PAGE_SHIFT);
>         set_memory_ro(text_start, (text_end - text_start) >> PAGE_SHIFT);
> +       set_memory_nx(init_data_start, (init_data_end - init_data_start) =
>> PAGE_SHIFT);
>         set_memory_nx(rodata_start, (data_start - rodata_start) >> PAGE_S=
HIFT);
>         set_memory_nx(data_start, (max_low - data_start) >> PAGE_SHIFT);
>  }
> diff --git a/arch/riscv/mm/pageattr.c b/arch/riscv/mm/pageattr.c
> index 19fecb362d81..aecedaf086ab 100644
> --- a/arch/riscv/mm/pageattr.c
> +++ b/arch/riscv/mm/pageattr.c
> @@ -128,6 +128,12 @@ static int __set_memory(unsigned long addr, int nump=
ages, pgprot_t set_mask,
>         return ret;
>  }
>
> +int set_memory_default(unsigned long addr, int numpages)
> +{
> +       return __set_memory(addr, numpages, __pgprot(_PAGE_KERNEL | _PAGE=
_EXEC),
> +                           __pgprot(0));
> +}
> +
>  int set_memory_ro(unsigned long addr, int numpages)
>  {
>         return __set_memory(addr, numpages, __pgprot(_PAGE_READ),


Hi Atish,

I tested this patchset and CONFIG_DEBUG_WX=3Dy

[    2.664012] Freeing unused kernel memory: 114420K
[    2.666081] ------------[ cut here ]------------
[    2.666779] riscv/mm: Found insecure W+X mapping at address
(____ptrval____)/0xffffffe000000000
[    2.668004] WARNING: CPU: 0 PID: 1 at arch/riscv/mm/ptdump.c:200
note_page+0xc2/0x238
[    2.669147] Modules linked in:
[    2.669735] CPU: 0 PID: 1 Comm: swapper/0 Not tainted
5.9.0-rc8-00033-gfacf070a80ea #153
[    2.670466] epc: ffffffe00700697c ra : ffffffe00700697c sp : ffffffe0fba=
9bc10
[    2.671054]  gp : ffffffe007e73078 tp : ffffffe0fba90000 t0 :
ffffffe007e861d0
[    2.671683]  t1 : 0000000000000064 t2 : ffffffe007801664 s0 :
ffffffe0fba9bc60
[    2.672499]  s1 : ffffffe0fba9bde8 a0 : 0000000000000053 a1 :
0000000000000020
[    2.673119]  a2 : 0000000000000000 a3 : 00000000000000f4 a4 :
d4328dc070ccb100
[    2.673729]  a5 : d4328dc070ccb100 a6 : 0000000000000000 a7 :
ffffffe007851e98
[    2.674333]  s2 : ffffffe007000000 s3 : ffffffe0fba9bde8 s4 :
0000000087200000
[    2.674963]  s5 : 00000000000000cb s6 : 0000000000000003 s7 :
ffffffe007e7ac00
[    2.675564]  s8 : ffffffe000000000 s9 : ffffffe007000000 s10:
ffffffe000000000
[    2.676392]  s11: ffffffe040000000 t3 : 000000000001da48 t4 :
000000000001da48
[    2.676992]  t5 : ffffffe007e74490 t6 : ffffffe007e81432
[    2.677449] status: 0000000000000120 badaddr: 0000000000000000
cause: 0000000000000003
[    2.678128] ---[ end trace 5f0a86dbe986db9b ]---
[    2.678952] Checked W+X mappings: failed, 28672 W+X pages found
[    2.679737] Run /init as init process

After debugging, I found it is because
set_memory_ro()/set_memory_nx()/... can't handle the 4KB-aligned
address if it is a 2MB mapping address.
For example, if we gave 0xffffffe000001000 and this address is in a
PMD mapping which is 2MB mapping, it will set the page attributes from
0xffffffe000000000.
And this caused the CPU hotplug failed because it is in head.text section.

#0  pageattr_pmd_entry (pmd=3D0xffffffe0ffdff000,
addr=3D18446743936270602240, next=3D18446743936270766080,
    walk=3D0xffffffe007e03e98) at arch/riscv/mm/pageattr.c:70
70              pmd_t val =3D READ_ONCE(*pmd);
=3D> 0xffffffe007005e96 <pageattr_pmd_entry+0>:   41 11   addi    sp,sp,-16
   0xffffffe007005e98 <pageattr_pmd_entry+2>:   22 e4   sd      s0,8(sp)
   0xffffffe007005e9a <pageattr_pmd_entry+4>:   00 08   addi    s0,sp,16
   0xffffffe007005e9c <pageattr_pmd_entry+6>:   1c 61   ld      a5,0(a0)
(gdb) p/x addr
$21 =3D 0xffffffe000001000

# cat /sys/kernel/debug/kernel_page_tables
---[ Fixmap start ]---
0xffffffcefef00000-0xffffffceff000000    0x0000000082200000         1M
PTE     D A . . . W R V
---[ Fixmap end ]---
---[ PCI I/O start ]---
---[ PCI I/O end ]---
---[ vmalloc() area ]---
0xffffffd000090000-0xffffffd000093000    0x00000001741bb000        12K
PTE     D A . . . W R V
0xffffffdffffbb000-0xffffffdffffbe000    0x0000000175f97000        12K
PTE     D A . . . W R V
0xffffffdffffcc000-0xffffffdffffcf000    0x0000000175f9a000        12K
PTE     D A . . . W R V
0xffffffdffffdd000-0xffffffdffffe0000    0x0000000175f9d000        12K
PTE     D A . . . W R V
0xffffffdffffee000-0xffffffdfffff1000    0x0000000175fa0000        12K
PTE     D A . . . W R V
---[ vmalloc() end ]---
---[ Linear mapping ]---
0xffffffe000000000-0xffffffe007000000    0x0000000080200000       112M
PMD     D A . . X W R V
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^^^^^^^^^^^^^^^^
0xffffffe007000000-0xffffffe007800000    0x0000000087200000         8M
PMD     D A . . X . R V
0xffffffe007800000-0xffffffe007e00000    0x0000000087a00000         6M
PMD     D A . . . . R V
0xffffffe007e00000-0xffffffe0ffe00000    0x0000000088000000      3968M
PMD     D A . . . W R V
#

Any idea?

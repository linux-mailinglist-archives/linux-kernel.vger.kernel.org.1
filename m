Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F8432B1926
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 11:36:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbgKMKgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 05:36:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:60430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726237AbgKMKf7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 05:35:59 -0500
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0FF62224B;
        Fri, 13 Nov 2020 10:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605263758;
        bh=Cj/vmGrSxLwu+lpMblI3qJ592RR38WKdGOx1XJGlKgM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FgeIsj1YwqWiJh1/zRvqGkoqariRiuLL1dl2H4yTGc2shngWESoI/xZy5SPLgPJZi
         jYjJNzvwiimbwxEdCrYdn5RE9tSYTJOr9CwPPMWPH8vPucwfnaa7LqMw9ss3wX5tLp
         PqfSy0qLrAb1ShYukRF5cgSK5sUhkTOo7JZe1ct0=
Received: by mail-oi1-f175.google.com with SMTP id t16so9871540oie.11;
        Fri, 13 Nov 2020 02:35:57 -0800 (PST)
X-Gm-Message-State: AOAM533m5sYz/Ugh7E3a8BPV/vVT4efDBo9/tTgd9aRSQV2TjiUncks8
        +tGfDBCDXT+G44WqYZqbatcKMftmN0cKRu/kMoM=
X-Google-Smtp-Source: ABdhPJyBM93Ae8G8Zp0kUtiLEkKeNrfxbg5gYf1YQH296+T8resJ9Ed/3dHdL/6yZbVpL05vFewZ3YDgQqdNVzzSO8Y=
X-Received: by 2002:aca:5c82:: with SMTP id q124mr974067oib.33.1605263757015;
 Fri, 13 Nov 2020 02:35:57 -0800 (PST)
MIME-Version: 1.0
References: <5fadef1f.1c69fb81.9166e.093c@mx.google.com> <e16e2ce5-dc21-d159-ecf2-e0a430d772e1@collabora.com>
In-Reply-To: <e16e2ce5-dc21-d159-ecf2-e0a430d772e1@collabora.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 13 Nov 2020 11:35:44 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFrxYqTARLprws6ja2=C1xZNC+TNr0Vvayr6sReqsUhyg@mail.gmail.com>
Message-ID: <CAMj1kXFrxYqTARLprws6ja2=C1xZNC+TNr0Vvayr6sReqsUhyg@mail.gmail.com>
Subject: Re: rmk/for-next bisection: baseline.login on bcm2836-rpi-2-b
To:     Guillaume Tucker <guillaume.tucker@collabora.com>
Cc:     Nicolas Pitre <nico@fluxnic.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        kernelci-results@groups.io,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Olof Johansson <olof@lixom.net>,
        Mike Rapoport <rppt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Marc Zyngier <maz@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Collabora Kernel ML <kernel@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Nov 2020 at 11:31, Guillaume Tucker
<guillaume.tucker@collabora.com> wrote:
>
> Hi Ard,
>
> Please see the bisection report below about a boot failure on
> RPi-2b.
>
> Reports aren't automatically sent to the public while we're
> trialing new bisection features on kernelci.org but this one
> looks valid.
>
> There's nothing in the serial console log, probably because it's
> crashing too early during boot.  I'm not sure if other platforms
> on kernelci.org were hit by this in the same way, but there
> doesn't seem to be any.
>
> The same regression can be see on rmk's for-next branch as well
> as in linux-next.  It happens with both bcm2835_defconfig and
> multi_v7_defconfig.
>
> Some more details can be found here:
>
>   https://kernelci.org/test/case/id/5fae44823818ee918adb8864/
>
> If this looks like a real issue but you don't have a platform at
> hand to reproduce it, please let us know if you would like the
> KernelCI test to be re-run with earlyprintk or some debug config
> turned on, or if you have a fix to try.
>
> Best wishes,
> Guillaume
>

Hello Guillaume,

That patch did have an issue, but it was already fixed by

https://www.armlinux.org.uk/developer/patches/viewpatch.php?id=9020/1
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=fc2933c133744305236793025b00c2f7d258b687

Could you please double check whether cherry-picking that on top of
the first bad commit fixes the problem?



>
>
> On 13/11/2020 02:27, KernelCI bot wrote:
> > * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> > * This automated bisection report was sent to you on the basis  *
> > * that you may be involved with the breaking commit it has      *
> > * found.  No manual investigation has been done to verify it,   *
> > * and the root cause of the problem may be somewhere else.      *
> > *                                                               *
> > * If you do send a fix, please include this trailer:            *
> > *   Reported-by: "kernelci.org bot" <bot@kernelci.org>          *
> > *                                                               *
> > * Hope this helps!                                              *
> > * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> >
> > rmk/for-next bisection: baseline.login on bcm2836-rpi-2-b
> >
> > Summary:
> >   Start:      40bd54f12902 Merge branch 'devel-stable' into for-next
> >   Plain log:  https://storage.kernelci.org/rmk/for-next/for-linus-35-g40bd54f129026/arm/bcm2835_defconfig/gcc-8/lab-collabora/baseline-bcm2836-rpi-2-b.txt
> >   HTML log:   https://storage.kernelci.org/rmk/for-next/for-linus-35-g40bd54f129026/arm/bcm2835_defconfig/gcc-8/lab-collabora/baseline-bcm2836-rpi-2-b.html
> >   Result:     7a1be318f579 ARM: 9012/1: move device tree mapping out of linear region
> >
> > Checks:
> >   revert:     PASS
> >   verify:     PASS
> >
> > Parameters:
> >   Tree:       rmk
> >   URL:        git://git.armlinux.org.uk/~rmk/linux-arm.git
> >   Branch:     for-next
> >   Target:     bcm2836-rpi-2-b
> >   CPU arch:   arm
> >   Lab:        lab-collabora
> >   Compiler:   gcc-8
> >   Config:     bcm2835_defconfig
> >   Test case:  baseline.login
> >
> > Breaking commit found:
> >
> > -------------------------------------------------------------------------------
> > commit 7a1be318f5795cb66fa0dc86b3ace427fe68057f
> > Author: Ard Biesheuvel <ardb@kernel.org>
> > Date:   Sun Oct 11 10:21:37 2020 +0100
> >
> >     ARM: 9012/1: move device tree mapping out of linear region
> >
> >     On ARM, setting up the linear region is tricky, given the constraints
> >     around placement and alignment of the memblocks, and how the kernel
> >     itself as well as the DT are placed in physical memory.
> >
> >     Let's simplify matters a bit, by moving the device tree mapping to the
> >     top of the address space, right between the end of the vmalloc region
> >     and the start of the the fixmap region, and create a read-only mapping
> >     for it that is independent of the size of the linear region, and how it
> >     is organized.
> >
> >     Since this region was formerly used as a guard region, which will now be
> >     populated fully on LPAE builds by this read-only mapping (which will
> >     still be able to function as a guard region for stray writes), bump the
> >     start of the [underutilized] fixmap region by 512 KB as well, to ensure
> >     that there is always a proper guard region here. Doing so still leaves
> >     ample room for the fixmap space, even with NR_CPUS set to its maximum
> >     value of 32.
> >
> >     Tested-by: Linus Walleij <linus.walleij@linaro.org>
> >     Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> >     Reviewed-by: Nicolas Pitre <nico@fluxnic.net>
> >     Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> >     Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> >
> > diff --git a/Documentation/arm/memory.rst b/Documentation/arm/memory.rst
> > index 0521b4ce5c96..34bb23c44a71 100644
> > --- a/Documentation/arm/memory.rst
> > +++ b/Documentation/arm/memory.rst
> > @@ -45,9 +45,14 @@ fffe8000   fffeffff        DTCM mapping area for platforms with
> >  fffe0000     fffe7fff        ITCM mapping area for platforms with
> >                               ITCM mounted inside the CPU.
> >
> > -ffc00000     ffefffff        Fixmap mapping region.  Addresses provided
> > +ffc80000     ffefffff        Fixmap mapping region.  Addresses provided
> >                               by fix_to_virt() will be located here.
> >
> > +ffc00000     ffc7ffff        Guard region
> > +
> > +ff800000     ffbfffff        Permanent, fixed read-only mapping of the
> > +                             firmware provided DT blob
> > +
> >  fee00000     feffffff        Mapping of PCI I/O space. This is a static
> >                               mapping within the vmalloc space.
> >
> > diff --git a/arch/arm/include/asm/fixmap.h b/arch/arm/include/asm/fixmap.h
> > index fc56fc3e1931..9575b404019c 100644
> > --- a/arch/arm/include/asm/fixmap.h
> > +++ b/arch/arm/include/asm/fixmap.h
> > @@ -2,7 +2,7 @@
> >  #ifndef _ASM_FIXMAP_H
> >  #define _ASM_FIXMAP_H
> >
> > -#define FIXADDR_START                0xffc00000UL
> > +#define FIXADDR_START                0xffc80000UL
> >  #define FIXADDR_END          0xfff00000UL
> >  #define FIXADDR_TOP          (FIXADDR_END - PAGE_SIZE)
> >
> > diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
> > index 99035b5891ef..bb79e52aeb90 100644
> > --- a/arch/arm/include/asm/memory.h
> > +++ b/arch/arm/include/asm/memory.h
> > @@ -67,6 +67,10 @@
> >   */
> >  #define XIP_VIRT_ADDR(physaddr)  (MODULES_VADDR + ((physaddr) & 0x000fffff))
> >
> > +#define FDT_FIXED_BASE               UL(0xff800000)
> > +#define FDT_FIXED_SIZE               (2 * PMD_SIZE)
> > +#define FDT_VIRT_ADDR(physaddr)      ((void *)(FDT_FIXED_BASE | (physaddr) % PMD_SIZE))
> > +
> >  #if !defined(CONFIG_SMP) && !defined(CONFIG_ARM_LPAE)
> >  /*
> >   * Allow 16MB-aligned ioremap pages
> > @@ -107,6 +111,7 @@ extern unsigned long vectors_base;
> >  #define MODULES_VADDR                PAGE_OFFSET
> >
> >  #define XIP_VIRT_ADDR(physaddr)  (physaddr)
> > +#define FDT_VIRT_ADDR(physaddr)  ((void *)(physaddr))
> >
> >  #endif /* !CONFIG_MMU */
> >
> > diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
> > index f8904227e7fd..9b18d8c66129 100644
> > --- a/arch/arm/kernel/head.S
> > +++ b/arch/arm/kernel/head.S
> > @@ -275,9 +275,8 @@ __create_page_tables:
> >        */
> >       mov     r0, r2, lsr #SECTION_SHIFT
> >       movs    r0, r0, lsl #SECTION_SHIFT
> > -     subne   r3, r0, r8
> > -     addne   r3, r3, #PAGE_OFFSET
> > -     addne   r3, r4, r3, lsr #(SECTION_SHIFT - PMD_ORDER)
> > +     ldrne   r3, =FDT_FIXED_BASE >> (SECTION_SHIFT - PMD_ORDER)
> > +     addne   r3, r3, r4
> >       orrne   r6, r7, r0
> >       strne   r6, [r3], #1 << PMD_ORDER
> >       addne   r6, r6, #1 << SECTION_SHIFT
> > diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
> > index 306bcd9844be..694aa6b4bd03 100644
> > --- a/arch/arm/kernel/setup.c
> > +++ b/arch/arm/kernel/setup.c
> > @@ -18,6 +18,7 @@
> >  #include <linux/of_platform.h>
> >  #include <linux/init.h>
> >  #include <linux/kexec.h>
> > +#include <linux/libfdt.h>
> >  #include <linux/of_fdt.h>
> >  #include <linux/cpu.h>
> >  #include <linux/interrupt.h>
> > @@ -89,7 +90,6 @@ unsigned int cacheid __read_mostly;
> >  EXPORT_SYMBOL(cacheid);
> >
> >  unsigned int __atags_pointer __initdata;
> > -void *atags_vaddr __initdata;
> >
> >  unsigned int system_rev;
> >  EXPORT_SYMBOL(system_rev);
> > @@ -1083,13 +1083,18 @@ void __init hyp_mode_check(void)
> >  void __init setup_arch(char **cmdline_p)
> >  {
> >       const struct machine_desc *mdesc = NULL;
> > +     void *atags_vaddr = NULL;
> >
> >       if (__atags_pointer)
> > -             atags_vaddr = phys_to_virt(__atags_pointer);
> > +             atags_vaddr = FDT_VIRT_ADDR(__atags_pointer);
> >
> >       setup_processor();
> > -     if (atags_vaddr)
> > +     if (atags_vaddr) {
> >               mdesc = setup_machine_fdt(atags_vaddr);
> > +             if (mdesc)
> > +                     memblock_reserve(__atags_pointer,
> > +                                      fdt_totalsize(atags_vaddr));
> > +     }
> >       if (!mdesc)
> >               mdesc = setup_machine_tags(atags_vaddr, __machine_arch_type);
> >       if (!mdesc) {
> > diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
> > index d57112a276f5..a391804c7ce3 100644
> > --- a/arch/arm/mm/init.c
> > +++ b/arch/arm/mm/init.c
> > @@ -223,7 +223,6 @@ void __init arm_memblock_init(const struct machine_desc *mdesc)
> >       if (mdesc->reserve)
> >               mdesc->reserve();
> >
> > -     early_init_fdt_reserve_self();
> >       early_init_fdt_scan_reserved_mem();
> >
> >       /* reserve memory for DMA contiguous allocations */
> > diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> > index 55991fe60054..fa259825310c 100644
> > --- a/arch/arm/mm/mmu.c
> > +++ b/arch/arm/mm/mmu.c
> > @@ -39,6 +39,8 @@
> >  #include "mm.h"
> >  #include "tcm.h"
> >
> > +extern unsigned long __atags_pointer;
> > +
> >  /*
> >   * empty_zero_page is a special page that is used for
> >   * zero-initialized data and COW.
> > @@ -946,7 +948,7 @@ static void __init create_mapping(struct map_desc *md)
> >               return;
> >       }
> >
> > -     if ((md->type == MT_DEVICE || md->type == MT_ROM) &&
> > +     if (md->type == MT_DEVICE &&
> >           md->virtual >= PAGE_OFFSET && md->virtual < FIXADDR_START &&
> >           (md->virtual < VMALLOC_START || md->virtual >= VMALLOC_END)) {
> >               pr_warn("BUG: mapping for 0x%08llx at 0x%08lx out of vmalloc space\n",
> > @@ -1333,6 +1335,15 @@ static void __init devicemaps_init(const struct machine_desc *mdesc)
> >       for (addr = VMALLOC_START; addr < (FIXADDR_TOP & PMD_MASK); addr += PMD_SIZE)
> >               pmd_clear(pmd_off_k(addr));
> >
> > +     if (__atags_pointer) {
> > +             /* create a read-only mapping of the device tree */
> > +             map.pfn = __phys_to_pfn(__atags_pointer & SECTION_MASK);
> > +             map.virtual = FDT_FIXED_BASE;
> > +             map.length = FDT_FIXED_SIZE;
> > +             map.type = MT_ROM;
> > +             create_mapping(&map);
> > +     }
> > +
> >       /*
> >        * Map the kernel if it is XIP.
> >        * It is always first in the modulearea.
> > @@ -1489,8 +1500,7 @@ static void __init map_lowmem(void)
> >  }
> >
> >  #ifdef CONFIG_ARM_PV_FIXUP
> > -extern void *atags_vaddr;
> > -typedef void pgtables_remap(long long offset, unsigned long pgd, void *bdata);
> > +typedef void pgtables_remap(long long offset, unsigned long pgd);
> >  pgtables_remap lpae_pgtables_remap_asm;
> >
> >  /*
> > @@ -1503,7 +1513,6 @@ static void __init early_paging_init(const struct machine_desc *mdesc)
> >       unsigned long pa_pgd;
> >       unsigned int cr, ttbcr;
> >       long long offset;
> > -     void *boot_data;
> >
> >       if (!mdesc->pv_fixup)
> >               return;
> > @@ -1520,7 +1529,6 @@ static void __init early_paging_init(const struct machine_desc *mdesc)
> >        */
> >       lpae_pgtables_remap = (pgtables_remap *)(unsigned long)__pa(lpae_pgtables_remap_asm);
> >       pa_pgd = __pa(swapper_pg_dir);
> > -     boot_data = atags_vaddr;
> >       barrier();
> >
> >       pr_info("Switching physical address space to 0x%08llx\n",
> > @@ -1556,7 +1564,7 @@ static void __init early_paging_init(const struct machine_desc *mdesc)
> >        * needs to be assembly.  It's fairly simple, as we're using the
> >        * temporary tables setup by the initial assembly code.
> >        */
> > -     lpae_pgtables_remap(offset, pa_pgd, boot_data);
> > +     lpae_pgtables_remap(offset, pa_pgd);
> >
> >       /* Re-enable the caches and cacheable TLB walks */
> >       asm volatile("mcr p15, 0, %0, c2, c0, 2" : : "r" (ttbcr));
> > diff --git a/arch/arm/mm/pv-fixup-asm.S b/arch/arm/mm/pv-fixup-asm.S
> > index 8eade0416739..5c5e1952000a 100644
> > --- a/arch/arm/mm/pv-fixup-asm.S
> > +++ b/arch/arm/mm/pv-fixup-asm.S
> > @@ -39,8 +39,8 @@ ENTRY(lpae_pgtables_remap_asm)
> >
> >       /* Update level 2 entries for the boot data */
> >       add     r7, r2, #0x1000
> > -     add     r7, r7, r3, lsr #SECTION_SHIFT - L2_ORDER
> > -     bic     r7, r7, #(1 << L2_ORDER) - 1
> > +     movw    r3, #FDT_FIXED_BASE >> (SECTION_SHIFT - L2_ORDER)
> > +     add     r7, r7, r3
> >       ldrd    r4, r5, [r7]
> >       adds    r4, r4, r0
> >       adc     r5, r5, r1
> > -------------------------------------------------------------------------------
> >
> >
> > Git bisection log:
> >
> > -------------------------------------------------------------------------------
> > git bisect start
> > # good: [adc5f7029376049873289be305d507022281b8dd] ARM: add malloc size to decompressor kexec size structure
> > git bisect good adc5f7029376049873289be305d507022281b8dd
> > # bad: [40bd54f129026a114a76cd6e756659373cf40151] Merge branch 'devel-stable' into for-next
> > git bisect bad 40bd54f129026a114a76cd6e756659373cf40151
> > # good: [93b694d096cc10994c817730d4d50288f9ae3d66] Merge tag 'drm-next-2020-10-15' of git://anongit.freedesktop.org/drm/drm
> > git bisect good 93b694d096cc10994c817730d4d50288f9ae3d66
> > # good: [c4cf498dc0241fa2d758dba177634268446afb06] Merge branch 'akpm' (patches from Andrew)
> > git bisect good c4cf498dc0241fa2d758dba177634268446afb06
> > # good: [ceae608a54898fff2aa0aba358fe81af027ef8c9] Merge tag 'pwm/for-5.10-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm
> > git bisect good ceae608a54898fff2aa0aba358fe81af027ef8c9
> > # good: [e731f3146ff3bba5424b40140e1a7e6f92e94964] Merge tag 'armsoc-soc' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
> > git bisect good e731f3146ff3bba5424b40140e1a7e6f92e94964
> > # good: [873c331927302ab484c859601982a7cb88bc0723] Merge tag 'stm32-dt-for-v5.10-1' of git://git.kernel.org/pub/scm/linux/kernel/git/atorgue/stm32 into arm/dt
> > git bisect good 873c331927302ab484c859601982a7cb88bc0723
> > # good: [e533cda12d8f0e7936354bafdc85c81741f805d2] Merge tag 'armsoc-dt' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
> > git bisect good e533cda12d8f0e7936354bafdc85c81741f805d2
> > # good: [af0041875ce7f5a05362b884e90cf82c27876096] Merge tag 'io_uring-5.10-2020-10-24' of git://git.kernel.dk/linux-block
> > git bisect good af0041875ce7f5a05362b884e90cf82c27876096
> > # good: [c10037f8323d2a94acb4fc6ecfbab0cda152fdd6] Merge tag '5.10-rc-smb3-fixes-part2' of git://git.samba.org/sfrench/cifs-2.6
> > git bisect good c10037f8323d2a94acb4fc6ecfbab0cda152fdd6
> > # bad: [421015713b306e47af95d4d61cdfbd96d462e4cb] ARM: 9017/2: Enable KASan for ARM
> > git bisect bad 421015713b306e47af95d4d61cdfbd96d462e4cb
> > # good: [87702a337f748d19a59a7826aeeffe0f6aeab7d4] Merge tag 'sched-urgent-2020-10-25' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
> > git bisect good 87702a337f748d19a59a7826aeeffe0f6aeab7d4
> > # good: [33def8498fdde180023444b08e12b72a9efed41d] treewide: Convert macro and uses of __section(foo) to __section("foo")
> > git bisect good 33def8498fdde180023444b08e12b72a9efed41d
> > # bad: [d5d44e7e3507b0ad868f68e0c5bca6a57afa1b8b] ARM: 9013/2: Disable KASan instrumentation for some code
> > git bisect bad d5d44e7e3507b0ad868f68e0c5bca6a57afa1b8b
> > # good: [e9a2f8b599d0bc22a1b13e69527246ac39c697b4] ARM: 9011/1: centralize phys-to-virt conversion of DT/ATAGS address
> > git bisect good e9a2f8b599d0bc22a1b13e69527246ac39c697b4
> > # bad: [7a1be318f5795cb66fa0dc86b3ace427fe68057f] ARM: 9012/1: move device tree mapping out of linear region
> > git bisect bad 7a1be318f5795cb66fa0dc86b3ace427fe68057f
> > # first bad commit: [7a1be318f5795cb66fa0dc86b3ace427fe68057f] ARM: 9012/1: move device tree mapping out of linear region
> > -------------------------------------------------------------------------------
> >
> >
> > -=-=-=-=-=-=-=-=-=-=-=-
> > Groups.io Links: You receive all messages sent to this group.
> > View/Reply Online (#3326): https://groups.io/g/kernelci-results/message/3326
> > Mute This Topic: https://groups.io/mt/78222009/924702
> > Group Owner: kernelci-results+owner@groups.io
> > Unsubscribe: https://groups.io/g/kernelci-results/unsub [guillaume.tucker@collabora.com]
> > -=-=-=-=-=-=-=-=-=-=-=-
> >
> >
>

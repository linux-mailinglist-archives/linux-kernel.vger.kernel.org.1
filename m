Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1E826C550
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 18:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbgIPQtp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 12:49:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:45560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726522AbgIPQd2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 12:33:28 -0400
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA7E3221E7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 11:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600254971;
        bh=cWH91ikJ9sLevZRmsgYzknJ3hAdxj+D8uvwGvGB15TI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=P9/irsFMlZfjOF8mVx4Y9H33E5bgajj3Tcvp9f4qVkNf0ARqmhZE/s5UDSRZlA/V9
         qkq/6v/52lvoOa/n8A69tEGuAtswpTaJMDcJXcJFfOZ7p0sh+7W3rS452R5d3wqMyS
         rwJBN47V5EBCJu8vDxjX5NImluP/Gkz0Guf4POHc=
Received: by mail-oi1-f169.google.com with SMTP id c13so7662518oiy.6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 04:16:11 -0700 (PDT)
X-Gm-Message-State: AOAM533Tov8tHaszA7zzX3JRAglhZnQMhT4/aNTC2FG20yWciVrsukQE
        JoZiYhI5hxXLM1WB05Z/NFusxbE4URTAk3GkJqE=
X-Google-Smtp-Source: ABdhPJwD1SsDphfrc1GdkjZ5if6Hi/Pgq/HhVFYcHzddy6zhxISUzKG9+7ev3I7t3LuDStNB+rh+4aWIKPwUmo6/IRo=
X-Received: by 2002:aca:d845:: with SMTP id p66mr2586629oig.47.1600254971043;
 Wed, 16 Sep 2020 04:16:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200916024927.3191-1-thunder.leizhen@huawei.com> <20200916024927.3191-3-thunder.leizhen@huawei.com>
In-Reply-To: <20200916024927.3191-3-thunder.leizhen@huawei.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 16 Sep 2020 14:15:59 +0300
X-Gmail-Original-Message-ID: <CAMj1kXFUbAaqprgO=RjjRhdMy+32c2PrPhUYNDzyOTXX94g71g@mail.gmail.com>
Message-ID: <CAMj1kXFUbAaqprgO=RjjRhdMy+32c2PrPhUYNDzyOTXX94g71g@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] ARM: support PHYS_OFFSET minimum aligned at 64KiB boundary
To:     Zhen Lei <thunder.leizhen@huawei.com>,
        Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@fluxnic.net>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jianguo Chen <chenjianguo3@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Libin <huawei.libin@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(+ Arnd, Nico)

On Wed, 16 Sep 2020 at 05:51, Zhen Lei <thunder.leizhen@huawei.com> wrote:
>
> Currently, only support the kernels where the base of physical memory is
> at a 16MiB boundary. Because the add/sub instructions only contains 8bits
> unrotated value. But we can use one more "add/sub" instructions to handle
> bits 23-16. The performance will be slightly affected.
>
> Since most boards meet 16 MiB alignment, so add a new configuration
> option ARM_PATCH_PHYS_VIRT_RADICAL (default n) to control it. Say Y if
> anyone really needs it.
>
> All r0-r7 (r1 = machine no, r2 = atags or dtb, in the start-up phase) are
> used in __fixup_a_pv_table() now, but the callee saved r11 is not used in
> the whole head.S file. So choose it.
>
> Because the calculation of "y = x + __pv_offset[63:24]" have been done,
> so we only need to calculate "y = y + __pv_offset[23:16]", that's why
> the parameters "to" and "from" of __pv_stub() and __pv_add_carry_stub()
> in the scope of CONFIG_ARM_PATCH_PHYS_VIRT_RADICAL are all passed "t"
> (above y).
>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  arch/arm/Kconfig              | 17 ++++++++++++++++-
>  arch/arm/include/asm/memory.h | 16 +++++++++++++---
>  arch/arm/kernel/head.S        | 25 +++++++++++++++++++------
>  3 files changed, 48 insertions(+), 10 deletions(-)
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index e00d94b16658765..073dafa428f3c87 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -240,12 +240,27 @@ config ARM_PATCH_PHYS_VIRT
>           kernel in system memory.
>
>           This can only be used with non-XIP MMU kernels where the base
> -         of physical memory is at a 16MB boundary.
> +         of physical memory is at a 16MiB boundary.
>
>           Only disable this option if you know that you do not require
>           this feature (eg, building a kernel for a single machine) and
>           you need to shrink the kernel to the minimal size.
>
> +config ARM_PATCH_PHYS_VIRT_RADICAL
> +       bool "Support PHYS_OFFSET minimum aligned at 64KiB boundary"
> +       depends on ARM_PATCH_PHYS_VIRT
> +       depends on !THUMB2_KERNEL

Why is this not implemented for Thumb2 too?

Also, as Russell points out as well, this may end up being enabled for
all multiarch kernels, so it makes sense to explore whether we can
enable this unconditionally. Do you have any numbers wrt the impact on
text size? I would assume it is negligible, but numbers help.

Being able to decompress the image to any 2MiB aligned base address is
also quite useful for EFI boot, and it may also help to get rid of the
TEXT_OFFSET hacks we have for some platforms in the future.


> +       help
> +         This can only be used with non-XIP MMU kernels where the base
> +         of physical memory is at a 64KiB boundary.
> +
> +         Compared with ARM_PATCH_PHYS_VIRT, one or two more instructions
> +         need to be added to implement the conversion of bits 23-16 of
> +         the VA/PA in phys-to-virt and virt-to-phys. The performance is
> +         slightly affected.
> +

Does it affect performance in other ways beyond code size/Icache density?

> +         If unsure say N here.
> +
>  config NEED_MACH_IO_H
>         bool
>         help
> diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
> index 99035b5891ef442..f97b37303a00f60 100644
> --- a/arch/arm/include/asm/memory.h
> +++ b/arch/arm/include/asm/memory.h
> @@ -173,6 +173,7 @@
>   * so that all we need to do is modify the 8-bit constant field.
>   */
>  #define __PV_BITS_31_24        0x81000000
> +#define __PV_BITS_23_16        0x00810000
>  #define __PV_BITS_7_0  0x81
>
>  extern unsigned long __pv_phys_pfn_offset;
> @@ -201,7 +202,7 @@
>         : "=r" (t)                                      \
>         : "I" (__PV_BITS_7_0))
>
> -#define __pv_add_carry_stub(x, y)                      \
> +#define __pv_add_carry_stub(x, y, type)                        \
>         __asm__ volatile("@ __pv_add_carry_stub\n"      \
>         "1:     adds    %Q0, %1, %2\n"                  \
>         "       adc     %R0, %R0, #0\n"                 \
> @@ -209,7 +210,7 @@
>         "       .long   1b\n"                           \
>         "       .popsection\n"                          \
>         : "+r" (y)                                      \
> -       : "r" (x), "I" (__PV_BITS_31_24)                \
> +       : "r" (x), "I" (type)                           \
>         : "cc")
>
>  static inline phys_addr_t __virt_to_phys_nodebug(unsigned long x)
> @@ -218,9 +219,15 @@ static inline phys_addr_t __virt_to_phys_nodebug(unsigned long x)
>
>         if (sizeof(phys_addr_t) == 4) {
>                 __pv_stub(x, t, "add", __PV_BITS_31_24);
> +#ifdef CONFIG_ARM_PATCH_PHYS_VIRT_RADICAL
> +               __pv_stub(t, t, "add", __PV_BITS_23_16);
> +#endif
>         } else {
>                 __pv_stub_mov_hi(t);
> -               __pv_add_carry_stub(x, t);
> +               __pv_add_carry_stub(x, t, __PV_BITS_31_24);
> +#ifdef CONFIG_ARM_PATCH_PHYS_VIRT_RADICAL
> +               __pv_add_carry_stub(t, t, __PV_BITS_23_16);
> +#endif
>         }
>         return t;
>  }
> @@ -236,6 +243,9 @@ static inline unsigned long __phys_to_virt(phys_addr_t x)
>          * in place where 'r' 32 bit operand is expected.
>          */
>         __pv_stub((unsigned long) x, t, "sub", __PV_BITS_31_24);
> +#ifdef CONFIG_ARM_PATCH_PHYS_VIRT_RADICAL
> +       __pv_stub(t, t, "sub", __PV_BITS_23_16);
> +#endif
>         return t;
>  }
>
> diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
> index 02d78c9198d0e8d..d9fb226a24d43ae 100644
> --- a/arch/arm/kernel/head.S
> +++ b/arch/arm/kernel/head.S
> @@ -120,7 +120,7 @@ ENTRY(stext)
>         bl      __fixup_smp
>  #endif
>  #ifdef CONFIG_ARM_PATCH_PHYS_VIRT
> -       bl      __fixup_pv_table
> +       bl      __fixup_pv_table                @r11 will be used
>  #endif
>         bl      __create_page_tables
>
> @@ -614,8 +614,13 @@ __fixup_pv_table:
>         mov     r0, r8, lsr #PAGE_SHIFT @ convert to PFN
>         str     r0, [r6]        @ save computed PHYS_PFN_OFFSET to __pv_phys_pfn_offset
>         strcc   ip, [r7, #HIGH_OFFSET]  @ save to __pv_offset high bits
> +#ifdef CONFIG_ARM_PATCH_PHYS_VIRT_RADICAL
> +       mov     r6, r3, lsr #16 @ constant for add/sub instructions
> +       teq     r3, r6, lsl #16 @ must be 64KiB aligned
> +#else
>         mov     r6, r3, lsr #24 @ constant for add/sub instructions
>         teq     r3, r6, lsl #24 @ must be 16MiB aligned
> +#endif
>  THUMB( it      ne              @ cross section branch )
>         bne     __error
>         str     r3, [r7, #LOW_OFFSET]   @ save to __pv_offset low bits
> @@ -636,7 +641,9 @@ __fixup_a_pv_table:
>         add     r6, r6, r3
>         ldr     r0, [r6, #HIGH_OFFSET]  @ __pv_offset high word
>         ldr     r6, [r6, #LOW_OFFSET]   @ __pv_offset low word
> -       mov     r6, r6, lsr #24
> +       mov     r11, r6, lsl #8
> +       mov     r11, r11, lsr #24       @ bits 23-16
> +       mov     r6, r6, lsr #24         @ bits 31-24
>         cmn     r0, #1
>  #ifdef CONFIG_THUMB2_KERNEL
>         moveq   r0, #0x200000   @ set bit 21, mov to mvn instruction
> @@ -682,14 +689,20 @@ ARM_BE8(rev16     ip, ip)
>  #ifdef CONFIG_CPU_ENDIAN_BE8
>         @ in BE8, we load data in BE, but instructions still in LE
>         bic     ip, ip, #0xff000000
> -       tst     ip, #0x000f0000 @ check the rotation field
> +       tst     ip, #0x00040000 @ check the rotation field
>         orrne   ip, ip, r6, lsl #24 @ mask in offset bits 31-24
> +       tst     ip, #0x00080000 @ check the rotation field
> +       orrne   ip, ip, r11, lsl #24 @ mask in offset bits 23-16
> +       tst     ip, #0x000f0000 @ check the rotation field
>         biceq   ip, ip, #0x00004000 @ clear bit 22
>         orreq   ip, ip, r0      @ mask in offset bits 7-0
>  #else
>         bic     ip, ip, #0x000000ff
> -       tst     ip, #0xf00      @ check the rotation field
> +       tst     ip, #0x400      @ check the rotation field
>         orrne   ip, ip, r6      @ mask in offset bits 31-24
> +       tst     ip, #0x800      @ check the rotation field
> +       orrne   ip, ip, r11     @ mask in offset bits 23-16
> +       tst     ip, #0xf00      @ check the rotation field
>         biceq   ip, ip, #0x400000       @ clear bit 22
>         orreq   ip, ip, r0      @ mask in offset bits 7-0
>  #endif
> @@ -705,12 +718,12 @@ ENDPROC(__fixup_a_pv_table)
>  3:     .long __pv_offset
>
>  ENTRY(fixup_pv_table)
> -       stmfd   sp!, {r4 - r7, lr}
> +       stmfd   sp!, {r4 - r7, r11, lr}
>         mov     r3, #0                  @ no offset
>         mov     r4, r0                  @ r0 = table start
>         add     r5, r0, r1              @ r1 = table size
>         bl      __fixup_a_pv_table
> -       ldmfd   sp!, {r4 - r7, pc}
> +       ldmfd   sp!, {r4 - r7, r11, pc}
>  ENDPROC(fixup_pv_table)
>
>         .data
> --
> 1.8.3
>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

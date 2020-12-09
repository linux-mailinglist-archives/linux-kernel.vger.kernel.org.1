Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F37022D43BB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 15:01:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728642AbgLIOAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 09:00:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728571AbgLIOAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 09:00:09 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3DAFC0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 05:59:27 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id h16so1646769edt.7
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 05:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AywCHhpIJ3sB1kUjhQf6O5kXexibNYwgXI2uRlaAuXc=;
        b=QOhKPRwoSREJ4CxBq6Yitq5qXTMSyztaNcEARYNNDX1UB2N9ys1Ij56hoAcibD//hw
         ngGj/fFj0iPqIy1s0xGjbHJM6Hndt6ANfOWQEr2FtzZ5st5hfPdgSTWU0iqukm+yo+V3
         9Q6Y151tR9kPLwkHA63Y8K1PIkw9NFhUNEkWYVf79cmBcy2zrWRA5rMgayfAg46d6Rtd
         ufFudsnrGTHE8iILBuy4zF4O/ifKwUU/DLAsZqeb5WICWK/Loh01UcoeubVAkXFNvYUa
         ISGMKBXVKqGoRtzzn/LQJr4ltW1ai2S1GDCY2GTeSHmJgNU2hS0UAd+ASK9v7ZB/htqc
         l4TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AywCHhpIJ3sB1kUjhQf6O5kXexibNYwgXI2uRlaAuXc=;
        b=DeHE7NbNQ2LilEFV6NUnHBZdSIBc7eAluDYiPK15+3HsP1ViGwVaJU3KHawl6ld4HU
         mNZ8/d42Ok+WN6hnJ3i5IKre6kSPwvb5i7l1WyuTG7K0n06FeWJgUiCnlqPu2U9FBasX
         NqiT+uS2qu3kw3uikci2poPHu+o0fsMl7Po1sfsRTAVqvVLgAzECVKxsvL+ceoPoAFmS
         PlcEiUjeMp9DO70HUpU56JXh/T+A//kz11UqZfJvp4LGibaGu2/3z53y33TKkzPzVxhi
         CMDGaUzH8jbOhMIJBkqC0i4DJdridXk+c9S9GLOBnIaAir8jKR/NiFUdJg9VcNGTug3m
         VUYg==
X-Gm-Message-State: AOAM5333GEr1H7CcOW4klu1H9RvyxAe6e+7f9v3dbufrCratoLksNsLn
        HXvEWmQ/Lurjr2V7mtIdDmZOaKI7ZUYaNDVir5l15yrHZo0MYg==
X-Google-Smtp-Source: ABdhPJw/aCKxrI2CV4QgvlqLi9b6Bi0jUrFo30f9pVOauZjeqgJvJYjSptb7edrEKSbYWfEF4mvw9YePvo6p0XkPn48=
X-Received: by 2002:aa7:c2d8:: with SMTP id m24mr2115640edp.300.1607522364981;
 Wed, 09 Dec 2020 05:59:24 -0800 (PST)
MIME-Version: 1.0
References: <43486cab370e0c0a79860120b71e0caac75a7e44.1606397528.git.michal.simek@xilinx.com>
In-Reply-To: <43486cab370e0c0a79860120b71e0caac75a7e44.1606397528.git.michal.simek@xilinx.com>
From:   Michal Simek <monstr@monstr.eu>
Date:   Wed, 9 Dec 2020 14:59:13 +0100
Message-ID: <CAHTX3dKHLtz86zKr1nhP=JPMg6TPQwu+i5HeHA7gjHp_LJ7ASQ@mail.gmail.com>
Subject: Re: [PATCH v2] microblaze: Remove noMMU code
To:     LKML <linux-kernel@vger.kernel.org>,
        Michal Simek <monstr@monstr.eu>, git <git@xilinx.com>
Cc:     Mike Rapoport <rppt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Baoquan He <bhe@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Eric Biggers <ebiggers@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greentime Hu <green.hu@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Helge Deller <deller@gmx.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ira Weiny <ira.weiny@intel.com>, Jens Axboe <axboe@kernel.dk>,
        Joe Perches <joe@perches.com>,
        Manish Narani <manish.narani@xilinx.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pekka Enberg <penberg@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rob Herring <robh@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Stefan Asserhall <stefan.asserhall@xilinx.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C4=8Dt 26. 11. 2020 v 14:32 odes=C3=ADlatel Michal Simek
<michal.simek@xilinx.com> napsal:
>
> This configuration is obsolete and likely none is really using it. That's
> why remove it to simplify code.
>
> Note about CONFIG_MMU in hw_exception_handler.S is left intentionally
> for better comment understanding.
>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
>
> Changes in v2:
> - Remove also configs around CONFIG_MICROBLAZE_X_PAGES
>
> If anybody is using this configuration please let me know.
>
> ---
>  arch/microblaze/Kconfig                       |  53 +-
>  arch/microblaze/Makefile                      |  11 +-
>  arch/microblaze/configs/mmu_defconfig         |   1 -
>  arch/microblaze/configs/nommu_defconfig       |  90 ---
>  arch/microblaze/include/asm/dma.h             |   6 -
>  arch/microblaze/include/asm/exceptions.h      |   5 -
>  arch/microblaze/include/asm/io.h              |   3 -
>  arch/microblaze/include/asm/mmu.h             |   4 -
>  arch/microblaze/include/asm/mmu_context.h     |   4 -
>  arch/microblaze/include/asm/page.h            |  59 --
>  arch/microblaze/include/asm/pgalloc.h         |   4 -
>  arch/microblaze/include/asm/pgtable.h         |  43 --
>  arch/microblaze/include/asm/processor.h       |  37 --
>  arch/microblaze/include/asm/registers.h       |   2 -
>  arch/microblaze/include/asm/setup.h           |   2 -
>  arch/microblaze/include/asm/tlbflush.h        |  14 -
>  arch/microblaze/include/asm/uaccess.h         |  27 -
>  arch/microblaze/kernel/Makefile               |   4 +-
>  arch/microblaze/kernel/asm-offsets.c          |   2 -
>  arch/microblaze/kernel/entry-nommu.S          | 622 ------------------
>  arch/microblaze/kernel/exceptions.c           |   5 -
>  arch/microblaze/kernel/head.S                 |  12 -
>  arch/microblaze/kernel/hw_exception_handler.S | 130 +---
>  arch/microblaze/kernel/microblaze_ksyms.c     |   2 -
>  arch/microblaze/kernel/process.c              |  10 -
>  arch/microblaze/kernel/setup.c                |   2 -
>  arch/microblaze/kernel/signal.c               |   7 -
>  arch/microblaze/kernel/unwind.c               |  19 -
>  arch/microblaze/mm/Makefile                   |   2 +-
>  arch/microblaze/mm/consistent.c               |  29 -
>  arch/microblaze/mm/init.c                     |  49 --
>  arch/microblaze/pci/pci-common.c              |   2 -
>  32 files changed, 11 insertions(+), 1251 deletions(-)
>  delete mode 100644 arch/microblaze/configs/nommu_defconfig
>  delete mode 100644 arch/microblaze/kernel/entry-nommu.S
>
> diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
> index 33925ffed68f..32739ab2af25 100644
> --- a/arch/microblaze/Kconfig
> +++ b/arch/microblaze/Kconfig
> @@ -3,19 +3,17 @@ config MICROBLAZE
>         def_bool y
>         select ARCH_32BIT_OFF_T
>         select ARCH_NO_SWAP
> -       select ARCH_HAS_BINFMT_FLAT if !MMU
>         select ARCH_HAS_DMA_PREP_COHERENT
>         select ARCH_HAS_GCOV_PROFILE_ALL
>         select ARCH_HAS_SYNC_DMA_FOR_CPU
>         select ARCH_HAS_SYNC_DMA_FOR_DEVICE
> -       select ARCH_HAS_DMA_SET_UNCACHED if !MMU
>         select ARCH_MIGHT_HAVE_PC_PARPORT
>         select ARCH_WANT_IPC_PARSE_VERSION
>         select BUILDTIME_TABLE_SORT
>         select TIMER_OF
>         select CLONE_BACKWARDS3
>         select COMMON_CLK
> -       select DMA_DIRECT_REMAP if MMU
> +       select DMA_DIRECT_REMAP
>         select GENERIC_ATOMIC64
>         select GENERIC_CLOCKEVENTS
>         select GENERIC_CPU_DEVICES
> @@ -45,7 +43,7 @@ config MICROBLAZE
>         select TRACING_SUPPORT
>         select VIRT_TO_BUS
>         select CPU_NO_EFFICIENT_FFS
> -       select MMU_GATHER_NO_RANGE if MMU
> +       select MMU_GATHER_NO_RANGE
>         select SPARSE_IRQ
>         select SET_FS
>
> @@ -96,8 +94,7 @@ menu "Processor type and features"
>  source "kernel/Kconfig.hz"
>
>  config MMU
> -       bool "MMU support"
> -       default n
> +       def_bool y
>
>  comment "Boot options"
>
> @@ -143,18 +140,8 @@ config ADVANCED_OPTIONS
>  comment "Default settings for advanced configuration options are used"
>         depends on !ADVANCED_OPTIONS
>
> -config XILINX_UNCACHED_SHADOW
> -       bool "Are you using uncached shadow for RAM ?"
> -       depends on ADVANCED_OPTIONS && !MMU
> -       default n
> -       help
> -         This is needed to be able to allocate uncachable memory regions=
.
> -         The feature requires the design to define the RAM memory contro=
ller
> -         window to be twice as large as the actual physical memory.
> -
>  config HIGHMEM
>         bool "High memory support"
> -       depends on MMU
>         help
>           The address space of Microblaze processors is only 4 Gigabytes =
large
>           and it has to accommodate user address space, kernel address
> @@ -167,7 +154,7 @@ config HIGHMEM
>
>  config LOWMEM_SIZE_BOOL
>         bool "Set maximum low memory"
> -       depends on ADVANCED_OPTIONS && MMU
> +       depends on ADVANCED_OPTIONS
>         help
>           This option allows you to set the maximum amount of memory whic=
h
>           will be used as "low memory", that is, memory which the kernel =
can
> @@ -205,12 +192,11 @@ config KERNEL_START_BOOL
>
>  config KERNEL_START
>         hex "Virtual address of kernel base" if KERNEL_START_BOOL
> -       default "0xc0000000" if MMU
> -       default KERNEL_BASE_ADDR if !MMU
> +       default "0xc0000000"
>
>  config TASK_SIZE_BOOL
>         bool "Set custom user task size"
> -       depends on ADVANCED_OPTIONS && MMU
> +       depends on ADVANCED_OPTIONS
>         help
>           This option allows you to set the amount of virtual address spa=
ce
>           allocated to user tasks.  This can be useful in optimizing the
> @@ -222,33 +208,6 @@ config TASK_SIZE
>         hex "Size of user task space" if TASK_SIZE_BOOL
>         default "0x80000000"
>
> -choice
> -       prompt "Page size"
> -       default MICROBLAZE_4K_PAGES
> -       depends on ADVANCED_OPTIONS && !MMU
> -       help
> -         Select the kernel logical page size. Increasing the page size
> -         will reduce software overhead at each page boundary, allow
> -         hardware prefetch mechanisms to be more effective, and allow
> -         larger dma transfers increasing IO efficiency and reducing
> -         overhead. However the utilization of memory will increase.
> -         For example, each cached file will using a multiple of the
> -         page size to hold its contents and the difference between the
> -         end of file and the end of page is wasted.
> -
> -         If unsure, choose 4K_PAGES.
> -
> -config MICROBLAZE_4K_PAGES
> -       bool "4k page size"
> -
> -config MICROBLAZE_16K_PAGES
> -       bool "16k page size"
> -
> -config MICROBLAZE_64K_PAGES
> -       bool "64k page size"
> -
> -endchoice
> -
>  endmenu
>
>  menu "Bus Options"
> diff --git a/arch/microblaze/Makefile b/arch/microblaze/Makefile
> index 7b340a35b194..bb980891816d 100644
> --- a/arch/microblaze/Makefile
> +++ b/arch/microblaze/Makefile
> @@ -1,11 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  KBUILD_DEFCONFIG :=3D mmu_defconfig
>
> -ifeq ($(CONFIG_MMU),y)
>  UTS_SYSNAME =3D -DUTS_SYSNAME=3D\"Linux\"
> -else
> -UTS_SYSNAME =3D -DUTS_SYSNAME=3D\"uClinux\"
> -endif
>
>  # What CPU vesion are we building for, and crack it open
>  # as major.minor.rev
> @@ -67,12 +63,7 @@ DTB:=3D$(subst simpleImage.,,$(filter simpleImage.%, $=
(MAKECMDGOALS)))
>
>  core-y +=3D $(boot)/dts/
>
> -# defines filename extension depending memory management type
> -ifeq ($(CONFIG_MMU),)
> -MMU :=3D -nommu
> -endif
> -
> -export MMU DTB
> +export DTB
>
>  all: linux.bin
>
> diff --git a/arch/microblaze/configs/mmu_defconfig b/arch/microblaze/conf=
igs/mmu_defconfig
> index 9b8a50f30662..51337fffb947 100644
> --- a/arch/microblaze/configs/mmu_defconfig
> +++ b/arch/microblaze/configs/mmu_defconfig
> @@ -16,7 +16,6 @@ CONFIG_XILINX_MICROBLAZE0_USE_DIV=3D1
>  CONFIG_XILINX_MICROBLAZE0_USE_HW_MUL=3D2
>  CONFIG_XILINX_MICROBLAZE0_USE_FPU=3D2
>  CONFIG_HZ_100=3Dy
> -CONFIG_MMU=3Dy
>  CONFIG_CMDLINE_BOOL=3Dy
>  CONFIG_CMDLINE_FORCE=3Dy
>  CONFIG_HIGHMEM=3Dy
> diff --git a/arch/microblaze/configs/nommu_defconfig b/arch/microblaze/co=
nfigs/nommu_defconfig
> deleted file mode 100644
> index 8c420782d6e4..000000000000
> --- a/arch/microblaze/configs/nommu_defconfig
> +++ /dev/null
> @@ -1,90 +0,0 @@
> -CONFIG_SYSVIPC=3Dy
> -CONFIG_POSIX_MQUEUE=3Dy
> -CONFIG_AUDIT=3Dy
> -CONFIG_BSD_PROCESS_ACCT=3Dy
> -CONFIG_BSD_PROCESS_ACCT_V3=3Dy
> -CONFIG_IKCONFIG=3Dy
> -CONFIG_IKCONFIG_PROC=3Dy
> -CONFIG_SYSFS_DEPRECATED=3Dy
> -CONFIG_SYSFS_DEPRECATED_V2=3Dy
> -# CONFIG_BASE_FULL is not set
> -CONFIG_KALLSYMS_ALL=3Dy
> -CONFIG_EMBEDDED=3Dy
> -CONFIG_SLAB=3Dy
> -CONFIG_XILINX_MICROBLAZE0_USE_MSR_INSTR=3D1
> -CONFIG_XILINX_MICROBLAZE0_USE_PCMP_INSTR=3D1
> -CONFIG_XILINX_MICROBLAZE0_USE_BARREL=3D1
> -CONFIG_XILINX_MICROBLAZE0_USE_DIV=3D1
> -CONFIG_XILINX_MICROBLAZE0_USE_HW_MUL=3D2
> -CONFIG_XILINX_MICROBLAZE0_USE_FPU=3D2
> -CONFIG_HZ_100=3Dy
> -CONFIG_CMDLINE_BOOL=3Dy
> -CONFIG_CMDLINE_FORCE=3Dy
> -CONFIG_PCI_XILINX=3Dy
> -CONFIG_MODULES=3Dy
> -CONFIG_MODULE_UNLOAD=3Dy
> -# CONFIG_BLK_DEV_BSG is not set
> -CONFIG_PARTITION_ADVANCED=3Dy
> -# CONFIG_EFI_PARTITION is not set
> -CONFIG_NET=3Dy
> -CONFIG_PACKET=3Dy
> -CONFIG_UNIX=3Dy
> -CONFIG_INET=3Dy
> -# CONFIG_IPV6 is not set
> -CONFIG_PCI=3Dy
> -CONFIG_MTD=3Dy
> -CONFIG_MTD_CMDLINE_PARTS=3Dy
> -CONFIG_MTD_BLOCK=3Dy
> -CONFIG_MTD_CFI=3Dy
> -CONFIG_MTD_CFI_INTELEXT=3Dy
> -CONFIG_MTD_CFI_AMDSTD=3Dy
> -CONFIG_MTD_RAM=3Dy
> -CONFIG_MTD_UCLINUX=3Dy
> -CONFIG_BLK_DEV_RAM=3Dy
> -CONFIG_BLK_DEV_RAM_SIZE=3D8192
> -CONFIG_NETDEVICES=3Dy
> -CONFIG_XILINX_EMACLITE=3Dy
> -CONFIG_XILINX_LL_TEMAC=3Dy
> -# CONFIG_INPUT is not set
> -# CONFIG_SERIO is not set
> -# CONFIG_VT is not set
> -CONFIG_SERIAL_8250=3Dy
> -CONFIG_SERIAL_8250_CONSOLE=3Dy
> -CONFIG_SERIAL_OF_PLATFORM=3Dy
> -CONFIG_SERIAL_UARTLITE=3Dy
> -CONFIG_SERIAL_UARTLITE_CONSOLE=3Dy
> -# CONFIG_HW_RANDOM is not set
> -CONFIG_XILINX_HWICAP=3Dy
> -CONFIG_I2C=3Dy
> -CONFIG_I2C_XILINX=3Dy
> -CONFIG_SPI=3Dy
> -CONFIG_SPI_XILINX=3Dy
> -CONFIG_GPIOLIB=3Dy
> -CONFIG_GPIO_SYSFS=3Dy
> -CONFIG_GPIO_XILINX=3Dy
> -CONFIG_POWER_RESET=3Dy
> -CONFIG_POWER_RESET_GPIO_RESTART=3Dy
> -# CONFIG_HWMON is not set
> -CONFIG_WATCHDOG=3Dy
> -CONFIG_XILINX_WATCHDOG=3Dy
> -CONFIG_FB=3Dy
> -CONFIG_FB_XILINX=3Dy
> -# CONFIG_USB_SUPPORT is not set
> -CONFIG_EXT3_FS=3Dy
> -# CONFIG_DNOTIFY is not set
> -CONFIG_CRAMFS=3Dy
> -CONFIG_ROMFS_FS=3Dy
> -CONFIG_NFS_FS=3Dy
> -CONFIG_NFS_V3_ACL=3Dy
> -CONFIG_NLS=3Dy
> -CONFIG_KEYS=3Dy
> -CONFIG_ENCRYPTED_KEYS=3Dy
> -CONFIG_CRYPTO_ECB=3Dy
> -CONFIG_CRYPTO_MD4=3Dy
> -CONFIG_CRYPTO_MD5=3Dy
> -CONFIG_CRYPTO_ARC4=3Dy
> -CONFIG_CRYPTO_DES=3Dy
> -CONFIG_DEBUG_INFO=3Dy
> -CONFIG_DEBUG_SLAB=3Dy
> -CONFIG_DETECT_HUNG_TASK=3Dy
> -CONFIG_DEBUG_SPINLOCK=3Dy
> diff --git a/arch/microblaze/include/asm/dma.h b/arch/microblaze/include/=
asm/dma.h
> index e6cb6d0725af..f801582be912 100644
> --- a/arch/microblaze/include/asm/dma.h
> +++ b/arch/microblaze/include/asm/dma.h
> @@ -6,14 +6,8 @@
>  #ifndef _ASM_MICROBLAZE_DMA_H
>  #define _ASM_MICROBLAZE_DMA_H
>
> -#ifndef CONFIG_MMU
> -/* we don't have dma address limit. define it as zero to be
> - * unlimited. */
> -#define MAX_DMA_ADDRESS                (0)
> -#else
>  /* Virtual address corresponding to last available physical memory addre=
ss.  */
>  #define MAX_DMA_ADDRESS (CONFIG_KERNEL_START + memory_size - 1)
> -#endif
>
>  #ifdef CONFIG_PCI
>  extern int isa_dma_bridge_buggy;
> diff --git a/arch/microblaze/include/asm/exceptions.h b/arch/microblaze/i=
nclude/asm/exceptions.h
> index d67e65b72215..967f175173e1 100644
> --- a/arch/microblaze/include/asm/exceptions.h
> +++ b/arch/microblaze/include/asm/exceptions.h
> @@ -11,11 +11,6 @@
>  #define _ASM_MICROBLAZE_EXCEPTIONS_H
>
>  #ifdef __KERNEL__
> -
> -#ifndef CONFIG_MMU
> -#define EX_HANDLER_STACK_SIZ   (4*19)
> -#endif
> -
>  #ifndef __ASSEMBLY__
>
>  /* Macros to enable and disable HW exceptions in the MSR */
> diff --git a/arch/microblaze/include/asm/io.h b/arch/microblaze/include/a=
sm/io.h
> index 1dd6fae41897..b6a57f8468f0 100644
> --- a/arch/microblaze/include/asm/io.h
> +++ b/arch/microblaze/include/asm/io.h
> @@ -30,15 +30,12 @@ extern resource_size_t isa_mem_base;
>  #define PCI_IOBASE     ((void __iomem *)_IO_BASE)
>  #define IO_SPACE_LIMIT (0xFFFFFFFF)
>
> -#ifdef CONFIG_MMU
>  #define page_to_bus(page)      (page_to_phys(page))
>
>  extern void iounmap(volatile void __iomem *addr);
>
>  extern void __iomem *ioremap(phys_addr_t address, unsigned long size);
>
> -#endif /* CONFIG_MMU */
> -
>  /* Big Endian */
>  #define out_be32(a, v) __raw_writel((v), (void __iomem __force *)(a))
>  #define out_be16(a, v) __raw_writew((v), (a))
> diff --git a/arch/microblaze/include/asm/mmu.h b/arch/microblaze/include/=
asm/mmu.h
> index 97f1243101cc..b928a87c0076 100644
> --- a/arch/microblaze/include/asm/mmu.h
> +++ b/arch/microblaze/include/asm/mmu.h
> @@ -8,9 +8,6 @@
>  #ifndef _ASM_MICROBLAZE_MMU_H
>  #define _ASM_MICROBLAZE_MMU_H
>
> -# ifndef CONFIG_MMU
> -#  include <asm-generic/mmu.h>
> -# else /* CONFIG_MMU */
>  #  ifdef __KERNEL__
>  #   ifndef __ASSEMBLY__
>
> @@ -119,5 +116,4 @@ extern u32 tlb_skip;
>  #  define TLB_G                        0x00000001 /* Memory is guarded f=
rom prefetch */
>
>  #  endif /* __KERNEL__ */
> -# endif /* CONFIG_MMU */
>  #endif /* _ASM_MICROBLAZE_MMU_H */
> diff --git a/arch/microblaze/include/asm/mmu_context.h b/arch/microblaze/=
include/asm/mmu_context.h
> index f74f9da07fdc..866e52da5eb9 100644
> --- a/arch/microblaze/include/asm/mmu_context.h
> +++ b/arch/microblaze/include/asm/mmu_context.h
> @@ -1,6 +1,2 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
> -#ifdef CONFIG_MMU
>  # include <asm/mmu_context_mm.h>
> -#else
> -# include <asm-generic/mmu_context.h>
> -#endif
> diff --git a/arch/microblaze/include/asm/page.h b/arch/microblaze/include=
/asm/page.h
> index b13463d39b38..bf681f272f72 100644
> --- a/arch/microblaze/include/asm/page.h
> +++ b/arch/microblaze/include/asm/page.h
> @@ -20,13 +20,7 @@
>  #ifdef __KERNEL__
>
>  /* PAGE_SHIFT determines the page size */
> -#if defined(CONFIG_MICROBLAZE_64K_PAGES)
> -#define PAGE_SHIFT             16
> -#elif defined(CONFIG_MICROBLAZE_16K_PAGES)
> -#define PAGE_SHIFT             14
> -#else
>  #define PAGE_SHIFT             12
> -#endif
>  #define PAGE_SIZE      (ASM_CONST(1) << PAGE_SHIFT)
>  #define PAGE_MASK      (~(PAGE_SIZE-1))
>
> @@ -44,17 +38,6 @@
>  #define PAGE_UP(addr)  (((addr)+((PAGE_SIZE)-1))&(~((PAGE_SIZE)-1)))
>  #define PAGE_DOWN(addr)        ((addr)&(~((PAGE_SIZE)-1)))
>
> -#ifndef CONFIG_MMU
> -/*
> - * PAGE_OFFSET -- the first address of the first page of memory. When no=
t
> - * using MMU this corresponds to the first free page in physical memory =
(aligned
> - * on a page boundary).
> - */
> -extern unsigned int __page_offset;
> -#define PAGE_OFFSET __page_offset
> -
> -#else /* CONFIG_MMU */
> -
>  /*
>   * PAGE_OFFSET -- the first address of the first page of memory. With MM=
U
>   * it is set to the kernel start address (aligned on a page boundary).
> @@ -70,8 +53,6 @@ extern unsigned int __page_offset;
>  typedef unsigned long pte_basic_t;
>  #define PTE_FMT                "%.8lx"
>
> -#endif /* CONFIG_MMU */
> -
>  # define copy_page(to, from)                   memcpy((to), (from), PAGE=
_SIZE)
>  # define clear_page(pgaddr)                    memset((pgaddr), 0, PAGE_=
SIZE)
>
> @@ -86,25 +67,12 @@ typedef struct page *pgtable_t;
>  typedef struct { unsigned long pte; }          pte_t;
>  typedef struct { unsigned long pgprot; }       pgprot_t;
>  /* FIXME this can depend on linux kernel version */
> -#   ifdef CONFIG_MMU
>  typedef struct { unsigned long pgd; } pgd_t;
> -#   else /* CONFIG_MMU */
> -typedef struct { unsigned long ste[64]; }      pmd_t;
> -typedef struct { pmd_t         pue[1]; }       pud_t;
> -typedef struct { pud_t         p4e[1]; }       p4d_t;
> -typedef struct { p4d_t         pge[1]; }       pgd_t;
> -#   endif /* CONFIG_MMU */
>
>  # define pte_val(x)    ((x).pte)
>  # define pgprot_val(x) ((x).pgprot)
>
> -#   ifdef CONFIG_MMU
>  #   define pgd_val(x)      ((x).pgd)
> -#   else  /* CONFIG_MMU */
> -#   define pmd_val(x)  ((x).ste[0])
> -#   define pud_val(x)  ((x).pue[0])
> -#   define pgd_val(x)  ((x).pge[0])
> -#   endif  /* CONFIG_MMU */
>
>  # define __pte(x)      ((pte_t) { (x) })
>  # define __pgd(x)      ((pgd_t) { (x) })
> @@ -142,28 +110,12 @@ extern int page_is_ram(unsigned long pfn);
>  # define virt_to_pfn(vaddr)    (phys_to_pfn((__pa(vaddr))))
>  # define pfn_to_virt(pfn)      __va(pfn_to_phys((pfn)))
>
> -#  ifdef CONFIG_MMU
> -
>  #  define virt_to_page(kaddr)  (pfn_to_page(__pa(kaddr) >> PAGE_SHIFT))
>  #  define page_to_virt(page)   __va(page_to_pfn(page) << PAGE_SHIFT)
>  #  define page_to_phys(page)     (page_to_pfn(page) << PAGE_SHIFT)
>
> -#  else /* CONFIG_MMU */
> -#  define virt_to_page(vaddr)  (pfn_to_page(virt_to_pfn(vaddr)))
> -#  define page_to_virt(page)   (pfn_to_virt(page_to_pfn(page)))
> -#  define page_to_phys(page)   (pfn_to_phys(page_to_pfn(page)))
> -#  define page_to_bus(page)    (page_to_phys(page))
> -#  define phys_to_page(paddr)  (pfn_to_page(phys_to_pfn(paddr)))
> -#  endif /* CONFIG_MMU */
> -
> -#  ifndef CONFIG_MMU
> -#  define pfn_valid(pfn)       (((pfn) >=3D min_low_pfn) && \
> -                               ((pfn) <=3D (min_low_pfn + max_mapnr)))
> -#  define ARCH_PFN_OFFSET      (PAGE_OFFSET >> PAGE_SHIFT)
> -#  else /* CONFIG_MMU */
>  #  define ARCH_PFN_OFFSET      (memory_start >> PAGE_SHIFT)
>  #  define pfn_valid(pfn)       ((pfn) < (max_mapnr + ARCH_PFN_OFFSET))
> -#  endif /* CONFIG_MMU */
>
>  # endif /* __ASSEMBLY__ */
>
> @@ -174,12 +126,6 @@ extern int page_is_ram(unsigned long pfn);
>
>  /* Convert between virtual and physical address for MMU. */
>  /* Handle MicroBlaze processor with virtual memory. */
> -#ifndef CONFIG_MMU
> -#define __virt_to_phys(addr)   addr
> -#define __phys_to_virt(addr)   addr
> -#define tophys(rd, rs) addik rd, rs, 0
> -#define tovirt(rd, rs) addik rd, rs, 0
> -#else
>  #define __virt_to_phys(addr) \
>         ((addr) + CONFIG_KERNEL_BASE_ADDR - CONFIG_KERNEL_START)
>  #define __phys_to_virt(addr) \
> @@ -188,14 +134,9 @@ extern int page_is_ram(unsigned long pfn);
>         addik rd, rs, (CONFIG_KERNEL_BASE_ADDR - CONFIG_KERNEL_START)
>  #define tovirt(rd, rs) \
>         addik rd, rs, (CONFIG_KERNEL_START - CONFIG_KERNEL_BASE_ADDR)
> -#endif /* CONFIG_MMU */
>
>  #define TOPHYS(addr)  __virt_to_phys(addr)
>
> -#ifdef CONFIG_MMU
> -
> -#endif /* CONFIG_MMU */
> -
>  #endif /* __KERNEL__ */
>
>  #include <asm-generic/memory_model.h>
> diff --git a/arch/microblaze/include/asm/pgalloc.h b/arch/microblaze/incl=
ude/asm/pgalloc.h
> index 8839ce00ea05..d56b9f670ad1 100644
> --- a/arch/microblaze/include/asm/pgalloc.h
> +++ b/arch/microblaze/include/asm/pgalloc.h
> @@ -8,8 +8,6 @@
>  #ifndef _ASM_MICROBLAZE_PGALLOC_H
>  #define _ASM_MICROBLAZE_PGALLOC_H
>
> -#ifdef CONFIG_MMU
> -
>  #include <linux/kernel.h>      /* For min/max macros */
>  #include <linux/highmem.h>
>  #include <linux/pgtable.h>
> @@ -42,6 +40,4 @@ extern pte_t *pte_alloc_one_kernel(struct mm_struct *mm=
);
>  #define pmd_populate_kernel(mm, pmd, pte) \
>                 (pmd_val(*(pmd)) =3D (unsigned long) (pte))
>
> -#endif /* CONFIG_MMU */
> -
>  #endif /* _ASM_MICROBLAZE_PGALLOC_H */
> diff --git a/arch/microblaze/include/asm/pgtable.h b/arch/microblaze/incl=
ude/asm/pgtable.h
> index 3fa1df90925e..9ae8d2c17dd5 100644
> --- a/arch/microblaze/include/asm/pgtable.h
> +++ b/arch/microblaze/include/asm/pgtable.h
> @@ -14,47 +14,6 @@
>  extern int mem_init_done;
>  #endif
>
> -#ifndef CONFIG_MMU
> -
> -#define pgd_present(pgd)       (1) /* pages are always present on non MM=
U */
> -#define pgd_none(pgd)          (0)
> -#define pgd_bad(pgd)           (0)
> -#define pgd_clear(pgdp)
> -#define kern_addr_valid(addr)  (1)
> -
> -#define PAGE_NONE              __pgprot(0) /* these mean nothing to non =
MMU */
> -#define PAGE_SHARED            __pgprot(0) /* these mean nothing to non =
MMU */
> -#define PAGE_COPY              __pgprot(0) /* these mean nothing to non =
MMU */
> -#define PAGE_READONLY          __pgprot(0) /* these mean nothing to non =
MMU */
> -#define PAGE_KERNEL            __pgprot(0) /* these mean nothing to non =
MMU */
> -
> -#define pgprot_noncached(x)    (x)
> -#define pgprot_writecombine    pgprot_noncached
> -#define pgprot_device          pgprot_noncached
> -
> -#define __swp_type(x)          (0)
> -#define __swp_offset(x)                (0)
> -#define __swp_entry(typ, off)  ((swp_entry_t) { ((typ) | ((off) << 7)) }=
)
> -#define __pte_to_swp_entry(pte)        ((swp_entry_t) { pte_val(pte) })
> -#define __swp_entry_to_pte(x)  ((pte_t) { (x).val })
> -
> -#define ZERO_PAGE(vaddr)       ({ BUG(); NULL; })
> -
> -#define swapper_pg_dir ((pgd_t *) NULL)
> -
> -#define arch_enter_lazy_cpu_mode()     do {} while (0)
> -
> -#define pgprot_noncached_wc(prot)      prot
> -
> -/*
> - * All 32bit addresses are effectively valid for vmalloc...
> - * Sort of meaningless for non-VM targets.
> - */
> -#define        VMALLOC_START   0
> -#define        VMALLOC_END     0xffffffff
> -
> -#else /* CONFIG_MMU */
> -
>  #include <asm-generic/pgtable-nopmd.h>
>
>  #ifdef __KERNEL__
> @@ -491,8 +450,6 @@ void __init *early_get_page(void);
>  #endif /* __ASSEMBLY__ */
>  #endif /* __KERNEL__ */
>
> -#endif /* CONFIG_MMU */
> -
>  #ifndef __ASSEMBLY__
>  extern unsigned long ioremap_bot, ioremap_base;
>
> diff --git a/arch/microblaze/include/asm/processor.h b/arch/microblaze/in=
clude/asm/processor.h
> index 1ff5a82b76b6..f4f3048cde4c 100644
> --- a/arch/microblaze/include/asm/processor.h
> +++ b/arch/microblaze/include/asm/processor.h
> @@ -31,42 +31,6 @@ extern void ret_from_kernel_thread(void);
>
>  # endif /* __ASSEMBLY__ */
>
> -# ifndef CONFIG_MMU
> -/*
> - * User space process size: memory size
> - *
> - * TASK_SIZE on MMU cpu is usually 1GB. However, on no-MMU arch, both
> - * user processes and the kernel is on the same memory region. They
> - * both share the memory space and that is limited by the amount of
> - * physical memory. thus, we set TASK_SIZE =3D=3D amount of total memory=
.
> - */
> -# define TASK_SIZE     (0x81000000 - 0x80000000)
> -
> -/*
> - * This decides where the kernel will search for a free chunk of vm
> - * space during mmap's. We won't be using it
> - */
> -# define TASK_UNMAPPED_BASE    0
> -
> -/* definition in include/linux/sched.h */
> -struct task_struct;
> -
> -/* thread_struct is gone. use thread_info instead. */
> -struct thread_struct { };
> -# define INIT_THREAD   { }
> -
> -/* Free all resources held by a thread. */
> -static inline void release_thread(struct task_struct *dead_task)
> -{
> -}
> -
> -extern unsigned long get_wchan(struct task_struct *p);
> -
> -# define KSTK_EIP(tsk) (0)
> -# define KSTK_ESP(tsk) (0)
> -
> -# else /* CONFIG_MMU */
> -
>  /*
>   * This is used to define STACK_TOP, and with MMU it must be below
>   * kernel base to select the correct PGD when handling MMU exceptions.
> @@ -133,5 +97,4 @@ extern struct dentry *of_debugfs_root;
>  #endif
>
>  #  endif /* __ASSEMBLY__ */
> -# endif /* CONFIG_MMU */
>  #endif /* _ASM_MICROBLAZE_PROCESSOR_H */
> diff --git a/arch/microblaze/include/asm/registers.h b/arch/microblaze/in=
clude/asm/registers.h
> index ee81e1cba008..6b36693fc621 100644
> --- a/arch/microblaze/include/asm/registers.h
> +++ b/arch/microblaze/include/asm/registers.h
> @@ -27,7 +27,6 @@
>  #define FSR_UF         (1<<1) /* Underflow */
>  #define FSR_DO         (1<<0) /* Denormalized operand error */
>
> -# ifdef CONFIG_MMU
>  /* Machine State Register (MSR) Fields */
>  # define MSR_UM                (1<<11) /* User Mode */
>  # define MSR_UMS       (1<<12) /* User Mode Save */
> @@ -43,5 +42,4 @@
>  # define         ESR_DIZ       (1<<11) /* Zone Protection */
>  # define         ESR_S         (1<<10) /* Store instruction */
>
> -# endif /* CONFIG_MMU */
>  #endif /* _ASM_MICROBLAZE_REGISTERS_H */
> diff --git a/arch/microblaze/include/asm/setup.h b/arch/microblaze/includ=
e/asm/setup.h
> index be10da9d87cb..a06cc1f97aa9 100644
> --- a/arch/microblaze/include/asm/setup.h
> +++ b/arch/microblaze/include/asm/setup.h
> @@ -14,9 +14,7 @@ extern char cmd_line[COMMAND_LINE_SIZE];
>
>  extern char *klimit;
>
> -#   ifdef CONFIG_MMU
>  extern void mmu_reset(void);
> -#   endif /* CONFIG_MMU */
>
>  void time_init(void);
>  void init_IRQ(void);
> diff --git a/arch/microblaze/include/asm/tlbflush.h b/arch/microblaze/inc=
lude/asm/tlbflush.h
> index 1200e2bf14bb..2038168ed128 100644
> --- a/arch/microblaze/include/asm/tlbflush.h
> +++ b/arch/microblaze/include/asm/tlbflush.h
> @@ -8,8 +8,6 @@
>  #ifndef _ASM_MICROBLAZE_TLBFLUSH_H
>  #define _ASM_MICROBLAZE_TLBFLUSH_H
>
> -#ifdef CONFIG_MMU
> -
>  #include <linux/sched.h>
>  #include <linux/threads.h>
>  #include <asm/processor.h>     /* For TASK_SIZE */
> @@ -50,16 +48,4 @@ static inline void local_flush_tlb_range(struct vm_are=
a_struct *vma,
>  static inline void flush_tlb_pgtables(struct mm_struct *mm,
>         unsigned long start, unsigned long end) { }
>
> -#else /* CONFIG_MMU */
> -
> -#define flush_tlb()                            BUG()
> -#define flush_tlb_all()                                BUG()
> -#define flush_tlb_mm(mm)                       BUG()
> -#define flush_tlb_page(vma, addr)              BUG()
> -#define flush_tlb_range(mm, start, end)                BUG()
> -#define flush_tlb_pgtables(mm, start, end)     BUG()
> -#define flush_tlb_kernel_range(start, end)     BUG()
> -
> -#endif /* CONFIG_MMU */
> -
>  #endif /* _ASM_MICROBLAZE_TLBFLUSH_H */
> diff --git a/arch/microblaze/include/asm/uaccess.h b/arch/microblaze/incl=
ude/asm/uaccess.h
> index 304b04ffea2f..c44b59470e45 100644
> --- a/arch/microblaze/include/asm/uaccess.h
> +++ b/arch/microblaze/include/asm/uaccess.h
> @@ -30,35 +30,14 @@
>   */
>  # define MAKE_MM_SEG(s)       ((mm_segment_t) { (s) })
>
> -#  ifndef CONFIG_MMU
> -#  define KERNEL_DS    MAKE_MM_SEG(0)
> -#  define USER_DS      KERNEL_DS
> -#  else
>  #  define KERNEL_DS    MAKE_MM_SEG(0xFFFFFFFF)
>  #  define USER_DS      MAKE_MM_SEG(TASK_SIZE - 1)
> -#  endif
>
>  # define get_fs()      (current_thread_info()->addr_limit)
>  # define set_fs(val)   (current_thread_info()->addr_limit =3D (val))
>
>  # define uaccess_kernel()      (get_fs().seg =3D=3D KERNEL_DS.seg)
>
> -#ifndef CONFIG_MMU
> -
> -/* Check against bounds of physical memory */
> -static inline int ___range_ok(unsigned long addr, unsigned long size)
> -{
> -       return ((addr < memory_start) ||
> -               ((addr + size - 1) > (memory_start + memory_size - 1)));
> -}
> -
> -#define __range_ok(addr, size) \
> -               ___range_ok((unsigned long)(addr), (unsigned long)(size))
> -
> -#define access_ok(addr, size) (__range_ok((addr), (size)) =3D=3D 0)
> -
> -#else
> -
>  static inline int access_ok(const void __user *addr, unsigned long size)
>  {
>         if (!size)
> @@ -77,15 +56,9 @@ static inline int access_ok(const void __user *addr, u=
nsigned long size)
>                         (u32)get_fs().seg);
>         return 1;
>  }
> -#endif
>
> -#ifdef CONFIG_MMU
>  # define __FIXUP_SECTION       ".section .fixup,\"ax\"\n"
>  # define __EX_TABLE_SECTION    ".section __ex_table,\"a\"\n"
> -#else
> -# define __FIXUP_SECTION       ".section .discard,\"ax\"\n"
> -# define __EX_TABLE_SECTION    ".section .discard,\"ax\"\n"
> -#endif
>
>  extern unsigned long __copy_tofrom_user(void __user *to,
>                 const void __user *from, unsigned long size);
> diff --git a/arch/microblaze/kernel/Makefile b/arch/microblaze/kernel/Mak=
efile
> index dd71637437f4..15a20eb814ce 100644
> --- a/arch/microblaze/kernel/Makefile
> +++ b/arch/microblaze/kernel/Makefile
> @@ -22,9 +22,9 @@ obj-y +=3D dma.o exceptions.o \
>  obj-y +=3D cpu/
>
>  obj-$(CONFIG_MODULES)          +=3D microblaze_ksyms.o module.o
> -obj-$(CONFIG_MMU)              +=3D misc.o
> +obj-y                          +=3D misc.o
>  obj-$(CONFIG_STACKTRACE)       +=3D stacktrace.o
>  obj-$(CONFIG_FUNCTION_TRACER)  +=3D ftrace.o mcount.o
>  obj-$(CONFIG_KGDB)             +=3D kgdb.o
>
> -obj-y  +=3D entry$(MMU).o
> +obj-y  +=3D entry.o
> diff --git a/arch/microblaze/kernel/asm-offsets.c b/arch/microblaze/kerne=
l/asm-offsets.c
> index c1b459c97571..6c69ce7be2e8 100644
> --- a/arch/microblaze/kernel/asm-offsets.c
> +++ b/arch/microblaze/kernel/asm-offsets.c
> @@ -70,7 +70,6 @@ int main(int argc, char *argv[])
>
>         /* struct task_struct */
>         DEFINE(TS_THREAD_INFO, offsetof(struct task_struct, stack));
> -#ifdef CONFIG_MMU
>         DEFINE(TASK_STATE, offsetof(struct task_struct, state));
>         DEFINE(TASK_FLAGS, offsetof(struct task_struct, flags));
>         DEFINE(TASK_PTRACE, offsetof(struct task_struct, ptrace));
> @@ -84,7 +83,6 @@ int main(int argc, char *argv[])
>
>         DEFINE(PGDIR, offsetof(struct thread_struct, pgdir));
>         BLANK();
> -#endif
>
>         /* struct thread_info */
>         DEFINE(TI_TASK, offsetof(struct thread_info, task));
> diff --git a/arch/microblaze/kernel/entry-nommu.S b/arch/microblaze/kerne=
l/entry-nommu.S
> deleted file mode 100644
> index 7e394fc2c439..000000000000
> --- a/arch/microblaze/kernel/entry-nommu.S
> +++ /dev/null
> @@ -1,622 +0,0 @@
> -/*
> - * Copyright (C) 2007-2009 Michal Simek <monstr@monstr.eu>
> - * Copyright (C) 2007-2009 PetaLogix
> - * Copyright (C) 2006 Atmark Techno, Inc.
> - *
> - * This file is subject to the terms and conditions of the GNU General P=
ublic
> - * License. See the file "COPYING" in the main directory of this archive
> - * for more details.
> - */
> -
> -#include <linux/linkage.h>
> -#include <asm/thread_info.h>
> -#include <linux/errno.h>
> -#include <asm/entry.h>
> -#include <asm/asm-offsets.h>
> -#include <asm/registers.h>
> -#include <asm/unistd.h>
> -#include <asm/percpu.h>
> -#include <asm/signal.h>
> -
> -#if CONFIG_XILINX_MICROBLAZE0_USE_MSR_INSTR
> -       .macro  disable_irq
> -       msrclr r0, MSR_IE
> -       .endm
> -
> -       .macro  enable_irq
> -       msrset r0, MSR_IE
> -       .endm
> -
> -       .macro  clear_bip
> -       msrclr r0, MSR_BIP
> -       .endm
> -#else
> -       .macro  disable_irq
> -       mfs r11, rmsr
> -       andi r11, r11, ~MSR_IE
> -       mts rmsr, r11
> -       .endm
> -
> -       .macro  enable_irq
> -       mfs r11, rmsr
> -       ori r11, r11, MSR_IE
> -       mts rmsr, r11
> -       .endm
> -
> -       .macro  clear_bip
> -       mfs r11, rmsr
> -       andi r11, r11, ~MSR_BIP
> -       mts rmsr, r11
> -       .endm
> -#endif
> -
> -ENTRY(_interrupt)
> -       swi     r1, r0, PER_CPU(ENTRY_SP)       /* save the current sp */
> -       swi     r11, r0, PER_CPU(R11_SAVE)      /* temporarily save r11 *=
/
> -       lwi     r11, r0, PER_CPU(KM)            /* load mode indicator */
> -       beqid   r11, 1f
> -       nop
> -       brid    2f                              /* jump over */
> -       addik   r1, r1, (-PT_SIZE)      /* room for pt_regs (delay slot) =
*/
> -1:                                             /* switch to kernel stack=
 */
> -       lwi     r1, r0, PER_CPU(CURRENT_SAVE)   /* get the saved current =
*/
> -       lwi     r1, r1, TS_THREAD_INFO          /* get the thread info */
> -       /* calculate kernel stack pointer */
> -       addik   r1, r1, THREAD_SIZE - PT_SIZE
> -2:
> -       swi     r11, r1, PT_MODE                /* store the mode */
> -       lwi     r11, r0, PER_CPU(R11_SAVE)      /* reload r11 */
> -       swi     r2, r1, PT_R2
> -       swi     r3, r1, PT_R3
> -       swi     r4, r1, PT_R4
> -       swi     r5, r1, PT_R5
> -       swi     r6, r1, PT_R6
> -       swi     r7, r1, PT_R7
> -       swi     r8, r1, PT_R8
> -       swi     r9, r1, PT_R9
> -       swi     r10, r1, PT_R10
> -       swi     r11, r1, PT_R11
> -       swi     r12, r1, PT_R12
> -       swi     r13, r1, PT_R13
> -       swi     r14, r1, PT_R14
> -       swi     r14, r1, PT_PC
> -       swi     r15, r1, PT_R15
> -       swi     r16, r1, PT_R16
> -       swi     r17, r1, PT_R17
> -       swi     r18, r1, PT_R18
> -       swi     r19, r1, PT_R19
> -       swi     r20, r1, PT_R20
> -       swi     r21, r1, PT_R21
> -       swi     r22, r1, PT_R22
> -       swi     r23, r1, PT_R23
> -       swi     r24, r1, PT_R24
> -       swi     r25, r1, PT_R25
> -       swi     r26, r1, PT_R26
> -       swi     r27, r1, PT_R27
> -       swi     r28, r1, PT_R28
> -       swi     r29, r1, PT_R29
> -       swi     r30, r1, PT_R30
> -       swi     r31, r1, PT_R31
> -       /* special purpose registers */
> -       mfs     r11, rmsr
> -       swi     r11, r1, PT_MSR
> -       mfs     r11, rear
> -       swi     r11, r1, PT_EAR
> -       mfs     r11, resr
> -       swi     r11, r1, PT_ESR
> -       mfs     r11, rfsr
> -       swi     r11, r1, PT_FSR
> -       /* reload original stack pointer and save it */
> -       lwi     r11, r0, PER_CPU(ENTRY_SP)
> -       swi     r11, r1, PT_R1
> -       /* update mode indicator we are in kernel mode */
> -       addik   r11, r0, 1
> -       swi     r11, r0, PER_CPU(KM)
> -       /* restore r31 */
> -       lwi     r31, r0, PER_CPU(CURRENT_SAVE)
> -       /* prepare the link register, the argument and jump */
> -       addik   r15, r0, ret_from_intr - 8
> -       addk    r6, r0, r15
> -       braid   do_IRQ
> -       add     r5, r0, r1
> -
> -ret_from_intr:
> -       lwi     r11, r1, PT_MODE
> -       bneid   r11, no_intr_resched
> -
> -3:
> -       lwi     r6, r31, TS_THREAD_INFO /* get thread info */
> -       lwi     r19, r6, TI_FLAGS       /* get flags in thread info */
> -                               /* do an extra work if any bits are set *=
/
> -
> -       andi    r11, r19, _TIF_NEED_RESCHED
> -       beqi    r11, 1f
> -       bralid  r15, schedule
> -       nop
> -       bri     3b
> -1:     andi    r11, r19, _TIF_SIGPENDING | _TIF_NOTIFY_RESUME
> -       beqid   r11, no_intr_resched
> -       addk    r5, r1, r0
> -       bralid  r15, do_notify_resume
> -       addk    r6, r0, r0
> -       bri     3b
> -
> -no_intr_resched:
> -       /* Disable interrupts, we are now committed to the state restore =
*/
> -       disable_irq
> -
> -       /* save mode indicator */
> -       lwi     r11, r1, PT_MODE
> -       swi     r11, r0, PER_CPU(KM)
> -
> -       /* save r31 */
> -       swi     r31, r0, PER_CPU(CURRENT_SAVE)
> -restore_context:
> -       /* special purpose registers */
> -       lwi     r11, r1, PT_FSR
> -       mts     rfsr, r11
> -       lwi     r11, r1, PT_ESR
> -       mts     resr, r11
> -       lwi     r11, r1, PT_EAR
> -       mts     rear, r11
> -       lwi     r11, r1, PT_MSR
> -       mts     rmsr, r11
> -
> -       lwi     r31, r1, PT_R31
> -       lwi     r30, r1, PT_R30
> -       lwi     r29, r1, PT_R29
> -       lwi     r28, r1, PT_R28
> -       lwi     r27, r1, PT_R27
> -       lwi     r26, r1, PT_R26
> -       lwi     r25, r1, PT_R25
> -       lwi     r24, r1, PT_R24
> -       lwi     r23, r1, PT_R23
> -       lwi     r22, r1, PT_R22
> -       lwi     r21, r1, PT_R21
> -       lwi     r20, r1, PT_R20
> -       lwi     r19, r1, PT_R19
> -       lwi     r18, r1, PT_R18
> -       lwi     r17, r1, PT_R17
> -       lwi     r16, r1, PT_R16
> -       lwi     r15, r1, PT_R15
> -       lwi     r14, r1, PT_PC
> -       lwi     r13, r1, PT_R13
> -       lwi     r12, r1, PT_R12
> -       lwi     r11, r1, PT_R11
> -       lwi     r10, r1, PT_R10
> -       lwi     r9, r1, PT_R9
> -       lwi     r8, r1, PT_R8
> -       lwi     r7, r1, PT_R7
> -       lwi     r6, r1, PT_R6
> -       lwi     r5, r1, PT_R5
> -       lwi     r4, r1, PT_R4
> -       lwi     r3, r1, PT_R3
> -       lwi     r2, r1, PT_R2
> -       lwi     r1, r1, PT_R1
> -       rtid    r14, 0
> -       nop
> -
> -ENTRY(_reset)
> -       brai    0;
> -
> -ENTRY(_user_exception)
> -       swi     r1, r0, PER_CPU(ENTRY_SP)       /* save the current sp */
> -       swi     r11, r0, PER_CPU(R11_SAVE)      /* temporarily save r11 *=
/
> -       lwi     r11, r0, PER_CPU(KM)            /* load mode indicator */
> -       beqid   r11, 1f                         /* Already in kernel mode=
? */
> -       nop
> -       brid    2f                              /* jump over */
> -       addik   r1, r1, (-PT_SIZE)      /* Room for pt_regs (delay slot) =
*/
> -1:                                             /* Switch to kernel stack=
 */
> -       lwi     r1, r0, PER_CPU(CURRENT_SAVE)   /* get the saved current =
*/
> -       lwi     r1, r1, TS_THREAD_INFO          /* get the thread info */
> -       /* calculate kernel stack pointer */
> -       addik   r1, r1, THREAD_SIZE - PT_SIZE
> -2:
> -       swi     r11, r1, PT_MODE                /* store the mode */
> -       lwi     r11, r0, PER_CPU(R11_SAVE)      /* reload r11 */
> -       /* save them on stack */
> -       swi     r2, r1, PT_R2
> -       swi     r3, r1, PT_R3 /* r3: _always_ in clobber list; see unistd=
.h */
> -       swi     r4, r1, PT_R4 /* r4: _always_ in clobber list; see unistd=
.h */
> -       swi     r5, r1, PT_R5
> -       swi     r6, r1, PT_R6
> -       swi     r7, r1, PT_R7
> -       swi     r8, r1, PT_R8
> -       swi     r9, r1, PT_R9
> -       swi     r10, r1, PT_R10
> -       swi     r11, r1, PT_R11
> -       /* r12: _always_ in clobber list; see unistd.h */
> -       swi     r12, r1, PT_R12
> -       swi     r13, r1, PT_R13
> -       /* r14: _always_ in clobber list; see unistd.h */
> -       swi     r14, r1, PT_R14
> -       /* but we want to return to the next inst. */
> -       addik   r14, r14, 0x4
> -       swi     r14, r1, PT_PC          /* increment by 4 and store in pc=
 */
> -       swi     r15, r1, PT_R15
> -       swi     r16, r1, PT_R16
> -       swi     r17, r1, PT_R17
> -       swi     r18, r1, PT_R18
> -       swi     r19, r1, PT_R19
> -       swi     r20, r1, PT_R20
> -       swi     r21, r1, PT_R21
> -       swi     r22, r1, PT_R22
> -       swi     r23, r1, PT_R23
> -       swi     r24, r1, PT_R24
> -       swi     r25, r1, PT_R25
> -       swi     r26, r1, PT_R26
> -       swi     r27, r1, PT_R27
> -       swi     r28, r1, PT_R28
> -       swi     r29, r1, PT_R29
> -       swi     r30, r1, PT_R30
> -       swi     r31, r1, PT_R31
> -
> -       disable_irq
> -       nop             /* make sure IE bit is in effect */
> -       clear_bip       /* once IE is in effect it is safe to clear BIP *=
/
> -       nop
> -
> -       /* special purpose registers */
> -       mfs     r11, rmsr
> -       swi     r11, r1, PT_MSR
> -       mfs     r11, rear
> -       swi     r11, r1, PT_EAR
> -       mfs     r11, resr
> -       swi     r11, r1, PT_ESR
> -       mfs     r11, rfsr
> -       swi     r11, r1, PT_FSR
> -       /* reload original stack pointer and save it */
> -       lwi     r11, r0, PER_CPU(ENTRY_SP)
> -       swi     r11, r1, PT_R1
> -       /* update mode indicator we are in kernel mode */
> -       addik   r11, r0, 1
> -       swi     r11, r0, PER_CPU(KM)
> -       /* restore r31 */
> -       lwi     r31, r0, PER_CPU(CURRENT_SAVE)
> -       /* re-enable interrupts now we are in kernel mode */
> -       enable_irq
> -
> -       /* See if the system call number is valid. */
> -       addi    r11, r12, -__NR_syscalls
> -       bgei    r11, 1f                 /* return to user if not valid */
> -       /* Figure out which function to use for this system call. */
> -       /* Note Microblaze barrel shift is optional, so don't rely on it =
*/
> -       add     r12, r12, r12                   /* convert num -> ptr */
> -       addik   r30, r0, 1                      /* restarts allowed */
> -       add     r12, r12, r12
> -       lwi     r12, r12, sys_call_table        /* Get function pointer *=
/
> -       addik   r15, r0, ret_to_user-8          /* set return address */
> -       bra     r12                             /* Make the system call. =
*/
> -       bri     0                               /* won't reach here */
> -1:
> -       brid    ret_to_user                     /* jump to syscall epilog=
ue */
> -       addi    r3, r0, -ENOSYS                 /* set errno in delay slo=
t */
> -
> -/*
> - * Debug traps are like a system call, but entered via brki r14, 0x60
> - * All we need to do is send the SIGTRAP signal to current, ptrace and
> - * do_notify_resume will handle the rest
> - */
> -ENTRY(_debug_exception)
> -       swi     r1, r0, PER_CPU(ENTRY_SP)       /* save the current sp */
> -       lwi     r1, r0, PER_CPU(CURRENT_SAVE)   /* get the saved current =
*/
> -       lwi     r1, r1, TS_THREAD_INFO          /* get the thread info */
> -       addik   r1, r1, THREAD_SIZE - PT_SIZE   /* get the kernel stack *=
/
> -       swi     r11, r0, PER_CPU(R11_SAVE)      /* temporarily save r11 *=
/
> -       lwi     r11, r0, PER_CPU(KM)            /* load mode indicator */
> -//save_context:
> -       swi     r11, r1, PT_MODE        /* store the mode */
> -       lwi     r11, r0, PER_CPU(R11_SAVE)      /* reload r11 */
> -       /* save them on stack */
> -       swi     r2, r1, PT_R2
> -       swi     r3, r1, PT_R3 /* r3: _always_ in clobber list; see unistd=
.h */
> -       swi     r4, r1, PT_R4 /* r4: _always_ in clobber list; see unistd=
.h */
> -       swi     r5, r1, PT_R5
> -       swi     r6, r1, PT_R6
> -       swi     r7, r1, PT_R7
> -       swi     r8, r1, PT_R8
> -       swi     r9, r1, PT_R9
> -       swi     r10, r1, PT_R10
> -       swi     r11, r1, PT_R11
> -       /* r12: _always_ in clobber list; see unistd.h */
> -       swi     r12, r1, PT_R12
> -       swi     r13, r1, PT_R13
> -       /* r14: _always_ in clobber list; see unistd.h */
> -       swi     r14, r1, PT_R14
> -       swi     r14, r1, PT_PC /* Will return to interrupted instruction =
*/
> -       swi     r15, r1, PT_R15
> -       swi     r16, r1, PT_R16
> -       swi     r17, r1, PT_R17
> -       swi     r18, r1, PT_R18
> -       swi     r19, r1, PT_R19
> -       swi     r20, r1, PT_R20
> -       swi     r21, r1, PT_R21
> -       swi     r22, r1, PT_R22
> -       swi     r23, r1, PT_R23
> -       swi     r24, r1, PT_R24
> -       swi     r25, r1, PT_R25
> -       swi     r26, r1, PT_R26
> -       swi     r27, r1, PT_R27
> -       swi     r28, r1, PT_R28
> -       swi     r29, r1, PT_R29
> -       swi     r30, r1, PT_R30
> -       swi     r31, r1, PT_R31
> -
> -       disable_irq
> -       nop             /* make sure IE bit is in effect */
> -       clear_bip       /* once IE is in effect it is safe to clear BIP *=
/
> -       nop
> -
> -       /* special purpose registers */
> -       mfs     r11, rmsr
> -       swi     r11, r1, PT_MSR
> -       mfs     r11, rear
> -       swi     r11, r1, PT_EAR
> -       mfs     r11, resr
> -       swi     r11, r1, PT_ESR
> -       mfs     r11, rfsr
> -       swi     r11, r1, PT_FSR
> -       /* reload original stack pointer and save it */
> -       lwi     r11, r0, PER_CPU(ENTRY_SP)
> -       swi     r11, r1, PT_R1
> -       /* update mode indicator we are in kernel mode */
> -       addik   r11, r0, 1
> -       swi     r11, r0, PER_CPU(KM)
> -       /* restore r31 */
> -       lwi     r31, r0, PER_CPU(CURRENT_SAVE)
> -       /* re-enable interrupts now we are in kernel mode */
> -       enable_irq
> -
> -       addi    r5, r0, SIGTRAP                 /* sending the trap signa=
l */
> -       add     r6, r0, r31                     /* to current */
> -       bralid  r15, send_sig
> -       add     r7, r0, r0                      /* 3rd param zero */
> -
> -       addik   r30, r0, 1                      /* restarts allowed ??? *=
/
> -       /* Restore r3/r4 to work around how ret_to_user works */
> -       lwi     r3, r1, PT_R3
> -       lwi     r4, r1, PT_R4
> -       bri     ret_to_user
> -
> -ENTRY(_break)
> -       bri     0
> -
> -/* struct task_struct *_switch_to(struct thread_info *prev,
> -                                       struct thread_info *next); */
> -ENTRY(_switch_to)
> -       /* prepare return value */
> -       addk    r3, r0, r31
> -
> -       /* save registers in cpu_context */
> -       /* use r11 and r12, volatile registers, as temp register */
> -       addik   r11, r5, TI_CPU_CONTEXT
> -       swi     r1, r11, CC_R1
> -       swi     r2, r11, CC_R2
> -       /* skip volatile registers.
> -        * they are saved on stack when we jumped to _switch_to() */
> -       /* dedicated registers */
> -       swi     r13, r11, CC_R13
> -       swi     r14, r11, CC_R14
> -       swi     r15, r11, CC_R15
> -       swi     r16, r11, CC_R16
> -       swi     r17, r11, CC_R17
> -       swi     r18, r11, CC_R18
> -       /* save non-volatile registers */
> -       swi     r19, r11, CC_R19
> -       swi     r20, r11, CC_R20
> -       swi     r21, r11, CC_R21
> -       swi     r22, r11, CC_R22
> -       swi     r23, r11, CC_R23
> -       swi     r24, r11, CC_R24
> -       swi     r25, r11, CC_R25
> -       swi     r26, r11, CC_R26
> -       swi     r27, r11, CC_R27
> -       swi     r28, r11, CC_R28
> -       swi     r29, r11, CC_R29
> -       swi     r30, r11, CC_R30
> -       /* special purpose registers */
> -       mfs     r12, rmsr
> -       swi     r12, r11, CC_MSR
> -       mfs     r12, rear
> -       swi     r12, r11, CC_EAR
> -       mfs     r12, resr
> -       swi     r12, r11, CC_ESR
> -       mfs     r12, rfsr
> -       swi     r12, r11, CC_FSR
> -
> -       /* update r31, the current */
> -       lwi     r31, r6, TI_TASK
> -       swi     r31, r0, PER_CPU(CURRENT_SAVE)
> -
> -       /* get new process' cpu context and restore */
> -       addik   r11, r6, TI_CPU_CONTEXT
> -
> -       /* special purpose registers */
> -       lwi     r12, r11, CC_FSR
> -       mts     rfsr, r12
> -       lwi     r12, r11, CC_ESR
> -       mts     resr, r12
> -       lwi     r12, r11, CC_EAR
> -       mts     rear, r12
> -       lwi     r12, r11, CC_MSR
> -       mts     rmsr, r12
> -       /* non-volatile registers */
> -       lwi     r30, r11, CC_R30
> -       lwi     r29, r11, CC_R29
> -       lwi     r28, r11, CC_R28
> -       lwi     r27, r11, CC_R27
> -       lwi     r26, r11, CC_R26
> -       lwi     r25, r11, CC_R25
> -       lwi     r24, r11, CC_R24
> -       lwi     r23, r11, CC_R23
> -       lwi     r22, r11, CC_R22
> -       lwi     r21, r11, CC_R21
> -       lwi     r20, r11, CC_R20
> -       lwi     r19, r11, CC_R19
> -       /* dedicated registers */
> -       lwi     r18, r11, CC_R18
> -       lwi     r17, r11, CC_R17
> -       lwi     r16, r11, CC_R16
> -       lwi     r15, r11, CC_R15
> -       lwi     r14, r11, CC_R14
> -       lwi     r13, r11, CC_R13
> -       /* skip volatile registers */
> -       lwi     r2, r11, CC_R2
> -       lwi     r1, r11, CC_R1
> -
> -       rtsd    r15, 8
> -       nop
> -
> -ENTRY(ret_from_fork)
> -       addk    r5, r0, r3
> -       brlid   r15, schedule_tail
> -       nop
> -       swi     r31, r1, PT_R31         /* save r31 in user context. */
> -                       /* will soon be restored to r31 in ret_to_user */
> -       addk    r3, r0, r0
> -       brid    ret_to_user
> -       nop
> -
> -ENTRY(ret_from_kernel_thread)
> -       brlid   r15, schedule_tail
> -       addk    r5, r0, r3
> -       brald   r15, r20
> -       addk    r5, r0, r19
> -       brid    ret_to_user
> -       addk    r3, r0, r0
> -
> -work_pending:
> -       lwi     r11, r1, PT_MODE
> -       bneid   r11, 2f
> -3:
> -       enable_irq
> -       andi    r11, r19, _TIF_NEED_RESCHED
> -       beqi    r11, 1f
> -       bralid  r15, schedule
> -       nop
> -       bri     4f
> -1:     andi    r11, r19, _TIF_SIGPENDING | _TIF_NOTIFY_RESUME
> -       beqi    r11, no_work_pending
> -       addk    r5, r30, r0
> -       bralid  r15, do_notify_resume
> -       addik   r6, r0, 1
> -       addk    r30, r0, r0     /* no restarts from now on */
> -4:
> -       disable_irq
> -       lwi     r6, r31, TS_THREAD_INFO /* get thread info */
> -       lwi     r19, r6, TI_FLAGS /* get flags in thread info */
> -       bri     3b
> -
> -ENTRY(ret_to_user)
> -       disable_irq
> -
> -       swi     r4, r1, PT_R4           /* return val */
> -       swi     r3, r1, PT_R3           /* return val */
> -
> -       lwi     r6, r31, TS_THREAD_INFO /* get thread info */
> -       lwi     r19, r6, TI_FLAGS /* get flags in thread info */
> -       bnei    r19, work_pending /* do an extra work if any bits are set=
 */
> -no_work_pending:
> -       disable_irq
> -
> -2:
> -       /* save r31 */
> -       swi     r31, r0, PER_CPU(CURRENT_SAVE)
> -       /* save mode indicator */
> -       lwi     r18, r1, PT_MODE
> -       swi     r18, r0, PER_CPU(KM)
> -//restore_context:
> -       /* special purpose registers */
> -       lwi     r18, r1, PT_FSR
> -       mts     rfsr, r18
> -       lwi     r18, r1, PT_ESR
> -       mts     resr, r18
> -       lwi     r18, r1, PT_EAR
> -       mts     rear, r18
> -       lwi     r18, r1, PT_MSR
> -       mts     rmsr, r18
> -
> -       lwi     r31, r1, PT_R31
> -       lwi     r30, r1, PT_R30
> -       lwi     r29, r1, PT_R29
> -       lwi     r28, r1, PT_R28
> -       lwi     r27, r1, PT_R27
> -       lwi     r26, r1, PT_R26
> -       lwi     r25, r1, PT_R25
> -       lwi     r24, r1, PT_R24
> -       lwi     r23, r1, PT_R23
> -       lwi     r22, r1, PT_R22
> -       lwi     r21, r1, PT_R21
> -       lwi     r20, r1, PT_R20
> -       lwi     r19, r1, PT_R19
> -       lwi     r18, r1, PT_R18
> -       lwi     r17, r1, PT_R17
> -       lwi     r16, r1, PT_R16
> -       lwi     r15, r1, PT_R15
> -       lwi     r14, r1, PT_PC
> -       lwi     r13, r1, PT_R13
> -       lwi     r12, r1, PT_R12
> -       lwi     r11, r1, PT_R11
> -       lwi     r10, r1, PT_R10
> -       lwi     r9, r1, PT_R9
> -       lwi     r8, r1, PT_R8
> -       lwi     r7, r1, PT_R7
> -       lwi     r6, r1, PT_R6
> -       lwi     r5, r1, PT_R5
> -       lwi     r4, r1, PT_R4           /* return val */
> -       lwi     r3, r1, PT_R3           /* return val */
> -       lwi     r2, r1, PT_R2
> -       lwi     r1, r1, PT_R1
> -
> -       rtid    r14, 0
> -       nop
> -
> -sys_rt_sigreturn_wrapper:
> -       addk    r30, r0, r0             /* no restarts for this one */
> -       brid    sys_rt_sigreturn
> -       addk    r5, r1, r0
> -
> -       /* Interrupt vector table */
> -       .section        .init.ivt, "ax"
> -       .org 0x0
> -       brai    _reset
> -       brai    _user_exception
> -       brai    _interrupt
> -       brai    _break
> -       brai    _hw_exception_handler
> -       .org 0x60
> -       brai    _debug_exception
> -
> -.section .rodata,"a"
> -#include "syscall_table.S"
> -
> -syscall_table_size=3D(.-sys_call_table)
> -
> -type_SYSCALL:
> -       .ascii "SYSCALL\0"
> -type_IRQ:
> -       .ascii "IRQ\0"
> -type_IRQ_PREEMPT:
> -       .ascii "IRQ (PREEMPTED)\0"
> -type_SYSCALL_PREEMPT:
> -       .ascii " SYSCALL (PREEMPTED)\0"
> -
> -       /*
> -        * Trap decoding for stack unwinder
> -        * Tuples are (start addr, end addr, string)
> -        * If return address lies on [start addr, end addr],
> -        * unwinder displays 'string'
> -        */
> -
> -       .align 4
> -.global microblaze_trap_handlers
> -microblaze_trap_handlers:
> -       /* Exact matches come first */
> -       .word ret_to_user  ; .word ret_to_user    ; .word type_SYSCALL
> -       .word ret_from_intr; .word ret_from_intr  ; .word type_IRQ
> -       /* Fuzzy matches go here */
> -       .word ret_from_intr; .word no_intr_resched; .word type_IRQ_PREEMP=
T
> -       .word work_pending ; .word no_work_pending; .word type_SYSCALL_PR=
EEMPT
> -       /* End of table */
> -       .word 0             ; .word 0               ; .word 0
> diff --git a/arch/microblaze/kernel/exceptions.c b/arch/microblaze/kernel=
/exceptions.c
> index cf99c411503e..908788497b28 100644
> --- a/arch/microblaze/kernel/exceptions.c
> +++ b/arch/microblaze/kernel/exceptions.c
> @@ -69,9 +69,7 @@ void _exception(int signr, struct pt_regs *regs, int co=
de, unsigned long addr)
>  asmlinkage void full_exception(struct pt_regs *regs, unsigned int type,
>                                                         int fsr, int addr=
)
>  {
> -#ifdef CONFIG_MMU
>         addr =3D regs->pc;
> -#endif
>
>  #if 0
>         pr_warn("Exception %02x in %s mode, FSR=3D%08x PC=3D%08x ESR=3D%0=
8x\n",
> @@ -132,13 +130,10 @@ asmlinkage void full_exception(struct pt_regs *regs=
, unsigned int type,
>                         fsr =3D FPE_FLTRES;
>                 _exception(SIGFPE, regs, fsr, addr);
>                 break;
> -
> -#ifdef CONFIG_MMU
>         case MICROBLAZE_PRIVILEGED_EXCEPTION:
>                 pr_debug("Privileged exception\n");
>                 _exception(SIGILL, regs, ILL_PRVOPC, addr);
>                 break;
> -#endif
>         default:
>         /* FIXME what to do in unexpected exception */
>                 pr_warn("Unexpected exception %02x PC=3D%08x in %s mode\n=
",
> diff --git a/arch/microblaze/kernel/head.S b/arch/microblaze/kernel/head.=
S
> index 14b276406153..ec2fcb545e64 100644
> --- a/arch/microblaze/kernel/head.S
> +++ b/arch/microblaze/kernel/head.S
> @@ -34,7 +34,6 @@
>  #include <asm/page.h>
>  #include <linux/of_fdt.h>              /* for OF_DT_HEADER */
>
> -#ifdef CONFIG_MMU
>  #include <asm/setup.h> /* COMMAND_LINE_SIZE */
>  #include <asm/mmu.h>
>  #include <asm/processor.h>
> @@ -48,8 +47,6 @@ empty_zero_page:
>  swapper_pg_dir:
>         .space  PAGE_SIZE
>
> -#endif /* CONFIG_MMU */
> -
>  .section .rodata
>  .align 4
>  endian_check:
> @@ -108,8 +105,6 @@ _copy_fdt:
>         addik   r3, r3, -4 /* descrement loop */
>  no_fdt_arg:
>
> -#ifdef CONFIG_MMU
> -
>  #ifndef CONFIG_CMDLINE_BOOL
>  /*
>   * handling command line
> @@ -329,7 +324,6 @@ turn_on_mmu:
>         nop
>
>  start_here:
> -#endif /* CONFIG_MMU */
>
>         /* Initialize small data anchors */
>         addik   r13, r0, _KERNEL_SDA_BASE_
> @@ -345,11 +339,6 @@ start_here:
>         brald   r15, r11
>         nop
>
> -#ifndef CONFIG_MMU
> -       addik   r15, r0, machine_halt
> -       braid   start_kernel
> -       nop
> -#else
>         /*
>          * Initialize the MMU.
>          */
> @@ -383,4 +372,3 @@ kernel_load_context:
>         nop
>         rted    r17, 0          /* enable MMU and jump to start_kernel */
>         nop
> -#endif /* CONFIG_MMU */
> diff --git a/arch/microblaze/kernel/hw_exception_handler.S b/arch/microbl=
aze/kernel/hw_exception_handler.S
> index 54411de22fa6..07ea23965f81 100644
> --- a/arch/microblaze/kernel/hw_exception_handler.S
> +++ b/arch/microblaze/kernel/hw_exception_handler.S
> @@ -80,7 +80,6 @@
>  /* Helpful Macros */
>  #define NUM_TO_REG(num)                r ## num
>
> -#ifdef CONFIG_MMU
>         #define RESTORE_STATE                   \
>                 lwi     r5, r1, 0;              \
>                 mts     rmsr, r5;               \
> @@ -92,7 +91,6 @@
>                 lwi     r11, r1, PT_R11;        \
>                 lwi     r31, r1, PT_R31;        \
>                 lwi     r1, r1, PT_R1;
> -#endif /* CONFIG_MMU */
>
>  #define LWREG_NOP                      \
>         bri     ex_handler_unhandled;   \
> @@ -102,10 +100,6 @@
>         bri     ex_handler_unhandled;   \
>         nop;
>
> -/* FIXME this is weird - for noMMU kernel is not possible to use brid
> - * instruction which can shorten executed time
> - */
> -
>  /* r3 is the source */
>  #define R3_TO_LWREG_V(regnum)                          \
>         swi     r3, r1, 4 * regnum;                             \
> @@ -126,7 +120,6 @@
>         or      r3, r0, NUM_TO_REG (regnum);            \
>         bri     ex_sw_tail;
>
> -#ifdef CONFIG_MMU
>         #define R3_TO_LWREG_VM_V(regnum)                \
>                 brid    ex_lw_end_vm;                   \
>                 swi     r3, r7, 4 * regnum;
> @@ -193,7 +186,6 @@
>         .endm
>         #endif
>
> -#endif /* CONFIG_MMU */
>
>  .extern other_exception_handler /* Defined in exception.c */
>
> @@ -251,7 +243,6 @@
>   */
>
>  /* wrappers to restore state before coming to entry.S */
> -#ifdef CONFIG_MMU
>  .section .data
>  .align 4
>  pt_pool_space:
> @@ -316,31 +307,24 @@ _MB_HW_ExceptionVectorTable:
>         .long   TOPHYS(ex_handler_unhandled)
>         .long   TOPHYS(ex_handler_unhandled)
>         .long   TOPHYS(ex_handler_unhandled)
> -#endif
>
>  .global _hw_exception_handler
>  .section .text
>  .align 4
>  .ent _hw_exception_handler
>  _hw_exception_handler:
> -#ifndef CONFIG_MMU
> -       addik   r1, r1, -(EX_HANDLER_STACK_SIZ); /* Create stack frame */
> -#else
>         swi     r1, r0, TOPHYS(pt_pool_space + PT_R1); /* GET_SP */
>         /* Save date to kernel memory. Here is the problem
>          * when you came from user space */
>         ori     r1, r0, TOPHYS(pt_pool_space);
> -#endif
>         swi     r3, r1, PT_R3
>         swi     r4, r1, PT_R4
>         swi     r5, r1, PT_R5
>         swi     r6, r1, PT_R6
>
> -#ifdef CONFIG_MMU
>         swi     r11, r1, PT_R11
>         swi     r31, r1, PT_R31
>         lwi     r31, r0, TOPHYS(PER_CPU(CURRENT_SAVE)) /* get saved curre=
nt */
> -#endif
>
>         mfs     r5, rmsr;
>         nop
> @@ -350,18 +334,8 @@ _hw_exception_handler:
>         mfs     r3, rear;
>         nop
>
> -#ifndef CONFIG_MMU
> -       andi    r5, r4, 0x1000;         /* Check ESR[DS] */
> -       beqi    r5, not_in_delay_slot;  /* Branch if ESR[DS] not set */
> -       mfs     r17, rbtr;      /* ESR[DS] set - return address in BTR */
> -       nop
> -not_in_delay_slot:
> -       swi     r17, r1, PT_R17
> -#endif
> -
>         andi    r5, r4, 0x1F;           /* Extract ESR[EXC] */
>
> -#ifdef CONFIG_MMU
>         /* Calculate exception vector offset =3D r5 << 2 */
>         addk    r6, r5, r5; /* << 1 */
>         addk    r6, r6, r6; /* << 2 */
> @@ -383,73 +357,6 @@ not_in_delay_slot:
>  full_exception_trapw:
>         RESTORE_STATE
>         bri     full_exception_trap
> -#else
> -       /* Exceptions enabled here. This will allow nested exceptions */
> -       mfs     r6, rmsr;
> -       nop
> -       swi     r6, r1, 0; /* RMSR_OFFSET */
> -       ori     r6, r6, 0x100; /* Turn ON the EE bit */
> -       andi    r6, r6, ~2; /* Disable interrupts */
> -       mts     rmsr, r6;
> -       nop
> -
> -       xori    r6, r5, 1; /* 00001 =3D Unaligned Exception */
> -       /* Jump to unalignment exception handler */
> -       beqi    r6, handle_unaligned_ex;
> -
> -handle_other_ex: /* Handle Other exceptions here */
> -       /* Save other volatiles before we make procedure calls below */
> -       swi     r7, r1, PT_R7
> -       swi     r8, r1, PT_R8
> -       swi     r9, r1, PT_R9
> -       swi     r10, r1, PT_R10
> -       swi     r11, r1, PT_R11
> -       swi     r12, r1, PT_R12
> -       swi     r14, r1, PT_R14
> -       swi     r15, r1, PT_R15
> -       swi     r18, r1, PT_R18
> -
> -       or      r5, r1, r0
> -       andi    r6, r4, 0x1F; /* Load ESR[EC] */
> -       lwi     r7, r0, PER_CPU(KM) /* MS: saving current kernel mode to =
regs */
> -       swi     r7, r1, PT_MODE
> -       mfs     r7, rfsr
> -       nop
> -       addk    r8, r17, r0; /* Load exception address */
> -       bralid  r15, full_exception; /* Branch to the handler */
> -       nop;
> -       mts     rfsr, r0;       /* Clear sticky fsr */
> -       nop
> -
> -       /*
> -        * Trigger execution of the signal handler by enabling
> -        * interrupts and calling an invalid syscall.
> -        */
> -       mfs     r5, rmsr;
> -       nop
> -       ori     r5, r5, 2;
> -       mts     rmsr, r5; /* enable interrupt */
> -       nop
> -       addi    r12, r0, __NR_syscalls;
> -       brki    r14, 0x08;
> -       mfs     r5, rmsr; /* disable interrupt */
> -       nop
> -       andi    r5, r5, ~2;
> -       mts     rmsr, r5;
> -       nop
> -
> -       lwi     r7, r1, PT_R7
> -       lwi     r8, r1, PT_R8
> -       lwi     r9, r1, PT_R9
> -       lwi     r10, r1, PT_R10
> -       lwi     r11, r1, PT_R11
> -       lwi     r12, r1, PT_R12
> -       lwi     r14, r1, PT_R14
> -       lwi     r15, r1, PT_R15
> -       lwi     r18, r1, PT_R18
> -
> -       bri     ex_handler_done; /* Complete exception handling */
> -#endif
>
>  /* 0x01 - Unaligned data access exception
>   * This occurs when a word access is not aligned on a word boundary,
> @@ -463,7 +370,6 @@ handle_unaligned_ex:
>          *  R4 =3D ESR
>          *  R3 =3D EAR
>          */
> -#ifdef CONFIG_MMU
>         andi    r6, r4, 0x1000                  /* Check ESR[DS] */
>         beqi    r6, _no_delayslot               /* Branch if ESR[DS] not =
set */
>         mfs     r17, rbtr;      /* ESR[DS] set - return address in BTR */
> @@ -472,7 +378,7 @@ _no_delayslot:
>         /* jump to high level unaligned handler */
>         RESTORE_STATE;
>         bri     unaligned_data_trap
> -#endif
> +
>         andi    r6, r4, 0x3E0; /* Mask and extract the register operand *=
/
>         srl     r6, r6; /* r6 >> 5 */
>         srl     r6, r6;
> @@ -558,25 +464,10 @@ ex_shw:
>  ex_sw_end: /* Exception handling of store word, ends. */
>
>  ex_handler_done:
> -#ifndef CONFIG_MMU
> -       lwi     r5, r1, 0 /* RMSR */
> -       mts     rmsr, r5
> -       nop
> -       lwi     r3, r1, PT_R3
> -       lwi     r4, r1, PT_R4
> -       lwi     r5, r1, PT_R5
> -       lwi     r6, r1, PT_R6
> -       lwi     r17, r1, PT_R17
> -
> -       rted    r17, 0
> -       addik   r1, r1, (EX_HANDLER_STACK_SIZ); /* Restore stack frame */
> -#else
>         RESTORE_STATE;
>         rted    r17, 0
>         nop
> -#endif
>
> -#ifdef CONFIG_MMU
>         /* Exception vector entry code. This code runs with address trans=
lation
>          * turned off (i.e. using physical addresses). */
>
> @@ -882,13 +773,7 @@ ex_handler_done:
>                  * bits 20 and 21 are zero.
>                  */
>                 andi    r3, r3, PAGE_MASK
> -#ifdef CONFIG_MICROBLAZE_64K_PAGES
> -               ori     r3, r3, TLB_VALID | TLB_PAGESZ(PAGESZ_64K)
> -#elif CONFIG_MICROBLAZE_16K_PAGES
> -               ori     r3, r3, TLB_VALID | TLB_PAGESZ(PAGESZ_16K)
> -#else
>                 ori     r3, r3, TLB_VALID | TLB_PAGESZ(PAGESZ_4K)
> -#endif
>                 mts     rtlbhi, r3              /* Load TLB HI */
>                 nop
>
> @@ -926,10 +811,8 @@ ex_handler_done:
>                 rtsd    r15,8
>                 nop
>
> -#endif
>  .end _hw_exception_handler
>
> -#ifdef CONFIG_MMU
>  /* Unaligned data access exception last on a 4k page for MMU.
>   * When this is called, we are in virtual mode with exceptions enabled
>   * and registers 1-13,15,17,18 saved.
> @@ -1044,7 +927,6 @@ ex_unaligned_fixup:
>         .word   store6,ex_unaligned_fixup;
>  .previous;
>  .end _unaligned_data_exception
> -#endif /* CONFIG_MMU */
>
>  .global ex_handler_unhandled
>  ex_handler_unhandled:
> @@ -1093,11 +975,7 @@ lw_r27:           R3_TO_LWREG     (27);
>  lw_r28:                R3_TO_LWREG     (28);
>  lw_r29:                R3_TO_LWREG     (29);
>  lw_r30:                R3_TO_LWREG     (30);
> -#ifdef CONFIG_MMU
>  lw_r31:        R3_TO_LWREG_V   (31);
> -#else
> -lw_r31:                R3_TO_LWREG     (31);
> -#endif
>
>  sw_table:
>  sw_r0:         SWREG_TO_R3     (0);
> @@ -1131,13 +1009,8 @@ sw_r27:          SWREG_TO_R3     (27);
>  sw_r28:                SWREG_TO_R3     (28);
>  sw_r29:                SWREG_TO_R3     (29);
>  sw_r30:                SWREG_TO_R3     (30);
> -#ifdef CONFIG_MMU
>  sw_r31:                SWREG_TO_R3_V   (31);
> -#else
> -sw_r31:                SWREG_TO_R3     (31);
> -#endif
>
> -#ifdef CONFIG_MMU
>  lw_table_vm:
>  lw_r0_vm:      R3_TO_LWREG_VM          (0);
>  lw_r1_vm:      R3_TO_LWREG_VM_V        (1);
> @@ -1205,7 +1078,6 @@ sw_r28_vm:        SWREG_TO_R3_VM_V        (28);
>  sw_r29_vm:     SWREG_TO_R3_VM_V        (29);
>  sw_r30_vm:     SWREG_TO_R3_VM_V        (30);
>  sw_r31_vm:     SWREG_TO_R3_VM_V        (31);
> -#endif /* CONFIG_MMU */
>
>  /* Temporary data structures used in the handler */
>  .section .data
> diff --git a/arch/microblaze/kernel/microblaze_ksyms.c b/arch/microblaze/=
kernel/microblaze_ksyms.c
> index 51c43ee5e380..303aaf13573b 100644
> --- a/arch/microblaze/kernel/microblaze_ksyms.c
> +++ b/arch/microblaze/kernel/microblaze_ksyms.c
> @@ -33,9 +33,7 @@ EXPORT_SYMBOL(memcpy);
>  EXPORT_SYMBOL(memmove);
>  #endif
>
> -#ifdef CONFIG_MMU
>  EXPORT_SYMBOL(empty_zero_page);
> -#endif
>
>  EXPORT_SYMBOL(mbc);
>
> diff --git a/arch/microblaze/kernel/process.c b/arch/microblaze/kernel/pr=
ocess.c
> index a9e46e525cd0..3afda1823730 100644
> --- a/arch/microblaze/kernel/process.c
> +++ b/arch/microblaze/kernel/process.c
> @@ -69,9 +69,7 @@ int copy_thread(unsigned long clone_flags, unsigned lon=
g usp, unsigned long arg,
>                 ti->cpu_context.r19 =3D (unsigned long)arg;
>                 childregs->pt_mode =3D 1;
>                 local_save_flags(childregs->msr);
> -#ifdef CONFIG_MMU
>                 ti->cpu_context.msr =3D childregs->msr & ~MSR_IE;
> -#endif
>                 ti->cpu_context.r15 =3D (unsigned long)ret_from_kernel_th=
read - 8;
>                 return 0;
>         }
> @@ -81,9 +79,6 @@ int copy_thread(unsigned long clone_flags, unsigned lon=
g usp, unsigned long arg,
>
>         memset(&ti->cpu_context, 0, sizeof(struct cpu_context));
>         ti->cpu_context.r1 =3D (unsigned long)childregs;
> -#ifndef CONFIG_MMU
> -       ti->cpu_context.msr =3D (unsigned long)childregs->msr;
> -#else
>         childregs->msr |=3D MSR_UMS;
>
>         /* we should consider the fact that childregs is a copy of the pa=
rent
> @@ -105,7 +100,6 @@ int copy_thread(unsigned long clone_flags, unsigned l=
ong usp, unsigned long arg,
>         ti->cpu_context.msr =3D (childregs->msr|MSR_VM);
>         ti->cpu_context.msr &=3D ~MSR_UMS; /* switch_to to kernel mode */
>         ti->cpu_context.msr &=3D ~MSR_IE;
> -#endif
>         ti->cpu_context.r15 =3D (unsigned long)ret_from_fork - 8;
>
>         /*
> @@ -130,13 +124,10 @@ void start_thread(struct pt_regs *regs, unsigned lo=
ng pc, unsigned long usp)
>         regs->pc =3D pc;
>         regs->r1 =3D usp;
>         regs->pt_mode =3D 0;
> -#ifdef CONFIG_MMU
>         regs->msr |=3D MSR_UMS;
>         regs->msr &=3D ~MSR_VM;
> -#endif
>  }
>
> -#ifdef CONFIG_MMU
>  #include <linux/elfcore.h>
>  /*
>   * Set up a thread for executing a new program
> @@ -145,7 +136,6 @@ int dump_fpu(struct pt_regs *regs, elf_fpregset_t *fp=
regs)
>  {
>         return 0; /* MicroBlaze has no separate FPU registers */
>  }
> -#endif /* CONFIG_MMU */
>
>  void arch_cpu_idle(void)
>  {
> diff --git a/arch/microblaze/kernel/setup.c b/arch/microblaze/kernel/setu=
p.c
> index 7fcf5279ad15..f417333eccae 100644
> --- a/arch/microblaze/kernel/setup.c
> +++ b/arch/microblaze/kernel/setup.c
> @@ -190,12 +190,10 @@ static int microblaze_debugfs_init(void)
>  }
>  arch_initcall(microblaze_debugfs_init);
>
> -# ifdef CONFIG_MMU
>  static int __init debugfs_tlb(void)
>  {
>         debugfs_create_u32("tlb_skip", S_IRUGO, of_debugfs_root, &tlb_ski=
p);
>         return 0;
>  }
>  device_initcall(debugfs_tlb);
> -# endif
>  #endif
> diff --git a/arch/microblaze/kernel/signal.c b/arch/microblaze/kernel/sig=
nal.c
> index 5a8d173d7b75..fc61eb0eb8dd 100644
> --- a/arch/microblaze/kernel/signal.c
> +++ b/arch/microblaze/kernel/signal.c
> @@ -157,10 +157,8 @@ static int setup_rt_frame(struct ksignal *ksig, sigs=
et_t *set,
>         struct rt_sigframe __user *frame;
>         int err =3D 0, sig =3D ksig->sig;
>         unsigned long address =3D 0;
> -#ifdef CONFIG_MMU
>         pmd_t *pmdp;
>         pte_t *ptep;
> -#endif
>
>         frame =3D get_sigframe(ksig, regs, sizeof(*frame));
>
> @@ -192,7 +190,6 @@ static int setup_rt_frame(struct ksignal *ksig, sigse=
t_t *set,
>         regs->r15 =3D ((unsigned long)frame->tramp)-8;
>
>         address =3D ((unsigned long)frame->tramp);
> -#ifdef CONFIG_MMU
>         pmdp =3D pmd_off(current->mm, address);
>
>         preempt_disable();
> @@ -208,10 +205,6 @@ static int setup_rt_frame(struct ksignal *ksig, sigs=
et_t *set,
>         }
>         pte_unmap(ptep);
>         preempt_enable();
> -#else
> -       flush_icache_range(address, address + 8);
> -       flush_dcache_range(address, address + 8);
> -#endif
>         if (err)
>                 return -EFAULT;
>
> diff --git a/arch/microblaze/kernel/unwind.c b/arch/microblaze/kernel/unw=
ind.c
> index 778a761af0a7..a530a7a6be7d 100644
> --- a/arch/microblaze/kernel/unwind.c
> +++ b/arch/microblaze/kernel/unwind.c
> @@ -161,22 +161,12 @@ static void microblaze_unwind_inner(struct task_str=
uct *task,
>   * unwind_trap - Unwind through a system trap, that stored previous stat=
e
>   *              on the stack.
>   */
> -#ifdef CONFIG_MMU
>  static inline void unwind_trap(struct task_struct *task, unsigned long p=
c,
>                                 unsigned long fp, struct stack_trace *tra=
ce,
>                                 const char *loglvl)
>  {
>         /* To be implemented */
>  }
> -#else
> -static inline void unwind_trap(struct task_struct *task, unsigned long p=
c,
> -                               unsigned long fp, struct stack_trace *tra=
ce,
> -                               const char *loglvl)
> -{
> -       const struct pt_regs *regs =3D (const struct pt_regs *) fp;
> -       microblaze_unwind_inner(task, regs->pc, regs->r1, regs->r15, trac=
e, loglvl);
> -}
> -#endif
>
>  /**
>   * microblaze_unwind_inner - Unwind the stack from the specified point
> @@ -215,16 +205,7 @@ static void microblaze_unwind_inner(struct task_stru=
ct *task,
>                          * HW exception handler doesn't save all register=
s,
>                          * so we open-code a special case of unwind_trap(=
)
>                          */
> -#ifndef CONFIG_MMU
> -                       const struct pt_regs *regs =3D
> -                               (const struct pt_regs *) fp;
> -#endif
>                         printk("%sHW EXCEPTION\n", loglvl);
> -#ifndef CONFIG_MMU
> -                       microblaze_unwind_inner(task, regs->r17 - 4,
> -                                               fp + EX_HANDLER_STACK_SIZ=
,
> -                                               regs->r15, trace, loglvl)=
;
> -#endif
>                         return;
>                 }
>
> diff --git a/arch/microblaze/mm/Makefile b/arch/microblaze/mm/Makefile
> index 1b16875cea70..cd8a844bf29e 100644
> --- a/arch/microblaze/mm/Makefile
> +++ b/arch/microblaze/mm/Makefile
> @@ -5,5 +5,5 @@
>
>  obj-y :=3D consistent.o init.o
>
> -obj-$(CONFIG_MMU) +=3D pgtable.o mmu_context.o fault.o
> +obj-y +=3D pgtable.o mmu_context.o fault.o
>  obj-$(CONFIG_HIGHMEM) +=3D highmem.o
> diff --git a/arch/microblaze/mm/consistent.c b/arch/microblaze/mm/consist=
ent.c
> index 81dffe43b18c..b7ad4a98636d 100644
> --- a/arch/microblaze/mm/consistent.c
> +++ b/arch/microblaze/mm/consistent.c
> @@ -21,32 +21,3 @@ void arch_dma_prep_coherent(struct page *page, size_t =
size)
>
>         flush_dcache_range(paddr, paddr + size);
>  }
> -
> -#ifndef CONFIG_MMU
> -/*
> - * Consistent memory allocators. Used for DMA devices that want to share
> - * uncached memory with the processor core.  My crufty no-MMU approach i=
s
> - * simple.  In the HW platform we can optionally mirror the DDR up above=
 the
> - * processor cacheable region.  So, memory accessed in this mirror regio=
n will
> - * not be cached.  It's alloced from the same pool as normal memory, but=
 the
> - * handle we return is shifted up into the uncached region.  This will n=
o doubt
> - * cause big problems if memory allocated here is not also freed properl=
y. -- JW
> - *
> - * I have to use dcache values because I can't relate on ram size:
> - */
> -#ifdef CONFIG_XILINX_UNCACHED_SHADOW
> -#define UNCACHED_SHADOW_MASK (cpuinfo.dcache_high - cpuinfo.dcache_base =
+ 1)
> -#else
> -#define UNCACHED_SHADOW_MASK 0
> -#endif /* CONFIG_XILINX_UNCACHED_SHADOW */
> -
> -void *arch_dma_set_uncached(void *ptr, size_t size)
> -{
> -       unsigned long addr =3D (unsigned long)ptr;
> -
> -       addr |=3D UNCACHED_SHADOW_MASK;
> -       if (addr > cpuinfo.dcache_base && addr < cpuinfo.dcache_high)
> -               pr_warn("ERROR: Your cache coherent area is CACHED!!!\n")=
;
> -       return (void *)addr;
> -}
> -#endif /* CONFIG_MMU */
> diff --git a/arch/microblaze/mm/init.c b/arch/microblaze/mm/init.c
> index 45da639bd22c..7129a20881ea 100644
> --- a/arch/microblaze/mm/init.c
> +++ b/arch/microblaze/mm/init.c
> @@ -29,11 +29,6 @@
>  /* Use for MMU and noMMU because of PCI generic code */
>  int mem_init_done;
>
> -#ifndef CONFIG_MMU
> -unsigned int __page_offset;
> -EXPORT_SYMBOL(__page_offset);
> -#endif /* CONFIG_MMU */
> -
>  char *klimit =3D _end;
>
>  /*
> @@ -82,13 +77,11 @@ static void highmem_setup(void)
>  static void __init paging_init(void)
>  {
>         unsigned long zones_size[MAX_NR_ZONES];
> -#ifdef CONFIG_MMU
>         int idx;
>
>         /* Setup fixmaps */
>         for (idx =3D 0; idx < __end_of_fixed_addresses; idx++)
>                 clear_fixmap(idx);
> -#endif
>
>         /* Clean every zones */
>         memset(zones_size, 0, sizeof(zones_size));
> @@ -108,40 +101,6 @@ static void __init paging_init(void)
>
>  void __init setup_memory(void)
>  {
> -#ifndef CONFIG_MMU
> -       u32 kernel_align_start, kernel_align_size;
> -       phys_addr_t start, end;
> -       u64 i;
> -
> -       /* Find main memory where is the kernel */
> -       for_each_mem_range(i, &start, &end) {
> -               memory_start =3D start;
> -               lowmem_size =3D end - start;
> -               if ((memory_start <=3D (u32)_text) &&
> -                       ((u32)_text <=3D (memory_start + lowmem_size - 1)=
)) {
> -                       memory_size =3D lowmem_size;
> -                       PAGE_OFFSET =3D memory_start;
> -                       pr_info("%s: Main mem: 0x%x, size 0x%08x\n",
> -                               __func__, (u32) memory_start,
> -                                       (u32) memory_size);
> -                       break;
> -               }
> -       }
> -
> -       if (!memory_start || !memory_size) {
> -               panic("%s: Missing memory setting 0x%08x, size=3D0x%08x\n=
",
> -                       __func__, (u32) memory_start, (u32) memory_size);
> -       }
> -
> -       /* reservation of region where is the kernel */
> -       kernel_align_start =3D PAGE_DOWN((u32)_text);
> -       /* ALIGN can be remove because _end in vmlinux.lds.S is align */
> -       kernel_align_size =3D PAGE_UP((u32)klimit) - kernel_align_start;
> -       pr_info("%s: kernel addr:0x%08x-0x%08x size=3D0x%08x\n",
> -               __func__, kernel_align_start, kernel_align_start
> -                       + kernel_align_size, kernel_align_size);
> -       memblock_reserve(kernel_align_start, kernel_align_size);
> -#endif
>         /*
>          * Kernel:
>          * start: base phys address of kernel - page align
> @@ -181,12 +140,6 @@ void __init mem_init(void)
>         mem_init_done =3D 1;
>  }
>
> -#ifndef CONFIG_MMU
> -int page_is_ram(unsigned long pfn)
> -{
> -       return __range_ok(pfn, 0);
> -}
> -#else
>  int page_is_ram(unsigned long pfn)
>  {
>         return pfn < max_low_pfn;
> @@ -330,8 +283,6 @@ void __init *early_get_page(void)
>                                 NUMA_NO_NODE);
>  }
>
> -#endif /* CONFIG_MMU */
> -
>  void * __ref zalloc_maybe_bootmem(size_t size, gfp_t mask)
>  {
>         void *p;
> diff --git a/arch/microblaze/pci/pci-common.c b/arch/microblaze/pci/pci-c=
ommon.c
> index 60a58c0015f2..557585f1be41 100644
> --- a/arch/microblaze/pci/pci-common.c
> +++ b/arch/microblaze/pci/pci-common.c
> @@ -325,12 +325,10 @@ int pci_mmap_legacy_page_range(struct pci_bus *bus,
>                  * memory, effectively behaving just like /dev/zero
>                  */
>                 if ((offset + size) > hose->isa_mem_size) {
> -#ifdef CONFIG_MMU
>                         pr_debug("Process %s (pid:%d) mapped non-existing=
 PCI",
>                                 current->comm, current->pid);
>                         pr_debug("legacy memory for 0%04x:%02x\n",
>                                 pci_domain_nr(bus), bus->number);
> -#endif
>                         if (vma->vm_flags & VM_SHARED)
>                                 return shmem_zero_setup(vma);
>                         return 0;
> --
> 2.29.2
>

Applied.
M

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs

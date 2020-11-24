Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4F12C1DFF
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 07:12:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729481AbgKXGMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 01:12:24 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:47622 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728707AbgKXGMX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 01:12:23 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4CgDFc0bYjz9ty3k;
        Tue, 24 Nov 2020 07:12:20 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id Q5fxlO7c8x8L; Tue, 24 Nov 2020 07:12:20 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4CgDFb6Qdfz9ty3j;
        Tue, 24 Nov 2020 07:12:19 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 97D9A8B7A3;
        Tue, 24 Nov 2020 07:12:20 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id S00fqmi1zdCW; Tue, 24 Nov 2020 07:12:20 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 867BE8B79F;
        Tue, 24 Nov 2020 07:12:19 +0100 (CET)
Subject: Re: [PATCH v2 02/19] elf: Move arch_setup_additional_pages() to
 generic elf.h
To:     Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Guo Ren <guoren@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>, x86@kernel.org
References: <20201124002932.1220517-1-dima@arista.com>
 <20201124002932.1220517-3-dima@arista.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <4e1ade4b-5205-d5e7-a7cd-7f5cb0d024d5@csgroup.eu>
Date:   Tue, 24 Nov 2020 07:12:19 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201124002932.1220517-3-dima@arista.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 24/11/2020 à 01:29, Dmitry Safonov a écrit :
> Ifdef the function in the header, not in the code.
> Following kernel style, move it to Kconfig.
> All it makes it easier to follow when the option is enabled/disabled.
> Remove re-definition from compat_binfmt_elf, as it's always defined
> under compat_arch_setup_additional_pages (to be reworked).
> 
> Signed-off-by: Dmitry Safonov <dima@arista.com>
> ---
>   arch/arm/Kconfig                |  1 +
>   arch/arm/include/asm/elf.h      |  5 -----
>   arch/arm64/Kconfig              |  1 +
>   arch/arm64/include/asm/elf.h    |  6 +-----
>   arch/csky/Kconfig               |  1 +
>   arch/csky/include/asm/elf.h     |  4 ----
>   arch/hexagon/Kconfig            |  1 +
>   arch/hexagon/include/asm/elf.h  |  6 ------
>   arch/mips/Kconfig               |  1 +
>   arch/mips/include/asm/elf.h     |  5 -----
>   arch/nds32/Kconfig              |  1 +
>   arch/nds32/include/asm/elf.h    |  3 ---
>   arch/nios2/Kconfig              |  1 +
>   arch/nios2/include/asm/elf.h    |  4 ----
>   arch/powerpc/Kconfig            |  1 +
>   arch/powerpc/include/asm/elf.h  |  5 -----
>   arch/riscv/Kconfig              |  1 +
>   arch/riscv/include/asm/elf.h    |  4 ----
>   arch/s390/Kconfig               |  1 +
>   arch/s390/include/asm/elf.h     |  5 -----
>   arch/sh/Kconfig                 |  1 +
>   arch/sh/include/asm/elf.h       |  6 ------
>   arch/sparc/Kconfig              |  1 +
>   arch/sparc/include/asm/elf_64.h |  6 ------
>   arch/x86/Kconfig                |  1 +
>   arch/x86/include/asm/elf.h      |  4 ----
>   arch/x86/um/asm/elf.h           |  5 -----
>   fs/Kconfig.binfmt               |  3 +++
>   fs/binfmt_elf.c                 |  2 --
>   fs/binfmt_elf_fdpic.c           |  3 +--
>   fs/compat_binfmt_elf.c          |  2 --
>   include/linux/elf.h             | 12 ++++++++++++
>   32 files changed, 30 insertions(+), 73 deletions(-)
> 
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 6fd7d38a60c8..4221f171d1a9 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -134,6 +134,7 @@ config PPC
>   	select ARCH_HAS_PTE_SPECIAL
>   	select ARCH_HAS_MEMBARRIER_CALLBACKS
>   	select ARCH_HAS_MEMBARRIER_SYNC_CORE
> +	select ARCH_HAS_SETUP_ADDITIONAL_PAGES

We try to keep alphabetic order on powerpc, should go after ARCH_HAS_SCALED_CPUTIME

>   	select ARCH_HAS_SCALED_CPUTIME		if VIRT_CPU_ACCOUNTING_NATIVE && PPC_BOOK3S_64
>   	select ARCH_HAS_STRICT_KERNEL_RWX	if (PPC32 && !HIBERNATION)
>   	select ARCH_HAS_TICK_BROADCAST		if GENERIC_CLOCKEVENTS_BROADCAST
> diff --git a/arch/powerpc/include/asm/elf.h b/arch/powerpc/include/asm/elf.h
> index 53ed2ca40151..ba0e1e331088 100644
> --- a/arch/powerpc/include/asm/elf.h
> +++ b/arch/powerpc/include/asm/elf.h
> @@ -111,11 +111,6 @@ extern int dcache_bsize;
>   extern int icache_bsize;
>   extern int ucache_bsize;
>   
> -/* vDSO has arch_setup_additional_pages */
> -#define ARCH_HAS_SETUP_ADDITIONAL_PAGES
> -struct linux_binprm;
> -extern int arch_setup_additional_pages(struct linux_binprm *bprm,
> -				       int uses_interp);
>   #define VDSO_AUX_ENT(a,b) NEW_AUX_ENT(a,b)
>   
>   /* 1GB for 64bit, 8MB for 32bit */

Christophe

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2F202C1E1C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 07:22:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729118AbgKXGWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 01:22:14 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:10411 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728601AbgKXGWO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 01:22:14 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4CgDSy2Dmfz9tySZ;
        Tue, 24 Nov 2020 07:22:10 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id oVUV-djEWx00; Tue, 24 Nov 2020 07:22:10 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4CgDSy1Bgzz9ty3k;
        Tue, 24 Nov 2020 07:22:10 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 01D668B7A3;
        Tue, 24 Nov 2020 07:22:11 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id R-K-LmnoVsW1; Tue, 24 Nov 2020 07:22:10 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0DCF78B79F;
        Tue, 24 Nov 2020 07:22:10 +0100 (CET)
Subject: Re: [PATCH v2 08/19] arm/vdso: Remove vdso pointer from mm->context
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
 <20201124002932.1220517-9-dima@arista.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <a6877fff-b066-cffb-cede-011601f8a410@csgroup.eu>
Date:   Tue, 24 Nov 2020 07:22:11 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201124002932.1220517-9-dima@arista.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 24/11/2020 à 01:29, Dmitry Safonov a écrit :
> Not used any more.

But what about mremap() ? Maybe you should explain why you can remove it ?

> 
> Signed-off-by: Dmitry Safonov <dima@arista.com>
> ---
>   arch/arm/include/asm/mmu.h |  3 ---
>   arch/arm/kernel/vdso.c     | 12 ------------
>   2 files changed, 15 deletions(-)
> 
> diff --git a/arch/arm/include/asm/mmu.h b/arch/arm/include/asm/mmu.h
> index 1592a4264488..2397b0a19f59 100644
> --- a/arch/arm/include/asm/mmu.h
> +++ b/arch/arm/include/asm/mmu.h
> @@ -12,9 +12,6 @@ typedef struct {
>   #endif
>   	unsigned int	vmalloc_seq;
>   	unsigned long	sigpage;
> -#ifdef CONFIG_VDSO
> -	unsigned long	vdso;
> -#endif
>   #ifdef CONFIG_BINFMT_ELF_FDPIC
>   	unsigned long	exec_fdpic_loadmap;
>   	unsigned long	interp_fdpic_loadmap;
> diff --git a/arch/arm/kernel/vdso.c b/arch/arm/kernel/vdso.c
> index 710e5ca99a53..4b39c7d8f525 100644
> --- a/arch/arm/kernel/vdso.c
> +++ b/arch/arm/kernel/vdso.c
> @@ -47,17 +47,8 @@ static const struct vm_special_mapping vdso_data_mapping = {
>   	.pages = &vdso_data_page,
>   };
>   
> -static int vdso_mremap(const struct vm_special_mapping *sm,
> -		struct vm_area_struct *new_vma)
> -{
> -	current->mm->context.vdso = new_vma->vm_start;
> -
> -	return 0;
> -}
> -
>   static struct vm_special_mapping vdso_text_mapping __ro_after_init = {
>   	.name = "[vdso]",
> -	.mremap = vdso_mremap,
>   };
>   
>   struct elfinfo {
> @@ -239,8 +230,6 @@ void arm_install_vdso(struct mm_struct *mm, unsigned long addr,
>   	struct vm_area_struct *vma;
>   	unsigned long len;
>   
> -	mm->context.vdso = 0;
> -
>   	if (vdso_text_pagelist == NULL)
>   		return;
>   
> @@ -258,7 +247,6 @@ void arm_install_vdso(struct mm_struct *mm, unsigned long addr,
>   	if (IS_ERR(vma))
>   		return;
>   
> -	mm->context.vdso = addr;
>   	*sysinfo_ehdr = addr;
>   }
>   
> 

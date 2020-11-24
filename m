Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 340A12C1E1F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 07:24:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729521AbgKXGWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 01:22:49 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:10458 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729350AbgKXGWt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 01:22:49 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4CgDTc6cn9z9tySj;
        Tue, 24 Nov 2020 07:22:44 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 7SMUS3ayqCaK; Tue, 24 Nov 2020 07:22:44 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4CgDTc4pfsz9tySZ;
        Tue, 24 Nov 2020 07:22:44 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7B16D8B7A3;
        Tue, 24 Nov 2020 07:22:45 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id AD3TmhH4TGpE; Tue, 24 Nov 2020 07:22:45 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 634098B79F;
        Tue, 24 Nov 2020 07:22:44 +0100 (CET)
Subject: Re: [PATCH v2 09/19] s390/vdso: Remove vdso_base pointer from
 mm->context
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
        Will Deacon <will@kernel.org>, x86@kernel.org,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org
References: <20201124002932.1220517-1-dima@arista.com>
 <20201124002932.1220517-10-dima@arista.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <7ec0d6b6-64b1-6095-c574-febca7478aa7@csgroup.eu>
Date:   Tue, 24 Nov 2020 07:22:45 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201124002932.1220517-10-dima@arista.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 24/11/2020 à 01:29, Dmitry Safonov a écrit :
> Not used any more.

Same, what about mremap(), why can it be removed ?

> 
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: linux-s390@vger.kernel.org
> Signed-off-by: Dmitry Safonov <dima@arista.com>
> ---
>   arch/s390/include/asm/mmu.h |  1 -
>   arch/s390/kernel/vdso.c     | 10 ----------
>   2 files changed, 11 deletions(-)
> 
> diff --git a/arch/s390/include/asm/mmu.h b/arch/s390/include/asm/mmu.h
> index e12ff0f29d1a..095d0596f700 100644
> --- a/arch/s390/include/asm/mmu.h
> +++ b/arch/s390/include/asm/mmu.h
> @@ -15,7 +15,6 @@ typedef struct {
>   	unsigned long gmap_asce;
>   	unsigned long asce;
>   	unsigned long asce_limit;
> -	unsigned long vdso_base;
>   	/* The mmu context belongs to a secure guest. */
>   	atomic_t is_protected;
>   	/*
> diff --git a/arch/s390/kernel/vdso.c b/arch/s390/kernel/vdso.c
> index 810b72f8985c..3f07711a07c1 100644
> --- a/arch/s390/kernel/vdso.c
> +++ b/arch/s390/kernel/vdso.c
> @@ -58,18 +58,9 @@ static vm_fault_t vdso_fault(const struct vm_special_mapping *sm,
>   	return 0;
>   }
>   
> -static int vdso_mremap(const struct vm_special_mapping *sm,
> -		       struct vm_area_struct *vma)
> -{
> -	current->mm->context.vdso_base = vma->vm_start;
> -
> -	return 0;
> -}
> -
>   static const struct vm_special_mapping vdso_mapping = {
>   	.name = "[vdso]",
>   	.fault = vdso_fault,
> -	.mremap = vdso_mremap,
>   };
>   
>   static int __init vdso_setup(char *str)
> @@ -204,7 +195,6 @@ int arch_setup_additional_pages(unsigned long *sysinfo_ehdr)
>   		goto out_up;
>   	}
>   
> -	current->mm->context.vdso_base = vdso_base;
>   	*sysinfo_ehdr = vdso_base;
>   	rc = 0;
>   
> 

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5B932C1E29
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 07:26:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729680AbgKXGZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 01:25:27 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:25590 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728206AbgKXGZ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 01:25:26 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4CgDXf6Njsz9tySl;
        Tue, 24 Nov 2020 07:25:22 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id AyR_J6UbZGd2; Tue, 24 Nov 2020 07:25:22 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4CgDXf4sRqz9tySj;
        Tue, 24 Nov 2020 07:25:22 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 578B18B7A3;
        Tue, 24 Nov 2020 07:25:23 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id FPOuEZrcpiaZ; Tue, 24 Nov 2020 07:25:23 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4D86E8B79F;
        Tue, 24 Nov 2020 07:25:22 +0100 (CET)
Subject: Re: [PATCH v2 11/19] mm/mmap: Make vm_special_mapping::mremap return
 void
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
 <20201124002932.1220517-12-dima@arista.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <a5a9a165-11ea-29d0-46e7-cd6ea0028fec@csgroup.eu>
Date:   Tue, 24 Nov 2020 07:25:22 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201124002932.1220517-12-dima@arista.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 24/11/2020 à 01:29, Dmitry Safonov a écrit :
> Previously .mremap() callback needed (int) return to provide way to
> restrict resizing of a special mapping. Now it's restricted by
> providing .may_split = special_mapping_split.
> 
> Removing (int) return simplifies further changes to
> special_mapping_mremap() as it won't need save ret code from the
> callback. Also, it removes needless `return 0` from callbacks.
> 
> Signed-off-by: Dmitry Safonov <dima@arista.com>
> ---
>   arch/arm/kernel/process.c | 3 +--
>   arch/arm64/kernel/vdso.c  | 4 +---
>   arch/mips/vdso/genvdso.c  | 3 +--
>   arch/x86/entry/vdso/vma.c | 4 +---
>   include/linux/mm_types.h  | 2 +-
>   mm/mmap.c                 | 2 +-
>   6 files changed, 6 insertions(+), 12 deletions(-)
> 
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 65df8abd90bd..95a257927dae 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -780,7 +780,7 @@ struct vm_special_mapping {
>   				struct vm_area_struct *vma,
>   				struct vm_fault *vmf);
>   
> -	int (*mremap)(const struct vm_special_mapping *sm,
> +	void (*mremap)(const struct vm_special_mapping *sm,
>   		     struct vm_area_struct *new_vma);

Second line should be aligned to first line's parenthesis I think.

>   };
>   
> diff --git a/mm/mmap.c b/mm/mmap.c
> index d0d458632c1b..17fe59a9780b 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -3433,7 +3433,7 @@ static int special_mapping_mremap(struct vm_area_struct *new_vma,
>   		return -EFAULT;
>   
>   	if (sm->mremap)
> -		return sm->mremap(sm, new_vma);
> +		sm->mremap(sm, new_vma);
>   
>   	return 0;
>   }
> 

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6FC25ED0D
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Sep 2020 08:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbgIFGu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Sep 2020 02:50:29 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:56496 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725283AbgIFGu3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 02:50:29 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4Bkhqx47Rtz9v23Q;
        Sun,  6 Sep 2020 08:50:21 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id g8aHV4iH8w-U; Sun,  6 Sep 2020 08:50:21 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4Bkhqx3JGsz9v0xL;
        Sun,  6 Sep 2020 08:50:21 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 2DA2C8B770;
        Sun,  6 Sep 2020 08:50:24 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id VnQw8iUDK7UY; Sun,  6 Sep 2020 08:50:24 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B77F08B75B;
        Sun,  6 Sep 2020 08:50:23 +0200 (CEST)
Subject: Re: [PATCH -next] powerpc/book3s64: fix link error with
 CONFIG_PPC_RADIX_MMU=n
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20200905112548.3265530-1-yangyingliang@huawei.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <39a976b8-896c-e878-bac7-50bbf3ccbc4f@csgroup.eu>
Date:   Sun, 6 Sep 2020 08:50:18 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200905112548.3265530-1-yangyingliang@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 05/09/2020 à 13:25, Yang Yingliang a écrit :
> Fix link error when CONFIG_PPC_RADIX_MMU is disabled:
> powerpc64-linux-gnu-ld: arch/powerpc/platforms/pseries/lpar.o:(.toc+0x0): undefined reference to `mmu_pid_bits'
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>   arch/powerpc/mm/book3s64/mmu_context.c | 4 ++++

In your commit log, you are just mentionning 
arch/powerpc/platforms/pseries/lpar.o, which is right.

You shouldn't need to modify arch/powerpc/mm/book3s64/mmu_context.c at 
all, see below.

>   arch/powerpc/platforms/pseries/lpar.c  | 2 ++
>   2 files changed, 6 insertions(+)
> 
> diff --git a/arch/powerpc/mm/book3s64/mmu_context.c b/arch/powerpc/mm/book3s64/mmu_context.c
> index 0ba30b8b935b..a8e292cd88f0 100644
> --- a/arch/powerpc/mm/book3s64/mmu_context.c
> +++ b/arch/powerpc/mm/book3s64/mmu_context.c
> @@ -152,6 +152,7 @@ void hash__setup_new_exec(void)
>   
>   static int radix__init_new_context(struct mm_struct *mm)
>   {
> +#ifdef CONFIG_PPC_RADIX_MMU

This shouldn't be required. radix__init_new_context() is only called 
when radix_enabled() returns true.
As it is a static function, when it is not called it gets optimised 
away, so you will never get an undefined reference to `mmu_pid_bits` there.

>   	unsigned long rts_field;
>   	int index, max_id;
>   
> @@ -177,6 +178,9 @@ static int radix__init_new_context(struct mm_struct *mm)
>   	mm->context.hash_context = NULL;
>   
>   	return index;
> +#else
> +	return -ENOTSUPP;
> +#endif
>   }
>   
>   int init_new_context(struct task_struct *tsk, struct mm_struct *mm)
> diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
> index baf24eacd268..e454e218dbba 100644
> --- a/arch/powerpc/platforms/pseries/lpar.c
> +++ b/arch/powerpc/platforms/pseries/lpar.c
> @@ -1726,10 +1726,12 @@ void __init hpte_init_pseries(void)
>   
>   void radix_init_pseries(void)
>   {
> +#ifdef CONFIG_PPC_RADIX_MMU

This function is only called from 
/arch/powerpc/mm/book3s64/radix_pgtable.c which is only built when 
CONFIG_PPC_RADIX_MMU is selected.

So the entire function should be encloded in the #ifdef.

>   	pr_info("Using radix MMU under hypervisor\n");
>   
>   	pseries_lpar_register_process_table(__pa(process_tb),
>   						0, PRTB_SIZE_SHIFT - 12);
> +#endif
>   }
>   
>   #ifdef CONFIG_PPC_SMLPAR
> 

Christophe

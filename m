Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 541BC2AD433
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 11:58:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729548AbgKJK5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 05:57:51 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:46173 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728345AbgKJK5u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 05:57:50 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4CVlFQ2clRz9tytk;
        Tue, 10 Nov 2020 11:57:46 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id T1bxLO48_2uC; Tue, 10 Nov 2020 11:57:46 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4CVlFQ1LbHz9tyth;
        Tue, 10 Nov 2020 11:57:46 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8E8278B7EE;
        Tue, 10 Nov 2020 11:57:46 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id aeTtjldkvaVJ; Tue, 10 Nov 2020 11:57:46 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0AB168B764;
        Tue, 10 Nov 2020 11:57:42 +0100 (CET)
Subject: Re: [PATCH V3] sched/rt, powerpc: Prepare for PREEMPT_RT
To:     Wang Qing <wangqing@vivo.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Jordan Niethe <jniethe5@gmail.com>,
        Alistair Popple <alistair@popple.id.au>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <1604998411-16116-1-git-send-email-wangqing@vivo.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <5e040e63-0a28-03ee-ca41-917598b690b5@csgroup.eu>
Date:   Tue, 10 Nov 2020 11:57:41 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.1
MIME-Version: 1.0
In-Reply-To: <1604998411-16116-1-git-send-email-wangqing@vivo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 10/11/2020 à 09:53, Wang Qing a écrit :
> PREEMPT_RT is a separate preemption model, CONFIG_PREEMPT will
>   be disabled when CONFIG_PREEMPT_RT is enabled,  so we need
> to add CONFIG_PREEMPT_RT output to __die().
> 
> Signed-off-by: Wang Qing <wangqing@vivo.com>

Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>

> 
> Changes in v3:
>   - Fix typo issue.
> 
> Changes in v2:
>   - Modify as Christophe suggested.
> ---
>   arch/powerpc/kernel/traps.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
> index 5006dcb..dec7b81
> --- a/arch/powerpc/kernel/traps.c
> +++ b/arch/powerpc/kernel/traps.c
> @@ -262,10 +262,11 @@ static int __die(const char *str, struct pt_regs *regs, long err)
>   {
>   	printk("Oops: %s, sig: %ld [#%d]\n", str, err, ++die_counter);
>   
> -	printk("%s PAGE_SIZE=%luK%s%s%s%s%s%s %s\n",
> +	printk("%s PAGE_SIZE=%luK%s%s%s%s%s%s%s %s\n",
>   	       IS_ENABLED(CONFIG_CPU_LITTLE_ENDIAN) ? "LE" : "BE",
>   	       PAGE_SIZE / 1024, get_mmu_str(),
>   	       IS_ENABLED(CONFIG_PREEMPT) ? " PREEMPT" : "",
> +	       IS_ENABLED(CONFIG_PREEMPT_RT) ? " PREEMPT_RT" : "",
>   	       IS_ENABLED(CONFIG_SMP) ? " SMP" : "",
>   	       IS_ENABLED(CONFIG_SMP) ? (" NR_CPUS=" __stringify(NR_CPUS)) : "",
>   	       debug_pagealloc_enabled() ? " DEBUG_PAGEALLOC" : "",
> 

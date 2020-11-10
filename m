Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E029F2ACF81
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 07:16:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbgKJGP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 01:15:59 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:53611 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729885AbgKJGP6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 01:15:58 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4CVd0C6LBBz9txrh;
        Tue, 10 Nov 2020 07:15:55 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id p1JPEI5GGxiV; Tue, 10 Nov 2020 07:15:55 +0100 (CET)
Received: from vm-hermes.si.c-s.fr (vm-hermes.si.c-s.fr [192.168.25.253])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4CVd0C54bNz9txrc;
        Tue, 10 Nov 2020 07:15:55 +0100 (CET)
Received: by vm-hermes.si.c-s.fr (Postfix, from userid 33)
        id DE046CC4; Tue, 10 Nov 2020 07:18:39 +0100 (CET)
Received: from 192.168.4.90 ([192.168.4.90]) by messagerie.c-s.fr (Horde
 Framework) with HTTP; Tue, 10 Nov 2020 07:18:39 +0100
Date:   Tue, 10 Nov 2020 07:18:39 +0100
Message-ID: <20201110071839.Horde.h-QuHo16fxj_ok8Qgdbdnw8@messagerie.c-s.fr>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Wang Qing <wangqing@vivo.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Alistair Popple <alistair@popple.id.au>,
        Jordan Niethe <jniethe5@gmail.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de
Subject: Re: [PATCH] sched/rt, powerpc: Prepare for PREEMPT_RT
In-Reply-To: <1604893209-18762-1-git-send-email-wangqing@vivo.com>
User-Agent: Internet Messaging Program (IMP) H5 (6.2.3)
Content-Type: text/plain; charset=UTF-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Quoting Wang Qing <wangqing@vivo.com>:

> Add PREEMPT_RT output to die().
>
> Signed-off-by: Wang Qing <wangqing@vivo.com>
> ---
>  arch/powerpc/kernel/traps.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
> index 5006dcb..6dfe567
> --- a/arch/powerpc/kernel/traps.c
> +++ b/arch/powerpc/kernel/traps.c
> @@ -258,6 +258,14 @@ static char *get_mmu_str(void)
>  	return "";
>  }
>
> +#ifdef CONFIG_PREEMPT
> +#define S_PREEMPT " PREEMPT"
> +#elif defined(CONFIG_PREEMPT_RT)
> +#define S_PREEMPT " PREEMPT_RT"
> +#else
> +#define S_PREEMPT ""
> +#endif

I don't like too much that forest of #ifdefs. IS_ENABLED() is prefered  
whenever possible.

> +
>  static int __die(const char *str, struct pt_regs *regs, long err)
>  {
>  	printk("Oops: %s, sig: %ld [#%d]\n", str, err, ++die_counter);
> @@ -265,7 +273,7 @@ static int __die(const char *str, struct pt_regs  
> *regs, long err)
>  	printk("%s PAGE_SIZE=%luK%s%s%s%s%s%s %s\n",
>  	       IS_ENABLED(CONFIG_CPU_LITTLE_ENDIAN) ? "LE" : "BE",
>  	       PAGE_SIZE / 1024, get_mmu_str(),
> -	       IS_ENABLED(CONFIG_PREEMPT) ? " PREEMPT" : "",
> +	       S_PREEMPT,
>  	       IS_ENABLED(CONFIG_SMP) ? " SMP" : "",
>  	       IS_ENABLED(CONFIG_SMP) ? (" NR_CPUS=" __stringify(NR_CPUS)) : "",
>  	       debug_pagealloc_enabled() ? " DEBUG_PAGEALLOC" : "",
> --
> 2.7.4

I'd prefer to remain in line with the existing and use IS_ENABLED()  
instead of #ifdefs, see below:

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 5006dcbe1d9f..dec7b81c72a4 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -262,10 +262,11 @@ static int __die(const char *str, struct pt_regs  
*regs, long err)
  {
  	printk("Oops: %s, sig: %ld [#%d]\n", str, err, ++die_counter);

-	printk("%s PAGE_SIZE=%luK%s%s%s%s%s%s %s\n",
+	printk("%s PAGE_SIZE=%luK%s%s%s%s%s%s%s %s\n",
  	       IS_ENABLED(CONFIG_CPU_LITTLE_ENDIAN) ? "LE" : "BE",
  	       PAGE_SIZE / 1024, get_mmu_str(),
  	       IS_ENABLED(CONFIG_PREEMPT) ? " PREEMPT" : "",
+	       IS_ENABLED(CONFIG_PREEMPT_RT) ? " PREEMPT_RT" : "",
  	       IS_ENABLED(CONFIG_SMP) ? " SMP" : "",
  	       IS_ENABLED(CONFIG_SMP) ? (" NR_CPUS=" __stringify(NR_CPUS)) : "",
  	       debug_pagealloc_enabled() ? " DEBUG_PAGEALLOC" : "",
---
Christophe

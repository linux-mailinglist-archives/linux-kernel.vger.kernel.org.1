Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD4BE2B9920
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 18:17:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728606AbgKSRQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 12:16:41 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:54136 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728551AbgKSRQl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 12:16:41 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4CcRDN3LDJzB09Zj;
        Thu, 19 Nov 2020 18:16:36 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id ESYK-3qNMaWe; Thu, 19 Nov 2020 18:16:36 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4CcRDN25C7zB09Zh;
        Thu, 19 Nov 2020 18:16:36 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 2339A8B809;
        Thu, 19 Nov 2020 18:16:36 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 39ZHbWsp1Kn1; Thu, 19 Nov 2020 18:16:36 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id AC7288B78A;
        Thu, 19 Nov 2020 18:16:27 +0100 (CET)
Subject: Re: [PATCH v3 1/2] powerpc/ptrace: simplify gpr_get/tm_cgpr_get
To:     Oleg Nesterov <oleg@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Jan Kratochvil <jan.kratochvil@redhat.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20201119160154.GA5183@redhat.com>
 <20201119160221.GA5188@redhat.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <94c56c46-e336-f61c-3623-1b2014fcbb2e@csgroup.eu>
Date:   Thu, 19 Nov 2020 18:16:16 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201119160221.GA5188@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 19/11/2020 à 17:02, Oleg Nesterov a écrit :
> gpr_get() does membuf_write() twice to override pt_regs->msr in between.

Is there anything wrong with that ?

> We can call membuf_write() once and change ->msr in the kernel buffer,
> this simplifies the code and the next fix.
> 
> The patch adds a new simple helper, membuf_at(offs), it returns the new
> membuf which can be safely used after membuf_write().
> 
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> ---
>   arch/powerpc/kernel/ptrace/ptrace-tm.c   | 13 +++++--------
>   arch/powerpc/kernel/ptrace/ptrace-view.c | 13 +++++--------
>   include/linux/regset.h                   | 12 ++++++++++++
>   3 files changed, 22 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/ptrace/ptrace-tm.c b/arch/powerpc/kernel/ptrace/ptrace-tm.c
> index 54f2d076206f..f8fcbd85d4cb 100644
> --- a/arch/powerpc/kernel/ptrace/ptrace-tm.c
> +++ b/arch/powerpc/kernel/ptrace/ptrace-tm.c
> @@ -86,6 +86,8 @@ int tm_cgpr_active(struct task_struct *target, const struct user_regset *regset)
>   int tm_cgpr_get(struct task_struct *target, const struct user_regset *regset,
>   		struct membuf to)
>   {
> +	struct membuf to_msr = membuf_at(&to, offsetof(struct pt_regs, msr));
> +
>   	if (!cpu_has_feature(CPU_FTR_TM))
>   		return -ENODEV;
>   
> @@ -97,17 +99,12 @@ int tm_cgpr_get(struct task_struct *target, const struct user_regset *regset,
>   	flush_altivec_to_thread(target);
>   
>   	membuf_write(&to, &target->thread.ckpt_regs,
> -			offsetof(struct pt_regs, msr));
> -	membuf_store(&to, get_user_ckpt_msr(target));
> +				sizeof(struct user_pt_regs));

This looks mis-aligned. But it should fit on a single line, now we allow up to 100 chars on a line.

>   
> -	BUILD_BUG_ON(offsetof(struct pt_regs, orig_gpr3) !=
> -		     offsetof(struct pt_regs, msr) + sizeof(long));
> +	membuf_store(&to_msr, get_user_ckpt_msr(target));
>   
> -	membuf_write(&to, &target->thread.ckpt_regs.orig_gpr3,
> -			sizeof(struct user_pt_regs) -
> -			offsetof(struct pt_regs, orig_gpr3));
>   	return membuf_zero(&to, ELF_NGREG * sizeof(unsigned long) -
> -			sizeof(struct user_pt_regs));
> +				sizeof(struct user_pt_regs));

I can't see any change here except the alignment. Can you leave it as is ?


>   }
>   
>   /*
> diff --git a/arch/powerpc/kernel/ptrace/ptrace-view.c b/arch/powerpc/kernel/ptrace/ptrace-view.c
> index 7e6478e7ed07..39686ede40b3 100644
> --- a/arch/powerpc/kernel/ptrace/ptrace-view.c
> +++ b/arch/powerpc/kernel/ptrace/ptrace-view.c
> @@ -217,6 +217,7 @@ int ptrace_put_reg(struct task_struct *task, int regno, unsigned long data)
>   static int gpr_get(struct task_struct *target, const struct user_regset *regset,
>   		   struct membuf to)
>   {
> +	struct membuf to_msr = membuf_at(&to, offsetof(struct pt_regs, msr));
>   	int i;
>   
>   	if (target->thread.regs == NULL)
> @@ -228,17 +229,13 @@ static int gpr_get(struct task_struct *target, const struct user_regset *regset,
>   			target->thread.regs->gpr[i] = NV_REG_POISON;
>   	}
>   
> -	membuf_write(&to, target->thread.regs, offsetof(struct pt_regs, msr));
> -	membuf_store(&to, get_user_msr(target));
> +	membuf_write(&to, target->thread.regs,
> +				sizeof(struct user_pt_regs));

This should fit on a single line.

>   
> -	BUILD_BUG_ON(offsetof(struct pt_regs, orig_gpr3) !=
> -		     offsetof(struct pt_regs, msr) + sizeof(long));
> +	membuf_store(&to_msr, get_user_msr(target));
>   
> -	membuf_write(&to, &target->thread.regs->orig_gpr3,
> -			sizeof(struct user_pt_regs) -
> -			offsetof(struct pt_regs, orig_gpr3));
>   	return membuf_zero(&to, ELF_NGREG * sizeof(unsigned long) -
> -				 sizeof(struct user_pt_regs));
> +				sizeof(struct user_pt_regs));

This should not change, it's not part of the changes for this patch.

>   }
>   
>   static int gpr_set(struct task_struct *target, const struct user_regset *regset,
> diff --git a/include/linux/regset.h b/include/linux/regset.h
> index c3403f328257..a00765f0e8cf 100644
> --- a/include/linux/regset.h
> +++ b/include/linux/regset.h
> @@ -46,6 +46,18 @@ static inline int membuf_write(struct membuf *s, const void *v, size_t size)
>   	return s->left;
>   }
>   
> +static inline struct membuf membuf_at(const struct membuf *s, size_t offs)
> +{
> +	struct membuf n = *s;

Is there any point in using a struct membuf * instaed of a struct membuf as parameter ?

> +
> +	if (offs > n.left)
> +		offs = n.left;
> +	n.p += offs;
> +	n.left -= offs;
> +
> +	return n;
> +}
> +
>   /* current s->p must be aligned for v; v must be a scalar */
>   #define membuf_store(s, v)				\
>   ({							\
> 

Christophe

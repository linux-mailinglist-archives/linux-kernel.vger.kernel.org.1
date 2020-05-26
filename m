Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14CB71A7324
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Apr 2020 07:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405600AbgDNFsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Apr 2020 01:48:42 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:7250 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729064AbgDNFsk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 01:48:40 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 491ZKd03TGz9txjw;
        Tue, 14 Apr 2020 07:48:37 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=XjqpawvA; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id CFRg9po7RoTN; Tue, 14 Apr 2020 07:48:36 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 491ZKc5qf7z9txjv;
        Tue, 14 Apr 2020 07:48:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1586843316; bh=la9sDQY/dxZgqFKLruaF3b+j+rnTidsUGNC7IrNFJSE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=XjqpawvAzKt6Jdvmq1FWMyWVqehzEkusRFhdD7YTIcd/OQAws19RU59vKRvS3c2gN
         1SLUR5ipesIbSxHVk2ust7Q5r7YGWHhAU/6SOoCr7Km83GYmIMqOELpMV9mCqsk3hd
         5afhfDxKoYYGO/aejZeGstqfUXr64p0GWi6sqT0I=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A9D098B77D;
        Tue, 14 Apr 2020 07:48:37 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id FBpeMWwl2jQz; Tue, 14 Apr 2020 07:48:37 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A96748B752;
        Tue, 14 Apr 2020 07:48:36 +0200 (CEST)
Subject: Re: [PATCH v3 12/16] powerpc/watchpoint: Use builtin ALIGN*() macros
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>, mpe@ellerman.id.au,
        mikey@neuling.org
Cc:     apopple@linux.ibm.com, paulus@samba.org, npiggin@gmail.com,
        naveen.n.rao@linux.vnet.ibm.com, peterz@infradead.org,
        jolsa@kernel.org, oleg@redhat.com, fweisbec@gmail.com,
        mingo@kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <20200414031659.58875-1-ravi.bangoria@linux.ibm.com>
 <20200414031659.58875-13-ravi.bangoria@linux.ibm.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <a2d7abe8-44e0-9780-6603-00f16300c2ca@c-s.fr>
Date:   Tue, 14 Apr 2020 07:48:33 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200414031659.58875-13-ravi.bangoria@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 14/04/2020 à 05:16, Ravi Bangoria a écrit :
> Currently we calculate hw aligned start and end addresses manually.
> Replace them with builtin ALIGN_DOWN() and ALIGN() macros.
> 
> Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> ---
>   arch/powerpc/include/asm/hw_breakpoint.h  |  5 +++--
>   arch/powerpc/kernel/hw_breakpoint.c       | 12 ++++++------
>   arch/powerpc/kernel/process.c             |  8 ++++----
>   arch/powerpc/kernel/ptrace/ptrace-noadv.c |  2 +-
>   4 files changed, 14 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/hw_breakpoint.h b/arch/powerpc/include/asm/hw_breakpoint.h
> index d472b2eb757e..add5aa076919 100644
> --- a/arch/powerpc/include/asm/hw_breakpoint.h
> +++ b/arch/powerpc/include/asm/hw_breakpoint.h
> @@ -34,10 +34,11 @@ struct arch_hw_breakpoint {
>   #define HW_BRK_TYPE_PRIV_ALL	(HW_BRK_TYPE_USER | HW_BRK_TYPE_KERNEL | \
>   				 HW_BRK_TYPE_HYP)
>   
> +/* Minimum granularity */
>   #ifdef CONFIG_PPC_8xx
> -#define HW_BREAKPOINT_ALIGN 0x3
> +#define HW_BREAKPOINT_SIZE  0x4
>   #else
> -#define HW_BREAKPOINT_ALIGN 0x7
> +#define HW_BREAKPOINT_SIZE  0x8
>   #endif
>   
>   #define DABR_MAX_LEN	8
> diff --git a/arch/powerpc/kernel/hw_breakpoint.c b/arch/powerpc/kernel/hw_breakpoint.c
> index 319a761b7412..02ffd14f4519 100644
> --- a/arch/powerpc/kernel/hw_breakpoint.c
> +++ b/arch/powerpc/kernel/hw_breakpoint.c
> @@ -145,10 +145,10 @@ int arch_bp_generic_fields(int type, int *gen_bp_type)
>    *    <---8 bytes--->
>    *
>    * In this case, we should configure hw as:
> - *   start_addr = address & ~HW_BREAKPOINT_ALIGN
> + *   start_addr = address & ~(HW_BREAKPOINT_SIZE - 1)
>    *   len = 16 bytes
>    *
> - * @start_addr and @end_addr are inclusive.
> + * @start_addr is inclusive but @end_addr is exclusive.
>    */
>   static int hw_breakpoint_validate_len(struct arch_hw_breakpoint *hw)
>   {
> @@ -156,14 +156,14 @@ static int hw_breakpoint_validate_len(struct arch_hw_breakpoint *hw)
>   	u16 hw_len;
>   	unsigned long start_addr, end_addr;
>   
> -	start_addr = hw->address & ~HW_BREAKPOINT_ALIGN;
> -	end_addr = (hw->address + hw->len - 1) | HW_BREAKPOINT_ALIGN;
> -	hw_len = end_addr - start_addr + 1;
> +	start_addr = ALIGN_DOWN(hw->address, HW_BREAKPOINT_SIZE);
> +	end_addr = ALIGN(hw->address + hw->len, HW_BREAKPOINT_SIZE);
> +	hw_len = end_addr - start_addr;
>   
>   	if (dawr_enabled()) {
>   		max_len = DAWR_MAX_LEN;
>   		/* DAWR region can't cross 512 bytes boundary */
> -		if ((start_addr >> 9) != (end_addr >> 9))
> +		if ((start_addr >> 9) != ((end_addr - 1) >> 9))

What about:
	if (ALIGN(start_addr, SZ_512M) != ALIGN(end - 1, SZ_512M))

>   			return -EINVAL;
>   	} else if (IS_ENABLED(CONFIG_PPC_8xx)) {
>   		/* 8xx can setup a range without limitation */
> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
> index aab82ab80dfa..06679adac447 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -800,12 +800,12 @@ static inline int set_breakpoint_8xx(struct arch_hw_breakpoint *brk)
>   	unsigned long lctrl1 = LCTRL1_CTE_GT | LCTRL1_CTF_LT | LCTRL1_CRWE_RW |
>   			       LCTRL1_CRWF_RW;
>   	unsigned long lctrl2 = LCTRL2_LW0EN | LCTRL2_LW0LADC | LCTRL2_SLW0EN;
> -	unsigned long start_addr = brk->address & ~HW_BREAKPOINT_ALIGN;
> -	unsigned long end_addr = (brk->address + brk->len - 1) | HW_BREAKPOINT_ALIGN;
> +	unsigned long start_addr = ALIGN_DOWN(brk->address, HW_BREAKPOINT_SIZE);
> +	unsigned long end_addr = ALIGN(brk->address + brk->len, HW_BREAKPOINT_SIZE);
>   
>   	if (start_addr == 0)
>   		lctrl2 |= LCTRL2_LW0LA_F;
> -	else if (end_addr == ~0U)
> +	else if (end_addr - 1 == ~0U)

What about:
	else if (end_addr == 0)

>   		lctrl2 |= LCTRL2_LW0LA_E;
>   	else
>   		lctrl2 |= LCTRL2_LW0LA_EandF;
> @@ -821,7 +821,7 @@ static inline int set_breakpoint_8xx(struct arch_hw_breakpoint *brk)
>   		lctrl1 |= LCTRL1_CRWE_WO | LCTRL1_CRWF_WO;
>   
>   	mtspr(SPRN_CMPE, start_addr - 1);
> -	mtspr(SPRN_CMPF, end_addr + 1);
> +	mtspr(SPRN_CMPF, end_addr);
>   	mtspr(SPRN_LCTRL1, lctrl1);
>   	mtspr(SPRN_LCTRL2, lctrl2);
>   
> diff --git a/arch/powerpc/kernel/ptrace/ptrace-noadv.c b/arch/powerpc/kernel/ptrace/ptrace-noadv.c
> index 08cb8c1b504c..697c7e4b5877 100644
> --- a/arch/powerpc/kernel/ptrace/ptrace-noadv.c
> +++ b/arch/powerpc/kernel/ptrace/ptrace-noadv.c
> @@ -216,7 +216,7 @@ long ppc_set_hwdebug(struct task_struct *child, struct ppc_hw_breakpoint *bp_inf
>   	if ((unsigned long)bp_info->addr >= TASK_SIZE)
>   		return -EIO;
>   
> -	brk.address = bp_info->addr & ~HW_BREAKPOINT_ALIGN;
> +	brk.address = ALIGN_DOWN(bp_info->addr, HW_BREAKPOINT_SIZE);
>   	brk.type = HW_BRK_TYPE_TRANSLATE;
>   	brk.len = DABR_MAX_LEN;
>   	if (bp_info->trigger_type & PPC_BREAKPOINT_TRIGGER_READ)
> 

Christophe

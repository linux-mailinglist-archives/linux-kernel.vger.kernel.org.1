Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2212986E1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 07:33:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1770425AbgJZGdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 02:33:22 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2580 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1770418AbgJZGdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 02:33:22 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CKQ5K2rwtzhZp8;
        Mon, 26 Oct 2020 14:33:25 +0800 (CST)
Received: from [10.67.102.197] (10.67.102.197) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Mon, 26 Oct 2020 14:33:10 +0800
Subject: ping //Re: [PATCH v2] arm:traps: Don't print stack or raw PC/LR hex
 values in backtraces
To:     <linux@armlinux.org.uk>, <dima@arista.com>, <will@kernel.org>,
        <jpoimboe@redhat.com>, <akpm@linux-foundation.org>,
        <christian.brauner@ubuntu.com>, <viro@zeniv.linux.org.uk>,
        <ldufour@linux.ibm.com>, <amanieu@gmail.com>, <walken@google.com>,
        <ben.dooks@codethink.co.uk>, <tglx@linutronix.de>,
        <bigeasy@linutronix.de>, <mingo@kernel.org>,
        <vincent.whitchurch@axis.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <wangle6@huawei.com>,
        <luohaizheng@huawei.com>
References: <20201016023141.85300-1-nixiaoming@huawei.com>
From:   Xiaoming Ni <nixiaoming@huawei.com>
Message-ID: <23a3ce81-e1b6-337f-c217-5027134c0131@huawei.com>
Date:   Mon, 26 Oct 2020 14:33:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0.1
MIME-Version: 1.0
In-Reply-To: <20201016023141.85300-1-nixiaoming@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.197]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping

On 2020/10/16 10:31, Xiaoming Ni wrote:
> Printing raw pointer values in backtraces has potential security
> implications and are of questionable value anyway.
> 
> This patch follows x86 and arm64's lead and removes the "Exception stack:"
> dump from kernel backtraces:
> 	commit a25ffd3a6302a6 ("arm64: traps: Don't print stack or raw
> 	 PC/LR values in backtraces")
> 	commit bb5e5ce545f203 ("x86/dumpstack: Remove kernel text
> 	 addresses from stack dump")
> 
> Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
> 
> -------
> v2:
>   Delete [<hex numbers>] from the stack according to the email discussion
>   in patch V1, Other information processing will be discussed in subsequent
>   patches.
> 
> v1: https://lore.kernel.org/lkml/20201009075957.110017-1-nixiaoming@huawei.com/
>    1. Don't print stack or raw PC/LR hex values in backtraces
>    2. Don't print stack mem in backtraces
>    3. if (!panic_on_oops), Don't print stack mem in __die()
> ---
>   arch/arm/kernel/process.c | 3 +--
>   arch/arm/kernel/traps.c   | 4 ++--
>   2 files changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
> index 8e6ace03e960..71c9e5597d39 100644
> --- a/arch/arm/kernel/process.c
> +++ b/arch/arm/kernel/process.c
> @@ -121,8 +121,7 @@ void __show_regs(struct pt_regs *regs)
>   
>   	printk("PC is at %pS\n", (void *)instruction_pointer(regs));
>   	printk("LR is at %pS\n", (void *)regs->ARM_lr);
> -	printk("pc : [<%08lx>]    lr : [<%08lx>]    psr: %08lx\n",
> -	       regs->ARM_pc, regs->ARM_lr, regs->ARM_cpsr);
> +	printk("psr: %08lx\n", regs->ARM_cpsr);
>   	printk("sp : %08lx  ip : %08lx  fp : %08lx\n",
>   	       regs->ARM_sp, regs->ARM_ip, regs->ARM_fp);
>   	printk("r10: %08lx  r9 : %08lx  r8 : %08lx\n",
> diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
> index 17d5a785df28..911bbf164875 100644
> --- a/arch/arm/kernel/traps.c
> +++ b/arch/arm/kernel/traps.c
> @@ -68,8 +68,8 @@ void dump_backtrace_entry(unsigned long where, unsigned long from,
>   	unsigned long end = frame + 4 + sizeof(struct pt_regs);
>   
>   #ifdef CONFIG_KALLSYMS
> -	printk("%s[<%08lx>] (%ps) from [<%08lx>] (%pS)\n",
> -		loglvl, where, (void *)where, from, (void *)from);
> +	printk("%s (%ps) from (%pS)\n",
> +		loglvl, (void *)where, (void *)from);
>   #else
>   	printk("%sFunction entered at [<%08lx>] from [<%08lx>]\n",
>   		loglvl, where, from);
> 


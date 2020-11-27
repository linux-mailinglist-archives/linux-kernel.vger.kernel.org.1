Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0862D2C6409
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 12:44:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729542AbgK0Lnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 06:43:31 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:8420 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbgK0Lnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 06:43:31 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CjCRt59xFz74mm;
        Fri, 27 Nov 2020 19:43:06 +0800 (CST)
Received: from [10.174.177.244] (10.174.177.244) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Fri, 27 Nov 2020 19:43:20 +0800
Subject: Re: [PATCH] riscv/stacktrace: fix stackframe without ra on the top
To:     Chen Huang <chenhuang5@huawei.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20201127084502.2133722-1-chenhuang5@huawei.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <22dbe32a-0757-97ad-8885-0f2ba55bb743@huawei.com>
Date:   Fri, 27 Nov 2020 19:43:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20201127084502.2133722-1-chenhuang5@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.177.244]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/11/27 16:45, Chen Huang wrote:
> When a function doesn't have a callee, then it will not push ra
> into the stack, such as lkdtm_BUG() function:
>
> addi	sp,sp,-16
> sd	s0,8(sp)
> addi	s0,sp,16
> ebreak
>
> Then we use pt_regs as a parameter to walk_stackframe(), for the
> struct stackframe use {fp,ra} to get information from stack, it
> will get the wrong value. And the call trace will be:
>
> [<ffffffe00066c56c>] lkdtm_BUG+0x6/0x8
> ---[ end trace 18da3fbdf08e25d5 ]---
>
> It should be that:
> [<ffffffe00066c56c>] lkdtm_BUG+0x6/0x8
> [<ffffffe0008b24a4>] lkdtm_do_action+0x14/0x1c
> [<ffffffe00066c372>] direct_entry+0xc0/0x10a
> [<ffffffe000439f86>] full_proxy_write+0x42/0x6a
> [<ffffffe000309626>] vfs_write+0x7e/0x214
> [<ffffffe00030992a>] ksys_write+0x98/0xc0
> [<ffffffe000309960>] sys_write+0xe/0x16
> [<ffffffe0002014bc>] ret_from_syscall+0x0/0x2
> ---[ end trace 61917f3d9a9fadcd ]---
>
> Signed-off-by: Chen Huang <chenhuang5@huawei.com>
> ---
>   arch/riscv/kernel/stacktrace.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kernel/stacktrace.c b/arch/riscv/kernel/stacktrace.c
> index 595342910c3f..d1d4c18335c4 100644
> --- a/arch/riscv/kernel/stacktrace.c
> +++ b/arch/riscv/kernel/stacktrace.c
> @@ -57,7 +57,14 @@ void notrace walk_stackframe(struct task_struct *task, struct pt_regs *regs,
>   		/* Unwind stack frame */
>   		frame = (struct stackframe *)fp - 1;
>   		sp = fp;
> -		fp = frame->fp;
> +		if (regs && (frame->fp & 0x7) && (pc == regs->epc)) {
> +			fp = frame->ra;
> +			pc = regs->ra;
> +			continue;
> +		} else {
> +			fp = frame->fp;
> +		}
> +
>   		pc = ftrace_graph_ret_addr(current, NULL, frame->ra,
>   					   (unsigned long *)(fp - 8));

Better to move above code into else branch

>   	}

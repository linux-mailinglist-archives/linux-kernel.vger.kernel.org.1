Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8126D286D64
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 05:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728536AbgJHDyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 23:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbgJHDyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 23:54:46 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9EE7C061755
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 20:54:45 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id g9so3104877pgh.8
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 20:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=Q+c2MJYhELH98kr9lkjUCAnsZSZe5uNfKC1agYba9DQ=;
        b=gwk/NF2dinzLpw9FR5Bslo0btqWiij9ybZg/UvVmRrAnxH7ifStyzuISzmMUJbO3bO
         X3d8fdmqRB6KXwm90lZawW7QFP2l622Cl6z0y+NCR9h0jFtVvtr0GGVNqxkv0ZDjRp5W
         9oAttZrPASIeT1rf3V5HQkxgvOWAtk6IQwHTASv0jRMIBYlGEMj9JJk7E8lK9MipVKKT
         ahNi+zT9HZM9XwHg1a6+SXo3wVuE3rYBHWRn6BapMC0utK1csmZQ9eLiLEG4DSXAaCTO
         a/BDXJ5ia5C8vlgLPohUJp9DvdRhaBsqO+g6E1GJkwO/FbxaJGJFvyRMd+ErAcg1wm2s
         osfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=Q+c2MJYhELH98kr9lkjUCAnsZSZe5uNfKC1agYba9DQ=;
        b=fGlsS4rOmL9qyict29qFoD+wa8c8TqWMU19rXwpzSueoIJiVWIiZaeQYw2om0gg6nZ
         jEmNcdR/wlqu2BIr4Fiz6WlMyFmwlVOg6vqC4Yot4BBiamrk0xwIpg5uuy3wWG8/xuJW
         /ib/BdgfYHvX5EfeDmlwh0FL4ezh718WWPnTYNmBgHSv7tVpLRt++7SdsQKMCxd8lhT2
         pXtRWrOrm+Ueh7H1V9RD+8V3zvNm5+00eGOHShGyHVeGNUBbRobxCifFXFQ4MDFl1GDi
         uglKQKFFklwRrXfCN2Mx7Puge01bbDWdCBNVft/5R/Hhs+jIDM2tAl6Vsv2xTUt0T1SO
         BxQw==
X-Gm-Message-State: AOAM532UECA4Y/HuyPYwFJE/V5/JfQLCSPOvsVrdcSS1LqNH4KkmHryT
        Q2LvmYbDWpuweCwwGNkWNcWhZBibcKA5Vw==
X-Google-Smtp-Source: ABdhPJzKUM9qiDzRRwdWo1bPBY+3Rl7tDqYOZHkJB6/meotQwzCYmvdSoFfbOayJDJ5x7Y6ix7Farg==
X-Received: by 2002:a17:90a:5901:: with SMTP id k1mr5914200pji.33.1602129284695;
        Wed, 07 Oct 2020 20:54:44 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id q8sm5128753pfl.100.2020.10.07.20.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 20:54:44 -0700 (PDT)
Date:   Wed, 07 Oct 2020 20:54:44 -0700 (PDT)
X-Google-Original-Date: Wed, 07 Oct 2020 20:54:42 PDT (-0700)
Subject:     Re: [PATCH 2/2] riscv: Fixup static_obj() fail v2
In-Reply-To: <1602083313-19239-2-git-send-email-guoren@kernel.org>
CC:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        atishp@atishpatra.org, schwab@linux-m68k.org, aurelien@aurel32.net,
        guoren@linux.alibaba.com
From:   Palmer Dabbelt <palmerdabbelt@google.com>
To:     guoren@kernel.org
Message-ID: <mhng-81dee5c2-f8ee-4ab5-92d7-0e46dc952e87@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 07 Oct 2020 08:08:33 PDT (-0700), guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
>
> v1 is commit: 6184358da0004c8fd940afda6c0a0fa4027dc911 which has
> been reverted.
>
> When enable LOCKDEP, static_obj() will cause error:
>
> [    0.067192] INFO: trying to register non-static key.
> [    0.067325] the code is fine but needs lockdep annotation.
> [    0.067449] turning off the locking correctness validator.
> [    0.067718] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.7.0-rc7-dirty #44
> [    0.067945] Call Trace:
> [    0.068369] [<ffffffe00020323c>] walk_stackframe+0x0/0xa4
> [    0.068506] [<ffffffe000203422>] show_stack+0x2a/0x34
> [    0.068631] [<ffffffe000521e4e>] dump_stack+0x94/0xca
> [    0.068757] [<ffffffe000255a4e>] register_lock_class+0x5b8/0x5bc
> [    0.068969] [<ffffffe000255abe>] __lock_acquire+0x6c/0x1d5c
> [    0.069101] [<ffffffe0002550fe>] lock_acquire+0xae/0x312
> [    0.069228] [<ffffffe000989a8e>] _raw_spin_lock_irqsave+0x40/0x5a
> [    0.069357] [<ffffffe000247c64>] complete+0x1e/0x50
> [    0.069479] [<ffffffe000984c38>] rest_init+0x1b0/0x28a
> [    0.069660] [<ffffffe0000016a2>] 0xffffffe0000016a2
> [    0.069779] [<ffffffe000001b84>] 0xffffffe000001b84
> [    0.069953] [<ffffffe000001092>] 0xffffffe000001092
>
> Because some __initdata static variables is before _stext:
>
> static int static_obj(const void *obj)
> {
>         unsigned long start = (unsigned long) &_stext,
>                       end   = (unsigned long) &_end,
>                       addr  = (unsigned long) obj;
>
>         /*
>          * static variable?
>          */
>         if ((addr >= start) && (addr < end))
>                 return 1;
>
> 	if (arch_is_kernel_data(addr))
> 		return 1;
>
> We could implement arch_is_kernel_data to fixup it.
>
> Link: https://lore.kernel.org/linux-riscv/1593266228-61125-1-git-send-email-guoren@kernel.org/T/#t
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Reported-by: Aurelien Jarno <aurelien@aurel32.net>
> Cc: Palmer Dabbelt <palmerdabbelt@google.com>
> Cc: Atish Patra <atishp@atishpatra.org>
> Cc: Andreas Schwab <schwab@linux-m68k.org>
> Cc: Aurelien Jarno <aurelien@aurel32.net>
> ---
>  arch/riscv/include/asm/sections.h | 20 ++++++++++++++++++++
>  arch/riscv/kernel/setup.c         |  9 +++++++++
>  2 files changed, 29 insertions(+)
>  create mode 100644 arch/riscv/include/asm/sections.h
>
> diff --git a/arch/riscv/include/asm/sections.h b/arch/riscv/include/asm/sections.h
> new file mode 100644
> index 00000000..2317b9e
> --- /dev/null
> +++ b/arch/riscv/include/asm/sections.h
> @@ -0,0 +1,20 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +
> +#ifndef _ASM_RISCV_SECTIONS_H
> +#define _ASM_RISCV_SECTIONS_H
> +
> +#define arch_is_kernel_data arch_is_kernel_data
> +
> +#include <asm-generic/sections.h>
> +
> +extern bool init_mem_is_free;
> +
> +static inline int arch_is_kernel_data(unsigned long addr)
> +{
> +	if (init_mem_is_free)
> +		return 0;
> +
> +	return addr >= (unsigned long)__init_begin &&
> +		addr < (unsigned long)__init_end;
> +}
> +#endif /* _ASM_RISCV_SECTIONS_H */
> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> index 2c6dd32..9ebd5eb4 100644
> --- a/arch/riscv/kernel/setup.c
> +++ b/arch/riscv/kernel/setup.c
> @@ -17,6 +17,7 @@
>  #include <linux/sched/task.h>
>  #include <linux/swiotlb.h>
>  #include <linux/smp.h>
> +#include <linux/poison.h>
>
>  #include <asm/cpu_ops.h>
>  #include <asm/setup.h>
> @@ -112,3 +113,11 @@ static int __init topology_init(void)
>  	return 0;
>  }
>  subsys_initcall(topology_init);
> +
> +bool init_mem_is_free = false;
> +
> +void free_initmem(void)
> +{
> +	free_initmem_default(POISON_FREE_INITMEM);
> +	init_mem_is_free = true;
> +}

I'm a bit confused as to what you're trying to do here.  Yesterday I got
another version of this patch set that moves init data around, today a
different one.  Yesterday's is tested and simpler, and given it's so late in
the process I'm inclined to take that as I don't want to break anything.

Right now I have

84814460eef9 ("riscv: Fixup bootup failure with HARDENED_USERCOPY")
a78c6f5956a9 ("RISC-V: Make sure memblock reserves the memory containing DT")
549738f15da0 ("Linux 5.9-rc8")

Unless there's some functional bug, that's what I'm going to send out for 5.9
-- I'm not all that worried about lacking the ability to free init data.  The
above seems like fine 5.10 material.

Let me know if I'm missing something here.

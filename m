Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACE262A63DD
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 13:05:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729599AbgKDMF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 07:05:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:36686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726344AbgKDMFZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 07:05:25 -0500
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5AD22242E;
        Wed,  4 Nov 2020 12:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604491522;
        bh=qU9E28va32MDluGSIgWVAZFeinMkYl77t4qiztLxQNM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WpK4MAjbCld8pwgsMYuhtxW5cv+75sPkU8pHMlvRdCjbraF4P/XS7Ry/h/LMXxjvm
         1jVlhuzDuBqPRDeaUgvTBx1OhewIXk1ZrdT5paa4NTmahhQEei3fo0j9pm5MmHPC02
         UJijQLI5LzcDp7qoduEdZJz94th6dEYkyaLKRFlA=
Received: by mail-lf1-f54.google.com with SMTP id l2so26850417lfk.0;
        Wed, 04 Nov 2020 04:05:21 -0800 (PST)
X-Gm-Message-State: AOAM533WJnELaIPX1YGumA3e1ezLR3NSm9SeZUQQb2Qo60KCuIPGHGOx
        slHwaVQ7cmYN8YKpvWc2Qtd3rhfAnuVq8S7C9lE=
X-Google-Smtp-Source: ABdhPJyj+GlUeh+betCbBjBwTpjb30L2PBMuPgLXzT3ufIa6UCAwJb2qRe3EvVv94WyWWx1h5k6kNSyyx1zg6IcqtsI=
X-Received: by 2002:a19:6b10:: with SMTP id d16mr9061556lfa.121.1604491519890;
 Wed, 04 Nov 2020 04:05:19 -0800 (PST)
MIME-Version: 1.0
References: <1603024697-30080-1-git-send-email-guoren@kernel.org>
In-Reply-To: <1603024697-30080-1-git-send-email-guoren@kernel.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 4 Nov 2020 20:05:08 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTE4CX9rhV5YzeBt4W7mxc1EzD0YJdm=g940SFS7+-=uQ@mail.gmail.com>
Message-ID: <CAJF2gTTE4CX9rhV5YzeBt4W7mxc1EzD0YJdm=g940SFS7+-=uQ@mail.gmail.com>
Subject: Re: [PATCH v4] riscv: Enable per-task stack canaries
To:     Kees Cook <keescook@chromium.org>, cooper.qu@linux.alibaba.com
Cc:     linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-csky@vger.kernel.org, Anup Patel <anup@brainfault.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Guo Ren <guoren@linux.alibaba.com>,
        Zong Li <zong.li@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Atish Patra <atish.patra@wdc.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees,

Ping? Any feedback?

On Sun, Oct 18, 2020 at 8:39 PM <guoren@kernel.org> wrote:
>
> From: Guo Ren <guoren@linux.alibaba.com>
>
> This enables the use of per-task stack canary values if GCC has
> support for emitting the stack canary reference relative to the
> value of tp, which holds the task struct pointer in the riscv
> kernel.
>
> After compare arm64 and x86 implementations, seems arm64's is more
> flexible and readable. The key point is how gcc get the offset of
> stack_canary from gs/el0_sp.
>
> x86: Use a fix offset from gs, not flexible.
>
> struct fixed_percpu_data {
>         /*
>          * GCC hardcodes the stack canary as %gs:40.  Since the
>          * irq_stack is the object at %gs:0, we reserve the bottom
>          * 48 bytes of the irq stack for the canary.
>          */
>         char            gs_base[40]; // :(
>         unsigned long   stack_canary;
> };
>
> arm64: Use -mstack-protector-guard-offset & guard-reg
>         gcc options:
>         -mstack-protector-guard=sysreg
>         -mstack-protector-guard-reg=sp_el0
>         -mstack-protector-guard-offset=xxx
>
> riscv: Use -mstack-protector-guard-offset & guard-reg
>         gcc options:
>         -mstack-protector-guard=tls
>         -mstack-protector-guard-reg=tp
>         -mstack-protector-guard-offset=xxx
>
>  GCC's implementation has been merged:
>  commit c931e8d5a96463427040b0d11f9c4352ac22b2b0
>  Author: Cooper Qu <cooper.qu@linux.alibaba.com>
>  Date:   Mon Jul 13 16:15:08 2020 +0800
>
>      RISC-V: Add support for TLS stack protector canary access
>
> In the end, these codes are inserted by gcc before return:
>
> *  0xffffffe00020b396 <+120>:   ld      a5,1008(tp) # 0x3f0
> *  0xffffffe00020b39a <+124>:   xor     a5,a5,a4
> *  0xffffffe00020b39c <+126>:   mv      a0,s5
> *  0xffffffe00020b39e <+128>:   bnez    a5,0xffffffe00020b61c <_do_fork+766>
>    0xffffffe00020b3a2 <+132>:   ld      ra,136(sp)
>    0xffffffe00020b3a4 <+134>:   ld      s0,128(sp)
>    0xffffffe00020b3a6 <+136>:   ld      s1,120(sp)
>    0xffffffe00020b3a8 <+138>:   ld      s2,112(sp)
>    0xffffffe00020b3aa <+140>:   ld      s3,104(sp)
>    0xffffffe00020b3ac <+142>:   ld      s4,96(sp)
>    0xffffffe00020b3ae <+144>:   ld      s5,88(sp)
>    0xffffffe00020b3b0 <+146>:   ld      s6,80(sp)
>    0xffffffe00020b3b2 <+148>:   ld      s7,72(sp)
>    0xffffffe00020b3b4 <+150>:   addi    sp,sp,144
>    0xffffffe00020b3b6 <+152>:   ret
>    ...
> *  0xffffffe00020b61c <+766>:   auipc   ra,0x7f8
> *  0xffffffe00020b620 <+770>:   jalr    -1764(ra) # 0xffffffe000a02f38 <__stack_chk_fail>
>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Cooper Qu <cooper.qu@linux.alibaba.com>
> Cc: Kees Cook <keescook@chromium.org>
> ---
>  arch/riscv/Kconfig                      |  7 +++++++
>  arch/riscv/Makefile                     | 10 ++++++++++
>  arch/riscv/include/asm/stackprotector.h |  3 ++-
>  arch/riscv/kernel/asm-offsets.c         |  3 +++
>  arch/riscv/kernel/process.c             |  2 +-
>  5 files changed, 23 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index b7821ac..95a0608 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -388,6 +388,13 @@ config CMDLINE_FORCE
>
>  endchoice
>
> +config CC_HAVE_STACKPROTECTOR_TLS
> +       def_bool $(cc-option,-mstack-protector-guard=tls -mstack-protector-guard-reg=tp -mstack-protector-guard-offset=0)
> +
> +config STACKPROTECTOR_PER_TASK
> +       def_bool y
> +       depends on STACKPROTECTOR && CC_HAVE_STACKPROTECTOR_TLS
> +
>  endmenu
>
>  config BUILTIN_DTB
> diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> index fb6e37d..f5f8ee9 100644
> --- a/arch/riscv/Makefile
> +++ b/arch/riscv/Makefile
> @@ -68,6 +68,16 @@ KBUILD_CFLAGS_MODULE += $(call cc-option,-mno-relax)
>  # architectures.  It's faster to have GCC emit only aligned accesses.
>  KBUILD_CFLAGS += $(call cc-option,-mstrict-align)
>
> +ifeq ($(CONFIG_STACKPROTECTOR_PER_TASK),y)
> +prepare: stack_protector_prepare
> +stack_protector_prepare: prepare0
> +       $(eval KBUILD_CFLAGS += -mstack-protector-guard=tls               \
> +                               -mstack-protector-guard-reg=tp            \
> +                               -mstack-protector-guard-offset=$(shell    \
> +                       awk '{if ($$2 == "TSK_STACK_CANARY") print $$3;}' \
> +                                       include/generated/asm-offsets.h))
> +endif
> +
>  # arch specific predefines for sparse
>  CHECKFLAGS += -D__riscv -D__riscv_xlen=$(BITS)
>
> diff --git a/arch/riscv/include/asm/stackprotector.h b/arch/riscv/include/asm/stackprotector.h
> index 5962f88..09093af 100644
> --- a/arch/riscv/include/asm/stackprotector.h
> +++ b/arch/riscv/include/asm/stackprotector.h
> @@ -24,6 +24,7 @@ static __always_inline void boot_init_stack_canary(void)
>         canary &= CANARY_MASK;
>
>         current->stack_canary = canary;
> -       __stack_chk_guard = current->stack_canary;
> +       if (!IS_ENABLED(CONFIG_STACKPROTECTOR_PER_TASK))
> +               __stack_chk_guard = current->stack_canary;
>  }
>  #endif /* _ASM_RISCV_STACKPROTECTOR_H */
> diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-offsets.c
> index db20344..877ff65 100644
> --- a/arch/riscv/kernel/asm-offsets.c
> +++ b/arch/riscv/kernel/asm-offsets.c
> @@ -66,6 +66,9 @@ void asm_offsets(void)
>         OFFSET(TASK_THREAD_F30, task_struct, thread.fstate.f[30]);
>         OFFSET(TASK_THREAD_F31, task_struct, thread.fstate.f[31]);
>         OFFSET(TASK_THREAD_FCSR, task_struct, thread.fstate.fcsr);
> +#ifdef CONFIG_STACKPROTECTOR
> +       OFFSET(TSK_STACK_CANARY, task_struct, stack_canary);
> +#endif
>
>         DEFINE(PT_SIZE, sizeof(struct pt_regs));
>         OFFSET(PT_EPC, pt_regs, epc);
> diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
> index 2b97c49..51ddc27 100644
> --- a/arch/riscv/kernel/process.c
> +++ b/arch/riscv/kernel/process.c
> @@ -24,7 +24,7 @@
>
>  register unsigned long gp_in_global __asm__("gp");
>
> -#ifdef CONFIG_STACKPROTECTOR
> +#if defined(CONFIG_STACKPROTECTOR) && !defined(CONFIG_STACKPROTECTOR_PER_TASK)
>  #include <linux/stackprotector.h>
>  unsigned long __stack_chk_guard __read_mostly;
>  EXPORT_SYMBOL(__stack_chk_guard);
> --
> 2.7.4
>


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/

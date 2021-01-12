Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19AE82F4040
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 01:47:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389203AbhALXXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 18:23:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731870AbhALXXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 18:23:32 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D929C061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 15:22:52 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id q7so223802pgm.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 15:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=auxzT8WGE14tQXppI+shw5Rz30NghYVmvwU0Vp5iL5k=;
        b=VyfqD7Hmw6QHBNOGpfz7VAedmZJbr38CvUUjNYsf339XkhPbpiP1pAyR1SfboNtHXY
         Jal/49YETAgcA31pn7zRGcgrY9h2PKK+UNzssj1Y1riAMrk/hpQW1BAkF8tCWtyvYHal
         rrW13Yswc47+740p+USRxQmcG8X2EmTobHol6tmkWMRsKs/eIFccHvA3dphT1JjS8oEj
         KNevcfnLooBv6H7M5f4ZwEhajmLjAo5zZvVaDT8GIy/BzBkIbtdnOYa0456kWZhnpyAW
         z+0m2vhw1+bLZfvZbgCHnldoKS4lra3tTscnUQnaHqYLqqlQGyBMYhl4XNuRqbuATIje
         C4HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=auxzT8WGE14tQXppI+shw5Rz30NghYVmvwU0Vp5iL5k=;
        b=G037nWf9+onrwA+UK01F+0s88NbDWs0AWH5YgrNlPz7jlrJEIvzDIN9UapZ3YC2saW
         s+0JVBQ46oT41VFz7tCDp+or5C4B8L3zkq80xa3KLZzfNvlJHI++s4g9sQX71POc97OK
         xYogBFwq+c6Ao9KmbBtHCCJ4evGSivJNnbTETh6HNV5C2nj5QPqIrAsSrBoi41CE3uM4
         VxW/rLY0Waa96p9AmpyVkHH6T+6Eyjy0plDkcsXsw8HhE9DWayaRQpJc1eLUs3FNVnux
         32Hbxrxr1aCzk2k+Uza7Y11V3qntRenyy4raPTY4GRbjqTgZrKDOOaqQx00T4eFOEjMs
         v3SQ==
X-Gm-Message-State: AOAM531Ly75b/VMmqJiWeXvhZldmzLCwYfxcC9plWy8IQXhoxXUGBQNB
        kTlFw7oaUGqiRU1wMjX73Z88kg==
X-Google-Smtp-Source: ABdhPJzFsGLD7kbS0RgvUR/OZyK9T2638CjYYZ8WQkg+IBAQpIy2f6o7FuoAxQiJst7JYje/ZHTjtw==
X-Received: by 2002:aa7:9f0f:0:b029:19b:c68f:61cd with SMTP id g15-20020aa79f0f0000b029019bc68f61cdmr1538881pfr.45.1610493771433;
        Tue, 12 Jan 2021 15:22:51 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id h5sm17749pgl.86.2021.01.12.15.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 15:22:50 -0800 (PST)
Date:   Tue, 12 Jan 2021 15:22:50 -0800 (PST)
X-Google-Original-Date: Tue, 12 Jan 2021 15:22:48 PST (-0800)
Subject:     Re: [PATCH RESEND v4] riscv: Enable per-task stack canaries
In-Reply-To: <1608222558-6677-1-git-send-email-guoren@kernel.org>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, anup@brainfault.org,
        greentime.hu@sifive.com, zong.li@sifive.com, keescook@chromium.org,
        Bjorn Topel <bjorn.topel@gmail.com>,
        Atish Patra <Atish.Patra@wdc.com>, cooper.qu@linux.alibaba.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, guoren@kernel.org,
        guoren@linux.alibaba.com
From:   Palmer Dabbelt <palmerdabbelt@google.com>
To:     guoren@kernel.org
Message-ID: <mhng-a07967fd-5808-4550-a909-954f1a25b53b@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Dec 2020 08:29:18 PST (-0800), guoren@kernel.org wrote:
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
> 	/*
> 	 * GCC hardcodes the stack canary as %gs:40.  Since the
> 	 * irq_stack is the object at %gs:0, we reserve the bottom
> 	 * 48 bytes of the irq stack for the canary.
> 	 */
> 	char            gs_base[40]; // :(
> 	unsigned long   stack_canary;
> };
>
> arm64: Use -mstack-protector-guard-offset & guard-reg
> 	gcc options:
> 	-mstack-protector-guard=sysreg
> 	-mstack-protector-guard-reg=sp_el0
> 	-mstack-protector-guard-offset=xxx
>
> riscv: Use -mstack-protector-guard-offset & guard-reg
> 	gcc options:
> 	-mstack-protector-guard=tls
> 	-mstack-protector-guard-reg=tp
> 	-mstack-protector-guard-offset=xxx
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
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Cc: Palmer Dabbelt <palmerdabbelt@google.com>
> ---
>  arch/riscv/Kconfig                      |  7 +++++++
>  arch/riscv/Makefile                     | 10 ++++++++++
>  arch/riscv/include/asm/stackprotector.h |  3 ++-
>  arch/riscv/kernel/asm-offsets.c         |  3 +++
>  arch/riscv/kernel/process.c             |  2 +-
>  5 files changed, 23 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index a627ae2..3d9daee 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -420,6 +420,13 @@ config EFI
>  	  allow the kernel to be booted as an EFI application. This
>  	  is only useful on systems that have UEFI firmware.
>
> +config CC_HAVE_STACKPROTECTOR_TLS
> +	def_bool $(cc-option,-mstack-protector-guard=tls -mstack-protector-guard-reg=tp -mstack-protector-guard-offset=0)
> +
> +config STACKPROTECTOR_PER_TASK
> +	def_bool y
> +	depends on STACKPROTECTOR && CC_HAVE_STACKPROTECTOR_TLS
> +
>  endmenu
>
>  config BUILTIN_DTB
> diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> index b6eb946..508de08 100644
> --- a/arch/riscv/Makefile
> +++ b/arch/riscv/Makefile
> @@ -67,6 +67,16 @@ KBUILD_CFLAGS_MODULE += $(call cc-option,-mno-relax)
>  # architectures.  It's faster to have GCC emit only aligned accesses.
>  KBUILD_CFLAGS += $(call cc-option,-mstrict-align)
>
> +ifeq ($(CONFIG_STACKPROTECTOR_PER_TASK),y)
> +prepare: stack_protector_prepare
> +stack_protector_prepare: prepare0
> +	$(eval KBUILD_CFLAGS += -mstack-protector-guard=tls		  \
> +				-mstack-protector-guard-reg=tp		  \
> +				-mstack-protector-guard-offset=$(shell	  \
> +			awk '{if ($$2 == "TSK_STACK_CANARY") print $$3;}' \
> +					include/generated/asm-offsets.h))
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
>  	canary &= CANARY_MASK;
>
>  	current->stack_canary = canary;
> -	__stack_chk_guard = current->stack_canary;
> +	if (!IS_ENABLED(CONFIG_STACKPROTECTOR_PER_TASK))
> +		__stack_chk_guard = current->stack_canary;
>  }
>  #endif /* _ASM_RISCV_STACKPROTECTOR_H */
> diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-offsets.c
> index db20344..877ff65 100644
> --- a/arch/riscv/kernel/asm-offsets.c
> +++ b/arch/riscv/kernel/asm-offsets.c
> @@ -66,6 +66,9 @@ void asm_offsets(void)
>  	OFFSET(TASK_THREAD_F30, task_struct, thread.fstate.f[30]);
>  	OFFSET(TASK_THREAD_F31, task_struct, thread.fstate.f[31]);
>  	OFFSET(TASK_THREAD_FCSR, task_struct, thread.fstate.fcsr);
> +#ifdef CONFIG_STACKPROTECTOR
> +	OFFSET(TSK_STACK_CANARY, task_struct, stack_canary);
> +#endif
>
>  	DEFINE(PT_SIZE, sizeof(struct pt_regs));
>  	OFFSET(PT_EPC, pt_regs, epc);
> diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
> index dd5f985..f786b5f 100644
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

Thanks, this is on for-next.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE5BA2A8BC4
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 02:03:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732763AbgKFBDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 20:03:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730895AbgKFBDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 20:03:48 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E89C0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 17:03:46 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id u4so2615927pgr.9
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 17:03:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=h1qhqRSMRUXyrUbUEOvVj1Xayt+tRFfnnKrhvY579fA=;
        b=Ye4CbyDkxD8CzEKWZyGLbqZxCo0wBnxB29MlGN/C/uWJtMnQPvPxxeNMU2Js3bAcYZ
         wrV5R5Re+PojfvDG7jTmIc3fv/+Oqh/kBQ/tU/cfYqt8X6ZkMvJ1mygETTmq5FIQgLCL
         YRXa7P4ZT+MgPEzsU2qU0I/RW21R5zbYyopVX8oa8OUW2bcM/IyqumlnyVdjCiujSmit
         wvIUf/EgAYtOzXcU78Xpsd0oPRhm8XTeMull7sikNu7528pnJtW6ydBP95nW6IARFgcQ
         QGvs8AAMYs8+Jwq6VYxq1gVoPQhovH3FxYRFM2wKXDSluczz+6NT57d4YgYzdp/DS4UX
         d9nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=h1qhqRSMRUXyrUbUEOvVj1Xayt+tRFfnnKrhvY579fA=;
        b=l/8llunkEsJarwkZXxwNxy+iH2qOONmx8C3njgAMROqsmjWYUk8yzZUYh/lOHA3QoT
         MmfbxUPJQklm01KGNf1BJS+mClV3ZgtNkmAHGscwoo1dqO6v4fw7K5Mxcdz71QQZg1ib
         YxlTdJBeDLfF1w9ctQ5O0vhnpQ6WrF5YOr4j+SyxZu7Th1lStCcncm+LFaa06VtBxSW3
         NaarkxmljfBBRqvZOUKli2D1DkwR+97j6UAvMG7Zyf3/ie7lBSRXq7P2G1D0+bp5jIFb
         ieVemPrgCe/tZiKqRKlCFtvP+Q1SGVqzVnXH8p1CVPr67O1CZYU/2ATcWVFx+Xsh92Gf
         s1Nw==
X-Gm-Message-State: AOAM533VF+tlgQtucCtVuHU3NGKHUsKubrQVtNIPWBQyUWjMR882gI9e
        6dnSZ97L2ARzquhvtgrr19B30A==
X-Google-Smtp-Source: ABdhPJxuk/9LN+HRinOOazfvVLm0ahfLbbwa3GQ3/PlZrz4ilMrIrzMVzDvSxLJYgNiAbSSHS0aPVg==
X-Received: by 2002:a62:5542:0:b029:156:222c:a630 with SMTP id j63-20020a6255420000b0290156222ca630mr4896256pfb.50.1604624626215;
        Thu, 05 Nov 2020 17:03:46 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id b16sm3765879pfp.195.2020.11.05.17.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 17:03:45 -0800 (PST)
Date:   Thu, 05 Nov 2020 17:03:45 -0800 (PST)
X-Google-Original-Date: Thu, 05 Nov 2020 17:03:43 PST (-0800)
Subject:     Re: [PATCH v4 1/9] RISC-V: Implement ptrace regs and stack API
In-Reply-To: <1602918377-23573-2-git-send-email-guoren@kernel.org>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, mhiramat@kernel.org,
        alankao@andestech.com, rostedt@goodmis.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        anup@brainfault.org, linux-csky@vger.kernel.org,
        greentime.hu@sifive.com, zong.li@sifive.com, guoren@kernel.org,
        me@packi.ch, guoren@linux.alibaba.com
From:   Palmer Dabbelt <palmerdabbelt@google.com>
To:     guoren@kernel.org
Message-ID: <mhng-c3f5e2b4-0467-42f6-9f5b-e66ade70eef2@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Oct 2020 00:06:09 PDT (-0700), guoren@kernel.org wrote:
> From: Patrick Stählin <me@packi.ch>
>
> Needed for kprobes support. Copied and adapted from arm64 code.
>
> Guo Ren fixup pt_regs type for linux-5.8-rc1.
>
> Signed-off-by: Patrick Stählin <me@packi.ch>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Reviewed-by: Pekka Enberg <penberg@kernel.org>
> Reviewed-by: Zong Li <zong.li@sifive.com>
> Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  arch/riscv/Kconfig              |  1 +
>  arch/riscv/include/asm/ptrace.h | 29 ++++++++++++
>  arch/riscv/kernel/ptrace.c      | 99 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 129 insertions(+)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index b7821ac..e6424d8b 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -87,6 +87,7 @@ config RISCV
>  	select SPARSE_IRQ
>  	select SYSCTL_EXCEPTION_TRACE
>  	select THREAD_INFO_IN_TASK
> +	select HAVE_REGS_AND_STACK_ACCESS_API

We alphabetize these now -- I'd usually just fix it, but there's a
Signed-off-by issue later in the patch set.

>
>  config ARCH_MMAP_RND_BITS_MIN
>  	default 18 if 64BIT
> diff --git a/arch/riscv/include/asm/ptrace.h b/arch/riscv/include/asm/ptrace.h
> index ee49f80..23372bb 100644
> --- a/arch/riscv/include/asm/ptrace.h
> +++ b/arch/riscv/include/asm/ptrace.h
> @@ -8,6 +8,7 @@
>
>  #include <uapi/asm/ptrace.h>
>  #include <asm/csr.h>
> +#include <linux/compiler.h>
>
>  #ifndef __ASSEMBLY__
>
> @@ -60,6 +61,7 @@ struct pt_regs {
>
>  #define user_mode(regs) (((regs)->status & SR_PP) == 0)
>
> +#define MAX_REG_OFFSET offsetof(struct pt_regs, orig_a0)
>
>  /* Helpers for working with the instruction pointer */
>  static inline unsigned long instruction_pointer(struct pt_regs *regs)
> @@ -85,6 +87,12 @@ static inline void user_stack_pointer_set(struct pt_regs *regs,
>  	regs->sp =  val;
>  }
>
> +/* Valid only for Kernel mode traps. */
> +static inline unsigned long kernel_stack_pointer(struct pt_regs *regs)
> +{
> +	return regs->sp;
> +}
> +
>  /* Helpers for working with the frame pointer */
>  static inline unsigned long frame_pointer(struct pt_regs *regs)
>  {
> @@ -101,6 +109,27 @@ static inline unsigned long regs_return_value(struct pt_regs *regs)
>  	return regs->a0;
>  }
>
> +extern int regs_query_register_offset(const char *name);
> +extern unsigned long regs_get_kernel_stack_nth(struct pt_regs *regs,
> +					       unsigned int n);
> +
> +/**
> + * regs_get_register() - get register value from its offset
> + * @regs:	pt_regs from which register value is gotten
> + * @offset:	offset of the register.
> + *
> + * regs_get_register returns the value of a register whose offset from @regs.
> + * The @offset is the offset of the register in struct pt_regs.
> + * If @offset is bigger than MAX_REG_OFFSET, this returns 0.
> + */
> +static inline unsigned long regs_get_register(struct pt_regs *regs,
> +					      unsigned int offset)
> +{
> +	if (unlikely(offset > MAX_REG_OFFSET))
> +		return 0;
> +
> +	return *(unsigned long *)((unsigned long)regs + offset);
> +}
>  #endif /* __ASSEMBLY__ */
>
>  #endif /* _ASM_RISCV_PTRACE_H */
> diff --git a/arch/riscv/kernel/ptrace.c b/arch/riscv/kernel/ptrace.c
> index 2d6395f..1a85305 100644
> --- a/arch/riscv/kernel/ptrace.c
> +++ b/arch/riscv/kernel/ptrace.c
> @@ -114,6 +114,105 @@ const struct user_regset_view *task_user_regset_view(struct task_struct *task)
>  	return &riscv_user_native_view;
>  }
>
> +struct pt_regs_offset {
> +	const char *name;
> +	int offset;
> +};
> +
> +#define REG_OFFSET_NAME(r) {.name = #r, .offset = offsetof(struct pt_regs, r)}
> +#define REG_OFFSET_END {.name = NULL, .offset = 0}
> +
> +static const struct pt_regs_offset regoffset_table[] = {
> +	REG_OFFSET_NAME(epc),
> +	REG_OFFSET_NAME(ra),
> +	REG_OFFSET_NAME(sp),
> +	REG_OFFSET_NAME(gp),
> +	REG_OFFSET_NAME(tp),
> +	REG_OFFSET_NAME(t0),
> +	REG_OFFSET_NAME(t1),
> +	REG_OFFSET_NAME(t2),
> +	REG_OFFSET_NAME(s0),
> +	REG_OFFSET_NAME(s1),
> +	REG_OFFSET_NAME(a0),
> +	REG_OFFSET_NAME(a1),
> +	REG_OFFSET_NAME(a2),
> +	REG_OFFSET_NAME(a3),
> +	REG_OFFSET_NAME(a4),
> +	REG_OFFSET_NAME(a5),
> +	REG_OFFSET_NAME(a6),
> +	REG_OFFSET_NAME(a7),
> +	REG_OFFSET_NAME(s2),
> +	REG_OFFSET_NAME(s3),
> +	REG_OFFSET_NAME(s4),
> +	REG_OFFSET_NAME(s5),
> +	REG_OFFSET_NAME(s6),
> +	REG_OFFSET_NAME(s7),
> +	REG_OFFSET_NAME(s8),
> +	REG_OFFSET_NAME(s9),
> +	REG_OFFSET_NAME(s10),
> +	REG_OFFSET_NAME(s11),
> +	REG_OFFSET_NAME(t3),
> +	REG_OFFSET_NAME(t4),
> +	REG_OFFSET_NAME(t5),
> +	REG_OFFSET_NAME(t6),
> +	REG_OFFSET_NAME(status),
> +	REG_OFFSET_NAME(badaddr),
> +	REG_OFFSET_NAME(cause),
> +	REG_OFFSET_NAME(orig_a0),
> +	REG_OFFSET_END,
> +};
> +
> +/**
> + * regs_query_register_offset() - query register offset from its name
> + * @name:	the name of a register
> + *
> + * regs_query_register_offset() returns the offset of a register in struct
> + * pt_regs from its name. If the name is invalid, this returns -EINVAL;
> + */
> +int regs_query_register_offset(const char *name)
> +{
> +	const struct pt_regs_offset *roff;
> +
> +	for (roff = regoffset_table; roff->name != NULL; roff++)
> +		if (!strcmp(roff->name, name))
> +			return roff->offset;
> +	return -EINVAL;
> +}
> +
> +/**
> + * regs_within_kernel_stack() - check the address in the stack
> + * @regs:      pt_regs which contains kernel stack pointer.
> + * @addr:      address which is checked.
> + *
> + * regs_within_kernel_stack() checks @addr is within the kernel stack page(s).
> + * If @addr is within the kernel stack, it returns true. If not, returns false.
> + */
> +static bool regs_within_kernel_stack(struct pt_regs *regs, unsigned long addr)
> +{
> +	return (addr & ~(THREAD_SIZE - 1))  ==
> +		(kernel_stack_pointer(regs) & ~(THREAD_SIZE - 1));
> +}
> +
> +/**
> + * regs_get_kernel_stack_nth() - get Nth entry of the stack
> + * @regs:	pt_regs which contains kernel stack pointer.
> + * @n:		stack entry number.
> + *
> + * regs_get_kernel_stack_nth() returns @n th entry of the kernel stack which
> + * is specified by @regs. If the @n th entry is NOT in the kernel stack,
> + * this returns 0.
> + */
> +unsigned long regs_get_kernel_stack_nth(struct pt_regs *regs, unsigned int n)
> +{
> +	unsigned long *addr = (unsigned long *)kernel_stack_pointer(regs);
> +
> +	addr += n;
> +	if (regs_within_kernel_stack(regs, (unsigned long)addr))
> +		return *addr;
> +	else
> +		return 0;
> +}
> +
>  void ptrace_disable(struct task_struct *child)
>  {
>  	clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);

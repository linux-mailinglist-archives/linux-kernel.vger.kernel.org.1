Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2474C2B9357
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 14:13:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbgKSNLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 08:11:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:34926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726619AbgKSNLY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 08:11:24 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF46B2222A;
        Thu, 19 Nov 2020 13:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605791483;
        bh=/KbjlQN64UwwsBKLJGp7YbJpfr+lizBmUjbVusfK52Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JJVH/sy7423W9dqkPvTZEVsy/PRgJ17r7frby8ETqqQShHZuv9lHM9mOoLa6nn/sd
         xusHAca+4bI/APIeQI/D/U8zBZSMeEFLo4HQO2yhd+z5Ogu04pvUuA6fZVjQXQg5Bz
         arOa0T7fMjHGcSlNKqCOgElT8e7lHqu0iz/zRD8o=
Date:   Thu, 19 Nov 2020 13:11:18 +0000
From:   Will Deacon <will@kernel.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: scs: use vmapped IRQ and SDEI shadow stacks
Message-ID: <20201119131118.GB4331@willie-the-truck>
References: <20201022202355.3529836-1-samitolvanen@google.com>
 <20201022202355.3529836-3-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201022202355.3529836-3-samitolvanen@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 22, 2020 at 01:23:55PM -0700, Sami Tolvanen wrote:
> Use scs_alloc() to allocate also IRQ and SDEI shadow stacks instead of
> using statically allocated stacks.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> ---
>  arch/arm64/include/asm/scs.h | 21 ++++++++++-
>  arch/arm64/kernel/entry.S    |  6 ++--
>  arch/arm64/kernel/irq.c      |  2 ++
>  arch/arm64/kernel/scs.c      | 67 +++++++++++++++++++++++++++++++++---
>  arch/arm64/kernel/sdei.c     |  7 ++++
>  include/linux/scs.h          |  8 ++---
>  kernel/scs.c                 |  4 +--
>  7 files changed, 101 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/scs.h b/arch/arm64/include/asm/scs.h
> index eaa2cd92e4c1..e9d2c3e67ff9 100644
> --- a/arch/arm64/include/asm/scs.h
> +++ b/arch/arm64/include/asm/scs.h
> @@ -24,6 +24,25 @@
>  	.endm
>  #endif /* CONFIG_SHADOW_CALL_STACK */
>  
> -#endif /* __ASSEMBLY __ */
> +#else /* __ASSEMBLY__ */
> +
> +#include <linux/scs.h>
> +
> +#ifdef CONFIG_SHADOW_CALL_STACK
> +
> +extern void scs_init_irq(void);
> +
> +extern void scs_free_sdei(void);

This is only called on the scs_init_sdei() failure path, so it can be
static. But see below, because I think we should move all of these functions
out of scs.c anyway.

> diff --git a/arch/arm64/kernel/irq.c b/arch/arm64/kernel/irq.c
> index 9cf2fb87584a..54ba3725bc0e 100644
> --- a/arch/arm64/kernel/irq.c
> +++ b/arch/arm64/kernel/irq.c
> @@ -20,6 +20,7 @@
>  #include <linux/seq_file.h>
>  #include <linux/vmalloc.h>
>  #include <asm/daifflags.h>
> +#include <asm/scs.h>
>  #include <asm/vmap_stack.h>
>  
>  /* Only access this in an NMI enter/exit */
> @@ -54,6 +55,7 @@ static void init_irq_stacks(void)
>  void __init init_IRQ(void)
>  {
>  	init_irq_stacks();
> +	scs_init_irq();

If we internalise this in init_irq_stacks()...

> diff --git a/arch/arm64/kernel/sdei.c b/arch/arm64/kernel/sdei.c
> index 7689f2031c0c..04519a7cb51d 100644
> --- a/arch/arm64/kernel/sdei.c
> +++ b/arch/arm64/kernel/sdei.c
> @@ -13,6 +13,7 @@
>  #include <asm/kprobes.h>
>  #include <asm/mmu.h>
>  #include <asm/ptrace.h>
> +#include <asm/scs.h>
>  #include <asm/sections.h>
>  #include <asm/stacktrace.h>
>  #include <asm/sysreg.h>
> @@ -138,6 +139,12 @@ unsigned long sdei_arch_get_entry_point(int conduit)
>  			return 0;
>  	}
>  
> +	if (scs_init_sdei()) {

... and this in init_sdei_stacks(), then I think we remove all of the code
from arch/arm64/kernel/scs.c.

> diff --git a/include/linux/scs.h b/include/linux/scs.h
> index 86e3c4b7b714..6b35a83576d4 100644
> --- a/include/linux/scs.h
> +++ b/include/linux/scs.h
> @@ -21,13 +21,11 @@
>  /* An illegal pointer value to mark the end of the shadow stack. */
>  #define SCS_END_MAGIC		(0x5f6UL + POISON_POINTER_DELTA)
>  
> -/* Allocate a static per-CPU shadow stack */
> -#define DEFINE_SCS(name)						\
> -	DEFINE_PER_CPU(unsigned long [SCS_SIZE/sizeof(long)], name)	\
> -
>  #define task_scs(tsk)		(task_thread_info(tsk)->scs_base)
>  #define task_scs_sp(tsk)	(task_thread_info(tsk)->scs_sp)
>  
> +void *scs_alloc(int node);
> +void scs_free(void *s);
>  void scs_init(void);
>  int scs_prepare(struct task_struct *tsk, int node);
>  void scs_release(struct task_struct *tsk);
> @@ -56,6 +54,8 @@ static inline bool task_scs_end_corrupted(struct task_struct *tsk)
>  
>  #else /* CONFIG_SHADOW_CALL_STACK */
>  
> +static inline void *scs_alloc(int node) { return NULL; }
> +static inline void scs_free(void *s) {}
>  static inline void scs_init(void) {}
>  static inline void scs_task_reset(struct task_struct *tsk) {}
>  static inline int scs_prepare(struct task_struct *tsk, int node) { return 0; }
> diff --git a/kernel/scs.c b/kernel/scs.c
> index 2136edba548d..8df4a92cd939 100644
> --- a/kernel/scs.c
> +++ b/kernel/scs.c
> @@ -24,7 +24,7 @@ static void __scs_account(void *s, int account)
>  #define NR_CACHED_SCS 2
>  static DEFINE_PER_CPU(void *, scs_cache[NR_CACHED_SCS]);
>  
> -static void *scs_alloc(int node)
> +void *scs_alloc(int node)
>  {
>  	int i;
>  	void *s;
> @@ -63,7 +63,7 @@ static void *scs_alloc(int node)
>  	return s;
>  }
>  
> -static void scs_free(void *s)
> +void scs_free(void *s)

Should be part of the first patch?

Will

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 082C6278563
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 12:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbgIYKtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 06:49:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:58354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727132AbgIYKtj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 06:49:39 -0400
Received: from gaia (unknown [31.124.44.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5020421D91;
        Fri, 25 Sep 2020 10:49:36 +0000 (UTC)
Date:   Fri, 25 Sep 2020 11:49:33 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        kasan-dev@googlegroups.com,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 26/39] arm64: mte: Add in-kernel tag fault handler
Message-ID: <20200925104933.GD4846@gaia>
References: <cover.1600987622.git.andreyknvl@google.com>
 <17ec8af55dc0a4d3ade679feb0858f0df4c80d27.1600987622.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17ec8af55dc0a4d3ade679feb0858f0df4c80d27.1600987622.git.andreyknvl@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25, 2020 at 12:50:33AM +0200, Andrey Konovalov wrote:
> diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
> index 991dd5f031e4..c7fff8daf2a7 100644
> --- a/arch/arm64/include/asm/uaccess.h
> +++ b/arch/arm64/include/asm/uaccess.h
> @@ -200,13 +200,36 @@ do {									\
>  				CONFIG_ARM64_PAN));			\
>  } while (0)
>  
> +/*
> + * The Tag Check Flag (TCF) mode for MTE is per EL, hence TCF0
> + * affects EL0 and TCF affects EL1 irrespective of which TTBR is
> + * used.
> + * The kernel accesses TTBR0 usually with LDTR/STTR instructions
> + * when UAO is available, so these would act as EL0 accesses using
> + * TCF0.
> + * However futex.h code uses exclusives which would be executed as
> + * EL1, this can potentially cause a tag check fault even if the
> + * user disables TCF0.
> + *
> + * To address the problem we set the PSTATE.TCO bit in uaccess_enable()
> + * and reset it in uaccess_disable().
> + *
> + * The Tag check override (TCO) bit disables temporarily the tag checking
> + * preventing the issue.
> + */
>  static inline void uaccess_disable(void)
>  {
> +	asm volatile(ALTERNATIVE("nop", SET_PSTATE_TCO(0),
> +				 ARM64_MTE, CONFIG_KASAN_HW_TAGS));
> +
>  	__uaccess_disable(ARM64_HAS_PAN);
>  }
>  
>  static inline void uaccess_enable(void)
>  {
> +	asm volatile(ALTERNATIVE("nop", SET_PSTATE_TCO(1),
> +				 ARM64_MTE, CONFIG_KASAN_HW_TAGS));
> +
>  	__uaccess_enable(ARM64_HAS_PAN);
>  }

This look fine.

> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> index a3bd189602df..d110f382dacf 100644
> --- a/arch/arm64/mm/fault.c
> +++ b/arch/arm64/mm/fault.c
> @@ -33,6 +33,7 @@
>  #include <asm/debug-monitors.h>
>  #include <asm/esr.h>
>  #include <asm/kprobes.h>
> +#include <asm/mte.h>
>  #include <asm/processor.h>
>  #include <asm/sysreg.h>
>  #include <asm/system_misc.h>
> @@ -294,6 +295,11 @@ static void die_kernel_fault(const char *msg, unsigned long addr,
>  	do_exit(SIGKILL);
>  }
>  
> +static void report_tag_fault(unsigned long addr, unsigned int esr,
> +			     struct pt_regs *regs)
> +{
> +}

Do we need to introduce report_tag_fault() in this patch? It's fine but
add a note in the commit log that it will be populated in a subsequent
patch.

> +
>  static void __do_kernel_fault(unsigned long addr, unsigned int esr,
>  			      struct pt_regs *regs)
>  {
> @@ -641,10 +647,40 @@ static int do_sea(unsigned long addr, unsigned int esr, struct pt_regs *regs)
>  	return 0;
>  }
>  
> +static void do_tag_recovery(unsigned long addr, unsigned int esr,
> +			   struct pt_regs *regs)
> +{
> +	static bool reported = false;
> +
> +	if (!READ_ONCE(reported)) {
> +		report_tag_fault(addr, esr, regs);
> +		WRITE_ONCE(reported, true);
> +	}

I don't mind the READ_ONCE/WRITE_ONCE here but not sure what they help
with.

-- 
Catalin

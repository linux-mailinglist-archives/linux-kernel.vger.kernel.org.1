Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C29212A0A31
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 16:47:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbgJ3Prz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 11:47:55 -0400
Received: from foss.arm.com ([217.140.110.172]:38052 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726384AbgJ3Prz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 11:47:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 70122139F;
        Fri, 30 Oct 2020 08:47:54 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.53.28])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 164E83F719;
        Fri, 30 Oct 2020 08:47:47 -0700 (PDT)
Date:   Fri, 30 Oct 2020 15:47:45 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Marco Elver <elver@google.com>
Cc:     akpm@linux-foundation.org, glider@google.com, hpa@zytor.com,
        paulmck@kernel.org, andreyknvl@google.com, aryabinin@virtuozzo.com,
        luto@kernel.org, bp@alien8.de, catalin.marinas@arm.com,
        cl@linux.com, dave.hansen@linux.intel.com, rientjes@google.com,
        dvyukov@google.com, edumazet@google.com,
        gregkh@linuxfoundation.org, hdanton@sina.com, mingo@redhat.com,
        jannh@google.com, Jonathan.Cameron@huawei.com, corbet@lwn.net,
        iamjoonsoo.kim@lge.com, joern@purestorage.com,
        keescook@chromium.org, penberg@kernel.org, peterz@infradead.org,
        sjpark@amazon.com, tglx@linutronix.de, vbabka@suse.cz,
        will@kernel.org, x86@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org
Subject: Re: [PATCH v6 3/9] arm64, kfence: enable KFENCE for ARM64
Message-ID: <20201030154745.GD50718@C02TD0UTHF1T.local>
References: <20201029131649.182037-1-elver@google.com>
 <20201029131649.182037-4-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201029131649.182037-4-elver@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 02:16:43PM +0100, Marco Elver wrote:
> Add architecture specific implementation details for KFENCE and enable
> KFENCE for the arm64 architecture. In particular, this implements the
> required interface in <asm/kfence.h>.
> 
> KFENCE requires that attributes for pages from its memory pool can
> individually be set. Therefore, force the entire linear map to be mapped
> at page granularity. Doing so may result in extra memory allocated for
> page tables in case rodata=full is not set; however, currently
> CONFIG_RODATA_FULL_DEFAULT_ENABLED=y is the default, and the common case
> is therefore not affected by this change.
> 
> Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
> Co-developed-by: Alexander Potapenko <glider@google.com>
> Signed-off-by: Alexander Potapenko <glider@google.com>
> Signed-off-by: Marco Elver <elver@google.com>
> ---
> v5:
> * Move generic page allocation code to core.c [suggested by Jann Horn].
> * Remove comment about HAVE_ARCH_KFENCE_STATIC_POOL, since we no longer
>   support static pools.
> * Force page granularity for the linear map [suggested by Mark Rutland].
> ---
>  arch/arm64/Kconfig              |  1 +
>  arch/arm64/include/asm/kfence.h | 19 +++++++++++++++++++
>  arch/arm64/mm/fault.c           |  4 ++++
>  arch/arm64/mm/mmu.c             |  7 ++++++-
>  4 files changed, 30 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm64/include/asm/kfence.h
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index f858c352f72a..2f8b32dddd8b 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -135,6 +135,7 @@ config ARM64
>  	select HAVE_ARCH_JUMP_LABEL_RELATIVE
>  	select HAVE_ARCH_KASAN if !(ARM64_16K_PAGES && ARM64_VA_BITS_48)
>  	select HAVE_ARCH_KASAN_SW_TAGS if HAVE_ARCH_KASAN
> +	select HAVE_ARCH_KFENCE if (!ARM64_16K_PAGES && !ARM64_64K_PAGES)

Why does this depend on the page size?

If this is functional, but has a larger overhead on 16K or 64K, I'd
suggest removing the dependency, and just updating the Kconfig help text
to explain that.

Otherwise, this patch looks fine to me.

Thanks,
Mark.

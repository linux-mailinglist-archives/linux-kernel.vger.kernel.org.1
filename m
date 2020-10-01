Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2964280608
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 19:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732999AbgJAR52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 13:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732751AbgJAR51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 13:57:27 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DFDBC0613D0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 10:57:27 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id z1so6843150wrt.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 10:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NrXP5K1QAOK1ooEoF09QcxyxzBvczwzY+6+OVR8Sv6k=;
        b=Ftzp9vYtlhuwTGkJFwqeer6Kks0+qgmyYK49BtNL7KyMB9YkFWpVM6yahd0J1rg15V
         WXlVOUzDt+6rGijpoHCmHgs8o6/BFrebhcVdjNfx1uy/FuLZDzAJmVth+3Q9q9/NKLcs
         2o0VNhJ//vitVKO82CY+yEJqkRSlnkCRxvpi2eTJmR3LPeWY60/vBVbemMiA2I5bspGA
         co8GVGvsbDSV/Zs7fOXOJFfgqEJShfhZDC4O/BOFu2wdr57c4LXtf+/gfkLcYRDkFEnD
         sNIwohgX6++pWxRVapKSyiblekRbahtYyEFwkXYLF2HQI8q5a+5h7SKIRsBcPsdb0yzS
         paMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NrXP5K1QAOK1ooEoF09QcxyxzBvczwzY+6+OVR8Sv6k=;
        b=Xf1H+HDkyhgIEZKRwxj60tJ972VZELVS8wGdo6zK6AGjs8k9RbItMi67TB+ywyKNFb
         YBjIQE734MfBNCPd7qw6ja+mzwJRuRct+Na4n31Bmh2zLrctvuQ1EmS9qulx1qYOvufI
         J0am1m6fchmBoya4SrJfUd8MoAUPkgpnx4wwUWt6w8k7P/oB/2M+cimta++ZMMlWIOz7
         A/8vUiA/82K/Jv5pu1Z7HrIUWU9AI2PLspLD/2uSmJjnrU9VJ3kx8mPMVvSr+JRGSuAv
         N0jmuu+yPubpeENZXO3IRJLx7sCSWESZNqDvld0Ge9RQkPcxC6P7qLkWkRo//ee72HZP
         ZFHw==
X-Gm-Message-State: AOAM530ouOQY4QHMS39r16LcZMQIJR6ghsMV809mJqmeDzkOgadPSdOe
        5nk+WuwgA1FoDuorCITEPw+7zQ==
X-Google-Smtp-Source: ABdhPJwGZNOXk9mj0Pqo41aou7Hqb8qY43tJa83Ff/NYunQpvUmCCWMBZx1ty7TKXBr/EJGK8M1KSA==
X-Received: by 2002:adf:dd82:: with SMTP id x2mr10956498wrl.419.1601575045792;
        Thu, 01 Oct 2020 10:57:25 -0700 (PDT)
Received: from elver.google.com ([100.105.32.75])
        by smtp.gmail.com with ESMTPSA id j10sm10054494wrn.2.2020.10.01.10.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 10:57:25 -0700 (PDT)
Date:   Thu, 1 Oct 2020 19:57:19 +0200
From:   elver@google.com
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        kasan-dev@googlegroups.com,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 22/39] kasan: introduce CONFIG_KASAN_HW_TAGS
Message-ID: <20201001175719.GR4162920@elver.google.com>
References: <cover.1600987622.git.andreyknvl@google.com>
 <76937ee6e88d0d1fc98003e503f31fe7b14a6a52.1600987622.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76937ee6e88d0d1fc98003e503f31fe7b14a6a52.1600987622.git.andreyknvl@google.com>
User-Agent: Mutt/1.14.5 (2020-06-23)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25, 2020 at 12:50AM +0200, Andrey Konovalov wrote:
> This patch adds a configuration option for a new KASAN mode called
> hardware tag-based KASAN. This mode uses the memory tagging approach
> like the software tag-based mode, but relies on arm64 Memory Tagging
> Extension feature for tag management and access checking.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

Reviewed-by: Marco Elver <elver@google.com>

> ---
> Change-Id: I246c2def9fffa6563278db1bddfbe742ca7bdefe
> ---
>  lib/Kconfig.kasan | 59 ++++++++++++++++++++++++++++++++---------------
>  1 file changed, 41 insertions(+), 18 deletions(-)
> 
> diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
> index b4cf6c519d71..516d3a24f7d7 100644
> --- a/lib/Kconfig.kasan
> +++ b/lib/Kconfig.kasan
> @@ -6,7 +6,10 @@ config HAVE_ARCH_KASAN
>  config HAVE_ARCH_KASAN_SW_TAGS
>  	bool
>  
> -config	HAVE_ARCH_KASAN_VMALLOC
> +config HAVE_ARCH_KASAN_HW_TAGS
> +	bool
> +
> +config HAVE_ARCH_KASAN_VMALLOC
>  	bool
>  
>  config CC_HAS_KASAN_GENERIC
> @@ -20,11 +23,11 @@ config CC_HAS_WORKING_NOSANITIZE_ADDRESS
>  
>  menuconfig KASAN
>  	bool "KASAN: runtime memory debugger"
> -	depends on (HAVE_ARCH_KASAN && CC_HAS_KASAN_GENERIC) || \
> -		   (HAVE_ARCH_KASAN_SW_TAGS && CC_HAS_KASAN_SW_TAGS)
> +	depends on (((HAVE_ARCH_KASAN && CC_HAS_KASAN_GENERIC) || \
> +		     (HAVE_ARCH_KASAN_SW_TAGS && CC_HAS_KASAN_SW_TAGS)) && \
> +		    CC_HAS_WORKING_NOSANITIZE_ADDRESS) || \
> +		   HAVE_ARCH_KASAN_HW_TAGS
>  	depends on (SLUB && SYSFS) || (SLAB && !DEBUG_SLAB)
> -	depends on CC_HAS_WORKING_NOSANITIZE_ADDRESS
> -	select SLUB_DEBUG if SLUB

See my comment in the other patch about moving this line again.

>  	select CONSTRUCTORS
>  	select STACKDEPOT
>  	help
> @@ -38,17 +41,23 @@ choice
>  	prompt "KASAN mode"
>  	default KASAN_GENERIC
>  	help
> -	  KASAN has two modes: generic KASAN (similar to userspace ASan,
> -	  x86_64/arm64/xtensa, enabled with CONFIG_KASAN_GENERIC) and
> -	  software tag-based KASAN (a version based on software memory
> -	  tagging, arm64 only, similar to userspace HWASan, enabled with
> -	  CONFIG_KASAN_SW_TAGS).
> +	  KASAN has three modes:
> +	  1. generic KASAN (similar to userspace ASan,
> +	     x86_64/arm64/xtensa, enabled with CONFIG_KASAN_GENERIC),
> +	  2. software tag-based KASAN (arm64 only, based on software
> +	     memory tagging (similar to userspace HWASan), enabled with
> +	     CONFIG_KASAN_SW_TAGS), and
> +	  3. hardware tag-based KASAN (arm64 only, based on hardware
> +	     memory tagging, enabled with CONFIG_KASAN_HW_TAGS).
> +
> +	  All KASAN modes are strictly debugging features.
>  
> -	  Both generic and tag-based KASAN are strictly debugging features.
> +	  For better error reports enable CONFIG_STACKTRACE.
>  
>  config KASAN_GENERIC
>  	bool "Generic mode"
>  	depends on HAVE_ARCH_KASAN && CC_HAS_KASAN_GENERIC
> +	select SLUB_DEBUG if SLUB
>  	help
>  	  Enables generic KASAN mode.
>  
> @@ -61,20 +70,21 @@ config KASAN_GENERIC
>  	  and introduces an overhead of ~x1.5 for the rest of the allocations.
>  	  The performance slowdown is ~x3.
>  
> -	  For better error detection enable CONFIG_STACKTRACE.
> -
>  	  Currently CONFIG_KASAN_GENERIC doesn't work with CONFIG_DEBUG_SLAB
>  	  (the resulting kernel does not boot).
>  
>  config KASAN_SW_TAGS
>  	bool "Software tag-based mode"
>  	depends on HAVE_ARCH_KASAN_SW_TAGS && CC_HAS_KASAN_SW_TAGS
> +	select SLUB_DEBUG if SLUB
>  	help
>  	  Enables software tag-based KASAN mode.
>  
> -	  This mode requires Top Byte Ignore support by the CPU and therefore
> -	  is only supported for arm64. This mode requires Clang version 7.0.0
> -	  or later.
> +	  This mode require software memory tagging support in the form of
> +	  HWASan-like compiler instrumentation.
> +
> +	  Currently this mode is only implemented for arm64 CPUs and relies on
> +	  Top Byte Ignore. This mode requires Clang version 7.0.0 or later.
>  
>  	  This mode consumes about 1/16th of available memory at kernel start
>  	  and introduces an overhead of ~20% for the rest of the allocations.
> @@ -82,15 +92,27 @@ config KASAN_SW_TAGS
>  	  casting and comparison, as it embeds tags into the top byte of each
>  	  pointer.
>  
> -	  For better error detection enable CONFIG_STACKTRACE.
> -
>  	  Currently CONFIG_KASAN_SW_TAGS doesn't work with CONFIG_DEBUG_SLAB
>  	  (the resulting kernel does not boot).
>  
> +config KASAN_HW_TAGS
> +	bool "Hardware tag-based mode"
> +	depends on HAVE_ARCH_KASAN_HW_TAGS
> +	depends on SLUB
> +	help
> +	  Enables hardware tag-based KASAN mode.
> +
> +	  This mode requires hardware memory tagging support, and can be used
> +	  by any architecture that provides it.
> +
> +	  Currently this mode is only implemented for arm64 CPUs starting from
> +	  ARMv8.5 and relies on Memory Tagging Extension and Top Byte Ignore.
> +
>  endchoice
>  
>  choice
>  	prompt "Instrumentation type"
> +	depends on KASAN_GENERIC || KASAN_SW_TAGS
>  	default KASAN_OUTLINE
>  
>  config KASAN_OUTLINE
> @@ -114,6 +136,7 @@ endchoice
>  
>  config KASAN_STACK_ENABLE
>  	bool "Enable stack instrumentation (unsafe)" if CC_IS_CLANG && !COMPILE_TEST
> +	depends on KASAN_GENERIC || KASAN_SW_TAGS
>  	help
>  	  The LLVM stack address sanitizer has a know problem that
>  	  causes excessive stack usage in a lot of functions, see
> -- 
> 2.28.0.681.g6f77f65b4e-goog
> 

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5382AF61E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 17:21:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbgKKQVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 11:21:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbgKKQU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 11:20:59 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E7ECC0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 08:20:59 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id s8so3059738wrw.10
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 08:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=h04pzBWTT3/7lLb3bXzNbuLnpXPPVyksc65veB41bHc=;
        b=OU4m2N6jkD06QsJEXoNnGq0wTIDtVx0xAr8Tn48tUcHrNQ6oZMQaIXgV0aTQyhQ/s/
         hcx4mzotI1Ij0H53R2Kl0kdmmhSObzVIgQXnbSrByJEBQoWiRtFNrvhX8Zw/FvEcyGLh
         0O6nYFqBiJtIeVc+jpxx/qWGlAjdDIgvXUDMoEQiu0SItxmPIkmVO/eFAbEEiZLwbQ4b
         JNnDO3Zm80rL9yOcl6JmyZ1iGaex18g0qBLsIbXw3fk8HVFjyNJ/lihVXuf4j8+1Eq8I
         jiVMONhB80oBkc6GeNwWahRtHmooRA420R2IvNWUfErKxiCtR0q+qefshibDanhm6G38
         yH+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=h04pzBWTT3/7lLb3bXzNbuLnpXPPVyksc65veB41bHc=;
        b=ftUACVgCwbQ85rWSTCWq6sWZbEKjrJOSHweRj26mtrtlxBodYRhqzw0ISDCq3hf0uk
         nZR4+870j/qg0e3Co/UdBxDVq0pxKYmCxj5u6F7pkvCN/Kt88detaXFrzWZJo/CUMJXp
         mSYVJtqkqPRDYRThnkI7UJuNNvpohHChyWI2khduQo9HLv/LcOqkVVhP2WM3nIvfD0b/
         Dwa9NYKkt66jqSm9h6OFHyUisT5NxrO/VenYWy6lkJeTPqM22+exiKya9G+I8XceDIWp
         mR8EYZFgp0rSedLmRnZVBQc1L/7vn6LAoAe4RgiB79YcpY6fazCV+ra/qhIAOybsIS+4
         arnA==
X-Gm-Message-State: AOAM5320qSr0dG96k+vlpSbNsfTlNWNN7zEt2KeIU9U5O8tM3f0JIqYa
        tU+AYGgW0AT4v+SfWjHeOnl6nA==
X-Google-Smtp-Source: ABdhPJxxlFWci8j3QfAeiJZTWzJ9B8pX9QXgXgNEi+Jmxe1zXm9nOMW05oMxWDt7zaDOuJjiX9bynA==
X-Received: by 2002:a05:6000:364:: with SMTP id f4mr3136596wrf.290.1605111658027;
        Wed, 11 Nov 2020 08:20:58 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:f693:9fff:fef4:2449])
        by smtp.gmail.com with ESMTPSA id e5sm1926733wrs.84.2020.11.11.08.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 08:20:57 -0800 (PST)
Date:   Wed, 11 Nov 2020 17:20:51 +0100
From:   Marco Elver <elver@google.com>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 05/20] kasan: allow VMAP_STACK for HW_TAGS mode
Message-ID: <20201111162051.GG517454@elver.google.com>
References: <cover.1605046662.git.andreyknvl@google.com>
 <3443e106c40799e5dc3981dec2011379f3cbbb0c.1605046662.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3443e106c40799e5dc3981dec2011379f3cbbb0c.1605046662.git.andreyknvl@google.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 11:20PM +0100, Andrey Konovalov wrote:
> Even though hardware tag-based mode currently doesn't support checking
> vmalloc allocations, it doesn't use shadow memory and works with
> VMAP_STACK as is. Change VMAP_STACK definition accordingly.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Link: https://linux-review.googlesource.com/id/I3552cbc12321dec82cd7372676e9372a2eb452ac
> ---

Shouldn't this be in the other series?

FWIW,

Reviewed-by: Marco Elver <elver@google.com>

>  arch/Kconfig | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 56b6ccc0e32d..7e7d14fae568 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -914,16 +914,16 @@ config VMAP_STACK
>  	default y
>  	bool "Use a virtually-mapped stack"
>  	depends on HAVE_ARCH_VMAP_STACK
> -	depends on !KASAN || KASAN_VMALLOC
> +	depends on !KASAN || KASAN_HW_TAGS || KASAN_VMALLOC
>  	help
>  	  Enable this if you want the use virtually-mapped kernel stacks
>  	  with guard pages.  This causes kernel stack overflows to be
>  	  caught immediately rather than causing difficult-to-diagnose
>  	  corruption.
>  
> -	  To use this with KASAN, the architecture must support backing
> -	  virtual mappings with real shadow memory, and KASAN_VMALLOC must
> -	  be enabled.
> +	  To use this with software KASAN modes, the architecture must support
> +	  backing virtual mappings with real shadow memory, and KASAN_VMALLOC
> +	  must be enabled.
>  
>  config ARCH_OPTIONAL_KERNEL_RWX
>  	def_bool n
> -- 
> 2.29.2.222.g5d2a92d10f8-goog
> 

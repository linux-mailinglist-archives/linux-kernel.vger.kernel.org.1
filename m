Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE87E28059A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 19:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732920AbgJARjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 13:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732096AbgJARjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 13:39:54 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D3A5C0613D0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 10:39:54 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id e16so6791950wrm.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 10:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7216dcRRE3Wn/EM/apMUAUVbD6PsUdlPnAr0Igr7XOw=;
        b=ptyqzr5KlaqwXGCWxthcuEXOqWrP87iiVAPL53D3y6ROp4TSs/wZ78d9mRg7iQLTJx
         6UeLl1ARtrStVJglbLLkIMWz/LNq+uHsiqrgXo0L80r6jfucTEmW5ib6fGkNVF4DTG6w
         hXv+8awczmTdAvLTgmWg7wIMkdOI3vPiyF8C1kzIddtqx/n0yp/gHjrTDjweG05vpfol
         ddjCbjuniqlDqPv3Sm92UqyGncDUAIT2+Qe6rfG9DByFQCnodOC22MMqTfJ60CXQgh+r
         JQ98cfavwZAELBnvwIbaQN2Xj/EOzXLAz7hazRs4KHapIezwYD7g/MJTof55xYdJTGz0
         P6xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7216dcRRE3Wn/EM/apMUAUVbD6PsUdlPnAr0Igr7XOw=;
        b=GvQ7GqQEq2nv6Vr0a7nSVZIk5zdG5WG/oKqnzLcFrrlq6GBQRaFD/N1/cFZdCWAqTh
         VthLX2xOsZj39fZYzkgKvyUn4S1VdpKHocjcS3TlE9kYebqjXTARKAaF9f25qFD5GZou
         t83ApNUssnhDeh97+jSl9YPMb86ItS/FVXobOy9frUTcYCwtZ6G/bhdLr78gjAXrw15W
         N+Roz4mgUR3CokzBeRKIPyjeNK1y80lWi6JV1OIrmWqeR/SbN86DG416atoEk0UsWqt9
         Wuf/CnR3fiOmsPkPBHYCk71UyfGetTPsbOj2NqBmgGx395t+Mpd+6HK7zyG1xz9h9oo1
         ygRw==
X-Gm-Message-State: AOAM5326T+32ynj17DFC9Ao39XdzEseoGIOGOhfF9OrhXb/ekUlU4JNq
        6nn4+mXkg+uzCavxe+uHSjXZkg==
X-Google-Smtp-Source: ABdhPJzJbvJMOEyc/fQ30bJrPNU6qkZ+WL5VMh3wle0oInfm6VZiuVKwbb5VAADZcWx+eKbi219y+w==
X-Received: by 2002:a5d:4151:: with SMTP id c17mr11009569wrq.302.1601573992713;
        Thu, 01 Oct 2020 10:39:52 -0700 (PDT)
Received: from elver.google.com ([100.105.32.75])
        by smtp.gmail.com with ESMTPSA id y14sm854478wma.48.2020.10.01.10.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 10:39:51 -0700 (PDT)
Date:   Thu, 1 Oct 2020 19:39:45 +0200
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
Subject: Re: [PATCH v3 11/39] kasan: don't duplicate config dependencies
Message-ID: <20201001173945.GI4162920@elver.google.com>
References: <cover.1600987622.git.andreyknvl@google.com>
 <728981bdedbca9dc1e4cca853699b6a6e8f244e0.1600987622.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <728981bdedbca9dc1e4cca853699b6a6e8f244e0.1600987622.git.andreyknvl@google.com>
User-Agent: Mutt/1.14.5 (2020-06-23)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25, 2020 at 12:50AM +0200, Andrey Konovalov wrote:
> Both KASAN_GENERIC and KASAN_SW_TAGS have common dependencies, move
> those to KASAN.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

Reviewed-by: Marco Elver <elver@google.com>

But see comment below:

> ---
> Change-Id: I77e475802e8f1750b9154fe4a6e6da4456054fcd
> ---
>  lib/Kconfig.kasan | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
> index e1d55331b618..b4cf6c519d71 100644
> --- a/lib/Kconfig.kasan
> +++ b/lib/Kconfig.kasan
> @@ -24,6 +24,9 @@ menuconfig KASAN
>  		   (HAVE_ARCH_KASAN_SW_TAGS && CC_HAS_KASAN_SW_TAGS)
>  	depends on (SLUB && SYSFS) || (SLAB && !DEBUG_SLAB)
>  	depends on CC_HAS_WORKING_NOSANITIZE_ADDRESS
> +	select SLUB_DEBUG if SLUB
> +	select CONSTRUCTORS
> +	select STACKDEPOT

In the later patch your move 'select SLUB_DEBUG' back to where they were
here it seems. The end result is the same, so I leave it to you if you
want to change it.

>  	help
>  	  Enables KASAN (KernelAddressSANitizer) - runtime memory debugger,
>  	  designed to find out-of-bounds accesses and use-after-free bugs.
> @@ -46,10 +49,6 @@ choice
>  config KASAN_GENERIC
>  	bool "Generic mode"
>  	depends on HAVE_ARCH_KASAN && CC_HAS_KASAN_GENERIC
> -	depends on (SLUB && SYSFS) || (SLAB && !DEBUG_SLAB)
> -	select SLUB_DEBUG if SLUB
> -	select CONSTRUCTORS
> -	select STACKDEPOT
>  	help
>  	  Enables generic KASAN mode.
>  
> @@ -70,10 +69,6 @@ config KASAN_GENERIC
>  config KASAN_SW_TAGS
>  	bool "Software tag-based mode"
>  	depends on HAVE_ARCH_KASAN_SW_TAGS && CC_HAS_KASAN_SW_TAGS
> -	depends on (SLUB && SYSFS) || (SLAB && !DEBUG_SLAB)
> -	select SLUB_DEBUG if SLUB
> -	select CONSTRUCTORS
> -	select STACKDEPOT
>  	help
>  	  Enables software tag-based KASAN mode.
>  
> -- 
> 2.28.0.681.g6f77f65b4e-goog
> 

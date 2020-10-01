Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67A15280601
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 19:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732991AbgJARzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 13:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732360AbgJARzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 13:55:47 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C747C0613D0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 10:55:47 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id j136so2781122wmj.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 10:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wXf2yDw1ZzKJ0lA2O+mYUFWQ3CJsg8/AyQ/IRMAajuk=;
        b=RBM4/RCc9JQJqoKl7RS0gHMrz6o2WGkgWjIYD22wM9haJCNIdRsAipIlXcp6sIbd3J
         7LGM5NvkMNSLScthwxqoZ7SnWfnHf44jUuL9PO34KkN20ZpU74CIdCfXdg2YY+uNKuFJ
         FALdUCfqWGwxGw52ODzhqD0st9RUmtuf1NbBd3ts14IgD7RBJpySsdv/3j4nxdLpgMvH
         9Zq+UJH+mVak0V1mwxGKXbXRa+u3s8gWSyReT2cWgPe9ZRxBwTon+acblHY+DrNcsUUo
         +cfvYmPsudbfJHe3em+O9CZVjnoxDjJi+zBJEITnwDHa7PLfCwzZ/kPX46F2ChPhLa8m
         xW4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wXf2yDw1ZzKJ0lA2O+mYUFWQ3CJsg8/AyQ/IRMAajuk=;
        b=BkBVvZ67TGOsRx66hS3f08FdbWVgI6XxAQyNhsF6ZqGADOB/nKapWLXfUdlYbuLTdQ
         xEQsxFqSHdWpTQaxyGzNmPkk4d7g4SWKZo7KQosnyTWjHrt2WFfNYC+TwJgsb25GWwCi
         vq2sX/R76/4NOEfN1mztM104Q3140qPq8d+hrKVO9G3gSpwCs3DYq5BR7kIX9sHVv5RF
         ZFfUDIFeN2+KxWQ8UiJPM8vHU0nRA0DsyDQXfsenpmxLJmO/pAUu7fYd6SFP0Ri4maxQ
         IDSVXNnE2jWN+c2Y9xxuYwzTK+yGw5f2SgXdmFlbEuaygxqIPzlfhIrbHGbyuW6rGj1Y
         bhJw==
X-Gm-Message-State: AOAM532Kr07mqv+uek4NdPhPsX6bjunbX6M3f0rYrEbRALHvl7A/L1T3
        VJreGB3eY6QBz6mkCrwp95Mp/A==
X-Google-Smtp-Source: ABdhPJzhCzAazXBZOMXz9D2H1FXg567NC2no+Tp5u7I1HOPVIW6DuCibV3E0GIvAkEa700+2fWLxIA==
X-Received: by 2002:a05:600c:216:: with SMTP id 22mr1100906wmi.149.1601574946075;
        Thu, 01 Oct 2020 10:55:46 -0700 (PDT)
Received: from elver.google.com ([100.105.32.75])
        by smtp.gmail.com with ESMTPSA id m11sm1045183wmf.10.2020.10.01.10.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 10:55:45 -0700 (PDT)
Date:   Thu, 1 Oct 2020 19:55:39 +0200
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
Subject: Re: [PATCH v3 21/39] kasan: don't allow SW_TAGS with ARM64_MTE
Message-ID: <20201001175539.GQ4162920@elver.google.com>
References: <cover.1600987622.git.andreyknvl@google.com>
 <d00f21f69ba7cb4809e850cf322247d48dae75ce.1600987622.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d00f21f69ba7cb4809e850cf322247d48dae75ce.1600987622.git.andreyknvl@google.com>
User-Agent: Mutt/1.14.5 (2020-06-23)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Does that patch title need an ", arm64" in it, like the others?

On Fri, Sep 25, 2020 at 12:50AM +0200, Andrey Konovalov wrote:
> Software tag-based KASAN provides its own tag checking machinery that
> can conflict with MTE. Don't allow enabling software tag-based KASAN
> when MTE is enabled.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> ---
> Change-Id: Icd29bd0c6b1d3d7a0ee3d50c20490f404d34fc97
> ---
>  arch/arm64/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index e7450fbd0aa7..e875db8e1c86 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -131,7 +131,7 @@ config ARM64
>  	select HAVE_ARCH_JUMP_LABEL
>  	select HAVE_ARCH_JUMP_LABEL_RELATIVE
>  	select HAVE_ARCH_KASAN if !(ARM64_16K_PAGES && ARM64_VA_BITS_48)
> -	select HAVE_ARCH_KASAN_SW_TAGS if HAVE_ARCH_KASAN
> +	select HAVE_ARCH_KASAN_SW_TAGS if (HAVE_ARCH_KASAN && !ARM64_MTE)
>  	select HAVE_ARCH_KGDB
>  	select HAVE_ARCH_MMAP_RND_BITS
>  	select HAVE_ARCH_MMAP_RND_COMPAT_BITS if COMPAT
> -- 
> 2.28.0.681.g6f77f65b4e-goog
> 

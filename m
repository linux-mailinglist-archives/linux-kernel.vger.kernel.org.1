Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C81E32804FF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 19:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732861AbgJARTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 13:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732213AbgJARTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 13:19:37 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22247C0613D0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 10:19:37 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id g4so6721817wrs.5
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 10:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=841G/mTiLV3Ld9kFkAJj5hFI/sTrvUOlTE4BhfWwZTU=;
        b=gYcO3CjTcL78262zFp/LcACcoQr5ajLuUus56hT6ZoiWBH+WkzZTJ9xoW9Now/eI11
         nqnTfk9gMXirD/bOJjQa2EK/Wgsx8tMWZmxnoKwd4nPFjotTL3/Vbo3UXJhUz8DIQdhc
         TCQFkuT+dkM8x/EozremdPpueAJ0648JQMTICZT7LvHlkKKMmscwOHGByKwLVGtaaMVP
         EdhCfnWP0ThzZNiVLziqGewAU1bzPGIwWHom/uMNLMhJZEu5mNjMkfKWFonlV5tYpfrY
         IjAJ45W3jYdXecqUcAb/JbDl+u6OGQ6fz92MblhqqRXodjUS/z06We8z+1nJNQXEElIX
         C/fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=841G/mTiLV3Ld9kFkAJj5hFI/sTrvUOlTE4BhfWwZTU=;
        b=aubfmZKYe8hByCOsE2huixfzw0hqT/dLkv1VU9OqxPs6+IFO0FaZQCzD3E1E8jyVoB
         x3p5PcIfHBaBwQ6bDgdPoA1oSltUZYJt6royL7TXXJLKkQEGZ0oGYeqk/elHcYlSVebc
         JzhEVCSf6hgkGS2zl1HaBIxEe2pN5NWrQEMEj1sal2ABwNOqe/y/t3ataqWJoPK6/6we
         JUG8tmxGilHfsecoHB8nu5M25Pt6DIhEg4/BGS4yDxB+8DMSr6bKOQ6Cj1q+GlwglMuP
         s42Itdrq/OjsbINxx/mUQXRhYv7fbgFv/QnvlTHihcYOgXeZbYPa9oVMNB3NHQPWOHDb
         C+xg==
X-Gm-Message-State: AOAM532mfN/S6OURRQ2hMF4KJ0PO1PVFTLyxgDup5PT5htSiUjmfR7Pc
        FCfunS/qMnCZgMyv1or/02to9A==
X-Google-Smtp-Source: ABdhPJzSgZ4/iTARNaTrtpwUQiHNHSeUnlfyb3XTlzXdTKq9BC1X0COHiSoGkL6Edra4NbtsPX+FMg==
X-Received: by 2002:adf:f802:: with SMTP id s2mr9774230wrp.328.1601572775654;
        Thu, 01 Oct 2020 10:19:35 -0700 (PDT)
Received: from elver.google.com ([100.105.32.75])
        by smtp.gmail.com with ESMTPSA id v2sm951415wme.19.2020.10.01.10.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 10:19:34 -0700 (PDT)
Date:   Thu, 1 Oct 2020 19:19:28 +0200
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
Subject: Re: [PATCH v3 02/39] kasan: KASAN_VMALLOC depends on KASAN_GENERIC
Message-ID: <20201001171928.GB4156371@elver.google.com>
References: <cover.1600987622.git.andreyknvl@google.com>
 <bc98612aeb00e3ffad45a103fdbfa4fc383b3d0d.1600987622.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc98612aeb00e3ffad45a103fdbfa4fc383b3d0d.1600987622.git.andreyknvl@google.com>
User-Agent: Mutt/1.14.5 (2020-06-23)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25, 2020 at 12:50AM +0200, Andrey Konovalov wrote:
> Currently only generic KASAN mode supports vmalloc, reflect that
> in the config.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

Reviewed-by: Marco Elver <elver@google.com>

> ---
> Change-Id: I1889e5b3bed28cc5d607802fb6ae43ba461c0dc1
> ---
>  lib/Kconfig.kasan | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
> index 047b53dbfd58..e1d55331b618 100644
> --- a/lib/Kconfig.kasan
> +++ b/lib/Kconfig.kasan
> @@ -156,7 +156,7 @@ config KASAN_SW_TAGS_IDENTIFY
>  
>  config KASAN_VMALLOC
>  	bool "Back mappings in vmalloc space with real shadow memory"
> -	depends on HAVE_ARCH_KASAN_VMALLOC
> +	depends on KASAN_GENERIC && HAVE_ARCH_KASAN_VMALLOC
>  	help
>  	  By default, the shadow region for vmalloc space is the read-only
>  	  zero page. This means that KASAN cannot detect errors involving
> -- 
> 2.28.0.681.g6f77f65b4e-goog
> 

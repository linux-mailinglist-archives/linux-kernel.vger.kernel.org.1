Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ACE7280614
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 19:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733021AbgJAR73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 13:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732407AbgJAR73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 13:59:29 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB14C0613D0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 10:59:27 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id t17so4086590wmi.4
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 10:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TLkPGKpJtl4arwZwTjWF8S+it5AeziayXNp4OPYQ4v0=;
        b=L/shRT1pI/QwzoXVUw9bsnM765r2VeYplu8Wz+LYLwBElfLPKZJVaFADv+0FmuGoBe
         KC2gFqgy0VKtCKReeyzvMp1PYPy4RL3vRvAggOg+cOb81/zFkgM5VGHl/HgaJAn+t4Kh
         C8GeBwASqw9u4KtGb/4L6OReaEay0i2VgmNW90WpTWQlttYqXQ3OtlXAWq3y3Ftq5eM2
         L+/b48+fjZqFxvEUjEqSA86pX3bf8DRTvnOToc7eq9RynDTEYIxfrHldw7vzInvPiHqz
         WJX+WwvWGNe7qGrKRdTgHDPEIRZY0aarmOSR2tedXtqrGev3BIcIPcDAKQGon+BRR/+k
         sIUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TLkPGKpJtl4arwZwTjWF8S+it5AeziayXNp4OPYQ4v0=;
        b=XP4ErCzyx5ForPsFk5yAHJ+IXrwk0rsA9QunkOXnbycoRKyDOMRR0YLrBsaMZJDH0i
         Y+sv0zZKhKpBN51LiDK8yw1Lb46cj80wyDZxU/7v1fQ1xgNr34DpyatmflTKWmFK4H8V
         FqgfVXBUUQR/KXptu806j13drn4rU2z9Q403aIexGG21tVWLwPQ0MioWVIQd9MhwMMQb
         tuxi1aohjsNpRpBCDN1OpmFmP3csKVXYElQJy5ZIGsXyugJKkZw1VqYSdfEjuuE4w8ji
         fSkiW4t4tG2eapEpwDlFcM+MzIeuFMIVOOFMb4igQei0mtwhB9JE5hPB5E5AEbWOhCPU
         P6AQ==
X-Gm-Message-State: AOAM530oZHxp3VID0IlUu+j54V5C8g+Ax4mTBVNtXaONAXpAKU1+q+K4
        mIELDvFUm1frN9QXkMIYGWAlHQ==
X-Google-Smtp-Source: ABdhPJz5PgD6vTssc8V1Lrw9XSn1QOwDzDEYGKvfMkJVoJ4ADqVAmBh2/G9ztT6GoF615R4L6e5WpQ==
X-Received: by 2002:a7b:cf30:: with SMTP id m16mr1235811wmg.0.1601575165850;
        Thu, 01 Oct 2020 10:59:25 -0700 (PDT)
Received: from elver.google.com ([100.105.32.75])
        by smtp.gmail.com with ESMTPSA id d23sm965442wmb.6.2020.10.01.10.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 10:59:24 -0700 (PDT)
Date:   Thu, 1 Oct 2020 19:59:19 +0200
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
Subject: Re: [PATCH v3 33/39] kasan, x86, s390: update undef CONFIG_KASAN
Message-ID: <20201001175919.GT4162920@elver.google.com>
References: <cover.1600987622.git.andreyknvl@google.com>
 <78ebf3bed0458172fec9e1e32f2d29d7c8c37341.1600987622.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78ebf3bed0458172fec9e1e32f2d29d7c8c37341.1600987622.git.andreyknvl@google.com>
User-Agent: Mutt/1.14.5 (2020-06-23)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25, 2020 at 12:50AM +0200, Andrey Konovalov wrote:
> With the intoduction of hardware tag-based KASAN some kernel checks of
> this kind:
> 
>   ifdef CONFIG_KASAN
> 
> will be updated to:
> 
>   if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
> 
> x86 and s390 use a trick to #undef CONFIG_KASAN for some of the code
> that isn't linked with KASAN runtime and shouldn't have any KASAN
> annotations.
> 
> Also #undef CONFIG_KASAN_GENERIC with CONFIG_KASAN.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

Reviewed-by: Marco Elver <elver@google.com>

> ---
> Change-Id: I2a622db0cb86a8feb60c30d8cb09190075be2a90
> ---
>  arch/s390/boot/string.c         | 1 +
>  arch/x86/boot/compressed/misc.h | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/arch/s390/boot/string.c b/arch/s390/boot/string.c
> index b11e8108773a..faccb33b462c 100644
> --- a/arch/s390/boot/string.c
> +++ b/arch/s390/boot/string.c
> @@ -3,6 +3,7 @@
>  #include <linux/kernel.h>
>  #include <linux/errno.h>
>  #undef CONFIG_KASAN
> +#undef CONFIG_KASAN_GENERIC
>  #include "../lib/string.c"
>  
>  int strncmp(const char *cs, const char *ct, size_t count)
> diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
> index 726e264410ff..2ac973983a8e 100644
> --- a/arch/x86/boot/compressed/misc.h
> +++ b/arch/x86/boot/compressed/misc.h
> @@ -12,6 +12,7 @@
>  #undef CONFIG_PARAVIRT_XXL
>  #undef CONFIG_PARAVIRT_SPINLOCKS
>  #undef CONFIG_KASAN
> +#undef CONFIG_KASAN_GENERIC
>  
>  /* cpu_feature_enabled() cannot be used this early */
>  #define USE_EARLY_PGTABLE_L5
> -- 
> 2.28.0.681.g6f77f65b4e-goog
> 

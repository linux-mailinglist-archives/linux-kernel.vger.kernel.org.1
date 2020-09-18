Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B736D26FAF8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 12:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbgIRKwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 06:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbgIRKwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 06:52:14 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C192C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 03:52:14 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id a17so5135555wrn.6
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 03:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QRQC3uLJVX16XzkVHd3z/hv57pExgyhDAmcqkPNt84U=;
        b=Sw1eIJfE1409NQTIJRhIX1I0QQR7u/g+MPtdgNo1Zo+Tq1UeGFnyz4F8ze7oe+nC1I
         5DAU5soFywsnnGBmflf0fXA5wZNF0tgCoxOGpoD1NKOYxCKxwVz2hjsMIH9vFlBxjYPO
         Rt9IWFekFWBaaYXoCwY92ZhEMZ6mkz2uqUVB6C9J9wvwjXqiHyO4t7xShiMY3bh/RARa
         moNtLS3MMZ/f20DEy1mgufmJJ2V2UIgeFP7ubM/v6zWF+zI5v2eXl/aTxbBoOvZb5GGZ
         Vfihpf0Z+pOKKzu5a8XUpDPjqjmVJV5pqtUDaR7YQZv7QAwT8GuIoTfbYWbrjxn3J1Yy
         NjuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QRQC3uLJVX16XzkVHd3z/hv57pExgyhDAmcqkPNt84U=;
        b=RtfDDy4soBxp6H4frli2L3KHKFnmKTHBLdiU/ATtAwBpz+79PXMWW0LiiaEPxF4Y2n
         aNesGLZhYKNSqMdjVaEgbsfKt+jDdwJP+5g0oQSY1KjQzhGttbDTIDilkXij5U7fKV+u
         1wSEohebjKmK/oshRtjT98gQDogjQYXDlhO5XFj7giLWbt1O5cxlOZIkVInEMV6EA9X/
         8ceMotV/Rbo1jKSw2pV6zyM2rn8fUSzzK382Jvx1QvVqArjqmDU3jqBlhJ+PuuA4taGp
         W6QgAgvwLLndaqkXIAgHl1KCjcDlOBbvCBUBpiZZAaULD0klz9j4uKBmLKlfLnfFeN65
         ZaSQ==
X-Gm-Message-State: AOAM5305kSxbtIgBTXcCQisZSTtQUlK/D9kuYwuOHXlMOqJ0Df2K50+F
        YRVIGANvKT5tOlARhjauGFT+wg==
X-Google-Smtp-Source: ABdhPJydrL632UFElWnacFMRQXcf43tkGyJ9uuzMmD/4tZJzHuCjMYxrGUNAacrDLdAoubM6aNocxw==
X-Received: by 2002:adf:b306:: with SMTP id j6mr35571156wrd.279.1600426332508;
        Fri, 18 Sep 2020 03:52:12 -0700 (PDT)
Received: from elver.google.com ([100.105.32.75])
        by smtp.gmail.com with ESMTPSA id a10sm4228229wmj.38.2020.09.18.03.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 03:52:11 -0700 (PDT)
Date:   Fri, 18 Sep 2020 12:52:06 +0200
From:   Marco Elver <elver@google.com>
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
Subject: Re: [PATCH v2 31/37] kasan, x86, s390: update undef CONFIG_KASAN
Message-ID: <20200918105206.GB2384246@elver.google.com>
References: <cover.1600204505.git.andreyknvl@google.com>
 <0a35b29d161bf2559d6e16fbd903e49351c7f6b8.1600204505.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a35b29d161bf2559d6e16fbd903e49351c7f6b8.1600204505.git.andreyknvl@google.com>
User-Agent: Mutt/1.14.4 (2020-06-18)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 11:16PM +0200, Andrey Konovalov wrote:
[...]
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

Is CONFIG_KASAN still used to guard instrumented versions of functions?

It looks like #undef CONFIG_KASAN is no longer needed -- at least
<linux/string.h> no longer mentions it.

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

Similar here; although it seems a little harder to check if CONFIG_KASAN
is still needed. (Maybe could check the preprocessed output diffs?)

>  
>  /* cpu_feature_enabled() cannot be used this early */
>  #define USE_EARLY_PGTABLE_L5
> -- 
> 2.28.0.618.gf4bc123cb7-goog
> 

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE0392AF5C7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 17:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbgKKQIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 11:08:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbgKKQI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 11:08:28 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E13AC0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 08:08:28 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id p1so3018384wrf.12
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 08:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JOTPMrM9cXc3gHfHHUUOqsLEtBpDW5NPaRavY4aCrIo=;
        b=QM4oYuC5Dv5jC1hneMgwO9I5PEumNL2bgDxUI+JJdMVCTuBTGTxF1SCYZV/00TgpOU
         jyL6y9Z4jttTYmROYsPvh/wz16cfpFGnzGyFnhes84Lei6yYH0jCsSHpI5AR6kxkiqc7
         ik18Y1bJ2FU5OQb8nz3f86wdDO3U+7w3dRViajfiHsrAzOjefbtM0uIJrPGin+syNTV+
         9tSmfDS7PNPRRnCPHUaQd0t15xRK+vJhg5Ny98KUKXbyEPq/pn7iRHU/oVOlJAUVLbmb
         eXZRZtTjweiRyy2RaB6eE3teAjLR2dyLJT+ssiPMaJ1aZ2oytbUGw9WTBmKFRSrGPD/h
         yhJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JOTPMrM9cXc3gHfHHUUOqsLEtBpDW5NPaRavY4aCrIo=;
        b=QySrufFd5of7WjOQUuVZIfNbKT0i9oJjC7zEsFWVVN1/k7X0pbHxB5kuiA3B7k6lFK
         ggsM0Cc4o9bu2habCECKcfQ5yAjntSmO90YFWkTNyHgdNrhL9H6BX694OwszU1SNYwgp
         6v6LNhrkp2CwgZlUIZcERWswIUsDTgl/ncma0wcUqsZXkiUGiykq+iZ6iRCVavsy6WIe
         E+HkCfYB2r1IFwtsloS9XrbEUN10E9JLRx1IheHDOPWNSsvWenp+u8yaAZMTiAyQ/Adk
         1rPhk9egUsjpGF9GC8OSN8lawKesgeYDyge7BvoyqKZTSwc53m+csD3J/Bz1EDR2NcNH
         N5hw==
X-Gm-Message-State: AOAM532iBsv4DpSlj4la/m/r/Y1C/NiLdvXVCDz3d9h6KdRYbpbl3xAT
        l9tBsxlBhfT7fPv/9CbGYBM5XQ==
X-Google-Smtp-Source: ABdhPJy1kKLqf6HaqcoO0w9pMiWiG9P2ZJ6j1NPhf0SJm9DRwyNAwOeaZQSjayP8e9C8Rp7vMSB0eg==
X-Received: by 2002:adf:a549:: with SMTP id j9mr16145230wrb.199.1605110906715;
        Wed, 11 Nov 2020 08:08:26 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:f693:9fff:fef4:2449])
        by smtp.gmail.com with ESMTPSA id y10sm3052674wru.94.2020.11.11.08.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 08:08:25 -0800 (PST)
Date:   Wed, 11 Nov 2020 17:08:20 +0100
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
Subject: Re: [PATCH v2 01/20] kasan: simplify quarantine_put call site
Message-ID: <20201111160819.GC517454@elver.google.com>
References: <cover.1605046662.git.andreyknvl@google.com>
 <d7182392511522e5b3ab7b0c1c0933b4f5963ce0.1605046662.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7182392511522e5b3ab7b0c1c0933b4f5963ce0.1605046662.git.andreyknvl@google.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 11:20PM +0100, Andrey Konovalov wrote:
> Move get_free_info() call into quarantine_put() to simplify the call site.
> 
> No functional changes.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
> Link: https://linux-review.googlesource.com/id/Iab0f04e7ebf8d83247024b7190c67c3c34c7940f
> ---
>  mm/kasan/common.c     | 2 +-
>  mm/kasan/kasan.h      | 5 ++---
>  mm/kasan/quarantine.c | 3 ++-
>  3 files changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Marco Elver <elver@google.com>

> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index 2bb0ef6da6bd..5712c66c11c1 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -308,7 +308,7 @@ static bool __kasan_slab_free(struct kmem_cache *cache, void *object,
>  
>  	kasan_set_free_info(cache, object, tag);
>  
> -	quarantine_put(get_free_info(cache, object), cache);
> +	quarantine_put(cache, object);
>  
>  	return IS_ENABLED(CONFIG_KASAN_GENERIC);
>  }
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index 21fe75c66f26..c2c40ec1544d 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -214,12 +214,11 @@ struct kasan_track *kasan_get_free_track(struct kmem_cache *cache,
>  
>  #if defined(CONFIG_KASAN_GENERIC) && \
>  	(defined(CONFIG_SLAB) || defined(CONFIG_SLUB))
> -void quarantine_put(struct kasan_free_meta *info, struct kmem_cache *cache);
> +void quarantine_put(struct kmem_cache *cache, void *object);
>  void quarantine_reduce(void);
>  void quarantine_remove_cache(struct kmem_cache *cache);
>  #else
> -static inline void quarantine_put(struct kasan_free_meta *info,
> -				struct kmem_cache *cache) { }
> +static inline void quarantine_put(struct kmem_cache *cache, void *object) { }
>  static inline void quarantine_reduce(void) { }
>  static inline void quarantine_remove_cache(struct kmem_cache *cache) { }
>  #endif
> diff --git a/mm/kasan/quarantine.c b/mm/kasan/quarantine.c
> index 580ff5610fc1..a0792f0d6d0f 100644
> --- a/mm/kasan/quarantine.c
> +++ b/mm/kasan/quarantine.c
> @@ -161,11 +161,12 @@ static void qlist_free_all(struct qlist_head *q, struct kmem_cache *cache)
>  	qlist_init(q);
>  }
>  
> -void quarantine_put(struct kasan_free_meta *info, struct kmem_cache *cache)
> +void quarantine_put(struct kmem_cache *cache, void *object)
>  {
>  	unsigned long flags;
>  	struct qlist_head *q;
>  	struct qlist_head temp = QLIST_INIT;
> +	struct kasan_free_meta *info = get_free_info(cache, object);
>  
>  	/*
>  	 * Note: irq must be disabled until after we move the batch to the
> -- 
> 2.29.2.222.g5d2a92d10f8-goog
> 

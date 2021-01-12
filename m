Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 215F32F31DC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 14:40:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbhALNjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 08:39:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbhALNjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 08:39:51 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F272C061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 05:39:11 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id r4so2142054wmh.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 05:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/gH3LsuYOCe5YajoCQBV3RVdjva6zoqEdCztkktjq5s=;
        b=OgC9q6GbZVYgSYwfRsnVA97mDQQb5YryYDbuZFTON5T2+M9PQsgMqupSXeu0/sx8vE
         2zWqyL+iSWOdmSaRkHou9pJTUuxus2fEik2ecgEwiuWw5zzGcQ28thXkiOlB4HhfG0iq
         VStgmplVPo5egyk/r/tR1xjTbFfUrYpu8GcRzL0dQnKVtgTmwzwVOlE8KQKr4f2EvBxK
         0AJ2sd4V3RBDsd6j784bCQIXxNo1It4nwn3islj3jGxvYcvUffFJLHibxYKdTigsyY3w
         r9ICUv94Kf7T9EtrWaC4egNPUgg035qOOU4HIF1/qJoD5h/HRAQEoeBkKyEwP6ZETzZV
         6M5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/gH3LsuYOCe5YajoCQBV3RVdjva6zoqEdCztkktjq5s=;
        b=P7tKIBHAH6IdQjw6NmdSbVjaq83GKjmgshmQIw2bAgCy0Y40p/PTemODxdmkC0mbfp
         vo1x/7lj4Oh8VVrMzWLB1gljswP9AW6pBNKWMiHRDjySrfMY/M4fsj5Fhhao3BauZRg6
         Ucea3ZCb7WKbQOsTiqkuWFXypKATlPDZYsP62dYmRiHxa0VQ/fmtpsLZEG8wkYESz8oe
         tDSvT99Cpx7exfeBiYRuXeOo1Kt22CfJPJ4vg5mg5fUYGnR0F6xjGGYkcA/c3HDvEkbf
         MYzLCl/zWbc2BUEqCNdYALEkQwn/mXjrAQaiIQGN3iKFWkvXBWIu3zx1rxmSkNLoEEk5
         THXQ==
X-Gm-Message-State: AOAM531iAR9vYpt6kpzYG7Nis0jWkPwz0O8HWsqFK5eQpAIiJoKDBjNT
        7/qXcykvuHoaWNjX1ysDmcBAwA==
X-Google-Smtp-Source: ABdhPJwfJ5xv+7Q8U7WOU65hNyU1wtHLGDZ9L7S4xnjkAKIEuZTC299bYdx3zqbgyyZ9nUOw/LBEuA==
X-Received: by 2002:a1c:c204:: with SMTP id s4mr3615203wmf.73.1610458749636;
        Tue, 12 Jan 2021 05:39:09 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:f693:9fff:fef4:2449])
        by smtp.gmail.com with ESMTPSA id l20sm5038940wrh.82.2021.01.12.05.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 05:39:08 -0800 (PST)
Date:   Tue, 12 Jan 2021 14:39:03 +0100
From:   Marco Elver <elver@google.com>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/11] kasan: adopt kmalloc_uaf2 test to HW_TAGS mode
Message-ID: <X/2md4h0Nki8RNW0@elver.google.com>
References: <cover.1609871239.git.andreyknvl@google.com>
 <9a4f47fe8717b4b249591b307cdd1f26c46dcb82.1609871239.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a4f47fe8717b4b249591b307cdd1f26c46dcb82.1609871239.git.andreyknvl@google.com>
User-Agent: Mutt/2.0.2 (2020-11-20)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 05, 2021 at 07:27PM +0100, Andrey Konovalov wrote:
> In the kmalloc_uaf2() test, the pointers to the two allocated memory
> blocks might be the same, and the test will fail. With the software
> tag-based mode, the probability of the that happening is 1/254, so it's
> hard to observe the failure. For the hardware tag-based mode though,
> the probablity is 1/14, which is quite noticable.
> 
> Allow up to 4 attempts at generating different tags for the tag-based
> modes.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Link: https://linux-review.googlesource.com/id/Ibfa458ef2804ff465d8eb07434a300bf36388d55
> ---
>  lib/test_kasan.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/lib/test_kasan.c b/lib/test_kasan.c
> index b5077a47b95a..b67da7f6e17f 100644
> --- a/lib/test_kasan.c
> +++ b/lib/test_kasan.c
> @@ -375,7 +375,9 @@ static void kmalloc_uaf2(struct kunit *test)
>  {
>  	char *ptr1, *ptr2;
>  	size_t size = 43;
> +	int counter = 0;
>  
> +again:
>  	ptr1 = kmalloc(size, GFP_KERNEL);
>  	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr1);
>  
> @@ -384,6 +386,13 @@ static void kmalloc_uaf2(struct kunit *test)
>  	ptr2 = kmalloc(size, GFP_KERNEL);
>  	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr2);
>  
> +	/*
> +	 * For tag-based KASAN ptr1 and ptr2 tags might happen to be the same.
> +	 * Allow up to 4 attempts at generating different tags.
> +	 */
> +	if (!IS_ENABLED(CONFIG_KASAN_GENERIC) && ptr1 == ptr2 && counter++ < 4)
> +		goto again;
> +

Why do we even need a limit? Why not retry until ptr1 != ptr2?

>  	KUNIT_EXPECT_KASAN_FAIL(test, ptr1[40] = 'x');
>  	KUNIT_EXPECT_PTR_NE(test, ptr1, ptr2);
>  
> -- 
> 2.29.2.729.g45daf8777d-goog
> 

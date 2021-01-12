Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB002F324E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 14:56:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730817AbhALN4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 08:56:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbhALN4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 08:56:07 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E30DAC061786
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 05:55:26 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id n16so1801281wmc.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 05:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jU0ycsEdEyG12FaOCf2AucocFaDBPHhikig1gZJxSS0=;
        b=USJ1WbcWVHmg2KSm7+bUEzehLqCHcu05wPWW5iCMzg1JSkfogd/hwH3PLqgNwxvMG3
         Z9eVLK1cbDNbGe8O3NaAPY4txG7GvekAuYF3gyCqpKmDxvnh0Ma2SJ/ZjPdVMrBLp8fw
         a+LQEEj0dX9Ku/1f3KkSKWN8hCj5iC0Uu+1fUT0m3uUOB7099dNFfFQ1tNuUTryo3+vz
         DJhboxbrHi81fU7gB641owMu7izhJ/9ZBCcgPQWaHU3bCU/Cx0uIyqCVHSPxPeIOG5Gz
         +YGtNCVdzNRTuBRMNvTkEX6k5qJIZBQHuKQSgQn+M4xayTc9D/A/OUXAiYhZvVuQLgiP
         /00Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jU0ycsEdEyG12FaOCf2AucocFaDBPHhikig1gZJxSS0=;
        b=gRdYokLY83WCqdXjh8kOA1RiRA+WzH3r72JVjVHxR4J5Nnl/rzST1R0A78whUCZY7E
         aenx40tEOGXzpNi+AP+peYfCPBRCmuqw+6135Jp8S76B+FO7t7i/SBaOlyulnVm4RDWi
         N6fOtNlsSwRuicDa0dc8H0jGQbM3bJBBKjcHaCvusnDittExRl6w+LaofuOdyb2SsMUp
         awkVeR/pJmqUuiHhEqj98kGOEbQe0obsHl+P+zxoFlzzAcafFWjzfl97M+5q2VWZhMzb
         Ac4RbBZpY0Vh1uxjTHXFXIzMBLkQ/d2c1NijJ9PuOuJIuFDvejpZ4DkZfjDGZjxi3lgJ
         4tWA==
X-Gm-Message-State: AOAM531dQKv4Ngc2ZuF/lD+gq1q/i0QcdNAjXIX+NBTONZ2R/OkG7Puo
        8mgMh9esuvUJcLfwmDhZgUDKSg==
X-Google-Smtp-Source: ABdhPJyt+xXTspVy3CyA7gxyG4tW/TsByXZ/HU6iwQNJNQ5hYjqVXPCO++la/5WhHGqluSbZl24okw==
X-Received: by 2002:a1c:356:: with SMTP id 83mr3856521wmd.31.1610459725577;
        Tue, 12 Jan 2021 05:55:25 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:f693:9fff:fef4:2449])
        by smtp.gmail.com with ESMTPSA id w21sm4052524wmi.45.2021.01.12.05.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 05:55:24 -0800 (PST)
Date:   Tue, 12 Jan 2021 14:55:18 +0100
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
Subject: Re: [PATCH 09/11] kasan: fix memory corruption in kasan_bitops_tags
 test
Message-ID: <X/2qRlGsBj06ellk@elver.google.com>
References: <cover.1609871239.git.andreyknvl@google.com>
 <0c51a7266ea851797dc9816405fc40d860a48db1.1609871239.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c51a7266ea851797dc9816405fc40d860a48db1.1609871239.git.andreyknvl@google.com>
User-Agent: Mutt/2.0.2 (2020-11-20)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 05, 2021 at 07:27PM +0100, Andrey Konovalov wrote:
> Since the hardware tag-based KASAN mode might not have a redzone that
> comes after an allocated object (when kasan.mode=prod is enabled), the
> kasan_bitops_tags() test ends up corrupting the next object in memory.
> 
> Change the test so it always accesses the redzone that lies within the
> allocated object's boundaries.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Link: https://linux-review.googlesource.com/id/I67f51d1ee48f0a8d0fe2658c2a39e4879fe0832a

Reviewed-by: Marco Elver <elver@google.com>

> ---
>  lib/test_kasan.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/lib/test_kasan.c b/lib/test_kasan.c
> index b67da7f6e17f..3ea52da52714 100644
> --- a/lib/test_kasan.c
> +++ b/lib/test_kasan.c
> @@ -771,17 +771,17 @@ static void kasan_bitops_tags(struct kunit *test)
>  
>  	/* This test is specifically crafted for the tag-based mode. */
>  	if (IS_ENABLED(CONFIG_KASAN_GENERIC)) {
> -		kunit_info(test, "skipping, CONFIG_KASAN_SW_TAGS required");
> +		kunit_info(test, "skipping, CONFIG_KASAN_SW/HW_TAGS required");
>  		return;
>  	}
>  
> -	/* Allocation size will be rounded to up granule size, which is 16. */
> -	bits = kzalloc(sizeof(*bits), GFP_KERNEL);
> +	/* kmalloc-64 cache will be used and the last 16 bytes will be the redzone. */
> +	bits = kzalloc(48, GFP_KERNEL);
>  	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, bits);
>  
> -	/* Do the accesses past the 16 allocated bytes. */
> -	kasan_bitops_modify(test, BITS_PER_LONG, &bits[1]);
> -	kasan_bitops_test_and_modify(test, BITS_PER_LONG + BITS_PER_BYTE, &bits[1]);
> +	/* Do the accesses past the 48 allocated bytes, but within the redone. */
> +	kasan_bitops_modify(test, BITS_PER_LONG, (void *)bits + 48);
> +	kasan_bitops_test_and_modify(test, BITS_PER_LONG + BITS_PER_BYTE, (void *)bits + 48);
>  
>  	kfree(bits);
>  }
> -- 
> 2.29.2.729.g45daf8777d-goog
> 

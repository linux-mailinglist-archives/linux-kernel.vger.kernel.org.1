Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86DF92805C1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 19:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732993AbgJARpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 13:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732096AbgJARpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 13:45:17 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A340C0613D0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 10:45:17 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id e16so6809989wrm.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 10:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SdTU4gQ/GSNzMeDvk9Yhuq+mmVJCx1AqWYuvXYSPp6E=;
        b=HIqQhj0r1gGYdw02V45ahQXi4QGLOB4PIPtcQRi7iRuA7fmkkN9svVGzTK1Y/rlcjA
         SPIdxpDNZQuuL+0BJjIgAMejpVODY6Fx47ubXD+cidu8YMiaR+omZqX6YldhiwKGbxob
         mUGHU6oINAGWbbhYD+l/Cz9z8q1AGWDxsX84tyYAIO3wg8Ta3LJRUVIDkLWRBvfeAjv9
         pa0y/97UbN4botFE7fHjk/2zLdDTWd2IXAHCRUJRCjcWFwoMZ4ZysMnbM8bHX3nXQe71
         cHpil8dlEuf+yZHPo+9tkopf+DMn/w3sVWswIXj5N+QXOjgK+wRQLErcpeMBMfU1Jq2N
         UPLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SdTU4gQ/GSNzMeDvk9Yhuq+mmVJCx1AqWYuvXYSPp6E=;
        b=t0xbWyFnDDnUi/+VX5Ozd55PlENoJvzecwp6AJNz0F8d8p8DP9V3NufcIf+Dm36JqT
         q0T6pmOpOPx/ekh5urtUWIhKhs4UgehfNYLBteTJ9FuTi6fkpu7NNpDQvwcH5XTZQQJc
         HEfayCUU9jH3+yYNchBJvDkyrLV2pHxv9AEAsbrzBToG3D2F+8yEW/l+8KEBQm09YAGr
         Qsh2xAeZ+EIqaj1qsg2gUc5UXlpy5C6P6gAGBzUrquSzVCSvJjJOA8oDAHZIrVNrtlLK
         ssF9vMtEFQvIsBtEWD3tPM34TkVAWno68+gs4oa6qUs2rkbLnJ/1ra0HZFGto9X9BuOy
         zbXQ==
X-Gm-Message-State: AOAM530WpMJhL4iaYXPSAozVBH2kTCte+irz18c3SoeKAN7r7mk25+sz
        AplspKjvC+bxnyxUfiNUy0Y3tQ==
X-Google-Smtp-Source: ABdhPJzJmTheU5+EobBQTbg33EPACuLKFxTHdCBuGuc/t70VfL3q1/rNXGQEbgHtlTe5XcWvcpQN+g==
X-Received: by 2002:adf:f6c8:: with SMTP id y8mr10971682wrp.217.1601574315975;
        Thu, 01 Oct 2020 10:45:15 -0700 (PDT)
Received: from elver.google.com ([100.105.32.75])
        by smtp.gmail.com with ESMTPSA id w7sm9695314wrm.92.2020.10.01.10.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 10:45:15 -0700 (PDT)
Date:   Thu, 1 Oct 2020 19:45:09 +0200
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
Subject: Re: [PATCH v3 16/39] kasan: rename addr_has_shadow to
 addr_has_metadata
Message-ID: <20201001174509.GL4162920@elver.google.com>
References: <cover.1600987622.git.andreyknvl@google.com>
 <fd0103571c825317241bfdc43ef19766fd370e4f.1600987622.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd0103571c825317241bfdc43ef19766fd370e4f.1600987622.git.andreyknvl@google.com>
User-Agent: Mutt/1.14.5 (2020-06-23)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25, 2020 at 12:50AM +0200, 'Andrey Konovalov' via kasan-dev wrote:
> This is a preparatory commit for the upcoming addition of a new hardware
> tag-based (MTE-based) KASAN mode.
> 
> Hardware tag-based KASAN won't be using shadow memory, but will reuse
> this function. Rename "shadow" to implementation-neutral "metadata".
> 
> No functional changes.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

Reviewed-by: Marco Elver <elver@google.com>

> ---
> Change-Id: I03706fe34b38da7860c39aa0968e00001a7d1873
> ---
>  mm/kasan/kasan.h          | 2 +-
>  mm/kasan/report.c         | 6 +++---
>  mm/kasan/report_generic.c | 2 +-
>  3 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index 8dfacc0f73ea..0bf669fad345 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -146,7 +146,7 @@ static inline const void *kasan_shadow_to_mem(const void *shadow_addr)
>  		<< KASAN_SHADOW_SCALE_SHIFT);
>  }
>  
> -static inline bool addr_has_shadow(const void *addr)
> +static inline bool addr_has_metadata(const void *addr)
>  {
>  	return (addr >= kasan_shadow_to_mem((void *)KASAN_SHADOW_START));
>  }
> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> index 91b869673148..145b966f8f4d 100644
> --- a/mm/kasan/report.c
> +++ b/mm/kasan/report.c
> @@ -329,7 +329,7 @@ static void __kasan_report(unsigned long addr, size_t size, bool is_write,
>  	untagged_addr = reset_tag(tagged_addr);
>  
>  	info.access_addr = tagged_addr;
> -	if (addr_has_shadow(untagged_addr))
> +	if (addr_has_metadata(untagged_addr))
>  		info.first_bad_addr = find_first_bad_addr(tagged_addr, size);
>  	else
>  		info.first_bad_addr = untagged_addr;
> @@ -340,11 +340,11 @@ static void __kasan_report(unsigned long addr, size_t size, bool is_write,
>  	start_report(&flags);
>  
>  	print_error_description(&info);
> -	if (addr_has_shadow(untagged_addr))
> +	if (addr_has_metadata(untagged_addr))
>  		print_tags(get_tag(tagged_addr), info.first_bad_addr);
>  	pr_err("\n");
>  
> -	if (addr_has_shadow(untagged_addr)) {
> +	if (addr_has_metadata(untagged_addr)) {
>  		print_address_description(untagged_addr, get_tag(tagged_addr));
>  		pr_err("\n");
>  		print_shadow_for_address(info.first_bad_addr);
> diff --git a/mm/kasan/report_generic.c b/mm/kasan/report_generic.c
> index 42b2b5791733..ff067071cd28 100644
> --- a/mm/kasan/report_generic.c
> +++ b/mm/kasan/report_generic.c
> @@ -117,7 +117,7 @@ const char *get_bug_type(struct kasan_access_info *info)
>  	if (info->access_addr + info->access_size < info->access_addr)
>  		return "out-of-bounds";
>  
> -	if (addr_has_shadow(info->access_addr))
> +	if (addr_has_metadata(info->access_addr))
>  		return get_shadow_bug_type(info);
>  	return get_wild_bug_type(info);
>  }
> -- 
> 2.28.0.681.g6f77f65b4e-goog
> 
> -- 
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/fd0103571c825317241bfdc43ef19766fd370e4f.1600987622.git.andreyknvl%40google.com.

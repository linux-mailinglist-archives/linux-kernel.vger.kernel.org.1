Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CBA7280610
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 19:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732949AbgJAR6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 13:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732782AbgJAR6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 13:58:51 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 393EAC0613D0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 10:58:49 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id s12so6840135wrw.11
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 10:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Z3LAespRKggBAzZJgRL/XlMKflXl6US5qlulvNZ+CWs=;
        b=od955wzcgv89aGAe3soOsbcrwpahgFEVliBe121WeV3EN8WamikoGFD/WC/565svPp
         tcMmvBhiE9klmcTllGYcDPAyjf9XgFRPsmw+Z4A/fl93I6/TMLjcsV9dGVFfpEEYcaxi
         42Ml7WCcIj4txqieI4wB0XVkiRqGrSAJHa2vXeEKIrbZVYuaqSgZrImzOkZiXU5MI4bR
         xEJdQ+LAY7UY3lklhF1a0xPajJN6QuGo30gbAxF5Z3XRs/0KkJlRBi9LC/z4m0C6iRNb
         VPPYimks4Hl44Rodptz8syBtu7copDzNunz2XOvfKGnut7dwL5dvs52+Gf+mDRHpMtdX
         vKQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Z3LAespRKggBAzZJgRL/XlMKflXl6US5qlulvNZ+CWs=;
        b=R1dvY0dj2GbFqGgHQOPT4yJYZHp7JNV2Og/t3spRNLQIV+hC8YAnXpiW2epgYmqkU1
         UNIsxVVHZxqcSbCfAoYJz/mDAladxKo+pPavI0qbSwWrPmDMyQ1ifjvjIqa/uhD8rgOT
         2vHJI6QqROcLIE2yCkNzY02Uunz/b+ysyaFv/CaPcw30z3pJ12QagONkFGMWJPRTB1ww
         QYZrDiIh8LkaJqn4SWjlHyrVGHmZ/JXBt24BvCFWYaelIiwdExtah3TcYekP/WsdcExf
         x9LI0iiVf0f82Si0JETprE8Zyg/7rr7i+k7j5wE3Q8veb2gfAt5T+uLjjDSze3Gx+Mf7
         II7A==
X-Gm-Message-State: AOAM531eOQKWp5YyxGcN8JLz0r5qzluy9BRIiIOnkwMov3qvb1OBiXFS
        uOp9HSTz3p99ENb9jRHyOxbRUA==
X-Google-Smtp-Source: ABdhPJybU2DR+386wgAvXpbetk9a0PADxBixIkZLW7YdX/4xa9aehfk2/lI5WeXpQfsw0wlb/FN+ng==
X-Received: by 2002:adf:f34a:: with SMTP id e10mr10271328wrp.91.1601575127768;
        Thu, 01 Oct 2020 10:58:47 -0700 (PDT)
Received: from elver.google.com ([100.105.32.75])
        by smtp.gmail.com with ESMTPSA id q12sm10203515wrs.48.2020.10.01.10.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 10:58:46 -0700 (PDT)
Date:   Thu, 1 Oct 2020 19:58:41 +0200
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
Subject: Re: [PATCH v3 32/39] kasan: define KASAN_GRANULE_SIZE for HW_TAGS
Message-ID: <20201001175841.GS4162920@elver.google.com>
References: <cover.1600987622.git.andreyknvl@google.com>
 <08b7f7fe6b20f6477fa2a447a931b3bbb1ad3121.1600987622.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08b7f7fe6b20f6477fa2a447a931b3bbb1ad3121.1600987622.git.andreyknvl@google.com>
User-Agent: Mutt/1.14.5 (2020-06-23)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25, 2020 at 12:50AM +0200, Andrey Konovalov wrote:
> Hardware tag-based KASAN has granules of MTE_GRANULE_SIZE. Define
> KASAN_GRANULE_SIZE to MTE_GRANULE_SIZE for CONFIG_KASAN_HW_TAGS.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

Reviewed-by: Marco Elver <elver@google.com>

> ---
> Change-Id: I5d1117e6a991cbca00d2cfb4ba66e8ae2d8f513a
> ---
>  mm/kasan/kasan.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index 9c73f324e3ce..bd51ab72c002 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -5,7 +5,13 @@
>  #include <linux/kasan.h>
>  #include <linux/stackdepot.h>
>  
> +#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
>  #define KASAN_GRANULE_SIZE	(1UL << KASAN_SHADOW_SCALE_SHIFT)
> +#else
> +#include <asm/mte-kasan.h>
> +#define KASAN_GRANULE_SIZE	(MTE_GRANULE_SIZE)

Why braces? Shouldn't MTE_GRANULE_SIZE already have braces?

> +#endif
> +
>  #define KASAN_GRANULE_MASK	(KASAN_GRANULE_SIZE - 1)
>  #define KASAN_GRANULE_PAGE	(KASAN_GRANULE_SIZE << PAGE_SHIFT)
>  
> -- 
> 2.28.0.681.g6f77f65b4e-goog
> 

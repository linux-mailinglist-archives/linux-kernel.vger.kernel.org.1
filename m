Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A87DC26FD8F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 14:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbgIRMwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 08:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbgIRMwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 08:52:25 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E23FDC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 05:52:24 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id l9so5468831wme.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 05:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9QeHCUfQyRWNLF4v5BVGx0mOMMB1DfrWlk1Da5oWEr0=;
        b=OPEfNMvDbr1GA16O+bD1EVvXU3RwiktLp1v4SspTfzVHQ3b6wc3DsOnL2yFV/7OJUX
         vJ86IOK7F7BbktHLeLTU4gwiJlcEho5MTNOtW2ME95PmxEoVh3EivAR0i7EzWek/DQ65
         0Gcho1HTrLf4Rus/rXNQXoYuXPIyirZTjVrXQWGo57ObWUwFDkqmjdswWagbQK17pKvg
         qOtIEOxBuS0Kl59UHyNYRZBb1BkFJxXOf8jOsNo34C1fv1A9zYG7wP0awOp76oxY/VBl
         hm9z5eWcdjEUOFpxnP8+Uhkt7kqLMpfyk1Mqu2n2rHZTO2BiEEQ7Ade2j+xiZjgOtsLW
         gsSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9QeHCUfQyRWNLF4v5BVGx0mOMMB1DfrWlk1Da5oWEr0=;
        b=jCnqDGfM+l+rVjKGHMzizz1Pn6RCx+0ZKyV4c7skF7wXqTBxAYRRWSek7o8W4yuHDF
         KseMU3r6287XRohrpKFEBdhZdWZos4Em/HKwF5aPTdcZFqkKAK2NRmIxw4XuH6nbU8VE
         IWVRJhUwBF4SRwX9x1ybvMET3duR2+9mZ2+3wfydsLXhiNUeCqi8Z533oY2ykSxkVn0Z
         rlG5r5gHyrvJ/moxFUOsy8N6q5C+MhIi42rZkSx+MA30wPmsr0R8CQ+fROB3gKH8hLzo
         vX0xca2Rbdk1JhnocO0IfErqHUoqngh/8PK6LOvVVOarHB7pmk23FZ4aDLVZurZjvwmc
         t4KQ==
X-Gm-Message-State: AOAM5331VE7TVkIfb1DORbFjrxwEN/cpFEpH/5KA4AopZl3UqwXTSLs9
        tF/kZcIRgNKj1Cnji5S0VIcb7Q==
X-Google-Smtp-Source: ABdhPJzZiAEODydg/nQYzxZIt0k+pmAXCO33IML30l+9SgWT24seOlXi9uwnfVeunAVfJvZCSWDf5Q==
X-Received: by 2002:a7b:ce96:: with SMTP id q22mr14478150wmj.132.1600433543383;
        Fri, 18 Sep 2020 05:52:23 -0700 (PDT)
Received: from elver.google.com ([100.105.32.75])
        by smtp.gmail.com with ESMTPSA id i16sm5028940wrq.73.2020.09.18.05.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 05:52:22 -0700 (PDT)
Date:   Fri, 18 Sep 2020 14:52:16 +0200
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
Subject: Re: [PATCH v2 33/37] kasan, arm64: implement HW_TAGS runtime
Message-ID: <20200918125216.GD2384246@elver.google.com>
References: <cover.1600204505.git.andreyknvl@google.com>
 <74133d1a57c47cb8fec791dd5d1e6417b0579fc3.1600204505.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74133d1a57c47cb8fec791dd5d1e6417b0579fc3.1600204505.git.andreyknvl@google.com>
User-Agent: Mutt/1.14.4 (2020-06-18)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Sorry for the additional email on this patch; trying to consolidate
  comments now. ]

On Tue, Sep 15, 2020 at 11:16PM +0200, Andrey Konovalov wrote:
> Provide implementation of KASAN functions required for the hardware
> tag-based mode. Those include core functions for memory and pointer
> tagging (tags_hw.c) and bug reporting (report_tags_hw.c). Also adapt
> common KASAN code to support the new mode.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---
> Change-Id: I8a8689ba098174a4d0ef3f1d008178387c80ee1c
> ---
>  arch/arm64/include/asm/memory.h   |  4 +-
>  arch/arm64/kernel/setup.c         |  1 -
>  include/linux/kasan.h             |  6 +--
>  include/linux/mm.h                |  2 +-
>  include/linux/page-flags-layout.h |  2 +-
>  mm/kasan/Makefile                 |  5 ++
>  mm/kasan/common.c                 | 14 +++---
>  mm/kasan/kasan.h                  | 17 +++++--
>  mm/kasan/report_tags_hw.c         | 47 +++++++++++++++++++
>  mm/kasan/report_tags_sw.c         |  2 +-
>  mm/kasan/shadow.c                 |  2 +-
>  mm/kasan/tags_hw.c                | 78 +++++++++++++++++++++++++++++++
>  mm/kasan/tags_sw.c                |  2 +-
>  13 files changed, 162 insertions(+), 20 deletions(-)
>  create mode 100644 mm/kasan/report_tags_hw.c
>  create mode 100644 mm/kasan/tags_hw.c
[...]
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index 41c7f1105eaa..412a23d1546b 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -118,7 +118,7 @@ void kasan_free_pages(struct page *page, unsigned int order)
>   */
>  static inline unsigned int optimal_redzone(unsigned int object_size)
>  {
> -	if (IS_ENABLED(CONFIG_KASAN_SW_TAGS))
> +	if (!IS_ENABLED(CONFIG_KASAN_GENERIC))
>  		return 0;
>  
>  	return
> @@ -183,14 +183,14 @@ size_t kasan_metadata_size(struct kmem_cache *cache)
>  struct kasan_alloc_meta *get_alloc_info(struct kmem_cache *cache,
>  					const void *object)
>  {
> -	return (void *)object + cache->kasan_info.alloc_meta_offset;
> +	return (void *)reset_tag(object) + cache->kasan_info.alloc_meta_offset;
>  }
>  
>  struct kasan_free_meta *get_free_info(struct kmem_cache *cache,
>  				      const void *object)
>  {
>  	BUILD_BUG_ON(sizeof(struct kasan_free_meta) > 32);
> -	return (void *)object + cache->kasan_info.free_meta_offset;
> +	return (void *)reset_tag(object) + cache->kasan_info.free_meta_offset;
>  }
>  
>  void kasan_poison_slab(struct page *page)
> @@ -272,7 +272,8 @@ void * __must_check kasan_init_slab_obj(struct kmem_cache *cache,
>  	alloc_info = get_alloc_info(cache, object);
>  	__memset(alloc_info, 0, sizeof(*alloc_info));

Suggested edit below (assuming the line-break wasn't intentional; this
should still be within checkpatch.pl's 100 col limit):
------
-	if (IS_ENABLED(CONFIG_KASAN_SW_TAGS) ||
-			IS_ENABLED(CONFIG_KASAN_HW_TAGS))
+	if (IS_ENABLED(CONFIG_KASAN_SW_TAGS) || IS_ENABLED(CONFIG_KASAN_HW_TAGS))
 		object = set_tag(object,
 				assign_tag(cache, object, true, false));
 
@@ -343,8 +342,7 @@ static void *__kasan_kmalloc(struct kmem_cache *cache, const void *object,
 	redzone_end = round_up((unsigned long)object + cache->object_size,
 				KASAN_GRANULE_SIZE);
 
-	if (IS_ENABLED(CONFIG_KASAN_SW_TAGS) ||
-			IS_ENABLED(CONFIG_KASAN_HW_TAGS))
+	if (IS_ENABLED(CONFIG_KASAN_SW_TAGS) || IS_ENABLED(CONFIG_KASAN_HW_TAGS))
 		tag = assign_tag(cache, object, false, keep_tag);
------

> -	if (IS_ENABLED(CONFIG_KASAN_SW_TAGS))
> +	if (IS_ENABLED(CONFIG_KASAN_SW_TAGS) ||
> +			IS_ENABLED(CONFIG_KASAN_HW_TAGS))
>  		object = set_tag(object,
>  				assign_tag(cache, object, true, false));
>  
> @@ -342,10 +343,11 @@ static void *__kasan_kmalloc(struct kmem_cache *cache, const void *object,
>  	redzone_end = round_up((unsigned long)object + cache->object_size,
>  				KASAN_GRANULE_SIZE);
>  
> -	if (IS_ENABLED(CONFIG_KASAN_SW_TAGS))
> +	if (IS_ENABLED(CONFIG_KASAN_SW_TAGS) ||
> +			IS_ENABLED(CONFIG_KASAN_HW_TAGS))
>  		tag = assign_tag(cache, object, false, keep_tag);
>  
> -	/* Tag is ignored in set_tag without CONFIG_KASAN_SW_TAGS */
> +	/* Tag is ignored in set_tag without CONFIG_KASAN_SW/HW_TAGS */
>  	kasan_unpoison_memory(set_tag(object, tag), size);
>  	kasan_poison_memory((void *)redzone_start, redzone_end - redzone_start,
>  		KASAN_KMALLOC_REDZONE);
[...]
> diff --git a/mm/kasan/report_tags_hw.c b/mm/kasan/report_tags_hw.c
> new file mode 100644
> index 000000000000..c2f73c46279a
> --- /dev/null
> +++ b/mm/kasan/report_tags_hw.c
> @@ -0,0 +1,47 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * This file contains hardware tag-based KASAN specific error reporting code.
> + *
> + * Copyright (c) 2020 Google, Inc.
> + * Author: Andrey Konovalov <andreyknvl@google.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *

I do not think we put the "This program is ..." preamble in new files
anymore. It should be covered by SPDX tag above.

> + */
> +
> +#include <linux/kasan.h>
> +#include <linux/kernel.h>
> +#include <linux/memory.h>
> +#include <linux/mm.h>
> +#include <linux/string.h>
> +#include <linux/types.h>
[...]
> diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
> index 4888084ecdfc..ca69726adf8f 100644
> --- a/mm/kasan/shadow.c
> +++ b/mm/kasan/shadow.c
> @@ -111,7 +111,7 @@ void kasan_unpoison_memory(const void *address, size_t size)
>  
>  		if (IS_ENABLED(CONFIG_KASAN_SW_TAGS))
>  			*shadow = tag;
> -		else
> +		else /* CONFIG_KASAN_GENERIC */
>  			*shadow = size & KASAN_GRANULE_MASK;
>  	}
>  }
> diff --git a/mm/kasan/tags_hw.c b/mm/kasan/tags_hw.c
> new file mode 100644
> index 000000000000..c93d43379e39
> --- /dev/null
> +++ b/mm/kasan/tags_hw.c
> @@ -0,0 +1,78 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * This file contains core hardware tag-based KASAN code.
> + *
> + * Copyright (c) 2020 Google, Inc.
> + * Author: Andrey Konovalov <andreyknvl@google.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *

I do not think we put the "This program is ..." preamble in new files
anymore. It should be covered by SPDX tag above.

> + */
> +
> +#include <linux/kasan.h>
> +#include <linux/kernel.h>
> +#include <linux/memory.h>
> +#include <linux/mm.h>
> +#include <linux/string.h>
> +#include <linux/types.h>
> +
> +#include "kasan.h"
> +
> +void kasan_init_tags(void)
> +{
> +	init_tags(KASAN_TAG_MAX);
> +}
> +
> +void *kasan_reset_tag(const void *addr)
> +{
> +	return reset_tag(addr);
> +}
> +

To help readability, would this edit be ok?
------
 void kasan_poison_memory(const void *address, size_t size, u8 value)
 {
-	set_mem_tag_range(reset_tag(address),
-		round_up(size, KASAN_GRANULE_SIZE), value);
+	set_mem_tag_range(reset_tag(address), round_up(size, KASAN_GRANULE_SIZE), value);
 }
 
 void kasan_unpoison_memory(const void *address, size_t size)
 {
-	set_mem_tag_range(reset_tag(address),
-		round_up(size, KASAN_GRANULE_SIZE), get_tag(address));
+	set_mem_tag_range(reset_tag(address), round_up(size, KASAN_GRANULE_SIZE), get_tag(address));
 }
------

> +void kasan_poison_memory(const void *address, size_t size, u8 value)
> +{
> +	set_mem_tag_range(reset_tag(address),
> +		round_up(size, KASAN_GRANULE_SIZE), value);
> +}
> +
> +void kasan_unpoison_memory(const void *address, size_t size)
> +{
> +	set_mem_tag_range(reset_tag(address),
> +		round_up(size, KASAN_GRANULE_SIZE), get_tag(address));
> +}
> +
> +u8 random_tag(void)
> +{
> +	return get_random_tag();
> +}
> +
> +bool check_invalid_free(void *addr)
> +{
> +	u8 ptr_tag = get_tag(addr);
> +	u8 mem_tag = get_mem_tag(addr);
> +


Why not just:
------
-	if (shadow_byte == KASAN_TAG_INVALID)
-		return true;
-	if (tag != KASAN_TAG_KERNEL && tag != shadow_byte)
-		return true;
-	return false;
+	return shadow_byte == KASAN_TAG_INVALID ||
+	       (tag != KASAN_TAG_KERNEL && tag != shadow_byte);
 }
------

> +	if (mem_tag == KASAN_TAG_INVALID)
> +		return true;
> +	if (ptr_tag != KASAN_TAG_KERNEL && ptr_tag != mem_tag)
> +		return true;
> +	return false;
> +}
> +

Thanks,
-- Marco

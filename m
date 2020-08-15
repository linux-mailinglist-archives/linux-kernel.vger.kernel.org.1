Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBA1D2452BD
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Aug 2020 23:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729304AbgHOVyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Aug 2020 17:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729108AbgHOVwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 17:52:33 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51CA8C0A88B5
        for <linux-kernel@vger.kernel.org>; Sat, 15 Aug 2020 09:59:59 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id k13so5492846plk.13
        for <linux-kernel@vger.kernel.org>; Sat, 15 Aug 2020 09:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Rb/IMQYAMEFrYCtyEvFVd8k7Hv2cYtIwx71PE3QM1p8=;
        b=bp6qJV4DEhzLrf629/G+tL9EvTZVqc/ysLjd/vQMHp+0jiX1XZtLIgjqec6Lpt/AaN
         WTq7cZUtJPMxGLrYA4iDCx3FAGjWmYa10boN5IBn8zvQ0LJy4jLy97V0yeOktIX46fym
         j+NDd7YOcqJgHy11LHoejm8VJES3NQHihXr5g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Rb/IMQYAMEFrYCtyEvFVd8k7Hv2cYtIwx71PE3QM1p8=;
        b=XaPp4wIO8GUzD3GSNyyZw8Pbv5vMvwXN4/c8E3tjCh/FAYLEmIdGOik1wZu2sWzIqQ
         ZhSynJXHCZujgRkm5isUjJ03ljWB9J3r9jKX3CRi0KeEmm2qyffx165ay15+xCkNVwRf
         Jzj19dnHXFpPwjQBQhx1Nm0FFRWJKEdb24ZmQ/rQerizmpBenzR7LKxUI2Acrve9nwTL
         GLSCDRABsVi3BZLavLWVPkIv6mNzwjhYLM29FnwUZzwH+AEzxDMMzfaEQIPtL5KRq4rd
         mhiiMpvtTJOdRVF7mAnltqmflLJ6ta+0yMG5v/XJOgs99lwEMbcIfVlPr1xcSXWXWWq9
         HRPw==
X-Gm-Message-State: AOAM531dVhVQGoqQIrYpMziAqedsgrOB4V7a4aeVdMJCHgSC/cb0rEhb
        Y3rSJpsYSToxHMr2eB9jwZQhJQ==
X-Google-Smtp-Source: ABdhPJzCrWUNRjB+5ydtKJX7u7Wr14mIRwWEOzQPie8wMcCnFEFODVqD0y9uyzTzDe5hmkp2qfJd5A==
X-Received: by 2002:a17:90a:e986:: with SMTP id v6mr6862878pjy.88.1597510798065;
        Sat, 15 Aug 2020 09:59:58 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d127sm12507740pfc.175.2020.08.15.09.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2020 09:59:57 -0700 (PDT)
Date:   Sat, 15 Aug 2020 09:59:56 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Alexander Popov <alex.popov@linux.com>
Cc:     Jann Horn <jannh@google.com>, Will Deacon <will@kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        David Howells <dhowells@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Laura Abbott <labbott@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org,
        notify@kernel.org
Subject: Re: [PATCH RFC 2/2] lkdtm: Add heap spraying test
Message-ID: <202008150952.E81C4A52F@keescook>
References: <20200813151922.1093791-1-alex.popov@linux.com>
 <20200813151922.1093791-3-alex.popov@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200813151922.1093791-3-alex.popov@linux.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 13, 2020 at 06:19:22PM +0300, Alexander Popov wrote:
> Add a simple test for CONFIG_SLAB_QUARANTINE.
> 
> It performs heap spraying that aims to reallocate the recently freed heap
> object. This technique is used for exploiting use-after-free
> vulnerabilities in the kernel code.
> 
> This test shows that CONFIG_SLAB_QUARANTINE breaks heap spraying
> exploitation technique.

Yay tests!

> 
> Signed-off-by: Alexander Popov <alex.popov@linux.com>
> ---
>  drivers/misc/lkdtm/core.c  |  1 +
>  drivers/misc/lkdtm/heap.c  | 40 ++++++++++++++++++++++++++++++++++++++
>  drivers/misc/lkdtm/lkdtm.h |  1 +
>  3 files changed, 42 insertions(+)
> 
> diff --git a/drivers/misc/lkdtm/core.c b/drivers/misc/lkdtm/core.c
> index a5e344df9166..78b7669c35eb 100644
> --- a/drivers/misc/lkdtm/core.c
> +++ b/drivers/misc/lkdtm/core.c
> @@ -126,6 +126,7 @@ static const struct crashtype crashtypes[] = {
>  	CRASHTYPE(SLAB_FREE_DOUBLE),
>  	CRASHTYPE(SLAB_FREE_CROSS),
>  	CRASHTYPE(SLAB_FREE_PAGE),
> +	CRASHTYPE(HEAP_SPRAY),
>  	CRASHTYPE(SOFTLOCKUP),
>  	CRASHTYPE(HARDLOCKUP),
>  	CRASHTYPE(SPINLOCKUP),
> diff --git a/drivers/misc/lkdtm/heap.c b/drivers/misc/lkdtm/heap.c
> index 1323bc16f113..a72a241e314a 100644
> --- a/drivers/misc/lkdtm/heap.c
> +++ b/drivers/misc/lkdtm/heap.c
> @@ -205,6 +205,46 @@ static void ctor_a(void *region)
>  static void ctor_b(void *region)
>  { }
>  
> +#define HEAP_SPRAY_SIZE 128
> +
> +void lkdtm_HEAP_SPRAY(void)
> +{
> +	int *addr;
> +	int *spray_addrs[HEAP_SPRAY_SIZE] = { 0 };

(the 0 isn't needed -- and it was left there, it should be NULL)

> +	unsigned long i = 0;
> +
> +	addr = kmem_cache_alloc(a_cache, GFP_KERNEL);

I would prefer this test add its own cache (e.g. spray_cache), to avoid
misbehaviors between tests. (e.g. the a and b caches already run the
risk of getting corrupted weirdly.)

> +	if (!addr) {
> +		pr_info("Unable to allocate memory in lkdtm-heap-a cache\n");
> +		return;
> +	}
> +
> +	*addr = 0x31337;
> +	kmem_cache_free(a_cache, addr);
> +
> +	pr_info("Performing heap spraying...\n");
> +	for (i = 0; i < HEAP_SPRAY_SIZE; i++) {
> +		spray_addrs[i] = kmem_cache_alloc(a_cache, GFP_KERNEL);
> +		*spray_addrs[i] = 0x31337;
> +		pr_info("attempt %lu: spray alloc addr %p vs freed addr %p\n",
> +						i, spray_addrs[i], addr);

That's 128 lines spewed into dmesg... I would leave this out.

> +		if (spray_addrs[i] == addr) {
> +			pr_info("freed addr is reallocated!\n");
> +			break;
> +		}
> +	}
> +
> +	if (i < HEAP_SPRAY_SIZE)
> +		pr_info("FAIL! Heap spraying succeed :(\n");

I'd move this into the "if (spray_addrs[i] == addr)" test instead of the
pr_info() that is there.

> +	else
> +		pr_info("OK! Heap spraying hasn't succeed :)\n");

And then make this an "if (i == HEAP_SPRAY_SIZE)" test

> +
> +	for (i = 0; i < HEAP_SPRAY_SIZE; i++) {
> +		if (spray_addrs[i])
> +			kmem_cache_free(a_cache, spray_addrs[i]);
> +	}
> +}
> +
>  void __init lkdtm_heap_init(void)
>  {
>  	double_free_cache = kmem_cache_create("lkdtm-heap-double_free",
> diff --git a/drivers/misc/lkdtm/lkdtm.h b/drivers/misc/lkdtm/lkdtm.h
> index 8878538b2c13..dfafb4ae6f3a 100644
> --- a/drivers/misc/lkdtm/lkdtm.h
> +++ b/drivers/misc/lkdtm/lkdtm.h
> @@ -45,6 +45,7 @@ void lkdtm_READ_BUDDY_AFTER_FREE(void);
>  void lkdtm_SLAB_FREE_DOUBLE(void);
>  void lkdtm_SLAB_FREE_CROSS(void);
>  void lkdtm_SLAB_FREE_PAGE(void);
> +void lkdtm_HEAP_SPRAY(void);
>  
>  /* lkdtm_perms.c */
>  void __init lkdtm_perms_init(void);
> -- 
> 2.26.2
> 

I assume enabling the quarantine defense also ends up being seen in the
SLAB_FREE_DOUBLE LKDTM test too, yes?

-- 
Kees Cook

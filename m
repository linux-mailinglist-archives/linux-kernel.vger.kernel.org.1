Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51E6626FDB6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 15:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbgIRNAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 09:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgIRNAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 09:00:45 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE19C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 06:00:45 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id y15so5495415wmi.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 06:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=j891grQjxK5nZuL7fttiNE/WOp/HbOWsFeG5TcMiTo4=;
        b=L7TWsV+UaIAuQHc8HWAUPeba9SlshbuAgMe0N4Yt1c9FaI30KVHDceU+jTcsZLTvHB
         Yj/yiotACRxgxBRxC08ptskxyuUDxXEeSnlYEGB0UcvyV8GAvfssA1MVRQHVt9xi8tlw
         aBuogfpXGxbU6FmkL7OuKyg+2++YtRqxb1KKBrG5YV+cKUrU4KESOV1oa3qRFjldHG8F
         rebr1ra97zTituSBdACNoQhSsj03qYx9S6w3v79EAaNaG5PIV+N/PTSK0sKKCheKMo7s
         t8mEqTKKfIS4Ed+Job4F8qPeFloBUr1W78hZVL5cqLBe2lV4+VKlbX2990/b6algGBs5
         unvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=j891grQjxK5nZuL7fttiNE/WOp/HbOWsFeG5TcMiTo4=;
        b=niB8SmG2EOufzHJCXfftZiykxuS8K95KSESElxj6uiNjzJPCq7+ohbDl9JYid3i1bj
         AU87pfdbHv4xnnPBicKcaCJAiHNBSjuOaRcEKhIXBhx6pArA+dlZGQwnT8ie1qQzqC5P
         bdmCctgJBLVksAkpOQZV3jpZKHn3wqPU+48PwN6gf/1Z4fsur7RZpFP/hhxeSSuQa22I
         p1GOCGglbHMjCu8BR9tBY+8ZB48a/aNVVOLLxFPMv7+TIR6/VPGmRu4XTqieTcpiRqZi
         4W2tFjeLWdJA1/ytS+BD3eh837/GqaaYy6mzu69QzxCLj+xHbMHpO8VMQ1bw6ehVzgEJ
         aRRg==
X-Gm-Message-State: AOAM533TvMklABhc7MRTgZ7aOEVnWQwTTPwsjNbM3vevoU0k8mDOBMpC
        5Lu77L8R/wb1HN/G8O5blOS/Eg==
X-Google-Smtp-Source: ABdhPJx3SwbH2SQ/9jKXGd0L8V8Y6NSJCHxq0HnJ0nvlRap+64gWCxVrFlRUpTHRjlE32zq2MqcCHg==
X-Received: by 2002:a1c:e90b:: with SMTP id q11mr15357828wmc.39.1600434043544;
        Fri, 18 Sep 2020 06:00:43 -0700 (PDT)
Received: from elver.google.com ([100.105.32.75])
        by smtp.gmail.com with ESMTPSA id z14sm5226677wrs.76.2020.09.18.06.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 06:00:42 -0700 (PDT)
Date:   Fri, 18 Sep 2020 15:00:37 +0200
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
Subject: Re: [PATCH v2 23/37] arm64: kasan: Add arch layer for memory tagging
 helpers
Message-ID: <20200918130037.GE2384246@elver.google.com>
References: <cover.1600204505.git.andreyknvl@google.com>
 <b52bdc9fc7fd11bf3e0003c96855bb4c191cc4fa.1600204505.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b52bdc9fc7fd11bf3e0003c96855bb4c191cc4fa.1600204505.git.andreyknvl@google.com>
User-Agent: Mutt/1.14.4 (2020-06-18)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 11:16PM +0200, 'Andrey Konovalov' via kasan-dev wrote:
> This patch add a set of arch_*() memory tagging helpers currently only
> defined for arm64 when hardware tag-based KASAN is enabled. These helpers
> will be used by KASAN runtime to implement the hardware tag-based mode.
> 
> The arch-level indirection level is introduced to simplify adding hardware
> tag-based KASAN support for other architectures in the future by defining
> the appropriate arch_*() macros.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Co-developed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---
> Change-Id: I42b0795a28067872f8308e00c6f0195bca435c2a
> ---
>  arch/arm64/include/asm/memory.h |  8 ++++++++
>  mm/kasan/kasan.h                | 19 +++++++++++++++++++
>  2 files changed, 27 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
> index e424fc3a68cb..268a3b6cebd2 100644
> --- a/arch/arm64/include/asm/memory.h
> +++ b/arch/arm64/include/asm/memory.h
> @@ -231,6 +231,14 @@ static inline const void *__tag_set(const void *addr, u8 tag)
>  	return (const void *)(__addr | __tag_shifted(tag));
>  }
>  
> +#ifdef CONFIG_KASAN_HW_TAGS
> +#define arch_init_tags(max_tag)			mte_init_tags(max_tag)
> +#define arch_get_random_tag()			mte_get_random_tag()
> +#define arch_get_mem_tag(addr)			mte_get_mem_tag(addr)
> +#define arch_set_mem_tag_range(addr, size, tag)	\
> +			mte_set_mem_tag_range((addr), (size), (tag))

Suggested edit below, assuming you're fine with checkpatch.pl's new
100col limit:

-#define set_mem_tag_range(addr, size, tag)	\
-				arch_set_mem_tag_range((addr), (size), (tag))
+#define set_mem_tag_range(addr, size, tag)	arch_set_mem_tag_range((addr), (size), (tag))

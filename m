Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E14C2805C8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 19:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732855AbgJARrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 13:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732096AbgJARrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 13:47:09 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E812C0613D0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 10:47:09 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id t10so6815891wrv.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 10:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7E5ey4NET4LMVLLkb7YG6DyEEKXE4OLZrVX+Ejvtxuk=;
        b=IT5todeM+6Ef3KBOJjNaDfGdR6swf3PWlcQXXCMXq9Cf3SqeomknzgGa0+7uMMb3Ls
         WiogPGuF2CR0aIhImDE7FoZm5zcmDyhxDC0wrmqP39hWk8sttOUCjtLUVHHXchd9m1iQ
         YTmQGmUL5TXPKOG3pUQ9Ycz54HjUoLnsMNV/7daTUMpK6ShFTjtqUDiE27QS5L9zg/6l
         fZjK5qIvQP1Zuwkv3EN4TtP4CW58emlnenOePJp+YjtiopUqbxgJ6/FE6SLa7ve4zQMJ
         M7zg+MvPHjwRla7x1OC873Ekr+96Gb4i1u3mwb6z5Ifl0qcBn2tP8I9WTZNxM8Rdi4aG
         dcdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7E5ey4NET4LMVLLkb7YG6DyEEKXE4OLZrVX+Ejvtxuk=;
        b=CJvOz6lDCtpSq4jyuqjONiBdN6ncZmt8/cgAudH64ChKYiFu6LaKB+anDaXCiIGMgE
         ocBRRkjyZIvcXrFAmWCkWok4Mc/yyxibIOru0Fu5vfpGTAzlZLRipamZTXoRSVqGIm1i
         NJuz7lPE/DSIy4PJ3iZGPKEbnyK/SemGIdShLuobo1mpTr48qBlv9RhM58FnbYKDJwTG
         3hxGiYK86XInvQ8murmCC3Y82lskCIVvUohJndCskSb+AOZOeLEGh/XscQnrOgs03X4m
         d6yyxDih+sOv6GjR+6Kxgj0kks62Yjrhhncvk47J66CF/nkH0Gpqye1xJIcwtbnwV0U4
         bQ3Q==
X-Gm-Message-State: AOAM531gJ6zlsGdHmV75GBsG/hIa7GSpGCzEOLvlezHPSlTamweqNZ60
        O5J+VW/jsrMv0sxfnrFZVMQO3w==
X-Google-Smtp-Source: ABdhPJybJ7izNLo5pBqz7NnZrOv9UdPeP5GTyxL7MxTx78gRIYJ8CitZKE7bn0eKShoDi0zlix53SQ==
X-Received: by 2002:adf:f10a:: with SMTP id r10mr9953039wro.86.1601574427998;
        Thu, 01 Oct 2020 10:47:07 -0700 (PDT)
Received: from elver.google.com ([100.105.32.75])
        by smtp.gmail.com with ESMTPSA id m13sm10484423wrr.74.2020.10.01.10.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 10:47:07 -0700 (PDT)
Date:   Thu, 1 Oct 2020 19:47:01 +0200
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
Subject: Re: [PATCH v3 18/39] kasan: kasan_non_canonical_hook only for
 software modes
Message-ID: <20201001174701.GN4162920@elver.google.com>
References: <cover.1600987622.git.andreyknvl@google.com>
 <ff0f9a3bab9d2b99580f436121812d1eee560b44.1600987622.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff0f9a3bab9d2b99580f436121812d1eee560b44.1600987622.git.andreyknvl@google.com>
User-Agent: Mutt/1.14.5 (2020-06-23)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25, 2020 at 12:50AM +0200, Andrey Konovalov wrote:
> This is a preparatory commit for the upcoming addition of a new hardware
> tag-based (MTE-based) KASAN mode.
> 
> kasan_non_canonical_hook() is only applicable to KASAN modes that use
> shadow memory, and won't be needed for hardware tag-based KASAN.
> 
> No functional changes for software modes.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

Reviewed-by: Marco Elver <elver@google.com>

> ---
> Change-Id: Icc9f5ef100a2e86f3a4214a0c3131a68266181b2
> ---
>  mm/kasan/report.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> index 9e4d539d62f4..67aa30b45805 100644
> --- a/mm/kasan/report.c
> +++ b/mm/kasan/report.c
> @@ -371,7 +371,8 @@ bool kasan_report(unsigned long addr, size_t size, bool is_write,
>  	return ret;
>  }
>  
> -#ifdef CONFIG_KASAN_INLINE
> +#if (defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)) && \
> +	defined(CONFIG_KASAN_INLINE)
>  /*
>   * With CONFIG_KASAN_INLINE, accesses to bogus pointers (outside the high
>   * canonical half of the address space) cause out-of-bounds shadow memory reads
> -- 
> 2.28.0.681.g6f77f65b4e-goog
> 

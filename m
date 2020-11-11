Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC0252AF6BB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 17:42:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727377AbgKKQmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 11:42:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727132AbgKKQmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 11:42:12 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7350EC0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 08:42:11 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id h62so2924367wme.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 08:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NA9CfSTIvFjKTTcCo0GBZExn6gG0rmPxEPFJJSh1HC0=;
        b=iZzMR3JKsn93UQVuTMqTVw5jkQ1FGXVEQsHhGkoysIut9rmfaPAa8DVtehRc7lGzfe
         aNPv9TKKFxCOHIJ/CU2qJQ3JIqcbOSthY9sia/hj0eY+JW7EOcadtLWbr/32Z1WTuyNc
         4UTo5D+p+doIy5vHjS1uS9SsI4cUsE0lfDpUgaLPMFvbB8ZxFy0p2s0DQUBxSWG3ShxC
         cotGgQaeyl0G9VaccrjlJvtBXneLiqdOWB8EQfLWlh02FHwknCDZpNYdPJfBJFq0uQGO
         9AHI7KIRSFoz4MxXnpYSKgolrCtrhdflo+46YRBtHH8uFiAS/ZZz9ibPQAb1J/L9glnw
         x6hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NA9CfSTIvFjKTTcCo0GBZExn6gG0rmPxEPFJJSh1HC0=;
        b=qxBJS8LTyHJr9YS+c7zBTX/qOVFIXDTGKlG3oBxqLsxLTZXhxoVp+bGnxY9mckh8c8
         Tz1WXzyX+Hv+o2/XbLqCtQURfqwAR8RRQrXfTXuoyWkgrON8PAS6EpMO5xNntDR/n6tD
         3KYTsywBjUMed4WLh6OWtopy4GPLe2jH70CtmB2DD+BayoKqXXZ77Mxb8dOZRtwWwX3R
         bQ/9T+kReicdRpaAVKFSZBT+5FJzlk8oV0+D046sTIRAoHBUd8vM9c4fJs+jPDqXhfde
         UsYsdf2O0UvFTUv3RRtGsijiWVBmXz/l3PUEd5/7/3vBrRU5zGH9gegOQnQc6ZInJ48V
         cdOw==
X-Gm-Message-State: AOAM532RdNrBQzouDaA0sKdbFAucMOU+mxCFFYC61jSUKC3XOeoaWUTM
        FbngCAcQxfK6eENgK2e++JwgdQ==
X-Google-Smtp-Source: ABdhPJzfOwchmgvUgHIEbEtU/j17AwAW695XbMtbpMUR0Zd+jCJBV5jjIXbQ8MplaBj3uPb3toGRyQ==
X-Received: by 2002:a1c:6a11:: with SMTP id f17mr4945240wmc.24.1605112929933;
        Wed, 11 Nov 2020 08:42:09 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:f693:9fff:fef4:2449])
        by smtp.gmail.com with ESMTPSA id z19sm3076154wmk.12.2020.11.11.08.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 08:42:09 -0800 (PST)
Date:   Wed, 11 Nov 2020 17:42:03 +0100
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
Subject: Re: [PATCH v2 06/20] kasan: remove __kasan_unpoison_stack
Message-ID: <20201111164203.GH517454@elver.google.com>
References: <cover.1605046662.git.andreyknvl@google.com>
 <462c375f39ba8c4c105b3a9bf3b5db17f3720159.1605046662.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <462c375f39ba8c4c105b3a9bf3b5db17f3720159.1605046662.git.andreyknvl@google.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 11:20PM +0100, Andrey Konovalov wrote:
> There's no need for __kasan_unpoison_stack() helper, as it's only
> currently used in a single place. Removing it also removes unneeded
> arithmetic.
> 
> No functional changes.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
> Link: https://linux-review.googlesource.com/id/Ie5ba549d445292fe629b4a96735e4034957bcc50
> ---
>  mm/kasan/common.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)

Reviewed-by: Marco Elver <elver@google.com>

Thanks for spotting this simplification.

> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index a3e67d49b893..9008fc6b0810 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -59,18 +59,12 @@ void kasan_disable_current(void)
>  #endif /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
>  
>  #if CONFIG_KASAN_STACK
> -static void __kasan_unpoison_stack(struct task_struct *task, const void *sp)
> -{
> -	void *base = task_stack_page(task);
> -	size_t size = sp - base;
> -
> -	kasan_unpoison_memory(base, size);
> -}
> -
>  /* Unpoison the entire stack for a task. */
>  void kasan_unpoison_task_stack(struct task_struct *task)
>  {
> -	__kasan_unpoison_stack(task, task_stack_page(task) + THREAD_SIZE);
> +	void *base = task_stack_page(task);
> +
> +	kasan_unpoison_memory(base, THREAD_SIZE);
>  }
>  
>  /* Unpoison the stack for the current task beyond a watermark sp value. */
> -- 
> 2.29.2.222.g5d2a92d10f8-goog
> 

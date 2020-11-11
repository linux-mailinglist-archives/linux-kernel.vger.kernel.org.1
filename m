Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2293F2AF859
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 19:43:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbgKKSmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 13:42:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725979AbgKKSmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 13:42:55 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00315C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 10:42:54 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id j7so3545659wrp.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 10:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VohxCgmaGc6F7Ktsca4rjVlrZ86gTh1fROnDD+cvua8=;
        b=q5lLWorcNvq+9Yc6F6OpKuLSxNfpexysmfo67YGIJQm9USpyAY1a0El1997oZE4wkP
         8oqytOtFLxzPFKfILJzTJgYc46xAEBJFyWtuM1LTEETuUfNL/KuH8ikBmZDq/UqQ/Id/
         E76iFLtXpDU/wuvo8+MAmKHQCxr/+4O4OJqc5u5N9uJbn25p6NqFNx+WALMGSWhTODnh
         kD66Fx1jLku1gDyfDnSOvkDgGCyu+iraGYhFX9JP4kQehD2F7J+O34XvINm9mbxUzcAS
         hQoG/Tiqe7+nF2rMK/813dHUyO2G+HXvIe2S5qscLlRg2Xzo7BlnfmqUHUy+lnNI4FXY
         5KCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VohxCgmaGc6F7Ktsca4rjVlrZ86gTh1fROnDD+cvua8=;
        b=tN4nSlHgsTYp2Iy63fQp++xcaCgN5eiSgKu8Q/dQwBUg+M8gX+JYZJR/9h/CAujOj+
         yVh+pWgbKegZHYbF6xCeiCGo13Rh6mMTFQuI1124w5Q1CF+PKt8HpIbJq5VFggK+DD66
         SLgq8RuMTkqlWhx1rGOovDPyyNN4QtfXmAF7f5TuCotbMURujD9uBlTMKjRPo307h7CP
         Wb+hPXNNYXuiW/dRVA11jGlyc/Xm4rIY/xG8KlnOt7F7Dsz+PcWkvZYwKOGcHSJ4ejO1
         D5wWLohN5gTAR6mcMbcT9FZxHAKC+P0C8cGnzLPSR4YPJOTE0nTptHOj07wa6Vr6GdUO
         +dUg==
X-Gm-Message-State: AOAM53006DlNv/2jyVFSPg9AjKNDVenlZU4FF4eYnflxCfF/QsDbMqNA
        A7Dj7S2+S+7hljzf18bQ9dVyEQ==
X-Google-Smtp-Source: ABdhPJwhO/pOEHygpEN38k/rCWZcOpBcvG2IP4pMbw5LM7pzlX+NSLqrby7G/rFyaxB3/C6to3EXwQ==
X-Received: by 2002:a5d:66c3:: with SMTP id k3mr26447563wrw.123.1605120173432;
        Wed, 11 Nov 2020 10:42:53 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:f693:9fff:fef4:2449])
        by smtp.gmail.com with ESMTPSA id n10sm3431496wrv.77.2020.11.11.10.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 10:42:52 -0800 (PST)
Date:   Wed, 11 Nov 2020 19:42:46 +0100
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
Subject: Re: [PATCH v2 13/20] kasan: simplify kasan_poison_kfree
Message-ID: <20201111184246.GO517454@elver.google.com>
References: <cover.1605046662.git.andreyknvl@google.com>
 <a1c57043fb19effce240355e7c57b0d9a58d389e.1605046662.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1c57043fb19effce240355e7c57b0d9a58d389e.1605046662.git.andreyknvl@google.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 11:20PM +0100, Andrey Konovalov wrote:
> kasan_poison_kfree() is currently only called for mempool allocations
> that are backed by either kmem_cache_alloc() or kmalloc(). Therefore, the
> page passed to kasan_poison_kfree() is always PageSlab() and there's no
> need to do the check. Remove it.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
> Link: https://linux-review.googlesource.com/id/If31f88726745da8744c6bea96fb32584e6c2778c
> ---
>  mm/kasan/common.c | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)

Reviewed-by: Marco Elver <elver@google.com>

> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index 385863eaec2c..819403548f2e 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -432,16 +432,7 @@ void __kasan_poison_kfree(void *ptr, unsigned long ip)
>  	struct page *page;
>  
>  	page = virt_to_head_page(ptr);
> -
> -	if (unlikely(!PageSlab(page))) {
> -		if (ptr != page_address(page)) {
> -			kasan_report_invalid_free(ptr, ip);
> -			return;
> -		}
> -		kasan_poison_memory(ptr, page_size(page), KASAN_FREE_PAGE);
> -	} else {
> -		____kasan_slab_free(page->slab_cache, ptr, ip, false);
> -	}
> +	____kasan_slab_free(page->slab_cache, ptr, ip, false);
>  }
>  
>  void __kasan_kfree_large(void *ptr, unsigned long ip)
> -- 
> 2.29.2.222.g5d2a92d10f8-goog
> 

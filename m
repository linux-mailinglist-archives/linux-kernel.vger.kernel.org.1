Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF1F2AF8DD
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 20:18:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727660AbgKKTSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 14:18:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgKKTSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 14:18:51 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA90C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 11:18:49 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id o15so3629832wru.6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 11:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OKGISrzawD1j8o64KuvlnCYWWA4Vpka6a0oknsEcZJw=;
        b=QIq5tT271m/1hqoWebW5vn4gjE/Uwv/AdBTyMmJwHN2JQe6QEGa0ZyGDwW6pU2iNaT
         5SWCsDGxemAKPn6UMPHGqapWwXqzT/tOgSvb7qjVq3EmSur3oge2ITFmLWRO1weKQ99e
         IqxOfQIYjxxcx97KM1S+pB8TwWWjVAxxOd1lpoLpAQqdar/u4S1v5lopqNcn8oPupLJ4
         JUItXv4lAOfU9oUFxlzWSjpn5+1KdyCLApwweGeHB7g+t8KKTWYHMLFDAXdnKEe7rK5g
         DA0SDqguVeNm3rnLi/KgQK19t/068ksnmR/iirxFZo/9cE4HHAYkwQzXde0T+p3RAkgQ
         p4yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OKGISrzawD1j8o64KuvlnCYWWA4Vpka6a0oknsEcZJw=;
        b=IMKAUWyDHunOx0CyVa1PaiyjLtWI7QSf2BvixzeD7Qb6hZiEZDzb2aPAIvjC0ohjhT
         MvULaElIDZgnPBFy7rKMRjU2nKpq5u5I1JEUT46tQzSOO75ePSLz+DJx7FVK4V87V4T3
         NjJ58dz0FryXU788AqLTtGeA6g47PhuMyLagK08XgMRNuAXFURrDHd1XkqbJWKmlfv4l
         9BiCLso1AcDaoYbzsgDiTUfbnBrmwPBLHa71Mq8D1OPXSRoCRQvbGkZP8IZ4iOiu4Qx6
         PV55GtfQZp/3cK4DyTyoh58DdxyrPS9EgmmwLNmrEh+pCGMDHEwdHieQCUMWB+YaXQzY
         XCvA==
X-Gm-Message-State: AOAM533EUdG+nJ+VAQ6Z3rHwGKoo9fhGVjVlPSxecdSCSWjZ0o0OBwct
        txFpWTiNSAgCBeCfn+E59CuyWw==
X-Google-Smtp-Source: ABdhPJy+Ds6tB3o1+P+c80bWAGxCKjWqrwUjd7Kqi8jPSulhfgKnbIsHBik9b8Ze1Rj5O2bj8ybVjQ==
X-Received: by 2002:adf:f644:: with SMTP id x4mr32047323wrp.5.1605122327874;
        Wed, 11 Nov 2020 11:18:47 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:f693:9fff:fef4:2449])
        by smtp.gmail.com with ESMTPSA id c6sm3806761wrh.74.2020.11.11.11.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 11:18:47 -0800 (PST)
Date:   Wed, 11 Nov 2020 20:18:41 +0100
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
Subject: Re: [PATCH v2 17/20] kasan: clarify comment in __kasan_kfree_large
Message-ID: <20201111191841.GS517454@elver.google.com>
References: <cover.1605046662.git.andreyknvl@google.com>
 <dd492a97ed68200b1d7e2dce55ed9a7790525396.1605046662.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd492a97ed68200b1d7e2dce55ed9a7790525396.1605046662.git.andreyknvl@google.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 11:20PM +0100, Andrey Konovalov wrote:
> Currently it says that the memory gets poisoned by page_alloc code.
> Clarify this by mentioning the specific callback that poisons the
> memory.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
> Link: https://linux-review.googlesource.com/id/I1334dffb69b87d7986fab88a1a039cc3ea764725
> ---
>  mm/kasan/common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Marco Elver <elver@google.com>

> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index 40ff3ce07a76..4360292ad7f3 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -436,5 +436,5 @@ void __kasan_kfree_large(void *ptr, unsigned long ip)
>  {
>  	if (ptr != page_address(virt_to_head_page(ptr)))
>  		kasan_report_invalid_free(ptr, ip);
> -	/* The object will be poisoned by page_alloc. */
> +	/* The object will be poisoned by kasan_free_pages(). */
>  }
> -- 
> 2.29.2.222.g5d2a92d10f8-goog
> 

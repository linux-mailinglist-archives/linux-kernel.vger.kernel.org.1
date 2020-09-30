Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59ECE27F3D7
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 23:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730586AbgI3VDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 17:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730505AbgI3VDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 17:03:06 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2865AC061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 14:03:05 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id f142so2997100qke.13
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 14:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZRNUEYokhV3ZutF68bV0ggq8sZtd21gQc+Q8hzdPDf0=;
        b=ZPMlqzGeCEiHwTpGNWQLeLMFfU7QFks6fD3heUFDiL6Fl+RiNeu1Cobjoo+BJcl93S
         hzMxUPbOGOe08lo/KW6S733CLxTmV8j/zDx4ZrFhZQvhcJ1fkW49L+YZLt1PKE13PyZv
         syxAZoY7aX0VsFPIhYp8JUj46b2AO7cv+6ELGA1fSWw8e5JeJiJnY0cQ8k6a9yzb6gY7
         uvb+pQciV2SKlPiAsWmDawryvdqq8Brn8QblFklUWhH62A+qSu6oa/K7STMbVXrIJbub
         b1ZyvdPyGax23mJx9drhhJtzR2QXHZ+blG3/wN2QtP6sfAVAyQabpVT+Cd1pTnTfgd7P
         Zs/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZRNUEYokhV3ZutF68bV0ggq8sZtd21gQc+Q8hzdPDf0=;
        b=OQzW3pMpoeQBfjnCJz5oS5/iMbnQSVoB859kZSlakQtJZqnL2fNbP8b6CqJrhBc09Q
         jrqiSxHH+unzxywGqYjTM7zlxHpNgkuxdbZe06d/wzlfs9r+4dneTx3MHafANeLMOZEw
         m68WMd4o9AVAMR0lWmVYu/aSlhE+Q30lMTBEX7CLUzLHosnjZIbrBcdvi3tZKBDmI9Pq
         5fGJHLz78Um5vYTXN5twpKKSacv9D/8aotmsnqXGEnoEgAw6hDG0v2JP6k9UopxyHtcG
         RNieCc+FF/Fmnw56JCuq6CdF11+N7Y9QSGWYWyWGJ/vkLobQtML/ZYt1hPd0A9VptoDi
         ItPw==
X-Gm-Message-State: AOAM533jcBlnMtimTGNMKZYdlhaDKjHtZm5MY+B2zmn+lAY9K/gg99S3
        6ovHBRsKF8iY9pONTn2ErVVqsw==
X-Google-Smtp-Source: ABdhPJweyidEzcAjSdMU/ZGDN0yZ4JtMYv5rz4uyhcVHpfgAjWjXCssDh/lwfcnPQ1yvxD4ac4XsIQ==
X-Received: by 2002:a37:d41:: with SMTP id 62mr4375984qkn.444.1601499784348;
        Wed, 30 Sep 2020 14:03:04 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:4e22])
        by smtp.gmail.com with ESMTPSA id 8sm3571982qkc.100.2020.09.30.14.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 14:03:03 -0700 (PDT)
Date:   Wed, 30 Sep 2020 17:01:24 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, kernel-team@fb.com
Subject: Re: [PATCH v3 4/4] mm: convert page kmemcg type to a page memcg flag
Message-ID: <20200930210124.GB469663@cmpxchg.org>
References: <20200929235920.537849-1-guro@fb.com>
 <20200929235920.537849-5-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929235920.537849-5-guro@fb.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 29, 2020 at 04:59:20PM -0700, Roman Gushchin wrote:
> @@ -3087,7 +3087,7 @@ int __memcg_kmem_charge_page(struct page *page, gfp_t gfp, int order)
>  		ret = __memcg_kmem_charge(memcg, gfp, 1 << order);
>  		if (!ret) {
>  			set_page_memcg(page, memcg);
> -			__SetPageKmemcg(page);
> +			__SetPageMemcgKmem(page);
>  			return 0;
>  		}
>  		css_put(&memcg->css);
> @@ -3112,10 +3112,6 @@ void __memcg_kmem_uncharge_page(struct page *page, int order)
>  	__memcg_kmem_uncharge(memcg, nr_pages);
>  	clear_page_memcg(page);
>  	css_put(&memcg->css);
> -
> -	/* slab pages do not have PageKmemcg flag set */
> -	if (PageKmemcg(page))
> -		__ClearPageKmemcg(page);

Hm, the named flags are great, and the getter functions are complex
enough to justify helpers.

But both flags are set along with the object pointer, and cleared when
the pointer is cleared (which makes sense, because pages can not
change their type while they're alive). page_clear_memcg() and
page_clear_objcgs() do the same thing.

	page->memcg_data = (unsigned long)pointer | MEMCG_DATA_TYPE;

and

	page->memcg_data = 0;

are straight-forward and really don't require abstraction. Please
open-code these.

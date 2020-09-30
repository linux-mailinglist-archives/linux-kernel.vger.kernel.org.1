Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 407FE27F3F1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 23:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730782AbgI3VIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 17:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730090AbgI3VIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 17:08:30 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C38AC061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 14:08:30 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id cy2so1732286qvb.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 14:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Z7NVwPN8FRHND4Ps48IR2LCzL7gRCF/0sN8/Bym6zig=;
        b=ZryS3Vhs/ofsUE6v35rSZRt18BInVxIR7lit/zAiHuB2RI4CW2JpdCHvQDqz5Fj/D0
         RM9fkXcPqT8+ae4H5/XrqyXF75V7radXS10OrcFfRB8hFY3/Xk1CRkUmrjRaq8HFrVFi
         e8KzvURuZ+v5uIJR5bm4WHKCaO5QvV3PKcJZFh3GozMdRRnaCu7VLXBQ9rcHEjunF2Me
         dvLmiB6pHwrIoOz70OGKiK3Nx35dyoSf1+dhiFiamonFDdYcVQdwoax1NRt8hlO0q2ns
         a/GIW1kMCv6MSFVwzYDd4ewDwYE8RDwK67at1wrTb2KHvzFaRvoNWaUvCRjahg09AOmW
         72TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Z7NVwPN8FRHND4Ps48IR2LCzL7gRCF/0sN8/Bym6zig=;
        b=JV8XbPzZyipQgzxUf7XsUG+N+dpZeCXruBVtgUKd0qHRlRW3A4sbgX4jruEhsemHiM
         K+Kvz5O6vTugTW4ZQd/aqrZ/fFD3CbgzF+ue6lELOBfkR6F4zceL1foYGmWnFd1zgbVc
         RAvHQXUXdR1snexDcz8QgRsD9MW7qunmQtaknRntTPDlEireMhupY87JoLQJMgpsyn8i
         G8uhstD1RaYWiopsSwsB/ULspbJqC3ZQgPo6hUOq4oGj3q+0xxYS76H5630BE9SkOz/B
         twXqIDuz3hKK6Mcg/JTQtmke//A8StmbUCGbv9bq2NZc0T15idb8XxbmxhRTqSbIQIYP
         nG8A==
X-Gm-Message-State: AOAM533Kci/kdMB0QfShRqpwovXu+O6BLkpTIyLKc/zoGfVrwVNEstiP
        eiPfDvdJDle6vLyJEP63x1cjjQ==
X-Google-Smtp-Source: ABdhPJylrxzDw10S8wdwfzc4qRuprS+dQI3GNj3BwxTD2mWlLNUgLp8OAj62OYTcRfIhK+gPi6M/Vg==
X-Received: by 2002:a0c:8d84:: with SMTP id t4mr4636011qvb.36.1601500109236;
        Wed, 30 Sep 2020 14:08:29 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:4e22])
        by smtp.gmail.com with ESMTPSA id k5sm3498676qkc.45.2020.09.30.14.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 14:08:28 -0700 (PDT)
Date:   Wed, 30 Sep 2020 17:06:49 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, kernel-team@fb.com
Subject: Re: [PATCH v3 4/4] mm: convert page kmemcg type to a page memcg flag
Message-ID: <20200930210649.GC469663@cmpxchg.org>
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
> @@ -449,6 +455,36 @@ static inline void clear_page_memcg(struct page *page)
>  	page->memcg_data = 0;
>  }
>  
> +/*
> + * PageMemcgKmem - check if the page has MemcgKmem flag set
> + * @page: a pointer to the page struct
> + *
> + * Checks if the page has MemcgKmem flag set. The caller must ensure that
> + * the page has an associated memory cgroup. It's not safe to call this function
> + * against some types of pages, e.g. slab pages.
> + */
> +static inline bool PageMemcgKmem(struct page *page)
> +{
> +	VM_BUG_ON_PAGE(test_bit(MEMCG_DATA_OBJCGS, &page->memcg_data), page);
> +	return test_bit(MEMCG_DATA_KMEM, &page->memcg_data);

Most other places need the bit mask and have to do ad-hoc shifting,
which is verbose and causes awkward line wrapping in various places.

There are no atomic accesses here, so there is no need to use the
atomic bitop interface here. I feel like I've mentioned this before.

Just make the MEMCG_DATA_ items bitfields directly, and do

	return page->memcg_data & MEMCG_DATA_KMEM

here.

Thanks

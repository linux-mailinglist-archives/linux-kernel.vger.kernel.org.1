Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 903DD28E34C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 17:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389357AbgJNP2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 11:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbgJNP2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 11:28:50 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B4DC061755
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 08:28:49 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id x1so3595472eds.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 08:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PiKeKQoLzWt1QYVrhRU+DXp7wjY+FIyozth8EY2CA0o=;
        b=TsZIkF/GcftCA8xQTGW3ms4PDi/84/N9unKIGLkZ2jX3+Kt3PMJP4wVwbvun2MGte3
         sVPBAG8ouQP8QLgNSbyUSo9qrja4GXjhB3wRIbLWaqI45cKKbXY78rO2djLfL0LI/hpF
         UZ6wwn+E0qpyUPS3g8Tmkiro6ekqNwACoUSl+bCK4dh78az8nfwIkQaDCuxDPzUHuSkb
         OJFWHc3da5fdgMOITOGGSbrDTT97cihcAYIDIfGNXIRNBCAAZWAa+//kR55chKyZvN+5
         6NNQStsLRRssqQDAm2FAO3WUh0x+IdXg4lkuO9JPhjBlenz4EC1+wOxte2MU1m19DGKK
         7oeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=PiKeKQoLzWt1QYVrhRU+DXp7wjY+FIyozth8EY2CA0o=;
        b=dF88gbU3aT6BUSyveu2B4NMHoGbqDW9a4CMp9PF0RjqcCSkoyUkz0jubCvLw07p5kr
         6LHLUZp2vigIQzHOEWBTaOy32maqQCXN0CTkfYSmkN0cYjSVt/qQo9+t0G20xq3rApXZ
         vkK4L/aFgx4hL8xAdii5Bitrl3SEMMf9kpiDBbWUNE/nL1AaLduSHBpQe8O3oThi/Hkz
         lIZmvWLCwcYs9+TRxwPWjau6skzoejcwSRZ60PO/6rjxofubXjhpAdOn9be145hmOC3j
         69tzcKjecWLjzQVzBuVdCl5fEWTlY7zQAHMVvc8UiBM42UYW8Nw4ab15ZiDYRHnFQIe7
         ZcAA==
X-Gm-Message-State: AOAM532MpsWjEeFbJPPczaIthQHxfee/vjd9xB3kSFXHXiJM6NIYN/xd
        7CYiHhrZ6HrWGi2dIAp+6wo=
X-Google-Smtp-Source: ABdhPJzytO8Dk37gQIukjrHDqdvFHEItJgb9Ly8H8N/sG64uYgJ1Y1an5mQH8AoI0RUFJdWoqKwRWw==
X-Received: by 2002:a50:871d:: with SMTP id i29mr5956976edb.300.1602689327788;
        Wed, 14 Oct 2020 08:28:47 -0700 (PDT)
Received: from gmail.com (563B81C8.dsl.pool.telekom.hu. [86.59.129.200])
        by smtp.gmail.com with ESMTPSA id y6sm1762190eds.93.2020.10.14.08.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2020 08:28:46 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 14 Oct 2020 17:28:45 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Ankur Arora <ankur.a.arora@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kirill@shutemov.name, mhocko@kernel.org,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6/8] mm, clear_huge_page: use clear_page_uncached() for
 gigantic pages
Message-ID: <20201014152845.GA1424414@gmail.com>
References: <20201014083300.19077-1-ankur.a.arora@oracle.com>
 <20201014083300.19077-7-ankur.a.arora@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201014083300.19077-7-ankur.a.arora@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Ankur Arora <ankur.a.arora@oracle.com> wrote:

> Uncached writes are suitable for circumstances where the region written to
> is not expected to be read again soon, or the region written to is large
> enough that there's no expectation that we will find the writes in the
> cache.
> 
> Accordingly switch to using clear_page_uncached() for gigantic pages.
> 
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> ---
>  mm/memory.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index eeae590e526a..4d2c58f83ab1 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -5092,7 +5092,7 @@ static void clear_gigantic_page(struct page *page,
>  	for (i = 0; i < pages_per_huge_page;
>  	     i++, p = mem_map_next(p, page, i)) {
>  		cond_resched();
> -		clear_user_highpage(p, addr + i * PAGE_SIZE);
> +		clear_user_highpage_uncached(p, addr + i * PAGE_SIZE);
>  	}
>  }

So this does the clearing in 4K chunks, and your measurements suggest that 
short memory clearing is not as efficient, right?

I'm wondering whether it would make sense to do 2MB chunked clearing on 
64-bit CPUs, instead of 512x 4k clearing? Both 2MB and GB pages are 
continuous in memory, so accessible to these instructions in a single 
narrow loop.

Thanks,

	Ingo

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6A882779ED
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 22:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbgIXUIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 16:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbgIXUId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 16:08:33 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F8EC0613D6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 13:02:56 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id cr8so152868qvb.10
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 13:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=V6UdUdkmkvok2W93q7i5z7Tnyyn+1qXAK4+CaS4d9dg=;
        b=AjvHKaw4mi9aIoc/WkGzvkf247jeN/YEE4XZED2eYU203MUOwuyVP6BIdt27dZ5Uv2
         Vwm/AnZjhBsuoIlALObXtvkXbsMYtqOjVjHHBWGUkTSnq4Kn8OgbakWt82URN5SWYKsK
         xrKpxzu81GsDBCk6f2x4+K+IV289VvQLK3yqL0SuncB9riMXQyx5OjZ1KiAHsLjBnRRe
         wdSMAWV6k6pBoZfzW7tVgiXFgfVVtVJcn5KqjdSL8uCpDewUOfoEOw/8fwflhoHOx2QI
         9aOJKQli2QY4QIymcHTe5Pqhu5OHN7xMlt4hgfGSThLVOMn2j+HlYLDAOR8ZS0o5I+B4
         z9QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=V6UdUdkmkvok2W93q7i5z7Tnyyn+1qXAK4+CaS4d9dg=;
        b=PWsmfnM145GsvlHteACTqP/tiMqqx4MA/VTPju3OK/Ngfq4bVoQv+2cnXYqcXYKH3c
         dM6xGLhVYqulSTUaPFNJ0HFup//GcsRVBxEdPJonCjxpvkfTzJ3i8Wyx45/u0S6u0Vi8
         7Mhzhy/GqlD0XC++1558NW3wbYfreeO4yYBFVjHItzk33tkukQJKbqGT3XcLEaXKA8Uw
         dUhWo7xe9lsGO5wF/vl87ex2DW7u8l1fhogUXmjYqW/FQqZQsJ4whZPeCpBSDjjlVKN5
         gJsFryP7Io3181i0Eq7OWM/5PNtRxWsaaM2vm0R2+z7yOZda5TZucDHVAw8+9fKwmJ7p
         UW3Q==
X-Gm-Message-State: AOAM531LXmBHlZ3dUZOJDeTsopQH6AIx9R+XOPgFUhKZkoLEW3T3sn+V
        F+xNV+mq7cRF3at+L3YK9115SQ==
X-Google-Smtp-Source: ABdhPJwQ58cQqwPYpnLzikAMkGBaC11Z6mEv8T+V8eydsQEavysyUGWO0mF3RmUMHBGQK43jVk1dMQ==
X-Received: by 2002:a0c:8406:: with SMTP id l6mr834013qva.15.1600977775408;
        Thu, 24 Sep 2020 13:02:55 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:4d7a])
        by smtp.gmail.com with ESMTPSA id f8sm384545qtx.81.2020.09.24.13.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 13:02:54 -0700 (PDT)
Date:   Thu, 24 Sep 2020 16:01:22 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, kernel-team@fb.com
Subject: Re: [PATCH v1 3/4] mm: introduce page memcg flags
Message-ID: <20200924200122.GC329853@cmpxchg.org>
References: <20200922203700.2879671-1-guro@fb.com>
 <20200922203700.2879671-4-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922203700.2879671-4-guro@fb.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 01:36:59PM -0700, Roman Gushchin wrote:
> The lowest bit in page->memcg_data is used to distinguish between
> struct memory_cgroup pointer and a pointer to a objcgs array.
> All checks and modifications of this bit are open-coded.
> 
> Let's formalize it using page memcg flags, defined in page_memcg_flags
> enum and replace all open-coded accesses with test_bit()/__set_bit().
> 
> Few additional flags might be added later. Flags are intended to be
> mutually exclusive.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>
> ---
>  include/linux/memcontrol.h | 29 +++++++++++++++++++----------
>  1 file changed, 19 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index ab3ea3e90583..9a49f1e1c0c7 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -343,6 +343,11 @@ struct mem_cgroup {
>  
>  extern struct mem_cgroup *root_mem_cgroup;
>  
> +enum page_memcg_flags {
> +	/* page->memcg_data is a pointer to an objcgs vector */
> +	PG_MEMCG_OBJ_CGROUPS,

How about enum memcg_data_flags and PGMEMCG_OBJCG?

> @@ -371,13 +376,7 @@ static inline struct mem_cgroup *page_mem_cgroup_check(struct page *page)
>  {
>  	unsigned long memcg_data = page->memcg_data;
>  
> -	/*
> -	 * The lowest bit set means that memcg isn't a valid
> -	 * memcg pointer, but a obj_cgroups pointer.
> -	 * In this case the page is shared and doesn't belong
> -	 * to any specific memory cgroup.
> -	 */
> -	if (memcg_data & 0x1UL)
> +	if (test_bit(PG_MEMCG_OBJ_CGROUPS, &memcg_data))
>  		return NULL;
>  
>  	return (struct mem_cgroup *)memcg_data;
> @@ -422,7 +421,13 @@ static inline void clear_page_mem_cgroup(struct page *page)
>   */
>  static inline struct obj_cgroup **page_obj_cgroups(struct page *page)
>  {
> -	return (struct obj_cgroup **)(page->memcg_data & ~0x1UL);
> +	unsigned long memcg_data = page->memcg_data;
> +
> +	VM_BUG_ON_PAGE(memcg_data && !test_bit(PG_MEMCG_OBJ_CGROUPS,
> +					       &memcg_data), page);
> +	__clear_bit(PG_MEMCG_OBJ_CGROUPS, &memcg_data);

The flag names make sense to me, but this shouldn't be using test_bit,
__clear_bit, __set_bit etc. on local variables. It suggests that it's
modifying some shared/global state, when it's just masking out a bit
during a read. We usually just open-code the bitwise ops for that.

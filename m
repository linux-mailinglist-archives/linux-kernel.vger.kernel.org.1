Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB1262779C7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 21:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbgIXTzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 15:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbgIXTz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 15:55:29 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92204C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 12:55:29 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id q5so717424qkc.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 12:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5Op4Hiq5hd5n1kw3kp86fKeHLeQWSXD9jmdVx/Yl5kY=;
        b=ob57nNMkag2afv4/5GijO9UhiVrufPCWTRekf9ZnP9YnX0uOutw01N8roWEPAYX1Y3
         GSIrgdgC4g2Ba3SCB+RIRl8VAqs8HofBralaCoTnhLk3C81eHmjWM6a/Sm76Zvb5NgQV
         zVJ/GR5X1x0usbNS6ElCjXwqfkzNMGYVLhhB/IJ6qKK9tSd8SEKviN8xLHq2UJzBlqgT
         UlH9lYz91lhJIggqVW2FcOhAPOUKfnAi8YRTEzZBospPmZ1HqV+g6dY0Dh+0a88f0MPI
         enXA8rziuHCgvdLYaxFWllxDb7l5KZdV0rxnhsRC6GpYdAZy+x7cTbnnGggJGwkW9MvE
         ARDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5Op4Hiq5hd5n1kw3kp86fKeHLeQWSXD9jmdVx/Yl5kY=;
        b=d9rx45sWJrOn51fluhgfR6gc5hWfgQkgPg4qhvK4w+vP0kXymjNltqDOQ0AiKL7l9K
         aUN4e/2R8icQTptpRs/QmROSE8qNO3VYuAgssNN0bZ2me3f0bsJY9VKvp7O7l6zdjpMO
         JkqYIcQA4luKB/8i1Pb2JAaZEXN0zS0I+okQp511AYiZcNmK3RslAQMOCkFN+sUrhKWZ
         ruocw1E+Fs12A41vNVDrOHkRi+QgQ28R6z/jiuqh0QWBajE9g7WRPCj5JDv4FjJp/k69
         crj+7Rf7rcWg1xKQ5r+QSH+cqZcrurrB0HVUsx0TnmL5kOviP5Mt6EEPo6fe2dqIJvNC
         P+5g==
X-Gm-Message-State: AOAM531N1OeaoLRoWlUosseO2bAWTsjoxwAdhyJA6rsajSn+wxeRAJ6m
        6Pq8K8tkNQnsOY3JoOA5529kjEsIO3GDyw==
X-Google-Smtp-Source: ABdhPJzJhT+2V8A7srU+lM90cHNW9zHPG/nmTnkKCgw4lydnSvLO3hoGvxPMcONsFz47UpyXnRrHuA==
X-Received: by 2002:a37:a87:: with SMTP id 129mr699650qkk.13.1600977328765;
        Thu, 24 Sep 2020 12:55:28 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:4d7a])
        by smtp.gmail.com with ESMTPSA id d76sm297769qkc.81.2020.09.24.12.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 12:55:28 -0700 (PDT)
Date:   Thu, 24 Sep 2020 15:53:56 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, kernel-team@fb.com
Subject: Re: [PATCH v1 2/4] mm: memcontrol/slab: use helpers to access slab
 page's memcg_data
Message-ID: <20200924195356.GB329853@cmpxchg.org>
References: <20200922203700.2879671-1-guro@fb.com>
 <20200922203700.2879671-3-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922203700.2879671-3-guro@fb.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 01:36:58PM -0700, Roman Gushchin wrote:
> To gather all direct accesses to struct page's memcg_data field
> in one place, let's introduce 4 new helper functions to use in
> the slab accounting code:
>   struct obj_cgroup **page_obj_cgroups(struct page *page);
>   struct obj_cgroup **page_obj_cgroups_check(struct page *page);
>   bool set_page_obj_cgroups(struct page *page, struct obj_cgroup **objcgs);
>   void clear_page_obj_cgroups(struct page *page);
> 
> They are similar to the corresponding API for generic pages, except
> that the setter can return false, indicating that the value has been
> already set from a different thread.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Reviewed-by: Shakeel Butt <shakeelb@google.com>
> ---
>  include/linux/memcontrol.h | 80 ++++++++++++++++++++++++++++++++++++++
>  mm/memcontrol.c            |  4 +-
>  mm/slab.h                  | 27 ++-----------
>  3 files changed, 85 insertions(+), 26 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 3313e7c21534..ab3ea3e90583 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -409,6 +409,86 @@ static inline void clear_page_mem_cgroup(struct page *page)
>  	page->memcg_data = 0;
>  }
>  
> +#ifdef CONFIG_MEMCG_KMEM
> +/*
> + * page_obj_cgroups - get the object cgroups vector associated with a page
> + * @page: a pointer to the page struct
> + *
> + * Returns a pointer to the object cgroups vector associated with the page,
> + * or NULL. This function assumes that the page is known to have an
> + * associated object cgroups vector. It's not safe to call this function
> + * against pages, which might have an associated memory cgroup: e.g.
> + * kernel stack pages.
> + */
> +static inline struct obj_cgroup **page_obj_cgroups(struct page *page)
> +{
> +	return (struct obj_cgroup **)(page->memcg_data & ~0x1UL);

page_mem_cgroup() has a VM_BUG_ON() if the page is in fact a slab
type. Should this also check that if memcg_data is set, it MUST have
the lower bit set?

In line with page_memcg(), I think page_objcgs() would be nicer.

As in 'memcg_reparent_objcgs()' :-) :-) :-)

> @@ -2923,7 +2923,7 @@ struct mem_cgroup *mem_cgroup_from_obj(void *p)
>  	 * Memcg membership data for each individual object is saved in
>  	 * the page->obj_cgroups.
>  	 */
> -	if (page_has_obj_cgroups(page)) {
> +	if (page_obj_cgroups_check(page)) {
>  		struct obj_cgroup *objcg;
>  		unsigned int off;

Similar to the previous patch: do we have anybody passing in objects
that aren't actual objects in the obj_cgroup sense?

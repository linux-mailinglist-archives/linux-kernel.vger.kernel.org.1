Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 167C92EC430
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 20:52:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbhAFTv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 14:51:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:46172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726697AbhAFTvZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 14:51:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id EFDE923131;
        Wed,  6 Jan 2021 19:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1609962645;
        bh=5kwh7EXq15V7c3k8dlsJ1An7qOaZRPcY0YlVfb4e0Q4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JlGRz55g7P3lJhKFgyXyXXHFWrlDGKKgiuVL75F6D5V0NJzNdck+Et37fd4VgVXgp
         /O+/fLAKYtYzd431NRrGH3/4gkfZAFNouEwd8R+D0Bmvwc3OdAY5O5DsfLNNH6l0Qt
         GCxq0Oh60XK9iDCK0baAm3nIF5YVYJyroAyQGk9Q=
Date:   Wed, 6 Jan 2021 11:50:44 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     <linux-mm@kvack.org>, Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Imran Khan <imran.f.khan@oracle.com>
Subject: Re: [PATCH] mm: memcg/slab: optimize objcg stock draining
Message-Id: <20210106115044.c4393afa1ad61ef3f8db1d94@linux-foundation.org>
In-Reply-To: <20210106042239.2860107-1-guro@fb.com>
References: <20210106042239.2860107-1-guro@fb.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Jan 2021 20:22:39 -0800 Roman Gushchin <guro@fb.com> wrote:

> Imran Khan reported a regression in hackbench results caused by the
> commit f2fe7b09a52b ("mm: memcg/slab: charge individual slab objects
> instead of pages").

How large was the regression?

> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -3122,9 +3122,7 @@ void __memcg_kmem_uncharge(struct mem_cgroup *memcg, unsigned int nr_pages)
>  	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
>  		page_counter_uncharge(&memcg->kmem, nr_pages);
>  
> -	page_counter_uncharge(&memcg->memory, nr_pages);
> -	if (do_memsw_account())
> -		page_counter_uncharge(&memcg->memsw, nr_pages);
> +	refill_stock(memcg, nr_pages);
>  }

IOW, which kernel version(s) should we be patching?

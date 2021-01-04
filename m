Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 522942E95AD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 14:17:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbhADNQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 08:16:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:39142 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726303AbhADNQ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 08:16:28 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1609766141; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=m9FH7UdWyUBdYihDsfPhtS0pob0EGsBcwtATyNQUkpo=;
        b=j4k5Afbfb9/1hn+kCHpIYdYTYTZ6TlwALYbP2iGzo9sIAo1TlJwz1EIUh27NwtT6B/PjZk
        icW0BIcMjWOHhkJn2fAR9LVt5RxzrNzwT5XxEmICvcnaagku1eBpF+bs46WIzEdJWtJRSJ
        M94WvOWeegiwyka5p/POiRpUZ8vLW7Y=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 470E8B737;
        Mon,  4 Jan 2021 13:15:41 +0000 (UTC)
Date:   Mon, 4 Jan 2021 14:15:40 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, andi.kleen@intel.com,
        tim.c.chen@intel.com, dave.hansen@intel.com, ying.huang@intel.com,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>
Subject: Re: [PATCH 2/2] mm: memcg: add a new MEMCG_UPDATE_BATCH
Message-ID: <20210104131540.GG13207@dhcp22.suse.cz>
References: <1609252514-27795-1-git-send-email-feng.tang@intel.com>
 <1609252514-27795-2-git-send-email-feng.tang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1609252514-27795-2-git-send-email-feng.tang@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 29-12-20 22:35:14, Feng Tang wrote:
> When profiling memory cgroup involved benchmarking, status update
> sometimes take quite some CPU cycles. Current MEMCG_CHARGE_BATCH
> is used for both charging and statistics/events updating, and is
> set to 32, which may be good for accuracy of memcg charging, but
> too small for stats update which causes concurrent access to global
> stats data instead of per-cpu ones.
> 
> So handle them differently, by adding a new bigger batch number
> for stats updating, while keeping the value for charging (though
> comments in memcontrol.h suggests to consider a bigger value too)
> 
> The new batch is set to 512, which considers 2MB huge pages (512
> pages), as the check logic mostly is:
> 
>     if (x > BATCH), then skip updating global data
> 
> so it will save 50% global data updating for 2MB pages

Please note that there is a patch set to change THP accounting to be per
page based (http://lkml.kernel.org/r/20201228164110.2838-1-songmuchun@bytedance.com)
which will change the current behavior already.

Our batch size (MEMCG_CHARGE_BATCH) is quite arbitrary. I do not think
anybody has ever seriously benchmarked the effect of the size. I am not
opposed to changing that but I have to say I dislike the charge to
diverge from counters in that respect. This just opens doors to weird
effects IMO. Those two are quite related already.
 
> Following are some performance data with the patch, against
> v5.11-rc1, on several generations of Xeon platforms. Each category
> below has several subcases run on different platform, and only the
> worst and best scores are listed:
> 
> fio:				 +2.0% ~  +6.8%
> will-it-scale/malloc:		 -0.9% ~  +6.2%
> will-it-scale/page_fault1:	 no change
> will-it-scale/page_fault2:	+13.7% ~ +26.2%
> 
> One thought is it could be dynamically calculated according to
> memcg limit and number of CPUs, and another is to add a periodic
> syncing of the data for accuracy reason similar to vmstat, as
> suggested by Ying.
> 
> Signed-off-by: Feng Tang <feng.tang@intel.com>
> Cc: Shakeel Butt <shakeelb@google.com>
> Cc: Roman Gushchin <guro@fb.com>
> ---
>  include/linux/memcontrol.h | 2 ++
>  mm/memcontrol.c            | 6 +++---
>  2 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index d827bd7..d58bf28 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -335,6 +335,8 @@ struct mem_cgroup {
>   */
>  #define MEMCG_CHARGE_BATCH 32U
>  
> +#define MEMCG_UPDATE_BATCH 512U
> +
>  extern struct mem_cgroup *root_mem_cgroup;
>  
>  enum page_memcg_data_flags {
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 605f671..01ca85d 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -760,7 +760,7 @@ mem_cgroup_largest_soft_limit_node(struct mem_cgroup_tree_per_node *mctz)
>   */
>  void __mod_memcg_state(struct mem_cgroup *memcg, int idx, int val)
>  {
> -	long x, threshold = MEMCG_CHARGE_BATCH;
> +	long x, threshold = MEMCG_UPDATE_BATCH;
>  
>  	if (mem_cgroup_disabled())
>  		return;
> @@ -800,7 +800,7 @@ void __mod_memcg_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
>  {
>  	struct mem_cgroup_per_node *pn;
>  	struct mem_cgroup *memcg;
> -	long x, threshold = MEMCG_CHARGE_BATCH;
> +	long x, threshold = MEMCG_UPDATE_BATCH;
>  
>  	pn = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
>  	memcg = pn->memcg;
> @@ -905,7 +905,7 @@ void __count_memcg_events(struct mem_cgroup *memcg, enum vm_event_item idx,
>  		return;
>  
>  	x = count + __this_cpu_read(memcg->vmstats_percpu->events[idx]);
> -	if (unlikely(x > MEMCG_CHARGE_BATCH)) {
> +	if (unlikely(x > MEMCG_UPDATE_BATCH)) {
>  		struct mem_cgroup *mi;
>  
>  		/*
> -- 
> 2.7.4
> 

-- 
Michal Hocko
SUSE Labs

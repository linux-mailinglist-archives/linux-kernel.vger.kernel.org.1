Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2910C1C3330
	for <lists+linux-kernel@lfdr.de>; Mon,  4 May 2020 08:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbgEDG4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 May 2020 02:56:05 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45476 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726712AbgEDG4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 02:56:05 -0400
Received: by mail-wr1-f67.google.com with SMTP id k1so649514wro.12;
        Sun, 03 May 2020 23:56:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jog4tz7JjzUtRGEMAhpCFp/8qoFX9sXC3gjVWFz42K8=;
        b=pK1F1Vyg7YfYzmAB/9+9HZzvxfqxYPBLnm+CQWLmQ1mbwNWV5y0YM9tPCuHZ/ZVYwq
         56Hi+J3micKxCokAx559pWcLcECcCoGWU6hD8Df8W1LcRVbf98ivtJ9wKVnmisCYoyFJ
         js/yoZ5LFXPq3vZQ+Q+MwbMl9q6jNMyW/7dQ5j81U5ZnU7rYD8gwaU6xsFU1fzC/lYiv
         B1cmf2SX2Jrx6vFMUqEoWnlrVUnQoD+kDnjcxNAa/rD2EmPFV4KjK3G6eYyI1qcRy0HM
         05MIp/a5/QhvI4cQBlHnJY0/KRBLU+FdiIn8xle1CtE9ctnMAzeb5U6ijYuzDWEG+ujg
         3xqg==
X-Gm-Message-State: AGi0PuayyCZ9B1sz5ngc+xDW/5cEuuGPXclaMWC8YX8PqEJad0B/oGBl
        nS+Kwt+XVckg3Z9XVoCoS9I=
X-Google-Smtp-Source: APiQypLjsOFQcdZkPtXf6gINBNzvhzc1hULS1DgGyhiSHP0rM4ORDVqfjQGSrKudO5a5FtWC9ZkFaw==
X-Received: by 2002:adf:f641:: with SMTP id x1mr17292876wrp.151.1588575361670;
        Sun, 03 May 2020 23:56:01 -0700 (PDT)
Received: from localhost (ip-37-188-183-9.eurotel.cz. [37.188.183.9])
        by smtp.gmail.com with ESMTPSA id e2sm17031153wrv.89.2020.05.03.23.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2020 23:56:01 -0700 (PDT)
Date:   Mon, 4 May 2020 08:56:00 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <guro@fb.com>,
        Greg Thelen <gthelen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memcg: oom: ignore oom warnings from memory.max
Message-ID: <20200504065600.GA22838@dhcp22.suse.cz>
References: <20200430182712.237526-1-shakeelb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200430182712.237526-1-shakeelb@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 30-04-20 11:27:12, Shakeel Butt wrote:
> Lowering memory.max can trigger an oom-kill if the reclaim does not
> succeed. However if oom-killer does not find a process for killing, it
> dumps a lot of warnings.

It shouldn't dump much more than the regular OOM report AFAICS. Sure
there is "Out of memory and no killable processes..." message printed as
well but is that a real problem?

> Deleting a memcg does not reclaim memory from it and the memory can
> linger till there is a memory pressure. One normal way to proactively
> reclaim such memory is to set memory.max to 0 just before deleting the
> memcg. However if some of the memcg's memory is pinned by others, this
> operation can trigger an oom-kill without any process and thus can log a
> lot un-needed warnings. So, ignore all such warnings from memory.max.

OK, I can see why you might want to use memory.max for that purpose but
I do not really understand why the oom report is a problem here.
memory.max can trigger the oom kill and user should be expecting the oom
report under that condition. Why is "no eligible task" so special? Is it
because you know that there won't be any tasks for your particular case?
What about other use cases where memory.max is not used as a "sweep
before tear down"?

> Signed-off-by: Shakeel Butt <shakeelb@google.com>
> ---
>  include/linux/oom.h | 3 +++
>  mm/memcontrol.c     | 9 +++++----
>  mm/oom_kill.c       | 2 +-
>  3 files changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/oom.h b/include/linux/oom.h
> index c696c265f019..6345dc55df64 100644
> --- a/include/linux/oom.h
> +++ b/include/linux/oom.h
> @@ -52,6 +52,9 @@ struct oom_control {
>  
>  	/* Used to print the constraint info. */
>  	enum oom_constraint constraint;
> +
> +	/* Do not warn even if there is no process to be killed. */
> +	bool no_warn;
>  };
>  
>  extern struct mutex oom_lock;
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 317dbbaac603..a1f00d9b9bb0 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1571,7 +1571,7 @@ unsigned long mem_cgroup_size(struct mem_cgroup *memcg)
>  }
>  
>  static bool mem_cgroup_out_of_memory(struct mem_cgroup *memcg, gfp_t gfp_mask,
> -				     int order)
> +				     int order, bool no_warn)
>  {
>  	struct oom_control oc = {
>  		.zonelist = NULL,
> @@ -1579,6 +1579,7 @@ static bool mem_cgroup_out_of_memory(struct mem_cgroup *memcg, gfp_t gfp_mask,
>  		.memcg = memcg,
>  		.gfp_mask = gfp_mask,
>  		.order = order,
> +		.no_warn = no_warn,
>  	};
>  	bool ret;
>  
> @@ -1821,7 +1822,7 @@ static enum oom_status mem_cgroup_oom(struct mem_cgroup *memcg, gfp_t mask, int
>  		mem_cgroup_oom_notify(memcg);
>  
>  	mem_cgroup_unmark_under_oom(memcg);
> -	if (mem_cgroup_out_of_memory(memcg, mask, order))
> +	if (mem_cgroup_out_of_memory(memcg, mask, order, false))
>  		ret = OOM_SUCCESS;
>  	else
>  		ret = OOM_FAILED;
> @@ -1880,7 +1881,7 @@ bool mem_cgroup_oom_synchronize(bool handle)
>  		mem_cgroup_unmark_under_oom(memcg);
>  		finish_wait(&memcg_oom_waitq, &owait.wait);
>  		mem_cgroup_out_of_memory(memcg, current->memcg_oom_gfp_mask,
> -					 current->memcg_oom_order);
> +					 current->memcg_oom_order, false);
>  	} else {
>  		schedule();
>  		mem_cgroup_unmark_under_oom(memcg);
> @@ -6106,7 +6107,7 @@ static ssize_t memory_max_write(struct kernfs_open_file *of,
>  		}
>  
>  		memcg_memory_event(memcg, MEMCG_OOM);
> -		if (!mem_cgroup_out_of_memory(memcg, GFP_KERNEL, 0))
> +		if (!mem_cgroup_out_of_memory(memcg, GFP_KERNEL, 0, true))
>  			break;
>  	}
>  
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index 463b3d74a64a..5ace39f6fe1e 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -1098,7 +1098,7 @@ bool out_of_memory(struct oom_control *oc)
>  
>  	select_bad_process(oc);
>  	/* Found nothing?!?! */
> -	if (!oc->chosen) {
> +	if (!oc->chosen && !oc->no_warn) {
>  		dump_header(oc, NULL);
>  		pr_warn("Out of memory and no killable processes...\n");
>  		/*
> -- 
> 2.26.2.526.g744177e7f7-goog

-- 
Michal Hocko
SUSE Labs

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 883772A82AF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 16:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731202AbgKEPwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 10:52:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731224AbgKEPwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 10:52:15 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEEBEC0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 07:52:14 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id j31so1381019qtb.8
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 07:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wav68iaVTQF0WFq+Th0tYUO0U3YMLisLGmELFio3w0M=;
        b=Xnz5zDvuzuiMRu0SqPXz9aeWh3Q9AxzO0MihtH60GbutMzaGAk38UiOjZfumJmRmz3
         vEYrezzLa9WeU78+kOYPbNKCWY7q5Domp0FcWKUKDB+BDa+0ZMeUwwpcu1BX/ZG/6ST8
         XziZn3I0Xa+SFkV7IHUQPIyHUV7WyzSQ1oCNGFjzkAXn+uQZIu/nsUQBF5rkqe/hH8Fj
         OYbEk4BuVZ0vLU6tLMTVLAUQHxO2F/xQ5WcItCssHRAUCDrOdJzngInmLnhTZa3KQdmq
         3JQjpzpZkv82pg8xodSsn84V3f8oVgfFeJLdDZL42xFOlE7u66xU3nDdd9uRQh7GEbYp
         +wlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wav68iaVTQF0WFq+Th0tYUO0U3YMLisLGmELFio3w0M=;
        b=hhyPUBVhcDgveGnEYKXSpnVLkGc/Pz1O0jLXq6/uqHDAxkzBrx5RfmojppJJbSXXlI
         w8HjsWZm7s8fwbKEvGK3WQ/dR3zR0LyWMYrMS3JnKbHzXXGKW6omUn9Mr1QNxtdMGi5e
         AumOiCQeCm1a3uy+qcEWOx4LxXXirBMEYqeEwLgQXyEpIWHCtaYsfhNjMHw3OLXjTcK+
         qcEpewvxc0dzlrrvV785V+ilN1R4m0zjgNpdcAnyJd591yrE++tcXiI+04s7bdhFym9S
         ypr7y9CZWFi1ZE+P2CJ+zWCtgYjlHJTks67MDJgsGectT+Yzt+iNjbb4LVbINwHy2o6C
         oFeQ==
X-Gm-Message-State: AOAM533sKS0nW59eEPDC6vuSyKwvfAead2KKPNTxZu29n/zvvV3v96TW
        61EBS6ot7B3ux3oKcJe4JM1VNQ==
X-Google-Smtp-Source: ABdhPJyiqFZo1XYeeeVe17iokfiADDG4yd79vYbdXi61nDVq6HpNYPOxEwq6CKtKsmvz538YXFnOVw==
X-Received: by 2002:ac8:5811:: with SMTP id g17mr2466932qtg.296.1604591534076;
        Thu, 05 Nov 2020 07:52:14 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:fc05])
        by smtp.gmail.com with ESMTPSA id o8sm1129518qtm.9.2020.11.05.07.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 07:52:13 -0800 (PST)
Date:   Thu, 5 Nov 2020 10:50:28 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     akpm@linux-foundation.org, shakeelb@google.com, guro@fb.com,
        mhocko@suse.com, laoar.shao@gmail.com, chris@chrisdown.name,
        tj@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: memcontrol: fix missing wakeup polling thread
Message-ID: <20201105155028.GD744831@cmpxchg.org>
References: <20201104125558.49472-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104125558.49472-1-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 04, 2020 at 08:55:58PM +0800, Muchun Song wrote:
> When wen poll the memory.swap.events, we can miss being waked up when the
> swap event occurs. Because we didn't notify.
> 
> Fixes: f3a53a3a1e5b ("mm, memcontrol: implement memory.swap.events")
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Good catch!

> ---
>  include/linux/memcontrol.h | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 0f4dd7829fb2..2456cb737329 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -1071,15 +1071,29 @@ static inline void count_memcg_event_mm(struct mm_struct *mm,
>  	rcu_read_unlock();
>  }
>  
> +static inline bool is_swap_memory_event(enum memcg_memory_event event)
> +{
> +	return event == MEMCG_SWAP_HIGH || event == MEMCG_SWAP_MAX ||
> +	       event == MEMCG_SWAP_FAIL;
> +}

Please inline this, it's not really worth the indirection.

>  static inline void memcg_memory_event(struct mem_cgroup *memcg,
>  				      enum memcg_memory_event event)
>  {
> +	bool swap_event = is_swap_memory_event(event);
> +	struct cgroup_file *cfile;
> +
>  	atomic_long_inc(&memcg->memory_events_local[event]);
> -	cgroup_file_notify(&memcg->events_local_file);
> +	if (swap_event) {
> +		cfile = &memcg->swap_events_file;
> +	} else {
> +		cfile = &memcg->events_file;
> +		cgroup_file_notify(&memcg->events_local_file);
> +	}
>  
>  	do {
>  		atomic_long_inc(&memcg->memory_events[event]);
> -		cgroup_file_notify(&memcg->events_file);
> +		cgroup_file_notify(cfile);

This loop is a walk up the hierarchy and memcg keeps changing, so you
cannot cache cfile up front.

		if (swap_event)
			cgroup_file_notify(&memcg->swap_events_file);
		else
			cgroup_file_notify(&memcg->events_file);

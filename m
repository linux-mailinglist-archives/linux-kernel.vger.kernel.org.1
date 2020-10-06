Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82476284D5C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 16:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbgJFOJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 10:09:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29477 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725902AbgJFOJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 10:09:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601993372;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7gFIiuqzW33g4a3B6bJupXNSjR4wyE9XrMIGmln4fWE=;
        b=dAlz6UGIMRtY/c2K6UTqkEPL3atupwzL0sD5VdUJ+ZyE05zU1i5NhrJZOheo3sCd8uQ35a
        zBHX4q7lI6oXXrgn1Dgpo+2CLXGDYi00VzUvCoQlNwgm9RsHm2a9ZNafKkRuoYReAq26Lw
        WOhIQCJIWdKe+M5mOSEkUKUP3WHVAbg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-OzAxhelMPGqBMpNGcCQCjg-1; Tue, 06 Oct 2020 10:09:30 -0400
X-MC-Unique: OzAxhelMPGqBMpNGcCQCjg-1
Received: by mail-wr1-f71.google.com with SMTP id r16so5377357wrm.18
        for <linux-kernel@vger.kernel.org>; Tue, 06 Oct 2020 07:09:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7gFIiuqzW33g4a3B6bJupXNSjR4wyE9XrMIGmln4fWE=;
        b=OQGCwNLegenEfF1CW7PKLHRBQvUv/2OGvbSD7G/He4+h9+6e00yZTHYwSlJseNYctk
         AuEsbOO76IT97ypl7JAJmXmZCXpUxQYXXmoMUKHpITCHeYyWRc1emmlnLWlvSVH55qOQ
         AXtauxjiVz3CSPAJrkKAJiTv4/txjoTKRETses0/SKaW+BLzVZKthcmNCRAHEONnEWxi
         JxUW+kp6cU2ChJH4+lTZ/3PZ5EbUJfxOBh1DLBLWmWq/3UiZbJ6va0c2/Kn2DMLFL3au
         nyOU7F6/ek5S+p+9+LiJvzDPZ6v48ILsTyqqcK3xbv21JgitKzagkjXryeGxnFnDy4ex
         UbBA==
X-Gm-Message-State: AOAM533QxA6t1ihJeloFJZmJTPMj8/3YFYXDKN3yYc/NlF/LBK5u549m
        0Ohto3+Fva1gpljqNfxJm7PNHxNkGhOz4iYFFRYg/bZzZQfr8621Mqg6YsMNuHtNb3h2SyNe40S
        O4iV4K6RE6qUczwooKG/w6sF1
X-Received: by 2002:a1c:2d85:: with SMTP id t127mr5057189wmt.22.1601993369477;
        Tue, 06 Oct 2020 07:09:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJypKp4PL0SVnUkd64Bf3VLuBJCTZaEfX7wnpjZU+wXjuyj4gp3NkI+FrJUFzwusUL++BqvSeA==
X-Received: by 2002:a1c:2d85:: with SMTP id t127mr5057159wmt.22.1601993369152;
        Tue, 06 Oct 2020 07:09:29 -0700 (PDT)
Received: from localhost.localdomain ([151.29.91.67])
        by smtp.gmail.com with ESMTPSA id f12sm4016658wmf.26.2020.10.06.07.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 07:09:28 -0700 (PDT)
Date:   Tue, 6 Oct 2020 16:09:26 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, qais.yousef@arm.com, swood@redhat.com,
        valentin.schneider@arm.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vincent.donnefort@arm.com,
        tj@kernel.org
Subject: Re: [PATCH -v2 12/17] sched,rt: Use cpumask_any*_distribute()
Message-ID: <20201006140926.GI4352@localhost.localdomain>
References: <20201005145717.346020688@infradead.org>
 <20201005150922.156231026@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201005150922.156231026@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 05/10/20 16:57, Peter Zijlstra wrote:
> Replace a bunch of cpumask_any*() instances with
> cpumask_any*_distribute(), by injecting this little bit of random in
> cpu selection, we reduce the chance two competing balance operations
> working off the same lowest_mask pick the same CPU.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  include/linux/cpumask.h |    6 ++++++
>  kernel/sched/cpupri.c   |    4 ++--
>  kernel/sched/deadline.c |    2 +-
>  kernel/sched/rt.c       |    6 +++---
>  lib/cpumask.c           |   18 ++++++++++++++++++
>  5 files changed, 30 insertions(+), 6 deletions(-)
> 
> --- a/include/linux/cpumask.h
> +++ b/include/linux/cpumask.h
> @@ -199,6 +199,11 @@ static inline int cpumask_any_and_distri
>  	return cpumask_next_and(-1, src1p, src2p);
>  }
>  
> +static inline int cpumask_any_distribute(const struct cpumask *srcp)
> +{
> +	return cpumask_first(srcp);
> +}
> +
>  #define for_each_cpu(cpu, mask)			\
>  	for ((cpu) = 0; (cpu) < 1; (cpu)++, (void)mask)
>  #define for_each_cpu_not(cpu, mask)		\
> @@ -252,6 +257,7 @@ int cpumask_any_but(const struct cpumask
>  unsigned int cpumask_local_spread(unsigned int i, int node);
>  int cpumask_any_and_distribute(const struct cpumask *src1p,
>  			       const struct cpumask *src2p);
> +int cpumask_any_distribute(const struct cpumask *srcp);
>  
>  /**
>   * for_each_cpu - iterate over every cpu in a mask
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -2001,7 +2001,7 @@ static int find_later_rq(struct task_str
>  	if (this_cpu != -1)
>  		return this_cpu;
>  
> -	cpu = cpumask_any(later_mask);
> +	cpu = cpumask_any_distribute(later_mask);
>  	if (cpu < nr_cpu_ids)
>  		return cpu;

Think we can use cpumask_any_and_distribute() with later_mask for
deadline as well inside the for_each_domain loop as you do for rt below.

Best,
Juri

> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -1752,8 +1752,8 @@ static int find_lowest_rq(struct task_st
>  				return this_cpu;
>  			}
>  
> -			best_cpu = cpumask_first_and(lowest_mask,
> -						     sched_domain_span(sd));
> +			best_cpu = cpumask_any_and_distribute(lowest_mask,
> +							      sched_domain_span(sd));
>  			if (best_cpu < nr_cpu_ids) {
>  				rcu_read_unlock();
>  				return best_cpu;
> @@ -1770,7 +1770,7 @@ static int find_lowest_rq(struct task_st
>  	if (this_cpu != -1)
>  		return this_cpu;
>  
> -	cpu = cpumask_any(lowest_mask);
> +	cpu = cpumask_any_distribute(lowest_mask);
>  	if (cpu < nr_cpu_ids)
>  		return cpu;


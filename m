Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D613292215
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 07:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbgJSFJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 01:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbgJSFJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 01:09:56 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D25C061755
        for <linux-kernel@vger.kernel.org>; Sun, 18 Oct 2020 22:09:55 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id w11so4377632pll.8
        for <linux-kernel@vger.kernel.org>; Sun, 18 Oct 2020 22:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9UfRTd1e3FTHvGK6RIc32bZdl/AF4IhWl0NemlQOkVs=;
        b=iD2j0xzI+DjBh4wKF6pdJ3v8Fv9c5HXyG/THIxqoAKSGtvixVhv1F1oDwiZVXLKjZI
         mjXJ1KHf4FEFgiimlWviht9N/OmZHErMZIwiElk4ccLyweTqG3aC/NSfjX/rU1JArRJz
         PKa5nrLjZZOdD/aIVDFcFc0qkaXB2Zdf6U3sXB2bO1qEx7D/mqkCUlbTrQaEl1zMMKgw
         0iqed1PYlhDnImsASgD+0Icr5otPD0QkrFFOvHe7RWE9ImEpBW1/I7/Z57a7vpwjNyF4
         nxdTkQaFUtY6xRLENu4khaRoknEOIH8y7cXmc0vADorrZwTftVRJH9gOgOdaxllpFjWI
         fsPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9UfRTd1e3FTHvGK6RIc32bZdl/AF4IhWl0NemlQOkVs=;
        b=rwWtkz4RLiIEMQUhpUhY+6JERP7lrLa5uB3MYiC+vpQcewWDmGPJ7eC//EsojDziDN
         1dF6Dp64uhsz/mFhskpJJc4m0Kdt4ZkmewD6HEgqn0PA0V/zwM/jRbBEo7xrdAV+Itmh
         kzGeQwqCXYKBRuRU7bQmFIRsYZPq7mdeixpBR4QLaoJBDO3z0rMDEcWEG6LSD/n11YWI
         X+1OEnwtukXZq2xl2sweuKAOeeAfLREyT1/svOvubbAI1tgbKcjMpHlxpFzIcnBcgU7P
         u9jTwpCT3DRERc3QOPJA0A+cEwxUcTsA8s/w+KRqunBs/BIKsVseWeh6RyIqh0f0sVfD
         6n9g==
X-Gm-Message-State: AOAM532LvWQKvNifIAARyEnMuz+8fipk4syQWQPpuMYMBOJ+avaXXoSw
        oLtJbYNVAlA4Bah3QINTuA4rtQ==
X-Google-Smtp-Source: ABdhPJxITnmBoXw1RKT37+O/i97Rk8mts5wnMskiu54aEI/6vp2dS/BI94X6UlBtMVPB7/s78m6D4w==
X-Received: by 2002:a17:902:b696:b029:d2:1ebe:d80c with SMTP id c22-20020a170902b696b02900d21ebed80cmr15507748pls.18.1603084194446;
        Sun, 18 Oct 2020 22:09:54 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id 204sm10132344pfz.74.2020.10.18.22.09.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Oct 2020 22:09:53 -0700 (PDT)
Date:   Mon, 19 Oct 2020 10:39:52 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Wei Wang <wvw@google.com>
Cc:     wei.vince.wang@gmail.com, qperret@google.com, rafael@kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: cpufreq_schedutil: restore cached freq when
 next_f is not changed
Message-ID: <20201019050952.cxovrbfffrxrl3uy@vireshk-i7>
References: <CAGXk5yoNxZBD9gX-8RvtsqAwB4rO=hFQKBewFhOGoMO171aJVA@mail.gmail.com>
 <20201016181722.884812-1-wvw@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201016181722.884812-1-wvw@google.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-10-20, 11:17, Wei Wang wrote:
> We have the raw cached freq to reduce the chance in calling cpufreq
> driver where it could be costly in some arch/SoC.
> 
> Currently, the raw cached freq will be reset when next_f is changed for
> correctness. This patch changes it to maintain the cached value instead
> of dropping it to honor the purpose of the cached value.
> 
> This is adapted from https://android-review.googlesource.com/1352810/
> 
> Signed-off-by: Wei Wang <wvw@google.com>
> ---
>  kernel/sched/cpufreq_schedutil.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 5ae7b4e6e8d6..e254745a82cb 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -441,6 +441,7 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
>  	unsigned long util, max;
>  	unsigned int next_f;
>  	bool busy;
> +	unsigned int cached_freq = sg_policy->cached_raw_freq;
>  
>  	sugov_iowait_boost(sg_cpu, time, flags);
>  	sg_cpu->last_update = time;
> @@ -464,8 +465,8 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
>  	if (busy && next_f < sg_policy->next_freq) {
>  		next_f = sg_policy->next_freq;
>  
> -		/* Reset cached freq as next_freq has changed */
> -		sg_policy->cached_raw_freq = 0;
> +		/* Restore cached freq as next_freq has changed */
> +		sg_policy->cached_raw_freq = cached_freq;
>  	}
>  
>  	/*

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE2028AE2E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 08:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbgJLGNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 02:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbgJLGNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 02:13:40 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F26FC0613D1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Oct 2020 23:13:39 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id b193so12381026pga.6
        for <linux-kernel@vger.kernel.org>; Sun, 11 Oct 2020 23:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wzwgHWW6fAZr3jurcNxxh+hZXMvNGactjM2e0hjZyhg=;
        b=sPESY74Q66CsNglsTg/3UY1/Fn8549U4STepmGTe0zQUUk72zSettmgX+BaFs9CVq0
         DruTaVdBebld5EfH33POJJWw5nwgn9fXFyt3ZEh/z3ESVkwMFpT5ZQnp60BIc7aOWp9g
         sf/7I8L29N1DXn4eWmktZa9OYX26H4ixeY4Ft7gA9IPuqVUnYQ3mxXZ18xozaw9zv0l2
         wmdYvykokiHwSUc+Itmw9eJwufwWcJMqUPBXKo5CjT2iPtB97XkKvkuSShI6L2xSutTc
         86d4W0V1Dw4ZzUrhwL5WIU67LT20PL2K7kojRaAiC0yvBvZDTVZFC9G4+c6fWqWCCpv+
         KJGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wzwgHWW6fAZr3jurcNxxh+hZXMvNGactjM2e0hjZyhg=;
        b=tRbgUAUUTwRH6fnN+sMyaup9KwB38W3ecsJqL+fVvWVjV3qLm/qOV2snHiUlv+Y//Z
         C5FxNYmFtWpDONC8KZY899pYm2dB/DSLKAUg5z9sq8J2WFCC/y1YfQFJOf4Ci2KfILqq
         ho+GD1RaDvexCFG2e1gzbVlRjO8aQuNC+dVnwoEZqVXOQoJUo1FFZ+ePnzuY/GnAMepq
         U43h5COAVF5DLuf36oDesvW26YtKjYVOHWQKRFJ6kE2qiVeM+ZGzmqLZ8DDgbFf8dKfV
         m6uzsx5vxVjX6bvueHpr93WKrh7vupRTtfEVOGzhpwqMSQbFRcLZGR7p8lK3XnXi+L98
         rdjg==
X-Gm-Message-State: AOAM532a2ISiQi0Yfc8AKfRHcNfTIdUcV+ynio9FsnUbvYdN4Z6+hLTj
        Um0t960LiKcZgrInPCdGqPbdog==
X-Google-Smtp-Source: ABdhPJwv+DgSLej3lQfBr6wGZhPZg0LBp7Tj7G2jrVpqjzGKafLrDp48qNU3IdOsQe84t73fdd2w3w==
X-Received: by 2002:a62:b506:0:b029:155:d56e:5193 with SMTP id y6-20020a62b5060000b0290155d56e5193mr6942930pfe.52.1602483218694;
        Sun, 11 Oct 2020 23:13:38 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id na9sm13558143pjb.45.2020.10.11.23.13.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Oct 2020 23:13:37 -0700 (PDT)
Date:   Mon, 12 Oct 2020 11:43:35 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sumit Gupta <sumitg@nvidia.com>
Cc:     rjw@rjwysocki.net, sudeep.holla@arm.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ksitaraman@nvidia.com,
        bbasu@nvidia.com
Subject: Re: [PATCH v2 2/2] cpufreq: tegra194: Fix unlisted boot freq warning
Message-ID: <20201012061335.nht4hnn7kdjupakn@vireshk-i7>
References: <1602162066-26442-1-git-send-email-sumitg@nvidia.com>
 <1602162066-26442-3-git-send-email-sumitg@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1602162066-26442-3-git-send-email-sumitg@nvidia.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-10-20, 18:31, Sumit Gupta wrote:
> Warning coming during boot because the boot freq set by bootloader
> gets filtered out due to big freq steps while creating freq_table.
> Fix this by setting closest higher frequency from freq_table.
> Warning:
>   cpufreq: cpufreq_online: CPU0: Running at unlisted freq
>   cpufreq: cpufreq_online: CPU0: Unlisted initial frequency changed
> 
> These warning messages also come during hotplug online of non-boot
> CPU's while exiting from 'Suspend-to-RAM'. This happens because
> during exit from 'Suspend-to-RAM', some time is taken to restore
> last software requested CPU frequency written in register before
> entering suspend.

And who does this restoration ?

> To fix this, adding online hook to wait till the
> current frequency becomes equal or close to the last requested
> frequency.
> 
> Fixes: df320f89359c ("cpufreq: Add Tegra194 cpufreq driver")
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>  drivers/cpufreq/tegra194-cpufreq.c | 86 ++++++++++++++++++++++++++++++++++----
>  1 file changed, 79 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/cpufreq/tegra194-cpufreq.c b/drivers/cpufreq/tegra194-cpufreq.c
> index d250e49..cc28b1e3 100644
> --- a/drivers/cpufreq/tegra194-cpufreq.c
> +++ b/drivers/cpufreq/tegra194-cpufreq.c
> @@ -7,6 +7,7 @@
>  #include <linux/cpufreq.h>
>  #include <linux/delay.h>
>  #include <linux/dma-mapping.h>
> +#include <linux/iopoll.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_platform.h>
> @@ -21,7 +22,6 @@
>  #define KHZ                     1000
>  #define REF_CLK_MHZ             408 /* 408 MHz */
>  #define US_DELAY                500
> -#define US_DELAY_MIN            2
>  #define CPUFREQ_TBL_STEP_HZ     (50 * KHZ * KHZ)
>  #define MAX_CNT                 ~0U
>  
> @@ -249,17 +249,22 @@ static unsigned int tegra194_get_speed(u32 cpu)
>  static int tegra194_cpufreq_init(struct cpufreq_policy *policy)
>  {
>  	struct tegra194_cpufreq_data *data = cpufreq_get_driver_data();
> -	u32 cpu;
> +	u32 cpu = policy->cpu;
> +	int ret;
>  	u32 cl;
>  
> -	smp_call_function_single(policy->cpu, get_cpu_cluster, &cl, true);
> +	if (!cpu_online(cpu))

Not required to check this.

> +		return -EINVAL;
> +
> +	ret = smp_call_function_single(cpu, get_cpu_cluster, &cl, true);
> +	if (ret) {

Same as in the other patch.

> +		pr_err("cpufreq: Failed to get cluster for CPU%d\n", cpu);
> +		return ret;
> +	}
>  
>  	if (cl >= data->num_clusters)
>  		return -EINVAL;
>  
> -	/* boot freq */
> -	policy->cur = tegra194_get_speed_common(policy->cpu, US_DELAY_MIN);
> -
>  	/* set same policy for all cpus in a cluster */
>  	for (cpu = (cl * 2); cpu < ((cl + 1) * 2); cpu++)
>  		cpumask_set_cpu(cpu, policy->cpus);
> @@ -267,7 +272,23 @@ static int tegra194_cpufreq_init(struct cpufreq_policy *policy)
>  	policy->freq_table = data->tables[cl];
>  	policy->cpuinfo.transition_latency = TEGRA_CPUFREQ_TRANSITION_LATENCY;
>  
> -	return 0;
> +	policy->cur = tegra194_get_speed_common(policy->cpu, US_DELAY);
> +
> +	ret = cpufreq_table_validate_and_sort(policy);
> +	if (ret)
> +		return ret;
> +
> +	/* Are we running at unknown frequency ? */
> +	ret = cpufreq_frequency_table_get_index(policy, policy->cur);
> +	if (ret == -EINVAL) {
> +		ret = __cpufreq_driver_target(policy, policy->cur - 1,
> +					      CPUFREQ_RELATION_L);
> +		if (ret)
> +			return ret;

> +		policy->cur = tegra194_get_speed_common(policy->cpu, US_DELAY);

cpufreq-core will do this anyway, you don't need to do it.

> +	}
> +
> +	return ret;
>  }

I wonder if I should change the pr_warn() in cpufreq-core to pr_info()
instead, will that help you guys ? Will that still be a problem ? This
is exactly same as what we do there.

>  static int tegra194_cpufreq_set_target(struct cpufreq_policy *policy,
> @@ -285,6 +306,55 @@ static int tegra194_cpufreq_set_target(struct cpufreq_policy *policy,
>  	return 0;
>  }
>  
> +static int tegra194_cpufreq_online(struct cpufreq_policy *policy)
> +{
> +	unsigned int interm_freq, last_set_freq;
> +	struct cpufreq_frequency_table *pos;
> +	u64 ndiv;
> +	int ret;
> +
> +	if (!cpu_online(policy->cpu))
> +		return -EINVAL;
> +
> +	/* get ndiv for the last frequency request from software  */
> +	ret = smp_call_function_single(policy->cpu, get_cpu_ndiv, &ndiv, true);
> +	if (ret) {
> +		pr_err("cpufreq: Failed to get ndiv for CPU%d\n", policy->cpu);
> +		return ret;
> +	}
> +
> +	cpufreq_for_each_valid_entry(pos, policy->freq_table) {
> +		if (pos->driver_data == ndiv) {
> +			last_set_freq = pos->frequency;
> +			break;
> +		}
> +	}
> +
> +	policy->cur = tegra194_get_speed_common(policy->cpu, US_DELAY);
> +	interm_freq =  policy->cur;
> +
> +	/*
> +	 * It takes some time to restore the previous frequency while
> +	 * turning-on non-boot cores during exit from SC7(Suspend-to-RAM).
> +	 * So, wait till it reaches the previous value and timeout if the
> +	 * time taken to reach requested freq is >100ms
> +	 */
> +	ret = read_poll_timeout(tegra194_get_speed_common, policy->cur,
> +				abs(policy->cur - last_set_freq) <= 115200, 0,
> +				100 * USEC_PER_MSEC, false, policy->cpu,
> +				US_DELAY);

The firmware does this update ? Why do we need to wait for this ? I
was actually suggesting an empty tegra194_cpufreq_online() routine
here.

-- 
viresh

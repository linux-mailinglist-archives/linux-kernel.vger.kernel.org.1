Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA4628AD90
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 07:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbgJLFWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 01:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbgJLFWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 01:22:30 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CACCEC0613D1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Oct 2020 22:22:30 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id g9so13171915pgh.8
        for <linux-kernel@vger.kernel.org>; Sun, 11 Oct 2020 22:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qmE6A/EKe0hTQJfNjsT3sfUiMsmf4sO+YlCAtCElHT4=;
        b=IbqtigImICgHWY7+4MtxnpiWYffaixBuI0p65m8WBT8s7qhDIXWrbGYHkKZjiM28Tx
         bFYDc9N1MkHT4hxFizyql+D9mXX2HnRLdLSTL5f9lD0RinlMPoDcTXX0mZcIF9ejzQP2
         OXnqCfY/Flb/48/k6Iz6aagtF95LbJYC12SFH5u2bQFL27fTMvwjSZw1aJATc4ryp3Qb
         s5GAKfnrrOWjoM/AXxV1OWpP3ijsH2zZdjcG/exb35au79LUjxNgqD8Vz5AOQclFEeRK
         oB03PoZ6pHCkCGeDUwzWPJLHA7BLUxtR5Z/u8BIU+m/cqWdykNXR2MvqXHQA6VcCsVou
         eT2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qmE6A/EKe0hTQJfNjsT3sfUiMsmf4sO+YlCAtCElHT4=;
        b=MFytNK4KDR8eSIKSWs49rfovMB8LlpM1qJn9MUDkmxPS9l49fjafoKieeF7C/JpZiV
         tvLgjkOex+dXFOOMF5cuZwJs4UkxtCjEA+TcrxHb1oAJ7JSNZtO4m+FDwlEwAohHUgJl
         X43wxNAA5ce5TJIGtPpvAfzwglCaNRlZFxXfKialpRtmBWKIGXRldOK/XYIXBQC7jYAQ
         vY6rDNnUXuWz4FPwxRe3jrfeHWsE2zwwmWblF3bYndRRK6GoA9t81Lz16UUxf7Sh6E6/
         Bs8LzOAW3HiXv8bKoUEnCiQXa82x7kShsH5W56/UbOh74uu+nVANiVN14r/Fxr8HKczn
         NxAQ==
X-Gm-Message-State: AOAM532heElPjQuyCwcSIZitqmPXl9z+pGVLvjsHgO+LGFoTinRpwXgM
        Chsj7nIq71u8E59CGR6qQVHoGA==
X-Google-Smtp-Source: ABdhPJzKiRNtosO8NGGmlAvudBt+rTXzZbJH1MOqFeWC9h7MElpsoLs64t0rf2Oe+W2vSevTayY3ew==
X-Received: by 2002:a17:90b:11d1:: with SMTP id gv17mr15654111pjb.3.1602480150206;
        Sun, 11 Oct 2020 22:22:30 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id b6sm21266225pjq.42.2020.10.11.22.22.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Oct 2020 22:22:29 -0700 (PDT)
Date:   Mon, 12 Oct 2020 10:52:27 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sumit Gupta <sumitg@nvidia.com>
Cc:     rjw@rjwysocki.net, sudeep.holla@arm.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ksitaraman@nvidia.com,
        bbasu@nvidia.com
Subject: Re: [PATCH v2 1/2] cpufreq: tegra194: get consistent cpuinfo_cur_freq
Message-ID: <20201012052227.x3bigztr7fit4jdz@vireshk-i7>
References: <1602162066-26442-1-git-send-email-sumitg@nvidia.com>
 <1602162066-26442-2-git-send-email-sumitg@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1602162066-26442-2-git-send-email-sumitg@nvidia.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-10-20, 18:31, Sumit Gupta wrote:
> Frequency returned by 'cpuinfo_cur_freq' using counters is not fixed
> and keeps changing slightly. This change returns a consistent value
> from freq_table. If the reconstructed frequency has acceptable delta
> from the last written value, then return the frequency corresponding
> to the last written ndiv value from freq_table. Otherwise, print a
> warning and return the reconstructed freq.
> 
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>  drivers/cpufreq/tegra194-cpufreq.c | 71 +++++++++++++++++++++++++++++++++-----
>  1 file changed, 62 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/cpufreq/tegra194-cpufreq.c b/drivers/cpufreq/tegra194-cpufreq.c
> index e1d931c..d250e49 100644
> --- a/drivers/cpufreq/tegra194-cpufreq.c
> +++ b/drivers/cpufreq/tegra194-cpufreq.c
> @@ -180,9 +180,70 @@ static unsigned int tegra194_get_speed_common(u32 cpu, u32 delay)
>  	return (rate_mhz * KHZ); /* in KHz */
>  }
>  
> +static void get_cpu_ndiv(void *ndiv)
> +{
> +	u64 ndiv_val;
> +
> +	asm volatile("mrs %0, s3_0_c15_c0_4" : "=r" (ndiv_val) : );
> +
> +	*(u64 *)ndiv = ndiv_val;
> +}
> +
> +static void set_cpu_ndiv(void *data)

You weren't required to do this unnecessary change.

> +{
> +	struct cpufreq_frequency_table *tbl = data;
> +	u64 ndiv_val = (u64)tbl->driver_data;
> +
> +	asm volatile("msr s3_0_c15_c0_4, %0" : : "r" (ndiv_val));
> +}
> +
>  static unsigned int tegra194_get_speed(u32 cpu)
>  {
> -	return tegra194_get_speed_common(cpu, US_DELAY);
> +	struct tegra194_cpufreq_data *data = cpufreq_get_driver_data();
> +	struct cpufreq_frequency_table *pos;
> +	unsigned int rate;
> +	u64 ndiv;
> +	int ret;
> +	u32 cl;
> +
> +	if (!cpu_online(cpu))

This isn't required. The CPU is guaranteed to be online here.

> +		return -EINVAL;
> +
> +	smp_call_function_single(cpu, get_cpu_cluster, &cl, true);
> +
> +	if (cl >= data->num_clusters)

Is it really possible here ? I meant you must have already checked
this at cpufreq-init level already. Else mark it unlikely at least.

> +		return -EINVAL;
> +
> +	/* reconstruct actual cpu freq using counters */
> +	rate = tegra194_get_speed_common(cpu, US_DELAY);
> +
> +	/* get last written ndiv value */
> +	ret = smp_call_function_single(cpu, get_cpu_ndiv, &ndiv, true);
> +	if (ret) {

What exactly can fail here ? get_cpu_ndiv() can't fail. Do we really
need this check ? What about WARN_ON_ONCE() ?

> +		pr_err("cpufreq: Failed to get ndiv for CPU%d, ret:%d\n",
> +		       cpu, ret);
> +		return rate;
> +	}
> +
> +	/*
> +	 * If the reconstructed frequency has acceptable delta from
> +	 * the last written value, then return freq corresponding
> +	 * to the last written ndiv value from freq_table. This is
> +	 * done to return consistent value.
> +	 */
> +	cpufreq_for_each_valid_entry(pos, data->tables[cl]) {
> +		if (pos->driver_data != ndiv)
> +			continue;
> +
> +		if (abs(pos->frequency - rate) > 115200) {

where does this 115200 comes from ? Strange that it matches tty's baud
rate :)

This is 115 MHz, right ? Isn't that too big of a delta ?

> +			pr_warn("cpufreq: cpu%d,cur:%u,set:%u,set ndiv:%llu\n",
> +				cpu, rate, pos->frequency, ndiv);
> +		} else {
> +			rate = pos->frequency;
> +		}
> +		break;
> +	}
> +	return rate;
>  }

-- 
viresh

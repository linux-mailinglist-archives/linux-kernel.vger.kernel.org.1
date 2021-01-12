Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD4642F2DCB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 12:21:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbhALLV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 06:21:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbhALLVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 06:21:24 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C397C061786
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 03:20:44 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id q4so1230654plr.7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 03:20:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gO/ONvJS/lYwOKo2vZirVkiqYC7odDjoVLCIXEUYZEU=;
        b=qMgOdEw2cCptoaMHXp/d6/waoBiD3/s/aN/YTBAtSeVjsdGeh9/k9M/Njt9svovqcX
         /YGrm/1PCp2+UU77yOqMzb7BukB70/o8hSs5KXuEiSS/X/AxOrm3Vsz5q/2Hw9Vowvdw
         eySX01PcKwwP8mWMZxgekw0cB5pEQE9en5WyAYpIn7O32cVk+Ydx5vOicZnkPb0QXw8f
         5GtcAGmuRZQ0z6KRB21FlmSLzBwwwBi3qTT0a+M2eJic/4xqpm8p+kHdbMX1vMsOiU0R
         r8nOCU++G/lYH+D5eFPU5D0GvnJD5VjuRDl7o1+yLQ0YLiFzo+TGujK5xM+3nYiqd9Js
         aJlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gO/ONvJS/lYwOKo2vZirVkiqYC7odDjoVLCIXEUYZEU=;
        b=GjXxVBH88pFwnLXlgEFtaeBmUOZRVQobwVvlRMY+qgGKn8hWMOa4IeMjsevJ2Vhz7X
         xIHB1uNrx+jmR7tzjbyloD42gCrcsIK77DOrHAKbHd0j8rAfS/hfqBxBOmLBcADRYyaz
         qGiA57CkTeq3cRZzjhiwfMgs6eVmpWrIZWwK269Psyyu0b9OXsN2soHwovMoytb2q461
         F7QSJYPdlMRGFmr5XjJSbVK1nvZgXAYD3bjCebxJHLkH/06Xe+c08rNZq3wKfcajV9+a
         QMEG5E+e0OQw2fPTI65Qwz+MDY/341Ub49e3fdKuh0C6dOGnPeVSpRlPlvM9t6jq4oBm
         2NEA==
X-Gm-Message-State: AOAM533lTMvMZVAEvweYT8ZLolpD5nfPjF9sbWbXCKqSptzLojr8ikgH
        DfIxnulpMb05/nbsG8G7x8h1YA==
X-Google-Smtp-Source: ABdhPJwKshbH4LDb8t63vzxoPC1twvdvEkbnAXjZF9InmvqfQx5PcVzfmoqZzqW484nfpIIu676yug==
X-Received: by 2002:a17:902:8d8d:b029:dc:4609:58a9 with SMTP id v13-20020a1709028d8db02900dc460958a9mr4669839plo.27.1610450443973;
        Tue, 12 Jan 2021 03:20:43 -0800 (PST)
Received: from localhost ([122.172.85.111])
        by smtp.gmail.com with ESMTPSA id h18sm2875586pfo.172.2021.01.12.03.20.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jan 2021 03:20:43 -0800 (PST)
Date:   Tue, 12 Jan 2021 16:50:41 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Nicola Mazzucato <nicola.mazzucato@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, sudeep.holla@arm.com, rjw@rjwysocki.net,
        vireshk@kernel.org, cristian.marussi@arm.com,
        morten.rasmussen@arm.com, chris.redpath@arm.com
Subject: Re: [PATCH v6 3/4] scmi-cpufreq: Get opp_shared_cpus from opp-v2 for
 EM
Message-ID: <20210112112041.7kjjrrgsqfbuq5mh@vireshk-i7>
References: <20210111154524.20196-1-nicola.mazzucato@arm.com>
 <20210111154524.20196-4-nicola.mazzucato@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210111154524.20196-4-nicola.mazzucato@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-01-21, 15:45, Nicola Mazzucato wrote:
> By design, SCMI performance domains define the granularity of
> performance controls, they do not describe any underlying hardware
> dependencies (although they may match in many cases).
> 
> It is therefore possible to have some platforms where hardware may have
> the ability to control CPU performance at different granularity and choose
> to describe fine-grained performance control through SCMI.
> 
> In such situations, the energy model would be provided with inaccurate
> information based on controls, while it still needs to know the
> performance boundaries.
> 
> To restore correct functionality, retrieve information of CPUs under the
> same performance domain from operating-points-v2 in DT, and pass it on to
> EM.
> 
> Signed-off-by: Nicola Mazzucato <nicola.mazzucato@arm.com>
> ---
>  drivers/cpufreq/scmi-cpufreq.c | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
> index 4aa97cdc5997..ff6ba6fab58b 100644
> --- a/drivers/cpufreq/scmi-cpufreq.c
> +++ b/drivers/cpufreq/scmi-cpufreq.c
> @@ -226,9 +226,12 @@ static int scmi_init_device(const struct scmi_handle *handle, int cpu)
>  	struct em_data_callback em_cb = EM_DATA_CB(scmi_get_cpu_power);
>  	bool power_scale_mw;
>  	cpumask_var_t scmi_cpus;
> +	cpumask_var_t opp_shared_cpus;
>  
>  	if (!zalloc_cpumask_var(&scmi_cpus, GFP_KERNEL))
>  		return -ENOMEM;
> +	if (!zalloc_cpumask_var(&opp_shared_cpus, GFP_KERNEL))
> +		return -ENOMEM;
>  
>  	cpumask_set_cpu(cpu, scmi_cpus);
>  
> @@ -240,6 +243,20 @@ static int scmi_init_device(const struct scmi_handle *handle, int cpu)
>  		goto free_cpumask;
>  	}
>  
> +	/*
> +	 * The OPP 'sharing cpus' info may come from dt through an empty opp
> +	 * table and opp-shared. If found, it takes precedence over the SCMI
> +	 * domain IDs info.
> +	 */
> +	ret = dev_pm_opp_of_get_sharing_cpus(cpu_dev, opp_shared_cpus);

If this succeeds, you shouldn't even try to call the other
get_sharing_cpus variant.

> +	if (ret || !cpumask_weight(opp_shared_cpus)) {
> +		/*
> +		 * Either opp-table is not set or no opp-shared was found,
> +		 * use the information from SCMI domain IDs.
> +		 */
> +		cpumask_copy(opp_shared_cpus, scmi_cpus);
> +	}
> +
>  	/*
>  	 * We get here for each CPU. Add OPPs only on those CPUs for which we
>  	 * haven't already done so, or set their OPPs as shared.
> @@ -252,7 +269,7 @@ static int scmi_init_device(const struct scmi_handle *handle, int cpu)
>  			goto free_cpumask;
>  		}
>  
> -		ret = dev_pm_opp_set_sharing_cpus(cpu_dev, scmi_cpus);
> +		ret = dev_pm_opp_set_sharing_cpus(cpu_dev, opp_shared_cpus);
>  		if (ret) {
>  			dev_err(cpu_dev, "%s: failed to mark OPPs as shared: %d\n",
>  				__func__, ret);
> @@ -269,7 +286,7 @@ static int scmi_init_device(const struct scmi_handle *handle, int cpu)
>  		}
>  
>  		power_scale_mw = handle->perf_ops->power_scale_mw_get(handle);
> -		em_dev_register_perf_domain(cpu_dev, nr_opp, &em_cb, scmi_cpus,
> +		em_dev_register_perf_domain(cpu_dev, nr_opp, &em_cb, opp_shared_cpus,
>  					    power_scale_mw);
>  	}
>  
> @@ -284,6 +301,7 @@ static int scmi_init_device(const struct scmi_handle *handle, int cpu)
>  
>  free_cpumask:
>  	free_cpumask_var(scmi_cpus);
> +	free_cpumask_var(opp_shared_cpus);
>  	return ret;
>  }
>  
> -- 
> 2.27.0

-- 
viresh

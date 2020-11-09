Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8692AB18F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 08:07:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729587AbgKIHHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 02:07:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728038AbgKIHHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 02:07:05 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54403C0613CF
        for <linux-kernel@vger.kernel.org>; Sun,  8 Nov 2020 23:07:05 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id q5so4258782pfk.6
        for <linux-kernel@vger.kernel.org>; Sun, 08 Nov 2020 23:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nPsivzFnUFcTnAHnLie1lQeFTXu73w43pTOVl9JFtLI=;
        b=cEywt5eFMRJgl6Effy/26SzrcKAwgtX9QlDVK2B7jJeYGfx0wYO5bCAh0cKbOr4afo
         +CUGLC805mXYilaKLAVwws14vQEGpeTvGzGMmvnX8ZCJCcKTZ7rXWpLFaAjs5pJVoNbP
         26LIhhDH7XTnA7H2AszAdQ7cV/b9xXkU2r4gcLF5maHpd7PX3xFN0629YDViMBrtyort
         K5MfhA1o4rWPNiLMqiJIsWDARpXVMidsl46SlyWs04Rdm0t2snUWPnYazDbZuGyI65ZE
         d9kSenXVPRlSolbxR/+Fy9R5+GFWqBL69UZvvuPR4FTHAympdZ5BbNgFw6UmE8AFOkSy
         YrQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nPsivzFnUFcTnAHnLie1lQeFTXu73w43pTOVl9JFtLI=;
        b=Nf3jZK2tK2HDVbPgFO3R/32S8v+yc7I1suUrL67tdhUQbURdBR9ygjyMzNwMWr+rUf
         5OP1WQ3ioGGvmgIK9TJ3VvvE8kXHo0Ry3hRJpqzGiZF27V1DFWq2qvRmdkxMudMqjaG2
         qQrf+H+ARx7P1X9p8oupMDwwH42Vl8+3EH1Bkkfv3hZoAcD8u52yJS4KP7kUgU8lLHtL
         J//ixzbMWu+AqOUmmrlWHIH4zPshOYPhoBD/dxoIAgq+2ZPTOiiX5vb2zfaYd3IWCaUs
         V9M1IQAIJhWdNEdG7rMXldYS2F6X7bzCeTDyZN/xAloWejsJ3HiBlYsORRiGp4OXd7Fs
         /FjA==
X-Gm-Message-State: AOAM532ftZkSpC5f4i3WYZDtBQ+EWgKZp0I9Rlf1/qYqzSU2LdC3+G8F
        DOifcwUxs0HtBBMC28t9vL00WQ==
X-Google-Smtp-Source: ABdhPJzJLosN7oEZtZrOk+2/yKkKRx6+mj8gYsZaHrzCywB50PtaEci23aXJZEV4UnLfsBD7q89cSw==
X-Received: by 2002:a17:90a:5b0a:: with SMTP id o10mr3219441pji.197.1604905624953;
        Sun, 08 Nov 2020 23:07:04 -0800 (PST)
Received: from localhost ([122.172.12.172])
        by smtp.gmail.com with ESMTPSA id r2sm10216403pji.55.2020.11.08.23.07.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Nov 2020 23:07:04 -0800 (PST)
Date:   Mon, 9 Nov 2020 12:37:02 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     rjw@rjwysocki.net, lenb@kernel.org, sudeep.holla@arm.com,
        morten.rasmussen@arm.com, jeremy.linton@arm.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/8] cppc_cpufreq: clarify support for coordination types
Message-ID: <20201109070702.2hod2xh7fddobnkl@vireshk-i7>
References: <20201105125524.4409-1-ionela.voinescu@arm.com>
 <20201105125524.4409-7-ionela.voinescu@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201105125524.4409-7-ionela.voinescu@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05-11-20, 12:55, Ionela Voinescu wrote:
> The previous coordination type handling in the cppc_cpufreq init code
> created some confusion: the comment mentioned "Support only SW_ANY for
> now" while only the SW_ALL/ALL case resulted in a failure. The other
> coordination types (HW_ALL/HW, NONE) were silently supported.
> 
> Clarify support for coordination types while describing in comments the
> intended behavior.
> 
> Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cppc_cpufreq.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index fd2daeb59b49..60ac7f8049b5 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -363,11 +363,22 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  	policy->transition_delay_us = cppc_cpufreq_get_transition_delay_us(cpu);
>  	policy->shared_type = domain->shared_type;
>  
> -	if (policy->shared_type == CPUFREQ_SHARED_TYPE_ANY) {
> +	switch (policy->shared_type) {
> +	case CPUFREQ_SHARED_TYPE_HW:
> +	case CPUFREQ_SHARED_TYPE_NONE:
> +		/* Nothing to be done - we'll have a policy for each CPU */
> +		break;
> +	case CPUFREQ_SHARED_TYPE_ANY:
> +		/*
> +		 * All CPUs in the domain will share a policy and all cpufreq
> +		 * operations will use a single cppc_cpudata structure stored
> +		 * in policy->driver_data.
> +		 */
>  		cpumask_copy(policy->cpus, domain->shared_cpu_map);
> -	} else if (policy->shared_type == CPUFREQ_SHARED_TYPE_ALL) {
> -		/* Support only SW_ANY for now. */
> -		pr_debug("Unsupported CPU co-ord type\n");
> +		break;
> +	default:
> +		pr_info("Unsupported cpufreq CPU co-ord type: %d\n",
> +			policy->shared_type);
>  		return -EFAULT;
>  	}
>  

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

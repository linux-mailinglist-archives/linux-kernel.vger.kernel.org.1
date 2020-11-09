Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF1C2AB18D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 08:05:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729411AbgKIHFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 02:05:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728873AbgKIHFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 02:05:35 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECEBFC0613D3
        for <linux-kernel@vger.kernel.org>; Sun,  8 Nov 2020 23:05:34 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id g7so7243401pfc.2
        for <linux-kernel@vger.kernel.org>; Sun, 08 Nov 2020 23:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=epMOivhj1EApMDHKjF5sX0TPV7pUrn5ftIs27exmojo=;
        b=yPsC+QihxyW2PTd/k3msNmL2iXBiyY7JAdmdzZlW8X/2LSqKmOQQ0gPkfY4iTmncUB
         fnWH2j3TueJbGpLtQnbb6HIKb1zhCvBNL7ys7XebgaAIqoqNAaLB+VBb7o1vj34G9pgv
         nxTQ2I7pQW5Kr645RuweSf3Czb6Ku8kB/Eb7guzZDEovoNB2BkkhNPi4EZamH6F2r76g
         2n0uepT4GFCFrU9UUGbcKKA4p45iZXcCJFlBZ7JyskKglYqoZdRbK6iMygC5zPzNZmjP
         fO2bn7TRkrh0CjfOvlBkRym1HdL8sYG285tjgZdG+RKTszZa4EW9TBhOqIVOIc5Oz52e
         g7SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=epMOivhj1EApMDHKjF5sX0TPV7pUrn5ftIs27exmojo=;
        b=kRtjGxJ4w+Vjo/i/mCgwUBCud2WA+SMVtsVVgHBqQ9TCJwVjf+HVwfBa9JiI6BxZ45
         9Fe9cKeceitSCoUKCoPk/WKk9RdhtFJSEkgjdH8io+TdIaezJZhgv7/ehsF6jHI3WjKv
         0l8u28LZxdYnhLoTSHaDsUDsRzQ+MJX41P67CZmDQLXrhWfdsaWFrBvsXCrB8G4FW1w5
         8FTrnfWGCtKhnxHoEapjpM2dpc0bOKkgfgTBlVeMCc2lCJknqtqd40N93850oNleB84M
         lBMNSG81TsDo6Sc5RInTfx48xGVvtEUK0QlRUfV5eKvx+yKY0J7umNqptxCOR92zdYXr
         GtFA==
X-Gm-Message-State: AOAM531wUerAOZ7DedfONoIEXnicJlB239baSqwCBUXSCOoZn7/7bHus
        5fQNzzGWkyXP99hM7fb5c3uVNqLMOIEGMg==
X-Google-Smtp-Source: ABdhPJwbCJJegOreqbeGm8UIq5shPsuDzRK5MpnViOxiHNEZpB+z1pu4ukED3jvhqVCQAnweo7kP8w==
X-Received: by 2002:a17:90a:5c82:: with SMTP id r2mr11513716pji.69.1604905534384;
        Sun, 08 Nov 2020 23:05:34 -0800 (PST)
Received: from localhost ([122.172.12.172])
        by smtp.gmail.com with ESMTPSA id v126sm9967550pfb.137.2020.11.08.23.05.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Nov 2020 23:05:33 -0800 (PST)
Date:   Mon, 9 Nov 2020 12:35:31 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     rjw@rjwysocki.net, lenb@kernel.org, sudeep.holla@arm.com,
        morten.rasmussen@arm.com, jeremy.linton@arm.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/8] cppc_cpufreq: use policy->cpu as driver of frequency
 setting
Message-ID: <20201109070531.jqoury5vniu3phdo@vireshk-i7>
References: <20201105125524.4409-1-ionela.voinescu@arm.com>
 <20201105125524.4409-6-ionela.voinescu@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201105125524.4409-6-ionela.voinescu@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05-11-20, 12:55, Ionela Voinescu wrote:
> Considering only the currently supported coordination types (ANY, HW,
> NONE), this change only makes a difference for the ANY type, when
> policy->cpu is hotplugged out. In that case the new policy->cpu will
> be different from ((struct cppc_cpudata *)policy->driver_data)->cpu.
> 
> While in this case the controls of *ANY* CPU could be used to drive
> frequency changes, it's more consistent to use policy->cpu as the
> leading CPU, as used in all other cppc_cpufreq functions. Additionally,
> the debug prints in cppc_set_perf() would no longer create confusion
> when referring to a CPU that is hotplugged out.
> 
> Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cppc_cpufreq.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index ac95b4424a2e..fd2daeb59b49 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -150,6 +150,7 @@ static int cppc_cpufreq_set_target(struct cpufreq_policy *policy,
>  
>  {
>  	struct cppc_cpudata *cpu_data = policy->driver_data;
> +	unsigned int cpu = policy->cpu;
>  	struct cpufreq_freqs freqs;
>  	u32 desired_perf;
>  	int ret = 0;
> @@ -164,12 +165,12 @@ static int cppc_cpufreq_set_target(struct cpufreq_policy *policy,
>  	freqs.new = target_freq;
>  
>  	cpufreq_freq_transition_begin(policy, &freqs);
> -	ret = cppc_set_perf(cpu_data->cpu, &cpu_data->perf_ctrls);
> +	ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
>  	cpufreq_freq_transition_end(policy, &freqs, ret != 0);
>  
>  	if (ret)
>  		pr_debug("Failed to set target on CPU:%d. ret:%d\n",
> -			 cpu_data->cpu, ret);
> +			 cpu, ret);
>  
>  	return ret;
>  }

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

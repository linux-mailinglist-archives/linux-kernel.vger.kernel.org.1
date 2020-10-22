Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C487C295CE6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 12:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896684AbgJVKrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 06:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2896664AbgJVKrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 06:47:09 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21295C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 03:47:07 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id v22so733326ply.12
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 03:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uGVhU4smGtP61qhIu7xcmfsOr0f4eACGr2l6M0jxpzc=;
        b=VM5T3ZvhLX0qcCX/KToG+n26Ce4gBD/qxYa1TPiG2Qel5jVmTaUMGUGaS+O8rDM4up
         +BXAiF+Eqgu+7NYruI82llTvjxGD346IvdxQzQ82cHH7DA4gSHtToXI9Qz+arbOD1k91
         pwKUlusPi3gcnmthbmFJknFqDlmc4Tu0WgI/meeVF3EPyqtuI33XM90lYiMVfWScfeGf
         H+syTY+HCIYKO8NqrLKft/OxVqqyHHI/N59OlDLntwcQKo1G27jKcjDzJBHCd/iQ8BJf
         cJDGhY2uaqu/iCyxWEBFIjUUjpPXHzsMdX5ywWqpCMZBu2ggC5Uawn38NJ74yp6NTjlZ
         D7ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uGVhU4smGtP61qhIu7xcmfsOr0f4eACGr2l6M0jxpzc=;
        b=XvE08oGz1JAZKSCxYF0am/SCq8rQekNgcaLh9jxd5NZtOUv364nmyLP0I9Psjw95KF
         oAYQG+lhRNrRxZrpAj6rAZLCm3FFFhsIa0xwcU6UK2P3ULzhN29NrI3To0f6vkAzuqu7
         /nlejgYI4U0+nv+viT4v8zGxcw/FxmLyWNw/x1aVSUNKZOFhCQdkj/2ynXgtkRg/eo9C
         ITCz+3k6rTL8yFW6cU0vE8gX54tT2mmneUViC5rlqMJzoK+GaRvz3MSWp3Ps21NRLT9T
         H6bqIjQRCv/z31LPPvEdrrxv8y4OjYE9eC1tdZw7TmCi/uLpW92+EiIdb7F45Kz9qkgT
         Xw3Q==
X-Gm-Message-State: AOAM533ZLFJCl1U2AWhbyl5vQ0ZZpH+32RbNZfssBswumvxcCLWW4n42
        2ympsQJJcCYdSoOg7y2k/2ULyA==
X-Google-Smtp-Source: ABdhPJwTP8kMgng+Oi6VrHYCek2dgCEO+numt84Cv2NW3ZBCvqHSrNOpH6yjpJHG29ujw+hzWLHoWw==
X-Received: by 2002:a17:902:bd48:b029:d2:8ce7:2d4c with SMTP id b8-20020a170902bd48b02900d28ce72d4cmr1935219plx.42.1603363626462;
        Thu, 22 Oct 2020 03:47:06 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id j15sm1921804pgn.32.2020.10.22.03.47.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Oct 2020 03:47:05 -0700 (PDT)
Date:   Thu, 22 Oct 2020 16:17:03 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Julia Lawall <julia.lawall@inria.fr>,
        Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@redhat.com>,
        kernel-janitors@vger.kernel.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org,
        Valentin Schneider <valentin.schneider@arm.com>,
        Gilles Muller <Gilles.Muller@inria.fr>,
        srinivas.pandruvada@linux.intel.com
Subject: Re: [PATCH] sched/fair: check for idle core
Message-ID: <20201022104703.nw45dwor6wfn4ity@vireshk-i7>
References: <1603211879-1064-1-git-send-email-Julia.Lawall@inria.fr>
 <20201021121950.GF2628@hirez.programming.kicks-ass.net>
 <20201021131026.GY2651@hirez.programming.kicks-ass.net>
 <6145907.dAfbsivgMF@kreacher>
 <20201022071145.GM2628@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201022071145.GM2628@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-10-20, 09:11, Peter Zijlstra wrote:
> Well, but we need to do something to force people onto schedutil,
> otherwise we'll get more crap like this thread.
> 
> Can we take the choice away? Only let Kconfig select which governors are
> available and then set the default ourselves? I mean, the end goal being
> to not have selectable governors at all, this seems like a good step
> anyway.

Just to clarify and complete the point a bit here, the users can still
pass the default governor from cmdline using
cpufreq.default_governor=, which will take precedence over the one the
below code is playing with. And later once the kernel is up, they can
still choose a different governor from userspace.

> ---
> 
> diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
> index 2c7171e0b001..3a9f54b382c0 100644
> --- a/drivers/cpufreq/Kconfig
> +++ b/drivers/cpufreq/Kconfig
> @@ -34,77 +34,6 @@ config CPU_FREQ_STAT
>  
>  	  If in doubt, say N.
>  
> -choice
> -	prompt "Default CPUFreq governor"
> -	default CPU_FREQ_DEFAULT_GOV_USERSPACE if ARM_SA1100_CPUFREQ || ARM_SA1110_CPUFREQ
> -	default CPU_FREQ_DEFAULT_GOV_SCHEDUTIL if ARM64 || ARM
> -	default CPU_FREQ_DEFAULT_GOV_SCHEDUTIL if X86_INTEL_PSTATE && SMP
> -	default CPU_FREQ_DEFAULT_GOV_PERFORMANCE
> -	help
> -	  This option sets which CPUFreq governor shall be loaded at
> -	  startup. If in doubt, use the default setting.
> -
> -config CPU_FREQ_DEFAULT_GOV_PERFORMANCE
> -	bool "performance"
> -	select CPU_FREQ_GOV_PERFORMANCE
> -	help
> -	  Use the CPUFreq governor 'performance' as default. This sets
> -	  the frequency statically to the highest frequency supported by
> -	  the CPU.
> -
> -config CPU_FREQ_DEFAULT_GOV_POWERSAVE
> -	bool "powersave"
> -	select CPU_FREQ_GOV_POWERSAVE
> -	help
> -	  Use the CPUFreq governor 'powersave' as default. This sets
> -	  the frequency statically to the lowest frequency supported by
> -	  the CPU.
> -
> -config CPU_FREQ_DEFAULT_GOV_USERSPACE
> -	bool "userspace"
> -	select CPU_FREQ_GOV_USERSPACE
> -	help
> -	  Use the CPUFreq governor 'userspace' as default. This allows
> -	  you to set the CPU frequency manually or when a userspace 
> -	  program shall be able to set the CPU dynamically without having
> -	  to enable the userspace governor manually.
> -
> -config CPU_FREQ_DEFAULT_GOV_ONDEMAND
> -	bool "ondemand"
> -	select CPU_FREQ_GOV_ONDEMAND
> -	select CPU_FREQ_GOV_PERFORMANCE
> -	help
> -	  Use the CPUFreq governor 'ondemand' as default. This allows
> -	  you to get a full dynamic frequency capable system by simply
> -	  loading your cpufreq low-level hardware driver.
> -	  Be aware that not all cpufreq drivers support the ondemand
> -	  governor. If unsure have a look at the help section of the
> -	  driver. Fallback governor will be the performance governor.
> -
> -config CPU_FREQ_DEFAULT_GOV_CONSERVATIVE
> -	bool "conservative"
> -	select CPU_FREQ_GOV_CONSERVATIVE
> -	select CPU_FREQ_GOV_PERFORMANCE
> -	help
> -	  Use the CPUFreq governor 'conservative' as default. This allows
> -	  you to get a full dynamic frequency capable system by simply
> -	  loading your cpufreq low-level hardware driver.
> -	  Be aware that not all cpufreq drivers support the conservative
> -	  governor. If unsure have a look at the help section of the
> -	  driver. Fallback governor will be the performance governor.
> -
> -config CPU_FREQ_DEFAULT_GOV_SCHEDUTIL
> -	bool "schedutil"
> -	depends on SMP
> -	select CPU_FREQ_GOV_SCHEDUTIL
> -	select CPU_FREQ_GOV_PERFORMANCE
> -	help
> -	  Use the 'schedutil' CPUFreq governor by default. If unsure,
> -	  have a look at the help section of that governor. The fallback
> -	  governor will be 'performance'.
> -
> -endchoice
> -
>  config CPU_FREQ_GOV_PERFORMANCE
>  	tristate "'performance' governor"
>  	help
> @@ -145,6 +74,7 @@ config CPU_FREQ_GOV_USERSPACE
>  config CPU_FREQ_GOV_ONDEMAND
>  	tristate "'ondemand' cpufreq policy governor"
>  	select CPU_FREQ_GOV_COMMON
> +	select CPU_FREQ_GOV_PERFORMANCE
>  	help
>  	  'ondemand' - This driver adds a dynamic cpufreq policy governor.
>  	  The governor does a periodic polling and 
> @@ -164,6 +94,7 @@ config CPU_FREQ_GOV_CONSERVATIVE
>  	tristate "'conservative' cpufreq governor"
>  	depends on CPU_FREQ
>  	select CPU_FREQ_GOV_COMMON
> +	select CPU_FREQ_GOV_PERFORMANCE
>  	help
>  	  'conservative' - this driver is rather similar to the 'ondemand'
>  	  governor both in its source code and its purpose, the difference is
> @@ -188,6 +119,7 @@ config CPU_FREQ_GOV_SCHEDUTIL
>  	bool "'schedutil' cpufreq policy governor"
>  	depends on CPU_FREQ && SMP
>  	select CPU_FREQ_GOV_ATTR_SET
> +	select CPU_FREQ_GOV_PERFORMANCE

And I am not really sure why we always wanted this backup performance
governor to be there unless the said governors are built as module.

>  	select IRQ_WORK
>  	help
>  	  This governor makes decisions based on the utilization data provided
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 1877f5e2e5b0..6848e3337b65 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -626,6 +626,49 @@ static struct cpufreq_governor *find_governor(const char *str_governor)
>  	return NULL;
>  }
>  
> +static struct cpufreq_governor *cpufreq_default_governor(void)
> +{
> +	struct cpufreq_governor *gov = NULL;
> +
> +#ifdef CONFIG_CPU_FREQ_GOV_SCHEDUTIL
> +	gov = find_governor("schedutil");
> +	if (gov)
> +		return gov;
> +#endif
> +
> +#ifdef CONFIG_CPU_FREQ_GOV_ONDEMAND
> +	gov = find_governor("ondemand");
> +	if (gov)
> +		return gov;
> +#endif
> +
> +#ifdef CONFIG_CPU_FREQ_GOV_CONSERVATIVE
> +	gov = find_governor("conservative");
> +	if (gov)
> +		return gov;
> +#endif
> +
> +#ifdef CONFIG_CPU_FREQ_GOV_USERSPACE
> +	gov = find_governor("userspace");
> +	if (gov)
> +		return gov;
> +#endif
> +
> +#ifdef CONFIG_CPU_FREQ_GOV_POWERSAVE
> +	gov = find_governor("powersave");
> +	if (gov)
> +		return gov;
> +#endif
> +
> +#ifdef CONFIG_CPU_FREQ_GOV_PERFORMANCE
> +	gov = find_governor("performance");
> +	if (gov)
> +		return gov;
> +#endif
> +
> +	return gov;
> +}

I think that would be fine with me. Though we would be required to
update couple of defconfigs here to make sure they keep working the
way they wanted to.

-- 
viresh

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0023929575D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 06:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2507598AbgJVElx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 00:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502378AbgJVElw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 00:41:52 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA394C0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 21:41:52 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id b6so278069pju.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 21:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7cJzNVPTTZFNbgG47IvnfLgtVfjxwapjyKuc8PcpjN4=;
        b=xZGB1UcW7HN6Va9qQ5hUDPjWcLDkfHdquLwX9mzPkfbp7sqA4ieXHrOO8Xv9UExSlB
         kg54dI+rO/lxFGuS9tynSpcn88hn/CKZxYcKENgSuoM0rrmCBM2frmv+DgxMi8+fX2/S
         50ck3oFdYYFz0Yw4EriYJFi417ikDO8yXpiNUQbkAopYoQlQONi5TuBI/9qK/o1/zXfW
         xVKNG9Cuwuhjtwf9h6a5WNbA6m+Y1a82X5gh93CgF/i7KGlbOiwtYBApGm43fS3rKZWe
         GcEHDp1lYOGf9mt2CelCqCo2wspbHTiuWjk1i+4mxGpOX0WWtx5tKZMT0m+qpHWnti8k
         TwKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7cJzNVPTTZFNbgG47IvnfLgtVfjxwapjyKuc8PcpjN4=;
        b=WeFMLGjG7Rth3WPox4PKIiy3/OzTEN3frmtuCZTeYVUw48Fn7scmZw5CfDuj+O35Lh
         0Y4+/iv9jq3kEIhY5U1G9FpO82UT+frpOakwyzyubEEujdxTgADyFpl5iKsy4MDL125y
         mxnfhv6xjjdltn7ZkFt+sctfts51YwIhPl9/wFpLBikie8vZvCe1PuPeBLZ8LKwIL3vW
         IX3/FcS5AwNxGkHLYFfDmTjqONsEuZGZq3+a7RYrlW6AhLfKcYI4nMxBaqWp8s/n8Ggx
         JGQ5VaeL/cMMRAFUIph473iEmoome84XuVCXZkgvhzqnYTCWR7hrnBaKTsH5DIbXX+p5
         qGRg==
X-Gm-Message-State: AOAM533Y5o1Oq0QV/PySYDcpH7k3JD3siRPxbkGVon6xFq9wHbcCs7Si
        waa3pyNXYMyWpbLdW/v5r7Dx+g==
X-Google-Smtp-Source: ABdhPJy7Kz2kXU/0CPE+lAJ2lEmZJm3/kX8MrWizdVmhljhiSlm0s7h+wYVIwi15OCd/hOgvbZMRKA==
X-Received: by 2002:a17:902:b111:b029:d4:cf7c:2ff1 with SMTP id q17-20020a170902b111b02900d4cf7c2ff1mr736017plr.59.1603341712084;
        Wed, 21 Oct 2020 21:41:52 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id w6sm478127pgw.28.2020.10.21.21.41.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Oct 2020 21:41:51 -0700 (PDT)
Date:   Thu, 22 Oct 2020 10:11:46 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <20201022044146.4n2jl6jzyycfhfzg@vireshk-i7>
References: <1603211879-1064-1-git-send-email-Julia.Lawall@inria.fr>
 <20201021121950.GF2628@hirez.programming.kicks-ass.net>
 <20201021131026.GY2651@hirez.programming.kicks-ass.net>
 <6145907.dAfbsivgMF@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6145907.dAfbsivgMF@kreacher>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-10-20, 20:11, Rafael J. Wysocki wrote:
> On Wednesday, October 21, 2020 3:10:26 PM CEST Peter Zijlstra wrote:
> > On Wed, Oct 21, 2020 at 02:19:50PM +0200, Peter Zijlstra wrote:
> > > On Wed, Oct 21, 2020 at 01:56:55PM +0200, Julia Lawall wrote:
> > > > Prior to 5.8, my machine was using intel_pstate and had few background
> > > > tasks.  Thus the problem wasn't visible in practice.  Starting with 5.8
> > > > the kernel decided that intel_cpufreq would be more appropriate, which
> > > > introduced kworkers every 0.004 seconds on all cores.
> > > 
> > > That still doesn't make any sense. Are you running the legacy on-demand
> > > thing or something?
> > > 
> > > Rafael, Srinivas, Viresh, how come it defaults to that?
> > 
> > Does we want something like this?
> > 
> > ---
> >  arch/x86/configs/i386_defconfig   | 3 +--
> >  arch/x86/configs/x86_64_defconfig | 3 +--
> >  drivers/cpufreq/Kconfig           | 7 +++++--
> >  3 files changed, 7 insertions(+), 6 deletions(-)
> > 
> > diff --git a/arch/x86/configs/i386_defconfig b/arch/x86/configs/i386_defconfig
> > index 78210793d357..c343ad459737 100644
> > --- a/arch/x86/configs/i386_defconfig
> > +++ b/arch/x86/configs/i386_defconfig
> > @@ -41,8 +41,7 @@ CONFIG_PM_DEBUG=y
> >  CONFIG_PM_TRACE_RTC=y
> >  CONFIG_ACPI_DOCK=y
> >  CONFIG_ACPI_BGRT=y
> > -CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE=y
> > -CONFIG_CPU_FREQ_GOV_ONDEMAND=y
> > +CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL=y
> >  CONFIG_X86_ACPI_CPUFREQ=y
> >  CONFIG_EFI_VARS=y
> >  CONFIG_KPROBES=y
> > diff --git a/arch/x86/configs/x86_64_defconfig b/arch/x86/configs/x86_64_defconfig
> > index 9936528e1939..23e1ea85c1ec 100644
> > --- a/arch/x86/configs/x86_64_defconfig
> > +++ b/arch/x86/configs/x86_64_defconfig
> > @@ -38,8 +38,7 @@ CONFIG_PM_DEBUG=y
> >  CONFIG_PM_TRACE_RTC=y
> >  CONFIG_ACPI_DOCK=y
> >  CONFIG_ACPI_BGRT=y
> > -CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE=y
> > -CONFIG_CPU_FREQ_GOV_ONDEMAND=y
> > +CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL=y
> >  CONFIG_X86_ACPI_CPUFREQ=y
> >  CONFIG_IA32_EMULATION=y
> >  CONFIG_EFI_VARS=y
> > diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
> > index 2c7171e0b001..8dfca6e9b836 100644
> > --- a/drivers/cpufreq/Kconfig
> > +++ b/drivers/cpufreq/Kconfig
> > @@ -37,8 +37,7 @@ config CPU_FREQ_STAT
> >  choice
> >  	prompt "Default CPUFreq governor"
> >  	default CPU_FREQ_DEFAULT_GOV_USERSPACE if ARM_SA1100_CPUFREQ || ARM_SA1110_CPUFREQ
> > -	default CPU_FREQ_DEFAULT_GOV_SCHEDUTIL if ARM64 || ARM
> > -	default CPU_FREQ_DEFAULT_GOV_SCHEDUTIL if X86_INTEL_PSTATE && SMP
> > +	default CPU_FREQ_DEFAULT_GOV_SCHEDUTIL if SMP
> >  	default CPU_FREQ_DEFAULT_GOV_PERFORMANCE
> >  	help
> >  	  This option sets which CPUFreq governor shall be loaded at
> > @@ -71,6 +70,7 @@ config CPU_FREQ_DEFAULT_GOV_USERSPACE
> >  
> >  config CPU_FREQ_DEFAULT_GOV_ONDEMAND
> >  	bool "ondemand"
> > +	depends on !SMP
> >  	select CPU_FREQ_GOV_ONDEMAND
> >  	select CPU_FREQ_GOV_PERFORMANCE
> >  	help
> > @@ -83,6 +83,7 @@ config CPU_FREQ_DEFAULT_GOV_ONDEMAND
> >  
> >  config CPU_FREQ_DEFAULT_GOV_CONSERVATIVE
> >  	bool "conservative"
> > +	depends on !SMP
> >  	select CPU_FREQ_GOV_CONSERVATIVE
> >  	select CPU_FREQ_GOV_PERFORMANCE
> >  	help
> 
> The changes above should work.
> 
> > @@ -144,6 +145,7 @@ config CPU_FREQ_GOV_USERSPACE
> >  
> >  config CPU_FREQ_GOV_ONDEMAND
> >  	tristate "'ondemand' cpufreq policy governor"
> > +	depends on !SMP
> 
> But I don't think that we can do this and the one below.

I have exactly the same comments.

> >  	select CPU_FREQ_GOV_COMMON
> >  	help
> >  	  'ondemand' - This driver adds a dynamic cpufreq policy governor.
> > @@ -163,6 +165,7 @@ config CPU_FREQ_GOV_ONDEMAND
> >  config CPU_FREQ_GOV_CONSERVATIVE
> >  	tristate "'conservative' cpufreq governor"
> >  	depends on CPU_FREQ
> > +	depends on !SMP
> >  	select CPU_FREQ_GOV_COMMON
> >  	help
> >  	  'conservative' - this driver is rather similar to the 'ondemand'
> > 
> 
> 
> 

-- 
viresh

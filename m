Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD48D2D5AA3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 13:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730172AbgLJMgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 07:36:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbgLJMgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 07:36:12 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4DE2C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 04:35:31 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id t7so3927741pfh.7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 04:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hdwWh04zzU88CLv3l5SqSPlVwD9LcmsUb5tkS37cFqI=;
        b=NePrJb6k8yCyfpevOCdGY5c4M/s4ISxDzP79s8WtJIcz3cGDo59aLzrv+IZvy1M+1b
         mb7qqmFY2KQCQjfLHNdWxPcecbrLKrzXQnaj1qtLbLx9PtfNVMrX2y3qyWJN17kSmEr3
         8YoMBoIs3677o3eCrynkmwiAslPLUGIxQqgRezVUAwiKXSI6wIO8rDF74IyFAJFDn7Xd
         /JhdHczws6sOD37ZuEDSmH34b4aS/B+QuFeUlaMl5mpKjxhUkJ+D86XfP2W5qi1PqIOA
         hays5qKCVmCXIf8r41TrFvC1FUN7yw1Xmh7Gbv7H3ehYhXfpu3pXl9+qWibzm8p/oBEY
         JHow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hdwWh04zzU88CLv3l5SqSPlVwD9LcmsUb5tkS37cFqI=;
        b=cBL2eS6+xetO8rl0Ryz7bTSKjTil/bYrbAngQ5g+4dKEKn+syqNlFfhggLFyrYGp10
         jneLlr7lxdxMNbOr7PvCC965UP7/AH6PrRE4QM6H4DJfvEovaLN5Sn+q3852N1HQh9qu
         YqS4AFc0wXk6C7h1TQCvpDkAM4EBx8e7pyhclMOPBhx0s2E9MgpLqddjBA36eVAbDace
         vHeDbwa/Prc8bAP3OGD92CFA/Z5R3MMC0KWM1cRJpaf0x6ekUxdmOG6rwHKY0/8QgyEf
         4omSdnz8FbFv+KeZVKTzQBQEL0s7ho5epkkr4DCQW4TazDgcudMgDRBjUEXV61t4Y9Ab
         u4Xg==
X-Gm-Message-State: AOAM530084H2XAsxlOfa0Od5cWBaWlk+YJmoUDn4leUPo5lD8Ro2Yqhf
        c00atJZryla19Y3qlYERzWoErj6PVenmpg==
X-Google-Smtp-Source: ABdhPJyev82ko6x8/xEdeviGQqL5KIllssf2ikbdrlfJZIvG4DKxIujvaC7g/h8G0Ub7VguJV2R7FQ==
X-Received: by 2002:a65:490c:: with SMTP id p12mr6461940pgs.98.1607603731547;
        Thu, 10 Dec 2020 04:35:31 -0800 (PST)
Received: from localhost ([122.172.20.109])
        by smtp.gmail.com with ESMTPSA id e3sm5803638pfe.154.2020.12.10.04.35.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Dec 2020 04:35:30 -0800 (PST)
Date:   Thu, 10 Dec 2020 18:05:27 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: topology: Avoid the
 static_branch_{enable|disable} dance
Message-ID: <20201210123527.ccl4k56hl5mc3jag@vireshk-i7>
References: <5594c7d6756a47b473ceb6f48cc217458db32ab0.1607584435.git.viresh.kumar@linaro.org>
 <10396de8046ada347d681eb84ea4dc6ec27e1742.1607593250.git.viresh.kumar@linaro.org>
 <20201210110906.GA5300@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201210110906.GA5300@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10-12-20, 11:09, Ionela Voinescu wrote:
> On Thursday 10 Dec 2020 at 15:12:25 (+0530), Viresh Kumar wrote:
> > Avoid the static_branch_enable() and static_branch_disable() dance by
> > redoing the code in a different way. We will be fully invariant here
> > only if amu_fie_cpus is set with all present CPUs, use that instead of
> > yet another call to topology_scale_freq_invariant().
> > 
> > This also avoids running rest of the routine if we enabled the static
> > branch, followed by a disable.
> > 
> > Also make the first call to topology_scale_freq_invariant() just when we
> > need it, instead of at the top of the routine. This makes it further
> > clear on why we need it, i.e. just around enabling AMUs use here.
> > 
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> >  arch/arm64/kernel/topology.c | 21 +++++++++------------
> >  1 file changed, 9 insertions(+), 12 deletions(-)
> > 
> > diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> > index 7f7d8de325b6..6dedc6ee91cf 100644
> > --- a/arch/arm64/kernel/topology.c
> > +++ b/arch/arm64/kernel/topology.c
> > @@ -221,7 +221,7 @@ static DEFINE_STATIC_KEY_FALSE(amu_fie_key);
> >  
> >  static int __init init_amu_fie(void)
> >  {
> > -	bool invariance_status = topology_scale_freq_invariant();
> > +	bool invariance_status;
> >  	cpumask_var_t valid_cpus;
> >  	int ret = 0;
> >  	int cpu;
> > @@ -255,18 +255,15 @@ static int __init init_amu_fie(void)
> >  	    cpumask_equal(valid_cpus, cpu_present_mask))
> >  		cpumask_copy(amu_fie_cpus, cpu_present_mask);
> >  
> > -	if (!cpumask_empty(amu_fie_cpus)) {
> > -		pr_info("CPUs[%*pbl]: counters will be used for FIE.",
> > -			cpumask_pr_args(amu_fie_cpus));
> > -		static_branch_enable(&amu_fie_key);
> > -	}
> 
> This check verifies if there are *any* CPUs for which AMUs can be used for
> FIE (!empty mask) -> enable static key.
> 
> > +	/* Disallow partial use of counters for frequency invariance */
> > +	if (!cpumask_equal(amu_fie_cpus, cpu_present_mask))
> > +		goto free_valid_mask;
> >  
> 
> The replacement verifies if *all* present CPUs support AMUs for FIE and
> only then it enables the static key.
> 
> > -	/*
> > -	 * If the system is not fully invariant after AMU init, disable
> > -	 * partial use of counters for frequency invariance.
> > -	 */
> > -	if (!topology_scale_freq_invariant())

I mis-read something here, as shared in the other thread, so yeah I
need to think again about this patch.

> > -		static_branch_disable(&amu_fie_key);
> > +	pr_info("CPUs[%*pbl]: counters will be used for FIE.",
> > +		cpumask_pr_args(amu_fie_cpus));
> > +
> > +	invariance_status = topology_scale_freq_invariant();
> > +	static_branch_enable(&amu_fie_key);
> >  
> >  	/*
> >  	 * Task scheduler behavior depends on frequency invariance support,
> > -- 
> > 2.25.0.rc1.19.g042ed3e048af
> > 

-- 
viresh

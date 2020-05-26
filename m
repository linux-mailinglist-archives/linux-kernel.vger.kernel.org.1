Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 193201D751A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 May 2020 12:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbgERKYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 May 2020 06:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbgERKYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 06:24:18 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E26FC05BD0B
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 03:24:18 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id 5so1722882pjd.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 03:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MN1cOtvKgI2CDdfH9WOPeSju4XcYLF26UcOgbNUXW2c=;
        b=s0jXev1kMMyFXAQc2MlxaXXGTQRsM9VMaTox1IL/2+po4rKJvNHbldSkIaPdSsIxZ8
         5WYkRgFYoASKVv+8qLmV5PRxhu7s1gF+uxWnoL4+oTFtJngKgRLUiJ6MPQg5Ft2zWJZG
         oOJmSifhMuJsM7gVceeeDadpRmpJdPJoajHSTnUh1LJF+caoQiUfo/7/hfxo6DZjN/BB
         ROGmQnVN4zeKIDdMfcw3SRZiryVueHB/tbEp9bXUtFd/NRbo++Cv0gc2t/8W89LAWKEa
         uf3ZKXCHhq+3lDBgXoilWViO008YLPDvSA+lZJF/+6Rz/Oj80isfSAjzuOeXk6FrFZaI
         9fpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MN1cOtvKgI2CDdfH9WOPeSju4XcYLF26UcOgbNUXW2c=;
        b=aoluHeS/J/9rBonEB4MOQtWjrc0N4RqO3r0fsVFd3MQkbFbqX2MqMDAA4+71ZAaxhq
         5gbgRq+zcfx3nU650NyD7lJHnEdbGb6oilAWpoSZesgUzevahjcfln11QtzKuQheoWwe
         HKUc9CzGQvuW7gSHi+43wa7v2yhckeWp+dnqo72Z3bgptQ0z3n4EH4KhhLqQ7SuPiFU9
         imlqb2XhD0s7B63a/mjrgLEToH9ZCPUt7hn3U1otmMlcQyb0s3HbFdhSQ05bNWs/xltM
         GFP9lGtfGwSziYqaQRsq10FEVoSUKN+pMeU5nrhbNmX5v9lkyU7CfsMgpMA06zdWj7+s
         uhHA==
X-Gm-Message-State: AOAM532WuQHKQHBDa0/H8lwo3jo+jZm6mUtC03uZeCjek8Xshc3djQTc
        j1fqOxJET1WWB5wPgb9lANM6nw==
X-Google-Smtp-Source: ABdhPJyaVCpDGMjNxk0GylVrK8GjSSgT7/5cRncjKx7m/vJ9/4yisRCzz7X6NNOfN+7/XuycmImE1Q==
X-Received: by 2002:a17:90a:c201:: with SMTP id e1mr19484028pjt.162.1589797457739;
        Mon, 18 May 2020 03:24:17 -0700 (PDT)
Received: from localhost ([122.167.130.103])
        by smtp.gmail.com with ESMTPSA id y75sm8603768pfb.212.2020.05.18.03.24.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 May 2020 03:24:17 -0700 (PDT)
Date:   Mon, 18 May 2020 15:54:15 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, linux-mips@vger.kernel.org,
        devicetree@vger.kernel.org, stable@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Yue Hu <huyue2@yulong.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 20/20] cpufreq: Return zero on success in boost sw
 setting
Message-ID: <20200518102415.k4c5qglodij5ac6h@vireshk-i7>
References: <20200306124807.3596F80307C2@mail.baikalelectronics.ru>
 <a8dfa493-f858-e35d-7e57-78478be555c4@intel.com>
 <20200518101109.4uggngudy4gfmlvo@vireshk-i7>
 <10461949.HoJUxHt8jL@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10461949.HoJUxHt8jL@kreacher>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-05-20, 12:22, Rafael J. Wysocki wrote:
> On Monday, May 18, 2020 12:11:09 PM CEST Viresh Kumar wrote:
> > On 18-05-20, 11:53, Rafael J. Wysocki wrote:
> > > That said if you really only want it to return 0 on success, you may as well
> > > add a ret = 0; statement (with a comment explaining why it is needed) after
> > > the last break in the loop.
> > 
> > That can be done as well, but will be a bit less efficient as the loop
> > will execute once for each policy, and so the statement will run
> > multiple times. Though it isn't going to add any significant latency
> > in the code.
> 
> Right.
> 
> However, the logic in this entire function looks somewhat less than
> straightforward to me, because it looks like it should return an
> error on the first policy without a frequency table (having a frequency
> table depends on the driver and that is the same for all policies, so it
> is pointless to iterate any further in that case).
> 
> Also, the error should not be -EINVAL, because that means "invalid
> argument" which would be the state value.
> 
> So I would do something like this:
> 
> ---
>  drivers/cpufreq/cpufreq.c |   11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> Index: linux-pm/drivers/cpufreq/cpufreq.c
> ===================================================================
> --- linux-pm.orig/drivers/cpufreq/cpufreq.c
> +++ linux-pm/drivers/cpufreq/cpufreq.c
> @@ -2535,26 +2535,27 @@ EXPORT_SYMBOL_GPL(cpufreq_update_limits)
>  static int cpufreq_boost_set_sw(int state)
>  {
>  	struct cpufreq_policy *policy;
> -	int ret = -EINVAL;
>  
>  	for_each_active_policy(policy) {
> +		int ret;
> +
>  		if (!policy->freq_table)
> -			continue;
> +			return -ENXIO;
>  
>  		ret = cpufreq_frequency_table_cpuinfo(policy,
>  						      policy->freq_table);
>  		if (ret) {
>  			pr_err("%s: Policy frequency update failed\n",
>  			       __func__);
> -			break;
> +			return ret;
>  		}
>  
>  		ret = freq_qos_update_request(policy->max_freq_req, policy->max);
>  		if (ret < 0)
> -			break;
> +			return ret;
>  	}
>  
> -	return ret;
> +	return 0;
>  }
>  
>  int cpufreq_boost_trigger_state(int state)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF2E1F9E55
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jun 2020 19:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731121AbgFORZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jun 2020 13:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730852AbgFORZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 13:25:56 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43BF5C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 10:25:56 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id e9so7861542pgo.9
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 10:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=X5U2nwVApxhHDTMk1l7E/NpbgEKCEjmDjLlaescVVIc=;
        b=lpoPGa06iKLPUWZt1VgDZQ/Nry9Jqo8K5dpidp28rbymaV+taoqY9dLwpPi7jvhOKb
         dXHKTJXdjcJ/7QeOtu8+IbMr487rKz1cNVNe5jddDmCrEdkEWgA7F8LzwTUsKWaD29yu
         n1dIK8rUIyc7A8GCxyjXjZ4VOsw4jliLKU78E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=X5U2nwVApxhHDTMk1l7E/NpbgEKCEjmDjLlaescVVIc=;
        b=EPC+lDjaV/RV4bh45uoJHoOc6b7ekcVWV4IForB/8DKHHW54duzZW3me+bAHto9o2V
         xSl364DQ+b/+MDbm/nMxn1abunkYMgNU0Z8IZV8AJBvLrasIRfXC9C8vZuq8+Kom9UtB
         dlfdWoo8BUHGO+tcgAofKbbcdEIIB4RisrOzBVaAEneGSIYjZ2SPbxa+QrdAv6+5Lm6p
         6G8g7xwX75RTz+0tzDJzyhNzNsKnVgDg/axu3fzX8MX4LijriIYWTzut43ke4q+CqYu6
         g9rFlPzpEDVwiVjrfQYyLeKr/Sy/dGeIeRKgMM5e0k3mXHHK0iEnLMIUFe87sV3x3qpF
         Ucig==
X-Gm-Message-State: AOAM532hLYj9hAMZP3y4wWTXIfCbLd+nA26i2xjheIGI2UaztCYszLZ1
        vOBFJbX2Njb5O9MQRTi/PUD9JA==
X-Google-Smtp-Source: ABdhPJzoAzxB8eO5LX/l+bG/6K/K/eD3XTuKN0PhlI001wuCHJ8FQ0AfRMZNeVIWlCvAUp7las1JrA==
X-Received: by 2002:a63:648:: with SMTP id 69mr22637399pgg.109.1592241955565;
        Mon, 15 Jun 2020 10:25:55 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id p14sm122143pjf.32.2020.06.15.10.25.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2020 10:25:54 -0700 (PDT)
Date:   Mon, 15 Jun 2020 10:25:53 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     viresh.kumar@linaro.org, sboyd@kernel.org,
        georgi.djakov@linaro.org, saravanak@google.com, nm@ti.com,
        bjorn.andersson@linaro.org, agross@kernel.org, rjw@rjwysocki.net,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dianders@chromium.org,
        vincent.guittot@linaro.org, amit.kucheria@linaro.org,
        lukasz.luba@arm.com, sudeep.holla@arm.com, smasetty@codeaurora.org
Subject: Re: [PATCH v6 4/5] cpufreq: qcom: Update the bandwidth levels on
 frequency change
Message-ID: <20200615172553.GU4525@google.com>
References: <20200605213332.609-1-sibis@codeaurora.org>
 <20200605213332.609-5-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200605213332.609-5-sibis@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sibi,

On Sat, Jun 06, 2020 at 03:03:31AM +0530, Sibi Sankar wrote:
> Add support to parse optional OPP table attached to the cpu node when
> the OPP bandwidth values are populated. This allows for scaling of
> DDR/L3 bandwidth levels with frequency change.
> 
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
> 
> v6:
>  * Add global flag to distinguish between voltage update and opp add.
>    Use the same flag before trying to scale ddr/l3 bw [Viresh]
>  * Use dev_pm_opp_find_freq_ceil to grab all opps [Viresh] 
>  * Move dev_pm_opp_of_find_icc_paths into probe [Viresh]
> 
> v5:
>  * Use dev_pm_opp_adjust_voltage instead [Viresh]
>  * Misc cleanup
> 
> v4:
>  * Split fast switch disable into another patch [Lukasz]
> 
>  drivers/cpufreq/qcom-cpufreq-hw.c | 82 ++++++++++++++++++++++++++++++-
>  1 file changed, 80 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> index fc92a8842e252..8fa6ab6e0e4b6 100644
> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> @@ -6,6 +6,7 @@
>  #include <linux/bitfield.h>
>  #include <linux/cpufreq.h>
>  #include <linux/init.h>
> +#include <linux/interconnect.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/of_address.h>
> @@ -30,6 +31,48 @@
>  
>  static unsigned long cpu_hw_rate, xo_rate;
>  static struct platform_device *global_pdev;
> +static bool icc_scaling_enabled;

It seem you rely on 'icc_scaling_enabled' to be initialized to 'false'.
This works during the first initialization, but not if the 'device' is
unbound/rebound. In theory things shouldn't be different in a succesive
initialization, however for robustness the variable should be explicitly
set to 'false' somewhere in the code path (_probe(), _read_lut(), ...).

> +static int qcom_cpufreq_set_bw(struct cpufreq_policy *policy,
> +			       unsigned long freq_khz)
> +{
> +	unsigned long freq_hz = freq_khz * 1000;
> +	struct dev_pm_opp *opp;
> +	struct device *dev;
> +	int ret;
> +
> +	dev = get_cpu_device(policy->cpu);
> +	if (!dev)
> +		return -ENODEV;
> +
> +	opp = dev_pm_opp_find_freq_exact(dev, freq_hz, true);
> +	if (IS_ERR(opp))
> +		return PTR_ERR(opp);
> +
> +	ret = dev_pm_opp_set_bw(dev, opp);
> +	dev_pm_opp_put(opp);
> +	return ret;
> +}
> +
> +static int qcom_cpufreq_update_opp(struct device *cpu_dev,
> +				   unsigned long freq_khz,
> +				   unsigned long volt)
> +{
> +	unsigned long freq_hz = freq_khz * 1000;
> +	int ret;
> +
> +	/* Skip voltage update if the opp table is not available */
> +	if (!icc_scaling_enabled)
> +		return dev_pm_opp_add(cpu_dev, freq_hz, volt);
> +
> +	ret = dev_pm_opp_adjust_voltage(cpu_dev, freq_hz, volt, volt, volt);
> +	if (ret) {
> +		dev_err(cpu_dev, "Voltage update failed freq=%ld\n", freq_khz);
> +		return ret;
> +	}
> +
> +	return dev_pm_opp_enable(cpu_dev, freq_hz);
> +}
>  
>  static int qcom_cpufreq_hw_target_index(struct cpufreq_policy *policy,
>  					unsigned int index)
> @@ -39,6 +82,9 @@ static int qcom_cpufreq_hw_target_index(struct cpufreq_policy *policy,
>  
>  	writel_relaxed(index, perf_state_reg);
>  
> +	if (icc_scaling_enabled)
> +		qcom_cpufreq_set_bw(policy, freq);
> +
>  	arch_set_freq_scale(policy->related_cpus, freq,
>  			    policy->cpuinfo.max_freq);
>  	return 0;
> @@ -89,11 +135,31 @@ static int qcom_cpufreq_hw_read_lut(struct device *cpu_dev,
>  	u32 data, src, lval, i, core_count, prev_freq = 0, freq;
>  	u32 volt;
>  	struct cpufreq_frequency_table	*table;
> +	struct dev_pm_opp *opp;
> +	unsigned long rate;
> +	int ret;
>  
>  	table = kcalloc(LUT_MAX_ENTRIES + 1, sizeof(*table), GFP_KERNEL);
>  	if (!table)
>  		return -ENOMEM;
>  
> +	ret = dev_pm_opp_of_add_table(cpu_dev);
> +	if (!ret) {
> +		/* Disable all opps and cross-validate against LUT */

nit: IIUC the cross-validation doesn't happen in this branch, so the
comment is a bit misleading. Maybe change it to "Disable all opps to
cross-validate against the LUT {below,later}".

> +		icc_scaling_enabled = true;
> +		for (rate = 0; ; rate++) {
> +			opp = dev_pm_opp_find_freq_ceil(cpu_dev, &rate);
> +			if (IS_ERR(opp))
> +				break;
> +
> +			dev_pm_opp_put(opp);
> +			dev_pm_opp_disable(cpu_dev, rate);
> +		}
> +	} else if (ret != -ENODEV) {
> +		dev_err(cpu_dev, "Invalid opp table in device tree\n");
> +		return ret;
> +	}
> +
>  	for (i = 0; i < LUT_MAX_ENTRIES; i++) {
>  		data = readl_relaxed(base + REG_FREQ_LUT +
>  				      i * LUT_ROW_SIZE);
> @@ -112,7 +178,7 @@ static int qcom_cpufreq_hw_read_lut(struct device *cpu_dev,
>  
>  		if (freq != prev_freq && core_count != LUT_TURBO_IND) {
>  			table[i].frequency = freq;
> -			dev_pm_opp_add(cpu_dev, freq * 1000, volt);
> +			qcom_cpufreq_update_opp(cpu_dev, freq, volt);

This is the cross-validation mentioned above, right? Shouldn't it include
a check of the return value?

>  			dev_dbg(cpu_dev, "index=%d freq=%d, core_count %d\n", i,
>  				freq, core_count);
>  		} else if (core_count == LUT_TURBO_IND) {
> @@ -133,7 +199,8 @@ static int qcom_cpufreq_hw_read_lut(struct device *cpu_dev,
>  			if (prev->frequency == CPUFREQ_ENTRY_INVALID) {
>  				prev->frequency = prev_freq;
>  				prev->flags = CPUFREQ_BOOST_FREQ;
> -				dev_pm_opp_add(cpu_dev,	prev_freq * 1000, volt);
> +				qcom_cpufreq_update_opp(cpu_dev, prev_freq,
> +							volt);

ditto

nit: with the updated max line length it isn't necessary anymore to break
this into multiple lines (https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/scripts/checkpatch.pl?h=v5.8-rc1#n54),
though the coding style still has the old limit.

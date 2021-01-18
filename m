Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 329CC2F9B24
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 09:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387767AbhARIVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 03:21:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387536AbhARIU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 03:20:56 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D903C061573
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 00:20:16 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id t29so4637670pfg.11
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 00:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dsBrzAiHn/QqryQ1yrFMR23Xt9wevpoQ3xsv50VodOw=;
        b=pXraTakKGaWCltyhTSmcgtT+BADsn0u85spUUygpv9366XMpechk3LWV5NWxlOgP9p
         te3WIXjJflC0y4B5fONLnx62ixn//P/uz0ANB7sjqj9VsZ1y0grYViulzjHEL13BeFBz
         FPZNsN5G4KvjBcMcAKPBGcCkNIX4cxNzHi/ztEehFeyt3R4TFkZN9VlzDnoLaOVgeeR9
         nm9djeWNyGvlxmTLGZFI6teMtPgNXNdg1nuc5OcySkh92GplWAfxe73U+jPUuw5bQ8P5
         elu+CvBPCMFc0Okeq1tbJPBy3LQg0tBv6ZxyboK4d0Orexvh4B61y3Gig+FTndtG1AO/
         dLow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dsBrzAiHn/QqryQ1yrFMR23Xt9wevpoQ3xsv50VodOw=;
        b=ZMMk60Dm3OelwXCZNJnYWI0eYXtJKWhrr+uQMoLrwAyCAsA/u+vHEjdN1aK5j44Oq8
         vo6kffRU1/lf+a/4tHDhC8SuP+Av2rxsVsM3rxAzvyPEKVUk2xIBRZjreZ3OafaMvcgZ
         lAOYGVXHv8GyPRJpWENgeCjHcx3nwQt1fBlW1NodWz4lTbopXuRkvDxTYj0x6XnOHbiP
         Uu/EkTQoomr9XG4RsDf5dP3uSHFLpuGP2YXLGTp7eybCXufNiA2G9Oorukm3RUKZqsGk
         jreGWi/bApUKuE5yjbEfu3u/ZqzvrtqDtYrZoMDdX6tvdvzdoLaifHoZfnnDOw11So3b
         ZmBQ==
X-Gm-Message-State: AOAM533+Lt5jnK8l5OB95mgn4R3fH0HwXOVY6NViR4rY5JlX3JWrkdmu
        XzHU5KLzDGgmOmZo90h6U2WRBQ==
X-Google-Smtp-Source: ABdhPJxLQmWRXH5EaNL+jpl63GF0SKDZkSgigNJXKSCuVDXdkRAYwYzXTcfvmbHPqhxTSBOfw3cTsw==
X-Received: by 2002:a62:97:0:b029:1ab:93bf:43a1 with SMTP id 145-20020a6200970000b02901ab93bf43a1mr24989223pfa.75.1610958016148;
        Mon, 18 Jan 2021 00:20:16 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id j17sm14631894pfh.183.2021.01.18.00.20.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jan 2021 00:20:15 -0800 (PST)
Date:   Mon, 18 Jan 2021 13:50:13 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Matt Merhar <mattmerhar@protonmail.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 04/12] opp: Add dev_pm_opp_sync_regulators()
Message-ID: <20210118082013.32y5tndlbw4xrdgc@vireshk-i7>
References: <20210118005524.27787-1-digetx@gmail.com>
 <20210118005524.27787-5-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210118005524.27787-5-digetx@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-01-21, 03:55, Dmitry Osipenko wrote:
> Extend OPP API with dev_pm_opp_sync_regulators() function, which syncs
> voltage state of regulators.
> 
> Tested-by: Peter Geis <pgwipeout@gmail.com>
> Tested-by: Nicolas Chauvet <kwizart@gmail.com>
> Tested-by: Matt Merhar <mattmerhar@protonmail.com>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/opp/core.c     | 45 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/pm_opp.h |  6 ++++++
>  2 files changed, 51 insertions(+)
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 7b4d07279638..99d18befc209 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -2686,3 +2686,48 @@ void dev_pm_opp_remove_table(struct device *dev)
>  	dev_pm_opp_put_opp_table(opp_table);
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_opp_remove_table);
> +
> +/**
> + * dev_pm_opp_sync_regulators() - Sync state of voltage regulators
> + * @dev:	device for which we do this operation
> + *
> + * Sync voltage state of the OPP table regulators.
> + *
> + * Return: 0 on success or a negative error value.
> + */
> +int dev_pm_opp_sync_regulators(struct device *dev)
> +{
> +	struct opp_table *opp_table;
> +	struct regulator *reg;
> +	int i, ret = 0;
> +
> +	/* Device may not have OPP table */
> +	opp_table = _find_opp_table(dev);
> +	if (IS_ERR(opp_table))
> +		return 0;
> +
> +	/* Regulator may not be required for the device */
> +	if (!opp_table->regulators)
> +		goto put_table;
> +
> +	mutex_lock(&opp_table->lock);

What exactly do you need this lock for ?

> +
> +	/* Nothing to sync if voltage wasn't changed */
> +	if (!opp_table->enabled)
> +		goto unlock;
> +
> +	for (i = 0; i < opp_table->regulator_count; i++) {
> +		reg = opp_table->regulators[i];
> +		ret = regulator_sync_voltage(reg);
> +		if (ret)
> +			break;
> +	}
> +unlock:
> +	mutex_unlock(&opp_table->lock);
> +put_table:
> +	/* Drop reference taken by _find_opp_table() */
> +	dev_pm_opp_put_opp_table(opp_table);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(dev_pm_opp_sync_regulators);
> diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
> index c24bd34339d7..1c3a09cc8dcd 100644
> --- a/include/linux/pm_opp.h
> +++ b/include/linux/pm_opp.h
> @@ -162,6 +162,7 @@ int dev_pm_opp_set_sharing_cpus(struct device *cpu_dev, const struct cpumask *cp
>  int dev_pm_opp_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask);
>  void dev_pm_opp_remove_table(struct device *dev);
>  void dev_pm_opp_cpumask_remove_table(const struct cpumask *cpumask);
> +int dev_pm_opp_sync_regulators(struct device *dev);
>  #else
>  static inline struct opp_table *dev_pm_opp_get_opp_table(struct device *dev)
>  {
> @@ -398,6 +399,11 @@ static inline void dev_pm_opp_cpumask_remove_table(const struct cpumask *cpumask
>  {
>  }
>  
> +static inline int dev_pm_opp_sync_regulators(struct device *dev)
> +{
> +	return -ENOTSUPP;
> +}
> +
>  #endif		/* CONFIG_PM_OPP */
>  
>  #if defined(CONFIG_PM_OPP) && defined(CONFIG_OF)
> -- 
> 2.29.2

-- 
viresh

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8A451FA7C4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jun 2020 06:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbgFPEbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jun 2020 00:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbgFPEbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 00:31:47 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0681BC05BD1E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 21:31:46 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id u128so1760435pgu.13
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 21:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yggJLQ1EcUgjHF19yDwrup+mzwUkwfoI6w/Q8w2BPpk=;
        b=EfhXBKtMMpywDdVRa97crf16rSBhJmC9upTtrKRxHjbYQ6vb5dFVW0F6JjwosFOWkY
         6EoRWcAzi6fqfgfosquSl77qy0o7OrBZp1CfljklHXisVRNBXDuNSOnz/qDKBJo4sZAI
         AIJubRaqdZkaJ+BNb46H0OzDMUg4+GeXDIRApMrupAA3f32FYfGS7R5cYoPcXV+kqxrB
         7YtCX7uuyUPpo6iXPtNvbTdQjxNf3K5GZ1W3AmIokh4hfydqgAcyUJnVMyQT5D+lm4lK
         Tanbbi3aIPnGPUGzU2ni0I1dVsAlTlFmVRtE60MvAMuE3YVDSJvaYN5jCxXiotiU5gBD
         ZVhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yggJLQ1EcUgjHF19yDwrup+mzwUkwfoI6w/Q8w2BPpk=;
        b=qlpwwt5rKzF/hgGRQvtUYuAF4CtLpkhgEU/oBETmKeoHvpB1o/JwkdhceQT+WRCRZc
         9Dw1CYb7E3sW5odObTJ3ekQ02yPfvz7NlfOlWMZToUy/gBTvTXWmZ3JBf3kBdVaPlzh7
         GNG4a569qjpOLv8b2QySO36RyzrjBUlrBYCyCyTqXdgGhxX1BkgMZF794pkDliraSBw+
         pw5iiPmQ6V2L/eNqCIVji4GVc3bccboJLO+8ezVEYZTlO2O10WdMit5KxweXksiHNKIA
         QmUe/brc4tI3k1XpBrKuW9y3YwAGXELboiVTHOBN5KdmXSB9W9RWke03yEs7V6Li211r
         /XXA==
X-Gm-Message-State: AOAM530sFMk+98aw2GeDsHejVc0/a4SKsYVV7AMTXjKb9CxTL7iXPXuo
        zeFclLnOWZm2fEl/VgVNnSIqTg==
X-Google-Smtp-Source: ABdhPJydDW3Q5YoUvXjbkK975S5wvd5Z8OCpB+59uxLDjteoZCSrgET+C2HheXpQubqW97fxpEilUw==
X-Received: by 2002:a63:7c5e:: with SMTP id l30mr697662pgn.276.1592281906422;
        Mon, 15 Jun 2020 21:31:46 -0700 (PDT)
Received: from localhost ([122.172.119.132])
        by smtp.gmail.com with ESMTPSA id h35sm937737pje.29.2020.06.15.21.31.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jun 2020 21:31:45 -0700 (PDT)
Date:   Tue, 16 Jun 2020 10:01:43 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Quentin Perret <qperret@google.com>
Cc:     rjw@rjwysocki.net, rafael@kernel.org, arnd@arndb.de,
        mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        kernel-team@android.com, tkjos@google.com, adharmap@codeaurora.org
Subject: Re: [PATCH 2/2] cpufreq: Specify default governor on command line
Message-ID: <20200616043143.obk5k3rv737j5dnd@vireshk-i7>
References: <20200615165554.228063-1-qperret@google.com>
 <20200615165554.228063-3-qperret@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200615165554.228063-3-qperret@google.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15-06-20, 17:55, Quentin Perret wrote:
> +static void cpufreq_get_default_governor(void)
> +{
> +	default_governor = cpufreq_parse_governor(cpufreq_param_governor);
> +	if (!default_governor) {
> +		if (*cpufreq_param_governor)
> +			pr_warn("Failed to find %s\n", cpufreq_param_governor);
> +		default_governor = cpufreq_default_governor();

A module_get() never happened for this case and so maybe a
module_put() should never get called.

> +	}
> +}
> +
> +static void cpufreq_put_default_governor(void)
> +{
> +	if (!default_governor)
> +		return;
> +	module_put(default_governor->owner);
> +	default_governor = NULL;
> +}
> +
>  static int cpufreq_init_governor(struct cpufreq_policy *policy)
>  {
>  	int ret;
> @@ -2701,6 +2721,8 @@ int cpufreq_register_driver(struct cpufreq_driver *driver_data)
>  
>  	if (driver_data->setpolicy)
>  		driver_data->flags |= CPUFREQ_CONST_LOOPS;
> +	else
> +		cpufreq_get_default_governor();
>  
>  	if (cpufreq_boost_supported()) {
>  		ret = create_boost_sysfs_file();
> @@ -2769,6 +2791,7 @@ int cpufreq_unregister_driver(struct cpufreq_driver *driver)
>  	subsys_interface_unregister(&cpufreq_interface);
>  	remove_boost_sysfs_file();
>  	cpuhp_remove_state_nocalls_cpuslocked(hp_online);
> +	cpufreq_put_default_governor();
>  
>  	write_lock_irqsave(&cpufreq_driver_lock, flags);
>  
> @@ -2792,4 +2815,5 @@ static int __init cpufreq_core_init(void)
>  	return 0;
>  }

And since this is a per boot thing, there is perhaps no need of doing
these at driver register/unregister, I would rather do it at:
cpufreq_core_init() time itself and so we will never need to run
cpufreq_put_default_governor() and so can be removed.

And another thing I am not able to understand (despite you commenting
about that in the commit log) is what happens if the default governor
chosen is built as a module ?

-- 
viresh

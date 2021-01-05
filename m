Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 616CE2EA427
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 04:55:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbhAEDyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 22:54:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728137AbhAEDyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 22:54:50 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC97DC061794
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jan 2021 19:54:09 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id j13so915656pjz.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jan 2021 19:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Z2EgidPs9i3+WSoRNwFT2rOqPzzdIfF25VjEgaOjsvQ=;
        b=YpCabG+Kz0rCRQLVEZEpC6mLNAG2DUk00mYxciiTaaAHfs85cuRI824ILTKlOCr9Kt
         dhOcA7TwmWN9RVT9OABvfp+v0xfCjxDHgdRe01Weymi+x+Llwj8kGuOenyseni5XDdJf
         sOsAw/JG3dWCXds4s2EzJCjtHeY9kSjXNoV0NNGoZM9YlSOQQCmDjpP+LD68BHSVMKpM
         ufKYaYLDWGajxHLC0gz35/dHNDLxIci701CZeSnxJ8EJX+9hI2gkTRDRoIGWovEuZrDT
         5K8cD0+PxvPv5eXw6pxj07WewLVmtt52jFNa//yEfIb7pVDKgi4dWKNgz2pOPK5oqwiX
         33Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Z2EgidPs9i3+WSoRNwFT2rOqPzzdIfF25VjEgaOjsvQ=;
        b=dljQsy/lzFzqwvapG2zqkaJ2MQJScBq0S4tk/g8AIxV4kPs1WeOyDa080s+hS0ioVl
         00sRgM5bYF56329LKHkUw5JE1X/pEiIiY55OLmvauVJ9M3ZVAJSRNS+WH8Nny/ieLvH2
         btLUBSFQDkcEa84Lq2cC4zwibPnFc/llRa5HyhUMUj6l7f2+vnKmuYc3sZiTo4PJNNgK
         vYtOnTHxkXKZwE7JmQk1duWJ+xn0APDK37yBo6i0Dlt7QXkyvfKlhJLmStIcT5nBWWFB
         tvWPnri/JKkKFW0PGeQwu2oo8YoPGfg/hCNBsnkMIKEpz1dEAutDzKV3e1UUFAume6ns
         xJJg==
X-Gm-Message-State: AOAM531pMRpjXt+18UvQZ5oSWImk1IFgiMgYqsLvS8hftF8Z5pdK7DWS
        qb6CybV+rCcSBFodQwsi9MgaZA==
X-Google-Smtp-Source: ABdhPJzurKr5qukIuZHHQ/C/W6YFRUFFgmzlEbEzjxdF2NW7GI7DyRqdAAstPJXZjo3s1JdslvN/Fw==
X-Received: by 2002:a17:90b:46d2:: with SMTP id jx18mr2165415pjb.106.1609818849340;
        Mon, 04 Jan 2021 19:54:09 -0800 (PST)
Received: from localhost ([122.172.20.109])
        by smtp.gmail.com with ESMTPSA id u12sm56134276pfh.98.2021.01.04.19.54.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Jan 2021 19:54:08 -0800 (PST)
Date:   Tue, 5 Jan 2021 09:24:04 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Colin King <colin.king@canonical.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Stephen Warren <swarren@nvidia.com>, linux-pm@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] cpufreq: powernow-k8: add null check to policy to
 avoid null pointer dereference
Message-ID: <20210105035404.c47atgdsiqoa2wuc@vireshk-i7>
References: <20210104130227.35354-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210104130227.35354-1-colin.king@canonical.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-01-21, 13:02, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently there is an unlikely case where cpufreq_cpu_get returns a
> null policy and this will cause a null pointer dereference later on.
> Fix this by adding a null check and adding an error return.
> 
> Addresses-Coverity: ("Dereference null return")
> Fixes: b43a7ffbf33b ("cpufreq: Notify all policy->cpus in cpufreq_notify_transition()")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/cpufreq/powernow-k8.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/cpufreq/powernow-k8.c b/drivers/cpufreq/powernow-k8.c
> index 0acc9e241cd7..c5368545ba1f 100644
> --- a/drivers/cpufreq/powernow-k8.c
> +++ b/drivers/cpufreq/powernow-k8.c
> @@ -913,6 +913,8 @@ static int transition_frequency_fidvid(struct powernow_k8_data *data,

The caller already has a pointer to the policy, you should rather pass
that here instead of doing cpufreq_cpu_get/put.

>  	freqs.new = find_khz_freq_from_fid(fid);
>  
>  	policy = cpufreq_cpu_get(smp_processor_id());
> +	if (!policy)
> +		return 1;
>  	cpufreq_cpu_put(policy);
>  
>  	cpufreq_freq_transition_begin(policy, &freqs);
> -- 
> 2.29.2

-- 
viresh

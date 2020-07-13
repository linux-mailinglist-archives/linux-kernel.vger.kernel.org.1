Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA01821CDB4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jul 2020 05:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728617AbgGMD2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jul 2020 23:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726684AbgGMD2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 23:28:07 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E11FBC08C5DB
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 20:28:06 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id f16so5545787pjt.0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 20:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CTRBBv9blTaUsrYeb0eeu5TKswQZvXFg2/jonGMy2rU=;
        b=rP9X1uOXiqLwidmJBZxTFvX5cQiI++9UHNsUbK7PYnSdO9zCGjE7R7rLZJS+VyM0iC
         5ZewOS37vO8J+gE4x6Fd5o08WlGg/KSSScSrm6jdllMjnLFMDTvc8Di5d5a+Jth0DrTJ
         8zRet+UlU7MW0qQF79Psuxt7FIoJ2jW3gf5c1VsPZmEjKEE4CR38/2Eip5HoqU1inzmL
         xuWuQcwm/rRxibkpwV8jRNHG7EvPiHM6clPK2v8qd+tx+0TPTUpGYDjsKg8/ZczV3r96
         glom65IBjbPdc+gN6GWIfeBEucxUcyJYcCctOIKQ/VG+BmgTieQZkCsq7sf53CI1RqYN
         UB6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CTRBBv9blTaUsrYeb0eeu5TKswQZvXFg2/jonGMy2rU=;
        b=dFomispr4YwLQIdkiDkgdZoIpjUexKkyuvpcslw26QtdPLXJR5WcOiOk1NPKcn6wjv
         WuTOpZrZz9eySQoQAhyoOAPyVDQnNIOb9eWTncuYelCdFJoBcXfGSk7RglROugOZLR1U
         LW4K5OOK8AuvkeyUGDKT5kTeqVUUBGMhnTVJEJfArczUrA+yKPu8yYA/0iWR6XTu+HxM
         sVwzFLgCOIZ829qfYbjdqgapNZ+iYpxdkvQAka8PwsEJuilohwZ9mhKSi/BN6t53+Gpr
         lBBGO7QllDElbnvu5rHCL3UyQBIPe90CmI1lSUX5Yp1STiWUeIORqZpggZujFQ26hOdP
         PbOA==
X-Gm-Message-State: AOAM530L0XrMKv4IZqzsLWk5YUwW43tmt/S8Gy0XFfOyDNwxQYrI4m0a
        WnO8jGv5ysbb2sPoXvOYJBPhLQ==
X-Google-Smtp-Source: ABdhPJyM9mzXA2I+RbttNKXr3SC2AFKXo95OQNQ40YPbj1juxkhiADn/VmgtLqUtjhcydj2jv9T5Mg==
X-Received: by 2002:a17:90a:c70e:: with SMTP id o14mr19352504pjt.70.1594610885294;
        Sun, 12 Jul 2020 20:28:05 -0700 (PDT)
Received: from localhost ([122.172.34.142])
        by smtp.gmail.com with ESMTPSA id j2sm32266589pjy.1.2020.07.12.20.28.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Jul 2020 20:28:04 -0700 (PDT)
Date:   Mon, 13 Jul 2020 08:58:02 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] cpufreq: tegra186: Simplify probe return path
Message-ID: <20200713032802.u4ubftfgwtixkaj3@vireshk-i7>
References: <20200712100645.13927-1-jonathanh@nvidia.com>
 <20200712100645.13927-2-jonathanh@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200712100645.13927-2-jonathanh@nvidia.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12-07-20, 11:06, Jon Hunter wrote:
> We always put the reference to BPMP device on exit of the Tegra186
> CPUFREQ driver and so there is no need to have separate exit paths
> for success and failure. Therefore, simplify the probe return path
> in the Tegra186 CPUFREQ driver by combining the success and failure
> paths.
> 
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>  drivers/cpufreq/tegra186-cpufreq.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/cpufreq/tegra186-cpufreq.c b/drivers/cpufreq/tegra186-cpufreq.c
> index c44190ce3f03..bf8cab357277 100644
> --- a/drivers/cpufreq/tegra186-cpufreq.c
> +++ b/drivers/cpufreq/tegra186-cpufreq.c
> @@ -231,15 +231,9 @@ static int tegra186_cpufreq_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> -	tegra_bpmp_put(bpmp);
> -
>  	tegra186_cpufreq_driver.driver_data = data;
>  
>  	err = cpufreq_register_driver(&tegra186_cpufreq_driver);
> -	if (err)
> -		return err;
> -
> -	return 0;
>  
>  put_bpmp:
>  	tegra_bpmp_put(bpmp);

Applied. Thanks.

-- 
viresh

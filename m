Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 568E72FCA04
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 05:33:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728433AbhATEdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 23:33:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727787AbhATEc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 23:32:58 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84400C0613C1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 20:32:18 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id m6so13743407pfk.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 20:32:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jtrfxvYoDEq3RZCyVGjLYtU5e+mF9oTQsRcyWM47vks=;
        b=Qi7IYVi+JQEiMs6lekW5M0ChYs+HdEmLIcV8nmfIq0ufPG4j5BYZMxff78LGzyTVvI
         Dtkwsndwy4DSomsmW8+E4WUmr+KN5vq8yxEUWqomHpNkE0RI5oBE15EoK2JCvXLOZdVj
         3Ey3cC3y1mYZSqLJ6ucdtqUUSZAeeZTCcl9zgLulc7SKBXrfDQd9GhnGtS9O033VVIb5
         huc1gp07WTTdQFLwvPOaxIi9m9cx3K+4WQn/DIpWBz4SNMiqUw8IPw/rXuyaLGfkIE75
         BjeUoZW03NC748AFJN/rkuZY8qX2KOUs1ORWaEzhwkoAZxsSuVEkN4TMSU03S3bHDpZU
         kKIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jtrfxvYoDEq3RZCyVGjLYtU5e+mF9oTQsRcyWM47vks=;
        b=KrgBecHhP3Ziz+Rq5i+lNtsO/wR5hCp52u5oonAqkjwLoR4ACnX3KCzlCbsWMJg2EB
         GzbaGjuQu6e8flD8xCM+jmcyuRhifVLdFAv1Hndpaxzj6+wAleeIwJY4d9Z9BXfu2a8n
         qkIF8lRGW++CmJABjxpZpLANKgkgpMhp7sMcKe0wlN3mq/nJ9HSh+HQsLRi5wb4BeI0y
         2M3IQhfcHuHPzuKwsze4MTOvyX0G1TXjuVoM260yuoaWII/BMeRZwJ5vZcai9rKgOYse
         7fdA+Y84tj5S91jaCr62P8UJDGjtkMIfybWUywEJYm9BMgG1Xrv36a10aF1EkCG3WHX4
         ICjQ==
X-Gm-Message-State: AOAM533IKvIi9Zts4Cpsnm+r9/XfSbRx4zA5tUxNGRi8JyUX7H27dNe8
        mM3M0kVCvoJwnOc6s2x5PGRUJg==
X-Google-Smtp-Source: ABdhPJwBADlP3zfaNDQ2lytPl+ztqBiN4oMl0NB+9YvvugtaEhsGTWHp/yJftqCzbgIcaG9HT+uSKQ==
X-Received: by 2002:a63:1261:: with SMTP id 33mr7577909pgs.213.1611117137877;
        Tue, 19 Jan 2021 20:32:17 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id 21sm617075pfx.84.2021.01.19.20.32.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jan 2021 20:32:16 -0800 (PST)
Date:   Wed, 20 Jan 2021 10:02:11 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Yangtao Li <tiny.windzz@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] cpufreq: tegra20: Use resource-managed API
Message-ID: <20210120043211.qakitv5yyr4lun37@vireshk-i7>
References: <20210117231825.28256-1-digetx@gmail.com>
 <20210118063910.on4vgbllfmsduezo@vireshk-i7>
 <09f93579-9de0-d541-1331-e2b45518c270@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09f93579-9de0-d541-1331-e2b45518c270@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-01-21, 18:01, Dmitry Osipenko wrote:
> The regular devm_opp_* helpers won't be usable for CPUFreq drivers because OPP is applied to the CPU device and not the device of the CPUFreq driver.

Ahh, I missed that.

> But maybe we could support such cases by the helpers?
> 
> I CC'd Yangtao Li.
> 
> For example we could do this:
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index ca8c6acc29f4..e2eb0f9cf46c 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -1771,7 +1771,8 @@ static void devm_pm_opp_supported_hw_release(void *data)
>  
>  /**
>   * devm_pm_opp_set_supported_hw() - Set supported platforms
> - * @dev: Device for which supported-hw has to be set.
> + * @dev: Device which manages allocated resources.
> + * @opp_dev: Device for which supported-hw has to be set.
>   * @versions: Array of hierarchy of versions to match.
>   * @count: Number of elements in the array.
>   *
> @@ -1783,13 +1784,14 @@ static void devm_pm_opp_supported_hw_release(void *data)
>   * The opp_table structure will be freed after the device is destroyed.
>   */
>  struct opp_table *devm_pm_opp_set_supported_hw(struct device *dev,
> +					       struct device *opp_dev,
>  					       const u32 *versions,
>  					       unsigned int count)
>  {
>  	struct opp_table *opp_table;
>  	int err;
>  
> -	opp_table = dev_pm_opp_set_supported_hw(dev, versions, count);
> +	opp_table = dev_pm_opp_set_supported_hw(opp_dev, versions, count);
>  	if (IS_ERR(opp_table))
>  		return opp_table;

No please :)

-- 
viresh

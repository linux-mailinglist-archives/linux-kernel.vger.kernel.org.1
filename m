Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56B002EB36F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 20:21:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730569AbhAETUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 14:20:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbhAETUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 14:20:48 -0500
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C91C061795
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 11:20:07 -0800 (PST)
Received: by mail-oo1-xc2c.google.com with SMTP id j21so195464oou.11
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 11:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pApZtT3kUoc3iG8fxyNumTsrhIoA70XGH4vOpczgKSg=;
        b=GFG4+jX20prcNuncQrsCbCXaDE1/+gSTKbaKjfYpz+g0RCZIbl4pXANTxdKUdUTmHS
         lYnsCEF966ZB+WYWeLXJI5CTuI4zriBu1UQ4Xc02Zuuo6RUFjeJzXQazknR4gKhGe+fC
         3pPWITGRrA3Ktne+C44Q7JHlkdxng69Cw67wRXX3/ejaBneJgkyykaqaprrnUm7Tr54m
         0X3tzTP4wrhtMOt1hZFzo7MKIenhTCcdq+DUtEoXASuzsXgY4zHSi92BJ8HQdUhhbhjg
         chjSOgT7DKZBh+45Ve9DBTxsBmtYtM4IB7XZHzo3IM+dMAOuw43CyXk1+hD5ezrL2lpu
         dZ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pApZtT3kUoc3iG8fxyNumTsrhIoA70XGH4vOpczgKSg=;
        b=cYGXTug5ThQtgEe3V0I55u6LXqAlLI/m3fGaePi01Bg268c/vJVCPZrqwQ18A5aPhE
         JbeyVcqRsaIZsquXZH5iwF/JFBE7nyRMcH6rvCRFJ34k/nflThLSQu+eobjXCTKa71O7
         pbwZEGVW5qzr9dDhi4b+ROFl8rnKPg5wEx8UTzXlz1ntgkNKBjFOa7w937r/XtXlQfyC
         Ze+DP12Zhz6p2fQ00AWP3RB1RjELiaz2CkpiYLVWAd0NlXJ0tfeUBBAIORZ3zpJSS6AV
         +3StM9K8qzqktcQ4JeGxHalZvsZwKBGGBdugWRPS8VeU9xfAqxsOsQKwPyu/EjUb2+QH
         6EXw==
X-Gm-Message-State: AOAM532ABJquoyFr/j31sN7yufeamqbFEmkiqJISDMafpjPWkvv7woaE
        /pYcXIKgQxUoyStXkKGKg9hCFg==
X-Google-Smtp-Source: ABdhPJzXak7VMpj8lBTjdyUrKLPtv3rchrkXI4TeIrAZmIGtz8rHTtTrm8rWH9LxaRbq0cAhEmVtRA==
X-Received: by 2002:a05:6820:441:: with SMTP id p1mr408451oou.21.1609874406662;
        Tue, 05 Jan 2021 11:20:06 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id g21sm23083otj.77.2021.01.05.11.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 11:20:05 -0800 (PST)
Date:   Tue, 5 Jan 2021 13:20:04 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Md Sadre Alam <mdalam@codeaurora.org>
Cc:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, sricharan@codeaurora.org
Subject: Re: [PATCH] mmc: sdhci-msm: Fix possible NULL pointer exception
Message-ID: <X/S75LlfnMWw+seh@builder.lan>
References: <1608626913-16675-1-git-send-email-mdalam@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1608626913-16675-1-git-send-email-mdalam@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 22 Dec 02:48 CST 2020, Md Sadre Alam wrote:

> of_device_get_match_data returns NULL when no match.
> So add the NULL pointer check to avoid dereference.
> 
> Signed-off-by: Md Sadre Alam <mdalam@codeaurora.org>
> ---
>  drivers/mmc/host/sdhci-msm.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index 9c7927b..f20e424 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -2235,6 +2235,8 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>  	 * the data associated with the version info.
>  	 */
>  	var_info = of_device_get_match_data(&pdev->dev);
> +	if (!var_info)

To get this you (the SDHCI driver developer) needs to add an entry in
sdhci_msm_dt_match[] without a .data specified.

> +		goto pltfm_free;

And this will cause sdhci_msm_probe() to return 0, giving no hint to
said developer that they screwed up. Given that this can only be caused
by a developer working on this driver you should provide feedback
suitable for such developer, e.g. by:

	if (WARN_ON(!var_info))
		return -EINVAL;

But given that this is only for the developer himself, I don't see that
this adds any value over just reading the callstack you get from the
panic when the next line dereferences var_info (NULL).

Regards,
Bjorn

>  
>  	msm_host->mci_removed = var_info->mci_removed;
>  	msm_host->restore_dll_config = var_info->restore_dll_config;
> -- 
> 2.7.4
> 

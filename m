Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35EFD2C9278
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 00:24:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388358AbgK3XYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 18:24:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730551AbgK3XYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 18:24:10 -0500
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD85C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 15:23:24 -0800 (PST)
Received: by mail-oi1-x241.google.com with SMTP id w15so16109977oie.13
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 15:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rfUvf+rulCtui//LVYbddkRCxkkehBqPZfURfP/eFrU=;
        b=PLlgDqjlIOXdd/Vh6ZyHIldiZt4b9P6ZhswLdwihql1BqN7yFeP1lNtxsAVT1rs6bL
         dPkQYsA2Is4Bz2IgCmjfIEu8Mq4MKHBjZXyiqaUng2qWixeMPRFCVYqdarz9g1iERotE
         2L4uLbzKUilmsVLLHLS3XzQTjFOQ/y+VyWXZ3cVBJ0e1zUxDxdyeTXl31KAfnWcNfy1K
         5MAKiaq4WryagQ722zzEIN6FuYOF8gYFjIWv6iyRN67OZanAAyNt1I/UOaS6dFwKiGIj
         sShpOM7uj0txKhHPyJNMbjDU3uE5Wwf8f8OAm+fZBKWQRMA5tPJwhTpTwyUhgPeLNaiL
         LL7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rfUvf+rulCtui//LVYbddkRCxkkehBqPZfURfP/eFrU=;
        b=TtUMiIkjaaZdYVTuHCAvKMjMdwbv2E69ETJ+6mwwY+f3SJzYvajAgIKpWQB2UTi/6d
         QgnWBwTVj6VooCfvN8+2HEZ9UTrwnehTTAyp0LJWHGtalYyq7LFn02hym+jYAWujMXp+
         UHJj/rRZ/46tSniF5whNwn5PvZVxGDfd0KMe94Ea96xjmjnmTfIVQZ53LByOqy+tev+j
         O0YQs1ygosj8m0u76WZMbRf/B1okaD/euftH/MDZeD4LX0OWr0Mc9ZAwhlXtEczbWp5T
         bh9+bwW+NMe+seSj95FvPPu2eZ+G1Ln+w6woyqFt1Ia1fhixHjyp0j9bX3pc4/5mxVnw
         UHNQ==
X-Gm-Message-State: AOAM533zmmO81OaNohTKbypPVfyEaq7S82NAYpGOVf/KgJG6je82xnat
        38Tn+F+CBI9q9ZqmWJJY3rTtNQ==
X-Google-Smtp-Source: ABdhPJzGX1RWNM92e0MhKFBt9MTPM9po/BVR8gIfY+k+Xx/iYnr1iktm9hSHta+ZFKAF398T7h6JLA==
X-Received: by 2002:a05:6808:b38:: with SMTP id t24mr114114oij.153.1606778604124;
        Mon, 30 Nov 2020 15:23:24 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id 19sm9422012oth.63.2020.11.30.15.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 15:23:16 -0800 (PST)
Date:   Mon, 30 Nov 2020 17:23:15 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Robert Marko <robert.marko@sartura.hr>
Cc:     agross@kernel.org, wim@linux-watchdog.org, linux@roeck-us.net,
        linux-arm-msm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luka Perkov <luka.perkov@sartura.hr>
Subject: Re: [PATCH v4] watchdog: qcom_wdt: set WDOG_HW_RUNNING bit when
 appropriate
Message-ID: <X8V+442lvcTpNmth@builder.lan>
References: <20201031121115.542752-1-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201031121115.542752-1-robert.marko@sartura.hr>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 31 Oct 07:11 CDT 2020, Robert Marko wrote:

> If the watchdog hardware is enabled/running during boot, e.g.
> due to a boot loader configuring it, we must tell the
> watchdog framework about this fact so that it can ping the
> watchdog until userspace opens the device and takes over
> control.
> 
> Do so using the WDOG_HW_RUNNING flag that exists for exactly
> that use-case.
> 
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> Cc: Luka Perkov <luka.perkov@sartura.hr>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> ---
> Changes in v4:
> * Use QCOM_WDT_ENABLE macro
> 
> Changes in v3:
> * Drop call to stop as start already does it
> * Update commit message
> 
> Changes in v2:
> * Correct authorship
> 
>  drivers/watchdog/qcom-wdt.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/watchdog/qcom-wdt.c b/drivers/watchdog/qcom-wdt.c
> index ab7465d186fd..07d399c4edc4 100644
> --- a/drivers/watchdog/qcom-wdt.c
> +++ b/drivers/watchdog/qcom-wdt.c
> @@ -152,6 +152,13 @@ static int qcom_wdt_restart(struct watchdog_device *wdd, unsigned long action,
>  	return 0;
>  }
>  
> +static int qcom_wdt_is_running(struct watchdog_device *wdd)
> +{
> +	struct qcom_wdt *wdt = to_qcom_wdt(wdd);
> +
> +	return (readl(wdt_addr(wdt, WDT_EN)) & QCOM_WDT_ENABLE);

Although, you don't need the outer () here.

Regards,
Bjorn

> +}
> +
>  static const struct watchdog_ops qcom_wdt_ops = {
>  	.start		= qcom_wdt_start,
>  	.stop		= qcom_wdt_stop,
> @@ -294,6 +301,17 @@ static int qcom_wdt_probe(struct platform_device *pdev)
>  	wdt->wdd.timeout = min(wdt->wdd.max_timeout, 30U);
>  	watchdog_init_timeout(&wdt->wdd, 0, dev);
>  
> +	/*
> +	 * If WDT is already running, call WDT start which
> +	 * will stop the WDT, set timeouts as bootloader
> +	 * might use different ones and set running bit
> +	 * to inform the WDT subsystem to ping the WDT
> +	 */
> +	if (qcom_wdt_is_running(&wdt->wdd)) {
> +		qcom_wdt_start(&wdt->wdd);
> +		set_bit(WDOG_HW_RUNNING, &wdt->wdd.status);
> +	}
> +
>  	ret = devm_watchdog_register_device(dev, &wdt->wdd);
>  	if (ret)
>  		return ret;
> -- 
> 2.28.0
> 

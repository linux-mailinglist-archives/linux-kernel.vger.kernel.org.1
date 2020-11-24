Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C53C52C1D24
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 05:53:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbgKXEwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 23:52:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbgKXEwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 23:52:00 -0500
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12849C0613D6
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 20:52:00 -0800 (PST)
Received: by mail-oi1-x244.google.com with SMTP id a130so14306263oif.7
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 20:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=21wh1RXrzLauQp1Zzrr3Pjj6ApJ/n51jC9LfHbkaKmY=;
        b=n0+dYK2xtpTlFNg42XEHZZzZwOGGufij+bDtWnHViKF9yePzEKzPJrA1FFYEgwpPa5
         oY1mB2mJngVy8JAvPrGAdkOOGYIWf0IpD+2BuGlz0nHYpDCJw0xT4yI3kVWay0HCieuC
         Vi9+iI8TdGRY5o38rbNJsazX19zg4M4jH3+T4W4R/W3YRkHzEEEsArM2jb+1+7fKPaGs
         iJR0NbItXQCxSoNLYm6SpOQWjRdb/T8PF0uJ7rvRD4Oeq9c6fiEQ01XrEOOV6F6jSGPl
         YZEYxcgFqWpX+ran3veNjljAXBwO8jST/RrbsAHvIxoU+eHd30V5Rohtq2FErIWTq1xV
         88EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=21wh1RXrzLauQp1Zzrr3Pjj6ApJ/n51jC9LfHbkaKmY=;
        b=YCWk6XxIb1fC/al+ArVC7YfqPx+2JtnaJIcsAoru5ZHY9XB10hWcNwLB4O/paLd2vK
         rNBsii/azYCqTX8tZQL+S906UDoR/lT3O4K8NFSdoEQ1mE25pik2nECLBSDicgufzukm
         x45aGEtJE4UGezU2f1ocwfB2So8Wo1FNjHcSth+h/4uXktY+OnABjmc1mhJTpE6a743X
         vH1bomygoYlVu/V8AynwMg6g8sOE6Mv7r9HvLp4g/JmKWRtx6TrEE/6cFgauj1esC/QS
         LANY6+a6uTHFp5lWWXm02JNBzdGRpa8mnHS+Wb0My32YC0y1Hrui4UKIAs+DDj1lStaH
         ytXw==
X-Gm-Message-State: AOAM5308LgkEvAJAZJRBGxPJM7nrOCUIx+Gd10U8CcZlCWA0brGqXUhm
        KG7/1EZzyoc0N2VDWrUkEbuAeA==
X-Google-Smtp-Source: ABdhPJxx8PNpFgul9bJq4f9P39PTOZ4UQOaHXVAQ3uMenmz0FcS/8UhRicJEaacMk+6aPMiKDvqJRg==
X-Received: by 2002:aca:f5c8:: with SMTP id t191mr1678894oih.40.1606193519483;
        Mon, 23 Nov 2020 20:51:59 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id z77sm8670400ooa.37.2020.11.23.20.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 20:51:58 -0800 (PST)
Date:   Mon, 23 Nov 2020 22:51:56 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>, Todd Kjos <tkjos@google.com>,
        Saravana Kannan <saravanak@google.com>,
        Andy Gross <agross@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Maulik Shah <mkshah@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2] regulator: Kconfig: Fix REGULATOR_QCOM_RPMH
 dependencies to avoid build error
Message-ID: <20201124045156.GI95182@builder.lan>
References: <20201123222359.103822-1-john.stultz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201123222359.103822-1-john.stultz@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 23 Nov 16:23 CST 2020, John Stultz wrote:

> The kernel test robot reported the following build error:
> 
> All errors (new ones prefixed by >>):
> 
>    xtensa-linux-ld: drivers/regulator/qcom-rpmh-regulator.o: in function `rpmh_regulator_vrm_get_voltage_sel':
>    qcom-rpmh-regulator.c:(.text+0x270): undefined reference to `rpmh_write'
>    xtensa-linux-ld: drivers/regulator/qcom-rpmh-regulator.o: in function `rpmh_regulator_send_request':
>    qcom-rpmh-regulator.c:(.text+0x2f2): undefined reference to `rpmh_write'
>    xtensa-linux-ld: drivers/regulator/qcom-rpmh-regulator.o: in function `rpmh_regulator_vrm_get_voltage_sel':
> >> qcom-rpmh-regulator.c:(.text+0x274): undefined reference to `rpmh_write_async'
>    xtensa-linux-ld: drivers/regulator/qcom-rpmh-regulator.o: in function `rpmh_regulator_send_request':
>    qcom-rpmh-regulator.c:(.text+0x2fc): undefined reference to `rpmh_write_async'
> 
> Which is due to REGULATOR_QCOM_RPMH depending on
> QCOM_RPMH || COMPILE_TEST. The problem is that QOM_RPMH can now
> be a module, which in that case requires REGULATOR_QCOM_RPMH=m
> to build.
> 
> However, if COMPILE_TEST is enabled, REGULATOR_QCOM_RPMH can be
> set to =y while QCOM_RPMH=m which will cause build failures.
> 
> The fix here is to add (QCOM_RPMH=n && COMPILE_TEST) to the
> dependency.
> 
> Feedback would be appreciated!

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> 
> Cc: Todd Kjos <tkjos@google.com>
> Cc: Saravana Kannan <saravanak@google.com>
> Cc: Andy Gross <agross@kernel.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Rajendra Nayak <rnayak@codeaurora.org>
> Cc: Maulik Shah <mkshah@codeaurora.org>
> Cc: Stephen Boyd <swboyd@chromium.org>
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: linux-arm-msm@vger.kernel.org
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> ---
> v2: Switch dependency logic as suggested by MarkB
> ---
>  drivers/regulator/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
> index 020a00d6696b..481c7b10133b 100644
> --- a/drivers/regulator/Kconfig
> +++ b/drivers/regulator/Kconfig
> @@ -843,7 +843,7 @@ config REGULATOR_QCOM_RPM
>  
>  config REGULATOR_QCOM_RPMH
>  	tristate "Qualcomm Technologies, Inc. RPMh regulator driver"
> -	depends on QCOM_RPMH || COMPILE_TEST
> +	depends on QCOM_RPMH || (QCOM_RPMH=n && COMPILE_TEST)
>  	help
>  	  This driver supports control of PMIC regulators via the RPMh hardware
>  	  block found on Qualcomm Technologies Inc. SoCs.  RPMh regulator
> -- 
> 2.17.1
> 

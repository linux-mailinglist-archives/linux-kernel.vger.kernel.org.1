Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 939AA2F7D13
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 14:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731707AbhAONry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 08:47:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727357AbhAONry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 08:47:54 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB659C061757
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 05:47:12 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id v15so5679670wrx.4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 05:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=gI1rGNtJLUPMtsBdl8TjmaIIxsFQAA6roo1dJpyj92g=;
        b=pl8NPSCmhYLcC71c99TqorY6LDAAeqcvPym/LZu5dnVd+E1Ay5J+ilOT+J/IQ3Eb6c
         O6aBW2RWpnEmdR7Vz+uT3g/Qy5r/zgcBNOm4468fpeoqninruIj5knKG5DyowWg4xsDf
         3KvhuGcivT9q6ugDL2r7JrQ6F43Y8sxvvi0zwJzhe6fPasxK5B7pWaOPxJoa0A5cqakM
         hRpxcHMM4jGX9XrSkwndrV0VHMFh/JYvpkfSxyBE/YJgL5mnW4kOxe/tjSyq4xxFfSE6
         ERa2Qo4EAF47k5W1tCwGn/TmFqekAgCXvUJeYQd/6z4bVqm045I5UnrtdNglpdYOgN0F
         6jdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=gI1rGNtJLUPMtsBdl8TjmaIIxsFQAA6roo1dJpyj92g=;
        b=Q8XYc0GxelnIGa1DFjRdgxOYeo2EIe7Fik++yCP0MUHTCw5CGh9ETnA5ZzteTnO1dj
         fP+B+A+aqBesD0hcCUt+guJDT1no9MTSnozQHD3QdllFnZe/CQzojgr0Nb/pRYJCuCgd
         MWVsnFf0fB4WamHL981U3qfUiPYFKgAYUXKq1qjI9S1Exp2GuDIqpZ1JNLTNlnGP91MH
         /KwgAc1KfBcCu8OMTJpRyHao86lylKaCKBGJTJRfymQy6i1Z/MWpfekBRJmXR2o9opS6
         8mNbd309M0fe65R5/fdKetLy09tfuaNwK9+HowBbTS2pZunwDRzNAYPGI9nhVjnSQtGS
         7Vjg==
X-Gm-Message-State: AOAM532/qADKrdFJ7s0I6kvC4GH0FoyP/4wDoBGpYN+qM+7Bd4czY6lm
        8JgEHO7b4HWCKtOA8zlFxP/igxJTgPy3/9DL
X-Google-Smtp-Source: ABdhPJzmEz/0avh77KvrdXDPg5Vdvu6IH4m4RjShY+RvDWYKQNMV6jSGl0dAxXWfzqcopqn0DnuIVw==
X-Received: by 2002:adf:b257:: with SMTP id y23mr7136057wra.371.1610718431531;
        Fri, 15 Jan 2021 05:47:11 -0800 (PST)
Received: from dell ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id s24sm8179535wmh.22.2021.01.15.05.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 05:47:10 -0800 (PST)
Date:   Fri, 15 Jan 2021 13:47:09 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     mazziesaccount@gmail.com, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-power@fi.rohmeurope.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: bd718x7, bd71828, Fix dvs voltage levels
Message-ID: <20210115134709.GM3975472@dell>
References: <20210115131040.GA633776@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210115131040.GA633776@localhost.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Jan 2021, Matti Vaittinen wrote:

> The ROHM BD718x7 and BD71828 drivers support setting HW state
> specific voltages from device-tree. This is used also by various
> in-tree DTS files.
> 
> These drivers do incorrectly try to compose bit-map using enum
> values. By a chance this works for first two valid levels having
> values 1 and 2 - but setting values for the rest of the levels
> do indicate capbility of setting values for first levels as
> well. Luckily the regulators which support settin values for
> SUSPEND/LPSR do usually also support setting values for RUN
> and IDLE too - thus this has not been such a fatal issue.
> 
> Fix this by defining the old enum values as bits and using
> new enum in parsing code. This allows keeping existing IC
> specific drivers intact and only adding the defines and
> slightly changing the rohm-regulator.c
> 
> Fixes: 21b72156ede8b ("regulator: bd718x7: Split driver to common and bd718x7 specific parts")
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> ---
>  drivers/regulator/rohm-regulator.c |  8 ++++----
>  include/linux/mfd/rohm-generic.h   | 22 ++++++++++++++++------
>  2 files changed, 20 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/regulator/rohm-regulator.c b/drivers/regulator/rohm-regulator.c
> index 399002383b28..96caae7dbef4 100644
> --- a/drivers/regulator/rohm-regulator.c
> +++ b/drivers/regulator/rohm-regulator.c
> @@ -55,25 +55,25 @@ int rohm_regulator_set_dvs_levels(const struct rohm_dvs_config *dvs,
>  	for (i = 0; i < ROHM_DVS_LEVEL_MAX && !ret; i++) {
>  		if (dvs->level_map & (1 << i)) {
>  			switch (i + 1) {
> -			case ROHM_DVS_LEVEL_RUN:
> +			case _ROHM_DVS_LEVEL_RUN:
>  				prop = "rohm,dvs-run-voltage";
>  				reg = dvs->run_reg;
>  				mask = dvs->run_mask;
>  				omask = dvs->run_on_mask;
>  				break;
> -			case ROHM_DVS_LEVEL_IDLE:
> +			case _ROHM_DVS_LEVEL_IDLE:
>  				prop = "rohm,dvs-idle-voltage";
>  				reg = dvs->idle_reg;
>  				mask = dvs->idle_mask;
>  				omask = dvs->idle_on_mask;
>  				break;
> -			case ROHM_DVS_LEVEL_SUSPEND:
> +			case _ROHM_DVS_LEVEL_SUSPEND:
>  				prop = "rohm,dvs-suspend-voltage";
>  				reg = dvs->suspend_reg;
>  				mask = dvs->suspend_mask;
>  				omask = dvs->suspend_on_mask;
>  				break;
> -			case ROHM_DVS_LEVEL_LPSR:
> +			case _ROHM_DVS_LEVEL_LPSR:
>  				prop = "rohm,dvs-lpsr-voltage";
>  				reg = dvs->lpsr_reg;
>  				mask = dvs->lpsr_mask;
> diff --git a/include/linux/mfd/rohm-generic.h b/include/linux/mfd/rohm-generic.h
> index 4283b5b33e04..a557988831d7 100644
> --- a/include/linux/mfd/rohm-generic.h
> +++ b/include/linux/mfd/rohm-generic.h
> @@ -20,15 +20,25 @@ struct rohm_regmap_dev {
>  	struct regmap *regmap;
>  };
>  
> +/*
> + * Do not use these in IC specific driver - the bit map should be created using
> + * defines without the underscore. These should be used only in rohm-regulator.c
> + */
>  enum {
> -	ROHM_DVS_LEVEL_UNKNOWN,
> -	ROHM_DVS_LEVEL_RUN,
> -	ROHM_DVS_LEVEL_IDLE,
> -	ROHM_DVS_LEVEL_SUSPEND,
> -	ROHM_DVS_LEVEL_LPSR,
> -	ROHM_DVS_LEVEL_MAX = ROHM_DVS_LEVEL_LPSR,
> +	_ROHM_DVS_LEVEL_UNKNOWN,
> +	_ROHM_DVS_LEVEL_RUN,
> +	_ROHM_DVS_LEVEL_IDLE,
> +	_ROHM_DVS_LEVEL_SUSPEND,
> +	_ROHM_DVS_LEVEL_LPSR,
> +	ROHM_DVS_LEVEL_MAX = _ROHM_DVS_LEVEL_LPSR,

I don't understand how this is still not broken.

I think you either need to change the for() loop that consumes this to
use "<=" or push the MAX enum to the last line (on its own).

The latter would be my personal preference.

>  };
>  
> +#define ROHM_DVS_LEVEL_UNKNOWN	(1 << _ROHM_DVS_LEVEL_UNKNOWN)
> +#define ROHM_DVS_LEVEL_RUN	(1 << _ROHM_DVS_LEVEL_RUN)
> +#define ROHM_DVS_LEVEL_IDLE	(1 << _ROHM_DVS_LEVEL_IDLE)
> +#define ROHM_DVS_LEVEL_SUSPEND	(1 << _ROHM_DVS_LEVEL_SUSPEND)
> +#define ROHM_DVS_LEVEL_LPSR	(1 << _ROHM_DVS_LEVEL_LPSR)
> +
>  /**
>   * struct rohm_dvs_config - dynamic voltage scaling register descriptions
>   *
> 
> base-commit: 7c53f6b671f4aba70ff15e1b05148b10d58c2837

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog

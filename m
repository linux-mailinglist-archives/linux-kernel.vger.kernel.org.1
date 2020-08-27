Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EEB2254CBB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Aug 2020 20:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbgH0SQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Aug 2020 14:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726093AbgH0SQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 14:16:18 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE8FC061264
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 11:16:18 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id t23so7505326ljc.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 11:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BMtVJeUzPW/21lgl19SChHP4cZE4M9iPKQteLK365hc=;
        b=wSFnOytpcvV49hUor1Rhdq4fcuf+m8XOkFWmRJFZONnZr5+2pKLo+thilZqINwctis
         Lih/hDbQknTYZiybi6yukykCPU/WuKeauT6TYHuuzPC2WcCYX/EwIZ4xgLFQESP8pBvg
         AuogxTrIHrNP7sZx5EiOukhE+A0WhNOPsuhU0/B6gSEuRBpdPaFS+oTNWCU0Y/txxi99
         nkpUElLoghA9MMX+xLCn49XPBXwSzET5O96KWH1urHfmWqEW3bVymWP4gtDJDAJB6j+W
         9xB/QzVEqvL5GGvXEOdRp9v0sdiTttXrn9JCLjxoQlhZ+2ievLWVO5tsWO8+SWalt9yc
         1YRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BMtVJeUzPW/21lgl19SChHP4cZE4M9iPKQteLK365hc=;
        b=RcmrOqf/7K6nLl5ztOKTbKvHmrjOB1NEhQaI2/0c3M5nMyAt1UpZWw89E+KD5KSD0p
         GZ4G/K48gf1BxzQq5rOtA/SHKiOtGR0mmaDljJ+oGvAigoeVOhWvaF5JfFeFcsgNosi0
         9eQvdTVkmjRCPBHBkJWWW5/hWVo207J2XMC7wEQAjVQCHePGcmiLG+B7OwCcJJ0rfLcL
         ZupwhYmC4wSNvjl2CtxHm/wU20i+uXw05msV4OF9gWN2CP/p9GxSZ0ikZEhkvwMIynhc
         7C99uc1Vx/gwQfgzhzuvxuw7PLlfprmrmb8RGA1PCyeuGvFhij/CZbAtPOcI3SiSa74w
         A+Aw==
X-Gm-Message-State: AOAM531DEc25BczB6d204pUw9LvSdYAcPBHGyAaMm1P5gUgnW6d2TAjO
        Dy2kyLSfUO2bqh4me0nUJxq4xQ==
X-Google-Smtp-Source: ABdhPJyRXbMmaqx33BlJbVeirHn2s23BP4VtRqpHZtPTTzbS8hQiyMwTkQPXvTPUnMPGqyp4G53J/w==
X-Received: by 2002:a05:651c:310:: with SMTP id a16mr9665626ljp.250.1598552176768;
        Thu, 27 Aug 2020 11:16:16 -0700 (PDT)
Received: from [192.168.1.211] ([188.162.64.50])
        by smtp.gmail.com with ESMTPSA id s4sm615367lja.124.2020.08.27.11.16.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2020 11:16:15 -0700 (PDT)
Subject: Re: [PATCH 4/5] soundwire: qcom: avoid dependency on CONFIG_SLIMBUS
To:     Jonathan Marek <jonathan@marek.ca>, alsa-devel@alsa-project.org
Cc:     Vinod Koul <vkoul@kernel.org>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>
References: <20200608204347.19685-1-jonathan@marek.ca>
 <20200608204347.19685-5-jonathan@marek.ca>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Message-ID: <43fdb4d4-0adc-28f2-b4a5-e0594b9a3044@linaro.org>
Date:   Thu, 27 Aug 2020 21:16:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200608204347.19685-5-jonathan@marek.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/06/2020 23:43, Jonathan Marek wrote:
> The driver may be used without slimbus, so don't depend on slimbus.
> 
> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> ---
>   drivers/soundwire/Kconfig | 1 -
>   drivers/soundwire/qcom.c  | 5 +++++
>   2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soundwire/Kconfig b/drivers/soundwire/Kconfig
> index fa2b4ab92ed9..d121cf739090 100644
> --- a/drivers/soundwire/Kconfig
> +++ b/drivers/soundwire/Kconfig
> @@ -33,7 +33,6 @@ config SOUNDWIRE_INTEL
>   
>   config SOUNDWIRE_QCOM
>   	tristate "Qualcomm SoundWire Master driver"
> -	depends on SLIMBUS

I'd suggest:
depends on SLIMBUS || !SLIMBUS #if SLIMBUS=m, this can not be builtin

This would allow building both SLIMBUS and SOUNDWIRE_QCOM as modules

>   	depends on SND_SOC
>   	help
>   	  SoundWire Qualcomm Master driver.
> diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
> index 14334442615f..ac81c64768ea 100644
> --- a/drivers/soundwire/qcom.c
> +++ b/drivers/soundwire/qcom.c
> @@ -769,13 +769,18 @@ static int qcom_swrm_probe(struct platform_device *pdev)
>   	if (!ctrl)
>   		return -ENOMEM;
>   
> +#ifdef CONFIG_SLIMBUS

and then #if IS_ENABLED(CONFIG_SLIBMUS) here

>   	if (dev->parent->bus == &slimbus_bus) {
> +#else
> +	if (false) {
> +#endif
>   		ctrl->reg_read = qcom_swrm_ahb_reg_read;
>   		ctrl->reg_write = qcom_swrm_ahb_reg_write;
>   		ctrl->regmap = dev_get_regmap(dev->parent, NULL);
>   		if (!ctrl->regmap)
>   			return -EINVAL;
>   	} else {
> +
>   		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>   
>   		ctrl->reg_read = qcom_swrm_cpu_reg_read;
> 


-- 
With best wishes
Dmitry

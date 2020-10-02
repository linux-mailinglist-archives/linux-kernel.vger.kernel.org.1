Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7EDF281346
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 14:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387886AbgJBM5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 08:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387412AbgJBM5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 08:57:42 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC5DC0613D0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 05:57:42 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id s13so1591672wmh.4
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 05:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=43YMyAraFcnlRIgLFQOPJ4TtLA2BehQoYI4Q0ek9zDk=;
        b=GHcbG5RACdnbf6XvhSlRxqvxF7cKprdivqsvJHAhDo6xLRSjfwNg7DDfHxTDXcBoJl
         EAC5D38Nds6fBzl50XZrxTX3WTmlM0DmILA5kMIK92Rjzs9EiLSnp5MsctzRBQNLP1D1
         pXPTFZ6DhQfYfGiMuRa3H2JJJbXp9F6M8IS7KHr5lw8Js/1/ibQ4wxnzPIWrfyAybytz
         euNFqndzGb7DmbS3beJmOFj+YF5ePCtu6/pIozohlVDuPKBQ3wOUcfpwbgh4YUV/K/7k
         Xqsqw4dagUyKwoSaLooIwz84AIOw+LkiMrj4Y+pUywSxdM22Nky84w7IOlGZwPMojsz5
         ikOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=43YMyAraFcnlRIgLFQOPJ4TtLA2BehQoYI4Q0ek9zDk=;
        b=IngFxPMN9Goa+aG07dJKS+Crpu/sDB9K0Xti6iEjUt+GDg+ZYqMgleWT3NpNLPOPOL
         dQoVgz2QLnL2MYikdTMgix/LCVrRWBusmjF8mvQ3Y1jKTwRGgDmKzaxLa4qU8/R85Vft
         x+eReQWnF/2PHiEAOdvbQNgvU7BPCEO+0utwVNus/uYWZqSmAt79KVyYwaeGiDGGPLqq
         uph5DPI3UatJaLMOe+FPgR38KHiN2EIaqJA6VjS8iLLsafgVhWKgZNicj77x+X4RXMKx
         2J9IINvUi2lpTd/ZWP0GwEycgKukP1LMHAcwJIDQliCPuWjg/IiWrDrG2YNomG6BM3Tw
         oXSA==
X-Gm-Message-State: AOAM533NDeZPJav3Zhye+syD/79lxToO74gcXo7QZsTy/xAFGwb/Pipl
        2LZQ75UfrxTGkCOMswLj4Mb77g==
X-Google-Smtp-Source: ABdhPJxD/MrPY3QcaILADFf85Aye8IYAKX/pGWFsiP5f10GYtQzE9IshZLLurZ3Vr0672gsG51qJPA==
X-Received: by 2002:a1c:7912:: with SMTP id l18mr2782925wme.124.1601643461273;
        Fri, 02 Oct 2020 05:57:41 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id l19sm1704717wmi.8.2020.10.02.05.57.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Oct 2020 05:57:40 -0700 (PDT)
Subject: Re: [PATCH -next] ASoC: qcom: fix SDM845 & QDSP6 dependencies more
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
References: <20201001183537.5781-1-rdunlap@infradead.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <602e1ffe-e916-17ed-a311-65dc3e3a3638@linaro.org>
Date:   Fri, 2 Oct 2020 13:57:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20201001183537.5781-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/10/2020 19:35, Randy Dunlap wrote:
> Fix a build error and Kconfig warning in sound/soc/qcom/.
> 
> ld: sound/soc/qcom/qdsp6/q6afe-clocks.o: in function `q6afe_clock_dev_probe':
> q6afe-clocks.c:(.text+0x182): undefined reference to `devm_clk_hw_register'
> ld: q6afe-clocks.c:(.text+0x19d): undefined reference to `of_clk_add_hw_provider'
> 
> After adding "depends on COMMON_CLK" for SND_SOC_QDSP6, the Kconfig
> warning appears because "select" does not honor any "depends on"
> clauses, so fix the dependency for SND_SOC_SDM845 also.
> 
> WARNING: unmet direct dependencies detected for SND_SOC_QDSP6
>    Depends on [n]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SND_SOC_QCOM [=y] && QCOM_APR [=y] && COMMON_CLK [=n]
>    Selected by [y]:
>    - SND_SOC_SDM845 [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SND_SOC_QCOM [=y] && QCOM_APR [=y] && I2C [=y] && SOUNDWIRE [=y]
> 
> Fixes: 520a1c396d19 ("ASoC: q6afe-clocks: add q6afe clock controller")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Jaroslav Kysela <perex@perex.cz>
> Cc: Takashi Iwai <tiwai@suse.com>
> Cc: alsa-devel@alsa-project.org

Thanks Randy for fixing this!

Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>


--srini
> ---
>   sound/soc/qcom/Kconfig |    2 ++
>   1 file changed, 2 insertions(+)
> 
> --- linux-next-20201001.orig/sound/soc/qcom/Kconfig
> +++ linux-next-20201001/sound/soc/qcom/Kconfig
> @@ -82,6 +82,7 @@ config SND_SOC_QDSP6_ASM_DAI
>   config SND_SOC_QDSP6
>   	tristate "SoC ALSA audio driver for QDSP6"
>   	depends on QCOM_APR
> +	depends on COMMON_CLK
>   	select SND_SOC_QDSP6_COMMON
>   	select SND_SOC_QDSP6_CORE
>   	select SND_SOC_QDSP6_AFE
> @@ -110,6 +111,7 @@ config SND_SOC_MSM8996
>   config SND_SOC_SDM845
>   	tristate "SoC Machine driver for SDM845 boards"
>   	depends on QCOM_APR && I2C && SOUNDWIRE
> +	depends on COMMON_CLK
>   	select SND_SOC_QDSP6
>   	select SND_SOC_QCOM_COMMON
>   	select SND_SOC_RT5663
> 

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 002D12CF358
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 18:49:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbgLDRtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 12:49:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbgLDRtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 12:49:02 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A8BFC0613D1
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 09:48:21 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id 3so7756194wmg.4
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 09:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sMl59r/DRuLhlu2MW09102jLe2PGam7zMSw8APT3Z8E=;
        b=i9UUNczYIoqf8Q0ReLkw6C9jKlRJzpV5SpA2c+E/H/NSOxbEpvbgpSpGvfrUNBP4Rg
         M5aVvqrY15vaHr4iWkhDtMPyN5GWi7LS/SzYJNSxnO9EYqoPf39zpDD4PUXqFkhrmHfD
         wptMqkTnE7mcf6pg8hIOg9QY8XLeQd676QxDre/GwAVEhSh6aUDWHXcEIub1mWxl3yjD
         DR/y+2FW/2xykQ6r7uX3bGphlVjgPgRdM2f3/m7ROHPB9DZ9LdDZpTV/IDa2sE3ePuDs
         ovQqsJpVso63a7xosb+C4X/etLR3//citOdWttgICGDwI99ZfSSSgd8/YMJtsmz3WFTp
         6VuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sMl59r/DRuLhlu2MW09102jLe2PGam7zMSw8APT3Z8E=;
        b=PXc0AJk6qbp2DMRwd73XsyCUOpdQeBBkzZlz76hYWrruk7KW+8mq4ClKZd7F9PtVmK
         y+h/X8S2COH/tEdQapApLpnQs6C04UNvwDyBF+HtP1+2X4cWqeReBrzULeZ59tP4DFIM
         JkJS+9Ch2V6eqlzQ17zrxyuSZG/vpGtGd/KSmwdRzZ+QV7wNh5iElHCJy5c6mrIRWVk2
         +GwywTtH7ReLfOnGZGGF4K4VAHqIWiH6FHfPC5YMxBjtMF6D2XMr1VosTY/w3N+9GTBD
         iFVjUKGI2lWVK4ub5qiXw9dWnDplbedE9N+M5n2o1qzB+yt0UX4fQpgn2hwiSFkDmu3+
         BuTA==
X-Gm-Message-State: AOAM5313baxUdcdnkpzXK/vhROjd6dCzi/ZZaeY8Cz1G1PdG6VsWdjo4
        L5yXJ23TkJLlGepT9Mv6Ta18BQa7NTvO4xdF
X-Google-Smtp-Source: ABdhPJxJxirtFSOAFrreLRqfQ9/krXdMGpQdC2UWJ2tuRPnf0tQGiAGmoud05hs+ubQH11BcUjmiKQ==
X-Received: by 2002:a1c:6056:: with SMTP id u83mr5375331wmb.90.1607104099954;
        Fri, 04 Dec 2020 09:48:19 -0800 (PST)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id n123sm4148301wmn.7.2020.12.04.09.48.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Dec 2020 09:48:18 -0800 (PST)
Subject: Re: [PATCH] ASoC: qcom: fix QDSP6 dependencies, attempt #3
To:     Arnd Bergmann <arnd@kernel.org>, Patrick Lai <plai@codeaurora.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Ajit Pandey <ajitp@codeaurora.org>,
        Rohit kumar <rohitkr@codeaurora.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20201203231443.1483763-1-arnd@kernel.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <8323d386-c3f1-2db6-1870-2279784dd85e@linaro.org>
Date:   Fri, 4 Dec 2020 17:48:17 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20201203231443.1483763-1-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/12/2020 23:14, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The previous fix left another warning in randconfig builds:
> 
> WARNING: unmet direct dependencies detected for SND_SOC_QDSP6
>    Depends on [n]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SND_SOC_QCOM [=y] && QCOM_APR [=y] && COMMON_CLK [=n]
>    Selected by [y]:
>    - SND_SOC_MSM8996 [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && SND_SOC_QCOM [=y] && QCOM_APR [=y]
> 
> Add one more dependency for this one.
> 
> Fixes: 2bc8831b135c ("ASoC: qcom: fix SDM845 & QDSP6 dependencies more")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks for the patch,

Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

> ---
>   sound/soc/qcom/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
> index 27f93006be96..cc7c1de2f1d9 100644
> --- a/sound/soc/qcom/Kconfig
> +++ b/sound/soc/qcom/Kconfig
> @@ -106,6 +106,7 @@ config SND_SOC_QDSP6
>   config SND_SOC_MSM8996
>   	tristate "SoC Machine driver for MSM8996 and APQ8096 boards"
>   	depends on QCOM_APR
> +	depends on COMMON_CLK
>   	select SND_SOC_QDSP6
>   	select SND_SOC_QCOM_COMMON
>   	help
> 

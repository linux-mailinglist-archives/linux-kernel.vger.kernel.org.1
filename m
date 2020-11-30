Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07A252C8314
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 12:20:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728854AbgK3LT5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 06:19:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727394AbgK3LT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 06:19:56 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B981C0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 03:19:16 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id c198so18057913wmd.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 03:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kA1B+3YWtsqZLdoP/PFm3M4IJcbU3ZY5uXa3zxL9D5U=;
        b=kXGC/hkXw3WUjUW8dyzi+KxMgQfPrY9PpqKHsi6N9ndZtsG6e1wl8Up32s/Q/MNzp/
         TG9HDjXySSC8sE2voSaQHmDaGs9ApE6cX2ZNK53ZPBiJ241946+2OdCXXwPPnyrB2g+I
         28BidxQ1k8Au44U2UvYUWh31ljl4YB44MmNzpBNIHXAKL2MNDa3DHBIzbXfbexLzRLoV
         LZWfLOWLBxWYNWAFbrN54yQ203hMABfhBDAabKVsALajqJXsZNN2leThKFjssZbpiSiw
         Z+c5ECJwrCHcsmjolzUkNOdA8OGjcKfgivWeo2E9oLtTVUs9KWRQwfWxaBSN1NwZ9fYe
         bEfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kA1B+3YWtsqZLdoP/PFm3M4IJcbU3ZY5uXa3zxL9D5U=;
        b=uKUNiSTe19GkYAqEpQLxs6XfSsOtyGIny7cVmgCmVGgJxeiBUdm6gBBoBU8YrxvGay
         HVJG5mVvUIq7ba8+gAHX6GRjies90kFzcVUS+UUOCR1215ubwWX/jdrA8ZSgLAaqYrUn
         sQ9OZAO8ycxvpjnZbTlT3mFq23rOm1CcJCQ9gxBN19Xvf09fUpNMnw1B2RItbiru4zKJ
         Ho8hSWL9I4ysCBwH2PHLipABsLuN/dCzhdSO1lq1XiiUoFRRRM3ouTRtRpRvQyX+iBCM
         gRsxdS8CNWjNEYHY3VWz+PFMfapbYDWpL/dfx5romzRdx+GXh0tqTlozjGx3VY8d9lNh
         Mfnw==
X-Gm-Message-State: AOAM532kI5lKpniLRZ/p/5JAkQ7UocJcPM51DxLVZYqM6VqfjE+QNj4y
        IKmU0wccuP7SSc4SsU6XeIngiw==
X-Google-Smtp-Source: ABdhPJx7hVSTJ3o2Q+DoAP6jkZgpwx9aW3qQbrc5tsnfxpODLxn1PpVJnz6LFK/zs2NdbZFgj3iJPw==
X-Received: by 2002:a1c:4802:: with SMTP id v2mr14690593wma.13.1606735155159;
        Mon, 30 Nov 2020 03:19:15 -0800 (PST)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id j14sm26432119wrs.49.2020.11.30.03.19.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Nov 2020 03:19:14 -0800 (PST)
Subject: Re: [PATCH v4 2/2] ASoC: qcom: Add support for playback recover after
 resume
To:     Srinivasa Rao Mandadapu <srivasam@codeaurora.org>,
        agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, plai@codeaurora.org,
        bgoswami@codeaurora.org, perex@perex.cz, tiwai@suse.com,
        rohitkr@codeaurora.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     V Sujith Kumar Reddy <vsujithk@codeaurora.org>
References: <1606539559-4277-1-git-send-email-srivasam@codeaurora.org>
 <1606539559-4277-3-git-send-email-srivasam@codeaurora.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <76b8d52f-4f54-734f-683a-72fe62fdd8e4@linaro.org>
Date:   Mon, 30 Nov 2020 11:19:13 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1606539559-4277-3-git-send-email-srivasam@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28/11/2020 04:59, Srinivasa Rao Mandadapu wrote:
> To support playback continuation after hard suspend(bypass powerd)
> and resume add component driver ops and do regcache sync.
> 
> Signed-off-by: V Sujith Kumar Reddy <vsujithk@codeaurora.org>
> Signed-off-by: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>

LGTM,

Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>


> ---
>   sound/soc/qcom/lpass-platform.c | 35 +++++++++++++++++++++++++++++++++++
>   1 file changed, 35 insertions(+)
> 
> diff --git a/sound/soc/qcom/lpass-platform.c b/sound/soc/qcom/lpass-platform.c
> index 0e71899..12764a8 100644
> --- a/sound/soc/qcom/lpass-platform.c
> +++ b/sound/soc/qcom/lpass-platform.c
> @@ -827,6 +827,39 @@ static void lpass_platform_pcm_free(struct snd_soc_component *component,
>   	}
>   }
>   
> +static int lpass_platform_pcmops_suspend(struct snd_soc_component *component)
> +{
> +	struct lpass_data *drvdata = snd_soc_component_get_drvdata(component);
> +	struct regmap *map;
> +	unsigned int dai_id = component->id;
> +
> +	if (dai_id == LPASS_DP_RX)
> +		map = drvdata->hdmiif_map;
> +	else
> +		map = drvdata->lpaif_map;
> +
> +	regcache_cache_only(map, true);
> +	regcache_mark_dirty(map);
> +
> +	return 0;
> +}
> +
> +static int lpass_platform_pcmops_resume(struct snd_soc_component *component)
> +{
> +	struct lpass_data *drvdata = snd_soc_component_get_drvdata(component);
> +	struct regmap *map;
> +	unsigned int dai_id = component->id;
> +
> +	if (dai_id == LPASS_DP_RX)
> +		map = drvdata->hdmiif_map;
> +	else
> +		map = drvdata->lpaif_map;
> +
> +	regcache_cache_only(map, false);
> +	return regcache_sync(map);
> +}
> +
> +
>   static const struct snd_soc_component_driver lpass_component_driver = {
>   	.name		= DRV_NAME,
>   	.open		= lpass_platform_pcmops_open,
> @@ -839,6 +872,8 @@ static const struct snd_soc_component_driver lpass_component_driver = {
>   	.mmap		= lpass_platform_pcmops_mmap,
>   	.pcm_construct	= lpass_platform_pcm_new,
>   	.pcm_destruct	= lpass_platform_pcm_free,
> +	.suspend		= lpass_platform_pcmops_suspend,
> +	.resume			= lpass_platform_pcmops_resume,
>   
>   };
>   
> 

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67932303611
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 06:59:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbhAZF6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 00:58:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728133AbhAYMmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 07:42:25 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8730C061220;
        Mon, 25 Jan 2021 03:40:46 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id i187so6954457lfd.4;
        Mon, 25 Jan 2021 03:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:references:cc:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PMgg2luzI+jv/8tT/PbY1/txpikMhuVrg+F0w7+xUaQ=;
        b=fUDbEVemeYrdAIYNi6hwdm3B4+Co85z3n6IkM5VeTKlGMjNLRRrS6MxejkUpPtP0uN
         NGu1ONUNIYs/uQOSPmvT+R9BjxTsdBCW4VC9sC7dU1Et6jWw2S29258ck3wjZrJNI6S4
         mJa0DIZTesmHECHOguXWpmO6FTUw4CYrp+JIP8RlfuoIONqkJ6ylIAo7eUH0XMxg41oM
         qV+jU/nJAbInpcnVomm0oGILMw7rQwu98lbB4iigx2DAH3Xu+kr22Cz0d8F7BHVQ9bt0
         1mNhoddFsLV0t9wmz9k2LgUNBt+n78tXcxUAcLDuB0gB3EKA77gSi6C//JvMCeHF6W88
         oFdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:references:cc:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PMgg2luzI+jv/8tT/PbY1/txpikMhuVrg+F0w7+xUaQ=;
        b=kQ5xLdKuDwg9Tx/3twovUOlxRq0UX/rZxakcMMbGczG70jNQFUxGgeQ0UhFxmAMj80
         2KD54qC+61YB7q9NIO1cEfqsyVwFij3tahc4TN0Ur3JLXoX6setmVoJUqMRAzb7QOSSx
         KzXutKGmIFeVcRCf2uvjd+fowYzKFJ6fsnMi342EnuNANHgyRMs00F0qSOKVDhfb7qnM
         OJWJXDBMrn4T0qnWrfmyhFeydghLRyMKbz2qHxeX31NrnfJZEIjG3f/TCZJQ76cWOVGj
         O2FwRZc7S3JcpGW7OeqNL49RD94Lfpys+Vu3gC/DclyHVEJ4up6CEmfFvntztbMcZWUx
         Dljw==
X-Gm-Message-State: AOAM5313wQwXqVCJjFOgVOP47M+qV6Tl0XNb+pA5LzvGUA3W6V5CfJ5f
        IQ/sV8KamK5qkg1UYCTMww4=
X-Google-Smtp-Source: ABdhPJy87Gc29+0wrax5LB9cFZHchKa03iCgfQ6KNpN7/FtekfRdihhuzTE08d+w+CzGYxAECdcs+g==
X-Received: by 2002:ac2:57c9:: with SMTP id k9mr67155lfo.165.1611574845303;
        Mon, 25 Jan 2021 03:40:45 -0800 (PST)
Received: from [10.0.0.42] (91-157-86-155.elisa-laajakaista.fi. [91.157.86.155])
        by smtp.gmail.com with ESMTPSA id s22sm1605927ljh.102.2021.01.25.03.40.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jan 2021 03:40:44 -0800 (PST)
To:     Pavel Machek <pavel@ucw.cz>, broonie@kernel.org,
        aaro.koskinen@iki.fi, spinal.by@gmail.com,
        jarkko.nikula@bitmer.com, merlijn@wizzup.org, sre@kernel.org,
        tony@atomide.com, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, phone-devel@vger.kernel.org
References: <20210124092713.GA22195@amd>
Cc:     kuninori.morimoto.gx@renesas.com
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
Subject: Re: [PATCH] ASoC: ti: Allocate dais dynamically for TDM and audio
 graph card
Message-ID: <2a9e7655-3d32-feb5-080c-8928a96f417e@gmail.com>
Date:   Mon, 25 Jan 2021 13:43:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210124092713.GA22195@amd>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On 1/24/21 11:27 AM, Pavel Machek wrote:
> From: Tony Lindgren <tony@atomide.com>
> 
> We can have multiple connections on a single McBSP instance configured
> with audio graph card when using TDM (Time Division Multiplexing). Let's
> allow that by configuring dais dynamically.

Still we have _one_ DAI per McBSP. TDM slots are not DAIs.

> See Documentation/devicetree/bindings/sound/audio-graph-card.txt and
> Documentation/devicetree/bindings/graph.txt for more details for
> multiple endpoints.

Documentation/devicetree/bindings/sound/audio-graph-card.yaml
Documentation/devicetree/bindings/sound/audio-graph.yaml

However the schemas does not provide too much insight (the txts were a 
bit more verbose).

> I've tested this with droid4 where cpcap pmic and modem voice are both
> both wired to mcbsp3. I've also tested this on droid4 both with and
> without the pending modem audio codec driver that is waiting for n_gsm
> serdev dependencies to clear.
 >
> Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
> Cc: Arthur D. <spinal.by@gmail.com>
> Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>
> Cc: Merlijn Wajer <merlijn@wizzup.org>
> Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Cc: Sebastian Reichel <sre@kernel.org>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Pavel Machek <pavel@ucw.cz>
> 
> ---
>   sound/soc/ti/omap-mcbsp-priv.h |  2 ++
>   sound/soc/ti/omap-mcbsp.c      | 76 +++++++++++++++++++++++++++++-------------
>   2 files changed, 55 insertions(+), 23 deletions(-)
> 
> diff --git a/sound/soc/ti/omap-mcbsp-priv.h b/sound/soc/ti/omap-mcbsp-priv.h
> index 7865cda4bf0a..9464f5d35822 100644
> --- a/sound/soc/ti/omap-mcbsp-priv.h
> +++ b/sound/soc/ti/omap-mcbsp-priv.h
> @@ -262,6 +262,8 @@ struct omap_mcbsp {
>   	struct omap_mcbsp_platform_data *pdata;
>   	struct omap_mcbsp_st_data *st_data;
>   	struct omap_mcbsp_reg_cfg cfg_regs;
> +	struct snd_soc_dai_driver *dais;
> +	int dai_count;
>   	struct snd_dmaengine_dai_dma_data dma_data[2];
>   	unsigned int dma_req[2];
>   	int dma_op_mode;
> diff --git a/sound/soc/ti/omap-mcbsp.c b/sound/soc/ti/omap-mcbsp.c
> index 6025b30bbe77..189a6461b671 100644
> --- a/sound/soc/ti/omap-mcbsp.c
> +++ b/sound/soc/ti/omap-mcbsp.c
> @@ -14,6 +14,7 @@
>   #include <linux/pm_runtime.h>
>   #include <linux/of.h>
>   #include <linux/of_device.h>
> +#include <linux/of_graph.h>
>   #include <sound/core.h>
>   #include <sound/pcm.h>
>   #include <sound/pcm_params.h>
> @@ -1299,23 +1300,53 @@ static int omap_mcbsp_remove(struct snd_soc_dai *dai)
>   	return 0;
>   }
>   
> -static struct snd_soc_dai_driver omap_mcbsp_dai = {
> -	.probe = omap_mcbsp_probe,
> -	.remove = omap_mcbsp_remove,
> -	.playback = {
> -		.channels_min = 1,
> -		.channels_max = 16,
> -		.rates = OMAP_MCBSP_RATES,
> -		.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S32_LE,
> -	},
> -	.capture = {
> -		.channels_min = 1,
> -		.channels_max = 16,
> -		.rates = OMAP_MCBSP_RATES,
> -		.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S32_LE,
> -	},
> -	.ops = &mcbsp_dai_ops,
> -};
> +static int omap_mcbsp_init_dais(struct omap_mcbsp *mcbsp)
> +{
> +	struct device_node *np = mcbsp->dev->of_node;
> +	int i;
> +
> +	if (np)
> +		mcbsp->dai_count = of_graph_get_endpoint_count(np);
> +
> +	if (!mcbsp->dai_count)
> +		mcbsp->dai_count = 1;
> +
> +	mcbsp->dais = devm_kcalloc(mcbsp->dev, mcbsp->dai_count,
> +				   sizeof(*mcbsp->dais), GFP_KERNEL);
> +	if (!mcbsp->dais)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < mcbsp->dai_count; i++) {
> +		struct snd_soc_dai_driver *dai = &mcbsp->dais[i];
> +
> +		dai->name = devm_kasprintf(mcbsp->dev, GFP_KERNEL, "%s-dai%i",
> +					   dev_name(mcbsp->dev), i);
> +
> +		if (i == 0) {
> +			dai->probe = omap_mcbsp_probe;
> +			dai->remove = omap_mcbsp_remove;
> +			dai->ops = &mcbsp_dai_ops;
> +		}

You are effectively creating extra dummy-dais (no ops), but naming them 
as McBSP.
The dummy-dais will only work if the real dai is in use and the dai link 
which contains the real dai must be configured (TDM slots, format, 
channels) to accomodate the link which contains the dummy-dai.

The idea did not aged well for me ;)
It still looks and sounds like a hack to model the TDM slots on a single 
DAI as multiple DAIs just to satisfy a generic binding which is not 
aimed to satisfy the droid4 setup (which is far from anything simple).

> +		dai->playback.channels_min = 1;
> +		dai->playback.channels_max = 16;
> +		dai->playback.rates = OMAP_MCBSP_RATES;
> +		if (mcbsp->pdata->reg_size == 2)
> +			dai->playback.formats = SNDRV_PCM_FMTBIT_S16_LE;
> +		else
> +			dai->playback.formats = SNDRV_PCM_FMTBIT_S16_LE |
> +						SNDRV_PCM_FMTBIT_S32_LE;
> +		dai->capture.channels_min = 1;
> +		dai->capture.channels_max = 16;
> +		dai->capture.rates = OMAP_MCBSP_RATES;
> +		if (mcbsp->pdata->reg_size == 2)
> +			dai->capture.formats = SNDRV_PCM_FMTBIT_S16_LE;
> +		else
> +			dai->capture.formats = SNDRV_PCM_FMTBIT_S16_LE |
> +					       SNDRV_PCM_FMTBIT_S32_LE;
> +	}
> +
> +	return 0;
> +}
>   
>   static const struct snd_soc_component_driver omap_mcbsp_component = {
>   	.name		= "omap-mcbsp",
> @@ -1404,18 +1435,17 @@ static int asoc_mcbsp_probe(struct platform_device *pdev)
>   	mcbsp->dev = &pdev->dev;
>   	platform_set_drvdata(pdev, mcbsp);
>   
> -	ret = omap_mcbsp_init(pdev);
> +	ret = omap_mcbsp_init_dais(mcbsp);
>   	if (ret)
>   		return ret;
>   
> -	if (mcbsp->pdata->reg_size == 2) {
> -		omap_mcbsp_dai.playback.formats = SNDRV_PCM_FMTBIT_S16_LE;
> -		omap_mcbsp_dai.capture.formats = SNDRV_PCM_FMTBIT_S16_LE;
> -	}
> +	ret = omap_mcbsp_init(pdev);
> +	if (ret)
> +		return ret;
>   
>   	ret = devm_snd_soc_register_component(&pdev->dev,
>   					      &omap_mcbsp_component,
> -					      &omap_mcbsp_dai, 1);
> +					      mcbsp->dais, mcbsp->dai_count);
>   	if (ret)
>   		return ret;
>   
> 

-- 
Péter

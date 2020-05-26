Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA7B1ABA7E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Apr 2020 09:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439745AbgDPH4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Apr 2020 03:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2440011AbgDPH4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 03:56:25 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 433E3C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 00:56:24 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id y24so3713362wma.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 00:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ulm6HXP6hdRkHQzW/BLmx++TLB4SCHFqhDCHGDLiv5k=;
        b=VCUgW+gvGSo/XCfIqo2sYI3PBbjb3wawnETBSCwGVfPCiqHKGOv3DPYvC1eL+jRpLt
         OeywBaxuHAlyazt97+Ff3g8Sq7DIzxIMjfcC4xCku9dfiNfTXm8Oo84NC5YMuNNdMdx7
         3fowegU2XrojDa5oIOLxE3D5zHJq2AN/yfPtZqshseVia0n4w6SyyTUGN1zgaWTobRNy
         ic140FiDKZCKRz79WZ+WkhVse+vyuAXAygWsoclijbqWjQvxrLlURtw+9s7dXcZM8u/m
         K6mJI3w4e84YnG29lpmarSFNCGD3uKRXaU9mBDutOBZPAyRvR4NMDhecfumiT1c+gQ2L
         dvow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ulm6HXP6hdRkHQzW/BLmx++TLB4SCHFqhDCHGDLiv5k=;
        b=H4bn0zP5x0Qk3oJFpUFA6rExZgKDMrEl6NgeyW0VKdYjkZmyejMxND8WIqUlMhUNq3
         lmqv+YFNLvakBRE3SSCP946OzlRvVQNxf9ee++pglV9LzVp8IvgmrKPFq7W+QY+0WjAX
         leXY2N8ed2JsJr30dLPctVD0FlVX5c4NPVma7fpcnI0QhWT4jE3NYXKd64f8ELcuJdLJ
         deR//0DJot6oPwfLiDL2+ReLU7Z/e9f2j563d0OJ49nfEoZloL8h5//53inGsW43I4ei
         IMR2s7YjtVJeTfnCmKHG8ofbbMkIYN28gB58a07DgQSBtLMfMOMrTGb3AuEjWTHmJi3v
         binA==
X-Gm-Message-State: AGi0PuZwyTqTb80fpu5l9I5A3U9IzlWAy29W7SDrWyPYWU+xHM5cuJlS
        vUoXTSwToIV1I1fAzUTGsujgbQ==
X-Google-Smtp-Source: APiQypIuyuTdkSr1XavGzGP+CH0F5J2V8jUq1iDBI93URi223iG8SPHxhzLzFDRV4YsUAnVC0qlN2w==
X-Received: by 2002:a1c:3d83:: with SMTP id k125mr3751097wma.177.1587023782932;
        Thu, 16 Apr 2020 00:56:22 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id s27sm17430055wra.94.2020.04.16.00.56.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Apr 2020 00:56:22 -0700 (PDT)
Subject: Re: [PATCH 02/11] ASoC: qcom: lpass: Add struct lpass_dai to store
 dai clocks pointer
To:     Ajit Pandey <ajitp@codeaurora.org>, alsa-devel@alsa-project.org,
        broonie@kernel.org, devicetree@vger.kernel.org,
        plai@codeaurora.org, bgoswami@codeaurora.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.com
References: <1586592171-31644-1-git-send-email-ajitp@codeaurora.org>
 <1586592171-31644-3-git-send-email-ajitp@codeaurora.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <3b6fb5bf-c580-a543-ab70-d08113193a34@linaro.org>
Date:   Thu, 16 Apr 2020 08:56:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1586592171-31644-3-git-send-email-ajitp@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/04/2020 09:02, Ajit Pandey wrote:
> lpass_dai will store clocks related to respective dai's and it will
> be initialized during probe based on variant clock names.
> 
> Signed-off-by: Ajit Pandey <ajitp@codeaurora.org>

I dont understand why do we need this change? What is the advantage of 
doing this way vs the existing one?


--srini

> ---
>   sound/soc/qcom/lpass-cpu.c | 89 ++++++++++++++++++++++++++--------------------
>   sound/soc/qcom/lpass.h     | 18 +++++-----
>   2 files changed, 61 insertions(+), 46 deletions(-)
> 
> diff --git a/sound/soc/qcom/lpass-cpu.c b/sound/soc/qcom/lpass-cpu.c
> index dbce7e9..492f27b 100644
> --- a/sound/soc/qcom/lpass-cpu.c
> +++ b/sound/soc/qcom/lpass-cpu.c
> @@ -23,13 +23,15 @@ static int lpass_cpu_daiops_set_sysclk(struct snd_soc_dai *dai, int clk_id,
>   		unsigned int freq, int dir)
>   {
>   	struct lpass_data *drvdata = snd_soc_dai_get_drvdata(dai);
> -	int ret;
> -
> -	ret = clk_set_rate(drvdata->mi2s_osr_clk[dai->driver->id], freq);
> -	if (ret)
> -		dev_err(dai->dev, "error setting mi2s osrclk to %u: %d\n",
> -			freq, ret);
> +	struct lpass_dai *dai_data = drvdata->dai_priv[dai->driver->id];
> +	int ret = 0;
>   
> +	if (dai_data->osr_clk != NULL) {
> +		ret = clk_set_rate(dai_data->osr_clk, freq);
> +		if (ret)
> +			dev_err(dai->dev, "error setting mi2s osrclk to %u:%d\n",
> +				freq, ret);
> +	}
>   	return ret;
>   }
>   
> @@ -37,18 +39,22 @@ static int lpass_cpu_daiops_startup(struct snd_pcm_substream *substream,
>   		struct snd_soc_dai *dai)
>   {
>   	struct lpass_data *drvdata = snd_soc_dai_get_drvdata(dai);
> +	struct lpass_dai *dai_data = drvdata->dai_priv[dai->driver->id];
>   	int ret;
>   
> -	ret = clk_prepare_enable(drvdata->mi2s_osr_clk[dai->driver->id]);
> -	if (ret) {
> -		dev_err(dai->dev, "error in enabling mi2s osr clk: %d\n", ret);
> -		return ret;
> +	if (dai_data->osr_clk != NULL) {
> +		ret = clk_prepare_enable(dai_data->osr_clk);
> +		if (ret) {
> +			dev_err(dai->dev,
> +				"error in enabling mi2s osr clk: %d\n", ret);
> +			return ret;
> +		}
>   	}
>   
> -	ret = clk_prepare_enable(drvdata->mi2s_bit_clk[dai->driver->id]);
> +	ret = clk_prepare_enable(dai_data->bit_clk);
>   	if (ret) {
>   		dev_err(dai->dev, "error in enabling mi2s bit clk: %d\n", ret);
> -		clk_disable_unprepare(drvdata->mi2s_osr_clk[dai->driver->id]);
> +		clk_disable_unprepare(dai_data->osr_clk);
>   		return ret;
>   	}
>   
> @@ -59,16 +65,18 @@ static void lpass_cpu_daiops_shutdown(struct snd_pcm_substream *substream,
>   		struct snd_soc_dai *dai)
>   {
>   	struct lpass_data *drvdata = snd_soc_dai_get_drvdata(dai);
> +	struct lpass_dai *dai_data = drvdata->dai_priv[dai->driver->id];
>   
> -	clk_disable_unprepare(drvdata->mi2s_bit_clk[dai->driver->id]);
> +	clk_disable_unprepare(dai_data->bit_clk);
>   
> -	clk_disable_unprepare(drvdata->mi2s_osr_clk[dai->driver->id]);
> +	clk_disable_unprepare(dai_data->osr_clk);
>   }
>   
>   static int lpass_cpu_daiops_hw_params(struct snd_pcm_substream *substream,
>   		struct snd_pcm_hw_params *params, struct snd_soc_dai *dai)
>   {
>   	struct lpass_data *drvdata = snd_soc_dai_get_drvdata(dai);
> +	struct lpass_dai *dai_data = drvdata->dai_priv[dai->driver->id];
>   	snd_pcm_format_t format = params_format(params);
>   	unsigned int channels = params_channels(params);
>   	unsigned int rate = params_rate(params);
> @@ -163,8 +171,7 @@ static int lpass_cpu_daiops_hw_params(struct snd_pcm_substream *substream,
>   		return ret;
>   	}
>   
> -	ret = clk_set_rate(drvdata->mi2s_bit_clk[dai->driver->id],
> -			   rate * bitwidth * 2);
> +	ret = clk_set_rate(dai_data->bit_clk, rate * bitwidth * 2);
>   	if (ret) {
>   		dev_err(dai->dev, "error setting mi2s bitclk to %u: %d\n",
>   			rate * bitwidth * 2, ret);
> @@ -413,6 +420,25 @@ static bool lpass_cpu_regmap_volatile(struct device *dev, unsigned int reg)
>   	.cache_type = REGCACHE_FLAT,
>   };
>   
> +static int lpass_init_dai_clocks(struct device *dev,
> +			   struct lpass_data *drvdata)
> +{
> +	struct lpass_dai *dai;
> +	struct lpass_variant *v = drvdata->variant;
> +	int i;
> +
> +	for (i = 0; i < v->num_dai; i++) {
> +
> +		dai = drvdata->dai_priv[i];
> +
> +		dai->osr_clk = devm_clk_get_optional(dev,
> +						     v->dai_osr_clk_names[i]);
> +		dai->bit_clk = devm_clk_get(dev, v->dai_bit_clk_names[i]);
> +	}
> +
> +	return 0;
> +}
> +
>   int asoc_qcom_lpass_cpu_platform_probe(struct platform_device *pdev)
>   {
>   	struct lpass_data *drvdata;
> @@ -421,7 +447,7 @@ int asoc_qcom_lpass_cpu_platform_probe(struct platform_device *pdev)
>   	struct lpass_variant *variant;
>   	struct device *dev = &pdev->dev;
>   	const struct of_device_id *match;
> -	int ret, i, dai_id;
> +	int ret, i;
>   
>   	dsp_of_node = of_parse_phandle(pdev->dev.of_node, "qcom,adsp", 0);
>   	if (dsp_of_node) {
> @@ -467,28 +493,15 @@ int asoc_qcom_lpass_cpu_platform_probe(struct platform_device *pdev)
>   		variant->init(pdev);
>   
>   	for (i = 0; i < variant->num_dai; i++) {
> -		dai_id = variant->dai_driver[i].id;
> -		drvdata->mi2s_osr_clk[dai_id] = devm_clk_get(&pdev->dev,
> -					     variant->dai_osr_clk_names[i]);
> -		if (IS_ERR(drvdata->mi2s_osr_clk[dai_id])) {
> -			dev_warn(&pdev->dev,
> -				"%s() error getting optional %s: %ld\n",
> -				__func__,
> -				variant->dai_osr_clk_names[i],
> -				PTR_ERR(drvdata->mi2s_osr_clk[dai_id]));
> -
> -			drvdata->mi2s_osr_clk[dai_id] = NULL;
> -		}
> +		drvdata->dai_priv[i] = devm_kzalloc(dev,
> +						sizeof(struct lpass_dai),
> +						GFP_KERNEL);
> +	}
>   
> -		drvdata->mi2s_bit_clk[dai_id] = devm_clk_get(&pdev->dev,
> -						variant->dai_bit_clk_names[i]);
> -		if (IS_ERR(drvdata->mi2s_bit_clk[dai_id])) {
> -			dev_err(&pdev->dev,
> -				"error getting %s: %ld\n",
> -				variant->dai_bit_clk_names[i],
> -				PTR_ERR(drvdata->mi2s_bit_clk[dai_id]));
> -			return PTR_ERR(drvdata->mi2s_bit_clk[dai_id]);
> -		}
> +	ret = lpass_init_dai_clocks(dev, drvdata);
> +	if (ret) {
> +		dev_err(&pdev->dev, "error intializing dai clock: %d\n", ret);
> +		return ret;
>   	}
>   
>   	drvdata->ahbix_clk = devm_clk_get(&pdev->dev, "ahbix-clk");
> diff --git a/sound/soc/qcom/lpass.h b/sound/soc/qcom/lpass.h
> index 17113d3..b729686 100644
> --- a/sound/soc/qcom/lpass.h
> +++ b/sound/soc/qcom/lpass.h
> @@ -13,9 +13,14 @@
>   #include <linux/platform_device.h>
>   #include <linux/regmap.h>
>   
> -#define LPASS_AHBIX_CLOCK_FREQUENCY		131072000
> -#define LPASS_MAX_MI2S_PORTS			(8)
> -#define LPASS_MAX_DMA_CHANNELS			(8)
> +#define LPASS_AHBIX_CLOCK_FREQUENCY            131072000
> +#define LPASS_MAX_MI2S_PORTS                   (8)
> +#define LPASS_MAX_DMA_CHANNELS                 (8)
> +
> +struct lpass_dai {
> +	struct clk *osr_clk;
> +	struct clk *bit_clk;
> +};
>   
>   /* Both the CPU DAI and platform drivers will access this data */
>   struct lpass_data {
> @@ -23,11 +28,8 @@ struct lpass_data {
>   	/* AHB-I/X bus clocks inside the low-power audio subsystem (LPASS) */
>   	struct clk *ahbix_clk;
>   
> -	/* MI2S system clock */
> -	struct clk *mi2s_osr_clk[LPASS_MAX_MI2S_PORTS];
> -
> -	/* MI2S bit clock (derived from system clock by a divider */
> -	struct clk *mi2s_bit_clk[LPASS_MAX_MI2S_PORTS];
> +	/* MI2S dai specific configuration */
> +	struct lpass_dai *dai_priv[LPASS_MAX_MI2S_PORTS];
>   
>   	/* low-power audio interface (LPAIF) registers */
>   	void __iomem *lpaif;
> 

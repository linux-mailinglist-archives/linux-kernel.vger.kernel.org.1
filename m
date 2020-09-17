Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0411026D0E0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 03:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgIQBxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 21:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgIQBxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 21:53:01 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B733C061756
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 18:53:01 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id d13so418818pgl.6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 18:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HptUpY5ZPADmDsSUpnGfz+yVn/Le7O8Q8dkxi5ZCrro=;
        b=QaaDzjuN6yqg0oJMsY/Y8x631w+CTfJ4VNFORoGX9SW+khthjq4WzrPjaGfPtnq++e
         IofEvC/PRtKxxjc96qjz5bDiR8kJ60bw1cx9fLbSRX+s0hny8xYMUQu/ddhSQN2W0ehg
         Eu5u7ZDFSD/PpoxmOQFGa7FGDbFe3m+xkHDN2LonWO+/jepBGo/3QE9DGlz7XjBMikLQ
         9EmlNDFnKCzM1DBC2FhcRh2IOsK3RoPXdONnJIlA3axHKclhC1ad1psBqAmgwC54f+Pf
         wZ8jHySqSd1npPylBy3OXSZdkD37m2RKIgragrm2n3kGDG01GLix9bICsEdHu7tIYibm
         RBKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HptUpY5ZPADmDsSUpnGfz+yVn/Le7O8Q8dkxi5ZCrro=;
        b=GbWFAQnXAgELvlEagYuE93Xb4trlhNVX5v3kHOWVPp1XMvypNGC19qsVDcauWpHzUz
         dQiXNtN2Q5KTIZvRgirmqJe2cRyA2S5D6qD/pCPHeuBTFsBQ7jz5LxXrKwczyAjBB437
         vG0CkBZC90yKlqmGkMlWd9xUv7NdjQB2xXLVFmIpz1TTm9waHJjATU+eWxPWmq3f1tqz
         XgEWj7r7+MxJiuIi89zJfuAsaVMWzuZX9P5K9hUXSk0J9caj9YSFfbn4pozXQqo2f93L
         Ji8Gf+Hpxcy5EbWH4pNmIdp1iQQtkZ3JdeHcqBKCJyCMQqT0YQN3g7vTQFfIbhx1yJWc
         +Mag==
X-Gm-Message-State: AOAM532y/lVxESpO0GVE+c08W5yKC189u0r/iKp3kIL+XjSlFYFIoRXl
        EIDkZqAQgM//dElOyebiTOI=
X-Google-Smtp-Source: ABdhPJx+w+YmbG8KZTbXzCyyEZZW96lMymsa7Uwppk+tAqf+WdxJ6BKWfJGYZi9hjgXeMN4Kh0mOHw==
X-Received: by 2002:a63:595a:: with SMTP id j26mr21319515pgm.406.1600307580770;
        Wed, 16 Sep 2020 18:53:00 -0700 (PDT)
Received: from Asurada-Nvidia (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id g21sm18500564pfh.30.2020.09.16.18.53.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Sep 2020 18:53:00 -0700 (PDT)
Date:   Wed, 16 Sep 2020 18:49:49 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     timur@kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, lgirdwood@gmail.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] ASoC: fsl_sai: Add fsl_sai_check_version function
Message-ID: <20200917014949.GC22566@Asurada-Nvidia>
References: <1600251387-1863-1-git-send-email-shengjiu.wang@nxp.com>
 <1600251387-1863-3-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1600251387-1863-3-git-send-email-shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 16, 2020 at 06:16:26PM +0800, Shengjiu Wang wrote:
> fsl_sai_check_version can help to parse the version info
> in VERID and PARAM registers.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

> ---
>  sound/soc/fsl/fsl_sai.c | 47 +++++++++++++++++++++++++++++++++++++++++
>  sound/soc/fsl/fsl_sai.h | 28 ++++++++++++++++++++++++
>  2 files changed, 75 insertions(+)
> 
> diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> index 24ca528ca2be..738b4dda7847 100644
> --- a/sound/soc/fsl/fsl_sai.c
> +++ b/sound/soc/fsl/fsl_sai.c
> @@ -946,6 +946,48 @@ static struct regmap_config fsl_sai_regmap_config = {
>  	.cache_type = REGCACHE_FLAT,
>  };
>  
> +static int fsl_sai_check_version(struct device *dev)
> +{
> +	struct fsl_sai *sai = dev_get_drvdata(dev);
> +	unsigned char ofs = sai->soc_data->reg_offset;
> +	unsigned int val;
> +	int ret;
> +
> +	if (FSL_SAI_TCSR(ofs) == FSL_SAI_VERID)
> +		return 0;
> +
> +	ret = regmap_read(sai->regmap, FSL_SAI_VERID, &val);
> +	if (ret < 0)
> +		return ret;
> +
> +	dev_dbg(dev, "VERID: 0x%016X\n", val);
> +
> +	sai->verid.major = (val & FSL_SAI_VERID_MAJOR_MASK) >>
> +			   FSL_SAI_VERID_MAJOR_SHIFT;
> +	sai->verid.minor = (val & FSL_SAI_VERID_MINOR_MASK) >>
> +			   FSL_SAI_VERID_MINOR_SHIFT;
> +	sai->verid.feature = val & FSL_SAI_VERID_FEATURE_MASK;
> +
> +	ret = regmap_read(sai->regmap, FSL_SAI_PARAM, &val);
> +	if (ret < 0)
> +		return ret;
> +
> +	dev_dbg(dev, "PARAM: 0x%016X\n", val);
> +
> +	/* Max slots per frame, power of 2 */
> +	sai->param.slot_num = 1 <<
> +		((val & FSL_SAI_PARAM_SPF_MASK) >> FSL_SAI_PARAM_SPF_SHIFT);
> +
> +	/* Words per fifo, power of 2 */
> +	sai->param.fifo_depth = 1 <<
> +		((val & FSL_SAI_PARAM_WPF_MASK) >> FSL_SAI_PARAM_WPF_SHIFT);
> +
> +	/* Number of datalines implemented */
> +	sai->param.dataline = val & FSL_SAI_PARAM_DLN_MASK;
> +
> +	return 0;
> +}
> +
>  static int fsl_sai_probe(struct platform_device *pdev)
>  {
>  	struct device_node *np = pdev->dev.of_node;
> @@ -1070,6 +1112,11 @@ static int fsl_sai_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, sai);
>  
> +	/* Get sai version */
> +	ret = fsl_sai_check_version(&pdev->dev);
> +	if (ret < 0)
> +		dev_warn(&pdev->dev, "Error reading SAI version: %d\n", ret);
> +
>  	pm_runtime_enable(&pdev->dev);
>  	regcache_cache_only(sai->regmap, true);
>  
> diff --git a/sound/soc/fsl/fsl_sai.h b/sound/soc/fsl/fsl_sai.h
> index d16fc4241f41..ba7425a9e217 100644
> --- a/sound/soc/fsl/fsl_sai.h
> +++ b/sound/soc/fsl/fsl_sai.h
> @@ -223,6 +223,32 @@ struct fsl_sai_soc_data {
>  	unsigned int reg_offset;
>  };
>  
> +/**
> + * struct fsl_sai_verid - version id data
> + * @major: major version number
> + * @minor: minor version number
> + * @feature: feature specification number
> + *           0000000000000000b - Standard feature set
> + *           0000000000000000b - Standard feature set
> + */
> +struct fsl_sai_verid {
> +	u32 major;
> +	u32 minor;
> +	u32 feature;
> +};
> +
> +/**
> + * struct fsl_sai_param - parameter data
> + * @slot_num: The maximum number of slots per frame
> + * @fifo_depth: The number of words in each FIFO (depth)
> + * @dataline: The number of datalines implemented
> + */
> +struct fsl_sai_param {
> +	u32 slot_num;
> +	u32 fifo_depth;
> +	u32 dataline;
> +};
> +
>  struct fsl_sai {
>  	struct platform_device *pdev;
>  	struct regmap *regmap;
> @@ -243,6 +269,8 @@ struct fsl_sai {
>  	const struct fsl_sai_soc_data *soc_data;
>  	struct snd_dmaengine_dai_dma_data dma_params_rx;
>  	struct snd_dmaengine_dai_dma_data dma_params_tx;
> +	struct fsl_sai_verid verid;
> +	struct fsl_sai_param param;
>  };
>  
>  #define TX 1
> -- 
> 2.27.0
> 

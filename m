Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5AD26A0D2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 10:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbgIOI0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 04:26:09 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:5171 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbgIOI0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 04:26:05 -0400
X-Originating-IP: 90.65.88.165
Received: from localhost (lfbn-lyo-1-1908-165.w90-65.abo.wanadoo.fr [90.65.88.165])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 57203240008;
        Tue, 15 Sep 2020 08:26:02 +0000 (UTC)
Date:   Tue, 15 Sep 2020 10:26:02 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 3/3] ASoC: tlv320aic32x4: Enable fast charge
Message-ID: <20200915082602.GH4230@piout.net>
References: <20200911173140.29984-1-miquel.raynal@bootlin.com>
 <20200911173140.29984-4-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200911173140.29984-4-miquel.raynal@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/09/2020 19:31:40+0200, Miquel Raynal wrote:
> At power-up the analog circuits may take up to one full second before
> being charged with the default configuration. Using the analog blocks
> before they are ready generates a *very* crappy sound.
> 
> Enable the fast charge feature, which will require a bit more power
> than normal charge but will definitely speed up the starting operation
> by shrinking this delay to up to 40 ms.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  sound/soc/codecs/tlv320aic32x4.c | 8 ++++++++
>  sound/soc/codecs/tlv320aic32x4.h | 7 +++++++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/sound/soc/codecs/tlv320aic32x4.c b/sound/soc/codecs/tlv320aic32x4.c
> index 7a1ffbaf48be..5fb8ba109bc9 100644
> --- a/sound/soc/codecs/tlv320aic32x4.c
> +++ b/sound/soc/codecs/tlv320aic32x4.c
> @@ -1009,6 +1009,14 @@ static int aic32x4_component_probe(struct snd_soc_component *component)
>  				AIC32X4_LADC_EN | AIC32X4_RADC_EN);
>  	snd_soc_component_write(component, AIC32X4_ADCSETUP, tmp_reg);
>  
> +	/*
> +	 * Enable the fast charging feature and ensure the needed 40ms ellapsed
> +	 * before using the analog circuits.
> +	 */
> +	snd_soc_component_write(component, AIC32X4_REFPOWERUP,
> +				AIC32X4_REFPOWERUP_40MS);
> +	msleep(40);
> +

Maybe the actual REFPOWERUP value could be exposed as a control so
userspace has a way to set the policy? 

I'm not sure it make sense to have the delay in probe because it is not
enable the analog part of the codec. The delay should probable be after
the clocks have been set up because the datasheet says that it is mdac
and madc that is starting the analog circuitry.

>  	return 0;
>  }
>  
> diff --git a/sound/soc/codecs/tlv320aic32x4.h b/sound/soc/codecs/tlv320aic32x4.h
> index 38f47704bb75..7550122e9f8a 100644
> --- a/sound/soc/codecs/tlv320aic32x4.h
> +++ b/sound/soc/codecs/tlv320aic32x4.h
> @@ -96,6 +96,7 @@ int aic32x4_register_clocks(struct device *dev, const char *mclk_name);
>  #define AIC32X4_FLOATINGINPUT	AIC32X4_REG(1, 58)
>  #define AIC32X4_LMICPGAVOL	AIC32X4_REG(1, 59)
>  #define AIC32X4_RMICPGAVOL	AIC32X4_REG(1, 60)
> +#define AIC32X4_REFPOWERUP	AIC32X4_REG(1, 123)
>  
>  /* Bits, masks, and shifts */
>  
> @@ -205,6 +206,12 @@ int aic32x4_register_clocks(struct device *dev, const char *mclk_name);
>  #define AIC32X4_RMICPGANIN_IN1L_10K	0x10
>  #define AIC32X4_RMICPGANIN_CM1R_10K	0x40
>  
> +/* AIC32X4_REFPOWERUP */
> +#define AIC32X4_REFPOWERUP_SLOW		0x04
> +#define AIC32X4_REFPOWERUP_40MS		0x05
> +#define AIC32X4_REFPOWERUP_80MS		0x06
> +#define AIC32X4_REFPOWERUP_120MS	0x07
> +
>  /* Common mask and enable for all of the dividers */
>  #define AIC32X4_DIVEN           BIT(7)
>  #define AIC32X4_DIV_MASK        GENMASK(6, 0)
> -- 
> 2.20.1
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

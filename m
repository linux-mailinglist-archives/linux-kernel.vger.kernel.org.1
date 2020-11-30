Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9322A2C9062
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 22:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387871AbgK3V5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 16:57:53 -0500
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:53773 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387576AbgK3V5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 16:57:52 -0500
X-Originating-IP: 86.194.74.19
Received: from localhost (lfbn-lyo-1-997-19.w86-194.abo.wanadoo.fr [86.194.74.19])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id B5ACD40002;
        Mon, 30 Nov 2020 21:57:10 +0000 (UTC)
Date:   Mon, 30 Nov 2020 22:57:10 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: adau1372: add missing dependencies
Message-ID: <20201130215710.GV1296649@piout.net>
References: <20201130215626.2400999-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201130215626.2400999-1-alexandre.belloni@bootlin.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/11/2020 22:56:26+0100, Alexandre Belloni wrote:
> SND_SOC_ADAU1372_I2C and SND_SOC_ADAU1372_SPI prpoerly select the REGMAP
> config they need but forget to depend on the underlying bus.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

I forgot:

Reported-by: kernel test robot <lkp@intel.com>

> ---
>  sound/soc/codecs/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
> index a457300f95da..625f762903ea 100644
> --- a/sound/soc/codecs/Kconfig
> +++ b/sound/soc/codecs/Kconfig
> @@ -371,11 +371,13 @@ config SND_SOC_ADAU1372
>  
>  config SND_SOC_ADAU1372_I2C
>  	tristate "Analog Devices ADAU1372 CODEC (I2C)"
> +	depends on I2C
>  	select SND_SOC_ADAU1372
>  	select REGMAP_I2C
>  
>  config SND_SOC_ADAU1372_SPI
>  	tristate "Analog Devices ADAU1372 CODEC (SPI)"
> +	depends on SPI
>  	select SND_SOC_ADAU1372
>  	select REGMAP_SPI
>  
> -- 
> 2.28.0
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

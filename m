Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44ECE29D672
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:15:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730787AbgJ1WPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:15:11 -0400
Received: from mslow2.mail.gandi.net ([217.70.178.242]:48912 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730978AbgJ1WO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:14:58 -0400
Received: from relay1-d.mail.gandi.net (unknown [217.70.183.193])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id 20EC53A33EE
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 20:34:48 +0000 (UTC)
X-Originating-IP: 86.194.74.19
Received: from localhost (lfbn-lyo-1-997-19.w86-194.abo.wanadoo.fr [86.194.74.19])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id AD130240003;
        Wed, 28 Oct 2020 20:34:26 +0000 (UTC)
Date:   Wed, 28 Oct 2020 21:34:26 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Eugen Hristev <eugen.hristev@microchip.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        nicolas.ferre@microchip.com, ludovic.desroches@microchip.com
Subject: Re: [PATCH] ARM: configs: at91: sama5: resync with media changes
Message-ID: <20201028203426.GG12276@piout.net>
References: <20201016075109.287506-1-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201016075109.287506-1-eugen.hristev@microchip.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 16/10/2020 10:51:09+0300, Eugen Hristev wrote:
> The media tree Kconfig has changed recently, and a lot of modules were
> built unintentionally, like the dvb frontends and encoders.
> Resync the defconfig to build the sama5 drivers and tested sensors.
> 

Isn't at91_defconfig also affected? I didn't know which sensors you
wanted to keep so I didn't do this cleanup. I guess only what is tested
with sam9x60 is relevant now.

> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> ---
>  arch/arm/configs/sama5_defconfig | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm/configs/sama5_defconfig b/arch/arm/configs/sama5_defconfig
> index 037d3a718a60..2c8a621a8f1f 100644
> --- a/arch/arm/configs/sama5_defconfig
> +++ b/arch/arm/configs/sama5_defconfig
> @@ -153,9 +153,18 @@ CONFIG_REGULATOR_ACT8945A=y
>  CONFIG_REGULATOR_MCP16502=m
>  CONFIG_REGULATOR_PWM=m
>  CONFIG_MEDIA_SUPPORT=y
> +CONFIG_MEDIA_SUPPORT_FILTER=y
> +# CONFIG_MEDIA_SUBDRV_AUTOSELECT is not set
>  CONFIG_MEDIA_CAMERA_SUPPORT=y
> +CONFIG_MEDIA_PLATFORM_SUPPORT=y
>  CONFIG_V4L_PLATFORM_DRIVERS=y
> +CONFIG_VIDEO_ATMEL_ISC=y
>  CONFIG_VIDEO_ATMEL_ISI=y
> +CONFIG_VIDEO_OV2640=m
> +CONFIG_VIDEO_OV5640=m
> +CONFIG_VIDEO_OV7670=m
> +CONFIG_VIDEO_OV7740=m
> +CONFIG_VIDEO_MT9V032=m
>  CONFIG_DRM=y
>  CONFIG_DRM_ATMEL_HLCDC=y
>  CONFIG_DRM_PANEL_SIMPLE=y
> -- 
> 2.25.1
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

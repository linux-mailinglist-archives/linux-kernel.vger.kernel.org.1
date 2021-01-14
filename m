Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3E502F5C32
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 09:12:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbhANIJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 03:09:39 -0500
Received: from smtpweb146.aruba.it ([62.149.158.146]:45873 "EHLO
        smtpweb146.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727377AbhANIJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 03:09:34 -0500
X-Greylist: delayed 570 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Jan 2021 03:09:34 EST
Received: from [192.168.1.184] ([79.10.42.7])
        by Aruba Outgoing Smtp  with ESMTPA
        id zxWnkhIPa5BgLzxWnkSPzT; Thu, 14 Jan 2021 08:58:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1610611128; bh=Rgd6zs9jBI4RaCIuGbuEUvq7+uJ588fkUWgOYTT3LZI=;
        h=Subject:To:From:Date:MIME-Version:Content-Type;
        b=EQp4nMTDbE7S70XFNLXWHAjMsmPeRpE14xdXU/P8ZstpO88UY3ffDXkcTxOwzyCTW
         gIYhfldV40TDHEl1pqBoXx8WDHTEIU/+iSBBLjz2xIhx0fcs9sKO8cOLT04B3fnaOw
         KiImq0JmRcH53iKsed+jc9slKsjOJdkNLn/jmirGlUjvBFnAnvITP28ZVejqRvSBUr
         GnxaAfJVPJZoIvOX/kLH9W6aEJg2OBcyPX+NUicg5zId3cindTklr3k9L3B531wix1
         T19vSw/7aPIsx8g5/79N4fmxdanZfrKxmqTNblqg/F7IqM/dqcJ2jq9exikQIghzpW
         WM9twBnmg1zUw==
Subject: Re: [PATCH v5] drm/sun4i: tcon: fix inverted DCLK polarity
To:     Giulio Benetti <giulio.benetti@benettiengineering.com>,
        Maxime Ripard <maxime@cerno.tech>
Cc:     wens@csie.org, daniel@ffwll.ch, airlied@linux.ie,
        treding@nvidia.com, Jernej Skrabec <jernej.skrabec@siol.net>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Giulio Benetti <giulio.benetti@micronovasrl.com>
References: <20210113104725.770459-1-giulio.benetti@benettiengineering.com>
 <20210113160526.928766-1-giulio.benetti@benettiengineering.com>
From:   Marjan Pascolo <marjan.pascolo@trexom.it>
Message-ID: <d244aa6b-00b7-d768-83cb-e5a228b7ee08@trexom.it>
Date:   Thu, 14 Jan 2021 08:58:44 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210113160526.928766-1-giulio.benetti@benettiengineering.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: it
X-CMAE-Envelope: MS4wfLhZtaxuk1is0TviLubUDK7iLG3VsdjeGut0x/doPPt8TCZzu0LzNW+3DIn7dZLIt3Nz49HXwQ3gSEQYI0vPZuQGhCtRnz+poXmT2Xs75p8h0xqeZrI9
 bBUYq9sKoyRSu5lVEc0jEcflHwVCDtlOToHrqOWORfgKpFh7sPJh2sxl1XdjeH6pZoqimK92An4eV0Nfz7r4w5DU12K34ji8R+oA/TB6jIYiuDxHQU2bLw4m
 3Ta4zmo4NJL7ncSSpKlt9VFkkCtkub3NuFRlo1Mon0VANgIA+VArbX+GHTV4mTrcCV0282w8JsuylVD3+Xhj1b9pKQP5avsaFNYRazJncvpTGBfXm8sq1wv7
 7OILg7KZjzFUUFWP4sBuYZbl2ckATI0i68VF9k1gFtG6hM6+yYh5sLusVPORGXImhZBaurf+E89ZHszPRS1DZmEP3XtSrIV/8PByxPXn0xUTzuCifnDKMaEx
 GE3Jt1/zR7Mbh8TMDTy+4hJeG2v3QBGL21Ik/aVJWsnrQZQzC6YINKUNteZRFWsD0OQwwlU4w2hNO2lL
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Giulio,

You did a typo

Il 13/01/2021 17:05, Giulio Benetti ha scritto:
> From: Giulio Benetti <giulio.benetti@micronovasrl.com>
>
> During commit 88bc4178568b ("drm: Use new
> DRM_BUS_FLAG_*_(DRIVE|SAMPLE)_(POS|NEG)EDGE flags") DRM_BUS_FLAG_*
> macros have been changed to avoid ambiguity but just because of this
> ambiguity previous DRM_BUS_FLAG_PIXDATA_(POS/NEG)EDGE were used meaning
> _SAMPLE_ not _DRIVE_. This leads to DLCK inversion and need to fix but
> instead of swapping phase values, let's adopt an easier approach Maxime
> suggested:
> It turned out that bit 26 of SUN4I_TCON0_IO_POL_REG is dedicated to
> invert DCLK polarity and this makes things really easier than before. So
> let's handle DCLK polarity by adding SUN4I_TCON0_IO_POL_DCLK_DRIVE_NEGEDGE
> as bit 26 and activating according to bus_flags the same way it is done
> for all the other signals polarity.
>
> Fixes: 88bc4178568b ("drm: Use new DRM_BUS_FLAG_*_(DRIVE|SAMPLE)_(POS|NEG)EDGE flags")
> Suggested-by: Maxime Ripard <maxime@cerno.tech>
> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
> ---
> V2->V3:
> - squash 2 patches into 1
> V3->V4:
> - add SUN4I_TCON0_IO_POL_DCLK_POSITIVE to regmap_update_bits()
> V4->V5:
> polarity is still wrong so:
> - let's use SUN4I_TCON0_IO_POL_DCLK_DRIVE_NEGEDGE macro
>    instead of _DCLK_POSITIVE(that would make sense only in realtion with DCLK)
> - invert condition using _NEGEDGE instead of _POSEDGE and then matching with
>    register bit SUN4I_TCON0_IO_POL_DCLK_DRIVE_NEGEDGE
> - correct commit log according to V4->V5 changes
> ---
>   drivers/gpu/drm/sun4i/sun4i_tcon.c | 21 ++-------------------
>   drivers/gpu/drm/sun4i/sun4i_tcon.h |  1 +
>   2 files changed, 3 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> index eaaf5d70e352..c172ccfff7e5 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> @@ -569,30 +569,13 @@ static void sun4i_tcon0_mode_set_rgb(struct sun4i_tcon *tcon,
>   	if (info->bus_flags & DRM_BUS_FLAG_DE_LOW)
>   		val |= SUN4I_TCON0_IO_POL_DE_NEGATIVE;
>   
> -	/*
> -	 * On A20 and similar SoCs, the only way to achieve Positive Edge
> -	 * (Rising Edge), is setting dclk clock phase to 2/3(240°).
> -	 * By default TCON works in Negative Edge(Falling Edge),
> -	 * this is why phase is set to 0 in that case.
> -	 * Unfortunately there's no way to logically invert dclk through
> -	 * IO_POL register.
> -	 * The only acceptable way to work, triple checked with scope,
> -	 * is using clock phase set to 0° for Negative Edge and set to 240°
> -	 * for Positive Edge.
> -	 * On A33 and similar SoCs there would be a 90° phase option,
> -	 * but it divides also dclk by 2.
> -	 * Following code is a way to avoid quirks all around TCON
> -	 * and DOTCLOCK drivers.
> -	 */
> -	if (info->bus_flags & DRM_BUS_FLAG_PIXDATA_DRIVE_POSEDGE)
> -		clk_set_phase(tcon->dclk, 240);
> -
>   	if (info->bus_flags & DRM_BUS_FLAG_PIXDATA_DRIVE_NEGEDGE)
> -		clk_set_phase(tcon->dclk, 0);
> +		val |= SUN4I_TCON0_IO_POL_DCLK_DRIVE_NEGEDGE;
>   
>   	regmap_update_bits(tcon->regs, SUN4I_TCON0_IO_POL_REG,
>   			   SUN4I_TCON0_IO_POL_HSYNC_POSITIVE |
>   			   SUN4I_TCON0_IO_POL_VSYNC_POSITIVE |
Here Below you missed an 'E'
> +			   SUN4I_TCON0_IO_POL_DCLK_DRIVE_NEGDGE |
>   			   SUN4I_TCON0_IO_POL_DE_NEGATIVE,
>   			   val);
>   
> diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.h b/drivers/gpu/drm/sun4i/sun4i_tcon.h
> index cfbf4e6c1679..c5ac1b02482c 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_tcon.h
> +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.h
> @@ -113,6 +113,7 @@
>   #define SUN4I_TCON0_IO_POL_REG			0x88
>   #define SUN4I_TCON0_IO_POL_DCLK_PHASE(phase)		((phase & 3) << 28)
>   #define SUN4I_TCON0_IO_POL_DE_NEGATIVE			BIT(27)
> +#define SUN4I_TCON0_IO_POL_DCLK_DRIVE_NEGEDGE		BIT(26)
>   #define SUN4I_TCON0_IO_POL_HSYNC_POSITIVE		BIT(25)
>   #define SUN4I_TCON0_IO_POL_VSYNC_POSITIVE		BIT(24)
>   

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8A52F606B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 12:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728456AbhANLmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 06:42:13 -0500
Received: from smtpweb147.aruba.it ([62.149.158.147]:44968 "EHLO
        smtpweb147.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726948AbhANLmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 06:42:12 -0500
Received: from [192.168.1.184] ([79.10.42.7])
        by Aruba Outgoing Smtp  with ESMTPA
        id 00zhlmCP65BgL00zilVupq; Thu, 14 Jan 2021 12:40:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1610624452; bh=5fQqfvw4DkWANFTt5ckFnOsldleYY7vSY0pJjS8pZDU=;
        h=Subject:To:From:Date:MIME-Version:Content-Type;
        b=ip+aYt1qggLYSmK3c2sbh8LUW/Nucij64rUPQGyTYzXAR6ITw/LE6xoftdOvK1BFn
         a6KFB0AEUzepiqp3F6BebnTAITOWDu5RysAlo49L9k1/XY4S7dm2dHxCHEBjyn/gW1
         WtvzJCjXSz2/2ZB1IimdZOgc4DAC63AZf0hOMvNKx9P8UBbMlgppJgfzCjtfeKN91s
         1u3s4QodU/ROl868SIPLq3/4/x2tNmofp3ZNtq7tBMgD4HAvc/VpqfGMqJnxBnpjH/
         PGWfUpYOYmqWUI920O6GKD1JiNj+PpXNQgecibF0LafXANIZddkTF1GgYp7sUAlz1Y
         N6rD/NJkGtu7g==
Subject: Re: [PATCH v6] drm/sun4i: tcon: fix inverted DCLK polarity
To:     Giulio Benetti <giulio.benetti@benettiengineering.com>,
        Maxime Ripard <maxime@cerno.tech>
Cc:     wens@csie.org, daniel@ffwll.ch, airlied@linux.ie,
        treding@nvidia.com, Jernej Skrabec <jernej.skrabec@siol.net>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Giulio Benetti <giulio.benetti@micronovasrl.com>
References: <d244aa6b-00b7-d768-83cb-e5a228b7ee08@trexom.it>
 <20210114081732.9386-1-giulio.benetti@benettiengineering.com>
From:   Marjan Pascolo <marjan.pascolo@trexom.it>
Message-ID: <08782c29-4988-8b8e-fbd2-61b9beff9fef@trexom.it>
Date:   Thu, 14 Jan 2021 12:40:49 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210114081732.9386-1-giulio.benetti@benettiengineering.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: it
X-CMAE-Envelope: MS4wfBVV2/iWGDhknf2LRCaTWYHc0JBSU+9FbBOzV8xo1c9IaZP6h0MQedJBMvbEL045NtestzcjSdSR2QaDGCw/d+/Y5OjyuRGE7NqkpLpAdHTT4QGs/FQu
 oAJ2p1vXfFyj8eZZ85HpydmmlVcGff2KC99Of4vyzOmgpwwp2I9Isi4Ur761XZmUv9xk6KDcS4MrJZy5TXaVzOSNQWK52uWGqXKMHHWEurHxf5SXYgnPkeBg
 ecSqKI/z/2abJHwwLEKkUJSB7kg5ujdPsLaEuSIO6Mk7cNFMfhVy5xU2cLkqlzOR/HE9lCo/oiVMvxgsXSZvdNW1nE6SLZDk21i3/QJhQzyPNkzsN26LdYEs
 av01kIWcpAikbGXS10un/VXrwgHx6KKxORU8mSgnz7K6aNbEwH4QD51DOX/YwG0oTD44YJr7nV3hRRPsUhW1UkeSgEeNQrVf1IVK5NS6V8pO1Amp3kLFpB8j
 T00PUHifcvBzKs5SZn//uiDXu+Y6l9bqTTWJsHupvhMUG3futlMa3S68UJhp/j/dl62YLHl+Wm6mOq8X
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Tested on a13 and works.

Here are results:

with DRIVE_NEGEDGE

https://pasteboard.co/JJAGDAy.jpg

https://pasteboard.co/JJAHDAj.jpg

with DRIVE_POSEDGE

https://pasteboard.co/JJAIbBf.jpg

https://pasteboard.co/JJAIGfo.jpg


Il 14/01/2021 09:17, Giulio Benetti ha scritto:
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

Tested-by: Marjan Pascolo <marjan.pascolo@trexom.it>
[Tested successfully with A13]

> ---
> V2->V3:
> - squash 2 patches into 1
> V3->V4:
> - add SUN4I_TCON0_IO_POL_DCLK_POSITIVE to regmap_update_bits() as suggested by Maxime
> V4->V5:
> polarity is still wrong so:
> - let's use SUN4I_TCON0_IO_POL_DCLK_DRIVE_NEGEDGE macro
>    instead of _DCLK_POSITIVE(that would make sense only in realtion with DCLK)
> - invert condition using _NEGEDGE instead of _POSEDGE and then matching with
>    register bit SUN4I_TCON0_IO_POL_DCLK_DRIVE_NEGEDGE
> - correct commit log according to V4->V5 changes
> V5->V6:
> - fix typo in SUN4I_TCON0_IO_POL_DCLK_DRIVE_NEGEDGE as suggested by Marjan
> ---
>   drivers/gpu/drm/sun4i/sun4i_tcon.c | 21 ++-------------------
>   drivers/gpu/drm/sun4i/sun4i_tcon.h |  1 +
>   2 files changed, 3 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> index eaaf5d70e352..6b9af4c08cd6 100644
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
> +			   SUN4I_TCON0_IO_POL_DCLK_DRIVE_NEGEDGE |
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

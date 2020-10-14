Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA7228E219
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 16:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgJNOTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 10:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbgJNOTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 10:19:51 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 646ECC0613D2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 07:19:51 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id e23so2464071wme.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 07:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ujYG5VF4LvrSV22lkx9qOMlIjb18yncwxkcr5GCM7hw=;
        b=Fye/mZ83y9B+0r+U9CJZ1waeayX+85FMlLHSc4+gTJWWZf4vBLP2YxZjSTBfzYBG8u
         8APzEnC430HqQz/llme76vMg8opmfPSROhfWmdUUgRVFP5yBpx4xlGeLcRaI5yoXYdkz
         5dzLed7XQ0dpRBNNDkzNdlSU9oKJDhO2qys/7oXsPla+LJdfvvjJF6hPB9SdlBPOXovk
         TmOGtJuIKFI4KHnsX1xLbC6gEPjK+oXdU8eSTh4nvZb2ThNHkeN207h50olGTuEFE5ax
         YavntgaTXvTtRdYN+fpGSbF9FWQHfY57Hr44ujNADGf3Y7GQB9kdlTGJ5ifZf3lFCToP
         ByJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ujYG5VF4LvrSV22lkx9qOMlIjb18yncwxkcr5GCM7hw=;
        b=plgtiONedC+y1H/0dxOmPLCrqB49BB+DBnuVFLiUWa/C+xexLZ2vqPFN6hROXBPM1e
         0HP1MCwIzugGlelZqAOo3VwVZ0S0Y6gK5sAeDzQHYmqQ6Q0N9hTENDOwSnNbQIui8d8o
         U7r5B0yXz5Mn37qf+tR0IxsezY6sl8LX/UDaXLT8kmL8K6MQ24PNmOrMFnHLWMkFo+Vt
         SFndQPqe/FnCd3OqF+zUGR56vlUs8CEeWu44Bg8NEyVDrnOCY+C0jx8eU4jf1+PAQdQk
         UJf9Vr+qgSnCD0kxSMNJRvboXHcipyuhF/6voYsbJsN7ki6RNo7xchkm9ul8DnJ6eVoA
         MZbg==
X-Gm-Message-State: AOAM532HeU/pj8LvcAAMsk9JcoeH4hFXjpe3tMayOgMtL31fqDZ06mBF
        4v88RIwpTR9FVzxQ5A4yXMDJhw==
X-Google-Smtp-Source: ABdhPJwhR5pVDkdV21ZSdeSLhJ7AM3WRmBim9XMCrehLjwtv0ScetmpTUZvdsADXzGFUQx3KVOD3YQ==
X-Received: by 2002:a1c:e1c2:: with SMTP id y185mr3557489wmg.81.1602685189944;
        Wed, 14 Oct 2020 07:19:49 -0700 (PDT)
Received: from holly.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id m14sm5155294wro.43.2020.10.14.07.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2020 07:19:49 -0700 (PDT)
Date:   Wed, 14 Oct 2020 15:19:46 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Alexandru Stan <amstan@chromium.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 2/3] ARM: dts: rockchip: veyron: Remove 0 point from
 brightness-levels
Message-ID: <20201014141946.mkrvpkrttucffkhj@holly.lan>
References: <20201013080103.410133-1-amstan@chromium.org>
 <20201013010056.v2.2.I96b8d872ec51171f19274e43e96cadc092881271@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201013010056.v2.2.I96b8d872ec51171f19274e43e96cadc092881271@changeid>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 13, 2020 at 01:01:02AM -0700, Alexandru Stan wrote:
> After the "PWM backlight interpolation adjustments" patches, the
> backlight interpolation works a little differently. The way these
> dts files were working before was relying on a bug (IMHO).
> 
> Remove the 0-3 range since otherwise we would have a 252 long
> interpolation that would slowly go between 0 and 3, looking really bad
> in userspace.
> 
> We don't need the 0% point, userspace seems to handle this just fine
> because it uses the bl_power property to turn off the display.
> 
> Signed-off-by: Alexandru Stan <amstan@chromium.org>

Acked-by: Daniel Thompson <daniel.thompson@linaro.org>

Note also shouldn't this be patch 1 of the set. AFAICT it makes sense
whether or not the interpolation algorithm is changed.


Daniel.

> ---
> 
>  arch/arm/boot/dts/rk3288-veyron-jaq.dts    | 2 +-
>  arch/arm/boot/dts/rk3288-veyron-minnie.dts | 2 +-
>  arch/arm/boot/dts/rk3288-veyron-tiger.dts  | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/rk3288-veyron-jaq.dts b/arch/arm/boot/dts/rk3288-veyron-jaq.dts
> index af77ab20586d..4a148cf1defc 100644
> --- a/arch/arm/boot/dts/rk3288-veyron-jaq.dts
> +++ b/arch/arm/boot/dts/rk3288-veyron-jaq.dts
> @@ -20,7 +20,7 @@ / {
>  
>  &backlight {
>  	/* Jaq panel PWM must be >= 3%, so start non-zero brightness at 8 */
> -	brightness-levels = <0 8 255>;
> +	brightness-levels = <8 255>;
>  	num-interpolated-steps = <247>;
>  };
>  
> diff --git a/arch/arm/boot/dts/rk3288-veyron-minnie.dts b/arch/arm/boot/dts/rk3288-veyron-minnie.dts
> index f8b69e0a16a0..82fc6fba9999 100644
> --- a/arch/arm/boot/dts/rk3288-veyron-minnie.dts
> +++ b/arch/arm/boot/dts/rk3288-veyron-minnie.dts
> @@ -39,7 +39,7 @@ volum_up {
>  
>  &backlight {
>  	/* Minnie panel PWM must be >= 1%, so start non-zero brightness at 3 */
> -	brightness-levels = <0 3 255>;
> +	brightness-levels = <3 255>;
>  	num-interpolated-steps = <252>;
>  };
>  
> diff --git a/arch/arm/boot/dts/rk3288-veyron-tiger.dts b/arch/arm/boot/dts/rk3288-veyron-tiger.dts
> index 069f0c2c1fdf..52a84cbe7a90 100644
> --- a/arch/arm/boot/dts/rk3288-veyron-tiger.dts
> +++ b/arch/arm/boot/dts/rk3288-veyron-tiger.dts
> @@ -23,7 +23,7 @@ / {
>  
>  &backlight {
>  	/* Tiger panel PWM must be >= 1%, so start non-zero brightness at 3 */
> -	brightness-levels = <0 3 255>;
> +	brightness-levels = <3 255>;
>  	num-interpolated-steps = <252>;
>  };
>  
> -- 
> 2.28.0
> 

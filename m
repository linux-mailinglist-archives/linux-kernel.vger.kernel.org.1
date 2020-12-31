Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 705CD2E7E98
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Dec 2020 08:28:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbgLaH2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Dec 2020 02:28:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbgLaH17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Dec 2020 02:27:59 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AEBCC061573
        for <linux-kernel@vger.kernel.org>; Wed, 30 Dec 2020 23:27:19 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id c79so10891846pfc.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Dec 2020 23:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=L3rchCgn60UXSNg/RkUXBGhv13ATR5wc8YM8fhcBkn4=;
        b=x4261brrKoUTmGEcVb8b6y4YuUMUAwI/WAJ6I3alcPunXupX7CbORvMgruLH8gs0G9
         GwtAdwg8P7p1mHxUw/4OjxCjrbB2Z6g0cRSNkwaHoeZLFAUmcIha8qokVnKxlGudDett
         NukWnXz3y8QOnK6oc4/j3OYiFTlktdT5Mt0cPNhPrgfxMQCi/6+N2kH9KDUFXU6XgX+s
         aYxuDapL2VXTwKbOY7j2bfYQsKO5xJ8fMXkC9iDdf2Wn2K+WiHAVzpNHAKfRvcILbixJ
         FxRUmWQgSOwAu5wVXBSHsjxxccz/qZU19+Esh9YYtfzQcMjhtI3eq5yp0tHQWs3XXBZ0
         F4ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=L3rchCgn60UXSNg/RkUXBGhv13ATR5wc8YM8fhcBkn4=;
        b=a4qxNulhNpdwKnBDNKJqEUd/TgSm2khbEnhllbMV+9mxS5QoTvliArlRuRD276S3I/
         ci4b8MvHybbz8woimVsjRUAOQWj8QLEGTXv6GLo8EJ/Puqswo7K2/gpyCwDUek9vgtZy
         jiz7p23KdMZaJiFuVnw+iONfAXC9XLV9UCyx6U1yun74s33tT7PCav+cc0YGF6/fsIXP
         cKuPpoX/vJmgyimD3kbC4zCowg4j/iRXqjAUo4TNuvwcg+YZR2tK/vr0ErWZ9HfWm7+F
         lcQUE7xZqN7EGa0PhMZRliXGiIsqpmEDAUZl3216BtxMqeBVYj8s5/cOIhyQohFRg6jn
         NxNw==
X-Gm-Message-State: AOAM532XatvAuVC6X+O9D5NGpinOYFqDHU74j0qKUDXFgC4e+1m/OIIM
        wsc9T1ugx804QFdFH/mu9U32
X-Google-Smtp-Source: ABdhPJyjSzd1B+plpmbHvjXcunIxJaD12PEru1NpFPYDBdpPKuhm2hQA1BpegeJ7YX2dsMxLKgqq+w==
X-Received: by 2002:a63:4559:: with SMTP id u25mr26577840pgk.306.1609399639035;
        Wed, 30 Dec 2020 23:27:19 -0800 (PST)
Received: from thinkpad ([2409:4072:6d1f:be3b:71a9:d2bf:a32d:897d])
        by smtp.gmail.com with ESMTPSA id j14sm9532596pjm.10.2020.12.30.23.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Dec 2020 23:27:18 -0800 (PST)
Date:   Thu, 31 Dec 2020 12:57:10 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 11/13] arm: dts: owl-s500-roseapplepi: Add uSD support
Message-ID: <20201231072710.GF7345@thinkpad>
References: <cover.1609263738.git.cristian.ciocaltea@gmail.com>
 <47ee9695e89198ec2fbc4ab6188f1d0ad0424b2f.1609263738.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47ee9695e89198ec2fbc4ab6188f1d0ad0424b2f.1609263738.git.cristian.ciocaltea@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 29, 2020 at 11:17:26PM +0200, Cristian Ciocaltea wrote:
> Add uSD support for RoseapplePi SBC using a fixed regulator as a
> temporary solution until PMIC support becomes available.
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
> Changes in v3:
>  - None
> 
>  arch/arm/boot/dts/owl-s500-roseapplepi.dts | 50 ++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/owl-s500-roseapplepi.dts b/arch/arm/boot/dts/owl-s500-roseapplepi.dts
> index 800edf5d2d12..fe9ae3619422 100644
> --- a/arch/arm/boot/dts/owl-s500-roseapplepi.dts
> +++ b/arch/arm/boot/dts/owl-s500-roseapplepi.dts
> @@ -14,6 +14,7 @@ / {
>  	model = "Roseapple Pi";
>  
>  	aliases {
> +		mmc0 = &mmc0;
>  		serial2 = &uart2;
>  	};
>  
> @@ -25,6 +26,55 @@ memory@0 {
>  		device_type = "memory";
>  		reg = <0x0 0x80000000>; /* 2GB */
>  	};
> +
> +	/* Fixed regulator used in the absence of PMIC */
> +	sd_vcc: sd-vcc {
> +		compatible = "regulator-fixed";
> +		regulator-name = "fixed-3.1V";
> +		regulator-min-microvolt = <3100000>;
> +		regulator-max-microvolt = <3100000>;
> +		regulator-always-on;
> +	};
> +};
> +
> +&pinctrl {
> +	mmc0_pins: mmc0-pins {
> +		pinmux {
> +			groups = "sd0_d0_mfp", "sd0_d1_mfp", "sd0_d2_d3_mfp",
> +				 "sd0_cmd_mfp", "sd0_clk_mfp";
> +			function = "sd0";
> +		};
> +
> +		drv-pinconf {
> +			groups = "sd0_d0_d3_drv", "sd0_cmd_drv", "sd0_clk_drv";
> +			drive-strength = <8>;
> +		};
> +
> +		bias0-pinconf {
> +			pins = "sd0_d0", "sd0_d1", "sd0_d2",
> +			       "sd0_d3", "sd0_cmd";
> +			bias-pull-up;
> +		};
> +
> +		bias1-pinconf {
> +			pins = "sd0_clk";
> +			bias-pull-down;
> +		};
> +	};
> +};
> +
> +/* uSD */
> +&mmc0 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mmc0_pins>;
> +	no-sdio;
> +	no-mmc;
> +	no-1-8-v;
> +	cd-gpios = <&pinctrl 117 GPIO_ACTIVE_LOW>;
> +	bus-width = <4>;
> +	vmmc-supply = <&sd_vcc>;
> +	vqmmc-supply = <&sd_vcc>;
>  };
>  
>  &twd_timer {
> -- 
> 2.30.0
> 

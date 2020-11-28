Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3002A2C718E
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Nov 2020 22:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390971AbgK1Vvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Nov 2020 16:51:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731532AbgK1Sw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Nov 2020 13:52:59 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A420C09427F
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 23:39:00 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id l17so6070553pgk.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 23:39:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=T/ekApRs2ogDKYVjCc+UT/3pDjFzfqmZDIBl/BKWSPM=;
        b=xHy6/9zWWW27cJCQ/JrkT6A3rb9sdjWrYUj6KxQIT4bKkVF+AmfMlotzD4qML5fpMW
         3tVKHRc83O91CqhhCGGP0Aui+1cVsBqCgVqvQouSXP061eTFUbTkKN2aWCWFFTie727H
         4Pry7nt3ZMSPQJpsV0XhMd9LvxiFUWf5qIiBilPDBKuETExgOtgkea69M/UF1W6zjdGU
         ELrd01YAl6H/DQXQiQwflTEvGqUowmlbWKfwvhCQfM5UwZjLcxTYoewxJ/BpIqn+yuWz
         EGcftacTmcBccSU7o73bGM/AvbTgJnbHemDlCbLfVjTtR7T+tamuH2eRdpUx/fMnKseQ
         y7DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=T/ekApRs2ogDKYVjCc+UT/3pDjFzfqmZDIBl/BKWSPM=;
        b=RbsL0WJ/e4PtnZTQo8vjENHwLGYKg8qFigSxzh3W3PMLZRJsLYRDM/CPPs3omvhODo
         W1sxB1D5Ea7al2TE1DhnqNB4WncknZNveEfbOxjUcsc/Zlzyq2NjA68+n6CJ8RJiIvG/
         7BTnUAaAV5uWYfBdNH2m15BjPdm/5dWO90gPSVgWdGY2o5elPYc2M4upJCUhm9grO37d
         UXY8ph7q1f5KJKDUWAzYv3PSWzAVtJBjFlEPefJjq4BEaFRUGyntyDRCWjBPZk3cpgw5
         1lFmFk398XCU1VUp1brH4NQTqSQCb2w5uzb0VXX/A7REwhIg3CEuwanSfeKTFRWKNirh
         Qn+g==
X-Gm-Message-State: AOAM533N0OvAoEETMvjUc1hgIDcX2KTMKLpTbn8FZ2Mjf+T5ougNqSxE
        zF3uNFHuc6updQ2jtGAF1q11fv6YFEzz
X-Google-Smtp-Source: ABdhPJwPU88NKoAJPxNC6799XCujY5nY8nwlbcFm7Prf8dvrO8TN+3L13C+OzCKf+2Cp2s8DefPzeg==
X-Received: by 2002:a17:90a:d495:: with SMTP id s21mr14233430pju.42.1606549139947;
        Fri, 27 Nov 2020 23:38:59 -0800 (PST)
Received: from thinkpad ([2409:4072:15:c612:48ab:f1cc:6b16:2820])
        by smtp.gmail.com with ESMTPSA id p15sm13569176pjg.21.2020.11.27.23.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 23:38:59 -0800 (PST)
Date:   Sat, 28 Nov 2020 13:08:51 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 16/18] arm: dts: owl-s500-roseapplepi: Add uSD support
Message-ID: <20201128073851.GC3077@thinkpad>
References: <cover.1605823502.git.cristian.ciocaltea@gmail.com>
 <cf62e297a18518d54dd887a0bc531b18a50da5c5.1605823502.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf62e297a18518d54dd887a0bc531b18a50da5c5.1605823502.git.cristian.ciocaltea@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 01:56:10AM +0200, Cristian Ciocaltea wrote:
> Add uSD support for RoseapplePi SBC using a fixed regulator as a
> temporary solution until PMIC support becomes available.
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> ---
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

Is this the exact name in the schematics?

Thanks,
Mani

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
> 2.29.2
> 

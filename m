Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 414132C7152
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Nov 2020 22:57:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403932AbgK1VxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Nov 2020 16:53:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733088AbgK1TFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Nov 2020 14:05:21 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB3CFC02B8DB
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 23:41:17 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id m9so6065796pgb.4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 23:41:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fiEKNoVjJnJUXQv73omVO0kLfIW0bUY/61VADsZy/nI=;
        b=eCQ0W7dX01bjSdwiLwo7VSutmcdYA/WYg3R59Lfh59MLvgAH/uwC57Mo8greSAjQNJ
         UAoWAmpfzgaj1GGBVwT7h4SWMMCecfYjtSOEcQJIKzsh5zh1LM3JeddqT4hdLz1zysPg
         Idi5pK98gJPgMM5coEZUhDa3SeGLuCZrQTblcgWjDRIQnWZ9kvHL4VU+YP0IjoeiZ9+E
         B+UCkS0JZsaaQbvM9jS9hsbfFj9ePjdry1IJZR6fLR73itjC4uzvOzOiIygHWrzoIxtx
         xFP4hdNY7szqbxnTbgL2AQxjI5Gw347yRVhcfQk4bN9iboCZtaZA0GixTmS9qFZCUV8n
         xqxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fiEKNoVjJnJUXQv73omVO0kLfIW0bUY/61VADsZy/nI=;
        b=cBX9Ix1tZkmY1hE6dz5B9Xk/NctZhDiLsZiXPKJMMBSQrnZkt9ED1YWykaJiAr7LUz
         0um1JTuZpc8KHKBd2of9YOkI5B+5080rW5S6tJX52gbHYYAXYLgNG2E3aVvV3Vs8OgQi
         QN+g38G5Ht9LrYg99TGxk1h+Rxd57Go7jrhiFY6wzhSuWq4svdJA+0nTmaloALPpE06k
         I/BGLr5yyHNKErRIee+o7pLU8KlvgYw0n4XVBYwqU6f4qhZLrZrD6dtXfHXEdStk3JJF
         rA20hg4TxMYepAYmhrSjx707xtq8L7NrXIUsXYNt+Gk0K/pkWAsrd0EE2ctCvb6f6Xa5
         cU9A==
X-Gm-Message-State: AOAM530NLgPTeL/BTSOR5BhIKMI2IQ9b3+Umr99z1vNuqAB9+up2MyRU
        z/MOu3wk9OoyN5FaIQyHulKM
X-Google-Smtp-Source: ABdhPJxqoZkRUVBdrARTuHH8eLsvzZgH4wa3wX3gt6FUglxdnv4nZr8gqiEHGuGnl5adYem9WJFv+Q==
X-Received: by 2002:a17:90b:438a:: with SMTP id in10mr14303785pjb.27.1606549277113;
        Fri, 27 Nov 2020 23:41:17 -0800 (PST)
Received: from thinkpad ([2409:4072:15:c612:48ab:f1cc:6b16:2820])
        by smtp.gmail.com with ESMTPSA id e23sm9700492pfd.64.2020.11.27.23.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 23:41:16 -0800 (PST)
Date:   Sat, 28 Nov 2020 13:11:08 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 17/18] arm: dts: owl-s500-roseapplepi: Add I2C pinctrl
 configuration
Message-ID: <20201128074108.GD3077@thinkpad>
References: <cover.1605823502.git.cristian.ciocaltea@gmail.com>
 <f41e33b12d77e75246fa94ed6acc57fffe84aaa4.1605823502.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f41e33b12d77e75246fa94ed6acc57fffe84aaa4.1605823502.git.cristian.ciocaltea@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 01:56:11AM +0200, Cristian Ciocaltea wrote:
> Add pinctrl definitions for the I2C controllers used in RoseapplePi SBC.
> For the moment enable only I2C0, which is used by the ATC2603C PMIC.
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>

Earlier we used to add "_default" suffix for the pin groups to
differentiate between active and sleep states. But I guess we can just
keep the suffix away until we hit usecase.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  arch/arm/boot/dts/owl-s500-roseapplepi.dts | 44 ++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/owl-s500-roseapplepi.dts b/arch/arm/boot/dts/owl-s500-roseapplepi.dts
> index fe9ae3619422..ff91561ca99c 100644
> --- a/arch/arm/boot/dts/owl-s500-roseapplepi.dts
> +++ b/arch/arm/boot/dts/owl-s500-roseapplepi.dts
> @@ -37,7 +37,51 @@ sd_vcc: sd-vcc {
>  	};
>  };
>  
> +&i2c0 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c0_pins>;
> +};
> +
> +&i2c1 {
> +	status = "disabled";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c1_pins>;
> +};
> +
> +&i2c2 {
> +	status = "disabled";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c2_pins>;
> +};
> +
>  &pinctrl {
> +	i2c0_pins: i2c0-pins {
> +		pinmux {
> +			groups = "i2c0_mfp";
> +			function = "i2c0";
> +		};
> +
> +		pinconf {
> +			pins = "i2c0_sclk", "i2c0_sdata";
> +			bias-pull-up;
> +		};
> +	};
> +
> +	i2c1_pins: i2c1-pins {
> +		pinconf {
> +			pins = "i2c1_sclk", "i2c1_sdata";
> +			bias-pull-up;
> +		};
> +	};
> +
> +	i2c2_pins: i2c2-pins {
> +		pinconf {
> +			pins = "i2c2_sclk", "i2c2_sdata";
> +			bias-pull-up;
> +		};
> +	};
> +
>  	mmc0_pins: mmc0-pins {
>  		pinmux {
>  			groups = "sd0_d0_mfp", "sd0_d1_mfp", "sd0_d2_d3_mfp",
> -- 
> 2.29.2
> 

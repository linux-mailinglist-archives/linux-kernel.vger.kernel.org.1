Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09FF5273B60
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 09:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729667AbgIVHEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 03:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729168AbgIVHEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 03:04:07 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D65C061755
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 00:04:07 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id k14so11173760pgi.9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 00:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YRpi9KwHALoKXKQSBhCBZZ06f6McWrPvpfammLbLT8k=;
        b=Vx4xa5YTBKUlMeIHTr3nUG0IcbX8yqVOQaPcvn8RIxMp1hyTKR1u8hm9kMvSOuyZ6V
         DzfQZgoxbcFyDF3t52mS/eLs+E7S6qThce7Gt2yc+mYETqAaoVpegKaRf8sUN7zAy6gV
         hwLSNv5idj6wgSIZB1yIOYoC91lK9gKAxKqG3Pdw90vTlj//h1YT60+ebH1AwyATN9sC
         k4pPnWXPMS5TmSwP0OGVZ7h378rUfe7aWSwaGaTCOtVTRckVv6UZYNQZ23tddKXNyb0G
         NTv8/F8v/rrZBu7fsUfPZUTTJn+8Au3MJyfuGnvALnIZHIRh/bG4W7k6WTemfdMFMArG
         kDqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YRpi9KwHALoKXKQSBhCBZZ06f6McWrPvpfammLbLT8k=;
        b=AUP6PFA5OIAguePuz1zlT4GVGvwb8GTndnrb/1pTuw0fuGMOdqrz4O3gz2jk6O0ITX
         MX9kGQXsMH/+cB8ih+3XytrIxTNTdSUZoogstSgEd/7a2sneLXHssdaRy+WYGePoMW/d
         DkJsDDg1SDF7KA+o72v94LIdMPZYAqXUH3GtWB28dVvwwVQaGfmLaH5hk1kbDE0MZYWK
         AJzV+BaFANae0prBfqqZJhSc4lUvDTKdpLg69r67WAQrd/2/lzrp14u77GCvl87JErEq
         AzOaSt8XeJJMO4RyPMc+NIOrEccRrWR4Wc/R9qJkugdQjL9cEunyoDdyPravQ+ISEt95
         HFcg==
X-Gm-Message-State: AOAM5329Xu31NGTgNnCsOVGtTr19RHo8b/oj3ZabG6M6Qu8vL5Xu/Yes
        faqxqulsq7UJ/RWF1XN/KEkN
X-Google-Smtp-Source: ABdhPJz6WA77oaxPRuROoCyX6vVBITEzYe90bgErw1k8pwMtDD7+wfNZ93rVhhxEneNx8PRzQwC5CQ==
X-Received: by 2002:a17:902:8e83:b029:d2:41d3:94e9 with SMTP id bg3-20020a1709028e83b02900d241d394e9mr1172015plb.75.1600758247230;
        Tue, 22 Sep 2020 00:04:07 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:6e1c:c062:1004:2ccf:6900:b97])
        by smtp.gmail.com with ESMTPSA id e2sm1412821pjm.27.2020.09.22.00.04.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Sep 2020 00:04:06 -0700 (PDT)
Date:   Tue, 22 Sep 2020 12:33:59 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Amit Singh Tomar <amittomer25@gmail.com>
Cc:     andre.przywara@arm.com, afaerber@suse.de, robh+dt@kernel.org,
        cristian.ciocaltea@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v7 10/10] arm64: dts: actions: Add uSD support for
 Cubieboard7
Message-ID: <20200922070359.GI29035@Mani-XPS-13-9360>
References: <1595180527-11320-1-git-send-email-amittomer25@gmail.com>
 <1595180527-11320-11-git-send-email-amittomer25@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1595180527-11320-11-git-send-email-amittomer25@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 19, 2020 at 11:12:07PM +0530, Amit Singh Tomar wrote:
> This commit adds uSD support for Cubieboard7 board based on Actions Semi
> S700 SoC. SD0 is connected to uSD slot. Since there is no PMIC support
> added yet, fixed regulator has been used as a regulator node.
> 
> Signed-off-by: Amit Singh Tomar <amittomer25@gmail.com>

Not applying this one! Please post it in next revision.

Thanks,
Mani

> ---
> Changes since v6:
> 	* Brought back the uSD fixed regulator.
> Changes since v5:
>         * Removed the Fixed regulators as these are
>           not needed.
> Changes since v4:
>         * No change.
> Changes since v3:
>         * No change.
> Changes since v2:
>         * No change.
> Changes since v1:
>         * No change.
> Changes since RFC:
>         * No change.
> ---
>  arch/arm64/boot/dts/actions/s700-cubieboard7.dts | 33 ++++++++++++++++++++++++
>  arch/arm64/boot/dts/actions/s700.dtsi            |  1 +
>  2 files changed, 34 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/actions/s700-cubieboard7.dts b/arch/arm64/boot/dts/actions/s700-cubieboard7.dts
> index 63e375cd9eb4..f81d63261ba2 100644
> --- a/arch/arm64/boot/dts/actions/s700-cubieboard7.dts
> +++ b/arch/arm64/boot/dts/actions/s700-cubieboard7.dts
> @@ -13,6 +13,7 @@
>  
>  	aliases {
>  		serial3 = &uart3;
> +		mmc0 = &mmc0;
>  	};
>  
>  	chosen {
> @@ -28,6 +29,15 @@
>  		device_type = "memory";
>  		reg = <0x1 0xe0000000 0x0 0x0>;
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
>  };
>  
>  &i2c0 {
> @@ -81,6 +91,14 @@
>  			bias-pull-up;
>  		};
>  	};
> +
> +	mmc0_default: mmc0_default {
> +		pinmux {
> +			groups = "sd0_d0_mfp", "sd0_d1_mfp", "sd0_d2_d3_mfp",
> +				 "sd0_cmd_mfp", "sd0_clk_mfp";
> +			function = "sd0";
> +		};
> +	};
>  };
>  
>  &timer {
> @@ -90,3 +108,18 @@
>  &uart3 {
>  	status = "okay";
>  };
> +
> +/* uSD */
> +&mmc0 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mmc0_default>;
> +	cd-gpios = <&pinctrl 120 GPIO_ACTIVE_LOW>;
> +	no-sdio;
> +	no-mmc;
> +	no-1-8-v;
> +	bus-width = <4>;
> +	vmmc-supply = <&sd_vcc>;
> +	vqmmc-supply = <&sd_vcc>;
> +};
> +
> diff --git a/arch/arm64/boot/dts/actions/s700.dtsi b/arch/arm64/boot/dts/actions/s700.dtsi
> index 9ed88aafc2da..ba498cf9217d 100644
> --- a/arch/arm64/boot/dts/actions/s700.dtsi
> +++ b/arch/arm64/boot/dts/actions/s700.dtsi
> @@ -4,6 +4,7 @@
>   */
>  
>  #include <dt-bindings/clock/actions,s700-cmu.h>
> +#include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/power/owl-s700-powergate.h>
>  #include <dt-bindings/reset/actions,s700-reset.h>
> -- 
> 2.7.4
> 

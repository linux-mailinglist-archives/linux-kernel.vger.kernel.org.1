Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA862E7ED9
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Dec 2020 10:07:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726348AbgLaJF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Dec 2020 04:05:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbgLaJF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Dec 2020 04:05:56 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573AAC061573;
        Thu, 31 Dec 2020 01:05:16 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id q22so24763673eja.2;
        Thu, 31 Dec 2020 01:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gEbEAo9FROsZiQZq5BVX+sHufiFAG2yfDXcJtE7ZVCI=;
        b=fV90FLLgBj5r/n2ef1vHBCCqq5ZFY/F++ubW+7VA+btHQotKi58OeKyYKymXJdaskL
         C70B40+17844mVv5nuUX9yfPYEG6U739m1HwCYH7siRogarimnPzE337vTOMKzwYfEZM
         emNiloqLtOWSWiFykJ8FulAjXPhSkHihaxf47T0dYYFKGyGhn2BX8aaaBzL8t/Tvj4JJ
         RJWUzAMJzlCvt24DMDnXhkEBr76PQfgSpkpgDvuP49zXnvHZQ/Q+tkk2SGpaubOsxUNg
         CbY4MJccRX94Xj9zZIRByUIUwGiHhyvitDOfX3Q0ELWXaTlOyrh52K5S3CZ33WHQw8s2
         n5qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gEbEAo9FROsZiQZq5BVX+sHufiFAG2yfDXcJtE7ZVCI=;
        b=mofjs2oWsNQN1/1Vjuk60IencPSbdKtBY7ScJjuR9czG3sIOWOnscyoPzx13JBdmTY
         HXJtbTbLHKTjXYCZA/N6bmmXMiNRY6yzxKAGlR5RHo0xktGLesIibEZtr8jckLObslFz
         HEETBpqypioxvTnVlp9bOK2+w4ch8DanlgfluLQ8rmND8k4MoyAZ3HpPhrpy8Pb+Dbc7
         m49+NNKKNfgkI9sXwH/LPwnmcVh8H+iXR4f8Xeunz0MXvZre8KXngWQumpOtU4ObffLB
         e4n/Ee9qIMeQYL5iPaX1fgqgI+jbTaqWkBVCKrKThRwaripKP+Ca4C9/ksiLHx7AAmXd
         SkxA==
X-Gm-Message-State: AOAM5303WzRRizTmFkLWsIqbfbp6xVX2fyezREPwP2HcW7RP6kVPZn34
        FFijr9pgg4C0tSAg4/yhsjs=
X-Google-Smtp-Source: ABdhPJzfERQjqyWFPG0CQrEKGSfO4C8Uv7lJ+QgNnwRMe8QISUIcxEuc6qwxJ6D0n+t3x5qUfYIDxA==
X-Received: by 2002:a17:906:b082:: with SMTP id x2mr49091817ejy.100.1609405514344;
        Thu, 31 Dec 2020 01:05:14 -0800 (PST)
Received: from ubuntu2004 ([188.24.159.61])
        by smtp.gmail.com with ESMTPSA id r7sm32420657edh.86.2020.12.31.01.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Dec 2020 01:05:13 -0800 (PST)
Date:   Thu, 31 Dec 2020 11:05:18 +0200
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 11/13] arm: dts: owl-s500-roseapplepi: Add uSD support
Message-ID: <20201231090518.GA916001@ubuntu2004>
References: <cover.1609263738.git.cristian.ciocaltea@gmail.com>
 <47ee9695e89198ec2fbc4ab6188f1d0ad0424b2f.1609263738.git.cristian.ciocaltea@gmail.com>
 <20201231072710.GF7345@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201231072710.GF7345@thinkpad>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 31, 2020 at 12:57:10PM +0530, Manivannan Sadhasivam wrote:
> On Tue, Dec 29, 2020 at 11:17:26PM +0200, Cristian Ciocaltea wrote:
> > Add uSD support for RoseapplePi SBC using a fixed regulator as a
> > temporary solution until PMIC support becomes available.
> > 
> > Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> 
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thank you, Mani!

> Thanks,
> Mani
> 
> > ---
> > Changes in v3:
> >  - None
> > 
> >  arch/arm/boot/dts/owl-s500-roseapplepi.dts | 50 ++++++++++++++++++++++
> >  1 file changed, 50 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/owl-s500-roseapplepi.dts b/arch/arm/boot/dts/owl-s500-roseapplepi.dts
> > index 800edf5d2d12..fe9ae3619422 100644
> > --- a/arch/arm/boot/dts/owl-s500-roseapplepi.dts
> > +++ b/arch/arm/boot/dts/owl-s500-roseapplepi.dts
> > @@ -14,6 +14,7 @@ / {
> >  	model = "Roseapple Pi";
> >  
> >  	aliases {
> > +		mmc0 = &mmc0;
> >  		serial2 = &uart2;
> >  	};
> >  
> > @@ -25,6 +26,55 @@ memory@0 {
> >  		device_type = "memory";
> >  		reg = <0x0 0x80000000>; /* 2GB */
> >  	};
> > +
> > +	/* Fixed regulator used in the absence of PMIC */
> > +	sd_vcc: sd-vcc {
> > +		compatible = "regulator-fixed";
> > +		regulator-name = "fixed-3.1V";
> > +		regulator-min-microvolt = <3100000>;
> > +		regulator-max-microvolt = <3100000>;
> > +		regulator-always-on;
> > +	};
> > +};
> > +
> > +&pinctrl {
> > +	mmc0_pins: mmc0-pins {
> > +		pinmux {
> > +			groups = "sd0_d0_mfp", "sd0_d1_mfp", "sd0_d2_d3_mfp",
> > +				 "sd0_cmd_mfp", "sd0_clk_mfp";
> > +			function = "sd0";
> > +		};
> > +
> > +		drv-pinconf {
> > +			groups = "sd0_d0_d3_drv", "sd0_cmd_drv", "sd0_clk_drv";
> > +			drive-strength = <8>;
> > +		};
> > +
> > +		bias0-pinconf {
> > +			pins = "sd0_d0", "sd0_d1", "sd0_d2",
> > +			       "sd0_d3", "sd0_cmd";
> > +			bias-pull-up;
> > +		};
> > +
> > +		bias1-pinconf {
> > +			pins = "sd0_clk";
> > +			bias-pull-down;
> > +		};
> > +	};
> > +};
> > +
> > +/* uSD */
> > +&mmc0 {
> > +	status = "okay";
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&mmc0_pins>;
> > +	no-sdio;
> > +	no-mmc;
> > +	no-1-8-v;
> > +	cd-gpios = <&pinctrl 117 GPIO_ACTIVE_LOW>;
> > +	bus-width = <4>;
> > +	vmmc-supply = <&sd_vcc>;
> > +	vqmmc-supply = <&sd_vcc>;
> >  };
> >  
> >  &twd_timer {
> > -- 
> > 2.30.0
> > 

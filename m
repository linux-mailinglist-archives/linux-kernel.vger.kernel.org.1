Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E61AC2C7AAD
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Nov 2020 19:36:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728858AbgK2SgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 13:36:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbgK2SgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 13:36:17 -0500
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85347C0613CF;
        Sun, 29 Nov 2020 10:35:37 -0800 (PST)
Received: by mail-ed1-x542.google.com with SMTP id q16so12184742edv.10;
        Sun, 29 Nov 2020 10:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=crRAcWRYB33Jt+9OZEGW4rivN9aVKD/I1b3sfdZ3wL4=;
        b=EpAp5nzPKggMHsS3zKvCBbzG8h0Bjh7kXDhn9DgMsAlkG+Doub9LXRQzPgS71Y7/Q5
         9zzfSFXQiXUNcayJ0/g/w3ASbOVMZOBeEv1WfLU5q7WrbBVuq5HJh6FunRG7zBx8oeKt
         NgxFggJ1BmgUmpFSJ8n4T4eMYDOAAXTYxKDkraPolY3KNf4KdNARdgtxUO+L/1anvtQZ
         rZ6NWXSD9akb3rwLIXE8Bl+x9dbjzsyfJCu9zapEXFuYR2/GZO2RcXdSxdskzOHwn6st
         dH/fQNF1lAxoMKrjYdCReBg4Cdo6hoF4E+wmqeJbXomMNAw3e7kUa3+6+eENy1T0yofs
         krvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=crRAcWRYB33Jt+9OZEGW4rivN9aVKD/I1b3sfdZ3wL4=;
        b=ddZiXA2apwMV7zEdsBCOuHDUTKov1U8F2+F7mJnUXz/L0b1PcVxXPCgzj5RiNEROJC
         uKocwU2s7xB7B7+pJznwhMla2ZKY5pCwUki8ry+qpIyimhPSWfgzSTeDoUG3e+s0ni7b
         /Dhk1+lOKI/qfwUC97FT6kt1gVOu/MyXy7ONujzAqsT/MbGsXAj9QVeVazgP8ZaqPnrd
         80/GyYUFrb2x7o37VHTknmfn5rxxECj2ljFtx/yr0jQEyuyI0QA8LtDKupR97BdTwOt/
         nMPRINuGIpm7DNRhTNUJTohAkULEnm/G9jg6t6gCyx6UCVEZkJsq/QmRI36KuhkcayrZ
         K9Ag==
X-Gm-Message-State: AOAM532qSBj520GURI8kL7yoR9AbEBWLacEkV0QXwMA12w6SUWfqSsUu
        QpGzniMZ9CUt4vr8g3K7s+G9ldED4HM=
X-Google-Smtp-Source: ABdhPJwLYrx4sYwcrgCMf3RNLjiWqPWjc7n2nN3cn7fa+o2L+a3A+GN+bx6Wop/yuRGBdOP7gPYjrQ==
X-Received: by 2002:aa7:d48d:: with SMTP id b13mr18203339edr.264.1606674935614;
        Sun, 29 Nov 2020 10:35:35 -0800 (PST)
Received: from BV030612LT ([188.24.159.61])
        by smtp.gmail.com with ESMTPSA id l19sm3330947edq.14.2020.11.29.10.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Nov 2020 10:35:34 -0800 (PST)
Date:   Sun, 29 Nov 2020 20:35:32 +0200
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 16/18] arm: dts: owl-s500-roseapplepi: Add uSD support
Message-ID: <20201129183532.GA748744@BV030612LT>
References: <cover.1605823502.git.cristian.ciocaltea@gmail.com>
 <cf62e297a18518d54dd887a0bc531b18a50da5c5.1605823502.git.cristian.ciocaltea@gmail.com>
 <20201128073851.GC3077@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201128073851.GC3077@thinkpad>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 28, 2020 at 01:08:51PM +0530, Manivannan Sadhasivam wrote:
> On Fri, Nov 20, 2020 at 01:56:10AM +0200, Cristian Ciocaltea wrote:
> > Add uSD support for RoseapplePi SBC using a fixed regulator as a
> > temporary solution until PMIC support becomes available.
> > 
> > Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> > ---
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
> 
> Is this the exact name in the schematics?

Yes, it is referred as "SD_VCC". Once the support for the ATC260x PMIC
will be available, the following item will be present in the regulators
list:

  sd_vcc: switchldo1 {
	regulator-name = "SD_VCC";
	regulator-min-microvolt = <3000000>;
	regulator-max-microvolt = <3300000>;
	regulator-always-on;
	regulator-boot-on;
  };

Thanks,
Cristi

> Thanks,
> Mani
> 
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
> > 2.29.2
> > 

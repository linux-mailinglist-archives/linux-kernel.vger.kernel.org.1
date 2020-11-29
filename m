Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAD552C7AF6
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Nov 2020 20:40:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbgK2Tg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 14:36:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726470AbgK2TgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 14:36:25 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69EECC0613D3;
        Sun, 29 Nov 2020 11:35:45 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id gj5so16642375ejb.8;
        Sun, 29 Nov 2020 11:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VJTurQv9SmuIqbxbzGcKFRaNIBwldzV4TEKvkjo/ws8=;
        b=pgu93Y+SVm2fARnZpQFRg+GLA5vygzeDditWd6X2Rc0to9o9/gWGJeUB4WjB1RZqnD
         VWwW2v3pdDe4ObLsQIj0ACnpBNHpW7yTPxHXlp0docwG4NMCCI/w8C2NjRJKeVNSncHu
         ooRcIdddKj6kehj9tTDtv3xUb75pDuGipYLkZg+8TDmoebg8e5HfylZdKXdsr41e5FgL
         UJ0izd8h+Amqy+Kiwynh8KWGMoL09QmlTVBeN4j8JlwNnE/IMUUFlH6Facxd7POaNIkf
         JVkaU9mVqVJICTYoNdz8A/cym/ZpQkswDwcDthU5ZGw/dExcY0oXI/hK/E2vfQhpncnp
         VNjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VJTurQv9SmuIqbxbzGcKFRaNIBwldzV4TEKvkjo/ws8=;
        b=nP9CS/cNFfb9Wxwdum6DezsbvaW501LH1+21t8AH33ZMh+BJn+OUlP+v9gmqT1q5l/
         kfWDCDSwzGwakuf6Ub0YQ77pidPL51qpyayHi4jcJ5iaxOv2S/cGtfUoMsNIonvvvWB7
         MwiFz2IsvdhOFYUg+Cn9dJrUvA95E9C1Nw3rj0EArdRzLawePRpfJn313GKGgJBAgTUf
         kuwtZxWa0XFwAkdSmfdw5muOahDZsh7m1UYYgBV63Dp0QUbSRoiQmsDBx1zBn60gWmrn
         Hx3G5V9+JoidVza6aXPvaMaFGsSPUSg6KX0mom56R8lbfFnUnUNBe3qehMKPO7n+e/+1
         lTrw==
X-Gm-Message-State: AOAM530VDsLFq6w1Qaufpx9FPEuaBhNwDMY+FfkAxnMX4tM9lHF2ty0k
        w91z+ZqlXbtTHI90uV3nmBk=
X-Google-Smtp-Source: ABdhPJw4aTp5hoL7pBhYisMuritmZ1LcC7oYcYekLah1uOIz+E75cKVtUBtH5Pi19GCU0eQRKLpfxA==
X-Received: by 2002:a17:906:edb2:: with SMTP id sa18mr15457895ejb.264.1606678544155;
        Sun, 29 Nov 2020 11:35:44 -0800 (PST)
Received: from BV030612LT ([188.24.159.61])
        by smtp.gmail.com with ESMTPSA id ot22sm1657731ejb.120.2020.11.29.11.35.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Nov 2020 11:35:43 -0800 (PST)
Date:   Sun, 29 Nov 2020 21:35:41 +0200
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 17/18] arm: dts: owl-s500-roseapplepi: Add I2C pinctrl
 configuration
Message-ID: <20201129193541.GB748744@BV030612LT>
References: <cover.1605823502.git.cristian.ciocaltea@gmail.com>
 <f41e33b12d77e75246fa94ed6acc57fffe84aaa4.1605823502.git.cristian.ciocaltea@gmail.com>
 <20201128074108.GD3077@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201128074108.GD3077@thinkpad>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 28, 2020 at 01:11:08PM +0530, Manivannan Sadhasivam wrote:
> On Fri, Nov 20, 2020 at 01:56:11AM +0200, Cristian Ciocaltea wrote:
> > Add pinctrl definitions for the I2C controllers used in RoseapplePi SBC.
> > For the moment enable only I2C0, which is used by the ATC2603C PMIC.
> > 
> > Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> 
> Earlier we used to add "_default" suffix for the pin groups to
> differentiate between active and sleep states. But I guess we can just
> keep the suffix away until we hit usecase.

I had actually used this suffix when I submitted the first revision of
the S500 pinctrl driver, but I dropped it later in the review process
since it was considered an uncommon approach:
https://lore.kernel.org/lkml/CAL_Jsq+8bX5duv=116e=hve1L-h8a=5quqCHVtSAs4PjK6xc1w@mail.gmail.com/

Thanks,
Cristi

> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> Thanks,
> Mani
> 
> > ---
> >  arch/arm/boot/dts/owl-s500-roseapplepi.dts | 44 ++++++++++++++++++++++
> >  1 file changed, 44 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/owl-s500-roseapplepi.dts b/arch/arm/boot/dts/owl-s500-roseapplepi.dts
> > index fe9ae3619422..ff91561ca99c 100644
> > --- a/arch/arm/boot/dts/owl-s500-roseapplepi.dts
> > +++ b/arch/arm/boot/dts/owl-s500-roseapplepi.dts
> > @@ -37,7 +37,51 @@ sd_vcc: sd-vcc {
> >  	};
> >  };
> >  
> > +&i2c0 {
> > +	status = "okay";
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&i2c0_pins>;
> > +};
> > +
> > +&i2c1 {
> > +	status = "disabled";
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&i2c1_pins>;
> > +};
> > +
> > +&i2c2 {
> > +	status = "disabled";
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&i2c2_pins>;
> > +};
> > +
> >  &pinctrl {
> > +	i2c0_pins: i2c0-pins {
> > +		pinmux {
> > +			groups = "i2c0_mfp";
> > +			function = "i2c0";
> > +		};
> > +
> > +		pinconf {
> > +			pins = "i2c0_sclk", "i2c0_sdata";
> > +			bias-pull-up;
> > +		};
> > +	};
> > +
> > +	i2c1_pins: i2c1-pins {
> > +		pinconf {
> > +			pins = "i2c1_sclk", "i2c1_sdata";
> > +			bias-pull-up;
> > +		};
> > +	};
> > +
> > +	i2c2_pins: i2c2-pins {
> > +		pinconf {
> > +			pins = "i2c2_sclk", "i2c2_sdata";
> > +			bias-pull-up;
> > +		};
> > +	};
> > +
> >  	mmc0_pins: mmc0-pins {
> >  		pinmux {
> >  			groups = "sd0_d0_mfp", "sd0_d1_mfp", "sd0_d2_d3_mfp",
> > -- 
> > 2.29.2
> > 

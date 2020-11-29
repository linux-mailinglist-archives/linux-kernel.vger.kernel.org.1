Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 703B92C7A74
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Nov 2020 19:10:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbgK2SJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 13:09:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbgK2SJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 13:09:58 -0500
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91831C0613CF;
        Sun, 29 Nov 2020 10:09:17 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id c7so4377705edv.6;
        Sun, 29 Nov 2020 10:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jh1ddfH82M+9/9xGKQsswipTVir4/HTDEBDiLjn68GM=;
        b=SpxjyzZ6/fD06lDe+qFMlwuvVS491FihDSROoCRT2Wl7ZwXcmFUuS3XAW1MYad3Q/t
         YGnsnVYUwnxQfrcgHPl4vfUnnc6CzAUQNTuiN3s4pHJlcNNUnPCorE08Ua/44uNoF0PC
         XBYLrX1As3fmmhZCzyzimaUyeZAc7+DDPuWehvV4wHHfclOPdgkrxgqEQdnCYqy0k5XT
         d8n48p08g2+VLfGuqKEVz3ECus/ON59cbstF/fBqA+fH3YdJANikdxbtWbg48/7DW2TS
         2OItQXACw69Q+AJI0fgWdUI2r13Pr+nsBkO2zZvCsnYP83EY+5BUK7U5/i8hGq9H58nj
         2lrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jh1ddfH82M+9/9xGKQsswipTVir4/HTDEBDiLjn68GM=;
        b=oh2PLqBsTOCojiv5IDbm0aRXA2XNU1EyrC+pPH39YUSqe+G6heAl3PhFC26kqNc5YK
         ieSBceH2OHUBs41hTDt68ahpGLeZE3lHoieGxVrl3hwXpzOEMTW4kj+SwPgCfKlC+oYU
         10bihLTdbQZgYAo1sclL64RBBQ20nYRn/HPOud42viYRmEaxLPJA459kYdU74wq4ZVtx
         9yR290poMJug2GiiOyyfCmxclOizPiPkuDiDMVvPybBN1H2J8cyGBqtYMJ1lq9Cobvxl
         rOT2dtyHOfq7yDeUnreZQp0HIVTYuDoZ8fxCpoJrcqL4UJKkHmY5VHfjcIorbjH+/NYM
         HLqw==
X-Gm-Message-State: AOAM530uRj59zB8bUqSnl5OpzrtJCoWUKHfoe2vs+udFey//icXeMkPX
        EuvykVUCarVGjF+j0LM9zYII2d+vTWA=
X-Google-Smtp-Source: ABdhPJxYX+oymAv34vK4CtkFageiJknB5F2rWappb7IyDCv7PiMs6gHF0gDZ+54yWSL+E17qaG6wXA==
X-Received: by 2002:a05:6402:1115:: with SMTP id u21mr18150115edv.148.1606673356059;
        Sun, 29 Nov 2020 10:09:16 -0800 (PST)
Received: from BV030612LT ([188.24.159.61])
        by smtp.gmail.com with ESMTPSA id op24sm7639858ejb.56.2020.11.29.10.09.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Nov 2020 10:09:15 -0800 (PST)
Date:   Sun, 29 Nov 2020 20:09:13 +0200
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/18] arm: dts: owl-s500: Set CMU clocks for UARTs
Message-ID: <20201129180913.GB696261@BV030612LT>
References: <cover.1605823502.git.cristian.ciocaltea@gmail.com>
 <1bd42cf44e5aaef1bb7e97e4e344444ddbfbb091.1605823502.git.cristian.ciocaltea@gmail.com>
 <20201128072513.GQ3077@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201128072513.GQ3077@thinkpad>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 28, 2020 at 12:55:13PM +0530, Manivannan Sadhasivam wrote:
> On Fri, Nov 20, 2020 at 01:55:56AM +0200, Cristian Ciocaltea wrote:
> > Set Clock Management Unit clocks for the UART nodes of Actions Semi
> > S500 SoCs.
> > 
> > Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> 
> Also in this patch itself, you need to remove the dummy "uart3_clk" from
> S500 dts. With that,

I have prepared the updated patch with the requested changes, including
also the merge of the RoseapplePi related patch (no. 15 in this series).

Thanks,
Cristi

> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> Thanks,
> Mani
> 
> > ---
> >  arch/arm/boot/dts/owl-s500.dtsi | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/owl-s500.dtsi b/arch/arm/boot/dts/owl-s500.dtsi
> > index 5d5ad9db549b..ac3d04c75dd5 100644
> > --- a/arch/arm/boot/dts/owl-s500.dtsi
> > +++ b/arch/arm/boot/dts/owl-s500.dtsi
> > @@ -131,6 +131,7 @@ uart0: serial@b0120000 {
> >  			compatible = "actions,s500-uart", "actions,owl-uart";
> >  			reg = <0xb0120000 0x2000>;
> >  			interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
> > +			clocks = <&cmu CLK_UART0>;
> >  			status = "disabled";
> >  		};
> >  
> > @@ -138,6 +139,7 @@ uart1: serial@b0122000 {
> >  			compatible = "actions,s500-uart", "actions,owl-uart";
> >  			reg = <0xb0122000 0x2000>;
> >  			interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
> > +			clocks = <&cmu CLK_UART1>;
> >  			status = "disabled";
> >  		};
> >  
> > @@ -145,6 +147,7 @@ uart2: serial@b0124000 {
> >  			compatible = "actions,s500-uart", "actions,owl-uart";
> >  			reg = <0xb0124000 0x2000>;
> >  			interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
> > +			clocks = <&cmu CLK_UART2>;
> >  			status = "disabled";
> >  		};
> >  
> > @@ -152,6 +155,7 @@ uart3: serial@b0126000 {
> >  			compatible = "actions,s500-uart", "actions,owl-uart";
> >  			reg = <0xb0126000 0x2000>;
> >  			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
> > +			clocks = <&cmu CLK_UART3>;
> >  			status = "disabled";
> >  		};
> >  
> > @@ -159,6 +163,7 @@ uart4: serial@b0128000 {
> >  			compatible = "actions,s500-uart", "actions,owl-uart";
> >  			reg = <0xb0128000 0x2000>;
> >  			interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
> > +			clocks = <&cmu CLK_UART4>;
> >  			status = "disabled";
> >  		};
> >  
> > @@ -166,6 +171,7 @@ uart5: serial@b012a000 {
> >  			compatible = "actions,s500-uart", "actions,owl-uart";
> >  			reg = <0xb012a000 0x2000>;
> >  			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
> > +			clocks = <&cmu CLK_UART5>;
> >  			status = "disabled";
> >  		};
> >  
> > @@ -173,6 +179,7 @@ uart6: serial@b012c000 {
> >  			compatible = "actions,s500-uart", "actions,owl-uart";
> >  			reg = <0xb012c000 0x2000>;
> >  			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
> > +			clocks = <&cmu CLK_UART6>;
> >  			status = "disabled";
> >  		};
> >  
> > -- 
> > 2.29.2
> > 

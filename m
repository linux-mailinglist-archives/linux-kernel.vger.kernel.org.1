Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 705082C7A6B
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Nov 2020 18:57:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728209AbgK2R4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 12:56:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbgK2R4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 12:56:04 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0284C0613CF;
        Sun, 29 Nov 2020 09:55:23 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id lt17so16281635ejb.3;
        Sun, 29 Nov 2020 09:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=1oDEgxrRX4905vbethbn/tME4SVwRYtURhXXsRLFMfE=;
        b=dfxvQKnJ8llk4Dq+ohXYx4DYBl/qXNPFno92Y8i9xke0Chj2bOVypPHYYKvsi5paoI
         uUZLdQNNCww3q9GQLZB/PmG3m9V2Vllx4xrFg9+jNZm66pWVpXloTQf+V1OS1g4oY8KU
         E+CbggwX1vCf4EcZNII5ruWY3t7x6+IxN6i8JsZNd73JDLXzw6TclPoo/oQxVkWazGCA
         yr7Db9WPVD4addOpVyIJd/9rzhuy6ZIoVoQvQ8V4ku5z/yzp7RVkGcrQjkzAKbRiT2+q
         o7qsX4EmOrVXuRxqcj77ofZdD7ZWm4EY6ZUy/QvxyaMdZzYb49cuGM7MH2bVKI7oSZOA
         yDtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=1oDEgxrRX4905vbethbn/tME4SVwRYtURhXXsRLFMfE=;
        b=s9Smef/E27mBI8A9yYCDxzBiB+bDdU8RH3DD+8akfpHHrUOG6uyio3hOdPNrvqnLUQ
         PnDaOLabRtFLyt9oZQ2bGdwg+pXizZQcN8oKsEXymBT9vRFeO+zPIW2bH93Focd/qddJ
         8T5Aa19X4kqOYwjCXCOpEnULU/U/yQ1zjShKcloSgcUR8g9Hn1escEXqaL8jsO2rpwkI
         NNIeQKRjkKmJKXKZPeCJgrl2m5ZVnp1Va5bC9ngL0LDYxZDP61fMdt0lQtOx4REtUYDO
         xzxDLw1qTz35ImjM/HLQIEKT/lP4BBZOeMP7erztIz3avj0/R16ro76SGKl925NXsbMo
         wQKQ==
X-Gm-Message-State: AOAM5319LfpJyXkrGRG6uYUT8eC9uFSSfvaebSej8GadmYL1C3EURVkq
        etWr+4YxGEDJ1LCSc4ebpB4=
X-Google-Smtp-Source: ABdhPJxgDNeUi+7pVo+kr/SIQ9cPk9Ns2qQpXJPaNVvlyzfEk0E2ggYQsFHPK7CflqrW/R6eXKdHeg==
X-Received: by 2002:a17:906:52d9:: with SMTP id w25mr17029120ejn.504.1606672522678;
        Sun, 29 Nov 2020 09:55:22 -0800 (PST)
Received: from BV030612LT ([188.24.159.61])
        by smtp.gmail.com with ESMTPSA id g15sm7494096edj.49.2020.11.29.09.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Nov 2020 09:55:21 -0800 (PST)
Date:   Sun, 29 Nov 2020 19:55:19 +0200
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/18] arm: dts: owl-s500: Add Clock Management Unit
Message-ID: <20201129175519.GA696261@BV030612LT>
References: <cover.1605823502.git.cristian.ciocaltea@gmail.com>
 <7c45642753b94e2b2f4fcef0d3206b4c237e3135.1605823502.git.cristian.ciocaltea@gmail.com>
 <20201128072212.GP3077@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201128072212.GP3077@thinkpad>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 28, 2020 at 12:52:12PM +0530, Manivannan Sadhasivam wrote:
> On Fri, Nov 20, 2020 at 01:55:55AM +0200, Cristian Ciocaltea wrote:
> > Add Clock Management Unit for Actions Semi S500 SoC.
> > 
> > Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> 
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks for taking the time to review this patch series!

Kind regards,
Cristi

> Thanks,
> Mani
> 
> > ---
> >  arch/arm/boot/dts/owl-s500.dtsi | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/owl-s500.dtsi b/arch/arm/boot/dts/owl-s500.dtsi
> > index 1dbe4e8b38ac..5d5ad9db549b 100644
> > --- a/arch/arm/boot/dts/owl-s500.dtsi
> > +++ b/arch/arm/boot/dts/owl-s500.dtsi
> > @@ -5,6 +5,7 @@
> >   * Copyright (c) 2016-2017 Andreas Färber
> >   */
> >  
> > +#include <dt-bindings/clock/actions,s500-cmu.h>
> >  #include <dt-bindings/interrupt-controller/arm-gic.h>
> >  #include <dt-bindings/power/owl-s500-powergate.h>
> >  
> > @@ -70,6 +71,12 @@ hosc: hosc {
> >  		#clock-cells = <0>;
> >  	};
> >  
> > +	losc: losc {
> > +		compatible = "fixed-clock";
> > +		clock-frequency = <32768>;
> > +		#clock-cells = <0>;
> > +	};
> > +
> >  	soc {
> >  		compatible = "simple-bus";
> >  		#address-cells = <1>;
> > @@ -169,6 +176,13 @@ uart6: serial@b012c000 {
> >  			status = "disabled";
> >  		};
> >  
> > +		cmu: clock-controller@b0160000 {
> > +			compatible = "actions,s500-cmu";
> > +			reg = <0xb0160000 0x8000>;
> > +			clocks = <&hosc>, <&losc>;
> > +			#clock-cells = <1>;
> > +		};
> > +
> >  		timer: timer@b0168000 {
> >  			compatible = "actions,s500-timer";
> >  			reg = <0xb0168000 0x8000>;
> > -- 
> > 2.29.2
> > 

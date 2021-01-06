Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7432B2EBA7F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 08:30:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbhAFHaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 02:30:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbhAFHaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 02:30:14 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 945A2C06134D
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 23:29:34 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id x126so1221716pfc.7
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 23:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=g13S8/D3qTa95X7RjYOUBZG594lrdeUyR9HzMIKa0WA=;
        b=qeTsTKmk75ITxMFz9OpPVaBjz3qFxy3uIc7eM205UyBH1n6eLqooLwYP/7FR2d4IXE
         o1aEOR8yjBN6vJBb5G9oiS5w7Yf0BfOCpVRMBBb5y0Gk0Y4oMuuBLpF/JsOjQb/tdDBI
         U+jQvUcbucptVckhoSCWotHHjyRzhriqI3kI+2zOlg+XSlHzOQUnn4lSH4i2pqPSQO0/
         8YeCrmNS+6Yzo/NzwOaMmDqv8UxoSCpd9g1GmukDj1kDc5Ysf6WT6G6kkdXQLcNfeS6A
         phzWR6jfFY940JZJ/NDj2W6mS/d2ItwioWr/uKFGWiBJltm7yi60v74OBumWpPwctf7W
         3a6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=g13S8/D3qTa95X7RjYOUBZG594lrdeUyR9HzMIKa0WA=;
        b=NeCbiA27ZrKKfvVRbF/LCcuJKKTMgoPoicNnww0N6DY8Fq2RUyrmwzYeGEGdGHCSEk
         NyTCz/wx0EOj8LT+MV9cg1fy2hLeWx4QW/SiDpmtPUU09ZkYDI2iHGoUE3WUaOzT7mYQ
         aA8UWFWgcTSfC1Gr/lap3wWYuidbfXH2K1ibNdaVNoresMLfMctAjVZHFIYU9p59b2bW
         Do3KmNbX5BCalJeqR/owfmISnnucheX4JrdvnjdBkQP3O/n2JYsMcWdmh+NVhvf0RZV2
         hMkQcLkoUpOFempg6hbU3PmVNdO+EShMTwJfBmcrM5BNTPDfMWRu6wA4hsxGJupujEyR
         h8aA==
X-Gm-Message-State: AOAM532810gWh7RAZ453lSoOkU7/nNRFOBXzKCTiSqiyCIBF0ClFM8M4
        uDSiV0RkGNUVPqZfPDlPncen
X-Google-Smtp-Source: ABdhPJznAbU313wXblnZtS33pSgg9t2SuPt+L84EG+LSBkY+e/6EBlVlgpJnt0KVy++SVQCR92qkew==
X-Received: by 2002:a63:4b54:: with SMTP id k20mr3223492pgl.290.1609918174003;
        Tue, 05 Jan 2021 23:29:34 -0800 (PST)
Received: from thinkpad ([2409:4072:6e17:af05:51f0:bf72:bf80:ec88])
        by smtp.gmail.com with ESMTPSA id b129sm1531176pgc.52.2021.01.05.23.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 23:29:33 -0800 (PST)
Date:   Wed, 6 Jan 2021 12:59:27 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 10/18] ARM: dts: qcom: sdx55: Add QPIC NAND support
Message-ID: <20210106072927.GB3131@thinkpad>
References: <20210105122649.13581-1-manivannan.sadhasivam@linaro.org>
 <20210105122649.13581-11-manivannan.sadhasivam@linaro.org>
 <20210105155102.GD2771@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210105155102.GD2771@vkoul-mobl>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 05, 2021 at 09:21:02PM +0530, Vinod Koul wrote:
> On 05-01-21, 17:56, Manivannan Sadhasivam wrote:
> > Add qpic_nand node to support QPIC NAND controller on SDX55 platform.
> > Since there is no "aon" clock in SDX55, a dummy clock is provided.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  arch/arm/boot/dts/qcom-sdx55.dtsi | 22 ++++++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/qcom-sdx55.dtsi b/arch/arm/boot/dts/qcom-sdx55.dtsi
> > index 1b9b990ad0a2..1a6947753972 100644
> > --- a/arch/arm/boot/dts/qcom-sdx55.dtsi
> > +++ b/arch/arm/boot/dts/qcom-sdx55.dtsi
> > @@ -41,6 +41,12 @@ pll_test_clk: pll-test-clk {
> >  			#clock-cells = <0>;
> >  			clock-frequency = <400000000>;
> >  		};
> > +
> > +		nand_clk_dummy: nand-clk-dummy {
> 
> Why dummy..? 

There is no such clock used on this platform but the driver requires it.

> > +			compatible = "fixed-clock";
> > +			#clock-cells = <0>;
> > +			clock-frequency = <32000>;
> 
> Is this sleep clock of platform..?
> 

Always ON (AON) clock.

Thanks,
Mani

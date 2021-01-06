Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21CB72EBC58
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 11:27:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbhAFK04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 05:26:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbhAFK0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 05:26:55 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA1FC061357
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 02:26:15 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id t22so1466853pfl.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 02:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4JkOyGZ2kMhBEZsAGChCGSnqza/6UfsyHzZgJWauIcw=;
        b=drCswdql1NblWIpOGIUE8YyFYX2BJo5jn5mTR9FX6iBs2UmSNUqD1I05DP+ikg7HBG
         GBjJNS4oxi0Uk0TtPrt4JHwNse0UEq0KIUtXvNGkE/i8dY0wRnIHnk6pgIZ4rwfrTAEn
         aTYga/zBfIHACg4rTIjdzViYfCHchUcslAng3YMAmGQ84BbM7uro5w2U2XWC8G/QNAqd
         MaKEwTaFlokvIvoDOXDRfxQHNW8o6SjinQwZ2+ZbHRcwFcSv56xsXHcZ2z6ZO5PXj7r5
         BvBXUN63eRPE4lKoP56vFAZSLl43lNtDHHi5ToGgEMSf5+W9+Jmvk+T+MVGWRJspoK6T
         PsGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4JkOyGZ2kMhBEZsAGChCGSnqza/6UfsyHzZgJWauIcw=;
        b=SrV8zNTnGcCe3VVmbxwDcWkn93ZOkrMyZlu9iwNHL4kNMNZ2Q4h057jBryJnQz/Wys
         cMwKEwNvHyihCBFB8xG3Razjb/2l1ZwUFd+WBTVehT0IMh+UEA2AEKCnN0O+8QpCOUkO
         E10Xg+oSYVJlLSyqpU8gT6W9VY9OOX1qv814FrKbre46+o0zH9UEHGAbOMHjlMTOdbTN
         cFqjUmNLhp91hkz9WcaqIns+HV0gLnM8O8NPbOEkA7ziUToX0+20TUvCbnEsReBRXzXP
         Tz4k3bdx2QSMTpiIwell6AQoaiziLallIuXZqHuMAWIxkwy6DrQXuqx2KM/iuDqGM39C
         dsXA==
X-Gm-Message-State: AOAM531JK6akt110LsvjfGH/aAtW1/QAN6rwnHXm14yzx4TTKGBrzOwx
        aviP2b+XBav3LwcOnkIyNqYV
X-Google-Smtp-Source: ABdhPJyxK+KcKPhQoaaUW39+xGe3K6eKpHn4U4+bOGAMIZMaQbwwybMoFIdfEplJkxxgDGzaUziQ1Q==
X-Received: by 2002:a63:2c93:: with SMTP id s141mr3889790pgs.150.1609928774836;
        Wed, 06 Jan 2021 02:26:14 -0800 (PST)
Received: from thinkpad ([2409:4072:6102:e7a2:51f0:bf72:bf80:ec88])
        by smtp.gmail.com with ESMTPSA id z3sm2071080pfb.157.2021.01.06.02.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 02:26:13 -0800 (PST)
Date:   Wed, 6 Jan 2021 15:56:08 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/18] ARM: dts: qcom: sdx55: Add support for SDHCI
 controller
Message-ID: <20210106102608.GC3131@thinkpad>
References: <20210105122649.13581-1-manivannan.sadhasivam@linaro.org>
 <20210105122649.13581-5-manivannan.sadhasivam@linaro.org>
 <20210105155259.GI2771@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210105155259.GI2771@vkoul-mobl>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 05, 2021 at 09:22:59PM +0530, Vinod Koul wrote:
> On 05-01-21, 17:56, Manivannan Sadhasivam wrote:
> > Add devicetree support for SDHCI controller found in Qualcomm SDX55 SoC.
> > The SDHCI controller used in this SoC is based on the MSM SDHCI v5 IP.
> > Hence, the support is added by reusing the existing sdhci driver with
> > "qcom,sdhci-msm-v5" as the fallback.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  arch/arm/boot/dts/qcom-sdx55.dtsi | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/qcom-sdx55.dtsi b/arch/arm/boot/dts/qcom-sdx55.dtsi
> > index eeb6bf392f93..3f8e98bfc020 100644
> > --- a/arch/arm/boot/dts/qcom-sdx55.dtsi
> > +++ b/arch/arm/boot/dts/qcom-sdx55.dtsi
> > @@ -154,6 +154,18 @@ blsp1_uart3: serial@831000 {
> >  			status = "disabled";
> >  		};
> >  
> > +		sdhc_1: sdhci@8804000 {
> 
> Any reason why this is sdhc_1 label, do we have another one..?
> 

The documentation lists this as SDC1 eventhough there seems to be no other
instances.

Thanks,
Mani

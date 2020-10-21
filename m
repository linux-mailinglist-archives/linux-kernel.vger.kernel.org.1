Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB54295015
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 17:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502637AbgJUPnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 11:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2501909AbgJUPnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 11:43:04 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB2CC0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 08:43:04 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id n15so2208302otl.8
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 08:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GRVTZ0+G5+e7Gux+3d1S4AXSA+7idOeLoopuLqwFUjs=;
        b=T/6wmvdVjJux3vjPa6gCiRYLDSGONafaoP0Hfv0kpZ48rFqbTg3Pr/qWh0hlL/KkFY
         Oh/Gt8/kOhs1KrwiNXy1MfwL54nyLeVfZk7ZqI4Ko3gIWXiL+XKisctpDz6D2VAbDHFY
         INL+FxemggHg6K66O6u4hMI9Sj0gFunje3+vKmfyRQ2cAc8Et7Wc9cdEMchWYpjaMyNm
         HkcOrNLwDANAWTz7tGP0WiRW8PzeelzC85+2VJczoAdf1eMtfyMvf2yhgqiCJRQWNmkP
         LXaIh8BDDSOSKxMvs4IZJTFM8rlVRwRA3gQrtgHCjdH8Xehzq8mow1SwnVOhlp5racst
         n60Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GRVTZ0+G5+e7Gux+3d1S4AXSA+7idOeLoopuLqwFUjs=;
        b=fM+6k1GdLi/atxrzceQAeAXzBCXmrNxvQ0pFX2wdE01DYlHoD9w2HKp2l3SaC2AaJ9
         c69g1EYm+ZnpFCmnRAAi5H58qQBRAHZFmL+YrjdA3u1UaoBpWMdQeO23bY0QP4HWV1kp
         oSl4L6AmiEmIJMKF2qMMHB29qddq2eqcjjp6m/DCLXH4vB5TI76c4M4nOqiZ/rhNAEV4
         p388mCCedGOVDD5CAnKmKmkUYfnhFd26arOgwqSK4FhDLDW9lbQnOkGRcyYeH5s/Ikuq
         QBFRgqOJKICRM1X6nydnVYKdsKzoVPPI9eWyPTevJ2aaZ5QOINby8K7jm1lAn1eTbSm+
         uBcg==
X-Gm-Message-State: AOAM531swHR0Fs4meooHZNVpQLgNuvoC4vfXgf9ZL3/dwJwRQgwrE2Hl
        0LM1tD6CabaS9c5JGqnWZ+evpg==
X-Google-Smtp-Source: ABdhPJxTplvkcmM/KoCmkb4Jc8WHOFJRl8ThWa3noqUWCPbYK9ytlkapINHoqlxpCiqpGztyBSJVhA==
X-Received: by 2002:a05:6830:2314:: with SMTP id u20mr3092642ote.259.1603294983226;
        Wed, 21 Oct 2020 08:43:03 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id n1sm670421otr.16.2020.10.21.08.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 08:43:02 -0700 (PDT)
Date:   Wed, 21 Oct 2020 10:38:01 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFT PATCH] arm64: dts: sdm845: Add iommus property to qup
Message-ID: <20201021153801.GG6705@builder.lan>
References: <20201020150301.3259814-1-bjorn.andersson@linaro.org>
 <20201021065033.GC9746@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201021065033.GC9746@vkoul-mobl>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 21 Oct 01:50 CDT 2020, Vinod Koul wrote:

> Hi Bjorn, Steve,
> 
> On 20-10-20, 08:03, Bjorn Andersson wrote:
> > From: Stephen Boyd <swboyd@chromium.org>
> > 
> > The SMMU that sits in front of the QUP needs to be programmed properly
> > so that the i2c geni driver can allocate DMA descriptors. Failure to do
> > this leads to faults when using devices such as an i2c touchscreen where
> > the transaction is larger than 32 bytes and we use a DMA buffer.
> 
> So I tried this and results in reboot for me when I use it in GSI
> driver in RB3. I seem to already have the iommu properties [1] but values
> are different
> 
> [1]: https://git.linaro.org/people/vinod.koul/kernel.git/commit/?h=topic/gsi3-db&id=385edef08d55432a40fc9a8ae1f49248d5417a92

Thanks for the testing, I was hoping to cover the two related streams in
one go - but in a discussion with Sai yesterday we concluded that it
would be better to just pinpoint the one stream that we know is relevant
for us. Hopefully this is the cause for the crash you're seeing as
well...

I will resend this in line with our discussion.

Thanks,
Bjorn

> 
> > arm-smmu 15000000.iommu: Unexpected global fault, this could be serious
> > arm-smmu 15000000.iommu:         GFSR 0x00000002, GFSYNR0 0x00000002, GFSYNR1 0x000006c0, GFSYNR2 0x00000000
> > 
> > Add the right SID and mask so this works.
> > 
> > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> > [bjorn: Define for second QUP as well]
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > ---
> >  arch/arm64/boot/dts/qcom/sdm845.dtsi | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > index 8eb5a31346d2..7d635bc919cb 100644
> > --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > @@ -811,6 +811,7 @@ qupv3_id_0: geniqup@8c0000 {
> >  			clock-names = "m-ahb", "s-ahb";
> >  			clocks = <&gcc GCC_QUPV3_WRAP_0_M_AHB_CLK>,
> >  				 <&gcc GCC_QUPV3_WRAP_0_S_AHB_CLK>;
> > +			iommus = <&apps_smmu 0x0 0x3>;
> >  			#address-cells = <2>;
> >  			#size-cells = <2>;
> >  			ranges;
> > @@ -1119,6 +1120,7 @@ qupv3_id_1: geniqup@ac0000 {
> >  			clock-names = "m-ahb", "s-ahb";
> >  			clocks = <&gcc GCC_QUPV3_WRAP_1_M_AHB_CLK>,
> >  				 <&gcc GCC_QUPV3_WRAP_1_S_AHB_CLK>;
> > +			iommus = <&apps_smmu 0x6c0 0x3>;
> >  			#address-cells = <2>;
> >  			#size-cells = <2>;
> >  			ranges;
> > -- 
> > 2.28.0
> 
> -- 
> ~Vinod

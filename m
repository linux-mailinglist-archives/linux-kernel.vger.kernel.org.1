Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC3F1300CE1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 20:56:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728568AbhAVTsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 14:48:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728366AbhAVSht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 13:37:49 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B309C061786
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 10:37:09 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id w8so7070659oie.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 10:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oiwTUWFMiiTAag0lmijypi0pOjEKvSmh8EmQOS0n7Gc=;
        b=cpnwDGd8R6/JJHRmec+G6nc6gOBqjaPwi2aGFQNIjDJM7SgZOfO2gMn5najABtCGGk
         Fq1/SDPVd9FR3YgmnCy6Df5qwJ9cOh/Gd37sTFqZRM2FborxaPyylbfz6Q49HoXAWIz2
         w6fq+yQ1CumMJZf4XQ0KLc39d8G+JyPUP8xK+9NQO35aTAcX9NQ9+PgvzgrJ9UgqRNt6
         5vLiw+aRoWepI9MyCNSWCtV4DB6UY6gcJhKgIi58HN6uaCCmb6O1gqU0RSv2Go7bxDjM
         F5OMSVS8CjUfrd8sHeAQ1Z2hqf0MQFf0KDK48Ka5QovqiI0jzv9g5Rw4LVFCrLN6Zaru
         e/dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oiwTUWFMiiTAag0lmijypi0pOjEKvSmh8EmQOS0n7Gc=;
        b=qaAcxgl89yblMYtSptPrpdkcq/s2po4PFBfS9g9s+jvr9txKH9osTKBWH58kaGkdoi
         1aFiUNQX2oqQteRRy6hyyEBQR1CDS00dYIDh3rhvPYHCEPP5wo8NDhh81jRC4T0pfxgh
         abkfkBKwP417qBfa2P3Mfprdvh6A9oo7DdodppIuTYNyGaFRPwww4g6oaHCtjO3ojHsv
         1johRLeJ/m3ls/r11j4WYoAvAMHN5s9lghwfhAhQ127hHGbsFT4yIL1ZFL44MZN4w3hS
         Et4W0CFkf0WT4teaXT3DBcysoyZynb6MY1vWyCvGfLZA+sUkDWF7I1Z05kvQ/BDwce4B
         AtKg==
X-Gm-Message-State: AOAM533y7aFidBNjP+VMQQwdrTT9odzKLXP24qZULX2AB+3JbTVHhWjm
        AfWmKXRmOEU05PRRjAMCLnHfY7RLX49bYw==
X-Google-Smtp-Source: ABdhPJwKAvyk3ThKI943yqpMg2u8a94sfT2RZdHPFBpX0QAr4RcLE8Sy3H4is4Db3CxyY4Bwld/d/Q==
X-Received: by 2002:aca:3784:: with SMTP id e126mr4145267oia.170.1611340628453;
        Fri, 22 Jan 2021 10:37:08 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id b19sm1852449oib.6.2021.01.22.10.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 10:37:07 -0800 (PST)
Date:   Fri, 22 Jan 2021 12:37:06 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Jonathan McDowell <noodles@earth.li>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: qcom: add prng definition to ipq806x
Message-ID: <YAsbUsLuDuDiqwFU@builder.lan>
References: <20200705142544.GA3389@earth.li>
 <20201129185022.GT32650@earth.li>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201129185022.GT32650@earth.li>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 29 Nov 12:50 CST 2020, Jonathan McDowell wrote:

> Gentle poke; did this just get missed or is there some reason not to
> apply it?
> 

There's no reason why this wasn't applied. I've picked it up now.

Thank you,
Bjorn

> On Sun, Jul 05, 2020 at 03:25:44PM +0100, Jonathan McDowell wrote:
> > Add missing prng definition for ipq806x SoC
> > 
> > Signed-off-by: Jonathan McDowell <noodles@earth.li>
> > ---
> >  arch/arm/boot/dts/qcom-ipq8064.dtsi | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
> > index b912da9a3ff3..22e0669b9133 100644
> > --- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
> > +++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
> > @@ -386,6 +386,13 @@ gsbi7_serial: serial@16640000 {
> >  			};
> >  		};
> >  
> > +		rng@1a500000 {
> > +			compatible = "qcom,prng";
> > +			reg = <0x1a500000 0x200>;
> > +			clocks = <&gcc PRNG_CLK>;
> > +			clock-names = "core";
> > +		};
> > +
> >  		sata_phy: sata-phy@1b400000 {
> >  			compatible = "qcom,ipq806x-sata-phy";
> >  			reg = <0x1b400000 0x200>;
> > -- 
> > 2.27.0
> > 
> 
> J.
> 
> -- 
> Revd Jonathan McDowell, ULC | Hail Eris. All hail Discordia. Fnord?

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94C362C7A94
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Nov 2020 19:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbgK2S1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 13:27:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbgK2S1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 13:27:04 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FCAEC0613CF;
        Sun, 29 Nov 2020 10:26:24 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id jx16so15779458ejb.10;
        Sun, 29 Nov 2020 10:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IZAEhmOpqu0W1t3GOmtpHDI5IkyGNnhym2Qzx8V0V+A=;
        b=JGWCkTeL/ENRNSwkSMSSiobsGMUVsknEknUC2WOv2lduBRMFpfwWqjWcqC846BOpyf
         j6oYyXe6Cg2g53GxslMylHa1/aJ/4EUM6jMtk5InBFsU8KoQHChvnaOYiVG5mTweYe5U
         GKthEup8p+FlL3nPZNu1Rrh3QHRKoXe2rBgB9FHJckOTO2at4blvgtrZrN7/fffZ1ihQ
         leOm1MUGblabevI2ttcC+2M0q86pkkjQqMXuwzSHq1fnVAOWhXOaUtNSHmhvnhU/USXg
         u6PQmGKIGPn5hG1VuzwJLspX5uBIxVn6uhRH0BNaoZAGz5LGbjqyccSQb/4Kyj8IG5Sz
         aGiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IZAEhmOpqu0W1t3GOmtpHDI5IkyGNnhym2Qzx8V0V+A=;
        b=ksr6EOTknOIjlAvIO0zhQzt+QCp4hApTdeAY3wZ4mIU5UV7CYFUVDmmuXAcbo7gqlK
         SNkgyQaELR6tiS8QDsK7tsgmaVCetdUlLg2ULd+D/0WIjvpQz+wGHXdi8RBpPIpEtKYq
         0eZ979eAFeVz7dEKNmRpGN6vu47L+yf0RlB35O6zwSFbBqry+KyTp/3ZSW/7QNlRwWzG
         J6hjVqndjacdRC7HogRf2jk98vPkBYa03VTNNLC5+csSbAkctkZ7KeACqY8KjecpLFwf
         kH6EbL7Fmb6eFDaaVphYwdQLZ40e2N/UXpLMGzyLJusjsQQAwz0FrMNrR2XXO2QcJ8y4
         5sUw==
X-Gm-Message-State: AOAM530DCYfXtgRlG7uM3oe6FsD40zuIz3X2KqnI4AzBMO80gwPHJ0IE
        TeTA7oUZ1txEzpcWWSI7LGo=
X-Google-Smtp-Source: ABdhPJzqsO+DLpGW9Y855WbjYuhemee3IcQMwlpMb8GXimfGOmu+D+rg8ToS9OYQHR+n3Ip1JVAgmw==
X-Received: by 2002:a17:906:768a:: with SMTP id o10mr17553218ejm.212.1606674383115;
        Sun, 29 Nov 2020 10:26:23 -0800 (PST)
Received: from BV030612LT ([188.24.159.61])
        by smtp.gmail.com with ESMTPSA id f19sm8019319edy.13.2020.11.29.10.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Nov 2020 10:26:22 -0800 (PST)
Date:   Sun, 29 Nov 2020 20:26:20 +0200
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 15/18] arm: dts: owl-s500-roseapplepi: Use UART clock
 from CMU
Message-ID: <20201129182620.GE696261@BV030612LT>
References: <cover.1605823502.git.cristian.ciocaltea@gmail.com>
 <976d0275aadbf691df87aba27a8a6be20ca3de53.1605823502.git.cristian.ciocaltea@gmail.com>
 <20201128073650.GB3077@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201128073650.GB3077@thinkpad>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 28, 2020 at 01:06:50PM +0530, Manivannan Sadhasivam wrote:
> On Fri, Nov 20, 2020 at 01:56:09AM +0200, Cristian Ciocaltea wrote:
> > Remove the UART fixed clock for RoseapplePi SBC and switch to using
> > the clock provided by CMU.
> > 
> > Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> 
> Please club this patch with the one adding CMU clock.

Done.

Thanks,
Cristi

> Thanks,
> Mani
> 
> > ---
> >  arch/arm/boot/dts/owl-s500-roseapplepi.dts | 7 -------
> >  1 file changed, 7 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/owl-s500-roseapplepi.dts b/arch/arm/boot/dts/owl-s500-roseapplepi.dts
> > index a2087e617cb2..800edf5d2d12 100644
> > --- a/arch/arm/boot/dts/owl-s500-roseapplepi.dts
> > +++ b/arch/arm/boot/dts/owl-s500-roseapplepi.dts
> > @@ -25,12 +25,6 @@ memory@0 {
> >  		device_type = "memory";
> >  		reg = <0x0 0x80000000>; /* 2GB */
> >  	};
> > -
> > -	uart2_clk: uart2-clk {
> > -		compatible = "fixed-clock";
> > -		clock-frequency = <921600>;
> > -		#clock-cells = <0>;
> > -	};
> >  };
> >  
> >  &twd_timer {
> > @@ -43,5 +37,4 @@ &timer {
> >  
> >  &uart2 {
> >  	status = "okay";
> > -	clocks = <&uart2_clk>;
> >  };
> > -- 
> > 2.29.2
> > 

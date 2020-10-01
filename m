Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC4727FA51
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 09:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731149AbgJAHcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 03:32:17 -0400
Received: from mail-ej1-f67.google.com ([209.85.218.67]:34741 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbgJAHcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 03:32:15 -0400
Received: by mail-ej1-f67.google.com with SMTP id gr14so6579125ejb.1;
        Thu, 01 Oct 2020 00:32:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GDPrLOwa2YDIt9rOahcyvMHm5jBbfc6BnJW0QyGmLM8=;
        b=VFD+mFrAfDoGofYfm6GZ/0Etu5F5uu6cKAMglsCymGrXXBgZszwIuVqFA3cM8JQrhh
         4pluvwCGv6FLm+FzUTNrmStPcvWmDf0vUdX/bF+E26tGwDnHNwPpger/EyCxPmxwMU3E
         84rAFl/EjlOAA5H6zKTfa4GHa0SO5SVpBVyJKpx8LjMb0MycjASuFW3tGASFRz/3WxEj
         5Te3TZZEHkxuF6+QNhYiPueWWCQYK5TEocUdHtE/jUveDKwMnDFNnCvqoWRd4MoIPw9x
         IXyfFsS394Tr6POrNEvXT1WWgPZDVBBiI/PZhhVwZOUmxbS4wH1VSLHY2goqGlcpIagZ
         FWYg==
X-Gm-Message-State: AOAM533kMi8IW6SnqLp+f3LBdtsdtvSYJyGMJuo76KYlDyr7aw076Kpb
        dtqQ20ybqPQ1OQmWsBTGL4g=
X-Google-Smtp-Source: ABdhPJzy3xgC6JU5blEUxdisaf5j4WjB6FYtXHbhypV1gfguZbrHfAJLc/4OCEMClu7A7rt/3kWtsw==
X-Received: by 2002:a17:906:4c89:: with SMTP id q9mr6954374eju.290.1601537531522;
        Thu, 01 Oct 2020 00:32:11 -0700 (PDT)
Received: from kozik-lap ([194.230.155.194])
        by smtp.googlemail.com with ESMTPSA id p7sm539897edq.5.2020.10.01.00.32.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Oct 2020 00:32:10 -0700 (PDT)
Date:   Thu, 1 Oct 2020 09:32:08 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        Stefan Riedmueller <s.riedmueller@phytec.de>,
        Robert Jones <rjones@gateworks.com>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 08/12] ARM: dts: imx6dl-pico: fix board compatibles
Message-ID: <20201001073208.GA5208@kozik-lap>
References: <20200930190143.27032-1-krzk@kernel.org>
 <20200930190143.27032-9-krzk@kernel.org>
 <0a0afea6-8cbb-3e89-5a4f-89660c942ca3@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0a0afea6-8cbb-3e89-5a4f-89660c942ca3@pengutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 01, 2020 at 09:22:03AM +0200, Ahmad Fatoum wrote:
> Hello Krzysztof,
> 
> On 9/30/20 9:01 PM, Krzysztof Kozlowski wrote:
> > There are four flavors of TechNexion PICO-IMX6 boards.  They have their
> > own DTSes, even though in Dwarf, Nymph and Pi are exactly the same.
> > They also have their own bindings so adjust the compatibles to match the
> > bindings.
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > 
> > ---
> > 
> > Changes since v1:
> > 1. None
> > ---
> >  arch/arm/boot/dts/imx6dl-pico-dwarf.dts  | 2 +-
> >  arch/arm/boot/dts/imx6dl-pico-hobbit.dts | 2 +-
> >  arch/arm/boot/dts/imx6dl-pico-nymph.dts  | 2 +-
> >  arch/arm/boot/dts/imx6dl-pico-pi.dts     | 2 +-
> >  4 files changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/imx6dl-pico-dwarf.dts b/arch/arm/boot/dts/imx6dl-pico-dwarf.dts
> > index 659a8e8714ea..d85b15a8c127 100644
> > --- a/arch/arm/boot/dts/imx6dl-pico-dwarf.dts
> > +++ b/arch/arm/boot/dts/imx6dl-pico-dwarf.dts
> > @@ -13,5 +13,5 @@
> >  
> >  / {
> >  	model = "TechNexion PICO-IMX6 DualLite/Solo Board and Dwarf baseboard";
> > -	compatible = "technexion,imx6dl-pico", "fsl,imx6dl";
> > +	compatible = "technexion,imx6dl-pico-dwarf", "fsl,imx6dl";
> 
> Could you change this to have all three compatibles ("technexion,imx6dl-pico-dwarf", "technexion,imx6dl-pico",
> "fsl,imx6dl") and likewise for the other files? 
> That way other firmware that reuses the Linux device tree files and match against the SoM compatible
> continues to work after update.
> 
> >  };
> > diff --git a/arch/arm/boot/dts/imx6dl-pico-hobbit.dts b/arch/arm/boot/dts/imx6dl-pico-hobbit.dts
> > index d7403c5c4337..08fedcbcc91b 100644
> > --- a/arch/arm/boot/dts/imx6dl-pico-hobbit.dts
> > +++ b/arch/arm/boot/dts/imx6dl-pico-hobbit.dts
> > @@ -13,5 +13,5 @@
> >  
> >  / {
> >  	model = "TechNexion PICO-IMX6 DualLite/Solo Board and Hobbit baseboard";
> > -	compatible = "technexion,imx6dl-pico", "fsl,imx6dl";
> > +	compatible = "technexion,imx6dl-pico-hobbit", "fsl,imx6dl";
> >  };
> > diff --git a/arch/arm/boot/dts/imx6dl-pico-nymph.dts b/arch/arm/boot/dts/imx6dl-pico-nymph.dts
> > index b282dbf953aa..32ccfc5d41ce 100644
> > --- a/arch/arm/boot/dts/imx6dl-pico-nymph.dts
> > +++ b/arch/arm/boot/dts/imx6dl-pico-nymph.dts
> > @@ -13,5 +13,5 @@
> >  
> >  / {
> >  	model = "TechNexion PICO-IMX6 DualLite/Solo Board and Nymph baseboard";
> > -	compatible = "technexion,imx6dl-pico", "fsl,imx6dl";
> > +	compatible = "technexion,imx6dl-pico-nymph", "fsl,imx6dl";
> >  };
> > diff --git a/arch/arm/boot/dts/imx6dl-pico-pi.dts b/arch/arm/boot/dts/imx6dl-pico-pi.dts
> > index b7b1c07f96f3..4590e8ad9a91 100644
> > --- a/arch/arm/boot/dts/imx6dl-pico-pi.dts
> > +++ b/arch/arm/boot/dts/imx6dl-pico-pi.dts

The bindings, added in commit 53b61224ca40 ("dt-bindings: arm: fsl: Add
TechNexion boards"), describe that these are the only valid compatibles.
"technexion,imx6dl-pico" is not valid and would require changing the
bindings, thus breaking compatibility which you want to avoid.

The bindings, not what is present in DTS, is considered ABI.

Best regards,
Krzysztof

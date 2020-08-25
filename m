Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF5A1251322
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Aug 2020 09:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729457AbgHYHZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Aug 2020 03:25:46 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44259 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729322AbgHYHZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 03:25:43 -0400
Received: by mail-wr1-f67.google.com with SMTP id c15so11591512wrs.11;
        Tue, 25 Aug 2020 00:25:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2UDn8nshmtelV8H6R+gegKh3+mv7xE3Ee9qPVJXzBko=;
        b=S4RdN/vMMc0Coh78HuMqgbN43vnvU4MEkGp4iVIhYKM1Ntu2HrZNF2ZA55pqJethkB
         VQnR21o1ifR3bFsXjjuAKGABHsFPtUr0O22RQBLsi6pqP2JvCsgVCW9Q7E9M1oDKbKMy
         FKT/q+bRvuvYmWXozyNqoDnJ4qcummDtpNpqtlLVBXvB4ySCCVU9Am9vb8QA8rxh6Pb4
         3xqfvENrKTM95G/MOF2fhccDxFkKyfzuvUWfOnBDCHpinuRO9NCe94cnhQTDbPhUGrMj
         7Gdmd0uuShBNvc/gVFbbxyUq6G7HjhuxUD0GU7RUHgzOBtBD+/Cn+Wv2y8FRqUS7YusC
         XYeA==
X-Gm-Message-State: AOAM5326ljVnj3Mz7IkCzbHLXJPObxWqMbbr13/ZkCuHfvmaDGypJa6c
        Jr/6+kDl7QEPnfFNNtxe1t8=
X-Google-Smtp-Source: ABdhPJzAtbLQMnecXqAvMsqz572yNqZJ5Dk8OpUuLTfB3ohjDCMwvv1x50yQZ9ondRCQBmNzjHwp/A==
X-Received: by 2002:adf:9224:: with SMTP id 33mr9207502wrj.24.1598340341132;
        Tue, 25 Aug 2020 00:25:41 -0700 (PDT)
Received: from kozik-lap ([194.230.155.216])
        by smtp.googlemail.com with ESMTPSA id f10sm3717581wmj.37.2020.08.25.00.25.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Aug 2020 00:25:40 -0700 (PDT)
Date:   Tue, 25 Aug 2020 09:25:37 +0200
From:   "krzk@kernel.org" <krzk@kernel.org>
To:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Cc:     "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "han.xu@nxp.com" <han.xu@nxp.com>,
        "Anson.Huang@nxp.com" <Anson.Huang@nxp.com>,
        "yibin.gong@nxp.com" <yibin.gong@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "aford173@gmail.com" <aford173@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "richard@nod.at" <richard@nod.at>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "daniel.baluta@nxp.com" <daniel.baluta@nxp.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "jun.li@nxp.com" <jun.li@nxp.com>
Subject: Re: [PATCH 03/16] arm64: dts: imx8mm-beacon-som.dtsi: Align
 regulator names with schema
Message-ID: <20200825072537.GA5914@kozik-lap>
References: <20200824190701.8447-1-krzk@kernel.org>
 <20200824190701.8447-3-krzk@kernel.org>
 <fa042a4f670775f340e88fca8f363252112fd538.camel@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fa042a4f670775f340e88fca8f363252112fd538.camel@fi.rohmeurope.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 25, 2020 at 06:51:33AM +0000, Vaittinen, Matti wrote:
> Hello Krzysztof,
> 
> Just some questions - please ignore if I misunderstood the impact of
> the change.
> 
> On Mon, 2020-08-24 at 21:06 +0200, Krzysztof Kozlowski wrote:
> > Device tree schema expects regulator names to be lowercase.  This
> > fixes
> > dtbs_check warnings like:
> > 
> >     arch/arm64/boot/dts/freescale/imx8mn-ddr4-evk.dt.yaml: pmic@4b:
> > regulators:LDO1:regulator-name:0: 'LDO1' does not match '^ldo[1-6]$'
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > ---
> >  .../boot/dts/freescale/imx8mn-ddr4-evk.dts    | 22 +++++++++------
> > ----
> >  1 file changed, 11 insertions(+), 11 deletions(-)
> > 
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mn-ddr4-evk.dts
> > b/arch/arm64/boot/dts/freescale/imx8mn-ddr4-evk.dts
> > index a1e5483dbbbe..299caed5d46e 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mn-ddr4-evk.dts
> > +++ b/arch/arm64/boot/dts/freescale/imx8mn-ddr4-evk.dts
> > @@ -60,7 +60,7 @@
> >  
> >  		regulators {
> >  			buck1_reg: BUCK1 {
> > -				regulator-name = "BUCK1";
> > +				regulator-name = "buck1";
> 
> I am not against this change but I would expect seeing some other
> patches too? I guess this will change the regulator name in regulator
> core, right? So maybe I am mistaken but it looks to me this change is
> visible in suppliers, sysfs and debugfs too? Thus changing this sounds
> a bit like asking for a nose bleed :) Am I right that the impact of
> this change has been thoroughly tested? Are there any other patches
> (that I have not seen) related to this change?

Oh, crap, the names of regulators in the driver are lowercase, but they
use of_match_ptr for upper case. Seriously, why making a binding which
is contradictory to the driver implementation on the first day?

The driver goes with binding, right? One expects uppercase, other
lowercase...

And tell me, what is now the ABI? The binding or the incorrect
implementation?

> 
> >  				regulator-min-microvolt = <700000>;
> >  				regulator-max-microvolt = <1300000>;
> >  				regulator-boot-on;
> > @@ -69,7 +69,7 @@
> >  			};
> >  
> >  			buck2_reg: BUCK2 {
> > -				regulator-name = "BUCK2";
> > +				regulator-name = "buck2";
> >  				regulator-min-microvolt = <700000>;
> >  				regulator-max-microvolt = <1300000>;
> >  				regulator-boot-on;
> > @@ -79,14 +79,14 @@
> >  
> >  			buck3_reg: BUCK3 {
> >  				// BUCK5 in datasheet
> > -				regulator-name = "BUCK3";
> > +				regulator-name = "buck3";
> >  				regulator-min-microvolt = <700000>;
> >  				regulator-max-microvolt = <1350000>;
> >  			};
> >  
> >  			buck4_reg: BUCK4 {
> >  				// BUCK6 in datasheet
> > -				regulator-name = "BUCK4";
> > +				regulator-name = "buck4";
> >  				regulator-min-microvolt = <3000000>;
> >  				regulator-max-microvolt = <3300000>;
> >  				regulator-boot-on;
> > @@ -95,7 +95,7 @@
> >  
> >  			buck5_reg: BUCK5 {
> >  				// BUCK7 in datasheet
> > -				regulator-name = "BUCK5";
> > +				regulator-name = "buck5";
> 
> What I see in bd718x7-regulator.c for LDO6 desc is:
> 
>                         /* LDO6 is supplied by buck5 */
>                         .supply_name = "buck5",
> 
> So, is this change going to change the supply-chain for the board? Is
> this intended? (Or am I mistaken on what is the impact of regulator-
> name property?)

The names will take regulator names from the driver. The problem is with
matching the of_node.


Dear Rob,

Maybe you have an idea how to fix this driver-binding ABI
incompatibility? Or better just leave it?


Best regards,
Krzysztof


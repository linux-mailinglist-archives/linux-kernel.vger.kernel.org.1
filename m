Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F30D2B802C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 16:13:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbgKRPNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 10:13:12 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:43794 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726306AbgKRPNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 10:13:11 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0AIFD0ol120514;
        Wed, 18 Nov 2020 09:13:00 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1605712380;
        bh=fRXYfmpAlOx5yxugSGF8b53ScMrQg/M0H0yln2Mppu4=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=f1XIWSZIi0ocJcBSPysUUp3LioUsM0gCj9ohXCclw8G+Aqq01tBIC2ONZfAqTmin1
         8y7WYBtZjuF8QWBvIWaFuGUHPvQ4wgi3V2e/X0xjeiPPv9tYTTY1b0RITJ1rYo0Zqd
         VOyDN4hpY47FO1Yadj8RQuGqdgp/JO3Qrm0PljZs=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0AIFD0BN082253
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 18 Nov 2020 09:13:00 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 18
 Nov 2020 09:12:59 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 18 Nov 2020 09:12:59 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0AIFCxEK025577;
        Wed, 18 Nov 2020 09:12:59 -0600
Date:   Wed, 18 Nov 2020 09:12:59 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Grygorii Strashko <grygorii.strashko@ti.com>
CC:     Sekhar Nori <nsekhar@ti.com>, Tero Kristo <t-kristo@ti.com>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Faiz Abbas <faiz_abbas@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Andre Przywara <andre.przywara@arm.com>
Subject: Re: [PATCH v2 2/4] arm64: dts: ti: k3: squelch warnings regarding no
 #address-cells for interrupt-controller
Message-ID: <20201118151259.kpag44djji4ssiup@eldest>
References: <20201117161942.38754-1-nsekhar@ti.com>
 <20201117161942.38754-3-nsekhar@ti.com>
 <ab9658ef-c8a7-155b-acb1-effa872132ca@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ab9658ef-c8a7-155b-acb1-effa872132ca@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13:38-20201118, Grygorii Strashko wrote:
> Hi Rob,
> 
> On 17/11/2020 18:19, Sekhar Nori wrote:
> > With dtc 1.6.0, building TI device-tree files with W=2 results in warnings
> > like below for all interrupt controllers.
> > 
> > /bus@100000/bus@30000000/interrupt-controller1: Missing #address-cells in interrupt provider
> > 
> > Fix these by adding #address-cells = <0>; for all interrupt controllers in
> > TI device-tree files. Any other #address-cells value is really only needed
> > if interrupt-map property is being used (which is not the case for existing
> > TI device-tree files)
> > 
> > Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> > ---
> >   arch/arm64/boot/dts/ti/k3-am65-main.dtsi              |  5 +++++
> >   arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi            |  2 ++
> >   arch/arm64/boot/dts/ti/k3-am654-base-board.dts        |  1 +
> >   arch/arm64/boot/dts/ti/k3-j7200-main.dtsi             |  3 +++
> >   arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi       |  1 +
> >   arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts |  1 +
> >   arch/arm64/boot/dts/ti/k3-j721e-main.dtsi             | 11 +++++++++++
> >   arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi       |  3 +++
> >   8 files changed, 27 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> > index aa8725db0187..55aaa1404d7d 100644
> > --- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> > +++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> > @@ -440,6 +440,7 @@
> >   		interrupt-controller;
> >   		interrupt-parent = <&gic500>;
> >   		#interrupt-cells = <1>;
> > +		#address-cells = <0>;
> Does it really required or mandatory to have #address-cells = <0>; defined for interrupt-controller DT nodes which
> do not have child nodes and no "interrupt-map"?

Just to help clarify (I could be mistaken as well): is'nt the
interrupt map for user interrupt map nodes that refer to this
interrupt controller node to state they dont need a parent address
specifier - so are we claiming none of the users will have an
interrupt-map (now and never in the future as well) - we we might want
to explain why we think that is the case, and if we are expecting dtc
to deduce that (if so how?)?

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

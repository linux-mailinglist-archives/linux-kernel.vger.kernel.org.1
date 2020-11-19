Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB8952B93A9
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 14:28:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbgKSN2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 08:28:38 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:46538 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726830AbgKSN2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 08:28:37 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0AJDSUBH073557;
        Thu, 19 Nov 2020 07:28:30 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1605792510;
        bh=NmHTxc6v5JleLk2XjI7t/Qwbwxph9n0MfiEUudzpZPk=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=YR9RROB5VqEICfw34nrf0HUynAOMR6j1NK0MERT2940VLTz9GOwGMrxtVVK46iJap
         ziySFKw7BoeKeVcbWhU1qa0j7ImHkoOKok65ZSuUvhLd26806c1b6J8Uc0WgS3zb+v
         d4uKl0++1G4rhMkQU1xrNiP+YomKVAEi4xyjVjfc=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0AJDSUaF098788
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 19 Nov 2020 07:28:30 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 19
 Nov 2020 07:28:30 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 19 Nov 2020 07:28:29 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0AJDSTHE078591;
        Thu, 19 Nov 2020 07:28:29 -0600
Date:   Thu, 19 Nov 2020 07:28:29 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Grygorii Strashko <grygorii.strashko@ti.com>
CC:     Device Tree Mailing List <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        Tero Kristo <t-kristo@ti.com>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Faiz Abbas <faiz_abbas@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Andre Przywara <andre.przywara@arm.com>
Subject: Re: [PATCH v2 2/4] arm64: dts: ti: k3: squelch warnings regarding no
 #address-cells for interrupt-controller
Message-ID: <20201119132829.sr435jf6s4275q4i@boxlike>
References: <20201117161942.38754-1-nsekhar@ti.com>
 <20201117161942.38754-3-nsekhar@ti.com>
 <ab9658ef-c8a7-155b-acb1-effa872132ca@ti.com>
 <20201118151259.kpag44djji4ssiup@eldest>
 <18e41dba-a3dd-308a-605e-63b76ca638e5@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <18e41dba-a3dd-308a-605e-63b76ca638e5@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Punting over to Rob and DT team's wisdom..

On 13:17-20201119, Grygorii Strashko wrote:
> 
> 
> On 18/11/2020 17:12, Nishanth Menon wrote:
> > On 13:38-20201118, Grygorii Strashko wrote:
> > > Hi Rob,
> > > 
> > > On 17/11/2020 18:19, Sekhar Nori wrote:
> > > > With dtc 1.6.0, building TI device-tree files with W=2 results in warnings
> > > > like below for all interrupt controllers.
> > > > 
> > > > /bus@100000/bus@30000000/interrupt-controller1: Missing #address-cells in interrupt provider
> > > > 
> > > > Fix these by adding #address-cells = <0>; for all interrupt controllers in
> > > > TI device-tree files. Any other #address-cells value is really only needed
> > > > if interrupt-map property is being used (which is not the case for existing
> > > > TI device-tree files)
> > > > 
> > > > Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> > > > ---
> > > >    arch/arm64/boot/dts/ti/k3-am65-main.dtsi              |  5 +++++
> > > >    arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi            |  2 ++
> > > >    arch/arm64/boot/dts/ti/k3-am654-base-board.dts        |  1 +
> > > >    arch/arm64/boot/dts/ti/k3-j7200-main.dtsi             |  3 +++
> > > >    arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi       |  1 +
> > > >    arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts |  1 +
> > > >    arch/arm64/boot/dts/ti/k3-j721e-main.dtsi             | 11 +++++++++++
> > > >    arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi       |  3 +++
> > > >    8 files changed, 27 insertions(+)
> > > > 
> > > > diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> > > > index aa8725db0187..55aaa1404d7d 100644
> > > > --- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> > > > +++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> > > > @@ -440,6 +440,7 @@
> > > >    		interrupt-controller;
> > > >    		interrupt-parent = <&gic500>;
> > > >    		#interrupt-cells = <1>;
> > > > +		#address-cells = <0>;
> > > Does it really required or mandatory to have #address-cells = <0>; defined for interrupt-controller DT nodes which
> > > do not have child nodes and no "interrupt-map"?
> > 
> > Just to help clarify (I could be mistaken as well): is'nt the
> > interrupt map for user interrupt map nodes that refer to this
> > interrupt controller node to state they dont need a parent address
> > specifier - so are we claiming none of the users will have an
> > interrupt-map (now and never in the future as well) - we we might want
> > to explain why we think that is the case, and if we are expecting dtc
> > to deduce that (if so how?)?
> > 
> 
> The main reason I commented - is hope to get some clarification from DT maintainers.
> 90% of interrupt-controller nodes do not have #address-cells and I never seen in in GPIO nodes
> (most often is present in PCI and GIC nodes).
> and nobody seems fixing it. So, if we are going to move this direction it's reasonable to get clarification to be sure.
> 
> And there is no "never" here - #address-cells always can be added if really required.


OK - as a GPIO node, but as an interrupt-controller node, I was
looking at [1] and wondering if that was the precedence.

Yes, will be good to get direction from the DT maintainers on this
topic.

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/interrupt-controller/open-pic.txt

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

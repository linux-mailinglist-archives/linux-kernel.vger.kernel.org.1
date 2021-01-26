Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C388304E3B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 02:07:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404211AbhA0ASl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 19:18:41 -0500
Received: from foss.arm.com ([217.140.110.172]:48742 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728281AbhAZRJR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 12:09:17 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 23A5131B;
        Tue, 26 Jan 2021 08:39:28 -0800 (PST)
Received: from slackpad.fritz.box (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9E95F3F66E;
        Tue, 26 Jan 2021 08:39:26 -0800 (PST)
Date:   Tue, 26 Jan 2021 16:38:39 +0000
From:   Andre Przywara <andre.przywara@arm.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Grygorii Strashko <grygorii.strashko@ti.com>,
        Nishanth Menon <nm@ti.com>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org,
        Tero Kristo <t-kristo@ti.com>, Faiz Abbas <faiz_abbas@ti.com>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 2/4] arm64: dts: ti: k3: squelch warnings regarding
 no #address-cells for interrupt-controller
Message-ID: <20210126163839.57491132@slackpad.fritz.box>
In-Reply-To: <20210126000108.GA1267192@robh.at.kernel.org>
References: <20201117161942.38754-1-nsekhar@ti.com>
        <20201117161942.38754-3-nsekhar@ti.com>
        <ab9658ef-c8a7-155b-acb1-effa872132ca@ti.com>
        <20201118151259.kpag44djji4ssiup@eldest>
        <18e41dba-a3dd-308a-605e-63b76ca638e5@ti.com>
        <20210126000108.GA1267192@robh.at.kernel.org>
Organization: Arm Ltd.
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.31; x86_64-slackware-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Jan 2021 18:01:08 -0600
Rob Herring <robh@kernel.org> wrote:

Hi,

> On Thu, Nov 19, 2020 at 01:17:36PM +0200, Grygorii Strashko wrote:
> > 
> > 
> > On 18/11/2020 17:12, Nishanth Menon wrote:  
> > > On 13:38-20201118, Grygorii Strashko wrote:  
> > > > Hi Rob,
> > > > 
> > > > On 17/11/2020 18:19, Sekhar Nori wrote:  
> > > > > With dtc 1.6.0, building TI device-tree files with W=2 results in warnings
> > > > > like below for all interrupt controllers.
> > > > > 
> > > > > /bus@100000/bus@30000000/interrupt-controller1: Missing #address-cells in interrupt provider
> > > > > 
> > > > > Fix these by adding #address-cells = <0>; for all interrupt controllers in
> > > > > TI device-tree files. Any other #address-cells value is really only needed
> > > > > if interrupt-map property is being used (which is not the case for existing
> > > > > TI device-tree files)
> > > > > 
> > > > > Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> > > > > ---
> > > > >    arch/arm64/boot/dts/ti/k3-am65-main.dtsi              |  5 +++++
> > > > >    arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi            |  2 ++
> > > > >    arch/arm64/boot/dts/ti/k3-am654-base-board.dts        |  1 +
> > > > >    arch/arm64/boot/dts/ti/k3-j7200-main.dtsi             |  3 +++
> > > > >    arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi       |  1 +
> > > > >    arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts |  1 +
> > > > >    arch/arm64/boot/dts/ti/k3-j721e-main.dtsi             | 11 +++++++++++
> > > > >    arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi       |  3 +++
> > > > >    8 files changed, 27 insertions(+)
> > > > > 
> > > > > diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> > > > > index aa8725db0187..55aaa1404d7d 100644
> > > > > --- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> > > > > +++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> > > > > @@ -440,6 +440,7 @@
> > > > >    		interrupt-controller;
> > > > >    		interrupt-parent = <&gic500>;
> > > > >    		#interrupt-cells = <1>;
> > > > > +		#address-cells = <0>;  
> > > > Does it really required or mandatory to have #address-cells = <0>; defined for interrupt-controller DT nodes which
> > > > do not have child nodes and no "interrupt-map"?  
> > > 
> > > Just to help clarify (I could be mistaken as well): is'nt the
> > > interrupt map for user interrupt map nodes that refer to this
> > > interrupt controller node to state they dont need a parent address
> > > specifier - so are we claiming none of the users will have an
> > > interrupt-map (now and never in the future as well) - we we might want
> > > to explain why we think that is the case, and if we are expecting dtc
> > > to deduce that (if so how?)?
> > >   
> > 
> > The main reason I commented - is hope to get some clarification from DT maintainers.
> > 90% of interrupt-controller nodes do not have #address-cells and I never seen in in GPIO nodes
> > (most often is present in PCI and GIC nodes).
> > and nobody seems fixing it. So, if we are going to move this direction it's reasonable to get clarification to be sure.
> > 
> > And there is no "never" here - #address-cells always can be added if really required.  
> 
> Once required, how does one figure that out? It's not obvious and 
> requires booting. So we need something at build time. I'm okay with 
> loosening the check as long as it warns when a interrupt parent phandle 
> in an interrupt-map is missing '#address-cells'.

So I think the rationale for requiring #address-cells is that the usage
of an interrupt in an interrupt-map can be totally disconnected from
the actual interrupt controller node. Typically the controller is in
the .dtsi, but an interrupt map could be anywhere, down in some
board .dts, or even some "common peripherals" intermediate .dts.
Possibly even in an overlay (I2C IRQ lines?).

So while not having this property works today, for your board, it might
surprisingly break for someone else. And those things are hard to find
(unless you know what you are looking for).
Been there, done that with the VExpress DTs, and that was the reason I
pushed for more tests.

On top of that is the standard's default value of "2" for
#address-cells, which Linux observes in this case. That leads to
somewhat surprising results when interpreting interrupt-maps without an
explicit #address-cells (cost me a few hours to figure out back then!)

So given the already somewhat complicated nature of interrupt-maps I
think it's comparably little to ask for explicit #address-cells
properties, even though you might not immediately benefit from it.

> Now that I look back at the dtc change, I'm now confused why this 
> check got applied. Both David and I wanted changes in regards to 
> #address-cells. Either a separate check or part of interrupt-map checks. 
> And the interrupt-map check never got applied. Andre?

Yeah, I somewhat dropped the ball on this, after some iterations and a
partial merge. Will put it on my list to revive this.

Cheers,
Andre.

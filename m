Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5BA029ACC5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 14:07:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751825AbgJ0NHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 09:07:06 -0400
Received: from muru.com ([72.249.23.125]:46866 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2441395AbgJ0NHG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 09:07:06 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 17D1F807E;
        Tue, 27 Oct 2020 13:07:09 +0000 (UTC)
Date:   Tue, 27 Oct 2020 15:07:01 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Nishanth Menon <nm@ti.com>
Cc:     Peter Ujfalusi <peter.ujfalusi@ti.com>, t-kristo@ti.com,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: ti: k3-j7200-main: Add McASP nodes
Message-ID: <20201027130701.GE5639@atomide.com>
References: <20201005074850.11247-1-peter.ujfalusi@ti.com>
 <20201005115805.d6yhykn7oc6x2tbu@charm>
 <5a9ed7d3-fcfd-edbf-fc34-112a7e55aa1c@ti.com>
 <20201005120837.75cwdmcpvzbvayq7@kinfolk>
 <d0e05389-9bd1-92a9-9624-4e9ac02a6a52@ti.com>
 <20201026145031.ggfugctq65zvgwp2@dismiss>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201026145031.ggfugctq65zvgwp2@dismiss>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Nishanth Menon <nm@ti.com> [201026 14:58]:
> On 13:38-20201007, Peter Ujfalusi wrote:
> [...]
> > >>>> +		status = "disabled";
> > >>>
> > >>> I see that there is inconsistent usage of "disabled" in our SoC.dts
> > >>>
> > >>> Our generic rule has been set them to disabled in board.dtsi
> > >>> McASP and DSS for existing SoC dts do not follow this.. which is a tad
> > >>> confusing.. (considering that not even all uarts come out on every board
> > >>> and every uart needs pinmux to function..)
> > >>
> > >> "keep them disabled because several required properties are not present
> > >> as they are board specific."
> > >>
> > >> In board file the enabled mcasp must be updated with options that is
> > >> required for operation. Without those option the McASP can not be
> > >> initialized.
> > >>
> > >> I think we have been revisiting the very same discussion every time we
> > >> have a new SoC with McASP...
> > >>
> > > 
> > > Yep.. This doe'snt really follow the rest of the SoC definition. [1]
> > > came to mind. The McASP discussion is a variation in the debate of the
> > > same.
> > 
> > Right, saying status = "okay" to a node which is missing required
> > properties (which can only be added by boards when the McASP is
> > connected up) does not sound a good solution.
> > How should the SW handle that? Fail the device probe and return with
> > -EINVAL or eat up the error and just probe with broken configuration.
> > Since the peripheral is not used, the broken configuration will not
> > cause much runtime errors as there will be no runtime use of the peripheral.
> > 
> > status of fail or fail-sss is not a good one either, their definition is:
> > "Indicates that the device is not operational. A serious error was
> > detected in the device, and it is unlikely to become operational without
> > repair."
> > 
> > The peripheral is fine, we are just trying to enable it without
> > providing the needed properties.
> > 
> > > I'd argue Serdes, or for that matter any IP that has a link to
> > > outside-the-SoC world has the same discussion point.
> > 
> > status = "disabled" is still the closest thing for everything which have
> > external dependencies. There is not much point to enable an i2c bus
> > without making sure that the signals are actually routed to the pins
> > where they supposed to go.

There is one reason to keep using the default status = "okay", for
i2c Linux can properly idle the device on boot without dependencies
to a certain boot loader version.

> > Or from other pow: a board design is not based on what is _not_
> > connected to outside world, but you actually _connect_ or _enable_
> > certain peripherals to external components, connectors.
> 
> OK, I will buy the argument that the current status thingy is a bit
> overloaded and does'nt imply the correct state we need it to imply with
> "fail-sss" either - I remember an argument for "fail-incomplete", but
> that never happened anyways.
> 
> Lets add this argument to the commit message and repost after testing
> on 5.10-rc1 please?

We should use status = "disabled" when the hardware is not accessible
to the SoC. That goes for things like secure world devices, and hardware
that relies on a missing external clock for example. For other things
we should just stick to the default which "okay" :)

Regards,

Tony

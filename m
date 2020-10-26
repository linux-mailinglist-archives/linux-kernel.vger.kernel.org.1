Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F460298FE4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 15:50:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1782064AbgJZOuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 10:50:39 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:37470 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1782056AbgJZOuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 10:50:39 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 09QEoWjc097759;
        Mon, 26 Oct 2020 09:50:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1603723832;
        bh=MsywtBpRGFNcQQmKNNDaQqYeG3MCDYWN9AXhYEX29OU=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=Y6nZxaqwJ13Rblm6S0bCz6Fo6bAJGkpm9MbdJINwqtthIWmBFUQt9fXtyYkyHEYz7
         1zm3GYk3KUoMNuObjy+fuPOqB1ijpoZU6ZgCFBbkHkMbfcjqls4F2KTyEMyIx+fwpF
         zWfLQm+iGflv+q/pOwItgF+ScTVCVfK1hjicPVQA=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 09QEoWIT051952
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 26 Oct 2020 09:50:32 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 26
 Oct 2020 09:50:31 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 26 Oct 2020 09:50:31 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 09QEoVEp095279;
        Mon, 26 Oct 2020 09:50:31 -0500
Date:   Mon, 26 Oct 2020 09:50:31 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
CC:     <t-kristo@ti.com>, <devicetree@vger.kernel.org>,
        <robh+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] arm64: dts: ti: k3-j7200-main: Add McASP nodes
Message-ID: <20201026145031.ggfugctq65zvgwp2@dismiss>
References: <20201005074850.11247-1-peter.ujfalusi@ti.com>
 <20201005115805.d6yhykn7oc6x2tbu@charm>
 <5a9ed7d3-fcfd-edbf-fc34-112a7e55aa1c@ti.com>
 <20201005120837.75cwdmcpvzbvayq7@kinfolk>
 <d0e05389-9bd1-92a9-9624-4e9ac02a6a52@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d0e05389-9bd1-92a9-9624-4e9ac02a6a52@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter,

On 13:38-20201007, Peter Ujfalusi wrote:
[...]
> >>>> +		status = "disabled";
> >>>
> >>> I see that there is inconsistent usage of "disabled" in our SoC.dts
> >>>
> >>> Our generic rule has been set them to disabled in board.dtsi
> >>> McASP and DSS for existing SoC dts do not follow this.. which is a tad
> >>> confusing.. (considering that not even all uarts come out on every board
> >>> and every uart needs pinmux to function..)
> >>
> >> "keep them disabled because several required properties are not present
> >> as they are board specific."
> >>
> >> In board file the enabled mcasp must be updated with options that is
> >> required for operation. Without those option the McASP can not be
> >> initialized.
> >>
> >> I think we have been revisiting the very same discussion every time we
> >> have a new SoC with McASP...
> >>
> > 
> > Yep.. This doe'snt really follow the rest of the SoC definition. [1]
> > came to mind. The McASP discussion is a variation in the debate of the
> > same.
> 
> Right, saying status = "okay" to a node which is missing required
> properties (which can only be added by boards when the McASP is
> connected up) does not sound a good solution.
> How should the SW handle that? Fail the device probe and return with
> -EINVAL or eat up the error and just probe with broken configuration.
> Since the peripheral is not used, the broken configuration will not
> cause much runtime errors as there will be no runtime use of the peripheral.
> 
> status of fail or fail-sss is not a good one either, their definition is:
> "Indicates that the device is not operational. A serious error was
> detected in the device, and it is unlikely to become operational without
> repair."
> 
> The peripheral is fine, we are just trying to enable it without
> providing the needed properties.
> 
> > I'd argue Serdes, or for that matter any IP that has a link to
> > outside-the-SoC world has the same discussion point.
> 
> status = "disabled" is still the closest thing for everything which have
> external dependencies. There is not much point to enable an i2c bus
> without making sure that the signals are actually routed to the pins
> where they supposed to go.
> 
> Or from other pow: a board design is not based on what is _not_
> connected to outside world, but you actually _connect_ or _enable_
> certain peripherals to external components, connectors.

OK, I will buy the argument that the current status thingy is a bit
overloaded and does'nt imply the correct state we need it to imply with
"fail-sss" either - I remember an argument for "fail-incomplete", but
that never happened anyways.

Lets add this argument to the commit message and repost after testing
on 5.10-rc1 please?

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

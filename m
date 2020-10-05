Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A39B4283564
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 14:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726015AbgJEMIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 08:08:43 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:38796 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbgJEMIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 08:08:43 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 095C8cPm047241;
        Mon, 5 Oct 2020 07:08:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601899718;
        bh=IYQh6NvcLHwQvpyUYx1AlXSUCurApS4nkon46rVr804=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=y2iAnCHIptattDu4Hk2vIuqHYDv1XkdWync2f+Zd8Up4WMZKgsgIWe6js+1pMdTzQ
         6l/GzK65c0ADBbn+KQbVYzbKH+z87Dht23riT3tlR8TBL4t3SuAZrF1oyLdx+rnc5y
         +gCd+IEwCJfCNWkQPIFW2ceI25PMnlekrUAf6tmg=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 095C8csV007784
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 5 Oct 2020 07:08:38 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 5 Oct
 2020 07:08:38 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 5 Oct 2020 07:08:38 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 095C8bMb051913;
        Mon, 5 Oct 2020 07:08:38 -0500
Date:   Mon, 5 Oct 2020 07:08:37 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
CC:     <t-kristo@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <robh+dt@kernel.org>
Subject: Re: [PATCH] arm64: dts: ti: k3-j7200-main: Add McASP nodes
Message-ID: <20201005120837.75cwdmcpvzbvayq7@kinfolk>
References: <20201005074850.11247-1-peter.ujfalusi@ti.com>
 <20201005115805.d6yhykn7oc6x2tbu@charm>
 <5a9ed7d3-fcfd-edbf-fc34-112a7e55aa1c@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5a9ed7d3-fcfd-edbf-fc34-112a7e55aa1c@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15:02-20201005, Peter Ujfalusi wrote:
> 
> 
> On 05/10/2020 14.58, Nishanth Menon wrote:
> > On 10:48-20201005, Peter Ujfalusi wrote:
> >> Add the nodes for McASP 0-2 and keep them disabled because several
> >> required properties are not present as they are board specific.
> >>
> >> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> >> ---
> >>  arch/arm64/boot/dts/ti/k3-j7200-main.dtsi | 57 +++++++++++++++++++++++
> >>  1 file changed, 57 insertions(+)
> >>
> >> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
> >> index 72d6496e88dd..cc6c2a81887a 100644
> >> --- a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
> >> +++ b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
> >> @@ -446,4 +446,61 @@ usb0: usb@6000000 {
> >>  			dr_mode = "otg";
> >>  		};
> >>  	};
> >> +x
> >> +	mcasp0: mcasp@02b00000 {
> >> +		compatible = "ti,am33xx-mcasp-audio";
> >> +		reg = <0x0 0x02b00000 0x0 0x2000>,
> >> +			<0x0 0x02b08000 0x0 0x1000>;
> >> +		reg-names = "mpu","dat";
> >> +		interrupts = <GIC_SPI 544 IRQ_TYPE_LEVEL_HIGH>,
> >> +				<GIC_SPI 545 IRQ_TYPE_LEVEL_HIGH>;
> >> +		interrupt-names = "tx", "rx";
> >> +
> >> +		dmas = <&main_udmap 0xc400>, <&main_udmap 0x4400>;
> >> +		dma-names = "tx", "rx";
> >> +
> >> +		clocks = <&k3_clks 174 40>;
> >> +		clock-names = "fck";
> >> +		power-domains = <&k3_pds 174 TI_SCI_PD_EXCLUSIVE>;
> >> +
> >> +		status = "disabled";
> > 
> > I see that there is inconsistent usage of "disabled" in our SoC.dts
> > 
> > Our generic rule has been set them to disabled in board.dtsi
> > McASP and DSS for existing SoC dts do not follow this.. which is a tad
> > confusing.. (considering that not even all uarts come out on every board
> > and every uart needs pinmux to function..)
> 
> "keep them disabled because several required properties are not present
> as they are board specific."
> 
> In board file the enabled mcasp must be updated with options that is
> required for operation. Without those option the McASP can not be
> initialized.
> 
> I think we have been revisiting the very same discussion every time we
> have a new SoC with McASP...
> 

Yep.. This doe'snt really follow the rest of the SoC definition. [1]
came to mind. The McASP discussion is a variation in the debate of the
same. I'd argue Serdes, or for that matter any IP that has a link to
outside-the-SoC world has the same discussion point.

[1] https://patchwork.kernel.org/patch/9304575/

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

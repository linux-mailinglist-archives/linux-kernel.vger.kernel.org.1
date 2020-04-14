Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64EDA1A7A3D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Apr 2020 14:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729567AbgDNMB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Apr 2020 08:01:29 -0400
Received: from gloria.sntech.de ([185.11.138.130]:40032 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439755AbgDNMBY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 08:01:24 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1jOKFk-0008I1-1j; Tue, 14 Apr 2020 14:01:20 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     Robin Murphy <robin.murphy@arm.com>, devicetree@vger.kernel.org,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: rockchip: remove bus-width from mmc nodes in rk3308.dtsi
Date:   Tue, 14 Apr 2020 14:01:19 +0200
Message-ID: <2038198.JSHZf9jCco@diego>
In-Reply-To: <f19b6b48-2950-abca-7dee-31c24118c3ef@gmail.com>
References: <20200413193652.1952-1-jbx6244@gmail.com> <20c81edc-247c-8db0-2b3c-a6c2fcad6b4e@arm.com> <f19b6b48-2950-abca-7dee-31c24118c3ef@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johan,

Am Dienstag, 14. April 2020, 13:45:00 CEST schrieb Johan Jonker:
> Hi Robin, Heiko,
> 
> If the Rockchip DT maintainers(= Heiko) agree that the new line for the
> 'bus-width' properties is that it should be placed in dtsi I'll produce
> a version 2. Please advise what should be done with the other Rockchip
> SoCs. Change them too?

(1) as Robin pointed out bus-width and pinctrl containing the bus-pins
    should be in the same file, as they describe parts of the same property
(2) essentially it is ok for pinctrl-defaults to live in the dtsi, when there
    are no pin variants ... (like the uartX_mY pin variants), so if you enable
    a node and only have essentially one pin variant to enable, this should
    live in the soc dtsi (like essentially all boards using 4-pin sdmmc
    and 8-pin emmc)
(3) Fixing other devicetrees is optional, so I won't oppose it of course
    but it's also not something "that must be done" ;-)


Heiko


> On 4/14/20 12:02 PM, Robin Murphy wrote:
> > On 2020-04-13 8:36 pm, Johan Jonker wrote:
> >> The 'bus-width' property for mmc nodes is defined both in
> >> 'rk3308.dtsi' and 'rk3308-roc-cc.dts'.
> >> In line with the other Rockchip SoCs define that in a user dts only,
> >> so remove all entries from mmc nodes in 'rk3308.dtsi'.
> > 
> > Judging by the pinctrl entries, these represent the number of pins
> > provided by the SoC itself. Obviously boards need to override that if
> > for some reason they don't wire up all the available data lines, but it
> > seems backwards to have every board restate the SoC's default value.
> > 
> > In fact, having brought it up, for this particular case the pinctrl
> > setting is inherently related to the bus width, so having one without
> > the other in either place doesn't smell right.
> > 
> > Robin.
> > 
> >> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> >> ---
> >>   arch/arm64/boot/dts/rockchip/rk3308.dtsi | 3 ---
> >>   1 file changed, 3 deletions(-)
> >>
> >> diff --git a/arch/arm64/boot/dts/rockchip/rk3308.dtsi
> >> b/arch/arm64/boot/dts/rockchip/rk3308.dtsi
> >> index a9b98555d..130771ede 100644
> >> --- a/arch/arm64/boot/dts/rockchip/rk3308.dtsi
> >> +++ b/arch/arm64/boot/dts/rockchip/rk3308.dtsi
> >> @@ -587,7 +587,6 @@
> >>           compatible = "rockchip,rk3308-dw-mshc",
> >> "rockchip,rk3288-dw-mshc";
> >>           reg = <0x0 0xff480000 0x0 0x4000>;
> >>           interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
> >> -        bus-width = <4>;
> >>           clocks = <&cru HCLK_SDMMC>, <&cru SCLK_SDMMC>,
> >>                <&cru SCLK_SDMMC_DRV>, <&cru SCLK_SDMMC_SAMPLE>;
> >>           clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
> >> @@ -602,7 +601,6 @@
> >>           compatible = "rockchip,rk3308-dw-mshc",
> >> "rockchip,rk3288-dw-mshc";
> >>           reg = <0x0 0xff490000 0x0 0x4000>;
> >>           interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
> >> -        bus-width = <8>;
> >>           clocks = <&cru HCLK_EMMC>, <&cru SCLK_EMMC>,
> >>                <&cru SCLK_EMMC_DRV>, <&cru SCLK_EMMC_SAMPLE>;
> >>           clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
> >> @@ -615,7 +613,6 @@
> >>           compatible = "rockchip,rk3308-dw-mshc",
> >> "rockchip,rk3288-dw-mshc";
> >>           reg = <0x0 0xff4a0000 0x0 0x4000>;
> >>           interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
> >> -        bus-width = <4>;
> >>           clocks = <&cru HCLK_SDIO>, <&cru SCLK_SDIO>,
> >>                <&cru SCLK_SDIO_DRV>, <&cru SCLK_SDIO_SAMPLE>;
> >>           clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
> >>
> 
> 





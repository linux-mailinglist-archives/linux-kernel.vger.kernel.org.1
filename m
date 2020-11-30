Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 658EB2C869B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 15:24:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbgK3OYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 09:24:21 -0500
Received: from relay11.mail.gandi.net ([217.70.178.231]:60377 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbgK3OYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 09:24:21 -0500
Received: from localhost (91-175-115-186.subs.proxad.net [91.175.115.186])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id BB34F100003;
        Mon, 30 Nov 2020 14:23:33 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Felipe Balbi <balbi@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 11/18] arm64: dts: marvell: cp11x: Harmonize xHCI DT
 nodes name
In-Reply-To: <20201111091552.15593-12-Sergey.Semin@baikalelectronics.ru>
References: <20201111091552.15593-1-Sergey.Semin@baikalelectronics.ru>
 <20201111091552.15593-12-Sergey.Semin@baikalelectronics.ru>
Date:   Mon, 30 Nov 2020 15:23:32 +0100
Message-ID: <87360qkjob.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> In accordance with the Generic xHCI bindings the corresponding node
> name is suppose to comply with the Generic USB HCD DT schema, which
> requires the USB nodes to have the name acceptable by the regexp:
> "^usb(@.*)?" . Make sure the "generic-xhci"-compatible nodes are
> correctly named.
>
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Applied on mvebu/dt64

Thanks,

Gregory
> ---
>  arch/arm64/boot/dts/marvell/armada-cp11x.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi b/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
> index 9dcf16beabf5..1e37ae181acf 100644
> --- a/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
> @@ -275,7 +275,7 @@ CP11X_LABEL(thermal): thermal-sensor@70 {
>  			};
>  		};
>  
> -		CP11X_LABEL(usb3_0): usb3@500000 {
> +		CP11X_LABEL(usb3_0): usb@500000 {
>  			compatible = "marvell,armada-8k-xhci",
>  			"generic-xhci";
>  			reg = <0x500000 0x4000>;
> @@ -287,7 +287,7 @@ CP11X_LABEL(usb3_0): usb3@500000 {
>  			status = "disabled";
>  		};
>  
> -		CP11X_LABEL(usb3_1): usb3@510000 {
> +		CP11X_LABEL(usb3_1): usb@510000 {
>  			compatible = "marvell,armada-8k-xhci",
>  			"generic-xhci";
>  			reg = <0x510000 0x4000>;
> -- 
> 2.28.0
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com

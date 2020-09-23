Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28D7A275B10
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 17:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbgIWPCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 11:02:34 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:45577 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726693AbgIWPCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 11:02:34 -0400
X-Originating-IP: 90.65.92.90
Received: from localhost (lfbn-lyo-1-1913-90.w90-65.abo.wanadoo.fr [90.65.92.90])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id B8E362000E;
        Wed, 23 Sep 2020 15:02:31 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Andre Heider <a.heider@gmail.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Pali =?utf-8?Q?Roh=C3=A1r?= <pali@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: marvell: espressobin: Simplify v7 ethernet port labeling
In-Reply-To: <20200908073050.535919-1-a.heider@gmail.com>
References: <20200908073050.535919-1-a.heider@gmail.com>
Date:   Wed, 23 Sep 2020 17:02:31 +0200
Message-ID: <873638iliw.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andre,

> Now that the switch ports have a label in the .dtsi, simplify the whole
> "switch0" block for the v7 dts files.
>
> Signed-off-by: Andre Heider <a.heider@gmail.com>

Applied on mvebu/dt64

Thanks,

Gregory

> ---
>
> This goes on top of Pali's patch:
> "arm64: dts: marvell: espressobin: Add ethernet switch aliases"
>
> The resulting .dtb files are the same.
>
>  .../armada-3720-espressobin-v7-emmc.dts        | 18 +++++-------------
>  .../dts/marvell/armada-3720-espressobin-v7.dts | 18 +++++-------------
>  2 files changed, 10 insertions(+), 26 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7-emmc.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7-emmc.dts
> index 215d2f702623..61d49d6a2a2a 100644
> --- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7-emmc.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7-emmc.dts
> @@ -28,20 +28,12 @@ aliases {
>  	};
>  };
>  
> -&switch0 {
> -	ports {
> -		switch0port1: port@1 {
> -			reg = <1>;
> -			label = "lan1";
> -			phy-handle = <&switch0phy0>;
> -		};
> +&switch0port1 {
> +	label = "lan1";
> +};
>  
> -		switch0port3: port@3 {
> -			reg = <3>;
> -			label = "wan";
> -			phy-handle = <&switch0phy2>;
> -		};
> -	};
> +&switch0port3 {
> +	label = "wan";
>  };
>  
>  /* U11 */
> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7.dts
> index b6f4af8ebafb..44dbe9a21cc7 100644
> --- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7.dts
> @@ -27,18 +27,10 @@ aliases {
>  	};
>  };
>  
> -&switch0 {
> -	ports {
> -		switch0port1: port@1 {
> -			reg = <1>;
> -			label = "lan1";
> -			phy-handle = <&switch0phy0>;
> -		};
> +&switch0port1 {
> +	label = "lan1";
> +};
>  
> -		switch0port3: port@3 {
> -			reg = <3>;
> -			label = "wan";
> -			phy-handle = <&switch0phy2>;
> -		};
> -	};
> +&switch0port3 {
> +	label = "wan";
>  };
> -- 
> 2.28.0
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com

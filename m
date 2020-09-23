Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61776275B0A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 17:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbgIWPCB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 23 Sep 2020 11:02:01 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:59109 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgIWPCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 11:02:01 -0400
X-Greylist: delayed 1434 seconds by postgrey-1.27 at vger.kernel.org; Wed, 23 Sep 2020 11:02:00 EDT
X-Originating-IP: 90.65.92.90
Received: from localhost (lfbn-lyo-1-1913-90.w90-65.abo.wanadoo.fr [90.65.92.90])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 7F8CC60023;
        Wed, 23 Sep 2020 15:01:54 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Pali =?utf-8?Q?Roh=C3=A1r?= <pali@kernel.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Andre Heider <a.heider@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: marvell: espressobin: Add ethernet switch aliases
In-Reply-To: <20200907112718.5994-1-pali@kernel.org>
References: <20200907112718.5994-1-pali@kernel.org>
Date:   Wed, 23 Sep 2020 17:01:54 +0200
Message-ID: <875z84iljx.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Pali,

> Espressobin boards have 3 ethernet ports and some of them got assigned more
> then one MAC address. MAC addresses are stored in U-Boot environment.
>
> Since commit a2c7023f7075c ("net: dsa: read mac address from DT for slave
> device") kernel can use MAC addresses from DT for particular DSA port.
>
> Currently Espressobin DTS file contains alias just for ethernet0.
>
> This patch defines additional ethernet aliases in Espressobin DTS files, so
> bootloader can fill correct MAC address for DSA switch ports if more MAC
> addresses were specified.
>
> DT alias ethernet1 is used for wan port, DT aliases ethernet2 and ethernet3
> are used for lan ports for both Espressobin revisions (V5 and V7).
>
> Fixes: 5253cb8c00a6f ("arm64: dts: marvell: espressobin: add ethernet alias")
> Signed-off-by: Pali Rohár <pali@kernel.org>


Applied on mvebu/fixes

Thanks,

Gregory

> ---
>  .../dts/marvell/armada-3720-espressobin-v7-emmc.dts  | 10 ++++++++--
>  .../boot/dts/marvell/armada-3720-espressobin-v7.dts  | 10 ++++++++--
>  .../boot/dts/marvell/armada-3720-espressobin.dtsi    | 12 ++++++++----
>  3 files changed, 24 insertions(+), 8 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7-emmc.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7-emmc.dts
> index 03733fd92732..215d2f702623 100644
> --- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7-emmc.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7-emmc.dts
> @@ -20,17 +20,23 @@
>  	compatible = "globalscale,espressobin-v7-emmc", "globalscale,espressobin-v7",
>  		     "globalscale,espressobin", "marvell,armada3720",
>  		     "marvell,armada3710";
> +
> +	aliases {
> +		/* ethernet1 is wan port */
> +		ethernet1 = &switch0port3;
> +		ethernet3 = &switch0port1;
> +	};
>  };
>  
>  &switch0 {
>  	ports {
> -		port@1 {
> +		switch0port1: port@1 {
>  			reg = <1>;
>  			label = "lan1";
>  			phy-handle = <&switch0phy0>;
>  		};
>  
> -		port@3 {
> +		switch0port3: port@3 {
>  			reg = <3>;
>  			label = "wan";
>  			phy-handle = <&switch0phy2>;
> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7.dts
> index 8570c5f47d7d..b6f4af8ebafb 100644
> --- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7.dts
> @@ -19,17 +19,23 @@
>  	model = "Globalscale Marvell ESPRESSOBin Board V7";
>  	compatible = "globalscale,espressobin-v7", "globalscale,espressobin",
>  		     "marvell,armada3720", "marvell,armada3710";
> +
> +	aliases {
> +		/* ethernet1 is wan port */
> +		ethernet1 = &switch0port3;
> +		ethernet3 = &switch0port1;
> +	};
>  };
>  
>  &switch0 {
>  	ports {
> -		port@1 {
> +		switch0port1: port@1 {
>  			reg = <1>;
>  			label = "lan1";
>  			phy-handle = <&switch0phy0>;
>  		};
>  
> -		port@3 {
> +		switch0port3: port@3 {
>  			reg = <3>;
>  			label = "wan";
>  			phy-handle = <&switch0phy2>;
> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi
> index b97218c72727..0775c16e0ec8 100644
> --- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi
> @@ -13,6 +13,10 @@
>  / {
>  	aliases {
>  		ethernet0 = &eth0;
> +		/* for dsa slave device */
> +		ethernet1 = &switch0port1;
> +		ethernet2 = &switch0port2;
> +		ethernet3 = &switch0port3;
>  		serial0 = &uart0;
>  		serial1 = &uart1;
>  	};
> @@ -120,7 +124,7 @@
>  			#address-cells = <1>;
>  			#size-cells = <0>;
>  
> -			port@0 {
> +			switch0port0: port@0 {
>  				reg = <0>;
>  				label = "cpu";
>  				ethernet = <&eth0>;
> @@ -131,19 +135,19 @@
>  				};
>  			};
>  
> -			port@1 {
> +			switch0port1: port@1 {
>  				reg = <1>;
>  				label = "wan";
>  				phy-handle = <&switch0phy0>;
>  			};
>  
> -			port@2 {
> +			switch0port2: port@2 {
>  				reg = <2>;
>  				label = "lan0";
>  				phy-handle = <&switch0phy1>;
>  			};
>  
> -			port@3 {
> +			switch0port3: port@3 {
>  				reg = <3>;
>  				label = "lan1";
>  				phy-handle = <&switch0phy2>;
> -- 
> 2.20.1
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com

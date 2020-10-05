Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC0AF283660
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 15:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbgJENOI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 5 Oct 2020 09:14:08 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:45233 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726123AbgJENOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 09:14:07 -0400
X-Originating-IP: 90.65.92.90
Received: from localhost (lfbn-lyo-1-1913-90.w90-65.abo.wanadoo.fr [90.65.92.90])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 94BB01BF218;
        Mon,  5 Oct 2020 13:14:04 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Pali =?utf-8?Q?Roh=C3=A1r?= <pali@kernel.org>,
        Andre Heider <a.heider@gmail.com>
Cc:     Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: marvell: espressobin: De-duplicate eMMC definitions
In-Reply-To: <20201002121352.ms6s3675tzzv77i2@pali>
References: <20200925085043.16389-1-pali@kernel.org> <a02747f7-8c9d-d445-fac3-afefe3a8ff4e@gmail.com> <20201002121352.ms6s3675tzzv77i2@pali>
Date:   Mon, 05 Oct 2020 15:14:04 +0200
Message-ID: <87mu10erxf.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pali,

> On Sunday 27 September 2020 08:40:41 Andre Heider wrote:
>> On 25/09/2020 10:50, Pali Rohár wrote:
>> > eMMC definitions in files armada-3720-espressobin-emmc.dts and
>> > armada-3720-espressobin-v7-emmc.dts is same. So move it into common
>> > armada-3720-espressobin.dtsi file with status "disabled".
>> > 
>> > This change simplifies eMMC variants of DTS files for Espressobin.
>> > 
>> > Signed-off-by: Pali Rohár <pali@kernel.org>
>> 
>> Reviewed-by: Andre Heider <a.heider@gmail.com>
>> Tested-by: Andre Heider <a.heider@gmail.com>
>> 
>> > ---
>> > Compiled DTB files armada-3720-espressobin-emmc.dtb and
>> > armada-3720-espressobin-v7-emmc.dtb are identical as without applying
>> > this patch.
>> > 
>> > Files armada-3720-espressobin.dtb and armada-3720-espressobin-v7.dtb
>> > are slightly different compared to version without this patch.
>> > 
>> > Main change is that numering in all "phandle" nodes is shifted and
>> > "sdhci0" node contains more attributes, but node is disabled.
>> > 
>> > 
>> > Andre, could you test this change on Espressobin (without eMMC) if
>> > everything is OK and there is no issue?
>> 
>> Look good to me, the node appears with status=disabled and everything seems
>> to work as before.
>
> Great!
>
> Gregory, would do you think about including this patch into next queue
> too?


I've applied on mvebu/dt64, however I am not sure I will be able to make
it merged for 5.10, but I will try.

Thanks,

Gregory


>
>> > 
>> > ---
>> >   .../marvell/armada-3720-espressobin-emmc.dts  | 18 --------------
>> >   .../armada-3720-espressobin-v7-emmc.dts       | 18 --------------
>> >   .../dts/marvell/armada-3720-espressobin.dtsi  | 24 +++++++++++++++++++
>> >   3 files changed, 24 insertions(+), 36 deletions(-)
>> > 
>> > diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-emmc.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-emmc.dts
>> > index ec72a11ed80f..5c4d8f379704 100644
>> > --- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-emmc.dts
>> > +++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-emmc.dts
>> > @@ -21,24 +21,6 @@
>> >   		     "marvell,armada3720", "marvell,armada3710";
>> >   };
>> > -/* U11 */
>> >   &sdhci0 {
>> > -	non-removable;
>> > -	bus-width = <8>;
>> > -	mmc-ddr-1_8v;
>> > -	mmc-hs400-1_8v;
>> > -	marvell,xenon-emmc;
>> > -	marvell,xenon-tun-count = <9>;
>> > -	marvell,pad-type = "fixed-1-8v";
>> > -
>> > -	pinctrl-names = "default";
>> > -	pinctrl-0 = <&mmc_pins>;
>> >   	status = "okay";
>> > -
>> > -	#address-cells = <1>;
>> > -	#size-cells = <0>;
>> > -	mmccard: mmccard@0 {
>> > -		compatible = "mmc-card";
>> > -		reg = <0>;
>> > -	};
>> >   };
>> > diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7-emmc.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7-emmc.dts
>> > index 6062a7df7342..4775a7eda481 100644
>> > --- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7-emmc.dts
>> > +++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7-emmc.dts
>> > @@ -36,24 +36,6 @@
>> >   	label = "wan";
>> >   };
>> > -/* U11 */
>> >   &sdhci0 {
>> > -	non-removable;
>> > -	bus-width = <8>;
>> > -	mmc-ddr-1_8v;
>> > -	mmc-hs400-1_8v;
>> > -	marvell,xenon-emmc;
>> > -	marvell,xenon-tun-count = <9>;
>> > -	marvell,pad-type = "fixed-1-8v";
>> > -
>> > -	pinctrl-names = "default";
>> > -	pinctrl-0 = <&mmc_pins>;
>> >   	status = "okay";
>> > -
>> > -	#address-cells = <1>;
>> > -	#size-cells = <0>;
>> > -	mmccard: mmccard@0 {
>> > -		compatible = "mmc-card";
>> > -		reg = <0>;
>> > -	};
>> >   };
>> > diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi
>> > index 3169a820558f..8a1c678bea5f 100644
>> > --- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi
>> > +++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi
>> > @@ -58,6 +58,30 @@
>> >   	phy-names = "sata-phy";
>> >   };
>> > +/* U11 */
>> > +&sdhci0 {
>> > +	/* Main DTS file for Espressobin is without eMMC */
>> > +	status = "disabled";
>> > +
>> > +	non-removable;
>> > +	bus-width = <8>;
>> > +	mmc-ddr-1_8v;
>> > +	mmc-hs400-1_8v;
>> > +	marvell,xenon-emmc;
>> > +	marvell,xenon-tun-count = <9>;
>> > +	marvell,pad-type = "fixed-1-8v";
>> > +
>> > +	pinctrl-names = "default";
>> > +	pinctrl-0 = <&mmc_pins>;
>> > +
>> > +	#address-cells = <1>;
>> > +	#size-cells = <0>;
>> > +	mmccard: mmccard@0 {
>> > +		compatible = "mmc-card";
>> > +		reg = <0>;
>> > +	};
>> > +};
>> > +
>> >   /* J1 */
>> >   &sdhci1 {
>> >   	wp-inverted;
>> > 
>> 

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com

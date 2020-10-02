Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D54A728120C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 14:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387718AbgJBMN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 08:13:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:34518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbgJBMN4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 08:13:56 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55AEA206C9;
        Fri,  2 Oct 2020 12:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601640835;
        bh=YZ5Gv+bg0FzRswfOJZLd3pzHGoc1cxOKgD4AO+Ebg5M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AkPz8yqKyZ0FtBuYuc1GW8YCD7L1OA1knoAL1kxgrm00e973Sr8CMk5YTcwLKoTF8
         xaiH2J69mwcRFBbt++VuHoX2t6SPl6juQW9XbPMEeh0QksiNN+is9jH8hRhalUQIm5
         o6cHeprlVJS/QL+anU/9hW21lEaKuOvVFmf18vmM=
Received: by pali.im (Postfix)
        id F29EAE79; Fri,  2 Oct 2020 14:13:52 +0200 (CEST)
Date:   Fri, 2 Oct 2020 14:13:52 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Andre Heider <a.heider@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>
Cc:     Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: marvell: espressobin: De-duplicate eMMC
 definitions
Message-ID: <20201002121352.ms6s3675tzzv77i2@pali>
References: <20200925085043.16389-1-pali@kernel.org>
 <a02747f7-8c9d-d445-fac3-afefe3a8ff4e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a02747f7-8c9d-d445-fac3-afefe3a8ff4e@gmail.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 27 September 2020 08:40:41 Andre Heider wrote:
> On 25/09/2020 10:50, Pali Rohár wrote:
> > eMMC definitions in files armada-3720-espressobin-emmc.dts and
> > armada-3720-espressobin-v7-emmc.dts is same. So move it into common
> > armada-3720-espressobin.dtsi file with status "disabled".
> > 
> > This change simplifies eMMC variants of DTS files for Espressobin.
> > 
> > Signed-off-by: Pali Rohár <pali@kernel.org>
> 
> Reviewed-by: Andre Heider <a.heider@gmail.com>
> Tested-by: Andre Heider <a.heider@gmail.com>
> 
> > ---
> > Compiled DTB files armada-3720-espressobin-emmc.dtb and
> > armada-3720-espressobin-v7-emmc.dtb are identical as without applying
> > this patch.
> > 
> > Files armada-3720-espressobin.dtb and armada-3720-espressobin-v7.dtb
> > are slightly different compared to version without this patch.
> > 
> > Main change is that numering in all "phandle" nodes is shifted and
> > "sdhci0" node contains more attributes, but node is disabled.
> > 
> > 
> > Andre, could you test this change on Espressobin (without eMMC) if
> > everything is OK and there is no issue?
> 
> Look good to me, the node appears with status=disabled and everything seems
> to work as before.

Great!

Gregory, would do you think about including this patch into next queue too?

> > 
> > ---
> >   .../marvell/armada-3720-espressobin-emmc.dts  | 18 --------------
> >   .../armada-3720-espressobin-v7-emmc.dts       | 18 --------------
> >   .../dts/marvell/armada-3720-espressobin.dtsi  | 24 +++++++++++++++++++
> >   3 files changed, 24 insertions(+), 36 deletions(-)
> > 
> > diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-emmc.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-emmc.dts
> > index ec72a11ed80f..5c4d8f379704 100644
> > --- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-emmc.dts
> > +++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-emmc.dts
> > @@ -21,24 +21,6 @@
> >   		     "marvell,armada3720", "marvell,armada3710";
> >   };
> > -/* U11 */
> >   &sdhci0 {
> > -	non-removable;
> > -	bus-width = <8>;
> > -	mmc-ddr-1_8v;
> > -	mmc-hs400-1_8v;
> > -	marvell,xenon-emmc;
> > -	marvell,xenon-tun-count = <9>;
> > -	marvell,pad-type = "fixed-1-8v";
> > -
> > -	pinctrl-names = "default";
> > -	pinctrl-0 = <&mmc_pins>;
> >   	status = "okay";
> > -
> > -	#address-cells = <1>;
> > -	#size-cells = <0>;
> > -	mmccard: mmccard@0 {
> > -		compatible = "mmc-card";
> > -		reg = <0>;
> > -	};
> >   };
> > diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7-emmc.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7-emmc.dts
> > index 6062a7df7342..4775a7eda481 100644
> > --- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7-emmc.dts
> > +++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7-emmc.dts
> > @@ -36,24 +36,6 @@
> >   	label = "wan";
> >   };
> > -/* U11 */
> >   &sdhci0 {
> > -	non-removable;
> > -	bus-width = <8>;
> > -	mmc-ddr-1_8v;
> > -	mmc-hs400-1_8v;
> > -	marvell,xenon-emmc;
> > -	marvell,xenon-tun-count = <9>;
> > -	marvell,pad-type = "fixed-1-8v";
> > -
> > -	pinctrl-names = "default";
> > -	pinctrl-0 = <&mmc_pins>;
> >   	status = "okay";
> > -
> > -	#address-cells = <1>;
> > -	#size-cells = <0>;
> > -	mmccard: mmccard@0 {
> > -		compatible = "mmc-card";
> > -		reg = <0>;
> > -	};
> >   };
> > diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi
> > index 3169a820558f..8a1c678bea5f 100644
> > --- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi
> > +++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi
> > @@ -58,6 +58,30 @@
> >   	phy-names = "sata-phy";
> >   };
> > +/* U11 */
> > +&sdhci0 {
> > +	/* Main DTS file for Espressobin is without eMMC */
> > +	status = "disabled";
> > +
> > +	non-removable;
> > +	bus-width = <8>;
> > +	mmc-ddr-1_8v;
> > +	mmc-hs400-1_8v;
> > +	marvell,xenon-emmc;
> > +	marvell,xenon-tun-count = <9>;
> > +	marvell,pad-type = "fixed-1-8v";
> > +
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&mmc_pins>;
> > +
> > +	#address-cells = <1>;
> > +	#size-cells = <0>;
> > +	mmccard: mmccard@0 {
> > +		compatible = "mmc-card";
> > +		reg = <0>;
> > +	};
> > +};
> > +
> >   /* J1 */
> >   &sdhci1 {
> >   	wp-inverted;
> > 
> 

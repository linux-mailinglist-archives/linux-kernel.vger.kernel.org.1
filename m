Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96DFF232289
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jul 2020 18:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbgG2QXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jul 2020 12:23:42 -0400
Received: from mail.z3ntu.xyz ([128.199.32.197]:43274 "EHLO mail.z3ntu.xyz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726341AbgG2QXm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 12:23:42 -0400
Received: by mail.z3ntu.xyz (Postfix, from userid 182)
        id 64790C8E45; Wed, 29 Jul 2020 16:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1596039819; bh=7px2oC8Rr1ovpP9dzxfQC/kDXj9f9FD7M6s/6OxDAF8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Q5hPbukLTWF94cfXnMKDlho+uP3P6HVIGUB5RGHKwb88+LEdoJoOjQqWY6iqHoZyf
         X0/cbpI4/E2k6i2nQpUrLNCi6A4NhRNyRjcuH1QqP8FCVV4ob38jL0mo9B/vBs+fZ4
         WoKRBcpYo+z6RggA2DNL4oge7kWjmjIg5jpW8InM=
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on arch-vps
X-Spam-Level: 
X-Spam-Status: No, score=0.9 required=5.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.4
Received: from g550jk.localnet (80-110-125-173.cgn.dynamic.surfer.at [80.110.125.173])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id AC2D5C8E45;
        Wed, 29 Jul 2020 16:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1596039811; bh=7px2oC8Rr1ovpP9dzxfQC/kDXj9f9FD7M6s/6OxDAF8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=WLpTBGH8HDIK79bA+Cbo4CzRFnaK1y3w4vMvd1mrN9fWSfsQZfl27xFef573kx7xZ
         Xz8kFd+bTHK1HZ34RGr34bBgaattlbOTsYCA0ipmxAJ4+2PobvkEwgNHY4ylqc/Bmk
         fn+QDnpdNUFB+Ii2LogswFM7B1sU3lAir6oF4Upc=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     linux-arm-kernel@lists.infradead.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: sun50i-pinephone: add led flash
Date:   Wed, 29 Jul 2020 18:23:30 +0200
Message-ID: <3310810.lkFDjMPtvk@g550jk>
In-Reply-To: <20200729123444.5t5cv47umhwu7jnd@gilmour.lan>
References: <20200725110812.199529-1-luca@z3ntu.xyz> <20200729123444.5t5cv47umhwu7jnd@gilmour.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

On Mittwoch, 29. Juli 2020 14:34:44 CEST Maxime Ripard wrote:
> Hi!
> 
> On Sat, Jul 25, 2020 at 01:08:12PM +0200, Luca Weiss wrote:
> > All revisions of the PinePhone have an SGM3140 LED flash. The gpios were
> > swapped on v1.0 of the board but this was fixed in later revisions.
> > 
> > Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> > ---
> > 
> >  .../boot/dts/allwinner/sun50i-a64-pinephone-1.0.dts   |  5 +++++
> >  .../boot/dts/allwinner/sun50i-a64-pinephone-1.1.dts   |  5 +++++
> >  .../boot/dts/allwinner/sun50i-a64-pinephone-1.2.dts   |  5 +++++
> >  .../boot/dts/allwinner/sun50i-a64-pinephone.dtsi      | 11 +++++++++++
> >  4 files changed, 26 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.0.dts
> > b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.0.dts index
> > 0c42272106afa..b579b03d4e026 100644
> > --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.0.dts
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.0.dts
> > @@ -9,3 +9,8 @@ / {
> > 
> >  	model = "Pine64 PinePhone Developer Batch (1.0)";
> >  	compatible = "pine64,pinephone-1.0", "allwinner,sun50i-a64";
> >  
> >  };
> > 
> > +
> > +&sgm3140 {
> > +	flash-gpios = <&pio 3 24 GPIO_ACTIVE_HIGH>; /* PD24 */
> > +	enable-gpios = <&pio 2 3 GPIO_ACTIVE_HIGH>; /* PC3 */
> > +};
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.1.dts
> > b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.1.dts index
> > 3e99a87e9ce52..8552587aac248 100644
> > --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.1.dts
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.1.dts
> > @@ -28,3 +28,8 @@ &backlight {
> > 
> >  	num-interpolated-steps = <50>;
> >  	default-brightness-level = <400>;
> >  
> >  };
> > 
> > +
> > +&sgm3140 {
> > +	flash-gpios = <&pio 2 3 GPIO_ACTIVE_HIGH>; /* PC3 */
> > +	enable-gpios = <&pio 3 24 GPIO_ACTIVE_HIGH>; /* PD24 */
> > +};
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.2.dts
> > b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.2.dts index
> > a9f5b670c9b82..ec77715ba4a2a 100644
> > --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.2.dts
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.2.dts
> > @@ -38,3 +38,8 @@ &lis3mdl {
> > 
> >  	interrupt-parent = <&pio>;
> >  	interrupts = <1 1 IRQ_TYPE_EDGE_RISING>; /* PB1 */
> >  
> >  };
> > 
> > +
> > +&sgm3140 {
> > +	flash-gpios = <&pio 2 3 GPIO_ACTIVE_HIGH>; /* PC3 */
> > +	enable-gpios = <&pio 3 24 GPIO_ACTIVE_HIGH>; /* PD24 */
> > +};
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> > b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi index
> > 25150aba749dc..e0bc1bcc1c1f3 100644
> > --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> > @@ -60,6 +60,17 @@ vibrator {
> > 
> >  		enable-gpios = <&pio 3 2 GPIO_ACTIVE_HIGH>; /* PD2 */
> >  		vcc-supply = <&reg_dcdc1>;
> >  	
> >  	};
> > 
> > +
> > +	sgm3140: led-controller {
> 
> The nodes should be ordered by node-name here

Will update the patch, forgot about that.

> > +		compatible = "sgmicro,sgm3140";
> > +		vin-supply = <&reg_dcdc1>;
> > +
> > +		sgm3140_flash: led {
> 
> What do you need the label for?

The label will be used for connecting the flash to the rear camera (which 
hasn't been upstreamed yet) using:

    flash-leds = <&sgm3140_flash>;

Hope that clears it up.

> 
> Thanks!
> Maxime

Regards
Luca



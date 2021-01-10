Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 963F52F099D
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 21:08:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbhAJUH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 15:07:29 -0500
Received: from gloria.sntech.de ([185.11.138.130]:43732 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726263AbhAJUH2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 15:07:28 -0500
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1kygz2-0000NH-Du; Sun, 10 Jan 2021 21:06:40 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>, Chen-Yu Tsai <wens@kernel.org>
Cc:     Chen-Yu Tsai <wens@kernel.org>, Rob Herring <robh@kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>
Subject: Re: [PATCH 3/3] arm64: dts: rockchip: rk3328: Add Radxa ROCK Pi E
Date:   Sun, 10 Jan 2021 21:06:39 +0100
Message-ID: <2241380.NG923GbCHz@diego>
In-Reply-To: <CAGb2v67=uO4HqRNEbhAJs2-d4mhL8URoijwE4ni9J8cYXrmAtQ@mail.gmail.com>
References: <20210110035846.9155-1-wens@kernel.org> <381648f9-d650-dddf-59e6-ef32d1e1bb43@gmail.com> <CAGb2v67=uO4HqRNEbhAJs2-d4mhL8URoijwE4ni9J8cYXrmAtQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am Sonntag, 10. Januar 2021, 16:37:15 CET schrieb Chen-Yu Tsai:
> > > +     vcc_sd: sdmmc-regulator {
> > > +             compatible = "regulator-fixed";
> > > +             gpio = <&gpio0 RK_PD6 GPIO_ACTIVE_LOW>;
> > > +             pinctrl-names = "default";
> > > +             pinctrl-0 = <&sdmmc0m1_pin>;
> >
> > > +             regulator-boot-on;
> > > +             regulator-name = "vcc_sd";
> >
> > regulator-name above other regulator properties
> 
> That is actually what I was used to, but some other rockchip dts files
> have all the properties sorted alphabetically. So I stuck with what I
> saw.

I try to keep it alphabetical except for the exceptions :-D .

regulator-name is such an exception. Similar to compatibles, the
regulator-name is an entry needed to see if you're at the right node,
so I really like it being the topmost regulator-foo property - just makes
reading easier.

(same for the compatible first, then regs, interrupts parts, as well
as "status-last")

But oftentimes, I just fix the ordering when applying - but seem to have
missed this somewhere in those "other Rockchip dts files" ;-) .


> > regulator voltage missing
> > make things as complete as possible
> >
> > from fixed-regulator.yaml:
> >
> > description:
> >   Any property defined as part of the core regulator binding, defined in
> >   regulator.yaml, can also be used. However a fixed voltage regulator is
> >   expected to have the regulator-min-microvolt and regulator-max-microvolt
> >   to be the same.
> 
> However this is not a real regulator; it is merely an on/off switch.
> I believe in this case it should just pass through the voltage from
> its upstream.

regulator-voltages are not marked required so can stay away if it's just
a dumb switch. I guess it's ok both ways and for individual board-
devicetrees the impact either way is minimal.


> > > +&i2c1 {
> > > +     status = "okay";
> > > +
> > > +     rk805: pmic@18 {
> > > +             compatible = "rockchip,rk805";
> > > +             reg = <0x18>;
> > > +             interrupt-parent = <&gpio2>;
> > > +             interrupts = <6 IRQ_TYPE_LEVEL_LOW>;
> >
> > > +             #clock-cells = <1>;
> >
> > all thing that start with "#" down the list
> 
> Is there a proper "preferred" sorting method defined somewhere?

I struggle with that often as well, but normally I'd do #clocks to clocks
with out "#", but really don't have a hard preference here.

especially as just ignoring the "#" would make #address-cells + #size-cells
look strangely sorted ... so more of a common sense thingy.


> > > +             eth_phy_int_pin: eth-phy-int-pin {
> > > +                     rockchip,pins = <1 RK_PD0 RK_FUNC_GPIO &pcfg_pull_down>;
> > > +             };
> > > +
> > > +             eth_phy_reset_pin: eth-phy-reset-pin {
> > > +                     rockchip,pins = <1 RK_PC2 RK_FUNC_GPIO &pcfg_pull_down>;
> > > +             };
> > > +     };
> > > +
> > > +     leds {
> > > +             led_pin: led-pin {
> > > +                     rockchip,pins = <3 RK_PA5 RK_FUNC_GPIO &pcfg_pull_none>;
> > > +             };
> > > +     };
> > > +
> > > +     pmic {
> > > +             pmic_int_l: pmic-int-l {
> > > +                     rockchip,pins = <2 RK_PA6 RK_FUNC_GPIO &pcfg_pull_up>;
> > > +             };
> > > +     };
> > > +
> >
> > > +     usb3 {
> >
> > usb
> >
> > Last numbers in nodenames are more related to the sort order then to
> > capabillity.
> > ie: mmc0, mmc1
> > All usb pin related things here.
> 
> I'd say it is more related to functionality in this case, as in "this group
> is for USB3 related pins". Makes more sense if the board supported both USB2
> and USB3.

I'd agree :-) ... especially as usb controllers on Rockchip boards are not
really numbered and I think we already have precedent for
usb2 -> usb version 2 pins in some other boards ;-)


> > > +     cap-sd-highspeed;
> > > +     disable-wp;
> > > +     pinctrl-names = "default";
> > > +     pinctrl-0 = <&sdmmc0_clk>, <&sdmmc0_cmd>, <&sdmmc0_dectn>, <&sdmmc0_bus4>;
> > > +     vmmc-supply = <&vcc_sd>;
> > > +     status = "okay";
> > > +};
> > > +
> >
> > > +&saradc {
> > > +     vref-supply = <&vcc_18>;
> > > +     status = "okay";
> > > +};
> >
> > What happened to the recovery key from the schematic?
> 
> I believe I originally planned on adding it, but failed to find a proper
> key event for it. Any suggestions?

Most boards seem to use the KEY_VENDOR keycode.


Heiko



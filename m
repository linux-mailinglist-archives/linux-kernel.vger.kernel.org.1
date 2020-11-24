Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C26BD2C33BD
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 23:16:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389289AbgKXWPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 17:15:20 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:48340 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389230AbgKXWPT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 17:15:19 -0500
Received: from andrew by vps0.lunn.ch with local (Exim 4.94)
        (envelope-from <andrew@lunn.ch>)
        id 1khgaT-008guk-Bs; Tue, 24 Nov 2020 23:15:01 +0100
Date:   Tue, 24 Nov 2020 23:15:01 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc:     Aryan Srivastava <Aryan.Srivastava@alliedtelesis.co.nz>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] ARM: dts: mvebu: Add device tree for RD-AC3X-48G4X2XL
 board
Message-ID: <20201124221501.GI2036992@lunn.ch>
References: <20201123035215.2239-1-aryan.srivastava@alliedtelesis.co.nz>
 <95016967-257b-e715-c907-0ac396e125ee@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95016967-257b-e715-c907-0ac396e125ee@alliedtelesis.co.nz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +&i2c0 {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&i2c0_pins>;
> > +	status = "okay";
> > +
> > +	eeprom@53{
> > +		compatible = "atmel,24c64";
> > +		reg = <0x53>;
> > +	};
> > +//	cpld@3c{
> > +//		compatible = "marvell,ac3x-cpld";
> > +//		reg = <0x3c>;
> > +//	};
> > +};
> 
> Question for the mvebu maintainers: We know there is a cpld with that 
> can be interfaced with over i2c. Other than detecting that it shows up 
> on the i2c bus we haven't done anything with it. We believe it 
> interfaces with some discrete IO and might mux the i2c interface towards 
> the SFP/QSFP cages.
> 
> Obviously there isn't a "marvell,ac3x-cpld" driver (yet) so I suggested 
> to Aryan that we put it in the dts to document its existence but leave 
> it commented out for now. Is this OK?

Hi Chris

I would just add a text comment, not DT. We have no idea what this
node will look like until we have the driver.

Is there an open source 'vendor crap driver'? Do we have anything to
go on?

     Andrew

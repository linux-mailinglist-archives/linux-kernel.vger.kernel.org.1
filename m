Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 940C72D985D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 13:55:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439166AbgLNMyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 07:54:41 -0500
Received: from foss.arm.com ([217.140.110.172]:47036 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438578AbgLNMyk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 07:54:40 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 013E11FB;
        Mon, 14 Dec 2020 04:53:55 -0800 (PST)
Received: from slackpad.fritz.box (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5299A3F66B;
        Mon, 14 Dec 2020 04:53:53 -0800 (PST)
Date:   Mon, 14 Dec 2020 12:53:43 +0000
From:   Andre Przywara <andre.przywara@arm.com>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Icenowy Zheng <icenowy@aosc.xyz>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        Shuosheng Huang <huangshuosheng@allwinnertech.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 19/21] arm64: dts: allwinner: Add Allwinner H616
 .dtsi file
Message-ID: <20201214125343.0cd1bc6a@slackpad.fritz.box>
In-Reply-To: <20201214095831.j63nks3fqxlaw75w@gilmour>
References: <20201211011934.6171-1-andre.przywara@arm.com>
 <20201211011934.6171-20-andre.przywara@arm.com>
 <20201214095831.j63nks3fqxlaw75w@gilmour>
Organization: Arm Ltd.
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.31; x86_64-slackware-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Dec 2020 10:58:31 +0100
Maxime Ripard <maxime@cerno.tech> wrote:

Hi,

> On Fri, Dec 11, 2020 at 01:19:32AM +0000, Andre Przywara wrote:
> > +	reserved-memory {
> > +		#address-cells = <2>;
> > +		#size-cells = <2>;
> > +		ranges;
> > +
> > +		/* 512KiB reserved for ARM Trusted Firmware (BL31)
> > */
> > +		secmon_reserved: secmon@40000000 {
> > +			reg = <0x0 0x40000000 0x0 0x80000>;
> > +			no-map;
> > +		};
> > +	};  
> 
> This should still be set by the firmware
> 
> > +		mmc0: mmc@4020000 {
> > +			compatible = "allwinner,sun50i-h616-mmc",
> > +				     "allwinner,sun50i-a100-mmc";
> > +			reg = <0x04020000 0x1000>;
> > +			clocks = <&ccu CLK_BUS_MMC0>, <&ccu
> > CLK_MMC0>;
> > +			clock-names = "ahb", "mmc";
> > +			resets = <&ccu RST_BUS_MMC0>;
> > +			reset-names = "ahb";
> > +			interrupts = <GIC_SPI 35
> > IRQ_TYPE_LEVEL_HIGH>;
> > +			pinctrl-names = "default";
> > +			pinctrl-0 = <&mmc0_pins>;
> > +			status = "disabled";
> > +			#address-cells = <1>;
> > +			#size-cells = <0>;
> > +		};  
> 
> Somewhat related: we shouldn't set the MMC speed flags in the drivers.
> This is biting us on the already supported SoCs, so it would be great
> to not repeat the same mistake with the new ones

Do you mean to list the "sd-uhs-sdr50" and friends properties here in
the DT?
What is the best practice here in terms putting them in the .dts vs.
the .dtsi? Surely the controller has limits, but bad traces on a board
could impose further restrictions, right? 
Though that's probably rare, so it sounds like a lot of churn to list
them in every board DT. So can we list everything in here (.dtsi), then
delete in those affected boards only?

Cheers,
Andre

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95A3D2FB6F9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 15:22:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388483AbhASJsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 04:48:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732409AbhASJVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 04:21:11 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41051C061573
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 01:20:27 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1l1nBZ-0004XH-NK; Tue, 19 Jan 2021 10:20:25 +0100
Subject: Re: [RFC PATCH] ARM: dts: imx6qdl: specify vcc-supply for NOP USB
 PHYs
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20201113152856.3758-1-a.fatoum@pengutronix.de>
 <20210119085700.GB4356@dragon>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Message-ID: <49756f17-c906-4fa5-4f0e-9297620c082e@pengutronix.de>
Date:   Tue, 19 Jan 2021 10:20:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210119085700.GB4356@dragon>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Shawn,

On 19.01.21 09:57, Shawn Guo wrote:
> On Fri, Nov 13, 2020 at 04:28:55PM +0100, Ahmad Fatoum wrote:
>> The SoC dtsi lists a NOP USB PHY for each of the two HSIC-only USB
>> controllers. Their device tree node doesn't indicate a vcc-supply
>> resulting in:
>>
>>   usb_phy_generic usbphynop1: supply vcc not found, using dummy regulator
>>   usb_phy_generic usbphynop2: supply vcc not found, using dummy regulator
> 
> So the patch is all for removing this kernel message, with introducing
> the following potential breakage?

Pretty much. Either:

 - We never fix the warning
 - We add an explicit dummy fixed-regulator, which doesn't reflect the HW
 - We reference the correct regulator and have the low risk of a
   non-upstream device tree breaking when they update both kernel,
   device tree and have an non-recommended CONFIG_REGULATOR_ANATOP=n

What do you think?

Cheers,
Ahmad

> 
> Shawn
> 
>>
>> warnings on boot up. The USB IP vcc-supply - separate from the vusb - is
>> hardwired to LDO_2P5[1], which we already have a device tree node for.
>> Reference it for the dummy "phy" as well.
>>
>> This will lead to breakage (probe deferment) for kernels that:
>>   - Use a HSIC USB controller
>>   - Use this new device tree
>>   - but have CONFIG_REGULATOR_ANATOP disabled
>>
>> Because while the regulator is always-on, it can't be resolved when
>> there is no driver for it.
>>
>> As there are
>>
>>   - no affected upstream device trees
>>   - existing device trees are unaffected without recompilation
>>   - disabling CONFIG_REGULATOR_ANATOP is explicitly a non-recommended
>>     configuration per symbol help text
>>
>> this potential breakage is deemed acceptable.
>>
>> [1]: i.MX 6Dual/6Quad Reference Manual, Rev. C,
>>      Figure 53-1. Power System Overview
>>
>> Cc: Frieder Schrempf <frieder.schrempf@kontron.de>
>> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
>> ---
>>  arch/arm/boot/dts/imx6qdl.dtsi | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
>> index 43edbf1156c7..22e4c142de13 100644
>> --- a/arch/arm/boot/dts/imx6qdl.dtsi
>> +++ b/arch/arm/boot/dts/imx6qdl.dtsi
>> @@ -131,11 +131,13 @@ pmu: pmu {
>>  
>>  	usbphynop1: usbphynop1 {
>>  		compatible = "usb-nop-xceiv";
>> +		vcc-supply = <&reg_vdd2p5>;
>>  		#phy-cells = <0>;
>>  	};
>>  
>>  	usbphynop2: usbphynop2 {
>>  		compatible = "usb-nop-xceiv";
>> +		vcc-supply = <&reg_vdd2p5>;
>>  		#phy-cells = <0>;
>>  	};
>>  
>> -- 
>> 2.28.0
>>
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

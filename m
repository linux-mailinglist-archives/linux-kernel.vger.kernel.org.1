Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 005BF2AD431
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 11:57:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbgKJK5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 05:57:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726280AbgKJK5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 05:57:42 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CDDBC0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 02:57:41 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1kcRLD-0003ml-TI; Tue, 10 Nov 2020 11:57:35 +0100
Subject: Re: [BUG] Error applying setting, reverse things back on lot of
 devices
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Corentin Labbe <clabbe.montjoie@gmail.com>, lgirdwood@gmail.com,
        mripard@kernel.org, linux-kernel@vger.kernel.org, wens@csie.org,
        broonie@kernel.org, linux-arm-kernel@lists.infradead.org,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
References: <20201021183149.GA8436@Red> <20201023134201.GA533@Red>
 <20201023203943.GA21435@Red> <20201024115307.GA2745@qmqm.qmqm.pl>
 <8a580d12-fa4a-6cd8-4d82-3e3b784e348b@pengutronix.de>
 <20201102202727.GA20042@qmqm.qmqm.pl>
 <124b90a8-72c7-c6cb-790f-7a22ef7510eb@pengutronix.de>
 <20201105025706.GE17266@qmqm.qmqm.pl>
 <7edc2b69-b77b-3546-63d7-108dab95fc91@pengutronix.de>
 <20201108170807.GA10914@qmqm.qmqm.pl>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Message-ID: <939ef8f1-9f64-d7c3-f765-ae7c2f1178de@pengutronix.de>
Date:   Tue, 10 Nov 2020 11:57:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201108170807.GA10914@qmqm.qmqm.pl>
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 11/8/20 6:08 PM, Micha³ Miros³aw wrote:
> On Thu, Nov 05, 2020 at 10:11:30AM +0100, Ahmad Fatoum wrote:
> It seems that final regulator_resolve_supply() is spinning recursively.
> Is the regulator name the same as its supply_name? Can you try the patch
> below to verify this?

Indeed that seems to be the case:

[    1.299103] stpmic1 1-0033: PMIC Chip Version: 0x10
[    1.307872] vddcore: 1200 <--> 1350 mV at 1200 mV, enabled
[    1.312173] stpmic1-regulator 5c002000.i2c:stpmic@33:regulators: Resolving supply buck1 for BUCK1
[    1.321083] stpmic1-regulator 5c002000.i2c:stpmic@33:regulators: Looking up buck1-supply from device tree
[    1.330838] stpmic1-regulator 5c002000.i2c:stpmic@33:regulators: Looking up buck1-supply property in node /soc/i2c@5c002000/stpmic@33/regulators failed
[    1.344650] vddcore: supplied by regulator-dummy
[    1.352016] vdd_ddr: 1350 mV, enabled
[    1.354421] stpmic1-regulator 5c002000.i2c:stpmic@33:regulators: Resolving supply buck2 for BUCK2
[    1.363341] stpmic1-regulator 5c002000.i2c:stpmic@33:regulators: Looking up buck2-supply from device tree
[    1.373124] stpmic1-regulator 5c002000.i2c:stpmic@33:regulators: Looking up buck2-supply property in node /soc/i2c@5c002000/stpmic@33/regulators failed
[    1.386921] vdd_ddr: supplied by regulator-dummy
[    1.394230] vdd: 3300 mV, enabled
[    1.396307] stpmic1-regulator 5c002000.i2c:stpmic@33:regulators: Resolving supply buck3 for BUCK3
[    1.405186] stpmic1-regulator 5c002000.i2c:stpmic@33:regulators: Looking up buck3-supply from device tree
[    1.414962] stpmic1-regulator 5c002000.i2c:stpmic@33:regulators: Looking up buck3-supply property in node /soc/i2c@5c002000/stpmic@33/regulators failed
[    1.428790] vdd: supplied by regulator-dummy
[    1.435880] v3v3: 3300 mV, enabled
[    1.438008] stpmic1-regulator 5c002000.i2c:stpmic@33:regulators: Resolving supply buck4 for BUCK4
[    1.446934] stpmic1-regulator 5c002000.i2c:stpmic@33:regulators: Looking up buck4-supply from device tree
[    1.456681] v3v3: supplied by 5V2
[    1.462533] v1v8_audio: 1800 mV, enabled
[    1.465218] stpmic1-regulator 5c002000.i2c:stpmic@33:regulators: Resolving supply ldo1 for LDO1
[    1.473906] stpmic1-regulator 5c002000.i2c:stpmic@33:regulators: Looking up ldo1-supply from device tree
[    1.483611] v1v8_audio: supplied by v3v3
[    1.490978] v3v3_hdmi: 3300 mV, enabled
[    1.493551] stpmic1-regulator 5c002000.i2c:stpmic@33:regulators: Resolving supply ldo2 for LDO2
[    1.502309] stpmic1-regulator 5c002000.i2c:stpmic@33:regulators: Looking up ldo2-supply from device tree
[    1.511959] v3v3_hdmi: supplied by 5V2
[    1.516320] vtt_ddr: override max_uV, 750000 -> 500000
[    1.523538] vtt_ddr: 500 mV, enabled
[    1.525881] stpmic1-regulator 5c002000.i2c:stpmic@33:regulators: Resolving supply ldo3 for LDO3
[    1.534555] stpmic1-regulator 5c002000.i2c:stpmic@33:regulators: Looking up ldo3-supply from device tree
[    1.544285] stpmic1-regulator 5c002000.i2c:stpmic@33:regulators: Looking up ldo3-supply property in node /soc/i2c@5c002000/stpmic@33/regulators failed
[    1.558017] vtt_ddr: supplied by regulator-dummy
[    1.562874] vdd_usb: 3300 mV, enabled
[    1.566585] stpmic1-regulator 5c002000.i2c:stpmic@33:regulators: Resolving supply ldo4 for LDO4
[    1.575297] stpmic1-regulator 5c002000.i2c:stpmic@33:regulators: Looking up ldo4-supply from device tree
[    1.585031] stpmic1-regulator 5c002000.i2c:stpmic@33:regulators: Looking up ldo4-supply property in node /soc/i2c@5c002000/stpmic@33/regulators failed
[    1.598716] vdd_usb: supplied by regulator-dummy
[    1.605030] edt_ft5x06 0-0038: touchscreen probe failed
[    1.606247] vdda: 2900 mV, enabled
[    1.612496] stpmic1-regulator 5c002000.i2c:stpmic@33:regulators: Resolving supply ldo5 for LDO5
[    1.621251] stpmic1-regulator 5c002000.i2c:stpmic@33:regulators: Looking up ldo5-supply from device tree
[    1.630888] vdda: supplied by 5V2
[    1.637155] v1v2_hdmi: 1200 mV, enabled
[    1.639742] stpmic1-regulator 5c002000.i2c:stpmic@33:regulators: Resolving supply ldo6 for LDO6
[    1.648473] stpmic1-regulator 5c002000.i2c:stpmic@33:regulators: Looking up ldo6-supply from device tree
[    1.658143] v1v2_hdmi: supplied by v3v3
[    1.664926] vref_ddr: at 500 mV, enabled
[    1.667597] stpmic1-regulator 5c002000.i2c:stpmic@33:regulators: Resolving supply vref_ddr for VREF_DDR
[    1.677055] stpmic1-regulator 5c002000.i2c:stpmic@33:regulators: Looking up vref_ddr-supply from device tree
[    1.687091] stpmic1-regulator 5c002000.i2c:stpmic@33:regulators: Looking up vref_ddr-supply property in node /soc/i2c@5c002000/stpmic@33/regulators failed
[    1.701181] stpmic1-regulator 5c002000.i2c:stpmic@33:regulators: Supply for VREF_DDR (vref_ddr) resolved to itself
[    1.711713] vref_ddr: unable to resolve supply
[    1.716413] bst_out: at 5000 mV, disabled
[    1.720445] stpmic1-regulator 5c002000.i2c:stpmic@33:regulators: Resolving supply vref_ddr for VREF_DDR
[    1.729920] stpmic1-regulator 5c002000.i2c:stpmic@33:regulators: Looking up vref_ddr-supply from device tree
[    1.739966] stpmic1-regulator 5c002000.i2c:stpmic@33:regulators: Looking up vref_ddr-supply property in node /soc/i2c@5c002000/stpmic@33/regulators failed
[    1.754044] stpmic1-regulator 5c002000.i2c:stpmic@33:regulators: Supply for VREF_DDR (vref_ddr) resolved to itself
[    1.764580] vref_ddr: unable to resolve supply
[    1.769108] stpmic1-regulator 5c002000.i2c:stpmic@33:regulators: Resolving supply boost for BOOST
[    1.778156] stpmic1-regulator 5c002000.i2c:stpmic@33:regulators: Looking up boost-supply from device tree
[    1.787919] bst_out: supplied by 5V2
[    1.791945] vbus_otg: at 5000 mV, disabled
[    1.795905] stpmic1-regulator 5c002000.i2c:stpmic@33:regulators: Resolving supply vref_ddr for VREF_DDR
[    1.805314] stpmic1-regulator 5c002000.i2c:stpmic@33:regulators: Looking up vref_ddr-supply from device tree
[    1.815360] stpmic1-regulator 5c002000.i2c:stpmic@33:regulators: Looking up vref_ddr-supply property in node /soc/i2c@5c002000/stpmic@33/regulators failed
[    1.829446] stpmic1-regulator 5c002000.i2c:stpmic@33:regulators: Supply for VREF_DDR (vref_ddr) resolved to itself
[    1.839987] vref_ddr: unable to resolve supply
[    1.844497] stpmic1-regulator 5c002000.i2c:stpmic@33:regulators: Resolving supply pwr_sw1 for VBUS_OTG
[    1.854003] stpmic1-regulator 5c002000.i2c:stpmic@33:regulators: Looking up pwr_sw1-supply from device tree
[    1.863959] vbus_otg: supplied by bst_out
[    1.868406] vbus_sw: at 5000 mV, disabled
[    1.872223] stpmic1-regulator 5c002000.i2c:stpmic@33:regulators: Resolving supply vref_ddr for VREF_DDR
[    1.881698] stpmic1-regulator 5c002000.i2c:stpmic@33:regulators: Looking up vref_ddr-supply from device tree
[    1.891731] stpmic1-regulator 5c002000.i2c:stpmic@33:regulators: Looking up vref_ddr-supply property in node /soc/i2c@5c002000/stpmic@33/regulators failed
[    1.905814] stpmic1-regulator 5c002000.i2c:stpmic@33:regulators: Supply for VREF_DDR (vref_ddr) resolved to itself
[    1.916362] vref_ddr: unable to resolve supply
[    1.920863] stpmic1-regulator 5c002000.i2c:stpmic@33:regulators: Resolving supply pwr_sw2 for SW_OUT
[    1.930192] stpmic1-regulator 5c002000.i2c:stpmic@33:regulators: Looking up pwr_sw2-supply from device tree
[    1.940131] vbus_sw: supplied by bst_out

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

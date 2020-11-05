Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 455A22A7A27
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 10:11:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730175AbgKEJLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 04:11:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725320AbgKEJLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 04:11:38 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 909D9C0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 01:11:38 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1kabIp-0002hD-Hs; Thu, 05 Nov 2020 10:11:31 +0100
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
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Message-ID: <7edc2b69-b77b-3546-63d7-108dab95fc91@pengutronix.de>
Date:   Thu, 5 Nov 2020 10:11:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201105025706.GE17266@qmqm.qmqm.pl>
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

On 11/5/20 3:57 AM, Micha³ Miros³aw wrote:
>>> Can you catch debug logs for the bootup in question? I'm not sure what's
>>> the failure mode in your case. I guess this is not a bypassed regulator?
>>
>> Boot up with v5.10-rc2 + your cf1ad559a2 ("regulator: defer probe when trying
>> to get voltage from unresolved supply") hangs:
>>
>> [    1.151489] stm32f7-i2c 40015000.i2c: STM32F7 I2C-0 bus adapter
>> [    1.180698] stpmic1 1-0033: PMIC Chip Version: 0x10
>> [    1.189526] vddcore: supplied by regulator-dummy
>> [    1.195633] vdd_ddr: supplied by regulator-dummy
>> [    1.201672] vdd: supplied by regulator-dummy
>> [    1.207452] v3v3: supplied by 5V2
>> [    1.211997] v1v8_audio: supplied by v3v3
>> [    1.218036] v3v3_hdmi: supplied by 5V2
>> [    1.223626] vtt_ddr: supplied by regulator-dummy
>> [    1.227107] vdd_usb: supplied by regulator-dummy
>> [    1.234532] vdda: supplied by 5V2
>> [    1.239497] v1v2_hdmi: supplied by v3v3
> [...]
> 
> Can you try with the patches I just sent and with debug logs enabled?
> 
> The first one just plugs a memory leak, but if there is some state
> changed/saved in the rdev->constraints (can't find that code, though),
> this might prevent it from being overwritten.
> 
> The second patch will just tell us if you hit the early resolve case.

Problem still persists. Early resolve case not hit:

[    1.231096] i2c /dev entries driver
[    1.258111] stm32f7-i2c 40015000.i2c: STM32F7 I2C-0 bus adapter
[    1.258348] edt_ft5x06 0-0038: Looking up vcc-supply from device tree
[    1.287207] stpmic1 1-0033: PMIC Chip Version: 0x10
[    1.295810] vddcore: 1200 <--> 1350 mV at 1200 mV, enabled
[    1.300108] stpmic1-regulator 5c002000.i2c:stpmic@33:regulators: Looking up buck1-supply from device tree
[    1.309747] stpmic1-regulator 5c002000.i2c:stpmic@33:regulators: Looking up buck1-supply property in node /soc/i2c@5c002000/stpmic@33/regulators failed
[    1.323526] vddcore: supplied by regulator-dummy
[    1.334951] vdd_ddr: 1350 mV, enabled
[    1.337356] stpmic1-regulator 5c002000.i2c:stpmic@33:regulators: Looking up buck2-supply from device tree
[    1.347016] stpmic1-regulator 5c002000.i2c:stpmic@33:regulators: Looking up buck2-supply property in node /soc/i2c@5c002000/stpmic@33/regulators failed
[    1.360805] vdd_ddr: supplied by regulator-dummy
[    1.372166] vdd: 3300 mV, enabled
[    1.374211] stpmic1-regulator 5c002000.i2c:stpmic@33:regulators: Looking up buck3-supply from device tree
[    1.383863] stpmic1-regulator 5c002000.i2c:stpmic@33:regulators: Looking up buck3-supply property in node /soc/i2c@5c002000/stpmic@33/regulators failed
[    1.397656] vdd: supplied by regulator-dummy
[    1.408473] v3v3: 3300 mV, enabled
[    1.410597] stpmic1-regulator 5c002000.i2c:stpmic@33:regulators: Looking up buck4-supply from device tree
[    1.420244] v3v3: supplied by 5V2
[    1.428843] v1v8_audio: 1800 mV, enabled
[    1.431502] stpmic1-regulator 5c002000.i2c:stpmic@33:regulators: Looking up ldo1-supply from device tree
[    1.441049] v1v8_audio: supplied by v3v3
[    1.451744] v3v3_hdmi: 3300 mV, enabled
[    1.454310] stpmic1-regulator 5c002000.i2c:stpmic@33:regulators: Looking up ldo2-supply from device tree
[    1.463864] v3v3_hdmi: supplied by 5V2
[    1.471367] vtt_ddr: override max_uV, 750000 -> 500000
[    1.478650] vtt_ddr: 500 mV, enabled
[    1.480958] stpmic1-regulator 5c002000.i2c:stpmic@33:regulators: Looking up ldo3-supply from device tree
[    1.490526] stpmic1-regulator 5c002000.i2c:stpmic@33:regulators: Looking up ldo3-supply property in node /soc/i2c@5c002000/stpmic@33/regulators failed
[    1.504227] vtt_ddr: supplied by regulator-dummy
[    1.513158] vdd_usb: 3300 mV, enabled
[    1.516875] stpmic1-regulator 5c002000.i2c:stpmic@33:regulators: Looking up ldo4-supply from device tree
[    1.526410] stpmic1-regulator 5c002000.i2c:stpmic@33:regulators: Looking up ldo4-supply property in node /soc/i2c@5c002000/stpmic@33/regulators failed
[    1.540133] vdd_usb: supplied by regulator-dummy
[    1.551741] vdda: 2900 mV, enabled
[    1.553864] stpmic1-regulator 5c002000.i2c:stpmic@33:regulators: Looking up ldo5-supply from device tree
[    1.563415] vdda: supplied by 5V2
[    1.572357] v1v2_hdmi: 1200 mV, enabled
[    1.574970] stpmic1-regulator 5c002000.i2c:stpmic@33:regulators: Looking up ldo6-supply from device tree
[    1.584441] v1v2_hdmi: supplied by v3v3
[    1.594492] vref_ddr: at 500 mV, enabled
[    1.597047] edt_ft5x06 0-0038: touchscreen probe failed
[    1.597211] stpmic1-regulator 5c002000.i2c:stpmic@33:regulators: Looking up vref_ddr-supply from device tree
[    1.612406] stpmic1-regulator 5c002000.i2c:stpmic@33:regulators: Looking up vref_ddr-supply property in node /soc/i2c@5c002000/stpmic@33/regulators failed


  [ snip - continues many times ]

[    6.699244] stpmic1-regulator 5c002000.i2c:stpmic@33:regulators: Looking up vref_ddr-supply property in node /soc/i2c@5c002000/stpmic@33/regulators failed
[    6.713312] stpmic1-regulator 5c002000.i2c:stpmic@33:regulators: Looking up vref_ddr-supply from device tree
[    6.723328] Kernel panic - not syncing: corrupted stack end detected inside scheduler
[    6.731288] CPU1: stopping
[    6.734028] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.10.0-rc2-00007-gd12735e25a7c-dirty #135
[    6.742882] Hardware name: STM32 (Device Tree Support)
[    6.748147] [<c010c05c>] (unwind_backtrace) from [<c0109ad0>] (show_stack+0x10/0x14)
[    6.756014] [<c0109ad0>] (show_stack) from [<c0727938>] (dump_stack+0x94/0xa8)
[    6.763368] [<c0727938>] (dump_stack) from [<c010a9b0>] (do_handle_IPI+0xf4/0x11c)
[    6.771075] [<c010a9b0>] (do_handle_IPI) from [<c010a9f0>] (ipi_handler+0x18/0x20)
[    6.778791] [<c010a9f0>] (ipi_handler) from [<c016bf7c>] (__handle_domain_irq+0x80/0xd4)
[    6.787034] [<c016bf7c>] (__handle_domain_irq) from [<c0421640>] (gic_handle_irq+0x70/0x84)
[    6.795540] [<c0421640>] (gic_handle_irq) from [<c0100b0c>] (__irq_svc+0x6c/0xa8)
[    6.803153] Exception stack(0xc1087f58 to 0xc1087fa0)
[    6.808295] 7f40:                                                       00000000 00000a68
[    6.816631] 7f60: deb3db84 c01156a0 c1086000 00000001 c0b04ed0 c0b04f10 00000000 c0a425b0
[    6.824964] 7f80: 00000000 c1087fb0 c0b04f88 c1087fa8 c0107020 c0107024 60000013 ffffffff
[    6.833303] [<c0100b0c>] (__irq_svc) from [<c0107024>] (arch_cpu_idle+0x38/0x3c)
[    6.840835] [<c0107024>] (arch_cpu_idle) from [<c014a3b4>] (do_idle+0x218/0x270)
[    6.848368] [<c014a3b4>] (do_idle) from [<c014a6e0>] (cpu_startup_entry+0x18/0x20)
[    6.856079] [<c014a6e0>] (cpu_startup_entry) from [<c010156c>] (__enableNOTICE:  CPU: STM32MP157C?? Rev.





> 
> Best Regards,
> Micha³ Miros³aw
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

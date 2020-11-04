Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2B02A619E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 11:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729263AbgKDKaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 05:30:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728645AbgKDK24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 05:28:56 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9DF0C0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 02:28:55 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1kaG23-0005vg-Ay; Wed, 04 Nov 2020 11:28:47 +0100
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
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Message-ID: <124b90a8-72c7-c6cb-790f-7a22ef7510eb@pengutronix.de>
Date:   Wed, 4 Nov 2020 11:28:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201102202727.GA20042@qmqm.qmqm.pl>
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

On 11/2/20 9:27 PM, Micha³ Miros³aw wrote:
> On Mon, Nov 02, 2020 at 01:48:54PM +0100, Ahmad Fatoum wrote:
>> Hello Micha³,
>>
>> CC += linux-stm32
>>
>> On 10/24/20 1:53 PM, Micha³ Miros³aw wrote:
>>> On Fri, Oct 23, 2020 at 10:39:43PM +0200, Corentin Labbe wrote:
>>>> On Fri, Oct 23, 2020 at 03:42:01PM +0200, Corentin Labbe wrote:
>>>>> On Wed, Oct 21, 2020 at 08:31:49PM +0200, Corentin Labbe wrote:
>>>>> I have just saw thoses 3 lines which are probably the real problem.
>>>>> I have started a new bisect with this error, but it is hitting the same "crash range" the first one.
>>>>>
>>>>
>>>> I have bisected the problem to commit aea6cb99703e17019e025aa71643b4d3e0a24413 ("regulator: resolve supply after creating regulator")
>>>> Reverting this fix my problem.
>>
>> The change broke boot on all the STM32MP1 boards, because the STPMIC driver
>> has a vref_ddr regulator, which does not have a dedicated supply, but without
>> a vref_ddr-supply property the system now no longer boots.
> [...]
> 
> Can you catch debug logs for the bootup in question? I'm not sure what's
> the failure mode in your case. I guess this is not a bypassed regulator?

Boot up with v5.10-rc2 + your cf1ad559a2 ("regulator: defer probe when trying
to get voltage from unresolved supply") hangs:

[    1.151489] stm32f7-i2c 40015000.i2c: STM32F7 I2C-0 bus adapter
[    1.180698] stpmic1 1-0033: PMIC Chip Version: 0x10
[    1.189526] vddcore: supplied by regulator-dummy
[    1.195633] vdd_ddr: supplied by regulator-dummy
[    1.201672] vdd: supplied by regulator-dummy
[    1.207452] v3v3: supplied by 5V2
[    1.211997] v1v8_audio: supplied by v3v3
[    1.218036] v3v3_hdmi: supplied by 5V2
[    1.223626] vtt_ddr: supplied by regulator-dummy
[    1.227107] vdd_usb: supplied by regulator-dummy
[    1.234532] vdda: supplied by 5V2
[    1.239497] v1v2_hdmi: supplied by v3v3

Boot up with v5.10-rc2 with aea6cb99 ("regulator: resolve supply after
creating regulator") reverted boots correctly:

[    1.151458] stm32f7-i2c 40015000.i2c: STM32F7 I2C-0 bus adapter
[    1.180668] stpmic1 1-0033: PMIC Chip Version: 0x10
[    1.186629] BUCK1: supplied by regulator-dummy
[    1.192628] BUCK2: supplied by regulator-dummy
[    1.198667] BUCK3: supplied by regulator-dummy
[    1.204623] BUCK4: supplied by 5V2
[    1.209424] LDO1: supplied by v3v3
[    1.214931] LDO2: supplied by 5V2
[    1.219897] LDO3: supplied by regulator-dummy
[    1.225784] LDO4: supplied by regulator-dummy
[    1.229239] LDO5: supplied by 5V2
[    1.235097] LDO6: supplied by v3v3
[    1.240164] VREF_DDR: supplied by regulator-dummy
[    1.246130] BOOST: supplied by 5V2
[    1.248617] VBUS_OTG: supplied by bst_out
[    1.252698] SW_OUT: supplied by bst_out

Boot up with v5.10-rc2 + your cf1ad559a2 + &pmic { regulators { vref_ddr-supply = <&reg_5v2>; }
boots correctly as well:

[    1.151531] stm32f7-i2c 40015000.i2c: STM32F7 I2C-0 bus adapter
[    1.180759] stpmic1 1-0033: PMIC Chip Version: 0x10
[    1.189543] vddcore: supplied by regulator-dummy
[    1.195651] vdd_ddr: supplied by regulator-dummy
[    1.201687] vdd: supplied by regulator-dummy
[    1.207470] v3v3: supplied by 5V2
[    1.212015] v1v8_audio: supplied by v3v3
[    1.218053] v3v3_hdmi: supplied by 5V2
[    1.223647] vtt_ddr: supplied by regulator-dummy
[    1.227128] vdd_usb: supplied by regulator-dummy
[    1.234553] vdda: supplied by 5V2
[    1.239510] v1v2_hdmi: supplied by v3v3
[    1.244932] vref_ddr: supplied by 5V2
[    1.247397] bst_out: supplied by 5V2
[    1.251338] vbus_otg: supplied by bst_out
[    1.255416] vbus_sw: supplied by bst_out


Cheers
Ahmad

> 
> Best Regards,
> Micha³ Miros³aw
> 
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

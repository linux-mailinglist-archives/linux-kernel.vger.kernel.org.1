Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAD302A6285
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 11:51:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728841AbgKDKvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 05:51:12 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:21668 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727001AbgKDKvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 05:51:10 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A4Al5QE016624;
        Wed, 4 Nov 2020 11:50:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=GB2ZMno1UiILyxLoSd3NBz+6AmaJ/cOfJuFys2cY8/Q=;
 b=emTFCoiIUA7urRear3hzAfGA4p+dJOn3cZnMEJ9BV1nWSHPIMIxWgPYjojg4TV9/4fkQ
 uzA22DejfkT4sr2STinmXbW3olt7tdaEvXOoSg8tFZX69R4uoCnIGs3BaB4yOnxJu8V2
 jE1JSIw9xQIv0WnsNCMj5jVMvnQfchAxdP2a52sw473tw3zItPguOoHbmrXj7rEfvX0i
 hUnAMxW/nlzryeAIGvL5TLQPIy9QLxeevLlqYXMLF8J0EyvpXQSDqgMxo20+/7N1yJxH
 iTwKJa7WHtkkgAxYc4Xb/iFPG1xPrhh5GxAamFGeETLaeXFiyK7kZK3t+LqzpSMeEY9H Ig== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 34h031qy22-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Nov 2020 11:50:44 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 57663100038;
        Wed,  4 Nov 2020 11:50:42 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 994C8244567;
        Wed,  4 Nov 2020 11:50:42 +0100 (CET)
Received: from lmecxl0912.lme.st.com (10.75.127.48) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 4 Nov
 2020 11:50:41 +0100
Subject: Re: [Linux-stm32] [BUG] Error applying setting, reverse things back
 on lot of devices
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
CC:     <lgirdwood@gmail.com>, <mripard@kernel.org>,
        <linux-kernel@vger.kernel.org>, <wens@csie.org>,
        <broonie@kernel.org>, Corentin Labbe <clabbe.montjoie@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <20201021183149.GA8436@Red> <20201023134201.GA533@Red>
 <20201023203943.GA21435@Red> <20201024115307.GA2745@qmqm.qmqm.pl>
 <8a580d12-fa4a-6cd8-4d82-3e3b784e348b@pengutronix.de>
 <20201102202727.GA20042@qmqm.qmqm.pl>
 <124b90a8-72c7-c6cb-790f-7a22ef7510eb@pengutronix.de>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <81490c3c-b27f-2280-3e4e-4319224fccea@st.com>
Date:   Wed, 4 Nov 2020 11:50:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <124b90a8-72c7-c6cb-790f-7a22ef7510eb@pengutronix.de>
Content-Type: text/plain; charset="iso-8859-2"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG6NODE3.st.com (10.75.127.18) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-04_06:2020-11-04,2020-11-04 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ahmad

On 11/4/20 11:28 AM, Ahmad Fatoum wrote:
> Hello,
> 
> On 11/2/20 9:27 PM, Micha³ Miros³aw wrote:
>> On Mon, Nov 02, 2020 at 01:48:54PM +0100, Ahmad Fatoum wrote:
>>> Hello Micha³,
>>>
>>> CC += linux-stm32
>>>
>>> On 10/24/20 1:53 PM, Micha³ Miros³aw wrote:
>>>> On Fri, Oct 23, 2020 at 10:39:43PM +0200, Corentin Labbe wrote:
>>>>> On Fri, Oct 23, 2020 at 03:42:01PM +0200, Corentin Labbe wrote:
>>>>>> On Wed, Oct 21, 2020 at 08:31:49PM +0200, Corentin Labbe wrote:
>>>>>> I have just saw thoses 3 lines which are probably the real problem.
>>>>>> I have started a new bisect with this error, but it is hitting the same "crash range" the first one.
>>>>>>
>>>>>
>>>>> I have bisected the problem to commit aea6cb99703e17019e025aa71643b4d3e0a24413 ("regulator: resolve supply after creating regulator")
>>>>> Reverting this fix my problem.
>>>
>>> The change broke boot on all the STM32MP1 boards, because the STPMIC driver
>>> has a vref_ddr regulator, which does not have a dedicated supply, but without
>>> a vref_ddr-supply property the system now no longer boots.
>> [...]
>>
>> Can you catch debug logs for the bootup in question? I'm not sure what's
>> the failure mode in your case. I guess this is not a bypassed regulator?
> 
> Boot up with v5.10-rc2 + your cf1ad559a2 ("regulator: defer probe when trying
> to get voltage from unresolved supply") hangs:
> 
> [    1.151489] stm32f7-i2c 40015000.i2c: STM32F7 I2C-0 bus adapter
> [    1.180698] stpmic1 1-0033: PMIC Chip Version: 0x10
> [    1.189526] vddcore: supplied by regulator-dummy
> [    1.195633] vdd_ddr: supplied by regulator-dummy
> [    1.201672] vdd: supplied by regulator-dummy
> [    1.207452] v3v3: supplied by 5V2
> [    1.211997] v1v8_audio: supplied by v3v3
> [    1.218036] v3v3_hdmi: supplied by 5V2
> [    1.223626] vtt_ddr: supplied by regulator-dummy
> [    1.227107] vdd_usb: supplied by regulator-dummy
> [    1.234532] vdda: supplied by 5V2
> [    1.239497] v1v2_hdmi: supplied by v3v3
> 
> Boot up with v5.10-rc2 with aea6cb99 ("regulator: resolve supply after
> creating regulator") reverted boots correctly:
> 
> [    1.151458] stm32f7-i2c 40015000.i2c: STM32F7 I2C-0 bus adapter
> [    1.180668] stpmic1 1-0033: PMIC Chip Version: 0x10
> [    1.186629] BUCK1: supplied by regulator-dummy
> [    1.192628] BUCK2: supplied by regulator-dummy
> [    1.198667] BUCK3: supplied by regulator-dummy
> [    1.204623] BUCK4: supplied by 5V2
> [    1.209424] LDO1: supplied by v3v3
> [    1.214931] LDO2: supplied by 5V2
> [    1.219897] LDO3: supplied by regulator-dummy
> [    1.225784] LDO4: supplied by regulator-dummy
> [    1.229239] LDO5: supplied by 5V2
> [    1.235097] LDO6: supplied by v3v3
> [    1.240164] VREF_DDR: supplied by regulator-dummy
> [    1.246130] BOOST: supplied by 5V2
> [    1.248617] VBUS_OTG: supplied by bst_out
> [    1.252698] SW_OUT: supplied by bst_out
> 
> Boot up with v5.10-rc2 + your cf1ad559a2 + &pmic { regulators { vref_ddr-supply = <&reg_5v2>; }

Just to know, Did you test v5.10-rc2 + vref_ddr-supply = <&reg_5v2>; ? 
(which seems to correspond to the patch I sent for DK/EV STM32 boards)

> boots correctly as well:
> 
> [    1.151531] stm32f7-i2c 40015000.i2c: STM32F7 I2C-0 bus adapter
> [    1.180759] stpmic1 1-0033: PMIC Chip Version: 0x10
> [    1.189543] vddcore: supplied by regulator-dummy
> [    1.195651] vdd_ddr: supplied by regulator-dummy
> [    1.201687] vdd: supplied by regulator-dummy
> [    1.207470] v3v3: supplied by 5V2
> [    1.212015] v1v8_audio: supplied by v3v3
> [    1.218053] v3v3_hdmi: supplied by 5V2
> [    1.223647] vtt_ddr: supplied by regulator-dummy
> [    1.227128] vdd_usb: supplied by regulator-dummy
> [    1.234553] vdda: supplied by 5V2
> [    1.239510] v1v2_hdmi: supplied by v3v3
> [    1.244932] vref_ddr: supplied by 5V2
> [    1.247397] bst_out: supplied by 5V2
> [    1.251338] vbus_otg: supplied by bst_out
> [    1.255416] vbus_sw: supplied by bst_out
> 
> 
> Cheers
> Ahmad
> 
>>
>> Best Regards,
>> Micha³ Miros³aw
>>
>>
> 

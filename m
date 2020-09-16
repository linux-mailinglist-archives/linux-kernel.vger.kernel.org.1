Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB68D26BC41
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 08:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbgIPGKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 02:10:45 -0400
Received: from foss.arm.com ([217.140.110.172]:53422 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726128AbgIPGKo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 02:10:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2655B1FB;
        Tue, 15 Sep 2020 23:10:43 -0700 (PDT)
Received: from [192.168.1.205] (unknown [10.37.8.121])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6B8223F68F;
        Tue, 15 Sep 2020 23:10:39 -0700 (PDT)
Subject: Re: [PATCH v1] soc: fsl: rcpm: Add ACPI support
To:     Ran Wang <ran.wang_1@nxp.com>,
        kuldip dwivedi <kuldip.dwivedi@puresoftware.com>,
        Leo Li <leoyang.li@nxp.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Biwen Li <biwen.li@nxp.com>, Varun Sethi <V.Sethi@nxp.com>,
        Arokia Samy <arokia.samy@nxp.com>,
        Samer El-Haj-Mahmoud <Samer.El-Haj-Mahmoud@arm.com>,
        Paul Yang <Paul.Yang@arm.com>,
        tanveer <tanveer.alam@puresoftware.com>
References: <20200915110647.846-1-kuldip.dwivedi@puresoftware.com>
 <4e008f0a-69da-d5c2-4dfc-ef8695e17f47@arm.com>
 <AM6PR04MB5413903EAAEDB2EED2E254C6F1210@AM6PR04MB5413.eurprd04.prod.outlook.com>
From:   Ard Biesheuvel <ard.biesheuvel@arm.com>
Message-ID: <caf01871-1c3d-bdf8-867d-daf7138966a8@arm.com>
Date:   Wed, 16 Sep 2020 09:10:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <AM6PR04MB5413903EAAEDB2EED2E254C6F1210@AM6PR04MB5413.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/16/20 3:32 AM, Ran Wang wrote:
> Hi Ard,
> 
> On Tuesday, September 15, 2020 7:10 PM, Ard Biesheuvel wrote:
>> Subject: Re: [PATCH v1] soc: fsl: rcpm: Add ACPI support
>>
>> On 9/15/20 1:06 PM, kuldip dwivedi wrote:
>>> Add ACPI support in fsl RCPM driver. This is required to support ACPI
>>> S3 state. S3 is the ACPI sleep state that is known as "sleep" or
>>> "suspend to RAM".
>>> It essentially turns off most power of the system but keeps memory
>>> powered.
>>>
>>> Signed-off-by: tanveer <tanveer.alam@puresoftware.com>
>>> Signed-off-by: kuldip dwivedi <kuldip.dwivedi@puresoftware.com>
>>
>> Why does the OS need to program this device? Can't this be done by
>> firmware?
> 
> This device is use to tell HW which IP (such as USB, SDHC, SATA, etc) should not be
> clock gated during system enter low power state (to allow that IP work as a
> wakeup source). And user does this configuration in device tree.

The point of ACPI is *not* to describe a DT topology using a table 
format that is not suited for it. The point of ACPI is to describe a 
machine that is more abstracted from the hardware than is typically 
possible with DT, where the abstractions are implemented by AML code 
that is provided by the firmware, but executed in the context of the OS.

So the idea is *not* finding the shortest possible path to get your 
existing DT driver code running on a system that boots via ACPI. 
Instead, you should carefully think about the abstract ACPI machine that 
you will expose to the OS, and hide everything else in firmware.

In this particular case, it seems like your USB, SDHC and SATA device 
objects may need power state dependent AML methods that program this 
block directly.



> So implement
> this RCPM driver to do it in kernel rather than firmware.
> 
> Regards,
> Ran
> 
>>> ---
>>>
>>> Notes:
>>>       1. Add ACPI match table
>>>       2. NXP team members are added for confirming HID changes
>>>       3. There is only one node in ACPI so no need to check for
>>>          current device explicitly
>>>       4. These changes are tested on LX2160A and LS1046A platforms
>>>
>>>    drivers/soc/fsl/rcpm.c | 22 +++++++++++++++++++---
>>>    1 file changed, 19 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/soc/fsl/rcpm.c b/drivers/soc/fsl/rcpm.c index
>>> a093dbe6d2cb..e75a436fb159 100644
>>> --- a/drivers/soc/fsl/rcpm.c
>>> +++ b/drivers/soc/fsl/rcpm.c
>>> @@ -2,10 +2,12 @@
>>>    //
>>>    // rcpm.c - Freescale QorIQ RCPM driver
>>>    //
>>> -// Copyright 2019 NXP
>>> +// Copyright 2019-2020 NXP
>>> +// Copyright 2020 Puresoftware Ltd.
>>>    //
>>>    // Author: Ran Wang <ran.wang_1@nxp.com>
>>>
>>> +#include <linux/acpi.h>
>>>    #include <linux/init.h>
>>>    #include <linux/module.h>
>>>    #include <linux/platform_device.h>
>>> @@ -57,8 +59,13 @@ static int rcpm_pm_prepare(struct device *dev)
>>>    				rcpm->wakeup_cells + 1);
>>>
>>>    		/*  Wakeup source should refer to current rcpm device */
>>> -		if (ret || (np->phandle != value[0]))
>>> -			continue;
>>> +		if (is_acpi_node(dev->fwnode)) {
>>> +			if (ret)
>>> +				continue;
>>> +		} else {
>>> +			if (ret || (np->phandle != value[0]))
>>> +				continue;
>>> +		}
>>>
>>>    		/* Property "#fsl,rcpm-wakeup-cells" of rcpm node defines the
>>>    		 * number of IPPDEXPCR register cells, and "fsl,rcpm-wakeup"
>>> @@ -139,10 +146,19 @@ static const struct of_device_id rcpm_of_match[]
>> = {
>>>    };
>>>    MODULE_DEVICE_TABLE(of, rcpm_of_match);
>>>
>>> +#ifdef CONFIG_ACPI
>>> +static const struct acpi_device_id rcpm_acpi_match[] = {
>>> +	{ "NXP0015", },
>>> +	{ }
>>> +};
>>> +MODULE_DEVICE_TABLE(acpi, rcpm_acpi_match); #endif
>>> +
>>>    static struct platform_driver rcpm_driver = {
>>>    	.driver = {
>>>    		.name = "rcpm",
>>>    		.of_match_table = rcpm_of_match,
>>> +		.acpi_match_table = ACPI_PTR(rcpm_acpi_match),
>>>    		.pm	= &rcpm_pm_ops,
>>>    	},
>>>    	.probe = rcpm_probe,
>>>
> 


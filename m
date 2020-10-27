Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9DD029AD3F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 14:26:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2900664AbgJ0N0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 09:26:21 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:40598 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410280AbgJ0N0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 09:26:21 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 09RDQD7f069029;
        Tue, 27 Oct 2020 08:26:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1603805173;
        bh=jFlTmK7DiJVnBpGbWIY3UaPdeNtf7KfJypLsXmoxVco=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=kedXen2lWi1q0+03mV18wcUxtBhcmTtIK7NXBYPe5VK1P46dNlu/m2EuKMHlProp+
         BNrOD+8RzRBUk/otp5jiZ49PC8wlGOWZxY5KZapy+HRu+KEHrbphzAKnOIy9GWoKfC
         BsFbUg7GEhV/EupPN7Ku/X+nZEXBNGDeQ6zv7o9U=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 09RDQDAH015839
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 27 Oct 2020 08:26:13 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 27
 Oct 2020 08:26:12 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 27 Oct 2020 08:26:12 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 09RDQ7Cv080837;
        Tue, 27 Oct 2020 08:26:09 -0500
Subject: Re: [PATCH] arm64: dts: ti: k3-j7200-main: Add McASP nodes
To:     Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>
CC:     <t-kristo@ti.com>, <devicetree@vger.kernel.org>,
        <robh+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20201005074850.11247-1-peter.ujfalusi@ti.com>
 <20201005115805.d6yhykn7oc6x2tbu@charm>
 <5a9ed7d3-fcfd-edbf-fc34-112a7e55aa1c@ti.com>
 <20201005120837.75cwdmcpvzbvayq7@kinfolk>
 <d0e05389-9bd1-92a9-9624-4e9ac02a6a52@ti.com>
 <20201026145031.ggfugctq65zvgwp2@dismiss> <20201027130701.GE5639@atomide.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <8cd2b8fa-366f-804f-5b10-d9100c96cf49@ti.com>
Date:   Tue, 27 Oct 2020 15:26:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201027130701.GE5639@atomide.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27/10/2020 15.07, Tony Lindgren wrote:
> * Nishanth Menon <nm@ti.com> [201026 14:58]:
>> On 13:38-20201007, Peter Ujfalusi wrote:
>> [...]
>>>>>>> +		status = "disabled";
>>>>>>
>>>>>> I see that there is inconsistent usage of "disabled" in our SoC.dts
>>>>>>
>>>>>> Our generic rule has been set them to disabled in board.dtsi
>>>>>> McASP and DSS for existing SoC dts do not follow this.. which is a tad
>>>>>> confusing.. (considering that not even all uarts come out on every board
>>>>>> and every uart needs pinmux to function..)
>>>>>
>>>>> "keep them disabled because several required properties are not present
>>>>> as they are board specific."
>>>>>
>>>>> In board file the enabled mcasp must be updated with options that is
>>>>> required for operation. Without those option the McASP can not be
>>>>> initialized.
>>>>>
>>>>> I think we have been revisiting the very same discussion every time we
>>>>> have a new SoC with McASP...
>>>>>
>>>>
>>>> Yep.. This doe'snt really follow the rest of the SoC definition. [1]
>>>> came to mind. The McASP discussion is a variation in the debate of the
>>>> same.
>>>
>>> Right, saying status = "okay" to a node which is missing required
>>> properties (which can only be added by boards when the McASP is
>>> connected up) does not sound a good solution.
>>> How should the SW handle that? Fail the device probe and return with
>>> -EINVAL or eat up the error and just probe with broken configuration.
>>> Since the peripheral is not used, the broken configuration will not
>>> cause much runtime errors as there will be no runtime use of the peripheral.
>>>
>>> status of fail or fail-sss is not a good one either, their definition is:
>>> "Indicates that the device is not operational. A serious error was
>>> detected in the device, and it is unlikely to become operational without
>>> repair."
>>>
>>> The peripheral is fine, we are just trying to enable it without
>>> providing the needed properties.
>>>
>>>> I'd argue Serdes, or for that matter any IP that has a link to
>>>> outside-the-SoC world has the same discussion point.
>>>
>>> status = "disabled" is still the closest thing for everything which have
>>> external dependencies. There is not much point to enable an i2c bus
>>> without making sure that the signals are actually routed to the pins
>>> where they supposed to go.
> 
> There is one reason to keep using the default status = "okay", for
> i2c Linux can properly idle the device on boot without dependencies
> to a certain boot loader version.

Right, but I would expect board files to disable not used peripherals,
peripherals which is not connected up in the board. Including i2c buses.

>>> Or from other pow: a board design is not based on what is _not_
>>> connected to outside world, but you actually _connect_ or _enable_
>>> certain peripherals to external components, connectors.
>>
>> OK, I will buy the argument that the current status thingy is a bit
>> overloaded and does'nt imply the correct state we need it to imply with
>> "fail-sss" either - I remember an argument for "fail-incomplete", but
>> that never happened anyways.
>>
>> Lets add this argument to the commit message and repost after testing
>> on 5.10-rc1 please?
> 
> We should use status = "disabled" when the hardware is not accessible
> to the SoC. That goes for things like secure world devices, and hardware
> that relies on a missing external clock for example. For other things
> we should just stick to the default which "okay" :)

Even for peripherals which needs board specific properties and those
properties are mandatory for the IP to be operational and usable?

The McASP bindings demands several must be present properties
(tdm-slots, slot direction for example) and they are coming from the
board design.
Board files will disable all unused McASPs, they should. Imho the board
dts file represents the board design and the board design is to
_connect_ peripherals and not _disconnect_ them.
Why would a board file should be in charge to disable what is not
connected/used?

iow: what is the difference of a peripheral disabled in dtsi over a
peripheral disabled in board dts file?

> 
> Regards,
> 
> Tony
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

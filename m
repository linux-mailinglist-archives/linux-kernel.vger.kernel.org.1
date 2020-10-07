Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27260285D06
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 12:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbgJGKiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 06:38:05 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:46196 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbgJGKiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 06:38:05 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 097Ac0jd028009;
        Wed, 7 Oct 2020 05:38:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1602067080;
        bh=x1/iBHIjMa1H+W4UR5Pt/y7opu/QPETmlx5x9EN+Ghg=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=ZYTx7VvnVFVYTqaqTexO512JSdr4DMXMCYizTwNiJpzT3st3khsGQ77g0YzatyDaj
         /WoedLHBkVGG4zRgtGuFgqB2Oakv0wwhFhBoRtmfXeMZsZiyQK/unii9Mclm6WlnJU
         i9Y3EUQZTQR2OIUHrOdmW2QNTl73K5SVJZvcwLXo=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 097Ac0Ai090554
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 7 Oct 2020 05:38:00 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 7 Oct
 2020 05:38:00 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 7 Oct 2020 05:38:00 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 097AbwsT127608;
        Wed, 7 Oct 2020 05:37:59 -0500
Subject: Re: [PATCH] arm64: dts: ti: k3-j7200-main: Add McASP nodes
To:     Nishanth Menon <nm@ti.com>
CC:     <t-kristo@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <robh+dt@kernel.org>
References: <20201005074850.11247-1-peter.ujfalusi@ti.com>
 <20201005115805.d6yhykn7oc6x2tbu@charm>
 <5a9ed7d3-fcfd-edbf-fc34-112a7e55aa1c@ti.com>
 <20201005120837.75cwdmcpvzbvayq7@kinfolk>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <d0e05389-9bd1-92a9-9624-4e9ac02a6a52@ti.com>
Date:   Wed, 7 Oct 2020 13:38:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201005120837.75cwdmcpvzbvayq7@kinfolk>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/10/2020 15.08, Nishanth Menon wrote:
> On 15:02-20201005, Peter Ujfalusi wrote:
>>
>>
>> On 05/10/2020 14.58, Nishanth Menon wrote:
>>> On 10:48-20201005, Peter Ujfalusi wrote:
>>>> Add the nodes for McASP 0-2 and keep them disabled because several
>>>> required properties are not present as they are board specific.
>>>>
>>>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>>>> ---
>>>>  arch/arm64/boot/dts/ti/k3-j7200-main.dtsi | 57 +++++++++++++++++++++++
>>>>  1 file changed, 57 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
>>>> index 72d6496e88dd..cc6c2a81887a 100644
>>>> --- a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
>>>> +++ b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
>>>> @@ -446,4 +446,61 @@ usb0: usb@6000000 {
>>>>  			dr_mode = "otg";
>>>>  		};
>>>>  	};
>>>> +x
>>>> +	mcasp0: mcasp@02b00000 {
>>>> +		compatible = "ti,am33xx-mcasp-audio";
>>>> +		reg = <0x0 0x02b00000 0x0 0x2000>,
>>>> +			<0x0 0x02b08000 0x0 0x1000>;
>>>> +		reg-names = "mpu","dat";
>>>> +		interrupts = <GIC_SPI 544 IRQ_TYPE_LEVEL_HIGH>,
>>>> +				<GIC_SPI 545 IRQ_TYPE_LEVEL_HIGH>;
>>>> +		interrupt-names = "tx", "rx";
>>>> +
>>>> +		dmas = <&main_udmap 0xc400>, <&main_udmap 0x4400>;
>>>> +		dma-names = "tx", "rx";
>>>> +
>>>> +		clocks = <&k3_clks 174 40>;
>>>> +		clock-names = "fck";
>>>> +		power-domains = <&k3_pds 174 TI_SCI_PD_EXCLUSIVE>;
>>>> +
>>>> +		status = "disabled";
>>>
>>> I see that there is inconsistent usage of "disabled" in our SoC.dts
>>>
>>> Our generic rule has been set them to disabled in board.dtsi
>>> McASP and DSS for existing SoC dts do not follow this.. which is a tad
>>> confusing.. (considering that not even all uarts come out on every board
>>> and every uart needs pinmux to function..)
>>
>> "keep them disabled because several required properties are not present
>> as they are board specific."
>>
>> In board file the enabled mcasp must be updated with options that is
>> required for operation. Without those option the McASP can not be
>> initialized.
>>
>> I think we have been revisiting the very same discussion every time we
>> have a new SoC with McASP...
>>
> 
> Yep.. This doe'snt really follow the rest of the SoC definition. [1]
> came to mind. The McASP discussion is a variation in the debate of the
> same.

Right, saying status = "okay" to a node which is missing required
properties (which can only be added by boards when the McASP is
connected up) does not sound a good solution.
How should the SW handle that? Fail the device probe and return with
-EINVAL or eat up the error and just probe with broken configuration.
Since the peripheral is not used, the broken configuration will not
cause much runtime errors as there will be no runtime use of the peripheral.

status of fail or fail-sss is not a good one either, their definition is:
"Indicates that the device is not operational. A serious error was
detected in the device, and it is unlikely to become operational without
repair."

The peripheral is fine, we are just trying to enable it without
providing the needed properties.

> I'd argue Serdes, or for that matter any IP that has a link to
> outside-the-SoC world has the same discussion point.

status = "disabled" is still the closest thing for everything which have
external dependencies. There is not much point to enable an i2c bus
without making sure that the signals are actually routed to the pins
where they supposed to go.

Or from other pow: a board design is not based on what is _not_
connected to outside world, but you actually _connect_ or _enable_
certain peripherals to external components, connectors.

> [1] https://patchwork.kernel.org/patch/9304575/
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

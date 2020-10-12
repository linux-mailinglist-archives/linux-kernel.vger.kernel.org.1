Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B77C28B429
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 13:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388292AbgJLLwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 07:52:23 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:42554 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388299AbgJLLwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 07:52:23 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 09CBqBt2095627;
        Mon, 12 Oct 2020 06:52:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1602503531;
        bh=qIA8MaEDSqiczPSjYouBXJZKFqpb41VkzVv/XxK+mdw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=rYAvjK/l/ilTz91RCRmuts90nKMfkWinbu0eWPdrH6CYXW3tKahVQsSVJF1vvW9dh
         7MSC+dymqN+QrR+t7/AmoaLdO8nATDrdFA5rGfP/IHN54b85dRKNgYJICr2lIz96XG
         ckViadULPKw1SWjiU4vS2TPMf63JAC0vIiVI7HyQ=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 09CBqBSL051461
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 12 Oct 2020 06:52:11 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 12
 Oct 2020 06:52:11 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 12 Oct 2020 06:52:11 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 09CBq8O9082144;
        Mon, 12 Oct 2020 06:52:09 -0500
Subject: Re: [PATCH v2 2/2] irqchip/ti-sci-inta: Add support for unmapped
 event handling
To:     Marc Zyngier <maz@kernel.org>
CC:     <nm@ti.com>, <devicetree@vger.kernel.org>, <jason@lakedaemon.net>,
        <lokeshvutla@ti.com>, <linux-kernel@vger.kernel.org>,
        <t-kristo@ti.com>, <robh+dt@kernel.org>, <ssantosh@kernel.org>,
        <tglx@linutronix.de>, <linux-arm-kernel@lists.infradead.org>
References: <20200930074559.18028-1-peter.ujfalusi@ti.com>
 <20200930074559.18028-3-peter.ujfalusi@ti.com>
 <af9ce252820bab9a21207ef2173da9fd@kernel.org>
 <3dc2f27f-0a41-b538-11ac-970ad4310ccb@ti.com>
 <714738536a5566c511e83dc424e94bf7@kernel.org>
 <d3180011-d9b4-3d3d-555c-3d81e1302028@ti.com>
 <3e9974b8-c0ab-9de4-9b51-541c2093c42a@ti.com>
 <7e66c03285db40c6ce38b951b87bcb45@kernel.org>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <a8e6f71d-d4c6-a83a-2e48-a426ceade3ed@ti.com>
Date:   Mon, 12 Oct 2020 14:52:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <7e66c03285db40c6ce38b951b87bcb45@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/10/2020 10.31, Marc Zyngier wrote:
> On 2020-10-09 09:58, Peter Ujfalusi wrote:
>> Marc,
>>
> 
> [...]
> 
>> The design of irqchip/irq-ti-sci-inta.c, soc/ti/ti_sci_inta_msi.c and
>> irqchip/irq-ti-sci-intr.c created to handle the interrupt needs present
>> in K3 devices with NAVSS.
>> DMSS of newer K3 devices extends and simplifies the NAVSS components and
>> a big part of that change was done with the INTA and DMAs.
>> System Firmware also changed to adopt to these changes.
>>
>> As an example, let's assume that we want an interrupt from a ring.
>> The high level of the events in this case are:
>>
>> NAVSS:
>> 1.1 ring generates an internal signal (up or down)
>> 1.2 the ringacc will send a (mapped) Global Event to INTA
>> 1.3 When INTA receives the global event, it will signal it's outgoing
>>     VINT to INTR
>> 1.4 INTR will trigger a host interrupt.
>>
>> DMSS
>> 1.1 ring generates an internal signal (up or down)
>> 1.2 the DMA (ring is now part of the DMA) will send an unmapped event to
>>     INTA
>> 1.3 When INTA receives the unmapped event, it will send a (mapped)
>>     Global Event to itself
>> 1.4 When INTA receives the global event, it will signal it's outgoing
>>     VINT to INTR
>> 1.5 INTR will trigger a host interrupt.
>>
>> The API from sysfw is the same to configure the global events and VINT,
>> but we need to use the INTA's tisci device identification number to let
>> sysfw know that the Global event number can be programmed into INTA's
>> unmapped event steering register. The DMA no longer have this register,
>> it sends unmapped event to INTA.
>>
>> The unmapped event number is fixed per sources, they will arrive at the
>> specific unmapped event configuration register of INTA.
>>
>> INTA itself does not know which source are allocated to be used by
>> Linux, the allocation is for the DMA resources and only the DMA driver
>> knows which channels, rings, flows can be used and can ask the INTA MSI
>> domain to create interrupts for those.
>>
>> By handling the ti,unmapped-event-sources the INTA driver can make
>> decision on the correct tisci dev_id to be used for the sysfw API to
>> where the global event must be configured and the client drivers does
>> not need to know how things are working under the hood.
>>
>> There are components in DMSS which use is exactly how they worked within
>> NAVSS, they are not using unmapped events. Ringacc comes to mind first.
>>
>> I can add a comment block to explain the nature of unmapped events and
>> the reason why we need to do what we do.
>>
>> Would this be acceptable?
> 
> That'd be useful, as long as it is shorter than the above.

OK, I will send an update next week after I'm back.


- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

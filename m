Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D98C2885AB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 10:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732996AbgJII7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 04:59:08 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:55834 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732989AbgJII7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 04:59:07 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0998vgBX002065;
        Fri, 9 Oct 2020 03:57:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1602233862;
        bh=neqOfIl9N1K7vUQ5TZqyIQl6IgYknjHz1QSd6eBANj4=;
        h=Subject:From:To:CC:References:Date:In-Reply-To;
        b=HE/VWNBPenWhoWBNX1B7g2qwIl97GKRUg2iQtFumwQ2PZQxp/tYnMpqVj+LW4rklG
         pM6wtS2VCW4an65GWG9VbsqIE4oqJZ18AI4B61Qlvud6nKiPxnfY1oD8byeYFyY9WU
         /XQJZwFf3E6HJlYn0Nwb0+cHII53GvHXjzjhVv+Q=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0998vgCh114893
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 9 Oct 2020 03:57:42 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 9 Oct
 2020 03:57:41 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 9 Oct 2020 03:57:41 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0998vdvV018493;
        Fri, 9 Oct 2020 03:57:39 -0500
Subject: Re: [PATCH v2 2/2] irqchip/ti-sci-inta: Add support for unmapped
 event handling
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
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
Message-ID: <3e9974b8-c0ab-9de4-9b51-541c2093c42a@ti.com>
Date:   Fri, 9 Oct 2020 11:58:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <d3180011-d9b4-3d3d-555c-3d81e1302028@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Marc,

On 01/10/2020 14.42, Peter Ujfalusi wrote:
> 
> 
> On 30/09/2020 16.13, Marc Zyngier wrote:
>> On 2020-09-30 11:01, Peter Ujfalusi wrote:
>>> On 30/09/2020 11.33, Marc Zyngier wrote:
>>>> On 2020-09-30 08:45, Peter Ujfalusi wrote:
>>>>> The DMA (BCDMA/PKTDMA and their rings/flows) events are under the
>>>>> INTA's
>>>>> supervision as unmapped events in AM64.
>>>>
>>>> What does "unmapped event" mean? An event that doesn't require a
>>>> mapping?
>>>> Or an internally generated event? Or a proxy event?
>>>>
>>>>>
>>>>> In order to keep the current SW stack working, the INTA driver must
>>>>> replace
>>>>> the dev_id with it's own when a request comes for BCDMA or PKTDMA
>>>>> resources.
>>>>
>>>> This seems to support my second option. Please clarify what you mean
>>>> exactly.
>>>
>>> In previous devices with NAVSS we had event registers in UDMAP and in
>>> rings.
>>> In AM64 with DMSS these event registers have been removed from the DMAs
>>> (rings are part of the DMAs).
>>> The event configuration registers in DMSS are part of the INTA and they
>>> under 'unmapped events'.
>>
>> Is "unmapped events" an official TI wording, described as such in the TRM?
> 
> Yes, this is the exact term.
> 
>>>
>>> In essence the difference boils down to the fact that we do not
>>> configure event numbers (to be consumed by INTA) for the events coming
>>> from DMAs, but they already have their specific offsets within INTA's
>>> unmapped region.
>>
>> OK, so they are not "unmapped". They are just permanently mapped, aren't
>> they?
> 
> The reason why these events are called as unmapped events is because
> they are _not_ contained within the SoC level global event map -> they
> are not mapped events -> unmapped events.
> SW should be treating the unmapped event list as global events using
> separate address mapping.
> The mapped and unmapped event map space exists in parallel if we put it
> this way.

The design of irqchip/irq-ti-sci-inta.c, soc/ti/ti_sci_inta_msi.c and
irqchip/irq-ti-sci-intr.c created to handle the interrupt needs present
in K3 devices with NAVSS.
DMSS of newer K3 devices extends and simplifies the NAVSS components and
a big part of that change was done with the INTA and DMAs.
System Firmware also changed to adopt to these changes.

As an example, let's assume that we want an interrupt from a ring.
The high level of the events in this case are:

NAVSS:
1.1 ring generates an internal signal (up or down)
1.2 the ringacc will send a (mapped) Global Event to INTA
1.3 When INTA receives the global event, it will signal it's outgoing
    VINT to INTR
1.4 INTR will trigger a host interrupt.

DMSS
1.1 ring generates an internal signal (up or down)
1.2 the DMA (ring is now part of the DMA) will send an unmapped event to
    INTA
1.3 When INTA receives the unmapped event, it will send a (mapped)
    Global Event to itself
1.4 When INTA receives the global event, it will signal it's outgoing
    VINT to INTR
1.5 INTR will trigger a host interrupt.

The API from sysfw is the same to configure the global events and VINT,
but we need to use the INTA's tisci device identification number to let
sysfw know that the Global event number can be programmed into INTA's
unmapped event steering register. The DMA no longer have this register,
it sends unmapped event to INTA.

The unmapped event number is fixed per sources, they will arrive at the
specific unmapped event configuration register of INTA.

INTA itself does not know which source are allocated to be used by
Linux, the allocation is for the DMA resources and only the DMA driver
knows which channels, rings, flows can be used and can ask the INTA MSI
domain to create interrupts for those.

By handling the ti,unmapped-event-sources the INTA driver can make
decision on the correct tisci dev_id to be used for the sysfw API to
where the global event must be configured and the client drivers does
not need to know how things are working under the hood.

There are components in DMSS which use is exactly how they worked within
NAVSS, they are not using unmapped events. Ringacc comes to mind first.

I can add a comment block to explain the nature of unmapped events and
the reason why we need to do what we do.

Would this be acceptable?

- Péter

>>> With this change in hardware we can not use the DMA's ti_sci device
>>> identification number to configure these events to produce interrupts,
>>> they are under INTA.
>>>
>>> The only difference in ti_sci API is that for DMA related
>>> interrupts/events we need to use the INTA's ti_sci device identification
>>> number in place of the DMA component's.
>>>
>>> I would say that I would describe the unmapped events with your first
>>> option. They kind of not require mapping from the source to INTA. The
>>> source of the event (DMA, ring) is pre-configured to send specific
>>> events to target the unmapped event area at specific offsets.
>>
>> If they truly don't require a mapping, why is this patch actually mapping
>> them with the INTA as a source? Your explanation doesn't make much sense
>> to me.
> 
> In DMSS lots of optimization went into the HW and one of them was to
> remove the Output Event Steering Registers (OESR) from the DMAs and it's
> rings. Well, not remove, but not add them as we have new DMAs.
> Now INTA have a section to handle the unmapped events via the new
> Unmapped Event Mapping Block.
> This provides similar functionality as OESR did when they were present
> on the parent IP. It also have the possibility to directly do unmapped
> to virtual interrupt mapping, skipping the unmapped -> global event ->
> local event flow.
> 
> The new INTA in DMSS supports the original global event to local event
> handling (for ringacc for example) and it introduced these new unmapped
> events.
> 
> To configure either type (mapped or unmapped global events) we have a
> single API from SYSFW.
> For mapped events the src_id is the source device identification (ring,
> DMA channel, etc).
> For unmapped events the src_id is the device identification number of
> the INTA where the unmapped event is handled.
> 
> For mapped events we have OESR register in the source peripheral's
> register space, this does not exists for unmapped event sources.
> 
> With the "ti,unmapped-event-sources" points to the devices from where
> these unmapped events are originating and the inta driver will use the
> appropriate src_id for SYSFW so client drivers do not need to know and
> care about the differences between the two INTA.
> 
>>> But in the unmapped event register one can still define either:
>>> - to send a global event (to be used as trigger or for other purposes)
>>> - to generate interrupt (in a similar way as the IMAP registers were
>>> doing in NAVSS).
>>>
>>> I'm not sure if this answers your question...
>>
>> I still believe the term "unmapped event" doesn't describe what we have
>> here. These events seems, at least from what the patch does, internally
>> generated by the INTA.
> 
> The INTA driver is ti-sci-inta, it relies on SYSFW interface solely, the
> hardware is abstracted by the interrupt API: TISCI_MSG_RM_IRQ_SET and
> TISCI_MSG_RM_IRQ_RELEASE.
> 
> But I do agree that the lack of OESR in the new DMA components and the
> unmapped events can be viewed and implemented in a different way.
> 
>> Irrespective of this, my other comments still stand.
>>
>>         M.
> 
> - Péter
> 
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

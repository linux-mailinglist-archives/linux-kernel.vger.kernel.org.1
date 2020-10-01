Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DBFC27FE95
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 13:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731890AbgJALnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 07:43:00 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:43604 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731243AbgJALnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 07:43:00 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 091BgcYf114493;
        Thu, 1 Oct 2020 06:42:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601552558;
        bh=ljxMSWc+30t587wgCSku10stb+v1LX7i+GEGX7hYrTs=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=OSgYrWY8KLVvBBwGyHVTzImg44Zr9jBhTrfiJET6Ol1EiG1+Vh8nX7ld8lJb0dzEM
         DFayKM7wIHmA6a6ndpjt3QAGVuvNiUu+jvEjd3ccz04lkpxLad5AbLW/AKW2MFYfOo
         thCLrfLgJ8/lCpn2/kTaG/9MZwthJOoOAdqVi0Sw=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 091BgcNn093511;
        Thu, 1 Oct 2020 06:42:38 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 1 Oct
 2020 06:42:38 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 1 Oct 2020 06:42:38 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 091BgZh3025455;
        Thu, 1 Oct 2020 06:42:36 -0500
Subject: Re: [PATCH v2 2/2] irqchip/ti-sci-inta: Add support for unmapped
 event handling
To:     Marc Zyngier <maz@kernel.org>
CC:     <nm@ti.com>, <t-kristo@ti.com>, <ssantosh@kernel.org>,
        <tglx@linutronix.de>, <jason@lakedaemon.net>, <robh+dt@kernel.org>,
        <lokeshvutla@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <20200930074559.18028-1-peter.ujfalusi@ti.com>
 <20200930074559.18028-3-peter.ujfalusi@ti.com>
 <af9ce252820bab9a21207ef2173da9fd@kernel.org>
 <3dc2f27f-0a41-b538-11ac-970ad4310ccb@ti.com>
 <714738536a5566c511e83dc424e94bf7@kernel.org>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
X-Pep-Version: 2.0
Message-ID: <d3180011-d9b4-3d3d-555c-3d81e1302028@ti.com>
Date:   Thu, 1 Oct 2020 14:42:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <714738536a5566c511e83dc424e94bf7@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30/09/2020 16.13, Marc Zyngier wrote:
> On 2020-09-30 11:01, Peter Ujfalusi wrote:
>> On 30/09/2020 11.33, Marc Zyngier wrote:
>>> On 2020-09-30 08:45, Peter Ujfalusi wrote:
>>>> The DMA (BCDMA/PKTDMA and their rings/flows) events are under the
>>>> INTA's
>>>> supervision as unmapped events in AM64.
>>>
>>> What does "unmapped event" mean? An event that doesn't require a
>>> mapping?
>>> Or an internally generated event? Or a proxy event?
>>>
>>>>
>>>> In order to keep the current SW stack working, the INTA driver must
>>>> replace
>>>> the dev_id with it's own when a request comes for BCDMA or PKTDMA
>>>> resources.
>>>
>>> This seems to support my second option. Please clarify what you mean
>>> exactly.
>>
>> In previous devices with NAVSS we had event registers in UDMAP and in
>> rings.
>> In AM64 with DMSS these event registers have been removed from the DMA=
s
>> (rings are part of the DMAs).
>> The event configuration registers in DMSS are part of the INTA and the=
y
>> under 'unmapped events'.
>=20
> Is "unmapped events" an official TI wording, described as such in the T=
RM?

Yes, this is the exact term.

>>
>> In essence the difference boils down to the fact that we do not
>> configure event numbers (to be consumed by INTA) for the events coming=

>> from DMAs, but they already have their specific offsets within INTA's
>> unmapped region.
>=20
> OK, so they are not "unmapped". They are just permanently mapped, aren'=
t
> they?

The reason why these events are called as unmapped events is because
they are _not_ contained within the SoC level global event map -> they
are not mapped events -> unmapped events.
SW should be treating the unmapped event list as global events using
separate address mapping.
The mapped and unmapped event map space exists in parallel if we put it
this way.

>> With this change in hardware we can not use the DMA's ti_sci device
>> identification number to configure these events to produce interrupts,=

>> they are under INTA.
>>
>> The only difference in ti_sci API is that for DMA related
>> interrupts/events we need to use the INTA's ti_sci device identificati=
on
>> number in place of the DMA component's.
>>
>> I would say that I would describe the unmapped events with your first
>> option. They kind of not require mapping from the source to INTA. The
>> source of the event (DMA, ring) is pre-configured to send specific
>> events to target the unmapped event area at specific offsets.
>=20
> If they truly don't require a mapping, why is this patch actually mappi=
ng
> them with the INTA as a source? Your explanation doesn't make much sens=
e
> to me.

In DMSS lots of optimization went into the HW and one of them was to
remove the Output Event Steering Registers (OESR) from the DMAs and it's
rings. Well, not remove, but not add them as we have new DMAs.
Now INTA have a section to handle the unmapped events via the new
Unmapped Event Mapping Block.
This provides similar functionality as OESR did when they were present
on the parent IP. It also have the possibility to directly do unmapped
to virtual interrupt mapping, skipping the unmapped -> global event ->
local event flow.

The new INTA in DMSS supports the original global event to local event
handling (for ringacc for example) and it introduced these new unmapped
events.

To configure either type (mapped or unmapped global events) we have a
single API from SYSFW.
For mapped events the src_id is the source device identification (ring,
DMA channel, etc).
For unmapped events the src_id is the device identification number of
the INTA where the unmapped event is handled.

For mapped events we have OESR register in the source peripheral's
register space, this does not exists for unmapped event sources.

With the "ti,unmapped-event-sources" points to the devices from where
these unmapped events are originating and the inta driver will use the
appropriate src_id for SYSFW so client drivers do not need to know and
care about the differences between the two INTA.

>> But in the unmapped event register one can still define either:
>> - to send a global event (to be used as trigger or for other purposes)=

>> - to generate interrupt (in a similar way as the IMAP registers were
>> doing in NAVSS).
>>
>> I'm not sure if this answers your question...
>=20
> I still believe the term "unmapped event" doesn't describe what we have=

> here. These events seems, at least from what the patch does, internally=

> generated by the INTA.

The INTA driver is ti-sci-inta, it relies on SYSFW interface solely, the
hardware is abstracted by the interrupt API: TISCI_MSG_RM_IRQ_SET and
TISCI_MSG_RM_IRQ_RELEASE.

But I do agree that the lack of OESR in the new DMA components and the
unmapped events can be viewed and implemented in a different way.

> Irrespective of this, my other comments still stand.
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 M.

- P=C3=A9ter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki


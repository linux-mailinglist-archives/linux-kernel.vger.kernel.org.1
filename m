Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9A4D27E5E6
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 12:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729080AbgI3KBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 06:01:35 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:34686 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbgI3KBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 06:01:31 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08UA1CrO083989;
        Wed, 30 Sep 2020 05:01:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601460073;
        bh=HSA4nrsZslLb4g6ttmiOhVsK7jIIJWiMn0B8sak9z4M=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Iz0WJAwwe+jchqPzE4DRhZX3EGE+vtqcV//gPvAYgrcK0vUiPDZaAQ6WdWAdqZzVI
         kMMxPjBEId6Y7avYKtBd2VRvGiCn6RMFXH52ijoY6aTXvttQYBtlamI/oeQP2sPEf5
         O9BWG3hPCqNUjAKlKZhwqwsd6Afpok40rtfJ+EiQ=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08UA1CCb054458
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 30 Sep 2020 05:01:12 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 30
 Sep 2020 05:01:12 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 30 Sep 2020 05:01:12 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08UA19lA128723;
        Wed, 30 Sep 2020 05:01:10 -0500
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
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
X-Pep-Version: 2.0
Message-ID: <3dc2f27f-0a41-b538-11ac-970ad4310ccb@ti.com>
Date:   Wed, 30 Sep 2020 13:01:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <af9ce252820bab9a21207ef2173da9fd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30/09/2020 11.33, Marc Zyngier wrote:
> On 2020-09-30 08:45, Peter Ujfalusi wrote:
>> The DMA (BCDMA/PKTDMA and their rings/flows) events are under the INTA=
's
>> supervision as unmapped events in AM64.
>=20
> What does "unmapped event" mean? An event that doesn't require a mappin=
g?
> Or an internally generated event? Or a proxy event?
>=20
>>
>> In order to keep the current SW stack working, the INTA driver must
>> replace
>> the dev_id with it's own when a request comes for BCDMA or PKTDMA
>> resources.
>=20
> This seems to support my second option. Please clarify what you mean
> exactly.

In previous devices with NAVSS we had event registers in UDMAP and in rin=
gs.
In AM64 with DMSS these event registers have been removed from the DMAs
(rings are part of the DMAs).
The event configuration registers in DMSS are part of the INTA and they
under 'unmapped events'.

In essence the difference boils down to the fact that we do not
configure event numbers (to be consumed by INTA) for the events coming
from DMAs, but they already have their specific offsets within INTA's
unmapped region.
With this change in hardware we can not use the DMA's ti_sci device
identification number to configure these events to produce interrupts,
they are under INTA.

The only difference in ti_sci API is that for DMA related
interrupts/events we need to use the INTA's ti_sci device identification
number in place of the DMA component's.

I would say that I would describe the unmapped events with your first
option. They kind of not require mapping from the source to INTA. The
source of the event (DMA, ring) is pre-configured to send specific
events to target the unmapped event area at specific offsets.

But in the unmapped event register one can still define either:
- to send a global event (to be used as trigger or for other purposes)
- to generate interrupt (in a similar way as the IMAP registers were
doing in NAVSS).

I'm not sure if this answers your question...

- P=C3=A9ter

>>
>> Implement parsing of the optional "ti,unmapped-event-sources" phandle
>> array
>> to get the sci-dev-ids of the devices where the unmapped events
>> originate.
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> ---
>> =C2=A0drivers/irqchip/irq-ti-sci-inta.c | 72 +++++++++++++++++++++++++=
++++--
>> =C2=A01 file changed, 68 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/irqchip/irq-ti-sci-inta.c
>> b/drivers/irqchip/irq-ti-sci-inta.c
>> index bc863ef7998d..00f5b34863c5 100644
>> --- a/drivers/irqchip/irq-ti-sci-inta.c
>> +++ b/drivers/irqchip/irq-ti-sci-inta.c
>> @@ -85,6 +85,8 @@ struct ti_sci_inta_vint_desc {
>> =C2=A0 * @base:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Base address=
 of the memory mapped IO registers
>> =C2=A0 * @pdev:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Pointer to p=
latform device.
>> =C2=A0 * @ti_sci_id:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TI-SCI =
device identifier
>> + * @difu_cnt:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Number of TI-=
SCI device identifiers for unmapped
>> events
>> + * @dev_ids_for_unmapped: Pointer to an array of TI-SCI device
>> identifiers
>> =C2=A0 */
>> =C2=A0struct ti_sci_inta_irq_domain {
>> =C2=A0=C2=A0=C2=A0=C2=A0 const struct ti_sci_handle *sci;
>> @@ -96,11 +98,33 @@ struct ti_sci_inta_irq_domain {
>> =C2=A0=C2=A0=C2=A0=C2=A0 void __iomem *base;
>> =C2=A0=C2=A0=C2=A0=C2=A0 struct platform_device *pdev;
>> =C2=A0=C2=A0=C2=A0=C2=A0 u32 ti_sci_id;
>> +
>> +=C2=A0=C2=A0=C2=A0 int difu_cnt;
>=20
> I like silly acronyms as much as the next man, but please adopt
> sensible names. unmapped_cnt, or something.
>=20
>> +=C2=A0=C2=A0=C2=A0 u32 *dev_ids_for_unmapped;
>=20
> unmapped_dev_ids?
>=20
>> =C2=A0};
>>
>> =C2=A0#define to_vint_desc(e, i) container_of(e, struct
>> ti_sci_inta_vint_desc, \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 events[i])
>>
>> +static u16 ti_sci_inta_get_dev_id(struct ti_sci_inta_irq_domain *inta=
,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u32 hwirq)
>> +{
>> +=C2=A0=C2=A0=C2=A0 u16 dev_id =3D HWIRQ_TO_DEVID(hwirq);
>> +=C2=A0=C2=A0=C2=A0 int i;
>> +
>> +=C2=A0=C2=A0=C2=A0 if (inta->difu_cnt =3D=3D 0)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return dev_id;
>> +
>> +=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < inta->difu_cnt; i++) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (dev_id =3D=3D inta->de=
v_ids_for_unmapped[i]) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 de=
v_id =3D inta->ti_sci_id;
>=20
> ti_sci_id is a u32, and you are implicitly casting it as u16.
> One of the two is wrong.
>=20
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 br=
eak;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 return dev_id;
>> +}
>> +
>> =C2=A0/**
>> =C2=A0 * ti_sci_inta_irq_handler() - Chained IRQ handler for the vint =
irqs
>> =C2=A0 * @desc:=C2=A0=C2=A0=C2=A0 Pointer to irq_desc corresponding to=
 the irq
>> @@ -251,7 +275,7 @@ static struct ti_sci_inta_event_desc
>> *ti_sci_inta_alloc_event(struct ti_sci_inta
>> =C2=A0=C2=A0=C2=A0=C2=A0 u16 dev_id, dev_index;
>> =C2=A0=C2=A0=C2=A0=C2=A0 int err;
>>
>> -=C2=A0=C2=A0=C2=A0 dev_id =3D HWIRQ_TO_DEVID(hwirq);
>> +=C2=A0=C2=A0=C2=A0 dev_id =3D ti_sci_inta_get_dev_id(inta, hwirq);
>> =C2=A0=C2=A0=C2=A0=C2=A0 dev_index =3D HWIRQ_TO_IRQID(hwirq);
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0 event_desc =3D &vint_desc->events[free_bit];
>> @@ -352,14 +376,15 @@ static void ti_sci_inta_free_irq(struct
>> ti_sci_inta_event_desc *event_desc,
>> =C2=A0{
>> =C2=A0=C2=A0=C2=A0=C2=A0 struct ti_sci_inta_vint_desc *vint_desc;
>> =C2=A0=C2=A0=C2=A0=C2=A0 struct ti_sci_inta_irq_domain *inta;
>> +=C2=A0=C2=A0=C2=A0 u16 dev_id;
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0 vint_desc =3D to_vint_desc(event_desc, event_=
desc->vint_bit);
>> =C2=A0=C2=A0=C2=A0=C2=A0 inta =3D vint_desc->domain->host_data;
>> +=C2=A0=C2=A0=C2=A0 dev_id =3D ti_sci_inta_get_dev_id(inta, hwirq);
>> =C2=A0=C2=A0=C2=A0=C2=A0 /* free event irq */
>> =C2=A0=C2=A0=C2=A0=C2=A0 mutex_lock(&inta->vint_mutex);
>> =C2=A0=C2=A0=C2=A0=C2=A0 inta->sci->ops.rm_irq_ops.free_event_map(inta=
->sci,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 HWIRQ_TO_DEVID(hwirq),
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 HWIRQ_TO_IRQID(hwirq),
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 dev_id, HWIRQ_TO_IRQID(hwirq),
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 inta->ti_sci_id,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 vint_desc->vint_id,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 event_desc->global_event,
>> @@ -562,7 +587,6 @@ static void
>> ti_sci_inta_msi_set_desc(msi_alloc_info_t *arg,
>> =C2=A0=C2=A0=C2=A0=C2=A0 arg->desc =3D desc;
>> =C2=A0=C2=A0=C2=A0=C2=A0 arg->hwirq =3D TO_HWIRQ(pdev->id, desc->inta.=
dev_index);
>> =C2=A0}
>> -
>> =C2=A0static struct msi_domain_ops ti_sci_inta_msi_ops =3D {
>> =C2=A0=C2=A0=C2=A0=C2=A0 .set_desc=C2=A0=C2=A0=C2=A0 =3D ti_sci_inta_m=
si_set_desc,
>> =C2=A0};
>> @@ -574,6 +598,42 @@ static struct msi_domain_info
>> ti_sci_inta_msi_domain_info =3D {
>> =C2=A0=C2=A0=C2=A0=C2=A0 .chip=C2=A0=C2=A0=C2=A0 =3D &ti_sci_inta_msi_=
irq_chip,
>> =C2=A0};
>>
>> +static int ti_sci_inta_get_unmapped_sources(struct
>> ti_sci_inta_irq_domain *inta)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct device *dev =3D &inta->pdev->dev;
>> +=C2=A0=C2=A0=C2=A0 struct device_node *node =3D dev_of_node(dev);
>> +=C2=A0=C2=A0=C2=A0 struct of_phandle_iterator it;
>> +=C2=A0=C2=A0=C2=A0 int count, err, ret, i;
>> +
>> +=C2=A0=C2=A0=C2=A0 count =3D of_count_phandle_with_args(node,
>> "ti,unmapped-event-sources",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NULL);
>> +=C2=A0=C2=A0=C2=A0 if (count <=3D 0)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>> +
>> +=C2=A0=C2=A0=C2=A0 inta->dev_ids_for_unmapped =3D devm_kcalloc(dev, c=
ount,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sizeof(*inta->dev_ids_for_u=
nmapped),
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GFP_KERNEL);
>> +=C2=A0=C2=A0=C2=A0 if (!inta->dev_ids_for_unmapped)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENOMEM;
>> +
>> +=C2=A0=C2=A0=C2=A0 i =3D 0;
>> +=C2=A0=C2=A0=C2=A0 of_for_each_phandle(&it, err, node, "ti,unmapped-e=
vent-sources",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 NULL, 0) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D of_property_read_u=
32(it.node, "ti,sci-dev-id",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &inta->de=
v_ids_for_unmapped[i++]);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 de=
v_err(dev, "ti,sci-dev-id read failure for %s\n",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 of_node_full_name(it.node));
>=20
> Use the printk format specifier instead of of_node_full_name.
>=20
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 of=
_node_put(it.node);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
turn ret;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 inta->difu_cnt =3D count;
>> +
>> +=C2=A0=C2=A0=C2=A0 return 0;
>> +}
>> +
>> =C2=A0static int ti_sci_inta_irq_domain_probe(struct platform_device *=
pdev)
>> =C2=A0{
>> =C2=A0=C2=A0=C2=A0=C2=A0 struct irq_domain *parent_domain, *domain, *m=
si_domain;
>> @@ -629,6 +689,10 @@ static int ti_sci_inta_irq_domain_probe(struct
>> platform_device *pdev)
>> =C2=A0=C2=A0=C2=A0=C2=A0 if (IS_ERR(inta->base))
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return PTR_ERR(inta->=
base);
>>
>> +=C2=A0=C2=A0=C2=A0 ret =3D ti_sci_inta_get_unmapped_sources(inta);
>> +=C2=A0=C2=A0=C2=A0 if (ret)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0 domain =3D irq_domain_add_linear(dev_of_node(=
dev),
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ti_sci=
_get_num_resources(inta->vint),
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &ti_sc=
i_inta_irq_domain_ops, inta);
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 M.


Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki


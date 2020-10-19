Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1E8E2926B9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 13:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbgJSLv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 07:51:59 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:44994 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbgJSLv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 07:51:58 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 09JBpZ2T129745;
        Mon, 19 Oct 2020 06:51:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1603108295;
        bh=oMc8cxidC4soC6sm/F1kZtDKNR1nvxlXtZ5poHhthHQ=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=fDe7e3cSbI9jovMwv6rXNZr5Wi5uuDPe7fJzo5ztVvr9o+mD/e107XDVYlef2LUZZ
         0LgFbXY5A7ulq5ea9WgGFWiN3sP+4BhCRff/FOtSrJAHdtB70/SgH3qmvhzHFhRP6A
         z9ENYcGa8z2r1tU8JrBPW/2zpRHVDcljbg77cRaM=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 09JBpZC4087478
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 19 Oct 2020 06:51:35 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 19
 Oct 2020 06:51:35 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 19 Oct 2020 06:51:35 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 09JBpWLC122421;
        Mon, 19 Oct 2020 06:51:33 -0500
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
Message-ID: <6e501bf0-e4d7-7ce3-2d61-536d0fa29627@ti.com>
Date:   Mon, 19 Oct 2020 14:52:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.3
MIME-Version: 1.0
In-Reply-To: <af9ce252820bab9a21207ef2173da9fd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Marc,

On 30/09/2020 11.33, Marc Zyngier wrote:
> On 2020-09-30 08:45, Peter Ujfalusi wrote:
>> The DMA (BCDMA/PKTDMA and their rings/flows) events are under the INTA's
>> supervision as unmapped events in AM64.
> 
> What does "unmapped event" mean? An event that doesn't require a mapping?
> Or an internally generated event? Or a proxy event?
> 
>>
>> In order to keep the current SW stack working, the INTA driver must
>> replace
>> the dev_id with it's own when a request comes for BCDMA or PKTDMA
>> resources.
> 
> This seems to support my second option. Please clarify what you mean
> exactly.

Looks like I forgot to reply on the other comments...

> 
>>
>> Implement parsing of the optional "ti,unmapped-event-sources" phandle
>> array
>> to get the sci-dev-ids of the devices where the unmapped events
>> originate.
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> ---
>>  drivers/irqchip/irq-ti-sci-inta.c | 72 +++++++++++++++++++++++++++++--
>>  1 file changed, 68 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/irqchip/irq-ti-sci-inta.c
>> b/drivers/irqchip/irq-ti-sci-inta.c
>> index bc863ef7998d..00f5b34863c5 100644
>> --- a/drivers/irqchip/irq-ti-sci-inta.c
>> +++ b/drivers/irqchip/irq-ti-sci-inta.c
>> @@ -85,6 +85,8 @@ struct ti_sci_inta_vint_desc {
>>   * @base:        Base address of the memory mapped IO registers
>>   * @pdev:        Pointer to platform device.
>>   * @ti_sci_id:        TI-SCI device identifier
>> + * @difu_cnt:        Number of TI-SCI device identifiers for unmapped
>> events
>> + * @dev_ids_for_unmapped: Pointer to an array of TI-SCI device
>> identifiers
>>   */
>>  struct ti_sci_inta_irq_domain {
>>      const struct ti_sci_handle *sci;
>> @@ -96,11 +98,33 @@ struct ti_sci_inta_irq_domain {
>>      void __iomem *base;
>>      struct platform_device *pdev;
>>      u32 ti_sci_id;
>> +
>> +    int difu_cnt;
> 
> I like silly acronyms as much as the next man, but please adopt
> sensible names. unmapped_cnt, or something.

It is silly to my taste as well...

> 
>> +    u32 *dev_ids_for_unmapped;
> 
> unmapped_dev_ids?

OK, I will came up with more reasobnable names.

> 
>>  };
>>
>>  #define to_vint_desc(e, i) container_of(e, struct
>> ti_sci_inta_vint_desc, \
>>                      events[i])
>>
>> +static u16 ti_sci_inta_get_dev_id(struct ti_sci_inta_irq_domain *inta,
>> +                  u32 hwirq)
>> +{
>> +    u16 dev_id = HWIRQ_TO_DEVID(hwirq);
>> +    int i;
>> +
>> +    if (inta->difu_cnt == 0)
>> +        return dev_id;
>> +
>> +    for (i = 0; i < inta->difu_cnt; i++) {
>> +        if (dev_id == inta->dev_ids_for_unmapped[i]) {
>> +            dev_id = inta->ti_sci_id;
> 
> ti_sci_id is a u32, and you are implicitly casting it as u16.
> One of the two is wrong.

Documentation/devicetree/bindings/arm/keystone/ti,k3-sci-common.yaml
defines the ti,sci-dev-id as u32.
I will store them in u16 array in ti_sci_inta_get_unmapped_sources()

> 
>> +            break;
>> +        }
>> +    }
>> +
>> +    return dev_id;
>> +}
>> +
>>  /**
>>   * ti_sci_inta_irq_handler() - Chained IRQ handler for the vint irqs
>>   * @desc:    Pointer to irq_desc corresponding to the irq
>> @@ -251,7 +275,7 @@ static struct ti_sci_inta_event_desc
>> *ti_sci_inta_alloc_event(struct ti_sci_inta
>>      u16 dev_id, dev_index;
>>      int err;
>>
>> -    dev_id = HWIRQ_TO_DEVID(hwirq);
>> +    dev_id = ti_sci_inta_get_dev_id(inta, hwirq);
>>      dev_index = HWIRQ_TO_IRQID(hwirq);
>>
>>      event_desc = &vint_desc->events[free_bit];
>> @@ -352,14 +376,15 @@ static void ti_sci_inta_free_irq(struct
>> ti_sci_inta_event_desc *event_desc,
>>  {
>>      struct ti_sci_inta_vint_desc *vint_desc;
>>      struct ti_sci_inta_irq_domain *inta;
>> +    u16 dev_id;
>>
>>      vint_desc = to_vint_desc(event_desc, event_desc->vint_bit);
>>      inta = vint_desc->domain->host_data;
>> +    dev_id = ti_sci_inta_get_dev_id(inta, hwirq);
>>      /* free event irq */
>>      mutex_lock(&inta->vint_mutex);
>>      inta->sci->ops.rm_irq_ops.free_event_map(inta->sci,
>> -                         HWIRQ_TO_DEVID(hwirq),
>> -                         HWIRQ_TO_IRQID(hwirq),
>> +                         dev_id, HWIRQ_TO_IRQID(hwirq),
>>                           inta->ti_sci_id,
>>                           vint_desc->vint_id,
>>                           event_desc->global_event,
>> @@ -562,7 +587,6 @@ static void
>> ti_sci_inta_msi_set_desc(msi_alloc_info_t *arg,
>>      arg->desc = desc;
>>      arg->hwirq = TO_HWIRQ(pdev->id, desc->inta.dev_index);
>>  }
>> -
>>  static struct msi_domain_ops ti_sci_inta_msi_ops = {
>>      .set_desc    = ti_sci_inta_msi_set_desc,
>>  };
>> @@ -574,6 +598,42 @@ static struct msi_domain_info
>> ti_sci_inta_msi_domain_info = {
>>      .chip    = &ti_sci_inta_msi_irq_chip,
>>  };
>>
>> +static int ti_sci_inta_get_unmapped_sources(struct
>> ti_sci_inta_irq_domain *inta)
>> +{
>> +    struct device *dev = &inta->pdev->dev;
>> +    struct device_node *node = dev_of_node(dev);
>> +    struct of_phandle_iterator it;
>> +    int count, err, ret, i;
>> +
>> +    count = of_count_phandle_with_args(node,
>> "ti,unmapped-event-sources",
>> +                       NULL);
>> +    if (count <= 0)
>> +        return 0;
>> +
>> +    inta->dev_ids_for_unmapped = devm_kcalloc(dev, count,
>> +                    sizeof(*inta->dev_ids_for_unmapped),
>> +                    GFP_KERNEL);
>> +    if (!inta->dev_ids_for_unmapped)
>> +        return -ENOMEM;
>> +
>> +    i = 0;
>> +    of_for_each_phandle(&it, err, node, "ti,unmapped-event-sources",
>> +                NULL, 0) {
>> +        ret = of_property_read_u32(it.node, "ti,sci-dev-id",
>> +                       &inta->dev_ids_for_unmapped[i++]);
>> +        if (ret) {
>> +            dev_err(dev, "ti,sci-dev-id read failure for %s\n",
>> +                of_node_full_name(it.node));
> 
> Use the printk format specifier instead of of_node_full_name.

OK.

> 
>> +            of_node_put(it.node);
>> +            return ret;
>> +        }
>> +    }
>> +
>> +    inta->difu_cnt = count;
>> +
>> +    return 0;
>> +}
>> +
>>  static int ti_sci_inta_irq_domain_probe(struct platform_device *pdev)
>>  {
>>      struct irq_domain *parent_domain, *domain, *msi_domain;
>> @@ -629,6 +689,10 @@ static int ti_sci_inta_irq_domain_probe(struct
>> platform_device *pdev)
>>      if (IS_ERR(inta->base))
>>          return PTR_ERR(inta->base);
>>
>> +    ret = ti_sci_inta_get_unmapped_sources(inta);
>> +    if (ret)
>> +        return ret;
>> +
>>      domain = irq_domain_add_linear(dev_of_node(dev),
>>                         ti_sci_get_num_resources(inta->vint),
>>                         &ti_sci_inta_irq_domain_ops, inta);
> 
>         M.

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

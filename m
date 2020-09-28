Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03F1427A91A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 09:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbgI1HyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 03:54:17 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:46762 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbgI1HyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 03:54:16 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08S7s1rK045014;
        Mon, 28 Sep 2020 02:54:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601279641;
        bh=cgJvYSHXLpTFbCnxLixqYlchPoF77Eey0h+ZJOn5yy0=;
        h=Subject:From:To:CC:References:Date:In-Reply-To;
        b=NA2Iw6EXx1tXdIUehLyQFK1mErYJAcK6iWPZHq0C91ZqxZhbRkxk7Iap1vn4iV4Kc
         1fi3h7eLGtrCpEyrtAZ2/HyizZNiPdq6SlqG43IjLekzPKgPlf5gRx4W6P+angf0UN
         uDz+xgEpJY5nQK2McvUabAzzVHb9fmr9k8Aj3e+c=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08S7s1Ub034693;
        Mon, 28 Sep 2020 02:54:01 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 28
 Sep 2020 02:54:01 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 28 Sep 2020 02:54:01 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08S7rw2I082114;
        Mon, 28 Sep 2020 02:53:59 -0500
Subject: Re: [PATCH 2/2] irqchip/ti-sci-inta: Add support for unmapped event
 handling
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <nm@ti.com>, <t-kristo@ti.com>, <ssantosh@kernel.org>,
        <tglx@linutronix.de>, <jason@lakedaemon.net>, <maz@kernel.org>,
        <robh+dt@kernel.org>, <lokeshvutla@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <20200928063930.12012-1-peter.ujfalusi@ti.com>
 <20200928063930.12012-3-peter.ujfalusi@ti.com>
X-Pep-Version: 2.0
Message-ID: <83675156-66ed-e0c8-cbb7-7a9a2739bb95@ti.com>
Date:   Mon, 28 Sep 2020 10:54:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200928063930.12012-3-peter.ujfalusi@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28/09/2020 9.39, Peter Ujfalusi wrote:
> The DMA (BCDMA/PKTDMA and their rings/flows) events are under the INTA'=
s
> supervision as unmapped events in AM64.
>=20
> In order to keep the current SW stack working, the INTA driver must rep=
lace
> the dev_id with it's own when a request comes for BCDMA or PKTDMA
> resources.
>=20
> Implement parsing of the optional "ti,unmapped-event-sources" phandle a=
rray
> to get the sci-dev-ids of the devices where the unmapped events origina=
te.
>=20
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  drivers/irqchip/irq-ti-sci-inta.c | 72 +++++++++++++++++++++++++++++--=

>  1 file changed, 68 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/irqchip/irq-ti-sci-inta.c b/drivers/irqchip/irq-ti=
-sci-inta.c
> index bc863ef7998d..02914d29140b 100644
> --- a/drivers/irqchip/irq-ti-sci-inta.c
> +++ b/drivers/irqchip/irq-ti-sci-inta.c
> @@ -85,6 +85,8 @@ struct ti_sci_inta_vint_desc {
>   * @base:		Base address of the memory mapped IO registers
>   * @pdev:		Pointer to platform device.
>   * @ti_sci_id:		TI-SCI device identifier
> + * @difu_cnt:		Number of TI-SCI device identifiers for unmapped events=

> + * @dev_ids_for_unmapped: Pointer to an array of TI-SCI device identif=
iers
>   */
>  struct ti_sci_inta_irq_domain {
>  	const struct ti_sci_handle *sci;
> @@ -96,11 +98,33 @@ struct ti_sci_inta_irq_domain {
>  	void __iomem *base;
>  	struct platform_device *pdev;
>  	u32 ti_sci_id;
> +
> +	int difu_cnt;
> +	u32 *dev_ids_for_unmapped;
>  };
> =20
>  #define to_vint_desc(e, i) container_of(e, struct ti_sci_inta_vint_des=
c, \
>  					events[i])
> =20
> +static u16 ti_sci_inta_get_dev_id(struct ti_sci_inta_irq_domain *inta,=

> +				  u32 hwirq)
> +{
> +	u16 dev_id =3D HWIRQ_TO_DEVID(hwirq);
> +	int i;
> +
> +	if (inta->difu_cnt =3D=3D 0)
> +		return dev_id;
> +
> +	for (i =3D 0; i < inta->difu_cnt; i++) {
> +		if (dev_id =3D=3D inta->dev_ids_for_unmapped[i]) {
> +			dev_id =3D inta->ti_sci_id;
> +			break;
> +		}
> +	}
> +
> +	return dev_id;
> +}
> +
>  /**
>   * ti_sci_inta_irq_handler() - Chained IRQ handler for the vint irqs
>   * @desc:	Pointer to irq_desc corresponding to the irq
> @@ -251,7 +275,7 @@ static struct ti_sci_inta_event_desc *ti_sci_inta_a=
lloc_event(struct ti_sci_inta
>  	u16 dev_id, dev_index;
>  	int err;
> =20
> -	dev_id =3D HWIRQ_TO_DEVID(hwirq);
> +	dev_id =3D ti_sci_inta_get_dev_id(inta, hwirq);
>  	dev_index =3D HWIRQ_TO_IRQID(hwirq);
> =20
>  	event_desc =3D &vint_desc->events[free_bit];
> @@ -352,14 +376,15 @@ static void ti_sci_inta_free_irq(struct ti_sci_in=
ta_event_desc *event_desc,
>  {
>  	struct ti_sci_inta_vint_desc *vint_desc;
>  	struct ti_sci_inta_irq_domain *inta;
> +	u16 dev_id;
> =20
>  	vint_desc =3D to_vint_desc(event_desc, event_desc->vint_bit);
>  	inta =3D vint_desc->domain->host_data;
> +	dev_id =3D ti_sci_inta_get_dev_id(inta, hwirq);
>  	/* free event irq */
>  	mutex_lock(&inta->vint_mutex);
>  	inta->sci->ops.rm_irq_ops.free_event_map(inta->sci,
> -						 HWIRQ_TO_DEVID(hwirq),
> -						 HWIRQ_TO_IRQID(hwirq),
> +						 dev_id, HWIRQ_TO_IRQID(hwirq),
>  						 inta->ti_sci_id,
>  						 vint_desc->vint_id,
>  						 event_desc->global_event,
> @@ -562,7 +587,6 @@ static void ti_sci_inta_msi_set_desc(msi_alloc_info=
_t *arg,
>  	arg->desc =3D desc;
>  	arg->hwirq =3D TO_HWIRQ(pdev->id, desc->inta.dev_index);
>  }
> -
>  static struct msi_domain_ops ti_sci_inta_msi_ops =3D {
>  	.set_desc	=3D ti_sci_inta_msi_set_desc,
>  };
> @@ -574,6 +598,42 @@ static struct msi_domain_info ti_sci_inta_msi_doma=
in_info =3D {
>  	.chip	=3D &ti_sci_inta_msi_irq_chip,
>  };
> =20
> +static int ti_sci_inta_get_unmapped_sources(struct ti_sci_inta_irq_dom=
ain *inta)
> +{
> +	struct device *dev =3D &inta->pdev->dev;
> +	struct device_node *node =3D dev_of_node(dev);
> +	struct of_phandle_iterator it;
> +	int count, err, ret, i;
> +
> +	count =3D of_count_phandle_with_args(node, "ti,unmapped-event-sources=
",
> +					   NULL);
> +	if (count <=3D 0)
> +		return count;

We should return 0 as the property is optional.
I will wait for other comments and send v2 with this fixed.

> +
> +	inta->dev_ids_for_unmapped =3D devm_kcalloc(dev, count,
> +					sizeof(*inta->dev_ids_for_unmapped),
> +					GFP_KERNEL);
> +	if (!inta->dev_ids_for_unmapped)
> +		return -ENOMEM;
> +
> +	i =3D 0;
> +	of_for_each_phandle(&it, err, node, "ti,unmapped-event-sources",
> +			    NULL, 0) {
> +		ret =3D of_property_read_u32(it.node, "ti,sci-dev-id",
> +					   &inta->dev_ids_for_unmapped[i++]);
> +		if (ret) {
> +			dev_err(dev, "ti,sci-dev-id read failure for %s\n",
> +				of_node_full_name(it.node));
> +			of_node_put(it.node);
> +			return ret;
> +		}
> +	}
> +
> +	inta->difu_cnt =3D count;
> +
> +	return 0;
> +}
> +
>  static int ti_sci_inta_irq_domain_probe(struct platform_device *pdev)
>  {
>  	struct irq_domain *parent_domain, *domain, *msi_domain;
> @@ -629,6 +689,10 @@ static int ti_sci_inta_irq_domain_probe(struct pla=
tform_device *pdev)
>  	if (IS_ERR(inta->base))
>  		return PTR_ERR(inta->base);
> =20
> +	ret =3D ti_sci_inta_get_unmapped_sources(inta);
> +	if (ret)
> +		return ret;
> +
>  	domain =3D irq_domain_add_linear(dev_of_node(dev),
>  				       ti_sci_get_num_resources(inta->vint),
>  				       &ti_sci_inta_irq_domain_ops, inta);
>=20

- P=C3=A9ter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki


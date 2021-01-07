Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB8E92EC879
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 04:01:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbhAGDBD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 6 Jan 2021 22:01:03 -0500
Received: from mail-eopbgr1300114.outbound.protection.outlook.com ([40.107.130.114]:22457
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726326AbhAGDBC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 22:01:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wlt5abQNpFmp0wCndsDJ1q/OkEUYzPQB/r2/RZixhyk9nBxLydo3am586a6ll0gLB6rgBwVenXoZSeSyCS9GjdpTUOcQuATNOXZNB29jWJz+8JNO9UvZ8bC0fsCL1+kzqOKFCaaeVPViyvcFBD7S4dV68SuoJ8GkciVV+YKxpa8A2x5BdgWeUNFj6n4WKFOdAvoJIFoP1UcSHpchCSXtl4z/xLFWMdGxzOQh9RD2ofQhnHToC4sMceKKrynnTYDogCnC81Ro1X29/8ir5xBnemhJSAGJpx6+2OziVzHVeinEi7WV6Qbns1YO9q90rywddOC3M7pp394ndIzATjX2rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sdtdsbn554L3rFaS36XfZF+hJ4ydBzn7hX446ZStvOo=;
 b=HWB4bJ74wQjAYbsgmINA9276iRMWoSgNAe+jjbx7TIMJXc+kuypesPjnEw5r8Kwit+Lq0t2yZ/nfcjiShByvHV7WaK+1aU3RbwFMaD0e9Wv1oTZsZYURxJI8+qlbvVlDkVouPVJ2m1tgg2geuavuzJCrfXkUEIcKMv/8JlR9FnAbUg09q/yWmB4yFjmnXBzFyS6i30ozbS6D2Y/oM74fOwTcnVSr6+XHvPFuV+S8PIF6diq+t3hWHbCYZOvC8nKVsHubs3ItuxdTN6Qy2x5+4h0aVX9emb4MEnbKYmOKZsfxQ5RNCjf3UHOWnzZ/2/sA54UaHBxs4QDvNt30qPmN0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
Received: from HK0PR06MB3779.apcprd06.prod.outlook.com (2603:1096:203:b8::10)
 by HK0PR06MB2114.apcprd06.prod.outlook.com (2603:1096:203:49::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.20; Thu, 7 Jan
 2021 02:59:23 +0000
Received: from HK0PR06MB3779.apcprd06.prod.outlook.com
 ([fe80::7061:73d9:50ae:b35e]) by HK0PR06MB3779.apcprd06.prod.outlook.com
 ([fe80::7061:73d9:50ae:b35e%7]) with mapi id 15.20.3721.024; Thu, 7 Jan 2021
 02:59:23 +0000
From:   ChiaWei Wang <chiawei_wang@aspeedtech.com>
To:     Marc Zyngier <maz@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        BMC-SW <BMC-SW@aspeedtech.com>
Subject: RE: [PATCH 4/6] irqchip/aspeed: Add Aspeed eSPI interrupt controller
Thread-Topic: [PATCH 4/6] irqchip/aspeed: Add Aspeed eSPI interrupt controller
Thread-Index: AQHW4/EFDPfA39yS00+qPo9RMp545KoabhuAgAEH4eA=
Date:   Thu, 7 Jan 2021 02:59:23 +0000
Message-ID: <HK0PR06MB377957C33FDD43C5A7F5EA1691AF0@HK0PR06MB3779.apcprd06.prod.outlook.com>
References: <20210106055939.19386-1-chiawei_wang@aspeedtech.com>
 <20210106055939.19386-5-chiawei_wang@aspeedtech.com>
 <123bc25c72b3b17c0c4154d8bd8ce3b0@kernel.org>
In-Reply-To: <123bc25c72b3b17c0c4154d8bd8ce3b0@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=aspeedtech.com;
x-originating-ip: [211.20.114.70]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c9913f1c-a344-403b-8f16-08d8b2b83cc3
x-ms-traffictypediagnostic: HK0PR06MB2114:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HK0PR06MB2114622A5DF838A0FF54B64491AF0@HK0PR06MB2114.apcprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NkfXmbt3lOTbSny+Rqb/7Gz1Ra2Wl/Hjlwqur/ynaWGceYNoVA89yq2o3m4J8zSyCt3M4L9YSPypxTKsvlVDbvJiceRB9henoJB6JdMoAhVhCSxRmgStxIxj+ViBrs4Uq6oeYhxo3MBSkEFNERZu1bPC/HuSzJOBoLYBTPpPodiLqErWYNo93/JxlSeiJvs5dh7x2cFGqqKHNI8CqJkf5a8Kewm/K4rpTm46I2gfqGsd1q8YW7Dlns8JBoVLXdVSvBohQ88WFiuPWHPPyKTXXwb8sopNCrLoWDY2UBaAzV9oY7LziGkvGt50bn10pEeWeHxoh4FLtbrftiuif1RgQ5E8AoNaLZEomMqZl6tWYC57kEMQ4IIYf5ueyn72xaJtL+Xv+CSJ4EPtEJaYqjZtiQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3779.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(39840400004)(366004)(376002)(396003)(6916009)(5660300002)(186003)(52536014)(478600001)(6506007)(8936002)(53546011)(7696005)(86362001)(4326008)(7416002)(55236004)(2906002)(8676002)(83380400001)(54906003)(33656002)(26005)(71200400001)(66476007)(66946007)(64756008)(66446008)(76116006)(316002)(66556008)(55016002)(107886003)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?ErrijoRayLFi3ii1wYCjwkxHTt/ib7RV5p45JSNdRpxV1EmbU0/RunE22p8u?=
 =?us-ascii?Q?e/i7XkuvKMkrJLjHvOQ0m6cbs87syChl2TixwTbkZqCBW5XwGYJ0usWaio/o?=
 =?us-ascii?Q?eiBJwKOEAUIIdtAwrZEqwFv7nTlQVIYxeDC7uEekUvz/JPdtKbZTzyXJhG2z?=
 =?us-ascii?Q?mYt0qyjJetE6dlOGZXGyJeqmXzVNvKys1YDWpfDC6Ix/7Y/146abI9sjkLPQ?=
 =?us-ascii?Q?LmUj+RYZyQUBuT+5QitC8fNBjmBdU3EhY1eCn6ZUZ0sk5LgJ47fiE2QH3Elo?=
 =?us-ascii?Q?y54fCWFh5gFmW3OU/hJby6oWMTY9A8MmjF2ViO6ON0l74x73h/ig59aupkS6?=
 =?us-ascii?Q?7/us/nn/+41reuuzRLP/GI3YJa2a0RClTmV6KHvxJPdy9VL7b2dcEzttNWb+?=
 =?us-ascii?Q?KBPsPBWMqJJJ1oWp7fg9PbITdPeT261Uzfx1nzNcs/yOekFiQ0Tw7ykA3yzQ?=
 =?us-ascii?Q?Wn18xdXJ9sczokvyHAWMprjHrjYqerIcJchN0LfS88jxLcMYMUo4tGCgudaA?=
 =?us-ascii?Q?HKVutBrZkmzi52zG//IPJRrziNBWqsmLuuznPcDOKbfCCqjoo1OEa5D6JMoZ?=
 =?us-ascii?Q?2r0KTDdB6fkfgiQbRxu6LRbkhO4s0nNbX3FO/298BxUt1n6kJRPcPdJ6MThL?=
 =?us-ascii?Q?n+sjFF3WG4ddFXAPBJtiLmFRzMc/fvKTu6WBXZMSr2QJrviHfwfN/VaG3zeg?=
 =?us-ascii?Q?8B9MtAqbzo6/6cc3keWUo0IjQxJp+nqKLdexAJr/Kd7yhvqknLOPQIdgJl2s?=
 =?us-ascii?Q?Vqr8dGoLz7wzwtg20lsMffbnATN90G1zKUIdxPM74UXIISuFG2T4tfH+6Xl3?=
 =?us-ascii?Q?fFAJZV+k/Bh0MwOnw1ugXdCdYILyHSyc80STh2CGPfwrtXgEF9WW87oB4LmY?=
 =?us-ascii?Q?nga74b70455Lt/PWCOTSJ90rI/MZHGiRnw1y6P4SOlTRlH53KMv0Ql4gnpC7?=
 =?us-ascii?Q?sfuOkVXJc2y3x7H25mfGBow77eANEoJdv/bm1zMwdvI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3779.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9913f1c-a344-403b-8f16-08d8b2b83cc3
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2021 02:59:23.4191
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ht88/n4rCj+QtqGm0QstyVB0Eb276pwuQ0HNvCn9T1Ilrlw6y+owecwmqSHRXe0AjbXfJki4D5EdFZr72mujwtekO/i6HZuQrQUDeBpegqg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR06MB2114
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

> -----Original Message-----
> From: Marc Zyngier <maz@kernel.org>
> Sent: Wednesday, January 6, 2021 6:59 PM
> To: ChiaWei Wang <chiawei_wang@aspeedtech.com>
> Subject: Re: [PATCH 4/6] irqchip/aspeed: Add Aspeed eSPI interrupt controller
> 
> On 2021-01-06 05:59, Chia-Wei, Wang wrote:
> > The eSPI interrupt controller acts as a SW IRQ number decoder to
> > correctly control/dispatch interrupts of the eSPI peripheral, virtual
> > wire, out-of-band, and flash channels.
> >
> > Signed-off-by: Chia-Wei, Wang <chiawei_wang@aspeedtech.com>
> > ---
> >  drivers/irqchip/Makefile             |   2 +-
> >  drivers/irqchip/irq-aspeed-espi-ic.c | 251 ++++++++++++++++++++++++
> >  include/soc/aspeed/espi.h            | 279
> +++++++++++++++++++++++++++
> >  3 files changed, 531 insertions(+), 1 deletion(-)  create mode 100644
> > drivers/irqchip/irq-aspeed-espi-ic.c
> >  create mode 100644 include/soc/aspeed/espi.h
> >
> > diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile index
> > 0ac93bfaec61..56da4a3123f8 100644
> > --- a/drivers/irqchip/Makefile
> > +++ b/drivers/irqchip/Makefile
> > @@ -86,7 +86,7 @@ obj-$(CONFIG_MVEBU_PIC)			+=
> irq-mvebu-pic.o
> >  obj-$(CONFIG_MVEBU_SEI)			+= irq-mvebu-sei.o
> >  obj-$(CONFIG_LS_EXTIRQ)			+= irq-ls-extirq.o
> >  obj-$(CONFIG_LS_SCFG_MSI)		+= irq-ls-scfg-msi.o
> > -obj-$(CONFIG_ARCH_ASPEED)		+= irq-aspeed-vic.o irq-aspeed-i2c-ic.o
> > irq-aspeed-scu-ic.o
> > +obj-$(CONFIG_ARCH_ASPEED)		+= irq-aspeed-vic.o irq-aspeed-i2c-ic.o
> > irq-aspeed-scu-ic.o irq-aspeed-espi-ic.o
> >  obj-$(CONFIG_STM32_EXTI) 		+= irq-stm32-exti.o
> >  obj-$(CONFIG_QCOM_IRQ_COMBINER)		+= qcom-irq-combiner.o
> >  obj-$(CONFIG_IRQ_UNIPHIER_AIDET)	+= irq-uniphier-aidet.o
> > diff --git a/drivers/irqchip/irq-aspeed-espi-ic.c
> > b/drivers/irqchip/irq-aspeed-espi-ic.c
> > new file mode 100644
> > index 000000000000..8a5cc8fe3f0c
> > --- /dev/null
> > +++ b/drivers/irqchip/irq-aspeed-espi-ic.c
> > @@ -0,0 +1,251 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Copyright (c) 2020 Aspeed Technology Inc.
> > + */
> > +#include <linux/bitops.h>
> > +#include <linux/module.h>
> > +#include <linux/irq.h>
> > +#include <linux/irqchip.h>
> > +#include <linux/irqchip/chained_irq.h> #include <linux/irqdomain.h>
> > +#include <linux/interrupt.h> #include <linux/mfd/syscon.h> #include
> > +<linux/regmap.h> #include <linux/of.h> #include <linux/of_platform.h>
> > +
> > +#include <soc/aspeed/espi.h>
> > +#include <dt-bindings/interrupt-controller/aspeed-espi-ic.h>
> > +
> > +#define DEVICE_NAME	"aspeed-espi-ic"
> > +#define IRQCHIP_NAME	"eSPI-IC"
> > +
> > +#define ESPI_IC_IRQ_NUM	7
> > +
> > +struct aspeed_espi_ic {
> > +	struct regmap *map;
> > +	int irq;
> > +	int gpio_irq;
> > +	struct irq_domain *irq_domain;
> > +};
> > +
> > +static void aspeed_espi_ic_gpio_isr(struct irq_desc *desc) {
> > +	unsigned int irq;
> > +	struct aspeed_espi_ic *espi_ic = irq_desc_get_handler_data(desc);
> > +	struct irq_chip *chip = irq_desc_get_chip(desc);
> > +
> > +	chained_irq_enter(chip, desc);
> > +
> > +	irq = irq_find_mapping(espi_ic->irq_domain,
> > +				   ASPEED_ESPI_IC_CTRL_RESET);
> > +	generic_handle_irq(irq);
> > +
> > +	irq = irq_find_mapping(espi_ic->irq_domain,
> > +				   ASPEED_ESPI_IC_CHAN_RESET);
> > +	generic_handle_irq(irq);
> 
> So for each mux interrupt, you generate two endpoints interrupt, without even
> checking whether they are pending? That's no good.

As the eSPI IC driver is chained to Aspeed GPIO IC, the pending is checked in the gpio-aspeed.c

> > +
> > +	chained_irq_exit(chip, desc);
> > +}
> > +
> > +static void aspeed_espi_ic_isr(struct irq_desc *desc) {
> > +	unsigned int sts;
> > +	unsigned int irq;
> > +	struct aspeed_espi_ic *espi_ic = irq_desc_get_handler_data(desc);
> > +	struct irq_chip *chip = irq_desc_get_chip(desc);
> > +
> > +	chained_irq_enter(chip, desc);
> > +
> > +	regmap_read(espi_ic->map, ESPI_INT_STS, &sts);
> > +
> > +	if (sts & ESPI_INT_STS_PERIF_BITS) {
> > +		irq = irq_find_mapping(espi_ic->irq_domain,
> > +				       ASPEED_ESPI_IC_PERIF_EVENT);
> > +		generic_handle_irq(irq);
> > +	}
> > +
> > +	if (sts & ESPI_INT_STS_VW_BITS) {
> > +		irq = irq_find_mapping(espi_ic->irq_domain,
> > +				       ASPEED_ESPI_IC_VW_EVENT);
> > +		generic_handle_irq(irq);
> > +	}
> > +
> > +	if (sts & ESPI_INT_STS_OOB_BITS) {
> > +		irq = irq_find_mapping(espi_ic->irq_domain,
> > +				       ASPEED_ESPI_IC_OOB_EVENT);
> > +		generic_handle_irq(irq);
> > +	}
> > +
> > +	if (sts & ESPI_INT_STS_FLASH_BITS) {
> > +		irq = irq_find_mapping(espi_ic->irq_domain,
> > +				       ASPEED_ESPI_IC_FLASH_EVENT);
> > +		generic_handle_irq(irq);
> > +	}
> > +
> > +	if (sts & ESPI_INT_STS_HW_RST_DEASSERT) {
> > +		irq = irq_find_mapping(espi_ic->irq_domain,
> > +				       ASPEED_ESPI_IC_CTRL_EVENT);
> > +		generic_handle_irq(irq);
> > +	}
> 
> This is horrible. Why can't you just use fls() in a loop?

The bits in the interrupt status register for a eSPI channel are not sequentially arranged.
Using fls() may invoke an eSPI channel ISR multiple times.
So I collected the bitmap for each channel, respectively, and call the ISR at once.

> 
> > +
> > +	chained_irq_exit(chip, desc);
> > +}
> > +
> > +static void aspeed_espi_ic_irq_disable(struct irq_data *data) {
> > +	struct aspeed_espi_ic *espi_ic = irq_data_get_irq_chip_data(data);
> > +
> > +	switch (data->hwirq) {
> > +	case ASPEED_ESPI_IC_CTRL_EVENT:
> > +		regmap_update_bits(espi_ic->map, ESPI_INT_EN,
> > +				   ESPI_INT_EN_HW_RST_DEASSERT,
> > +				   0);
> > +		break;
> > +	case ASPEED_ESPI_IC_PERIF_EVENT:
> > +		regmap_update_bits(espi_ic->map, ESPI_INT_EN,
> > +				   ESPI_INT_EN_PERIF_BITS, 0);
> > +		break;
> > +	case ASPEED_ESPI_IC_VW_EVENT:
> > +		regmap_update_bits(espi_ic->map, ESPI_INT_EN,
> > +				   ESPI_INT_EN_VW_BITS, 0);
> > +		break;
> > +	case ASPEED_ESPI_IC_OOB_EVENT:
> > +		regmap_update_bits(espi_ic->map, ESPI_INT_EN,
> > +				   ESPI_INT_EN_OOB_BITS, 0);
> > +		break;
> > +	case ASPEED_ESPI_IC_FLASH_EVENT:
> > +		regmap_update_bits(espi_ic->map, ESPI_INT_EN,
> > +				   ESPI_INT_EN_FLASH_BITS, 0);
> > +		break;
> > +	}
> 
> Most of these are masking multiple events at once, which makes me think that
> it really doesn't belong here...
> 
> > +}
> > +
> > +static void aspeed_espi_ic_irq_enable(struct irq_data *data) {
> > +	struct aspeed_espi_ic *espi_ic = irq_data_get_irq_chip_data(data);
> > +
> > +	switch (data->hwirq) {
> > +	case ASPEED_ESPI_IC_CTRL_EVENT:
> > +		regmap_update_bits(espi_ic->map, ESPI_INT_EN,
> > +				   ESPI_INT_EN_HW_RST_DEASSERT,
> > +				   ESPI_INT_EN_HW_RST_DEASSERT);
> > +		break;
> > +	case ASPEED_ESPI_IC_PERIF_EVENT:
> > +		regmap_update_bits(espi_ic->map, ESPI_INT_EN,
> > +				   ESPI_INT_EN_PERIF_BITS,
> > +				   ESPI_INT_EN_PERIF_BITS);
> > +		break;
> > +	case ASPEED_ESPI_IC_VW_EVENT:
> > +		regmap_update_bits(espi_ic->map, ESPI_INT_EN,
> > +				   ESPI_INT_EN_VW_BITS,
> > +				   ESPI_INT_EN_VW_BITS);
> > +		break;
> > +	case ASPEED_ESPI_IC_OOB_EVENT:
> > +		regmap_update_bits(espi_ic->map, ESPI_INT_EN,
> > +				   ESPI_INT_EN_OOB_BITS,
> > +				   ESPI_INT_EN_OOB_BITS);
> > +		break;
> > +	case ASPEED_ESPI_IC_FLASH_EVENT:
> > +		regmap_update_bits(espi_ic->map, ESPI_INT_EN,
> > +				   ESPI_INT_EN_FLASH_BITS,
> > +				   ESPI_INT_EN_FLASH_BITS);
> > +		break;
> > +	}
> > +}
> > +
> > +static struct irq_chip aspeed_espi_ic_chip = {
> > +	.name = IRQCHIP_NAME,
> > +	.irq_enable = aspeed_espi_ic_irq_enable,
> > +	.irq_disable = aspeed_espi_ic_irq_disable, };
> > +
> > +static int aspeed_espi_ic_map(struct irq_domain *domain, unsigned int
> > irq,
> > +			     irq_hw_number_t hwirq)
> > +{
> > +	irq_set_chip_and_handler(irq, &aspeed_espi_ic_chip,
> > handle_simple_irq);
> > +	irq_set_chip_data(irq, domain->host_data);
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct irq_domain_ops aspeed_espi_ic_domain_ops = {
> > +	.map = aspeed_espi_ic_map,
> > +};
> > +
> > +static int aspeed_espi_ic_probe(struct platform_device *pdev) {
> > +	struct device *dev;
> > +	struct aspeed_espi_ic *espi_ic;
> > +
> > +	dev = &pdev->dev;
> > +
> > +	espi_ic = devm_kzalloc(dev, sizeof(*espi_ic), GFP_KERNEL);
> > +	if (!espi_ic)
> > +		return -ENOMEM;
> > +
> > +	espi_ic->map = syscon_node_to_regmap(dev->parent->of_node);
> > +	if (IS_ERR(espi_ic->map)) {
> > +		dev_err(dev, "cannot get regmap\n");
> > +		return -ENODEV;
> > +	}
> > +
> > +	espi_ic->irq = platform_get_irq(pdev, 0);
> > +	if (espi_ic->irq < 0)
> > +		return espi_ic->irq;
> > +
> > +	espi_ic->gpio_irq = platform_get_irq(pdev, 1);
> > +	if (espi_ic->gpio_irq < 0)
> > +		return espi_ic->gpio_irq;
> > +
> > +	espi_ic->irq_domain = irq_domain_add_linear(dev->of_node,
> > ESPI_IC_IRQ_NUM,
> > +						    &aspeed_espi_ic_domain_ops,
> > +						    espi_ic);
> > +	if (!espi_ic->irq_domain) {
> > +		dev_err(dev, "cannot to add irq domain\n");
> > +		return -ENOMEM;
> > +	}
> > +
> > +	irq_set_chained_handler_and_data(espi_ic->irq,
> > +					 aspeed_espi_ic_isr,
> > +					 espi_ic);
> > +
> > +	irq_set_chained_handler_and_data(espi_ic->gpio_irq,
> > +					 aspeed_espi_ic_gpio_isr,
> > +					 espi_ic);
> > +
> > +	dev_set_drvdata(dev, espi_ic);
> > +
> > +	dev_info(dev, "eSPI IRQ controller initialized\n");
> > +
> > +	return 0;
> > +}
> > +
> > +static int aspeed_espi_ic_remove(struct platform_device *pdev) {
> > +	struct aspeed_espi_ic *espi_ic = platform_get_drvdata(pdev);
> > +
> > +	irq_domain_remove(espi_ic->irq_domain);
> > +	return 0;
> > +}
> > +
> > +static const struct of_device_id aspeed_espi_ic_of_matches[] = {
> > +	{ .compatible = "aspeed,ast2600-espi-ic" },
> > +	{ },
> > +};
> > +
> > +static struct platform_driver aspeed_espi_ic_driver = {
> > +	.driver = {
> > +		.name = DEVICE_NAME,
> > +		.of_match_table = aspeed_espi_ic_of_matches,
> > +	},
> > +	.probe = aspeed_espi_ic_probe,
> > +	.remove = aspeed_espi_ic_remove,
> > +};
> > +
> > +module_platform_driver(aspeed_espi_ic_driver);
> > +
> > +MODULE_AUTHOR("Chia-Wei Wang <chiawei_wang@aspeedtech.com>");
> > +MODULE_AUTHOR("Ryan Chen <ryan_chen@aspeedtech.com>");
> > +MODULE_DESCRIPTION("Aspeed eSPI interrupt controller");
> > +MODULE_LICENSE("GPL v2");
> > diff --git a/include/soc/aspeed/espi.h b/include/soc/aspeed/espi.h new
> > file mode 100644 index 000000000000..c9a4f51737ee
> > --- /dev/null
> > +++ b/include/soc/aspeed/espi.h
> > @@ -0,0 +1,279 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +/*
> > + * Copyright (c) 2020 Aspeed Technology Inc.
> > + * Author: Chia-Wei Wang <chiawei_wang@aspeedtech.com>  */ #ifndef
> > +_ASPEED_ESPI_H_ #define _ASPEED_ESPI_H_
> 
> [...]
> 
> If nothing else uses the data here, move it to the irqchip driver.

The header will be used by other eSPI driver files. 

Chiawei.

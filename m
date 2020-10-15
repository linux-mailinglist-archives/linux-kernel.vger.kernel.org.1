Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24A0128F37D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 15:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730085AbgJONk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 09:40:29 -0400
Received: from mx0b-00010702.pphosted.com ([148.163.158.57]:30557 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730022AbgJONk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 09:40:27 -0400
Received: from pps.filterd (m0098779.ppops.net [127.0.0.1])
        by mx0b-00010702.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 09FDc8XG029260;
        Thu, 15 Oct 2020 08:40:20 -0500
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by mx0b-00010702.pphosted.com with ESMTP id 343as5w2tm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Oct 2020 08:40:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PliOj72duLEthHwZSBn17AvOaqRHvfgfXnFwZyH2/US2tUQ2rblKSX9KLg894E17+B4rkXVY8J2rodJiHCt7oJfRGzfkC4epb4HAE6++zV6UDGPxLdMAiatQIAwM19ynz9oXZsBFoXSGYjhc//ElVj34N72iSH5skexubWQIkqn3QV5FMYvLbWMO1+5ZDTh+2CMl1UWI7LXcAzaeE4M7GjfrpUyRIRq4NNfpfc6H7Eh4Ya33IG6H6bEnYbxRgykRjbMJXX5ALyiaNETe1i6D1zZyp9vZt/RvKkqpF3T1KcyWJejnMORY3vH2VPWR6hKuYHoTb7SzDlxvqHCTQ9UL5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dMOkb7KX4c8T6LoGjzR88iM32TcvTK7vLmnXkwgsp6M=;
 b=cxvcZZlMppm/ao1DlLUapzlYHiVRkyn9XcXFdJTGbEEQk+R6gwafx/Az8g5l1KgbOuej/prZeXOmlyBFeolKYyLT1hyz5AoMMIrjK1OWQLVHBFEuhZ6jifKc2dqssg3MHKCw9XH8Jl2j8svZfPLAa9ok5obmUk/PsbI1L5o6bKfI8PvDeVgAK3h0ZOgcXgOeFSZsIv6Ab5sA+5dLXpDhYZWcsWuDnuZZqrXV9Nu4/bNgwX5z19YbF5POQtkL7GIiOOVToYKhbOiPiC93qCYZvQzcSzxALtYGd+mwCnXzgezG5DixvcWS9FklLm5Med5L+r9ulm9RUB4+7D6mALdxfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ni.com; dmarc=pass action=none header.from=ni.com; dkim=pass
 header.d=ni.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector2-nio365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dMOkb7KX4c8T6LoGjzR88iM32TcvTK7vLmnXkwgsp6M=;
 b=NM+NRIcZAO+ljvW41vjVeDWXID4poEg6ntWZD3ZtOKPu8KD29xQT11KTIDF/duQ8qOwhckFL4DlkkqbA5YD3HSolVlk4Wlo2PNGC4c5sT1VozEkxaYhpZDspQzBBoiMj4/rYHli9J/vZmB5EUOyvi6fLon80At8eo5fHKdo7MYM=
Authentication-Results: samsung.com; dkim=none (message not signed)
 header.d=none;samsung.com; dmarc=none action=none header.from=ni.com;
Received: from SN4PR0401MB3646.namprd04.prod.outlook.com
 (2603:10b6:803:4b::29) by SN6PR04MB4591.namprd04.prod.outlook.com
 (2603:10b6:805:ae::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.27; Thu, 15 Oct
 2020 13:40:18 +0000
Received: from SN4PR0401MB3646.namprd04.prod.outlook.com
 ([fe80::f4f0:f1bc:f09a:da84]) by SN4PR0401MB3646.namprd04.prod.outlook.com
 ([fe80::f4f0:f1bc:f09a:da84%7]) with mapi id 15.20.3455.034; Thu, 15 Oct 2020
 13:40:18 +0000
Date:   Thu, 15 Oct 2020 08:40:17 -0500
From:   Michael Auchter <michael.auchter@ni.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        linux-kernel@vger.kernel.org
Message-ID: <20201015134017.GB239257@xaphan>
References: <CGME20201012145748epcas1p13f59fc2f062133e4988bb1d565408ae9@epcas1p1.samsung.com>
 <20201012144754.738830-1-michael.auchter@ni.com>
 <3c3300b9-33cb-4948-f873-63540ecebbb3@samsung.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c3300b9-33cb-4948-f873-63540ecebbb3@samsung.com>
X-Originating-IP: [2605:a601:ab23:3c00:cdda:4935:f7a0:c63c]
X-ClientProxiedBy: SN2PR01CA0072.prod.exchangelabs.com (2603:10b6:800::40) To
 SN4PR0401MB3646.namprd04.prod.outlook.com (2603:10b6:803:4b::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2605:a601:ab23:3c00:cdda:4935:f7a0:c63c) by SN2PR01CA0072.prod.exchangelabs.com (2603:10b6:800::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21 via Frontend Transport; Thu, 15 Oct 2020 13:40:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 14e7c0b5-625e-47ff-1fbf-08d8710fdabf
X-MS-TrafficTypeDiagnostic: SN6PR04MB4591:
X-Microsoft-Antispam-PRVS: <SN6PR04MB4591F911FDACA4E68798504587020@SN6PR04MB4591.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DL2E4PNkkj2g/HFxKOlNL9STYuNOz1xgjhvU6etK9ZQxI0UlpHVtfeC6l7m7ZkdhH7BpSS6Otgj7biHYIrwsQ6EptT0ubwfqx+JV4HCVGDRq+kEeKGGErF/yOMBLkxohOrraUz8IedzS4pHLs7rLXoOf/smvcyBOwYe7AME0Y79GtNccc58ha8hGbnD+3p5mvFO6ABB27WnG7OgjLbolf6sTHBEAf0jn3wJMbrWUiTFANKHIyQfuK92F4szdctdVmybHnAgn7VxLPa0px0LYwefw2sC6mS+tIznWvSijAjlcs2God2264C8xSChGgfn2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3646.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(39860400002)(136003)(376002)(366004)(346002)(396003)(4326008)(1076003)(186003)(16526019)(52116002)(8936002)(33716001)(83380400001)(53546011)(8676002)(316002)(44832011)(6486002)(2906002)(33656002)(9686003)(86362001)(66556008)(66946007)(478600001)(66476007)(6496006)(6916009)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: UbJgJYecf+XRbd5kU9xUURxq4uIysaxbz4VFlGg16fXrt8+P+cxCY81ir2yqnbPPWRQZNdg+8cafPfaIUDWJdQ8FAsLyD4hlV2re3mekcBywEmw9/bEvgCaIRk3ee+XROhQFW573dv1T7SNShZH8hbFqPgA8m7+BcFflxkpMeIrgZ9hHRCJZ7ibU4JMlnEalosy+PUF2j7qx5/YedE1JYVTlzMFc/kCAj/mwn8tJFw2HF5tX+OavJlPbv7l8jDmDUwkJNOoqQGWoF/SxvB7jcCx8GKxhtF2lp1dyrQ1UgbUa76DTwkZOTWPJ2KtPtYvw6hZ/4TTnVw7L4Ch77J//DS7p/6C+tNfHMNgQ+QT/geUgrbKI3AZaomVUM6qDXcQDCXDqQ+0rCjvKAv/Kj1NIdTepa42F9jiYRS7l/38VK+tbUQyJdZgf4wSDKbOKVSsMIhWCa/yCWR0nna62qJV4xYjl/z62DhgDCEFI4xqhPmXM7ZOZs8cQ01BRHAqHgngYsQHDWgwWcl/pVIOWBmHDiNe07dCJ1kAyVI2xUemP6Us60x/inmaXbPaTc42Ur4a1ZVWBkn4LvZgQLrH/09+5XcT3KuJY9twzG0TOhBREB4IiSZ9H3J0DV4RRxqSVC4gr3LisiQAcj8td85/Z5hpZdGQ7b/PXE4uxQ6vH7/Ere/OK9/A0qzRkjM/xud9EHb3BxkuCJK/pPtWZES3tJcdIqw==
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14e7c0b5-625e-47ff-1fbf-08d8710fdabf
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3646.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2020 13:40:18.3760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w3bi4oxTA7y3fhdpm4K/09PexIlk3njznNGdEeKVR9DVBqvPeCC9UON2l5YOISJn6PI9yNUCimP8mTXdJyevzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4591
Subject: Re: Re: [PATCH v2 1/2] extcon: add driver for TI TUSB320
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-15_08:2020-10-14,2020-10-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_policy_notspam policy=outbound_policy score=30 clxscore=1015
 mlxscore=0 adultscore=0 mlxlogscore=999 malwarescore=0 suspectscore=1
 impostorscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 phishscore=0 classifier=spam adjust=30 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010150097
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 14, 2020 at 12:51:26PM +0900, Chanwoo Choi wrote:
> Hi,
> 
> Looks good to me. I add some comment. Please check them.

Thanks for the prompt review! I'll address these and send out a v3.

Cheers,
 Michael

> On 10/12/20 11:47 PM, Michael Auchter wrote:
> > This patch adds an extcon driver for the TI TUSB320 USB Type-C device.
> > This can be used to detect whether the port is configured as a
> > downstream or upstream facing port.
> > 
> > Signed-off-by: Michael Auchter <michael.auchter@ni.com>
> > ---
> > Changes since v1:
> > - Drop license text that's redundant with SPDX tag
> > - Cleanup, sort list of includes
> > - Add additional register defines
> > - Switch to use regmap API
> > - Fix Kconfig to depend on I2C, not GPIOLIB
> > 
> >  drivers/extcon/Kconfig               |   8 ++
> >  drivers/extcon/Makefile              |   1 +
> >  drivers/extcon/extcon-usbc-tusb320.c | 191 +++++++++++++++++++++++++++
> >  3 files changed, 200 insertions(+)
> >  create mode 100644 drivers/extcon/extcon-usbc-tusb320.c
> > 
> > diff --git a/drivers/extcon/Kconfig b/drivers/extcon/Kconfig
> > index aac507bff135..af58ebca2bf6 100644
> > --- a/drivers/extcon/Kconfig
> > +++ b/drivers/extcon/Kconfig
> > @@ -186,4 +186,12 @@ config EXTCON_USBC_CROS_EC
> >  	  Say Y here to enable USB Type C cable detection extcon support when
> >  	  using Chrome OS EC based USB Type-C ports.
> >  
> > +config EXTCON_USBC_TUSB320
> > +	tristate "TI TUSB320 USB-C extcon support"
> > +	depends on I2C
> > +	select REGMAP_I2C
> > +	help
> > +	  Say Y here to enable support for USB Type C cable detection extcon
> > +	  support using a TUSB320.
> > +
> >  endif
> > diff --git a/drivers/extcon/Makefile b/drivers/extcon/Makefile
> > index 52096fd8a216..fe10a1b7d18b 100644
> > --- a/drivers/extcon/Makefile
> > +++ b/drivers/extcon/Makefile
> > @@ -25,3 +25,4 @@ obj-$(CONFIG_EXTCON_RT8973A)	+= extcon-rt8973a.o
> >  obj-$(CONFIG_EXTCON_SM5502)	+= extcon-sm5502.o
> >  obj-$(CONFIG_EXTCON_USB_GPIO)	+= extcon-usb-gpio.o
> >  obj-$(CONFIG_EXTCON_USBC_CROS_EC) += extcon-usbc-cros-ec.o
> > +obj-$(CONFIG_EXTCON_USBC_TUSB320) += extcon-usbc-tusb320.o
> > diff --git a/drivers/extcon/extcon-usbc-tusb320.c b/drivers/extcon/extcon-usbc-tusb320.c
> > new file mode 100644
> > index 000000000000..93f1843ca89b
> > --- /dev/null
> > +++ b/drivers/extcon/extcon-usbc-tusb320.c
> > @@ -0,0 +1,191 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/**
> > + * drivers/extcon/extcon-tusb320.c - TUSB320 extcon driver
> > + *
> > + * Copyright (C) 2020 National Instruments Corporation
> > + * Author: Michael Auchter <michael.auchter@ni.com>
> > + */
> > +
> > +#include <linux/extcon-provider.h>
> > +#include <linux/i2c.h>
> > +#include <linux/init.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/irq.h>
> 
> irq.h doesn't be needed. Better to remove irq.h.
> 
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/regmap.h>
> > +
> > +#define TUSB320_REG9				0x9
> > +#define TUSB320_REG9_ATTACHED_STATE_SHIFT	6
> > +#define TUSB320_REG9_ATTACHED_STATE_MASK	0x3
> > +#define TUSB320_REG9_CABLE_DIRECTION		BIT(5)
> > +#define TUSB320_REG9_INTERRUPT_STATUS		BIT(4)
> > +#define TUSB320_ATTACHED_STATE_NONE		0x0
> > +#define TUSB320_ATTACHED_STATE_DFP  		0x1
> > +#define TUSB320_ATTACHED_STATE_UFP  		0x2
> > +#define TUSB320_ATTACHED_STATE_ACC  		0x3
> 
> Above definition contain the 'space' for indentation.
> Please edit it as following:
> 
> 
> -#define TUSB320_ATTACHED_STATE_DFP             0x1
> -#define TUSB320_ATTACHED_STATE_UFP             0x2
> -#define TUSB320_ATTACHED_STATE_ACC             0x3
> +#define TUSB320_ATTACHED_STATE_DFP             0x1
> +#define TUSB320_ATTACHED_STATE_UFP             0x2
> +#define TUSB320_ATTACHED_STATE_ACC             0x3
> 
> 
> > +
> > +struct tusb320_priv {
> > +	struct device *dev;
> > +	struct regmap *regmap;
> > +	struct extcon_dev *edev;
> > +};
> > +
> > +static const char * const tusb_attached_states[] = {
> > +	[TUSB320_ATTACHED_STATE_NONE] = "not attached",
> > +	[TUSB320_ATTACHED_STATE_DFP]  = "downstream facing port",
> > +	[TUSB320_ATTACHED_STATE_UFP]  = "upstream facing port",
> > +	[TUSB320_ATTACHED_STATE_ACC]  = "accessory",
> > +};
> > +
> > +static const unsigned int tusb320_extcon_cable[] = {
> > +	EXTCON_USB,
> > +	EXTCON_USB_HOST,
> > +	EXTCON_NONE,
> > +};
> > +
> > +static int tusb320_check_signature(struct tusb320_priv *priv)
> > +{
> > +	static const char sig[] = { '\0', 'T', 'U', 'S', 'B', '3', '2', '0' };
> > +	unsigned val;
> > +	int i, ret;
> > +
> > +	for (i = 0; i < sizeof(sig); i++) {
> > +		ret = regmap_read(priv->regmap, sizeof(sig) - 1 - i, &val);
> > +		if (ret < 0)
> > +			return ret;
> > +		if (val != sig[i]) {
> > +			dev_err(priv->dev, "signature mismatch!\n");
> > +			return -ENODEV;
> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static irqreturn_t tusb320_irq_handler(int irq, void *dev_id)
> > +{
> > +	struct tusb320_priv *priv = dev_id;
> > +	int state, polarity;
> > +	unsigned reg;
> > +
> > +	if (regmap_read(priv->regmap, TUSB320_REG9, &reg)) {
> > +		dev_err(priv->dev, "error during i2c read!\n");
> > +		return IRQ_NONE;
> > +	}
> > +
> > +	if (!(reg & TUSB320_REG9_INTERRUPT_STATUS))
> > +		return IRQ_NONE;
> > +
> > +	state = (reg >> TUSB320_REG9_ATTACHED_STATE_SHIFT) &
> > +		TUSB320_REG9_ATTACHED_STATE_MASK;
> > +	polarity = !!(reg & TUSB320_REG9_CABLE_DIRECTION);
> > +
> > +	dev_dbg(priv->dev, "attached state: %s, polarity: %d\n",
> > +		tusb_attached_states[state], polarity);
> > +
> > +	extcon_set_state(priv->edev, EXTCON_USB,
> > +			 state == TUSB320_ATTACHED_STATE_UFP);
> > +	extcon_set_state(priv->edev, EXTCON_USB_HOST,
> > +			 state == TUSB320_ATTACHED_STATE_DFP);
> > +	extcon_set_property(priv->edev, EXTCON_USB,
> > +			    EXTCON_PROP_USB_TYPEC_POLARITY,
> > +			    (union extcon_property_value)polarity);
> > +	extcon_set_property(priv->edev, EXTCON_USB_HOST,
> > +			    EXTCON_PROP_USB_TYPEC_POLARITY,
> > +			    (union extcon_property_value)polarity);
> > +	extcon_sync(priv->edev, EXTCON_USB);
> > +	extcon_sync(priv->edev, EXTCON_USB_HOST);
> > +
> > +	regmap_write(priv->regmap, TUSB320_REG9, reg);
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static const struct regmap_config tusb320_regmap_config = {
> > +	.reg_bits = 8,
> > +	.val_bits = 8,
> > +};
> > +
> > +static int tusb320_extcon_probe(struct i2c_client *client,
> > +				const struct i2c_device_id *id)
> > +{
> > +	struct tusb320_priv *priv;
> > +	int ret;
> > +
> > +	priv = devm_kzalloc(&client->dev, sizeof(*priv), GFP_KERNEL);
> > +	if (!priv)
> > +		return -ENOMEM;
> > +	priv->dev = &client->dev;
> > +
> > +	priv->regmap = devm_regmap_init_i2c(client, &tusb320_regmap_config);
> > +	if (IS_ERR(priv->regmap))
> > +		return PTR_ERR(priv->regmap);
> > +
> > +	ret = tusb320_check_signature(priv);
> > +	if (ret)
> > +		return ret;
> > +
> > +	priv->edev = devm_extcon_dev_allocate(priv->dev, tusb320_extcon_cable);
> > +	if (IS_ERR(priv->edev)) {
> > +		dev_err(priv->dev, "failed to allocate extcon device\n");
> > +		return -ENOMEM;
> 
> Use 'return PTR_ERR(priv->edev)' instead of '-ENOMEM'.
> 
> > +	}
> > +
> > +	ret = devm_extcon_dev_register(priv->dev, priv->edev);
> > +	if (ret < 0) {
> > +		dev_err(priv->dev, "failed to register extcon device\n");
> > +		return ret;
> > +	}
> > +
> > +	extcon_set_property_capability(priv->edev, EXTCON_USB,
> > +				       EXTCON_PROP_USB_TYPEC_POLARITY);
> > +	extcon_set_property_capability(priv->edev, EXTCON_USB_HOST,
> > +				       EXTCON_PROP_USB_TYPEC_POLARITY);
> > +
> > +	/* update initial state */
> > +	tusb320_irq_handler(client->irq, priv);
> > +
> > +	ret = devm_request_threaded_irq(priv->dev, client->irq, NULL,
> > +					tusb320_irq_handler,
> > +					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> > +					dev_name(priv->dev), priv);
> > +
> > +	return ret;
> > +}
> > +
> > +static const struct of_device_id tusb320_extcon_dt_match[] = {
> > +	{ .compatible = "ti,tusb320", },
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(of, tusb320_extcon_dt_match);
> > +
> > +static const struct i2c_device_id tusb320_i2c_id[] = {
> > +	{ "tusb320", 0 },
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(i2c, tusb320_i2c_id);
> 
> tusb320_i2c_id is not used on this driver.
> 
> > +
> > +static struct i2c_driver tusb320_extcon_driver = {
> > +	.probe		= tusb320_extcon_probe,
> > +	.driver		= {
> > +		.name	= "extcon-tusb320",
> > +		.of_match_table = tusb320_extcon_dt_match,
> > +	},
> > +};
> > +
> > +static int __init tusb320_init(void)
> > +{
> > +	return i2c_add_driver(&tusb320_extcon_driver);
> > +}
> > +subsys_initcall(tusb320_init);
> > +
> > +static void __exit tusb320_exit(void)
> > +{
> > +	i2c_del_driver(&tusb320_extcon_driver);
> > +}
> > +module_exit(tusb320_exit);
> > +
> > +MODULE_AUTHOR("Michael Auchter <michael.auchter@ni.com>");
> > +MODULE_DESCRIPTION("TI TUSB320 extcon driver");
> > +MODULE_LICENSE("GPL v2");
> > 
> 
> -- 
> Best Regards,
> Chanwoo Choi
> Samsung Electronics

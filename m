Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8F2287F9E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 02:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730145AbgJIAwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 20:52:16 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:28309 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730074AbgJIAwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 20:52:14 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20201009005210epoutp02450038bb147d7003c16ec0a121a03e7e~8LLaaORQ31819118191epoutp02W
        for <linux-kernel@vger.kernel.org>; Fri,  9 Oct 2020 00:52:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20201009005210epoutp02450038bb147d7003c16ec0a121a03e7e~8LLaaORQ31819118191epoutp02W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1602204730;
        bh=DEeeLeicPR0xDDFrV2FPbBl/227E8IbxqvUiHdGK1mg=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=uclneGWLEn5Nr6+zBPSpePVT8xWIdWlch7i06/WaHEWOzaxsv3do8xFoNUuAoWQi2
         O9muMP55I4OfxM9qcDLG1NqtVMwg//sb2F86KfbKKaeLGVgnO7386uFaCTEBqE1aRq
         //ymHQmdMXgOr8Str871V5m7jghZIeIXzlBN+rMI=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20201009005208epcas1p3ae131c82f85e144ae03f2271a393a4b8~8LLY7Uy2a2776327763epcas1p3m;
        Fri,  9 Oct 2020 00:52:08 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.158]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4C6qKL34qYzMqYlp; Fri,  9 Oct
        2020 00:52:06 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        89.28.09582.634BF7F5; Fri,  9 Oct 2020 09:52:06 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20201009005205epcas1p45b17c5fabbdd97be8624eb196447ea4b~8LLVt9yTv2604226042epcas1p4G;
        Fri,  9 Oct 2020 00:52:05 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20201009005205epsmtrp23d9ed693f7fc13c53c2793cdfd60e20d~8LLVtWvB31709717097epsmtrp2G;
        Fri,  9 Oct 2020 00:52:05 +0000 (GMT)
X-AuditID: b6c32a37-899ff7000000256e-79-5f7fb436cd88
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        76.47.08604.434BF7F5; Fri,  9 Oct 2020 09:52:04 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20201009005204epsmtip1a045ac0801eb38bfd52cb126d729ba90~8LLVcpP-m1763017630epsmtip1N;
        Fri,  9 Oct 2020 00:52:04 +0000 (GMT)
Subject: Re: [PATCH 1/2] extcon: add driver for TI TUSB320
To:     Michael Auchter <michael.auchter@ni.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Cc:     linux-kernel@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <4acd00c6-8c0f-9478-ac4f-1ba0738fe90a@samsung.com>
Date:   Fri, 9 Oct 2020 10:05:27 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20201008223929.399791-1-michael.auchter@ni.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGKsWRmVeSWpSXmKPExsWy7bCmvq7Zlvp4g/lPxSwu75rDZvHs+U9W
        i9uNK9gcmD2un9nO5NG3ZRWjx+dNcgHMUdk2GamJKalFCql5yfkpmXnptkrewfHO8aZmBoa6
        hpYW5koKeYm5qbZKLj4Bum6ZOUCLlBTKEnNKgUIBicXFSvp2NkX5pSWpChn5xSW2SqkFKTkF
        lgV6xYm5xaV56XrJ+blWhgYGRqZAhQnZGU9+tTEVTHepWHB1HXsD4yHzLkYODgkBE4n5yw26
        GDk5hAR2MEos3SIMYX9ilLh9RQLC/sYoce8+mA1SfvLiU/YuRi6g+F5GiXnt21ghnPeMEt++
        TGcFqRIWsJL4dXc5G4gtIhAucWzScnYQm1lAQeLXvU1gNWwCWhL7X9wAq+EXUJS4+uMxI4jN
        K2Ance3RdTCbRUBF4vSMA8wgtqhAmMTJbS1QNYISJ2c+YQGxOQVsJS72/2KFmC8ucevJfCYI
        W15i+9s5zCDHSQi8ZZd4fPgqC8THLhKvj5RDfCMs8er4FnYIW0ri87u9bBB2tcTKk0fYIHo7
        GCW27L/ACpEwlti/dDITyBxmAU2J9bv0IcKKEjt/z2WE2Msn8e5rDyvEKl6JjjYhiBJlicsP
        7jJB2JISi9s72SYwKs1C8s0sJB/MQvLBLIRlCxhZVjGKpRYU56anFhsWGCPH9CZGcALUMt/B
        OO3tB71DjEwcjIcYJTiYlUR4071r4oV4UxIrq1KL8uOLSnNSiw8xmgLDdyKzlGhyPjAF55XE
        G5oaGRsbW5gYmpkaGiqJ8z68pRAvJJCeWJKanZpakFoE08fEwSnVwPTkbFas2VEHBukJ71ae
        UE6aOenQjpjZErtued4rZOQtejezVDZigcNKUd8ju9gXPjwpOGux0pY3sZq8jk/88mQuGvB1
        iP7hYunfYt30uP0m17/YH6vl8uquRWuEW978L1M/v+ZFh8cbtvMfLmdMqZQwf8N92eBxFQ/T
        8remWVwqC9etPMj2c00JZ8qv+y78K2ZNZn7pN7vAv/rzu2juf7FPvFpebeGffP3WopKWKvv6
        1zV2L+5yaD6dmF3lpa64Rr/iclB56sXgIH3fK3yLHN/a8vpsSbr6at3kYveSKyqWx9gvyxZr
        rHhlGflSYP4T5dPB3r/9TJNlGzdPrd/+cduiReGFvzZ5fagWavOYF6XEUpyRaKjFXFScCAAC
        aYoECQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCLMWRmVeSWpSXmKPExsWy7bCSnK7plvp4g2u+Fpd3zWGzePb8J6vF
        7cYVbA7MHtfPbGfy6NuyitHj8ya5AOYoLpuU1JzMstQifbsErownv9qYCqa7VCy4uo69gfGQ
        eRcjJ4eEgInEyYtP2bsYuTiEBHYzSvT8n8EGkZCUmHbxKHMXIweQLSxx+HAxRM1bRolVm7tZ
        QGqEBawkft1dDlYvIhAuse7CPEYQm1lAQeLXvU2sEA0TGCXefn0PlmAT0JLY/+IGWAO/gKLE
        1R+PweK8AnYS1x5dB7NZBFQkTs84wAxiiwqESexc8pgJokZQ4uTMJ2CLOQVsJS72/2KFWKYu
        8WfeJWYIW1zi1pP5TBC2vMT2t3OYJzAKz0LSPgtJyywkLbOQtCxgZFnFKJlaUJybnltsWGCY
        l1quV5yYW1yal66XnJ+7iREcEVqaOxi3r/qgd4iRiYPxEKMEB7OSCG+6d028EG9KYmVValF+
        fFFpTmrxIUZpDhYlcd4bhQvjhATSE0tSs1NTC1KLYLJMHJxSDUzr+FqzI8U+Su59srrM5UWW
        P8+dhynycU47Da+sKFilfZPL6+aLTrflnLnXHNdEpN7tfPXr0b5u3Q+vVxXcap8S0ndTRjF0
        V/SF87NCjMSd3Vh3spb1q/2edHNhRfIK61Wz+9laWZeacPYxHd3vP2txV7yWyc+TO1/0eS69
        YHjOzzvGzutlbGTPYgWOG6GTcjed8Ar4KO+R/+v98uxm4/TQ42H8ybt6ZWSet/uWT7zdKLol
        puBDfNe2kuC/H6K/h3F8m7Ao7eDMDXP6rIq9HH++2M36Y0orn3RVrlreHxU+Cd67H4/tlunT
        sl0beIiNPSb+o6j09bknZ2xXfnS8i8HbNVeN69SkhKMz4s8s7VNiKc5INNRiLipOBABQMIK9
        9wIAAA==
X-CMS-MailID: 20201009005205epcas1p45b17c5fabbdd97be8624eb196447ea4b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20201008223958epcas1p106e9e643db81b66ac242e91f63510486
References: <CGME20201008223958epcas1p106e9e643db81b66ac242e91f63510486@epcas1p1.samsung.com>
        <20201008223929.399791-1-michael.auchter@ni.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Almost looks good to me. I added some comments.

On 10/9/20 7:39 AM, Michael Auchter wrote:
> This patch adds an extcon driver for the TI TUSB320 USB Type-C device.
> This can be used to detect whether the port is configured as a
> downstream or upstream facing port.
> 
> Signed-off-by: Michael Auchter <michael.auchter@ni.com>
> ---
>  drivers/extcon/Kconfig               |   7 ++
>  drivers/extcon/Makefile              |   1 +
>  drivers/extcon/extcon-usbc-tusb320.c | 180 +++++++++++++++++++++++++++
>  3 files changed, 188 insertions(+)
>  create mode 100644 drivers/extcon/extcon-usbc-tusb320.c
> 
> diff --git a/drivers/extcon/Kconfig b/drivers/extcon/Kconfig
> index aac507bff135..241acaf8b882 100644
> --- a/drivers/extcon/Kconfig
> +++ b/drivers/extcon/Kconfig
> @@ -186,4 +186,11 @@ config EXTCON_USBC_CROS_EC
>  	  Say Y here to enable USB Type C cable detection extcon support when
>  	  using Chrome OS EC based USB Type-C ports.
>  
> +config EXTCON_USBC_TUSB320
> +	tristate "TI TUSB320 USB-C extcon support"
> +	depends on GPIOLIB || COMPILE_TEST
> +	help
> +	  Say Y here to enable support for USB Type C cable detection extcon
> +	  support using a TUSB320.
> +
>  endif
> diff --git a/drivers/extcon/Makefile b/drivers/extcon/Makefile
> index 52096fd8a216..fe10a1b7d18b 100644
> --- a/drivers/extcon/Makefile
> +++ b/drivers/extcon/Makefile
> @@ -25,3 +25,4 @@ obj-$(CONFIG_EXTCON_RT8973A)	+= extcon-rt8973a.o
>  obj-$(CONFIG_EXTCON_SM5502)	+= extcon-sm5502.o
>  obj-$(CONFIG_EXTCON_USB_GPIO)	+= extcon-usb-gpio.o
>  obj-$(CONFIG_EXTCON_USBC_CROS_EC) += extcon-usbc-cros-ec.o
> +obj-$(CONFIG_EXTCON_USBC_TUSB320) += extcon-usbc-tusb320.o
> diff --git a/drivers/extcon/extcon-usbc-tusb320.c b/drivers/extcon/extcon-usbc-tusb320.c
> new file mode 100644
> index 000000000000..217d6f416ff6
> --- /dev/null
> +++ b/drivers/extcon/extcon-usbc-tusb320.c
> @@ -0,0 +1,180 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/**
> + * drivers/extcon/extcon-tusb320.c - TUSB320 extcon driver
> + *
> + * Copyright (C) 2020 National Instruments Corporation
> + * Author: Michael Auchter <michael.auchter@ni.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.

You don't need to additional license info below 'author'
because you added '// SPDX-License-Identifier: GPL-2.0' at the first line.

> + */
> +
> +#include <linux/extcon-provider.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/i2c.h>
> +#include <linux/irq.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/workqueue.h>
> +
> +#define TUSB320_REG_9 0x9
> +#define TUSB320_REG_9_INTERRUPT_STATUS BIT(4)
> +#define TUSB320_REG_9_GET_ATTACHED_STATE(reg) (((reg) >> 6) & 0x3)

You need to define what is meaning of '6' and '0x3'.

#define TUSB30_xxx_SHIFT	6
#define TUSB30_xxx_MASK		0x3

> +#define TUSB320_REG_9_GET_CABLE_DIR(reg) (((reg) >> 5) & 1)

ditto.

#define TUSB30_xxx__SHIFT	5
#define TUSB30_xxx_MASK		0x1


> +#define TUSB320_ATTACHED_STATE_NONE 0x0
> +#define TUSB320_ATTACHED_STATE_DFP  0x1
> +#define TUSB320_ATTACHED_STATE_UFP  0x2
> +#define TUSB320_ATTACHED_STATE_ACC  0x3
> +

nitpick. For the indentation, how about editing as following:

#define TUSB320_REG_9 				0x9
#define TUSB320_REG_9_INTERRUPT_STATUS 		BIT(4)
#define TUSB320_REG_9_GET_ATTACHED_STATE(reg)	(((reg) >> 6) & 0x3)
#define TUSB320_REG_9_GET_CABLE_DIR(reg)	(((reg) >> 5) & 1)
#define TUSB320_ATTACHED_STATE_NONE		0x0
#define TUSB320_ATTACHED_STATE_DFP		0x1
#define TUSB320_ATTACHED_STATE_UFP		0x2
#define TUSB320_ATTACHED_STATE_ACC		0x3

> +static const char * const tusb_attached_states[] = {
> +	[TUSB320_ATTACHED_STATE_NONE] = "not attached",
> +	[TUSB320_ATTACHED_STATE_DFP]  = "downstream facing port",
> +	[TUSB320_ATTACHED_STATE_UFP]  = "upstream facing port",
> +	[TUSB320_ATTACHED_STATE_ACC]  = "accessory",
> +};
> +
> +static const unsigned int tusb320_extcon_cable[] = {
> +	EXTCON_USB,
> +	EXTCON_USB_HOST,
> +	EXTCON_NONE,
> +};
> +
> +static int tusb320_check_signature(struct i2c_client *client)
> +{
> +	static const char sig[] = { '\0', 'T', 'U', 'S', 'B', '3', '2', '0' };
> +	int i, ret;
> +
> +	for (i = 0; i < sizeof(sig); i++) {
> +		ret = i2c_smbus_read_byte_data(client, sizeof(sig) - 1 - i);
> +		if (ret < 0)
> +			return ret;
> +		if (ret != sig[i]) {
> +			dev_err(&client->dev, "signature mismatch!\n");
> +			return -ENODEV;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static irqreturn_t tusb320_irq_handler(int irq, void *dev_id)
> +{
> +	struct i2c_client *client = dev_id;
> +	struct extcon_dev *edev = i2c_get_clientdata(client);
> +	int reg, state, polarity;
> +
> +	reg = i2c_smbus_read_byte_data(client, TUSB320_REG_9);
> +	if (reg < 0) {
> +		dev_err(&client->dev, "error during i2c read: %d\n", reg);
> +		return IRQ_NONE;
> +	}
> +
> +	if (!(reg & TUSB320_REG_9_INTERRUPT_STATUS))
> +		return IRQ_NONE;
> +
> +	state = TUSB320_REG_9_GET_ATTACHED_STATE(reg);
> +	polarity = TUSB320_REG_9_GET_CABLE_DIR(reg);
> +
> +	dev_dbg(&client->dev, "attached state: %s, polarity: %d\n",
> +		tusb_attached_states[state], polarity);
> +
> +	extcon_set_state(edev, EXTCON_USB,
> +			 state == TUSB320_ATTACHED_STATE_UFP);
> +	extcon_set_state(edev, EXTCON_USB_HOST,
> +			 state == TUSB320_ATTACHED_STATE_DFP);
> +	extcon_set_property(edev, EXTCON_USB,
> +			    EXTCON_PROP_USB_TYPEC_POLARITY,
> +			    (union extcon_property_value)polarity);
> +	extcon_set_property(edev, EXTCON_USB_HOST,
> +			    EXTCON_PROP_USB_TYPEC_POLARITY,
> +			    (union extcon_property_value)polarity);
> +	extcon_sync(edev, EXTCON_USB);
> +	extcon_sync(edev, EXTCON_USB_HOST);
> +
> +	i2c_smbus_write_byte_data(client, TUSB320_REG_9, reg);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int tusb320_extcon_probe(struct i2c_client *client,
> +				const struct i2c_device_id *id)
> +{
> +	struct extcon_dev *edev;
> +	int ret;

I recommend that you better to use regmap_i2c with devm_regmap_init_i2c() function
instead of using i2c_smbus_*() function. You can refer regmap_i2c usage
on drivers/extcon/extcon-sm5502.c.

> +
> +	ret = tusb320_check_signature(client);
> +	if (ret)
> +		return ret;
> +
> +	edev = devm_extcon_dev_allocate(&client->dev, tusb320_extcon_cable);
> +	if (IS_ERR(edev)) {
> +		dev_err(&client->dev, "failed to allocate extcon device\n");
> +		return -ENOMEM;
> +	}
> +	i2c_set_clientdata(client, edev);
> +
> +	ret = devm_extcon_dev_register(&client->dev, edev);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "failed to register extcon device\n");
> +		return ret;
> +	}
> +
> +	extcon_set_property_capability(edev, EXTCON_USB,
> +				       EXTCON_PROP_USB_TYPEC_POLARITY);
> +	extcon_set_property_capability(edev, EXTCON_USB_HOST,
> +				       EXTCON_PROP_USB_TYPEC_POLARITY);
> +
> +	/* update initial state */
> +	tusb320_irq_handler(client->irq, client);
> +
> +	ret = devm_request_threaded_irq(&client->dev, client->irq,
> +					NULL, tusb320_irq_handler,
> +					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> +					dev_name(&client->dev), client);
> +
> +	return ret;
> +}
> +
> +static const struct of_device_id tusb320_extcon_dt_match[] = {
> +	{ .compatible = "ti,tusb320", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, tusb320_extcon_dt_match);
> +
> +static const struct i2c_device_id tusb320_i2c_id[] = {
> +	{ "tusb320", 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, tusb320_i2c_id);
> +
> +static struct i2c_driver tusb320_extcon_driver = {
> +	.probe		= tusb320_extcon_probe,
> +	.driver		= {
> +		.name	= "extcon-tusb320",
> +		.of_match_table = tusb320_extcon_dt_match,
> +	},
> +};
> +
> +static int __init tusb320_init(void)
> +{
> +	return i2c_add_driver(&tusb320_extcon_driver);
> +}
> +subsys_initcall(tusb320_init);
> +
> +static void __exit tusb320_exit(void)
> +{
> +	i2c_del_driver(&tusb320_extcon_driver);
> +}
> +module_exit(tusb320_exit);
> +
> +MODULE_AUTHOR("Michael Auchter <michael.auchter@ni.com>");
> +MODULE_DESCRIPTION("TI TUSB320 extcon driver");
> +MODULE_LICENSE("GPL v2");
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AECD0292531
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 12:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729012AbgJSKKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 06:10:47 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:56052 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727192AbgJSKKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 06:10:47 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20201019101042epoutp0448214e2060a134cf88c4ffde6ba5565e~-XP7-0wM91779317793epoutp04v
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 10:10:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20201019101042epoutp0448214e2060a134cf88c4ffde6ba5565e~-XP7-0wM91779317793epoutp04v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1603102242;
        bh=bJPG90jtC8VXPGclK60D2/9MqPO0jJtgPsuXe37vnNU=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=aeRj/ZiSxQqL3V9oO+KqjAt62GX6zp/kFCQWSsGB29UkrjmB32qLXtwYhst+T4Ewu
         l7SsXYzGG+V6b1xLRLem6/sTdP6RNXrpw27Sijr5jZzT93H6pR3ToDDf7e5aPolm5B
         P/Wa9HZwFtDltJZC/5Jhk5iOsh/JtyFs0BgiTVMA=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20201019101042epcas1p16898cd8375a4c14a8cfd9545827aa629~-XP7hyTSP2497724977epcas1p1_;
        Mon, 19 Oct 2020 10:10:42 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.154]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4CFCFD05cYzMqYkW; Mon, 19 Oct
        2020 10:10:40 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        B5.64.09577.D166D8F5; Mon, 19 Oct 2020 19:10:37 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20201019101036epcas1p18d62593ac7957d3c89d62a15595b5821~-XP2DfCvg1709917099epcas1p1m;
        Mon, 19 Oct 2020 10:10:36 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20201019101036epsmtrp2e169dd41891fab79ed1c5a7392f7eed9~-XP2Cy81a0509505095epsmtrp2G;
        Mon, 19 Oct 2020 10:10:36 +0000 (GMT)
X-AuditID: b6c32a39-193b3a8000002569-9c-5f8d661d1357
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        37.AD.08604.C166D8F5; Mon, 19 Oct 2020 19:10:36 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20201019101036epsmtip122260deadfd3934e4308ede8dfb0c6f7~-XP1219VM2482024820epsmtip1R;
        Mon, 19 Oct 2020 10:10:36 +0000 (GMT)
Subject: Re: [PATCH 1/2] extcon: add driver for TI TUSB320
To:     Michael Auchter <michael.auchter@ni.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Cc:     linux-kernel@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <d2494518-ecea-e9b7-a57a-83946948ec2a@samsung.com>
Date:   Mon, 19 Oct 2020 19:24:00 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20201015140737.1183818-1-michael.auchter@ni.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBKsWRmVeSWpSXmKPExsWy7bCmnq5sWm+8wb7lQhaXd81hs3j2/Cer
        xe3GFWwOzB7Xz2xn8ujbsorR4/MmuQDmqGybjNTElNQihdS85PyUzLx0WyXv4HjneFMzA0Nd
        Q0sLcyWFvMTcVFslF58AXbfMHKBFSgpliTmlQKGAxOJiJX07m6L80pJUhYz84hJbpdSClJwC
        ywK94sTc4tK8dL3k/FwrQwMDI1OgwoTsjKP/29gLXtlVvPj9jrWBscW4i5GTQ0LAROLnx+Ws
        XYxcHEICOxglNp87zQjhfGKUWH4TJMMJ5HxjlFi7yx6m4/CJRcwQ8b2MEr+3ZEE0vGeUuPFv
        I1iDsICVxK+7y9lAbBGBcIljk5azg9jMAgoSv+5tAqthE9CS2P/iBlgNv4CixNUfjxlBbF4B
        O4m7Rw8CxTk4WARUJWatqwEJiwqESZzc1gJVIihxcuYTFhCbE6i84dtWZojx4hK3nsxngrDl
        Jba/ncMMcpuEwFt2iSWvZ7JDPOAi8fB6F5QtLPHq+BYoW0ri87u9bBB2tcTKk0fYIJo7GCW2
        7L/ACpEwlti/dDITyHHMApoS63fpQ4QVJXb+nssIsZhP4t3XHlaQEgkBXomONiGIEmWJyw/u
        MkHYkhKL2zvZJjAqzULyziwkL8xC8sIshGULGFlWMYqlFhTnpqcWGxaYIsf1JkZwEtSy3ME4
        /e0HvUOMTByMhxglOJiVRHgjBbvihXhTEiurUovy44tKc1KLDzGaAsN3IrOUaHI+MA3nlcQb
        mhoZGxtbmBiamRoaKonz/tHuiBcSSE8sSc1OTS1ILYLpY+LglGpgSuqv+hpe1C10qP/Av6dn
        LsZtnf5H454tl+yTzVdSkhguhS2N5Nqnpzy/0mNtKd9mZWnHTpuTRqbGWwu+BEa+VU7nqnt+
        75J+acG8NauOnr4Y3andzXxp9i035Zy4387X+9OlHz9iOX+0IaHuhhB3htH+uNnTtKQaDuv3
        VP3ScP9pocjA/PX0YqGLr10PGH81ffBi93Nl/uAn24wUDXZ4CZi9VxH4q9+oPv/4yXWet55l
        6wbvO+qy9oi3VKaXUfyLYstJLU239LUte7bOZY5qFZtweOJNvpMMD7WWrxC0drr2M+Xl/Zzu
        y2+XhW31SzZZbyd3+O7quLlpn8z+Hoo7yKqeNdF8UdLLFfvfRF0wVWIpzkg01GIuKk4EAHk8
        xXYLBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCLMWRmVeSWpSXmKPExsWy7bCSnK5MWm+8wezPnBaXd81hs3j2/Cer
        xe3GFWwOzB7Xz2xn8ujbsorR4/MmuQDmKC6blNSczLLUIn27BK6Mo//b2Ate2VW8+P2OtYGx
        xbiLkZNDQsBE4vCJRcxdjFwcQgK7GSWWvD3JBJGQlJh28ShQggPIFpY4fLgYouYto8Ty3VPZ
        QGqEBawkft1dDmaLCIRLrLswjxHEZhZQkPh1bxMrRMNERolHf3pZQRJsAloS+1/cAGvgF1CU
        uPrjMVgDr4CdxN2jB9lAlrEIqErMWlcDEhYVCJPYueQxE0SJoMTJmU9YQGxOoPKGb1uZIXap
        S/yZdwnKFpe49WQ+E4QtL7H97RzmCYzCs5C0z0LSMgtJyywkLQsYWVYxSqYWFOem5xYbFhjm
        pZbrFSfmFpfmpesl5+duYgRHhJbmDsbtqz7oHWJk4mA8xCjBwawkwhsp2BUvxJuSWFmVWpQf
        X1Sak1p8iFGag0VJnPdG4cI4IYH0xJLU7NTUgtQimCwTB6dUA5NnXkVuya/HFy7IFsY/dXqv
        fLt4Q9fxzZl3zC1P32AqSfvicTOcza9kWe6mWJs1/uVXrRp8dhRmb6xfE75a1P/fGq/qPeH1
        77+fyOSocHL68zuQtWv3hJK3j3+8fuD6/F9Q0Nl93ssvKlhYvzz96PX67ZU/hUVYX+lMZ7+y
        rpKL93SjPUO0Tc2CV/Wers2p6x7WsLXYy5T9+pD5M69tRvdNvY67JWlfZ/h9+tNqKbmolDHU
        q/l0+sw/esVsH6K2R7DMvyzKt9IlI2nr5ZNXdhz0d5jQrHhPnNGuOfnDjyNW5W0rTt/+9ShP
        9XfPwenp77QyljAvV/B2uPrDKlnxuFzjv++9d68ELLKpCDg+P1KJpTgj0VCLuag4EQBpvxvN
        9wIAAA==
X-CMS-MailID: 20201019101036epcas1p18d62593ac7957d3c89d62a15595b5821
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20201015140757epcas1p43b728b2b67e9ded476a46de127e2ce8b
References: <CGME20201015140757epcas1p43b728b2b67e9ded476a46de127e2ce8b@epcas1p4.samsung.com>
        <20201015140737.1183818-1-michael.auchter@ni.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/15/20 11:07 PM, Michael Auchter wrote:
> This patch adds an extcon driver for the TI TUSB320 USB Type-C device.
> This can be used to detect whether the port is configured as a
> downstream or upstream facing port.
> 
> Signed-off-by: Michael Auchter <michael.auchter@ni.com>
> ---
> Changes since v1:
> - Drop license text that's redundant with SPDX tag
> - Cleanup, sort list of includes
> - Add additional register defines
> - Switch to use regmap API
> - Fix Kconfig to depend on I2C, not GPIOLIB
> since v2:
> - Drop unused irq.h
> - Fix spaces in definitions
> - Return PTR_ERR(priv->edev) instead of -ENOMEM
> - Remove unused i2c_device_id table
> - use client->name instead of dev_name() in request_irq to be more
>   descriptive
> 
>  drivers/extcon/Kconfig               |   8 ++
>  drivers/extcon/Makefile              |   1 +
>  drivers/extcon/extcon-usbc-tusb320.c | 184 +++++++++++++++++++++++++++
>  3 files changed, 193 insertions(+)
>  create mode 100644 drivers/extcon/extcon-usbc-tusb320.c
> 
> diff --git a/drivers/extcon/Kconfig b/drivers/extcon/Kconfig
> index aac507bff135..af58ebca2bf6 100644
> --- a/drivers/extcon/Kconfig
> +++ b/drivers/extcon/Kconfig
> @@ -186,4 +186,12 @@ config EXTCON_USBC_CROS_EC
>  	  Say Y here to enable USB Type C cable detection extcon support when
>  	  using Chrome OS EC based USB Type-C ports.
>  
> +config EXTCON_USBC_TUSB320
> +	tristate "TI TUSB320 USB-C extcon support"
> +	depends on I2C
> +	select REGMAP_I2C
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
> index 000000000000..805af73b4152
> --- /dev/null
> +++ b/drivers/extcon/extcon-usbc-tusb320.c
> @@ -0,0 +1,184 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/**
> + * drivers/extcon/extcon-tusb320.c - TUSB320 extcon driver
> + *
> + * Copyright (C) 2020 National Instruments Corporation
> + * Author: Michael Auchter <michael.auchter@ni.com>
> + */
> +
> +#include <linux/extcon-provider.h>
> +#include <linux/i2c.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +
> +#define TUSB320_REG9				0x9
> +#define TUSB320_REG9_ATTACHED_STATE_SHIFT	6
> +#define TUSB320_REG9_ATTACHED_STATE_MASK	0x3
> +#define TUSB320_REG9_CABLE_DIRECTION		BIT(5)
> +#define TUSB320_REG9_INTERRUPT_STATUS		BIT(4)
> +#define TUSB320_ATTACHED_STATE_NONE		0x0
> +#define TUSB320_ATTACHED_STATE_DFP		0x1
> +#define TUSB320_ATTACHED_STATE_UFP		0x2
> +#define TUSB320_ATTACHED_STATE_ACC		0x3
> +
> +struct tusb320_priv {
> +	struct device *dev;
> +	struct regmap *regmap;
> +	struct extcon_dev *edev;
> +};
> +
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
> +static int tusb320_check_signature(struct tusb320_priv *priv)
> +{
> +	static const char sig[] = { '\0', 'T', 'U', 'S', 'B', '3', '2', '0' };
> +	unsigned val;
> +	int i, ret;
> +
> +	for (i = 0; i < sizeof(sig); i++) {
> +		ret = regmap_read(priv->regmap, sizeof(sig) - 1 - i, &val);
> +		if (ret < 0)
> +			return ret;
> +		if (val != sig[i]) {
> +			dev_err(priv->dev, "signature mismatch!\n");
> +			return -ENODEV;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static irqreturn_t tusb320_irq_handler(int irq, void *dev_id)
> +{
> +	struct tusb320_priv *priv = dev_id;
> +	int state, polarity;
> +	unsigned reg;
> +
> +	if (regmap_read(priv->regmap, TUSB320_REG9, &reg)) {
> +		dev_err(priv->dev, "error during i2c read!\n");
> +		return IRQ_NONE;
> +	}
> +
> +	if (!(reg & TUSB320_REG9_INTERRUPT_STATUS))
> +		return IRQ_NONE;
> +
> +	state = (reg >> TUSB320_REG9_ATTACHED_STATE_SHIFT) &
> +		TUSB320_REG9_ATTACHED_STATE_MASK;
> +	polarity = !!(reg & TUSB320_REG9_CABLE_DIRECTION);
> +
> +	dev_dbg(priv->dev, "attached state: %s, polarity: %d\n",
> +		tusb_attached_states[state], polarity);
> +
> +	extcon_set_state(priv->edev, EXTCON_USB,
> +			 state == TUSB320_ATTACHED_STATE_UFP);
> +	extcon_set_state(priv->edev, EXTCON_USB_HOST,
> +			 state == TUSB320_ATTACHED_STATE_DFP);
> +	extcon_set_property(priv->edev, EXTCON_USB,
> +			    EXTCON_PROP_USB_TYPEC_POLARITY,
> +			    (union extcon_property_value)polarity);
> +	extcon_set_property(priv->edev, EXTCON_USB_HOST,
> +			    EXTCON_PROP_USB_TYPEC_POLARITY,
> +			    (union extcon_property_value)polarity);
> +	extcon_sync(priv->edev, EXTCON_USB);
> +	extcon_sync(priv->edev, EXTCON_USB_HOST);
> +
> +	regmap_write(priv->regmap, TUSB320_REG9, reg);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static const struct regmap_config tusb320_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +};
> +
> +static int tusb320_extcon_probe(struct i2c_client *client,
> +				const struct i2c_device_id *id)
> +{
> +	struct tusb320_priv *priv;
> +	int ret;
> +
> +	priv = devm_kzalloc(&client->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +	priv->dev = &client->dev;
> +
> +	priv->regmap = devm_regmap_init_i2c(client, &tusb320_regmap_config);
> +	if (IS_ERR(priv->regmap))
> +		return PTR_ERR(priv->regmap);
> +
> +	ret = tusb320_check_signature(priv);
> +	if (ret)
> +		return ret;
> +
> +	priv->edev = devm_extcon_dev_allocate(priv->dev, tusb320_extcon_cable);
> +	if (IS_ERR(priv->edev)) {
> +		dev_err(priv->dev, "failed to allocate extcon device\n");
> +		return PTR_ERR(priv->edev);
> +	}
> +
> +	ret = devm_extcon_dev_register(priv->dev, priv->edev);
> +	if (ret < 0) {
> +		dev_err(priv->dev, "failed to register extcon device\n");
> +		return ret;
> +	}
> +
> +	extcon_set_property_capability(priv->edev, EXTCON_USB,
> +				       EXTCON_PROP_USB_TYPEC_POLARITY);
> +	extcon_set_property_capability(priv->edev, EXTCON_USB_HOST,
> +				       EXTCON_PROP_USB_TYPEC_POLARITY);
> +
> +	/* update initial state */
> +	tusb320_irq_handler(client->irq, priv);
> +
> +	ret = devm_request_threaded_irq(priv->dev, client->irq, NULL,
> +					tusb320_irq_handler,
> +					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> +					client->name, priv);
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

Applied them. Thanks.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics

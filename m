Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8904128D903
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 05:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729657AbgJNDiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 23:38:05 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:45660 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729395AbgJNDiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 23:38:04 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20201014033800epoutp010adc96e38a9e1584d54483c7336ef0eb~9vqod05IT3182031820epoutp01V
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 03:38:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20201014033800epoutp010adc96e38a9e1584d54483c7336ef0eb~9vqod05IT3182031820epoutp01V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1602646680;
        bh=bpG98+Mj7ejC8HYAuMCIz4vBjoTiYMY34OK1dsIaqwU=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=S8Fp1zrSmrMqco0HU3tWzMXOdnyBsO9f0rRlNx+thRl5wL1QKWTqwIKRWY4h16zRg
         UliN1uaGqNvePRIcAZM7aXk7qRQcJIW+t7K3mrfLwYxqjVujfTuCsjJzDoXoFyRkrR
         cwn6vXwBNapYhmtNCmgOQcBMVsuU4mzJJnAoGQd8=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20201014033759epcas1p18a94f4ee180031f012846e7cca1847e1~9vqoCsTIa0728507285epcas1p1A;
        Wed, 14 Oct 2020 03:37:59 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.153]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4C9ymP4xvTzMqYlr; Wed, 14 Oct
        2020 03:37:57 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        7E.FC.09543.592768F5; Wed, 14 Oct 2020 12:37:57 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20201014033756epcas1p4ab3baa074c927964d9ef05ca35a1f059~9vqlKPwx30087000870epcas1p4e;
        Wed, 14 Oct 2020 03:37:56 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20201014033756epsmtrp1bc1bd599921709e46d92db3f865f2858~9vqlJuh2c1346413464epsmtrp1x;
        Wed, 14 Oct 2020 03:37:56 +0000 (GMT)
X-AuditID: b6c32a35-35dff70000002547-5c-5f8672953c89
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        CC.17.08604.492768F5; Wed, 14 Oct 2020 12:37:56 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20201014033756epsmtip1ef5f013065f22442cdf8b0f05f643a32~9vqk890Aq3001430014epsmtip1f;
        Wed, 14 Oct 2020 03:37:56 +0000 (GMT)
Subject: Re: [PATCH v2 1/2] extcon: add driver for TI TUSB320
To:     Michael Auchter <michael.auchter@ni.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Cc:     linux-kernel@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <3c3300b9-33cb-4948-f873-63540ecebbb3@samsung.com>
Date:   Wed, 14 Oct 2020 12:51:26 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20201012144754.738830-1-michael.auchter@ni.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBKsWRmVeSWpSXmKPExsWy7bCmvu7UorZ4g4efBS0u75rDZvHs+U9W
        i9uNK9gcmD2un9nO5NG3ZRWjx+dNcgHMUdk2GamJKalFCql5yfkpmXnptkrewfHO8aZmBoa6
        hpYW5koKeYm5qbZKLj4Bum6ZOUCLlBTKEnNKgUIBicXFSvp2NkX5pSWpChn5xSW2SqkFKTkF
        lgV6xYm5xaV56XrJ+blWhgYGRqZAhQnZGT3TPzMWTHCueHWpha2Bsdusi5GDQ0LAROLAOfEu
        Ri4OIYEdjBJnLnUyQTifGCVmdv5ihXC+MUo8udMFlOEE63jRdpkNIrGXUeLL/X5WkISQwHtG
        ia1PeUBsYQFbiQUPXrKB2CIC4RLHJi1nB7GZBRQkft3bBFbPJqAlsf/FDbAafgFFias/HjOC
        2LwCdhKXV3wAq2ERUJXYtns5WFxUIEzi5LYWqBpBiZMzn7CA2JxAux5N3skIMV9c4taT+UwQ
        trzE9rdzmCGOfssu8bFXF8J2kVj/tpcdwhaWeHV8C5QtJfGyvw3KrpZYefII2JMSAh2MElv2
        X2CFSBhL7F86mQkUdswCmhLrd+lDhBUldv6eC3UDn8S7rz2skODllehoE4IoUZa4/OAuNAwl
        JRa3d7JNYFSaheSbWUg+mIXkg1kIyxYwsqxiFEstKM5NTy02LDBEjutNjOAkqGW6g3Hi2w96
        hxiZOBgPMUpwMCuJ8L6SbosX4k1JrKxKLcqPLyrNSS0+xGgKDN+JzFKiyfnANJxXEm9oamRs
        bGxhYmhmamioJM778JZCvJBAemJJanZqakFqEUwfEwenVANTiNCJuwX1vN1TVt/4n3p7ndaU
        1xo+X2zdnOvtzlxmXX1Gq1uCSXqzvAmzlti7BWG6jjd6TCSnc0naXWLiYTwk0XDt8YaPj2ek
        yj8zkD13tFv93FOuM2v49Z6YC+zceDr+mKZmxFXG6Q9miCnN82K7EzDJqEjWJPe8bvTJxjkn
        wjRniBbcXXa/fYJx4aatAZ37DlpGpaht8M8752OflH2i1z/ArmXyfMbApyUfo+Sy7kmGbFXp
        9jt/9NriDY8Dt62+OTPuNuec3vXRvZckJe9v2s25O/PX0vZPskJCZ1YE7I96yhTy7St38ePJ
        je03c571Zq85seyI5/c07rNXpLh3Mec0Td3B/1TDYnettSCzEktxRqKhFnNRcSIAkqQVGwsE
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKLMWRmVeSWpSXmKPExsWy7bCSnO6UorZ4g42blS0u75rDZvHs+U9W
        i9uNK9gcmD2un9nO5NG3ZRWjx+dNcgHMUVw2Kak5mWWpRfp2CVwZPdM/MxZMcK54damFrYGx
        26yLkZNDQsBE4kXbZbYuRi4OIYHdjBI3py1ihEhISky7eJS5i5EDyBaWOHy4GKLmLaPEp2VX
        mEBqhAVsJRY8eMkGYosIhEusuzAPrJdZQEHi171NrBANExglNi6/DNbAJqAlsf/FDbAGfgFF
        ias/HoM18ArYSVxe8YEVxGYRUJXYtns5WFxUIExi55LHTBA1ghInZz5hAbE5gRY/mrwTapm6
        xJ95l5ghbHGJW0/mM0HY8hLb385hnsAoPAtJ+ywkLbOQtMxC0rKAkWUVo2RqQXFuem6xYYFh
        Xmq5XnFibnFpXrpecn7uJkZwTGhp7mDcvuqD3iFGJg7GQ4wSHMxKIryvpNvihXhTEiurUovy
        44tKc1KLDzFKc7AoifPeKFwYJySQnliSmp2aWpBaBJNl4uCUamAS9Fm6oHeb66INmSULjZNE
        k/wTAxOKrk3dzCWo+sf9xoyKKTcvTpL8Nkt8b+++kCDnrtc/uT+sqMgLqFqRf+CCqPS/QH3P
        pwLrJ9w2TpzvpWSavDHp46VwbXn5939C4v1sM7ilAxg7IpY82iRjs+Wk6Onea5c0b/xZ8UFs
        drhY0E7+jVL6v+ZJ/lx4/0sBh1XR/z3tF0OtbY/ybVOx1tQ4FM7w9ea/ezUflz97+3rTQTln
        zqUBf9zWpF6ZyJ154NyKuj8cDFfj8xcsWTvh4uRNLts5RDbmRT7n+vj54A7OoJBoNfH+pIx+
        n8BtUVu8Fe45JM/f/aYgmPHPHwu29NOmxvNcHxpmzH4T5hC+YG6WEktxRqKhFnNRcSIAGlcQ
        4vgCAAA=
X-CMS-MailID: 20201014033756epcas1p4ab3baa074c927964d9ef05ca35a1f059
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20201012145748epcas1p13f59fc2f062133e4988bb1d565408ae9
References: <CGME20201012145748epcas1p13f59fc2f062133e4988bb1d565408ae9@epcas1p1.samsung.com>
        <20201012144754.738830-1-michael.auchter@ni.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Looks good to me. I add some comment. Please check them.

On 10/12/20 11:47 PM, Michael Auchter wrote:
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
> 
>  drivers/extcon/Kconfig               |   8 ++
>  drivers/extcon/Makefile              |   1 +
>  drivers/extcon/extcon-usbc-tusb320.c | 191 +++++++++++++++++++++++++++
>  3 files changed, 200 insertions(+)
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
> index 000000000000..93f1843ca89b
> --- /dev/null
> +++ b/drivers/extcon/extcon-usbc-tusb320.c
> @@ -0,0 +1,191 @@
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
> +#include <linux/irq.h>

irq.h doesn't be needed. Better to remove irq.h.

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
> +#define TUSB320_ATTACHED_STATE_DFP  		0x1
> +#define TUSB320_ATTACHED_STATE_UFP  		0x2
> +#define TUSB320_ATTACHED_STATE_ACC  		0x3

Above definition contain the 'space' for indentation.
Please edit it as following:


-#define TUSB320_ATTACHED_STATE_DFP             0x1
-#define TUSB320_ATTACHED_STATE_UFP             0x2
-#define TUSB320_ATTACHED_STATE_ACC             0x3
+#define TUSB320_ATTACHED_STATE_DFP             0x1
+#define TUSB320_ATTACHED_STATE_UFP             0x2
+#define TUSB320_ATTACHED_STATE_ACC             0x3


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
> +		return -ENOMEM;

Use 'return PTR_ERR(priv->edev)' instead of '-ENOMEM'.

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
> +					dev_name(priv->dev), priv);
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

tusb320_i2c_id is not used on this driver.

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

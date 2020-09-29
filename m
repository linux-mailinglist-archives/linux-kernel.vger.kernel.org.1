Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81DF127BB99
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 05:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbgI2DiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 23:38:16 -0400
Received: from mail-eopbgr70080.outbound.protection.outlook.com ([40.107.7.80]:46762
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726064AbgI2DiQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 23:38:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KNflIOTvkdYWrBeej6m8Uy4tJsxyM4dS9kaxSvCYeuyyAmmj4nvQM1YtJFJ0GQAsIWvncOxgh3LsXKEwEoNZK7Duc7Yp30hXMpjEwi9qIWkFU5hsWlDYHl9lZfnQXWHoHHnNzwFrlIPueBJbtM30V/QQ1j4+In9aXnvwufoITkP6qwpJzDdYTncO7gQfKA1UbC/ASsMyKrN0egijjKcA218XcAVBdgtwrJp46zPJJwM67Cf0hTRHfg+x64W92FH5gV/22UXpvf+JeQtMEZfPFkN9GjB6wHDvRGT8EwQ8xCTLwdsEtwNnq1uObgAuBNdkQ0NDhF8t5k7J3Evv+g7wmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Z/V/0ipxho4QOqM95ImOQPSq2hKcVd609jyErrGT2w=;
 b=iHUjkl5OuNEl1WymJh0GpIc6IvwiUI3G0Hv8qFvtCM73iprYCglFHDnYc1Yv/C1Gqrsut44afe6SRxCUHS/aVQ0Iko11MDf7JrdEx57uMfCWrvL4EW/0iDXQEKbn2h6QCrrMP8Xojdajd8HCuOxojgp+CgoFtyyDWCf3QTTm4qS8wS0Wl3uWDXzATCt+X0nBqre/SWOKHffsrOFrhyEGe+zulriDlIIK2dgGSNxRDcUf13ayGnHqHGLS7rKfTMZ65kM5/nPY26rljOyCQgi2sP5kTk911vHGgNXmhu97QwtX5p7clSjRycui/2+RA6SCOhNzT/ZH7qdYmwOYuZ/XQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Z/V/0ipxho4QOqM95ImOQPSq2hKcVd609jyErrGT2w=;
 b=rCR2geBglgWX9HdfQ/GvOzRwX1OWkWY0h+J+Agt7SnchpHdtS7R9lKzqymswM+qSWEK9qFG0b3qefIy+ngOkoXVsVDvhAeTDMVj9Y+cFI57rccvZlMfwmHCpgFtKrYlIAVJ6cigMEQ/MYht2C7R3ov/XKpSluxjyjERzjmOzuIM=
Received: from AM8PR04MB7300.eurprd04.prod.outlook.com (2603:10a6:20b:1c7::12)
 by AM4PR0401MB2292.eurprd04.prod.outlook.com (2603:10a6:200:50::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Tue, 29 Sep
 2020 03:38:00 +0000
Received: from AM8PR04MB7300.eurprd04.prod.outlook.com
 ([fe80::ad01:9b1c:3b4b:3a77]) by AM8PR04MB7300.eurprd04.prod.outlook.com
 ([fe80::ad01:9b1c:3b4b:3a77%7]) with mapi id 15.20.3412.029; Tue, 29 Sep 2020
 03:38:00 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Pawel Laszczak <pawell@cadence.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "colin.king@canonical.com" <colin.king@canonical.com>,
        "rogerq@ti.com" <rogerq@ti.com>,
        "jpawar@cadence.com" <jpawar@cadence.com>,
        "kurahul@cadence.com" <kurahul@cadence.com>,
        "sparmar@cadence.com" <sparmar@cadence.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        "chunfeng.yun@mediatek.com" <chunfeng.yun@mediatek.com>,
        "yanaijie@huawei.com" <yanaijie@huawei.com>
Subject: Re: [PATCH 2/8] usb: cdns3: Split core.c into cdns3-plat and core.c
 file
Thread-Topic: [PATCH 2/8] usb: cdns3: Split core.c into cdns3-plat and core.c
 file
Thread-Index: AQHWlZOge3wrYSazF0e0fC2RwzxNmKl++GaA
Date:   Tue, 29 Sep 2020 03:37:59 +0000
Message-ID: <20200929033655.GB9076@b29397-desktop>
References: <20200928122741.17884-1-pawell@cadence.com>
 <20200928122741.17884-3-pawell@cadence.com>
In-Reply-To: <20200928122741.17884-3-pawell@cadence.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: cadence.com; dkim=none (message not signed)
 header.d=none;cadence.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7035478e-373c-48b9-84c8-08d864291033
x-ms-traffictypediagnostic: AM4PR0401MB2292:
x-microsoft-antispam-prvs: <AM4PR0401MB2292115AFB183A79B2B16B128B320@AM4PR0401MB2292.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u3m4NmUwk/ycOOKAt5pxboOg9mqW7jWXuPt7RWcnZ8mOCZDBeeD/mbFK8/ydz0to75JNkNL2pJjd5tHo9LWbCmhJmL0loEsDVE5aNYWU71qDtMDdsVSXHIcSiDC+OW4jgPIL1HwjFj6sxd5cTFWYYX4BR74m8D0PyNOthdl0IIOdE8HpdiI/iIeXazgaSRO1lTROsWFIkvE+L++Xtu/kZtpLkm9TNFUWrlPZGpUrjZZ5tHdufOkzqZyQqKOd9EWqhdWVQpN7EbiG2FebNL4VtpphMqut6L4ySU8VoZ5piUnxlzgfXa2D2YUj1/9Z+p7WeKOzIiX+QsAC7AdmZEKUzxpJUvqWV3bWVR6eONdmFy7q6ugXTSFTv9s1BU0dvNeM
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7300.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(4636009)(346002)(366004)(396003)(136003)(376002)(39860400002)(6486002)(4326008)(44832011)(478600001)(1076003)(2906002)(54906003)(7416002)(26005)(33656002)(6916009)(5660300002)(30864003)(33716001)(8936002)(86362001)(83380400001)(9686003)(6512007)(8676002)(316002)(53546011)(6506007)(91956017)(186003)(66446008)(76116006)(66946007)(64756008)(66476007)(66556008)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: SdFs/KiMOlAvYX3HV7MuwYbjwgbg6KTZ7hsFX+mPFpcxm/vwcTpglMZSj73pb8CcXammIKmtKfpfvxrJ6XhCHh+/oJ/VXOBu1evCDirXX/1StIe0aNek6V6OxhCiR3f7f08atLu2k2FYH+82k38NHwSH+rM2g1gLGtxcDHqxnlB28p3ceZe1EIp6dOcg9rnGirLpYPykrPp+XHHIjHDE0IAAaqWktQYjeCRzIuDkgT9JO7ahWbZjsOfDZ1fA114AwDM7YJI7GEASAnB/HgaeemQKgrafH9nR4RMqRp2mDTF2ltUtcYmT19GSY46V0EpYOnmM2N2YpjuSEILfxZ8SiYE0HNtNij8fyjF7yseNK3ZUDYZZnGKmvpPrP7IvMc7WqnlO2ANKsgi+/xFUcoPi8gK5ZNPNdanxsdeoTpXMs/Cze+8oQa7Rynxxr1Mq2dxuVvSg/8UPh5aDb0cmc6xmX5Kwi63MGjDdkyEx2GtdS0KmCo2AiG4xNh653/XLA6Kg8D5o9K8ESG6wijyO/8VZM2/umMhzf0KhVvCv58rPKmKxKFokinIRyARygtWcyvMTpaUja9loKpJaG8SoxAtALDTSXMNKuNc7L3gnpHplnPhcFgYT5O1kFokv5651vmIJO8Ox3AznyiPEJbkp7G1B9g==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <49CCAD1D1F797245970EFA5CE5D22B65@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7300.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7035478e-373c-48b9-84c8-08d864291033
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2020 03:37:59.7330
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qSprPC1vDyvK8w2Y9sD/IfKPWUvouXBsaigkx2g0ceGku4vexgKIlM1JqENGsrrPqQvPv2VpxC3y++harsWgRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0401MB2292
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-09-28 14:27:35, Pawel Laszczak wrote:
> Patch splits file core.c into core.c containing the common reusable code
> and cnd3-plat.c containing device platform specific code. These changes

cdns3-plat.c

Pawel, at 5.10-rc1, there are some cdns3 driver updates at Felipe's
next tree, you may create patches based on that to avoid rebase effects in
future.

Peter

> are required to make possible reuse DRD part of CDNS3 driver in CDNSP
> driver.
>=20
> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> ---
>  drivers/usb/cdns3/Makefile     |   2 +-
>  drivers/usb/cdns3/cdns3-plat.c | 209 +++++++++++++++++++++++++++++++++
>  drivers/usb/cdns3/core.c       | 181 +++-------------------------
>  drivers/usb/cdns3/core.h       |   8 +-
>  4 files changed, 234 insertions(+), 166 deletions(-)
>  create mode 100644 drivers/usb/cdns3/cdns3-plat.c
>=20
> diff --git a/drivers/usb/cdns3/Makefile b/drivers/usb/cdns3/Makefile
> index d47e341a6f39..a1fe9612053a 100644
> --- a/drivers/usb/cdns3/Makefile
> +++ b/drivers/usb/cdns3/Makefile
> @@ -2,7 +2,7 @@
>  # define_trace.h needs to know how to find our header
>  CFLAGS_trace.o				:=3D -I$(src)
> =20
> -cdns3-y					:=3D core.o drd.o
> +cdns3-y					:=3D cdns3-plat.o core.o drd.o
> =20
>  obj-$(CONFIG_USB_CDNS3)			+=3D cdns3.o
>  cdns3-$(CONFIG_USB_CDNS3_GADGET)	+=3D gadget.o ep0.o
> diff --git a/drivers/usb/cdns3/cdns3-plat.c b/drivers/usb/cdns3/cdns3-pla=
t.c
> new file mode 100644
> index 000000000000..f35e9dca30fe
> --- /dev/null
> +++ b/drivers/usb/cdns3/cdns3-plat.c
> @@ -0,0 +1,209 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Cadence USBSS DRD Driver.
> + *
> + * Copyright (C) 2018-2020 Cadence.
> + * Copyright (C) 2017-2018 NXP
> + * Copyright (C) 2019 Texas Instrumentsq
> + *
> + *
> + * Author: Peter Chen <peter.chen@nxp.com>
> + *         Pawel Laszczak <pawell@cadence.com>
> + *         Roger Quadros <rogerq@ti.com>
> + */
> +
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +
> +#include "core.h"
> +
> +/**
> + * cdns3_plat_probe - probe for cdns3 core device
> + * @pdev: Pointer to cdns3 core platform device
> + *
> + * Returns 0 on success otherwise negative errno
> + */
> +static int cdns3_plat_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct resource	*res;
> +	struct cdns3 *cdns;
> +	void __iomem *regs;
> +	int ret;
> +
> +	cdns =3D devm_kzalloc(dev, sizeof(*cdns), GFP_KERNEL);
> +	if (!cdns)
> +		return -ENOMEM;
> +
> +	cdns->dev =3D dev;
> +
> +	platform_set_drvdata(pdev, cdns);
> +
> +	res =3D platform_get_resource_byname(pdev, IORESOURCE_IRQ, "host");
> +	if (!res) {
> +		dev_err(dev, "missing host IRQ\n");
> +		return -ENODEV;
> +	}
> +
> +	cdns->xhci_res[0] =3D *res;
> +
> +	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "xhci");
> +	if (!res) {
> +		dev_err(dev, "couldn't get xhci resource\n");
> +		return -ENXIO;
> +	}
> +
> +	cdns->xhci_res[1] =3D *res;
> +
> +	cdns->dev_irq =3D platform_get_irq_byname(pdev, "peripheral");
> +	if (cdns->dev_irq =3D=3D -EPROBE_DEFER)
> +		return cdns->dev_irq;
> +
> +	if (cdns->dev_irq < 0)
> +		dev_err(dev, "couldn't get peripheral irq\n");
> +
> +	regs =3D devm_platform_ioremap_resource_byname(pdev, "dev");
> +	if (IS_ERR(regs))
> +		return PTR_ERR(regs);
> +	cdns->dev_regs	=3D regs;
> +
> +	cdns->otg_irq =3D platform_get_irq_byname(pdev, "otg");
> +	if (cdns->otg_irq =3D=3D -EPROBE_DEFER)
> +		return cdns->otg_irq;
> +
> +	if (cdns->otg_irq < 0) {
> +		dev_err(dev, "couldn't get otg irq\n");
> +		return cdns->otg_irq;
> +	}
> +
> +	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "otg");
> +	if (!res) {
> +		dev_err(dev, "couldn't get otg resource\n");
> +		return -ENXIO;
> +	}
> +
> +	cdns->otg_res =3D *res;
> +
> +	cdns->usb2_phy =3D devm_phy_optional_get(dev, "cdns3,usb2-phy");
> +	if (IS_ERR(cdns->usb2_phy))
> +		return PTR_ERR(cdns->usb2_phy);
> +
> +	ret =3D phy_init(cdns->usb2_phy);
> +	if (ret)
> +		return ret;
> +
> +	cdns->usb3_phy =3D devm_phy_optional_get(dev, "cdns3,usb3-phy");
> +	if (IS_ERR(cdns->usb3_phy))
> +		return PTR_ERR(cdns->usb3_phy);
> +
> +	ret =3D phy_init(cdns->usb3_phy);
> +	if (ret)
> +		goto err_phy3_init;
> +
> +	ret =3D phy_power_on(cdns->usb2_phy);
> +	if (ret)
> +		goto err_phy2_power_on;
> +
> +	ret =3D phy_power_on(cdns->usb3_phy);
> +	if (ret)
> +		goto err_phy3_power_on;
> +
> +	ret =3D cdns3_init(cdns);
> +	if (ret)
> +		goto err_cdns_init;
> +
> +	device_set_wakeup_capable(dev, true);
> +	pm_runtime_set_active(dev);
> +	pm_runtime_enable(dev);
> +
> +	/*
> +	 * The controller needs less time between bus and controller suspend,
> +	 * and we also needs a small delay to avoid frequently entering low
> +	 * power mode.
> +	 */
> +	pm_runtime_set_autosuspend_delay(dev, 20);
> +	pm_runtime_mark_last_busy(dev);
> +
> +	return 0;
> +
> +err_cdns_init:
> +	phy_power_off(cdns->usb3_phy);
> +err_phy3_power_on:
> +	phy_power_off(cdns->usb2_phy);
> +err_phy2_power_on:
> +	phy_exit(cdns->usb3_phy);
> +err_phy3_init:
> +	phy_exit(cdns->usb2_phy);
> +
> +	return ret;
> +}
> +
> +/**
> + * cdns3_remove - unbind drd driver and clean up
> + * @pdev: Pointer to Linux platform device
> + *
> + * Returns 0 on success otherwise negative errno
> + */
> +static int cdns3_plat_remove(struct platform_device *pdev)
> +{
> +	struct cdns3 *cdns =3D platform_get_drvdata(pdev);
> +	struct device *dev =3D cdns->dev;
> +
> +	pm_runtime_get_sync(dev);
> +	pm_runtime_disable(dev);
> +	pm_runtime_put_noidle(dev);
> +	cdns3_remove(cdns);
> +	phy_power_off(cdns->usb2_phy);
> +	phy_power_off(cdns->usb3_phy);
> +	phy_exit(cdns->usb2_phy);
> +	phy_exit(cdns->usb3_phy);
> +	return 0;
> +}
> +
> +#ifdef CONFIG_PM_SLEEP
> +
> +static int cdns3_plat_suspend(struct device *dev)
> +{
> +	struct cdns3 *cdns =3D dev_get_drvdata(dev);
> +
> +	return cdns3_suspend(cdns);
> +}
> +
> +static int cdns3_plat_resume(struct device *dev)
> +{
> +	struct cdns3 *cdns =3D dev_get_drvdata(dev);
> +
> +	return cdns3_resume(cdns);
> +}
> +#endif
> +
> +static const struct dev_pm_ops cdns3_pm_ops =3D {
> +	SET_SYSTEM_SLEEP_PM_OPS(cdns3_plat_suspend, cdns3_plat_resume)
> +};
> +
> +#ifdef CONFIG_OF
> +static const struct of_device_id of_cdns3_match[] =3D {
> +	{ .compatible =3D "cdns,usb3" },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, of_cdns3_match);
> +#endif
> +
> +static struct platform_driver cdns3_driver =3D {
> +	.probe		=3D cdns3_plat_probe,
> +	.remove		=3D cdns3_plat_remove,
> +	.driver		=3D {
> +		.name	=3D "cdns-usb3",
> +		.of_match_table	=3D of_match_ptr(of_cdns3_match),
> +		.pm	=3D &cdns3_pm_ops,
> +	},
> +};
> +
> +module_platform_driver(cdns3_driver);
> +
> +MODULE_ALIAS("platform:cdns3");
> +MODULE_AUTHOR("Pawel Laszczak <pawell@cadence.com>");
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("Cadence USB3 DRD Controller Driver");
> diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
> index 371128e9a4ae..079bd2abf65d 100644
> --- a/drivers/usb/cdns3/core.c
> +++ b/drivers/usb/cdns3/core.c
> @@ -2,7 +2,7 @@
>  /*
>   * Cadence USBSS DRD Driver.
>   *
> - * Copyright (C) 2018-2019 Cadence.
> + * Copyright (C) 2018-2020 Cadence.
>   * Copyright (C) 2017-2018 NXP
>   * Copyright (C) 2019 Texas Instruments
>   *
> @@ -383,17 +383,14 @@ static int cdns3_role_set(struct usb_role_switch *s=
w, enum usb_role role)
> =20
>  /**
>   * cdns3_probe - probe for cdns3 core device
> - * @pdev: Pointer to cdns3 core platform device
> + * @cdns: Pointer to cdnsp structure.
>   *
>   * Returns 0 on success otherwise negative errno
>   */
> -static int cdns3_probe(struct platform_device *pdev)
> +int cdns3_init(struct cdns3 *cdns)
>  {
>  	struct usb_role_switch_desc sw_desc =3D { };
> -	struct device *dev =3D &pdev->dev;
> -	struct resource	*res;
> -	struct cdns3 *cdns;
> -	void __iomem *regs;
> +	struct device *dev =3D cdns->dev;
>  	int ret;
> =20
>  	ret =3D dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
> @@ -402,85 +399,8 @@ static int cdns3_probe(struct platform_device *pdev)
>  		return ret;
>  	}
> =20
> -	cdns =3D devm_kzalloc(dev, sizeof(*cdns), GFP_KERNEL);
> -	if (!cdns)
> -		return -ENOMEM;
> -
> -	cdns->dev =3D dev;
> -
> -	platform_set_drvdata(pdev, cdns);
> -
> -	res =3D platform_get_resource_byname(pdev, IORESOURCE_IRQ, "host");
> -	if (!res) {
> -		dev_err(dev, "missing host IRQ\n");
> -		return -ENODEV;
> -	}
> -
> -	cdns->xhci_res[0] =3D *res;
> -
> -	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "xhci");
> -	if (!res) {
> -		dev_err(dev, "couldn't get xhci resource\n");
> -		return -ENXIO;
> -	}
> -
> -	cdns->xhci_res[1] =3D *res;
> -
> -	cdns->dev_irq =3D platform_get_irq_byname(pdev, "peripheral");
> -	if (cdns->dev_irq =3D=3D -EPROBE_DEFER)
> -		return cdns->dev_irq;
> -
> -	if (cdns->dev_irq < 0)
> -		dev_err(dev, "couldn't get peripheral irq\n");
> -
> -	regs =3D devm_platform_ioremap_resource_byname(pdev, "dev");
> -	if (IS_ERR(regs))
> -		return PTR_ERR(regs);
> -	cdns->dev_regs	=3D regs;
> -
> -	cdns->otg_irq =3D platform_get_irq_byname(pdev, "otg");
> -	if (cdns->otg_irq =3D=3D -EPROBE_DEFER)
> -		return cdns->otg_irq;
> -
> -	if (cdns->otg_irq < 0) {
> -		dev_err(dev, "couldn't get otg irq\n");
> -		return cdns->otg_irq;
> -	}
> -
> -	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "otg");
> -	if (!res) {
> -		dev_err(dev, "couldn't get otg resource\n");
> -		return -ENXIO;
> -	}
> -
> -	cdns->otg_res =3D *res;
> -
>  	mutex_init(&cdns->mutex);
> =20
> -	cdns->usb2_phy =3D devm_phy_optional_get(dev, "cdns3,usb2-phy");
> -	if (IS_ERR(cdns->usb2_phy))
> -		return PTR_ERR(cdns->usb2_phy);
> -
> -	ret =3D phy_init(cdns->usb2_phy);
> -	if (ret)
> -		return ret;
> -
> -	cdns->usb3_phy =3D devm_phy_optional_get(dev, "cdns3,usb3-phy");
> -	if (IS_ERR(cdns->usb3_phy))
> -		return PTR_ERR(cdns->usb3_phy);
> -
> -	ret =3D phy_init(cdns->usb3_phy);
> -	if (ret)
> -		goto err1;
> -
> -	ret =3D phy_power_on(cdns->usb2_phy);
> -	if (ret)
> -		goto err2;
> -
> -	ret =3D phy_power_on(cdns->usb3_phy);
> -	if (ret)
> -		goto err3;
> -
>  	sw_desc.set =3D cdns3_role_set;
>  	sw_desc.get =3D cdns3_role_get;
>  	sw_desc.allow_userspace_control =3D true;
> @@ -490,78 +410,47 @@ static int cdns3_probe(struct platform_device *pdev=
)
> =20
>  	cdns->role_sw =3D usb_role_switch_register(dev, &sw_desc);
>  	if (IS_ERR(cdns->role_sw)) {
> -		ret =3D PTR_ERR(cdns->role_sw);
>  		dev_warn(dev, "Unable to register Role Switch\n");
> -		goto err4;
> +		return PTR_ERR(cdns->role_sw);
>  	}
> =20
>  	ret =3D cdns3_drd_init(cdns);
>  	if (ret)
> -		goto err5;
> +		goto init_failed;
> =20
>  	ret =3D cdns3_core_init_role(cdns);
>  	if (ret)
> -		goto err5;
> -
> -	device_set_wakeup_capable(dev, true);
> -	pm_runtime_set_active(dev);
> -	pm_runtime_enable(dev);
> +		goto init_failed;
> =20
> -	/*
> -	 * The controller needs less time between bus and controller suspend,
> -	 * and we also needs a small delay to avoid frequently entering low
> -	 * power mode.
> -	 */
> -	pm_runtime_set_autosuspend_delay(dev, 20);
> -	pm_runtime_mark_last_busy(dev);
> -	pm_runtime_use_autosuspend(dev);
>  	dev_dbg(dev, "Cadence USB3 core: probe succeed\n");
> =20
>  	return 0;
> -err5:
> +init_failed:
>  	cdns3_drd_exit(cdns);
>  	usb_role_switch_unregister(cdns->role_sw);
> -err4:
> -	phy_power_off(cdns->usb3_phy);
> -
> -err3:
> -	phy_power_off(cdns->usb2_phy);
> -err2:
> -	phy_exit(cdns->usb3_phy);
> -err1:
> -	phy_exit(cdns->usb2_phy);
> =20
>  	return ret;
>  }
> =20
>  /**
>   * cdns3_remove - unbind drd driver and clean up
> - * @pdev: Pointer to Linux platform device
> + * @cdns: Pointer to cdnsp structure.
>   *
>   * Returns 0 on success otherwise negative errno
>   */
> -static int cdns3_remove(struct platform_device *pdev)
> +int cdns3_remove(struct cdns3 *cdns)
>  {
> -	struct cdns3 *cdns =3D platform_get_drvdata(pdev);
> -
> -	pm_runtime_get_sync(&pdev->dev);
> -	pm_runtime_disable(&pdev->dev);
> -	pm_runtime_put_noidle(&pdev->dev);
>  	cdns3_exit_roles(cdns);
>  	usb_role_switch_unregister(cdns->role_sw);
> -	phy_power_off(cdns->usb2_phy);
> -	phy_power_off(cdns->usb3_phy);
> -	phy_exit(cdns->usb2_phy);
> -	phy_exit(cdns->usb3_phy);
> +
>  	return 0;
>  }
> =20
>  #ifdef CONFIG_PM_SLEEP
> =20
> -static int cdns3_suspend(struct device *dev)
> +int cdns3_suspend(struct cdns3 *cdns)
>  {
> -	struct cdns3 *cdns =3D dev_get_drvdata(dev);
> -	unsigned long flags;
> +	struct device *dev =3D cdns->dev;
> =20
>  	if (cdns->role =3D=3D USB_ROLE_HOST)
>  		return 0;
> @@ -569,28 +458,21 @@ static int cdns3_suspend(struct device *dev)
>  	if (pm_runtime_status_suspended(dev))
>  		pm_runtime_resume(dev);
> =20
> -	if (cdns->roles[cdns->role]->suspend) {
> -		spin_lock_irqsave(&cdns->gadget_dev->lock, flags);
> +	if (cdns->roles[cdns->role]->suspend)
>  		cdns->roles[cdns->role]->suspend(cdns, false);
> -		spin_unlock_irqrestore(&cdns->gadget_dev->lock, flags);
> -	}
> =20
>  	return 0;
>  }
> =20
> -static int cdns3_resume(struct device *dev)
> +int cdns3_resume(struct cdns3 *cdns)
>  {
> -	struct cdns3 *cdns =3D dev_get_drvdata(dev);
> -	unsigned long flags;
> +	struct device *dev =3D cdns->dev;
> =20
>  	if (cdns->role =3D=3D USB_ROLE_HOST)
>  		return 0;
> =20
> -	if (cdns->roles[cdns->role]->resume) {
> -		spin_lock_irqsave(&cdns->gadget_dev->lock, flags);
> +	if (cdns->roles[cdns->role]->resume)
>  		cdns->roles[cdns->role]->resume(cdns, false);
> -		spin_unlock_irqrestore(&cdns->gadget_dev->lock, flags);
> -	}
> =20
>  	pm_runtime_disable(dev);
>  	pm_runtime_set_active(dev);
> @@ -599,32 +481,3 @@ static int cdns3_resume(struct device *dev)
>  	return 0;
>  }
>  #endif
> -
> -static const struct dev_pm_ops cdns3_pm_ops =3D {
> -	SET_SYSTEM_SLEEP_PM_OPS(cdns3_suspend, cdns3_resume)
> -};
> -
> -#ifdef CONFIG_OF
> -static const struct of_device_id of_cdns3_match[] =3D {
> -	{ .compatible =3D "cdns,usb3" },
> -	{ },
> -};
> -MODULE_DEVICE_TABLE(of, of_cdns3_match);
> -#endif
> -
> -static struct platform_driver cdns3_driver =3D {
> -	.probe		=3D cdns3_probe,
> -	.remove		=3D cdns3_remove,
> -	.driver		=3D {
> -		.name	=3D "cdns-usb3",
> -		.of_match_table	=3D of_match_ptr(of_cdns3_match),
> -		.pm	=3D &cdns3_pm_ops,
> -	},
> -};
> -
> -module_platform_driver(cdns3_driver);
> -
> -MODULE_ALIAS("platform:cdns3");
> -MODULE_AUTHOR("Pawel Laszczak <pawell@cadence.com>");
> -MODULE_LICENSE("GPL v2");
> -MODULE_DESCRIPTION("Cadence USB3 DRD Controller Driver");
> diff --git a/drivers/usb/cdns3/core.h b/drivers/usb/cdns3/core.h
> index c09fdde3ae8f..284707c19620 100644
> --- a/drivers/usb/cdns3/core.h
> +++ b/drivers/usb/cdns3/core.h
> @@ -3,7 +3,7 @@
>   * Cadence USBSS DRD Header File.
>   *
>   * Copyright (C) 2017-2018 NXP
> - * Copyright (C) 2018-2019 Cadence.
> + * Copyright (C) 2018-2020 Cadence.
>   *
>   * Authors: Peter Chen <peter.chen@nxp.com>
>   *          Pawel Laszczak <pawell@cadence.com>
> @@ -97,5 +97,11 @@ struct cdns3 {
>  };
> =20
>  int cdns3_hw_role_switch(struct cdns3 *cdns);
> +int cdns3_init(struct cdns3 *cdns);
> +int cdns3_remove(struct cdns3 *cdns);
> =20
> +#ifdef CONFIG_PM_SLEEP
> +int cdns3_resume(struct cdns3 *cdns);
> +int cdns3_suspend(struct cdns3 *cdns);
> +#endif /* CONFIG_PM_SLEEP */
>  #endif /* __LINUX_CDNS3_CORE_H */
> --=20
> 2.17.1
>=20

--=20

Thanks,
Peter Chen=

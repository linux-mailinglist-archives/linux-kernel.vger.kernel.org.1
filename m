Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF9A12AD221
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 10:09:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729676AbgKJJJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 04:09:31 -0500
Received: from mail-eopbgr40058.outbound.protection.outlook.com ([40.107.4.58]:56294
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726467AbgKJJJa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 04:09:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c+L3X+67HVJXR24LelFafjkCiUxKDi3RsDuNdfbe0LCF+0IkWGO+2x4GomWm1i2iE5Jh9AaVPWlX4DLWGaWwCwaYU0nqkeUtcYpnXUELA3c5rCOruH/ZpHEs1CCN81SCDqkULUlfl0l3U9m+7JX4QRC7xixoNB5qDG7hMKV8Q/9wq8kw0wZ1j+ob0HRzpCmY08f7moOtdPHL0XLXG9yxsG/H6DOgP1NWByISo+NxYWTsGU/qSm/GNGLXcAvs/wgZp5e57ghCcGidcGBlZikf/Wb2xwGKa4tw8H+KXHJZ053Dh4i5rNKORlOv2Ju9fCMAnnb3Qywcz/PztQpEOYP+7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0UXVCB3yhI6yz9VbFKdbm735kADOQZMAJkbvkwos8JU=;
 b=XnYbiQDlNwhZd4YtAe1rSpZFoY0TMqhkSz48dtUs/Sm5IFQs4xXNSetSBtfKneKOL4Fevj4wsf4RAD3Bc9Jd7QZo0SbzoYFCtW/gcFnsT42vS8+3VJqj/saFV7b/YvEfO/JMkKX0UTSzxU9DFUBI4HvALYqHHVmA2RWG941oiMMX4pKLjR6KvtBovl6EQpBhu8Ca1gdh5zWtX3yefcUrGksEKGuheaAPN4vVhEq1DsZTPKT/btNTL6xkqd1KPeLfMr+DkQKnLZwvwFoVvi/WylAa6gGT+3qnTBvfEof50UIpqOPkBOSFQSSF8X7mF+cMnlWhhoEp8iDzVhmnx2TW1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0UXVCB3yhI6yz9VbFKdbm735kADOQZMAJkbvkwos8JU=;
 b=Orc2waNAlqWsaZaQKWmwX1Gl7L9nhGV2prRgvNLMzON6Pqd+0XXkiPfUsOdh3xTYGRh1q4ivAgLeWm2m90rXOeFv6LepWzkjakO/GFMExO3sv+IeAihWH1E81MQgYc/zZM0uNwK1CpaRWXTXjxiFSWTeEnXii+xFTUWVGOy1crM=
Received: from DBBPR04MB7979.eurprd04.prod.outlook.com (2603:10a6:10:1ec::9)
 by DB8PR04MB6716.eurprd04.prod.outlook.com (2603:10a6:10:109::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.25; Tue, 10 Nov
 2020 09:09:23 +0000
Received: from DBBPR04MB7979.eurprd04.prod.outlook.com
 ([fe80::c8c:888f:3e0c:8d5c]) by DBBPR04MB7979.eurprd04.prod.outlook.com
 ([fe80::c8c:888f:3e0c:8d5c%5]) with mapi id 15.20.3541.025; Tue, 10 Nov 2020
 09:09:23 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Pawel Laszczak <pawell@cadence.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "colin.king@canonical.com" <colin.king@canonical.com>,
        "rogerq@ti.com" <rogerq@ti.com>,
        "kurahul@cadence.com" <kurahul@cadence.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>
Subject: Re: [PATCH v2 03/10] usb: cdns3: Moves reusable code to separate
 module
Thread-Topic: [PATCH v2 03/10] usb: cdns3: Moves reusable code to separate
 module
Thread-Index: AQHWtDIyz+T8rxkKp0C+ynxTcVw25qnBGdUA
Date:   Tue, 10 Nov 2020 09:09:23 +0000
Message-ID: <20201110090854.GB22481@b29397-desktop>
References: <20201106114300.1245-1-pawell@cadence.com>
 <20201106114300.1245-4-pawell@cadence.com>
In-Reply-To: <20201106114300.1245-4-pawell@cadence.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: cadence.com; dkim=none (message not signed)
 header.d=none;cadence.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fd5706e5-b185-4024-245b-08d8855850dc
x-ms-traffictypediagnostic: DB8PR04MB6716:
x-microsoft-antispam-prvs: <DB8PR04MB67164F443308C28375A33E258BE90@DB8PR04MB6716.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:173;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Wu9Hi281MtlI0OcrgfFmMksHUKn8umsEHIz6OfhOk1jS432t4QQwMI5eO3nwZA55Yq7vjXIlyl/0C0j8dyP/ZRmOHwxuUZDFE5b+OynKJRAD+pgVfdcArzLe5Z8KkUIYu68faK76Gdh4qFREDZGNfvh2GjGUsaptJGu7SMgMANVVlRSATLmCD/PF0UPiGiwVDq3woZFIz6Qx1MI7CYRDS6TY++kysDWYibwE06ObRvNOfckZx8L7RD4m7/DtK88RpoF8m2RH+hzZXE9/VfON00nKE2KOJSBx1YMDJ4XwdsOumVBKL3IlKd46LWZ4fov5LmUZ9SNJxIjTRTYKZJCyRA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7979.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(346002)(136003)(366004)(396003)(376002)(39860400002)(8936002)(1076003)(8676002)(5660300002)(4326008)(91956017)(33716001)(6916009)(66476007)(66946007)(66556008)(71200400001)(64756008)(76116006)(66446008)(316002)(26005)(33656002)(83380400001)(186003)(6486002)(86362001)(2906002)(54906003)(9686003)(6506007)(53546011)(6512007)(44832011)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: eG8GtA6LOFYSnXFGxSM3z1Oz5E2V/IXp99VLDt8kZPb54Y1ez3KizJ8SMGJfdQ5e2wqvTfG7l3tq0wad6zOuoJGs9qZhcFcBp0qE+prfoVGlv9UvGR5SScyHr+o3a/KYrAckXHG/rf4s6T26PG4fa4z2TYIbsu212Pto+R/sTvH/Ce7U5FbMB6+QvCGzoS02MZ16UPgajoCW7+uLogtf4nkmfDoH4oCbN9oU3rBjL+v6WsUSOrSEADLXdk6LYVgubpTa1xvlhgiSKv2ymFDWJtQKDnNcVZZ2XABtuO5qdN5JBv+DyjNY/k3nOkWH33n2CM9BWGarmJlISUGIoBIBRG45DOCzV/YqCrjEIIyofPYZ7rKJ4YwTfXS5ATR8ihMONLNbDOyF2AGMWhf1s+EfjzlF2pKpkVvWR7WI6pIRv1w8OWjLvdOvd98Eg8B7OLsrNhimrlAAWI6x5tpSGVVLVbdpjfY/es+iwGER/WHY/kO6cKP3aZWcwVmw3C2FfWmLosnAgPcjT+ezEAo5XWwW5DpXC/akM00F4pI4z9XUSfBUWy/vYF5Pwh3LF276p2/WWGnNtOKwtOHo9fQAJCg6EyrpzT2faGZl1JbquqK0PPP7V8UGKKUdPf0pPDSn/vmvqJTZTTuyuFLExdj8FimHNg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A17661C559278043BFD3D024ED247F93@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7979.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd5706e5-b185-4024-245b-08d8855850dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2020 09:09:23.1732
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HLwm50yt/pLav2FGcUr7L3JpObDNYfeldBpzvpiriAnmGgFvxPHHUA06Zti0705GJM8GGL12ardq0zSwaMGOHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6716
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-11-06 12:42:53, Pawel Laszczak wrote:
> Patch moves common reusable code used by cdns3 and cdnsp driver
> to cdns-usb-common library. This library include core.c, drd.c
> and host.c files.
>=20
> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> ---
>  drivers/usb/cdns3/Kconfig      |  8 ++++++++
>  drivers/usb/cdns3/Makefile     |  8 +++++---
>  drivers/usb/cdns3/cdns3-plat.c |  2 ++
>  drivers/usb/cdns3/core.c       | 18 +++++++++++++++---
>  drivers/usb/cdns3/core.h       | 11 +++++++----
>  drivers/usb/cdns3/drd.c        |  3 ++-
>  drivers/usb/cdns3/drd.h        |  4 ++--
>  7 files changed, 41 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/usb/cdns3/Kconfig b/drivers/usb/cdns3/Kconfig
> index 84716d216ae5..58154c0a73ac 100644
> --- a/drivers/usb/cdns3/Kconfig
> +++ b/drivers/usb/cdns3/Kconfig
> @@ -1,8 +1,15 @@
> +config CDNS_USB_COMMON
> +	tristate
> +
> +config CDNS_USB_HOST
> +	bool
> +
>  config USB_CDNS3
>  	tristate "Cadence USB3 Dual-Role Controller"
>  	depends on USB_SUPPORT && (USB || USB_GADGET) && HAS_DMA
>  	select USB_XHCI_PLATFORM if USB_XHCI_HCD
>  	select USB_ROLE_SWITCH
> +	select CDNS_USB_COMMON
>  	help
>  	  Say Y here if your system has a Cadence USB3 dual-role controller.
>  	  It supports: dual-role switch, Host-only, and Peripheral-only.
> @@ -25,6 +32,7 @@ config USB_CDNS3_GADGET
>  config USB_CDNS3_HOST
>  	bool "Cadence USB3 host controller"
>  	depends on USB=3Dy || USB=3DUSB_CDNS3
> +	select CDNS_USB_HOST
>  	help
>  	  Say Y here to enable host controller functionality of the
>  	  Cadence driver.
> diff --git a/drivers/usb/cdns3/Makefile b/drivers/usb/cdns3/Makefile
> index a1fe9612053a..16df87abf3cf 100644
> --- a/drivers/usb/cdns3/Makefile
> +++ b/drivers/usb/cdns3/Makefile
> @@ -2,17 +2,19 @@
>  # define_trace.h needs to know how to find our header
>  CFLAGS_trace.o				:=3D -I$(src)
> =20
> -cdns3-y					:=3D cdns3-plat.o core.o drd.o
> +cdns-usb-common-y			:=3D core.o drd.o
> +cdns3-y					:=3D cdns3-plat.o
> =20
>  obj-$(CONFIG_USB_CDNS3)			+=3D cdns3.o
> +obj-$(CONFIG_CDNS_USB_COMMON)		+=3D cdns-usb-common.o
> +
> +cdns-usb-common-$(CONFIG_CDNS_USB_HOST) +=3D host.o
>  cdns3-$(CONFIG_USB_CDNS3_GADGET)	+=3D gadget.o ep0.o
> =20
>  ifneq ($(CONFIG_USB_CDNS3_GADGET),)
>  cdns3-$(CONFIG_TRACING)			+=3D trace.o
>  endif
> =20
> -cdns3-$(CONFIG_USB_CDNS3_HOST)		+=3D host.o
> -
>  obj-$(CONFIG_USB_CDNS3_PCI_WRAP)	+=3D cdns3-pci-wrap.o
>  obj-$(CONFIG_USB_CDNS3_TI)		+=3D cdns3-ti.o
>  obj-$(CONFIG_USB_CDNS3_IMX)		+=3D cdns3-imx.o
> diff --git a/drivers/usb/cdns3/cdns3-plat.c b/drivers/usb/cdns3/cdns3-pla=
t.c
> index b74882af3a9f..562163c81911 100644
> --- a/drivers/usb/cdns3/cdns3-plat.c
> +++ b/drivers/usb/cdns3/cdns3-plat.c
> @@ -18,6 +18,7 @@
>  #include <linux/pm_runtime.h>
> =20
>  #include "core.h"
> +#include "gadget-export.h"
> =20
>  static int set_phy_power_on(struct cdns3 *cdns)
>  {
> @@ -134,6 +135,7 @@ static int cdns3_plat_probe(struct platform_device *p=
dev)
>  	if (ret)
>  		goto err_phy_power_on;
> =20
> +	cdns->gadget_init =3D cdns3_gadget_init;
>  	ret =3D cdns3_init(cdns);
>  	if (ret)
>  		goto err_cdns_init;
> diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
> index 758fd5d67196..4fedf32855af 100644
> --- a/drivers/usb/cdns3/core.c
> +++ b/drivers/usb/cdns3/core.c
> @@ -19,10 +19,8 @@
>  #include <linux/io.h>
>  #include <linux/pm_runtime.h>
> =20
> -#include "gadget.h"
>  #include "core.h"
>  #include "host-export.h"
> -#include "gadget-export.h"
>  #include "drd.h"
> =20
>  static int cdns3_idle_init(struct cdns3 *cdns);
> @@ -147,7 +145,11 @@ static int cdns3_core_init_role(struct cdns3 *cdns)
>  	}
> =20
>  	if (dr_mode =3D=3D USB_DR_MODE_OTG || dr_mode =3D=3D USB_DR_MODE_PERIPH=
ERAL) {
> -		ret =3D cdns3_gadget_init(cdns);
> +		if (cdns->gadget_init)
> +			ret =3D cdns->gadget_init(cdns);
> +		else
> +			ret =3D -ENXIO;
> +
>  		if (ret) {
>  			dev_err(dev, "Device initialization failed with %d\n",
>  				ret);
> @@ -473,6 +475,7 @@ int cdns3_init(struct cdns3 *cdns)
> =20
>  	return ret;
>  }
> +EXPORT_SYMBOL_GPL(cdns3_init);
> =20
>  /**
>   * cdns3_remove - unbind drd driver and clean up
> @@ -487,6 +490,7 @@ int cdns3_remove(struct cdns3 *cdns)
> =20
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(cdns3_remove);
> =20
>  #ifdef CONFIG_PM_SLEEP
>  int cdns3_suspend(struct cdns3 *cdns)
> @@ -505,6 +509,7 @@ int cdns3_suspend(struct cdns3 *cdns)
> =20
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(cdns3_suspend);
> =20
>  int cdns3_resume(struct cdns3 *cdns, u8 set_active)
>  {
> @@ -521,4 +526,11 @@ int cdns3_resume(struct cdns3 *cdns, u8 set_active)
> =20
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(cdns3_resume);
>  #endif /* CONFIG_PM_SLEEP */
> +
> +MODULE_AUTHOR("Peter Chen <peter.chen@nxp.com>");
> +MODULE_AUTHOR("Pawel Laszczak <pawell@cadence.com>");
> +MODULE_AUTHOR("Roger Quadros <rogerq@ti.com>");
> +MODULE_DESCRIPTION("Cadence USBSS and USBSSP DRD Driver");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/usb/cdns3/core.h b/drivers/usb/cdns3/core.h
> index 7e5d9a344a53..96bdab7e8357 100644
> --- a/drivers/usb/cdns3/core.h
> +++ b/drivers/usb/cdns3/core.h
> @@ -75,6 +75,7 @@ struct cdns3_platform_data {
>   * @wakeup_pending: wakeup interrupt pending
>   * @pdata: platform data from glue layer
>   * @lock: spinlock structure
> + * @gadget_init: pointer to gadget initialization function
>   */
>  struct cdns3 {
>  	struct device			*dev;
> @@ -111,14 +112,16 @@ struct cdns3 {
>  	bool				wakeup_pending;
>  	struct cdns3_platform_data	*pdata;
>  	spinlock_t			lock;
> +
> +	int (*gadget_init)(struct cdns3 *cdns);
>  };
> =20
>  int cdns3_hw_role_switch(struct cdns3 *cdns);
> -int cdns3_init(struct cdns3 *cdns);
> -int cdns3_remove(struct cdns3 *cdns);
> +extern int cdns3_init(struct cdns3 *cdns);
> +extern int cdns3_remove(struct cdns3 *cdns);

Why add "extern" here and below?

Peter
> =20
>  #ifdef CONFIG_PM_SLEEP
> -int cdns3_resume(struct cdns3 *cdns, u8 set_active);
> -int cdns3_suspend(struct cdns3 *cdns);
> +extern int cdns3_resume(struct cdns3 *cdns, u8 set_active);
> +extern int cdns3_suspend(struct cdns3 *cdns);
>  #endif /* CONFIG_PM_SLEEP */
>  #endif /* __LINUX_CDNS3_CORE_H */
> diff --git a/drivers/usb/cdns3/drd.c b/drivers/usb/cdns3/drd.c
> index ed8cde91a02c..1874dc6018f0 100644
> --- a/drivers/usb/cdns3/drd.c
> +++ b/drivers/usb/cdns3/drd.c
> @@ -15,7 +15,6 @@
>  #include <linux/iopoll.h>
>  #include <linux/usb/otg.h>
> =20
> -#include "gadget.h"
>  #include "drd.h"
>  #include "core.h"
> =20
> @@ -226,6 +225,7 @@ int cdns3_drd_gadget_on(struct cdns3 *cdns)
>  	phy_set_mode(cdns->usb3_phy, PHY_MODE_USB_DEVICE);
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(cdns3_drd_gadget_on);
> =20
>  /**
>   * cdns3_drd_gadget_off - stop gadget.
> @@ -249,6 +249,7 @@ void cdns3_drd_gadget_off(struct cdns3 *cdns)
>  				  1, 2000000);
>  	phy_set_mode(cdns->usb3_phy, PHY_MODE_INVALID);
>  }
> +EXPORT_SYMBOL_GPL(cdns3_drd_gadget_off);
> =20
>  /**
>   * cdns3_init_otg_mode - initialize drd controller
> diff --git a/drivers/usb/cdns3/drd.h b/drivers/usb/cdns3/drd.h
> index d752d8806a38..972aba8a40b6 100644
> --- a/drivers/usb/cdns3/drd.h
> +++ b/drivers/usb/cdns3/drd.h
> @@ -209,8 +209,8 @@ int cdns3_get_vbus(struct cdns3 *cdns);
>  int cdns3_drd_init(struct cdns3 *cdns);
>  int cdns3_drd_exit(struct cdns3 *cdns);
>  int cdns3_drd_update_mode(struct cdns3 *cdns);
> -int cdns3_drd_gadget_on(struct cdns3 *cdns);
> -void cdns3_drd_gadget_off(struct cdns3 *cdns);
> +extern int cdns3_drd_gadget_on(struct cdns3 *cdns);
> +extern void cdns3_drd_gadget_off(struct cdns3 *cdns);
>  int cdns3_drd_host_on(struct cdns3 *cdns);
>  void cdns3_drd_host_off(struct cdns3 *cdns);
> =20
> --=20
> 2.17.1
>=20

--=20

Thanks,
Peter Chen=

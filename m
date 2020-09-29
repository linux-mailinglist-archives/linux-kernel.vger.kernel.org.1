Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 598AE27BC55
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 07:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbgI2FRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 01:17:19 -0400
Received: from mail-eopbgr80078.outbound.protection.outlook.com ([40.107.8.78]:37377
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725536AbgI2FRS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 01:17:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FOEE4Yb7U9Y+NeTrXqAufHG0feCFvpu1SfPVk0XRR7vsex98W0aAjsu8ag30vhlv/XlHI16H4PKPpEXveig6f632VVxfkyw2HxsNwg+6Wbi5MlS2grFEOcib9k7foPdvM8e5l88rjhXQkepWKQ853NvZhi3Id0k/YIPBlUAkfD69Tl8891P927vW6G4ACxCZoKPG/YmUKhCryFEz2sTKvrQSEVeFs3il2A4CtrXwOc8JtwNQvtYjrpmin4NwWNtmo3CQhDf0Y9WXedwpwHWXLkjSmzK+A81E2S5tXgDLrd4ssISq8zDUwfquxS0C5ygIF+J5XO0pTukWB7gPrIsNQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jPtInieTTCiBbe2ARrGvgd69aoC3Cd/yIJF1y3MvFpc=;
 b=BiX2yDi4eaco2G2hLty0eNUhIjJjiNpKMxk6AdTv0/Q+BW2xnaFSaGi47BJRuL6DsoRIjKQeVOSxNTbL7rZWfJLvp1VTen4HsyZj8mJ2XRtf3g7DK3ORa+pDr3gseybj6LM9L38puu0LEUDMi2TKlEAfUkFOHW2WN3FRP7Bn9Q/AWztTcyF8DQIfmPZ8LSfh0XdDCbtD21adL1fURErUExaJRwoIzyTIQnVt9ifKyIV1AvP3lkIaZTTA5beDWubu83asZDypZCLFSjOaXaD4iCaLqMXbg9iyINfAgBh08cxTXiNUMpG/QUUujudeNpX0PnX95U/DFqwbFOlYxXaUKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jPtInieTTCiBbe2ARrGvgd69aoC3Cd/yIJF1y3MvFpc=;
 b=pnpFJxJSqzNP2LDrbrRidKccHwUynDlGvGENmOQ/ue9k4caOieomj1nFzwdZTK+pPUWUwDwrc8A/iUaL8OAllGxyePoXrt0idFiTi5i+Tu5OQRTCVYiCoJ8t3UROdpM8vDjDZOUv/yJPtaqcchNSa9y1x02UzbjnNQltd0QeO+4=
Received: from AM8PR04MB7300.eurprd04.prod.outlook.com (2603:10a6:20b:1c7::12)
 by AM0PR04MB6851.eurprd04.prod.outlook.com (2603:10a6:208:182::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Tue, 29 Sep
 2020 04:46:38 +0000
Received: from AM8PR04MB7300.eurprd04.prod.outlook.com
 ([fe80::ad01:9b1c:3b4b:3a77]) by AM8PR04MB7300.eurprd04.prod.outlook.com
 ([fe80::ad01:9b1c:3b4b:3a77%7]) with mapi id 15.20.3412.029; Tue, 29 Sep 2020
 04:46:38 +0000
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
Subject: Re: [PATCH 7/8] usb: cdnsp: cdns3 Add main part of Cadence USBSSP DRD
 Driver
Thread-Topic: [PATCH 7/8] usb: cdnsp: cdns3 Add main part of Cadence USBSSP
 DRD Driver
Thread-Index: AQHWlZPO5+oTPjxkk0agOeql57So9ql/C5IA
Date:   Tue, 29 Sep 2020 04:46:38 +0000
Message-ID: <20200929044532.GE9076@b29397-desktop>
References: <20200928122741.17884-1-pawell@cadence.com>
 <20200928122741.17884-8-pawell@cadence.com>
In-Reply-To: <20200928122741.17884-8-pawell@cadence.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: cadence.com; dkim=none (message not signed)
 header.d=none;cadence.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0bdfdfa2-684e-4e83-d0fe-08d86432a72e
x-ms-traffictypediagnostic: AM0PR04MB6851:
x-microsoft-antispam-prvs: <AM0PR04MB685179BFC5100EE32D096F2E8B320@AM0PR04MB6851.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ba1EUV56dF+87gvjGg/orypjZIj3cEysMp4v4dv81YrCv2hp4NJNC0n9eRfqw+lpVb3UMitDoB8e26sFoanH3ujHg106wDXm2GLJtbfyZB15SM+B7pWGKAhOSJuL3LzOD9548Q4AJVnjEATquFQ2+Lyw1CR2WKz4AxdoBOaFQoIVNFP2ZX7yGfPNEi8F4Dh+YNIJCfg4Ld0txWxxKWbNln7xwXexayTc6gidNuzrQ85BryXgpUDaBUohGu5AaiCFyHC8idN9xS8scFJbh73+LLHmkTjtJvqEcSUKLVk6KTfyZu00s6d/drr6IpPF0Cn1TIRodwRO/ZBy5u/ENI2QTHJsiesdyITjwKcuMYWgfsbpmD6I8Xsy2PLAiifXmT3xA7SqkESzht6ava4Ih1RaEP4GmLtEoEc3E+qzh1Yjvn8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7300.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(4636009)(136003)(39860400002)(376002)(396003)(366004)(346002)(66446008)(64756008)(66556008)(66476007)(76116006)(91956017)(54906003)(66946007)(5660300002)(6916009)(86362001)(186003)(9686003)(478600001)(6512007)(45080400002)(83380400001)(2906002)(316002)(8676002)(33716001)(4326008)(7416002)(53546011)(6506007)(6486002)(26005)(44832011)(71200400001)(30864003)(1076003)(33656002)(8936002)(559001)(569008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 8H5YB3npwUg3GDLTMGu2ozy36NOfN33vv8Y5VTu9i57is481Jlk+PbvxfsT9ekukJ7vbiKWUV3Gs1br+TMUj+gsYEJyAV/lgi1DUwcp0UAAzQ//2EaRmQPlqzZOVDFrxRHgksTGAdacv22OK9ZKLs6BqR2ZFqe0CjZphmyBP9KpCNWPfX4kl7Opk+JS9kt6l8xNiTn0iJWIFU+ZEPYMbCMHWVCsjvUjaGpMstoH4Gk3LgVxZTKk07O7/6v8947aHmCrclY+TAJq+n+PNYG/YDsV2/wXYnqYaQM7ZSjAxsxTkGcxdIcH3SrPIOANf13CRWyFZS7J4kH94octiYU/L60JI/MO+pjXG2G6Bq2jTDNRw7XqQ9FEHxbp36e90jbI2u0ZozwGu5arh/6QsExPU+kl+ygpYtNIUOQ9qU9liJvum9uIs8wsuzNp6c1H9yfW+Mf9Aish68y+E/dh9MvXFJBfYJ1zZPvT4H4zPvxcb2QKolQf5iH20j3VDDgFpQSD4JeIR6APNxHVt6GYSWnrXp8dSM7je9xaL2UP3STA8rGR/XZUrQ1aejxCoIT43BsrCd4Vb7E+GgovU4HaKDIOOcpCcEtyIrK9guCXs81TavyvCFweNJnYKPmLcmoxzLo7tyvKLzm8shEVCOaQWHykUYw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <34C64FC994E9594C91113AEB2C4DC8A6@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7300.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bdfdfa2-684e-4e83-d0fe-08d86432a72e
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2020 04:46:38.5436
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kok7rDL5+AEDQYnl+/9YoU7KuEd0K8bCfCeKOXT3phn0nuBcHSPfrkOPo/AgDUuwHizzY1lvFaPZSBlAdjhtjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6851
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-09-28 14:27:40, Pawel Laszczak wrote:
> This patch introduces the main part of Cadence USBSSP DRD driver
> to Linux kernel.
> To reduce the patch size a little bit, the header file gadget.h was
> intentionally added as separate patch.
>=20
> The Cadence USBSSP DRD Controller is a highly configurable IP Core which
> can be instantiated as Dual-Role Device (DRD), Peripheral Only and
> Host Only (XHCI)configurations.
>=20
> The current driver has been validated with FPGA platform. We have
> support for PCIe bus, which is used on FPGA prototyping.
>=20
> The host side of USBSS DRD controller is compliant with XHCI.
> The architecture for device side is almost the same as for host side,
> and most of the XHCI specification can be used to understand how
> this controller operates.
>=20
> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> ---
>  drivers/usb/Kconfig               |    1 +
>  drivers/usb/Makefile              |    1 +
>  drivers/usb/cdns3/core.c          |   19 +-
>  drivers/usb/cdns3/drd.c           |   28 +
>  drivers/usb/cdns3/drd.h           |    2 +
>  drivers/usb/cdns3/gadget-export.h |   18 +-
>  drivers/usb/cdns3/host-export.h   |    4 +-
>  drivers/usb/cdnsp/Kconfig         |   40 +
>  drivers/usb/cdnsp/Makefile        |    7 +
>  drivers/usb/cdnsp/cdnsp-pci.c     |  247 +++
>  drivers/usb/cdnsp/ep0.c           |  480 ++++++
>  drivers/usb/cdnsp/gadget.c        | 1946 ++++++++++++++++++++++++
>  drivers/usb/cdnsp/gadget.h        |  139 ++
>  drivers/usb/cdnsp/mem.c           | 1312 ++++++++++++++++
>  drivers/usb/cdnsp/ring.c          | 2363 +++++++++++++++++++++++++++++

Pawel, I think you may put cdnsp stuff under the folder
of cdns3. It is may not be suitable there are two IP drivers folder
under the root of usb.

You could create files like below:
cdns3-ep0.c
cdns3-gadget.c
cdns3-gadget.h

cdnsp-ep0.c
cdnsp-gadget.c
cdnsp-gadget.h
cdnsp-mem.c
cdnsp-ring.c

Besides, what's the difference between cdnsp-pci.c and current
cdns3-pci-wrap.c, does host controller also be changed?

Peter

>  15 files changed, 6600 insertions(+), 7 deletions(-)
>  create mode 100644 drivers/usb/cdnsp/Kconfig
>  create mode 100644 drivers/usb/cdnsp/Makefile
>  create mode 100644 drivers/usb/cdnsp/cdnsp-pci.c
>  create mode 100644 drivers/usb/cdnsp/ep0.c
>  create mode 100644 drivers/usb/cdnsp/gadget.c
>  create mode 100644 drivers/usb/cdnsp/mem.c
>  create mode 100644 drivers/usb/cdnsp/ring.c
>=20
> diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig
> index 26475b409b53..555c4a4cb465 100644
> --- a/drivers/usb/Kconfig
> +++ b/drivers/usb/Kconfig
> @@ -112,6 +112,7 @@ source "drivers/usb/usbip/Kconfig"
> endif
> =20
>  source "drivers/usb/cdns3/Kconfig"
> +source "drivers/usb/cdnsp/Kconfig"
> =20
>  source "drivers/usb/mtu3/Kconfig"
> =20
> diff --git a/drivers/usb/Makefile b/drivers/usb/Makefile
> index 1c1c1d659394..84727f7a4b92 100644
> --- a/drivers/usb/Makefile
> +++ b/drivers/usb/Makefile
> @@ -14,6 +14,7 @@ obj-$(CONFIG_USB_DWC2)		+=3D dwc2/
>  obj-$(CONFIG_USB_ISP1760)	+=3D isp1760/
> =20
>  obj-$(CONFIG_USB_CDNS3)		+=3D cdns3/
> +obj-$(CONFIG_USB_CDNSP)		+=3D cdnsp/
> =20
>  obj-$(CONFIG_USB_MON)		+=3D mon/
>  obj-$(CONFIG_USB_MTU3)		+=3D mtu3/
> diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
> index 2af99294beaa..560783092d8a 100644
> --- a/drivers/usb/cdns3/core.c
> +++ b/drivers/usb/cdns3/core.c
> @@ -138,7 +138,14 @@ static int cdns_core_init_role(struct cdns *cdns)
>  	dr_mode =3D best_dr_mode;
> =20
>  	if (dr_mode =3D=3D USB_DR_MODE_OTG || dr_mode =3D=3D USB_DR_MODE_HOST) =
{
> -		ret =3D cdns_host_init(cdns);
> +		if ((cdns->version =3D=3D CDNSP_CONTROLLER_V2 &&
> +		     IS_ENABLED(CONFIG_USB_CDNSP_HOST)) ||
> +		    (cdns->version < CDNSP_CONTROLLER_V2 &&
> +		     IS_ENABLED(CONFIG_USB_CDNS3_HOST)))
> +			ret =3D cdns_host_init(cdns);
> +		else
> +			ret =3D -ENXIO;
> +
>  		if (ret) {
>  			dev_err(dev, "Host initialization failed with %d\n",
>  				ret);
> @@ -147,7 +154,15 @@ static int cdns_core_init_role(struct cdns *cdns)
>  	}
> =20
>  	if (dr_mode =3D=3D USB_DR_MODE_OTG || dr_mode =3D=3D USB_DR_MODE_PERIPH=
ERAL) {
> -		ret =3D cdns3_gadget_init(cdns);
> +		if (cdns->version =3D=3D CDNSP_CONTROLLER_V2 &&
> +		    IS_ENABLED(CONFIG_USB_CDNSP_GADGET))
> +			ret =3D cdnsp_gadget_init(cdns);
> +		else if (cdns->version < CDNSP_CONTROLLER_V2 &&
> +			 IS_ENABLED(CONFIG_USB_CDNS3_GADGET))
> +			ret =3D cdns3_gadget_init(cdns);
> +		else
> +			ret =3D -ENXIO;
> +
>  		if (ret) {
>  			dev_err(dev, "Device initialization failed with %d\n",
>  				ret);
> diff --git a/drivers/usb/cdns3/drd.c b/drivers/usb/cdns3/drd.c
> index 7feb622972da..3c732e19c61c 100644
> --- a/drivers/usb/cdns3/drd.c
> +++ b/drivers/usb/cdns3/drd.c
> @@ -90,6 +90,32 @@ int cdns_get_vbus(struct cdns *cdns)
>  	return vbus;
>  }
> =20
> +void cdns_clear_vbus(struct cdns *cdns)
> +{
> +	u32 reg;
> +
> +	if (cdns->version !=3D CDNSP_CONTROLLER_V2)
> +		return;
> +
> +	reg =3D readl(&cdns->otg_cdnsp_regs->override);
> +	reg |=3D OVERRIDE_SESS_VLD_SEL;
> +	writel(reg, &cdns->otg_cdnsp_regs->override);
> +}
> +EXPORT_SYMBOL_GPL(cdns_clear_vbus);
> +
> +void cdns_set_vbus(struct cdns *cdns)
> +{
> +	u32 reg;
> +
> +	if (cdns->version !=3D CDNSP_CONTROLLER_V2)
> +		return;
> +
> +	reg =3D readl(&cdns->otg_cdnsp_regs->override);
> +	reg &=3D ~OVERRIDE_SESS_VLD_SEL;
> +	writel(reg, &cdns->otg_cdnsp_regs->override);
> +}
> +EXPORT_SYMBOL_GPL(cdns_set_vbus);
> +
>  bool cdns_is_host(struct cdns *cdns)
>  {
>  	if (cdns->dr_mode =3D=3D USB_DR_MODE_HOST)
> @@ -431,5 +457,7 @@ int cdns_drd_init(struct cdns *cdns)
>  int cdns_drd_exit(struct cdns *cdns)
>  {
>  	cdns_otg_disable_irq(cdns);
> +	devm_free_irq(cdns->dev, cdns->otg_irq, cdns);
> +
>  	return 0;
>  }
> diff --git a/drivers/usb/cdns3/drd.h b/drivers/usb/cdns3/drd.h
> index b92e2834dc3f..7ef14bef047c 100644
> --- a/drivers/usb/cdns3/drd.h
> +++ b/drivers/usb/cdns3/drd.h
> @@ -204,6 +204,8 @@ bool cdns_is_host(struct cdns *cdns);
>  bool cdns_is_device(struct cdns *cdns);
>  int cdns_get_id(struct cdns *cdns);
>  int cdns_get_vbus(struct cdns *cdns);
> +extern void cdns_clear_vbus(struct cdns *cdns);
> +extern void cdns_set_vbus(struct cdns *cdns);
>  int cdns_drd_init(struct cdns *cdns);
>  int cdns_drd_exit(struct cdns *cdns);
>  int cdns_drd_update_mode(struct cdns *cdns);
> diff --git a/drivers/usb/cdns3/gadget-export.h b/drivers/usb/cdns3/gadget=
-export.h
> index e784584fe053..b7eec9fb8fda 100644
> --- a/drivers/usb/cdns3/gadget-export.h
> +++ b/drivers/usb/cdns3/gadget-export.h
> @@ -1,6 +1,6 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
>  /*
> - * Cadence USBSS DRD Driver - Gadget Export APIs.
> + * Cadence USBSS and USBSSP DRD Driver - Gadget Export APIs.
>   *
>   * Copyright (C) 2017 NXP
>   * Copyright (C) 2017-2018 NXP
> @@ -10,7 +10,19 @@
>  #ifndef __LINUX_CDNS3_GADGET_EXPORT
>  #define __LINUX_CDNS3_GADGET_EXPORT
> =20
> -#ifdef CONFIG_USB_CDNS3_GADGET
> +#if IS_ENABLED(CONFIG_USB_CDNSP_GADGET)
> +
> +extern int cdnsp_gadget_init(struct cdns *cdns);
> +#else
> +
> +static inline int cdnsp_gadget_init(struct cdns *cdns)
> +{
> +	return -ENXIO;
> +}
> +
> +#endif  /* CONFIG_USB_CDNSP_GADGET */
> +
> +#if IS_ENABLED(CONFIG_USB_CDNS3_GADGET)
> =20
>  extern int cdns3_gadget_init(struct cdns *cdns);
>  void cdns3_gadget_exit(struct cdns *cdns);
> @@ -23,6 +35,6 @@ static inline int cdns3_gadget_init(struct cdns *cdns)
> =20
>  static inline void cdns3_gadget_exit(struct cdns *cdns) { }
> =20
> -#endif
> +#endif /* CONFIG_USB_CDNS3_GADGET */
> =20
>  #endif /* __LINUX_CDNS3_GADGET_EXPORT */
> diff --git a/drivers/usb/cdns3/host-export.h b/drivers/usb/cdns3/host-exp=
ort.h
> index d82b83d070ad..41f7ea1fed29 100644
> --- a/drivers/usb/cdns3/host-export.h
> +++ b/drivers/usb/cdns3/host-export.h
> @@ -9,7 +9,7 @@
>  #ifndef __LINUX_CDNS3_HOST_EXPORT
>  #define __LINUX_CDNS3_HOST_EXPORT
> =20
> -#ifdef CONFIG_USB_CDNS3_HOST
> +#if  IS_ENABLED(CONFIG_USB_CDNS3_HOST) || IS_ENABLED(CONFIG_USB_CDNSP_GA=
DGET)
> =20
>  int cdns_host_init(struct cdns *cdns);
> =20
> @@ -22,6 +22,6 @@ static inline int cdns_host_init(struct cdns *cdns)
> =20
>  static inline void cdns_host_exit(struct cdns *cdns) { }
> =20
> -#endif /* CONFIG_USB_CDNS3_HOST */
> +#endif /* CONFIG_USB_CDNS3_HOST || CONFIG_USB_CDNSP_GADGET */
> =20
>  #endif /* __LINUX_CDNS3_HOST_EXPORT */
> diff --git a/drivers/usb/cdnsp/Kconfig b/drivers/usb/cdnsp/Kconfig
> new file mode 100644
> index 000000000000..56cee5f6dfb4
> --- /dev/null
> +++ b/drivers/usb/cdnsp/Kconfig
> @@ -0,0 +1,40 @@
> +config USB_CDNSP_PCI
> +	tristate "Cadence CDNSP Dual-Role Controller"
> +	depends on USB_SUPPORT && (USB || USB_GADGET) && HAS_DMA && USB_PCI && =
ACPI
> +	select USB_XHCI_PLATFORM if USB_XHCI_HCD
> +	select USB_ROLE_SWITCH
> +	select CDNS_USB_COMMON
> +	help
> +	  Say Y here if your system has a Cadence CDNSP dual-role controller.
> +	  It supports: dual-role switch Host-only, and Peripheral-only.
> +
> +	  If you choose to build this driver is a dynamically linked
> +	  module, the module will be called cdnsp.ko.
> +
> +if USB_CDNSP_PCI
> +
> +config USB_CDNSP_GADGET
> +	bool "Cadence CDNSP device controller"
> +	depends on USB_GADGET=3Dy || USB_GADGET=3DUSB_CDNSP_PCI
> +	help
> +	  Say Y here to enable device controller functionality of the
> +	  Cadence CDNSP-DEV driver.
> +
> +	  Cadence CDNSP Device Controller in device mode is
> +	  very similar to XHCI controller. Therefore some algorithms
> +	  used has been taken from host driver.
> +	  This controller supports FF, HS, SS and SSP mode.
> +	  It doesn't support LS.
> +
> +config USB_CDNSP_HOST
> +	bool "Cadence CDNSP host controller"
> +	depends on USB=3Dy || USB=3DUSB_CDNSP_PCI
> +	select CDNS_USB_HOST
> +	help
> +	  Say Y here to enable host controller functionality of the
> +	  Cadence driver.
> +
> +	  Host controller is compliant with XHCI so it uses
> +	  standard XHCI driver.
> +
> +endif
> diff --git a/drivers/usb/cdnsp/Makefile b/drivers/usb/cdnsp/Makefile
> new file mode 100644
> index 000000000000..53202b21a8d2
> --- /dev/null
> +++ b/drivers/usb/cdnsp/Makefile
> @@ -0,0 +1,7 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +cdnsp-udc-pci-y					:=3D cdnsp-pci.o
> +
> +obj-$(CONFIG_USB_CDNSP_PCI) 			+=3D cdnsp-udc-pci.o
> +cdnsp-udc-pci-$(CONFIG_USB_CDNSP_GADGET)	+=3D ring.o gadget.o mem.o ep0.=
o
> +
> diff --git a/drivers/usb/cdnsp/cdnsp-pci.c b/drivers/usb/cdnsp/cdnsp-pci.=
c
> new file mode 100644
> index 000000000000..f67ee8effcd3
> --- /dev/null
> +++ b/drivers/usb/cdnsp/cdnsp-pci.c
> @@ -0,0 +1,247 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Cadence PCI Glue driver.
> + *
> + * Copyright (C) 2019 Cadence.
> + *
> + * Author: Pawel Laszczak <pawell@cadence.com>
> + *
> + */
> +
> +#include <linux/platform_device.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/pci.h>
> +
> +#include "../cdns3/core.h"
> +
> +#define PCI_BAR_HOST		0
> +#define PCI_BAR_OTG		0
> +#define PCI_BAR_DEV		2
> +
> +#define PCI_DEV_FN_HOST_DEVICE	0
> +#define PCI_DEV_FN_OTG		1
> +
> +#define PCI_DRIVER_NAME		"cdns-pci-usbssp"
> +#define PLAT_DRIVER_NAME	"cdns-usbssp"
> +
> +#define CDNS_VENDOR_ID		0x17cd
> +#define CDNS_DEVICE_ID		0x0100
> +#define CDNS_DRD_IF		(PCI_CLASS_SERIAL_USB << 8 | 0x80)
> +
> +static struct pci_dev *cdnsp_get_second_fun(struct pci_dev *pdev)
> +{
> +	struct pci_dev *func;
> +
> +	/*
> +	 * Gets the second function.
> +	 * It's little tricky, but this platform has two function.
> +	 * The fist keeps resources for Host/Device while the second
> +	 * keeps resources for DRD/OTG.
> +	 */
> +	func =3D pci_get_device(pdev->vendor, pdev->device, NULL);
> +	if (!func)
> +		return NULL;
> +
> +	if (func->devfn =3D=3D pdev->devfn) {
> +		func =3D pci_get_device(pdev->vendor, pdev->device, func);
> +		if (!func)
> +			return NULL;
> +	}
> +
> +	return func;
> +}
> +
> +static int cdnsp_pci_probe(struct pci_dev *pdev,
> +			   const struct pci_device_id *id)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct pci_dev *func;
> +	struct resource *res;
> +	struct cdns *cdnsp;
> +	int ret;
> +
> +	/*
> +	 * For GADGET/HOST PCI (devfn) function number is 0,
> +	 * for OTG PCI (devfn) function number is 1.
> +	 */
> +	if (!id || (pdev->devfn !=3D PCI_DEV_FN_HOST_DEVICE &&
> +		    pdev->devfn !=3D PCI_DEV_FN_OTG))
> +		return -EINVAL;
> +
> +	func =3D cdnsp_get_second_fun(pdev);
> +	if (!func)
> +		return -EINVAL;
> +
> +	if (func->class =3D=3D PCI_CLASS_SERIAL_USB_XHCI ||
> +	    pdev->class =3D=3D PCI_CLASS_SERIAL_USB_XHCI) {
> +		ret =3D -EINVAL;
> +		goto put_pci;
> +	}
> +
> +	ret =3D pcim_enable_device(pdev);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Enabling PCI device has failed %d\n", ret);
> +		goto put_pci;
> +	}
> +
> +	pci_set_master(pdev);
> +	if (pci_is_enabled(func)) {
> +		cdnsp =3D pci_get_drvdata(func);
> +	} else {
> +		cdnsp =3D kzalloc(sizeof(*cdnsp), GFP_KERNEL);
> +		if (!cdnsp) {
> +			ret =3D -ENOMEM;
> +			goto disable_pci;
> +		}
> +	}
> +
> +	/* For GADGET device function number is 0. */
> +	if (pdev->devfn =3D=3D 0) {
> +		resource_size_t rsrc_start, rsrc_len;
> +
> +		/* Function 0: host(BAR_0) + device(BAR_1).*/
> +		dev_dbg(dev, "Initialize resources\n");
> +		rsrc_start =3D pci_resource_start(pdev, PCI_BAR_DEV);
> +		rsrc_len =3D pci_resource_len(pdev, PCI_BAR_DEV);
> +		res =3D devm_request_mem_region(dev, rsrc_start, rsrc_len, "dev");
> +		if (!res) {
> +			dev_dbg(dev, "controller already in use\n");
> +			ret =3D -EBUSY;
> +			goto free_cdnsp;
> +		}
> +
> +		cdnsp->dev_regs =3D devm_ioremap(dev, rsrc_start, rsrc_len);
> +		if (!cdnsp->dev_regs) {
> +			dev_dbg(dev, "error mapping memory\n");
> +			ret =3D -EFAULT;
> +			goto free_cdnsp;
> +		}
> +
> +		cdnsp->dev_irq =3D pdev->irq;
> +		dev_dbg(dev, "USBSS-DEV physical base addr: %pa\n",
> +			&rsrc_start);
> +
> +		res =3D &cdnsp->xhci_res[0];
> +		res->start =3D pci_resource_start(pdev, PCI_BAR_HOST);
> +		res->end =3D pci_resource_end(pdev, PCI_BAR_HOST);
> +		res->name =3D "xhci";
> +		res->flags =3D IORESOURCE_MEM;
> +		dev_dbg(dev, "USBSS-XHCI physical base addr: %pa\n",
> +			&res->start);
> +
> +		/* Interrupt for XHCI, */
> +		res =3D &cdnsp->xhci_res[1];
> +		res->start =3D pdev->irq;
> +		res->name =3D "host";
> +		res->flags =3D IORESOURCE_IRQ;
> +	} else {
> +		res =3D &cdnsp->otg_res;
> +		res->start =3D pci_resource_start(pdev, PCI_BAR_OTG);
> +		res->end =3D   pci_resource_end(pdev, PCI_BAR_OTG);
> +		res->name =3D "otg";
> +		res->flags =3D IORESOURCE_MEM;
> +		dev_dbg(dev, "CDNSP-DRD physical base addr: %pa\n",
> +			&res->start);
> +
> +		/* Interrupt for OTG/DRD. */
> +		cdnsp->otg_irq =3D pdev->irq;
> +	}
> +
> +	if (pci_is_enabled(func)) {
> +		cdnsp->dev =3D dev;
> +
> +		ret =3D cdns_init(cdnsp);
> +		if (ret)
> +			goto free_cdnsp;
> +	}
> +
> +	pci_set_drvdata(pdev, cdnsp);
> +
> +	device_wakeup_enable(&pdev->dev);
> +	if (pci_dev_run_wake(pdev))
> +		pm_runtime_put_noidle(&pdev->dev);
> +
> +	return 0;
> +
> +free_cdnsp:
> +	if (!pci_is_enabled(func))
> +		kfree(cdnsp);
> +
> +disable_pci:
> +	pci_disable_device(pdev);
> +
> +put_pci:
> +	pci_dev_put(func);
> +
> +	return ret;
> +}
> +
> +static void cdnsp_pci_remove(struct pci_dev *pdev)
> +{
> +	struct cdns *cdnsp;
> +	struct pci_dev *func;
> +
> +	func =3D cdnsp_get_second_fun(pdev);
> +	cdnsp =3D (struct cdns *)pci_get_drvdata(pdev);
> +
> +	if (pci_dev_run_wake(pdev))
> +		pm_runtime_get_noresume(&pdev->dev);
> +
> +	if (!pci_is_enabled(func)) {
> +		kfree(cdnsp);
> +		goto pci_put;
> +	}
> +
> +	cdns_remove(cdnsp);
> +
> +pci_put:
> +	pci_dev_put(func);
> +}
> +
> +static int __maybe_unused cdnsp_pci_suspend(struct device *dev)
> +{
> +	struct cdns *cdns =3D dev_get_drvdata(dev);
> +
> +	return cdns_suspend(cdns);
> +}
> +
> +static int __maybe_unused cdnsp_pci_resume(struct device *dev)
> +{
> +	struct cdns *cdns =3D dev_get_drvdata(dev);
> +
> +	return cdns_resume(cdns);
> +}
> +
> +static const struct dev_pm_ops cdnsp_pci_pm_ops =3D {
> +	SET_SYSTEM_SLEEP_PM_OPS(cdnsp_pci_suspend, cdnsp_pci_resume)
> +};
> +
> +static const struct pci_device_id cdnsp_pci_ids[] =3D {
> +	{ PCI_VENDOR_ID_CDNS, CDNS_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID,
> +	  PCI_CLASS_SERIAL_USB_DEVICE, PCI_ANY_ID },
> +	{ PCI_VENDOR_ID_CDNS, CDNS_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID,
> +	  CDNS_DRD_IF, PCI_ANY_ID },
> +	{ 0, }
> +};
> +
> +static struct pci_driver cdnsp_pci_driver =3D {
> +	.name =3D "cdnsp-pci",
> +	.id_table =3D &cdnsp_pci_ids[0],
> +	.probe =3D cdnsp_pci_probe,
> +	.remove =3D cdnsp_pci_remove,
> +	.driver =3D {
> +		.pm =3D &cdnsp_pci_pm_ops,
> +	}
> +};
> +
> +module_pci_driver(cdnsp_pci_driver);
> +MODULE_DEVICE_TABLE(pci, cdnsp_pci_ids);
> +
> +MODULE_ALIAS("pci:cdnsp");
> +MODULE_AUTHOR("Pawel Laszczak <pawell@cadence.com>");
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("Cadence CDNSP PCI driver");
> +
> diff --git a/drivers/usb/cdnsp/ep0.c b/drivers/usb/cdnsp/ep0.c
> new file mode 100644
> index 000000000000..7f6e1d28d3b8
> --- /dev/null
> +++ b/drivers/usb/cdnsp/ep0.c
> @@ -0,0 +1,480 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Cadence CDNSP DRD Driver.
> + *
> + * Copyright (C) 2020 Cadence.
> + *
> + * Author: Pawel Laszczak <pawell@cadence.com>
> + *
> + */
> +
> +#include <linux/usb/composite.h>
> +#include <linux/usb/gadget.h>
> +#include <linux/list.h>
> +
> +#include "gadget.h"
> +
> +static void cdnsp_ep0_stall(struct cdnsp_device *pdev)
> +{
> +	struct cdnsp_request *preq;
> +	struct cdnsp_ep *pep;
> +
> +	pep =3D &pdev->eps[0];
> +	preq =3D next_request(&pep->pending_list);
> +
> +	if (pdev->three_stage_setup) {
> +		cdnsp_halt_endpoint(pdev, pep, true);
> +
> +		if (preq)
> +			cdnsp_gadget_giveback(pep, preq, -ECONNRESET);
> +	} else {
> +		pep->ep_state |=3D EP0_HALTED_STATUS;
> +
> +		if (preq)
> +			list_del(&preq->list);
> +
> +		cdnsp_status_stage(pdev);
> +	}
> +}
> +
> +static int cdnsp_ep0_delegate_req(struct cdnsp_device *pdev,
> +				  struct usb_ctrlrequest *ctrl)
> +{
> +	int ret;
> +
> +	spin_unlock(&pdev->lock);
> +	ret =3D pdev->gadget_driver->setup(&pdev->gadget, ctrl);
> +	spin_lock(&pdev->lock);
> +
> +	return ret;
> +}
> +
> +static int cdnsp_ep0_set_config(struct cdnsp_device *pdev,
> +				struct usb_ctrlrequest *ctrl)
> +{
> +	enum usb_device_state state =3D pdev->gadget.state;
> +	u32 cfg;
> +	int ret;
> +
> +	cfg =3D le16_to_cpu(ctrl->wValue);
> +
> +	switch (state) {
> +	case USB_STATE_ADDRESS:
> +		ret =3D cdnsp_ep0_delegate_req(pdev, ctrl);
> +		if (ret)
> +			return ret;
> +		break;
> +	case USB_STATE_CONFIGURED:
> +		ret =3D cdnsp_ep0_delegate_req(pdev, ctrl);
> +		if (ret)
> +			return ret;
> +		break;
> +	default:
> +		dev_err(pdev->dev, "Set Configuration - bad device state\n");
> +		return -EINVAL;
> +	}
> +
> +	if (!cfg)
> +		usb_gadget_set_state(&pdev->gadget, USB_STATE_ADDRESS);
> +
> +	return 0;
> +}
> +
> +static int cdnsp_ep0_set_address(struct cdnsp_device *pdev,
> +				 struct usb_ctrlrequest *ctrl)
> +{
> +	enum usb_device_state state =3D pdev->gadget.state;
> +	struct cdnsp_slot_ctx *slot_ctx;
> +	unsigned int slot_state;
> +	int ret;
> +	u32 addr;
> +
> +	addr =3D le16_to_cpu(ctrl->wValue);
> +
> +	if (addr > 127) {
> +		dev_err(pdev->dev, "Invalid device address %d\n", addr);
> +		return -EINVAL;
> +	}
> +
> +	slot_ctx =3D cdnsp_get_slot_ctx(&pdev->out_ctx);
> +
> +	if (state =3D=3D USB_STATE_CONFIGURED) {
> +		dev_err(pdev->dev, "Can't Set Address from Configured State\n");
> +		return -EINVAL;
> +	}
> +
> +	pdev->device_address =3D le16_to_cpu(ctrl->wValue);
> +
> +	slot_ctx =3D cdnsp_get_slot_ctx(&pdev->out_ctx);
> +	slot_state =3D GET_SLOT_STATE(le32_to_cpu(slot_ctx->dev_state));
> +	if (slot_state =3D=3D SLOT_STATE_ADDRESSED)
> +		cdnsp_reset_device(pdev);
> +
> +	/*set device address*/
> +	ret =3D cdnsp_setup_device(pdev, SETUP_CONTEXT_ADDRESS);
> +	if (ret)
> +		return ret;
> +
> +	if (addr)
> +		usb_gadget_set_state(&pdev->gadget, USB_STATE_ADDRESS);
> +	else
> +		usb_gadget_set_state(&pdev->gadget, USB_STATE_DEFAULT);
> +
> +	return 0;
> +}
> +
> +int cdnsp_status_stage(struct cdnsp_device *pdev)
> +{
> +	pdev->ep0_stage =3D CDNSP_STATUS_STAGE;
> +	pdev->ep0_preq.request.length =3D 0;
> +
> +	return cdnsp_ep_enqueue(pdev->ep0_preq.pep, &pdev->ep0_preq);
> +}
> +
> +static int cdnsp_w_index_to_ep_index(__le32  wIndex)
> +{
> +	wIndex =3D le32_to_cpu(wIndex);
> +
> +	if (!(wIndex & USB_ENDPOINT_NUMBER_MASK))
> +		return 0;
> +
> +	return ((wIndex & USB_ENDPOINT_NUMBER_MASK) * 2) +
> +		(wIndex & USB_ENDPOINT_DIR_MASK ? 1 : 0) - 1;
> +}
> +
> +static int cdnsp_ep0_handle_status(struct cdnsp_device *pdev,
> +				   struct usb_ctrlrequest *ctrl)
> +{
> +	struct cdnsp_ep *pep;
> +	__le16 *response;
> +	int ep_sts =3D 0;
> +	u16 status =3D 0;
> +	u32 recipient;
> +
> +	recipient =3D ctrl->bRequestType & USB_RECIP_MASK;
> +
> +	switch (recipient) {
> +	case USB_RECIP_DEVICE:
> +		status =3D pdev->gadget.is_selfpowered;
> +		status |=3D pdev->may_wakeup << USB_DEVICE_REMOTE_WAKEUP;
> +
> +		if (pdev->gadget.speed >=3D USB_SPEED_SUPER) {
> +			status |=3D pdev->u1_allowed << USB_DEV_STAT_U1_ENABLED;
> +			status |=3D pdev->u2_allowed << USB_DEV_STAT_U2_ENABLED;
> +		}
> +		break;
> +	case USB_RECIP_INTERFACE:
> +		/*
> +		 * Function Remote Wake Capable	D0
> +		 * Function Remote Wakeup	D1
> +		 */
> +		return cdnsp_ep0_delegate_req(pdev, ctrl);
> +	case USB_RECIP_ENDPOINT:
> +		pep =3D &pdev->eps[cdnsp_w_index_to_ep_index(ctrl->wIndex)];
> +		ep_sts =3D GET_EP_CTX_STATE(pep->out_ctx);
> +
> +		/* check if endpoint is stalled */
> +		if (ep_sts =3D=3D EP_STATE_HALTED)
> +			status =3D  BIT(USB_ENDPOINT_HALT);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	response =3D (__le16 *)pdev->setup_buf;
> +	*response =3D cpu_to_le16(status);
> +
> +	pdev->ep0_preq.request.length =3D sizeof(*response);
> +	pdev->ep0_preq.request.buf =3D pdev->setup_buf;
> +
> +	return cdnsp_ep_enqueue(pdev->ep0_preq.pep, &pdev->ep0_preq);
> +}
> +
> +static void cdnsp_enter_test_mode(struct cdnsp_device *pdev)
> +{
> +	u32 temp;
> +
> +	temp =3D readl(&pdev->active_port->regs->portpmsc) & ~GENMASK(31, 28);
> +	temp |=3D PORT_TEST_MODE(pdev->test_mode);
> +	writel(temp, &pdev->active_port->regs->portpmsc);
> +	pdev->test_mode =3D 0;
> +}
> +
> +static int cdnsp_ep0_handle_feature_device(struct cdnsp_device *pdev,
> +					   struct usb_ctrlrequest *ctrl,
> +					   int set)
> +{
> +	enum usb_device_state state;
> +	enum usb_device_speed speed;
> +	u16 tmode;
> +
> +	state =3D pdev->gadget.state;
> +	speed =3D pdev->gadget.speed;
> +
> +	switch (le16_to_cpu(ctrl->wValue)) {
> +	case USB_DEVICE_REMOTE_WAKEUP:
> +		pdev->may_wakeup =3D !!set;
> +		break;
> +	case USB_DEVICE_U1_ENABLE:
> +		if (state !=3D USB_STATE_CONFIGURED || speed < USB_SPEED_SUPER)
> +			return -EINVAL;
> +
> +		pdev->u1_allowed =3D !!set;
> +		break;
> +	case USB_DEVICE_U2_ENABLE:
> +		if (state !=3D USB_STATE_CONFIGURED || speed < USB_SPEED_SUPER)
> +			return -EINVAL;
> +
> +		pdev->u2_allowed =3D !!set;
> +		break;
> +	case USB_DEVICE_LTM_ENABLE:
> +		return -EINVAL;
> +	case USB_DEVICE_TEST_MODE:
> +		if (state !=3D USB_STATE_CONFIGURED || speed > USB_SPEED_HIGH)
> +			return -EINVAL;
> +
> +		tmode =3D le16_to_cpu(ctrl->wIndex);
> +
> +		if (!set || (tmode & 0xff) !=3D 0)
> +			return -EINVAL;
> +
> +		tmode =3D tmode >> 8;
> +
> +		if (tmode > USB_TEST_FORCE_ENABLE || tmode < USB_TEST_J)
> +			return -EINVAL;
> +
> +		pdev->test_mode =3D tmode;
> +
> +		/*
> +		 * Test mode must be set before Status Stage but controller
> +		 * will start testing sequence after Status Stage.
> +		 */
> +		cdnsp_enter_test_mode(pdev);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int cdnsp_ep0_handle_feature_intf(struct cdnsp_device *pdev,
> +					 struct usb_ctrlrequest *ctrl,
> +					 int set)
> +{
> +	u16 wValue, wIndex;
> +	int ret;
> +
> +	wValue =3D le16_to_cpu(ctrl->wValue);
> +	wIndex =3D le16_to_cpu(ctrl->wIndex);
> +
> +	switch (wValue) {
> +	case USB_INTRF_FUNC_SUSPEND:
> +		ret =3D cdnsp_ep0_delegate_req(pdev, ctrl);
> +		if (ret)
> +			return ret;
> +
> +		/*
> +		 * Remote wakeup is enabled when any function within a device
> +		 * is enabled for function remote wakeup.
> +		 */
> +		if (wIndex & USB_INTRF_FUNC_SUSPEND_RW)
> +			pdev->may_wakeup++;
> +		else
> +			if (pdev->may_wakeup > 0)
> +				pdev->may_wakeup--;
> +
> +		return 0;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int cdnsp_ep0_handle_feature_endpoint(struct cdnsp_device *pdev,
> +					     struct usb_ctrlrequest *ctrl,
> +					     int set)
> +{
> +	struct cdnsp_ep *pep;
> +	u32 wValue;
> +
> +	wValue =3D le16_to_cpu(ctrl->wValue);
> +	pep =3D &pdev->eps[cdnsp_w_index_to_ep_index(ctrl->wIndex)];
> +
> +	switch (wValue) {
> +	case USB_ENDPOINT_HALT:
> +		if (!set && (pep->ep_state & EP_WEDGE)) {
> +			/* Resets Sequence Number */
> +			cdnsp_halt_endpoint(pdev, pep, 0);
> +			cdnsp_halt_endpoint(pdev, pep, 1);
> +			break;
> +		}
> +
> +		return cdnsp_halt_endpoint(pdev, pep, set);
> +	default:
> +		dev_warn(pdev->dev, "WARN Incorrect wValue %04x\n", wValue);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int cdnsp_ep0_handle_feature(struct cdnsp_device *pdev,
> +				    struct usb_ctrlrequest *ctrl,
> +				    int set)
> +{
> +	switch (ctrl->bRequestType & USB_RECIP_MASK) {
> +	case USB_RECIP_DEVICE:
> +		return cdnsp_ep0_handle_feature_device(pdev, ctrl, set);
> +	case USB_RECIP_INTERFACE:
> +		return cdnsp_ep0_handle_feature_intf(pdev, ctrl, set);
> +	case USB_RECIP_ENDPOINT:
> +		return cdnsp_ep0_handle_feature_endpoint(pdev, ctrl, set);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int cdnsp_ep0_set_sel(struct cdnsp_device *pdev,
> +			     struct usb_ctrlrequest *ctrl)
> +{
> +	enum usb_device_state state =3D pdev->gadget.state;
> +	u16 wLength;
> +
> +	if (state =3D=3D USB_STATE_DEFAULT)
> +		return -EINVAL;
> +
> +	wLength =3D le16_to_cpu(ctrl->wLength);
> +
> +	if (wLength !=3D 6) {
> +		dev_err(pdev->dev, "Set SEL should be 6 bytes, got %d\n",
> +			wLength);
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * To handle Set SEL we need to receive 6 bytes from Host. So let's
> +	 * queue a usb_request for 6 bytes.
> +	 */
> +	pdev->ep0_preq.request.length =3D 6;
> +	pdev->ep0_preq.request.buf =3D pdev->setup_buf;
> +
> +	return cdnsp_ep_enqueue(pdev->ep0_preq.pep, &pdev->ep0_preq);
> +}
> +
> +static int cdnsp_ep0_set_isoch_delay(struct cdnsp_device *pdev,
> +				     struct usb_ctrlrequest *ctrl)
> +{
> +	if (le16_to_cpu(ctrl->wIndex) || le16_to_cpu(ctrl->wLength))
> +		return -EINVAL;
> +
> +	pdev->gadget.isoch_delay =3D le16_to_cpu(ctrl->wValue);
> +
> +	return 0;
> +}
> +
> +static int cdnsp_ep0_std_request(struct cdnsp_device *pdev,
> +				 struct usb_ctrlrequest *ctrl)
> +{
> +	int ret;
> +
> +	switch (ctrl->bRequest) {
> +	case USB_REQ_GET_STATUS:
> +		ret =3D cdnsp_ep0_handle_status(pdev, ctrl);
> +		break;
> +	case USB_REQ_CLEAR_FEATURE:
> +		ret =3D cdnsp_ep0_handle_feature(pdev, ctrl, 0);
> +		break;
> +	case USB_REQ_SET_FEATURE:
> +		ret =3D cdnsp_ep0_handle_feature(pdev, ctrl, 1);
> +		break;
> +	case USB_REQ_SET_ADDRESS:
> +		ret =3D cdnsp_ep0_set_address(pdev, ctrl);
> +		break;
> +	case USB_REQ_SET_CONFIGURATION:
> +		ret =3D cdnsp_ep0_set_config(pdev, ctrl);
> +		break;
> +	case USB_REQ_SET_SEL:
> +		ret =3D cdnsp_ep0_set_sel(pdev, ctrl);
> +		break;
> +	case USB_REQ_SET_ISOCH_DELAY:
> +		ret =3D cdnsp_ep0_set_isoch_delay(pdev, ctrl);
> +		break;
> +	case USB_REQ_SET_INTERFACE:
> +		/*
> +		 * Add request into pending list to block sending status stage
> +		 * by libcomposite.
> +		 */
> +		list_add_tail(&pdev->ep0_preq.list,
> +			      &pdev->ep0_preq.pep->pending_list);
> +
> +		ret =3D cdnsp_ep0_delegate_req(pdev, ctrl);
> +		if (ret =3D=3D -EBUSY)
> +			ret =3D 0;
> +
> +		list_del(&pdev->ep0_preq.list);
> +		break;
> +	default:
> +		ret =3D cdnsp_ep0_delegate_req(pdev, ctrl);
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +void cdnsp_setup_analyze(struct cdnsp_device *pdev)
> +{
> +	struct usb_ctrlrequest *ctrl =3D &pdev->setup;
> +	int ret =3D 0;
> +	__le16 len;
> +
> +	if (!pdev->gadget_driver)
> +		goto out;
> +
> +	if (pdev->gadget.state =3D=3D USB_STATE_NOTATTACHED) {
> +		dev_err(pdev->dev, "ERR: Setup detected in unattached state\n");
> +		ret =3D -EINVAL;
> +		goto out;
> +	}
> +
> +	/* Restore the ep0 to Stopped/Running state. */
> +	if (pdev->eps[0].ep_state & EP_HALTED)
> +		cdnsp_halt_endpoint(pdev, &pdev->eps[0], 0);
> +
> +	/*
> +	 * Finishing previous SETUP transfer by removing request from
> +	 * list and informing upper layer
> +	 */
> +	if (!list_empty(&pdev->eps[0].pending_list)) {
> +		struct cdnsp_request	*req;
> +
> +		req =3D next_request(&pdev->eps[0].pending_list);
> +		cdnsp_ep_dequeue(&pdev->eps[0], req);
> +	}
> +
> +	len =3D le16_to_cpu(ctrl->wLength);
> +	if (!len) {
> +		pdev->three_stage_setup =3D false;
> +		pdev->ep0_expect_in =3D false;
> +	} else {
> +		pdev->three_stage_setup =3D true;
> +		pdev->ep0_expect_in =3D !!(ctrl->bRequestType & USB_DIR_IN);
> +	}
> +
> +	if ((ctrl->bRequestType & USB_TYPE_MASK) =3D=3D USB_TYPE_STANDARD)
> +		ret =3D cdnsp_ep0_std_request(pdev, ctrl);
> +	else
> +		ret =3D cdnsp_ep0_delegate_req(pdev, ctrl);
> +
> +	if (!len)
> +		pdev->ep0_stage =3D CDNSP_STATUS_STAGE;
> +
> +	if (ret =3D=3D USB_GADGET_DELAYED_STATUS)
> +		return;
> +out:
> +	if (ret < 0)
> +		cdnsp_ep0_stall(pdev);
> +	else if (pdev->ep0_stage =3D=3D CDNSP_STATUS_STAGE)
> +		cdnsp_status_stage(pdev);
> +}
> diff --git a/drivers/usb/cdnsp/gadget.c b/drivers/usb/cdnsp/gadget.c
> new file mode 100644
> index 000000000000..38ad170b2bdd
> --- /dev/null
> +++ b/drivers/usb/cdnsp/gadget.c
> @@ -0,0 +1,1946 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Cadence CDNSP DRD Driver.
> + *
> + * Copyright (C) 2020 Cadence.
> + *
> + * Author: Pawel Laszczak <pawell@cadence.com>
> + *
> + */
> +
> +#include <linux/moduleparam.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/module.h>
> +#include <linux/iopoll.h>
> +#include <linux/delay.h>
> +#include <linux/log2.h>
> +#include <linux/slab.h>
> +#include <linux/pci.h>
> +#include <linux/irq.h>
> +#include <linux/dmi.h>
> +
> +#include "../cdns3/core.h"
> +#include "../cdns3/gadget-export.h"
> +#include "../cdns3/drd.h"
> +#include "gadget.h"
> +
> +unsigned int cdnsp_port_speed(unsigned int port_status)
> +{
> +	/*Detect gadget speed based on PORTSC register*/
> +	if (DEV_SUPERSPEEDPLUS(port_status))
> +		return USB_SPEED_SUPER_PLUS;
> +	else if (DEV_SUPERSPEED(port_status))
> +		return USB_SPEED_SUPER;
> +	else if (DEV_HIGHSPEED(port_status))
> +		return USB_SPEED_HIGH;
> +	else if (DEV_FULLSPEED(port_status))
> +		return USB_SPEED_FULL;
> +
> +	/* If device is detached then speed will be USB_SPEED_UNKNOWN.*/
> +	return USB_SPEED_UNKNOWN;
> +}
> +
> +/*
> + * Given a port state, this function returns a value that would result i=
n the
> + * port being in the same state, if the value was written to the port st=
atus
> + * control register.
> + * Save Read Only (RO) bits and save read/write bits where
> + * writing a 0 clears the bit and writing a 1 sets the bit (RWS).
> + * For all other types (RW1S, RW1CS, RW, and RZ), writing a '0' has no e=
ffect.
> + */
> +u32 cdnsp_port_state_to_neutral(u32 state)
> +{
> +	/* Save read-only status and port state. */
> +	return (state & CDNSP_PORT_RO) | (state & CDNSP_PORT_RWS);
> +}
> +
> +/**
> + * Find the offset of the extended capabilities with capability ID id.
> + * @base: PCI MMIO registers base address.
> + * @start: Address at which to start looking, (0 or HCC_PARAMS to start =
at
> + *         beginning of list)
> + * @id: Extended capability ID to search for.
> + *
> + * Returns the offset of the next matching extended capability structure=
.
> + * Some capabilities can occur several times,
> + * e.g., the EXT_CAPS_PROTOCOL, and this provides a way to find them all=
.
> + */
> +int cdnsp_find_next_ext_cap(void __iomem *base, u32 start, int id)
> +{
> +	u32 offset =3D start;
> +	u32 next;
> +	u32 val;
> +
> +	if (!start || start =3D=3D HCC_PARAMS_OFFSET) {
> +		val =3D readl(base + HCC_PARAMS_OFFSET);
> +		if (val =3D=3D ~0)
> +			return 0;
> +
> +		offset =3D HCC_EXT_CAPS(val) << 2;
> +		if (!offset)
> +			return 0;
> +	};
> +
> +	do {
> +		val =3D readl(base + offset);
> +		if (val =3D=3D ~0)
> +			return 0;
> +
> +		if (EXT_CAPS_ID(val) =3D=3D id && offset !=3D start)
> +			return offset;
> +
> +		next =3D EXT_CAPS_NEXT(val);
> +		offset +=3D next << 2;
> +	} while (next);
> +
> +	return 0;
> +}
> +
> +void cdnsp_set_link_state(struct cdnsp_device *pdev,
> +			  __le32 __iomem *port_regs,
> +			  u32 link_state)
> +{
> +	u32 temp;
> +
> +	temp =3D readl(port_regs);
> +	temp =3D cdnsp_port_state_to_neutral(temp);
> +	temp |=3D PORT_WKCONN_E | PORT_WKDISC_E;
> +	writel(temp, port_regs);
> +
> +	temp &=3D ~PORT_PLS_MASK;
> +	temp |=3D PORT_LINK_STROBE | link_state;
> +
> +	writel(temp, port_regs);
> +}
> +
> +static void cdnsp_disable_port(struct cdnsp_device *pdev,
> +			       __le32 __iomem *port_regs)
> +{
> +	u32 temp =3D cdnsp_port_state_to_neutral(readl(port_regs));
> +
> +	writel(temp | PORT_PED, port_regs);
> +}
> +
> +static void cdnsp_clear_port_change_bit(struct cdnsp_device *pdev,
> +					__le32 __iomem *port_regs)
> +{
> +	u32 portsc =3D readl(port_regs);
> +
> +	writel(cdnsp_port_state_to_neutral(portsc) |
> +	       (portsc & PORT_CHANGE_BITS), port_regs);
> +}
> +
> +static void cdnsp_set_chicken_bits_2(struct cdnsp_device *pdev, u32 bit)
> +{
> +	__le32 __iomem *reg;
> +	void __iomem *base;
> +	u32 offset =3D 0;
> +
> +	base =3D &pdev->cap_regs->hc_capbase;
> +	offset =3D cdnsp_find_next_ext_cap(base, offset, D_XEC_PRE_REGS_CAP);
> +	reg =3D base + offset + REG_CHICKEN_BITS_2_OFFSET;
> +
> +	bit =3D readl(reg) | bit;
> +	writel(bit, reg);
> +}
> +
> +static void cdnsp_clear_chicken_bits_2(struct cdnsp_device *pdev, u32 bi=
t)
> +{
> +	__le32 __iomem *reg;
> +	void __iomem *base;
> +	u32 offset =3D 0;
> +
> +	base =3D &pdev->cap_regs->hc_capbase;
> +	offset =3D cdnsp_find_next_ext_cap(base, offset, D_XEC_PRE_REGS_CAP);
> +	reg =3D base + offset + REG_CHICKEN_BITS_2_OFFSET;
> +
> +	bit =3D readl(reg) & ~bit;
> +	writel(bit, reg);
> +}
> +
> +/*
> + * Disable interrupts and begin the controller halting process.
> + */
> +static void cdnsp_quiesce(struct cdnsp_device *pdev)
> +{
> +	u32 halted;
> +	u32 mask;
> +	u32 cmd;
> +
> +	mask =3D ~(u32)(CDNSP_IRQS);
> +
> +	halted =3D readl(&pdev->op_regs->status) & STS_HALT;
> +	if (!halted)
> +		mask &=3D ~(CMD_R_S | CMD_DEVEN);
> +
> +	cmd =3D readl(&pdev->op_regs->command);
> +	cmd &=3D mask;
> +	writel(cmd, &pdev->op_regs->command);
> +}
> +
> +/*
> + * Force controller into halt state.
> + *
> + * Disable any IRQs and clear the run/stop bit.
> + * Controller will complete any current and actively pipelined transacti=
ons, and
> + * should halt within 16 ms of the run/stop bit being cleared.
> + * Read controller Halted bit in the status register to see when the
> + * controller is finished.
> + */
> +int cdnsp_halt(struct cdnsp_device *pdev)
> +{
> +	int ret;
> +	u32 val;
> +
> +	cdnsp_quiesce(pdev);
> +
> +	ret =3D readl_poll_timeout_atomic(&pdev->op_regs->status, val,
> +					val & STS_HALT, 1,
> +					CDNSP_MAX_HALT_USEC);
> +	if (ret) {
> +		dev_err(pdev->dev, "ERROR: Device halt failed\n");
> +		return ret;
> +	}
> +
> +	pdev->cdnsp_state |=3D CDNSP_STATE_HALTED;
> +
> +	return 0;
> +}
> +
> +/*
> + * device controller died, register read returns 0xffffffff, or command =
never
> + * ends.
> + */
> +void cdnsp_died(struct cdnsp_device *pdev)
> +{
> +	dev_err(pdev->dev, "ERROR: CDNSP controller not responding\n");
> +	pdev->cdnsp_state |=3D CDNSP_STATE_DYING;
> +	cdnsp_halt(pdev);
> +}
> +
> +/*
> + * Set the run bit and wait for the device to be running.
> + */
> +static int cdnsp_start(struct cdnsp_device *pdev)
> +{
> +	u32 temp;
> +	int ret;
> +
> +	temp =3D readl(&pdev->op_regs->command);
> +	temp |=3D (CMD_R_S | CMD_DEVEN);
> +	writel(temp, &pdev->op_regs->command);
> +
> +	pdev->cdnsp_state =3D 0;
> +
> +	/*
> +	 * Wait for the STS_HALT Status bit to be 0 to indicate the device is
> +	 * running.
> +	 */
> +	ret =3D readl_poll_timeout_atomic(&pdev->op_regs->status, temp,
> +					!(temp & STS_HALT), 1,
> +					CDNSP_MAX_HALT_USEC);
> +	if (ret) {
> +		pdev->cdnsp_state =3D CDNSP_STATE_DYING;
> +		dev_err(pdev->dev, "ERROR: Controller run failed\n");
> +	}
> +
> +	return ret;
> +}
> +
> +/*
> + * Reset a halted controller.
> + *
> + * This resets pipelines, timers, counters, state machines, etc.
> + * Transactions will be terminated immediately, and operational register=
s
> + * will be set to their defaults.
> + */
> +int cdnsp_reset(struct cdnsp_device *pdev)
> +{
> +	u32 command;
> +	u32 temp;
> +	int ret;
> +
> +	temp =3D readl(&pdev->op_regs->status);
> +
> +	if (temp =3D=3D ~(u32)0) {
> +		dev_err(pdev->dev, "Device not accessible, reset failed.\n");
> +		return -ENODEV;
> +	}
> +
> +	if ((temp & STS_HALT) =3D=3D 0) {
> +		dev_err(pdev->dev, "Controller not halted, aborting reset.\n");
> +		return -EINVAL;
> +	}
> +
> +	command =3D readl(&pdev->op_regs->command);
> +	command |=3D CMD_RESET;
> +	writel(command, &pdev->op_regs->command);
> +
> +	ret =3D readl_poll_timeout_atomic(&pdev->op_regs->command, temp,
> +					!(temp & CMD_RESET), 1,
> +					10 * 1000);
> +	if (ret) {
> +		dev_err(pdev->dev, "ERROR: Controller reset failed\n");
> +		return ret;
> +	}
> +
> +	/*
> +	 * CDNSP cannot write any doorbells or operational registers other
> +	 * than status until the "Controller Not Ready" flag is cleared.
> +	 */
> +	ret =3D readl_poll_timeout_atomic(&pdev->op_regs->status, temp,
> +					!(temp & STS_CNR), 1,
> +					10 * 1000);
> +
> +	if (ret) {
> +		dev_err(pdev->dev, "ERROR: Controller not ready to work\n");
> +		return ret;
> +	}
> +
> +	dev_info(pdev->dev, "Controller ready to work");
> +
> +	return ret;
> +}
> +
> +/*
> + * cdnsp_get_endpoint_index - Find the index for an endpoint given its
> + * descriptor.Use the return value to right shift 1 for the bitmask.
> + *
> + * Index =3D (epnum * 2) + direction - 1,
> + * where direction =3D 0 for OUT, 1 for IN.
> + * For control endpoints, the IN index is used (OUT index is unused), so
> + * index =3D (epnum * 2) + direction - 1 =3D (epnum * 2) + 1 - 1 =3D (ep=
num * 2)
> + */
> +static unsigned int
> +	cdnsp_get_endpoint_index(const struct usb_endpoint_descriptor *desc)
> +{
> +	unsigned int index =3D (unsigned int)usb_endpoint_num(desc);
> +
> +	if (usb_endpoint_xfer_control(desc))
> +		return index * 2;
> +
> +	return (index * 2) + (usb_endpoint_dir_in(desc) ? 1 : 0) - 1;
> +}
> +
> +/*
> + * Find the flag for this endpoint (for use in the control context). Use=
 the
> + * endpoint index to create a bitmask. The slot context is bit 0, endpoi=
nt 0 is
> + * bit 1, etc.
> + */
> +static unsigned int
> +	cdnsp_get_endpoint_flag(const struct usb_endpoint_descriptor *desc)
> +{
> +	return 1 << (cdnsp_get_endpoint_index(desc) + 1);
> +}
> +
> +int cdnsp_ep_enqueue(struct cdnsp_ep *pep, struct cdnsp_request *preq)
> +{
> +	struct cdnsp_device *pdev =3D pep->pdev;
> +	struct usb_request *request;
> +	int ret;
> +
> +	if (preq->epnum =3D=3D 0 && !list_empty(&pep->pending_list))
> +		return -EBUSY;
> +
> +	request =3D &preq->request;
> +	request->actual =3D 0;
> +	request->status =3D -EINPROGRESS;
> +	preq->direction =3D pep->direction;
> +	preq->epnum =3D pep->number;
> +	preq->td.drbl =3D 0;
> +
> +	ret =3D usb_gadget_map_request_by_dev(pdev->dev, request, pep->directio=
n);
> +	if (ret)
> +		return ret;
> +
> +	list_add_tail(&preq->list, &pep->pending_list);
> +
> +	switch (usb_endpoint_type(pep->endpoint.desc)) {
> +	case USB_ENDPOINT_XFER_CONTROL:
> +		ret =3D cdnsp_queue_ctrl_tx(pdev, preq);
> +		break;
> +	case USB_ENDPOINT_XFER_BULK:
> +	case USB_ENDPOINT_XFER_INT:
> +		ret =3D cdnsp_queue_bulk_tx(pdev, preq);
> +		break;
> +	case USB_ENDPOINT_XFER_ISOC:
> +		ret =3D cdnsp_queue_isoc_tx_prepare(pdev, preq);
> +	}
> +
> +	if (ret)
> +		goto unmap;
> +
> +	return 0;
> +
> +unmap:
> +	usb_gadget_unmap_request_by_dev(pdev->dev, &preq->request,
> +					pep->direction);
> +	list_del(&preq->list);
> +
> +	return ret;
> +}
> +
> +/*
> + * Remove the request's TD from the endpoint ring. This may cause the
> + * controller to stop USB transfers, potentially stopping in the middle =
of a
> + * TRB buffer. The controller should pick up where it left off in the TD=
,
> + * unless a Set Transfer Ring Dequeue Pointer is issued.
> + *
> + * The TRBs that make up the buffers for the canceled request will be "r=
emoved"
> + * from the ring. Since the ring is a contiguous structure, they can't b=
e
> + * physically removed. Instead, there are two options:
> + *
> + *  1) If the controller is in the middle of processing the request to b=
e
> + *     canceled, we simply move the ring's dequeue pointer past those TR=
Bs
> + *     using the Set Transfer Ring Dequeue Pointer command. This will be
> + *     the common case, when drivers timeout on the last submitted reque=
st
> + *     and attempt to cancel.
> + *
> + *  2) If the controller is in the middle of a different TD, we turn the=
 TRBs
> + *     into a series of 1-TRB transfer no-op TDs. No-ops shouldn't be ch=
ained.
> + *     The controller will need to invalidate the any TRBs it has cached=
 after
> + *     the stop endpoint command.
> + *
> + *  3) The TD may have completed by the time the Stop Endpoint Command
> + *     completes, so software needs to handle that case too.
> + *
> + */
> +int cdnsp_ep_dequeue(struct cdnsp_ep *pep, struct cdnsp_request *preq)
> +{
> +	struct cdnsp_device *pdev =3D pep->pdev;
> +	int ret;
> +
> +	if (GET_EP_CTX_STATE(pep->out_ctx) =3D=3D EP_STATE_RUNNING) {
> +		ret =3D cdnsp_cmd_stop_ep(pdev, pep);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return cdnsp_remove_request(pdev, preq, pep);
> +}
> +
> +static void cdnsp_zero_in_ctx(struct cdnsp_device *pdev)
> +{
> +	struct cdnsp_input_control_ctx *ctrl_ctx;
> +	struct cdnsp_slot_ctx *slot_ctx;
> +	struct cdnsp_ep_ctx *ep_ctx;
> +	int i;
> +
> +	ctrl_ctx =3D cdnsp_get_input_control_ctx(&pdev->in_ctx);
> +
> +	/*
> +	 * When a device's add flag and drop flag are zero, any subsequent
> +	 * configure endpoint command will leave that endpoint's state
> +	 * untouched. Make sure we don't leave any old state in the input
> +	 * endpoint contexts.
> +	 */
> +	ctrl_ctx->drop_flags =3D 0;
> +	ctrl_ctx->add_flags =3D 0;
> +	slot_ctx =3D cdnsp_get_slot_ctx(&pdev->in_ctx);
> +	slot_ctx->dev_info &=3D cpu_to_le32(~LAST_CTX_MASK);
> +
> +	/* Endpoint 0 is always valid */
> +	slot_ctx->dev_info |=3D cpu_to_le32(LAST_CTX(1));
> +	for (i =3D 1; i < 31; ++i) {
> +		ep_ctx =3D cdnsp_get_ep_ctx(&pdev->in_ctx, i);
> +		ep_ctx->ep_info =3D 0;
> +		ep_ctx->ep_info2 =3D 0;
> +		ep_ctx->deq =3D 0;
> +		ep_ctx->tx_info =3D 0;
> +	}
> +}
> +
> +/* Issue a configure endpoint command and wait for it to finish. */
> +static int cdnsp_configure_endpoint(struct cdnsp_device *pdev)
> +{
> +	int ret;
> +
> +	cdnsp_queue_configure_endpoint(pdev, pdev->cmd.in_ctx->dma);
> +	cdnsp_ring_cmd_db(pdev);
> +	ret =3D cdnsp_wait_for_cmd_compl(pdev);
> +	if (ret) {
> +		dev_err(pdev->dev,
> +			"ERR: unexpected command completion code 0x%x.\n", ret);
> +		return -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
> +static void cdnsp_invalidate_ep_events(struct cdnsp_device *pdev,
> +				       struct cdnsp_ep *pep)
> +{
> +	struct cdnsp_segment *segment;
> +	union cdnsp_trb *event;
> +	u32 cycle_state;
> +	__le32  data;
> +
> +	event =3D pdev->event_ring->dequeue;
> +	segment =3D pdev->event_ring->deq_seg;
> +	cycle_state =3D pdev->event_ring->cycle_state;
> +
> +	while (1) {
> +		data =3D le32_to_cpu(event->trans_event.flags);
> +
> +		/* Check the owner of the TRB. */
> +		if ((data & TRB_CYCLE) !=3D cycle_state)
> +			break;
> +
> +		if (TRB_FIELD_TO_TYPE(data) =3D=3D TRB_TRANSFER &&
> +		    TRB_TO_EP_ID(data) =3D=3D (pep->idx + 1)) {
> +			data |=3D TRB_EVENT_INVALIDATE;
> +			event->trans_event.flags =3D cpu_to_le32(data);
> +		}
> +
> +		if (cdnsp_last_trb_on_seg(segment, event)) {
> +			cycle_state ^=3D 1;
> +			segment =3D pdev->event_ring->deq_seg->next;
> +			event =3D segment->trbs;
> +		} else {
> +			event++;
> +		}
> +	}
> +}
> +
> +int cdnsp_wait_for_cmd_compl(struct cdnsp_device *pdev)
> +{
> +	struct cdnsp_segment *event_deq_seg;
> +	dma_addr_t cmd_deq_dma;
> +	union cdnsp_trb *cmd_trb;
> +	union cdnsp_trb *event;
> +	u32 cycle_state;
> +	__le32  flags;
> +	int ret, val;
> +	u64 cmd_dma;
> +
> +	cmd_trb =3D pdev->cmd.command_trb;
> +	pdev->cmd.status =3D 0;
> +
> +	ret =3D readl_poll_timeout_atomic(&pdev->op_regs->cmd_ring, val,
> +					!CMD_RING_BUSY(val), 1,
> +					CDNSP_CMD_TIMEOUT);
> +	if (ret) {
> +		dev_err(pdev->dev, "ERR: Timeout while waiting for command\n");
> +		pdev->cdnsp_state =3D CDNSP_STATE_DYING;
> +		return -ETIMEDOUT;
> +	}
> +
> +	event =3D pdev->event_ring->dequeue;
> +	event_deq_seg =3D pdev->event_ring->deq_seg;
> +	cycle_state =3D pdev->event_ring->cycle_state;
> +
> +	cmd_deq_dma =3D cdnsp_trb_virt_to_dma(pdev->cmd_ring->deq_seg, cmd_trb)=
;
> +	if (!cmd_deq_dma)
> +		return -EINVAL;
> +
> +	while (1) {
> +		flags =3D le32_to_cpu(event->event_cmd.flags);
> +
> +		/* Check the owner of the TRB. */
> +		if ((flags & TRB_CYCLE) !=3D cycle_state)
> +			return -EINVAL;
> +
> +		cmd_dma =3D le64_to_cpu(event->event_cmd.cmd_trb);
> +
> +		/*
> +		 * Check whether the completion event is for last queued
> +		 * command.
> +		 */
> +		if (TRB_FIELD_TO_TYPE(flags) !=3D TRB_COMPLETION ||
> +		    cmd_dma !=3D (u64)cmd_deq_dma) {
> +			if (!cdnsp_last_trb_on_seg(event_deq_seg, event)) {
> +				event++;
> +				continue;
> +			}
> +
> +			if (cdnsp_last_trb_on_ring(pdev->event_ring,
> +						   event_deq_seg, event))
> +				cycle_state ^=3D 1;
> +
> +			event_deq_seg =3D event_deq_seg->next;
> +			event =3D event_deq_seg->trbs;
> +			continue;
> +		}
> +
> +		pdev->cmd.status =3D GET_COMP_CODE(le32_to_cpu(event->event_cmd.status=
));
> +		if (pdev->cmd.status =3D=3D COMP_SUCCESS)
> +			return 0;
> +
> +		return -pdev->cmd.status;
> +	}
> +
> +	return 0;
> +}
> +
> +int cdnsp_halt_endpoint(struct cdnsp_device *pdev,
> +			struct cdnsp_ep *pep,
> +			int value)
> +{
> +	int ret;
> +
> +	if (value) {
> +		ret =3D cdnsp_cmd_stop_ep(pdev, pep);
> +		if (ret)
> +			return ret;
> +
> +		if (GET_EP_CTX_STATE(pep->out_ctx) =3D=3D EP_STATE_STOPPED) {
> +			cdnsp_queue_halt_endpoint(pdev, pep->idx);
> +			cdnsp_ring_cmd_db(pdev);
> +			ret =3D cdnsp_wait_for_cmd_compl(pdev);
> +		}
> +
> +		pep->ep_state |=3D EP_HALTED;
> +	} else {
> +		/*
> +		 * In device mode driver can call reset endpoint command
> +		 * from any endpoint state.
> +		 */
> +		cdnsp_queue_reset_ep(pdev, pep->idx);
> +		cdnsp_ring_cmd_db(pdev);
> +		ret =3D cdnsp_wait_for_cmd_compl(pdev);
> +		if (ret)
> +			return ret;
> +
> +		pep->ep_state &=3D ~EP_HALTED;
> +
> +		if (pep->idx !=3D 0 && !(pep->ep_state & EP_WEDGE))
> +			cdnsp_ring_doorbell_for_active_rings(pdev, pep);
> +
> +		pep->ep_state &=3D ~EP_WEDGE;
> +	}
> +
> +	return 0;
> +}
> +
> +static int cdnsp_update_eps_configuration(struct cdnsp_device *pdev,
> +					  struct cdnsp_ep *pep)
> +{
> +	struct cdnsp_input_control_ctx *ctrl_ctx;
> +	struct cdnsp_slot_ctx *slot_ctx;
> +	int ret =3D 0;
> +	u32 ep_sts;
> +	int i;
> +
> +	ctrl_ctx =3D cdnsp_get_input_control_ctx(&pdev->in_ctx);
> +
> +	/* Don't issue the command if there's no endpoints to update. */
> +	if (ctrl_ctx->add_flags =3D=3D 0 && ctrl_ctx->drop_flags =3D=3D 0)
> +		return 0;
> +
> +	ctrl_ctx->add_flags |=3D cpu_to_le32(SLOT_FLAG);
> +	ctrl_ctx->add_flags &=3D cpu_to_le32(~EP0_FLAG);
> +	ctrl_ctx->drop_flags &=3D cpu_to_le32(~(SLOT_FLAG | EP0_FLAG));
> +
> +	/* Fix up Context Entries field. Minimum value is EP0 =3D=3D BIT(1). */
> +	slot_ctx =3D cdnsp_get_slot_ctx(&pdev->in_ctx);
> +	for (i =3D 31; i >=3D 1; i--) {
> +		__le32 le32 =3D cpu_to_le32(BIT(i));
> +
> +		if ((pdev->eps[i - 1].ring && !(ctrl_ctx->drop_flags & le32)) ||
> +		    (ctrl_ctx->add_flags & le32) || i =3D=3D 1) {
> +			slot_ctx->dev_info &=3D cpu_to_le32(~LAST_CTX_MASK);
> +			slot_ctx->dev_info |=3D cpu_to_le32(LAST_CTX(i));
> +			break;
> +		}
> +	}
> +
> +	ep_sts =3D GET_EP_CTX_STATE(pep->out_ctx);
> +
> +	if ((ctrl_ctx->add_flags !=3D cpu_to_le32(SLOT_FLAG) &&
> +	     ep_sts =3D=3D EP_STATE_DISABLED) ||
> +	    (ep_sts !=3D EP_STATE_DISABLED && ctrl_ctx->drop_flags))
> +		ret =3D cdnsp_configure_endpoint(pdev);
> +
> +	cdnsp_zero_in_ctx(pdev);
> +
> +	return ret;
> +}
> +
> +/*
> + * This submits a Reset Device Command, which will set the device state =
to 0,
> + * set the device address to 0, and disable all the endpoints except the=
 default
> + * control endpoint. The USB core should come back and call
> + * cdnsp_setup_device(), and then re-set up the configuration.
> + */
> +int cdnsp_reset_device(struct cdnsp_device *pdev)
> +{
> +	struct cdnsp_slot_ctx *slot_ctx;
> +	int slot_state;
> +	int ret, i;
> +
> +	slot_ctx =3D cdnsp_get_slot_ctx(&pdev->in_ctx);
> +	slot_ctx->dev_info =3D 0;
> +	pdev->device_address =3D 0;
> +
> +	/* If device is not setup, there is no point in resetting it. */
> +	slot_ctx =3D cdnsp_get_slot_ctx(&pdev->out_ctx);
> +	slot_state =3D GET_SLOT_STATE(le32_to_cpu(slot_ctx->dev_state));
> +
> +	if (slot_state <=3D SLOT_STATE_DEFAULT &&
> +	    pdev->eps[0].ep_state & EP_HALTED) {
> +		cdnsp_halt_endpoint(pdev, &pdev->eps[0], 0);
> +	}
> +
> +	/*
> +	 * During Reset Device command controller shall transition the
> +	 * endpoint ep0 to the Running State.
> +	 */
> +	pdev->eps[0].ep_state &=3D ~(EP_STOPPED | EP_HALTED);
> +	pdev->eps[0].ep_state |=3D EP_ENABLED;
> +
> +	if (slot_state <=3D SLOT_STATE_DEFAULT)
> +		return 0;
> +
> +	cdnsp_queue_reset_device(pdev);
> +	cdnsp_ring_cmd_db(pdev);
> +	ret =3D cdnsp_wait_for_cmd_compl(pdev);
> +
> +	/*
> +	 * After Reset Device command all not default endpoints
> +	 * are in Disabled state.
> +	 */
> +	for (i =3D 1; i < 31; ++i)
> +		pdev->eps[i].ep_state |=3D EP_STOPPED;
> +
> +	if (ret)
> +		dev_err(pdev->dev, "Reset device failed with error code %d",
> +			ret);
> +
> +	return ret;
> +}
> +
> +/*
> + * Sets the MaxPStreams field and the Linear Stream Array field.
> + * Sets the dequeue pointer to the stream context array.
> + */
> +static void cdnsp_setup_streams_ep_input_ctx(struct cdnsp_device *pdev,
> +					     struct cdnsp_ep_ctx *ep_ctx,
> +					     struct cdnsp_stream_info *stream_info)
> +{
> +	u32 max_primary_streams;
> +
> +	/* MaxPStreams is the number of stream context array entries, not the
> +	 * number we're actually using. Must be in 2^(MaxPstreams + 1) format.
> +	 * fls(0) =3D 0, fls(0x1) =3D 1, fls(0x10) =3D 2, fls(0x100) =3D 3, etc=
.
> +	 */
> +	max_primary_streams =3D fls(stream_info->num_stream_ctxs) - 2;
> +	ep_ctx->ep_info &=3D cpu_to_le32(~EP_MAXPSTREAMS_MASK);
> +	ep_ctx->ep_info |=3D cpu_to_le32(EP_MAXPSTREAMS(max_primary_streams)
> +				       | EP_HAS_LSA);
> +	ep_ctx->deq  =3D cpu_to_le64(stream_info->ctx_array_dma);
> +}
> +
> +/*
> + * The drivers use this function to prepare a bulk endpoints to use stre=
ams.
> + *
> + * Don't allow the call to succeed if endpoint only supports one stream
> + * (which means it doesn't support streams at all).
> + */
> +int cdnsp_alloc_streams(struct cdnsp_device *pdev, struct cdnsp_ep *pep)
> +{
> +	unsigned int num_streams =3D usb_ss_max_streams(pep->endpoint.comp_desc=
);
> +	unsigned int num_stream_ctxs;
> +	int ret;
> +
> +	if (num_streams =3D=3D  0)
> +		return 0;
> +
> +	if (num_streams > STREAM_NUM_STREAMS)
> +		return -EINVAL;
> +
> +	/*
> +	 * Add two to the number of streams requested to account for
> +	 * stream 0 that is reserved for controller usage and one additional
> +	 * for TASK SET FULL response.
> +	 */
> +	num_streams +=3D 2;
> +
> +	/* The stream context array size must be a power of two */
> +	num_stream_ctxs =3D roundup_pow_of_two(num_streams);
> +
> +	ret =3D cdnsp_alloc_stream_info(pdev, pep, num_stream_ctxs, num_streams=
);
> +	if (ret)
> +		return ret;
> +
> +	cdnsp_setup_streams_ep_input_ctx(pdev, pep->in_ctx, &pep->stream_info);
> +
> +	pep->ep_state |=3D EP_HAS_STREAMS;
> +	pep->stream_info.td_count =3D 0;
> +	pep->stream_info.first_prime_det =3D 0;
> +
> +	/* Subtract 1 for stream 0, which drivers can't use. */
> +	return num_streams - 1;
> +}
> +
> +int cdnsp_disable_slot(struct cdnsp_device *pdev)
> +{
> +	int ret;
> +
> +	cdnsp_queue_slot_control(pdev, TRB_DISABLE_SLOT);
> +	cdnsp_ring_cmd_db(pdev);
> +	ret =3D cdnsp_wait_for_cmd_compl(pdev);
> +
> +	pdev->slot_id =3D 0;
> +	pdev->active_port =3D NULL;
> +
> +	memset(pdev->in_ctx.bytes, 0, CDNSP_CTX_SIZE);
> +	memset(pdev->out_ctx.bytes, 0, CDNSP_CTX_SIZE);
> +
> +	return ret;
> +}
> +
> +int cdnsp_enable_slot(struct cdnsp_device *pdev)
> +{
> +	struct cdnsp_slot_ctx *slot_ctx;
> +	int slot_state;
> +	int ret;
> +
> +	/* If device is not setup, there is no point in resetting it */
> +	slot_ctx =3D cdnsp_get_slot_ctx(&pdev->out_ctx);
> +	slot_state =3D GET_SLOT_STATE(le32_to_cpu(slot_ctx->dev_state));
> +
> +	if (slot_state !=3D SLOT_STATE_DISABLED)
> +		return 0;
> +
> +	cdnsp_queue_slot_control(pdev, TRB_ENABLE_SLOT);
> +	cdnsp_ring_cmd_db(pdev);
> +	ret =3D cdnsp_wait_for_cmd_compl(pdev);
> +	if (ret)
> +		return ret;
> +
> +	pdev->slot_id =3D 1;
> +
> +	return 0;
> +}
> +
> +/*
> + * Issue an Address Device command with BSR=3D0 if setup is SETUP_CONTEX=
T_ONLY
> + * or with BSR =3D 1 if set_address is SETUP_CONTEXT_ADDRESS.
> + */
> +int cdnsp_setup_device(struct cdnsp_device *pdev, enum cdnsp_setup_dev s=
etup)
> +{
> +	struct cdnsp_input_control_ctx *ctrl_ctx;
> +	struct cdnsp_slot_ctx *slot_ctx;
> +	int dev_state =3D 0;
> +	int ret;
> +
> +	if (!pdev->slot_id)
> +		return -EINVAL;
> +
> +	if (!pdev->active_port->port_num)
> +		return -EINVAL;
> +
> +	slot_ctx =3D cdnsp_get_slot_ctx(&pdev->out_ctx);
> +	dev_state =3D GET_SLOT_STATE(le32_to_cpu(slot_ctx->dev_state));
> +
> +	if (setup =3D=3D SETUP_CONTEXT_ONLY && dev_state =3D=3D SLOT_STATE_DEFA=
ULT)
> +		return 0;
> +
> +	slot_ctx =3D cdnsp_get_slot_ctx(&pdev->in_ctx);
> +	ctrl_ctx =3D cdnsp_get_input_control_ctx(&pdev->in_ctx);
> +
> +	if (!slot_ctx->dev_info || dev_state =3D=3D SLOT_STATE_DEFAULT) {
> +		ret =3D cdnsp_setup_addressable_priv_dev(pdev);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	cdnsp_copy_ep0_dequeue_into_input_ctx(pdev);
> +
> +	ctrl_ctx->add_flags =3D cpu_to_le32(SLOT_FLAG | EP0_FLAG);
> +	ctrl_ctx->drop_flags =3D 0;
> +
> +	cdnsp_queue_address_device(pdev, pdev->in_ctx.dma, setup);
> +	cdnsp_ring_cmd_db(pdev);
> +	ret =3D cdnsp_wait_for_cmd_compl(pdev);
> +
> +	/* Zero the input context control for later use. */
> +	ctrl_ctx->add_flags =3D 0;
> +	ctrl_ctx->drop_flags =3D 0;
> +
> +	return ret;
> +}
> +
> +void cdnsp_set_usb2_hardware_lpm(struct cdnsp_device *pdev,
> +				 struct usb_request *req,
> +				 int enable)
> +{
> +	if (pdev->active_port !=3D &pdev->usb2_port || !pdev->gadget.lpm_capabl=
e)
> +		return;
> +
> +	if (enable)
> +		writel(PORT_BESL(CDNSP_DEFAULT_BESL) | PORT_L1S_NYET | PORT_HLE,
> +		       &pdev->active_port->regs->portpmsc);
> +	else
> +		writel(PORT_L1S_NYET, &pdev->active_port->regs->portpmsc);
> +}
> +
> +static int cdnsp_get_frame(struct cdnsp_device *pdev)
> +{
> +	return readl(&pdev->run_regs->microframe_index) >> 3;
> +}
> +
> +static int cdnsp_gadget_ep_enable(struct usb_ep *ep,
> +				  const struct usb_endpoint_descriptor *desc)
> +{
> +	struct cdnsp_input_control_ctx *ctrl_ctx;
> +	struct cdnsp_device *pdev;
> +	struct cdnsp_ep *pep;
> +	unsigned long flags;
> +	u32 added_ctxs;
> +	int ret;
> +
> +	if (!ep || !desc || desc->bDescriptorType !=3D USB_DT_ENDPOINT ||
> +	    !desc->wMaxPacketSize)
> +		return -EINVAL;
> +
> +	pep =3D to_cdnsp_ep(ep);
> +	pdev =3D pep->pdev;
> +
> +	if (dev_WARN_ONCE(pdev->dev, pep->ep_state & EP_ENABLED,
> +			  "%s is already enabled\n", pep->name))
> +		return 0;
> +
> +	spin_lock_irqsave(&pdev->lock, flags);
> +
> +	added_ctxs =3D cdnsp_get_endpoint_flag(desc);
> +	if (added_ctxs =3D=3D SLOT_FLAG || added_ctxs =3D=3D EP0_FLAG) {
> +		dev_err(pdev->dev, "ERROR: Bad endpoint number\n");
> +		ret =3D -EINVAL;
> +		goto unlock;
> +	}
> +
> +	pep->interval =3D desc->bInterval ? BIT(desc->bInterval - 1) : 0;
> +
> +	if (pdev->gadget.speed =3D=3D USB_SPEED_FULL) {
> +		if (usb_endpoint_type(desc) =3D=3D USB_ENDPOINT_XFER_INT)
> +			pep->interval =3D desc->bInterval << 3;
> +		if (usb_endpoint_type(desc) =3D=3D USB_ENDPOINT_XFER_ISOC)
> +			pep->interval =3D BIT(desc->bInterval - 1) << 3;
> +	}
> +
> +	if (usb_endpoint_type(desc) =3D=3D USB_ENDPOINT_XFER_ISOC) {
> +		if (pep->interval > BIT(12)) {
> +			dev_err(pdev->dev, "bInterval %d not supported\n",
> +				desc->bInterval);
> +			ret =3D -EINVAL;
> +			goto unlock;
> +		}
> +		cdnsp_set_chicken_bits_2(pdev, CHICKEN_XDMA_2_TP_CACHE_DIS);
> +	}
> +
> +	ret =3D cdnsp_endpoint_init(pdev, pep, GFP_ATOMIC);
> +	if (ret)
> +		goto unlock;
> +
> +	ctrl_ctx =3D cdnsp_get_input_control_ctx(&pdev->in_ctx);
> +	ctrl_ctx->add_flags =3D cpu_to_le32(added_ctxs);
> +	ctrl_ctx->drop_flags =3D 0;
> +
> +	ret =3D cdnsp_update_eps_configuration(pdev, pep);
> +	if (ret) {
> +		cdnsp_free_endpoint_rings(pdev, pep);
> +		goto unlock;
> +	}
> +
> +	pep->ep_state |=3D EP_ENABLED;
> +	pep->ep_state &=3D ~EP_STOPPED;
> +
> +unlock:
> +	spin_unlock_irqrestore(&pdev->lock, flags);
> +
> +	return ret;
> +}
> +
> +static int cdnsp_gadget_ep_disable(struct usb_ep *ep)
> +{
> +	struct cdnsp_input_control_ctx *ctrl_ctx;
> +	struct cdnsp_request *preq;
> +	struct cdnsp_device *pdev;
> +	struct cdnsp_ep *pep;
> +	unsigned long flags;
> +	u32 drop_flag;
> +	int ret =3D 0;
> +
> +	if (!ep)
> +		return -EINVAL;
> +
> +	pep =3D to_cdnsp_ep(ep);
> +	pdev =3D pep->pdev;
> +
> +	spin_lock_irqsave(&pdev->lock, flags);
> +
> +	if (!(pep->ep_state & EP_ENABLED)) {
> +		dev_err(pdev->dev, "%s is already disabled\n", pep->name);
> +		ret =3D -EINVAL;
> +		goto finish;
> +	}
> +
> +	cdnsp_cmd_stop_ep(pdev, pep);
> +	pep->ep_state |=3D EP_DIS_IN_RROGRESS;
> +	cdnsp_cmd_flush_ep(pdev, pep);
> +
> +	/* Remove all queued USB requests. */
> +	while (!list_empty(&pep->pending_list)) {
> +		preq =3D next_request(&pep->pending_list);
> +		cdnsp_ep_dequeue(pep, preq);
> +	}
> +
> +	cdnsp_invalidate_ep_events(pdev, pep);
> +
> +	pep->ep_state &=3D ~EP_DIS_IN_RROGRESS;
> +	drop_flag =3D cdnsp_get_endpoint_flag(pep->endpoint.desc);
> +	ctrl_ctx =3D cdnsp_get_input_control_ctx(&pdev->in_ctx);
> +	ctrl_ctx->drop_flags =3D cpu_to_le32(drop_flag);
> +	ctrl_ctx->add_flags =3D 0;
> +
> +	cdnsp_endpoint_zero(pdev, pep);
> +
> +	ret =3D cdnsp_update_eps_configuration(pdev, pep);
> +	cdnsp_free_endpoint_rings(pdev, pep);
> +
> +	pep->ep_state &=3D ~EP_ENABLED;
> +	pep->ep_state |=3D EP_STOPPED;
> +
> +finish:
> +	spin_unlock_irqrestore(&pdev->lock, flags);
> +
> +	return ret;
> +}
> +
> +static struct usb_request *cdnsp_gadget_ep_alloc_request(struct usb_ep *=
ep,
> +							 gfp_t gfp_flags)
> +{
> +	struct cdnsp_ep *pep =3D to_cdnsp_ep(ep);
> +	struct cdnsp_request *preq;
> +
> +	preq =3D kzalloc(sizeof(*preq), gfp_flags);
> +	if (!preq)
> +		return NULL;
> +
> +	preq->epnum =3D pep->number;
> +	preq->pep =3D pep;
> +
> +	return &preq->request;
> +}
> +
> +static void cdnsp_gadget_ep_free_request(struct usb_ep *ep,
> +					 struct usb_request *request)
> +{
> +	struct cdnsp_request *preq =3D to_cdnsp_request(request);
> +
> +	kfree(preq);
> +}
> +
> +static int cdnsp_gadget_ep_queue(struct usb_ep *ep,
> +				 struct usb_request *request,
> +				 gfp_t gfp_flags)
> +{
> +	struct cdnsp_request *preq;
> +	struct cdnsp_device *pdev;
> +	struct cdnsp_ep *pep;
> +	unsigned long flags;
> +	int ret;
> +
> +	if (!request || !ep)
> +		return -EINVAL;
> +
> +	pep =3D to_cdnsp_ep(ep);
> +	pdev =3D pep->pdev;
> +
> +	if (!(pep->ep_state & EP_ENABLED)) {
> +		dev_err(pdev->dev, "%s: can't queue to disabled endpoint\n",
> +			pep->name);
> +		return -EINVAL;
> +	}
> +
> +	preq =3D to_cdnsp_request(request);
> +	spin_lock_irqsave(&pdev->lock, flags);
> +	ret =3D cdnsp_ep_enqueue(pep, preq);
> +	spin_unlock_irqrestore(&pdev->lock, flags);
> +
> +	return ret;
> +}
> +
> +static int cdnsp_gadget_ep_dequeue(struct usb_ep *ep,
> +				   struct usb_request *request)
> +{
> +	struct cdnsp_ep *pep =3D to_cdnsp_ep(ep);
> +	struct cdnsp_device *pdev =3D pep->pdev;
> +	unsigned long flags;
> +	int ret;
> +
> +	if (!pep->endpoint.desc) {
> +		dev_err(pdev->dev,
> +			"%s: can't dequeue to disabled endpoint\n",
> +			pep->name);
> +		return -ESHUTDOWN;
> +	}
> +
> +	spin_lock_irqsave(&pdev->lock, flags);
> +	ret =3D cdnsp_ep_dequeue(pep, to_cdnsp_request(request));
> +	spin_unlock_irqrestore(&pdev->lock, flags);
> +
> +	return ret;
> +}
> +
> +static int cdnsp_gadget_ep_set_halt(struct usb_ep *ep, int value)
> +{
> +	struct cdnsp_ep *pep =3D to_cdnsp_ep(ep);
> +	struct cdnsp_device *pdev =3D pep->pdev;
> +	struct cdnsp_request *preq;
> +	unsigned long flags =3D 0;
> +	int ret;
> +
> +	spin_lock_irqsave(&pdev->lock, flags);
> +
> +	preq =3D next_request(&pep->pending_list);
> +	if (value) {
> +		if (preq) {
> +			ret =3D -EAGAIN;
> +			goto done;
> +		}
> +	}
> +
> +	ret =3D cdnsp_halt_endpoint(pdev, pep, value);
> +
> +done:
> +	spin_unlock_irqrestore(&pdev->lock, flags);
> +	return ret;
> +}
> +
> +static int cdnsp_gadget_ep_set_wedge(struct usb_ep *ep)
> +{
> +	struct cdnsp_ep *pep =3D to_cdnsp_ep(ep);
> +	struct cdnsp_device *pdev =3D pep->pdev;
> +	unsigned long flags =3D 0;
> +	int ret;
> +
> +	spin_lock_irqsave(&pdev->lock, flags);
> +	pep->ep_state |=3D EP_WEDGE;
> +	ret =3D cdnsp_halt_endpoint(pdev, pep, 1);
> +	spin_unlock_irqrestore(&pdev->lock, flags);
> +
> +	return ret;
> +}
> +
> +static const struct usb_ep_ops cdnsp_gadget_ep0_ops =3D {
> +	.enable		=3D cdnsp_gadget_ep_enable,
> +	.disable	=3D cdnsp_gadget_ep_disable,
> +	.alloc_request	=3D cdnsp_gadget_ep_alloc_request,
> +	.free_request	=3D cdnsp_gadget_ep_free_request,
> +	.queue		=3D cdnsp_gadget_ep_queue,
> +	.dequeue	=3D cdnsp_gadget_ep_dequeue,
> +	.set_halt	=3D cdnsp_gadget_ep_set_halt,
> +	.set_wedge	=3D cdnsp_gadget_ep_set_wedge,
> +};
> +
> +static const struct usb_ep_ops cdnsp_gadget_ep_ops =3D {
> +	.enable		=3D cdnsp_gadget_ep_enable,
> +	.disable	=3D cdnsp_gadget_ep_disable,
> +	.alloc_request	=3D cdnsp_gadget_ep_alloc_request,
> +	.free_request	=3D cdnsp_gadget_ep_free_request,
> +	.queue		=3D cdnsp_gadget_ep_queue,
> +	.dequeue	=3D cdnsp_gadget_ep_dequeue,
> +	.set_halt	=3D cdnsp_gadget_ep_set_halt,
> +	.set_wedge	=3D cdnsp_gadget_ep_set_wedge,
> +};
> +
> +void cdnsp_gadget_giveback(struct cdnsp_ep *pep,
> +			   struct cdnsp_request *preq,
> +			   int status)
> +{
> +	struct cdnsp_device *pdev =3D pep->pdev;
> +
> +	list_del(&preq->list);
> +
> +	if (preq->request.status =3D=3D -EINPROGRESS)
> +		preq->request.status =3D status;
> +
> +	usb_gadget_unmap_request_by_dev(pdev->dev, &preq->request,
> +					preq->direction);
> +
> +	if (preq !=3D &pdev->ep0_preq) {
> +		spin_unlock(&pdev->lock);
> +		usb_gadget_giveback_request(&pep->endpoint, &preq->request);
> +		spin_lock(&pdev->lock);
> +	}
> +}
> +
> +static struct usb_endpoint_descriptor cdnsp_gadget_ep0_desc =3D {
> +	.bLength =3D		USB_DT_ENDPOINT_SIZE,
> +	.bDescriptorType =3D	USB_DT_ENDPOINT,
> +	.bmAttributes =3D		USB_ENDPOINT_XFER_CONTROL,
> +};
> +
> +static int cdnsp_run(struct cdnsp_device *pdev,
> +		     enum usb_device_speed speed)
> +{
> +	u32 fs_speed =3D 0;
> +	u64 temp_64;
> +	u32 temp;
> +	int ret;
> +
> +	temp_64 =3D cdnsp_read_64(pdev, &pdev->ir_set->erst_dequeue);
> +	temp_64 &=3D ~ERST_PTR_MASK;
> +	temp =3D readl(&pdev->ir_set->irq_control);
> +	temp &=3D ~IMOD_INTERVAL_MASK;
> +	temp |=3D ((IMOD_DEFAULT_INTERVAL / 250) & IMOD_INTERVAL_MASK);
> +	writel(temp, &pdev->ir_set->irq_control);
> +
> +	temp =3D readl(&pdev->port3x_regs->mode_addr);
> +
> +	switch (speed) {
> +	case USB_SPEED_SUPER_PLUS:
> +		temp |=3D CFG_3XPORT_SSP_SUPPORT;
> +		break;
> +	case USB_SPEED_SUPER:
> +		temp &=3D ~CFG_3XPORT_SSP_SUPPORT;
> +		break;
> +	case USB_SPEED_HIGH:
> +		break;
> +	case USB_SPEED_FULL:
> +		fs_speed =3D PORT_REG6_FORCE_FS;
> +		break;
> +	default:
> +		dev_err(pdev->dev, "invalid maximum_speed parameter %d\n",
> +			speed);
> +		fallthrough;
> +	case USB_SPEED_UNKNOWN:
> +		/* Default to superspeed. */
> +		speed =3D USB_SPEED_SUPER;
> +		break;
> +	}
> +
> +	if (speed >=3D USB_SPEED_SUPER) {
> +		writel(temp, &pdev->port3x_regs->mode_addr);
> +		cdnsp_set_link_state(pdev, &pdev->usb3_port.regs->portsc,
> +				     XDEV_RXDETECT);
> +	} else {
> +		cdnsp_disable_port(pdev, &pdev->usb3_port.regs->portsc);
> +	}
> +
> +	cdnsp_set_link_state(pdev, &pdev->usb2_port.regs->portsc,
> +			     XDEV_RXDETECT);
> +
> +	cdnsp_gadget_ep0_desc.wMaxPacketSize =3D cpu_to_le16(512);
> +
> +	writel(PORT_REG6_L1_L0_HW_EN | fs_speed, &pdev->port20_regs->port_reg6)=
;
> +
> +	ret =3D cdnsp_start(pdev);
> +	if (ret) {
> +		ret =3D -ENODEV;
> +		goto err;
> +	}
> +
> +	temp =3D readl(&pdev->op_regs->command);
> +	temp |=3D (CMD_INTE);
> +	writel(temp, &pdev->op_regs->command);
> +
> +	temp =3D readl(&pdev->ir_set->irq_pending);
> +	writel(IMAN_IE_SET(temp), &pdev->ir_set->irq_pending);
> +
> +	return 0;
> +err:
> +	cdnsp_halt(pdev);
> +	return ret;
> +}
> +
> +static int cdnsp_gadget_udc_start(struct usb_gadget *g,
> +				  struct usb_gadget_driver *driver)
> +{
> +	enum usb_device_speed max_speed =3D driver->max_speed;
> +	struct cdnsp_device *pdev =3D gadget_to_cdnsp(g);
> +	unsigned long flags;
> +	int ret;
> +
> +	spin_lock_irqsave(&pdev->lock, flags);
> +	pdev->gadget_driver =3D driver;
> +
> +	/* limit speed if necessary */
> +	max_speed =3D min(driver->max_speed, g->max_speed);
> +	ret =3D cdnsp_run(pdev, max_speed);
> +
> +	spin_unlock_irqrestore(&pdev->lock, flags);
> +
> +	return ret;
> +}
> +
> +/*
> + * Update Event Ring Dequeue Pointer:
> + * - When all events have finished
> + * - To avoid "Event Ring Full Error" condition
> + */
> +void cdnsp_update_erst_dequeue(struct cdnsp_device *pdev,
> +			       union cdnsp_trb *event_ring_deq,
> +			       u8 clear_ehb)
> +{
> +	u64 temp_64;
> +	dma_addr_t deq;
> +
> +	temp_64 =3D cdnsp_read_64(pdev, &pdev->ir_set->erst_dequeue);
> +
> +	/* If necessary, update the HW's version of the event ring deq ptr. */
> +	if (event_ring_deq !=3D pdev->event_ring->dequeue) {
> +		deq =3D cdnsp_trb_virt_to_dma(pdev->event_ring->deq_seg,
> +					    pdev->event_ring->dequeue);
> +		temp_64 &=3D ERST_PTR_MASK;
> +		temp_64 |=3D ((u64)deq & (u64)~ERST_PTR_MASK);
> +	}
> +
> +	/* Clear the event handler busy flag (RW1C). */
> +	if (clear_ehb)
> +		temp_64 |=3D ERST_EHB;
> +	else
> +		temp_64 &=3D ~ERST_EHB;
> +
> +	cdnsp_write_64(pdev, temp_64, &pdev->ir_set->erst_dequeue);
> +}
> +
> +static void cdnsp_clear_cmd_ring(struct cdnsp_device *pdev)
> +{
> +	struct cdnsp_segment *seg;
> +	u64 val_64;
> +	int i;
> +
> +	cdnsp_initialize_ring_info(pdev->cmd_ring);
> +
> +	seg =3D pdev->cmd_ring->first_seg;
> +	for (i =3D 0; i < pdev->cmd_ring->num_segs; i++) {
> +		memset(seg->trbs, 0,
> +		       sizeof(union cdnsp_trb) * (TRBS_PER_SEGMENT - 1));
> +		seg =3D seg->next;
> +	}
> +
> +	/* Set the address in the Command Ring Control register. */
> +	val_64 =3D cdnsp_read_64(pdev, &pdev->op_regs->cmd_ring);
> +	val_64 =3D (val_64 & (u64)CMD_RING_RSVD_BITS) |
> +		 (pdev->cmd_ring->first_seg->dma & (u64)~CMD_RING_RSVD_BITS) |
> +		 pdev->cmd_ring->cycle_state;
> +	cdnsp_write_64(pdev, val_64, &pdev->op_regs->cmd_ring);
> +}
> +
> +static void cdnsp_consume_all_events(struct cdnsp_device *pdev)
> +{
> +	struct cdnsp_segment *event_deq_seg;
> +	union cdnsp_trb *event_ring_deq;
> +	union cdnsp_trb *event;
> +	u32 cycle_bit;
> +
> +	event_ring_deq =3D pdev->event_ring->dequeue;
> +	event_deq_seg =3D pdev->event_ring->deq_seg;
> +	event =3D pdev->event_ring->dequeue;
> +
> +	/* Update ring dequeue pointer. */
> +	while (1) {
> +		cycle_bit =3D (le32_to_cpu(event->event_cmd.flags) & TRB_CYCLE);
> +
> +		/* Does the controller or driver own the TRB? */
> +		if (cycle_bit !=3D pdev->event_ring->cycle_state)
> +			break;
> +
> +		cdnsp_inc_deq(pdev, pdev->event_ring);
> +
> +		if (!cdnsp_last_trb_on_seg(event_deq_seg, event)) {
> +			event++;
> +			continue;
> +		}
> +
> +		if (cdnsp_last_trb_on_ring(pdev->event_ring, event_deq_seg,
> +					   event))
> +			cycle_bit ^=3D 1;
> +
> +		event_deq_seg =3D event_deq_seg->next;
> +		event =3D event_deq_seg->trbs;
> +	}
> +
> +	cdnsp_update_erst_dequeue(pdev,  event_ring_deq, 1);
> +}
> +
> +static void cdnsp_stop(struct cdnsp_device *pdev)
> +{
> +	u32 temp;
> +
> +	cdnsp_cmd_flush_ep(pdev, &pdev->eps[0]);
> +
> +	/* Remove internally queued request for ep0. */
> +	if (!list_empty(&pdev->eps[0].pending_list)) {
> +		struct cdnsp_request *req;
> +
> +		req =3D next_request(&pdev->eps[0].pending_list);
> +		if (req =3D=3D &pdev->ep0_preq)
> +			cdnsp_ep_dequeue(&pdev->eps[0], req);
> +	}
> +
> +	cdnsp_disable_port(pdev, &pdev->usb2_port.regs->portsc);
> +	cdnsp_disable_port(pdev, &pdev->usb3_port.regs->portsc);
> +	cdnsp_disable_slot(pdev);
> +	cdnsp_halt(pdev);
> +
> +	temp =3D readl(&pdev->op_regs->status);
> +	writel((temp & ~0x1fff) | STS_EINT, &pdev->op_regs->status);
> +	temp =3D readl(&pdev->ir_set->irq_pending);
> +	writel(IMAN_IE_CLEAR(temp), &pdev->ir_set->irq_pending);
> +
> +	cdnsp_clear_port_change_bit(pdev, &pdev->usb2_port.regs->portsc);
> +	cdnsp_clear_port_change_bit(pdev, &pdev->usb3_port.regs->portsc);
> +
> +	/*Clear interrupt line */
> +	temp =3D readl(&pdev->ir_set->irq_pending);
> +	temp |=3D IMAN_IP;
> +	writel(temp, &pdev->ir_set->irq_pending);
> +
> +	cdnsp_consume_all_events(pdev);
> +	cdnsp_clear_cmd_ring(pdev);
> +}
> +
> +/*
> + * Stop controller.
> + * This function is called by the gadget core when the driver is removed=
.
> + * Disable slot, disable IRQs, and quiesce the controller.
> + */
> +static int cdnsp_gadget_udc_stop(struct usb_gadget *g)
> +{
> +	struct cdnsp_device *pdev =3D gadget_to_cdnsp(g);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&pdev->lock, flags);
> +	cdnsp_stop(pdev);
> +	pdev->gadget_driver =3D NULL;
> +	spin_unlock_irqrestore(&pdev->lock, flags);
> +
> +	return 0;
> +}
> +
> +static int cdnsp_gadget_get_frame(struct usb_gadget *g)
> +{
> +	struct cdnsp_device *pdev =3D gadget_to_cdnsp(g);
> +
> +	return cdnsp_get_frame(pdev);
> +}
> +
> +static void __cdnsp_gadget_wakeup(struct cdnsp_device *pdev)
> +{
> +	struct cdnsp_port_regs __iomem *port_regs;
> +	u32 portpm, portsc;
> +
> +	port_regs =3D pdev->active_port->regs;
> +	portsc =3D readl(&port_regs->portsc) & PORT_PLS_MASK;
> +
> +	/* Remote wakeup feature is not enabled by host. */
> +	if (pdev->gadget.speed < USB_SPEED_SUPER && portsc =3D=3D XDEV_U2) {
> +		portpm =3D readl(&port_regs->portpmsc);
> +
> +		if (!(portpm & PORT_RWE))
> +			return;
> +	}
> +
> +	if (portsc =3D=3D XDEV_U3 && !pdev->may_wakeup)
> +		return;
> +
> +	cdnsp_set_link_state(pdev, &port_regs->portsc, XDEV_U0);
> +
> +	pdev->cdnsp_state |=3D CDNSP_WAKEUP_PENDING;
> +}
> +
> +static int cdnsp_gadget_wakeup(struct usb_gadget *g)
> +{
> +	struct cdnsp_device *pdev =3D gadget_to_cdnsp(g);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&pdev->lock, flags);
> +	__cdnsp_gadget_wakeup(pdev);
> +	spin_unlock_irqrestore(&pdev->lock, flags);
> +
> +	return 0;
> +}
> +
> +static int cdnsp_gadget_set_selfpowered(struct usb_gadget *g,
> +					int is_selfpowered)
> +{
> +	struct cdnsp_device *pdev =3D gadget_to_cdnsp(g);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&pdev->lock, flags);
> +	g->is_selfpowered =3D !!is_selfpowered;
> +	spin_unlock_irqrestore(&pdev->lock, flags);
> +
> +	return 0;
> +}
> +
> +static int cdnsp_gadget_pullup(struct usb_gadget *gadget, int is_on)
> +{
> +	struct cdnsp_device *pdev =3D gadget_to_cdnsp(gadget);
> +	struct cdns *cdns =3D dev_get_drvdata(pdev->dev);
> +
> +	if (!is_on) {
> +		cdnsp_reset_device(pdev);
> +		cdns_clear_vbus(cdns);
> +	} else {
> +		cdns_set_vbus(cdns);
> +	}
> +	return 0;
> +}
> +
> +const struct usb_gadget_ops cdnsp_gadget_ops =3D {
> +	.get_frame		=3D cdnsp_gadget_get_frame,
> +	.wakeup			=3D cdnsp_gadget_wakeup,
> +	.set_selfpowered	=3D cdnsp_gadget_set_selfpowered,
> +	.pullup			=3D cdnsp_gadget_pullup,
> +	.udc_start		=3D cdnsp_gadget_udc_start,
> +	.udc_stop		=3D cdnsp_gadget_udc_stop,
> +};
> +
> +static void cdnsp_get_ep_buffering(struct cdnsp_device *pdev,
> +				   struct cdnsp_ep *pep)
> +{
> +	void __iomem *reg =3D &pdev->cap_regs->hc_capbase;
> +	int endpoints;
> +
> +	reg +=3D cdnsp_find_next_ext_cap(reg, 0, XBUF_CAP_ID);
> +
> +	if (!pep->direction) {
> +		pep->buffering =3D readl(reg + XBUF_RX_TAG_MASK_0_OFFSET);
> +		pep->buffering_period =3D readl(reg + XBUF_RX_TAG_MASK_1_OFFSET);
> +		pep->buffering =3D (pep->buffering + 1) / 2;
> +		pep->buffering_period =3D (pep->buffering_period + 1) / 2;
> +		return;
> +	}
> +
> +	endpoints =3D HCS_ENDPOINTS(readl(&pdev->hcs_params1)) / 2;
> +
> +	/* Set to XBUF_TX_TAG_MASK_0 register. */
> +	reg +=3D XBUF_TX_CMD_OFFSET + (endpoints * 2 + 2) * sizeof(u32);
> +	/* Set reg to XBUF_TX_TAG_MASK_N related with this endpoint. */
> +	reg +=3D pep->number * sizeof(u32) * 2;
> +
> +	pep->buffering =3D (readl(reg) + 1) / 2;
> +	pep->buffering_period =3D pep->buffering;
> +}
> +
> +static int cdnsp_gadget_init_endpoints(struct cdnsp_device *pdev)
> +{
> +	int max_streams =3D HCC_MAX_PSA(pdev->hcc_params);
> +	struct cdnsp_ep *pep;
> +	int i;
> +
> +	INIT_LIST_HEAD(&pdev->gadget.ep_list);
> +
> +	if (max_streams < STREAM_LOG_STREAMS) {
> +		dev_err(pdev->dev, "Stream size %d not supported\n",
> +			max_streams);
> +		return -EINVAL;
> +	}
> +
> +	max_streams =3D STREAM_LOG_STREAMS;
> +
> +	for (i =3D 0; i < CDNSP_ENDPOINTS_NUM; i++) {
> +		bool direction =3D !(i & 1); /* Start from OUT endpoint. */
> +		u8 epnum =3D ((i + 1) >> 1);
> +
> +		if (!CDNSP_IF_EP_EXIST(pdev, epnum, direction))
> +			continue;
> +
> +		pep =3D &pdev->eps[i];
> +		pep->pdev =3D pdev;
> +		pep->number =3D epnum;
> +		pep->direction =3D direction; /* 0 for OUT, 1 for IN. */
> +
> +		/*
> +		 * Ep0 is bidirectional, so ep0in and ep0out are represented by
> +		 * pdev->eps[0]
> +		 */
> +		if (epnum =3D=3D 0) {
> +			snprintf(pep->name, sizeof(pep->name), "ep%d%s",
> +				 epnum, "BiDir");
> +
> +			pep->idx =3D 0;
> +			usb_ep_set_maxpacket_limit(&pep->endpoint, 512);
> +			pep->endpoint.maxburst =3D 1;
> +			pep->endpoint.ops =3D &cdnsp_gadget_ep0_ops;
> +			pep->endpoint.desc =3D &cdnsp_gadget_ep0_desc;
> +			pep->endpoint.comp_desc =3D NULL;
> +			pep->endpoint.caps.type_control =3D true;
> +			pep->endpoint.caps.dir_in =3D true;
> +			pep->endpoint.caps.dir_out =3D true;
> +
> +			pdev->ep0_preq.epnum =3D pep->number;
> +			pdev->ep0_preq.pep =3D pep;
> +			pdev->gadget.ep0 =3D &pep->endpoint;
> +		} else {
> +			snprintf(pep->name, sizeof(pep->name), "ep%d%s",
> +				 epnum, (pep->direction) ? "in"  : "out");
> +
> +			pep->idx =3D  (epnum * 2 + (direction ? 1 : 0)) - 1;
> +			usb_ep_set_maxpacket_limit(&pep->endpoint, 1024);
> +
> +			pep->endpoint.max_streams =3D max_streams;
> +			pep->endpoint.ops =3D &cdnsp_gadget_ep_ops;
> +			list_add_tail(&pep->endpoint.ep_list,
> +				      &pdev->gadget.ep_list);
> +
> +			pep->endpoint.caps.type_iso =3D true;
> +			pep->endpoint.caps.type_bulk =3D true;
> +			pep->endpoint.caps.type_int =3D true;
> +
> +			pep->endpoint.caps.dir_in =3D direction;
> +			pep->endpoint.caps.dir_out =3D !direction;
> +		}
> +
> +		pep->endpoint.name =3D pep->name;
> +		pep->in_ctx =3D cdnsp_get_ep_ctx(&pdev->in_ctx, pep->idx);
> +		pep->out_ctx =3D cdnsp_get_ep_ctx(&pdev->out_ctx, pep->idx);
> +		cdnsp_get_ep_buffering(pdev, pep);
> +
> +		dev_dbg(pdev->dev, "Init %s, MPS: %04x SupType: "
> +			"CTRL: %s, INT: %s, BULK: %s, ISOC %s, "
> +			"SupDir IN: %s, OUT: %s\n",
> +			pep->name, 1024,
> +			(pep->endpoint.caps.type_control) ? "yes" : "no",
> +			(pep->endpoint.caps.type_int) ? "yes" : "no",
> +			(pep->endpoint.caps.type_bulk) ? "yes" : "no",
> +			(pep->endpoint.caps.type_iso) ? "yes" : "no",
> +			(pep->endpoint.caps.dir_in) ? "yes" : "no",
> +			(pep->endpoint.caps.dir_out) ? "yes" : "no");
> +
> +		INIT_LIST_HEAD(&pep->pending_list);
> +	}
> +
> +	return 0;
> +}
> +
> +static void cdnsp_gadget_free_endpoints(struct cdnsp_device *pdev)
> +{
> +	struct cdnsp_ep *pep;
> +	int i;
> +
> +	for (i =3D 0; i < CDNSP_ENDPOINTS_NUM; i++) {
> +		pep =3D &pdev->eps[i];
> +		if (pep->number !=3D 0 && pep->out_ctx)
> +			list_del(&pep->endpoint.ep_list);
> +	}
> +}
> +
> +void cdnsp_disconnect_gadget(struct cdnsp_device *pdev)
> +{
> +	pdev->cdnsp_state |=3D CDNSP_STATE_DISCONNECT_PENDING;
> +
> +	if (pdev->gadget_driver && pdev->gadget_driver->disconnect) {
> +		spin_unlock(&pdev->lock);
> +		pdev->gadget_driver->disconnect(&pdev->gadget);
> +		spin_lock(&pdev->lock);
> +	}
> +
> +	pdev->gadget.speed =3D USB_SPEED_UNKNOWN;
> +	usb_gadget_set_state(&pdev->gadget, USB_STATE_NOTATTACHED);
> +
> +	pdev->cdnsp_state &=3D ~CDNSP_STATE_DISCONNECT_PENDING;
> +}
> +
> +void cdnsp_suspend_gadget(struct cdnsp_device *pdev)
> +{
> +	if (pdev->gadget_driver && pdev->gadget_driver->suspend) {
> +		spin_unlock(&pdev->lock);
> +		pdev->gadget_driver->suspend(&pdev->gadget);
> +		spin_lock(&pdev->lock);
> +	}
> +}
> +
> +void cdnsp_resume_gadget(struct cdnsp_device *pdev)
> +{
> +	if (pdev->gadget_driver && pdev->gadget_driver->resume) {
> +		spin_unlock(&pdev->lock);
> +		pdev->gadget_driver->resume(&pdev->gadget);
> +		spin_lock(&pdev->lock);
> +	}
> +}
> +
> +void cdnsp_irq_reset(struct cdnsp_device *pdev)
> +{
> +	struct cdnsp_port_regs __iomem *port_regs;
> +
> +	cdnsp_reset_device(pdev);
> +
> +	port_regs =3D pdev->active_port->regs;
> +	pdev->gadget.speed =3D cdnsp_port_speed(readl(port_regs));
> +
> +	spin_unlock(&pdev->lock);
> +	usb_gadget_udc_reset(&pdev->gadget, pdev->gadget_driver);
> +	spin_lock(&pdev->lock);
> +
> +	switch (pdev->gadget.speed) {
> +	case USB_SPEED_SUPER_PLUS:
> +	case USB_SPEED_SUPER:
> +		cdnsp_gadget_ep0_desc.wMaxPacketSize =3D cpu_to_le16(512);
> +		pdev->gadget.ep0->maxpacket =3D 512;
> +		break;
> +	case USB_SPEED_HIGH:
> +	case USB_SPEED_FULL:
> +		cdnsp_gadget_ep0_desc.wMaxPacketSize =3D cpu_to_le16(64);
> +		pdev->gadget.ep0->maxpacket =3D 64;
> +		break;
> +	default:
> +		/* Low speed is not supported. */
> +		dev_err(pdev->dev, "Unknown device speed\n");
> +		break;
> +	}
> +
> +	cdnsp_clear_chicken_bits_2(pdev, CHICKEN_XDMA_2_TP_CACHE_DIS);
> +	cdnsp_setup_device(pdev, SETUP_CONTEXT_ONLY);
> +	usb_gadget_set_state(&pdev->gadget, USB_STATE_DEFAULT);
> +}
> +
> +static void cdnsp_get_rev_cap(struct cdnsp_device *pdev)
> +{
> +	void __iomem *reg =3D &pdev->cap_regs->hc_capbase;
> +	struct cdnsp_rev_cap *rev_cap;
> +
> +	reg +=3D cdnsp_find_next_ext_cap(reg, 0, RTL_REV_CAP);
> +	rev_cap =3D reg;
> +
> +	pdev->rev_cap.ctrl_revision =3D readl(&rev_cap->ctrl_revision);
> +	pdev->rev_cap.rtl_revision =3D readl(&rev_cap->rtl_revision);
> +	pdev->rev_cap.ep_supported =3D readl(&rev_cap->ep_supported);
> +	pdev->rev_cap.ext_cap =3D readl(&rev_cap->ext_cap);
> +	pdev->rev_cap.rx_buff_size =3D readl(&rev_cap->rx_buff_size);
> +	pdev->rev_cap.tx_buff_size =3D readl(&rev_cap->tx_buff_size);
> +
> +	dev_info(pdev->dev, "Rev: %08x/%08x, eps: %08x, buff: %08x/%08x\n",
> +		 pdev->rev_cap.ctrl_revision, pdev->rev_cap.rtl_revision,
> +		 pdev->rev_cap.ep_supported, pdev->rev_cap.rx_buff_size,
> +		 pdev->rev_cap.tx_buff_size);
> +}
> +
> +static int cdnsp_gen_setup(struct cdnsp_device *pdev)
> +{
> +	int ret;
> +
> +	pdev->cap_regs =3D pdev->regs;
> +	pdev->op_regs =3D pdev->regs +
> +		HC_LENGTH(readl(&pdev->cap_regs->hc_capbase));
> +	pdev->run_regs =3D pdev->regs +
> +		(readl(&pdev->cap_regs->run_regs_off) & RTSOFF_MASK);
> +
> +	/* Cache read-only capability registers */
> +	pdev->hcs_params1 =3D readl(&pdev->cap_regs->hcs_params1);
> +	pdev->hcc_params =3D readl(&pdev->cap_regs->hc_capbase);
> +	pdev->hci_version =3D HC_VERSION(pdev->hcc_params);
> +	pdev->hcc_params =3D readl(&pdev->cap_regs->hcc_params);
> +
> +	cdnsp_get_rev_cap(pdev);
> +
> +	/* Make sure the Device Controller is halted. */
> +	ret =3D cdnsp_halt(pdev);
> +	if (ret)
> +		return ret;
> +
> +	/* Reset the internal controller memory state and registers. */
> +	ret =3D cdnsp_reset(pdev);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Set dma_mask and coherent_dma_mask to 64-bits,
> +	 * if controller supports 64-bit addressing.
> +	 */
> +	if (HCC_64BIT_ADDR(pdev->hcc_params) &&
> +	    !dma_set_mask(pdev->dev, DMA_BIT_MASK(64))) {
> +		dev_dbg(pdev->dev, "Enabling 64-bit DMA addresses.\n");
> +		dma_set_coherent_mask(pdev->dev, DMA_BIT_MASK(64));
> +	} else {
> +		/*
> +		 * This is to avoid error in cases where a 32-bit USB
> +		 * controller is used on a 64-bit capable system.
> +		 */
> +		ret =3D dma_set_mask(pdev->dev, DMA_BIT_MASK(32));
> +		if (ret)
> +			return ret;
> +		dev_dbg(pdev->dev, "Enabling 32-bit DMA addresses.\n");
> +		dma_set_coherent_mask(pdev->dev, DMA_BIT_MASK(32));
> +	}
> +
> +	spin_lock_init(&pdev->lock);
> +
> +	ret =3D cdnsp_mem_init(pdev, GFP_KERNEL);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int __cdnsp_gadget_init(struct cdns *cdns)
> +{
> +	struct cdnsp_device *pdev;
> +	u32 max_speed;
> +	int ret =3D -ENOMEM;
> +
> +	cdns_drd_gadget_on(cdns);
> +
> +	pdev =3D kzalloc(sizeof(*pdev), GFP_KERNEL);
> +	if (!pdev)
> +		return -ENOMEM;
> +
> +	pm_runtime_get_sync(cdns->dev);
> +
> +	cdns->gadget_dev =3D pdev;
> +	pdev->dev =3D cdns->dev;
> +	pdev->regs =3D cdns->dev_regs;
> +	max_speed =3D usb_get_maximum_speed(cdns->dev);
> +
> +	switch (max_speed) {
> +	case USB_SPEED_FULL:
> +	case USB_SPEED_HIGH:
> +	case USB_SPEED_SUPER:
> +	case USB_SPEED_SUPER_PLUS:
> +		break;
> +	default:
> +		dev_err(cdns->dev, "invalid speed parameter %d\n", max_speed);
> +		fallthrough;
> +	case USB_SPEED_UNKNOWN:
> +		/* Default to SSP */
> +		max_speed =3D USB_SPEED_SUPER_PLUS;
> +		break;
> +	}
> +
> +	pdev->gadget.ops =3D &cdnsp_gadget_ops;
> +	pdev->gadget.name =3D "cdnsp-gadget";
> +	pdev->gadget.speed =3D USB_SPEED_UNKNOWN;
> +	pdev->gadget.sg_supported =3D 1;
> +	pdev->gadget.max_speed =3D USB_SPEED_SUPER_PLUS;
> +	pdev->gadget.lpm_capable =3D 1;
> +
> +	pdev->setup_buf =3D kzalloc(CDNSP_EP0_SETUP_SIZE, GFP_KERNEL);
> +	if (!pdev->setup_buf)
> +		goto free_pdev;
> +
> +	/*
> +	 * Controller supports not aligned buffer but it should improve
> +	 * performance.
> +	 */
> +	pdev->gadget.quirk_ep_out_aligned_size =3D true;
> +
> +	ret =3D cdnsp_gen_setup(pdev);
> +	if (ret) {
> +		dev_err(pdev->dev, "Generic initialization failed %d\n", ret);
> +		goto free_setup;
> +	}
> +
> +	ret =3D cdnsp_gadget_init_endpoints(pdev);
> +	if (ret) {
> +		dev_err(pdev->dev, "failed to initialize endpoints\n");
> +		goto halt_pdev;
> +	}
> +
> +	ret =3D usb_add_gadget_udc(pdev->dev, &pdev->gadget);
> +	if (ret) {
> +		dev_err(pdev->dev, "failed to register udc\n");
> +		goto free_endpoints;
> +	}
> +
> +	ret =3D devm_request_threaded_irq(pdev->dev, cdns->dev_irq,
> +					cdnsp_irq_handler,
> +					cdnsp_thread_irq_handler, IRQF_SHARED,
> +					dev_name(pdev->dev), pdev);
> +	if (ret)
> +		goto del_gadget;
> +
> +	return 0;
> +
> +del_gadget:
> +	usb_del_gadget_udc(&pdev->gadget);
> +free_endpoints:
> +	cdnsp_gadget_free_endpoints(pdev);
> +halt_pdev:
> +	cdnsp_halt(pdev);
> +	cdnsp_reset(pdev);
> +	cdnsp_mem_cleanup(pdev);
> +free_setup:
> +	kfree(pdev->setup_buf);
> +free_pdev:
> +	kfree(pdev);
> +
> +	return ret;
> +}
> +
> +static void cdnsp_gadget_exit(struct cdns *cdns)
> +{
> +	struct cdnsp_device *pdev =3D cdns->gadget_dev;
> +
> +	devm_free_irq(pdev->dev, cdns->dev_irq, pdev);
> +	pm_runtime_mark_last_busy(cdns->dev);
> +	pm_runtime_put_autosuspend(cdns->dev);
> +	usb_del_gadget_udc(&pdev->gadget);
> +	cdnsp_gadget_free_endpoints(pdev);
> +	cdnsp_mem_cleanup(pdev);
> +	kfree(pdev);
> +	cdns->gadget_dev =3D NULL;
> +	cdns_drd_gadget_off(cdns);
> +}
> +
> +static int cdnsp_gadget_suspend(struct cdns *cdns, bool do_wakeup)
> +{
> +	struct cdnsp_device *pdev =3D cdns->gadget_dev;
> +	unsigned long flags;
> +
> +	if (pdev->link_state =3D=3D XDEV_U3)
> +		return 0;
> +
> +	spin_lock_irqsave(&pdev->lock, flags);
> +	cdnsp_disconnect_gadget(pdev);
> +	cdnsp_stop(pdev);
> +	spin_unlock_irqrestore(&pdev->lock, flags);
> +
> +	return 0;
> +}
> +
> +static int cdnsp_gadget_resume(struct cdns *cdns, bool hibernated)
> +{
> +	struct cdnsp_device *pdev =3D cdns->gadget_dev;
> +	enum usb_device_speed max_speed;
> +	unsigned long flags;
> +	int ret;
> +
> +	if (!pdev->gadget_driver)
> +		return 0;
> +
> +	spin_lock_irqsave(&pdev->lock, flags);
> +	max_speed =3D pdev->gadget_driver->max_speed;
> +
> +	/* Limit speed if necessary. */
> +	max_speed =3D min(max_speed, pdev->gadget.max_speed);
> +
> +	ret =3D cdnsp_run(pdev, max_speed);
> +
> +	if (pdev->link_state =3D=3D XDEV_U3)
> +		__cdnsp_gadget_wakeup(pdev);
> +
> +	spin_unlock_irqrestore(&pdev->lock, flags);
> +
> +	return ret;
> +}
> +
> +/**
> + * cdnsp_gadget_init - initialize device structure
> + * @cdns: cdnsp instance
> + *
> + * This function initializes the gadget.
> + */
> +int cdnsp_gadget_init(struct cdns *cdns)
> +{
> +	struct cdns_role_driver *rdrv;
> +
> +	rdrv =3D devm_kzalloc(cdns->dev, sizeof(*rdrv), GFP_KERNEL);
> +	if (!rdrv)
> +		return -ENOMEM;
> +
> +	rdrv->start	=3D __cdnsp_gadget_init;
> +	rdrv->stop	=3D cdnsp_gadget_exit;
> +	rdrv->suspend	=3D cdnsp_gadget_suspend;
> +	rdrv->resume	=3D cdnsp_gadget_resume;
> +	rdrv->state	=3D CDNS_ROLE_STATE_INACTIVE;
> +	rdrv->name	=3D "gadget";
> +	cdns->roles[USB_ROLE_DEVICE] =3D rdrv;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(cdnsp_gadget_init);
> diff --git a/drivers/usb/cdnsp/gadget.h b/drivers/usb/cdnsp/gadget.h
> index bfc4196c3b10..547516681fbe 100644
> --- a/drivers/usb/cdnsp/gadget.h
> +++ b/drivers/usb/cdnsp/gadget.h
> @@ -1456,4 +1456,143 @@ struct cdnsp_device {
>  	u16 test_mode;
>  };
> =20
> +/*
> + * Registers should always be accessed with double word or quad word acc=
esses.
> + *
> + * Registers with 64-bit address pointers should be written to with
> + * dword accesses by writing the low dword first (ptr[0]), then the high=
 dword
> + * (ptr[1]) second. controller implementations that do not support 64-bi=
t
> + * address pointers will ignore the high dword, and write order is irrel=
evant.
> + */
> +static inline u64 cdnsp_read_64(const struct cdnsp_device *pdev,
> +				__le64 __iomem *regs)
> +{
> +	return lo_hi_readq(regs);
> +}
> +
> +static inline void cdnsp_write_64(struct cdnsp_device *pdev,
> +				  const u64 val, __le64 __iomem *regs)
> +{
> +	lo_hi_writeq(val, regs);
> +}
> +
> +/* CDNSP memory management functions. */
> +void cdnsp_mem_cleanup(struct cdnsp_device *pdev);
> +int cdnsp_mem_init(struct cdnsp_device *pdev, gfp_t flags);
> +int cdnsp_setup_addressable_priv_dev(struct cdnsp_device *pdev);
> +void cdnsp_copy_ep0_dequeue_into_input_ctx(struct cdnsp_device *pdev);
> +void cdnsp_endpoint_zero(struct cdnsp_device *pdev, struct cdnsp_ep *ep)=
;
> +int cdnsp_endpoint_init(struct cdnsp_device *pdev,
> +			struct cdnsp_ep *pep,
> +			gfp_t mem_flags);
> +int cdnsp_ring_expansion(struct cdnsp_device *pdev,
> +			 struct cdnsp_ring *ring,
> +			 unsigned int num_trbs, gfp_t flags);
> +struct cdnsp_ring *cdnsp_dma_to_transfer_ring(struct cdnsp_ep *ep, u64 a=
ddress);
> +int cdnsp_alloc_stream_info(struct cdnsp_device *pdev,
> +			    struct cdnsp_ep *pep,
> +			    unsigned int num_stream_ctxs,
> +			    unsigned int num_streams);
> +int cdnsp_alloc_streams(struct cdnsp_device *pdev, struct cdnsp_ep *pep)=
;
> +void cdnsp_free_endpoint_rings(struct cdnsp_device *pdev, struct cdnsp_e=
p *pep);
> +
> +/* Device controller glue. */
> +int cdnsp_find_next_ext_cap(void __iomem *base, u32 start, int id);
> +int cdnsp_halt(struct cdnsp_device *pdev);
> +void cdnsp_died(struct cdnsp_device *pdev);
> +int cdnsp_reset(struct cdnsp_device *pdev);
> +irqreturn_t cdnsp_irq_handler(int irq, void *priv);
> +int cdnsp_setup_device(struct cdnsp_device *pdev, enum cdnsp_setup_dev s=
etup);
> +void cdnsp_set_usb2_hardware_lpm(struct cdnsp_device *usbsssp_data,
> +				 struct usb_request *req, int enable);
> +irqreturn_t cdnsp_thread_irq_handler(int irq, void *data);
> +
> +/* Ring, segment, TRB, and TD functions. */
> +dma_addr_t cdnsp_trb_virt_to_dma(struct cdnsp_segment *seg,
> +				 union cdnsp_trb *trb);
> +bool cdnsp_last_trb_on_seg(struct cdnsp_segment *seg, union cdnsp_trb *t=
rb);
> +bool cdnsp_last_trb_on_ring(struct cdnsp_ring *ring,
> +			    struct cdnsp_segment *seg,
> +			    union cdnsp_trb *trb);
> +int cdnsp_wait_for_cmd_compl(struct cdnsp_device *pdev);
> +void cdnsp_update_erst_dequeue(struct cdnsp_device *pdev,
> +			       union cdnsp_trb *event_ring_deq,
> +			       u8 clear_ehb);
> +void cdnsp_initialize_ring_info(struct cdnsp_ring *ring);
> +void cdnsp_ring_cmd_db(struct cdnsp_device *pdev);
> +void cdnsp_queue_slot_control(struct cdnsp_device *pdev, u32 trb_type);
> +void cdnsp_queue_address_device(struct cdnsp_device *pdev,
> +				dma_addr_t in_ctx_ptr,
> +				enum cdnsp_setup_dev setup);
> +void cdnsp_queue_stop_endpoint(struct cdnsp_device *pdev,
> +			       unsigned int ep_index);
> +int cdnsp_queue_ctrl_tx(struct cdnsp_device *pdev, struct cdnsp_request =
*preq);
> +int cdnsp_queue_bulk_tx(struct cdnsp_device *pdev, struct cdnsp_request =
*preq);
> +int cdnsp_queue_isoc_tx_prepare(struct cdnsp_device *pdev,
> +				struct cdnsp_request *preq);
> +void cdnsp_queue_configure_endpoint(struct cdnsp_device *pdev,
> +				    dma_addr_t in_ctx_ptr);
> +void cdnsp_queue_reset_ep(struct cdnsp_device *pdev, unsigned int ep_ind=
ex);
> +void cdnsp_queue_halt_endpoint(struct cdnsp_device *pdev,
> +			       unsigned int ep_index);
> +void cdnsp_queue_flush_endpoint(struct cdnsp_device *pdev,
> +				unsigned int ep_index);
> +void cdnsp_force_header_wakeup(struct cdnsp_device *pdev, int intf_num);
> +void cdnsp_queue_reset_device(struct cdnsp_device *pdev);
> +void cdnsp_queue_new_dequeue_state(struct cdnsp_device *pdev,
> +				   struct cdnsp_ep *pep,
> +				   struct cdnsp_dequeue_state *deq_state);
> +void cdnsp_ring_doorbell_for_active_rings(struct cdnsp_device *pdev,
> +					  struct cdnsp_ep *pep);
> +void cdnsp_inc_deq(struct cdnsp_device *pdev, struct cdnsp_ring *ring);
> +void cdnsp_set_link_state(struct cdnsp_device *pdev,
> +			  __le32 __iomem *port_regs, u32 link_state);
> +u32 cdnsp_port_state_to_neutral(u32 state);
> +
> +/* CDNSP device controller contexts. */
> +int cdnsp_enable_slot(struct cdnsp_device *pdev);
> +int cdnsp_disable_slot(struct cdnsp_device *pdev);
> +struct cdnsp_input_control_ctx
> +	*cdnsp_get_input_control_ctx(struct cdnsp_container_ctx *ctx);
> +struct cdnsp_slot_ctx *cdnsp_get_slot_ctx(struct cdnsp_container_ctx *ct=
x);
> +struct cdnsp_ep_ctx *cdnsp_get_ep_ctx(struct cdnsp_container_ctx *ctx,
> +				      unsigned int ep_index);
> +/* CDNSP gadget interface. */
> +void cdnsp_suspend_gadget(struct cdnsp_device *pdev);
> +void cdnsp_resume_gadget(struct cdnsp_device *pdev);
> +void cdnsp_disconnect_gadget(struct cdnsp_device *pdev);
> +void cdnsp_gadget_giveback(struct cdnsp_ep *pep, struct cdnsp_request *p=
req,
> +			   int status);
> +int cdnsp_ep_enqueue(struct cdnsp_ep *pep, struct cdnsp_request *preq);
> +int cdnsp_ep_dequeue(struct cdnsp_ep *pep, struct cdnsp_request *preq);
> +unsigned int cdnsp_port_speed(unsigned int port_status);
> +void cdnsp_irq_reset(struct cdnsp_device *pdev);
> +int cdnsp_halt_endpoint(struct cdnsp_device *pdev,
> +			struct cdnsp_ep *pep, int value);
> +int cdnsp_cmd_stop_ep(struct cdnsp_device *pdev, struct cdnsp_ep *pep);
> +int cdnsp_cmd_flush_ep(struct cdnsp_device *pdev, struct cdnsp_ep *pep);
> +void cdnsp_setup_analyze(struct cdnsp_device *pdev);
> +int cdnsp_status_stage(struct cdnsp_device *pdev);
> +int cdnsp_reset_device(struct cdnsp_device *pdev);
> +
> +/**
> + * next_request - gets the next request on the given list
> + * @list: the request list to operate on
> + *
> + * Caller should take care of locking. This function return NULL or the =
first
> + * request available on list.
> + */
> +static inline struct cdnsp_request *next_request(struct list_head *list)
> +{
> +	return list_first_entry_or_null(list, struct cdnsp_request, list);
> +}
> +
> +#define to_cdnsp_ep(ep) (container_of(ep, struct cdnsp_ep, endpoint))
> +#define gadget_to_cdnsp(g) (container_of(g, struct cdnsp_device, gadget)=
)
> +#define request_to_cdnsp_request(r) (container_of(r, struct cdnsp_reques=
t, \
> +				     request))
> +#define to_cdnsp_request(r) (container_of(r, struct cdnsp_request, reque=
st))
> +int cdnsp_remove_request(struct cdnsp_device *pdev, struct cdnsp_request=
 *preq,
> +			 struct cdnsp_ep *pep);
> +
>  #endif /* __LINUX_CDNSP_GADGET_H */
> diff --git a/drivers/usb/cdnsp/mem.c b/drivers/usb/cdnsp/mem.c
> new file mode 100644
> index 000000000000..09662574adeb
> --- /dev/null
> +++ b/drivers/usb/cdnsp/mem.c
> @@ -0,0 +1,1312 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Cadence CDNSP DRD Driver.
> + *
> + * Copyright (C) 2020 Cadence.
> + *
> + * Author: Pawel Laszczak <pawell@cadence.com>
> + *
> + * Code based on Linux XHCI driver.
> + * Origin: Copyright (C) 2008 Intel Corp.
> + */
> +
> +#include <linux/dma-mapping.h>
> +#include <linux/dmapool.h>
> +#include <linux/slab.h>
> +#include <linux/usb.h>
> +
> +#include "gadget.h"
> +
> +static void cdnsp_free_stream_info(struct cdnsp_device *pdev,
> +				   struct cdnsp_ep *pep);
> +/*
> + * Allocates a generic ring segment from the ring pool, sets the dma add=
ress,
> + * initializes the segment to zero, and sets the private next pointer to=
 NULL.
> + *
> + * "All components of all Command and Transfer TRBs shall be initialized=
 to '0'"
> + */
> +static struct cdnsp_segment *cdnsp_segment_alloc(struct cdnsp_device *pd=
ev,
> +						 unsigned int cycle_state,
> +						 unsigned int max_packet,
> +						 gfp_t flags)
> +{
> +	struct cdnsp_segment *seg;
> +	dma_addr_t dma;
> +	int i;
> +
> +	seg =3D kzalloc(sizeof(*seg), flags);
> +	if (!seg)
> +		return NULL;
> +
> +	seg->trbs =3D dma_pool_zalloc(pdev->segment_pool, flags, &dma);
> +	if (!seg->trbs) {
> +		kfree(seg);
> +		return NULL;
> +	}
> +
> +	if (max_packet) {
> +		seg->bounce_buf =3D kzalloc(max_packet, flags | GFP_DMA);
> +		if (!seg->bounce_buf)
> +			goto free_dma;
> +	}
> +
> +	/* If the cycle state is 0, set the cycle bit to 1 for all the TRBs. */
> +	if (cycle_state =3D=3D 0) {
> +		for (i =3D 0; i < TRBS_PER_SEGMENT; i++)
> +			seg->trbs[i].link.control |=3D cpu_to_le32(TRB_CYCLE);
> +	}
> +	seg->dma =3D dma;
> +	seg->next =3D NULL;
> +
> +	return seg;
> +
> +free_dma:
> +	dma_pool_free(pdev->segment_pool, seg->trbs, dma);
> +	kfree(seg);
> +
> +	return NULL;
> +}
> +
> +static void cdnsp_segment_free(struct cdnsp_device *pdev,
> +			       struct cdnsp_segment *seg)
> +{
> +	if (seg->trbs)
> +		dma_pool_free(pdev->segment_pool, seg->trbs, seg->dma);
> +
> +	kfree(seg->bounce_buf);
> +	kfree(seg);
> +}
> +
> +static void cdnsp_free_segments_for_ring(struct cdnsp_device *pdev,
> +					 struct cdnsp_segment *first)
> +{
> +	struct cdnsp_segment *seg;
> +
> +	seg =3D first->next;
> +
> +	while (seg !=3D first) {
> +		struct cdnsp_segment *next =3D seg->next;
> +
> +		cdnsp_segment_free(pdev, seg);
> +		seg =3D next;
> +	}
> +
> +	cdnsp_segment_free(pdev, first);
> +}
> +
> +/*
> + * Make the prev segment point to the next segment.
> + *
> + * Change the last TRB in the prev segment to be a Link TRB which points=
 to the
> + * DMA address of the next segment. The caller needs to set any Link TRB
> + * related flags, such as End TRB, Toggle Cycle, and no snoop.
> + */
> +static void cdnsp_link_segments(struct cdnsp_device *pdev,
> +				struct cdnsp_segment *prev,
> +				struct cdnsp_segment *next,
> +				enum cdnsp_ring_type type)
> +{
> +	struct cdnsp_link_trb *link;
> +	u32 val;
> +
> +	if (!prev || !next)
> +		return;
> +
> +	prev->next =3D next;
> +	if (type !=3D TYPE_EVENT) {
> +		link =3D &prev->trbs[TRBS_PER_SEGMENT - 1].link;
> +		link->segment_ptr =3D cpu_to_le64(next->dma);
> +
> +		/*
> +		 * Set the last TRB in the segment to have a TRB type ID
> +		 * of Link TRB
> +		 */
> +		val =3D le32_to_cpu(link->control);
> +		val &=3D ~TRB_TYPE_BITMASK;
> +		val |=3D TRB_TYPE(TRB_LINK);
> +		link->control =3D cpu_to_le32(val);
> +	}
> +}
> +
> +/*
> + * Link the ring to the new segments.
> + * Set Toggle Cycle for the new ring if needed.
> + */
> +static void cdnsp_link_rings(struct cdnsp_device *pdev,
> +			     struct cdnsp_ring *ring,
> +			     struct cdnsp_segment *first,
> +			     struct cdnsp_segment *last,
> +			     unsigned int num_segs)
> +{
> +	struct cdnsp_segment *next;
> +
> +	if (!ring || !first || !last)
> +		return;
> +
> +	next =3D ring->enq_seg->next;
> +	cdnsp_link_segments(pdev, ring->enq_seg, first, ring->type);
> +	cdnsp_link_segments(pdev, last, next, ring->type);
> +	ring->num_segs +=3D num_segs;
> +	ring->num_trbs_free +=3D (TRBS_PER_SEGMENT - 1) * num_segs;
> +
> +	if (ring->type !=3D TYPE_EVENT && ring->enq_seg =3D=3D ring->last_seg) =
{
> +		ring->last_seg->trbs[TRBS_PER_SEGMENT - 1].link.control &=3D
> +			~cpu_to_le32(LINK_TOGGLE);
> +		last->trbs[TRBS_PER_SEGMENT - 1].link.control |=3D
> +			cpu_to_le32(LINK_TOGGLE);
> +		ring->last_seg =3D last;
> +	}
> +}
> +
> +/*
> + * We need a radix tree for mapping physical addresses of TRBs to which =
stream
> + * ID they belong to. We need to do this because the device controller w=
on't
> + * tell us which stream ring the TRB came from. We could store the strea=
m ID
> + * in an event data TRB, but that doesn't help us for the cancellation c=
ase,
> + * since the endpoint may stop before it reaches that event data TRB.
> + *
> + * The radix tree maps the upper portion of the TRB DMA address to a rin=
g
> + * segment that has the same upper portion of DMA addresses. For example=
,
> + * say I have segments of size 1KB, that are always 1KB aligned. A segme=
nt may
> + * start at 0x10c91000 and end at 0x10c913f0. If I use the upper 10 bits=
, the
> + * key to the stream ID is 0x43244. I can use the DMA address of the TRB=
 to
> + * pass the radix tree a key to get the right stream ID:
> + *
> + *	0x10c90fff >> 10 =3D 0x43243
> + *	0x10c912c0 >> 10 =3D 0x43244
> + *	0x10c91400 >> 10 =3D 0x43245
> + *
> + * Obviously, only those TRBs with DMA addresses that are within the seg=
ment
> + * will make the radix tree return the stream ID for that ring.
> + *
> + * Caveats for the radix tree:
> + *
> + * The radix tree uses an unsigned long as a key pair. On 32-bit systems=
, an
> + * unsigned long will be 32-bits; on a 64-bit system an unsigned long wi=
ll be
> + * 64-bits. Since we only request 32-bit DMA addresses, we can use that =
as the
> + * key on 32-bit or 64-bit systems (it would also be fine if we asked fo=
r 64-bit
> + * PCI DMA addresses on a 64-bit system). There might be a problem on 32=
-bit
> + * extended systems (where the DMA address can be bigger than 32-bits),
> + * if we allow the PCI dma mask to be bigger than 32-bits. So don't do t=
hat.
> + */
> +static int cdnsp_insert_segment_mapping(struct radix_tree_root *trb_addr=
ess_map,
> +					struct cdnsp_ring *ring,
> +					struct cdnsp_segment *seg,
> +					gfp_t mem_flags)
> +{
> +	unsigned long key;
> +	int ret;
> +
> +	key =3D (unsigned long)(seg->dma >> TRB_SEGMENT_SHIFT);
> +
> +	/* Skip any segments that were already added. */
> +	if (radix_tree_lookup(trb_address_map, key))
> +		return 0;
> +
> +	ret =3D radix_tree_maybe_preload(mem_flags);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D radix_tree_insert(trb_address_map, key, ring);
> +	radix_tree_preload_end();
> +
> +	return ret;
> +}
> +
> +static void cdnsp_remove_segment_mapping(struct radix_tree_root *trb_add=
ress_map,
> +					 struct cdnsp_segment *seg)
> +{
> +	unsigned long key;
> +
> +	key =3D (unsigned long)(seg->dma >> TRB_SEGMENT_SHIFT);
> +	if (radix_tree_lookup(trb_address_map, key))
> +		radix_tree_delete(trb_address_map, key);
> +}
> +
> +static int cdnsp_update_stream_segment_mapping(struct radix_tree_root *t=
rb_address_map,
> +					       struct cdnsp_ring *ring,
> +					       struct cdnsp_segment *first_seg,
> +					       struct cdnsp_segment *last_seg,
> +					       gfp_t mem_flags)
> +{
> +	struct cdnsp_segment *failed_seg;
> +	struct cdnsp_segment *seg;
> +	int ret;
> +
> +	seg =3D first_seg;
> +	do {
> +		ret =3D cdnsp_insert_segment_mapping(trb_address_map, ring, seg,
> +						   mem_flags);
> +		if (ret)
> +			goto remove_streams;
> +		if (seg =3D=3D last_seg)
> +			return 0;
> +		seg =3D seg->next;
> +	} while (seg !=3D first_seg);
> +
> +	return 0;
> +
> +remove_streams:
> +	failed_seg =3D seg;
> +	seg =3D first_seg;
> +	do {
> +		cdnsp_remove_segment_mapping(trb_address_map, seg);
> +		if (seg =3D=3D failed_seg)
> +			return ret;
> +		seg =3D seg->next;
> +	} while (seg !=3D first_seg);
> +
> +	return ret;
> +}
> +
> +static void cdnsp_remove_stream_mapping(struct cdnsp_ring *ring)
> +{
> +	struct cdnsp_segment *seg;
> +
> +	seg =3D ring->first_seg;
> +	do {
> +		cdnsp_remove_segment_mapping(ring->trb_address_map, seg);
> +		seg =3D seg->next;
> +	} while (seg !=3D ring->first_seg);
> +}
> +
> +static int cdnsp_update_stream_mapping(struct cdnsp_ring *ring)
> +{
> +	return cdnsp_update_stream_segment_mapping(ring->trb_address_map, ring,
> +			ring->first_seg, ring->last_seg, GFP_ATOMIC);
> +}
> +
> +static void cdnsp_ring_free(struct cdnsp_device *pdev, struct cdnsp_ring=
 *ring)
> +{
> +	if (!ring)
> +		return;
> +
> +	if (ring->first_seg) {
> +		if (ring->type =3D=3D TYPE_STREAM)
> +			cdnsp_remove_stream_mapping(ring);
> +
> +		cdnsp_free_segments_for_ring(pdev, ring->first_seg);
> +	}
> +
> +	kfree(ring);
> +}
> +
> +void cdnsp_initialize_ring_info(struct cdnsp_ring *ring)
> +{
> +	ring->enqueue =3D ring->first_seg->trbs;
> +	ring->enq_seg =3D ring->first_seg;
> +	ring->dequeue =3D ring->enqueue;
> +	ring->deq_seg =3D ring->first_seg;
> +
> +	/*
> +	 * The ring is initialized to 0. The producer must write 1 to the cycle
> +	 * bit to handover ownership of the TRB, so PCS =3D 1. The consumer mus=
t
> +	 * compare CCS to the cycle bit to check ownership, so CCS =3D 1.
> +	 *
> +	 * New rings are initialized with cycle state equal to 1; if we are
> +	 * handling ring expansion, set the cycle state equal to the old ring.
> +	 */
> +	ring->cycle_state =3D 1;
> +
> +	/*
> +	 * Each segment has a link TRB, and leave an extra TRB for SW
> +	 * accounting purpose
> +	 */
> +	ring->num_trbs_free =3D ring->num_segs * (TRBS_PER_SEGMENT - 1) - 1;
> +}
> +
> +/* Allocate segments and link them for a ring. */
> +static int cdnsp_alloc_segments_for_ring(struct cdnsp_device *pdev,
> +					 struct cdnsp_segment **first,
> +					 struct cdnsp_segment **last,
> +					 unsigned int num_segs,
> +					 unsigned int cycle_state,
> +					 enum cdnsp_ring_type type,
> +					 unsigned int max_packet,
> +					 gfp_t flags)
> +{
> +	struct cdnsp_segment *prev;
> +
> +	/* Allocate first segment. */
> +	prev =3D cdnsp_segment_alloc(pdev, cycle_state, max_packet, flags);
> +	if (!prev)
> +		return -ENOMEM;
> +
> +	num_segs--;
> +	*first =3D prev;
> +
> +	/* Allocate all other segments. */
> +	while (num_segs > 0) {
> +		struct cdnsp_segment	*next;
> +
> +		next =3D cdnsp_segment_alloc(pdev, cycle_state,
> +					   max_packet, flags);
> +		if (!next) {
> +			cdnsp_free_segments_for_ring(pdev, *first);
> +			return -ENOMEM;
> +		}
> +
> +		cdnsp_link_segments(pdev, prev, next, type);
> +
> +		prev =3D next;
> +		num_segs--;
> +	}
> +
> +	cdnsp_link_segments(pdev, prev, *first, type);
> +	*last =3D prev;
> +
> +	return 0;
> +}
> +
> +/*
> + * Create a new ring with zero or more segments.
> + *
> + * Link each segment together into a ring.
> + * Set the end flag and the cycle toggle bit on the last segment.
> + */
> +static struct cdnsp_ring *cdnsp_ring_alloc(struct cdnsp_device *pdev,
> +					   unsigned int num_segs,
> +					   enum cdnsp_ring_type type,
> +					   unsigned int max_packet,
> +					   gfp_t flags)
> +{
> +	struct cdnsp_ring *ring;
> +	int ret;
> +
> +	ring =3D kzalloc(sizeof *(ring), flags);
> +	if (!ring)
> +		return NULL;
> +
> +	ring->num_segs =3D num_segs;
> +	ring->bounce_buf_len =3D max_packet;
> +	INIT_LIST_HEAD(&ring->td_list);
> +	ring->type =3D type;
> +
> +	if (num_segs =3D=3D 0)
> +		return ring;
> +
> +	ret =3D cdnsp_alloc_segments_for_ring(pdev, &ring->first_seg,
> +					    &ring->last_seg, num_segs,
> +					    1, type, max_packet, flags);
> +	if (ret)
> +		goto fail;
> +
> +	/* Only event ring does not use link TRB. */
> +	if (type !=3D TYPE_EVENT)
> +		ring->last_seg->trbs[TRBS_PER_SEGMENT - 1].link.control |=3D
> +			cpu_to_le32(LINK_TOGGLE);
> +
> +	cdnsp_initialize_ring_info(ring);
> +
> +	return ring;
> +fail:
> +	kfree(ring);
> +	return NULL;
> +}
> +
> +void cdnsp_free_endpoint_rings(struct cdnsp_device *pdev, struct cdnsp_e=
p *pep)
> +{
> +	cdnsp_ring_free(pdev, pep->ring);
> +	pep->ring =3D NULL;
> +	cdnsp_free_stream_info(pdev, pep);
> +}
> +
> +/*
> + * Expand an existing ring.
> + * Allocate a new ring which has same segment numbers and link the two r=
ings.
> + */
> +int cdnsp_ring_expansion(struct cdnsp_device *pdev,
> +			 struct cdnsp_ring *ring,
> +			 unsigned int num_trbs,
> +			 gfp_t flags)
> +{
> +	unsigned int num_segs_needed;
> +	struct cdnsp_segment *first;
> +	struct cdnsp_segment *last;
> +	unsigned int num_segs;
> +	int ret;
> +
> +	num_segs_needed =3D (num_trbs + (TRBS_PER_SEGMENT - 1) - 1) /
> +			(TRBS_PER_SEGMENT - 1);
> +
> +	/* Allocate number of segments we needed, or double the ring size. */
> +	num_segs =3D max(ring->num_segs, num_segs_needed);
> +
> +	ret =3D cdnsp_alloc_segments_for_ring(pdev, &first, &last, num_segs,
> +					    ring->cycle_state, ring->type,
> +					    ring->bounce_buf_len, flags);
> +	if (ret)
> +		return -ENOMEM;
> +
> +	if (ring->type =3D=3D TYPE_STREAM)
> +		ret =3D cdnsp_update_stream_segment_mapping(ring->trb_address_map,
> +							  ring, first,
> +							  last, flags);
> +
> +	if (ret) {
> +		cdnsp_free_segments_for_ring(pdev, first);
> +
> +		return ret;
> +	}
> +
> +	cdnsp_link_rings(pdev, ring, first, last, num_segs);
> +
> +	return 0;
> +}
> +
> +static int cdnsp_init_device_ctx(struct cdnsp_device *pdev)
> +{
> +	int size =3D HCC_64BYTE_CONTEXT(pdev->hcc_params) ? 2048 : 1024;
> +
> +	pdev->out_ctx.type =3D CDNSP_CTX_TYPE_DEVICE;
> +	pdev->out_ctx.size =3D size;
> +	pdev->out_ctx.ctx_size =3D CTX_SIZE(pdev->hcc_params);
> +	pdev->out_ctx.bytes =3D dma_pool_zalloc(pdev->device_pool, GFP_ATOMIC,
> +					      &pdev->out_ctx.dma);
> +
> +	if (!pdev->out_ctx.bytes)
> +		return -ENOMEM;
> +
> +	pdev->in_ctx.type =3D CDNSP_CTX_TYPE_INPUT;
> +	pdev->in_ctx.ctx_size =3D pdev->out_ctx.ctx_size;
> +	pdev->in_ctx.size =3D size + pdev->out_ctx.ctx_size;
> +	pdev->in_ctx.bytes =3D dma_pool_zalloc(pdev->device_pool, GFP_ATOMIC,
> +					     &pdev->in_ctx.dma);
> +
> +	if (!pdev->in_ctx.bytes) {
> +		dma_pool_free(pdev->device_pool, pdev->out_ctx.bytes,
> +			      pdev->out_ctx.dma);
> +		return -ENOMEM;
> +	}
> +
> +	return 0;
> +}
> +
> +struct cdnsp_input_control_ctx
> +	*cdnsp_get_input_control_ctx(struct cdnsp_container_ctx *ctx)
> +{
> +	if (ctx->type !=3D CDNSP_CTX_TYPE_INPUT)
> +		return NULL;
> +
> +	return (struct cdnsp_input_control_ctx *)ctx->bytes;
> +}
> +
> +struct cdnsp_slot_ctx *cdnsp_get_slot_ctx(struct cdnsp_container_ctx *ct=
x)
> +{
> +	if (ctx->type =3D=3D CDNSP_CTX_TYPE_DEVICE)
> +		return (struct cdnsp_slot_ctx *)ctx->bytes;
> +
> +	return (struct cdnsp_slot_ctx *)(ctx->bytes + ctx->ctx_size);
> +}
> +
> +struct cdnsp_ep_ctx *cdnsp_get_ep_ctx(struct cdnsp_container_ctx *ctx,
> +				      unsigned int ep_index)
> +{
> +	/* Increment ep index by offset of start of ep ctx array. */
> +	ep_index++;
> +	if (ctx->type =3D=3D CDNSP_CTX_TYPE_INPUT)
> +		ep_index++;
> +
> +	return (struct cdnsp_ep_ctx *)(ctx->bytes + (ep_index * ctx->ctx_size))=
;
> +}
> +
> +static void cdnsp_free_stream_ctx(struct cdnsp_device *pdev,
> +				  struct cdnsp_ep *pep)
> +{
> +	dma_pool_free(pdev->device_pool, pep->stream_info.stream_ctx_array,
> +		      pep->stream_info.ctx_array_dma);
> +}
> +
> +/* The stream context array must be a power of 2. */
> +static struct cdnsp_stream_ctx
> +	*cdnsp_alloc_stream_ctx(struct cdnsp_device *pdev, struct cdnsp_ep *pep=
)
> +{
> +	size_t size =3D sizeof(struct cdnsp_stream_ctx) *
> +		      pep->stream_info.num_stream_ctxs;
> +
> +	if (size > CDNSP_CTX_SIZE)
> +		return NULL;
> +
> +	/**
> +	 * Driver uses intentionally the device_pool to allocated stream
> +	 * context array. Device Pool has 2048 bytes of size what gives us
> +	 * 128 entries.
> +	 */
> +	return dma_pool_zalloc(pdev->device_pool, GFP_DMA32 | GFP_ATOMIC,
> +			       &pep->stream_info.ctx_array_dma);
> +}
> +
> +struct cdnsp_ring *cdnsp_dma_to_transfer_ring(struct cdnsp_ep *pep, u64 =
address)
> +{
> +	if (pep->ep_state & EP_HAS_STREAMS)
> +		return radix_tree_lookup(&pep->stream_info.trb_address_map,
> +					 address >> TRB_SEGMENT_SHIFT);
> +
> +	return pep->ring;
> +}
> +
> +/*
> + * Change an endpoint's internal structure so it supports stream IDs.
> + * The number of requested streams includes stream 0, which cannot be us=
ed by
> + * driver.
> + *
> + * The number of stream contexts in the stream context array may be bigg=
er than
> + * the number of streams the driver wants to use. This is because the nu=
mber of
> + * stream context array entries must be a power of two.
> + */
> +int cdnsp_alloc_stream_info(struct cdnsp_device *pdev,
> +			    struct cdnsp_ep *pep,
> +			    unsigned int num_stream_ctxs,
> +			    unsigned int num_streams)
> +{
> +	struct cdnsp_stream_info *stream_info;
> +	struct cdnsp_ring *cur_ring;
> +	u32 cur_stream;
> +	u64 addr;
> +	int ret;
> +	int mps;
> +
> +	stream_info =3D &pep->stream_info;
> +	stream_info->num_streams =3D num_streams;
> +	stream_info->num_stream_ctxs =3D num_stream_ctxs;
> +
> +	/* Initialize the array of virtual pointers to stream rings. */
> +	stream_info->stream_rings =3D kcalloc(num_streams,
> +					    sizeof(struct cdnsp_ring *),
> +					    GFP_ATOMIC);
> +	if (!stream_info->stream_rings)
> +		return -ENOMEM;
> +
> +	/* Initialize the array of DMA addresses for stream rings for the HW. *=
/
> +	stream_info->stream_ctx_array =3D cdnsp_alloc_stream_ctx(pdev, pep);
> +	if (!stream_info->stream_ctx_array)
> +		goto cleanup_stream_rings;
> +
> +	memset(stream_info->stream_ctx_array, 0,
> +	       sizeof(struct cdnsp_stream_ctx) * num_stream_ctxs);
> +	INIT_RADIX_TREE(&stream_info->trb_address_map, GFP_ATOMIC);
> +	mps =3D usb_endpoint_maxp(pep->endpoint.desc);
> +
> +	/*
> +	 * Allocate rings for all the streams that the driver will use,
> +	 * and add their segment DMA addresses to the radix tree.
> +	 * Stream 0 is reserved.
> +	 */
> +	for (cur_stream =3D 1; cur_stream < num_streams; cur_stream++) {
> +		cur_ring =3D cdnsp_ring_alloc(pdev, 2, TYPE_STREAM, mps,
> +					    GFP_ATOMIC);
> +		stream_info->stream_rings[cur_stream] =3D cur_ring;
> +
> +		if (!cur_ring)
> +			goto cleanup_rings;
> +
> +		cur_ring->stream_id =3D cur_stream;
> +		cur_ring->trb_address_map =3D &stream_info->trb_address_map;
> +
> +		/* Set deq ptr, cycle bit, and stream context type. */
> +		addr =3D cur_ring->first_seg->dma | SCT_FOR_CTX(SCT_PRI_TR) |
> +		       cur_ring->cycle_state;
> +
> +		stream_info->stream_ctx_array[cur_stream].stream_ring =3D
> +			cpu_to_le64(addr);
> +
> +		ret =3D cdnsp_update_stream_mapping(cur_ring);
> +		if (ret)
> +			goto cleanup_rings;
> +	}
> +
> +	return 0;
> +
> +cleanup_rings:
> +	for (cur_stream =3D 1; cur_stream < num_streams; cur_stream++) {
> +		cur_ring =3D stream_info->stream_rings[cur_stream];
> +		if (cur_ring) {
> +			cdnsp_ring_free(pdev, cur_ring);
> +			stream_info->stream_rings[cur_stream] =3D NULL;
> +		}
> +	}
> +
> +cleanup_stream_rings:
> +	kfree(pep->stream_info.stream_rings);
> +
> +	return -ENOMEM;
> +}
> +
> +/* Frees all stream contexts associated with the endpoint. */
> +static void cdnsp_free_stream_info(struct cdnsp_device *pdev,
> +				   struct cdnsp_ep *pep)
> +{
> +	struct cdnsp_stream_info *stream_info =3D &pep->stream_info;
> +	struct cdnsp_ring *cur_ring;
> +	int cur_stream;
> +
> +	if (!(pep->ep_state & EP_HAS_STREAMS))
> +		return;
> +
> +	for (cur_stream =3D 1; cur_stream < stream_info->num_streams;
> +	     cur_stream++) {
> +		cur_ring =3D stream_info->stream_rings[cur_stream];
> +		if (cur_ring) {
> +			cdnsp_ring_free(pdev, cur_ring);
> +			stream_info->stream_rings[cur_stream] =3D NULL;
> +		}
> +	}
> +
> +	if (stream_info->stream_ctx_array)
> +		cdnsp_free_stream_ctx(pdev, pep);
> +
> +	kfree(stream_info->stream_rings);
> +	pep->ep_state &=3D ~EP_HAS_STREAMS;
> +}
> +
> +/* All the cdnsp_tds in the ring's TD list should be freed at this point=
.*/
> +static void cdnsp_free_priv_device(struct cdnsp_device *pdev)
> +{
> +	pdev->dcbaa->dev_context_ptrs[1] =3D 0;
> +
> +	cdnsp_free_endpoint_rings(pdev, &pdev->eps[0]);
> +
> +	if (pdev->in_ctx.bytes)
> +		dma_pool_free(pdev->device_pool, pdev->in_ctx.bytes,
> +			      pdev->in_ctx.dma);
> +
> +	if (pdev->out_ctx.bytes)
> +		dma_pool_free(pdev->device_pool, pdev->out_ctx.bytes,
> +			      pdev->out_ctx.dma);
> +
> +	pdev->in_ctx.bytes =3D NULL;
> +	pdev->out_ctx.bytes =3D NULL;
> +}
> +
> +static int cdnsp_alloc_priv_device(struct cdnsp_device *pdev, gfp_t flag=
s)
> +{
> +	int ret =3D -ENOMEM;
> +
> +	ret =3D cdnsp_init_device_ctx(pdev);
> +	if (ret)
> +		return ret;
> +
> +	/* Allocate endpoint 0 ring. */
> +	pdev->eps[0].ring =3D cdnsp_ring_alloc(pdev, 2, TYPE_CTRL, 0, flags);
> +	if (!pdev->eps[0].ring)
> +		goto fail;
> +
> +	/* Point to output device context in dcbaa. */
> +	pdev->dcbaa->dev_context_ptrs[1] =3D cpu_to_le64(pdev->out_ctx.dma);
> +	pdev->cmd.in_ctx =3D &pdev->in_ctx;
> +
> +	return 0;
> +fail:
> +	dma_pool_free(pdev->device_pool, pdev->out_ctx.bytes,
> +		      pdev->out_ctx.dma);
> +	dma_pool_free(pdev->device_pool, pdev->in_ctx.bytes,
> +		      pdev->in_ctx.dma);
> +
> +	return ret;
> +}
> +
> +void cdnsp_copy_ep0_dequeue_into_input_ctx(struct cdnsp_device *pdev)
> +{
> +	struct cdnsp_ep_ctx *ep0_ctx =3D pdev->eps[0].in_ctx;
> +	struct cdnsp_ring *ep_ring =3D pdev->eps[0].ring;
> +	dma_addr_t dma;
> +
> +	dma =3D cdnsp_trb_virt_to_dma(ep_ring->enq_seg, ep_ring->enqueue);
> +	ep0_ctx->deq =3D cpu_to_le64(dma | ep_ring->cycle_state);
> +}
> +
> +/* Setup an controller private device for a Set Address command. */
> +int cdnsp_setup_addressable_priv_dev(struct cdnsp_device *pdev)
> +{
> +	struct cdnsp_slot_ctx *slot_ctx;
> +	struct cdnsp_ep_ctx *ep0_ctx;
> +	u32 max_packets, port;
> +
> +	ep0_ctx =3D cdnsp_get_ep_ctx(&pdev->in_ctx, 0);
> +	slot_ctx =3D cdnsp_get_slot_ctx(&pdev->in_ctx);
> +
> +	/* Only the control endpoint is valid - one endpoint context. */
> +	slot_ctx->dev_info |=3D cpu_to_le32(LAST_CTX(1));
> +
> +	switch (pdev->gadget.speed) {
> +	case USB_SPEED_SUPER_PLUS:
> +		slot_ctx->dev_info |=3D cpu_to_le32(SLOT_SPEED_SSP);
> +		max_packets =3D MAX_PACKET(512);
> +		break;
> +	case USB_SPEED_SUPER:
> +		slot_ctx->dev_info |=3D cpu_to_le32(SLOT_SPEED_SS);
> +		max_packets =3D MAX_PACKET(512);
> +		break;
> +	case USB_SPEED_HIGH:
> +		slot_ctx->dev_info |=3D cpu_to_le32(SLOT_SPEED_HS);
> +		max_packets =3D MAX_PACKET(64);
> +		break;
> +	case USB_SPEED_FULL:
> +		slot_ctx->dev_info |=3D cpu_to_le32(SLOT_SPEED_FS);
> +		max_packets =3D MAX_PACKET(64);
> +		break;
> +	default:
> +		/* Speed was not set , this shouldn't happen. */
> +		return -EINVAL;
> +	}
> +
> +	port =3D DEV_PORT(pdev->active_port->port_num);
> +	slot_ctx->dev_port |=3D cpu_to_le32(port);
> +	slot_ctx->dev_state =3D (pdev->device_address & DEV_ADDR_MASK);
> +	ep0_ctx->tx_info =3D EP_AVG_TRB_LENGTH(0x8);
> +	ep0_ctx->ep_info2 =3D cpu_to_le32(EP_TYPE(CTRL_EP));
> +	ep0_ctx->ep_info2 |=3D cpu_to_le32(MAX_BURST(0) | ERROR_COUNT(3) |
> +					 max_packets);
> +
> +	ep0_ctx->deq =3D cpu_to_le64(pdev->eps[0].ring->first_seg->dma |
> +				   pdev->eps[0].ring->cycle_state);
> +
> +	return 0;
> +}
> +
> +/*
> + * Convert interval expressed as 2^(bInterval - 1) =3D=3D interval into
> + * straight exponent value 2^n =3D=3D interval.
> + */
> +static unsigned int cdnsp_parse_exponent_interval(struct usb_gadget *g,
> +						  struct cdnsp_ep *pep)
> +{
> +	unsigned int interval;
> +
> +	interval =3D clamp_val(pep->endpoint.desc->bInterval, 1, 16) - 1;
> +	if (interval !=3D pep->endpoint.desc->bInterval - 1)
> +		dev_warn(&g->dev, "ep %s - rounding interval to %d %sframes\n",
> +			 pep->name, 1 << interval,
> +			 g->speed =3D=3D USB_SPEED_FULL ? "" : "micro");
> +
> +	/*
> +	 * Full speed isoc endpoints specify interval in frames,
> +	 * not microframes. We are using microframes everywhere,
> +	 * so adjust accordingly.
> +	 */
> +	if (g->speed =3D=3D USB_SPEED_FULL)
> +		interval +=3D 3;	/* 1 frame =3D 2^3 uframes */
> +
> +	/* Controller handles only up to 512ms (2^12). */
> +	if (interval > 12)
> +		interval =3D 12;
> +
> +	return interval;
> +}
> +
> +/*
> + * Convert bInterval expressed in microframes (in 1-255 range) to expone=
nt of
> + * microframes, rounded down to nearest power of 2.
> + */
> +static unsigned int cdnsp_microframes_to_exponent(struct usb_gadget *g,
> +						  struct cdnsp_ep *pep,
> +						  unsigned int desc_interval,
> +						  unsigned int min_exponent,
> +						  unsigned int max_exponent)
> +{
> +	unsigned int interval;
> +
> +	interval =3D fls(desc_interval) - 1;
> +	return clamp_val(interval, min_exponent, max_exponent);
> +}
> +
> +/*
> + * Return the polling interval.
> + *
> + * The polling interval is expressed in "microframes". If controllers's =
Interval
> + * field is set to N, it will service the endpoint every 2^(Interval)*12=
5us.
> + */
> +static unsigned int cdnsp_get_endpoint_interval(struct usb_gadget *g,
> +						struct cdnsp_ep *pep)
> +{
> +	unsigned int interval =3D 0;
> +
> +	switch (g->speed) {
> +	case USB_SPEED_HIGH:
> +	case USB_SPEED_SUPER_PLUS:
> +	case USB_SPEED_SUPER:
> +		if (usb_endpoint_xfer_int(pep->endpoint.desc) ||
> +		    usb_endpoint_xfer_isoc(pep->endpoint.desc))
> +			interval =3D cdnsp_parse_exponent_interval(g, pep);
> +		break;
> +	case USB_SPEED_FULL:
> +		if (usb_endpoint_xfer_isoc(pep->endpoint.desc)) {
> +			interval =3D cdnsp_parse_exponent_interval(g, pep);
> +		} else if (usb_endpoint_xfer_int(pep->endpoint.desc)) {
> +			interval =3D pep->endpoint.desc->bInterval << 3;
> +			interval =3D cdnsp_microframes_to_exponent(g, pep,
> +								 interval,
> +								 3, 10);
> +		}
> +
> +		break;
> +	default:
> +		WARN_ON(1);
> +	}
> +
> +	return interval;
> +}
> +
> +/*
> + * The "Mult" field in the endpoint context is only set for SuperSpeed i=
soc eps.
> + * High speed endpoint descriptors can define "the number of additional
> + * transaction opportunities per microframe", but that goes in the Max B=
urst
> + * endpoint context field.
> + */
> +static u32 cdnsp_get_endpoint_mult(struct usb_gadget *g, struct cdnsp_ep=
 *pep)
> +{
> +	if (g->speed < USB_SPEED_SUPER ||
> +	    !usb_endpoint_xfer_isoc(pep->endpoint.desc))
> +		return 0;
> +
> +	return pep->endpoint.comp_desc->bmAttributes;
> +}
> +
> +static u32 cdnsp_get_endpoint_max_burst(struct usb_gadget *g,
> +					struct cdnsp_ep *pep)
> +{
> +	/* Super speed and Plus have max burst in ep companion desc */
> +	if (g->speed >=3D USB_SPEED_SUPER)
> +		return pep->endpoint.comp_desc->bMaxBurst;
> +
> +	if (g->speed =3D=3D USB_SPEED_HIGH &&
> +	    (usb_endpoint_xfer_isoc(pep->endpoint.desc) ||
> +	     usb_endpoint_xfer_int(pep->endpoint.desc)))
> +		return (usb_endpoint_maxp(pep->endpoint.desc) & 0x1800) >> 11;
> +
> +	return 0;
> +}
> +
> +static u32 cdnsp_get_endpoint_type(const struct usb_endpoint_descriptor =
*desc)
> +{
> +	int in;
> +
> +	in =3D usb_endpoint_dir_in(desc);
> +
> +	switch (usb_endpoint_type(desc)) {
> +	case USB_ENDPOINT_XFER_CONTROL:
> +		return CTRL_EP;
> +	case USB_ENDPOINT_XFER_BULK:
> +		return in ? BULK_IN_EP : BULK_OUT_EP;
> +	case USB_ENDPOINT_XFER_ISOC:
> +		return in ? ISOC_IN_EP : ISOC_OUT_EP;
> +	case USB_ENDPOINT_XFER_INT:
> +		return in ? INT_IN_EP : INT_OUT_EP;
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * Return the maximum endpoint service interval time (ESIT) payload.
> + * Basically, this is the maxpacket size, multiplied by the burst size
> + * and mult size.
> + */
> +static u32 cdnsp_get_max_esit_payload(struct usb_gadget *g,
> +				      struct cdnsp_ep *pep)
> +{
> +	int max_packet;
> +	int max_burst;
> +
> +	/* Only applies for interrupt or isochronous endpoints*/
> +	if (usb_endpoint_xfer_control(pep->endpoint.desc) ||
> +	    usb_endpoint_xfer_bulk(pep->endpoint.desc))
> +		return 0;
> +
> +	/* SuperSpeedPlus Isoc ep sending over 48k per EIST. */
> +	if (g->speed >=3D USB_SPEED_SUPER_PLUS &&
> +	    USB_SS_SSP_ISOC_COMP(pep->endpoint.desc->bmAttributes))
> +		return le32_to_cpu(pep->endpoint.comp_desc->wBytesPerInterval);
> +	/* SuperSpeed or SuperSpeedPlus Isoc ep with less than 48k per esit */
> +	else if (g->speed >=3D USB_SPEED_SUPER)
> +		return le16_to_cpu(pep->endpoint.comp_desc->wBytesPerInterval);
> +
> +	max_packet =3D usb_endpoint_maxp(pep->endpoint.desc);
> +	max_burst =3D usb_endpoint_maxp_mult(pep->endpoint.desc);
> +
> +	/* A 0 in max burst means 1 transfer per ESIT */
> +	return max_packet * max_burst;
> +}
> +
> +int cdnsp_endpoint_init(struct cdnsp_device *pdev,
> +			struct cdnsp_ep *pep,
> +			gfp_t mem_flags)
> +{
> +	enum cdnsp_ring_type ring_type;
> +	struct cdnsp_ep_ctx *ep_ctx;
> +	unsigned int err_count =3D 0;
> +	unsigned int avg_trb_len;
> +	unsigned int max_packet;
> +	unsigned int max_burst;
> +	unsigned int interval;
> +	u32 max_esit_payload;
> +	unsigned int mult;
> +	u32 endpoint_type;
> +	int ret;
> +
> +	ep_ctx =3D pep->in_ctx;
> +
> +	endpoint_type =3D cdnsp_get_endpoint_type(pep->endpoint.desc);
> +	if (!endpoint_type)
> +		return -EINVAL;
> +
> +	ring_type =3D usb_endpoint_type(pep->endpoint.desc);
> +
> +	/*
> +	 * Get values to fill the endpoint context, mostly from ep descriptor.
> +	 * The average TRB buffer length for bulk endpoints is unclear as we
> +	 * have no clue on scatter gather list entry size. For Isoc and Int,
> +	 * set it to max available.
> +	 */
> +	max_esit_payload =3D cdnsp_get_max_esit_payload(&pdev->gadget, pep);
> +	interval =3D cdnsp_get_endpoint_interval(&pdev->gadget, pep);
> +	mult =3D cdnsp_get_endpoint_mult(&pdev->gadget, pep);
> +	max_packet =3D usb_endpoint_maxp(pep->endpoint.desc);
> +	max_burst =3D cdnsp_get_endpoint_max_burst(&pdev->gadget, pep);
> +	avg_trb_len =3D max_esit_payload;
> +
> +	/* Allow 3 retries for everything but isoc, set CErr =3D 3. */
> +	if (!usb_endpoint_xfer_isoc(pep->endpoint.desc))
> +		err_count =3D 3;
> +	if (usb_endpoint_xfer_bulk(pep->endpoint.desc) &&
> +	    pdev->gadget.speed =3D=3D USB_SPEED_HIGH)
> +		max_packet =3D 512;
> +	/* Controller spec indicates that ctrl ep avg TRB Length should be 8. *=
/
> +	if (usb_endpoint_xfer_control(pep->endpoint.desc))
> +		avg_trb_len =3D 8;
> +
> +	/* Set up the endpoint ring. */
> +	pep->ring =3D cdnsp_ring_alloc(pdev, 2, ring_type, max_packet, mem_flag=
s);
> +	pep->skip =3D false;
> +
> +	/* Fill the endpoint context */
> +	ep_ctx->ep_info =3D cpu_to_le32(EP_MAX_ESIT_PAYLOAD_HI(max_esit_payload=
) |
> +				EP_INTERVAL(interval) | EP_MULT(mult));
> +	ep_ctx->ep_info2 =3D cpu_to_le32(EP_TYPE(endpoint_type) |
> +				MAX_PACKET(max_packet) | MAX_BURST(max_burst) |
> +				ERROR_COUNT(err_count));
> +	ep_ctx->deq =3D cpu_to_le64(pep->ring->first_seg->dma |
> +				  pep->ring->cycle_state);
> +
> +	ep_ctx->tx_info =3D cpu_to_le32(EP_MAX_ESIT_PAYLOAD_LO(max_esit_payload=
) |
> +				EP_AVG_TRB_LENGTH(avg_trb_len));
> +
> +	if (usb_endpoint_xfer_bulk(pep->endpoint.desc) &&
> +	    pdev->gadget.speed > USB_SPEED_HIGH) {
> +		ret =3D cdnsp_alloc_streams(pdev, pep);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +void cdnsp_endpoint_zero(struct cdnsp_device *pdev, struct cdnsp_ep *pep=
)
> +{
> +	pep->in_ctx->ep_info =3D 0;
> +	pep->in_ctx->ep_info2 =3D 0;
> +	pep->in_ctx->deq =3D 0;
> +	pep->in_ctx->tx_info =3D 0;
> +}
> +
> +static int cdnsp_alloc_erst(struct cdnsp_device *pdev,
> +			    struct cdnsp_ring *evt_ring,
> +			    struct cdnsp_erst *erst,
> +			    gfp_t flags)
> +{
> +	struct cdnsp_erst_entry *entry;
> +	struct cdnsp_segment *seg;
> +	unsigned int val;
> +	size_t size;
> +
> +	size =3D sizeof(struct cdnsp_erst_entry) * evt_ring->num_segs;
> +	erst->entries =3D dma_alloc_coherent(pdev->dev, size,
> +					   &erst->erst_dma_addr, flags);
> +	if (!erst->entries)
> +		return -ENOMEM;
> +
> +	erst->num_entries =3D evt_ring->num_segs;
> +
> +	seg =3D evt_ring->first_seg;
> +	for (val =3D 0; val < evt_ring->num_segs; val++) {
> +		entry =3D &erst->entries[val];
> +		entry->seg_addr =3D cpu_to_le64(seg->dma);
> +		entry->seg_size =3D cpu_to_le32(TRBS_PER_SEGMENT);
> +		entry->rsvd =3D 0;
> +		seg =3D seg->next;
> +	}
> +
> +	return 0;
> +}
> +
> +static void cdnsp_free_erst(struct cdnsp_device *pdev, struct cdnsp_erst=
 *erst)
> +{
> +	size_t size =3D sizeof(struct cdnsp_erst_entry) * (erst->num_entries);
> +	struct device *dev =3D pdev->dev;
> +
> +	if (erst->entries)
> +		dma_free_coherent(dev, size, erst->entries,
> +				  erst->erst_dma_addr);
> +
> +	erst->entries =3D NULL;
> +}
> +
> +void cdnsp_mem_cleanup(struct cdnsp_device *pdev)
> +{
> +	struct device *dev =3D pdev->dev;
> +
> +	cdnsp_free_priv_device(pdev);
> +	cdnsp_free_erst(pdev, &pdev->erst);
> +
> +	if (pdev->event_ring)
> +		cdnsp_ring_free(pdev, pdev->event_ring);
> +
> +	pdev->event_ring =3D NULL;
> +
> +	if (pdev->cmd_ring)
> +		cdnsp_ring_free(pdev, pdev->cmd_ring);
> +
> +	pdev->cmd_ring =3D NULL;
> +
> +	dma_pool_destroy(pdev->segment_pool);
> +	pdev->segment_pool =3D NULL;
> +	dma_pool_destroy(pdev->device_pool);
> +	pdev->device_pool =3D NULL;
> +
> +	if (pdev->dcbaa)
> +		dma_free_coherent(dev, sizeof(*pdev->dcbaa),
> +				  pdev->dcbaa, pdev->dcbaa->dma);
> +
> +	pdev->dcbaa =3D NULL;
> +
> +	pdev->usb2_port.exist =3D 0;
> +	pdev->usb3_port.exist =3D 0;
> +	pdev->usb2_port.port_num =3D 0;
> +	pdev->usb3_port.port_num =3D 0;
> +	pdev->active_port =3D NULL;
> +}
> +
> +static void cdnsp_set_event_deq(struct cdnsp_device *pdev)
> +{
> +	dma_addr_t deq;
> +	u64 temp;
> +
> +	deq =3D cdnsp_trb_virt_to_dma(pdev->event_ring->deq_seg,
> +				    pdev->event_ring->dequeue);
> +
> +	/* Update controller event ring dequeue pointer */
> +	temp =3D cdnsp_read_64(pdev, &pdev->ir_set->erst_dequeue);
> +	temp &=3D ERST_PTR_MASK;
> +
> +	/*
> +	 * Don't clear the EHB bit (which is RW1C) because
> +	 * there might be more events to service.
> +	 */
> +	temp &=3D ~ERST_EHB;
> +
> +	cdnsp_write_64(pdev, ((u64)deq & (u64)~ERST_PTR_MASK) | temp,
> +		       &pdev->ir_set->erst_dequeue);
> +}
> +
> +static void cdnsp_add_in_port(struct cdnsp_device *pdev,
> +			      struct cdnsp_port *port,
> +			      __le32 __iomem *addr)
> +{
> +	u32 temp, port_offset;
> +
> +	temp =3D readl(addr);
> +	port->maj_rev =3D CDNSP_EXT_PORT_MAJOR(temp);
> +	port->min_rev =3D CDNSP_EXT_PORT_MINOR(temp);
> +
> +	/* Port offset and count in the third dword.*/
> +	temp =3D readl(addr + 2);
> +	port_offset =3D CDNSP_EXT_PORT_OFF(temp);
> +
> +	port->port_num =3D port_offset;
> +	port->exist =3D 1;
> +}
> +
> +/*
> + * Scan the Extended Capabilities for the "Supported Protocol Capabiliti=
es" that
> + * specify what speeds each port is supposed to be.
> + */
> +static int cdnsp_setup_port_arrays(struct cdnsp_device *pdev, gfp_t flag=
s)
> +{
> +	void __iomem *base;
> +	u32 offset =3D 0;
> +	int i;
> +
> +	base =3D &pdev->cap_regs->hc_capbase;
> +	offset =3D cdnsp_find_next_ext_cap(base, offset,
> +					 EXT_CAP_CFG_DEV_20PORT_CAP_ID);
> +	pdev->port20_regs =3D base + offset;
> +
> +	base =3D &pdev->cap_regs->hc_capbase;
> +	offset =3D cdnsp_find_next_ext_cap(base, offset, D_XEC_CFG_3XPORT_CAP);
> +	pdev->port3x_regs =3D  base + offset;
> +
> +	offset =3D 0;
> +	base =3D &pdev->cap_regs->hc_capbase;
> +
> +	/* Driver expects max 2 extended protocol capability. */
> +	for (i =3D 0; i < 2; i++) {
> +		u32 temp;
> +
> +		offset =3D cdnsp_find_next_ext_cap(base, offset,
> +						 EXT_CAPS_PROTOCOL);
> +		temp =3D readl(base + offset);
> +
> +		if (CDNSP_EXT_PORT_MAJOR(temp) =3D=3D 0x03 &&
> +		    !pdev->usb3_port.port_num)
> +			cdnsp_add_in_port(pdev, &pdev->usb3_port,
> +					  base + offset);
> +
> +		if (CDNSP_EXT_PORT_MAJOR(temp) =3D=3D 0x02 &&
> +		    !pdev->usb2_port.port_num)
> +			cdnsp_add_in_port(pdev, &pdev->usb2_port,
> +					  base + offset);
> +	}
> +
> +	if (!pdev->usb2_port.exist || !pdev->usb3_port.exist) {
> +		dev_err(pdev->dev, "Error: Only one port detected\n");
> +		return -ENODEV;
> +	}
> +
> +	pdev->usb2_port.regs =3D (struct cdnsp_port_regs *)
> +			       (&pdev->op_regs->port_reg_base + NUM_PORT_REGS *
> +				(pdev->usb2_port.port_num - 1));
> +
> +	pdev->usb3_port.regs =3D (struct cdnsp_port_regs *)
> +			       (&pdev->op_regs->port_reg_base + NUM_PORT_REGS *
> +				(pdev->usb3_port.port_num - 1));
> +
> +	return 0;
> +}
> +
> +/*
> + * Initialize memory for CDNSP (one-time init).
> + *
> + * Program the PAGESIZE register, initialize the device context array, c=
reate
> + * device contexts, set up a command ring segment, create event
> + * ring (one for now).
> + */
> +int cdnsp_mem_init(struct cdnsp_device *pdev, gfp_t flags)
> +{
> +	struct device *dev =3D pdev->dev;
> +	int ret =3D -ENOMEM;
> +	unsigned int val;
> +	dma_addr_t dma;
> +	u32 page_size;
> +	u64 val_64;
> +
> +	/*
> +	 * Use 4K pages, since that's common and the minimum the
> +	 * controller supports
> +	 */
> +	page_size =3D 1 << 12;
> +
> +	val =3D readl(&pdev->op_regs->config_reg);
> +	val |=3D ((val & ~MAX_DEVS) | CDNSP_DEV_MAX_SLOTS) | CONFIG_U3E;
> +	writel(val, &pdev->op_regs->config_reg);
> +
> +	/*
> +	 * Doorbell array must be physically contiguous
> +	 * and 64-byte (cache line) aligned.
> +	 */
> +	pdev->dcbaa =3D dma_alloc_coherent(dev, sizeof(*pdev->dcbaa),
> +					 &dma, GFP_KERNEL);
> +	if (!pdev->dcbaa)
> +		goto mem_init_fail;
> +
> +	memset(pdev->dcbaa, 0, sizeof(*pdev->dcbaa));
> +	pdev->dcbaa->dma =3D dma;
> +
> +	cdnsp_write_64(pdev, dma, &pdev->op_regs->dcbaa_ptr);
> +
> +	/*
> +	 * Initialize the ring segment pool.  The ring must be a contiguous
> +	 * structure comprised of TRBs. The TRBs must be 16 byte aligned,
> +	 * however, the command ring segment needs 64-byte aligned segments
> +	 * and our use of dma addresses in the trb_address_map radix tree needs
> +	 * TRB_SEGMENT_SIZE alignment, so driver pick the greater alignment
> +	 * need.
> +	 */
> +	pdev->segment_pool =3D dma_pool_create("CDNSP ring segments", dev,
> +					     TRB_SEGMENT_SIZE, TRB_SEGMENT_SIZE,
> +					     page_size);
> +
> +	pdev->device_pool =3D dma_pool_create("CDNSP input/output contexts", de=
v,
> +					    CDNSP_CTX_SIZE, 64, page_size);
> +
> +	if (!pdev->segment_pool || !pdev->device_pool)
> +		goto mem_init_fail;
> +
> +	/* Set up the command ring to have one segments for now. */
> +	pdev->cmd_ring =3D cdnsp_ring_alloc(pdev, 1, TYPE_COMMAND, 0, flags);
> +	if (!pdev->cmd_ring)
> +		goto mem_init_fail;
> +
> +	/* Set the address in the Command Ring Control register */
> +	val_64 =3D cdnsp_read_64(pdev, &pdev->op_regs->cmd_ring);
> +	val_64 =3D (val_64 & (u64)CMD_RING_RSVD_BITS) |
> +		 (pdev->cmd_ring->first_seg->dma & (u64)~CMD_RING_RSVD_BITS) |
> +		 pdev->cmd_ring->cycle_state;
> +	cdnsp_write_64(pdev, val_64, &pdev->op_regs->cmd_ring);
> +
> +	val =3D readl(&pdev->cap_regs->db_off);
> +	val &=3D DBOFF_MASK;
> +	pdev->dba =3D (void __iomem *)pdev->cap_regs + val;
> +
> +	/* Set ir_set to interrupt register set 0 */
> +	pdev->ir_set =3D &pdev->run_regs->ir_set[0];
> +
> +	/*
> +	 * Event ring setup: Allocate a normal ring, but also setup
> +	 * the event ring segment table (ERST).
> +	 */
> +	pdev->event_ring =3D cdnsp_ring_alloc(pdev, ERST_NUM_SEGS, TYPE_EVENT,
> +					    0, flags);
> +	if (!pdev->event_ring)
> +		goto mem_init_fail;
> +
> +	ret =3D cdnsp_alloc_erst(pdev, pdev->event_ring, &pdev->erst, flags);
> +	if (ret)
> +		goto mem_init_fail;
> +
> +	/* Set ERST count with the number of entries in the segment table. */
> +	val =3D readl(&pdev->ir_set->erst_size);
> +	val &=3D ERST_SIZE_MASK;
> +	val |=3D ERST_NUM_SEGS;
> +	writel(val, &pdev->ir_set->erst_size);
> +
> +	/* Set the segment table base address. */
> +	val_64 =3D cdnsp_read_64(pdev, &pdev->ir_set->erst_base);
> +	val_64 &=3D ERST_PTR_MASK;
> +	val_64 |=3D (pdev->erst.erst_dma_addr & (u64)~ERST_PTR_MASK);
> +	cdnsp_write_64(pdev, val_64, &pdev->ir_set->erst_base);
> +
> +	/* Set the event ring dequeue address. */
> +	cdnsp_set_event_deq(pdev);
> +
> +	ret =3D cdnsp_setup_port_arrays(pdev, flags);
> +	if (ret)
> +		goto mem_init_fail;
> +
> +	ret =3D cdnsp_alloc_priv_device(pdev, GFP_ATOMIC);
> +	if (ret) {
> +		dev_err(pdev->dev,
> +			"Could not allocate cdnsp_device data structures\n");
> +		goto mem_init_fail;
> +	}
> +
> +	return 0;
> +
> +mem_init_fail:
> +	dev_err(pdev->dev, "Couldn't initialize memory\n");
> +	cdnsp_halt(pdev);
> +	cdnsp_reset(pdev);
> +	cdnsp_mem_cleanup(pdev);
> +
> +	return ret;
> +}
> +
> diff --git a/drivers/usb/cdnsp/ring.c b/drivers/usb/cdnsp/ring.c
> new file mode 100644
> index 000000000000..b7fdfbbebcc0
> --- /dev/null
> +++ b/drivers/usb/cdnsp/ring.c
> @@ -0,0 +1,2363 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Cadence CDNSP DRD Driver.
> + *
> + * Copyright (C) 2020 Cadence.
> + *
> + * Author: Pawel Laszczak <pawell@cadence.com>
> + *
> + * Code based on Linux XHCI driver.
> + * Origin: Copyright (C) 2008 Intel Corp
> + */
> +
> +/*
> + * Ring initialization rules:
> + * 1. Each segment is initialized to zero, except for link TRBs.
> + * 2. Ring cycle state =3D 0. This represents Producer Cycle State (PCS)=
 or
> + *    Consumer Cycle State (CCS), depending on ring function.
> + * 3. Enqueue pointer =3D dequeue pointer =3D address of first TRB in th=
e segment.
> + *
> + * Ring behavior rules:
> + * 1. A ring is empty if enqueue =3D=3D dequeue. This means there will a=
lways be at
> + *    least one free TRB in the ring. This is useful if you want to turn=
 that
> + *    into a link TRB and expand the ring.
> + * 2. When incrementing an enqueue or dequeue pointer, if the next TRB i=
s a
> + *    link TRB, then load the pointer with the address in the link TRB. =
If the
> + *    link TRB had its toggle bit set, you may need to update the ring c=
ycle
> + *    state (see cycle bit rules). You may have to do this multiple time=
s
> + *    until you reach a non-link TRB.
> + * 3. A ring is full if enqueue++ (for the definition of increment above=
)
> + *    equals the dequeue pointer.
> + *
> + * Cycle bit rules:
> + * 1. When a consumer increments a dequeue pointer and encounters a togg=
le bit
> + *    in a link TRB, it must toggle the ring cycle state.
> + * 2. When a producer increments an enqueue pointer and encounters a tog=
gle bit
> + *    in a link TRB, it must toggle the ring cycle state.
> + *
> + * Producer rules:
> + * 1. Check if ring is full before you enqueue.
> + * 2. Write the ring cycle state to the cycle bit in the TRB you're enqu=
euing.
> + *    Update enqueue pointer between each write (which may update the ri=
ng
> + *    cycle state).
> + * 3. Notify consumer. If SW is producer, it rings the doorbell for comm=
and
> + *    and endpoint rings. If controller is the producer for the event ri=
ng,
> + *    and it generates an interrupt according to interrupt modulation ru=
les.
> + *
> + * Consumer rules:
> + * 1. Check if TRB belongs to you. If the cycle bit =3D=3D your ring cyc=
le state,
> + *    the TRB is owned by the consumer.
> + * 2. Update dequeue pointer (which may update the ring cycle state) and
> + *    continue processing TRBs until you reach a TRB which is not owned =
by you.
> + * 3. Notify the producer. SW is the consumer for the event ring, and it
> + *    updates event ring dequeue pointer. Controller is the consumer for=
 the
> + *    command and endpoint rings; it generates events on the event ring
> + *    for these.
> + */
> +
> +#include <linux/scatterlist.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/delay.h>
> +#include <linux/slab.h>
> +#include <linux/irq.h>
> +
> +#include "gadget.h"
> +
> +/*
> + * Returns zero if the TRB isn't in this segment, otherwise it returns t=
he DMA
> + * address of the TRB.
> + */
> +dma_addr_t cdnsp_trb_virt_to_dma(struct cdnsp_segment *seg,
> +				 union cdnsp_trb *trb)
> +{
> +	unsigned long segment_offset =3D trb - seg->trbs;
> +
> +	if (trb < seg->trbs || segment_offset >=3D TRBS_PER_SEGMENT)
> +		return 0;
> +
> +	return seg->dma + (segment_offset * sizeof(*trb));
> +}
> +
> +static bool cdnsp_trb_is_noop(union cdnsp_trb *trb)
> +{
> +	return TRB_TYPE_NOOP_LE32(trb->generic.field[3]);
> +}
> +
> +static bool cdnsp_trb_is_link(union cdnsp_trb *trb)
> +{
> +	return TRB_TYPE_LINK_LE32(trb->link.control);
> +}
> +
> +bool cdnsp_last_trb_on_seg(struct cdnsp_segment *seg, union cdnsp_trb *t=
rb)
> +{
> +	return trb =3D=3D &seg->trbs[TRBS_PER_SEGMENT - 1];
> +}
> +
> +bool cdnsp_last_trb_on_ring(struct cdnsp_ring *ring,
> +			    struct cdnsp_segment *seg,
> +			    union cdnsp_trb *trb)
> +{
> +	return cdnsp_last_trb_on_seg(seg, trb) && (seg->next =3D=3D ring->first=
_seg);
> +}
> +
> +static bool cdnsp_link_trb_toggles_cycle(union cdnsp_trb *trb)
> +{
> +	return le32_to_cpu(trb->link.control) & LINK_TOGGLE;
> +}
> +
> +static void cdnsp_trb_to_noop(union cdnsp_trb *trb, u32 noop_type)
> +{
> +	if (cdnsp_trb_is_link(trb)) {
> +		/* Unchain chained link TRBs. */
> +		trb->link.control &=3D cpu_to_le32(~TRB_CHAIN);
> +	} else {
> +		trb->generic.field[0] =3D 0;
> +		trb->generic.field[1] =3D 0;
> +		trb->generic.field[2] =3D 0;
> +		/* Preserve only the cycle bit of this TRB. */
> +		trb->generic.field[3] &=3D cpu_to_le32(TRB_CYCLE);
> +		trb->generic.field[3] |=3D cpu_to_le32(TRB_TYPE(noop_type));
> +	}
> +}
> +
> +/*
> + * Updates trb to point to the next TRB in the ring, and updates seg if =
the next
> + * TRB is in a new segment. This does not skip over link TRBs, and it do=
es not
> + * effect the ring dequeue or enqueue pointers.
> + */
> +static void cdnsp_next_trb(struct cdnsp_device *pdev,
> +			   struct cdnsp_ring *ring,
> +			   struct cdnsp_segment **seg,
> +			   union cdnsp_trb **trb)
> +{
> +	if (cdnsp_trb_is_link(*trb)) {
> +		*seg =3D (*seg)->next;
> +		*trb =3D ((*seg)->trbs);
> +	} else {
> +		(*trb)++;
> +	}
> +}
> +
> +/*
> + * See Cycle bit rules. SW is the consumer for the event ring only.
> + * Don't make a ring full of link TRBs. That would be dumb and this woul=
d loop.
> + */
> +void cdnsp_inc_deq(struct cdnsp_device *pdev, struct cdnsp_ring *ring)
> +{
> +	/* event ring doesn't have link trbs, check for last trb. */
> +	if (ring->type =3D=3D TYPE_EVENT) {
> +		if (!cdnsp_last_trb_on_seg(ring->deq_seg, ring->dequeue)) {
> +			ring->dequeue++;
> +			return;
> +		}
> +
> +		if (cdnsp_last_trb_on_ring(ring, ring->deq_seg, ring->dequeue))
> +			ring->cycle_state ^=3D 1;
> +
> +		ring->deq_seg =3D ring->deq_seg->next;
> +		ring->dequeue =3D ring->deq_seg->trbs;
> +		return;
> +	}
> +
> +	/* All other rings have link trbs. */
> +	if (!cdnsp_trb_is_link(ring->dequeue)) {
> +		ring->dequeue++;
> +		ring->num_trbs_free++;
> +	}
> +	while (cdnsp_trb_is_link(ring->dequeue)) {
> +		ring->deq_seg =3D ring->deq_seg->next;
> +		ring->dequeue =3D ring->deq_seg->trbs;
> +	}
> +}
> +
> +/*
> + * See Cycle bit rules. SW is the consumer for the event ring only.
> + * Don't make a ring full of link TRBs. That would be dumb and this woul=
d loop.
> + *
> + * If we've just enqueued a TRB that is in the middle of a TD (meaning t=
he
> + * chain bit is set), then set the chain bit in all the following link T=
RBs.
> + * If we've enqueued the last TRB in a TD, make sure the following link =
TRBs
> + * have their chain bit cleared (so that each Link TRB is a separate TD)=
.
> + *
> + * @more_trbs_coming:	Will you enqueue more TRBs before ringing the door=
bell.
> + */
> +static void cdnsp_inc_enq(struct cdnsp_device *pdev,
> +			  struct cdnsp_ring *ring,
> +			  bool more_trbs_coming)
> +{
> +	union cdnsp_trb *next;
> +	u32 chain;
> +
> +	chain =3D le32_to_cpu(ring->enqueue->generic.field[3]) & TRB_CHAIN;
> +
> +	/* If this is not event ring, there is one less usable TRB. */
> +	if (!cdnsp_trb_is_link(ring->enqueue))
> +		ring->num_trbs_free--;
> +	next =3D ++(ring->enqueue);
> +
> +	/* Update the dequeue pointer further if that was a link TRB */
> +	while (cdnsp_trb_is_link(next)) {
> +		/*
> +		 * If the caller doesn't plan on enqueuing more TDs before
> +		 * ringing the doorbell, then we don't want to give the link TRB
> +		 * to the hardware just yet. We'll give the link TRB back in
> +		 * cdnsp_prepare_ring() just before we enqueue the TD at the
> +		 * top of the ring.
> +		 */
> +		if (!chain && !more_trbs_coming)
> +			break;
> +
> +		next->link.control &=3D cpu_to_le32(~TRB_CHAIN);
> +		next->link.control |=3D cpu_to_le32(chain);
> +
> +		/* Give this link TRB to the hardware */
> +		wmb();
> +		next->link.control ^=3D cpu_to_le32(TRB_CYCLE);
> +
> +		/* Toggle the cycle bit after the last ring segment. */
> +		if (cdnsp_link_trb_toggles_cycle(next))
> +			ring->cycle_state ^=3D 1;
> +
> +		ring->enq_seg =3D ring->enq_seg->next;
> +		ring->enqueue =3D ring->enq_seg->trbs;
> +		next =3D ring->enqueue;
> +	}
> +}
> +
> +/*
> + * Check to see if there's room to enqueue num_trbs on the ring and make=
 sure
> + * enqueue pointer will not advance into dequeue segment.
> + */
> +static bool cdnsp_room_on_ring(struct cdnsp_device *pdev,
> +			       struct cdnsp_ring *ring,
> +			       unsigned int num_trbs)
> +{
> +	int num_trbs_in_deq_seg;
> +
> +	if (ring->num_trbs_free < num_trbs)
> +		return false;
> +
> +	if (ring->type !=3D TYPE_COMMAND && ring->type !=3D TYPE_EVENT) {
> +		num_trbs_in_deq_seg =3D ring->dequeue - ring->deq_seg->trbs;
> +
> +		if (ring->num_trbs_free < num_trbs + num_trbs_in_deq_seg)
> +			return false;
> +	}
> +
> +	return true;
> +}
> +
> +/* Ring the doorbell after placing a command on the ring. */
> +void cdnsp_ring_cmd_db(struct cdnsp_device *pdev)
> +{
> +	writel(DB_VALUE_CMD, &pdev->dba->cmd_db);
> +}
> +
> +/*
> + * Ring the doorbell after placing a transfer on the ring.
> + * Returns true if doorbell was set, otherwise false.
> + */
> +static bool cdnsp_ring_ep_doorbell(struct cdnsp_device *pdev,
> +				   struct cdnsp_ep *pep,
> +				   unsigned int stream_id)
> +{
> +	__le32 __iomem *reg_addr =3D &pdev->dba->ep_db;
> +	unsigned int ep_state =3D pep->ep_state;
> +	unsigned int db_value;
> +
> +	/*
> +	 * Don't ring the doorbell for this endpoint if endpoint is halted or
> +	 * disabled.
> +	 */
> +	if (ep_state & EP_HALTED || !(ep_state & EP_ENABLED))
> +		return false;
> +
> +	/* For stream capable endpoints driver can ring doorbell only twice. */
> +	if (pep->ep_state & EP_HAS_STREAMS) {
> +		if (pep->stream_info.drbls_count >=3D 2)
> +			return false;
> +
> +		pep->stream_info.drbls_count++;
> +	}
> +
> +	pep->ep_state &=3D ~EP_STOPPED;
> +
> +	if (pep->idx =3D=3D 0 && pdev->ep0_stage =3D=3D CDNSP_DATA_STAGE &&
> +	    !pdev->ep0_expect_in)
> +		db_value =3D DB_VALUE_EP0_OUT(pep->idx, stream_id);
> +	else
> +		db_value =3D DB_VALUE(pep->idx, stream_id);
> +
> +	writel(db_value, reg_addr);
> +
> +	/* Doorbell was set. */
> +	return true;
> +}
> +
> +/*
> + * Get the right ring for the given pep and stream_id.
> + * If the endpoint supports streams, boundary check the USB request's st=
ream ID.
> + * If the endpoint doesn't support streams, return the singular endpoint=
 ring.
> + */
> +static struct cdnsp_ring *cdnsp_get_transfer_ring(struct cdnsp_device *p=
dev,
> +						  struct cdnsp_ep *pep,
> +						  unsigned int stream_id)
> +{
> +	if (!(pep->ep_state & EP_HAS_STREAMS))
> +		return pep->ring;
> +
> +	if (stream_id =3D=3D 0 || stream_id >=3D pep->stream_info.num_streams) =
{
> +		dev_err(pdev->dev, "ERR: %s ring doesn't exist for SID: %d.\n",
> +			pep->name, stream_id);
> +		return NULL;
> +	}
> +
> +	return pep->stream_info.stream_rings[stream_id];
> +}
> +
> +static struct cdnsp_ring *
> +	cdnsp_request_to_transfer_ring(struct cdnsp_device *pdev,
> +				       struct cdnsp_request *preq)
> +{
> +	return cdnsp_get_transfer_ring(pdev, preq->pep,
> +				       preq->request.stream_id);
> +}
> +
> +/* Ring the doorbell for any rings with pending requests. */
> +void cdnsp_ring_doorbell_for_active_rings(struct cdnsp_device *pdev,
> +					  struct cdnsp_ep *pep)
> +{
> +	struct cdnsp_stream_info *stream_info;
> +	unsigned int stream_id;
> +	int ret;
> +
> +	if (pep->ep_state & EP_DIS_IN_RROGRESS)
> +		return;
> +
> +	/* A ring has pending Request if its TD list is not empty. */
> +	if (!(pep->ep_state & EP_HAS_STREAMS) && pep->number) {
> +		if (pep->ring && !list_empty(&pep->ring->td_list))
> +			cdnsp_ring_ep_doorbell(pdev, pep, 0);
> +		return;
> +	}
> +
> +	stream_info =3D &pep->stream_info;
> +
> +	for (stream_id =3D 1; stream_id < stream_info->num_streams; stream_id++=
) {
> +		struct cdnsp_td *td, *td_temp;
> +		struct cdnsp_ring *ep_ring;
> +
> +		if (stream_info->drbls_count >=3D 2)
> +			return;
> +
> +		ep_ring =3D cdnsp_get_transfer_ring(pdev, pep, stream_id);
> +		if (!ep_ring)
> +			continue;
> +
> +		if (!ep_ring->stream_active || ep_ring->stream_rejected)
> +			continue;
> +
> +		list_for_each_entry_safe(td, td_temp, &ep_ring->td_list,
> +					 td_list) {
> +			if (td->drbl)
> +				continue;
> +
> +			ret =3D cdnsp_ring_ep_doorbell(pdev, pep, stream_id);
> +			if (ret)
> +				td->drbl =3D 1;
> +		}
> +	}
> +}
> +
> +/*
> + * Get the hw dequeue pointer controller stopped on, either directly fro=
m the
> + * endpoint context, or if streams are in use from the stream context.
> + * The returned hw_dequeue contains the lowest four bits with cycle stat=
e
> + * and possible stream context type.
> + */
> +static u64 cdnsp_get_hw_deq(struct cdnsp_device *pdev,
> +			    unsigned int ep_index,
> +			    unsigned int stream_id)
> +{
> +	struct cdnsp_stream_ctx *st_ctx;
> +	struct cdnsp_ep *pep;
> +
> +	pep =3D &pdev->eps[stream_id];
> +
> +	if (pep->ep_state & EP_HAS_STREAMS) {
> +		st_ctx =3D &pep->stream_info.stream_ctx_array[stream_id];
> +		return le64_to_cpu(st_ctx->stream_ring);
> +	}
> +
> +	return le64_to_cpu(pep->out_ctx->deq);
> +}
> +
> +/*
> + * Move the controller endpoint ring dequeue pointer past cur_td.
> + * Record the new state of the controller endpoint ring dequeue segment,
> + * dequeue pointer, and new consumer cycle state in state.
> + * Update internal representation of the ring's dequeue pointer.
> + *
> + * We do this in three jumps:
> + *  - First we update our new ring state to be the same as when the
> + *    controller stopped.
> + *  - Then we traverse the ring to find the segment that contains
> + *    the last TRB in the TD. We toggle the controller new cycle state
> + *    when we pass any link TRBs with the toggle cycle bit set.
> + *  - Finally we move the dequeue state one TRB further, toggling the cy=
cle bit
> + *    if we've moved it past a link TRB with the toggle cycle bit set.
> + */
> +static void cdnsp_find_new_dequeue_state(struct cdnsp_device *pdev,
> +					 struct cdnsp_ep *pep,
> +					 unsigned int stream_id,
> +					 struct cdnsp_td *cur_td,
> +					 struct cdnsp_dequeue_state *state)
> +{
> +	bool td_last_trb_found =3D false;
> +	struct cdnsp_segment *new_seg;
> +	struct cdnsp_ring *ep_ring;
> +	union cdnsp_trb *new_deq;
> +	bool cycle_found =3D false;
> +	u64 hw_dequeue;
> +
> +	ep_ring =3D cdnsp_get_transfer_ring(pdev, pep, stream_id);
> +	if (!ep_ring)
> +		return;
> +
> +	/*
> +	 * Dig out the cycle state saved by the controller during the
> +	 * stop endpoint command.
> +	 */
> +	hw_dequeue =3D cdnsp_get_hw_deq(pdev, pep->idx, stream_id);
> +	new_seg =3D ep_ring->deq_seg;
> +	new_deq =3D ep_ring->dequeue;
> +	state->new_cycle_state =3D hw_dequeue & 0x1;
> +	state->stream_id =3D stream_id;
> +
> +	/*
> +	 * We want to find the pointer, segment and cycle state of the new trb
> +	 * (the one after current TD's last_trb). We know the cycle state at
> +	 * hw_dequeue, so walk the ring until both hw_dequeue and last_trb are
> +	 * found.
> +	 */
> +	do {
> +		if (!cycle_found && cdnsp_trb_virt_to_dma(new_seg, new_deq)
> +		    =3D=3D (dma_addr_t)(hw_dequeue & ~0xf)) {
> +			cycle_found =3D true;
> +
> +			if (td_last_trb_found)
> +				break;
> +		}
> +
> +		if (new_deq =3D=3D cur_td->last_trb)
> +			td_last_trb_found =3D true;
> +
> +		if (cycle_found && cdnsp_trb_is_link(new_deq) &&
> +		    cdnsp_link_trb_toggles_cycle(new_deq))
> +			state->new_cycle_state ^=3D 0x1;
> +
> +		cdnsp_next_trb(pdev, ep_ring, &new_seg, &new_deq);
> +
> +		/* Search wrapped around, bail out. */
> +		if (new_deq =3D=3D pep->ring->dequeue) {
> +			dev_err(pdev->dev,
> +				"Error: Failed finding new dequeue state\n");
> +			state->new_deq_seg =3D NULL;
> +			state->new_deq_ptr =3D NULL;
> +			return;
> +		}
> +
> +	} while (!cycle_found || !td_last_trb_found);
> +
> +	state->new_deq_seg =3D new_seg;
> +	state->new_deq_ptr =3D new_deq;
> +}
> +
> +/*
> + * flip_cycle means flip the cycle bit of all but the first and last TRB=
.
> + * (The last TRB actually points to the ring enqueue pointer, which is n=
ot part
> + * of this TD.) This is used to remove partially enqueued isoc TDs from =
a ring.
> + */
> +static void cdnsp_td_to_noop(struct cdnsp_device *pdev,
> +			     struct cdnsp_ring *ep_ring,
> +			     struct cdnsp_td *td,
> +			     bool flip_cycle)
> +{
> +	struct cdnsp_segment *seg =3D td->start_seg;
> +	union cdnsp_trb *trb =3D td->first_trb;
> +
> +	while (1) {
> +		cdnsp_trb_to_noop(trb, TRB_TR_NOOP);
> +
> +		/* flip cycle if asked to */
> +		if (flip_cycle && trb !=3D td->first_trb && trb !=3D td->last_trb)
> +			trb->generic.field[3] ^=3D cpu_to_le32(TRB_CYCLE);
> +
> +		if (trb =3D=3D td->last_trb)
> +			break;
> +
> +		cdnsp_next_trb(pdev, ep_ring, &seg, &trb);
> +	}
> +}
> +
> +/*
> + * This TD is defined by the TRBs starting at start_trb in start_seg and=
 ending
> + * at end_trb, which may be in another segment. If the suspect DMA addre=
ss is a
> + * TRB in this TD, this function returns that TRB's segment. Otherwise i=
t
> + * returns 0.
> + */
> +static struct cdnsp_segment *cdnsp_trb_in_td(struct cdnsp_device *pdev,
> +					     struct cdnsp_segment *start_seg,
> +					     union cdnsp_trb *start_trb,
> +					     union cdnsp_trb *end_trb,
> +					     dma_addr_t suspect_dma)
> +{
> +	struct cdnsp_segment *cur_seg;
> +	union cdnsp_trb *temp_trb;
> +	dma_addr_t end_seg_dma;
> +	dma_addr_t end_trb_dma;
> +	dma_addr_t start_dma;
> +
> +	start_dma =3D cdnsp_trb_virt_to_dma(start_seg, start_trb);
> +	cur_seg =3D start_seg;
> +
> +	do {
> +		if (start_dma =3D=3D 0)
> +			return NULL;
> +
> +		temp_trb =3D &cur_seg->trbs[TRBS_PER_SEGMENT - 1];
> +		/* We may get an event for a Link TRB in the middle of a TD */
> +		end_seg_dma =3D cdnsp_trb_virt_to_dma(cur_seg, temp_trb);
> +		/* If the end TRB isn't in this segment, this is set to 0 */
> +		end_trb_dma =3D cdnsp_trb_virt_to_dma(cur_seg, end_trb);
> +
> +		if (end_trb_dma > 0) {
> +			/*
> +			 * The end TRB is in this segment, so suspect should
> +			 * be here
> +			 */
> +			if (start_dma <=3D end_trb_dma) {
> +				if (suspect_dma >=3D start_dma &&
> +				    suspect_dma <=3D end_trb_dma) {
> +					return cur_seg;
> +				}
> +			} else {
> +				/*
> +				 * Case for one segment with a
> +				 * TD wrapped around to the top
> +				 */
> +				if ((suspect_dma >=3D start_dma &&
> +				     suspect_dma <=3D end_seg_dma) ||
> +				    (suspect_dma >=3D cur_seg->dma &&
> +				     suspect_dma <=3D end_trb_dma)) {
> +					return cur_seg;
> +				}
> +			}
> +
> +			return NULL;
> +		}
> +
> +		/* Might still be somewhere in this segment */
> +		if (suspect_dma >=3D start_dma && suspect_dma <=3D end_seg_dma)
> +			return cur_seg;
> +
> +		cur_seg =3D cur_seg->next;
> +		start_dma =3D cdnsp_trb_virt_to_dma(cur_seg, &cur_seg->trbs[0]);
> +	} while (cur_seg !=3D start_seg);
> +
> +	return NULL;
> +}
> +
> +static void cdnsp_unmap_td_bounce_buffer(struct cdnsp_device *pdev,
> +					 struct cdnsp_ring *ring,
> +					 struct cdnsp_td *td)
> +{
> +	struct cdnsp_segment *seg =3D td->bounce_seg;
> +	struct cdnsp_request *preq;
> +	size_t len;
> +
> +	if (!seg)
> +		return;
> +
> +	preq =3D td->preq;
> +
> +	if (!preq->direction) {
> +		dma_unmap_single(pdev->dev, seg->bounce_dma,
> +				 ring->bounce_buf_len,  DMA_TO_DEVICE);
> +		return;
> +	}
> +
> +	dma_unmap_single(pdev->dev, seg->bounce_dma, ring->bounce_buf_len,
> +			 DMA_FROM_DEVICE);
> +
> +	/* For in transfers we need to copy the data from bounce to sg */
> +	len =3D sg_pcopy_from_buffer(preq->request.sg, preq->request.num_sgs,
> +				   seg->bounce_buf, seg->bounce_len,
> +				   seg->bounce_offs);
> +	if (len !=3D seg->bounce_len)
> +		dev_warn(pdev->dev, "WARN Wrong bounce buffer read length: %zu !=3D %d=
\n",
> +			 len, seg->bounce_len);
> +
> +	seg->bounce_len =3D 0;
> +	seg->bounce_offs =3D 0;
> +}
> +
> +static int cdnsp_cmd_set_deq(struct cdnsp_device *pdev,
> +			     struct cdnsp_ep *pep,
> +			     struct cdnsp_dequeue_state *deq_state)
> +{
> +	struct cdnsp_ring *ep_ring;
> +	int ret;
> +
> +	if (!deq_state->new_deq_ptr || !deq_state->new_deq_seg) {
> +		cdnsp_ring_doorbell_for_active_rings(pdev, pep);
> +		return 0;
> +	}
> +
> +	cdnsp_queue_new_dequeue_state(pdev, pep, deq_state);
> +	cdnsp_ring_cmd_db(pdev);
> +	ret =3D cdnsp_wait_for_cmd_compl(pdev);
> +
> +	/*
> +	 * Update the ring's dequeue segment and dequeue pointer
> +	 * to reflect the new position.
> +	 */
> +	ep_ring =3D cdnsp_get_transfer_ring(pdev, pep, deq_state->stream_id);
> +
> +	if (cdnsp_trb_is_link(ep_ring->dequeue)) {
> +		ep_ring->deq_seg =3D ep_ring->deq_seg->next;
> +		ep_ring->dequeue =3D ep_ring->deq_seg->trbs;
> +	}
> +
> +	while (ep_ring->dequeue !=3D deq_state->new_deq_ptr) {
> +		ep_ring->num_trbs_free++;
> +		ep_ring->dequeue++;
> +
> +		if (cdnsp_trb_is_link(ep_ring->dequeue)) {
> +			if (ep_ring->dequeue =3D=3D deq_state->new_deq_ptr)
> +				break;
> +
> +			ep_ring->deq_seg =3D ep_ring->deq_seg->next;
> +			ep_ring->dequeue =3D ep_ring->deq_seg->trbs;
> +		}
> +	}
> +
> +	/*
> +	 * Probably there was TIMEOUT during handling Set Dequeue Pointer
> +	 * command. It's critical error and controller will be stopped.
> +	 */
> +	if (ret)
> +		return -ESHUTDOWN;
> +
> +	/* Restart any rings with pending requests */
> +	cdnsp_ring_doorbell_for_active_rings(pdev, pep);
> +
> +	return 0;
> +}
> +
> +int cdnsp_remove_request(struct cdnsp_device *pdev,
> +			 struct cdnsp_request *preq,
> +			 struct cdnsp_ep *pep)
> +{
> +	struct cdnsp_dequeue_state deq_state;
> +	struct cdnsp_td *cur_td =3D NULL;
> +	struct cdnsp_ring *ep_ring;
> +	struct cdnsp_segment *seg;
> +	int status =3D -ECONNRESET;
> +	int ret =3D 0;
> +	u64 hw_deq;
> +
> +	memset(&deq_state, 0, sizeof(deq_state));
> +
> +	cur_td =3D &preq->td;
> +	ep_ring =3D cdnsp_request_to_transfer_ring(pdev, preq);
> +
> +	/*
> +	 * If we stopped on the TD we need to cancel, then we have to
> +	 * move the controller endpoint ring dequeue pointer past
> +	 * this TD.
> +	 */
> +	hw_deq =3D cdnsp_get_hw_deq(pdev, pep->idx, preq->request.stream_id);
> +	hw_deq &=3D ~0xf;
> +
> +	seg =3D cdnsp_trb_in_td(pdev, cur_td->start_seg, cur_td->first_trb,
> +			      cur_td->last_trb, hw_deq);
> +
> +	if (seg && (pep->ep_state & EP_ENABLED))
> +		cdnsp_find_new_dequeue_state(pdev, pep, preq->request.stream_id,
> +					     cur_td, &deq_state);
> +	else
> +		cdnsp_td_to_noop(pdev, ep_ring, cur_td, false);
> +
> +	/*
> +	 * The event handler won't see a completion for this TD anymore,
> +	 * so remove it from the endpoint ring's TD list.
> +	 */
> +	list_del_init(&cur_td->td_list);
> +	ep_ring->num_tds--;
> +	pep->stream_info.td_count--;
> +
> +	/*
> +	 * During disconnecting all endpoint will be disabled so we don't
> +	 * have to worry about updating dequeue pointer.
> +	 */
> +	if (pdev->cdnsp_state & CDNSP_STATE_DISCONNECT_PENDING) {
> +		status =3D -ESHUTDOWN;
> +		ret =3D cdnsp_cmd_set_deq(pdev, pep, &deq_state);
> +	}
> +
> +	cdnsp_unmap_td_bounce_buffer(pdev, ep_ring, cur_td);
> +	cdnsp_gadget_giveback(pep, cur_td->preq, status);
> +
> +	return ret;
> +}
> +
> +static int cdnsp_update_port_id(struct cdnsp_device *pdev, u32 port_id)
> +{
> +	struct cdnsp_port *port =3D pdev->active_port;
> +	u8 old_port =3D 0;
> +
> +	if (port && port->port_num =3D=3D port_id)
> +		return 0;
> +
> +	if (port)
> +		old_port =3D port->port_num;
> +
> +	if (port_id =3D=3D pdev->usb2_port.port_num) {
> +		port =3D &pdev->usb2_port;
> +	} else if (port_id =3D=3D pdev->usb3_port.port_num) {
> +		port  =3D &pdev->usb3_port;
> +	} else {
> +		dev_err(pdev->dev, "Port event with invalid port ID %d\n",
> +			port_id);
> +		return -EINVAL;
> +	}
> +
> +	if (port_id !=3D old_port) {
> +		cdnsp_disable_slot(pdev);
> +		pdev->active_port =3D port;
> +		cdnsp_enable_slot(pdev);
> +	}
> +
> +	if (port_id =3D=3D pdev->usb2_port.port_num)
> +		cdnsp_set_usb2_hardware_lpm(pdev, NULL, 1);
> +	else
> +		writel(PORT_U1_TIMEOUT(1) | PORT_U2_TIMEOUT(1),
> +		       &pdev->usb3_port.regs->portpmsc);
> +
> +	return 0;
> +}
> +
> +static void cdnsp_handle_port_status(struct cdnsp_device *pdev,
> +				     union cdnsp_trb *event)
> +{
> +	struct cdnsp_port_regs __iomem *port_regs;
> +	u32 portsc, cmd_regs;
> +	bool port2 =3D false;
> +	u32 link_state;
> +	u32 port_id;
> +
> +	/* Port status change events always have a successful completion code *=
/
> +	if (GET_COMP_CODE(le32_to_cpu(event->generic.field[2])) !=3D COMP_SUCCE=
SS)
> +		dev_err(pdev->dev, "ERR: incorrect PSC event\n");
> +
> +	port_id =3D GET_PORT_ID(le32_to_cpu(event->generic.field[0]));
> +
> +	if (cdnsp_update_port_id(pdev, port_id))
> +		goto cleanup;
> +
> +	port_regs =3D pdev->active_port->regs;
> +
> +	if (port_id =3D=3D pdev->usb2_port.port_num)
> +		port2 =3D true;
> +
> +new_event:
> +	portsc =3D readl(&port_regs->portsc);
> +	writel(cdnsp_port_state_to_neutral(portsc) |
> +	       (portsc & PORT_CHANGE_BITS), &port_regs->portsc);
> +
> +	pdev->gadget.speed =3D cdnsp_port_speed(portsc);
> +	link_state =3D portsc & PORT_PLS_MASK;
> +
> +	/* Port Link State change detected. */
> +	if ((portsc & PORT_PLC)) {
> +		if (!(pdev->cdnsp_state & CDNSP_WAKEUP_PENDING)  &&
> +		    link_state =3D=3D XDEV_RESUME) {
> +			cmd_regs =3D readl(&pdev->op_regs->command);
> +			if (!(cmd_regs & CMD_R_S))
> +				goto cleanup;
> +
> +			if (DEV_SUPERSPEED_ANY(portsc)) {
> +				cdnsp_set_link_state(pdev, &port_regs->portsc,
> +						     XDEV_U0);
> +
> +				cdnsp_resume_gadget(pdev);
> +			}
> +		}
> +
> +		if ((pdev->cdnsp_state & CDNSP_WAKEUP_PENDING) &&
> +		    link_state =3D=3D XDEV_U0) {
> +			pdev->cdnsp_state &=3D ~CDNSP_WAKEUP_PENDING;
> +
> +			cdnsp_force_header_wakeup(pdev, 1);
> +			cdnsp_ring_cmd_db(pdev);
> +			cdnsp_wait_for_cmd_compl(pdev);
> +		}
> +
> +		if (link_state =3D=3D XDEV_U0 && pdev->link_state =3D=3D XDEV_U3 &&
> +		    !DEV_SUPERSPEED_ANY(portsc))
> +			cdnsp_resume_gadget(pdev);
> +
> +		if (link_state =3D=3D XDEV_U3 &&  pdev->link_state !=3D XDEV_U3)
> +			cdnsp_suspend_gadget(pdev);
> +
> +		pdev->link_state =3D link_state;
> +	}
> +
> +	if (portsc & PORT_CSC) {
> +		/* Detach device. */
> +		if (pdev->gadget.connected && !(portsc & PORT_CONNECT))
> +			cdnsp_disconnect_gadget(pdev);
> +
> +		/* Attach device. */
> +		if (portsc & PORT_CONNECT) {
> +			if (!port2)
> +				cdnsp_irq_reset(pdev);
> +
> +			usb_gadget_set_state(&pdev->gadget, USB_STATE_ATTACHED);
> +		}
> +	}
> +
> +	/* Port reset. */
> +	if ((portsc & (PORT_RC | PORT_WRC)) && (portsc & PORT_CONNECT)) {
> +		cdnsp_irq_reset(pdev);
> +		pdev->u1_allowed =3D 0;
> +		pdev->u2_allowed =3D 0;
> +		pdev->may_wakeup =3D 0;
> +	}
> +
> +	if (portsc & PORT_CEC)
> +		dev_err(pdev->dev, "Port Over Current detected\n");
> +
> +	if (portsc & PORT_CEC)
> +		dev_err(pdev->dev, "Port Configure Error detected\n");
> +
> +	if (readl(&port_regs->portsc) & PORT_CHANGE_BITS)
> +		goto new_event;
> +
> +cleanup:
> +	cdnsp_inc_deq(pdev, pdev->event_ring);
> +}
> +
> +static void cdnsp_td_cleanup(struct cdnsp_device *pdev,
> +			     struct cdnsp_td *td,
> +			     struct cdnsp_ring *ep_ring,
> +			     int *status)
> +{
> +	struct cdnsp_request *preq =3D td->preq;
> +
> +	/* if a bounce buffer was used to align this td then unmap it */
> +	cdnsp_unmap_td_bounce_buffer(pdev, ep_ring, td);
> +
> +	/*
> +	 * If the controller said we transferred more data than the buffer
> +	 * length, Play it safe and say we didn't transfer anything.
> +	 */
> +	if (preq->request.actual > preq->request.length) {
> +		preq->request.actual =3D 0;
> +		*status =3D 0;
> +	}
> +
> +	list_del_init(&td->td_list);
> +	ep_ring->num_tds--;
> +	preq->pep->stream_info.td_count--;
> +
> +	cdnsp_gadget_giveback(preq->pep, preq, *status);
> +}
> +
> +static void cdnsp_finish_td(struct cdnsp_device *pdev,
> +			    struct cdnsp_td *td,
> +			    struct cdnsp_transfer_event *event,
> +			    struct cdnsp_ep *ep,
> +			    int *status)
> +{
> +	struct cdnsp_ring *ep_ring;
> +	u32 trb_comp_code;
> +
> +	ep_ring =3D cdnsp_dma_to_transfer_ring(ep, le64_to_cpu(event->buffer));
> +	trb_comp_code =3D GET_COMP_CODE(le32_to_cpu(event->transfer_len));
> +
> +	if (trb_comp_code =3D=3D COMP_STOPPED_LENGTH_INVALID ||
> +	    trb_comp_code =3D=3D COMP_STOPPED ||
> +	    trb_comp_code =3D=3D COMP_STOPPED_SHORT_PACKET) {
> +		/*
> +		 * The Endpoint Stop Command completion will take care of any
> +		 * stopped TDs. A stopped TD may be restarted, so don't update
> +		 * the ring dequeue pointer or take this TD off any lists yet.
> +		 */
> +		return;
> +	}
> +
> +	/* Update ring dequeue pointer */
> +	while (ep_ring->dequeue !=3D td->last_trb)
> +		cdnsp_inc_deq(pdev, ep_ring);
> +
> +	cdnsp_inc_deq(pdev, ep_ring);
> +
> +	cdnsp_td_cleanup(pdev, td, ep_ring, status);
> +}
> +
> +/* sum trb lengths from ring dequeue up to stop_trb, _excluding_ stop_tr=
b */
> +static int cdnsp_sum_trb_lengths(struct cdnsp_device *pdev,
> +				 struct cdnsp_ring *ring,
> +				 union cdnsp_trb *stop_trb)
> +{
> +	struct cdnsp_segment *seg =3D ring->deq_seg;
> +	union cdnsp_trb *trb =3D ring->dequeue;
> +	u32 sum;
> +
> +	for (sum =3D 0; trb !=3D stop_trb; cdnsp_next_trb(pdev, ring, &seg, &tr=
b)) {
> +		if (!cdnsp_trb_is_noop(trb) && !cdnsp_trb_is_link(trb))
> +			sum +=3D TRB_LEN(le32_to_cpu(trb->generic.field[2]));
> +	}
> +	return sum;
> +}
> +
> +static int cdnsp_giveback_first_trb(struct cdnsp_device *pdev,
> +				    struct cdnsp_ep *pep,
> +				    unsigned int stream_id,
> +				    int start_cycle,
> +				    struct cdnsp_generic_trb *start_trb)
> +{
> +	/*
> +	 * Pass all the TRBs to the hardware at once and make sure this write
> +	 * isn't reordered.
> +	 */
> +	wmb();
> +
> +	if (start_cycle)
> +		start_trb->field[3] |=3D cpu_to_le32(start_cycle);
> +	else
> +		start_trb->field[3] &=3D cpu_to_le32(~TRB_CYCLE);
> +
> +	if ((pep->ep_state & EP_HAS_STREAMS) &&
> +	    !pep->stream_info.first_prime_det)
> +		return 0;
> +
> +	return cdnsp_ring_ep_doorbell(pdev, pep, stream_id);
> +}
> +
> +/*
> + * Process control tds, update USB request status and actual_length.
> + */
> +static void cdnsp_process_ctrl_td(struct cdnsp_device *pdev,
> +				  struct cdnsp_td *td,
> +				  union cdnsp_trb *event_trb,
> +				  struct cdnsp_transfer_event *event,
> +				  struct cdnsp_ep *pep,
> +				  int *status)
> +{
> +	struct cdnsp_ring *ep_ring;
> +	u32 remaining;
> +	u32 trb_type;
> +
> +	trb_type =3D TRB_FIELD_TO_TYPE(le32_to_cpu(event_trb->generic.field[3])=
);
> +	ep_ring =3D cdnsp_dma_to_transfer_ring(pep, le64_to_cpu(event->buffer))=
;
> +	remaining =3D EVENT_TRB_LEN(le32_to_cpu(event->transfer_len));
> +
> +	/*
> +	 * if on data stage then update the actual_length of the USB
> +	 * request and flag it as set, so it won't be overwritten in the event
> +	 * for the last TRB.
> +	 */
> +	if (trb_type =3D=3D TRB_DATA) {
> +		td->request_length_set =3D true;
> +		td->preq->request.actual =3D td->preq->request.length - remaining;
> +	}
> +
> +	/* at status stage */
> +	if (!td->request_length_set)
> +		td->preq->request.actual =3D td->preq->request.length;
> +
> +	if (pdev->ep0_stage =3D=3D CDNSP_DATA_STAGE && pep->number =3D=3D 0 &&
> +	    pdev->three_stage_setup) {
> +		td =3D list_entry(ep_ring->td_list.next, struct cdnsp_td,
> +				td_list);
> +		pdev->ep0_stage =3D CDNSP_STATUS_STAGE;
> +
> +		cdnsp_giveback_first_trb(pdev, pep, 0, ep_ring->cycle_state,
> +					 &td->last_trb->generic);
> +		return;
> +	}
> +
> +	cdnsp_finish_td(pdev, td, event, pep, status);
> +}
> +
> +/*
> + * Process isochronous tds, update usb request status and actual_length.
> + */
> +static void cdnsp_process_isoc_td(struct cdnsp_device *pdev,
> +				  struct cdnsp_td *td,
> +				  union cdnsp_trb *ep_trb,
> +				  struct cdnsp_transfer_event *event,
> +				  struct cdnsp_ep *pep,
> +				  int status)
> +{
> +	struct cdnsp_request *preq =3D td->preq;
> +	u32 remaining, requested, ep_trb_len;
> +	bool sum_trbs_for_length =3D false;
> +	struct cdnsp_ring *ep_ring;
> +	u32 trb_comp_code;
> +	u32 td_length;
> +
> +	ep_ring =3D cdnsp_dma_to_transfer_ring(pep, le64_to_cpu(event->buffer))=
;
> +	trb_comp_code =3D GET_COMP_CODE(le32_to_cpu(event->transfer_len));
> +	remaining =3D EVENT_TRB_LEN(le32_to_cpu(event->transfer_len));
> +	ep_trb_len =3D TRB_LEN(le32_to_cpu(ep_trb->generic.field[2]));
> +
> +	requested =3D preq->request.length;
> +
> +	/* handle completion code */
> +	switch (trb_comp_code) {
> +	case COMP_SUCCESS:
> +		preq->request.status =3D 0;
> +		break;
> +	case COMP_SHORT_PACKET:
> +		preq->request.status =3D 0;
> +		sum_trbs_for_length =3D true;
> +		break;
> +	case COMP_ISOCH_BUFFER_OVERRUN:
> +	case COMP_BABBLE_DETECTED_ERROR:
> +		preq->request.status =3D -EOVERFLOW;
> +		break;
> +	case COMP_STOPPED:
> +		sum_trbs_for_length =3D true;
> +		break;
> +	case COMP_STOPPED_SHORT_PACKET:
> +		/* field normally containing residue now contains transferred */
> +		preq->request.status  =3D 0;
> +		requested =3D remaining;
> +		break;
> +	case COMP_STOPPED_LENGTH_INVALID:
> +		requested =3D 0;
> +		remaining =3D 0;
> +		break;
> +	default:
> +		sum_trbs_for_length =3D true;
> +		preq->request.status =3D -1;
> +		break;
> +	}
> +
> +	if (sum_trbs_for_length) {
> +		td_length =3D cdnsp_sum_trb_lengths(pdev, ep_ring, ep_trb);
> +		td_length +=3D ep_trb_len - remaining;
> +	} else {
> +		td_length =3D requested;
> +	}
> +
> +	td->preq->request.actual +=3D td_length;
> +
> +	cdnsp_finish_td(pdev, td, event, pep, &status);
> +}
> +
> +static void cdnsp_skip_isoc_td(struct cdnsp_device *pdev,
> +			       struct cdnsp_td *td,
> +			       struct cdnsp_transfer_event *event,
> +			       struct cdnsp_ep *pep,
> +			       int status)
> +{
> +	struct cdnsp_ring *ep_ring;
> +
> +	ep_ring =3D cdnsp_dma_to_transfer_ring(pep, le64_to_cpu(event->buffer))=
;
> +	td->preq->request.status =3D -EXDEV;
> +	td->preq->request.actual =3D 0;
> +
> +	/* Update ring dequeue pointer */
> +	while (ep_ring->dequeue !=3D td->last_trb)
> +		cdnsp_inc_deq(pdev, ep_ring);
> +
> +	cdnsp_inc_deq(pdev, ep_ring);
> +
> +	cdnsp_td_cleanup(pdev, td, ep_ring, &status);
> +}
> +
> +/*
> + * Process bulk and interrupt tds, update usb request status and actual_=
length.
> + */
> +static void cdnsp_process_bulk_intr_td(struct cdnsp_device *pdev,
> +				       struct cdnsp_td *td,
> +				       union cdnsp_trb *ep_trb,
> +				       struct cdnsp_transfer_event *event,
> +				       struct cdnsp_ep *ep,
> +				       int *status)
> +{
> +	u32 remaining, requested, ep_trb_len;
> +	struct cdnsp_ring *ep_ring;
> +	u32 trb_comp_code;
> +
> +	ep_ring =3D cdnsp_dma_to_transfer_ring(ep, le64_to_cpu(event->buffer));
> +	trb_comp_code =3D GET_COMP_CODE(le32_to_cpu(event->transfer_len));
> +	remaining =3D EVENT_TRB_LEN(le32_to_cpu(event->transfer_len));
> +	ep_trb_len =3D TRB_LEN(le32_to_cpu(ep_trb->generic.field[2]));
> +	requested =3D td->preq->request.length;
> +
> +	switch (trb_comp_code) {
> +	case COMP_SUCCESS:
> +	case COMP_SHORT_PACKET:
> +		*status =3D 0;
> +		break;
> +	case COMP_STOPPED_SHORT_PACKET:
> +		td->preq->request.actual =3D remaining;
> +		goto finish_td;
> +	case COMP_STOPPED_LENGTH_INVALID:
> +		/* Stopped on ep trb with invalid length, exclude it. */
> +		ep_trb_len =3D 0;
> +		remaining =3D 0;
> +		break;
> +	}
> +
> +	if (ep_trb =3D=3D td->last_trb)
> +		ep_trb_len =3D requested - remaining;
> +	else
> +		ep_trb_len =3D cdnsp_sum_trb_lengths(pdev, ep_ring, ep_trb) +
> +						   ep_trb_len - remaining;
> +	td->preq->request.actual =3D ep_trb_len;
> +
> +finish_td:
> +	ep->stream_info.drbls_count--;
> +
> +	cdnsp_finish_td(pdev, td, event, ep, status);
> +}
> +
> +static void cdnsp_handle_tx_nrdy(struct cdnsp_device *pdev,
> +				 struct cdnsp_transfer_event *event)
> +{
> +	struct cdnsp_generic_trb *generic;
> +	struct cdnsp_ring *ep_ring;
> +	struct cdnsp_ep *pep;
> +	int cur_stream;
> +	int ep_index;
> +	int host_sid;
> +	int dev_sid;
> +
> +	generic =3D (struct cdnsp_generic_trb *)event;
> +	ep_index =3D TRB_TO_EP_ID(le32_to_cpu(event->flags)) - 1;
> +	dev_sid =3D TRB_TO_DEV_STREAM(le32_to_cpu(generic->field[0]));
> +	host_sid =3D TRB_TO_HOST_STREAM(le32_to_cpu(generic->field[2]));
> +
> +	pep =3D &pdev->eps[ep_index];
> +
> +	if (!(pep->ep_state & EP_HAS_STREAMS))
> +		return;
> +
> +	if (host_sid =3D=3D STREAM_PRIME_ACK) {
> +		pep->stream_info.first_prime_det =3D 1;
> +		for (cur_stream =3D 1; cur_stream < pep->stream_info.num_streams;
> +		    cur_stream++) {
> +			ep_ring =3D pep->stream_info.stream_rings[cur_stream];
> +			ep_ring->stream_active =3D 1;
> +			ep_ring->stream_rejected =3D 0;
> +		}
> +	}
> +
> +	if (host_sid =3D=3D STREAM_REJECTED) {
> +		struct cdnsp_td *td, *td_temp;
> +
> +		pep->stream_info.drbls_count--;
> +		ep_ring =3D pep->stream_info.stream_rings[dev_sid];
> +		ep_ring->stream_active =3D 0;
> +		ep_ring->stream_rejected =3D 1;
> +
> +		list_for_each_entry_safe(td, td_temp, &ep_ring->td_list,
> +					 td_list) {
> +			td->drbl =3D 0;
> +		}
> +	}
> +
> +	cdnsp_ring_doorbell_for_active_rings(pdev, pep);
> +}
> +
> +/*
> + * If this function returns an error condition, it means it got a Transf=
er
> + * event with a corrupted TRB DMA address or endpoint is disabled.
> + */
> +static int cdnsp_handle_tx_event(struct cdnsp_device *pdev,
> +				 struct cdnsp_transfer_event *event)
> +{
> +	const struct usb_endpoint_descriptor *desc;
> +	bool handling_skipped_tds =3D false;
> +	struct cdnsp_segment *ep_seg;
> +	struct cdnsp_ring *ep_ring;
> +	int status =3D -EINPROGRESS;
> +	union cdnsp_trb *ep_trb;
> +	dma_addr_t ep_trb_dma;
> +	struct cdnsp_ep *pep;
> +	struct cdnsp_td *td;
> +	u32 trb_comp_code;
> +	int invalidate;
> +	int ep_index;
> +
> +	invalidate =3D le32_to_cpu(event->flags) & TRB_EVENT_INVALIDATE;
> +	ep_index =3D TRB_TO_EP_ID(le32_to_cpu(event->flags)) - 1;
> +	trb_comp_code =3D GET_COMP_CODE(le32_to_cpu(event->transfer_len));
> +	ep_trb_dma =3D le64_to_cpu(event->buffer);
> +
> +	pep =3D &pdev->eps[ep_index];
> +	ep_ring =3D cdnsp_dma_to_transfer_ring(pep, le64_to_cpu(event->buffer))=
;
> +
> +	/*
> +	 * If device is disconnect then all requests will be dequeued
> +	 * by upper layers as part of disconnect sequence.
> +	 * We don't want handle such event to avoid racing.
> +	 */
> +	if (invalidate || !pdev->gadget.connected)
> +		goto cleanup;
> +
> +	if (GET_EP_CTX_STATE(pep->out_ctx) =3D=3D EP_STATE_DISABLED)
> +		goto err_out;
> +
> +	/* Some transfer events don't always point to a trb*/
> +	if (!ep_ring) {
> +		switch (trb_comp_code) {
> +		case COMP_INVALID_STREAM_TYPE_ERROR:
> +		case COMP_INVALID_STREAM_ID_ERROR:
> +		case COMP_RING_UNDERRUN:
> +		case COMP_RING_OVERRUN:
> +			goto cleanup;
> +		default:
> +			dev_err(pdev->dev, "ERROR: %s event for unknown ring\n",
> +				pep->name);
> +			goto err_out;
> +		}
> +	}
> +
> +	/* Look for some error cases that need special treatment. */
> +	switch (trb_comp_code) {
> +	case COMP_BABBLE_DETECTED_ERROR:
> +		status =3D -EOVERFLOW;
> +		break;
> +	case COMP_RING_UNDERRUN:
> +	case COMP_RING_OVERRUN:
> +		/*
> +		 * When the Isoch ring is empty, the controller will generate
> +		 * a Ring Overrun Event for IN Isoch endpoint or Ring
> +		 * Underrun Event for OUT Isoch endpoint.
> +		 */
> +		goto cleanup;
> +	case COMP_MISSED_SERVICE_ERROR:
> +		/*
> +		 * When encounter missed service error, one or more isoc tds
> +		 * may be missed by controller.
> +		 * Set skip flag of the ep_ring; Complete the missed tds as
> +		 * short transfer when process the ep_ring next time.
> +		 */
> +		pep->skip =3D true;
> +		break;
> +	}
> +
> +	do {
> +		/*
> +		 * This TRB should be in the TD at the head of this ring's TD
> +		 * list.
> +		 */
> +		if (list_empty(&ep_ring->td_list)) {
> +			if (pep->skip)
> +				pep->skip =3D false;
> +
> +			goto cleanup;
> +		}
> +
> +		td =3D list_entry(ep_ring->td_list.next, struct cdnsp_td,
> +				td_list);
> +
> +		/* Is this a TRB in the currently executing TD? */
> +		ep_seg =3D cdnsp_trb_in_td(pdev, ep_ring->deq_seg,
> +					 ep_ring->dequeue, td->last_trb,
> +					 ep_trb_dma);
> +
> +		/*
> +		 * Skip the Force Stopped Event. The event_trb(ep_trb_dma)
> +		 * of FSE is not in the current TD pointed by ep_ring->dequeue
> +		 * because that the hardware dequeue pointer still at the
> +		 * previous TRB of the current TD. The previous TRB maybe a
> +		 * Link TD or the last TRB of the previous TD. The command
> +		 * completion handle will take care the rest.
> +		 */
> +		if (!ep_seg && (trb_comp_code =3D=3D COMP_STOPPED ||
> +				trb_comp_code =3D=3D COMP_STOPPED_LENGTH_INVALID)) {
> +			pep->skip =3D false;
> +			goto cleanup;
> +		}
> +
> +		desc =3D td->preq->pep->endpoint.desc;
> +		if (!ep_seg) {
> +			if (!pep->skip || !usb_endpoint_xfer_isoc(desc)) {
> +				/* Something is busted, give up! */
> +				dev_err(pdev->dev,
> +					"ERROR Transfer event TRB DMA ptr not "
> +					"part of current TD ep_index %d "
> +					"comp_code %u\n", ep_index,
> +					trb_comp_code);
> +				return -EINVAL;
> +			}
> +
> +			cdnsp_skip_isoc_td(pdev, td, event, pep, status);
> +			goto cleanup;
> +		}
> +
> +		if (trb_comp_code =3D=3D COMP_SHORT_PACKET)
> +			ep_ring->last_td_was_short =3D true;
> +		else
> +			ep_ring->last_td_was_short =3D false;
> +
> +		if (pep->skip) {
> +			pep->skip =3D false;
> +			cdnsp_skip_isoc_td(pdev, td, event, pep, status);
> +			goto cleanup;
> +		}
> +
> +		ep_trb =3D &ep_seg->trbs[(ep_trb_dma - ep_seg->dma)
> +				       / sizeof(*ep_trb)];
> +
> +		if (cdnsp_trb_is_noop(ep_trb))
> +			goto cleanup;
> +
> +		if (usb_endpoint_xfer_control(desc))
> +			cdnsp_process_ctrl_td(pdev, td, ep_trb, event, pep,
> +					      &status);
> +		else if (usb_endpoint_xfer_isoc(desc))
> +			cdnsp_process_isoc_td(pdev, td, ep_trb, event, pep,
> +					      status);
> +		else
> +			cdnsp_process_bulk_intr_td(pdev, td, ep_trb, event, pep,
> +						   &status);
> +cleanup:
> +		handling_skipped_tds =3D pep->skip;
> +
> +		/*
> +		 * Do not update event ring dequeue pointer if we're in a loop
> +		 * processing missed tds.
> +		 */
> +		if (!handling_skipped_tds)
> +			cdnsp_inc_deq(pdev, pdev->event_ring);
> +
> +	/*
> +	 * If ep->skip is set, it means there are missed tds on the
> +	 * endpoint ring need to take care of.
> +	 * Process them as short transfer until reach the td pointed by
> +	 * the event.
> +	 */
> +	} while (handling_skipped_tds);
> +	return 0;
> +
> +err_out:
> +	dev_err(pdev->dev, "@%016llx %08x %08x %08x %08x\n",
> +		(unsigned long long)
> +		cdnsp_trb_virt_to_dma(pdev->event_ring->deq_seg,
> +				      pdev->event_ring->dequeue),
> +		 lower_32_bits(le64_to_cpu(event->buffer)),
> +		 upper_32_bits(le64_to_cpu(event->buffer)),
> +		 le32_to_cpu(event->transfer_len),
> +		 le32_to_cpu(event->flags));
> +	return -EINVAL;
> +}
> +
> +/*
> + * This function handles all events on the event ring.
> + * Returns true for "possibly more events to process" (caller should cal=
l
> + * again), otherwise false if done.
> + */
> +static bool cdnsp_handle_event(struct cdnsp_device *pdev)
> +{
> +	unsigned int comp_code;
> +	union cdnsp_trb *event;
> +	bool update_ptrs =3D true;
> +	__le32 cycle_bit;
> +	int ret =3D 0;
> +	u32 flags;
> +
> +	event =3D pdev->event_ring->dequeue;
> +	flags =3D le32_to_cpu(event->event_cmd.flags);
> +	cycle_bit =3D (flags & TRB_CYCLE);
> +
> +	/* Does the controller or driver own the TRB? */
> +	if (cycle_bit !=3D pdev->event_ring->cycle_state)
> +		return false;
> +
> +	/*
> +	 * Barrier between reading the TRB_CYCLE (valid) flag above and any
> +	 * reads of the event's flags/data below.
> +	 */
> +	rmb();
> +
> +	switch (flags & TRB_TYPE_BITMASK) {
> +	case TRB_TYPE(TRB_COMPLETION):
> +		/*
> +		 * Command can't be handled in interrupt context so just
> +		 * increment command ring dequeue pointer.
> +		 */
> +		cdnsp_inc_deq(pdev, pdev->cmd_ring);
> +		break;
> +	case TRB_TYPE(TRB_PORT_STATUS):
> +		cdnsp_handle_port_status(pdev, event);
> +		update_ptrs =3D false;
> +		break;
> +	case TRB_TYPE(TRB_TRANSFER):
> +		ret =3D cdnsp_handle_tx_event(pdev, &event->trans_event);
> +		if (ret >=3D 0)
> +			update_ptrs =3D false;
> +		break;
> +	case TRB_TYPE(TRB_SETUP):
> +		pdev->ep0_stage =3D CDNSP_SETUP_STAGE;
> +		pdev->setup_id =3D TRB_SETUPID_TO_TYPE(flags);
> +		pdev->setup_speed =3D TRB_SETUP_SPEEDID(flags);
> +		pdev->setup =3D *((struct usb_ctrlrequest *)
> +				&event->trans_event.buffer);
> +
> +		cdnsp_setup_analyze(pdev);
> +		break;
> +	case TRB_TYPE(TRB_ENDPOINT_NRDY):
> +		cdnsp_handle_tx_nrdy(pdev, &event->trans_event);
> +		break;
> +	case TRB_TYPE(TRB_HC_EVENT): {
> +		comp_code =3D GET_COMP_CODE(le32_to_cpu(event->generic.field[2]));
> +
> +		switch (comp_code) {
> +		case COMP_EVENT_RING_FULL_ERROR:
> +			dev_err(pdev->dev, "Event Ring Full\n");
> +			break;
> +		default:
> +			dev_err(pdev->dev, "Controller error code 0x%02x\n",
> +				comp_code);
> +		}
> +
> +		break;
> +	}
> +	case TRB_TYPE(TRB_MFINDEX_WRAP):
> +	case TRB_TYPE(TRB_DRB_OVERFLOW):
> +		break;
> +	default:
> +		dev_warn(pdev->dev, "ERROR unknown event type %ld\n",
> +			 TRB_FIELD_TO_TYPE(flags));
> +	}
> +
> +	if (update_ptrs)
> +		/* Update SW event ring dequeue pointer. */
> +		cdnsp_inc_deq(pdev, pdev->event_ring);
> +
> +	/*
> +	 * Caller will call us again to check if there are more items
> +	 * on the event ring.
> +	 */
> +	return true;
> +}
> +
> +irqreturn_t cdnsp_thread_irq_handler(int irq, void *data)
> +{
> +	struct cdnsp_device *pdev =3D (struct cdnsp_device *)data;
> +	union cdnsp_trb *event_ring_deq;
> +	int counter =3D 0;
> +
> +	spin_lock(&pdev->lock);
> +
> +	if (pdev->cdnsp_state & (CDNSP_STATE_HALTED | CDNSP_STATE_DYING)) {
> +		cdnsp_died(pdev);
> +		spin_unlock(&pdev->lock);
> +		return IRQ_HANDLED;
> +	}
> +
> +	event_ring_deq =3D pdev->event_ring->dequeue;
> +
> +	while (cdnsp_handle_event(pdev)) {
> +		if (++counter >=3D TRBS_PER_EV_DEQ_UPDATE) {
> +			cdnsp_update_erst_dequeue(pdev, event_ring_deq, 0);
> +			event_ring_deq =3D pdev->event_ring->dequeue;
> +			counter =3D 0;
> +		}
> +	}
> +
> +	cdnsp_update_erst_dequeue(pdev, event_ring_deq, 1);
> +
> +	spin_unlock(&pdev->lock);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +irqreturn_t cdnsp_irq_handler(int irq, void *priv)
> +{
> +	struct cdnsp_device *pdev =3D (struct cdnsp_device *)priv;
> +	u32 irq_pending;
> +	u32 status;
> +
> +	status =3D readl(&pdev->op_regs->status);
> +
> +	if (status =3D=3D ~(u32)0) {
> +		cdnsp_died(pdev);
> +		return IRQ_HANDLED;
> +	}
> +
> +	if (!(status & STS_EINT))
> +		return IRQ_NONE;
> +
> +	writel(status | STS_EINT, &pdev->op_regs->status);
> +	irq_pending =3D readl(&pdev->ir_set->irq_pending);
> +	irq_pending |=3D IMAN_IP;
> +	writel(irq_pending, &pdev->ir_set->irq_pending);
> +
> +	if (status & STS_FATAL) {
> +		cdnsp_died(pdev);
> +		return IRQ_HANDLED;
> +	}
> +
> +	return IRQ_WAKE_THREAD;
> +}
> +
> +/*
> + * Generic function for queuing a TRB on a ring.
> + * The caller must have checked to make sure there's room on the ring.
> + *
> + * @more_trbs_coming:	Will you enqueue more TRBs before setting doorbell=
?
> + */
> +static void cdnsp_queue_trb(struct cdnsp_device *pdev, struct cdnsp_ring=
 *ring,
> +			    bool more_trbs_coming, u32 field1, u32 field2,
> +			    u32 field3, u32 field4)
> +{
> +	struct cdnsp_generic_trb *trb;
> +
> +	trb =3D &ring->enqueue->generic;
> +
> +	trb->field[0] =3D cpu_to_le32(field1);
> +	trb->field[1] =3D cpu_to_le32(field2);
> +	trb->field[2] =3D cpu_to_le32(field3);
> +	trb->field[3] =3D cpu_to_le32(field4);
> +
> +	cdnsp_inc_enq(pdev, ring, more_trbs_coming);
> +}
> +
> +/*
> + * Does various checks on the endpoint ring, and makes it ready to
> + * queue num_trbs.
> + */
> +static int cdnsp_prepare_ring(struct cdnsp_device *pdev,
> +			      struct cdnsp_ring *ep_ring,
> +			      u32 ep_state, unsigned
> +			      int num_trbs,
> +			      gfp_t mem_flags)
> +{
> +	unsigned int num_trbs_needed;
> +
> +	/* Make sure the endpoint has been added to controller schedule. */
> +	switch (ep_state) {
> +	case EP_STATE_STOPPED:
> +	case EP_STATE_RUNNING:
> +	case EP_STATE_HALTED:
> +		break;
> +	default:
> +		dev_err(pdev->dev, "ERROR: incorrect endpoint state\n");
> +		return -EINVAL;
> +	}
> +
> +	while (1) {
> +		if (cdnsp_room_on_ring(pdev, ep_ring, num_trbs))
> +			break;
> +
> +		num_trbs_needed =3D num_trbs - ep_ring->num_trbs_free;
> +		if (cdnsp_ring_expansion(pdev, ep_ring, num_trbs_needed,
> +					 mem_flags)) {
> +			dev_err(pdev->dev, "Ring expansion failed\n");
> +			return -ENOMEM;
> +		}
> +	}
> +
> +	while (cdnsp_trb_is_link(ep_ring->enqueue)) {
> +		ep_ring->enqueue->link.control |=3D cpu_to_le32(TRB_CHAIN);
> +		/* The cycle bit must be set as the last operation. */
> +		wmb();
> +		ep_ring->enqueue->link.control ^=3D cpu_to_le32(TRB_CYCLE);
> +
> +		/* Toggle the cycle bit after the last ring segment. */
> +		if (cdnsp_link_trb_toggles_cycle(ep_ring->enqueue))
> +			ep_ring->cycle_state ^=3D 1;
> +		ep_ring->enq_seg =3D ep_ring->enq_seg->next;
> +		ep_ring->enqueue =3D ep_ring->enq_seg->trbs;
> +	}
> +	return 0;
> +}
> +
> +static int cdnsp_prepare_transfer(struct cdnsp_device *pdev,
> +				  struct cdnsp_request *preq,
> +				  unsigned int num_trbs)
> +{
> +	struct cdnsp_ring *ep_ring;
> +	int ret;
> +
> +	ep_ring =3D cdnsp_get_transfer_ring(pdev, preq->pep,
> +					  preq->request.stream_id);
> +	if (!ep_ring)
> +		return -EINVAL;
> +
> +	ret =3D cdnsp_prepare_ring(pdev, ep_ring,
> +				 GET_EP_CTX_STATE(preq->pep->out_ctx),
> +				 num_trbs, GFP_ATOMIC);
> +	if (ret)
> +		return ret;
> +
> +	INIT_LIST_HEAD(&preq->td.td_list);
> +	preq->td.preq =3D preq;
> +
> +	/* Add this TD to the tail of the endpoint ring's TD list. */
> +	list_add_tail(&preq->td.td_list, &ep_ring->td_list);
> +	ep_ring->num_tds++;
> +	preq->pep->stream_info.td_count++;
> +
> +	preq->td.start_seg =3D ep_ring->enq_seg;
> +	preq->td.first_trb =3D ep_ring->enqueue;
> +
> +	return 0;
> +}
> +
> +static unsigned int cdnsp_count_trbs(u64 addr, u64 len)
> +{
> +	unsigned int num_trbs;
> +
> +	num_trbs =3D DIV_ROUND_UP(len + (addr & (TRB_MAX_BUFF_SIZE - 1)),
> +				TRB_MAX_BUFF_SIZE);
> +	if (num_trbs =3D=3D 0)
> +		num_trbs++;
> +
> +	return num_trbs;
> +}
> +
> +static unsigned int count_trbs_needed(struct cdnsp_request *preq)
> +{
> +	return cdnsp_count_trbs(preq->request.dma, preq->request.length);
> +}
> +
> +static unsigned int count_sg_trbs_needed(struct cdnsp_request *preq)
> +{
> +	unsigned int i, len, full_len, num_trbs =3D 0;
> +	struct scatterlist *sg;
> +
> +	full_len =3D preq->request.length;
> +
> +	for_each_sg(preq->request.sg, sg, preq->request.num_sgs, i) {
> +		len =3D sg_dma_len(sg);
> +		num_trbs +=3D cdnsp_count_trbs(sg_dma_address(sg), len);
> +		len =3D min(len, full_len);
> +		full_len -=3D len;
> +		if (full_len =3D=3D 0)
> +			break;
> +	}
> +
> +	return num_trbs;
> +}
> +
> +static unsigned int count_isoc_trbs_needed(struct cdnsp_request *preq)
> +{
> +	return cdnsp_count_trbs(preq->request.dma, preq->request.length);
> +}
> +
> +static void cdnsp_check_trb_math(struct cdnsp_request *preq, int running=
_total)
> +{
> +	if (running_total !=3D preq->request.length)
> +		dev_err(preq->pep->pdev->dev,
> +			"%s - Miscalculated tx length, "
> +			"queued %#x, asked for %#x (%d)\n",
> +			preq->pep->name, running_total,
> +			preq->request.length, preq->request.actual);
> +}
> +
> +/*
> + * TD size is the number of max packet sized packets remaining in the TD
> + * (*not* including this TRB).
> + *
> + * Total TD packet count =3D total_packet_count =3D
> + *     DIV_ROUND_UP(TD size in bytes / wMaxPacketSize)
> + *
> + * Packets transferred up to and including this TRB =3D packets_transfer=
red =3D
> + *     rounddown(total bytes transferred including this TRB / wMaxPacket=
Size)
> + *
> + * TD size =3D total_packet_count - packets_transferred
> + *
> + * It must fit in bits 21:17, so it can't be bigger than 31.
> + * This is taken care of in the TRB_TD_SIZE() macro
> + *
> + * The last TRB in a TD must have the TD size set to zero.
> + */
> +static u32 cdnsp_td_remainder(struct cdnsp_device *pdev,
> +			      int transferred,
> +			      int trb_buff_len,
> +			      unsigned int td_total_len,
> +			      struct cdnsp_request *preq,
> +			      bool more_trbs_coming)
> +{
> +	u32 maxp, total_packet_count;
> +
> +	/* One TRB with a zero-length data packet. */
> +	if (!more_trbs_coming || (transferred =3D=3D 0 && trb_buff_len =3D=3D 0=
) ||
> +	    trb_buff_len =3D=3D td_total_len)
> +		return 0;
> +
> +	maxp =3D usb_endpoint_maxp(preq->pep->endpoint.desc);
> +	total_packet_count =3D DIV_ROUND_UP(td_total_len, maxp);
> +
> +	/* Queuing functions don't count the current TRB into transferred. */
> +	return (total_packet_count - ((transferred + trb_buff_len) / maxp));
> +}
> +
> +static int cdnsp_align_td(struct cdnsp_device *pdev,
> +			  struct cdnsp_request *preq, u32 enqd_len,
> +			  u32 *trb_buff_len, struct cdnsp_segment *seg)
> +{
> +	struct device *dev =3D pdev->dev;
> +	unsigned int unalign;
> +	unsigned int max_pkt;
> +	u32 new_buff_len;
> +
> +	max_pkt =3D usb_endpoint_maxp(preq->pep->endpoint.desc);
> +	unalign =3D (enqd_len + *trb_buff_len) % max_pkt;
> +
> +	/* We got lucky, last normal TRB data on segment is packet aligned. */
> +	if (unalign =3D=3D 0)
> +		return 0;
> +
> +	/* Is the last nornal TRB alignable by splitting it. */
> +	if (*trb_buff_len > unalign) {
> +		*trb_buff_len -=3D unalign;
> +		return 0;
> +	}
> +
> +	/*
> +	 * We want enqd_len + trb_buff_len to sum up to a number aligned to
> +	 * number which is divisible by the endpoint's wMaxPacketSize. IOW:
> +	 * (size of currently enqueued TRBs + remainder) % wMaxPacketSize =3D=
=3D 0.
> +	 */
> +	new_buff_len =3D max_pkt - (enqd_len % max_pkt);
> +
> +	if (new_buff_len > (preq->request.length - enqd_len))
> +		new_buff_len =3D (preq->request.length - enqd_len);
> +
> +	/* Create a max max_pkt sized bounce buffer pointed to by last trb. */
> +	if (preq->direction) {
> +		sg_pcopy_to_buffer(preq->request.sg,
> +				   preq->request.num_mapped_sgs,
> +				   seg->bounce_buf, new_buff_len, enqd_len);
> +		seg->bounce_dma =3D dma_map_single(dev, seg->bounce_buf,
> +						 max_pkt, DMA_TO_DEVICE);
> +	} else {
> +		seg->bounce_dma =3D dma_map_single(dev, seg->bounce_buf,
> +						 max_pkt, DMA_FROM_DEVICE);
> +	}
> +
> +	if (dma_mapping_error(dev, seg->bounce_dma)) {
> +		/* Try without aligning.*/
> +		dev_warn(pdev->dev,
> +			 "Failed mapping bounce buffer, not aligning\n");
> +		return 0;
> +	}
> +
> +	*trb_buff_len =3D new_buff_len;
> +	seg->bounce_len =3D new_buff_len;
> +	seg->bounce_offs =3D enqd_len;
> +
> +	/*
> +	 * Bounce buffer successful aligned and seg->bounce_dma will be used
> +	 * in transfer TRB as new transfer buffer address.
> +	 */
> +	return 1;
> +}
> +
> +int cdnsp_queue_bulk_tx(struct cdnsp_device *pdev, struct cdnsp_request =
*preq)
> +{
> +	unsigned int enqd_len, block_len, trb_buff_len, full_len;
> +	unsigned int start_cycle, num_sgs =3D 0;
> +	struct cdnsp_generic_trb *start_trb;
> +	u32 field, length_field, remainder;
> +	struct scatterlist *sg =3D NULL;
> +	bool more_trbs_coming =3D true;
> +	bool need_zero_pkt =3D false;
> +	bool zero_len_trb =3D false;
> +	struct cdnsp_ring *ring;
> +	bool first_trb =3D true;
> +	unsigned int num_trbs;
> +	struct cdnsp_ep *pep;
> +	u64 addr, send_addr;
> +	int sent_len, ret;
> +
> +	ring =3D cdnsp_request_to_transfer_ring(pdev, preq);
> +	if (!ring)
> +		return -EINVAL;
> +
> +	full_len =3D preq->request.length;
> +
> +	if (preq->request.num_sgs) {
> +		num_sgs =3D preq->request.num_sgs;
> +		sg =3D preq->request.sg;
> +		addr =3D (u64)sg_dma_address(sg);
> +		block_len =3D sg_dma_len(sg);
> +		num_trbs =3D count_sg_trbs_needed(preq);
> +	} else {
> +		num_trbs =3D count_trbs_needed(preq);
> +		addr =3D (u64)preq->request.dma;
> +		block_len =3D full_len;
> +	}
> +
> +	pep =3D preq->pep;
> +
> +	/* Deal with request.zero - need one more td/trb. */
> +	if (preq->request.zero && preq->request.length &&
> +	    IS_ALIGNED(full_len, usb_endpoint_maxp(pep->endpoint.desc))) {
> +		need_zero_pkt =3D true;
> +		num_trbs++;
> +	}
> +
> +	ret =3D cdnsp_prepare_transfer(pdev, preq, num_trbs);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Don't give the first TRB to the hardware (by toggling the cycle bit)
> +	 * until we've finished creating all the other TRBs. The ring's cycle
> +	 * state may change as we enqueue the other TRBs, so save it too.
> +	 */
> +	start_trb =3D &ring->enqueue->generic;
> +	start_cycle =3D ring->cycle_state;
> +	send_addr =3D addr;
> +
> +	/* Queue the TRBs, even if they are zero-length */
> +	for (enqd_len =3D 0; zero_len_trb || first_trb || enqd_len < full_len;
> +	     enqd_len +=3D trb_buff_len) {
> +		field =3D TRB_TYPE(TRB_NORMAL);
> +
> +		/* TRB buffer should not cross 64KB boundaries */
> +		trb_buff_len =3D TRB_BUFF_LEN_UP_TO_BOUNDARY(addr);
> +		trb_buff_len =3D min(trb_buff_len, block_len);
> +		if (enqd_len + trb_buff_len > full_len)
> +			trb_buff_len =3D full_len - enqd_len;
> +
> +		/* Don't change the cycle bit of the first TRB until later */
> +		if (first_trb) {
> +			first_trb =3D false;
> +			if (start_cycle =3D=3D 0)
> +				field |=3D TRB_CYCLE;
> +		} else {
> +			field |=3D ring->cycle_state;
> +		}
> +
> +		/*
> +		 * Chain all the TRBs together; clear the chain bit in the last
> +		 * TRB to indicate it's the last TRB in the chain.
> +		 */
> +		if (enqd_len + trb_buff_len < full_len || need_zero_pkt) {
> +			field |=3D TRB_CHAIN;
> +			if (cdnsp_trb_is_link(ring->enqueue + 1)) {
> +				if (cdnsp_align_td(pdev, preq, enqd_len,
> +						   &trb_buff_len,
> +						   ring->enq_seg)) {
> +					send_addr =3D ring->enq_seg->bounce_dma;
> +					/* Assuming TD won't span 2 segs */
> +					preq->td.bounce_seg =3D ring->enq_seg;
> +				}
> +			}
> +		}
> +
> +		if (enqd_len + trb_buff_len >=3D full_len) {
> +			if (need_zero_pkt && zero_len_trb) {
> +				zero_len_trb =3D true;
> +			} else {
> +				field &=3D ~TRB_CHAIN;
> +				field |=3D TRB_IOC;
> +				more_trbs_coming =3D false;
> +				need_zero_pkt =3D false;
> +				preq->td.last_trb =3D ring->enqueue;
> +			}
> +		}
> +
> +		/* Only set interrupt on short packet for OUT endpoints. */
> +		if (!preq->direction)
> +			field |=3D TRB_ISP;
> +
> +		/* Set the TRB length, TD size, and interrupter fields. */
> +		remainder =3D cdnsp_td_remainder(pdev, enqd_len, trb_buff_len,
> +					       full_len, preq,
> +					       more_trbs_coming);
> +
> +		length_field =3D TRB_LEN(trb_buff_len) | TRB_TD_SIZE(remainder) |
> +			TRB_INTR_TARGET(0);
> +
> +		cdnsp_queue_trb(pdev, ring, more_trbs_coming | need_zero_pkt,
> +				lower_32_bits(send_addr),
> +				upper_32_bits(send_addr),
> +				length_field,
> +				field);
> +
> +		addr +=3D trb_buff_len;
> +		sent_len =3D trb_buff_len;
> +		while (sg && sent_len >=3D block_len) {
> +			/* New sg entry */
> +			--num_sgs;
> +			sent_len -=3D block_len;
> +			if (num_sgs !=3D 0) {
> +				sg =3D sg_next(sg);
> +				block_len =3D sg_dma_len(sg);
> +				addr =3D (u64)sg_dma_address(sg);
> +				addr +=3D sent_len;
> +			}
> +		}
> +		block_len -=3D sent_len;
> +		send_addr =3D addr;
> +	}
> +
> +	cdnsp_check_trb_math(preq, enqd_len);
> +	ret =3D cdnsp_giveback_first_trb(pdev, pep, preq->request.stream_id,
> +				       start_cycle, start_trb);
> +
> +	if (ret)
> +		preq->td.drbl =3D 1;
> +
> +	return 0;
> +}
> +
> +int cdnsp_queue_ctrl_tx(struct cdnsp_device *pdev, struct cdnsp_request =
*preq)
> +{
> +	u32 field, length_field, remainder;
> +	struct cdnsp_ep *pep =3D preq->pep;
> +	struct cdnsp_ring *ep_ring;
> +	int num_trbs;
> +	int ret;
> +
> +	ep_ring =3D cdnsp_request_to_transfer_ring(pdev, preq);
> +	if (!ep_ring)
> +		return -EINVAL;
> +
> +	/* 1 TRB for data, 1 for status */
> +	num_trbs =3D (pdev->three_stage_setup) ? 2 : 1;
> +
> +	ret =3D cdnsp_prepare_transfer(pdev, preq, num_trbs);
> +	if (ret)
> +		return ret;
> +
> +	/* If there's data, queue data TRBs */
> +	if (pdev->ep0_expect_in)
> +		field =3D TRB_TYPE(TRB_DATA) | TRB_IOC;
> +	else
> +		field =3D TRB_ISP | TRB_TYPE(TRB_DATA) | TRB_IOC;
> +
> +	if (preq->request.length > 0) {
> +		remainder =3D cdnsp_td_remainder(pdev, 0, preq->request.length,
> +					       preq->request.length, preq, 1);
> +
> +		length_field =3D TRB_LEN(preq->request.length) |
> +				TRB_TD_SIZE(remainder) | TRB_INTR_TARGET(0);
> +
> +		if (pdev->ep0_expect_in)
> +			field |=3D TRB_DIR_IN;
> +
> +		cdnsp_queue_trb(pdev, ep_ring, true,
> +				lower_32_bits(preq->request.dma),
> +				upper_32_bits(preq->request.dma), length_field,
> +				field | ep_ring->cycle_state |
> +				TRB_SETUPID(pdev->setup_id) |
> +				pdev->setup_speed);
> +
> +		pdev->ep0_stage =3D CDNSP_DATA_STAGE;
> +	}
> +
> +	/* Save the DMA address of the last TRB in the TD. */
> +	preq->td.last_trb =3D ep_ring->enqueue;
> +
> +	/* Queue status TRB. */
> +	if (preq->request.length =3D=3D 0)
> +		field =3D ep_ring->cycle_state;
> +	else
> +		field =3D (ep_ring->cycle_state ^ 1);
> +
> +	if (preq->request.length > 0 && pdev->ep0_expect_in)
> +		field |=3D TRB_DIR_IN;
> +
> +	if (pep->ep_state & EP0_HALTED_STATUS) {
> +		pep->ep_state &=3D ~EP0_HALTED_STATUS;
> +		field |=3D TRB_SETUPSTAT(TRB_SETUPSTAT_STALL);
> +	} else {
> +		field |=3D TRB_SETUPSTAT(TRB_SETUPSTAT_ACK);
> +	}
> +
> +	cdnsp_queue_trb(pdev, ep_ring, false, 0, 0, TRB_INTR_TARGET(0),
> +			field | TRB_IOC | TRB_SETUPID(pdev->setup_id) |
> +			TRB_TYPE(TRB_STATUS) | pdev->setup_speed);
> +
> +	cdnsp_ring_ep_doorbell(pdev, pep, preq->request.stream_id);
> +
> +	return 0;
> +}
> +
> +int cdnsp_cmd_stop_ep(struct cdnsp_device *pdev, struct cdnsp_ep *pep)
> +{
> +	u32 ep_state =3D GET_EP_CTX_STATE(pep->out_ctx);
> +	int ret =3D 0;
> +
> +	if (ep_state =3D=3D EP_STATE_STOPPED || ep_state =3D=3D EP_STATE_DISABL=
ED)
> +		goto ep_stopped;
> +
> +	cdnsp_queue_stop_endpoint(pdev, pep->idx);
> +	cdnsp_ring_cmd_db(pdev);
> +	ret =3D cdnsp_wait_for_cmd_compl(pdev);
> +
> +ep_stopped:
> +	pep->ep_state |=3D EP_STOPPED;
> +	return ret;
> +}
> +
> +int cdnsp_cmd_flush_ep(struct cdnsp_device *pdev, struct cdnsp_ep *pep)
> +{
> +	int ret;
> +
> +	cdnsp_queue_flush_endpoint(pdev, pep->idx);
> +	cdnsp_ring_cmd_db(pdev);
> +	ret =3D cdnsp_wait_for_cmd_compl(pdev);
> +
> +	return ret;
> +}
> +
> +/*
> + * The transfer burst count field of the isochronous TRB defines the num=
ber of
> + * bursts that are required to move all packets in this TD. Only SuperSp=
eed
> + * devices can burst up to bMaxBurst number of packets per service inter=
val.
> + * This field is zero based, meaning a value of zero in the field means =
one
> + * burst. Basically, for everything but SuperSpeed devices, this field w=
ill be
> + * zero.
> + */
> +static unsigned int cdnsp_get_burst_count(struct cdnsp_device *pdev,
> +					  struct cdnsp_request *preq,
> +					  unsigned int total_packet_count)
> +{
> +	unsigned int max_burst;
> +
> +	if (pdev->gadget.speed < USB_SPEED_SUPER)
> +		return 0;
> +
> +	max_burst =3D preq->pep->endpoint.comp_desc->bMaxBurst;
> +	return DIV_ROUND_UP(total_packet_count, max_burst + 1) - 1;
> +}
> +
> +/*
> + * Returns the number of packets in the last "burst" of packets. This fi=
eld is
> + * valid for all speeds of devices. USB 2.0 devices can only do one "bur=
st", so
> + * the last burst packet count is equal to the total number of packets i=
n the
> + * TD. SuperSpeed endpoints can have up to 3 bursts. All but the last bu=
rst
> + * must contain (bMaxBurst + 1) number of packets, but the last burst ca=
n
> + * contain 1 to (bMaxBurst + 1) packets.
> + */
> +static unsigned int
> +	cdnsp_get_last_burst_packet_count(struct cdnsp_device *pdev,
> +					  struct cdnsp_request *preq,
> +					  unsigned int total_packet_count)
> +{
> +	unsigned int max_burst;
> +	unsigned int residue;
> +
> +	if (pdev->gadget.speed >=3D USB_SPEED_SUPER) {
> +		/* bMaxBurst is zero based: 0 means 1 packet per burst. */
> +		max_burst =3D preq->pep->endpoint.comp_desc->bMaxBurst;
> +		residue =3D total_packet_count % (max_burst + 1);
> +
> +		/*
> +		 * If residue is zero, the last burst contains (max_burst + 1)
> +		 * number of packets, but the TLBPC field is zero-based.
> +		 */
> +		if (residue =3D=3D 0)
> +			return max_burst;
> +
> +		return residue - 1;
> +	}
> +	if (total_packet_count =3D=3D 0)
> +		return 0;
> +
> +	return total_packet_count - 1;
> +}
> +
> +/* Queue function isoc transfer */
> +static int cdnsp_queue_isoc_tx(struct cdnsp_device *pdev,
> +			       struct cdnsp_request *preq)
> +{
> +	int trb_buff_len, td_len, td_remain_len, ret;
> +	unsigned int burst_count, last_burst_pkt;
> +	unsigned int total_pkt_count, max_pkt;
> +	struct cdnsp_generic_trb *start_trb;
> +	bool more_trbs_coming =3D true;
> +	struct cdnsp_ring *ep_ring;
> +	int running_total =3D 0;
> +	u32 field, length_field;
> +	int start_cycle;
> +	int trbs_per_td;
> +	u64 addr;
> +	int i;
> +
> +	ep_ring =3D preq->pep->ring;
> +	start_trb =3D &ep_ring->enqueue->generic;
> +	start_cycle =3D ep_ring->cycle_state;
> +	td_len =3D preq->request.length;
> +	addr =3D (u64)preq->request.dma;
> +	td_remain_len =3D td_len;
> +
> +	max_pkt =3D usb_endpoint_maxp(preq->pep->endpoint.desc);
> +	total_pkt_count =3D DIV_ROUND_UP(td_len, max_pkt);
> +
> +	/* A zero-length transfer still involves at least one packet. */
> +	if (total_pkt_count =3D=3D 0)
> +		total_pkt_count++;
> +
> +	burst_count =3D cdnsp_get_burst_count(pdev, preq, total_pkt_count);
> +	last_burst_pkt =3D cdnsp_get_last_burst_packet_count(pdev, preq,
> +							   total_pkt_count);
> +	trbs_per_td =3D count_isoc_trbs_needed(preq);
> +
> +	ret =3D cdnsp_prepare_transfer(pdev, preq, trbs_per_td);
> +	if (ret)
> +		goto cleanup;
> +
> +	/*
> +	 * Set isoc specific data for the first TRB in a TD.
> +	 * Prevent HW from getting the TRBs by keeping the cycle state
> +	 * inverted in the first TDs isoc TRB.
> +	 */
> +	field =3D TRB_TYPE(TRB_ISOC) | TRB_TLBPC(last_burst_pkt) |
> +		!start_cycle | TRB_SIA | TRB_TBC(burst_count);
> +
> +	/* Fill the rest of the TRB fields, and remaining normal TRBs. */
> +	for (i =3D 0; i < trbs_per_td; i++) {
> +		u32 remainder;
> +
> +		/* Calculate TRB length. */
> +		trb_buff_len =3D TRB_BUFF_LEN_UP_TO_BOUNDARY(addr);
> +		if (trb_buff_len > td_remain_len)
> +			trb_buff_len =3D td_remain_len;
> +
> +		/* Set the TRB length, TD size, & interrupter fields. */
> +		remainder =3D cdnsp_td_remainder(pdev, running_total,
> +					       trb_buff_len, td_len, preq,
> +					       more_trbs_coming);
> +
> +		length_field =3D TRB_LEN(trb_buff_len) | TRB_INTR_TARGET(0);
> +
> +		/* Only first TRB is isoc, overwrite otherwise. */
> +		if (i) {
> +			field =3D TRB_TYPE(TRB_NORMAL) | ep_ring->cycle_state;
> +			length_field |=3D TRB_TD_SIZE(remainder);
> +		} else {
> +			length_field |=3D TRB_TD_SIZE_TBC(burst_count);
> +		}
> +
> +		/* Only set interrupt on short packet for OUT EPs. */
> +		if (usb_endpoint_dir_out(preq->pep->endpoint.desc))
> +			field |=3D TRB_ISP;
> +
> +		/* Set the chain bit for all except the last TRB. */
> +		if (i < trbs_per_td - 1) {
> +			more_trbs_coming =3D true;
> +			field |=3D TRB_CHAIN;
> +		} else {
> +			more_trbs_coming =3D false;
> +			preq->td.last_trb =3D ep_ring->enqueue;
> +			field |=3D TRB_IOC;
> +		}
> +
> +		cdnsp_queue_trb(pdev, ep_ring, more_trbs_coming,
> +				lower_32_bits(addr), upper_32_bits(addr),
> +				length_field, field);
> +
> +		running_total +=3D trb_buff_len;
> +		addr +=3D trb_buff_len;
> +		td_remain_len -=3D trb_buff_len;
> +	}
> +
> +	/* Check TD length */
> +	if (running_total !=3D td_len) {
> +		dev_err(pdev->dev, "ISOC TD length unmatch\n");
> +		ret =3D -EINVAL;
> +		goto cleanup;
> +	}
> +
> +	cdnsp_giveback_first_trb(pdev, preq->pep, preq->request.stream_id,
> +				 start_cycle, start_trb);
> +
> +	return 0;
> +
> +cleanup:
> +	/* Clean up a partially enqueued isoc transfer. */
> +	list_del_init(&preq->td.td_list);
> +	ep_ring->num_tds--;
> +
> +	/*
> +	 * Use the first TD as a temporary variable to turn the TDs we've
> +	 * queued into No-ops with a software-owned cycle bit.
> +	 * That way the hardware won't accidentally start executing bogus TDs
> +	 * when we partially overwrite them.
> +	 * td->first_trb and td->start_seg are already set.
> +	 */
> +	preq->td.last_trb =3D ep_ring->enqueue;
> +	/* Every TRB except the first & last will have its cycle bit flipped. *=
/
> +	cdnsp_td_to_noop(pdev, ep_ring, &preq->td, true);
> +
> +	/* Reset the ring enqueue back to the first TRB and its cycle bit. */
> +	ep_ring->enqueue =3D preq->td.first_trb;
> +	ep_ring->enq_seg =3D preq->td.start_seg;
> +	ep_ring->cycle_state =3D start_cycle;
> +	return ret;
> +}
> +
> +int cdnsp_queue_isoc_tx_prepare(struct cdnsp_device *pdev,
> +				struct cdnsp_request *preq)
> +{
> +	struct cdnsp_ring *ep_ring;
> +	u32 ep_state;
> +	int num_trbs;
> +	int ret;
> +
> +	ep_ring =3D preq->pep->ring;
> +	ep_state =3D GET_EP_CTX_STATE(preq->pep->out_ctx);
> +	num_trbs =3D count_isoc_trbs_needed(preq);
> +
> +	/*
> +	 * Check the ring to guarantee there is enough room for the whole
> +	 * request. Do not insert any td of the USB Request to the ring if the
> +	 * check failed.
> +	 */
> +	ret =3D cdnsp_prepare_ring(pdev, ep_ring, ep_state, num_trbs, GFP_ATOMI=
C);
> +	if (ret)
> +		return ret;
> +
> +	return cdnsp_queue_isoc_tx(pdev, preq);
> +}
> +
> +/****		Command Ring Operations		****/
> +/*
> + * Generic function for queuing a command TRB on the command ring.
> + * Driver queue only one command to ring in the moment.
> + */
> +static void cdnsp_queue_command(struct cdnsp_device *pdev,
> +				u32 field1,
> +				u32 field2,
> +				u32 field3,
> +				u32 field4)
> +{
> +	cdnsp_prepare_ring(pdev, pdev->cmd_ring, EP_STATE_RUNNING, 1,
> +			   GFP_ATOMIC);
> +
> +	pdev->cmd.command_trb =3D pdev->cmd_ring->enqueue;
> +
> +	cdnsp_queue_trb(pdev, pdev->cmd_ring, false, field1, field2,
> +			field3, field4 | pdev->cmd_ring->cycle_state);
> +}
> +
> +/* Queue a slot enable or disable request on the command ring */
> +void cdnsp_queue_slot_control(struct cdnsp_device *pdev, u32 trb_type)
> +{
> +	cdnsp_queue_command(pdev, 0, 0, 0, TRB_TYPE(trb_type) |
> +			    SLOT_ID_FOR_TRB(pdev->slot_id));
> +}
> +
> +/* Queue an address device command TRB */
> +void cdnsp_queue_address_device(struct cdnsp_device *pdev,
> +				dma_addr_t in_ctx_ptr,
> +				enum cdnsp_setup_dev setup)
> +{
> +	cdnsp_queue_command(pdev, lower_32_bits(in_ctx_ptr),
> +			    upper_32_bits(in_ctx_ptr), 0,
> +			    TRB_TYPE(TRB_ADDR_DEV) |
> +			    SLOT_ID_FOR_TRB(pdev->slot_id) |
> +			    (setup =3D=3D SETUP_CONTEXT_ONLY ? TRB_BSR : 0));
> +}
> +
> +/* Queue a reset device command TRB */
> +void cdnsp_queue_reset_device(struct cdnsp_device *pdev)
> +{
> +	cdnsp_queue_command(pdev, 0, 0, 0, TRB_TYPE(TRB_RESET_DEV) |
> +			    SLOT_ID_FOR_TRB(pdev->slot_id));
> +}
> +
> +/* Queue a configure endpoint command TRB */
> +void cdnsp_queue_configure_endpoint(struct cdnsp_device *pdev,
> +				    dma_addr_t in_ctx_ptr)
> +{
> +	cdnsp_queue_command(pdev, lower_32_bits(in_ctx_ptr),
> +			    upper_32_bits(in_ctx_ptr), 0,
> +			    TRB_TYPE(TRB_CONFIG_EP) |
> +			    SLOT_ID_FOR_TRB(pdev->slot_id));
> +}
> +
> +/*
> + * Suspend is set to indicate "Stop Endpoint Command" is being issued to=
 stop
> + * activity on an endpoint that is about to be suspended.
> + */
> +void cdnsp_queue_stop_endpoint(struct cdnsp_device *pdev, unsigned int e=
p_index)
> +{
> +	cdnsp_queue_command(pdev, 0, 0, 0, SLOT_ID_FOR_TRB(pdev->slot_id) |
> +			    EP_ID_FOR_TRB(ep_index) | TRB_TYPE(TRB_STOP_RING));
> +}
> +
> +/* Set Transfer Ring Dequeue Pointer command. */
> +void cdnsp_queue_new_dequeue_state(struct cdnsp_device *pdev,
> +				   struct cdnsp_ep *pep,
> +				   struct cdnsp_dequeue_state *deq_state)
> +{
> +	u32 trb_stream_id =3D STREAM_ID_FOR_TRB(deq_state->stream_id);
> +	u32 trb_slot_id =3D SLOT_ID_FOR_TRB(pdev->slot_id);
> +	u32 type =3D TRB_TYPE(TRB_SET_DEQ);
> +	u32 trb_sct =3D 0;
> +	dma_addr_t addr;
> +
> +	addr =3D cdnsp_trb_virt_to_dma(deq_state->new_deq_seg,
> +				     deq_state->new_deq_ptr);
> +
> +	if (deq_state->stream_id)
> +		trb_sct =3D SCT_FOR_TRB(SCT_PRI_TR);
> +
> +	cdnsp_queue_command(pdev, lower_32_bits(addr) | trb_sct |
> +			    deq_state->new_cycle_state, upper_32_bits(addr),
> +			    trb_stream_id, trb_slot_id |
> +			    EP_ID_FOR_TRB(pep->idx) | type);
> +}
> +
> +void cdnsp_queue_reset_ep(struct cdnsp_device *pdev, unsigned int ep_ind=
ex)
> +{
> +	return cdnsp_queue_command(pdev, 0, 0, 0,
> +				   SLOT_ID_FOR_TRB(pdev->slot_id) |
> +				   EP_ID_FOR_TRB(ep_index) |
> +				   TRB_TYPE(TRB_RESET_EP));
> +}
> +
> +/*
> + * Queue a halt endpoint request on the command ring.
> + */
> +void cdnsp_queue_halt_endpoint(struct cdnsp_device *pdev, unsigned int e=
p_index)
> +{
> +	cdnsp_queue_command(pdev, 0, 0, 0, TRB_TYPE(TRB_HALT_ENDPOINT) |
> +			    SLOT_ID_FOR_TRB(pdev->slot_id) |
> +			    EP_ID_FOR_TRB(ep_index));
> +}
> +
> +/*
> + * Queue a flush endpoint request on the command ring.
> + */
> +void  cdnsp_queue_flush_endpoint(struct cdnsp_device *pdev,
> +				 unsigned int ep_index)
> +{
> +	cdnsp_queue_command(pdev, 0, 0, 0, TRB_TYPE(TRB_FLUSH_ENDPOINT) |
> +			    SLOT_ID_FOR_TRB(pdev->slot_id) |
> +			    EP_ID_FOR_TRB(ep_index));
> +}
> +
> +void cdnsp_force_header_wakeup(struct cdnsp_device *pdev, int intf_num)
> +{
> +	u32 lo, mid;
> +
> +	lo =3D TRB_FH_TO_PACKET_TYPE(TRB_FH_TR_PACKET) |
> +	     TRB_FH_TO_DEVICE_ADDRESS(pdev->device_address);
> +	mid =3D TRB_FH_TR_PACKET_DEV_NOT |
> +	      TRB_FH_TO_NOT_TYPE(TRB_FH_TR_PACKET_FUNCTION_WAKE) |
> +	      TRB_FH_TO_INTERFACE(intf_num);
> +
> +	cdnsp_queue_command(pdev, lo, mid, 0,
> +			    TRB_TYPE(TRB_FORCE_HEADER) | SET_PORT_ID(2));
> +}
> --=20
> 2.17.1
>=20

--=20

Thanks,
Peter Chen=

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39C743003D1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 14:10:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbhAVNJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 08:09:23 -0500
Received: from mail-eopbgr700053.outbound.protection.outlook.com ([40.107.70.53]:40894
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727783AbhAVNHQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 08:07:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eA0cpY2sUkAzzfA9sPpMrqOk5tC9pc+Y9XppVLKEk0oxSeODBqDe+r4EXAT2cWV/pDhfJnyxyez2kX9uFjXnUpJLb9OggCzTijGD03X62t9wKJVWyM5RmwcT2+IYkkJp8pJ2Lc5+1QUvYzN+edI84s1C2evvP5S4a4oHCeOYJdB/4ov4yuMXHaOPOzY8A7blC62MQkSNvYEblMKny0nnHsFCYf8Vi0bfyb6q/2gJsgAQagkzcqtiN9ICPNF2+OMqaAf/k1LOdxzqZIRWvMt/b3V8Cy8DkKvph+mUBRn92bbvuada2xlfTLelftARZ+WNGm10ShBiw8PQgKcjfpOhYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xAdXW0lPWAl4t/SjndcR4sOZ8BM/bTysqm5QQ2d92Gw=;
 b=GmdV8mjphTYOao8NtMN1kD3U3MW4lYXAQF+mG1nOKqG4MtYCtxwKbrVRbVfPitryF7653lr/Q76Lw2qd7Dqop8t82cA2bgvOuWhgmtX0wXsf6v5kXitlMRKonnr6jzdqEpDmVnoHVaFfbiT+8YYtQlMMXHkuLOdXKtkVjuoeeytRbitnRxbsdbqFhvTi8jhA2BplkRmYRTQ6YJuwcC7V8xzVX6yVJaCQpaq67O2eliDRwU7JFFLuD+0V86CpGu9q5I2NprOHVb2aNy5tv7Vd9xgZTVn2aU9+QSYQQGJmiJwowuLe20tx05xi+Ah6jclEOGh08Y4UQO0QeN72EYoPug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xAdXW0lPWAl4t/SjndcR4sOZ8BM/bTysqm5QQ2d92Gw=;
 b=mUBMqBkcdqo7ZQIzT/cjJjDqF4wo6FNPJIXBW8uOxZ0pel+j0RhIoh/ubjEdDCzJ6dC28U+JcSrSPVfjBf4l4KRdqMtjeVQ75CWKDvZxbpVpdyGvvQBCy0T07je76uo8cTwVCDmthKfje5LO4uZt1z3QAZH09NE+aTCHz5edISc=
Received: from BYAPR02MB5896.namprd02.prod.outlook.com (2603:10b6:a03:122::10)
 by BYAPR02MB5784.namprd02.prod.outlook.com (2603:10b6:a03:129::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9; Fri, 22 Jan
 2021 13:06:23 +0000
Received: from BYAPR02MB5896.namprd02.prod.outlook.com
 ([fe80::4804:29ba:116f:fe7]) by BYAPR02MB5896.namprd02.prod.outlook.com
 ([fe80::4804:29ba:116f:fe7%3]) with mapi id 15.20.3784.015; Fri, 22 Jan 2021
 13:06:22 +0000
From:   Manish Narani <MNARANI@xilinx.com>
To:     Michael Grzeschik <mgr@pengutronix.de>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Michal Simek <michals@xilinx.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>, git <git@xilinx.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [RESEND PATCH v3 2/2] usb: dwc3: Add driver for Xilinx platforms
Thread-Topic: [RESEND PATCH v3 2/2] usb: dwc3: Add driver for Xilinx platforms
Thread-Index: AQHW0q9EwtT3SEPXrk68pgN7S+dn2KotmiIAgAXsHACAAEOYwA==
Date:   Fri, 22 Jan 2021 13:06:22 +0000
Message-ID: <BYAPR02MB589689FC1EAE48B5D2213E96C1A09@BYAPR02MB5896.namprd02.prod.outlook.com>
References: <1608015291-52007-1-git-send-email-manish.narani@xilinx.com>
 <1608015291-52007-3-git-send-email-manish.narani@xilinx.com>
 <20210118134223.GE12316@pengutronix.de>
 <20210122080846.GI12316@pengutronix.de>
In-Reply-To: <20210122080846.GI12316@pengutronix.de>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=xilinx.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [183.83.141.107]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e309061e-4577-4e7f-b4f7-08d8bed6848b
x-ms-traffictypediagnostic: BYAPR02MB5784:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR02MB5784A1FF2B9918E872B6D694C1A00@BYAPR02MB5784.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Fu7MekZTO8p+sxl4yGvMI64ZVV+ewlK5F/gw4qcFh5+z4UG0M4ASTQcO+d/8tKmGMcLOtvcAUAvY5obX0Vqu/tQdfmGhZHEMZ5OBJhcbra3XoLp+pft++lZLeuVwlHvbjG3g3Kxct042CXld9/7ACeyaWOGAsPfHwDOYjQ1AxJldc0NsC+M5PRnE0e1cNiNOdWp4fZ+J9GWBH3EZomJMaPOt710LXJCN5zKnLXT+L+d3Hu6zfHqSJmlgRAkh4hnJ8W0Xs1LSI7wMQ3bJekKOXP3DsooBlgYKq4h+uYYgUvLob8PEMvWiteaYjzcFtc+9DhCie9YJZAH+1HuVZpCYO1PecnPVR2GXYhBWEyT6POG8BsUzv7gLfCohKu88isc1lFL61GfbuTI/iIm4bkuZBiUhyyl5SvanY3eIFlK+f51SxxZUvv353P/ush3h99AGOni3SOR00ZX/8rMuHNoEmn8v2FoTkE4IrVaOj7IjqCRAsXjLmKXt+WDDU15J8fmoIUgrAgDRJnIjnwuDo/sJjm+lyWFAYePIBdl9xfIwf9wbZ4VnHbmLr4Q2NT9mqD0LpLD0ALYnXDRrd3YwYS98x+/JYNs/NDODPOm8pVhjY5pwuI3LxzxgXN9WjZxZV5TbdPUP/RoEDk5A1enC9saC+MpaQpfOIPHOJs7/F8udO00=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR02MB5896.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(376002)(39860400002)(366004)(136003)(7416002)(9686003)(478600001)(8676002)(66476007)(2906002)(66946007)(55016002)(66446008)(8936002)(64756008)(83080400002)(66556008)(4326008)(53546011)(83380400001)(5660300002)(30864003)(76116006)(26005)(186003)(6916009)(44832011)(6506007)(52536014)(316002)(7696005)(71200400001)(54906003)(33656002)(966005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?TtLycT7qXMN0aYORYiWZFPAzqDWehrmhN9mTNROWzUis1k8tPzILJmdWt8WA?=
 =?us-ascii?Q?prrNNNPiwtH83fDvCv9hxBAC/CXZI8M5TrTZR0x/kRDBULvmjmAi1sDAsNg9?=
 =?us-ascii?Q?MEsv/5QDPSCLVcSIvHn9eiLUNCfnDy1K6F8lUEGxnplwb9J3h9qqokMotDwN?=
 =?us-ascii?Q?SeXP17RjSjjd4ltFGhRzr5WeuCLTK8qvHkcjoq7OZUPffuFV1D9Y6UkcBFbA?=
 =?us-ascii?Q?cMS4xGVYFjK+msEUQoTwJZb/AUXQOZKG8Cbw9fjn2Isqa9gAxpfaKWu8FudX?=
 =?us-ascii?Q?CeGb81dBcB0h4XI3+Che6S7taGUkRLMTPt8i1gTw4t0ZCmSQMTPqMhRAAXgP?=
 =?us-ascii?Q?xTWehqv+DarzONWrUf8TMAJ8YpVDyPrbmsB74sye+8tzTipSqPGBJnEwgPBN?=
 =?us-ascii?Q?GL5SF0yNpM1GVYuUfgjy9kG3+aLoxVVAUonLjNemUS8hRBkyf3mPrQzL7kNJ?=
 =?us-ascii?Q?XLSW8Fuz5E6B80ml+EKIpZrJAyjWsRAILPj9z1uaRDKXkok7q+mCkAgTLnsG?=
 =?us-ascii?Q?YftdGaMJvwpQ6NaF1esuo/4RHkumH2KTguxd5BAeurVHTPUj4EWc38rCGiUE?=
 =?us-ascii?Q?E9U89PrtA2M+nzlDrzbYOPomxaZct7CtJ3VLEoZS6qUkXwVYlnFUw76nSzco?=
 =?us-ascii?Q?TH1LUvoVtS+OuWWtfq/bFrMX9U0lFJmLcgkDxll9Czl61tQ+qrtir+YPUuph?=
 =?us-ascii?Q?Xm/RVIhs3JrsbpnX1XLKDIiiuUkaHRIfd6wBK2Z5l3m91sOmio4fqoSUTSGs?=
 =?us-ascii?Q?kwzXaQWI3mcK4RAUJ8C+JESATXoreb4etXjZ9wL+Jd45QBcjiJe8AapXxfjn?=
 =?us-ascii?Q?rRjMTQ4FF+Rrk0Efcu7dMD/JWdO8H5xv2b6rCIjadqFYPge8pby83cQ6nYpE?=
 =?us-ascii?Q?Q3AomZRNHs79O7Uvn+W54CaIO8XamOoRuZRvNQxqk7aPsVNAtPE/oN5egDtx?=
 =?us-ascii?Q?9lLqgOpShj8Rl9hsk9vHpopZd/G9qvB5d95cWz6zSgo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB5896.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e309061e-4577-4e7f-b4f7-08d8bed6848b
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2021 13:06:22.7703
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KRw4tETT1dSes3yeltn8LQqi1rzByYOh++NvBjc6lQL7QO2zFGIaLsdXQFzGu0L9/pNJggvQE/xeGGOnKnzItg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5784
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

> -----Original Message-----
> From: Michael Grzeschik <mgr@pengutronix.de>
> Sent: Friday, January 22, 2021 1:39 PM
> To: Manish Narani <MNARANI@xilinx.com>
> Cc: devicetree@vger.kernel.org; kernel@pengutronix.de; balbi@kernel.org;
> gregkh@linuxfoundation.org; linux-usb@vger.kernel.org; Michal Simek
> <michals@xilinx.com>; linux-kernel@vger.kernel.org; robh+dt@kernel.org;
> git <git@xilinx.com>; p.zabel@pengutronix.de; linux-arm-
> kernel@lists.infradead.org
> Subject: Re: [RESEND PATCH v3 2/2] usb: dwc3: Add driver for Xilinx
> platforms
>=20
> Hello!
>=20
> On Mon, Jan 18, 2021 at 02:42:24PM +0100, Michael Grzeschik wrote:
> >Hi!
> >
> >On Tue, Dec 15, 2020 at 12:24:51PM +0530, Manish Narani wrote:
> >>Add a new driver for supporting Xilinx platforms. This driver is used
> >>for some sequence of operations required for Xilinx USB controllers.
> >>This driver is also used to choose between PIPE clock coming from SerDe=
s
> >>and the Suspend Clock. Before the controller is out of reset, the clock
> >>selection should be changed to PIPE clock in order to make the USB
> >>controller work. There is a register added in Xilinx USB controller
> >>register space for the same.
> >
> >I tried out this driver with the vanilla kernel on an zynqmp. Without
> >this patch the USB-Gadget is already acting buggy. In the gadget mode,
> >some iterations of plug/unplug results to an stalled gadget which will
> >never come back without a reboot.
> >
> >With the corresponding code of this driver (reset assert, clk modify,
> >reset deassert) in the downstream kernels phy driver we found out it is
> >totaly stable. But using this exact glue driver which should do the same
> >as the downstream code, the gadget still was buggy the way described
> >above.
> >
> >I suspect the difference lays in the different order of operations.
> >While the downstream code is runing the resets inside the phy driver
> >which is powered and initialized in the dwc3-core itself. With this glue
> >layser approach of this patch the whole phy init is done before even
> >touching dwc3-core in any way. It seems not to have the same effect,
> >though.
> >
> >If really the order of operations is limiting us, we probably need
> >another solution than this glue layer. Any Ideas?
>=20
> I found out what the difference between the Downstream and this
> Glue is. When using vanilla with this Glue code we may not set
> the following bit:
>=20
> https://www.xilinx.com/html_docs/registers/ug1087/ug1087-zynq-
> ultrascale-registers.html#usb3_regs___fpd_power_prsnt.html
>=20
> >>+	/* Set PIPE Power Present signal in FPD Power Present Register*/
> >>+	writel(PIPE_POWER_ON, priv_data->regs +
> XLNX_USB_FPD_POWER_PRSNT);
>=20
> When I comment this out, the link stays stable. This is different in
> the Downstream Xilinx Kernel, where the bit is also set but has no
> negativ effect.
>=20
> Manish, can you give me a pointer what to look for?
> So setting this will also work with mainline?
I am looking further on this but from what I see here is that,
In order to make USB function properly, there are some dt changes needed in=
 mainline for
USB node which include defining clocks coming from serdes.
The DT changes are pending to be sent to mainline.
Can you share the DT settings for USB node on your side?
Meanwhile I will keep updating on the same.

Thanks,
Manish

>=20
> Regards,
> Michael
>=20
> >>
> >>Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> >>---
> >>drivers/usb/dwc3/Kconfig          |   9 +
> >>drivers/usb/dwc3/Makefile         |   1 +
> >>drivers/usb/dwc3/dwc3-of-simple.c |   1 -
> >>drivers/usb/dwc3/dwc3-xilinx.c    | 334
> ++++++++++++++++++++++++++++++
> >>4 files changed, 344 insertions(+), 1 deletion(-)
> >>create mode 100644 drivers/usb/dwc3/dwc3-xilinx.c
> >>
> >>diff --git a/drivers/usb/dwc3/Kconfig b/drivers/usb/dwc3/Kconfig
> >>index 7a2304565a73..0e00e6dfccd8 100644
> >>--- a/drivers/usb/dwc3/Kconfig
> >>+++ b/drivers/usb/dwc3/Kconfig
> >>@@ -139,4 +139,13 @@ config USB_DWC3_QCOM
> >>	  for peripheral mode support.
> >>	  Say 'Y' or 'M' if you have one such device.
> >>
> >>+config USB_DWC3_XILINX
> >>+	tristate "Xilinx Platforms"
> >>+	depends on (ARCH_ZYNQMP || ARCH_VERSAL) && OF
> >>+	default USB_DWC3
> >>+	help
> >>+	  Support Xilinx SoCs with DesignWare Core USB3 IP.
> >>+	  This driver handles both ZynqMP and Versal SoC operations.
> >>+	  Say 'Y' or 'M' if you have one such device.
> >>+
> >>endif
> >>diff --git a/drivers/usb/dwc3/Makefile b/drivers/usb/dwc3/Makefile
> >>index ae86da0dc5bd..add567578b1f 100644
> >>--- a/drivers/usb/dwc3/Makefile
> >>+++ b/drivers/usb/dwc3/Makefile
> >>@@ -51,3 +51,4 @@ obj-$(CONFIG_USB_DWC3_MESON_G12A)	+=3D
> dwc3-meson-g12a.o
> >>obj-$(CONFIG_USB_DWC3_OF_SIMPLE)	+=3D dwc3-of-simple.o
> >>obj-$(CONFIG_USB_DWC3_ST)		+=3D dwc3-st.o
> >>obj-$(CONFIG_USB_DWC3_QCOM)		+=3D dwc3-qcom.o
> >>+obj-$(CONFIG_USB_DWC3_XILINX)		+=3D dwc3-xilinx.o
> >>diff --git a/drivers/usb/dwc3/dwc3-of-simple.c b/drivers/usb/dwc3/dwc3-
> of-simple.c
> >>index e62ecd22b3ed..71fd620c5161 100644
> >>--- a/drivers/usb/dwc3/dwc3-of-simple.c
> >>+++ b/drivers/usb/dwc3/dwc3-of-simple.c
> >>@@ -172,7 +172,6 @@ static const struct dev_pm_ops
> dwc3_of_simple_dev_pm_ops =3D {
> >>
> >>static const struct of_device_id of_dwc3_simple_match[] =3D {
> >>	{ .compatible =3D "rockchip,rk3399-dwc3" },
> >>-	{ .compatible =3D "xlnx,zynqmp-dwc3" },
> >>	{ .compatible =3D "cavium,octeon-7130-usb-uctl" },
> >>	{ .compatible =3D "sprd,sc9860-dwc3" },
> >>	{ .compatible =3D "allwinner,sun50i-h6-dwc3" },
> >>diff --git a/drivers/usb/dwc3/dwc3-xilinx.c b/drivers/usb/dwc3/dwc3-
> xilinx.c
> >>new file mode 100644
> >>index 000000000000..7e485951d2f7
> >>--- /dev/null
> >>+++ b/drivers/usb/dwc3/dwc3-xilinx.c
> >>@@ -0,0 +1,334 @@
> >>+// SPDX-License-Identifier: GPL-2.0
> >>+/**
> >>+ * dwc3-xilinx.c - Xilinx DWC3 controller specific glue driver
> >>+ *
> >>+ * Authors: Manish Narani <manish.narani@xilinx.com>
> >>+ *          Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
> >>+ */
> >>+
> >>+#include <linux/module.h>
> >>+#include <linux/kernel.h>
> >>+#include <linux/slab.h>
> >>+#include <linux/clk.h>
> >>+#include <linux/of.h>
> >>+#include <linux/platform_device.h>
> >>+#include <linux/dma-mapping.h>
> >>+#include <linux/of_platform.h>
> >>+#include <linux/pm_runtime.h>
> >>+#include <linux/reset.h>
> >>+#include <linux/of_address.h>
> >>+#include <linux/delay.h>
> >>+#include <linux/firmware/xlnx-zynqmp.h>
> >>+#include <linux/io.h>
> >>+
> >>+#include <linux/phy/phy.h>
> >>+
> >>+/* USB phy reset mask register */
> >>+#define XLNX_USB_PHY_RST_EN			0x001C
> >>+#define XLNX_PHY_RST_MASK			0x1
> >>+
> >>+/* Xilinx USB 3.0 IP Register */
> >>+#define XLNX_USB_TRAFFIC_ROUTE_CONFIG		0x005C
> >>+#define XLNX_USB_TRAFFIC_ROUTE_FPD		0x1
> >>+
> >>+/* Versal USB Reset ID */
> >>+#define VERSAL_USB_RESET_ID			0xC104036
> >>+
> >>+#define XLNX_USB_FPD_PIPE_CLK			0x7c
> >>+#define PIPE_CLK_DESELECT			1
> >>+#define PIPE_CLK_SELECT				0
> >>+#define XLNX_USB_FPD_POWER_PRSNT		0x80
> >>+#define PIPE_POWER_ON				1
> >>+#define PIPE_POWER_OFF				0
> >>+
> >>+struct dwc3_xlnx {
> >>+	int				num_clocks;
> >>+	struct clk_bulk_data		*clks;
> >>+	struct device			*dev;
> >>+	void __iomem			*regs;
> >>+	int				(*pltfm_init)(struct dwc3_xlnx *data);
> >>+};
> >>+
> >>+static void dwc3_xlnx_mask_phy_rst(struct dwc3_xlnx *priv_data, bool
> mask)
> >>+{
> >>+	u32 reg;
> >>+
> >>+	/*
> >>+	 * Enable or disable ULPI PHY reset from USB Controller.
> >>+	 * This does not actually reset the phy, but just controls
> >>+	 * whether USB controller can or cannot reset ULPI PHY.
> >>+	 */
> >>+	reg =3D readl(priv_data->regs + XLNX_USB_PHY_RST_EN);
> >>+
> >>+	if (mask)
> >>+		reg &=3D ~XLNX_PHY_RST_MASK;
> >>+	else
> >>+		reg |=3D XLNX_PHY_RST_MASK;
> >>+
> >>+	writel(reg, priv_data->regs + XLNX_USB_PHY_RST_EN);
> >>+}
> >>+
> >>+static int dwc3_xlnx_init_versal(struct dwc3_xlnx *priv_data)
> >>+{
> >>+	struct device		*dev =3D priv_data->dev;
> >>+	int			ret;
> >>+
> >>+	dwc3_xlnx_mask_phy_rst(priv_data, false);
> >>+
> >>+	/* Assert and De-assert reset */
> >>+	ret =3D zynqmp_pm_reset_assert(VERSAL_USB_RESET_ID,
> >>+				     PM_RESET_ACTION_ASSERT);
> >>+	if (ret < 0) {
> >>+		dev_err_probe(dev, ret, "failed to assert Reset\n");
> >>+		return ret;
> >>+	}
> >>+
> >>+	ret =3D zynqmp_pm_reset_assert(VERSAL_USB_RESET_ID,
> >>+				     PM_RESET_ACTION_RELEASE);
> >>+	if (ret < 0) {
> >>+		dev_err_probe(dev, ret, "failed to De-assert Reset\n");
> >>+		return ret;
> >>+	}
> >>+
> >>+	dwc3_xlnx_mask_phy_rst(priv_data, true);
> >>+
> >>+	return 0;
> >>+}
> >>+
> >>+static int dwc3_xlnx_init_zynqmp(struct dwc3_xlnx *priv_data)
> >>+{
> >>+	struct device		*dev =3D priv_data->dev;
> >>+	struct reset_control	*crst, *hibrst, *apbrst;
> >>+	struct phy		*usb3_phy;
> >>+	int			ret;
> >>+	u32			reg;
> >>+
> >>+	crst =3D devm_reset_control_get_exclusive(dev, "usb_crst");
> >>+	if (IS_ERR(crst)) {
> >>+		ret =3D PTR_ERR(crst);
> >>+		dev_err_probe(dev, ret,
> >>+			      "failed to get core reset signal\n");
> >>+		goto err;
> >>+	}
> >>+
> >>+	hibrst =3D devm_reset_control_get_exclusive(dev, "usb_hibrst");
> >>+	if (IS_ERR(hibrst)) {
> >>+		ret =3D PTR_ERR(hibrst);
> >>+		dev_err_probe(dev, ret,
> >>+			      "failed to get hibernation reset signal\n");
> >>+		goto err;
> >>+	}
> >>+
> >>+	apbrst =3D devm_reset_control_get_exclusive(dev, "usb_apbrst");
> >>+	if (IS_ERR(apbrst)) {
> >>+		ret =3D PTR_ERR(apbrst);
> >>+		dev_err_probe(dev, ret,
> >>+			      "failed to get APB reset signal\n");
> >>+		goto err;
> >>+	}
> >>+
> >>+	ret =3D reset_control_assert(crst);
> >>+	if (ret < 0) {
> >>+		dev_err(dev, "Failed to assert core reset\n");
> >>+		goto err;
> >>+	}
> >>+
> >>+	ret =3D reset_control_assert(hibrst);
> >>+	if (ret < 0) {
> >>+		dev_err(dev, "Failed to assert hibernation reset\n");
> >>+		goto err;
> >>+	}
> >>+
> >>+	ret =3D reset_control_assert(apbrst);
> >>+	if (ret < 0) {
> >>+		dev_err(dev, "Failed to assert APB reset\n");
> >>+		goto err;
> >>+	}
> >>+
> >>+	usb3_phy =3D devm_phy_get(dev, "usb3-phy");
> >>+
> >>+	ret =3D phy_init(usb3_phy);
> >>+	if (ret < 0) {
> >>+		phy_exit(usb3_phy);
> >>+		goto err;
> >>+	}
> >>+
> >>+	ret =3D reset_control_deassert(apbrst);
> >>+	if (ret < 0) {
> >>+		dev_err(dev, "Failed to release APB reset\n");
> >>+		goto err;
> >>+	}
> >>+
> >>+	/* Set PIPE Power Present signal in FPD Power Present Register*/
> >>+	writel(PIPE_POWER_ON, priv_data->regs +
> XLNX_USB_FPD_POWER_PRSNT);
>=20
> This is somehow leading to an unstable link when using vanilla.
>=20
> >>+
> >>+	/* Set the PIPE Clock Select bit in FPD PIPE Clock register */
> >>+	writel(PIPE_CLK_SELECT, priv_data->regs +
> XLNX_USB_FPD_PIPE_CLK);
> >>+
> >>+	ret =3D reset_control_deassert(crst);
> >>+	if (ret < 0) {
> >>+		dev_err(dev, "Failed to release core reset\n");
> >>+		goto err;
> >>+	}
> >>+
> >>+	ret =3D reset_control_deassert(hibrst);
> >>+	if (ret < 0) {
> >>+		dev_err(dev, "Failed to release hibernation reset\n");
> >>+		goto err;
> >>+	}
> >>+
> >>+	ret =3D phy_power_on(usb3_phy);
> >>+	if (ret < 0) {
> >>+		phy_exit(usb3_phy);
> >>+		goto err;
> >>+	}
> >>+
> >>+	/*
> >>+	 * This routes the USB DMA traffic to go through FPD path instead
> >>+	 * of reaching DDR directly. This traffic routing is needed to
> >>+	 * make SMMU and CCI work with USB DMA.
> >>+	 */
> >>+	if (of_dma_is_coherent(dev->of_node) ||
> device_iommu_mapped(dev)) {
> >>+		reg =3D readl(priv_data->regs +
> XLNX_USB_TRAFFIC_ROUTE_CONFIG);
> >>+		reg |=3D XLNX_USB_TRAFFIC_ROUTE_FPD;
> >>+		writel(reg, priv_data->regs +
> XLNX_USB_TRAFFIC_ROUTE_CONFIG);
> >>+	}
> >>+
> >>+err:
> >>+	return ret;
> >>+}
> >>+
> >>+static const struct of_device_id dwc3_xlnx_of_match[] =3D {
> >>+	{
> >>+		.compatible =3D "xlnx,zynqmp-dwc3",
> >>+		.data =3D &dwc3_xlnx_init_zynqmp,
> >>+	},
> >>+	{
> >>+		.compatible =3D "xlnx,versal-dwc3",
> >>+		.data =3D &dwc3_xlnx_init_versal,
> >>+	},
> >>+	{ /* Sentinel */ }
> >>+};
> >>+MODULE_DEVICE_TABLE(of, dwc3_xlnx_of_match);
> >>+
> >>+static int dwc3_xlnx_probe(struct platform_device *pdev)
> >>+{
> >>+	struct dwc3_xlnx		*priv_data;
> >>+	struct device			*dev =3D &pdev->dev;
> >>+	struct device_node		*np =3D dev->of_node;
> >>+	const struct of_device_id	*match;
> >>+	void __iomem			*regs;
> >>+	int				ret;
> >>+
> >>+	priv_data =3D devm_kzalloc(dev, sizeof(*priv_data), GFP_KERNEL);
> >>+	if (!priv_data)
> >>+		return -ENOMEM;
> >>+
> >>+	regs =3D devm_platform_ioremap_resource(pdev, 0);
> >>+	if (IS_ERR(regs)) {
> >>+		ret =3D PTR_ERR(regs);
> >>+		dev_err_probe(dev, ret, "failed to map registers\n");
> >>+		return ret;
> >>+	}
> >>+
> >>+	match =3D of_match_node(dwc3_xlnx_of_match, pdev->dev.of_node);
> >>+
> >>+	priv_data->pltfm_init =3D match->data;
> >>+	priv_data->regs =3D regs;
> >>+	priv_data->dev =3D dev;
> >>+
> >>+	platform_set_drvdata(pdev, priv_data);
> >>+
> >>+	ret =3D devm_clk_bulk_get_all(priv_data->dev, &priv_data->clks);
> >>+	if (ret < 0)
> >>+		return ret;
> >>+
> >>+	priv_data->num_clocks =3D ret;
> >>+
> >>+	ret =3D clk_bulk_prepare_enable(priv_data->num_clocks, priv_data-
> >clks);
> >>+	if (ret)
> >>+		return ret;
> >>+
> >>+	ret =3D priv_data->pltfm_init(priv_data);
> >>+	if (ret)
> >>+		goto err_clk_put;
> >>+
> >>+	ret =3D of_platform_populate(np, NULL, NULL, dev);
> >>+	if (ret)
> >>+		goto err_clk_put;
> >>+
> >>+	pm_runtime_set_active(dev);
> >>+	pm_runtime_enable(dev);
> >>+	pm_suspend_ignore_children(dev, false);
> >>+	pm_runtime_get_sync(dev);
> >>+
> >>+	return 0;
> >>+
> >>+err_clk_put:
> >>+	clk_bulk_disable_unprepare(priv_data->num_clocks, priv_data-
> >clks);
> >>+	clk_bulk_put_all(priv_data->num_clocks, priv_data->clks);
> >>+
> >>+	return ret;
> >>+}
> >>+
> >>+static int dwc3_xlnx_remove(struct platform_device *pdev)
> >>+{
> >>+	struct dwc3_xlnx	*priv_data =3D platform_get_drvdata(pdev);
> >>+	struct device		*dev =3D &pdev->dev;
> >>+
> >>+	of_platform_depopulate(dev);
> >>+
> >>+	clk_bulk_disable_unprepare(priv_data->num_clocks, priv_data-
> >clks);
> >>+	clk_bulk_put_all(priv_data->num_clocks, priv_data->clks);
> >>+	priv_data->num_clocks =3D 0;
> >>+
> >>+	pm_runtime_disable(dev);
> >>+	pm_runtime_put_noidle(dev);
> >>+	pm_runtime_set_suspended(dev);
> >>+
> >>+	return 0;
> >>+}
> >>+
> >>+static int __maybe_unused dwc3_xlnx_suspend_common(struct device
> *dev)
> >>+{
> >>+	struct dwc3_xlnx *priv_data =3D dev_get_drvdata(dev);
> >>+
> >>+	clk_bulk_disable(priv_data->num_clocks, priv_data->clks);
> >>+
> >>+	return 0;
> >>+}
> >>+
> >>+static int __maybe_unused dwc3_xlnx_resume_common(struct device
> *dev)
> >>+{
> >>+	struct dwc3_xlnx *priv_data =3D dev_get_drvdata(dev);
> >>+
> >>+	return clk_bulk_enable(priv_data->num_clocks, priv_data->clks);
> >>+}
> >>+
> >>+static int __maybe_unused dwc3_xlnx_runtime_idle(struct device *dev)
> >>+{
> >>+	pm_runtime_mark_last_busy(dev);
> >>+	pm_runtime_autosuspend(dev);
> >>+
> >>+	return 0;
> >>+}
> >>+
> >>+static UNIVERSAL_DEV_PM_OPS(dwc3_xlnx_dev_pm_ops,
> dwc3_xlnx_suspend_common,
> >>+			    dwc3_xlnx_resume_common,
> dwc3_xlnx_runtime_idle);
> >>+
> >>+static struct platform_driver dwc3_xlnx_driver =3D {
> >>+	.probe		=3D dwc3_xlnx_probe,
> >>+	.remove		=3D dwc3_xlnx_remove,
> >>+	.driver		=3D {
> >>+		.name		=3D "dwc3-xilinx",
> >>+		.of_match_table	=3D dwc3_xlnx_of_match,
> >>+		.pm		=3D &dwc3_xlnx_dev_pm_ops,
> >>+	},
> >>+};
> >>+
> >>+module_platform_driver(dwc3_xlnx_driver);
> >>+
> >>+MODULE_LICENSE("GPL v2");
> >>+MODULE_DESCRIPTION("Xilinx DWC3 controller specific glue driver");
> >>+MODULE_AUTHOR("Manish Narani <manish.narani@xilinx.com>");
> >>+MODULE_AUTHOR("Anurag Kumar Vulisha
> <anurag.kumar.vulisha@xilinx.com>");
> >>--
> >>2.17.1
> >>
> >>
> >>_______________________________________________
> >>linux-arm-kernel mailing list
> >>linux-arm-kernel@lists.infradead.org
> >>http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> >
> >--
> >Pengutronix e.K.                           |                            =
 |
> >Steuerwalder Str. 21                       | http://www.pengutronix.de/ =
 |
> >31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0   =
 |
> >Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555=
 |
>=20
>=20
>=20
> >_______________________________________________
> >linux-arm-kernel mailing list
> >linux-arm-kernel@lists.infradead.org
> >http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>=20
>=20
> --
> Pengutronix e.K.                           |                             =
|
> Steuerwalder Str. 21                       | http://www.pengutronix.de/  =
|
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    =
|
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 =
|

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B38F3284C22
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 15:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbgJFNDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 09:03:15 -0400
Received: from mail-mw2nam10on2072.outbound.protection.outlook.com ([40.107.94.72]:12000
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725891AbgJFNDP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 09:03:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BlYpgH4us5eZofQL+7YK6WxxAAnkgMjbyIlqi7Wpb0kULK/hEPYfRlubsgt4yQyG2YCzwCZJ4OrI14onkNXKPiF8SB2w307VSg8tpHayevSawQCRjaJGpf5awK9aHySF4kJaGYNmfjn+QE7JiBtmTsd4EQTscATx2Bz8mK5mtgnfF7jbarnlB0BgcbcxPwPwoMezTk9PAO8F9QQsp83a0CETTt7vHAj8UUbBJhT4CtCbwTPU/kTbEej11GaRatwV2sCKo35KHiZ9SXxBMGppC6FB//YiGUVO5sfbYcMyK6NznuCXzxhryMRNNxgC3Q7asYP7RvYk1W0h5zDsvSgwBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U6uhGSmqiHUR1UhpsG5imw/DHr5eMWVxJ2ee3N6j/CQ=;
 b=jtPLddp2//Mvfpo2MagQFezmza/tyDJ9MkuXBSRDNE9tcx7+zx71akkIlAl12cXt3g6dMLG3P2Jl8rJ3AHECtdCg1kHSjXTCwY30Fu+E/NuMij+x/cxCtiH+PTeMK/+iOT35hCbdKSxooARN1b/LE2lgKtNcfoxAX31BPk+8om72oSt3PatXt++3mm0EQoT556VfY0hbqCmQBYufsUXUY0dsKk8Bhz6gbtO1Hk605hsv2NkSd5wErWxvxWZlZ6nenR8gyYnz0qEOzOIKBFp55GMGaNAsAyd22tXN0qghDX3WePbIGSFYAsY1HnnNkBSMl6SYNCSRAAgKP9eSA93kmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U6uhGSmqiHUR1UhpsG5imw/DHr5eMWVxJ2ee3N6j/CQ=;
 b=EutOoPKOhkKBEEKVH9ekw1CiBeNDSGItM2Mr+VqIDmYMw4a+oamsDp6v8Dq3zxi78tVHRdEdrgWyRDBVTmpPNX8UOFEoTWmBGVmjtG2WSbXoGuPYxz9Qy2q6gjk5X7nrl4D2M8R95Jg0uQVyVHodkXb6NVj91cGHyvkheFFXG3U=
Received: from BYAPR02MB5896.namprd02.prod.outlook.com (2603:10b6:a03:122::10)
 by BYAPR02MB6438.namprd02.prod.outlook.com (2603:10b6:a03:11d::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.42; Tue, 6 Oct
 2020 13:03:07 +0000
Received: from BYAPR02MB5896.namprd02.prod.outlook.com
 ([fe80::1876:e714:1c03:e89b]) by BYAPR02MB5896.namprd02.prod.outlook.com
 ([fe80::1876:e714:1c03:e89b%6]) with mapi id 15.20.3433.044; Tue, 6 Oct 2020
 13:03:07 +0000
From:   Manish Narani <MNARANI@xilinx.com>
To:     Manish Narani <MNARANI@xilinx.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Michal Simek <michals@xilinx.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        git <git@xilinx.com>
Subject: RE: [PATCH v2 2/2] usb: dwc3: Add driver for Xilinx platforms
Thread-Topic: [PATCH v2 2/2] usb: dwc3: Add driver for Xilinx platforms
Thread-Index: AQHWhty0Pk5Siz7cE0mhij0cZyagMamKs0iQ
Date:   Tue, 6 Oct 2020 13:03:07 +0000
Message-ID: <BYAPR02MB5896B6BB9F71DBDEC9DD7E72C10D0@BYAPR02MB5896.namprd02.prod.outlook.com>
References: <1599678185-119412-1-git-send-email-manish.narani@xilinx.com>
 <1599678185-119412-3-git-send-email-manish.narani@xilinx.com>
In-Reply-To: <1599678185-119412-3-git-send-email-manish.narani@xilinx.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: xilinx.com; dkim=none (message not signed)
 header.d=none;xilinx.com; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [149.199.50.128]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 43c33fda-7c2f-4832-0033-08d869f82b6a
x-ms-traffictypediagnostic: BYAPR02MB6438:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR02MB643852E55FA282074B8B3F6AC10D0@BYAPR02MB6438.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lR1czf/n9Kii7e/QsflSdZsg1XLl2NB52UwOnQsOvUOJVpZWTHvfGKTM4N6KasOUrIEMEV/VGItq9h/3rks1bEQl3l5yOreSfEll41/hpDmgI41q4OPvB3Jyp1speKf0UxK6ArE85/RoNoY9PmtvCf5nX0UD2rJZgpnL+pDvtR9JRGguq4AFOFWnozSKnu+Ij6vaH5yqAFzvlip5jruhCjoRpVDg1uX2k1JJPkl+soCa2hkeG/3ycbF87BIgeCYQj21EropAsgAgbXu3HS7Aq50E3z/aSE8Wl8FmvLlbs70dY/n2ZdtA1YQn4hX1T7OKZ0rM1YndPlf6ZNTtCDnFOA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR02MB5896.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(346002)(136003)(39860400002)(396003)(66476007)(5660300002)(66556008)(71200400001)(8676002)(64756008)(54906003)(86362001)(76116006)(7416002)(30864003)(110136005)(316002)(66946007)(107886003)(8936002)(9686003)(66446008)(33656002)(478600001)(52536014)(83380400001)(26005)(4326008)(6506007)(186003)(53546011)(2906002)(55016002)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: h496OpstednJdUe+G3Kruy97YabAK4PE9Y0y8XPqkWT7EkDNN7myJYLUskKcszbhrmiX/YomZyMWnXr5QuRsTzL+1Kgogb366ywDBxf+/K4erI0Xw25ky5ic0a3lk8q/7Qt/05vrkKccoTp+Q0KX7J9ub12LJLIUn4AJsrHCVI5xSDL1Wg73RW2gmeqdQD0cb4UTtIlArmE2FmnRFJwjstahj1oyDpu+IiZ2liMrbO39NmfGFk9Axn0UAnYPzpqoLa1lESIWLlV0SYHSfh7DY8u8hzlR6zXcsji9mzg8DA71FthaG93T/ruOsGj6r/d2Seu55gbrh5Ae/BlbZQJrOmeU+PXvHZFAkop2VBa/LwYyx5/34mIHgV/Gik0IrtF9Ii0HlWcmHpyLio5uJeVEuKv4bsSeFZ9pfIYcS/5v8wGnvSGZwPcajYsGjpoWYKPR/nRad9afq6CTmZyW5BxKUIRRj4qkq6RiXrB+4WiX4MCRZ6w9zIAlKrc++VtmDbSBT4W0FMjTwFDAllD3wALWmoL0RpHhItAmyV7sPu/AyXCLUYeiLjryjYShHmdUMMbxvn/oYbE0ysmqG+spCjpPqvKzHCRcgdryPYR2Z0JWUireYdPf9J35BNMFRnywodfMFYiJFgKLYX68Vn3XvqtZKQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB5896.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43c33fda-7c2f-4832-0033-08d869f82b6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2020 13:03:07.2259
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MrYx/i3I3Avm1kkMgZpY0wxFwAZjo38LHLPThsflmEMcDwnb8124MQ+tc4qS8lmrr/Tf80lsI7VchEo8Q88ozQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB6438
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Felipe,

Would you please review this patch? So that in v3, I can include the change=
s in the driver if any, along with the binding corrections.

Thanks,
Manish

> -----Original Message-----
> From: Manish Narani <manish.narani@xilinx.com>
> Sent: Thursday, September 10, 2020 12:33 AM
> To: gregkh@linuxfoundation.org; robh+dt@kernel.org; Michal Simek
> <michals@xilinx.com>; balbi@kernel.org; p.zabel@pengutronix.de
> Cc: linux-usb@vger.kernel.org; devicetree@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; linux-kernel@vger.kernel.org; git
> <git@xilinx.com>; Manish Narani <MNARANI@xilinx.com>
> Subject: [PATCH v2 2/2] usb: dwc3: Add driver for Xilinx platforms
>=20
> Add a new driver for supporting Xilinx platforms. This driver is used
> for some sequence of operations required for Xilinx USB controllers.
> This driver is also used to choose between PIPE clock coming from SerDes
> and the Suspend Clock. Before the controller is out of reset, the clock
> selection should be changed to PIPE clock in order to make the USB
> controller work. There is a register added in Xilinx USB controller
> register space for the same.
>=20
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> ---
>  drivers/usb/dwc3/Kconfig          |   9 +
>  drivers/usb/dwc3/Makefile         |   1 +
>  drivers/usb/dwc3/dwc3-of-simple.c |   1 -
>  drivers/usb/dwc3/dwc3-xilinx.c    | 334 ++++++++++++++++++++++++++++++
>  4 files changed, 344 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/usb/dwc3/dwc3-xilinx.c
>=20
> diff --git a/drivers/usb/dwc3/Kconfig b/drivers/usb/dwc3/Kconfig
> index 7a2304565a73..0e00e6dfccd8 100644
> --- a/drivers/usb/dwc3/Kconfig
> +++ b/drivers/usb/dwc3/Kconfig
> @@ -139,4 +139,13 @@ config USB_DWC3_QCOM
>  	  for peripheral mode support.
>  	  Say 'Y' or 'M' if you have one such device.
>=20
> +config USB_DWC3_XILINX
> +	tristate "Xilinx Platforms"
> +	depends on (ARCH_ZYNQMP || ARCH_VERSAL) && OF
> +	default USB_DWC3
> +	help
> +	  Support Xilinx SoCs with DesignWare Core USB3 IP.
> +	  This driver handles both ZynqMP and Versal SoC operations.
> +	  Say 'Y' or 'M' if you have one such device.
> +
>  endif
> diff --git a/drivers/usb/dwc3/Makefile b/drivers/usb/dwc3/Makefile
> index ae86da0dc5bd..add567578b1f 100644
> --- a/drivers/usb/dwc3/Makefile
> +++ b/drivers/usb/dwc3/Makefile
> @@ -51,3 +51,4 @@ obj-$(CONFIG_USB_DWC3_MESON_G12A)	+=3D
> dwc3-meson-g12a.o
>  obj-$(CONFIG_USB_DWC3_OF_SIMPLE)	+=3D dwc3-of-simple.o
>  obj-$(CONFIG_USB_DWC3_ST)		+=3D dwc3-st.o
>  obj-$(CONFIG_USB_DWC3_QCOM)		+=3D dwc3-qcom.o
> +obj-$(CONFIG_USB_DWC3_XILINX)		+=3D dwc3-xilinx.o
> diff --git a/drivers/usb/dwc3/dwc3-of-simple.c b/drivers/usb/dwc3/dwc3-of=
-
> simple.c
> index 7df115012935..e3a485b76818 100644
> --- a/drivers/usb/dwc3/dwc3-of-simple.c
> +++ b/drivers/usb/dwc3/dwc3-of-simple.c
> @@ -172,7 +172,6 @@ static const struct dev_pm_ops
> dwc3_of_simple_dev_pm_ops =3D {
>=20
>  static const struct of_device_id of_dwc3_simple_match[] =3D {
>  	{ .compatible =3D "rockchip,rk3399-dwc3" },
> -	{ .compatible =3D "xlnx,zynqmp-dwc3" },
>  	{ .compatible =3D "cavium,octeon-7130-usb-uctl" },
>  	{ .compatible =3D "sprd,sc9860-dwc3" },
>  	{ .compatible =3D "allwinner,sun50i-h6-dwc3" },
> diff --git a/drivers/usb/dwc3/dwc3-xilinx.c b/drivers/usb/dwc3/dwc3-xilin=
x.c
> new file mode 100644
> index 000000000000..7e485951d2f7
> --- /dev/null
> +++ b/drivers/usb/dwc3/dwc3-xilinx.c
> @@ -0,0 +1,334 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/**
> + * dwc3-xilinx.c - Xilinx DWC3 controller specific glue driver
> + *
> + * Authors: Manish Narani <manish.narani@xilinx.com>
> + *          Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
> + */
> +
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/slab.h>
> +#include <linux/clk.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/of_platform.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/reset.h>
> +#include <linux/of_address.h>
> +#include <linux/delay.h>
> +#include <linux/firmware/xlnx-zynqmp.h>
> +#include <linux/io.h>
> +
> +#include <linux/phy/phy.h>
> +
> +/* USB phy reset mask register */
> +#define XLNX_USB_PHY_RST_EN			0x001C
> +#define XLNX_PHY_RST_MASK			0x1
> +
> +/* Xilinx USB 3.0 IP Register */
> +#define XLNX_USB_TRAFFIC_ROUTE_CONFIG		0x005C
> +#define XLNX_USB_TRAFFIC_ROUTE_FPD		0x1
> +
> +/* Versal USB Reset ID */
> +#define VERSAL_USB_RESET_ID			0xC104036
> +
> +#define XLNX_USB_FPD_PIPE_CLK			0x7c
> +#define PIPE_CLK_DESELECT			1
> +#define PIPE_CLK_SELECT				0
> +#define XLNX_USB_FPD_POWER_PRSNT		0x80
> +#define PIPE_POWER_ON				1
> +#define PIPE_POWER_OFF				0
> +
> +struct dwc3_xlnx {
> +	int				num_clocks;
> +	struct clk_bulk_data		*clks;
> +	struct device			*dev;
> +	void __iomem			*regs;
> +	int				(*pltfm_init)(struct dwc3_xlnx *data);
> +};
> +
> +static void dwc3_xlnx_mask_phy_rst(struct dwc3_xlnx *priv_data, bool
> mask)
> +{
> +	u32 reg;
> +
> +	/*
> +	 * Enable or disable ULPI PHY reset from USB Controller.
> +	 * This does not actually reset the phy, but just controls
> +	 * whether USB controller can or cannot reset ULPI PHY.
> +	 */
> +	reg =3D readl(priv_data->regs + XLNX_USB_PHY_RST_EN);
> +
> +	if (mask)
> +		reg &=3D ~XLNX_PHY_RST_MASK;
> +	else
> +		reg |=3D XLNX_PHY_RST_MASK;
> +
> +	writel(reg, priv_data->regs + XLNX_USB_PHY_RST_EN);
> +}
> +
> +static int dwc3_xlnx_init_versal(struct dwc3_xlnx *priv_data)
> +{
> +	struct device		*dev =3D priv_data->dev;
> +	int			ret;
> +
> +	dwc3_xlnx_mask_phy_rst(priv_data, false);
> +
> +	/* Assert and De-assert reset */
> +	ret =3D zynqmp_pm_reset_assert(VERSAL_USB_RESET_ID,
> +				     PM_RESET_ACTION_ASSERT);
> +	if (ret < 0) {
> +		dev_err_probe(dev, ret, "failed to assert Reset\n");
> +		return ret;
> +	}
> +
> +	ret =3D zynqmp_pm_reset_assert(VERSAL_USB_RESET_ID,
> +				     PM_RESET_ACTION_RELEASE);
> +	if (ret < 0) {
> +		dev_err_probe(dev, ret, "failed to De-assert Reset\n");
> +		return ret;
> +	}
> +
> +	dwc3_xlnx_mask_phy_rst(priv_data, true);
> +
> +	return 0;
> +}
> +
> +static int dwc3_xlnx_init_zynqmp(struct dwc3_xlnx *priv_data)
> +{
> +	struct device		*dev =3D priv_data->dev;
> +	struct reset_control	*crst, *hibrst, *apbrst;
> +	struct phy		*usb3_phy;
> +	int			ret;
> +	u32			reg;
> +
> +	crst =3D devm_reset_control_get_exclusive(dev, "usb_crst");
> +	if (IS_ERR(crst)) {
> +		ret =3D PTR_ERR(crst);
> +		dev_err_probe(dev, ret,
> +			      "failed to get core reset signal\n");
> +		goto err;
> +	}
> +
> +	hibrst =3D devm_reset_control_get_exclusive(dev, "usb_hibrst");
> +	if (IS_ERR(hibrst)) {
> +		ret =3D PTR_ERR(hibrst);
> +		dev_err_probe(dev, ret,
> +			      "failed to get hibernation reset signal\n");
> +		goto err;
> +	}
> +
> +	apbrst =3D devm_reset_control_get_exclusive(dev, "usb_apbrst");
> +	if (IS_ERR(apbrst)) {
> +		ret =3D PTR_ERR(apbrst);
> +		dev_err_probe(dev, ret,
> +			      "failed to get APB reset signal\n");
> +		goto err;
> +	}
> +
> +	ret =3D reset_control_assert(crst);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to assert core reset\n");
> +		goto err;
> +	}
> +
> +	ret =3D reset_control_assert(hibrst);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to assert hibernation reset\n");
> +		goto err;
> +	}
> +
> +	ret =3D reset_control_assert(apbrst);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to assert APB reset\n");
> +		goto err;
> +	}
> +
> +	usb3_phy =3D devm_phy_get(dev, "usb3-phy");
> +
> +	ret =3D phy_init(usb3_phy);
> +	if (ret < 0) {
> +		phy_exit(usb3_phy);
> +		goto err;
> +	}
> +
> +	ret =3D reset_control_deassert(apbrst);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to release APB reset\n");
> +		goto err;
> +	}
> +
> +	/* Set PIPE Power Present signal in FPD Power Present Register*/
> +	writel(PIPE_POWER_ON, priv_data->regs +
> XLNX_USB_FPD_POWER_PRSNT);
> +
> +	/* Set the PIPE Clock Select bit in FPD PIPE Clock register */
> +	writel(PIPE_CLK_SELECT, priv_data->regs +
> XLNX_USB_FPD_PIPE_CLK);
> +
> +	ret =3D reset_control_deassert(crst);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to release core reset\n");
> +		goto err;
> +	}
> +
> +	ret =3D reset_control_deassert(hibrst);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to release hibernation reset\n");
> +		goto err;
> +	}
> +
> +	ret =3D phy_power_on(usb3_phy);
> +	if (ret < 0) {
> +		phy_exit(usb3_phy);
> +		goto err;
> +	}
> +
> +	/*
> +	 * This routes the USB DMA traffic to go through FPD path instead
> +	 * of reaching DDR directly. This traffic routing is needed to
> +	 * make SMMU and CCI work with USB DMA.
> +	 */
> +	if (of_dma_is_coherent(dev->of_node) ||
> device_iommu_mapped(dev)) {
> +		reg =3D readl(priv_data->regs +
> XLNX_USB_TRAFFIC_ROUTE_CONFIG);
> +		reg |=3D XLNX_USB_TRAFFIC_ROUTE_FPD;
> +		writel(reg, priv_data->regs +
> XLNX_USB_TRAFFIC_ROUTE_CONFIG);
> +	}
> +
> +err:
> +	return ret;
> +}
> +
> +static const struct of_device_id dwc3_xlnx_of_match[] =3D {
> +	{
> +		.compatible =3D "xlnx,zynqmp-dwc3",
> +		.data =3D &dwc3_xlnx_init_zynqmp,
> +	},
> +	{
> +		.compatible =3D "xlnx,versal-dwc3",
> +		.data =3D &dwc3_xlnx_init_versal,
> +	},
> +	{ /* Sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, dwc3_xlnx_of_match);
> +
> +static int dwc3_xlnx_probe(struct platform_device *pdev)
> +{
> +	struct dwc3_xlnx		*priv_data;
> +	struct device			*dev =3D &pdev->dev;
> +	struct device_node		*np =3D dev->of_node;
> +	const struct of_device_id	*match;
> +	void __iomem			*regs;
> +	int				ret;
> +
> +	priv_data =3D devm_kzalloc(dev, sizeof(*priv_data), GFP_KERNEL);
> +	if (!priv_data)
> +		return -ENOMEM;
> +
> +	regs =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(regs)) {
> +		ret =3D PTR_ERR(regs);
> +		dev_err_probe(dev, ret, "failed to map registers\n");
> +		return ret;
> +	}
> +
> +	match =3D of_match_node(dwc3_xlnx_of_match, pdev->dev.of_node);
> +
> +	priv_data->pltfm_init =3D match->data;
> +	priv_data->regs =3D regs;
> +	priv_data->dev =3D dev;
> +
> +	platform_set_drvdata(pdev, priv_data);
> +
> +	ret =3D devm_clk_bulk_get_all(priv_data->dev, &priv_data->clks);
> +	if (ret < 0)
> +		return ret;
> +
> +	priv_data->num_clocks =3D ret;
> +
> +	ret =3D clk_bulk_prepare_enable(priv_data->num_clocks, priv_data-
> >clks);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D priv_data->pltfm_init(priv_data);
> +	if (ret)
> +		goto err_clk_put;
> +
> +	ret =3D of_platform_populate(np, NULL, NULL, dev);
> +	if (ret)
> +		goto err_clk_put;
> +
> +	pm_runtime_set_active(dev);
> +	pm_runtime_enable(dev);
> +	pm_suspend_ignore_children(dev, false);
> +	pm_runtime_get_sync(dev);
> +
> +	return 0;
> +
> +err_clk_put:
> +	clk_bulk_disable_unprepare(priv_data->num_clocks, priv_data-
> >clks);
> +	clk_bulk_put_all(priv_data->num_clocks, priv_data->clks);
> +
> +	return ret;
> +}
> +
> +static int dwc3_xlnx_remove(struct platform_device *pdev)
> +{
> +	struct dwc3_xlnx	*priv_data =3D platform_get_drvdata(pdev);
> +	struct device		*dev =3D &pdev->dev;
> +
> +	of_platform_depopulate(dev);
> +
> +	clk_bulk_disable_unprepare(priv_data->num_clocks, priv_data-
> >clks);
> +	clk_bulk_put_all(priv_data->num_clocks, priv_data->clks);
> +	priv_data->num_clocks =3D 0;
> +
> +	pm_runtime_disable(dev);
> +	pm_runtime_put_noidle(dev);
> +	pm_runtime_set_suspended(dev);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused dwc3_xlnx_suspend_common(struct device
> *dev)
> +{
> +	struct dwc3_xlnx *priv_data =3D dev_get_drvdata(dev);
> +
> +	clk_bulk_disable(priv_data->num_clocks, priv_data->clks);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused dwc3_xlnx_resume_common(struct device
> *dev)
> +{
> +	struct dwc3_xlnx *priv_data =3D dev_get_drvdata(dev);
> +
> +	return clk_bulk_enable(priv_data->num_clocks, priv_data->clks);
> +}
> +
> +static int __maybe_unused dwc3_xlnx_runtime_idle(struct device *dev)
> +{
> +	pm_runtime_mark_last_busy(dev);
> +	pm_runtime_autosuspend(dev);
> +
> +	return 0;
> +}
> +
> +static UNIVERSAL_DEV_PM_OPS(dwc3_xlnx_dev_pm_ops,
> dwc3_xlnx_suspend_common,
> +			    dwc3_xlnx_resume_common,
> dwc3_xlnx_runtime_idle);
> +
> +static struct platform_driver dwc3_xlnx_driver =3D {
> +	.probe		=3D dwc3_xlnx_probe,
> +	.remove		=3D dwc3_xlnx_remove,
> +	.driver		=3D {
> +		.name		=3D "dwc3-xilinx",
> +		.of_match_table	=3D dwc3_xlnx_of_match,
> +		.pm		=3D &dwc3_xlnx_dev_pm_ops,
> +	},
> +};
> +
> +module_platform_driver(dwc3_xlnx_driver);
> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("Xilinx DWC3 controller specific glue driver");
> +MODULE_AUTHOR("Manish Narani <manish.narani@xilinx.com>");
> +MODULE_AUTHOR("Anurag Kumar Vulisha
> <anurag.kumar.vulisha@xilinx.com>");
> --
> 2.17.1


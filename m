Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9331027539C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 10:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbgIWIr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 04:47:26 -0400
Received: from mail-eopbgr1320095.outbound.protection.outlook.com ([40.107.132.95]:59132
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726342AbgIWIrZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 04:47:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZsvDdBdmwj3a7nB0AZM29q1FxauDIrWZ1a8Te9eWaJeDBiG00pAPtfnLteDYJeZ5r0pv50inSIi+eYXVChllSSl2H//e2PXr3Hk8hGZx7wbMTZnVhgJV+IXH/pF305eXqxdr93Yitc0pVEeuLn//TNQe7vicZSQwsKwMwkF2enC5MZ2wW59GDaPXl+PH1/hJR6khChXBkkoa8t1gr/pkqhNkzNfA003+oUi4LE/7P0JdWyZgQf+lhzLPhS60f+6pn+dTLow5R0gVw0ZoSMRyTkKI7QDBHv4Ba27LdvMoCuXQhpP3ZzJGqo59W0Rd1yuvJnJbwKVFBCr8ww1MLcSTGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8E/4XumCEPkVdnJ2/9Wkdgq+sUFXX/dONAeJdCPrTyM=;
 b=j1gTS75dV6SYKJELyb4nehsyZv+nQSVy4ADPIpkcLJxZOb2turucNd0Cds88WvsT5EFez3cYzAK7BFqSi5tap9cyI3Nbfzc53Gb1WbSchZOyv2dMdjtXVqjnmch1a0nvrI9H2B7/i6TdKYgQbm52cULBWvR8ka/graukpH/r+RJSlI/x9AyrNuMCv62343aQSaQPtmdl6kknuF0GertEjH7YJmHOcF/rRQB1szmduK+StxUKZXnn++uX6sePnFb8bT792rTCsMvz1fAA98NzoJbAOJsZDii3m1z4nf7Edxb6Chi5yNeFFvb+CLziKt2IyXOMLFKayoqCWC5Vu0X/gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8E/4XumCEPkVdnJ2/9Wkdgq+sUFXX/dONAeJdCPrTyM=;
 b=btaS3d69Ma+UF6ZJfBba8CEOdh/jsHiYPSq2SCYsbz0FLUWxPMwRdKsurj19umoc79PuYFwtO0bI8lYDhCokU9TT0ZbqhwV4JIhMlBNITgiB9sTzGyQ0rDIpiRh6eeEk0Zijk5Uq4et5u4qZWXxJsQq4XO8uBKEzB2vgLQR/WNE=
Received: from TY2PR01MB3692.jpnprd01.prod.outlook.com (2603:1096:404:d5::22)
 by TY2PR01MB4506.jpnprd01.prod.outlook.com (2603:1096:404:119::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Wed, 23 Sep
 2020 08:47:14 +0000
Received: from TY2PR01MB3692.jpnprd01.prod.outlook.com
 ([fe80::9055:525d:2d64:b625]) by TY2PR01MB3692.jpnprd01.prod.outlook.com
 ([fe80::9055:525d:2d64:b625%5]) with mapi id 15.20.3391.027; Wed, 23 Sep 2020
 08:47:14 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
CC:     Mathias Nyman <mathias.nyman@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Lee Jones <lee.jones@linaro.org>, Jann Horn <jannh@google.com>,
        Jason Yan <yanaijie@huawei.com>, Arnd Bergmann <arnd@arndb.de>,
        Chuhong Yuan <hslester96@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>,
        Saurav Girepunje <saurav.girepunje@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>
Subject: RE: [PATCH v4 04/11] usb: xhci-rcar: convert to
 readl_poll_timeout_atomic()
Thread-Topic: [PATCH v4 04/11] usb: xhci-rcar: convert to
 readl_poll_timeout_atomic()
Thread-Index: AQHWj97WeuTEVdT9kUKqeRXYZHMso6l16stw
Date:   Wed, 23 Sep 2020 08:47:14 +0000
Message-ID: <TY2PR01MB3692184CBB3C12EE8A02BA48D8380@TY2PR01MB3692.jpnprd01.prod.outlook.com>
References: <1600668815-12135-1-git-send-email-chunfeng.yun@mediatek.com>
 <1600668815-12135-4-git-send-email-chunfeng.yun@mediatek.com>
In-Reply-To: <1600668815-12135-4-git-send-email-chunfeng.yun@mediatek.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mediatek.com; dkim=none (message not signed)
 header.d=none;mediatek.com; dmarc=none action=none header.from=renesas.com;
x-originating-ip: [124.210.22.195]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 18b3fa72-7c64-4f94-2254-08d85f9d44f8
x-ms-traffictypediagnostic: TY2PR01MB4506:
x-microsoft-antispam-prvs: <TY2PR01MB45066FFE4117BA5D3D747F4FD8380@TY2PR01MB4506.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wWpdmCbU7vfEl4OwptWsXKwncwUD0XVZ8JPDhwXEvuKofquo0sIT6NvZfb3LsFqwUv9KshOUxs66jJvxZyaj2H8xaeMosMXJmRo0AziziGDctEJwAV0XKx13rDROw+EwJ/MSuNQTwrHFxzRT/EpQXtxmfZ/mndYs1aAJ7jj+un/xZRhpfqKyfxyFo0/3G85HB98JxnKhtLNo1WFnjfnO/Wx1SezKjD0mu6b75b9VUreddoiVMPk+p9qzMv0+z8FLgzecEIrPJGgjKSXnozYurL6ylsJoLQqCx+gQvDe/UvSiuUYcEWYuQSc4zzJABbVYQXQExPV97hkMOtTHdwJzId/QNRbvBIkoDyJz6JHMJI1i+jBaphfCcamUIAMoW2qt
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3692.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(346002)(376002)(396003)(39860400002)(26005)(52536014)(86362001)(2906002)(6506007)(186003)(7696005)(8936002)(5660300002)(6916009)(8676002)(55236004)(55016002)(9686003)(33656002)(71200400001)(478600001)(54906003)(316002)(7416002)(66556008)(66446008)(4326008)(64756008)(66946007)(76116006)(83380400001)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: vhCdG7K9t0Jz8grsOxqpQwdcxmZqZ6gTk4qYmKJY2k55L9DoBRfsru6S1DGvKudCGTGkKN/OSp7DaPw4XGgH79/wzOt+Q0yXvULn5CJVNH2paSnErvakn4RyLsTZTeiBqLQxFheZUOfDY6/dsLFHlRsli2mfozWoxuDKXcAlq5sPb4i3ijlUjXRNtzg70kIDsKH1GPYFK4vtyAQN2mCGBmc/hLsfMoP3clX0BnrPn8ez92A8WnqeqkhRHnbSNv4DF934Pm4urM1EQsKZ4lflgtawlBUm/5/kOXN4xVZ1i5F2M6tc0yDTrFTXoouV9q6OEcu9ELP2zKAQrILaIZPUkNHRwTAHzEQNb6UdVjvqwTjllQ+9Oe3AOEC2Ibv0GWAC9NXTbKr7mLuHYlENuNKpSxlyrC8xeOtdtFX634Fu3PV//ERF1/qLAcDJz6pqCebUzqj1dKyuueHRFi2upszjtg0X2mWTEGHqES1MCfJRnkV292JBTOjF2MoEOsbkTFOBEeSIbcgfujguoxSYKVsMxMv0dLEdeQDcbIsjSVzGs6k77K8Hd/V+gEmel7wnO/6ddCviJY2axw6tv+/a6QO7BTsc6ZC7QFyqGsLxe3w78NY9D9iqfO8kfVezEOXUl1bavovn5n9nGPz7sjZFqYdB1w==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3692.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18b3fa72-7c64-4f94-2254-08d85f9d44f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2020 08:47:14.2213
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n49f2EA9kreUV3Qeb9pOFWVNnsSEgZNg4tncohVzEaW1fn3FHMzyfR/hbzgnsRBNt6FGu1l1xDZ70caTVi/IJ9NPFqY7aQfAF6nyum/KQfYaQSW1U/ublyEbal1TLm0h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB4506
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chungeng,

Thank you for the patch!

> From: Chunfeng Yun, Sent: Monday, September 21, 2020 3:13 PM
>=20
> Use readl_poll_timeout_atomic() to simplify code
>=20
> Cc: Mathias Nyman <mathias.nyman@linux.intel.com>
> Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
> v4: changes
>     1. remove unnecessary parentheses suggested by Yoshihiro
>     2. fix the wrong return value suggested by Yoshihiro & Daniel
>=20
> v2~v3: no changes
> ---
>  drivers/usb/host/xhci-rcar.c | 43 ++++++++++++--------------------------=
-----
>  1 file changed, 12 insertions(+), 31 deletions(-)
>=20
> diff --git a/drivers/usb/host/xhci-rcar.c b/drivers/usb/host/xhci-rcar.c
> index c1025d3..1bc4fe7 100644
> --- a/drivers/usb/host/xhci-rcar.c
> +++ b/drivers/usb/host/xhci-rcar.c
> @@ -6,6 +6,7 @@
>   */
>=20
>  #include <linux/firmware.h>
> +#include <linux/iopoll.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  #include <linux/of.h>
> @@ -127,8 +128,7 @@ static int xhci_rcar_download_firmware(struct usb_hcd=
 *hcd)
>  	void __iomem *regs =3D hcd->regs;
>  	struct xhci_plat_priv *priv =3D hcd_to_xhci_priv(hcd);
>  	const struct firmware *fw;
> -	int retval, index, j, time;
> -	int timeout =3D 10000;
> +	int retval, index, j;
>  	u32 data, val, temp;
>  	u32 quirks =3D 0;
>  	const struct soc_device_attribute *attr;
> @@ -166,32 +166,19 @@ static int xhci_rcar_download_firmware(struct usb_h=
cd *hcd)
>  		temp |=3D RCAR_USB3_DL_CTRL_FW_SET_DATA0;
>  		writel(temp, regs + RCAR_USB3_DL_CTRL);
>=20
> -		for (time =3D 0; time < timeout; time++) {
> -			val =3D readl(regs + RCAR_USB3_DL_CTRL);
> -			if ((val & RCAR_USB3_DL_CTRL_FW_SET_DATA0) =3D=3D 0)
> -				break;
> -			udelay(1);
> -		}
> -		if (time =3D=3D timeout) {
> -			retval =3D -ETIMEDOUT;
> +		retval =3D readl_poll_timeout_atomic(regs + RCAR_USB3_DL_CTRL,
> +				val, !(val & RCAR_USB3_DL_CTRL_FW_SET_DATA0),
> +				1, 10000);
> +		if (retval < 0)
>  			break;
> -		}
>  	}
>=20
>  	temp =3D readl(regs + RCAR_USB3_DL_CTRL);
>  	temp &=3D ~RCAR_USB3_DL_CTRL_ENABLE;
>  	writel(temp, regs + RCAR_USB3_DL_CTRL);
>=20
> -	for (time =3D 0; time < timeout; time++) {
> -		val =3D readl(regs + RCAR_USB3_DL_CTRL);
> -		if (val & RCAR_USB3_DL_CTRL_FW_SUCCESS) {
> -			retval =3D 0;
> -			break;
> -		}
> -		udelay(1);
> -	}
> -	if (time =3D=3D timeout)
> -		retval =3D -ETIMEDOUT;
> +	retval =3D readl_poll_timeout_atomic((regs + RCAR_USB3_DL_CTRL),

We can also remove these unnecessary parentheses like below.

+	retval =3D readl_poll_timeout_atomic(regs + RCAR_USB3_DL_CTRL,

After fixed this:

Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Best regards,
Yoshihiro Shimoda


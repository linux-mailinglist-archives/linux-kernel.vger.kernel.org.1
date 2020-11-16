Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 317442B4547
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 14:56:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729920AbgKPNzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 08:55:10 -0500
Received: from mail-vi1eur05on2068.outbound.protection.outlook.com ([40.107.21.68]:61984
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729893AbgKPNzJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 08:55:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DC5jlxCbgvo6FNj0J+LlV/N7C0Vf/fiIf793DoFWuJNjLZyjmlHHNU11d9LtNM0JTnsq7h+t8CfkrUNUlr1Y3P3KfC3GxG1+jsl3e4fpDjRpD/LL/zY0rPVhFF+6/ny470VHfGhfRkBEyhcmUk8r+1bGaJzP6Nwdkzro3Vmi+uLzdPIkN4c8zvuK0fhrTmrxbapPMvwfoHdVQjdKhgCkEjAnOBlaqNbNl3uV0n/Fs+zSnd7QPWMWBN+I76ONrqvS6tNZRPG36EESLauC75wqDr6UHrTJal++YR7kP24ROiMVHH2YlxOoQiVFiMCOMIe1Xepwznlc6scciiyud9U3Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BTCGtJZU6Cc8Dt0PL/q6A7yV90Wxo5YLV/kTh+e7CD0=;
 b=M8GyR4BdN7HWF5SW8pO0XzhUTGX9hzqJ8hB48ENaBLxzLlOg50asEQ4xagDdRVzj9NFtBNFCca2gxdYqTjQ13Ds3y4s5LZJTUZmQdwOGEaAiiRlPMy/Gt+TEbDGvE3l63w16hLSdU6sgOAxJhVm8aINYUWcwOk8GlhJExNWkyKWTN0cNhqfCE7Qgpe1lHih+BoZk7f6vI2V7nIRzng/3kYQGI/YejY9toxOdznJBcu3wVovZUaFtkMsDxk+hxB+Aj1ek+dY9XwqfI58QD6D9m5RwHlshybRBflFrYjyk7OQu4Uc0Fa1DKA9PtV2jhq/JBLbuOeBUgGWN/yjxRe4l3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BTCGtJZU6Cc8Dt0PL/q6A7yV90Wxo5YLV/kTh+e7CD0=;
 b=ARC9jqjg8nn8TstHXKn6fG4YIk1JmxbY/KnoQu205EhIAvPadoExhYUS3iGaMV4kAsIft3J9k/KUBWA64xYSsgnjVXcuLzl3hBKKMl+8qjdbaXfipd9y7gVuI7QOjBWWZfh1VqELHgyEEXSYAxHOw9DeRfAQknQsEhN+jJNwofc=
Received: from DBBPR04MB7979.eurprd04.prod.outlook.com (2603:10a6:10:1ec::9)
 by DBBPR04MB6027.eurprd04.prod.outlook.com (2603:10a6:10:c7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.28; Mon, 16 Nov
 2020 13:55:04 +0000
Received: from DBBPR04MB7979.eurprd04.prod.outlook.com
 ([fe80::c8c:888f:3e0c:8d5c]) by DBBPR04MB7979.eurprd04.prod.outlook.com
 ([fe80::c8c:888f:3e0c:8d5c%5]) with mapi id 15.20.3564.028; Mon, 16 Nov 2020
 13:55:04 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Wesley Cheng <wcheng@codeaurora.org>
CC:     "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "jackp@codeaurora.org" <jackp@codeaurora.org>
Subject: Re: [PATCH 3/3] usb: gadget: configfs: Add a specific configFS reset
 callback
Thread-Topic: [PATCH 3/3] usb: gadget: configfs: Add a specific configFS reset
 callback
Thread-Index: AQHWul43O0hfmlT/D0uhAjVYLr2LN6nKy00A
Date:   Mon, 16 Nov 2020 13:55:04 +0000
Message-ID: <20201116135435.GF28313@b29397-desktop>
References: <20201114081247.25063-1-wcheng@codeaurora.org>
 <20201114081247.25063-4-wcheng@codeaurora.org>
In-Reply-To: <20201114081247.25063-4-wcheng@codeaurora.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: codeaurora.org; dkim=none (message not signed)
 header.d=none;codeaurora.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fa396b52-0fa0-429e-9ca1-08d88a37388d
x-ms-traffictypediagnostic: DBBPR04MB6027:
x-microsoft-antispam-prvs: <DBBPR04MB6027E21073943770E726B7DB8BE30@DBBPR04MB6027.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VTb9b8mt/J0lGdQ+AuChrfucj1KZEg+IHqm1T/Jwfd1jqUjI80uN2Npz0g5pDftTYJ6XkvQEuFvA0aLtI+Ppp20nK4w0JTMv0S7Z3Gq+I0I5DqmMzRk6vKhjQbS9KuD024DUqy2c8i8wyfHuasdG4w6Pmmj+SQvPvNUmiG3TIy5B0UAWbf2TU/NcSPT31jnSCBH4V3XPogKZ9Ch7H9KvzkntwQb+VMUkrAY5tkYVvsS1v5Z5e1x1GBDVXap1TeCE6CSLTz+9twr+Y+LhLoZfU+R5Oco1hNUrC7DDwcRzzOZItiihKrI8AgjdM2/iVUKaGMgj/yJjoq8hL4btjGyqjw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7979.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(376002)(346002)(39860400002)(366004)(396003)(136003)(478600001)(6512007)(2906002)(83380400001)(6916009)(6486002)(9686003)(186003)(76116006)(91956017)(44832011)(5660300002)(26005)(6506007)(316002)(54906003)(53546011)(71200400001)(33656002)(8676002)(4326008)(66946007)(33716001)(66476007)(86362001)(66556008)(66446008)(64756008)(8936002)(1076003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: rQsIPLJBoJPgTnVujPYw7vT05xQNbLk9jg/l2j7gmO4b5pUny9He2d/drWK7oFQROWfD/JY57jEFGYbPSUGraWoxdpNa3t+UWFahx/dlGZKTEijQFIHlkmAoNtKO0Co66X7IW8DEjHPxZ67VJ04AxP9CsGmWEERUjmquv8tDb4tt0KY9XeOP6WCUYxREPq+y20F7gZTjwpZBbuyGWkiUIFnMFqArJATS2WKA5MXIxd9TalDGz0CLN9r44PJCE2xvp0ZbfaGz9ehGGv6lr4I455qkTOy0hkANxk9++oGN4R2BDA2rqqijo9vuHmdMUoHW053y9bXlx7ZXYWxpOhQmbYRT4CL6xeSqu049oxUWr28YbszW05+NG8pT4KMbL8lvnEb8uSfVaEVQAus1pakEfPZI6tvm+WeywS9R255z49RKStnqwHBACvyu0HDWV3AOmj0G5Oi1kHalU8zBebVCt78Slwhjos7xJ9GrJezvXZGgkxnmvItTQfpukkES5k4J0tFRGBXRuRrNZVgdi2trdsVmGzG9ILsqGjpqAgOC/XJFgVkW0B8ropf3BSTBnoewJ3zxgEU+/Ii0wUr6t3KGz73dH+1VyIMATviPs8eS3Izuqv5wGKz54p6fXme+6vkFAfpqbToW7o8XO/8DhlP9BQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <122BCDA57440CF41B1520864519A7F39@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7979.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa396b52-0fa0-429e-9ca1-08d88a37388d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2020 13:55:04.8588
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zb9zSlvkzZ4y9zb+mJKg9q+ubdzpAM5jqdgEfUicx9ug1c3ZiQ+DwfljD7HDj5JEw0fLmlwf5R5GESlgNT0fsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB6027
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-11-14 00:12:47, Wesley Cheng wrote:
> In order for configFS based USB gadgets to set the proper charge current
> for bus reset scenarios, expose a separate reset callback to set the
> current to 100mA based on the USB battery charging specification.
>=20
> Signed-off-by: Wesley Cheng <wcheng@codeaurora.org>

Reviewed-by: Peter Chen <peter.chen@nxp.com>

> ---
>  drivers/usb/gadget/configfs.c | 24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/usb/gadget/configfs.c b/drivers/usb/gadget/configfs.=
c
> index 56051bb97349..80ca7ff2fb97 100644
> --- a/drivers/usb/gadget/configfs.c
> +++ b/drivers/usb/gadget/configfs.c
> @@ -1481,6 +1481,28 @@ static void configfs_composite_disconnect(struct u=
sb_gadget *gadget)
>  	spin_unlock_irqrestore(&gi->spinlock, flags);
>  }
> =20
> +static void configfs_composite_reset(struct usb_gadget *gadget)
> +{
> +	struct usb_composite_dev *cdev;
> +	struct gadget_info *gi;
> +	unsigned long flags;
> +
> +	cdev =3D get_gadget_data(gadget);
> +	if (!cdev)
> +		return;
> +
> +	gi =3D container_of(cdev, struct gadget_info, cdev);
> +	spin_lock_irqsave(&gi->spinlock, flags);
> +	cdev =3D get_gadget_data(gadget);
> +	if (!cdev || gi->unbind) {
> +		spin_unlock_irqrestore(&gi->spinlock, flags);
> +		return;
> +	}
> +
> +	composite_reset(gadget);
> +	spin_unlock_irqrestore(&gi->spinlock, flags);
> +}
> +
>  static void configfs_composite_suspend(struct usb_gadget *gadget)
>  {
>  	struct usb_composite_dev *cdev;
> @@ -1530,7 +1552,7 @@ static const struct usb_gadget_driver configfs_driv=
er_template =3D {
>  	.unbind         =3D configfs_composite_unbind,
> =20
>  	.setup          =3D configfs_composite_setup,
> -	.reset          =3D configfs_composite_disconnect,
> +	.reset          =3D configfs_composite_reset,
>  	.disconnect     =3D configfs_composite_disconnect,
> =20
>  	.suspend	=3D configfs_composite_suspend,
> --=20
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum=
,
> a Linux Foundation Collaborative Project
>=20

--=20

Thanks,
Peter Chen=

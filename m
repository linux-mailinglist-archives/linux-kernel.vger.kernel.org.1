Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B817628C996
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 09:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390503AbgJMHxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 03:53:53 -0400
Received: from mail-db8eur05on2056.outbound.protection.outlook.com ([40.107.20.56]:10848
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390484AbgJMHxw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 03:53:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jCpmf6MfMPvl3Vsp3pK0npYwQAC05Q0pTHCiMdjwwVpp9ioLCuP9BzKwHlk+wyWXlv+CLLS0WUDvuntMt7cYTEvTvfZIJbZ3EfShPbOm8qPRs8/M7DWBcpA5Rm7eKrRoCTwS37yWhLdCtlsoiiDUhnw3pHq5mi4qK1zBj/Zee0+2w5nWZIIlor75oWPVRmJDwLQk+eW0VLOidLIHQoQojjNaCFnyc94bmtkE3RO9qZIbUb1lqVJF0wMp9flgen4rcaXlo6SqZDtU9Tc4i5t4kXCP5ZpKWZkEvF4EPDlJaPIZPne2UDpuoNmmPQ9P+ZzfPutR7r+gBNmhPCTTyF66Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MfXVVmVu20XzWWDIyhAb+fnM0AwaCIpfHbg6yzZavIs=;
 b=gRfj4o4odMDF+zapNfc4Ee867O7L3t/Eo0gkPHMm8NgFGPndH+FP8xizYpiHtoT0oaR6hKeiWFDb5DdGBdxyxBHKtdBd8RY1V9dwAdyNukmdcdkngrndHJ8Ro3BMQbgdEk/F8LUttVlyYPYGvKqpdJFxzbT2ILi1T3ycoUY3MB2V/OwTL1e4tZn1EUi6ex5nxjLmKc4AvdnW3DyVtdKsZ2VvxDdAMitqser5PR7qyZyI0Opx5BYL3xkEQZNWCqZpIuoM6SeH8wEVlvcDhVBBZIwreQ6IYI+qHqZJyLkV7H/jNgW8DuyEFZeQzhndXPFR5gO9O9muP7nNbrYgO9B/7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MfXVVmVu20XzWWDIyhAb+fnM0AwaCIpfHbg6yzZavIs=;
 b=O3cds9tUzyqrAXcZvheYJ6R9Oeh1KpCLjy7Ky8Pt5QZp5/3Ex7xyIPKAafeyZqdcZupVvhA1O+zjmAZz/TCl3meQF8axp5gQE0ObHqR1k9McKnA+96u7auI5sg3sneCNeU9z7kitnr48z4wz1UXzik187HTwDfdfyvKN02TjiUE=
Received: from AM8PR04MB7300.eurprd04.prod.outlook.com (2603:10a6:20b:1c7::12)
 by AM0PR0402MB3537.eurprd04.prod.outlook.com (2603:10a6:208:20::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.26; Tue, 13 Oct
 2020 07:53:49 +0000
Received: from AM8PR04MB7300.eurprd04.prod.outlook.com
 ([fe80::ad01:9b1c:3b4b:3a77]) by AM8PR04MB7300.eurprd04.prod.outlook.com
 ([fe80::ad01:9b1c:3b4b:3a77%7]) with mapi id 15.20.3455.030; Tue, 13 Oct 2020
 07:53:49 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Pawel Laszczak <pawell@cadence.com>,
        "balbi@kernel.org" <balbi@kernel.org>
CC:     "rogerq@ti.com" <rogerq@ti.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kurahul@cadence.com" <kurahul@cadence.com>
Subject: RE: [PATCH v3] usb: cdns3: Rids of duplicate error message
Thread-Topic: [PATCH v3] usb: cdns3: Rids of duplicate error message
Thread-Index: AQHWoRVn2B+tSOfiSUSGMpYsT2GpRqmVKYGg
Date:   Tue, 13 Oct 2020 07:53:49 +0000
Message-ID: <AM8PR04MB7300072DF781A5FD6FAA51DD8B040@AM8PR04MB7300.eurprd04.prod.outlook.com>
References: <20201013040005.25706-1-pawell@cadence.com>
In-Reply-To: <20201013040005.25706-1-pawell@cadence.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: cadence.com; dkim=none (message not signed)
 header.d=none;cadence.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8676eb39-5c8c-4fe0-48f8-08d86f4d1ec8
x-ms-traffictypediagnostic: AM0PR0402MB3537:
x-microsoft-antispam-prvs: <AM0PR0402MB3537CF8FFCAF55D56002ABB58B040@AM0PR0402MB3537.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: f/d2pElMUZNmWcH7hpeo0KZz2PyMJRjVZQg3BaVZmmEBmYm7wdukahZSiNHZSZqg2B/Rk4FeubRExjdn5GAQInS6aICwx7Mkhg+s1ePzoNDMgV8h+yAz9YMj3jScWWKVzhdLl/8xfmnZgr677B7DlhShNW2Z7GP/aqHX0UebaLTOi/2XrjyjY+aRRc1m53xLi+HV5S1lS7jqOl+NdEA3ND/JWol3vSf155BCVgzbASFwFgUINUPbxKxJXHZ89oBbZJlg/6oXLTHVLrPmL9OvSta1VbVBolMc71gODGjhrfNXCd3DixVNfqJG8zctX1vZWNzc/ZKtkuvwD0sKTZeN+Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7300.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(136003)(396003)(376002)(346002)(52536014)(110136005)(316002)(44832011)(54906003)(8676002)(8936002)(83380400001)(7696005)(9686003)(5660300002)(4326008)(55016002)(86362001)(66476007)(66556008)(66446008)(64756008)(33656002)(6506007)(2906002)(66946007)(26005)(186003)(478600001)(71200400001)(15650500001)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: R1bE6djfOB9vER73Dr3XZ6EA1KZM7gSk/Tm9eDNJmqfdcgiy79aGTKyNJWktzBnzUkpCFISo4DwOYQ+1BYvEKLXwWq/FVnbx520eRRmHig9/fgZHYCbrHqw6z8pyDuRqFzUfbnlo+kL/413Zpjw4B8JxIrTYEu8PtRtjXD6jAE+fAVacS0ksXms7XFlUhyFWByX1LG9CGSynOVCCiuPtXMNV/tWITsbRr7bpuR3UUNzsOU104LLSIwC7yV64p3FKU2AoMmiQ2vu9ijPmL/c/w1Axdy/GLKqcuMI8oyq2BP57ewBnEZFG7sz41/VRIErYcYbVLDwx23ESpDn7dMKdBZrXALiYTd1EKC96BKIBr0GkKc4ke10WWks6V5Osn8TPOm5IuQTDFj9Lk9WHWWUdjOIS0nnxSnAPHK5IhZ2yQ81inYkBeAgmxmII8zVT1oF5winFy9hP6NBD7V1kzCJDxQAWwqKWm9UZjQjiCv5KnEhgVxDZbCyxpAkdEoGypAX0vo4Ro1PQ6NrTgPMjFmt/AIxymYL0mujMfxZ4qsevvvQ2RaO6j1CSYEDnhVsoaOsTy8OWUIUk/tmuzCnKSloiF1ZK/4npNCi1D3OV2audKmqTZoXi9mLCKAO2vy69kPO+nhlwMO4GqALP3t32+yIynQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7300.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8676eb39-5c8c-4fe0-48f8-08d86f4d1ec8
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2020 07:53:49.1646
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hlID5c8sGuX9uE46Eh0r1wKrX/37ooEpjhW8BLMzTsGe9Ckbi7eExqoOq/UQ7IzfvBBVk49HfCNfjZSjBdsR2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3537
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=20
> On failure, the platform_get_irq_byname prints an error message so, patch

typo, "message, so patch..." Otherwise:

Acked-by: Peter Chen <peter.chen@nxp.com>

Peter

> removes error message related to this function from core.c file.
>=20
> A change was suggested during reviewing CDNSP driver by Chunfeng Yun.
>=20
> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> ---
> Changelog:
> v3
> - changed error condition checking for dev_irq.
> v2
> - simplified code as sugested by Roger Quadros.
>=20
>  drivers/usb/cdns3/core.c | 12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c index
> a0f73d4711ae..f2dedce3a40e 100644
> --- a/drivers/usb/cdns3/core.c
> +++ b/drivers/usb/cdns3/core.c
> @@ -466,11 +466,8 @@ static int cdns3_probe(struct platform_device *pdev)
>  	cdns->xhci_res[1] =3D *res;
>=20
>  	cdns->dev_irq =3D platform_get_irq_byname(pdev, "peripheral");
> -	if (cdns->dev_irq =3D=3D -EPROBE_DEFER)
> -		return cdns->dev_irq;
> -
>  	if (cdns->dev_irq < 0)
> -		dev_err(dev, "couldn't get peripheral irq\n");
> +		return cdns->dev_irq;
>=20
>  	regs =3D devm_platform_ioremap_resource_byname(pdev, "dev");
>  	if (IS_ERR(regs))
> @@ -478,14 +475,9 @@ static int cdns3_probe(struct platform_device *pdev)
>  	cdns->dev_regs	=3D regs;
>=20
>  	cdns->otg_irq =3D platform_get_irq_byname(pdev, "otg");
> -	if (cdns->otg_irq =3D=3D -EPROBE_DEFER)
> +	if (cdns->otg_irq < 0)
>  		return cdns->otg_irq;
>=20
> -	if (cdns->otg_irq < 0) {
> -		dev_err(dev, "couldn't get otg irq\n");
> -		return cdns->otg_irq;
> -	}
> -
>  	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "otg");
>  	if (!res) {
>  		dev_err(dev, "couldn't get otg resource\n");
> --
> 2.17.1


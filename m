Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 398BD2B456E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 15:03:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730218AbgKPOBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 09:01:37 -0500
Received: from mail-eopbgr60055.outbound.protection.outlook.com ([40.107.6.55]:34693
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730211AbgKPOBf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 09:01:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=idndw+9bjNvng9YfM5RKu2LBj/mIU2aJ8n4DKg3uQl4OGZeo8Nxriu+LuuZC15UsWjiykCNgBFFfHYijONBBfDHYO5hkBNg5DnepLFML1kVH1nFPRIZdb5QB0PlL1EgJMsau/7MOI3jmGavcgZAXIMy4dqRmHYX/ESB++IDboZEcyjDUBDyGco6DswQYYYBWa5vJoyon67FH0uhQodIydTUM2aKPj2JWH0LF3KNCRqZtt3xygO8redpLaVTHlqdZJT8lewXaeEMYfbd/cedkHkE4bnkggHm5eg0+NuRRc1kpanmu+8veyDqv0q/4NPd3T0oE9KpvjxFmucs7qAZK9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zwuI+rn5HNfIbC6upNB+7LKwEGjcclUS5DLsoDgOSw0=;
 b=ivSHafjy/0eG+s85LaJPcen9DnAJuQO5SmvjunB1AW2sKeDVaw8ktFYP11c83vPyev7jlT9nJ/nNpNf+dASIX0HPhCdqsskqCsByF0D6lSabNeFeZOlY2m24sczy/Yq1Jl9QYkJrIAOq9po52n0KLUAm6oBF9RJ4jA2e0tavkPmMNRXTNw8fkFBKp5PU75vwXvCT/5PFNIUPoUHPcGa4Zsg+ci//6nKHyyiZc1WREt4aZkbwkil2WAOxVwbepAjpoda1jvUy/HdsWZwOqeSu24otWevWxPl0Y/3CxUJxmSmeDi7UtVnVGzehISZ1qrpBWq2xMNqRbYS9E/1Wo7E6gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zwuI+rn5HNfIbC6upNB+7LKwEGjcclUS5DLsoDgOSw0=;
 b=HTxgnnUp9w+puKT7jiYZCIsBkTDZ0B04Zsn3u4OnJVVvua4/M+sYQi/qMHV5rnPzhLBzSa75kyEWrmkYNyr8wGxJefKUo16E+RNFMi01H8AN7mk1jQ1dw0Qg6Ph6QHSIljOKF9NyYaEdxbE+pOpyu4w5GqWiL54ePDxEOw4EoME=
Received: from DBBPR04MB7979.eurprd04.prod.outlook.com (2603:10a6:10:1ec::9)
 by DBBPR04MB6027.eurprd04.prod.outlook.com (2603:10a6:10:c7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.28; Mon, 16 Nov
 2020 14:01:33 +0000
Received: from DBBPR04MB7979.eurprd04.prod.outlook.com
 ([fe80::c8c:888f:3e0c:8d5c]) by DBBPR04MB7979.eurprd04.prod.outlook.com
 ([fe80::c8c:888f:3e0c:8d5c%5]) with mapi id 15.20.3564.028; Mon, 16 Nov 2020
 14:01:33 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Chen Zhou <chenzhou10@huawei.com>
CC:     "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "weiyongjun1@huawei.com" <weiyongjun1@huawei.com>,
        "jun.li@freescale.com" <jun.li@freescale.com>,
        "rogerq@ti.com" <rogerq@ti.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH v2] usb: gadget: mass_storage: fix error return code in
 msg_bind()
Thread-Topic: [PATCH v2] usb: gadget: mass_storage: fix error return code in
 msg_bind()
Thread-Index: AQHWuPqsLIOnAtmxwUipVxtESKIpeqnKz+IA
Date:   Mon, 16 Nov 2020 14:01:33 +0000
Message-ID: <20201116140104.GG28313@b29397-desktop>
References: <20201112135423.89536-1-chenzhou10@huawei.com>
In-Reply-To: <20201112135423.89536-1-chenzhou10@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 59ca0937-133b-455b-35e9-08d88a381fef
x-ms-traffictypediagnostic: DBBPR04MB6027:
x-microsoft-antispam-prvs: <DBBPR04MB6027F6233ABC3C02F01B4C378BE30@DBBPR04MB6027.eurprd04.prod.outlook.com>
x-ms-exchange-transport-forked: True
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eP0FywL9RcClidAcFY8KlsUcw9IMMGTenwuYdVglSmKXr16Q3jFv3D9oyvo4bTFRdCOh3Og47e+a8I3N4ldtqiXT/6KviLDbW1gI4PMEtNa4Xk64TMNZkd2RL5YYdzxsUt6c1jnPt2Hzw5w7CWuNSPN3xgAmddl1F+mU8+y+ZPPuCZeZ3jG0taVtz2/ymfsTBg7j/N/cMNfLs17roS/ycpgYiKPS2e5og3pJ6y167Tj81c5rkVgm2kzvZi/TLweGE/qOaYLGCgKdauCsN1yy0CnISC/M6U1jcm5s5b2DJLJd9yVhI7yIZGzzlQUPE5VyXS/gV89gjQcxi2j5IqQy1Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7979.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(366004)(396003)(136003)(39860400002)(346002)(376002)(26005)(53546011)(71200400001)(54906003)(6506007)(316002)(186003)(44832011)(5660300002)(76116006)(91956017)(66446008)(64756008)(1076003)(8936002)(66556008)(66476007)(86362001)(33716001)(33656002)(8676002)(4326008)(66946007)(83380400001)(6916009)(478600001)(2906002)(6512007)(9686003)(6486002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: xfSPciGe4yiheKmL/nzAUW1C3a4vzdCyDgVjxFZXAH84Sp0oeTEG4dSpFIDpNI6s1pTMEIcdm5tQQx7K953K1pre1cnX0vxcBx6FznC4SFN6Obkoo68hXzJerRPZkb+kKxUdGJrvvse7qTYhHZSG4jrmqKj0kMeQV/Y/ev2OPCw51PLnpAbF494Z3VnAkVckX921u+ctVC3v/ll20z7EbXoxNGMLUzrToBVl86390nRcI+0u6VBosmjb8UITyzjhvL+sOzfDF2FeTHFvF6IKYkCU8ivYdE40lKZ4N/VDz+wyubc55qwiN7vSDrbtj7uoPMXbw+VBrwE3YSdsH/ewlLJKTy29dR8jpEI/tfhI7p2LTFRVlHCwzL7HNNz4XegdgW/YHQlaQJ0LceEVGtJMLKlZMBdLPuXg1kUnVHTZoqPrz8XrZpMi6Sj0+JsM1gnNBE4DicnkOHc/nWO7oe+b9gks2P2cd3vS09wuKx966fHrRG0uoO9voXx+3twQOg3PiPj9Hfo3rYnj2F7F8AWEs8JLtXsDR0Jhi0p5BoNg7RwWIuP8jWmpnkQ0s3BuMmGCF+83NOWWXyzK7y4qI/MidsBRzXcNd0ndjlg5WnzAqp1TnPLRNyD20Y9RLEacQn690APwomOPIlBoFkCQPd33gQ==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <93BBCD88BDED4349B2F61D504CDF2BEC@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7979.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59ca0937-133b-455b-35e9-08d88a381fef
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2020 14:01:33.0591
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lAFXCUpN3WnPZQeOiL78TjfcvU5DKjz+sX2JBJtOY6lFl5ecDq6O5C7M42ZKTgrrYsf0tGzQ+Em5TR1H+sAB8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB6027
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-11-12 21:54:23, Chen Zhou wrote:
> Fix to return a negative error code from the error handling case
> instead of 0 in function msg_bind(), as done elsewhere in this
> function.
>=20
> Fixes: d86788979761 ("usb: gadget: mass_storage: allocate and init otg de=
scriptor by otg capabilities")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>

Reviewed-by: Peter Chen <peter.chen@nxp.com>

Peter
> ---
>  drivers/usb/gadget/legacy/mass_storage.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/usb/gadget/legacy/mass_storage.c b/drivers/usb/gadge=
t/legacy/mass_storage.c
> index 9ed22c5fb7fe..ac1741126619 100644
> --- a/drivers/usb/gadget/legacy/mass_storage.c
> +++ b/drivers/usb/gadget/legacy/mass_storage.c
> @@ -175,8 +175,10 @@ static int msg_bind(struct usb_composite_dev *cdev)
>  		struct usb_descriptor_header *usb_desc;
> =20
>  		usb_desc =3D usb_otg_descriptor_alloc(cdev->gadget);
> -		if (!usb_desc)
> +		if (!usb_desc) {
> +			status =3D -ENOMEM;
>  			goto fail_string_ids;
> +		}
>  		usb_otg_descriptor_init(cdev->gadget, usb_desc);
>  		otg_desc[0] =3D usb_desc;
>  		otg_desc[1] =3D NULL;
> --=20
> 2.20.1
>=20

--=20

Thanks,
Peter Chen=

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF9D28A47C
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 01:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387546AbgJJXlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Oct 2020 19:41:00 -0400
Received: from mail-eopbgr70043.outbound.protection.outlook.com ([40.107.7.43]:55877
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726989AbgJJXlA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Oct 2020 19:41:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eArVUn3kI1vY2opaWDngT6NK1B4QECBV8EjEAOOZK5ipevUPzrmu4x06BzjL48Wf3atRMI1A/VvgJ38CdctjQ4VpNQs+Fy263dMGwn+g6liORcmUesoCa2GQ3VCqPxEWUcMuqOF5PH3NcCFCMvqGpXQipsZM3CFGMAMAbNmIzIzBIZf/fzWzSw6Iil+IzZpMo8+wPh1Oo33sOWjOWs9SZe2vlOB94w5DGf4euKpRQAL+wbu0CeEoKQzUxPLyarhIyETk4NUydYLo81D2QwiEx4QWfEovb7BbaqZ28mbkWshlZEM9A74sbHjhOXrWlfbEsygFSmF+naLZkGxzZtANgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b5wAntxq+9TE0g7PNZNxBuXDLYdS4G25ouLpHBEhLxA=;
 b=IXQsy4uuAZ6fs9YwzTaUNEuDM/vxuCL/ttjimVNWfJcCnaYEZb6d6zE7uu9A9813eh0Mxe2m9q2JTeKAgty1DI53t9ZNyO0YtiGAzg//IHyl/ggDTmhHJ8MH2xmq3w7PK4ehBCgAZcxiOPSaGP2CJ9hsNAvkw54KRsCTBl/mkoZ9xWpJbwAlRjMefueHkoLJZfHB2sPGduM1xBFYu7fLNoMdiCSy7gcSC5iK5htySt4c2LCV1KVGP7+i6yRxnfMP6PhXtD7+X+5UPlVmTYdQ5fqdnC3CPNlY3FZznffVEab2e14MjCxj4UASyYT01IKMkWbAFv77Nb4PzcrS9qtOxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b5wAntxq+9TE0g7PNZNxBuXDLYdS4G25ouLpHBEhLxA=;
 b=UWbzy3rpPNgaOydYdFce+9RI2pMX99hgqMpBqw9CFYQ00YS4lHWGNw+GlfLzGtF39X29XLKI2/pGMD/ySXyKXLxtrxqBKp1o5qLkUtz01dqKvOp5WDG5H841D7UvUeU1KTI5RZszuh4otK74pTB5bh3tWR9fKVkEtcSCE1ikwus=
Received: from AM8PR04MB7300.eurprd04.prod.outlook.com (2603:10a6:20b:1c7::12)
 by AM0PR04MB4417.eurprd04.prod.outlook.com (2603:10a6:208:76::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.26; Sat, 10 Oct
 2020 23:40:56 +0000
Received: from AM8PR04MB7300.eurprd04.prod.outlook.com
 ([fe80::ad01:9b1c:3b4b:3a77]) by AM8PR04MB7300.eurprd04.prod.outlook.com
 ([fe80::ad01:9b1c:3b4b:3a77%7]) with mapi id 15.20.3455.028; Sat, 10 Oct 2020
 23:40:55 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Ran Wang <ran.wang_1@nxp.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jun Li <jun.li@nxp.com>,
        "open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: host: fsl-mph-dr-of: check return of dma_set_mask()
Thread-Topic: [PATCH] usb: host: fsl-mph-dr-of: check return of dma_set_mask()
Thread-Index: AQHWnsxMafGOyChLpEqh4ZaQKTdKaqmRf+CA
Date:   Sat, 10 Oct 2020 23:40:55 +0000
Message-ID: <20201010234028.GA16433@b29397-desktop>
References: <20201010060308.33693-1-ran.wang_1@nxp.com>
In-Reply-To: <20201010060308.33693-1-ran.wang_1@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0fe317c8-1728-4a2b-678a-08d86d75eeeb
x-ms-traffictypediagnostic: AM0PR04MB4417:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB4417C14C7BE712A1903A9DC08B090@AM0PR04MB4417.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:792;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qtvIQPxtNy7UFnSCbuIb9xD7fRd2VPOVFAVeR8YxaIVYxhoa7YiLaVWoM3MTFLe2PP9wfhNljfE45gjfvUNUwpOkShJAqSaV5UWYkLgjCW1N0PMZaMVSxSVvgTUPVadZgeh/bqRgLpAOlCelJcOUBlpJWB/JcbdQn/HTsSArZgjZGbvzpQQSTF6fWkYkyrKml4btaWDOv/BcmbVIH0nRj4qb6clMeyO8sLqATORBgJN2gdxsSOxxYtCmiS++F2mfdI7go6dLPN2rFdpsviXPfhDOQCu2LJ2Mcm1W0JeIxEf24CWYIzFg/ISuPhR8ZNe5TnedCcw1GOZI6R9CVcZy9Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7300.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(39860400002)(376002)(136003)(366004)(346002)(396003)(91956017)(9686003)(8936002)(66946007)(86362001)(71200400001)(64756008)(6512007)(66556008)(66446008)(76116006)(66476007)(54906003)(186003)(316002)(53546011)(6506007)(6636002)(44832011)(8676002)(478600001)(6486002)(83380400001)(1076003)(33716001)(5660300002)(33656002)(4326008)(26005)(2906002)(6862004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: NxEWXVuIyUFpDp0IxQEmPiQ2ZxTvw/4t05qGmC6IibcOnRK04b1BdYn6Pp8/d6XRsr92hQkSqYUD+0p1/qly9e+HkJLxjQp9CnBX+l6Bp4xntFOWaSyi8malCxQx9cPnuW6yW9xy8qjko4fXydPFDjar+zjfHGDoKRCWKKO53gn2y3+cbVaDswElwVTaZmRmIJAHRJUY/A3a1hB9mAuW7q0oeiWvASwy3bdH89Htfs8weJOhH0EvmWy08VG8ePrVrdMnqTmt03V9Y+6mjlnoxeIc8dzh3jYfvd/5x/Uts03e7d/mNV5g6WW84PacfWDsd2j1LWzN6bj++9B9//xyixOssx6cg5TIqGX8SqlDvHs8fVujtsUFIuKDBgBDeZFUeogBzcSVD28OX7jREU3WGKurgmjAW+lh+6tY8IZG5fRpBPyGokPfIqrNoB7K211dvgVYNTNCyrWSn0PrmI1Kdd1b5XzSvsK6IE4ENhY/rq1NE/JvO9WbkV7FA4XheInMKJaXkOb2HfJazAApCBXYNnxsZmfltJqqKjELgvDTNUcglOch0hsfBUmS1MtxCA6cx7djh/ed6/qeSLuKMtYnmjzQldEnJ7icJ8lJfRfNugPY7Ujk2swiVPabGtb8357QBSS2P7jxIFzkU4ahhl/xNw==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B7AD5C457915104989BE8079B8DAEF0E@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7300.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fe317c8-1728-4a2b-678a-08d86d75eeeb
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2020 23:40:55.8527
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZDsb81wKufnrdp4VC1r82nR5x2W8jMIIlWtR7GSmJ7IBW/mrl1abhouH7C5A/ccgscVWSt1O2pmNsShK8o+KMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4417
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-10-10 14:03:08, Ran Wang wrote:
> fsl_usb2_device_register() should stop init if dma_set_mask() return
> error.
>=20
> Fixes: cae058610465 ("drivers/usb/host: fsl: Set DMA_MASK of usb platform=
 device")
> Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
> ---
>  drivers/usb/host/fsl-mph-dr-of.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/usb/host/fsl-mph-dr-of.c b/drivers/usb/host/fsl-mph-=
dr-of.c
> index ae8f60f..44a7e58 100644
> --- a/drivers/usb/host/fsl-mph-dr-of.c
> +++ b/drivers/usb/host/fsl-mph-dr-of.c
> @@ -94,10 +94,13 @@ static struct platform_device *fsl_usb2_device_regist=
er(
> =20
>  	pdev->dev.coherent_dma_mask =3D ofdev->dev.coherent_dma_mask;
> =20
> -	if (!pdev->dev.dma_mask)
> +	if (!pdev->dev.dma_mask) {
>  		pdev->dev.dma_mask =3D &ofdev->dev.coherent_dma_mask;
> -	else
> -		dma_set_mask(&pdev->dev, DMA_BIT_MASK(32));
> +	} else {
> +		retval =3D dma_set_mask(&pdev->dev, DMA_BIT_MASK(32));
> +		if (retval)
> +			goto error;
> +	}
> =20
>  	retval =3D platform_device_add_data(pdev, pdata, sizeof(*pdata));
>  	if (retval)
> --=20
> 2.7.4
>=20

Reviewed-by: Peter Chen <peter.chen@nxp.com>

One more place need to fix, if platform_device_alloc returns NULL,
it should not call platform_device_put to release platform
device memory.

	pdev =3D platform_device_alloc(name, id);
	if (!pdev) {
		retval =3D -ENOMEM;
		goto error;
	}
	...
error:
	platform_device_put(pdev);
	return ERR_PTR(retval);
--=20

Thanks,
Peter Chen=

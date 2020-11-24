Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81E3A2C1E7C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 07:50:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729836AbgKXGtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 01:49:32 -0500
Received: from mail-eopbgr30070.outbound.protection.outlook.com ([40.107.3.70]:24099
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725786AbgKXGtb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 01:49:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i+3om4+Ia4B++BpcNkGX/r9O4pIQi+Ctr/GGOkZ0fh2q02TxJL1HarUedJ9vQoncMvUvqlwYV2SBjF+zavqLUZ+RWGCP2lhhBRDMmiscT8kUHVCLRxSxeAu4s2eyNozzfWZmj0Mcz5Pz2F5G7Zpqn+l/PWrtbR5k0f+id9H9wNJOsYcsk31FkFZvWzajdI4WOjDc8Vai1/FKfuvwtiBdh+/ZypUWwmlOhvhiBLy/brVaeJbGPyQJNTpZMzclpH6wAiK0gPQmIh5BselXt8wAuGEam2Vkv3VsebivODUn7WLKfiflU4DvdY+p6kkYdoaJ1s/QTkaMVVzkYLBLGIA4SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J5ZLoOxvx4T+WIUQDNJdUUtFmEwVgMIcNCMb7S4Sdm8=;
 b=lh7e3nlniojbk+IDcpsG+eZHA30NNbjYm+X1xaF80dN1T6ZxTMHP964rbFH3CXAQjTWpA5yoz1AFScl4+IS0iunypc1TkGe8kSR4BGMBhD5o9t6CoxHmHgBu3fQkSeSSeOhAJNS99m8ihC2u6mlRFVEIVxt+0IzwjsnwV0MINz/ZMkPLKsss+ofklotNFI/hzhzVCfLOKDW3U0PwkrTgg83mUEB1y0UxqnlOIn9sEP1ZcnwZTZ94925auMSy0r5/Zgiwg7Rw+5CYltnP46H/p1KMM5y5ekzT1aBgtGXI/ML2bKW3mISAh7GWpWVidIc14kWUpoN8CRLqZaOh+l5Vuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J5ZLoOxvx4T+WIUQDNJdUUtFmEwVgMIcNCMb7S4Sdm8=;
 b=jGZuQcRAXx9yhQjW4ZB1C9p4AyedagYnOQRTIo4SbamCb61xoNRPPADQ0O146i8NHURNaJWM1yU9+xPmSU0aJJIQtN6awOfMBuHWC5gCjEtU+9MkNFWcX8wnOm5i3zhxfRxOUxtTiHGy2Txw08w5VZcqGrG9yASt4JE474nL5aI=
Received: from DBBPR04MB7979.eurprd04.prod.outlook.com (2603:10a6:10:1ec::9)
 by DBBPR04MB7817.eurprd04.prod.outlook.com (2603:10a6:10:1ef::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20; Tue, 24 Nov
 2020 06:49:27 +0000
Received: from DBBPR04MB7979.eurprd04.prod.outlook.com
 ([fe80::c8c:888f:3e0c:8d5c]) by DBBPR04MB7979.eurprd04.prod.outlook.com
 ([fe80::c8c:888f:3e0c:8d5c%5]) with mapi id 15.20.3589.030; Tue, 24 Nov 2020
 06:49:27 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Roger Quadros <rogerq@ti.com>
CC:     "pawell@cadence.com" <pawell@cadence.com>,
        "balbi@kernel.org" <balbi@kernel.org>, "nm@ti.com" <nm@ti.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>,
        "a-govindraju@ti.com" <a-govindraju@ti.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: cdns3: fix NULL pointer dereference on no platform
 data
Thread-Topic: [PATCH] usb: cdns3: fix NULL pointer dereference on no platform
 data
Thread-Index: AQHWwYZZgRghacfihUSnukQUanlqQqnW2K+A
Date:   Tue, 24 Nov 2020 06:49:27 +0000
Message-ID: <20201124064851.GB32310@b29397-desktop>
References: <20201123104931.2653-1-rogerq@ti.com>
In-Reply-To: <20201123104931.2653-1-rogerq@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 209b05af-c73d-4057-ba3c-08d89045163d
x-ms-traffictypediagnostic: DBBPR04MB7817:
x-microsoft-antispam-prvs: <DBBPR04MB78177FE3C62EC8472E87D6C98BFB0@DBBPR04MB7817.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DiZl9Ug5PKiEPYP2gt21bKW5AetlTtFITJ8YPpwm8AlON4fFPig/HL2yC/08CMvw2RP0bbeSiJhlqG8H29yRfuy4CV47x4oBrNxYeyOL6LPtYI5V81e0XT4J8oHuA0oXXbJJ5VVhfr4mfpTHq0pizUJgc46kvefYZ8U8b0DKb4wnSX4Bu7HWhkANflmL32zPQlJMH7PiztcKrz5rnHQenFEc7D2FmD26amzhzLmx/vaZDo6ZSG87jiorKhvcS5o/pxrGvAsdoYyqVPN/nDjY2CdBOB+h3oeJghuXDxaKYLbNBXB4fj+sLQqQA50TV4AqrKd7H8XkqmxFHxoDEHxfAQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7979.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(376002)(396003)(136003)(366004)(39860400002)(346002)(83380400001)(33656002)(2906002)(8936002)(8676002)(6486002)(5660300002)(44832011)(9686003)(6512007)(316002)(86362001)(4326008)(6506007)(71200400001)(66446008)(186003)(54906003)(33716001)(76116006)(91956017)(26005)(66946007)(66556008)(478600001)(6916009)(66476007)(53546011)(1076003)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 0aGOQ1gNSAHuAu7QytKWKbrPzMa0r9fosKA188c8SZeBmn+dDNisJ9z3xd+cjRopJamxBfVUcqSldu1xieRIIv2BgnFhff0E1V58FEsGRnjIV2V/8ubCIgTKQNWELT649vJBuioifod91Al1OJha/53HjPqZSM/z7ofBoIw/Hmb1wsxyM/TERk019wzyN13oBFKhAqBNMZu7uQuAmklw8uRpn1zAnIj2m+hrnj2xxpadSoNuKZecJ3N123mRGmr7xrw1LiRctNPtWeMEtA/gBZyiQ9KuQwxgDXO2KHGS9GXpcgDK7ApXapjE3RP0BmN5le6+a9e3f+umvKpixmVOjk7QH2CQA5L2vHuh5a+LstONbTn8UQJjjE0NifiMXb/g7dM0f7MxNV+0y8/NCfAeqcclhknpqz7fJtTvzSuiLHFwebwlCh1dTJRLTLnw3fNOMPF5cuy562LzNUHlJY50gqp/BatgptJHDqMIRzVmEdxEXkBYdIZhtkG/abbIBVYcs7MKnpPl9vs+bsOg3YnTgoVLwJMq5vIeHANRFa7HKxLqCQMFKiIdRKscBEWGBs6kS4XN04iVu9ybDpLWNIOciRB8FvnIBCGFOSNLJ/BMdtUi0hiY3Fc974ZfiQ4ePpW3ey1hUh+vtXqEz/z9BTK9ZVlt6m/0WYEbx8U0Ea/AJlRHGbocPcAB2zGtdHnD376HvA8Awxq4nmuGBirismT1fv8g+5Ct7eau1OGWYEZHNAAvzyWCQMjoPxTBgj+UW6Hn2f80fNbTmO2ieDL4fA0sjhGJHylovKU/z2GXObewoj4Ar2v8naMGMQ3ZEW5HXBmD44+o7zOtNO0oND1e59eTrKaP/bCeTf7d2Pzb8I+ExyH7ufZnO4OONA2yEV76RWfEXat5lW5MUddLckk2sUkpkg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DD146DB8D5E3F24290E0B96BBE4E26F7@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7979.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 209b05af-c73d-4057-ba3c-08d89045163d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2020 06:49:27.2615
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1SZ4tJIFQtWyASmzAJBtkw+E+wN8AlcP25xU1cwSt2W/BA5rEfdZIeFH5ahHqLkqPpDOURyDPeRauaUU0FbwCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7817
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-11-23 12:49:31, Roger Quadros wrote:
> Some platforms (e.g. TI) will not have any platform data which will
> lead to NULL pointer dereference if we don't check for NULL pdata.
>=20
> Fixes: a284b7fd1b8f ("usb: cdns3: add quirk for enable runtime pm by defa=
ult")
> Reported-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>  drivers/usb/cdns3/core.c | 2 +-
>  drivers/usb/cdns3/host.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
> index 54d841aa626f..0f08aebce86d 100644
> --- a/drivers/usb/cdns3/core.c
> +++ b/drivers/usb/cdns3/core.c
> @@ -559,7 +559,7 @@ static int cdns3_probe(struct platform_device *pdev)
>  	device_set_wakeup_capable(dev, true);
>  	pm_runtime_set_active(dev);
>  	pm_runtime_enable(dev);
> -	if (!(cdns->pdata->quirks & CDNS3_DEFAULT_PM_RUNTIME_ALLOW))
> +	if (!(cdns->pdata && (cdns->pdata->quirks & CDNS3_DEFAULT_PM_RUNTIME_AL=
LOW)))
>  		pm_runtime_forbid(dev);
> =20
>  	/*
> diff --git a/drivers/usb/cdns3/host.c b/drivers/usb/cdns3/host.c
> index 08103785a17a..ec89f2e5430f 100644
> --- a/drivers/usb/cdns3/host.c
> +++ b/drivers/usb/cdns3/host.c
> @@ -59,7 +59,7 @@ static int __cdns3_host_init(struct cdns3 *cdns)
>  		goto err1;
>  	}
> =20
> -	if (cdns->pdata->quirks & CDNS3_DEFAULT_PM_RUNTIME_ALLOW)
> +	if (cdns->pdata && (cdns->pdata->quirks & CDNS3_DEFAULT_PM_RUNTIME_ALLO=
W))
>  		cdns->xhci_plat_data->quirks |=3D XHCI_DEFAULT_PM_RUNTIME_ALLOW;
> =20
>  	ret =3D platform_device_add_data(xhci, cdns->xhci_plat_data,

Thanks for fixing it, already applied to -next tree.

--=20

Thanks,
Peter Chen=

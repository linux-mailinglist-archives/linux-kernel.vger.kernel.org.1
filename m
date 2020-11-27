Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8FA12C6659
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 14:10:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730135AbgK0NID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 08:08:03 -0500
Received: from mail-vi1eur05on2071.outbound.protection.outlook.com ([40.107.21.71]:33120
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730060AbgK0NIA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 08:08:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jiP7Ufwb43eVHbxNATqN7s3rnJ9yf9gHtAC59pKQGkFXhnqvhjg9Jn23isYCUqNCv4Xg5qGZwOb5iGFwQtFkgXts8tI0En5TCSc4viovgXT5LaGCC69/xB0hwzSyiB3E9G4c7QI3Z1nz3j4LHYcgKCkoj2T6j7dnLZ90fs6y4huXYJH/HvC9HFGSXk/ozFHJVJ6nW1dMRPJkseszA2HmosvXZM81NBnlSsTcLCBUrPS8Mjr21cCauXN5GCHOKjQXx5ictTo0uAXsD+rOMq42J38nucBECu2p1L7rCU/5n2dxK2duk8Zg6C8k9Ut8ZVyms+Fp1QkXdIIB4+MZIZC63g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ke7DXqQmwX0+0dfvtJy5Hs1j9VleMMJQwXsHVppehq0=;
 b=O/bH/kazbH4eaYyvz4Ae/X6y8dmG6LnZDrbP2NeMKINAV7uCImzACf47E7fYbBBG8pSC4MB8OAjDAAyhTfysF7atcrBLjrD6dwzUTQPEPJl6QLMyK68gyIDQ7z+Ur/bg7zGWAko0xNdgkMB9UoXn+8Ownr1YSVAeKLYt1qqzgEyK6YQ9A6lufNd3CvOxsowGr+MLkHGQvRuE9r42Xvm1Ej+UE8ZKYziHPNBVwsySutE/7KucKce8PH+ixo7kbxUUihXh0C0Pbzs3HJqpr+0Rnazcuczmv2H8hLhdroJ9MezBt3nOhnhfXLW5zO5qnn/G82dA9CvKuFhmbjE404UUJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ke7DXqQmwX0+0dfvtJy5Hs1j9VleMMJQwXsHVppehq0=;
 b=MAHEtojVF283vFhBNQHI8FXiqN/qDBNpsXPGpJPeBUaOTUrdwHVUwohl0z/iRhOv5T8+ld4cnTvGdWtA3gqeQ83PU6JGD3X+fCGZWwCq3Gq9y9e3Uax3bEMY1/9Sy22UcY4KUxjXw3PFrV/K+XCVakENn7k/xXqgXg2xaGCw1+Y=
Received: from PR3PR10MB4142.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:ac::5)
 by PR3PR10MB3882.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:45::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.22; Fri, 27 Nov
 2020 13:07:51 +0000
Received: from PR3PR10MB4142.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::67:233d:68c6:cabc]) by PR3PR10MB4142.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::67:233d:68c6:cabc%7]) with mapi id 15.20.3611.023; Fri, 27 Nov 2020
 13:07:51 +0000
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     Michael Klein <michael@fossekall.de>,
        Andrei Stefanescu <andrei.stefanescu@microchip.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Support Opensource <Support.Opensource@diasemi.com>,
        Lee Jones <lee.jones@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "trivial@kernel.org" <trivial@kernel.org>
Subject: RE: [PATCH v2 3/3] mfd: da9055: fix "REGULATOR" spelling in register
 content macro
Thread-Topic: [PATCH v2 3/3] mfd: da9055: fix "REGULATOR" spelling in register
 content macro
Thread-Index: AQHWxLw4FoWNz81Yd0eCGKRKS43NVKnb8sAg
Date:   Fri, 27 Nov 2020 13:07:48 +0000
Message-ID: <PR3PR10MB4142ACD8B0CAC1EE0A2377F280F80@PR3PR10MB4142.EURPRD10.PROD.OUTLOOK.COM>
References: <20201127093142.GP2455276@dell>
 <20201127125202.23917-1-michael@fossekall.de>
 <20201127125202.23917-3-michael@fossekall.de>
In-Reply-To: <20201127125202.23917-3-michael@fossekall.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fossekall.de; dkim=none (message not signed)
 header.d=none;fossekall.de; dmarc=none action=none header.from=diasemi.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.225.80.85]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c2fd90ae-e5e3-42d6-02be-08d892d57253
x-ms-traffictypediagnostic: PR3PR10MB3882:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PR3PR10MB3882DF0203A0A81F8D7A64B5A7F80@PR3PR10MB3882.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:400;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y+aphFHUxhnsUou7SFF2qVdEjpP6/0AYmVIqaLcLedmQgwISxUGMMNiwUxDwOqaWgcjD7he89KXgAKbGA5Xlo4GWZVmAJ5oUNg3i5/KqTlfKrj8lahEG6lyoQQOpcfd9Ygkn4mxYCApZciJcG5e28IJec8uv03JDYm+UGyr86MA6gOhtoJG4KbvwAhxUjGvMqpP8B7rIWWto+HmtEYLtc5t3bndwiMHe0k4zMVKj2RYlx5IYZzBAchAMM12hz2BCAc4i31o8ksYXqxzvzuWR67a2i7llRXwfah302ek9gzXo8HrEgsVc8bsSksbYUOKs0i6sbEI4ANs8S9qSY73W3w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3PR10MB4142.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(39860400002)(136003)(396003)(366004)(71200400001)(186003)(52536014)(66476007)(6506007)(66556008)(8676002)(33656002)(53546011)(26005)(66446008)(64756008)(66946007)(478600001)(76116006)(55236004)(316002)(86362001)(55016002)(9686003)(558084003)(5660300002)(4326008)(54906003)(6666004)(8936002)(2906002)(7696005)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Fi84KTAkcu8lsKp1BJhMRbY3lNWUFj6Bpm6E+rUyaLQq2A5C7CmwAFmQRy5f?=
 =?us-ascii?Q?+mVpeQTieMgWwkevNzuWJYYjQpxq/Ug22MxA7sNxl2srN0RgG82CFkvzZ/11?=
 =?us-ascii?Q?fD7nuyGY/W6azpmIE+Av4HXcHGoX1vogIoQ/xBN+VDj5cwEZaE9TA5KJJV6o?=
 =?us-ascii?Q?iiznIRql/+3hT3Q1pidj3izW/U0dVfutEJwrC9668NaKwoe3kcgLzCLa5Mx1?=
 =?us-ascii?Q?PDZ05CXqd17ogczk/24bO8UVkAmKStR2wDBIWCl0qHa7K38aHwIqfBZYzPN7?=
 =?us-ascii?Q?c6E+lzHGkIdbV/A+NxilgPuPDPUe30InSiah/sc5X2NI/EKHjEgmLs4BGbdy?=
 =?us-ascii?Q?Xu54QqjOuner39UnqEoL5RwuVg8+fPb2Juez5EYEK8wbC+efLW7v7KK1yn95?=
 =?us-ascii?Q?o6r/UTiK48FwRqrU6BEzGC4/CAFVKmverINMtL9C4bLRs0xRyvcHw9CTaJzf?=
 =?us-ascii?Q?5aVfHv7YKXFMySSCs3pwFmHSPBUZ1wFnSQOsO7RXEmoMBiOmEAnCEl4s66QM?=
 =?us-ascii?Q?KLacRB26U3ca7w+cYz+pf9iNWXchm0JxAaAVFV6ERpZHlONuf62+1fShqOD4?=
 =?us-ascii?Q?eoU67pW2jI85Na0EBupX71H5YkRi2jD8nm6lul+Swi0qiCQda6IICPCOqGrJ?=
 =?us-ascii?Q?O3xZ4AjGwFmUOTJSGXLW3pdoDnfsXCOenlTMv9nLMCizaGy4moAy935vwjlZ?=
 =?us-ascii?Q?kCtwIPhdAHBdKXb210zKzfesnmg60ha0y1r4XKV6vCd86w3iHyCTMSX14GAY?=
 =?us-ascii?Q?161YiES7gBZzNq8ExZNOF3+LvSdM8aqQ+YIUgrjApZz0iS+fcAergfYgy2TB?=
 =?us-ascii?Q?SqvY05g+rf6uYx51WhirS/zjZml+PUYfbogKiGIEAkLGMJPiG00txpF/MfcR?=
 =?us-ascii?Q?b+0CEEVO0pLnYSb44SV8hV3tp36LgJB2Z/Ukb9qE3P6pJy/IerKGyKO6JRt+?=
 =?us-ascii?Q?wdgC4VL3gCDb8oFDFey5RY5eiIerjM/tCzNZeMmXmyw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PR3PR10MB4142.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c2fd90ae-e5e3-42d6-02be-08d892d57253
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2020 13:07:48.5763
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Aqmo1/CFZmEy16pWRzdusnmDBPc4YhRFKKqjQ+FhixR5SBtwvYCwB1ebCjDx+fPUHqqU4nC+Vn1dOrA9FpHuNsaCnkyy4V/0mFEPJF9vSpc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3882
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 November 2020 12:52, Michael Klein wrote:

> "REGUALTOR" -> "REGULATOR"
>=20
> Signed-off-by: Michael Klein <michael@fossekall.de>

Reviewed-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>

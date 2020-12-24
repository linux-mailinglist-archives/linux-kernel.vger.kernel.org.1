Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9112E2729
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Dec 2020 14:19:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728699AbgLXNQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Dec 2020 08:16:11 -0500
Received: from mail-vi1eur05on2083.outbound.protection.outlook.com ([40.107.21.83]:27744
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727372AbgLXNQK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Dec 2020 08:16:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l5dQUl76mwaiHRPvXtE6wzS0Czv/4xbw6S6emUfGki9LjSw8S779P8JFOaHxqbDQEYccoKutdMJBPkjTAKyet6bIkTfF/JFPVeqU9zPYTyHu0ZHje1B4wf2Vbu7JQLAiC4M8qW9PqDMJoddKjoLk8js1zuJzQ0wYBX8Tuf+L5DY7DHokZGhhG8oeHTdsIGkqGwztglY6Th6ChW00kaKoGjKOBZ9ex6jQBEOvNznuupg3iJ4BZtVbH/IZL5ciRKt2JTtHMtUk0QkjuldWOVFlPXB9nkUrhJHlnA4RRLujprhu5qGyqo/z2IEHFU4tYS5Ot2sUzrLzuTp/g+yx7Ro7Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/YUDH/F2nusqS7/6XfTZP2hIFMlmrOTi9SS/63euKZ0=;
 b=kuefgu1dnrG6cFkpGnxM+xFNRCgayA13fxXiFt1/rt+ERiBkFNWJt4X3vaK4OCz7jWKpZFpuJVH8d+aonxuH6Hwh8COwGOxLxZQAkCtGSR/4EWkvYtxJoq7I8eumqWwQKMoRGPNejc5fbP/qEj2RR0ZMZNOKigypoASyxV8Dgly2JgywxlSErZF9ZNpoDsScT7goFyDvag5PEDHiO1fcNsZxw7Nz7pgGurrr5LqxyeS0EcZ32U6OyHXRRLxvPd2sWgGuKZhN5zB/u27d3zESHlqu8EH8oEhTLPJZsCk+K2HIiNLANijS0PIPpnuPlBr2zA+NyPfQumc4zpAnB9ds2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/YUDH/F2nusqS7/6XfTZP2hIFMlmrOTi9SS/63euKZ0=;
 b=tBRDzcUZnXfAG8g246peKZb0Q5mdbisB5K2Xub5osGGeF+InfN8sT9RyHW6oCLWuo6apeBsFWvDgNSOdEqILA66awjaEd0ncfFckMD13DIfQ5LkS3gBGJhf5X4bB8Lwb0SluMgjWrgsK/CEW8u3NHKy0bnDzijJM4y5DWBXp99A=
Received: from DBBPR04MB7979.eurprd04.prod.outlook.com (2603:10a6:10:1ec::9)
 by DB8PR04MB7177.eurprd04.prod.outlook.com (2603:10a6:10:127::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.27; Thu, 24 Dec
 2020 13:15:21 +0000
Received: from DBBPR04MB7979.eurprd04.prod.outlook.com
 ([fe80::c8c:888f:3e0c:8d5c]) by DBBPR04MB7979.eurprd04.prod.outlook.com
 ([fe80::c8c:888f:3e0c:8d5c%5]) with mapi id 15.20.3676.033; Thu, 24 Dec 2020
 13:15:21 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     =?iso-8859-1?Q?Pali_Roh=E1r?= <pali@kernel.org>
CC:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] usb: host: xhci: mvebu: make USB 3.0 PHY optional for
 Armada 3720
Thread-Topic: [PATCH] usb: host: xhci: mvebu: make USB 3.0 PHY optional for
 Armada 3720
Thread-Index: AQHW2UgQyk5+oV5VRE2UEkoGEW5gpKoFv+eAgAB1K4CAAAV7IA==
Date:   Thu, 24 Dec 2020 13:15:21 +0000
Message-ID: <DBBPR04MB797907A4C3D7666B867AE2F08BDD0@DBBPR04MB7979.eurprd04.prod.outlook.com>
References: <20201223162403.10897-1-pali@kernel.org>
 <20201224055425.GA27629@b29397-desktop>
 <20201224125347.z2ka7itpxuvboghq@pali>
In-Reply-To: <20201224125347.z2ka7itpxuvboghq@pali>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 394f538a-654e-4e4c-fe2b-08d8a80df7c2
x-ms-traffictypediagnostic: DB8PR04MB7177:
x-microsoft-antispam-prvs: <DB8PR04MB7177A5EEE9F0B20FEAE8FE7F8BDD0@DB8PR04MB7177.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 454KxY/9bx8xfi0raLaU0PB24oVIQlcA5olxC2t6sFDFIP1+UIa603wb7Q4S7bnhHnjrzjxBcnm5Ilv7NHoDAbzcmQJf2raPskuTdDkRK2t/hrz8Mt6D+3OuuJ8pDoi2m7VF02Q/UqPq8iQ1LAt8dWcayWGsEwykWdfGHxT0lqj+MlH/2lQ3sdVs1ef1HEbT/7CQLW5EVFW4LAb0oia4Vuaosp40vlfdQ3+3PkDH9VyaBFHy1a+wMS0BZhoWbB7PRIi0Ckpvt+biCia785FdvSke8lZ6uelTmrRpIWC0xD5Vb4g+GjZgGAQOWEGxqsKCeJdVunZalJqUy/K5c/dVUJVaDd9PU+/shD1WFEGGj/6j1/7wNMrLH5DTc/QRnDr+v/b0OZjdbnGLdFtJGwuGnQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7979.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(66446008)(64756008)(86362001)(66556008)(66476007)(4326008)(6916009)(2906002)(54906003)(8936002)(6506007)(76116006)(26005)(5660300002)(186003)(66946007)(7696005)(52536014)(83380400001)(71200400001)(8676002)(9686003)(55016002)(316002)(44832011)(33656002)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?MYLeQahXns3GLP4wKXH70vaFNYC+E+PNds6P6cruivFDMDLIABY6GZ4WCu?=
 =?iso-8859-1?Q?vzEnhs7BFxRIRIwJzM8yei334TrikDLffTTdVkZaTJLFtylZbybg2hbzxJ?=
 =?iso-8859-1?Q?SVnP9B2Ga4/sItqjnXU6JVfb4VzyKUCXQhKGM6+p8SMDe96Z230e29lzQV?=
 =?iso-8859-1?Q?AnJwYLdw8f5KoGznEt+O6BsupQFWWSBh3l5Lx97x4cvLm8pw0Y5cOFov0d?=
 =?iso-8859-1?Q?T3Xar/UhJ0pjBqT3C/RHo6R1xqQ+gPqy/99srwmEGTW6F+v+aGfdn34rV4?=
 =?iso-8859-1?Q?uMsSxXEB5tKTI2YOsYF5W0OLDBmZlSDZNP0Tk2Rts8s1SV83JkDMsq4GTt?=
 =?iso-8859-1?Q?QEGFJImzvE3Hyxdx9M4AEK27KzpEbWST8eNVQ6IxVAbulQaMXCokoUI8EC?=
 =?iso-8859-1?Q?IDBj6iP20JrpmoyvYRpYwl+x+2yS8ExUy9UvMjgamSCAx1JaDb6kYd92GI?=
 =?iso-8859-1?Q?6fxBNW00rYeF6yC1rMyC3sAOpK/SusOpo1A2mopO3VrbIj8bksbh/GqLWY?=
 =?iso-8859-1?Q?H7YAD7OtDSVqmzCrjBZ5huW+MwDfJEd61cEFSXlxB8tGwYmnQ3kdzAE/dP?=
 =?iso-8859-1?Q?6fGnojIg2JwA+CVqxBqauSGyxLGeccOz5tgmeuU0hxujF7navZDWJwvQ8Y?=
 =?iso-8859-1?Q?v6UBhs/aJdb7dXr4m5LDMAa7xdhcOpTv7QLnQAzJ1XGodQbiH3oPSQh2pV?=
 =?iso-8859-1?Q?kF+fQlEF7zQBdvLgodXxdZzQjAQmGhnS30/voRhBnLiu5BThRI53b8aZoI?=
 =?iso-8859-1?Q?iqq+XQ+WKDnU961nI2BxW9MJQEcDdxREMFvaRajt64+k1FmVOgvdFVo1Ng?=
 =?iso-8859-1?Q?HFfdd+iYdoA7JYVTsrIoC0y/d0pOdniy6G814bAM2Yun85d6Q2JhIywC6X?=
 =?iso-8859-1?Q?c0zk1FOvJKMhuq0JPEplANLn31FwESgVP4SNwnyJ76JpJpgoYnTbF4KIMw?=
 =?iso-8859-1?Q?rPQS5dcHYl1NEXGreV3IzJu/Ww2BgXmXCQsYpGZIaQXLVHCVrBAqNv82YD?=
 =?iso-8859-1?Q?ttvakljZ0R5dITTg8=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7979.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 394f538a-654e-4e4c-fe2b-08d8a80df7c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Dec 2020 13:15:21.7279
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OrZ+3e8/zEgdI3kLjWtV3xuFsS8iL7iiSlrTAtM5d6yRXYKHS0eoamZWSNV/+y+Hxk9bQBvt4U08V0DiYt5+AQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7177
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=20
> > > +	/* Old bindings miss the PHY handle */
> > > +	phy =3D of_phy_get(dev->of_node, "usb3-phy");
> > > +	if (IS_ERR(phy) && PTR_ERR(phy) =3D=3D -EPROBE_DEFER)
> > > +		return -EPROBE_DEFER;
> >
> > Doesn't need to judge IS_ERR(phy).
>=20
> Ok, I can remove it. I used same condition which is already in SATA and P=
CIe
> phy code.
>=20
> > > +	else if (IS_ERR(phy))
> > > +		goto phy_out;
> > > +
> > > +	ret =3D phy_init(phy);
> > > +	if (ret)
> > > +		goto phy_put;
> > > +
> > > +	ret =3D phy_set_mode(phy, PHY_MODE_USB_HOST_SS);
> > > +	if (ret)
> > > +		goto phy_exit;
> > > +
> > > +	ret =3D phy_power_on(phy);
> > > +	if (ret =3D=3D -EOPNOTSUPP) {
> > > +		/* Skip initializatin of XHCI PHY when it is unsupported by
> firmware */
> > > +		dev_warn(dev, "PHY unsupported by firmware\n");
> > > +		xhci->quirks |=3D XHCI_SKIP_PHY_INIT;
> > > +	}
> > > +	if (ret)
> > > +		goto phy_exit;
> > > +
> > > +	phy_power_off(phy);
> > > +phy_exit:
> > > +	phy_exit(phy);
> > > +phy_put:
> > > +	of_phy_put(phy);
> > > +phy_out:
> > > +
> >
> > You do power on and off again only want to know if PHY has already
> > powered at ATF, right?
>=20
> I need to know if power on/off procedure is supported by ATF. And if not
> (indicated by -EOPNOTSUPP) then I need to ensure that usb hdc code would =
not
> try to call phy_power_on() as it would cause failure as described in the =
commit
> message. You can look at those other two commits for PCIe and SATA. Same
> thing is needed for USB.

If not supported by ATF, then where to power on and off PHY since no other =
place calls PHY APIs? Is it always on?

Peter

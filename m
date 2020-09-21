Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD4AA2725A7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 15:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbgIUNeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 09:34:13 -0400
Received: from mail-eopbgr70053.outbound.protection.outlook.com ([40.107.7.53]:31299
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726501AbgIUNeL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 09:34:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BSqvQAMrOhKHG6zjyLP+h4AxXDMNIvgQK62Emt7pSGRNx/b2CJWdW2p9+DtGH+CNxwKJ014YhKkx3EdScYay2/RKgZH+QXlDWADhw/Omk6K+xjCTLSwLNjQa3PP8UL5+OVjAio3wqpi3kbv3VQtfIE8vRV9OpunX5rakUIqMSwzuxNYpm0/X1BAhB1qQRE4zDNURS+b9P7xzadvs+kfO6W/ZSHISeiOFc3O5tWsHj8pTvVsp97F/qEFIzNrGCHLPFf1DRk/Z0Giys8bdEqL7H8N2i3fwPkmIVrWIKLoMj318oO4s5tXMvCk5XoBS/MAz+bK3LEyuMqvwe9GXRiAEAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YrCS5wcJtiKDlQAmtG5FgcYchlxa4vKGZka+IUyKSLs=;
 b=ANlPOpOAJi9zl+ipOfYvSKfk3WUcVYVXY31gGb/4c9Av135yNGm7xllTGWGnST0Y0XToa5zU1t5tkdzSg1MpEIUxAQPBn1Wv/VACjiEOb9awKiyF2XgQI+5FhaDBj/+ttXshX5OvnWdOBm16k/0WjJcye1/kqwtfa1ru/plq4N40D6h8BeQUuxxExUXlPwXbdP3d9W1/cSYVZ2lb/VB8iC5vaLF5Uz88kyBNpA6kLajC9YOmf83CdQ1In7QUqbfZxTMymgGh6IYSX6n/1fKiD9ZSWFwrO7AVB1mPWSadghf04AlMBI6ulILGg6ZSzgF5Krc5reZPPRM1O5AHxTVCWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YrCS5wcJtiKDlQAmtG5FgcYchlxa4vKGZka+IUyKSLs=;
 b=TwaW1s2K0VP8DuWokXzoj4UZV9r6qnXkosr/N7mk+i2sEtTiqbBnTzhKN4RISYqCgETY15wONc9JxhIZ/ta8g0nKHJi7xW5UYDwxRCzQhseUWwTqW4Ru7FTjE+fr02T2DWJJ8dkARfzpnOS3DvpFaOoMb6CtF0s6URVGreOZ2wU=
Received: from AM7PR04MB6885.eurprd04.prod.outlook.com (2603:10a6:20b:10d::24)
 by AM7PR04MB6901.eurprd04.prod.outlook.com (2603:10a6:20b:10b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.15; Mon, 21 Sep
 2020 13:34:07 +0000
Received: from AM7PR04MB6885.eurprd04.prod.outlook.com
 ([fe80::f431:1df6:f18b:ad99]) by AM7PR04MB6885.eurprd04.prod.outlook.com
 ([fe80::f431:1df6:f18b:ad99%7]) with mapi id 15.20.3391.026; Mon, 21 Sep 2020
 13:34:07 +0000
From:   Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Varun Sethi <V.Sethi@nxp.com>, Leo Li <leoyang.li@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Kuldeep Singh <kuldeep.singh@nxp.com>
Subject: RE: [PATCH 2/2] arm64: dts: lx2160a: add device tree for lx2162aqds
 board
Thread-Topic: [PATCH 2/2] arm64: dts: lx2160a: add device tree for lx2162aqds
 board
Thread-Index: AQHWgTuoJIcsrSh3jEy4wdu9ducPKqlZsQ4AgAY8A2CABORpAIAN438wgAB3wICAAAhv4A==
Date:   Mon, 21 Sep 2020 13:34:06 +0000
Message-ID: <AM7PR04MB6885E3EB822D59F2228DA4908E3A0@AM7PR04MB6885.eurprd04.prod.outlook.com>
References: <1599059610-7570-1-git-send-email-meenakshi.aggarwal@nxp.com>
 <1599059610-7570-2-git-send-email-meenakshi.aggarwal@nxp.com>
 <20200905075419.GN9261@dragon>
 <AM7PR04MB688571606382A8992C71E8E38E260@AM7PR04MB6885.eurprd04.prod.outlook.com>
 <20200912094913.GB25109@dragon>
 <AM7PR04MB6885EF94F69D741496AD9C838E3A0@AM7PR04MB6885.eurprd04.prod.outlook.com>
 <20200921130325.GA25428@dragon>
In-Reply-To: <20200921130325.GA25428@dragon>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [103.92.43.176]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d6d07dea-6efb-4b09-540b-08d85e3303b2
x-ms-traffictypediagnostic: AM7PR04MB6901:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM7PR04MB69016B39D066F8E487EBE32B8E3A0@AM7PR04MB6901.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9SQzqPPiCZEdaRoPrGC0ic94+xd97tL/YeJ+kNS5fk/FfGhW0d2uK+YFscFRqjeWnTPBDAMfvyRbBEIzefHVR8yY/iJrvZBfLHUSGtakZdWk0ZRD90StimZbNgX9F3gj06afbGnxlZGGGOI95QGDAuvSgvLeZu78YXY3kvUVB5AI50vHg1pl0oIwrudCNyRf7d+7IwElQz4qebCilWsbGW1lJnorjZ68R6tB69umTqHK+XFZHjWFKqvtc/ZGVoF8U03Dca/h2Iy0bIFIKXqh8VJxl8xwIj0gvcrzaNgAXXFTxelmj7uKSnaVFH+dsSBlc4TRcl2su4z7NlXo5sr88aw+ZcGIBwwEIiTyfChtUOsIL/ZldnAAhybFvD7VRHFT
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6885.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(39860400002)(396003)(366004)(33656002)(186003)(26005)(55016002)(7696005)(53546011)(6506007)(52536014)(9686003)(54906003)(86362001)(71200400001)(478600001)(66946007)(66556008)(66446008)(66476007)(64756008)(76116006)(8936002)(6916009)(8676002)(316002)(4326008)(44832011)(2906002)(5660300002)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: SIjJgPelnpZjqJHH8T3kd0T1uYnMRaRuQeGJW5LeN0zIt1fU8cOur9Q+qfgHon9EhHtwx9QYcaC8QcRiWlEly42GLv+aG/21Cint+thfA518DXA0Ji60CYl8tgtVVl3Nz5ZM15Lzp+nJN4cf/pIxQgrnjzxE1UKWfrri6u+RaZRYmRNmLew1/Dt0G98FyviUZ9JT3xpDQqEwDvuI8bcF+gd8GTW05vsVRFdTI10ij8IPW6kjQBKzvG7E3ucZ41Kf1eHLQc2k7LmeSA9/t8NzaYjoHLoKLt8UDnFNIMP6NE3WP3EYiA4yPq8feIclPwj4Pc10uvaUwfKU7trteHVbTghr9hPmME07IT/uLtKSQbVNqVjLDp9+FfBz/IL2NLFPWhQbKzzvfppktSkOnIBlEAXvExPg1mr+XydwKChdhWEKL7769iKMEIU8Tc1j79H2XGDRhBrLmI/4V3SgtqefVKJpXdeP4zNyYVOt+UhASA3Px4Oowy2tavQ2t54BeDtOE9kfwQh0GbqLwoaEhlEvN9iRoI0SNvfNKKH1j6PK53nahLPmkcoqHIlzrx2B6m2sQYW3ejlBQb3iIJ39IUnGmnI+s0Nx8JkX1m/sV4hKBdS7M2iXVMgWScL3YNzRh9ObsWNYYhvWrvJY7gvwZ5Sw7A==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6885.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6d07dea-6efb-4b09-540b-08d85e3303b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2020 13:34:06.9624
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QyvUp8s1+iYtCiLThw8qsdF+S1SAewKOI3gbO/Cb2K128o06GBo5aRKuF50vqYRNWK5dw/n7xUyxJrxzF0oDtU8sUhzG8hqccPrgavpoLcU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6901
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, I will update the dts with your suggestions.

Thanks,
Meenakshi

> -----Original Message-----
> From: Shawn Guo <shawnguo@kernel.org>
> Sent: Monday, September 21, 2020 6:33 PM
> To: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
> Cc: robh+dt@kernel.org; Varun Sethi <V.Sethi@nxp.com>; Leo Li
> <leoyang.li@nxp.com>; linux-arm-kernel@lists.infradead.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; Ioana Ciornei
> <ioana.ciornei@nxp.com>; Kuldeep Singh <kuldeep.singh@nxp.com>
> Subject: Re: [PATCH 2/2] arm64: dts: lx2160a: add device tree for lx2162a=
qds
> board
>=20
> On Mon, Sep 21, 2020 at 06:00:53AM +0000, Meenakshi Aggarwal wrote:
> >
> >
> > > -----Original Message-----
> > > From: Shawn Guo <shawnguo@kernel.org>
> > > Sent: Saturday, September 12, 2020 3:19 PM
> > > To: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
> > > Cc: robh+dt@kernel.org; Varun Sethi <V.Sethi@nxp.com>; Leo Li
> > > <leoyang.li@nxp.com>; linux-arm-kernel@lists.infradead.org;
> > > devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; Ioana
> > > Ciornei <ioana.ciornei@nxp.com>; Kuldeep Singh
> > > <kuldeep.singh@nxp.com>
> > > Subject: Re: [PATCH 2/2] arm64: dts: lx2160a: add device tree for
> > > lx2162aqds board
> > >
> > > On Wed, Sep 09, 2020 at 07:10:12AM +0000, Meenakshi Aggarwal wrote:
> > > > > > +	sb_3v3: regulator-sb3v3 {
> > > > > > +		compatible =3D "regulator-fixed";
> > > > > > +		regulator-name =3D "MC34717-3.3VSB";
> > > > > > +		regulator-min-microvolt =3D <3300000>;
> > > > > > +		regulator-max-microvolt =3D <3300000>;
> > > > > > +		regulator-boot-on;
> > > > > > +		regulator-always-on;
> > > > >
> > > > > I do not see any point to have regulator-boot-on or
> > > > > regulator-always-on for a regulator that doesn't have on/off cont=
rol.
> > > > [Meenakshi Aggarwal] Properties are added to specify that platform
> > > > firmware's out of reset configuration enabled the regulator and
> > > > regulator
> > > should never be disabled or change its operative status.
> > >
> > > What I was wondering if how this regulator is enabled by firmware,
> > > by some GPIO control?  In that case, 'gpio' property should be there
> > > to describe the GPIO control.
> > >
> > [Meenakshi Aggarwal] Its not controlled by GPIO. Its gets power on with=
 board.
> > > >
> > > > Can you help in understanding why these optional properties cannot
> > > > be used together
> > >
> > > It's totally fine to use these properties together.  But if the
> > > regulator doesn't have on/off control, neither of them makes sense.
> > [Meenakshi Aggarwal] As per documentation, we should keep "
> > regulator-always-on " as per description, we Can remove " regulator-boo=
t-on"
> property from dts.
> >
> > regulator-always-on:
> >     description: boolean, regulator should never be disabled
>=20
> Again, the property is only meaningful for a regulator that can possibly =
be
> disabled.
>=20
> Shawn

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29046271A94
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 08:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbgIUGA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 02:00:57 -0400
Received: from mail-eopbgr140077.outbound.protection.outlook.com ([40.107.14.77]:54853
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726149AbgIUGA5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 02:00:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dT+h2Ur5PDWDQcD8RUbCO9c16ssXbQjOF0kngRMrpFmQ2uALe5ScqkJw4tA94YlzQzjTSOMb1/NImupIfWBsRmjO2MBYYiEjT0al9DCE/v2p6XYeYHmVGlNTQosW0wZruY1cj4ZEPR9Ojwqc7g/m1mMDv+edJv6zwlYOACyHzq4AG6meVLD7jkKrNxFvH74+vswIXu6Uq8iUrEf6j4+N5yPwtJbtIY8iN3fgeOuXMOvqvAKROD70wSFCQKlb77mZ9fHQH5ToFYOkjVia1A/iY/wG0UQMJ6F0nuVyjarlRKhrrS9/MPHsYTHrRnmHjVyxt+EgOVRbifEWHNZBVkFriw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wai/hiQfNBWthWrWGzPkwt0GWhgcgNnW30H+Zdy2jEM=;
 b=lkx9mPJqkMPYpSqioBIpady9qGS5mBvCYErV1czq5JYTkx6hIkmwV7cdjXS8QeRS0uFvtfv3psv4uw6/2OG5gKAPIX6PWHSFsAMk2IZIL8R2xDgJxK0dHYBPeZQkkDygUGa7FGZosEqpCZrXevlAslQz83a2WdfDLHKgUq1xpyALysQ1ASa4AGtJX2JRjdAR9NWmWyoNk7AHUhCFztuILOrSSUkOwGPLmAxAX4VGZAOPvT+tBdXTHBQzlFJP9gnOUlYLbcy7ZmqoRwTGuuB9aciNH1t3dnyGqhgCCwu/2v0xAZ545sE8HP3Nci8/DFNz0X08VCJaw+spIOKyoSMDHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wai/hiQfNBWthWrWGzPkwt0GWhgcgNnW30H+Zdy2jEM=;
 b=FzNDiG++gVxDTlc8jJdWe3jKUclMmMT9Tybhgt64horYBbZ8JlU6DFo4O6BFef+TxfsGl3H1ngqDXgKsjakXgx3l65iJXngtRSyo7S1oPgk7x+MV16tmX9GLDGEQJrSwHsR014cW6pDVPPYYCkAdXX2EY5+grwx8rvhSRLegECU=
Received: from AM7PR04MB6885.eurprd04.prod.outlook.com (2603:10a6:20b:10d::24)
 by AM6PR04MB5895.eurprd04.prod.outlook.com (2603:10a6:20b:b0::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.22; Mon, 21 Sep
 2020 06:00:53 +0000
Received: from AM7PR04MB6885.eurprd04.prod.outlook.com
 ([fe80::f431:1df6:f18b:ad99]) by AM7PR04MB6885.eurprd04.prod.outlook.com
 ([fe80::f431:1df6:f18b:ad99%7]) with mapi id 15.20.3391.026; Mon, 21 Sep 2020
 06:00:53 +0000
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
Thread-Index: AQHWgTuoJIcsrSh3jEy4wdu9ducPKqlZsQ4AgAY8A2CABORpAIAN438w
Date:   Mon, 21 Sep 2020 06:00:53 +0000
Message-ID: <AM7PR04MB6885EF94F69D741496AD9C838E3A0@AM7PR04MB6885.eurprd04.prod.outlook.com>
References: <1599059610-7570-1-git-send-email-meenakshi.aggarwal@nxp.com>
 <1599059610-7570-2-git-send-email-meenakshi.aggarwal@nxp.com>
 <20200905075419.GN9261@dragon>
 <AM7PR04MB688571606382A8992C71E8E38E260@AM7PR04MB6885.eurprd04.prod.outlook.com>
 <20200912094913.GB25109@dragon>
In-Reply-To: <20200912094913.GB25109@dragon>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [103.92.43.176]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cbb10f7f-c99d-4126-c2c5-08d85df3b308
x-ms-traffictypediagnostic: AM6PR04MB5895:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB589557D59C951D6B3A5F8ED08E3A0@AM6PR04MB5895.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0hUysTo0vf1p5SDoGV2UJ871bAjXYwf2Jb9fv9FCqcnnf/GuRLDgJrOb+85iKTmJcHtzvvKzwP4412EIEFbu/4IQILkKiMvtUlh0MBC6qrBxPl2kXl6pQN6rrTDHeD19i5Het8ELRoPcRYcH9XDxzWogTDEa2nVNJCi0hdfYrZ5nkgPJb7EpinCBWBwB9E6OlbDHIHML3ETfoCeO7sXIRc5g1L/F78alSe8ocX3kvQjEPMU+8jWAGkU7/EgdNaCLbZoij7hHBGCrh4BomOQIEOHTOphWBUG4y8lY3pcNpN4P8YYV91TNWAyGNdZpETd/IcAFpNbRXXxT0QySS7gTGtWuiFdwLP03Gj8BLm0D4he9FgH6uyKPja2OfcdsFg6E
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6885.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(346002)(366004)(39860400002)(136003)(4326008)(7696005)(26005)(71200400001)(316002)(54906003)(186003)(478600001)(2906002)(66946007)(66476007)(44832011)(6916009)(9686003)(52536014)(8676002)(55016002)(83380400001)(66556008)(66446008)(64756008)(8936002)(86362001)(53546011)(6506007)(5660300002)(33656002)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: Fyiyxf4j9TdD7dSPd9vEwuZBYcfknEuSGdq8BevRRuVMKcYxbMUKQO4BAzfVBujfFqhiL78R9Z0fl1Qs+XSfr3xWLjpfNtrBWAGhckcO4E2L9NeDe/BDXHIxKmSoWsfV/VKYiF3k09hwicLNNUHycNeB1TWJyt+GP29Z7HDnHzGEieseuL2VuvMaVyZnOQF/iA4kTWb8XZwWz1PbjQaD3ipHzM0BLN6rPVz/ZMLr/EuUAE8rrMqX7IuFmyym2tnfEXKNhAEqrjFh8NeyLZkzWBFXOvrT2irx+eJzzyaT4AbCTx3wjA4QIYh8SX6KaOsoI4mbjZdNgJen8ZcxA+IZDSjHrA96UvAHm330GH3qqAVovxRbuuxZkYck1jjn6eBpI/LQ4A9LfvgXAJdTDV9DIUlO31N9TKhPUT3xZHBalApWU4GcIKrEBCCiTa340kolOXM6frq7kP2xZZlEfL7O5p1s5TkTVeRyI99Jkrm9Pe1u/AojKDUDcLQOdSTJncpY6DiT8DoeUrveolngNkvqsbZqW1tQ8wtiBLmnZwYSGDOsOmAtaddliJoM4V58hmRb8T8OwrYIuZTLiUqRAKWNkd05csPtt9bQRmvbtCGESHdT44hlbfx9ausHjiFXaV7/1iGqazmR5Vl1Einnr34rQQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6885.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbb10f7f-c99d-4126-c2c5-08d85df3b308
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2020 06:00:53.4330
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fkvU30LMPW2vDvOvRB7Akk608av7euiJQpnrcDdpfrHRI14+FmG9ahJDs2rWb0u5GKXxz72KwxTXU9jtELpOi6MGdK6ma9nioRiFz35zVZc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5895
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Shawn Guo <shawnguo@kernel.org>
> Sent: Saturday, September 12, 2020 3:19 PM
> To: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
> Cc: robh+dt@kernel.org; Varun Sethi <V.Sethi@nxp.com>; Leo Li
> <leoyang.li@nxp.com>; linux-arm-kernel@lists.infradead.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; Ioana Ciornei
> <ioana.ciornei@nxp.com>; Kuldeep Singh <kuldeep.singh@nxp.com>
> Subject: Re: [PATCH 2/2] arm64: dts: lx2160a: add device tree for lx2162a=
qds
> board
>=20
> On Wed, Sep 09, 2020 at 07:10:12AM +0000, Meenakshi Aggarwal wrote:
> > > > +	sb_3v3: regulator-sb3v3 {
> > > > +		compatible =3D "regulator-fixed";
> > > > +		regulator-name =3D "MC34717-3.3VSB";
> > > > +		regulator-min-microvolt =3D <3300000>;
> > > > +		regulator-max-microvolt =3D <3300000>;
> > > > +		regulator-boot-on;
> > > > +		regulator-always-on;
> > >
> > > I do not see any point to have regulator-boot-on or
> > > regulator-always-on for a regulator that doesn't have on/off control.
> > [Meenakshi Aggarwal] Properties are added to specify that platform
> > firmware's out of reset configuration enabled the regulator and regulat=
or
> should never be disabled or change its operative status.
>=20
> What I was wondering if how this regulator is enabled by firmware, by som=
e
> GPIO control?  In that case, 'gpio' property should be there to describe =
the GPIO
> control.
>=20
[Meenakshi Aggarwal] Its not controlled by GPIO. Its gets power on with boa=
rd.
> >
> > Can you help in understanding why these optional properties cannot be
> > used together
>=20
> It's totally fine to use these properties together.  But if the regulator=
 doesn't
> have on/off control, neither of them makes sense.
[Meenakshi Aggarwal] As per documentation, we should keep " regulator-alway=
s-on " as per description, we
Can remove " regulator-boot-on" property from dts.

regulator-always-on:
    description: boolean, regulator should never be disabled               =
                  =20
 =20
=20
.
>=20
> Shawn

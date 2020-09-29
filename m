Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FAA427C08E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 11:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbgI2JKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 05:10:07 -0400
Received: from mail-eopbgr60076.outbound.protection.outlook.com ([40.107.6.76]:57757
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727902AbgI2JKG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 05:10:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jOhcpSWSCZGmt5XT3snBSzcc0Pt9MIn+Ohqvh4G/i34rhHDThrosmL3xpqM/25aVbT/e2oNMmxgdbbK+baKxa88LG2jC3DRVlpIRzf8mxagyVTvC3shfbxRiETpXt3HIkizNzBN+ASZScer4vy5VwkLnpCCRfOOI0xVB5dMO7PsudWUnMfNVGkX5N/P0JSzAhMigRuMJeVIwAlHEGaZEdCHerd2t2/n38ReOEX9mqy7dsWbWg1vjAe/wC6iWmYz0R8Pbe8w3Ad7Fh94OEP076mCunLlA7ed7vlMw0jATUtEPiXd3TJOCfT2tscECMJUMTCA/LoSk0ajIWJTRa866DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OnerOwFbt36KoCg5vzdpHWlF0lkuR36cdYwwQHtazwg=;
 b=kZOYvVdeNUgEM4j4lq+BANO4gP4SU/zjlJ9NFXKhBmMSJFDRz/xl/qvZdsEc+TV90TaC/1rtTj197KKcB9DzySXaDS1CoI6TYZA50outVkK/gCXtsjQo44uF1eTAqwY53oSjnAXMbBhWhLf/mC4VrArByFbKKKc/IU6KTGseR52OaRvLUtUI4idDXPTeFdH2T+MX31qBvxHtOArUb65XMI8ymfksnZr7i6AXERAgpoi1FAIMbm3clEZwhHPfFlvkpXdSBEwWz0BRJ80UnpPG2A6x1d9ngQMSpP48Cq9E1t2y4DDz/q3M0JDqZvDsk1MGy9yyVeExKFgWI3pcpSVTdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OnerOwFbt36KoCg5vzdpHWlF0lkuR36cdYwwQHtazwg=;
 b=Fgu8NnpRUdoYWaJ0YrTF+4ie15G5UBTiViqVvTMS2TP5nGcVfzVSO4eTWc7e9BwJ3ZSnmMzCHLCgYdd/53mgPj4XgsurEJkXZf/76rtADuYwZhdtfG6gbCY2+zymFB8q6EeeMN9DuTH9jOVHdHc3H4/pwAPUwjJmBAG1wAOOEjo=
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VI1PR0402MB2862.eurprd04.prod.outlook.com (2603:10a6:800:b6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Tue, 29 Sep
 2020 09:10:03 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::ad7f:d95a:5413:a950]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::ad7f:d95a:5413:a950%3]) with mapi id 15.20.3412.029; Tue, 29 Sep 2020
 09:10:03 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     Marco Felsch <m.felsch@pengutronix.de>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        Anson Huang <anson.huang@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 1/2] regulator: pca9450: add enable_val for all bucks
Thread-Topic: [PATCH v1 1/2] regulator: pca9450: add enable_val for all bucks
Thread-Index: AQHWf3GYvz7pHbbwy0Oh0swEP0rom6lSCuoAgAD5ICCALHVfEA==
Date:   Tue, 29 Sep 2020 09:10:03 +0000
Message-ID: <VE1PR04MB66385C2A3ADDB0E36081BA3689320@VE1PR04MB6638.eurprd04.prod.outlook.com>
References: <1598892515-30950-1-git-send-email-yibin.gong@nxp.com>
 <20200831105304.6qcpjfmranay6q4y@pengutronix.de>
 <VE1PR04MB6638767DC4367488F9104913892E0@VE1PR04MB6638.eurprd04.prod.outlook.com>
In-Reply-To: <VE1PR04MB6638767DC4367488F9104913892E0@VE1PR04MB6638.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f5aa88ca-696f-484d-a1c5-08d864577356
x-ms-traffictypediagnostic: VI1PR0402MB2862:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0402MB286229028243D4C55B8E7D9389320@VI1PR0402MB2862.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HbVckn6PdqTvOlhfqMrtwKUdfLlWaUwL5IFOcH0yg9e5htvJcv3qMlC5virFhkgoEZ9g/MvV1L9uUSQy8nxHs1laZkqMpiAMrdy4dckOUigFSBwdTJ5Lj+iwEBXvMHj2B28oL8RZwpIAdEQlPF56yxFYvrUYSwYE+12H0tMPskGbvFFAFPjCmgyV3LvnkkGC6wPAOrBTZPyjF3PqVa16kaxX7TjGWZqElbwArRhxhg3/wpO4iOdWaC4hiNqjAocQaHRa71pbZ3CvJah7DA8bCqnYtQKiikRpIlBFWlbBWmQxW0kqoUKQ+LabrzLa6Tnp9UTVr1XGx3ZcsFdkxJJiIJh5vFZh2T0KNRp1kKto/vezbmtMzTb+ycJaJg0DsVxx
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(346002)(39860400002)(376002)(396003)(2906002)(86362001)(6916009)(478600001)(316002)(7696005)(4326008)(6506007)(53546011)(9686003)(83380400001)(186003)(33656002)(5660300002)(8676002)(7416002)(76116006)(66476007)(66446008)(66946007)(8936002)(52536014)(64756008)(66556008)(26005)(54906003)(55016002)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 8cgZOrZX4ZUWg5jRoRL2WVQjJhNNCASdjdrGznboU6JUCtBDGrFSjh/WWT7nralCy8dMbOnEvUxEKB2CTeY9JPu6nGy3awRIFHWDKMG+Zx9sAuE8a5gN/SsQ7GhDGpxoxCAHiUtYpiHJK/1Ws3yi2VekToXr1EbR3BSi8V/p4lmRz0Ce+Q+/6kFV7jcfKBoV9tqNfeYDRsx6M6wUM3/Q/nQFZwJomXHOU6O8OVjhK+hr8u25i075CQY39ObgAe7N/Cmo1JNefGOG7uJEzqxgGtCdy63gZDIoXGWgUYmBtGs9TBgcti/GYtd9zSBlTALLqvP/DZpxsN+07FordA3MLnMyTVEA7wpmKIffrHNMTJQmL8wLFxL+hs/MVezVYgkbkPIeuI/fr5GlOuJsym/h6g2Mag+eWAjlNdKXPJJK9GbTeCUIu9tVt68Hcqm1Ip1Am3mRLyKq4MPnDt4PikDU9lhAV5/mFx3TQpj2GSTW56mVhhPbYeOEulF7WVMItKD7bwvQO4N4srF5JV2rgemoiNeNr0M34P78jn1L1xQeMiikRcgeNgFe3VnMrKTQ8+SthnneYcUbuMqZolstrxT5LsFQ+xlhZAJQGB542XkzZY47zdsSaHHz+/brSLNnbrSXLywwpsgEt+PmWfA2bBa4Yw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5aa88ca-696f-484d-a1c5-08d864577356
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2020 09:10:03.1765
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gtb/ZZqwR9sNo8a3z6YdkSkj0rZNjE/8k18BSAebZ2G8TQEOZMGda/MnmIjH8oDdf7jEwfDAsVPbTPP5ptmAjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2862
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/09/01 9:58 Robin Gong <yibin.gong@nxp.com> wrote:
> On 2020/08/31 18:53 Marco Felsch <m.felsch@pengutronix.de> wrote:
> > Hi Robin,
> >
> > On 20-09-01 00:48, Robin Gong wrote:
> > > BuckX enable mode
> > > 00b =3D OFF
> > > 01b =3D ON by PMIC_ON_REQ =3D H
> > > 10b =3D ON by PMIC_ON_REQ =3D H && PMIC_STBY_REQ =3D L 11b =3D Always=
 ON
> > >
> > > For such enable mode, enable_value should be clearly set in
> > > requlator desc,
> > > 00/11 is not enough, correct it now for different bucks. For
> > > example,
> > > buck2 is designed for vddarm which could be off in 'PMIC_STBY_REQ =3D=
 H'
> > > after kernel enter suspend, so should be set '10b' as ON, while other=
s is
> '01b'
> > as ON.
> > > All are the same as the default setting which means bucks no need to
> > > be enabled again during kernel boot even if they have been enabled
> > > already after pmic on.
> >
> > I wouldn't hard-code the regulator behaviour because the behaviour
> > comes from the system design which in most cases are comming from our
> hw-guys.
> > Till now I saw a few intelligent designs don't following the pmic user
> > recommendations to save money. I would love to specify the regulator
> > behaviour/mode within the dt or acpi.
> Well, if so the better way is moving into dts. Will implement it in v2.
Hi Marco,
	Sorry, I'm afraid that big changes have to be made for moving it to dts, b=
ecause
current pca9450 driver is using common regulator_enable_regmap() which mean=
s
rdev->desc is const and 'enable_value' can't be changed runtime with the va=
lue in
dts. Regards to pca9450 is the specific pmic designed for i.mx8m family rat=
her than
generic pmic, the power rails defining should be the same as NXP MEK refere=
nce
board, especially for the BUCKs which match well with SOC's power. So may I=
 leave it
at this time, and pick it up if the 'unbelievable trouble' really come out =
in the future?  =20

>=20
> >
> > > Signed-off-by: Robin Gong <yibin.gong@nxp.com>
> > > ---
> > >  drivers/regulator/pca9450-regulator.c | 15 +++++++++++++--
> > >  1 file changed, 13 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/regulator/pca9450-regulator.c
> > > b/drivers/regulator/pca9450-regulator.c
> > > index eb5822b..79f2a5a 100644
> > > --- a/drivers/regulator/pca9450-regulator.c
> > > +++ b/drivers/regulator/pca9450-regulator.c
> > > @@ -249,6 +249,7 @@ static const struct pca9450_regulator_desc
> > pca9450a_regulators[] =3D {
> > >  			.vsel_mask =3D BUCK1OUT_DVS0_MASK,
> > >  			.enable_reg =3D PCA9450_REG_BUCK1CTRL,
> > >  			.enable_mask =3D BUCK1_ENMODE_MASK,
> > > +			.enable_val =3D BUCK_ENMODE_ONREQ,
> > >  			.owner =3D THIS_MODULE,
> > >  			.of_parse_cb =3D pca9450_set_dvs_levels,
> > >  		},
> > > @@ -273,7 +274,8 @@ static const struct pca9450_regulator_desc
> > pca9450a_regulators[] =3D {
> > >  			.vsel_reg =3D PCA9450_REG_BUCK2OUT_DVS0,
> > >  			.vsel_mask =3D BUCK2OUT_DVS0_MASK,
> > >  			.enable_reg =3D PCA9450_REG_BUCK2CTRL,
> > > -			.enable_mask =3D BUCK1_ENMODE_MASK,
> > > +			.enable_mask =3D BUCK2_ENMODE_MASK,
> >
> > Unrelated change?
> Yes, that's just correct it minor literal since that's BUCK2 although the=
y're the
> same, will split it anyway.

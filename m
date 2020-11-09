Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 520F32AB543
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 11:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729323AbgKIKqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 05:46:17 -0500
Received: from mail-am6eur05on2068.outbound.protection.outlook.com ([40.107.22.68]:26923
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726535AbgKIKqP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 05:46:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IoaLq3coQAnWx9sklACY9o+22h4XLJbkfVRUzEa/XJ2csnuk4RocpwCrS6s9aCQMhHVOfIV5LWLGDXmbKX9jHvxEOaswL2Ny9LK81gCiuCJAFO5OS6XSApC3+6Wj1HZyzkU6iyzVs12helkguolOXmDGvpCWd8SbOPGvBRP/mWNbLdzzXWix/HTp++QchGD7CdBZQ+J7RsRMIFhNilPV4dZSijs2o7EkrBj1ReK5Uir/4fAWeKLW2vxamZbzU7Rj2XD++eYR5NiyMBu2GAcp7GcnZI75KM8K8dvokOP2OP3Wa+yVQIaWbMbKcKhPcMFkNPeL5FHs1l2DmOwyXuymrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b73Q7kNpE1zg9Yl5LwDjvG2EQU4rmCYAKSA8+Fk5x+0=;
 b=VBh+IZApcbm8xkjuHwuxODv4DI8giX6Gls3OckKrjOYo/qgmwf1YPjCZMbDg2UVrcp/Ad10KWddbspY9i6JvzAfW2m01SiwdFk5gmQTBPfcVfzJDaN8eMKEvYH4EMiRveAgDtN3G42GMwH/ifKw/fUhZozBM4yDqJ4talcOj55adqv4ZptNCVdjbUnArGGQHMT07dUtOzL5uKJ2eXPiYM4Gi8X3nwtsIKq0VhEN7tAhEVZS4fTWh9k+VtMYhuIW5KrY4dou/Hgtkn/y4Qp5Cyu98RhpBdNiD2Ot2oMw175g131wP1s9D+dyOnav1B3WaxLS6XJyF9L35McauoNmd0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b73Q7kNpE1zg9Yl5LwDjvG2EQU4rmCYAKSA8+Fk5x+0=;
 b=WnBtQ9Uhn7ajf1HoUhXeopUw4UTC2Vmlr0gGLiP6iuI2e2PyAr96fleH1WMma733awDBDGjAhepHuIx34OuEQNW76IV5Wrvq8DhtMa4pkIiuYg61+Et17IZq+eY+Nefw7pZmdqKXwjtrC+XUAjuCfuORSh/YHr3gnTA6oiGLfL4=
Received: from AM6PR04MB5685.eurprd04.prod.outlook.com (2603:10a6:20b:a4::30)
 by AS8PR04MB7526.eurprd04.prod.outlook.com (2603:10a6:20b:299::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Mon, 9 Nov
 2020 10:46:07 +0000
Received: from AM6PR04MB5685.eurprd04.prod.outlook.com
 ([fe80::c62:742e:bcca:e226]) by AM6PR04MB5685.eurprd04.prod.outlook.com
 ([fe80::c62:742e:bcca:e226%4]) with mapi id 15.20.3499.032; Mon, 9 Nov 2020
 10:46:06 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Michael Walle <michael@walle.cc>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, Leo Li <leoyang.li@nxp.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Ioana Ciornei <ioana.cionei@nxp.com>
Subject: Re: [PATCH net] arm64: dts: fsl-ls1028a-kontron-sl28: specify in-band
 mode for ENETC
Thread-Topic: [PATCH net] arm64: dts: fsl-ls1028a-kontron-sl28: specify
 in-band mode for ENETC
Thread-Index: AQHWsFGeixGx/s/0HU6mwAEfgSmZwam+kYcAgAEY4YA=
Date:   Mon, 9 Nov 2020 10:46:06 +0000
Message-ID: <20201109104605.vzg2dt572krlijpk@skbuf>
References: <20201101131905.8316-1-michael@walle.cc>
 <b2b33b89e0f363344fc3b036e58d5cdc@walle.cc>
In-Reply-To: <b2b33b89e0f363344fc3b036e58d5cdc@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: walle.cc; dkim=none (message not signed)
 header.d=none;walle.cc; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [188.25.2.177]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ff6d9acf-b3c1-4a0a-d5e8-08d8849ca969
x-ms-traffictypediagnostic: AS8PR04MB7526:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AS8PR04MB752690D6CF0D8BBEB2FDAAB5E0EA0@AS8PR04MB7526.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fK4z2h5eDGy4LaHUYBLwQ/WZHU5S6y3gPuPNvFqMrv3xRGrfE+d0lW4EFoWIoBTipl380gaqr1kUc6rHoB7zcJBVzdi4kf40CLMHJrEJZga9Ul3rRPv3UgovjYj9UJBTNQ82n+xnPp/hecg0R0WRd4P44633uGwI4RCSMGeU1jQlPxOfs2doMLsFQ4+wf7c3pSkBNDUehEEK3ZeYlgHj+uFq+X68iQvc3ZHIsj2SPdc+zGGM/UkjRT9VANvn21LHVO/EXT3IAnsOIzHo1jwxmCGwbmCkui+lfnnvRJN0o4XHf/2TORgNRIS4dbLsG/0pJgqTU9g2ICXym9GGzPTMOw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5685.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(4636009)(346002)(396003)(366004)(39860400002)(136003)(376002)(54906003)(66446008)(64756008)(66556008)(66476007)(66946007)(71200400001)(6512007)(9686003)(6486002)(478600001)(186003)(26005)(4326008)(6506007)(76116006)(1076003)(91956017)(5660300002)(33716001)(44832011)(6916009)(86362001)(8676002)(2906002)(8936002)(316002)(4744005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 6BJ0DeeQlQV2OMbCVZDiTs0JtwIdkk34RJ/Mk1+JVn74mftY6FmUDpAguFkO8GA356IU/CBP6VDjujhtG3iOk64GRtrEhyz3JL0PutkU6E2ZgqZ4KOU0UoV0FpvcXalRhVIioV++kjaTgSAGAGFJy79Hh5WYA4o0PuASiBUmVMF5+AnolbN9BGlZXxzsbiX6dNx/V01GnccM9CKTJTT2E7LvtSRvKzKkB11RNS03TPDo0PojCX+MJ/oWXnWhcY2W7hkEX0bg3hflR6leh864ATdFQwaAUvnHqVyjI3FitSHPxXekuR7Jl7BA3cvO9Ds2XgpE2VXo+fti7XP2S2TqHf6yqvnP//P1UMAlQjtx63y/COjJO7nUAJcV4hP3mAEdSK8c7dIw1dOYsJ3b/q73pr5SfZg5flAZqUuhL9MILETOdCF+ZHzBhV3hYez5o7Zf+G7FGVoJ5CQSDvU8jujTyQsgGZJnIPnxprC8q0sXOYOVjGO3Ep5AI+mtERjMSOyUAkCp47PHgg7phlOmsR62aXZbSeD767WWtHCcf5OyV9b4iBd288OjbcNzOgWABFEFEE/g6jYLxMQ1svDHiJESxQ0oZPiNUQqNO6ZguSaozy2iXAWW7nKxn+lbi7Q+/S5QqxQDPyF7ctV1V/mo0oXRFA==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4EF530CBDB45554BA91F3FDCBF62E55F@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5685.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff6d9acf-b3c1-4a0a-d5e8-08d8849ca969
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2020 10:46:06.3656
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U1ien+ucqqlloYGqQwi8GkxE+I7lB3BN64G7AqEgmT9xtwZ8yDsQ/uwmUoybsc5Ol+FMRSBYRYn9Yp/4ZHrf5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7526
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 08, 2020 at 07:00:46PM +0100, Michael Walle wrote:
> Hi,
>=20
> Am 2020-11-01 14:19, schrieb Michael Walle:
> > Since commit 71b77a7a27a3 ("enetc: Migrate to PHYLINK and PCS_LYNX") th=
e
> > network port of the Kontron sl28 board is broken. After the migration t=
o
> > phylink the device tree has to specify the in-band-mode property. Add
> > it.
> >=20
> > Fixes: 71b77a7a27a3 ("enetc: Migrate to PHYLINK and PCS_LYNX")
> > Suggested-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> > Signed-off-by: Michael Walle <michael@walle.cc>
>=20
> Ping. will this go through the net queue or Shawn's queue. In any case,
> it should make it into a fixes queue, because this board is currently
> broken in 5.10-rc2.

Michael, this cannot go through the net queue, since you didn't copy
netdev@vger.kernel.org to the email. It's not in Jakub's patchwork. My
advice would be to resend it.=

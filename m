Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAD9229A383
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 04:58:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505309AbgJ0D6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 23:58:52 -0400
Received: from mail-eopbgr40057.outbound.protection.outlook.com ([40.107.4.57]:19884
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2410312AbgJ0D6v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 23:58:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gxrb584Ftt2m/1CHF0p9hu+6TZWnrlvcqqAn8139/x0rfZYIqzyoJz6WUpImczk/kr9iAUksMTbEPJGBaSWUwY5NhXp5BWBToAnc0kA/OZrss7cQepNB/f7rt3gYjELK9+f2nWOOc1j5WHnWFC7no9V9WfUbRlypU3ffTqDJLzphLVh24sPTqu8weOdBzcraTMyPqEBy4p+NkXt7LIE8ojBEoVIGrcwl+gpG7ku8XbgQp5V5xp4JkS6tWsQgtcw8/sty7sWPs2O6+MSSfMKsJiSkeK0Yi1/mP60V5aPtNLWpCkkVeYcrAcHeJqXBsQJ9zLCd0kIEhG07BeM2XmCEYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=01gCwYe9DzWJBqadbCka6Dds9VvntxqIHF6+vwIi1uU=;
 b=OOhEyncIy813ERS1B6nyXHsApjnXabqJPozM418NlhjtVLvwEY8ISyODDwX1LinqUXY24Gsx/hSKTNBdkCiBVT2Pa23fCCAxOPKRbRJ+WUsoobwqt1oGPkTEFzWB7Ussqh38ZDPa7yUcCA3rLS7pCnrA7ExOEcctq/VeHm4xpW++wwlw+X9twEQK31tp17MAlwoqUdKWlekPxoi6YwOh58FoLEI8yG52gs3F+3pHYc/NN9489Kiu5mYFevQlK/IaONfBjU4uqhQilIqfnycJhk4n4bqH/bNBmK+dldFhPfK27x7QTmSRrT3IB6p0yYWQLqT5QVwcqxQGwqPryBhH1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=01gCwYe9DzWJBqadbCka6Dds9VvntxqIHF6+vwIi1uU=;
 b=GCueQc7RtGMcN/Fq4bX3lPoPtzH7i8snTF08ImKyrPYg5UkX4029hFjjS2uy8GAmIZcWZ3WHzMRh1GiwkXNlQ3Ss81rI6wFkww+OU6gC8iJ1DFBjonm/mAJsiXr1WMHSBRuF2FPYTI+zja6sadffpomxMr6W/OGQS6vBm6yW4z0=
Received: from AM8PR04MB7300.eurprd04.prod.outlook.com (2603:10a6:20b:1c7::12)
 by AM9PR04MB7633.eurprd04.prod.outlook.com (2603:10a6:20b:2d9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Tue, 27 Oct
 2020 03:58:48 +0000
Received: from AM8PR04MB7300.eurprd04.prod.outlook.com
 ([fe80::b902:6be0:622b:26c2]) by AM8PR04MB7300.eurprd04.prod.outlook.com
 ([fe80::b902:6be0:622b:26c2%4]) with mapi id 15.20.3477.028; Tue, 27 Oct 2020
 03:58:48 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Pawel Laszczak <pawell@cadence.com>
CC:     "balbi@kernel.org" <balbi@kernel.org>,
        "rogerq@ti.com" <rogerq@ti.com>, "nsekhar@ti.com" <nsekhar@ti.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rahul Kumar <kurahul@cadence.com>
Subject: RE: [PATCH v3] usb: cdns3: Variable 'length' set but not used
Thread-Topic: [PATCH v3] usb: cdns3: Variable 'length' set but not used
Thread-Index: AQHWoq98xx7XZYJdVkmeSngJp6ePZqmptLIAgAAh+NCAAQ3WQA==
Date:   Tue, 27 Oct 2020 03:58:48 +0000
Message-ID: <AM8PR04MB73000CE28EC53B3402BFC5BE8B160@AM8PR04MB7300.eurprd04.prod.outlook.com>
References: <20201015045529.2022-1-pawell@cadence.com>
 <DM6PR07MB55290EA090C418457C1E293BDD190@DM6PR07MB5529.namprd07.prod.outlook.com>
 <AM8PR04MB7300C4C0BB37319ABC1680528B190@AM8PR04MB7300.eurprd04.prod.outlook.com>
In-Reply-To: <AM8PR04MB7300C4C0BB37319ABC1680528B190@AM8PR04MB7300.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: cadence.com; dkim=none (message not signed)
 header.d=none;cadence.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [180.164.158.209]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 923acf57-47c9-45c8-f381-08d87a2c9bf3
x-ms-traffictypediagnostic: AM9PR04MB7633:
x-microsoft-antispam-prvs: <AM9PR04MB76338D2C2299AE87C8C972958B160@AM9PR04MB7633.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FfNjPFABuIwEvA8joeXhnd5Bg6+oSI0mfsMqj0eTfrZcSmGXk3ypn/D43S8xPADtXp30nX+QgJE4TTkyAbZjKxFbEQJe/f5oaF6P0TaSHmprTimMZOe2Y88bRB/M96yA/VD/X3jX4Q3XMHORZN/JDq3JVbRxxg5637PoPwr6SQ+sHrPszkf53I/UjLusU8FrkcovR+ylHOJtlJmQYy2HDA108BHqclAnMW/VWSXKa1OB4V6J+7MeO6EgPKZOgReeAA78jIU+kYW4rbJLbftUai7iO03UR5gdksScEkiz5NDnA5xx7wpwBxlS6lxxUI7f
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7300.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(39860400002)(136003)(366004)(396003)(186003)(54906003)(55016002)(6506007)(26005)(44832011)(316002)(86362001)(478600001)(33656002)(7696005)(8936002)(76116006)(5660300002)(6916009)(4326008)(9686003)(2906002)(8676002)(83380400001)(4744005)(66946007)(66476007)(52536014)(64756008)(66446008)(71200400001)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: RrpmGF7Br7qXlnZkFK88hT0Oj3AAusk8DnssWrWzP4oZSZo+VWHVG0/IS72iAXHwt+HVehKRfh31/d4/VynlCIRxu2ELaEZDZ1AhO32qFWtWvUpRmBp8R9/nLv6mxpIprZrPTEk8GsYtAS25VhHkvflTOt8lvyZ7mZK0NHYCpnE+vCwzaGZbjW/T9iswk1OfkpkwHCPm3xkUB0xbELorNcKCpv8Y2UPygFd9LSc/wilX2OsGE56cFD7O63rM/PkX+r1gSqUuEvBYD5PFxf9zEmiQSBMGZ9e4icM6Mu1UhsX9yqeOW+KEYB36lh0jn6nJW62hKwICG/K9XVpaIIDO78qqAxyhTot2QzhW5RuoOLdUYh7FEMMpEtNUCnu5c47ivhzQutpvNDgXA20ylsEuTs/ahUvH6jPFSMk6K9Mp06XvqOOnPkZ7V12fBBpLVrqpONiyAONxatnPJ/u8cZaFxOxVThwgNYi88YHoy4KGNGSKdpBR3b6ORWz8SkT9tett3jaZXwsGFheDePmIUoaGO6OTO19PDrk/tGCxb8nR3yXlWYOtDSPgfgEhDYyf36n82PzqQLJ6G8Rv+FzWD0xnFotPug/T0LzpIB/d+u2+XthWcsSdEB+Xj++bQG/pLRGZjSRcM8qOTBzUj+Q+xeg+yg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7300.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 923acf57-47c9-45c8-f381-08d87a2c9bf3
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2020 03:58:48.5296
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +h8YSvrW2V/QlObphQ3JPhpnYS9aDpbcyz9Yitq43xJoipJsd6NsxTeCZjgWOE5brdAE0I5Yh1RBfrGkFXeacA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7633
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=20
> >
> > A gentle ping.
> >
> > I assume that you should add this and the rest overdue cdsn3 patches
> > as first to you ci-for-usb-next branch.
> > Am I right?
> >
>=20
> Hi Pawel,
>=20
> I queued them locally, and I waited for v5.10-rc1 which was out yesterday=
, then
> I will apply them, and add cdns3 patches to my kernel.org branch. Will up=
date
> you these two days.
>=20
> Peter

Hi Pawel,

The cdns3 -next patches pushed to: for-usb-next; cdns3 -fixes patches pushe=
d to: for-usb-fixes.
The git is: git://git.kernel.org/pub/scm/linux/kernel/git/peter.chen/usb.gi=
t

Currently, I only pushed three of your patches, would you please review my =
patches, thanks.

Peter

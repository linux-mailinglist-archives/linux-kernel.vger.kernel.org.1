Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEE4F298C6E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 12:55:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1774170AbgJZLzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 07:55:18 -0400
Received: from mail-am6eur05on2054.outbound.protection.outlook.com ([40.107.22.54]:64128
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1774149AbgJZLzN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 07:55:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Quvvtz2yNQWfLEztSp3iAAGFur9zJHsy6TUteoQroHqkM12j8jJIeQ2OMVzLRk/KeYyyHYe9fIkK2ntqusWzGRF4ZBQIv4kpAdeWDsipsVe4B47JpQ/EhOFYVGhmO1NB2Q0AvLopzEQ+PXfEJxiBDAbGP3WI7yje4pI0GLCXyhLMdYkwq3IoeKmFYrIbkFc3G148LKFEDvyeFCDKqkTkNG6LODru6RDlKu54LELiNzt7syCeWt5MZb8kpJoOhELD7pF9bdER3wK1LbRHiIUYkYteswm6lzhV3rWUn7uuRoR1QbC+Xq0PmfHZZtTNO9Zc5h6bcCMOeb+yqqwn+lizog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JCqB2GMsFU5yJYlrjyo6K7kUOfEgg0Mk8PX9SN5mqjA=;
 b=CXTs5keweOuQDq/WEbu9clSk/qEHzPSabn/n/8anEHsTY4UZXzzfM1eBL0IB/bXu9KFhCtotZh1dNldNSDcypLRXRFU2z5kdTdiq1JxucnXjoQWGVM7oCAyI3ALTYO7yzFDJih4X/u+eCLyT9Z0kCGCBNKBcL16Y1qUIUvLn9Qah6txPB8PiQMwuoZqd4e+wlVPPptOS4IWP5YB1ABZSkCN9hLH1yruElFC3l76nMHPb7IHM5lSjlTv8ciXNXr9EElD4em9zdN4/exKnheJD+Z6LePXahlT3tdgKrOQ48M+E0QxsmaiPPMRE1KDuUr6ju5WPymcC++YAoLXvHNn4gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JCqB2GMsFU5yJYlrjyo6K7kUOfEgg0Mk8PX9SN5mqjA=;
 b=I0RYcfGhFTYSaWJVDDQPOPSuSHHdoDvV7lKF+Vv4ja1ejQ0VKfpkXSLBFEoZ2T0APdnlCL/jpHYg6NPyjKV4g80om4X8PoDV4oX1DQ8+Yey3MFt8TEXmIP6qaHUgj/b9xxdXUhoH95lC4J83kx9dBxwj/8D7DeUg6zEebmDxYo0=
Received: from AM8PR04MB7300.eurprd04.prod.outlook.com (2603:10a6:20b:1c7::12)
 by AM0PR04MB6371.eurprd04.prod.outlook.com (2603:10a6:208:178::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.25; Mon, 26 Oct
 2020 11:55:09 +0000
Received: from AM8PR04MB7300.eurprd04.prod.outlook.com
 ([fe80::b902:6be0:622b:26c2]) by AM8PR04MB7300.eurprd04.prod.outlook.com
 ([fe80::b902:6be0:622b:26c2%4]) with mapi id 15.20.3477.028; Mon, 26 Oct 2020
 11:55:09 +0000
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
Thread-Index: AQHWoq98xx7XZYJdVkmeSngJp6ePZqmptLIAgAAh+NA=
Date:   Mon, 26 Oct 2020 11:55:09 +0000
Message-ID: <AM8PR04MB7300C4C0BB37319ABC1680528B190@AM8PR04MB7300.eurprd04.prod.outlook.com>
References: <20201015045529.2022-1-pawell@cadence.com>
 <DM6PR07MB55290EA090C418457C1E293BDD190@DM6PR07MB5529.namprd07.prod.outlook.com>
In-Reply-To: <DM6PR07MB55290EA090C418457C1E293BDD190@DM6PR07MB5529.namprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: cadence.com; dkim=none (message not signed)
 header.d=none;cadence.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [180.164.158.209]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a824250c-d570-4aff-5b51-08d879a5fd0e
x-ms-traffictypediagnostic: AM0PR04MB6371:
x-microsoft-antispam-prvs: <AM0PR04MB6371CBE3C527DA9D26B772908B190@AM0PR04MB6371.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2XF1pQSwBNq60FYNP+uWfCzKjP+eP8g5Y00qWQ3V7Mu6PbT1yc9PftVJ9n/V0piuo261rkxGCB3N3FZQeL1fFY2tydtV0pqSCoolD82z44IX/K/QMLJjSuy5gf+VE7ffxx7JfzKPsbkYMoF19BzXAiww3YvfYIAC8QUi+oJ/D1KafFW65nR9DGgddA0wxPZwnXmtt604qOLOG9PZnNd6WgjA7fCp1JDU6JN0Iib3c3gsPkxn4sWiVexUyhDCd6XGqU6vNYcReVYiTXS34tSBgsdNasOaSVAfrpGkNKIOxP7sqRAuQGLKpiOXDc0h07yaXNP2cFkLVKOTeCddi7sZOg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7300.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(396003)(346002)(376002)(136003)(4326008)(71200400001)(54906003)(8676002)(6916009)(66446008)(66946007)(186003)(83380400001)(478600001)(8936002)(26005)(33656002)(6506007)(44832011)(76116006)(64756008)(66476007)(55016002)(66556008)(9686003)(316002)(2906002)(52536014)(5660300002)(7696005)(4744005)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: G6s9GtvvIUpB4nZLKsG0lCNT51dnwaNt6ytfS350wSII7OaMMfvYIyv5Sqx+W5AC0SybjeU8BR+uh6ipIXqumcPgG1l4jJyuTNv1yOmbYDSSp4BHjVKGC3qzfMHJmVKvUEQn/U2Umv5GMkObe/B8KEmIltMabgCNOYFteJZOI10Bm8QXVQVZ69yjcKE2+JYTzbXlY6c4SpnTH/AscGF5J5XYd9ecqOiODnYycD9Z6tXQDe+WfaRnowssLrOhYpTGpI08seC+d1MruzC9AZryZWkm2jHyvF7D1mA/XVGpU+HeM1DaVUUl9ruIsdPHBcHCKWltENnK+jlZRw8LNwO2wBSstWsBaGxb8W94vT7xtRTXrAZz9iKMEF9FjhWvpzP2dBeRUkuhTVptTFiNSuea96OLLjnnGkpTzWjJ5aoq5gxEMABsypGIoSIkP5L/odEGUT5uwicLclP2OItG0UGuZhkTmZvBSaTnoH2U1A01hUQgbGzl05hME7fynm7gzzlcIb9OuL0uS1V6ZD7wYK0MD3I0Ej4GJ+1WQ2YosFcoxbcQCbqWHCBKHBZn/TOUh0foYIoWI9vWyd0cHV3o+nqmznLU6KJLRbAf6k6jyeyl/oXE76ltVTCUc96iXBgHoVqmj+qMu9SeRA9fTkGEHb+RPw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7300.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a824250c-d570-4aff-5b51-08d879a5fd0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2020 11:55:09.2915
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dPfouR90FC5JtB89KBdadFnsKz7W4eMtUfr5jm2Wbb31MozGl+yFz0UVxlr0/ZLzPLfNJEXnoR+eHBFbJYCWUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6371
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


=20
>=20
> A gentle ping.
>=20
> I assume that you should add this and the rest overdue cdsn3 patches as f=
irst
> to you ci-for-usb-next branch.
> Am I right?
>=20
=20
Hi Pawel,

I queued them locally, and I waited for v5.10-rc1 which was out yesterday, =
then I will apply them,
and add cdns3 patches to my kernel.org branch. Will update you these two da=
ys.

Peter


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2F031A764E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Apr 2020 10:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436998AbgDNIkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Apr 2020 04:40:46 -0400
Received: from mail-eopbgr10065.outbound.protection.outlook.com ([40.107.1.65]:10979
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2436981AbgDNIkf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 04:40:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GdHOBagvB8lGfg256VZ1rlNJqpjRY5Ycg8k9EfHuY6ZG9DF8W9D133CV1QJ/7Qs2Mt3FnGHAwhjollxO7mitNOUEGHuZTbEU/Ttc/Atu2bi5mzKphBCCTCV2JI/ENx/n4RqLG5KIlhurs/FhM3+lJ4gjQqa2okcLwAxUcNw1fxdKTKZ/wWi3Iv4m0J+qUtZf3LM4nZ2dxC7vm3dz5zEmoIpG8c606ISt22OTAGtm5cGg5bntLHgeelep2bx35Y1Y3H7fpS8OLF/eKL8sNR3uxObHolqQOvmpBpRN+IYHjklD1mZQIGhUEUWS53A4mobQwTc9lzPbTkkBp4cj0gE23Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xc5c9qVSbdIVQvIgLLc3BYBS6U6GkcdHbgGkL6PgOY0=;
 b=HGnYm/TvcV1l48RD3O5msI/P91inBpGRCXTFSMxrKsf5pdWzNkBKHKP7qemfQDpxLRTw0T+LEQkNWgzQAoJkv+92A+T2g20NSia93hXip/V3cYWpRt+jweD8GILdleWpv7ii9hOcA28OnVEtvZjlAvQsdzJJdwEuf+MP8DdeJLNn7xYRj9i+R+wdid9CNG/uhdO5B4G7SvnEKRXgeTmnAbOw1hfhmw2DNAvKZV2Y+ySW9NELBLn7JFa1PuGcyE9P9Va98eOGmtftAnUL4zifwb1DCdO1XMPTvyJG/kQW4tRERfLYZSTd7gHUba255CbwK9QkJ2GnVXi9ANjSr6DK9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xc5c9qVSbdIVQvIgLLc3BYBS6U6GkcdHbgGkL6PgOY0=;
 b=gY3dzy/W6ZQMFfdWxJkIJsvsgGyXqhMP7eYD0lkq55jLGmiN43kGOEDCWsL3kGks7++yfbRAoM6hNteAz2Q9vq1u6lomk2v4G5NdcnbgUhWYDu5ivwK2n++dVByyNyYVIwQSQtVLf3opcEas7summwVWpJOHtNXKGfdmsua279M=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (2603:10a6:208:70::15)
 by AM0PR04MB5204.eurprd04.prod.outlook.com (2603:10a6:208:bf::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.28; Tue, 14 Apr
 2020 08:40:20 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::ad44:6b0d:205d:f8fc]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::ad44:6b0d:205d:f8fc%7]) with mapi id 15.20.2900.028; Tue, 14 Apr 2020
 08:40:20 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "o.rempel@pengutronix.de" <o.rempel@pengutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH] mailbox: imx-mailbox: fix scu msg header size check
Thread-Topic: [PATCH] mailbox: imx-mailbox: fix scu msg header size check
Thread-Index: AQHWEjVOJqZ73kq4ZkWCSd6i237Mtah4SGeAgAAB9XA=
Date:   Tue, 14 Apr 2020 08:40:19 +0000
Message-ID: <AM0PR04MB4481562AFA8A4B9CDDD3E55F88DA0@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1586851826-16596-1-git-send-email-peng.fan@nxp.com>
 <20200414082635.jo5yljonh5xgnujd@pengutronix.de>
In-Reply-To: <20200414082635.jo5yljonh5xgnujd@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 27bc825e-c552-4fde-3821-08d7e04f7710
x-ms-traffictypediagnostic: AM0PR04MB5204:|AM0PR04MB5204:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB5204E38DDC0F6EDEBCE4FEAC88DA0@AM0PR04MB5204.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0373D94D15
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB4481.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(366004)(346002)(39860400002)(136003)(376002)(396003)(6506007)(55016002)(45080400002)(7696005)(86362001)(54906003)(8676002)(71200400001)(52536014)(478600001)(83080400001)(316002)(2906002)(44832011)(4326008)(5660300002)(15650500001)(26005)(186003)(9686003)(66476007)(8936002)(66556008)(6916009)(966005)(64756008)(66574012)(66446008)(33656002)(76116006)(81156014)(66946007);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UeEkyWS6tiuNQRH0tLo2BsVxdt+TVVXYSMN9R57Ku5MPkdVVsdeJ9xj/o0EZ/ducreXQHA6WlyTRqQcfaBO/cq4/q4zaTAJNuVDeDEwQ1RPOjNWjieQ0jk8qXS7SGXa8GV+H+NDu8RvPmyIT5/rAoQkJ5fag1aD8sevi3xV5222muUW0B/HMWkjyqX4JmTxr//ozkEP0McdoRYq+Ra9gmOLF4uIXD9HBlSnoiyQOzeBL8Ibdi1OgbJ5nLfCyUk1J7jtqqj9vRyvsSuHj6z2Mh45UH+fgzeYOyYW/2zCV6gJXSGKYoW1QYcEktVQpAc/lN0luYyP6bTepBpLLwgbJXmwJO4IH7Bkgmly3BKC3Y/OeapHfVGN5a6ovNM1R9whq1ESzjgqvTFw4UMMxRcas3TW3iz1rcgzEylW6GDi7PL/UJOcyGC4fQAaWcoSzIOczwZDfanrrq04a4DxxOXILOhUFy8GvWZogLkI6wJkYAdsa8q3D2gea1kLgZkn07da1BreH0Q0twZ0z+6Lm32/SLg==
x-ms-exchange-antispam-messagedata: zwKq6yiyAwqodp1P+N+CfxT0B8ix9Wz3zBAtwVBoOdJvO/Q2495BmEOApG8BLlukeivaHuA5KLEWzDm9R1nTiFQxAbcj/FyWP97Yn15uW8GVILEm3NSzzFuYVmuLj+jc3VUxn/GWGtkWrAV6fLbv1w==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27bc825e-c552-4fde-3821-08d7e04f7710
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2020 08:40:19.8695
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Np5pxY//l4ahF22/XylSevcBP+V3YwxyyN5T90Ny2DkYzfiq14sFRu47jVITfALS9jXOEQiQ6k3Oue6RSS2LgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5204
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH] mailbox: imx-mailbox: fix scu msg header size check
>=20
> On Tue, Apr 14, 2020 at 04:10:26PM +0800, peng.fan@nxp.com wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > The i.MX8 SCU message header size is the number of "u32" elements, not
> > "u8", so fix the check.
> >
> > Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
> > Addresses-Coverity-ID: 1461658 ("Memory - corruptions")
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >
> > V2:
> >  I not include the fixes tag, since this patch still in next tree.
> >
> >  drivers/mailbox/imx-mailbox.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/mailbox/imx-mailbox.c
> > b/drivers/mailbox/imx-mailbox.c index 7906624a731c..c2398cb63ea0
> > 100644
> > --- a/drivers/mailbox/imx-mailbox.c
> > +++ b/drivers/mailbox/imx-mailbox.c
> > @@ -154,12 +154,12 @@ static int imx_mu_scu_tx(struct imx_mu_priv
> > *priv,
> >
> >  	switch (cp->type) {
> >  	case IMX_MU_TYPE_TX:
> > -		if (msg->hdr.size > sizeof(*msg)) {
> > +		if (msg->hdr.size > (sizeof(*msg) / 4)) {
>=20
> No need for the parenthesis. Maybe a comment would be helpful here,
> something like:
>=20
> 	/*
> 	 * msg->hdr.size specifies the number of u32 words while sizeof
> 	 * yields bytes.
> 	 */

V2 will have the update.

>=20
> >  			/*
> >  			 * The real message size can be different to
> >  			 * struct imx_sc_rpc_msg_max size
> >  			 */
> > -			dev_err(priv->dev, "Exceed max msg size (%zu) on TX,
> got: %i\n", sizeof(*msg), msg->hdr.size);
> > +			dev_err(priv->dev, "Exceed max msg size (%zu) on TX,
> got: %i\n",
> > +sizeof(*msg) / 4, msg->hdr.size);
>=20
> The unit here is also "number of u32 words", maybe bytes is more natural?

ok. Will change to msg->hdr.size << 2 keeping sizeof(*msg).

> And I suggesting specifying the unit in the error message.

Is this ok to you?
dev_err(priv->dev, "Exceed max msg size (%zu) on TX, got: %i,=20
msg->hdr.size: %i\n", sizeof(*msg), msg->hdr.size << 2, msg->hdr.size);

Thanks,
Peng.

>=20
> Best regards
> Uwe
>=20
> --
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig
> |
> Industrial Linux Solutions                 |
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fwww.
> pengutronix.de%2F&amp;data=3D02%7C01%7Cpeng.fan%40nxp.com%7Ca6a32
> 1daf8f84601a28808d7e04d8def%7C686ea1d3bc2b4c6fa92cd99c5c301635%
> 7C0%7C0%7C637224496010304343&amp;sdata=3DGebTJ82O2xOf52yISwVZTM
> 6s2q%2Blar533PAGnm%2FAPHI%3D&amp;reserved=3D0 |

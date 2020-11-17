Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A79D22B5660
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 02:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbgKQBo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 20:44:57 -0500
Received: from mail-db8eur05on2062.outbound.protection.outlook.com ([40.107.20.62]:45280
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726436AbgKQBo4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 20:44:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hv0yIa9niB/hzwVjWrWCP/b6GfmoHX2CEILV52WrcFSWnN3tVlW/uTJSiXN1Bfwt3n6imF4XfxBKFbMqik/7OhcraEAEWFtmvkX3+PNj2tZuaEUjmUnuW1i3Pe0kRsSHSnhTCVUEfI1RGJAKK+musxx1ByJRWGWjwEaPm42OMOZ1X7awlefVee8e/yF2XucIX8/qOkLPbSmrHekliw2wuGGNqkOkjFz8hNyMlZRyzNXweZ2mDC0hC//pfWVb1upTVihrvXNaf8dLnR6k2izmdkcKXl3661brmaOfD33pGx5niJpsV0BEsD/QBEHIpklSF012GM/w4ELc0ply9FQAsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E+shoNKiLCAwkvYPZiZM/7kN1iwCG8Kb3do2BnBu7aM=;
 b=MTbRZG6ovVKDLPZ39ULAYTnSv19vTmraMPltg2l/puowrapPlWwESDdjFHAvsPeWrOYFB07JEQ/7EI2RY/Sl4m/44PqIE6sI5z7JRVvXyaH3O0uA0kluVLJiZilEo7NZ8JtQW7tOOabuB2AbmJeGdyvC7tIXY+Du3E9x/rT4nBd2/ljA4xQi5vQGHfJmq0gKjiJjeM6f86Z3f60nqQL0rrP/DQoqt98dZ5RAx61FdGd3/nWQM6dacDCb9vBJ+jsDdUDDeTeJPYcgUsZ/mLeI2++XFlz0CB6r5xG9MH4vBMwH1D/Qz7O9ME00l11Dyye6DjX7otOkM6wVauMtniZhIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E+shoNKiLCAwkvYPZiZM/7kN1iwCG8Kb3do2BnBu7aM=;
 b=FVos5zAuJWwOuGpgZ/6HyxuuctnKKcSUv8aL+4SdBbDdD24w7mbeYv/WFTKQPOYYcWIm8lQOjB3olZcyY6Hw2jM4qiD6x5IrsolbPd7GVMlt1jsczukGYxyLEXOOC5dLDXWA7M2VO1Sv44QFqW7NUAa3EBKuBX0wtgpSCdL/9YM=
Received: from VE1PR04MB6687.eurprd04.prod.outlook.com (2603:10a6:803:121::30)
 by VE1PR04MB6368.eurprd04.prod.outlook.com (2603:10a6:803:11b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25; Tue, 17 Nov
 2020 01:41:16 +0000
Received: from VE1PR04MB6687.eurprd04.prod.outlook.com
 ([fe80::a0c4:bfb0:589c:e41e]) by VE1PR04MB6687.eurprd04.prod.outlook.com
 ([fe80::a0c4:bfb0:589c:e41e%6]) with mapi id 15.20.3564.028; Tue, 17 Nov 2020
 01:41:16 +0000
From:   Leo Li <leoyang.li@nxp.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        "kbuild@lists.01.org" <kbuild@lists.01.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
CC:     "lkp@intel.com" <lkp@intel.com>, Dan Carpenter <error27@gmail.com>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Timur Tabi <timur@kernel.org>
Subject: RE: drivers/net/ethernet/freescale/gianfar.c:580 gfar_parse_group()
 warn: 'grp->regs' not released on lines: 517.
Thread-Topic: drivers/net/ethernet/freescale/gianfar.c:580 gfar_parse_group()
 warn: 'grp->regs' not released on lines: 517.
Thread-Index: AQHWu/q16PzAkYzhJEeZXgZC2snErKnLjGng
Date:   Tue, 17 Nov 2020 01:41:15 +0000
Message-ID: <VE1PR04MB6687ADE11367CF7FAE759B678FE20@VE1PR04MB6687.eurprd04.prod.outlook.com>
References: <20201116092505.GU29398@kadam>
In-Reply-To: <20201116092505.GU29398@kadam>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [136.49.1.200]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 18de1ed7-8fcd-4506-7704-08d88a99dfc0
x-ms-traffictypediagnostic: VE1PR04MB6368:
x-microsoft-antispam-prvs: <VE1PR04MB63681D167F013AF8E19C38448FE20@VE1PR04MB6368.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:257;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UgMWgvlBvYZz2cuuFD5PQbKJN1/RK4eOzlVv4s2C+VWGvURQ09JD7hw3SI2l8sQUq2JcUfS58alK1ETLLnJ8Eaczgm29AMHwueHkGX98QzDFgIjgsamRWaQDO4e02eJL4/PQ0hfCBv3STPkAzSv1nHlJasxK5MPL56lCzy6O7NRsMhxBUrLYQmtpMHtcRaqrvGgggFfeX8kRkoKn3pgH+BnjWtVp8BFEZyGRpMF/twJNxmKgeY9FFy/ZqsF+YUtRHGKuOdrh1kl3dyifi2YIV/sLTz0MNKgWbwKy6iKQs2BGkPSvIypeLKFYg6UxQ0Yo6o3sLnMoV1T16UTmPkbNMGJ/FkrTkhL/qAuPvpTXuET2QjsPUrUt0k7hs7QdGYyvDn5NchzfCs4vpjBWNCD7Ag==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6687.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(396003)(346002)(366004)(376002)(83380400001)(86362001)(7696005)(55016002)(52536014)(45080400002)(8676002)(9686003)(53546011)(54906003)(316002)(6506007)(26005)(110136005)(5660300002)(186003)(8936002)(66476007)(64756008)(71200400001)(66556008)(76116006)(66446008)(66946007)(2906002)(478600001)(4001150100001)(33656002)(4326008)(966005)(30864003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: rLSoxkeU4S/li0sh38eBdK5a2z5WEQuZE+dARgmKBfmh7YzdgU9t2eJywR/gwyO6PGJWKhVl+hmcb3C6xWLLNrrS0x9E/hdRMNz18MzGgk7TUAS+X07+UUoGR50KqhH/gTme/l/sO9gyyqtGatiboVCKOLSaGsyBifcqe9E1yGaLzPe2zOGK2T2MYGrYPhw54yY3X5J1k1F5L8PWoDEtG/f1iWSYMw9fvEDOq5reLeYMRKJy7zlWGdPmoPH5shksz8RviToL55Ckytx1+NU9/SsdxbZuuTzQgSiHLUCEuLQUczNN5mFEk9LmFhIcHuFLco6N4Orn7yNPOn+Vw1HLChIb23nIxBLmlA2MfAhlEJQRHPH2BVeajygVU44pCAoYKtr/+GApVuo726UDr0jOwaUsBHrmiW1GvqYKGvAQDkSIa6QBbDFJID3u0bWmj4X3vkdQoI+tukGkiRkhL4OR95ZSTgzhKLcHGA+U2UL8DI7jqkdOua0+D/4gmUe/WF93uQL6k+nqJG/CFu3HVYQ+yZU2mCBQSzbb2GaDpaklsJz2cxrckiKecBVEItaa+LEOnvEQNXEQya3mGCnUU0jI61ZwpKb4GoIjRr0d7WU8HhCKEuJhlQnn2iE9aPRX/4CFu7VHwaiFffS4vQZGqKkQQg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6687.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18de1ed7-8fcd-4506-7704-08d88a99dfc0
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2020 01:41:15.9907
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aePsufcxHhVY++j/moTL3PvO9J1D7udWG1etyMPVrWPJW0qLzK38zRKHXS8P1Eo/ZHVF8ZLqbzj1cPFMkeEACQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6368
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Dan Carpenter <dan.carpenter@oracle.com>
> Sent: Monday, November 16, 2020 3:25 AM
> To: kbuild@lists.01.org; Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Cc: lkp@intel.com; Dan Carpenter <error27@gmail.com>; kbuild-
> all@lists.01.org; linux-kernel@vger.kernel.org; Leo Li <leoyang.li@nxp.co=
m>;
> Timur Tabi <timur@kernel.org>
> Subject: drivers/net/ethernet/freescale/gianfar.c:580 gfar_parse_group()
> warn: 'grp->regs' not released on lines: 517.
>=20
> Hi Rasmus,
>=20
> First bad commit (maybe !=3D root cause):
>=20
> tree:
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit.k=
e
> rnel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftorvalds%2Flinux.git&a
> mp;data=3D04%7C01%7Cleoyang.li%40nxp.com%7Cfcd86334161e4c85f12408d8
> 8a11d649%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6374111565
> 08189838%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoi
> V2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DZvr6xt8Ew
> NKnUbBs1NMdnLf8xfeYbDGy1yASNs21pKU%3D&amp;reserved=3D0 master
> head:   f01c30de86f1047e9bae1b1b1417b0ce8dcd15b1
> commit: 5a35435ef4e6e4bd2aabd6706b146b298a9cffe5 soc: fsl: qe: remove
> PPC32 dependency from CONFIG_QUICC_ENGINE

It is strange that this driver is not related to the commit above.

> config: powerpc64-randconfig-m031-20201113 (attached as .config)
> compiler: powerpc64-linux-gcc (GCC) 9.3.0
>=20
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>=20
> smatch warnings:
> drivers/net/ethernet/freescale/gianfar.c:580 gfar_parse_group() warn: 'gr=
p-
> >regs' not released on lines: 517.
>=20
> vim +580 drivers/net/ethernet/freescale/gianfar.c
>=20
> 46ceb60ca80fa07 drivers/net/gianfar.c                    Sandeep Gopalpet=
 2009-11-
> 02  491  static int gfar_parse_group(struct device_node *np,
> 46ceb60ca80fa07 drivers/net/gianfar.c                    Sandeep Gopalpet=
 2009-11-
> 02  492  			    struct gfar_private *priv, const char *model)
> 46ceb60ca80fa07 drivers/net/gianfar.c                    Sandeep Gopalpet=
 2009-11-
> 02  493  {
> 5fedcc14d40e355 drivers/net/ethernet/freescale/gianfar.c Claudiu Manoil
> 2013-01-29  494  	struct gfar_priv_grp *grp =3D &priv->gfargrp[priv-
> >num_grps];
> ee873fda3bec7c6 drivers/net/ethernet/freescale/gianfar.c Claudiu Manoil
> 2013-01-29  495  	int i;
> ee873fda3bec7c6 drivers/net/ethernet/freescale/gianfar.c Claudiu Manoil
> 2013-01-29  496
> ee873fda3bec7c6 drivers/net/ethernet/freescale/gianfar.c Claudiu Manoil
> 2013-01-29  497  	for (i =3D 0; i < GFAR_NUM_IRQS; i++) {
> ee873fda3bec7c6 drivers/net/ethernet/freescale/gianfar.c Claudiu Manoil
> 2013-01-29  498  		grp->irqinfo[i] =3D kzalloc(sizeof(struct
> gfar_irqinfo),
> ee873fda3bec7c6 drivers/net/ethernet/freescale/gianfar.c Claudiu Manoil
> 2013-01-29  499  					  GFP_KERNEL);
> ee873fda3bec7c6 drivers/net/ethernet/freescale/gianfar.c Claudiu Manoil
> 2013-01-29  500  		if (!grp->irqinfo[i])
> ee873fda3bec7c6 drivers/net/ethernet/freescale/gianfar.c Claudiu Manoil
> 2013-01-29  501  			return -ENOMEM;
> ee873fda3bec7c6 drivers/net/ethernet/freescale/gianfar.c Claudiu Manoil
> 2013-01-29  502  	}
> 46ceb60ca80fa07 drivers/net/gianfar.c                    Sandeep Gopalpet=
 2009-11-
> 02  503
> 5fedcc14d40e355 drivers/net/ethernet/freescale/gianfar.c Claudiu Manoil
> 2013-01-29  504  	grp->regs =3D of_iomap(np, 0);
>                                                                          =
                                   ^^^^^^^^^^^^^^^
>=20
> 5fedcc14d40e355 drivers/net/ethernet/freescale/gianfar.c Claudiu Manoil
> 2013-01-29  505  	if (!grp->regs)
> 46ceb60ca80fa07 drivers/net/gianfar.c                    Sandeep Gopalpet=
 2009-11-
> 02  506  		return -ENOMEM;
> 46ceb60ca80fa07 drivers/net/gianfar.c                    Sandeep Gopalpet=
 2009-11-
> 02  507
> ee873fda3bec7c6 drivers/net/ethernet/freescale/gianfar.c Claudiu Manoil
> 2013-01-29  508  	gfar_irq(grp, TX)->irq =3D irq_of_parse_and_map(np,
> 0);
> 46ceb60ca80fa07 drivers/net/gianfar.c                    Sandeep Gopalpet=
 2009-11-
> 02  509
> 46ceb60ca80fa07 drivers/net/gianfar.c                    Sandeep Gopalpet=
 2009-11-
> 02  510  	/* If we aren't the FEC we have multiple interrupts */
> 46ceb60ca80fa07 drivers/net/gianfar.c                    Sandeep Gopalpet=
 2009-11-
> 02  511  	if (model && strcasecmp(model, "FEC")) {
> ee873fda3bec7c6 drivers/net/ethernet/freescale/gianfar.c Claudiu Manoil
> 2013-01-29  512  		gfar_irq(grp, RX)->irq =3D
> irq_of_parse_and_map(np, 1);
> ee873fda3bec7c6 drivers/net/ethernet/freescale/gianfar.c Claudiu Manoil
> 2013-01-29  513  		gfar_irq(grp, ER)->irq =3D
> irq_of_parse_and_map(np, 2);
> fea0f6650979a4f drivers/net/ethernet/freescale/gianfar.c Mark Brown
> 2015-11-26  514  		if (!gfar_irq(grp, TX)->irq ||
> fea0f6650979a4f drivers/net/ethernet/freescale/gianfar.c Mark Brown
> 2015-11-26  515  		    !gfar_irq(grp, RX)->irq ||
> fea0f6650979a4f drivers/net/ethernet/freescale/gianfar.c Mark Brown
> 2015-11-26  516  		    !gfar_irq(grp, ER)->irq)
> 46ceb60ca80fa07 drivers/net/gianfar.c                    Sandeep Gopalpet=
 2009-11-
> 02  517  			return -EINVAL;
>=20
> This should unmap "grp->regs".

This variable is unmapped in the caller with a wholesale cleanup function u=
nmap_group_regs().  Probably a false positive for smatch?

>=20
> 46ceb60ca80fa07 drivers/net/gianfar.c                    Sandeep Gopalpet=
 2009-11-
> 02  518  	}
> 46ceb60ca80fa07 drivers/net/gianfar.c                    Sandeep Gopalpet=
 2009-11-
> 02  519
> 5fedcc14d40e355 drivers/net/ethernet/freescale/gianfar.c Claudiu Manoil
> 2013-01-29  520  	grp->priv =3D priv;
> 5fedcc14d40e355 drivers/net/ethernet/freescale/gianfar.c Claudiu Manoil
> 2013-01-29  521  	spin_lock_init(&grp->grplock);
> 46ceb60ca80fa07 drivers/net/gianfar.c                    Sandeep Gopalpet=
 2009-11-
> 02  522  	if (priv->mode =3D=3D MQ_MG_MODE) {
> 559176415cc663f drivers/net/ethernet/freescale/gianfar.c Jingchang Lu
> 2015-03-13  523  		u32 rxq_mask, txq_mask;
> 559176415cc663f drivers/net/ethernet/freescale/gianfar.c Jingchang Lu
> 2015-03-13  524  		int ret;
> 71ff9e3df7e1c5d drivers/net/ethernet/freescale/gianfar.c Claudiu Manoil
> 2014-03-07  525
> 71ff9e3df7e1c5d drivers/net/ethernet/freescale/gianfar.c Claudiu Manoil
> 2014-03-07  526  		grp->rx_bit_map =3D (DEFAULT_MAPPING >>
> priv->num_grps);
> 71ff9e3df7e1c5d drivers/net/ethernet/freescale/gianfar.c Claudiu Manoil
> 2014-03-07  527  		grp->tx_bit_map =3D (DEFAULT_MAPPING >>
> priv->num_grps);
> 559176415cc663f drivers/net/ethernet/freescale/gianfar.c Jingchang Lu
> 2015-03-13  528
> 559176415cc663f drivers/net/ethernet/freescale/gianfar.c Jingchang Lu
> 2015-03-13  529  		ret =3D of_property_read_u32(np, "fsl,rx-bit-
> map", &rxq_mask);
> 559176415cc663f drivers/net/ethernet/freescale/gianfar.c Jingchang Lu
> 2015-03-13  530  		if (!ret) {
> 71ff9e3df7e1c5d drivers/net/ethernet/freescale/gianfar.c Claudiu Manoil
> 2014-03-07  531  			grp->rx_bit_map =3D rxq_mask ?
> 559176415cc663f drivers/net/ethernet/freescale/gianfar.c Jingchang Lu
> 2015-03-13  532  			rxq_mask : (DEFAULT_MAPPING >>
> priv->num_grps);
> 559176415cc663f drivers/net/ethernet/freescale/gianfar.c Jingchang Lu
> 2015-03-13  533  		}
> 559176415cc663f drivers/net/ethernet/freescale/gianfar.c Jingchang Lu
> 2015-03-13  534
> 559176415cc663f drivers/net/ethernet/freescale/gianfar.c Jingchang Lu
> 2015-03-13  535  		ret =3D of_property_read_u32(np, "fsl,tx-bit-
> map", &txq_mask);
> 559176415cc663f drivers/net/ethernet/freescale/gianfar.c Jingchang Lu
> 2015-03-13  536  		if (!ret) {
> 71ff9e3df7e1c5d drivers/net/ethernet/freescale/gianfar.c Claudiu Manoil
> 2014-03-07  537  			grp->tx_bit_map =3D txq_mask ?
> 559176415cc663f drivers/net/ethernet/freescale/gianfar.c Jingchang Lu
> 2015-03-13  538  			txq_mask : (DEFAULT_MAPPING >>
> priv->num_grps);
> 559176415cc663f drivers/net/ethernet/freescale/gianfar.c Jingchang Lu
> 2015-03-13  539  		}
> 559176415cc663f drivers/net/ethernet/freescale/gianfar.c Jingchang Lu
> 2015-03-13  540
> 559176415cc663f drivers/net/ethernet/freescale/gianfar.c Jingchang Lu
> 2015-03-13  541  		if (priv->poll_mode =3D=3D GFAR_SQ_POLLING) {
> 559176415cc663f drivers/net/ethernet/freescale/gianfar.c Jingchang Lu
> 2015-03-13  542  			/* One Q per interrupt group: Q0 to
> G0, Q1 to G1 */
> 559176415cc663f drivers/net/ethernet/freescale/gianfar.c Jingchang Lu
> 2015-03-13  543  			grp->rx_bit_map =3D
> (DEFAULT_MAPPING >> priv->num_grps);
> 559176415cc663f drivers/net/ethernet/freescale/gianfar.c Jingchang Lu
> 2015-03-13  544  			grp->tx_bit_map =3D
> (DEFAULT_MAPPING >> priv->num_grps);
> 71ff9e3df7e1c5d drivers/net/ethernet/freescale/gianfar.c Claudiu Manoil
> 2014-03-07  545  		}
> 46ceb60ca80fa07 drivers/net/gianfar.c                    Sandeep Gopalpet=
 2009-11-
> 02  546  	} else {
> 5fedcc14d40e355 drivers/net/ethernet/freescale/gianfar.c Claudiu Manoil
> 2013-01-29  547  		grp->rx_bit_map =3D 0xFF;
> 5fedcc14d40e355 drivers/net/ethernet/freescale/gianfar.c Claudiu Manoil
> 2013-01-29  548  		grp->tx_bit_map =3D 0xFF;
> 46ceb60ca80fa07 drivers/net/gianfar.c                    Sandeep Gopalpet=
 2009-11-
> 02  549  	}
> 208627883ecfaa1 drivers/net/ethernet/freescale/gianfar.c Claudiu Manoil
> 2014-02-17  550
> 208627883ecfaa1 drivers/net/ethernet/freescale/gianfar.c Claudiu Manoil
> 2014-02-17  551  	/* bit_map's MSB is q0 (from q0 to q7) but,
> for_each_set_bit parses
> 208627883ecfaa1 drivers/net/ethernet/freescale/gianfar.c Claudiu Manoil
> 2014-02-17  552  	 * right to left, so we need to revert the 8 bits to ge=
t
> the q index
> 208627883ecfaa1 drivers/net/ethernet/freescale/gianfar.c Claudiu Manoil
> 2014-02-17  553  	 */
> 208627883ecfaa1 drivers/net/ethernet/freescale/gianfar.c Claudiu Manoil
> 2014-02-17  554  	grp->rx_bit_map =3D bitrev8(grp->rx_bit_map);
> 208627883ecfaa1 drivers/net/ethernet/freescale/gianfar.c Claudiu Manoil
> 2014-02-17  555  	grp->tx_bit_map =3D bitrev8(grp->tx_bit_map);
> 208627883ecfaa1 drivers/net/ethernet/freescale/gianfar.c Claudiu Manoil
> 2014-02-17  556
> 208627883ecfaa1 drivers/net/ethernet/freescale/gianfar.c Claudiu Manoil
> 2014-02-17  557  	/* Calculate RSTAT, TSTAT, RQUEUE and TQUEUE
> values,
> 208627883ecfaa1 drivers/net/ethernet/freescale/gianfar.c Claudiu Manoil
> 2014-02-17  558  	 * also assign queues to groups
> 208627883ecfaa1 drivers/net/ethernet/freescale/gianfar.c Claudiu Manoil
> 2014-02-17  559  	 */
> 208627883ecfaa1 drivers/net/ethernet/freescale/gianfar.c Claudiu Manoil
> 2014-02-17  560  	for_each_set_bit(i, &grp->rx_bit_map, priv-
> >num_rx_queues) {
> 71ff9e3df7e1c5d drivers/net/ethernet/freescale/gianfar.c Claudiu Manoil
> 2014-03-07  561  		if (!grp->rx_queue)
> 71ff9e3df7e1c5d drivers/net/ethernet/freescale/gianfar.c Claudiu Manoil
> 2014-03-07  562  			grp->rx_queue =3D priv->rx_queue[i];
> 208627883ecfaa1 drivers/net/ethernet/freescale/gianfar.c Claudiu Manoil
> 2014-02-17  563  		grp->num_rx_queues++;
> 208627883ecfaa1 drivers/net/ethernet/freescale/gianfar.c Claudiu Manoil
> 2014-02-17  564  		grp->rstat |=3D (RSTAT_CLEAR_RHALT >> i);
> 208627883ecfaa1 drivers/net/ethernet/freescale/gianfar.c Claudiu Manoil
> 2014-02-17  565  		priv->rqueue |=3D ((RQUEUE_EN0 |
> RQUEUE_EX0) >> i);
> 208627883ecfaa1 drivers/net/ethernet/freescale/gianfar.c Claudiu Manoil
> 2014-02-17  566  		priv->rx_queue[i]->grp =3D grp;
> 208627883ecfaa1 drivers/net/ethernet/freescale/gianfar.c Claudiu Manoil
> 2014-02-17  567  	}
> 208627883ecfaa1 drivers/net/ethernet/freescale/gianfar.c Claudiu Manoil
> 2014-02-17  568
> 208627883ecfaa1 drivers/net/ethernet/freescale/gianfar.c Claudiu Manoil
> 2014-02-17  569  	for_each_set_bit(i, &grp->tx_bit_map, priv-
> >num_tx_queues) {
> 71ff9e3df7e1c5d drivers/net/ethernet/freescale/gianfar.c Claudiu Manoil
> 2014-03-07  570  		if (!grp->tx_queue)
> 71ff9e3df7e1c5d drivers/net/ethernet/freescale/gianfar.c Claudiu Manoil
> 2014-03-07  571  			grp->tx_queue =3D priv->tx_queue[i];
> 208627883ecfaa1 drivers/net/ethernet/freescale/gianfar.c Claudiu Manoil
> 2014-02-17  572  		grp->num_tx_queues++;
> 208627883ecfaa1 drivers/net/ethernet/freescale/gianfar.c Claudiu Manoil
> 2014-02-17  573  		grp->tstat |=3D (TSTAT_CLEAR_THALT >> i);
> 208627883ecfaa1 drivers/net/ethernet/freescale/gianfar.c Claudiu Manoil
> 2014-02-17  574  		priv->tqueue |=3D (TQUEUE_EN0 >> i);
> 208627883ecfaa1 drivers/net/ethernet/freescale/gianfar.c Claudiu Manoil
> 2014-02-17  575  		priv->tx_queue[i]->grp =3D grp;
> 208627883ecfaa1 drivers/net/ethernet/freescale/gianfar.c Claudiu Manoil
> 2014-02-17  576  	}
> 208627883ecfaa1 drivers/net/ethernet/freescale/gianfar.c Claudiu Manoil
> 2014-02-17  577
> 46ceb60ca80fa07 drivers/net/gianfar.c                    Sandeep Gopalpet=
 2009-11-
> 02  578  	priv->num_grps++;
> 46ceb60ca80fa07 drivers/net/gianfar.c                    Sandeep Gopalpet=
 2009-11-
> 02  579
> 46ceb60ca80fa07 drivers/net/gianfar.c                    Sandeep Gopalpet=
 2009-11-
> 02 @580  	return 0;
> 46ceb60ca80fa07 drivers/net/gianfar.c                    Sandeep Gopalpet=
 2009-11-
> 02  581  }
>=20
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists=
.0
> 1.org%2Fhyperkitty%2Flist%2Fkbuild-
> all%40lists.01.org&amp;data=3D04%7C01%7Cleoyang.li%40nxp.com%7Cfcd8633
> 4161e4c85f12408d88a11d649%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%
> 7C0%7C637411156508189838%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4
> wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&a
> mp;sdata=3DLD7l%2FaKN%2FrmZp3Z21TzF1vP1B92fMJ48st55fTdLbx4%3D&amp
> ;reserved=3D0

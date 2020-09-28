Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7743527AB89
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 12:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbgI1KLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 06:11:03 -0400
Received: from mail-eopbgr20043.outbound.protection.outlook.com ([40.107.2.43]:43146
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726328AbgI1KLD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 06:11:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cYz/eO39IITRdkh9xQYSzQShXXSU9blvJ2U6AZddHQ5S7c14tiJNz0RS9ddNqf4NEJK5xhuLmmCOLrxw5O1e6pNyYAyk+gmOsIB9fzWszvjgQ585vihC7/uta/YFNM+ifChlEbSJgRJPkeE5cY15ptmLSQZi/KV+oh394YQAoQrkBV9WnoYEZ4QolxRXGmCci29XMQPl+ALXkAJvfL4mOO8aHxRYWevUX5A5JVr0Zjb61ZdGGXPmHN7Y3Cjr01IidrdbtPw2cnSFozABq5JVqAjAx+FEvC0KemmYuRMyTGEUroQik9Ru4n/LbO682PhgXapQqkQpFUrwenpjLOn2BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iXHbyfw4KL8WziptAawZ3rb0HTbjW/qo3X/hfu1M79M=;
 b=aBfryL4Rojh267KxHIqhpuoKLOnffXvqBmmo3yZs1FQN0DPSISGWpzMhqPgoENQ5n2Kp6WnQ5SUbr8swZ6hbhDrOG8YggxKIjDQsVXJzibbhL+NI+JvKVSDojq1OPfKTZB6cAbQS4VRBgTi3yZcwBjvTkGcZQtzj4svyb8nXCsBSxeMpb47Uaszd61bjdUcGnvfMWBlUXO8vMuRCdwR6b6p6viXe5fGBVQP4Wed+b/QjpnKfN/6iNGcHgzvzeEyz1JksR4NlIYUu9kt7TBIwR/cAuK5hPMh4xdJKCKOP30OO4w7h7scneRYDC+V6ADc30X/cnoFAESiTkydY0Lbvdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iXHbyfw4KL8WziptAawZ3rb0HTbjW/qo3X/hfu1M79M=;
 b=iJJNiWGLWU3nZOsI5zzgAjKy4dnN0SFRqM97NyGV4G7PUq4H/FO4j3MwtS+DyMcYH6E9w+HsYk1dIbn7CEfsFMP7CwrYpMxdBN7MItngRldShkaHN++6VEbHts4BALVIrojPqcNOK6qu9f1eldudqsLQYFcqdBQfsV2IvRLlIsI=
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com (2603:10a6:803:57::21)
 by VE1PR04MB7421.eurprd04.prod.outlook.com (2603:10a6:800:1b3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22; Mon, 28 Sep
 2020 10:10:58 +0000
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b178:a37b:1f9e:3a6]) by VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b178:a37b:1f9e:3a6%3]) with mapi id 15.20.3412.029; Mon, 28 Sep 2020
 10:10:58 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     "sudeep.dutt@intel.com" <sudeep.dutt@intel.com>,
        "ashutosh.dixit@intel.com" <ashutosh.dixit@intel.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "wang.yi59@zte.com.cn" <wang.yi59@zte.com.cn>,
        "huang.zijiang@zte.com.cn" <huang.zijiang@zte.com.cn>,
        "rikard.falkeborn@gmail.com" <rikard.falkeborn@gmail.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "mst@redhat.com" <mst@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 1/5] misc: vop: change the way of allocating vring for
 noncoherent platform
Thread-Topic: [PATCH 1/5] misc: vop: change the way of allocating vring for
 noncoherent platform
Thread-Index: AQHWkw1Ua/wMKuww70uQvYAscuCr2al6jTyAgAGOkqCAAXnSAIAAP/9g
Date:   Mon, 28 Sep 2020 10:10:58 +0000
Message-ID: <VI1PR04MB496062A92DF661738F274A7292350@VI1PR04MB4960.eurprd04.prod.outlook.com>
References: <20200925072630.8157-1-sherry.sun@nxp.com>
 <20200925072630.8157-2-sherry.sun@nxp.com>
 <20200926075015.GA18592@infradead.org>
 <VI1PR04MB4960DC1E64D65634FE76C7AA92340@VI1PR04MB4960.eurprd04.prod.outlook.com>
 <20200928060904.GA9387@infradead.org>
In-Reply-To: <20200928060904.GA9387@infradead.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f45f8aec-4195-42fa-2206-08d86396cba8
x-ms-traffictypediagnostic: VE1PR04MB7421:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VE1PR04MB7421330D6987FBF58314955892350@VE1PR04MB7421.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jl/zyO3VAyAPILoRzH+dHNpmoDQuN1JoLsDSlZ7HDt6aljvVcZGBJHP5PWiz0K3DbpK/0HRCaiL93T3NpL+RYhRAJ41dH73XXPtwvCt8mA2xc+97QyWFV9hyKXV8OEZ/8vGHg2T+YGIzZM4Dc6lhR05ESUuq8j9m27v18MV1kBtHHZhtBbHaZOu64585UPifjZAcZnl65SwotgbXvyphgsckvFZPjTNWj3+MFeWqMALFRW7U8otsSO0/KoZ7lyeo7w3APyGDcvi2O6o+jEUSGfR5GZauRfqZUvp6UDtQ+sDOuMKoSUEXRmv5ai007RLJC/nolvLHl2bQGbVgHkxPo5tuQ4Ar31oPRiT8HHnPGCmxBzCYs8Y7P6OIhN6fAgcD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4960.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(26005)(71200400001)(6506007)(498600001)(55016002)(186003)(44832011)(5660300002)(76116006)(52536014)(33656002)(66476007)(66556008)(66946007)(7696005)(83380400001)(6916009)(64756008)(66446008)(7416002)(2906002)(4326008)(9686003)(54906003)(86362001)(8676002)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 2uw8vmgRHyq0+SC/6E7T6zcJTKSENVSIufAgrAhzz8eT8SzvON0nSH6brnzQlKfNnOdhTEepoKkLXDPXK9iheD9S4AdrAVrBbMJ0bvxVftjNQEVIcEeCnE1yNeDRInwoV7CDA5OmHdZeAfMCgDv31yt/X34RAFLcisNYY72RUbAd5GWw31za8PDNhT+LB8Ri58O7MFOGr19jWv0c0tOjgCbu6BLUO2EH7DA14bYfNMJL32ccxgl8myHP40BAiYsWT45muukA1utXFl97peEjzwbdbwLFzUjMk4LB7hPceGzosJ/WLFpKyOvBr0wamyWERmEMOOyOepY8kqy8pSyKnwAaO9j4Ar2X11zExr/EqHtE8hMBiRvBjUdrD6xE6KLqfCJfbcdqOW87kdTg96G68cYQbtaNolJ2EtnN5u6mNo2FHINuvG9UF+eGS87GUnObDmzBOwu48HtPF1lYlbWRVLrXFkmChrt6unqqLzga9WzE4XRm9W2zhW1gWJpzZs7Cu8jQB2O5/DssGuGrRthYzYlWhYBddPhObkrrKYwB5GgnaP+WAsNGWWQlL9Yf3tF/0Y2SqSCrpXDj4MObDGhcy+mimMLe694M1ZolwVlxZewJXiB9MmJBF9VMaq6gY4uWdQ7i3+6c00rhV3ZaN624xA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4960.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f45f8aec-4195-42fa-2206-08d86396cba8
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2020 10:10:58.5063
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RtfQjmGnvO6iFJLFLRG18TlnCg6qMWR6xhnzxzjs5YlGzI+raScZS03Bc9aEZ1J3a6bMn2RTHJNbHAFScaSNQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7421
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

> On Sun, Sep 27, 2020 at 07:58:29AM +0000, Sherry Sun wrote:
> > Thanks for your reply.
> > Can you explain why we cannot use the API and header above in drivers?
> > And do you know if there are any APIs that could replace this to check =
the
> device hardware dma coherent support?
>=20
> If your treat the memory as if it is coherent with device access you shou=
ld
> always use dma_alloc_coherent.  The whole point of the DMA API is to
> abstract such differences away.

Well, for vring and device pages in vop driver, dma coherent memory maybe m=
ore reasonable.
Will use dma_alloc_coherent to replace the orginal memory allocate method i=
n V2.

>=20
> > >
> > > > +			vdev->vvr[i].vrh.vring.used =3D
> > > > +				(void __force *)vpdev->hw_ops->remap(
> > >
> > > And you must not use __force casts without a comment explanation why
> > > they are safe.
> >
> > Here is the original code, I moved the original code into the if() with=
out
> change it.
> > But I think  this is because vpdev->hw_ops->remap() return type is void
> __iomem *, but vring.used need type void *.
> > Maybe this is a workaround for Intel MIC platform, as it reassigns the =
used
> ring on the EP side.
>=20
> Well, we'll need to figure out what is going on here, and blind casts to =
and
> from __iomem are dangerous.

Yes, you are right.=20

Regards
Sherry

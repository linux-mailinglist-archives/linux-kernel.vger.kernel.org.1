Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD6BB2EC825
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 03:37:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbhAGChc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 6 Jan 2021 21:37:32 -0500
Received: from mail-eopbgr1300091.outbound.protection.outlook.com ([40.107.130.91]:35838
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726687AbhAGChb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 21:37:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RpD5liAk095yLPxK2T4kCRBImOfsW+3gFQ7vK6N1OYP2syUOVBzSbzLnNub009K6AgK7V0tFzUL0bdUf4lggds4Vtfla7s5bMjNh4FGviDMFhebN/+eO68a91mXCzx9TttU63lN1Aog7699P0PFiriy3SfbuPOHRPx4JmMK2mWPBktRvYS+D2YzyeeTTgdRRca+A+vG1x8NYXi2xu9qmrKAElOBbdqMgM1fmPQHcAdPUTkdwd5nuYvpMyh/jIVSepMwNJVZI6xWc/scpm/LPJb9LTqX3FYeuDYDlmDO2p3vXJ0DF+6S0Wd7ThGNQ7isYqgMxa298HgZN6Jvt32i53g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/PjrzBT2z9im296jXVBbhYJe7Oft6hi+Xam1CoRgfxw=;
 b=aJK2QBhBt4QL9ejnZa6nKrjv08CfD2+Rq3zIn2TfL5uv5sCrEaw5ApsZtUxYM0ZvJkBctg7x3fs52ii7P2dVAadsgTpNGQhDrwjUnTP9GqkRZujuffne5dKsu0CXWNCx5ctNfDRxB2FXbvw41WKsew4gjGWgsSqw1RRPakb6VimvsgjOR85CcKXVUrSjGx36PGYIS0SLmdDZFylVO19+JfMJ7uOXtjLO5dWzUTxFg57O1TUfFuEfQh2yGL6Lq/Gfge+esie2Dw0qD7jdXY3um9qT8MrG8/IJQTUMB2DIigtwJMvL8ci4XRWlsSJ9Ju055DB0oVsvSWsE3g90iC6wkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
Received: from HK0PR06MB3779.apcprd06.prod.outlook.com (2603:1096:203:b8::10)
 by HK0PR06MB2819.apcprd06.prod.outlook.com (2603:1096:203:30::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.20; Thu, 7 Jan
 2021 02:35:55 +0000
Received: from HK0PR06MB3779.apcprd06.prod.outlook.com
 ([fe80::7061:73d9:50ae:b35e]) by HK0PR06MB3779.apcprd06.prod.outlook.com
 ([fe80::7061:73d9:50ae:b35e%7]) with mapi id 15.20.3721.024; Thu, 7 Jan 2021
 02:35:55 +0000
From:   ChiaWei Wang <chiawei_wang@aspeedtech.com>
To:     Rob Herring <robh@kernel.org>
CC:     "joel@jms.id.au" <joel@jms.id.au>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "maz@kernel.org" <maz@kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        BMC-SW <BMC-SW@aspeedtech.com>
Subject: RE: [PATCH 5/6] soc: aspeed: Add eSPI driver
Thread-Topic: [PATCH 5/6] soc: aspeed: Add eSPI driver
Thread-Index: AQHW4/EGoESQVzUaJEaOOPEvbJ+dwKoaukYAgAC4MiA=
Date:   Thu, 7 Jan 2021 02:35:55 +0000
Message-ID: <HK0PR06MB377987E19F57E53CC4F32FF991AF0@HK0PR06MB3779.apcprd06.prod.outlook.com>
References: <20210106055939.19386-1-chiawei_wang@aspeedtech.com>
 <20210106055939.19386-6-chiawei_wang@aspeedtech.com>
 <20210106153202.GA2258036@robh.at.kernel.org>
In-Reply-To: <20210106153202.GA2258036@robh.at.kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=aspeedtech.com;
x-originating-ip: [211.20.114.70]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f884026d-687f-48f1-c7f3-08d8b2b4f590
x-ms-traffictypediagnostic: HK0PR06MB2819:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HK0PR06MB2819B9BDBD331F87D863723A91AF0@HK0PR06MB2819.apcprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XvKta+2Yf8s1UBBeUHLlOhEC9ScPW4m4YL6jM7ay+EPglCITYNlhFqN5c7kcwkOkme0mtkKaaQdfMLh/C+sWciZu6wphl3oMjHgtTG+jxC6JG6IlFCveXCOqTBs+sOSOZ22RWbQJLx1OdPD7RQnj4BXlD/26nwVrwfNkzKaLT6KPQfMQFBxwgGJ1ShgT36R3RUE69SrFuKFfYn+wmg2Os9iW7bzhDrVWGi5q6RZtQ8pZqxz0vm9BV+7ASYLiK9Wv8pxOzy8CM53eB/mFm89h1mlM60Sx5wV0jvu7CKUC1AdsjCLZ4GOvyTY7KZCPUaYeo2YyRDLBgmKrWwip+YB6BBgD2ZXqi2NEuRygc0N0lwHdqFYABS+Qc8IUqFWZY28x408fcFu4EfieOMR+pf9GgQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3779.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(39840400004)(346002)(376002)(366004)(54906003)(66476007)(71200400001)(66446008)(66556008)(66946007)(64756008)(83380400001)(33656002)(478600001)(76116006)(55016002)(86362001)(9686003)(7416002)(6916009)(8936002)(52536014)(107886003)(26005)(6506007)(186003)(316002)(8676002)(53546011)(55236004)(2906002)(7696005)(5660300002)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?prWSocsdHj/06c4eASnPIWHRhQ+2mcCz+CkFZ7ocdpZQD5PLpXzu53B5SXol?=
 =?us-ascii?Q?NQECg1f3Ygnsv/84OwacJIFbvEbu4VahglGbDqvsP6MFr3SjPO4dGQ2BTMqM?=
 =?us-ascii?Q?CCopEiUaBKZLs1UB9WH5zV+cKcXh71GHjOO2f5a6d4C+oevBbUypV7o1VDEn?=
 =?us-ascii?Q?1BVVvUDCo12p3FjcUwLFo7udfv92UsXlzBvbR3pAK+2MO9OTmd2Z8cTZIBkJ?=
 =?us-ascii?Q?LmoIWA2y5D+oaTF0xo5kp2ml7nPW//cg2SFUzJ+7gs8KKWm6CzeiEZ/IOMWI?=
 =?us-ascii?Q?4QBsHsqeZnDc3biHHgr5Fa6jH1GbCkhPy7SLyY/dffr7iiLKyGszK8Ymm5Ya?=
 =?us-ascii?Q?B4DkMecgdOQ7UM0jkOsallnzJKi9WQfWtTmAlrn0CZ85SWV7ELhBrDn3bdEC?=
 =?us-ascii?Q?tvlj0OTqJwvve9scSLtKEzVKdWToY5d3255hFDB06rBWDG9Cf88QnoiUxFjc?=
 =?us-ascii?Q?Kt92Pran4mBRL7lgl7d1IpqV5dpyQYHYwNlHZfGLWHdKL6x9YBj5qkYEi93u?=
 =?us-ascii?Q?JPy84gYTImuxbVcPlxpefGpdMvAgOCqQtVoWr4/kmV/qte5JK9LAzhJishVH?=
 =?us-ascii?Q?lRsRjnzVhjxDjWR5PS50Ol1DSGwnxV3gawctPzyuYk2gG021x+BFn4RORlI/?=
 =?us-ascii?Q?NVoorC6yd3oa8icWTUqyltYV+0KypUCkpFUnUQuROW1YJGguWTq/4NzR2O9v?=
 =?us-ascii?Q?FnJd0ELIVili6VwPP/6+N0UmbZt1vlpNcpqVvbdbnZ7K05F+SCHcfta0ggjx?=
 =?us-ascii?Q?cJl28zZwHg0SKlzl9V5thU+ImuvdA0Ltxp+koDum6j3/V3AwxpcmyrWrQnng?=
 =?us-ascii?Q?9IPIdtUsik4CMwZvGGkdd0xYEHa3jSYXXLBDcfRGwbbnZW3BH4seS9E6Q4A9?=
 =?us-ascii?Q?Ah2vV69tEKgDk6Dk8Ii8HIqjwM0bD8Y/BX5bSi/hjM1E751lxB9BWWWnkFna?=
 =?us-ascii?Q?7xRQaZEoIrbkEF3Fm8Zrsj/THJsDGqLrEql3Hm53f+8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3779.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f884026d-687f-48f1-c7f3-08d8b2b4f590
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2021 02:35:55.5429
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PRQ11b0V11Z021sUdojzkyBQWhahI2Jm3Bit/AePw5LyaeYZXh6uJV7u/Of4kbTBX683GlQQtTOfGzRJdxgnaevYdsDgN99cE67CoOYFyPE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR06MB2819
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Wednesday, January 6, 2021 11:32 PM
> To: ChiaWei Wang <chiawei_wang@aspeedtech.com>
> Subject: Re: [PATCH 5/6] soc: aspeed: Add eSPI driver
> 
> On Wed, Jan 06, 2021 at 01:59:38PM +0800, Chia-Wei, Wang wrote:
> > The Aspeed eSPI controller is slave device to communicate with the
> > master through the Enhanced Serial Peripheral Interface (eSPI).
> > All of the four eSPI channels, namely peripheral, virtual wire,
> > out-of-band, and flash are supported.
> >
> > Signed-off-by: Chia-Wei, Wang <chiawei_wang@aspeedtech.com>
> > ---
> >  drivers/soc/aspeed/Kconfig                  |  49 ++
> >  drivers/soc/aspeed/Makefile                 |   5 +
> >  drivers/soc/aspeed/aspeed-espi-ctrl.c       | 197 ++++++
> >  drivers/soc/aspeed/aspeed-espi-flash.c      | 490 ++++++++++++++
> >  drivers/soc/aspeed/aspeed-espi-oob.c        | 706
> ++++++++++++++++++++
> >  drivers/soc/aspeed/aspeed-espi-peripheral.c | 613 +++++++++++++++++
> >  drivers/soc/aspeed/aspeed-espi-vw.c         | 211 ++++++
> >  include/uapi/linux/aspeed-espi.h            | 160 +++++
> >  8 files changed, 2431 insertions(+)
> >  create mode 100644 drivers/soc/aspeed/aspeed-espi-ctrl.c
> >  create mode 100644 drivers/soc/aspeed/aspeed-espi-flash.c
> >  create mode 100644 drivers/soc/aspeed/aspeed-espi-oob.c
> >  create mode 100644 drivers/soc/aspeed/aspeed-espi-peripheral.c
> >  create mode 100644 drivers/soc/aspeed/aspeed-espi-vw.c
> 
> drivers/spi/ is the correct location for a SPI controller.
> 
> >  create mode 100644 include/uapi/linux/aspeed-espi.h
> 
> This userspace interface is not going to be accepted upstream.
> 
> I'd suggest you look at similar SPI flash capable SPI controller drivers upstream
> and model your driver after them. This looks like it needs major reworking.
> 
eSPI resues the timing and electrical specification of SPI but runs completely different protocol.
Only the flash channel is related to SPI and the other 3 channels are for EC/BMC/SIO.
Therefore, an eSPI driver might not fit into the SPI model.

Chiawei

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A80252AEE43
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 10:56:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbgKKJ46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 04:56:58 -0500
Received: from mail-bn8nam12on2084.outbound.protection.outlook.com ([40.107.237.84]:36416
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726024AbgKKJ4y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 04:56:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eNu0kZnoALHrErfLDXKVzUQoJ7Fn9go3ObncOS1r73sUzJAKnF5cn+9VYQgCJXJuESvrMEPFoPxKUOSTTy3cOaSI1hC7ibLcXKh4okvBigfvia9NYC+rD+oiS7GjmcU8vTqECDedeLI1zhTxmJ41W6U2kGem4i6Yihgah+1SWeFg6e6ZkqkNx14xAaDlwwJMT51x73n/MdwMcj5Ov38dqE8IJ9m7J94RpFqLLd0fLNx2Bfl49qujuX3ttwwgfep+rLS5hIMvDPwF+2gMT93PK+9crBfAfhH8XJlpnXzAFwYN5rweDsIlSkO2hNm/fHdqxX6KOnsUsZEW10UX5hE94Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cmSv//ndwHZGGFNKJLiWw64enTOe77gWB5Jm50o6kAU=;
 b=lo/zYk6sZogHlZmSUir0oPfqJQa88UfYUcnMcqWC0KDNE5KtsoqLuXhAdtXP3GC0ngGaPWQA1+FVF+oZZAPAA1aDsP4iS5QGjC6DdKOo5xDePsGSsPGM4J6jjOW630VTh/yrjsWnvdd3wP2Cocq6ykpQ7Jc5vKi3sn7/koTioJd4f8UllO8N24ljNLI5C4op43norFtyyjY1CXh7f2f2S0OfsX/ob3OK0cb0ildH0hcK+Ka2oOxjWmmG/vZxtpg2XFV4I2Rruw+F0m8r1doXSLnD9r3n+LpzBoC33OsbOix8To/PcWPGBzMhQEYxjEdhuGBq58gz2NguJGtV+DD9hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=openfive.com; dmarc=pass action=none header.from=openfive.com;
 dkim=pass header.d=openfive.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=osportal.onmicrosoft.com; s=selector2-osportal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cmSv//ndwHZGGFNKJLiWw64enTOe77gWB5Jm50o6kAU=;
 b=MchM3jtsqGDRdmSAeedyTO9NabgdGIXfRZSNbKdPvzQqVPFknK4W3fuQhOMFeVqQi6YSpN2SemV87QsvkHFiGLLgVloiC/Nz3dtsjIQhkFq7MCV2Y1JH4ud0CkWk223x82fAqMlIcrXD1EpqexWc8PY1lnT3zfS7g6uiGXYNiNQ=
Received: from MN2PR13MB2797.namprd13.prod.outlook.com (2603:10b6:208:f2::30)
 by MN2PR13MB4055.namprd13.prod.outlook.com (2603:10b6:208:261::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.14; Wed, 11 Nov
 2020 09:56:50 +0000
Received: from MN2PR13MB2797.namprd13.prod.outlook.com
 ([fe80::dcec:40d7:3fd6:308d]) by MN2PR13MB2797.namprd13.prod.outlook.com
 ([fe80::dcec:40d7:3fd6:308d%7]) with mapi id 15.20.3564.021; Wed, 11 Nov 2020
 09:56:49 +0000
From:   Pragnesh Patel <pragnesh.patel@openfive.com>
To:     Zong Li <zong.li@sifive.com>,
        "Paul Walmsley ( Sifive)" <paul.walmsley@sifive.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "schwab@linux-m68k.org" <schwab@linux-m68k.org>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        Yash Shah <yash.shah@openfive.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
CC:     Zong Li <zong.li@sifive.com>,
        "Henry Styles ( Sifive)" <hes@sifive.com>,
        Erik Danie <erik.danie@sifive.com>
Subject: RE: [PATCH v3 3/3] clk: sifive: Add a driver for the SiFive FU740
 PRCI IP block
Thread-Topic: [PATCH v3 3/3] clk: sifive: Add a driver for the SiFive FU740
 PRCI IP block
Thread-Index: AQHWuA3/FT10AOhipE6O6xDyJASfxqnCsTAw
Date:   Wed, 11 Nov 2020 09:56:49 +0000
Message-ID: <MN2PR13MB2797C7CA6356C5A125C83C6FEBE80@MN2PR13MB2797.namprd13.prod.outlook.com>
References: <20201111093514.103155-1-zong.li@sifive.com>
 <20201111093514.103155-4-zong.li@sifive.com>
In-Reply-To: <20201111093514.103155-4-zong.li@sifive.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: sifive.com; dkim=none (message not signed)
 header.d=none;sifive.com; dmarc=none action=none header.from=openfive.com;
x-originating-ip: [2405:204:8004:b7c5:51af:eea5:ce7c:81]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7e973519-9071-4e91-9a91-08d886281c07
x-ms-traffictypediagnostic: MN2PR13MB4055:
x-ld-processed: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR13MB405559F21EDE42801F5E463EEBE80@MN2PR13MB4055.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: get9OKFR/icvj3pIs6t1SzXt/XaBwVrbgoB4apBqoo78rFDxgcZY+8vEy24JZ80Dw4R4NNJvXyHag5FCGR+wkpfgE9Eg/y1B+pqFIG6ITbttbRkQ9MD2h3xDfHaZMZX7GeSNVLxI/7hFwxK4pJiVXIEqsMbJUqgKCLNG4l18vJILHIx4PJaMC4MV6PcBbyVtV16bxs3pXRiwAQigI732Jkb7kBLdFChEEOTwLOugub2fa4VNZ25T2sU3o0eG2h6jPqXxpUfWbTIuCqCpYctb0oicuIY3uRd9HfKSgQ2UINAHsA8r/0I12Ip5cacx6JCVi42eskFPx3ZmJXMroh2GAWcwtRjkKZwbVvsqRICH6k62wfJHxM466CqHUNF/g89H
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR13MB2797.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(6029001)(136003)(396003)(39840400004)(376002)(366004)(346002)(9686003)(71200400001)(83380400001)(5660300002)(110136005)(186003)(8676002)(107886003)(478600001)(6506007)(8936002)(33656002)(66946007)(66476007)(52536014)(7696005)(66556008)(316002)(76116006)(4326008)(44832011)(55016002)(66446008)(54906003)(64756008)(2906002)(86362001)(921003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 2kCBLmQewbtNmgpkMn9JsMlKQJJ1WZIfuSB+n+VQbaiJ9azv6gLrrQLGDjC5bxJrDXpyglAMSQrmzG1hgU+98Gibub/3p3tPhYy7IvFVVNxlbMbP7syICHN2VC1xhS/zvV8NJMDK8O2fCtUrYwOIvWw8cXWh4/CT8pXUc2YkUuVZI1lbQSEJHh41zqyLOkoHykgoBkhwo69I3YvxaNsY6yd5nh54dvqmBYolOg2rItsGMKT07tqNR35zkDlu66HaDiwEsxAWfY207fiRDPt9DY+4FoihokN5iKlew7t4cOGp0hsz2FCBgvjKPOASLJTKXP+V0w4/0wM0kA9UzFCVuQqrwFkSrEQTtuyC/XIY8w9jCjDHh+FKwUygSXR0RxRgwFYAYIPxnU/mFwQHJ3ujmK2CzmJl7a+YZJ8QZ/4N8L++uc4bkpTASiJuJxdxgQdbdrZgNkZmKQAfo8/IbZptHtfmlAUgsq4UCbMngspALHnaVwlgyOrRWDRCOmsLQIiWPrs/3O/0SU2TNA8bk51w0RsFtL84l6I9M7zVWXDvdFJTsMy24fZYOCbOjjtDeK29dd8ZFHo2EzUmvWTTWylJEnKz2Wz40W3/LKwI9vA7tuCYG4O6QrVibVlayWVmcO26j4z1cog99DnFiZ1rik3DwA/XzLcgRJ38I1pG5nnYMP7dYxeykYXP+59czVXuEg0AKRnSArM9BbqKvephUf05Gw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: openfive.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR13MB2797.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e973519-9071-4e91-9a91-08d886281c07
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2020 09:56:49.7660
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4N6yGJodOR5UgD04CHHEft16bxIC+NJ8iK9CUN4r4z8+d9IwmTel4KvUHT7JaZGUCa9SaARr06v5eSPQXcYI/yDGG65zzj74vKu4Ti7S9zw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB4055
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>-----Original Message-----
>From: Zong Li <zong.li@sifive.com>
>Sent: 11 November 2020 15:05
>To: Paul Walmsley ( Sifive) <paul.walmsley@sifive.com>; palmer@dabbelt.com=
;
>sboyd@kernel.org; schwab@linux-m68k.org; Pragnesh Patel
><pragnesh.patel@openfive.com>; aou@eecs.berkeley.edu;
>mturquette@baylibre.com; Yash Shah <yash.shah@openfive.com>; linux-
>kernel@vger.kernel.org; linux-clk@vger.kernel.org; linux-
>riscv@lists.infradead.org
>Cc: Zong Li <zong.li@sifive.com>; Henry Styles ( Sifive) <hes@sifive.com>;=
 Erik
>Danie <erik.danie@sifive.com>
>Subject: [PATCH v3 3/3] clk: sifive: Add a driver for the SiFive FU740 PRC=
I IP
>block
>
>Add driver code for the SiFive FU740 PRCI IP block. This IP block handles =
reset
>and clock control for the SiFive FU740 device and implements SoC-level clo=
ck
>tree controls and dividers.
>
>This driver contains bug fixes and contributions from Henry Styles
><hes@sifive.com> Erik Danie <erik.danie@sifive.com> Pragnesh Patel
><pragnesh.patel@openfive.com>
>
>Signed-off-by: Zong Li <zong.li@sifive.com>
>Cc: Henry Styles <hes@sifive.com>
>Cc: Erik Danie <erik.danie@sifive.com>
>Cc: Pragnesh Patel <pragnesh.patel@openfive.com>
>---
> drivers/clk/sifive/Kconfig                    |   4 +-
> drivers/clk/sifive/Makefile                   |   1 +
> drivers/clk/sifive/fu740-prci.c               | 122 ++++++++++++++++++
> drivers/clk/sifive/fu740-prci.h               |  21 +++
> drivers/clk/sifive/sifive-prci.c              | 120 +++++++++++++++++
> drivers/clk/sifive/sifive-prci.h              |  88 +++++++++++++
> include/dt-bindings/clock/sifive-fu740-prci.h |  23 ++++
> 7 files changed, 377 insertions(+), 2 deletions(-)  create mode 100644

Reviewed-by: Pragnesh Patel <Pragnesh.patel@sifive.com>


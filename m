Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51A8F2C3958
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 07:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbgKYGxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 01:53:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbgKYGxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 01:53:11 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on0612.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0d::612])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83929C0613D4;
        Tue, 24 Nov 2020 22:53:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eilqg5k1pkn9JXTllaXKdfrivhbxEwKmaHqAx6awP92nr/KvSoIcoqHVaYypp4uU64Gk2WRj7jJ6blXx4n4ukvWF+mpnzabCzJ6RU6L4w+Fdse8dUuYHP3PErdGkkHWzxlobyMqDphXQxTMKfZ0HeNC91AgYN7DR7lQM3TrDM/31EvhMHU/2OJl0n/mxj9IKLEvkO+Wev/kPwxtswJXSxh0/KpUYI5l0xL0eiRYzG6/EtZrK9GDgi1kpFYY8lyVOlxQ1jFlgMe2iDbIrtZztIu/zruMnPfXFkJBceyEbDTSQfR9fKykAPI+wiGOfUDJ8bK7MIH61oaOB/+a69viwqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rmsz45l8fbec0ut6owUWZ04y2CO7/rDU1JqHNqxvm0k=;
 b=AaxPnt20oURpqunnHw5uMXNdKB6BkjdnwcmB1e/dLN4nG1a6vMHN+dsZh5jWj6bPv1kXyQjYoUvcOegcA+YXY9dOE6Ir3B62T9Z7TmKUdYBQojdHD87wv2V38cxUAQBNYu0zmoKnMf0m3DvYDETZeH6c6tLF7FRTUXh4aIPDvw2eOenQeEYSWJx+IyHVr09U9TU2y6j8mPLKBKk1iHHZWeU2QgZxJ+Dl2rDdh8azZ/5JCk7xd6Pje5Xw46t3IJFjB7OD8z7MelY6l5WbXZ3OFWR46W+BuisWXmGmbpc1IyzbcGqDxpdMZXLxcc0mhE5wm5RipEJfgAesqm5P52vN/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rmsz45l8fbec0ut6owUWZ04y2CO7/rDU1JqHNqxvm0k=;
 b=FIVXyaI1Je5MAL1VLDcsxfnR9/u78F4iKeMBc+H2rQswgc+/2XtvJW+U8IluPFywe5DsoUrUrnlRl7pmzHKzpCovTq29bxD7EG5tkcPZog3t6MhuMqLV9cDU9DTe5Xb/3cldpCEnZhfwvI98TSTr+gsPPN5fOem9ISgdLTTw04Q=
Received: from DBBPR04MB7979.eurprd04.prod.outlook.com (2603:10a6:10:1ec::9)
 by DB3PR0402MB3916.eurprd04.prod.outlook.com (2603:10a6:8:10::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.28; Wed, 25 Nov
 2020 06:53:06 +0000
Received: from DBBPR04MB7979.eurprd04.prod.outlook.com
 ([fe80::c8c:888f:3e0c:8d5c]) by DBBPR04MB7979.eurprd04.prod.outlook.com
 ([fe80::c8c:888f:3e0c:8d5c%5]) with mapi id 15.20.3589.030; Wed, 25 Nov 2020
 06:53:06 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Pawel Laszczak <pawell@cadence.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "colin.king@canonical.com" <colin.king@canonical.com>,
        "rogerq@ti.com" <rogerq@ti.com>, Rahul Kumar <kurahul@cadence.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>
Subject: RE: [PATCH v3 00/10] Introduced new Cadence USBSSP DRD Driver.
Thread-Topic: [PATCH v3 00/10] Introduced new Cadence USBSSP DRD Driver.
Thread-Index: AQHWvn5dJMNE6+//dE+JAvEKZI/EXanW7/CAgAAZfwCAAVwpgIAADG9w
Date:   Wed, 25 Nov 2020 06:53:06 +0000
Message-ID: <DBBPR04MB7979BE93D8A7A28D3AE24FDF8BFA0@DBBPR04MB7979.eurprd04.prod.outlook.com>
References: <20201119141307.8342-1-pawell@cadence.com>
 <20201124075023.GC32310@b29397-desktop>
 <DM6PR07MB55299F262CEA81216999CB05DDFB0@DM6PR07MB5529.namprd07.prod.outlook.com>
 <DM6PR07MB55294D86FE79E85F41838918DDFA0@DM6PR07MB5529.namprd07.prod.outlook.com>
In-Reply-To: <DM6PR07MB55294D86FE79E85F41838918DDFA0@DM6PR07MB5529.namprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: cadence.com; dkim=none (message not signed)
 header.d=none;cadence.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 337d93cd-0f50-49ab-943c-08d8910ec384
x-ms-traffictypediagnostic: DB3PR0402MB3916:
x-microsoft-antispam-prvs: <DB3PR0402MB391628793CB2CA2D0D18E6EB8BFA0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PVHC6t0xesigRSxbv5Vf5UHhpqOj2VahT4bV+YF7XheS+SEBu7Ub+9rLqVUm39OnZv6wSX/2Z1aqVv78pXP1JqQTvtQ2rFNW9cA0j5q4X/YvivUKKg2Kx6JghiBi7q9WG0PrSwwxP06ihDFmxYaoyHQTQEz07e6eiLKnNWM+WrMzhY536FwBO7TldPRNo94KyFX9LieHCgWL3MAeWljoAXWPgm0r5RBht3V/efn3BqpGiakiKd19uIzIHaGvIxUr5GIPB7tEzPezmEecy34GgT1O4L4AnxuQUy49PZ9xrXIyRcXKEGciunVzdQh3Yd5uglnha5oFfd5xyugncdkSTA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7979.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(376002)(366004)(346002)(39860400002)(76116006)(66446008)(52536014)(9686003)(478600001)(64756008)(33656002)(86362001)(6916009)(55016002)(66476007)(83380400001)(66946007)(66556008)(54906003)(316002)(186003)(6506007)(8676002)(8936002)(26005)(71200400001)(7696005)(2906002)(5660300002)(4326008)(44832011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: vjqqA8buQfH+0f9D0MEAEVFUWyaZ4o7gTFAf2jjzfQ7toZDGtiCw0AsvGfn5yjsAYG5SVUXWM2aDFk/qvTXWfJyrX6hm9xk8rZonCO9ioLsgijoYkjUdc6UocO5+CXi4BaoTxsb11x+jKvLgS4xwaFHerRjF2JvGzsE7AXt8TfykCXP8pxiCGoFJxzfkaMmXyPlZPrFRwTh6ZE3/3miAmS3g9oh8jfxvBCnfCoYF1/JNf1x5iGtQ0H+iB8JWnRFahfRCoClFoN+C4mX4djpyYUxtZ8BMs+ANkRR4orTKQpix43Y2DL0GCXszHCYO8wyah1+65qz5Zhz5Xybs1c3QoIVBqBd8oEoMnX7BaExYslOY8BSpwp3/qnA8iQ9x5mbpqrifosPqFdvpZyj32Ptkut7QU7krpn7oZU5xkTJm34FA9VTnw2ZUuJIYHRINBoo54zkzNihQ4rD6BTdiQPldfk/JQ/q+REfHpC93naDlocgcPZ0ZSji8Bzpr3k9s4s6KdEQakWkXgxIdmAT8sbUJ5SccnyvNtGfevW1JbRoJsorXuiKVI820eVjVaHjmxQXyw1L2qZfXhtI/2gpWBtwgsGj/bu506fUXSWDX/f2Eqz1EuBvILirRoHkDbVuwdSt/V/t9lpjlk2mO/1tEBQKpLtg9wchO0s/W/sHGfx4UYMXafo3nFtF4aqWia2q5tcnF2GA6XXNwn1p+/0o+szMC9udzIzGu4o1drxQXi51Vs4d6l7qj/CWHe/JoTrKC4xPUcwsM27pLBce27lH2koXbcU0h7m6NeBvfPulu3biXXS2QXqs2qv3TyEY10YVOaRkSxLhA+pHIWb+REORqDL06n90YgxYClwEnSCSBDjwmC/v5KelNcO5z9UZxUuFDjwQ2FrDbIjhw42iVwJYtTnjCkg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7979.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 337d93cd-0f50-49ab-943c-08d8910ec384
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2020 06:53:06.7545
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R5U7msT6j5siCbMmh6pAYjGv3i/+h2F7tR0fTtN+4miim4DPj5rtorNw2Wj6xUpv6sY2rhZVf7tk/58XzY94yQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3916
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> >>>
> >>> The device side of USBSS DRD controller is compliant with XHCI.
> >>> The architecture for device side is almost the same as for host
> >>> side, and most of the XHCI specification can be used to understand
> >>> how this controller operates.
> >>>
> >>> This controller and driver support Full Speed, Hight Speed, Supper
> >>> Speed and Supper Speed Plus USB protocol.
> >>>
> >>> The prefix cdnsp used in driver has chosen by analogy to cdn3 driver.
> >>> The last letter of this acronym means PLUS. The formal name of
> >>> controller is USBSSP but it's to generic so I've decided to use CDNSP=
.
> >>>
> >>> The patch 1: adds support for DRD CDNSP.
> >>> The patch 2: separates common code that can be reusable by cdnsp driv=
er.
> >>> The patch 3: moves reusable code to separate module.
> >>> The patch 4: changes prefixes in reusable code from cdns3 to common
> cdns.
> >>> The patch 5: adopts gadget_dev pointer in cdns structure to make poss=
ible
> >>>              use it in both drivers.
> >>> The patches 6-8: add the main part of driver and has been intentional=
ly
> >>>              split into 3 part. In my opinion such division should no=
t
> >>>              affect understanding and reviewing the driver, and cause
> that
> >>>              main patch (7/8) is little smaller. Patch 6 introduces m=
ain
> >>>              header file for driver, 7 is the main part that implemen=
ts
> all
> >>>              functionality of driver and 8 introduces tracepoints.
> >>> The patch 9: Adds cdns3 prefixes to files related with USBSS driver.
> >>> the patch 10: Adds USBSSP DRD IP driver entry to MAINTAINERS file.
> >>>
> >>> Changlog from v2:
> >>> - removed not used pdev parameter from cdnsp_read/wite_64 functions
> >>> - fixed incorrect value assigned to CDNSP_ENDPOINTS_NUM (32 -> 31)
> >>> - replaced some constant value with CDNSP_ENDPOINTS_NUM macro
> >>> - replaced 'true' with '1' in bits description in cdnsp-gadget.h
> >>> file
> >>> - fixed some typos
> >>> - some other less important changes suggested by Peter Chen
> >>
> >>Hi Pawel,
> >>
> >>I have updated my -next tree as the latest usb-next tree which
> >>v5.10-rc4 is included, would you please rebase my tree and send again,
> >>I could apply your patches and test, if test could pass, I will apply i=
t to my
> -next tree.
> >>You don't need to rebase again since it is a huge patch set, will take
> >>some efforts for rebase.
> >>
> >
> >I'll try to post it tomorrow.
>=20
> Can I send the new version CDNSP or I should wait for completion
> 'Re: [PATCH] Revert "usb: cdns3: core: quit if it uses role switch class"=
' and
> applying the appropriate fix to your repo ?
>=20
=20
Please wait that fix, thanks.

Peter

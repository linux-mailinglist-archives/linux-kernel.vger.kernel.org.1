Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE0E29A5C9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 08:48:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2508097AbgJ0HsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 03:48:23 -0400
Received: from mail-eopbgr70083.outbound.protection.outlook.com ([40.107.7.83]:58829
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2508088AbgJ0HsW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 03:48:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PIOIKkULeZG8q8wQl+bUEOWJ7Z8sRc3w8TR1qshgOAU6GHycpcKuVRWWCQjkhjqIQw5WTBAMgzu2gTfUb86CZM54EBWCGn9IxDUeEJsvVxX1ewrQ+fwBXjKJUOZKwta54plszqVpUbQCUqWquYvw9PCCSgXJf6kmqQ51XEN+q5tVJ5PYYnl3C7Ti0Y4A0ArICu43WtYhvXiQwMj3l7DZoQ1tryPY7pAUgEsIdg0GEj2O6jsFxoj5oRcIRhS6pausaXiwTY8v8Wd5GRAHJdmQjRBS9Q3blm352PEkIsf0/NAxg96VCVGcI1EDH4Wr6AjkYsb1P5sFqvvJUAlxvYSLpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jmYB6QozIqc1v7SYRp/X5rvyl4UMnON3izqBbpsn4ZU=;
 b=Vk1G71prPoc8O7z5Ojnn67J3EmRKnvcHXz7CRVKvydywFhkU6Qg2es6tRagWmAKafV6ZAkZSDKu/pj9vs68iXi7sXHbAPUu0XYwK+0OAB64dP8ZPxySdJoZzz8x9bU/Ovhf/TS475FQT+NDBq0GU7De8BGI9nRj1hSd3M0IpgXUXU3m//NZMfsyGpHYjP4nzHbxtmd1vEiQo0cYaXTTBygS76AF+QS54IKtE5AN2vf3SaqKK/tl54lDNcxUSUWJ1F+WSpnIS0hVBtLE7omnFHJDZ6pAKPkOHXnGAlng77hKuSBrL4jAuo7XQzWkq6/8lVLd+/9a9VX9EwKI8vOxGVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jmYB6QozIqc1v7SYRp/X5rvyl4UMnON3izqBbpsn4ZU=;
 b=mzeOKmNU+WL2uHroFN932C9pTar+xRDNcD6cNeN0r4io/i7+l1FCttEkz/up/POCQINYfE4+FwOy1tDepTldzC9iq8lIutRo/9SpfZuikYWRKxjMrhwc6s7Vd28gP4lElMxs+31X55xTzisMYWNGE5Pr+lBLRl7WQcOq/LUxbbI=
Received: from DB6PR0401MB2438.eurprd04.prod.outlook.com (2603:10a6:4:33::14)
 by DB8PR04MB7001.eurprd04.prod.outlook.com (2603:10a6:10:11f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.24; Tue, 27 Oct
 2020 07:48:17 +0000
Received: from DB6PR0401MB2438.eurprd04.prod.outlook.com
 ([fe80::c8a:a759:d4ba:181e]) by DB6PR0401MB2438.eurprd04.prod.outlook.com
 ([fe80::c8a:a759:d4ba:181e%7]) with mapi id 15.20.3477.029; Tue, 27 Oct 2020
 07:48:17 +0000
From:   Biwen Li <biwen.li@nxp.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Biwen Li (OSS)" <biwen.li@oss.nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Leo Li <leoyang.li@nxp.com>, "Z.q. Hou" <zhiqiang.hou@nxp.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "maz@kernel.org" <maz@kernel.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jiafei Pan <jiafei.pan@nxp.com>,
        Xiaobo Xie <xiaobo.xie@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [EXT] Re: [v2 01/11] irqchip: ls-extirq: Add LS1043A, LS1088A
 external interrupt
Thread-Topic: [EXT] Re: [v2 01/11] irqchip: ls-extirq: Add LS1043A, LS1088A
 external interrupt
Thread-Index: AQHWrB1rT1rZT9wf3U6a6wH3dRQoQKmrEJ2AgAABvNA=
Date:   Tue, 27 Oct 2020 07:48:17 +0000
Message-ID: <DB6PR0401MB2438ED1C8F629CA1E1F469768F160@DB6PR0401MB2438.eurprd04.prod.outlook.com>
References: <20201027044619.41879-1-biwen.li@oss.nxp.com>
 <5b1f2911-98b3-511f-404b-7d0fa44cc0c2@rasmusvillemoes.dk>
In-Reply-To: <5b1f2911-98b3-511f-404b-7d0fa44cc0c2@rasmusvillemoes.dk>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: rasmusvillemoes.dk; dkim=none (message not signed)
 header.d=none;rasmusvillemoes.dk; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8fbb9d72-d099-402a-7c97-08d87a4caafb
x-ms-traffictypediagnostic: DB8PR04MB7001:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR04MB7001D53A362DB4C80FF84F048F160@DB8PR04MB7001.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IgzF0pQLk4+eMNoV9LahybBps5rpKK8SJW+bAG9lhpQPNt10mfTLXmyGfN1ijBm729e4B+HENri6ns+UBJ0YU/BuwQTsoARgxr4driLcQ+3NNOlRvLjP9fvI315Z5vi/gkX2xEsaXPHi3j9mKeHYY0zhkfTERx9g0pUe56He6pKVDUDmy5MYaLxwIsCqjh38yFt3kBCTtMBeJUeBoAhM7PkLb3NiSutcjWNg0D9yYy4XI7cc50lmEMqtnhuKDArWCSXwZwF2d+eDgffob6qDP780KCYMy35rCP3XB6Bz1YsWQwDMJR9bj2/Q1YjUh+A83CJ4EuYy8El/E+qPuPhqd/xvS82BILv5VD5c0I2xp30v56Nh5nsZgBuyf2H+ei3m
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0401MB2438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(396003)(346002)(136003)(366004)(66476007)(33656002)(7696005)(66946007)(316002)(64756008)(7416002)(5660300002)(66446008)(71200400001)(76116006)(4326008)(52536014)(2906002)(66556008)(478600001)(44832011)(86362001)(110136005)(83380400001)(8676002)(8936002)(54906003)(55016002)(26005)(9686003)(186003)(6506007)(921003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: D8PVO+odhiToXuNHJjiOLnm1alihxWSZdoS+JeEulpMNRAvbISQI5q8cqjlAmUUipmmsvxgQDJ2eopk5m4U1CZY7IDzCmL8bISc3Z3jMDsL+hFx0mqnup1LRV1zPuZJP4NI9zWydZ/8JLLM16Cb8pAiZTp8cigu92bRB4Bw0fKbweCCXGnIj1Mq5A1Ve+Bt8OXa5YO4togrZuPbg/gdKNJ0QrDbP9TTtbqAQI3BAAnXqP1PT+d8tZV8vEDFU9sqsRu5uRQYGm8mFWsPKcvzSq8j3+QC+y7iJ/Sk4FCLu4YOzrvHGLTudX9Bl1an8jvH8EzGhQwbw64BRZjtzvrGMcB5lvtTS5KFbDT369Q7XTBpyN/cKANmi84k76q7/cfOpqllu4ytlf4AhwQvy0GjD5wOB0+JNcPxx3tf7D4P1sC/itU19nDkK8WiA1OKtP2dgGplI1WE9SorE7sT2soAmuAiG/KFRBPBOZc33PNtuBVXitBi8AqMnp31rgjCz1Dx+oaeZgNojaQpb1No/vNnoCqFg5edxRtElKnn35rwGNX2GvTuZjpsz5bE6gUM0hyrPDVQvdqi00TsmoFdFM7VNfvCOBDf5QcS+GReChWM1inQHmoK7RkqwXmX/BCY4DOJkOQ96lnNTmqqA4l8h4sTJXg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0401MB2438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fbb9d72-d099-402a-7c97-08d87a4caafb
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2020 07:48:17.5647
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NS2a7D7XHv2MmUu5QZDJJcihwM3ITh5Mkq52L0bkm5X7QR/5BMg5t2ZDIOEmbSvUDIJmSQwcHKveSi9R0h/2Fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7001
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>=20
> Caution: EXT Email
>=20
> On 27/10/2020 05.46, Biwen Li wrote:
> > From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> >
> > Add an new IRQ chip declaration for LS1043A and LS1088A
> > - compatible "fsl,ls1043a-extirq" for LS1043A, LS1046A. SCFG_INTPCR[31:=
0]
> >   of these SoCs is stored/read as SCFG_INTPCR[0:31] defaultly(bit
> >   reverse)
>=20
> s/defaultly/by default/ I suppose. But what does that mean? Is it still
> configurable, just now through some undocumented register? If that regist=
er
> still exists, does it now have a reset value of all-ones as opposed to th=
e ls1021
> case? If it's not configurable, then describing the situation as "by defa=
ult" is
> confusing and wrong, it should just say "On LS1043A, LS1046A, SCFG_INTPCR
> is stored/read bit-reversed."
Okay, got it. Will update it in v3. Thanks.
>=20
>=20
> > - compatible "fsl,ls1088a-extirq" for LS1088A, LS208xA, LX216xA
> >
> > Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> > Signed-off-by: Biwen Li <biwen.li@nxp.com>
> > ---
> > Change in v2:
> >       - add despcription of bit reverse
> >       - update copyright
> >
> >  drivers/irqchip/irq-ls-extirq.c | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/irqchip/irq-ls-extirq.c
> > b/drivers/irqchip/irq-ls-extirq.c index 4d1179fed77c..9587bc2607fc
> > 100644
> > --- a/drivers/irqchip/irq-ls-extirq.c
> > +++ b/drivers/irqchip/irq-ls-extirq.c
> > @@ -1,5 +1,8 @@
> >  // SPDX-License-Identifier: GPL-2.0
> > -
> > +/*
> > + * Author: Rasmus Villemoes <linux@rasmusvillemoes.dk>
>=20
> If I wanted my name splattered all over the files I touch or add, I'd add=
 it myself,
> TYVM. The git history is plenty fine for recording authorship as far as I=
'm
> concerned, and I absolutely abhor having to skip over any kind of legales=
e
> boilerplate when opening a file.
Okay, got it. Will drop it in v3. Thanks.
>=20
> Rasmus

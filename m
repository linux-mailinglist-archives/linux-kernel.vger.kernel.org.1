Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D37629AA1C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 11:56:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2898770AbgJ0Kz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 06:55:57 -0400
Received: from mail-eopbgr10082.outbound.protection.outlook.com ([40.107.1.82]:40325
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2898758AbgJ0Kzy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 06:55:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JwMJ7115Hb1Nk+LX5axTcAi86cttwmAtK3hXuIXFSMh/DgULHpiTCGAkLkqD2v5oOO85eWqih9jMZHPclA3HMcKZ0pn+MgmJg3EcfQbXv8ONEg662X14Z+mgspa5BAlMfAOP1ZTttDjioSdcDkSxLo59OXqSmaHE6LspSZsCsL9csKUoLUqrrMZ6oIbHiI3vHzhMCsYgqnP13K9l1GE/Ib7idERWPGUkZ9/MhJ9DOvlqEPy9bg7nG25gmnjSoH9HTkRd6abiBSBpuVr5rttg89VU0z5R9AYSnpzbDL0RrhiYp9Fk6i40btkQMdKAsvsskiouaZUHcAcZh3Mk7lQzKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+KydwbrFObfZP7UZypCcdQNj2jxedfW6pd8Bhr8jMhs=;
 b=od6PFULMhukF/ZXY3HX5fTg3jY0rrFjalGAUa9RX8lfTfNzxszeuPzQdbgfQ941zm33ewHYxH5yIXhzObw2b2ZqAIP6zMN+7WkwWebYOlvH8wzIbtOIzn5ibaAxog1YFb34cvGFqjsbMDhhFJDrzbbhfpcB22StzhC7KOymGQDjxfYneVXshmxZTMez2ZDSDpnt2MyuYi6s97P2m301AYAN6FP9gNZXKh143xNAQIph+jcFINF1fzFL2T/2Arbn+RFlSONh7eHIELYLYLl5WG+si8yEN8NGm6ZFBBHW7S4yJRpeF1DZpFPxk4BnM0iOysrIH7RRgFhTIKYNkaTaTrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+KydwbrFObfZP7UZypCcdQNj2jxedfW6pd8Bhr8jMhs=;
 b=f8DV7XaQSBCPQbeal4uSOCbMVOSmQX4jkjU+zfy9/qWyTYHBPAFmIQU1yLMn2jKThboNPJvBjuFAZhgKu4J2n/zX1pbD3ucy4y8XtMDfvB3t7+PT53Yx45xIKVox8i2WWNM7dJWifkLOufG2oDPdZykLE0wKlFKQYspc/RxPi2o=
Received: from HE1PR0401MB2444.eurprd04.prod.outlook.com (2603:10a6:3:83::15)
 by HE1PR0401MB2634.eurprd04.prod.outlook.com (2603:10a6:3:87::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Tue, 27 Oct
 2020 10:55:48 +0000
Received: from HE1PR0401MB2444.eurprd04.prod.outlook.com
 ([fe80::2465:b69a:bcd7:75d9]) by HE1PR0401MB2444.eurprd04.prod.outlook.com
 ([fe80::2465:b69a:bcd7:75d9%5]) with mapi id 15.20.3477.028; Tue, 27 Oct 2020
 10:55:48 +0000
From:   "Biwen Li (OSS)" <biwen.li@oss.nxp.com>
To:     Marc Zyngier <maz@kernel.org>,
        "Biwen Li (OSS)" <biwen.li@oss.nxp.com>
CC:     "linux@rasmusvillemoes.dk" <linux@rasmusvillemoes.dk>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Leo Li <leoyang.li@nxp.com>, "Z.q. Hou" <zhiqiang.hou@nxp.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jiafei Pan <jiafei.pan@nxp.com>,
        Xiaobo Xie <xiaobo.xie@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [v2 01/11] irqchip: ls-extirq: Add LS1043A, LS1088A external
 interrupt
Thread-Topic: [v2 01/11] irqchip: ls-extirq: Add LS1043A, LS1088A external
 interrupt
Thread-Index: AQHWrEzzsEWsQcWWFESnNpVhpDbBsamrQV8AgAACDACAAANj8A==
Date:   Tue, 27 Oct 2020 10:55:48 +0000
Message-ID: <HE1PR0401MB2444133CEF5CD207C36DC81E8F160@HE1PR0401MB2444.eurprd04.prod.outlook.com>
References: <20201027044619.41879-1-biwen.li@oss.nxp.com>
 <d5d6deb90b4b3d086024fcf01b737da9@kernel.org>
 <HE1PR0401MB2444AA759104F4A34F91B61F8F160@HE1PR0401MB2444.eurprd04.prod.outlook.com>
 <e6cd6eecb0221742548e657faf211733@kernel.org>
In-Reply-To: <e6cd6eecb0221742548e657faf211733@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f9d354ae-ee4d-4eb7-85b5-08d87a66dcf2
x-ms-traffictypediagnostic: HE1PR0401MB2634:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HE1PR0401MB2634AE35B55CDCA27D20EC98CE160@HE1PR0401MB2634.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:590;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i8lHOQMUZMN/LUny6PVTiLbSAM6bl9Y8OCQkPCE2v+U0HV2Ni1gDf2FLxedYhZAo1hMCkxn1WOHCRSN/vYPk7HTJE/RReiQrSSSUUuU6d7hhFFOamWBN8xl4HmPU3cu6HOQ8VquSF7vAdo8ncT9n7Sk0ibk03zFsNG0ngu/2a9g0ZKpRGRVhM+xo+TF4nGvMwHhssV5UIuRFidnYW9oqfryNMdI0tA4t3AIlkxVGNA/2JFYZdsiURBjfvUHcR6NjHytumAEQhRkjig0O+5WB2bw+Uno7+gGV6Y05rwaiIsx31nGalpx6zbjzePUMzhpvbh0aeovGESvrQhCtd4qZpw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0401MB2444.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(346002)(376002)(366004)(136003)(66556008)(66476007)(9686003)(52536014)(186003)(478600001)(2906002)(7416002)(66446008)(8936002)(53546011)(4001150100001)(55016002)(71200400001)(83380400001)(4326008)(6506007)(76116006)(110136005)(8676002)(26005)(5660300002)(64756008)(7696005)(66946007)(33656002)(86362001)(54906003)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: Yhm758XkXalnW5g02yirdvTMIF37fYmX1HOT1TVTkTMJy2pKlh7kw4kW4XDU3JVLK6s/ti+uLy9N5Ph5g1KpbI2kwDIZLhl2urfAzb694hj/fRSwicupU5gdkXdqFOlDxOviIE4zv4fkPgfmYE62UkeCQbZf79vk9qWe6JkHxh/X2dwajpBLlYFJc7Rz/SFHyKvVOpMwsDKevGlImfE9gz+aodxtNTtd7UkoreJf0tb45hc5JCHLVhqwMmIwoIzqSf0/AGBZVYQamC2LGbCgBk8TEKinaYx9jCjWIS25zd3+0oCFt/22wbSRnrQXaehmgmBDqku0zImX/Un7LJuX1VJNXdMQraCxXrkxcyfSos90D+axOJQFdNq9UoKKtQqOfS62yZfzsgZ/iWkN2HzjTmkrJcuaDvtD0HubnPkYbfFB35jrTsAjX0YYweoSogTHzH2MEfCXwWmWNAbdhGpaDPgvf1kNVu8o5OrmiIVkYh3tnI4DGeUNvKG2hVeAf3aP1GpuFci87giUloc8mr5gksAZtcKJjvsBOr6s0/pJGylHLO1rvToGGgN7gyghcQJk7RiPKy8LzOSw6nlKz+697su8KlzHjmbT+oWXkE/FLAXBBTRnn4R1uN+9TFzEFDYqcYyB4qx4nMxRZ8/UuQ/EKQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0401MB2444.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9d354ae-ee4d-4eb7-85b5-08d87a66dcf2
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2020 10:55:48.3550
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TTSnMfwaHWK/ssyR99XRiQBshOKCKrmN/5TgVeIBMjqcUdT5bsAtivpoXDlHdThE46+bAp0T8k1e5HJXDpFVlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2634
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> >> On 2020-10-27 04:46, Biwen Li wrote:
> >> > From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> >> >
> >> > Add an new IRQ chip declaration for LS1043A and LS1088A
> >> > - compatible "fsl,ls1043a-extirq" for LS1043A, LS1046A.
> >> > SCFG_INTPCR[31:0]
> >> >   of these SoCs is stored/read as SCFG_INTPCR[0:31] defaultly(bit
> >> >   reverse)
> >> > - compatible "fsl,ls1088a-extirq" for LS1088A, LS208xA, LX216xA
> >> >
> >> > Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> >> > Signed-off-by: Biwen Li <biwen.li@nxp.com>
> >>
> >> You clearly couldn't be bothered to read what I wrote in my earlier
> >> replies. I'm thus ignoring this series...
> > Okay, got it.
> >>
> >> > ---
> >> > Change in v2:
> >> > 	- add despcription of bit reverse
> >> > 	- update copyright
> >> >
> >> >  drivers/irqchip/irq-ls-extirq.c | 10 +++++++++-
> >> >  1 file changed, 9 insertions(+), 1 deletion(-)
> >> >
> >> > diff --git a/drivers/irqchip/irq-ls-extirq.c
> >> > b/drivers/irqchip/irq-ls-extirq.c index 4d1179fed77c..9587bc2607fc
> >> > 100644
> >> > --- a/drivers/irqchip/irq-ls-extirq.c
> >> > +++ b/drivers/irqchip/irq-ls-extirq.c
> >> > @@ -1,5 +1,8 @@
> >> >  // SPDX-License-Identifier: GPL-2.0
> >> > -
> >> > +/*
> >> > + * Author: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> >> > + * Copyright 2020 NXP
> >>
> >> ... specially when you keep attributing someone else's copyright to
> >> NXP.
> > Then I don't know how to add the copyright, any suggestions?
>=20
> Simple. You don't add anything. NXP's copyright doesn't apply to this fil=
e
> before this patch, and your changes are so trivial that they don't really=
 warrant
> a mention. Furthermore, the git history already keeps track of who did wh=
at.
Okay, got it. Thanks.
>=20
>          M.
> --
> Jazz is not dead. It just smells funny...

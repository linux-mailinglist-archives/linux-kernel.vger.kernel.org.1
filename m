Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8357F2A24B2
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 07:15:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728200AbgKBGPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 01:15:05 -0500
Received: from mail-db8eur05on2059.outbound.protection.outlook.com ([40.107.20.59]:55776
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727950AbgKBGPE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 01:15:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kihRuxlP0SgznCV7WrnuBU8TV8ym0yG9NfMgNPObEeplZrVcl4LgppDdHyrPM+V6NayLQ8tVc40mZ2FKIibGHPzHafIP66I/RahQAik6gMpFO7PNjYmCSb0wDhdFx47wlZRhSV01cKl7DrjrCJ18vU4KeHZPHYFDFPuueAKMSc1VoJd1uexdPq4Y7Jr+zVO+YYG8NLgRZ8T5wSc5hJqacD025YAB2ZdsOTvKARfBqJAvwILpVpKUsBU2oX4suUGJ0jx+AdlejEyR2mJHP6aypsK5ElQHAPKPx3JaIjAA1f+hIquGR8WYj6HOfxmtyGMcociRytNnqfF7L0G165i6bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mXgnPLYXab5Cet3DgisxXKTqY0nI+4ulgLStNQeRqRE=;
 b=OejmNjNIcgwzic9FM7Q10UfzBrZWR40RwZVOwYqS9VIkJNU51SaKN8Aj7lIRAoMDg1OhFphb06Is+z3B3aIf1QSJdupNKAGSQIFjVojTm/fnXzFva2I2J9C0Y9NesEXlzUXCcFFikGan0VskJ97f/5xix9qmUIelsambAlhgNFUU8WDeMzaBOGT0Gu9aG/5N2W2h13rMfhjvcssOxnl+xO8iqvHTN3F20+PW3slhKT38T0YqNfy2kEqr04v7vF08prktMx6mc/21WjPd4BdV/TQG8kRc2/GAYuXhU8knP0rRBHpoGgpZLjDcfPFvpULlED/tMRXElX+4pihRMb+nhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mXgnPLYXab5Cet3DgisxXKTqY0nI+4ulgLStNQeRqRE=;
 b=myrIJgAr0SNo+hYEc4hwjNne6gi7bQLIF/6M3J22thAs0OZ+HyFs47KvihOt7oVPG9vx2PZlGHWhx+sSxaC8vWZoAf6AGnS+MebmPVrucJyu4WIMPyqgzqkmwk6ir+OiTMcIXvBtTVc0wKRkmLzaciW0qgsxLfMVt+NtlJKUjWQ=
Received: from DB6PR0401MB2438.eurprd04.prod.outlook.com (2603:10a6:4:33::14)
 by DB8PR04MB7065.eurprd04.prod.outlook.com (2603:10a6:10:127::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Mon, 2 Nov
 2020 06:14:59 +0000
Received: from DB6PR0401MB2438.eurprd04.prod.outlook.com
 ([fe80::f0c9:fd48:c8d1:5c22]) by DB6PR0401MB2438.eurprd04.prod.outlook.com
 ([fe80::f0c9:fd48:c8d1:5c22%11]) with mapi id 15.20.3499.030; Mon, 2 Nov 2020
 06:14:59 +0000
From:   "Biwen Li (OSS)" <biwen.li@oss.nxp.com>
To:     Leo Li <leoyang.li@nxp.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Biwen Li (OSS)" <biwen.li@oss.nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "Z.q. Hou" <zhiqiang.hou@nxp.com>,
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
Thread-Index: AQHWrB1rT1rZT9wf3U6a6wH3dRQoQKmrEJ2AgAABvNCAAOZGAIAIbhlg
Date:   Mon, 2 Nov 2020 06:14:58 +0000
Message-ID: <DB6PR0401MB2438DCABBF4892ECF599D4528F100@DB6PR0401MB2438.eurprd04.prod.outlook.com>
References: <20201027044619.41879-1-biwen.li@oss.nxp.com>
 <5b1f2911-98b3-511f-404b-7d0fa44cc0c2@rasmusvillemoes.dk>
 <DB6PR0401MB2438ED1C8F629CA1E1F469768F160@DB6PR0401MB2438.eurprd04.prod.outlook.com>
 <VE1PR04MB668790304253EAEEBC1B79F48F160@VE1PR04MB6687.eurprd04.prod.outlook.com>
In-Reply-To: <VE1PR04MB668790304253EAEEBC1B79F48F160@VE1PR04MB6687.eurprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fdce3176-a3d1-4e99-60a4-08d87ef6a062
x-ms-traffictypediagnostic: DB8PR04MB7065:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR04MB706574FB6FC7BCA233428F00CE100@DB8PR04MB7065.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C5Dv+7lMsgGIv7KkAoOls01fVOlmaGJUaxjkcYyjDILUef3G9sRV7Nc7LecSzU9oeg0epOgN7h9pC9oZqLn6LbeRQ46jDEEtP7qAL/6YQQSdguNCzd6xk8jTpruDuHgynXdqVTwuX0bV2HZ6m/PHTJNcSW+smjKyxIdV9baSJflt1Io7XhKoPEG1nmWmKdfe44a1WL/zZjRgOoXiUrEKDB0HfaKXva5NA65FLBlmlbyrnzpU1Yw82K+gjqAuwiE+NOaPeDWYXZ+PUGuG3JEvyrq6J3qcQlaPFqJK4kG6xX4ogSb6QFlajPxfV7lerLXIbxfSFMaoqGTdP+E7bu0/G8CvKzGVdwRMgTH61BzJyYJsSIpvDPQvjDZfnYnH3msJ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0401MB2438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(39860400002)(346002)(396003)(376002)(66446008)(66476007)(66556008)(66946007)(76116006)(54906003)(316002)(478600001)(86362001)(55016002)(8676002)(7416002)(5660300002)(4326008)(71200400001)(64756008)(52536014)(110136005)(6506007)(2906002)(26005)(186003)(8936002)(33656002)(83380400001)(7696005)(9686003)(921003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: OlIn/5v2svSqkmb09CiYvTYFY25V98rQtQLv6w/6Vm8atvXSe/qe26H6dYjqOVN61Kob1IQSSpDMqTJcouwZ5kOAhpxof6MOqNaW1NfuQLifsyAEKSsV2IEjy6dfFkG8uiLp3F7P0xas3L7jxKB+laJauwf0//SG3YB6hzZxedfLCMgXnq4mTfOFQ6wFbRG9PjfZkrdjNUvV7MJPkfumzu6FgjeQeKqLIjbMS92IbaQsJIkEnHeKIq4kvQtssim6zQjrZx6Nv0AwWWGByTPs6xXHrukfu8j3/mvnjbH9jsH+FdGDav6U+7RLMLg1iMHjvFjF8lD7JWUcpM1xO7og5UKRwVHHk+iwyqXwa1iv/X+YOUoiCg6USG3DFSfh7uO84zHHMFvf0l5qGBbu4toF0+yef7+vO62aSQPmtHLwUha/pnnemK5QD5W+3m8vpb2m9zV7OI+qUY6u1hfD9tgrBcOzxtLL0IwqnD/2sMtxZApOFjutlNl9f7H8jkm60EsRiJ9fN2fHuIsA0H562+NbItVEDWBYiLGbp+ezO/K5UPPW/0V9tTWZ1pLmRqrcL0b//Z5aDPqGYs0hzc7tGtI6KcF9Fe2YfGW9jwa++jg+iKEzQrw31XvCPCR/vpRL1j2+CSvBKiDVC8DprLfPYejKWw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0401MB2438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdce3176-a3d1-4e99-60a4-08d87ef6a062
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2020 06:14:58.9562
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VKL7KwS4z0u+IGFkJRJMbMsaw9u0w1G1EBWBljzO65PtKsJedkHs+WmcGtBxCHU3XxUz3Zbrl90om58tqiArQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7065
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > >
> > > Caution: EXT Email
> > >
> > > On 27/10/2020 05.46, Biwen Li wrote:
> > > > From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> > > >
> > > > Add an new IRQ chip declaration for LS1043A and LS1088A
> > > > - compatible "fsl,ls1043a-extirq" for LS1043A, LS1046A.
> SCFG_INTPCR[31:0]
> > > >   of these SoCs is stored/read as SCFG_INTPCR[0:31] defaultly(bit
> > > >   reverse)
> > >
> > > s/defaultly/by default/ I suppose. But what does that mean? Is it
> > > still configurable, just now through some undocumented register? If
> > > that register still exists, does it now have a reset value of
> > > all-ones as opposed to the ls1021 case? If it's not configurable,
> > > then describing the situation as "by default" is confusing and
> > > wrong, it should just say "On LS1043A, LS1046A, SCFG_INTPCR is
> > > stored/read bit-
> > reversed."
> > Okay, got it. Will update it in v3. Thanks.
>=20
> Hi Biwen,
>=20
> Where did you get this information that the register on LS1043 and LS1046=
 is bit
> reversed?  I cannot find such information in the RM.  And does this mean =
all
> other SCFG registers are also bit reversed?  If this is some information =
that is
> not covered by the RM, we probably should clarify it in the code and the =
commit
> message.
Hi Leo,

I directly use the same logic to write the bit(field IRQ0~11INTP) of the re=
gister SCFG_INTPCR
in LS1043A and LS1046A.
Such as,
if I want to control the polarity of IRQ0(field IRQ0INTP, IRQ0 is active lo=
w) of LS1043A/LS1046A,
then I just need write a value 1 << (31 - 0) to it.
The logic depends on register's definition in LS1043A/LS1046A's RM.

Regards,
Biwen

>=20
> Regards,
> Leo
>=20
> > >
> > >
> > > > - compatible "fsl,ls1088a-extirq" for LS1088A, LS208xA, LX216xA
> > > >
> > > > Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> > > > Signed-off-by: Biwen Li <biwen.li@nxp.com>
> > > > ---
> > > > Change in v2:
> > > >       - add despcription of bit reverse
> > > >       - update copyright
> > > >
> > > >  drivers/irqchip/irq-ls-extirq.c | 10 +++++++++-
> > > >  1 file changed, 9 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/irqchip/irq-ls-extirq.c
> > > > b/drivers/irqchip/irq-ls-extirq.c index 4d1179fed77c..9587bc2607fc
> > > > 100644
> > > > --- a/drivers/irqchip/irq-ls-extirq.c
> > > > +++ b/drivers/irqchip/irq-ls-extirq.c
> > > > @@ -1,5 +1,8 @@
> > > >  // SPDX-License-Identifier: GPL-2.0
> > > > -
> > > > +/*
> > > > + * Author: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> > >
> > > If I wanted my name splattered all over the files I touch or add,
> > > I'd add it myself, TYVM. The git history is plenty fine for
> > > recording authorship as far as I'm concerned, and I absolutely abhor
> > > having to skip over any kind of legalese boilerplate when opening a f=
ile.
> > Okay, got it. Will drop it in v3. Thanks.
> > >
> > > Rasmus

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD2AB29A349
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 04:26:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504955AbgJ0DZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 23:25:59 -0400
Received: from mail-eopbgr50056.outbound.protection.outlook.com ([40.107.5.56]:14310
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726186AbgJ0DZ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 23:25:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KxHWvd+x7I2Me7OTcNkeisb/zOmrKvzLdZCdLrKFI3jXY5ZUqZiTWUVkY+Fl463SIqQX+4QRtqt5Qp1S3+QopE0zPNaDdhYToHzsqcns+6oIf4oFT3iitV44un2ohXI/FSFZNh9PehKYMjDt2CLZ0FDP/R8q5qCl3qrCmznsItdfC51UmyPWuOvzkQfO6Zk9Ds9Uj2eXwszUiX3SeFWGMUZCOQqrqJCjHrT9lb5AFjLS8HcZdbFAu3tmf03JU5sbkKhN0GxJmf9exx9gxiUkIDBaHAVX8GxMUMm78+YQsZwd9PXd/8tMdkats8QYFlt/5t/Tx0gH0ZumF10JQcLVjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cIvFKeSxsE7TvpPEkqlNeCJ2wY3uoUl6Mt5bxkP91f8=;
 b=MLR8kmLmTRrLme1xPl0IXFdux//O1b4vzCVv+JPhV8zIfs8b45VYx+Y4rUPY2IHxiuemqvKZF4ZHAzoEHapBEZjyJfpblFlWJhzAMpthIA3VHJj8S+9NL2izjmW3ECjETZVYVHiAbj49wmM5Be5AkOATXrEb7nYQNsf7iXVJGsfDGtpiR9l9eG9ZozCYsI6HTxDnEC/8Srjnn+3ZDmWaCyVnSOKEQYoqbMm8Aj5Zkn6+y72Z0PeHe4vaR40w2RYVSgR9iWClz1AeWP/AnJ8Wv/FilhIdvjwf/L33rk4QyRFxnYz6DZe9b8G/lfyJQGVYQTaKJ+wIic7ZInxxCz3Gvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cIvFKeSxsE7TvpPEkqlNeCJ2wY3uoUl6Mt5bxkP91f8=;
 b=UtacdgHwU/gN7mmctx8r6nv/HiTHRG+R1SiiozgKlsHhaEcfN2Q+chugKey20pk0iXLNRMRgWKf2Brog+j8iStLQT/KBroycivQxztlCK/d7RCXC1FiI6YpR77nWfjYKlY9vTsXedDdlipdpE8IzCZhLiM8EwhaGl+LUSBjapQI=
Received: from DB6PR0401MB2438.eurprd04.prod.outlook.com (2603:10a6:4:33::14)
 by DB7PR04MB4729.eurprd04.prod.outlook.com (2603:10a6:10:21::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Tue, 27 Oct
 2020 03:25:53 +0000
Received: from DB6PR0401MB2438.eurprd04.prod.outlook.com
 ([fe80::c8a:a759:d4ba:181e]) by DB6PR0401MB2438.eurprd04.prod.outlook.com
 ([fe80::c8a:a759:d4ba:181e%7]) with mapi id 15.20.3477.029; Tue, 27 Oct 2020
 03:25:53 +0000
From:   "Biwen Li (OSS)" <biwen.li@oss.nxp.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Marc Zyngier <maz@kernel.org>,
        "Biwen Li (OSS)" <biwen.li@oss.nxp.com>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
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
Subject: RE: [RESEND 01/11] irqchip: ls-extirq: Add LS1043A, LS1088A external
 interrupt
Thread-Topic: [RESEND 01/11] irqchip: ls-extirq: Add LS1043A, LS1088A external
 interrupt
Thread-Index: AQHWrBDg23J7/+yWj0uXRQhWZKYN/w==
Date:   Tue, 27 Oct 2020 03:25:53 +0000
Message-ID: <DB6PR0401MB243864E0183E3754D8DF5C368F160@DB6PR0401MB2438.eurprd04.prod.outlook.com>
References: <20201026080127.40499-1-biwen.li@oss.nxp.com>
 <31d8971374c261003aee9f4807c8ac8c@kernel.org>
 <3448c822-31b1-7f9d-fedf-49912418fc3f@rasmusvillemoes.dk>
In-Reply-To: <3448c822-31b1-7f9d-fedf-49912418fc3f@rasmusvillemoes.dk>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: rasmusvillemoes.dk; dkim=none (message not signed)
 header.d=none;rasmusvillemoes.dk; dmarc=none action=none
 header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bd8d203c-9956-4498-ff8c-08d87a2802eb
x-ms-traffictypediagnostic: DB7PR04MB4729:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR04MB4729E5647274D0FC0616D56ECE160@DB7PR04MB4729.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LIUBnn64ReZYHQk7IrFYV2WcZZ1RGMngvqndtmrWq5fGDdxj+x1sUOBsdl0SGMIXRO7q19OSvh7csahYYGRj6vY72Lx4RFV3yhG72XYvC3bt0ZdhlTF1d6nW2Er/FB3ukF75x71ytCp7Cf1lYrTzLMLk6pUuWst7exJobwMG0T0q8H/DkplFp8ioTY3nXMIDris4LouT9O0NOVbaIULkEFeztkqklTwef7E/+/Qu9pP+AFmNlZMujuyjmmtNUGhlcxF/zLX6oG9NsSYUz58Yix3IRGp7s5sm4KsjI1rsWTXg5p/g5GMO7E+1etCxQSMhMUJ2X/6gXFmaGqj5toTK5A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0401MB2438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(136003)(39860400002)(366004)(8936002)(8676002)(186003)(71200400001)(66476007)(52536014)(66946007)(7416002)(86362001)(66446008)(66556008)(76116006)(64756008)(4326008)(5660300002)(7696005)(33656002)(6506007)(4001150100001)(478600001)(26005)(55016002)(9686003)(83380400001)(54906003)(316002)(110136005)(2906002)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 4BRrLiF/xkzP7MQxnyMMzmMj4qAMFx8jKwwOYhgRv1dCxmXfUVVuCe3tT1fOjxM04CFhLu+HkKW5o2ujsyXGwrcbVMNYUJJnavwWHBo67uqp/tH0cqh18Bbh3UTi30TxEj9O+ARNuX0ntKjKduzxthmkx48qVb46lx8Mx8zBcE8bnkmLvFJ0AxtyBqXyhi3s/NydX38GddMeVWrN2q56d+HlDb3jugVWcOvpOqtdSW9zp0m2IOMy1vZjlcMp3bqoPLXhel1Wm5hdNiDFZpn758iqeGIQnNTWbamVn8aPdgthmsxBX58CFV8rXpaRYJJ0FvBme8jAxoXClFXt9zMfhsKXOoNQw7PPVaX8HpgRDDQHfsd6jQhYO9LGUztA9dWAMq3S0NPiA5dnnZd0SkdXj5yFU8JYgCSF68sZi7S+xBTj5wR0/LlT8U3Bk9SMxpH+z3L8cKjeyC2YA0MzfW4I7nuoUfXSsbu+yJjTlIW57wZTo9xVfAShLpNH+Tt0/kpe6njB1zhHCxns/TMV7uBc0WlLRjshV/dl2BR6CB+BAZpDCpbnfRSplCpCPiZxMQvtwM34lB+GbgIFcGIGyV500jKzIa49dHkpzvRZfFDmZuOzv/LeCZEVj1UMQrLh5yGT8Il+yRGyBF5wmZEv3xwHkw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0401MB2438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd8d203c-9956-4498-ff8c-08d87a2802eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2020 03:25:53.7027
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tAahwTeS0lqMDvzh2V7LgKCqfa8K2Xi45Y5FVHfhXEXuDxM9CkazjZQqJJs7usQvwRC8Cp29s8qsgxdb1qVtLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4729
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [RESEND 01/11] irqchip: ls-extirq: Add LS1043A, LS1088A exte=
rnal
> interrupt
>=20
> On 26/10/2020 09.44, Marc Zyngier wrote:
> > On 2020-10-26 08:01, Biwen Li wrote:
> >> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> >>
> >> Add an new IRQ chip declaration for LS1043A and LS1088A
> >> - compatible "fsl,ls1043a-extirq" for LS1043A, LS1046A
> >> - compatible "fsl,ls1088a-extirq" for LS1088A, LS208xA, LX216xA
> >
> > Three things:
> > - This commit message doesn't describe the bit_reverse change
>=20
> Yeah, please elaborate on that, as the RM for 1043 or 1046 doesn't mentio=
n
> anything about bit reversal for the scfg registers - they don't seem to h=
ave the
> utter nonsense that is SCFG_SCFGREVCR, but perhaps, instead of removing i=
t,
> that has just become a hard-coded part of the IP.
Yeah, you are right, I will update it in v2.
>=20
> Also, IANAL etc., but
>=20
> >> +// Copyright 2019-2020 NXP
>=20
> really? Seems to be a bit of a stretch.
>=20
> At the very least, cc'ing the original author and only person to ever tou=
ch that
> file would have been appreciated.
Okay, it's my fault, I will update it, thanks.
>=20
> Rasmus

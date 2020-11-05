Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3904D2A8A5C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 00:04:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732425AbgKEXD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 18:03:58 -0500
Received: from mail-vi1eur05on2076.outbound.protection.outlook.com ([40.107.21.76]:18639
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731899AbgKEXD6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 18:03:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S5kd2hnQC1V1XFWiq1RUEsWPFvHG6meAz9tvJh08/U2EFsFwpabR7UdTwEgX6lgsM965hbotjMdIsq+LT54Ze/kf4iLVdo52giHNeJxrfSO3PSX2274vsg2vTXmg89lsPEnmZzeixcLxvw0UYLeekHQg1H1IToCN+fSgj1PcHstveXeGHjPjq7txUo6DJuXnZ1PqOghtqMCT1Avsy3gOVoW2kp6Xy1hC3z7kAg7k0nYf4sCH8DhrBU5qwYghhbIhqjci+zqOxWjWvk2KR0MpPqrM5/n3U+opSKQ2qODX/SdN4P+/BMFAcHNz6x9BboFDiuOSiZIDQlzkoJ30Ov59xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X4UiCvHmeaUSRHgSSl8Tx5zYj+eSuZrgPdLMJZRYx8I=;
 b=NfmUf62yqEznKjqjECPLrDdz+mgokmg+TU8qoO3oH4oyaByjSgUV9OVYmR2LK6tKBo/C29/s+W9meOaIaejcJCuwjV22oSX/UuKf8k3GpwavoLOulJ5SyY85+9GxvvH69lb7A3h/u80ETPPKZ4WbcmmW5fNUhEZxMXwoiFUhx2fJlYkkkHqBBlpXFLvPjxfNHKAcxr7ORWSOrSgF5F6qoK0qYdNDMR28lE64eWbvPMRxAVkjZJulTL7IDIqATl30wYHf9OjykCpLfb1AImX0JsD4QalDNqCwenBxwA0pUFMXdZiNoqXae6xRnKKgayMWkahGH4UdHQ8FUpDSrZV0Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X4UiCvHmeaUSRHgSSl8Tx5zYj+eSuZrgPdLMJZRYx8I=;
 b=bHsBzJCt6B5XdEMnbc7veQMx/vYpq00zif9FGPRQZ2OOuvTqU3II2ZggaJ0mLS5K1egHnvgVkb8LDcnA2DaweG6fFkKU80CmoWwNijXEoc4FK02kBiTkqZ7WA3Uw508blGMtfDEKp2/Q4vVsM7TX0jvIQIylaejyUMhCiDcUqdM=
Received: from VE1PR04MB6687.eurprd04.prod.outlook.com (2603:10a6:803:121::30)
 by VE1PR04MB7423.eurprd04.prod.outlook.com (2603:10a6:800:1a0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Thu, 5 Nov
 2020 23:03:55 +0000
Received: from VE1PR04MB6687.eurprd04.prod.outlook.com
 ([fe80::b106:ac49:e3c7:6dc8]) by VE1PR04MB6687.eurprd04.prod.outlook.com
 ([fe80::b106:ac49:e3c7:6dc8%7]) with mapi id 15.20.3499.032; Thu, 5 Nov 2020
 23:03:55 +0000
From:   Leo Li <leoyang.li@nxp.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
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
Thread-Index: AQHWrB1r8C3YTVD4gUGfvnOjzP6Q2amrEJ2AgAACOICAANrToIAIeRcAgAD4mMCAALfQAIAEGdlg
Date:   Thu, 5 Nov 2020 23:03:55 +0000
Message-ID: <VE1PR04MB66876B8AF6F0D3C5A583BBDF8FEE0@VE1PR04MB6687.eurprd04.prod.outlook.com>
References: <20201027044619.41879-1-biwen.li@oss.nxp.com>
 <5b1f2911-98b3-511f-404b-7d0fa44cc0c2@rasmusvillemoes.dk>
 <DB6PR0401MB2438ED1C8F629CA1E1F469768F160@DB6PR0401MB2438.eurprd04.prod.outlook.com>
 <VE1PR04MB668790304253EAEEBC1B79F48F160@VE1PR04MB6687.eurprd04.prod.outlook.com>
 <DB6PR0401MB2438DCABBF4892ECF599D4528F100@DB6PR0401MB2438.eurprd04.prod.outlook.com>
 <VE1PR04MB6687738526B56F3F0E6812C58F100@VE1PR04MB6687.eurprd04.prod.outlook.com>
 <03dc38bb-b83a-7926-60dc-61152a3ac967@rasmusvillemoes.dk>
In-Reply-To: <03dc38bb-b83a-7926-60dc-61152a3ac967@rasmusvillemoes.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: rasmusvillemoes.dk; dkim=none (message not signed)
 header.d=none;rasmusvillemoes.dk; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [136.49.1.200]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f914dcfe-3c47-4013-53cf-08d881df1206
x-ms-traffictypediagnostic: VE1PR04MB7423:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VE1PR04MB7423E4EA2E0B6C1225DD84528FEE0@VE1PR04MB7423.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1850;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zm4lI6RlgPd7V7ST5/pJBUHO1Br9HEnCHQnIIlYW7GV7TKjlX3Zt9bmlPV+8VQrx+LocCCS6hoeR65ezlOFqLVm1dDc8Y4tj+jIdDUWDvhKUHhAGx23TeO8bQmaczjgs5p/RMkudftf6EENVWFpejxUo/KtDsvsionmizcZByCA+YemY9avLOz+p4FdgFIjzQUQyJTKqlRSAuv5UxStcopPYGyFB/ytHSqSYL+1miY8ZpFEs7ghEejZBspmgD28VhS8G9kFkRAH6hFzcVtpdSNvC68DnYMOkMV3hMgRyO8R4IyhCOIvdpo9ogaghhjz/u5avihe4JwuyL5UQh3ozhQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6687.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(136003)(376002)(39860400002)(396003)(7416002)(4326008)(66446008)(7696005)(316002)(71200400001)(110136005)(66556008)(66476007)(54906003)(8676002)(64756008)(26005)(52536014)(33656002)(5660300002)(53546011)(6506007)(186003)(8936002)(83380400001)(2906002)(55016002)(66946007)(9686003)(478600001)(76116006)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: uY4ozb0s1qZQKtfPJmer/sAMopTqogkY+4poVJ8e5XMkaxr8nNjcbtgmyiSLslTzio/RS3oJEQeuKiBsPzStaY/9ckE4sVr3pBtZGWAwpkj7fzz33uC24AvZpOiWH44laDFrT0Wx5R7KlyN1YJPIMI8/ypPF7HEWFbcF7UGl/72Ve/dI6F5NgxyFeIVlmLV7hbN05J/uaF4FRyqzp3Qwk+QNq6ivVaMTOqoA4FdkpooazU/hLC+2rxNiq2YF3z7l6GHnA2ULjCMa7FAK8xoHNK0tUgzXuygEFeY0Lz3agKQERpjKUCSohAjtz7azgpGl5PmY59Tj2Nn0KZ7UX18CuQmGmpK46+ZpkxRAQ7BPs8SBRCcmvbh/npNwuF17MJmhlG+DmNq27gONYXKokXC7cc/gVD1is1oKd8sinVfLWTLpEf5uxfZitrwd7EOAjaRWZh2XU8eeS4VeQ7IvZp23as4PnVNbToo5LVKoNgYUAbkmrHLGMZ8NqiTmn/seykTRcrFfxwPLsp6jJEDwa94safCUVwA95dU71CIPo1ZPs6rALfkOFv35Wst1SBPyvoDyjg+SSgcHBhaaA2lGrCxCFJsDXtdF2AVkScNTZVSZ691cDaWi8VAI62u545vElp7tix1ejHRncCCaKaJW2DCK0w==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6687.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f914dcfe-3c47-4013-53cf-08d881df1206
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2020 23:03:55.1740
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R/c2+SN03HAJuHrsjDclAncHRTYOGJXpsewqBgfkz8C7ySME1gI8ruqpo1cZezZmaGjtW+xOKcaJMEO5j52NnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7423
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Sent: Tuesday, November 3, 2020 2:03 AM
> To: Leo Li <leoyang.li@nxp.com>; Biwen Li (OSS) <biwen.li@oss.nxp.com>;
> shawnguo@kernel.org; robh+dt@kernel.org; mark.rutland@arm.com; Z.q.
> Hou <zhiqiang.hou@nxp.com>; tglx@linutronix.de; jason@lakedaemon.net;
> maz@kernel.org
> Cc: devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; Jiafei Pan
> <jiafei.pan@nxp.com>; Xiaobo Xie <xiaobo.xie@nxp.com>; linux-arm-
> kernel@lists.infradead.org
> Subject: Re: [EXT] Re: [v2 01/11] irqchip: ls-extirq: Add LS1043A, LS1088=
A
> external interrupt
>=20
> On 02/11/2020 22.22, Leo Li wrote:
> >>>
> >>> Where did you get this information that the register on LS1043 and
> >>> LS1046 is bit reversed?  I cannot find such information in the RM.
> >>> And does this mean all other SCFG registers are also bit reversed?
> >>> If this is some information that is not covered by the RM, we
> >>> probably should clarify it in the code and the commit message.
> >> Hi Leo,
> >>
> >> I directly use the same logic to write the bit(field IRQ0~11INTP) of
> >> the register SCFG_INTPCR in LS1043A and LS1046A.
> >> Such as,
> >> if I want to control the polarity of IRQ0(field IRQ0INTP, IRQ0 is
> >> active low) of LS1043A/LS1046A, then I just need write a value 1 << (3=
1 - 0)
> to it.
> >> The logic depends on register's definition in LS1043A/LS1046A's RM.
> >
> > Ok.  The SCFG_SCFGREVCR seems to be a one-off fixup only existed on
> LS1021.  And it is mandatory to be bit_reversed according to the RM which=
 is
> already taken care of in the RCW.  So the bit reversed case should be the=
 only
> case supported otherwise a lot of other places for SCFG access should be
> failed.
> >
> > I think we should remove the bit_reverse thing all together from the dr=
iver
> for good.  This will prevent future confusion.  Rasmus, what do you think=
?
>=20
> Yes, all the ls1021a-derived boards I know of do have something like
>=20
> # Initialize bit reverse of SCFG registers
> 09570200 ffffffff
>=20
> in their pre-boot-loader config file. And yes, the RM does say
>=20
>   This register must be written 0xFFFF_FFFF as a part of
>   initialization sequence before writing to any other SCFG
>   register.
>=20
> but nowhere does it say "or else...", nor a little honest addendum "becau=
se
> we accidentally released broken silicon with this misfeature _and_ wrong
> POR value".

Yeah.  I do think they messed up at the beginning when trying to integrate =
the big endian registers on little endian core.  It is good that we are doi=
ng it correctly in later SoCs.

>=20
> Can we have an official statement from NXP stating that SCFGREVCR is a
> hardware design bug? And can you send it through a time-machine so I had =
it
> three years ago avoiding the whole "fsl,bit-reverse device-tree-property,=
 no,
> read the register if you're on a ls1021a and decide" hullabaloo.

I'm not sure if it is possible to update the related documents right now fo=
r this.  But definitely it was not your fault to have introduced this in th=
e driver due to the confusion from document.  My suggestion to remove it is=
 just to prevent this from causing more confusions in the future as this dr=
iver is used on more SoCs.

Regards,
Leo

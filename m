Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0B4229907E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 16:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1783135AbgJZPG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 11:06:29 -0400
Received: from mail-eopbgr40064.outbound.protection.outlook.com ([40.107.4.64]:10254
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1783102AbgJZPGX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 11:06:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BcMdB30MMo1U9Jwv7ei6yn78xnaDd1pS5UHl+pIp7+Z4Ct6qXyDHEN9GQeorAPJjFv9/H7ehJGcNzetlS+V119zKJO11+0q5njzpZVWjPyjo/tueT0SVWWe2Fg0KkSxeWZue8mUegj7O28b+3IpGiHvtO5qzXT2eCNbCVRK8DJM3nAylW+4jiWuyIRmi0/OHQSaJUBkB4sEMu4ftFECayrxrI/hN26NlzjkToZPhj6Un7OjxjjXeaamkxYiPo8Yb3r7EouODZYlPn0hE5u6MjuUceJoJpiVkCtY5Qa2vdwqjFToOuKVGHPX4j1R8BXf1Dr/VzpjcakxnubXlkMD7oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AFM6H8nJ/hzKj2ENuIqfnOu96VVRIFJFFvIpqag1HX0=;
 b=g0F8hGYW7gQs6ysBDGZFZP8qZpELPeFhq6N0NIDg9/uSHLugUPiJW2B3RbHQ9NJfSLL9/BqI9bbzEEajp+gePPrfJAUXAaqLYQG4DsP91EJXmi8D2jeEGWcMwaJ1Z/YKr0sYkGMruOBC6THUT7l4AQPc/LYPHTPCzK3I5TbAHVywwMP5XEMBeNrE9EkSOtD6OpxHD0wYP356TmT5PCN4BLJ0/co6dGfjpeBk5MedAbv4z+QHtFs9OS+x68mprKUYtb1qC/5cB+SCVdyvRu6mq2D/hDGVss7P8Nm4XTGMJvYmDZDjniRst4k++5eYLuE1LN69QikpbNKv46+npnPDew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AFM6H8nJ/hzKj2ENuIqfnOu96VVRIFJFFvIpqag1HX0=;
 b=cbC084ppyzRYbVI6pnuuWGIof5ywd6OrGeTxVWuN61vRiY/4pMOIcC3sMB1H7Zx9G7zPVhwvV3ly/Km9EG6LJtq1rBtnJYXEoa3uwu8u3BcahpWaojwaT1v/hvUa75iSEqzatOJedELxxkTrPk8l7qQtBOgognHXLNXHDactDCk=
Received: from VE1PR04MB6687.eurprd04.prod.outlook.com (2603:10a6:803:121::30)
 by VI1PR0401MB2495.eurprd04.prod.outlook.com (2603:10a6:800:52::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.24; Mon, 26 Oct
 2020 15:06:19 +0000
Received: from VE1PR04MB6687.eurprd04.prod.outlook.com
 ([fe80::b106:ac49:e3c7:6dc8]) by VE1PR04MB6687.eurprd04.prod.outlook.com
 ([fe80::b106:ac49:e3c7:6dc8%7]) with mapi id 15.20.3477.028; Mon, 26 Oct 2020
 15:06:19 +0000
From:   Leo Li <leoyang.li@nxp.com>
To:     Marc Zyngier <maz@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
CC:     "Biwen Li (OSS)" <biwen.li@oss.nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "Z.q. Hou" <zhiqiang.hou@nxp.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jiafei Pan <jiafei.pan@nxp.com>,
        Xiaobo Xie <xiaobo.xie@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, Biwen Li <biwen.li@nxp.com>
Subject: RE: [RESEND 01/11] irqchip: ls-extirq: Add LS1043A, LS1088A external
 interrupt
Thread-Topic: [RESEND 01/11] irqchip: ls-extirq: Add LS1043A, LS1088A external
 interrupt
Thread-Index: AQHWq2+CLg8O51zq50exYYqsZaIXIKmpkXkAgAAGWgCAAARoAIAAW4Tg
Date:   Mon, 26 Oct 2020 15:06:19 +0000
Message-ID: <VE1PR04MB668737DF1DDA6E1007BCA24C8F190@VE1PR04MB6687.eurprd04.prod.outlook.com>
References: <20201026080127.40499-1-biwen.li@oss.nxp.com>
 <31d8971374c261003aee9f4807c8ac8c@kernel.org>
 <3448c822-31b1-7f9d-fedf-49912418fc3f@rasmusvillemoes.dk>
 <b65acafab54b62a2a22aa942089b8033@kernel.org>
In-Reply-To: <b65acafab54b62a2a22aa942089b8033@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [136.49.1.200]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d49ba7c7-2108-41e8-276a-08d879c0b197
x-ms-traffictypediagnostic: VI1PR0401MB2495:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0401MB2495CDFE880982746E40189D8F190@VI1PR0401MB2495.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Cvkd+eF+ZJQTW2q6nHerTWVBspP7ldSOeWtwVVc9jOGV4kofP9HXlEmMSX2l4XcfPpQobRDIQ4VcqB1EGMKC6Pk2YhSh/OLnWsvGTprG13H5bZ917OHkfpCzXZNz+Fi7iSaHaQziJm0zBv7IVMdkKShP4McLTAhhEUz9OVUDjTkZUxTIeEofalnGoxi7ZpKjyou7PbjPhvSEt94peGJH4blEiJEaDSBNdeFV8IQfJmn9kHlEcbGfL5ceDp4sDZOmh2MJpCiWXySTc3XdnVaq0tYmpu8Y4+OK/ZuEO0ouVVLjJ9GoUx6YlHZYkjzbtEjeoaZBZz8G+eC6d1/4/H6qkA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6687.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(396003)(346002)(39860400002)(376002)(7696005)(8936002)(66946007)(2906002)(6506007)(71200400001)(7416002)(5660300002)(66476007)(54906003)(110136005)(33656002)(76116006)(55016002)(53546011)(86362001)(66556008)(8676002)(66446008)(52536014)(26005)(4001150100001)(316002)(83380400001)(9686003)(4326008)(478600001)(64756008)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 2TBpK8CIrpefELnJrQKmmqJJ2Ppj9P12PhN4fJ/2+xiGyoGwc93wTZyj+Cj/74GSQxi5Id0oAfxcfoQDPm+quGWJSnxm1F9fJWmW6cF3Ya88eHNmq7hU7ynRMSHEbCro4zFJipqBGCLSFwncIC0JEM+pEvVZIaDQr+M7H4wyOhEgTJnm4Pnk9mWFy4Rk4BblR0MGSe7txzPMQu+x3labE+DEw9QjmbIicuLpL1G5IScOJaH7Ng6Z9BboKXv8W3X0XV03NhWfCAr1pmIi5gIX/NwRiUZRULZrJ7ggWrivMLBj0GmhqlinGsyl68IzXj736eRk7t+D5PJnwnWlvaWsTfcr3g4mxcgvaFYZ4oa5hDQ7hUbpstDOcb+jtP/Z6RXtNfuNDPiX5SNiphCIieO3uACKWbCdT98TQ8eMkhQIHYAOmE0BV2nxJgu0dJWpPjK6Srumglh9iWhSq80vLwD3thMkppms6NJr9n5z06m3PWJ+0j3Kpt7grmfc1Wah5oMxy4CxNjDS9ElIPhnN9oWtmo8S0Y3/z2dFB6SKQQLPjs5eUJKobe/W+/TcvyNXQAzDeYGVgDB7ksyqUwrc+NkxAMoYt1MeHHvkic1tIxpPzyJl3Mt5VithDnk6z6soff6j9fZiUIwMDp5XdyHSM4zLMA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6687.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d49ba7c7-2108-41e8-276a-08d879c0b197
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2020 15:06:19.2200
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pO3sNqIA1a0FenjWcGu0WlGd9VKiwl6hRidB/n+pUkI2DbGR3Eeqt4+d+R72rGwa1Vx9YmB5lDMLeKnhTUIjPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2495
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Marc Zyngier <maz@kernel.org>
> Sent: Monday, October 26, 2020 4:23 AM
> To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Cc: Biwen Li (OSS) <biwen.li@oss.nxp.com>; shawnguo@kernel.org;
> robh+dt@kernel.org; mark.rutland@arm.com; Leo Li <leoyang.li@nxp.com>;
> Z.q. Hou <zhiqiang.hou@nxp.com>; tglx@linutronix.de;
> jason@lakedaemon.net; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; Jiafei Pan <jiafei.pan@nxp.com>; Xiaobo Xie
> <xiaobo.xie@nxp.com>; linux-arm-kernel@lists.infradead.org; Biwen Li
> <biwen.li@nxp.com>
> Subject: Re: [RESEND 01/11] irqchip: ls-extirq: Add LS1043A, LS1088A exte=
rnal
> interrupt
>=20
> On 2020-10-26 09:06, Rasmus Villemoes wrote:
> > On 26/10/2020 09.44, Marc Zyngier wrote:
> >> On 2020-10-26 08:01, Biwen Li wrote:
> >>> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> >>>
> >>> Add an new IRQ chip declaration for LS1043A and LS1088A
> >>> - compatible "fsl,ls1043a-extirq" for LS1043A, LS1046A
> >>> - compatible "fsl,ls1088a-extirq" for LS1088A, LS208xA, LX216xA
> >>
> >> Three things:
> >> - This commit message doesn't describe the bit_reverse change
> >
> > Yeah, please elaborate on that, as the RM for 1043 or 1046 doesn't
> > mention anything about bit reversal for the scfg registers - they
> > don't seem to have the utter nonsense that is SCFG_SCFGREVCR, but
> > perhaps, instead of removing it, that has just become a hard-coded
> > part of the IP.
> >
> > Also, IANAL etc., but
> >
> >>> +// Copyright 2019-2020 NXP
> >
> > really? Seems to be a bit of a stretch.
> >
> > At the very least, cc'ing the original author and only person to ever
> > touch that file would have been appreciated.
>=20
> Huh. Well spotted. That's definitely not on.
> NXP people, please talk to your legal department.

We do have an internal policy to require developer adding/updating NXP copy=
right on non-trivial changes.  I'm not sure if this change should be consid=
ered trivial, but adding copyright claim on a file without prior copyright =
claims could causing confusion like in this case.  One potential solution i=
s to add a more specific description on the NXP change together with the co=
pyright claim.  But maybe an easier solution is to add Rasmus your Copyrigh=
t claim first if you are ok with it.

Regards,
Leo

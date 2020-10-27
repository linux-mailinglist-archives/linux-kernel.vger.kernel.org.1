Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 897C029A30E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 04:14:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502372AbgJ0DOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 23:14:14 -0400
Received: from mail-am6eur05on2051.outbound.protection.outlook.com ([40.107.22.51]:63942
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2409229AbgJ0DOO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 23:14:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VIjP+SVQhfYw4Sgnuef4tsK3mN+W53axWPpkQVapHkftcjVvF417G7/eV4XgQ4HJ1agJIZ9NxU/CcFCB+gsBxGrhrQpqAt6JRdQ5Rxm731Yf1QIfnnxH3C9hXu+CJESDOOfKB0boZghczmNHxD5yG7+8xdufLoIxCVYJbxR7C1SySMp1rY4WFQ6SlgAwSc6OP1R9sIJZStMcmlvbqwl6vc0xatQts8YjLv5k2tF9/41FoHpyUA+SbhZLP70k++h8IRNlLW8CV/PTc7uyPd8WaT8EgQ0qfnqQPJo/WZLMw122TbaUK7mUfImw3DYnoNZXtLe+Q28WGgvOY/DUB+2myg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HKi2HMqfmNOmz0tn0d04bFFbjloRXz7aq4/Fj24zPAA=;
 b=XxMPWef3bdZFtdgyVgBFmbRPiuUjTAf7ftOcMVIuyR3DvgigTidjXeNncCzEoq2WPa6vvxSzTECfaqv8Jv28RCKgHIjSGE68J5RL35N31kBCd8HKKOdsQ088JHBM36xD5/oIzUccFcdoMhYO3xN7iV8hVayDNA3QJDvJbxV8RPNmcLo8rUwhlNh3H3vsCWUthOve0aGq7dmo4IsiZaRHhAqdma9mTySSadO6rTFbWaEMxUkAhHsFIt3ecJBp94rIKN5StRHEW1Zp6snpjQg+bMr871zXcfULV7afJsqei367MJ0ArUEZy2mNP7/nFy8csSU5BPoCDoox6liyLvZhmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HKi2HMqfmNOmz0tn0d04bFFbjloRXz7aq4/Fj24zPAA=;
 b=k3B695qAfroQm3hde7hELyCbw/d/DGbILv2h94onjQm6rMexeArJIGm1XvFHZ1niU8jtQ3Eo1zoyGO+qR708fvIF5LbFMohWBD1ltIPq6Q5uo/pGpLvbChRBpeGW9QVVGRjf6LKBX6DJziBq8CVj9APKuIki3kFEVCm5km//N90=
Received: from DB6PR0401MB2438.eurprd04.prod.outlook.com (2603:10a6:4:33::14)
 by DB7PR04MB4058.eurprd04.prod.outlook.com (2603:10a6:5:1b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.25; Tue, 27 Oct
 2020 03:14:10 +0000
Received: from DB6PR0401MB2438.eurprd04.prod.outlook.com
 ([fe80::c8a:a759:d4ba:181e]) by DB6PR0401MB2438.eurprd04.prod.outlook.com
 ([fe80::c8a:a759:d4ba:181e%7]) with mapi id 15.20.3477.029; Tue, 27 Oct 2020
 03:14:09 +0000
From:   Biwen Li <biwen.li@nxp.com>
To:     Leo Li <leoyang.li@nxp.com>, Marc Zyngier <maz@kernel.org>,
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
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [RESEND 01/11] irqchip: ls-extirq: Add LS1043A, LS1088A external
 interrupt
Thread-Topic: [RESEND 01/11] irqchip: ls-extirq: Add LS1043A, LS1088A external
 interrupt
Thread-Index: AQHWq6mP+ALMp9rpPEmvsss83oVh0Kmqxp/Q
Date:   Tue, 27 Oct 2020 03:14:09 +0000
Message-ID: <DB6PR0401MB2438DEFC7410BB75B1F89E528F160@DB6PR0401MB2438.eurprd04.prod.outlook.com>
References: <20201026080127.40499-1-biwen.li@oss.nxp.com>
 <31d8971374c261003aee9f4807c8ac8c@kernel.org>
 <3448c822-31b1-7f9d-fedf-49912418fc3f@rasmusvillemoes.dk>
 <b65acafab54b62a2a22aa942089b8033@kernel.org>
 <VE1PR04MB668737DF1DDA6E1007BCA24C8F190@VE1PR04MB6687.eurprd04.prod.outlook.com>
In-Reply-To: <VE1PR04MB668737DF1DDA6E1007BCA24C8F190@VE1PR04MB6687.eurprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5aafe518-a6bf-48fd-ac5a-08d87a265f51
x-ms-traffictypediagnostic: DB7PR04MB4058:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR04MB405863FAAC1EDA2910DD95098F160@DB7PR04MB4058.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1HX5VTjgkNW3FfRNaSSBb5aGZXgURQX2bVndsIKF9SBsiVV7lfItE0NfkuA6n3v4Lvp9cndu2EC5wyxG1pAuVCckOIv/H3Qgl/JtRumqRpf/RbqbzgXTgFzSvrOLdT2sBDtiRFrsL1VBK2Mf3G8JV7WXGhrUEDnvtj4hYuIxp+KKe1G59prn32YaXgjb7m2o0GXwLaZ2HKHUyDLf0pfl5VUZ5q3B4dFbqpnxBnWJ8urRXcfbKfBP+irwpaMLWW00oFHox+1qKdvN7oy9Wtxq9Y0diFj3LpuCPuhfs5Ci4KtcGxJ8bfiusq4DflZ7vojs4tJfrgoHhJxikvQr+F2J0g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0401MB2438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(396003)(136003)(376002)(39860400002)(44832011)(64756008)(71200400001)(8676002)(55016002)(54906003)(7416002)(316002)(478600001)(186003)(8936002)(66946007)(52536014)(110136005)(26005)(6506007)(66476007)(66556008)(53546011)(86362001)(7696005)(83380400001)(5660300002)(9686003)(76116006)(4001150100001)(66446008)(33656002)(4326008)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: qeKIfy4AcNNP+GYd5pZ1D4pmnNBLG+5kFysesogFJxsgKPC4k354dQwdFlz5jZ6HG2XeXf0U5FvpFRFBCBYB7VIh3Z04/ea5My1fSZ+/kIMzQ5YZfmfivS3xKvQcV+vL+c8LBGlpqDYQ1MzKprLOVjADAciOutOhfwuNnX/qS2Lu1gxAAbWZwuS2KFp4gOTRU3yVCM5iwzBGpwWW7JEWcp27awDU5nopUXqU3ZPyWG3aC2Qztaued3WDXUu0uTMLf6TY2AF6BZY+CwOOh6g+X4NFX1wEHwU0QljeBJjtgKhoocmCyzi0edihAPmsLXIMEUruN0HpY4oV/k5ESEBEuYWXvz8bm8R+YQSLHi16S8NJSZHC3BtCfZzQ7anQGxIJteVlNOUsezvUQyZVCgrfOZ8/4L71DCsXG+/+DWehqX2uQjVuJg2rCpT4nCDWaiFAg1xcTL2HDtNM9/z5TXAiJfN1WcCj/AlOxtGrpZecbUdcjNVBN6wiPmwFLb6O/ajClZt2E2X/kvLv/s5oraQAyRzBukirnU8OwgHVD0uBf//eJE0RDdAfu9hWkrF+N3Hdqno+ntKgF3bwsHxdiiFZvzo3tbFIKbuMZDxS6aCwuCJHzn2kvaEneEMT4YqEeGq0Po6X2LAYSGIxf+jXN6qY7Q==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0401MB2438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aafe518-a6bf-48fd-ac5a-08d87a265f51
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2020 03:14:09.7329
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TadxpEu7fy2pD4VBtBVPZtyWq0ksLzKS/vaPD5xYKd0ufGdcgPNi3tiZWNYkIIQjnjRT9qOVcvhBHaz84WPI7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4058
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > -----Original Message-----
> > From: Marc Zyngier <maz@kernel.org>
> > Sent: Monday, October 26, 2020 4:23 AM
> > To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> > Cc: Biwen Li (OSS) <biwen.li@oss.nxp.com>; shawnguo@kernel.org;
> > robh+dt@kernel.org; mark.rutland@arm.com; Leo Li <leoyang.li@nxp.com>;
> > Z.q. Hou <zhiqiang.hou@nxp.com>; tglx@linutronix.de;
> > jason@lakedaemon.net; devicetree@vger.kernel.org; linux-
> > kernel@vger.kernel.org; Jiafei Pan <jiafei.pan@nxp.com>; Xiaobo Xie
> > <xiaobo.xie@nxp.com>; linux-arm-kernel@lists.infradead.org; Biwen Li
> > <biwen.li@nxp.com>
> > Subject: Re: [RESEND 01/11] irqchip: ls-extirq: Add LS1043A, LS1088A
> > external interrupt
> >
> > On 2020-10-26 09:06, Rasmus Villemoes wrote:
> > > On 26/10/2020 09.44, Marc Zyngier wrote:
> > >> On 2020-10-26 08:01, Biwen Li wrote:
> > >>> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> > >>>
> > >>> Add an new IRQ chip declaration for LS1043A and LS1088A
> > >>> - compatible "fsl,ls1043a-extirq" for LS1043A, LS1046A
> > >>> - compatible "fsl,ls1088a-extirq" for LS1088A, LS208xA, LX216xA
> > >>
> > >> Three things:
> > >> - This commit message doesn't describe the bit_reverse change
> > >
> > > Yeah, please elaborate on that, as the RM for 1043 or 1046 doesn't
> > > mention anything about bit reversal for the scfg registers - they
> > > don't seem to have the utter nonsense that is SCFG_SCFGREVCR, but
> > > perhaps, instead of removing it, that has just become a hard-coded
> > > part of the IP.
> > >
> > > Also, IANAL etc., but
> > >
> > >>> +// Copyright 2019-2020 NXP
> > >
> > > really? Seems to be a bit of a stretch.
> > >
> > > At the very least, cc'ing the original author and only person to
> > > ever touch that file would have been appreciated.
> >
> > Huh. Well spotted. That's definitely not on.
> > NXP people, please talk to your legal department.
>=20
> We do have an internal policy to require developer adding/updating NXP
> copyright on non-trivial changes.  I'm not sure if this change should be
> considered trivial, but adding copyright claim on a file without prior co=
pyright
> claims could causing confusion like in this case.  One potential solution=
 is to
> add a more specific description on the NXP change together with the copyr=
ight
> claim.  But maybe an easier solution is to add Rasmus your Copyright clai=
m
> first if you are ok with it.
Yes, added a wrong Copyright.
>=20
> Regards,
> Leo

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B473827E42C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 10:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728577AbgI3IwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 04:52:01 -0400
Received: from esa10.fujitsucc.c3s2.iphmx.com ([68.232.159.247]:60108 "EHLO
        esa10.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725872AbgI3IwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 04:52:01 -0400
IronPort-SDR: A08Pc0w0ft4BXGZ4ANPOAZg7mtSbbrbqjmV9koaA91KfBjK8iNK0KhC1vSZEObf+stdxN/LbzI
 x1on3657QyxaiYF5uIwVuUV5PKFdgSDKBzk9gPu+douJhoEBCjakc7iSv8LqW1fiju8qfyp6m1
 bHwEFcGkDT/vgraMcHVydlMLZ5i+795eYIWsTZEbl8EU44h5hD54UPR0wyyN6T2Q5p5y5Hk7zb
 GntggPLm03lTtvs6DB7hVVjh154sXUZLXrShbT4rBojAgPESzdmlp0Lyo8BZkhMrlR1S+vtacb
 3Ys=
X-IronPort-AV: E=McAfee;i="6000,8403,9759"; a="18862067"
X-IronPort-AV: E=Sophos;i="5.77,321,1596466800"; 
   d="scan'208";a="18862067"
Received: from mail-ty1jpn01lp2051.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.51])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2020 17:51:56 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OZ9qo3/hTW0o6Z+eqAl+L+ScB2zvqnURJyiQsuxPDEQmM9K88r8XbrJbc/DpmzSd4dASzz86VR63dfhyXMxssWd2NCfvDL3VgYXYVKRlIPt/pK99DOl6z6vt8tEerO/+sfJo32hSfGmQaEQnn+OI4A9dFbtCQ9kgSC2OV7obdFpEMwDql+rSIOf5/E58L88ry64siF+YZEsL32yj6j2KafnVq3hNfjZl0HktCTPQa/R0tHDrbYNGQI590oYZEXrUbgAdqZDM0E1k5mWm9D7roeEJqTeI9+MEhPe7Ey2ZaSbAfqTTj+Joei+UrsWiC2+eYUL0tt08QwCye0NNM5Hwyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fR57kZ/b/NJ7Fp+m33DoRyrChak8jbLgCnslQuHKHX0=;
 b=Hkk4GCLusNNz5Q/Msi0tgBHir+9aK6KpbtaY3qRKfj+f2NJUjwooLpSBLDMatiUYIxk/yu3ewsH98vI5mAAtXf0StABJ7bCzuuTadU+Z6svHltiQiQX1QxEqfaLGl+sum/EvDRVA6RibMomkpeAZkGUZ2/Z8kNPLJvgCmfhbzFhwVApqd+yRVTZYQgTHdbRICiqho5EAmC9A29UVplOWmxjkmaVn4QnZYxpuHsPf/AFzd6ijJJvvUKWSnJ/9rpwnJP+dXHoBPSoypXSLav2qCH+NEAbX3L/HPNunh3cBCwRFFApMMRLwVVpN5IIP0w1KhwgVckD9dil4Yp3wgn3oSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fR57kZ/b/NJ7Fp+m33DoRyrChak8jbLgCnslQuHKHX0=;
 b=ZaV2R5gC6qL57Fb/30XXKLGFB+1D+2YT+eOMOKZNE8KLsikvZSXbnV6XhX6KBoKV5Lx6th13+Vq0Dm9I71YePgycJQ9Sh6ry786543Zlu181pKxD1CjDQMIf9VMRNEyfjSyapJsy/dCilERgqC4E3G2Ve+iFUbl8knTp/Qv3Kb0=
Received: from OSAPR01MB4227.jpnprd01.prod.outlook.com (2603:1096:604:58::11)
 by OSBPR01MB4741.jpnprd01.prod.outlook.com (2603:1096:604:39::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.25; Wed, 30 Sep
 2020 08:51:54 +0000
Received: from OSAPR01MB4227.jpnprd01.prod.outlook.com
 ([fe80::b5c4:75d0:68ff:e400]) by OSAPR01MB4227.jpnprd01.prod.outlook.com
 ([fe80::b5c4:75d0:68ff:e400%6]) with mapi id 15.20.3412.029; Wed, 30 Sep 2020
 08:51:54 +0000
From:   "ito-yuichi@fujitsu.com" <ito-yuichi@fujitsu.com>
To:     'Marc Zyngier' <maz@kernel.org>
CC:     "sumit.garg@linaro.org" <sumit.garg@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/2] Enable support IPI_CPU_CRASH_STOP to be pseudo-NMI
Thread-Topic: [PATCH 0/2] Enable support IPI_CPU_CRASH_STOP to be pseudo-NMI
Thread-Index: AQHWki1OzvWvE6qquUyffKCpvoCHGKl9XDZAgABqwgCAAQTGkIAArc6AgAFayhA=
Date:   Wed, 30 Sep 2020 08:51:54 +0000
Message-ID: <OSAPR01MB4227CE6CC27B4EF48539E4548F330@OSAPR01MB4227.jpnprd01.prod.outlook.com>
References: <20200924044236.1245808-1-ito-yuichi@fujitsu.com>
 <OSAPR01MB42279E9BFA43419F49231ECE8F350@OSAPR01MB4227.jpnprd01.prod.outlook.com>
 <498b10b51f5c961f00b3d18e17c52e94@kernel.org>
 <OSAPR01MB4227204DB45A285761B520998F320@OSAPR01MB4227.jpnprd01.prod.outlook.com>
 <74f6c812041970cb8f5e8c0da22fca92@kernel.org>
In-Reply-To: <74f6c812041970cb8f5e8c0da22fca92@kernel.org>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fujitsu.com;
x-originating-ip: [210.162.30.49]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bdba938a-d33a-4ca2-15ca-08d8651e14dc
x-ms-traffictypediagnostic: OSBPR01MB4741:
x-microsoft-antispam-prvs: <OSBPR01MB4741B371D0C13B076830C2168F330@OSBPR01MB4741.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m/ecOW6oAvruK/VndO79o7IUDL6o9iT7Hu1EJKIWDKUBxUeofvViTpO+FCVC/GjP28467WJtVxOAC5I3aO0awqe27PlFbZlnP5QM/5bf/SlAcnSv7FSmzvdu2/ZowInpkbOwG2L41dbX1l408EQXQMtUm7qU/AFc8NOM+VS4LlJovovVgxTbbsB8zeGlSRztkCvfzgNYxKFLvOcPzWw+LXy+fmMhsrXgZpvOcQspmgx4h0uTsGGRthi48/qEO/SGVT0B0jJUmywBmpLXiaW7iLKdczssL78lfZarkMMmlIrEyFIBoM4NvnJbDK+MLVjnO1meegUYOUJCQWMvjkIiXWbrmvXo8hUjVu4FZxy8uWP4cp9smzGAtd4O9FJllswnBirDgm+RImL+ED5kg2rQQHw9JaR2S8xXIiDtWc5BIjk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB4227.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(376002)(346002)(396003)(39860400002)(4744005)(76116006)(6916009)(33656002)(8676002)(86362001)(8936002)(5660300002)(85182001)(54906003)(64756008)(66946007)(66446008)(52536014)(66476007)(66556008)(316002)(83380400001)(2906002)(478600001)(6506007)(26005)(71200400001)(53546011)(186003)(4326008)(7696005)(9686003)(55016002)(777600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: eid0+3k0tdjpEUhm9BuPZoslcoyDGgVQuUuyov0Jy3Ndi+YWIqQno7Ma/7T2RdmKPBHyEtwCbavTGcsjixCL9E8SLFEnP+g5hYqicOWoo2cGa1HpFiVp1nR3l8Jom3E2cGGImNX3TJsYYJQpDcy5qLhxGtqe0bA113EeDvcpscTiNToAV0Lf3O3sTXoR00nXEvg4Ity8oR/O5x391KTpJHjznms69TptfSPKJaVnKbvLYS3GhBCbnXWEqn+QKVAmDebUJWcrk1B4UKSlVCl/jCcDoakGUz+A8nbN7T4xyXMADWeG0SJChxWVwerD4ehLgL4H/hyhdH4R9LrAF10Kb7Fmo3dbwnNnpNKyXDZZDGWQP5QN+BmahgkAoQx8ssHJiEmZjJdZ4gJusMLnj/fsbOeiQeXVyaosPOGSCSmQAKyB0PWAWWM2H9w5q4ICJVlQKhI3lytYVlDjBj84dSUaH81StCLPGzHVYGSF8En+00s/TCj1oNFHata6wLPOdLFZmFi97LsWkdE8beR+PwrJBw5efHezdgFrTMY00ME5YO2wrVaogSScfo3p9gdBXHF30fB0hv0boC88wJyowBJrAiG5L0Mt00YCQQh9iSWM8PfWCyJ0H4aTMn1aeJYmLiGr5dAYgBeuyygFgKDu871pmQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB4227.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdba938a-d33a-4ca2-15ca-08d8651e14dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2020 08:51:54.5587
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pnfXPRjPIebiRT1GjAPSwil/tPfL48OfpzBxBCg28zw8YZDULcDtpULmPTS/Ls0uMNjp7S0Dr3NDHAlzq1WL7cJg2TDc6Sbn0k7zk5A9f7s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB4741
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc

>=20
> On 2020-09-29 06:50, ito-yuichi@fujitsu.com wrote:
> > Hi Marc
>=20
> [...]
>=20
> >> >> The patch has been tested on ThunderX.
> >>
> >> Which ThunderX? TX2 (at least the incarnation I used in the past)
> >> wasn't able
> >> to correctly deal with priorities.
> >
> > I tried it with ThunderX CN8890.
> > If you tell me steps to reproduce the problem of TX2, I will
> > investigate it with TX as well.
>=20
> PMR_EL1 reporting fantasy values, non-uniform priority support across
> the interrupt classes, and generally prone to lockups. The original TX
> is a very different machine though (TX 1 and 2 only share the engraving
> of the manufacturer on the heat-spreader).

Thank you for the information.
I will check if we have a ThunderX1 or X2 environment. If we have either on=
e, I will investigate it.

>          M.
> --
> Jazz is not dead. It just smells funny...


Thank you and best regards,

Yuichi Ito

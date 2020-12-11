Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 207072D72FD
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 10:43:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405637AbgLKJkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 04:40:17 -0500
Received: from mail-eopbgr50050.outbound.protection.outlook.com ([40.107.5.50]:37911
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726086AbgLKJjq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 04:39:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ul2YGGE7w4fvrTOumlOHB5wjYezAX93f/yHhIwpwcTF5FMEz7XJm5t9OpJqS62P/isyFZFnvklmv6lxk0Liurhue7ttOElT+vNd0kEvUichTCjik5485fnGyd/9Obf44q0F9ooZs68W5DhaH6SebFbI8SXma2uVpCtvsOVowHv8ifN7hP1mecr2nwQzvrS8Rp/f3gjwzGd7qdeYExRpZ2kfF/nBGsq1m34EeBD4+VfRB2RM5TaWfYKcNvIYvE4epJneCzzTx9YIGK7ICc4Q6cW9zgXufEKjJBaaWYH7jplP+et89YoeQEC8GDQzOa9tZshozY2MtD+EJT+IOIZ4sDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xc5arlWWr6OMV1aDbkoNUFUS9MXagVC4EF47dq0Ahjc=;
 b=hj5Tk3RwmyeF53iWsqj4pWwYGbMTXCeGTjPq78OcNdpVBqXkrmETdbfEXGzguoU8CvIBnRBbSeXrx5M5wxeEdcpu05SzK6Ai0JlbXiNHxbiFWpr9NCHG+1Zisy1ubLiPFt8UaIGJf2d08Ztfv0gmcaYEMGuepmt3g/h190qCSwrfFEg21elyTKVXWYPdHUCc15R73eoILBh+W5VXSUzw8ItjQzaHUFjtMCLxX6jRp+0gkMvYKOsNRr2FAyd3LXYVp5oB8lco92QORvvARicggkE8sCG+L5Y4RAu7RMROM3tvRDCn6bw6SHpYBlvLd354k0endxamwRjHkXFBaxSCLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xc5arlWWr6OMV1aDbkoNUFUS9MXagVC4EF47dq0Ahjc=;
 b=fIe/S15ZgjTIMaAUiKM9+8jy7dywjZW0F6pYfBj3eOD0Jj9R3ppTBf05UO1lckt6bhShkQHzHsDwbLMp7T4JxkJeyNQD4ojleBcyl2j0D65mtEMIe7IEjaZ7e3E1R6lOhBHwkvA0vjtNws11h6j7+VLUQZ7nW8kJvprdrsMqgIc=
Received: from VI1PR0402MB3871.eurprd04.prod.outlook.com
 (2603:10a6:803:16::14) by VI1PR04MB4128.eurprd04.prod.outlook.com
 (2603:10a6:803:45::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Fri, 11 Dec
 2020 09:38:57 +0000
Received: from VI1PR0402MB3871.eurprd04.prod.outlook.com
 ([fe80::818e:8d79:99a9:188f]) by VI1PR0402MB3871.eurprd04.prod.outlook.com
 ([fe80::818e:8d79:99a9:188f%6]) with mapi id 15.20.3654.017; Fri, 11 Dec 2020
 09:38:57 +0000
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     David Laight <David.Laight@ACULAB.COM>
CC:     'Daniel Thompson' <daniel.thompson@linaro.org>,
        "linux-netdev@vger.kernel.org" <linux-netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RESEND net-next 1/2] dpaa2-eth: send a scatter-gather FD
 instead of realloc-ing
Thread-Topic: [PATCH RESEND net-next 1/2] dpaa2-eth: send a scatter-gather FD
 instead of realloc-ing
Thread-Index: AQHWzxpfkmhJ4/PRJUyjg6gvz97H0KnxomOAgAACSwA=
Date:   Fri, 11 Dec 2020 09:38:57 +0000
Message-ID: <20201211093856.gj3do6ntnmxsqtzp@skbuf>
References: <20200629184712.12449-2-ioana.ciornei () nxp ! com>
 <20201210173156.mbizovo6rxvkda73@holly.lan>
 <c4e033fe17674685b64a60055c68704e@AcuMS.aculab.com>
In-Reply-To: <c4e033fe17674685b64a60055c68704e@AcuMS.aculab.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: ACULAB.COM; dkim=none (message not signed)
 header.d=none;ACULAB.COM; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [188.25.2.120]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: dc44db53-01fd-4db0-e544-08d89db89527
x-ms-traffictypediagnostic: VI1PR04MB4128:
x-microsoft-antispam-prvs: <VI1PR04MB41281A21BE02007419FFE3B2E0CA0@VI1PR04MB4128.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XkXVTuqFt9g77Yo0FXFQqfdZmwM3GCXEgtv01pvLsOykxhUyzgUws7u6zIudi/U4+K4N9gdPnWwKXL0E0BDJZ2UYAVXt3C1XrKXnCIAvSlWF2z2CroXFRQWnSom9w7jvHwaH4150Zbj+6xWaouuA6dqPgNANJVAIrg+EidWzZszlnXcrTDh4gZFY4bo1EeFRNgjdNgejC/35zMN2WMo2/w2zAP6n8Qjms3eGOPYXPJVORMN8J9aZed7JXoHNAklo6tsRztlkAeyAlVBaZb4C8NnxWEuKK7gs//gDjpkQnh1Vly4rEhSMQMkRSUH0okaY+fm/hpOom3oSQtQINuRzIQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3871.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(366004)(346002)(376002)(39860400002)(396003)(136003)(54906003)(478600001)(71200400001)(4326008)(86362001)(2906002)(8936002)(186003)(66446008)(66476007)(4744005)(26005)(5660300002)(6506007)(8676002)(1076003)(33716001)(66946007)(76116006)(6486002)(66556008)(6916009)(6512007)(9686003)(316002)(44832011)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Bl6M8aqv/JVxYjeVVXsSjhytCmsfcBDLpjCSpK0R8lTuCqhbzJDiVBiaISkJ?=
 =?us-ascii?Q?IlY4HMjPizBYxTKT+RqiFASN7/rNcakWXXvV+1HI5qJwdRP0/GvdQ4mjOZHG?=
 =?us-ascii?Q?FApl8M0kFsiY7NveTzz0qdbC0Yzd7yVVGOPG4qWmfczZbKJT5lfxtV59beMY?=
 =?us-ascii?Q?vdWDEqTbL/yGHBYpcWNOmqy7f0aCSCHqjePMxETqgUnegdg9E5sSo2MDvohb?=
 =?us-ascii?Q?jfLP/nWS3HqlInhJlbjMekZPyrsicDYpiaQmpWl33C0cowh7v2I2YS8puDij?=
 =?us-ascii?Q?0iAbXJL4S1uwhH2EtiyPNs9+k2IpbmsTJ5uCRlbh6A6b0zxHsk75WGXs7HJY?=
 =?us-ascii?Q?BE8FTLeu56AhyLRdZoJLcHquOWEpzzxW9Wiq+Tpo+ChArmQMX2MWoj5f+gUp?=
 =?us-ascii?Q?knp8ECy7IiB9HOJD3cuxr0jkEcGxqyksCZkEDk6nkWV3fM3eHJJqu4yUIAbS?=
 =?us-ascii?Q?cwGhyPI1XXKxn6PDXMSucLJVQPwMIlltcaIP3xqH+MqJtg5/K8UKJP7T7e2t?=
 =?us-ascii?Q?3RsdLJQHQuqPvNGqLgGGWpqhYeeFycU97n8do7IPfK8XHplLyPkTEMw831b0?=
 =?us-ascii?Q?hWWUqtBqFfHpXi1Q+9XqRpX9h1Ud63WT7crhCUoy+XI0FwyzjV09Ktv/8rrB?=
 =?us-ascii?Q?oLzPMG7F8pnFbucT7bIo16vsfipfCMOg5EINV4O6R4i6XLVu5N8U6SQMGJrU?=
 =?us-ascii?Q?/qaLn8o+UxuFC6/XvwsoJZNMld7axbXPae37YXgeMhCIyK/87Sf6vj6YB0fV?=
 =?us-ascii?Q?0X+EZIpSfjfuBBRcvdO1Ft0IKM0t7/sjLBr4UUh8lrDHVMmqTFpbIzHUpQGX?=
 =?us-ascii?Q?lD3adYjQXUs6JJoo3pPjcj1DasM9MmFCJmDNImAMUfljHjWobwA/94YxPcLR?=
 =?us-ascii?Q?1F5ttSJ/YhVr2SxVz6PXPboU4Q6/Xh+lM1UNZGOvmbaHFD4Ytyp3BboRpDg2?=
 =?us-ascii?Q?pStDY1SUCM2unz852PDjlTmXFUWCuGEDyy/pP8rlRp+V11mINTdILkgvj7lO?=
 =?us-ascii?Q?OZI7?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CB5C63B8D8D11C4AAC6FD948600CC2DC@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3871.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc44db53-01fd-4db0-e544-08d89db89527
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2020 09:38:57.3399
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vZ48qIuBPOsanLKPpaZFTnjqqCzZpQ8Iz6UT9hkqZhIzIwd1pd4rSPmvmxuf5ZbKMYV6ATnotcvjj8vEvZse9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4128
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 11, 2020 at 09:30:43AM +0000, David Laight wrote:
> From: Daniel Thompson
> > Sent: 10 December 2020 17:32
> >=20
> > On Mon, Jun 29, 2020 at 06:47:11PM +0000, Ioana Ciornei wrote:
> > > Instead of realloc-ing the skb on the Tx path when the provided headr=
oom
> > > is smaller than the HW requirements, create a Scatter/Gather frame
> > > descriptor with only one entry.
>=20
> Is it worth simplifying the code by permanently allocating (and dma-mappi=
ng)
> the extra structure for every ring entry.
> It is (probably) only one page and 1 iommu entry.


That is exactly what I was thinking. At the moment the SGT structure is
pre-allocated but not pre-mapped.

I'll let you know how it goes.

Ioana=

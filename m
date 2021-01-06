Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ACDD2EC597
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 22:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbhAFVSm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 16:18:42 -0500
Received: from mga06.intel.com ([134.134.136.31]:13572 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725860AbhAFVSm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 16:18:42 -0500
IronPort-SDR: 5mE3/KKfnb5jJoUfG7NTSrF7Sp5cG8tg9Zg6AgkLW/rZP1xffntEwDycykiIXnT4hHmrqRmPsk
 fVAFiU6mRWag==
X-IronPort-AV: E=McAfee;i="6000,8403,9856"; a="238884926"
X-IronPort-AV: E=Sophos;i="5.79,328,1602572400"; 
   d="scan'208";a="238884926"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2021 13:18:01 -0800
IronPort-SDR: YEJZpd+GdDGfRwXE0dE66Ugo8WQA/GWfXTYg8joXm9QElso2h2aWOr5731RpvZEjhP1S+V+3wr
 rz+WqU3Bw8fA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,328,1602572400"; 
   d="scan'208";a="570195692"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by fmsmga005.fm.intel.com with ESMTP; 06 Jan 2021 13:18:00 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 6 Jan 2021 13:18:00 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 6 Jan 2021 13:18:00 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.174)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Wed, 6 Jan 2021 13:18:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IZdRdnYrof3E/ISK5xwSIKYZOKTUiM/59tl8aVebesOULT9XfoQG9OoHShbLZVAk4KT63l4TNFd7nIMHeLYyFHVA1Afk+DPv6kZJjC2irrahdRBctvwVtVJAqkLA4iiy2PEAzXZZeQJUVdIVnFiaHSyFKubqiSH/7QlFbB9sgZqfdoH4D0BKQUqv5H3cyaj9q5P76U8J9dqj9jc6CTADT4PrFAK/QFGYt9WCNMPp6ibzBa0hEWVRWbAHf2wK4NMCEFLg4R7BFccD/AvVqxlq5E/HpiSrLlJJI2snifoB0KW/cvurL/2/5SisjUdKFlBgjBBwp4Mvoh+4L08Pyd+Cqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=51UPPcHa5L8dwtuhZuJIsuAUUN3K44YBYgJeKDuE3/s=;
 b=Vipm7PTy++5tvmSRZreoXM78M7cGv4BN1gJujSBZkrULZEI/fLWveiFh9RqUcB1UFcyT1OzykNT98/XTPbX4VT+uwaUIkH+SlNm9PUmBewL5MhIoVGS4H9uXeAddzColnoVEJcvXaDa4iryovf3hP3Q143YMz6cIQ8SXUEaYe+Q95JOthphAr0iooOQXmP8wsuTWcEJjm+J1Q/1C0natgg69CmPrDgIrs+1EKSZXYIi4ArlJnRGPxGg6VUfd8OzAnUfsFFJnWn7FPNfqLribylhJbJnNJviTwwHrJyIUtzvoCtb2ZKdjD7F8OspyggWPE8bX4+mKEYDo/m2xH21W2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=51UPPcHa5L8dwtuhZuJIsuAUUN3K44YBYgJeKDuE3/s=;
 b=L4lXA/tcQI2TXWmLWgOFZq1RdAkZ2EVYHHjwMXiSBqx68kaVtCoG60B2eqjw2lkdD1J3F1gSdKYtswpTSTqoN6Onzsq2udmQsENsA3Y6cLPaW5MDRMECPhK2W2EsYYS45LqFqx6xKvtSzDQoCv5Zo/jXOKS7I0udVlF5TO1L3Ro=
Received: from MWHPR11MB0048.namprd11.prod.outlook.com (2603:10b6:301:6a::31)
 by MWHPR1101MB2191.namprd11.prod.outlook.com (2603:10b6:301:5a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Wed, 6 Jan
 2021 21:17:59 +0000
Received: from MWHPR11MB0048.namprd11.prod.outlook.com
 ([fe80::f423:df7f:ca32:c875]) by MWHPR11MB0048.namprd11.prod.outlook.com
 ([fe80::f423:df7f:ca32:c875%5]) with mapi id 15.20.3721.024; Wed, 6 Jan 2021
 21:17:59 +0000
From:   "Patel, Utkarsh H" <utkarsh.h.patel@intel.com>
To:     Benson Leung <bleung@google.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "pmalani@chromium.org" <pmalani@chromium.org>,
        "bleung@chromium.org" <bleung@chromium.org>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        "Mani, Rajmohan" <rajmohan.mani@intel.com>
Subject: RE: [PATCH 2/2] platform/chrome: cros_ec_typec: Send mux
 configuration acknowledgment to EC
Thread-Topic: [PATCH 2/2] platform/chrome: cros_ec_typec: Send mux
 configuration acknowledgment to EC
Thread-Index: AQHWzrsx4jhzkeZK+Ee8qthNzOpyP6oZzOWAgABHFHA=
Date:   Wed, 6 Jan 2021 21:17:58 +0000
Message-ID: <MWHPR11MB0048066CBB95E3C1CBBDD41EA9D00@MWHPR11MB0048.namprd11.prod.outlook.com>
References: <20201210060903.2205-1-utkarsh.h.patel@intel.com>
 <20201210060903.2205-3-utkarsh.h.patel@intel.com>
 <X/TtO/HbYAKhznhg@google.com>
In-Reply-To: <X/TtO/HbYAKhznhg@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [134.134.136.192]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a67b04db-dca8-4870-bc2f-08d8b2888afc
x-ms-traffictypediagnostic: MWHPR1101MB2191:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR1101MB2191ABC654FB125294B78037A9D00@MWHPR1101MB2191.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 27cLx4DmY5werUBmRvkp4hOz6yQNgIaUBExr7+BF6c/u0uXsBirp8TLFm68t5s2EMnhU9O5TsFPV1U4p5TlFybULz58Yx1NMIrJ65GL7SmgDXZnsk5v9RDkRuwRKc7vSL+u1DqF+yEi5ghj+cyTUzqMdD3VEtzWmi6OtewOTlTFtZnC2vl0YbkAAZn4CxUy64GtcTeUKnWk+BJL2/nMvanXrJqDqm55C3y9uiQAjjABrWPyFtp/MKTJ3tK7cSgAjc0H1Nu3O9e5jfSFix+VNt0DSZetihRenBt6KYu7FeG/cCQaXH21OCHh70Uc7AmYjZ0oyeMy/GeRzKf4+gazDTYYsiYVuFlptDAtDLkcnirfATDEUyetzVPal5mtxxM5DGou0nbBivSyoTgkfm+GD5FoQ7rr8kZ2VAAs2HG5vsrlxn8AJ9uDXCg1t4NpN+YyK/17CZ1CGoxEjntlKoJZovA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB0048.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(396003)(39860400002)(376002)(136003)(52536014)(26005)(2906002)(83380400001)(478600001)(71200400001)(186003)(8676002)(7696005)(33656002)(316002)(966005)(4326008)(66446008)(64756008)(76116006)(6916009)(66946007)(6506007)(66476007)(54906003)(53546011)(55016002)(66556008)(5660300002)(9686003)(86362001)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?AQbrtbvE46pOXdUzmjij7jddFVqURJoPhwGuV9tiZLIDxSX4K4+RPacOPCDJ?=
 =?us-ascii?Q?ti3H/477KUmXD6i3lGxjjB5nBVRuWgB/7AuFF3PGOuv964jtJXbZt3PEIQmU?=
 =?us-ascii?Q?PziweMWR4a8D5S9XIGFoTdKip5DNACWsJHJB1hphmkWrBHtHdTU9ay0qWXV7?=
 =?us-ascii?Q?EyVFnk+yG37fyytsJRK4O+RD7F/hhYj8gkoAmw1JcBiGNTf0Rkl2FiwTYU1Q?=
 =?us-ascii?Q?SlWIv3Z54RHTBAKkxrmXIGE+xI5F/EqZaCcCA7cYKs4Xri0F0fzAVxDSB3nd?=
 =?us-ascii?Q?eWKwafhZ+rFIffztbnDTRvaNIyVWq8ynQ30G0S5D/jGE03bqBh97kap9N0fu?=
 =?us-ascii?Q?HLTnAowrJnRUXbM7bDKNxw/lyF7Tu+nUQbj64CDVEuU+mrQkwRtp049ynmwv?=
 =?us-ascii?Q?IPrtG9FHemII/qAt72/pRDwtC8Lnqwy3JC+Sx/DB5iCvYuwjYlwiK94xB9qW?=
 =?us-ascii?Q?+DLuC95zPsVzvzrRLIS7RLxyFiOnhtRxG2/PjVIDJqAKGIKvrvS3YfosSYqh?=
 =?us-ascii?Q?wWbUey9Puopj8rRxFYrvIQ4OlrqRtT7wYDghM/bfPHmCAU5sZrHzL1Sxo9QM?=
 =?us-ascii?Q?0kPDp/3hopm4wViltvO2e/1k8uUYrNf63ZXIp09K7g+Rprwc3sq9QeqORG6k?=
 =?us-ascii?Q?bjTSLYTa7xSmSbf0iYBv9uut2A6uuD+5MPWRcsVVWiHFycLaN3SkSu4yLXmW?=
 =?us-ascii?Q?0ddd+q0x3TZ6iXJPYd/NJ+jDlcqC2lKQSMxeGv2Kz6gPLXPrgevkrOqSIXhk?=
 =?us-ascii?Q?XPr3Gz7evfiXLgDjnow22CLgztqHRf/sw5z5Ht1gRyTLi8K9G2IzYUjYG6DX?=
 =?us-ascii?Q?ICeTPOHFbiinx6u9jajJMge01igAh1+G0xh8cDfqC/Gh/h6mk92tumAZxdPo?=
 =?us-ascii?Q?u+9jKQTV9X9HD7GGmHnJUWT0ovCXooPktL3lki8IjLKuAFpFnM2gYwSquZTg?=
 =?us-ascii?Q?84yxqH8M5iJ7JIKcoi7IPViI9hADUcB3xwSnRCVDL54=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB0048.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a67b04db-dca8-4870-bc2f-08d8b2888afc
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2021 21:17:58.9191
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mjgtr3vBVHQDy7PbvS21eJqbE2S4DK4j8S4zU+i1dd9pWNzNjR3ZIPyLVRsHygmfROQFdpFnpm2dicu5oMea3dVTDSLAuEh9AFm4dld16WY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2191
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benson,

Thank you for applying the patches.

> -----Original Message-----
> From: Benson Leung <bleung@google.com>
> Sent: Tuesday, January 05, 2021 2:51 PM
> To: Patel, Utkarsh H <utkarsh.h.patel@intel.com>
> Cc: linux-kernel@vger.kernel.org; enric.balletbo@collabora.com;
> pmalani@chromium.org; bleung@chromium.org;
> heikki.krogerus@linux.intel.com; Mani, Rajmohan
> <rajmohan.mani@intel.com>
> Subject: Re: [PATCH 2/2] platform/chrome: cros_ec_typec: Send mux
> configuration acknowledgment to EC
>=20
> Hi Utkarsh,
>=20
> > diff --git a/drivers/platform/chrome/cros_ec_typec.c
> > b/drivers/platform/chrome/cros_ec_typec.c
> > index 650aa5332055..e6abe205890c 100644
>=20
> I went ahead and staged this commit, but just for your information, apply=
ing
> this patch was problematic because the sha1 used here didn't match anythi=
ng
> in the upstream kernel.
>=20
> Here's the error when I try to apply this using git am:
> Applying: platform/chrome: cros_ec_typec: Send mux configuration
> acknowledgment to EC
> error: sha1 information is lacking or useless
> (drivers/platform/chrome/cros_ec_typec.c).
> error: could not build fake ancestor
> Patch failed at 0001 platform/chrome: cros_ec_typec: Send mux configurati=
on
> acknowledgment to EC
>=20
>=20
> Please double check when you run git-format-patch that the branch you are
> working on comes from publicly available git repos, ideally, based on lin=
us's
> tagged releases. This will ensure things apply cleanly on my side.

Sorry about this. I think I might have used for-next branch mistakenly when=
 running git-format-patch.
I will make sure to use correct one next time.=20

>=20
> I've gone ahead and staged this, but could you please sanity check that t=
he
> result is as intended?
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/chrome-
> platform/linux.git/commit/?h=3Dcros-ec-typec-for-
> 5.12&id=3D8553a979fcd03448a4096c7d431b7ee1a52bfca3

I have checked it on myside and works as intended.

>=20
> Thank you,
> Benson
>=20

Sincerely,
Utkarsh Patel.=20

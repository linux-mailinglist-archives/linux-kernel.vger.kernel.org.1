Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9460A2D7C90
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 18:15:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394910AbgLKROD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 12:14:03 -0500
Received: from mga09.intel.com ([134.134.136.24]:25803 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733260AbgLKRN1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 12:13:27 -0500
IronPort-SDR: jcD1vvcrQnCH0aL0IHphiJI/BunR/crBZ1kNc1jARnFTiZzLRaPeOmyNTooqiVzc/OHLCDyPX9
 TvGMfOw+eJYw==
X-IronPort-AV: E=McAfee;i="6000,8403,9832"; a="174610252"
X-IronPort-AV: E=Sophos;i="5.78,411,1599548400"; 
   d="scan'208";a="174610252"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2020 09:12:41 -0800
IronPort-SDR: PSsZwJNlQXnzoSjUT5co+YGCen3/WaeslXLygVayPDK5g1JKG/aIHbtptDr/tvst0WI6S10mGt
 +VFC6wR9RaeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,411,1599548400"; 
   d="scan'208";a="376631963"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga007.jf.intel.com with ESMTP; 11 Dec 2020 09:12:41 -0800
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 11 Dec 2020 09:12:40 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 11 Dec 2020 09:12:40 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 11 Dec 2020 09:12:40 -0800
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (104.47.46.50) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Fri, 11 Dec 2020 09:12:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PX4A8kc7bu2zy8bs/lp41tHE9k9rL+y+4aEoUuaNzhJTQi6ox/TRDSubyLRpiRtSBGD2D4/ZC6puQzq66jm4RJARfpLlac4sIjybMDINGh7FrGg3/lzswEc/dHlcXTyePCzxEB8gKG4PGF6PrOBbM9VK7qegZVuK1eao7GZeKA9rwyUue0PfCo9nsN6QuZ8LyW+eAvHDkNi/0Ki9N/1RxqdhMrV0w3wC4VyPTtqLjwZhK9WWcAO41PyQX4BaAk7gpnCPzAQKME5FOhwGZDImjDkBu9wIUYjfoS8y35DTWPrtbImXYzJc4RqmnJw7Xe4QcarW8ZgO2kaZShiQ81o9Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GZWV4qt/hsmchmAhexrSttc0Vn9ZWmX0QEnd9rK6+yc=;
 b=P/lb4GVn3j6Gyn5w9cdjXNafa6J31yuK2BBgIRNj8hi6RiBkiGcfBz+7Xg7lNkcYIcOvhXoOGVwDbkwXnQyxnQhJPuKvnEOV9EpirtaAFODMDuS+XQAU5W8Fi//rrGALhDpBfc8e2c6xCyeL0hagVYZ+YXubOYbwDlRI6vdnqo8cxL6EJFO00s4xz3xq978NiSNRfKVDvQtIOK7XQiDUDjybkwFnJwOxf4yNL+Z4IaWepn9CE9kDuAhNRzc5ejSnSZucEz6Xjl0GD4Ei60+tba0oekmf0rL3Ga25Ku6EBZ5jf2bK+yht0ioalzWARL/+EFlGo/818GY53tBQ4Qu8Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GZWV4qt/hsmchmAhexrSttc0Vn9ZWmX0QEnd9rK6+yc=;
 b=eZhshrF3YboJPL02699mvEeFmIQWumBT0iZmn2hudh6F+TyQ3kXkhmDor7L6yPGdLLduzQy4PFEynuMtxICAQg3a6y9Ycyxv/zrsqbDvcCnrB4esiwAds9S8hg9qwxLL3UkL6vA9Xckw3dGPLrTvD3NFACd1netRg7/rJ6u8PPA=
Received: from MWHPR11MB1679.namprd11.prod.outlook.com (2603:10b6:301:f::12)
 by MWHPR11MB1742.namprd11.prod.outlook.com (2603:10b6:300:113::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Fri, 11 Dec
 2020 17:12:36 +0000
Received: from MWHPR11MB1679.namprd11.prod.outlook.com
 ([fe80::c84:799f:437b:19d0]) by MWHPR11MB1679.namprd11.prod.outlook.com
 ([fe80::c84:799f:437b:19d0%4]) with mapi id 15.20.3654.013; Fri, 11 Dec 2020
 17:12:36 +0000
From:   "Gross, Mark" <mark.gross@intel.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Kelly, Seamus" <seamus.kelly@intel.com>
CC:     Joe Perches <joe@perches.com>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "markgross@kernel.org" <markgross@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>, "bp@suse.de" <bp@suse.de>,
        "damien.lemoal@wdc.com" <damien.lemoal@wdc.com>,
        "dragan.cvetic@xilinx.com" <dragan.cvetic@xilinx.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "leonard.crestez@nxp.com" <leonard.crestez@nxp.com>,
        "palmerdabbelt@google.com" <palmerdabbelt@google.com>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "peng.fan@nxp.com" <peng.fan@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Ryan Carnaghi <ryan.r.carnaghi@intel.com>
Subject: RE: [PATCH 16/22] xlink-ipc: Add xlink ipc driver
Thread-Topic: [PATCH 16/22] xlink-ipc: Add xlink ipc driver
Thread-Index: AQHWyDJGFxqyr8OX1U6i9Ui3w6Ab6anq8huAgAbgRQCAAAt7AIAAUACA
Date:   Fri, 11 Dec 2020 17:12:36 +0000
Message-ID: <MWHPR11MB16798D68001AC5FC59AC0D458ECA0@MWHPR11MB1679.namprd11.prod.outlook.com>
References: <20201201223511.65542-1-mgross@linux.intel.com>
 <20201201223511.65542-17-mgross@linux.intel.com>
 <d33f6b90d50feb6c05bd45ffdedf3fb6d5ceb5ee.camel@perches.com>
 <BYAPR11MB37839DDCA13DC55E594F5D108ACA0@BYAPR11MB3783.namprd11.prod.outlook.com>
 <X9NikKO55TEBODJP@kroah.com>
In-Reply-To: <X9NikKO55TEBODJP@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=intel.com;
x-originating-ip: [50.53.49.126]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6afb23d6-b8cd-4946-fcf8-08d89df7f4e0
x-ms-traffictypediagnostic: MWHPR11MB1742:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB1742217DB529F5BF07D49F9C8ECA0@MWHPR11MB1742.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m+t18/S9WYVo+BeooJomO6870nOdTV8za2KLvGdLihLHzXP2Jox3jOG5njROdgre60v0e/oG8N21VuW71olfH2btcN0m9YrjliheoQ8LU8AniVv4BYc5InxgxTBVyyneFvpSQkLuGinNF96VoTNNi47JadQKSS3i3ags5xB39UkV6YxUzofy8DMdGrb/1WpLxGWaZBuvwXb47314KfXoTYqzyYQo+LS2y9x2cSVfiXna5QDsVeVCimWQa+rGCcSkv9Dv53hwMWO4lnDnrRjobUMFbOe1uYDf19ZZG2nd6JaZdc1wzmAi+ylaD9SAuZ3+ZJSSCJoL+0CBrJMJNSQ8mA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1679.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(346002)(376002)(508600001)(64756008)(26005)(54906003)(6506007)(53546011)(7416002)(4326008)(5660300002)(66446008)(66556008)(186003)(76116006)(66946007)(66476007)(83380400001)(33656002)(9686003)(55016002)(6636002)(52536014)(7696005)(8936002)(8676002)(110136005)(71200400001)(2906002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?te25tOD/Xx89ssbbyZAB1z5uBvaY/84v9vG7PtyWPX6xMiPiD4Byd9Gbum23?=
 =?us-ascii?Q?Q7JWE0HtrdwxvbTKR9W2meenj82W/KjAoQTs3IEIJ3XWdudL9yZcKVrzU7Pt?=
 =?us-ascii?Q?S0y7wGW90PP5sNNWiVKW5Ih+GyuiC7hCtkh9yYRf1c0W48qXBAOLdgCwPDVX?=
 =?us-ascii?Q?zhhU0M5y+D0+1P27i9+GAE5Xi1J71/e3rEKSbstlwaTZftF5aruFa3/z+76o?=
 =?us-ascii?Q?YYvEa1M7GbPFA7ENuB5UxHVyHYRI47a+/rdHzjBtvBmTuoJhHwfkyUz+1Grj?=
 =?us-ascii?Q?OJaL0py+MXQWMWhU2gvk6M+o44MDbrzWfAYxh/EHvHff4x83/VGNNg2gMGpq?=
 =?us-ascii?Q?rp7IzWcfzH7nw+lqaHcNpfr5QNf2N48n1ILzTo9bBtviE0ExnH6shepX3VBZ?=
 =?us-ascii?Q?RBpvPPXzyirY1CPFXff32GwGHnAnKEO8E3Qw2GgIcwhbYJBE1E7c1JtEwf7l?=
 =?us-ascii?Q?hHkpIaDt/hW1GUwncyVf6vWL7TTranfr0B9OngyocnI9g1KlGxc/jfsPLjeL?=
 =?us-ascii?Q?gNVOQ/PkAQDCY7JtSGpMSDCdXtZJWb4Z88CKCK/6L/zQf4/SjOG5gfsCa7Q4?=
 =?us-ascii?Q?tokxDhqZ1/sTsVxbBg0Tumjo73InRDQejIi5nvC45jKd/O2DJajKph1IKVuk?=
 =?us-ascii?Q?851uZ/8zPJ9Bvd4V/ENMIxxEaDRSK/ArmGVDQ29RgPYmGEQB6/CBOkSe66Dq?=
 =?us-ascii?Q?wlX2bzEsSQ3V7j6SM8o05ylA6dMUKX9KV+EQaITd2xTY2FIwVz83giI/dNFe?=
 =?us-ascii?Q?ZOZOkt+I3CvOrVuj68x9Vrxr8d0xueMqskRUh31pweru3sCSF+A5/h/R3Vqq?=
 =?us-ascii?Q?j0N9SUWMIHu+eMvWnieUVSYkg3gt9oppFnH+Y8NeRGeQjjfg9H+YIme5C5Vw?=
 =?us-ascii?Q?LeqVZG9FCGmktskRm1X+nrGfNxbDM8GfDlwFv2BilGEsa5V57o70G3X85Dnh?=
 =?us-ascii?Q?tfgI2U/S+f2CbLFwS/DG8UQsQ78NtB2KIc1tGQR7zGM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1679.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6afb23d6-b8cd-4946-fcf8-08d89df7f4e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2020 17:12:36.2324
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0S9zGxKKuFs34fgEwcFFQioS3dWFlZC+3Ki7XZjT7S0QSweEH/Tgpv+mCQXhWNlBcvo4YiqdE6QJcJXj14TVCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1742
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: gregkh@linuxfoundation.org <gregkh@linuxfoundation.org>
> Sent: Friday, December 11, 2020 4:14 AM
> To: Kelly, Seamus <seamus.kelly@intel.com>
> Cc: Joe Perches <joe@perches.com>; mgross@linux.intel.com;
> markgross@kernel.org; arnd@arndb.de; bp@suse.de;
> damien.lemoal@wdc.com; dragan.cvetic@xilinx.com; corbet@lwn.net;
> leonard.crestez@nxp.com; palmerdabbelt@google.com;
> paul.walmsley@sifive.com; peng.fan@nxp.com; robh+dt@kernel.org;
> shawnguo@kernel.org; linux-kernel@vger.kernel.org; linux-
> doc@vger.kernel.org; Ryan Carnaghi <ryan.r.carnaghi@intel.com>
> Subject: Re: [PATCH 16/22] xlink-ipc: Add xlink ipc driver
>=20
> On Fri, Dec 11, 2020 at 11:33:02AM +0000, Kelly, Seamus wrote:
> > This e-mail and any attachments may contain confidential material for
> > the sole use of the intended recipient(s). Any review or distribution
> > by others is strictly prohibited. If you are not the intended
> > recipient, please contact the sender and delete all copies.

Must be something Seamus is using that knows when emails go outside.  I wou=
ld have caught this on our internal mock reviews otherwise.

>=20
> Now deleted!
>=20
> This footer is incompatible with Linux kernel development, please remove =
it in
> order for us to read your emails and do anything with them.
Yes, I know.

>=20
> I can't believe that Intel still has this problem, after all of these yea=
rs...
I'll add a warning about this in my training collateral and have all engine=
ers I work with on this type of upstreaming send a test email to markgross@=
kernel.org so I can see if they have such legal clauses appended to out-bou=
nd email that is not visible to internal recipients.  I'll fix this.

Sorry,=20

--mark

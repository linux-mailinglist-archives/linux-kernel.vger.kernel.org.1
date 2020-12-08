Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2EDC2D20E2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 03:38:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbgLHChH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 21:37:07 -0500
Received: from mail-eopbgr1400049.outbound.protection.outlook.com ([40.107.140.49]:61024
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727075AbgLHChG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 21:37:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ixJBst3nLmPw3oUgqFnfg0TrAe1tbFEXeBD0FtmwBI1UVcpCUIiEM2IwKNkmNvizr4mTUTXUaZLKNIVhZQ1Q/MNo4Ktpj3QIYa4CZtQT9eVdNwRu2+HbmGRWb0xLysHrf4kIS+mxMBFKSwrivlb5OAAHalZbHrCj5kgPVQNnfvDaUJFdcgpoB2LTt7wzgHpZr6yw5BJGGllWZGmo2frz2o97M1LFbc1SyW5gwCUPCleGqqpeblqb2eyxHgE9uqdqfy3T0PuDg64bEdxhDYd0/+HAKcskK5hezWQEkoi8y2rIxuNyRyI4OOO03i7jHbbR6G0izjXyrCZuxx2S4aF0CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1aKlP0qRPFYtHfVr57TXLqkAzpQJ9XBfvxaOJP9UvNA=;
 b=LoNgUITpk3UMc/2aO2PVNDvdhUK2ypWyfbRoVJRtMx609cqqnOodic0nLciZ/UtekXlO2C50oMRwa0LwiYifPss8dOaS4haJdOP62XTC7Y2Uh+8b/WsqI3v4XKIhZvjdYdvAhQQqUwnkxrlnTgUWsoiXy4C5Dfusn12B25Uq5cm8hqe6wXWWUy4YU9EC2TYsyW02wCkV1W8t8JHe6D5KXl1UYWSJILFiD9ESD8reTfUOl4z742Etf9/U3D0L/FANv99EYZ75gtMGHzymcVRh21oTs7gVY+ZWSIZFSrDV4QGODQb0sYfwV9ftuhNOXqPUK4VK6ppw9DasXQubyeMeOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=necglobal.onmicrosoft.com; s=selector1-necglobal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1aKlP0qRPFYtHfVr57TXLqkAzpQJ9XBfvxaOJP9UvNA=;
 b=r7p6M/OfliqKtCFbx1TZxbIv7nlyALhJDfhjbMw7tZh7IStS3Bw4IKn3ttUhT1+rHlQFFzmtyr53uXih9xcIOnJF5VOu8RcHmjlPtgpCiBBNOelqpUgU3yPBZRkpMleZDgt7W7UX+pCfsP+QElldOf0mdmK2DNvETjZ5hA7UJgw=
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com (2603:1096:403:8::12)
 by TYAPR01MB5930.jpnprd01.prod.outlook.com (2603:1096:404:8055::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Tue, 8 Dec
 2020 02:34:46 +0000
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::8453:2ddb:cf2b:d244]) by TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::8453:2ddb:cf2b:d244%7]) with mapi id 15.20.3632.023; Tue, 8 Dec 2020
 02:34:46 +0000
From:   =?iso-2022-jp?B?SE9SSUdVQ0hJIE5BT1lBKBskQktZOH0hIUQ+TGkbKEIp?= 
        <naoya.horiguchi@nec.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Oscar Salvador <osalvador@suse.de>,
        "n-horiguchi@ah.jp.nec.com" <n-horiguchi@ah.jp.nec.com>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm,memory_failure: Always pin the page in
 madvise_inject_error
Thread-Topic: [PATCH] mm,memory_failure: Always pin the page in
 madvise_inject_error
Thread-Index: AQHWzH4hO9bKFpDJuEiM7pqnWm2hdKnseNQAgAADkgA=
Date:   Tue, 8 Dec 2020 02:34:46 +0000
Message-ID: <20201208023446.GA10757@hori.linux.bs1.fc.nec.co.jp>
References: <20201207094818.8518-1-osalvador@suse.de>
 <20201207182200.21f97d90211c78609ffd7351@linux-foundation.org>
In-Reply-To: <20201207182200.21f97d90211c78609ffd7351@linux-foundation.org>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=nec.com;
x-originating-ip: [165.225.110.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 65208571-5143-4281-241d-08d89b21d429
x-ms-traffictypediagnostic: TYAPR01MB5930:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYAPR01MB5930D57EB7F01A8BB6684E76E7CD0@TYAPR01MB5930.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1bE2sjvOSoQTyiqvBkg6xDSm0bsYmCLvH2DalAR8WdKeB1ZvjgCh6+v/VmkiR5mWqXrBlqBqlIQuZtMvwrh3AsIICxbBtTQXODNq1VOF7l0NWal2uP6kzvHdwNVIHZjM1FfEMs9PXsbK3gRWdKGleQnsh/yueKUZQj9u3cx59JSbP0pSqzlQOKT7XsqnTM7Ogg5C+/GGG2Pk8584XkxIiq7Q4YIzZciZelFQNXtumuww8eugy3dkxE+vjaRY8q5JFYH92crM+dxmCNOz+A6tqFgQ4ELRpfNADGT6p0uaKls/lwxe9dsOhJf+JJM8+uYuK8icOrXJnwYENhlS9ctVZA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1852.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(376002)(346002)(6506007)(66946007)(71200400001)(508600001)(9686003)(86362001)(26005)(55236004)(8676002)(4326008)(6512007)(64756008)(66556008)(1076003)(6916009)(54906003)(66476007)(186003)(8936002)(5660300002)(2906002)(33656002)(66446008)(83380400001)(6486002)(85182001)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-2022-jp?B?N29TSk1DeC9Jamt6UU5ncXNXYWtRSTlQY0dtTGwwNzUxYmpZU05URFJt?=
 =?iso-2022-jp?B?RnF6NEN2akZtRSsxWmpFdTRWRFBySUY5SHVCdjVoYlV3QnJXZGxYNm81?=
 =?iso-2022-jp?B?bEpibzFCVy9iWkIzMGEwTmdZK2tzSlRpN3orY3NIVEdIVzNjNGxCVHVP?=
 =?iso-2022-jp?B?OHR6bTdrRjQ5eVdEYjVneldCeDREd25FakRTRnpXZUZJYm05dks3YStR?=
 =?iso-2022-jp?B?N01KTFdXMW1SblkybWZRSk91MnVQaUs5QmxPWWFBckJ0Uml5Si9aa2VN?=
 =?iso-2022-jp?B?NUVDU1VFcmZBUmtXZVVmQnlUVmdmMnVQdUk4blg3c01xRld0c3NTMHlj?=
 =?iso-2022-jp?B?Qmw3MUVFUWhON3FEWTU3Qll0ZmZPTGF2cHlZYWRtM1lXZnhPRk05MzEz?=
 =?iso-2022-jp?B?OEo1dW5vMzA0SEdkR2Z1WngzeE1pNC9kaVMxWDQyMityY2tzakdCZUkw?=
 =?iso-2022-jp?B?bXRlOElvRmNTWnRzck5zUUxIYXpQMUNZNi81d3hUdGNTV25uRGhRcGRM?=
 =?iso-2022-jp?B?aTU4ZThPd3hGZHd0U09meG1HM2ZwN25MemoyR2pjWGNDaXA3MnpsazNC?=
 =?iso-2022-jp?B?V0svMlE1RzNaZnBaMzRpZ2szTWR2ZFVheTdpa1JnUzY3eTA4MmF6TUl0?=
 =?iso-2022-jp?B?dmVwWFRWOG9wUmI1RzhCbXRqZ2sybDFvYUp1SzdVLzVNc2p5NlV1TXNQ?=
 =?iso-2022-jp?B?R0NULzhwWWlxVFhDYVhCVDl0aVNQYW41Z05zZEQ1OVRCQldZeFdPTis0?=
 =?iso-2022-jp?B?VUdYSXFaL2JmUVVnMWU2RGNDYmlmUFJKVzdqQWNibWQ5R2JPSUNyNDNM?=
 =?iso-2022-jp?B?WmtJWFhuZ3JhVzFFQWtjT1BYZktSRW9VVExaMWRRdVhFVFVNNkRYYS9o?=
 =?iso-2022-jp?B?azhkL1NSd0k4MlFPK050c1RDdk9hY2JQSjZYUjUrOFBRekFhOWdNZnM4?=
 =?iso-2022-jp?B?bFluYjQ2R1pvRjdhaGtUTzIxRmpSOFpPdG82OFQvcE5qbXBUUFF3ejN5?=
 =?iso-2022-jp?B?YlF0Z3BCbWcvUDN6RXJCWVVrR1c1OWZRcTlVTUt6SnVxTWJSOUdoL1JM?=
 =?iso-2022-jp?B?UnE1ZnUwb3BzWTVmeFZ3SkQwRm1nMStBOVZrT01ka2V4bHBMTmNoVHN3?=
 =?iso-2022-jp?B?M1FvY0N6a2pZdEhPUythWEhhVG9jM2k5YXBYUTZSbVBZbHQ0TlRWa09L?=
 =?iso-2022-jp?B?Z0dYa2FEbEdxUnRhMkFQR21CeC9zMWQ4dzNEa3JpUzZ1cVpaVkt1VVRr?=
 =?iso-2022-jp?B?eEZMZlE3NGl4bU9ULzRZN2pNUGV2TkR6aFdZbGs1aVoyZ3R3cXlnYVFS?=
 =?iso-2022-jp?B?dlBRNWpTdkc3UldEcFZiT3VOQnVva3J5MVRJeEppNy93dU5tSVFJSnRN?=
 =?iso-2022-jp?B?VFMzVXRjODF1eFFaelI4dWVBZFJuODZzWEtLSC9xWHlBc1QrN3F4bE4v?=
 =?iso-2022-jp?B?TGQ2RHZYV290UDRSTWRRNA==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <5D6917F77437494398313077B256598B@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1852.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65208571-5143-4281-241d-08d89b21d429
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2020 02:34:46.7997
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fzxysoeHHimEGW29KQCoZT7MbSzq2OLoUqlGbS0tNkMFvwo7ZS/AcxyM0VjuGpydwTNjNG7mI2tI3cDGc1peVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5930
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 07, 2020 at 06:22:00PM -0800, Andrew Morton wrote:
> On Mon,  7 Dec 2020 10:48:18 +0100 Oscar Salvador <osalvador@suse.de> wro=
te:
>=20
> > madvise_inject_error() uses get_user_pages_fast to translate the
> > address we specified to a page.
> > After [1], we drop the extra reference count for memory_failure() path.
> > That commit says that memory_failure wanted to keep the pin in order
> > to take the page out of circulation.
> >=20
> > The truth is that we need to keep the page pinned, otherwise the
> > page might be re-used after the put_page() and we can end up messing
> > with someone else's memory.
> >=20
> > E.g:
> >=20
> > CPU0
> > process X					CPU1
> >  madvise_inject_error
> >   get_user_pages
> >    put_page
> > 					page gets reclaimed
> > 					process Y allocates the page
> >   memory_failure
> >    // We mess with process Y memory
> >=20
> > madvise() is meant to operate on a self address space, so messing with
> > pages that do not belong to us seems the wrong thing to do.
> > To avoid that, let us keep the page pinned for memory_failure as well.
> >=20
> > Pages for DAX mappings will release this extra refcount in
> > memory_failure_dev_pagemap.
>=20
> Does the bug have any known user-visible effects?  Is a deliberate
> exploit conceivable?
>=20
> IOW, cc:stable and if so, why?

This interface is a testing feature and only available only for privileged
(CAP_SYS_ADMIN) users, so I don't think that this bug is critical. But if
someone think it need to go to stable, I'm fine with that.

Thanks,
Naoya Horiguchi=

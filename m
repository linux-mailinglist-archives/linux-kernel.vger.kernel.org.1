Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6560275249
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 09:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbgIWH1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 03:27:38 -0400
Received: from mail-eopbgr1320059.outbound.protection.outlook.com ([40.107.132.59]:34386
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726557AbgIWH1i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 03:27:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ayIwr107CGA5POczTTR1RamQzKsHBep8Q1Up/TYxX64RL2//7Y+qhQARi0OW5+eRzFYSPg5j6r7g2cyszwj7FIUdB8si/pSvRAMOFSxgyHLe6M5L2fGjMtVes+XKNdUp0L4oozzJaIMX7lSuGlO9tnvHhzMgNDhx/Hp0ikMIWqqaadijQ21/YtcL4WarktjSzpU9sNp2fx4cjfb32d72xoW6UZ61pRiimk7iZXYaxCP7NhfabadhxQzDg6N0fIbrBgPZulOe8qtvKDUheSuMK2ShWWfj7NwptHFHKHwtYI84LerzixyXUjn4lpZT2NwC1FhERcUmVZZUHXfuIHpxQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hc9t4CelhZfGin+5SadsslC9u6ayFXXfFASxQ9iJkRU=;
 b=mNZw1W9xi1zbNve5CckIIGW4DmqUiYAu6RlnRjnjNvEJDqZBFL8yUtqcLVh1c0crh7gs+OiWj5yGbqr24muWUhbiGkxIcH2E9iNfOn2BTYpzY3Hwekh58bCKELa8kW4jXj6uXpsLhtywJQqnTsji+E+USyU87FEUWjc/kCwXHIhcU5KVlbgmAHgDDiDSqUKvpXxDYAbkQKfxexKEqsgoN61x2h7mhteJ5QbUhSngEvfsphc9nuaHUBnU8WK9HK1Bo6r3jYX4Zbbr3FhSTvnE5JWMhfRap69uSvDy8aRXk6utkFUJpVT33p6I44d5NnnQ4lVln34904UHxtTVq0dFFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=necglobal.onmicrosoft.com; s=selector1-necglobal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hc9t4CelhZfGin+5SadsslC9u6ayFXXfFASxQ9iJkRU=;
 b=ZBMTVclHtZCeTVkr2BWHq33OPY7TSDfPFnSVSrhk+OvnK7urV1H9kjXQ943yKxw6wr5OhAoi+xJKWDb+tjX3fYbAY0heZDvhwW7eAS25cyWL/TPIuZEJUyCLP6DxBxhsIKVZQvRRQCYZ8lCQyoP8ZfzSOkwQD8bUu2Z4+3rsikU=
Received: from TY2PR01MB3210.jpnprd01.prod.outlook.com (2603:1096:404:74::14)
 by TY2PR01MB1961.jpnprd01.prod.outlook.com (2603:1096:404:b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Wed, 23 Sep
 2020 07:27:34 +0000
Received: from TY2PR01MB3210.jpnprd01.prod.outlook.com
 ([fe80::108f:629c:d934:9206]) by TY2PR01MB3210.jpnprd01.prod.outlook.com
 ([fe80::108f:629c:d934:9206%7]) with mapi id 15.20.3412.020; Wed, 23 Sep 2020
 07:27:34 +0000
From:   =?iso-2022-jp?B?SE9SSUdVQ0hJIE5BT1lBKBskQktZOH0hIUQ+TGkbKEIp?= 
        <naoya.horiguchi@nec.com>
To:     Oscar Salvador <osalvador@suse.de>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "aris@ruivo.org" <aris@ruivo.org>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "cai@lca.pw" <cai@lca.pw>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH v7 08/14] mm,hwpoison: rework soft offline for free pages
Thread-Topic: [PATCH v7 08/14] mm,hwpoison: rework soft offline for free pages
Thread-Index: AQHWkOhHhPSks/uu9Em9rYoCckvXQal11DCA
Date:   Wed, 23 Sep 2020 07:27:33 +0000
Message-ID: <20200923072733.GA15221@hori.linux.bs1.fc.nec.co.jp>
References: <20200922135650.1634-1-osalvador@suse.de>
 <20200922135650.1634-9-osalvador@suse.de>
In-Reply-To: <20200922135650.1634-9-osalvador@suse.de>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=nec.com;
x-originating-ip: [165.225.110.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7bbad6db-5589-4011-fffe-08d85f9223a3
x-ms-traffictypediagnostic: TY2PR01MB1961:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TY2PR01MB1961A48A266D4BF6EDBDB2B0E7380@TY2PR01MB1961.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bJYASbeNhAtdDqw+avwC6R5Y7wCSf5i+76PdeDLC+7RuIudpnqmpDCkxfz559/5Mk0tZtmkfK0wxar7583e0APOo7ldG4aZToAU3xFGmoruJGsG3ZgFL2LDXcHa4VQM4TUr+d0UyO0zmHps9ce2KHhhk2QOhmr90c0aRxuRO/zWv+NnP8HV6L834x4tRc/EFOfoVar/9QKW94lcnHIQqKyvKSGENb/jtVIR1WwzUcegb9yqLrdQZnHGVQBuesF2B1j2WrsFggXHpxRGRMgxtErq5aJUrsBk876TPhxcysY/v2xh4i3b4v+qUa6Ea9obdGzicmMasaYSXhPKTIN2slbOKaGVRPYvzTMizWf7ZcT5PCTMe4HDvLaFzJJIiNaQ3wOkYbZs9LaFozeTBZTSLnA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3210.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(346002)(39860400002)(396003)(366004)(6486002)(26005)(2906002)(6506007)(55236004)(186003)(83380400001)(8676002)(54906003)(5660300002)(8936002)(66556008)(64756008)(66446008)(66476007)(66946007)(76116006)(71200400001)(85182001)(316002)(478600001)(86362001)(33656002)(6916009)(4326008)(1076003)(9686003)(6512007)(4744005)(142933001)(4533004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: Fo/omSQoAXq5qCmESqMT0mdzPi3ZmnkUHoZ//cwzo6KZLktLEZ1Koqpv9yHIB4DelUEZKiU5jYTN7hHB9a1lMx9abgv4ND+FmaSFEAYg449khyGsY8aIWuOtkJzqYUa99FwFVh2e1r5kwCzm7Xv8Cu6r3PV+z3Qaqoo9j9X+/Zp2WbbN0A2Tm7QbzsjD1xm8ci9XO4AV+r0Y4S4T+yJ0vuGViHkgjmBLdVIVUQa4tEw87bBYJcceMury56JoWGLMEHbc14GOFf/XkAHFcP68Ygd0Ea1xOciaPJzQJ3OwHVhW48MIgVXxwiu3L9/TCeFeKc4qM13a48t4tlnN6rxSkIiHjlzIM/0Dr0tjzYFraDLzN/RB6deUnWfhs96SAca6eM7H9YETZgcz0p149gQ6VA0Ec9ndLT6O3fV4OiCWxkAa+1IK1AVyzwX2f/DOZS6+PflnbGT3yzCFcC9NdcB8ri1tD6CKgoa7KdEsSyzV63FwTgN+L5S1Ppx9nG3suIK5GRim/g6YqyMLZ3062nBzf5Qc4+jMoy+FpQDFXgz989o1idvmehvEmPnrHqSSEM8zRHJt3fteKw6wSWp5yYAiO5uOKxhAZ2DJgmPOP7/xkNI1dYQ+QbdR7bzblWxhhG26ZYuAkW387b/qIJ9aojtBjw==
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <AC008C71D459A94AAD31CF9F33CFCD02@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3210.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bbad6db-5589-4011-fffe-08d85f9223a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2020 07:27:34.0039
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +Jm7kKGpxKJw2C1TDkNgqdy/8R4hEl24gjCcoGF7OZ6naad5FuFPIpzWxtsgYvkB52Mp1dhy/spSoAM/0AwOdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB1961
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 03:56:44PM +0200, Oscar Salvador wrote:
> When trying to soft-offline a free page, we need to first take it off the
> buddy allocator.
> Once we know is out of reach, we can safely flag it as poisoned.
>=20
> take_page_off_buddy will be used to take a page meant to be poisoned off
> the buddy allocator. take_page_off_buddy calls break_down_buddy_pages,
> which splits a higher-order page in case our page belongs to one.
>=20
> Once the page is under our control, we call page_handle_poison to set it
> as poisoned and grab a refcount on it.
>=20
> Signed-off-by: Oscar Salvador <osalvador@suse.de>

Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>=

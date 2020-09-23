Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0311275243
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 09:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgIWHYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 03:24:42 -0400
Received: from mail-eopbgr1410079.outbound.protection.outlook.com ([40.107.141.79]:5595
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726557AbgIWHYm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 03:24:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gE/DdnLGl8mm/61juuUDzpgs9eJgSthSSmnqtGn7gaozli3nAGDR5iSgSsV+4DP6C3+CMwcXsrLUSC6EpVOIigBV77xOTDrjStG54WSUwgw6YLDo5uP8MmH5qS/+ACFq04bcSD1ZolJoTX80+xYHYHjrdOV2reXTxhvG3F6n3rDxOdkKiHNAwJRi2hH4Nic+BRzPfOvfXMqoIB5pM883CGOUJVFT/9fBuLbDzmVBzJN32ucA9Z0QKy8raD+1nYGzoCeu0VHhKL4JOwUtJqUeAn8diaNuaeU/2AeW9409xXPYtU4G0/zjQjHHgpMIFqgph66w2KiGMzhv556ov2ycJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GV/v9W4dI/Y0SX3JYKe55p1wd27JJ2HnGrZ3peNNtGg=;
 b=cnSweaDAT9ic1QKteFBO6X26pwVIoDJ12+5AeJcD0kNE+5KuSiXdMi3kd9AIXJfiWFvOQM9HMGqVq6MKjZ8fqYu315rdUAKAIVaj2Bv8bIgLRPYuHhUGt7/WWooxLWCvBW68fS8bH4uro93n/tC7m7Y7LCDtkTu7P0gvn7Ex/h8h+Q6quOj+GuKNd4l8fSy7/PMUGJKh8qGzh2Z0TkDQBt/r7DmPlDXO0EmlsDLKx15NcuOXDvayuLJpOTF0lrzzRl4wbPmXOmtlCkP3OXUIbpySneweqN0GDjG/V8V+4R6XztpixmMS6NEsjEGRKICHLNF3iZrhghDcBtl2A3KrBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=necglobal.onmicrosoft.com; s=selector1-necglobal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GV/v9W4dI/Y0SX3JYKe55p1wd27JJ2HnGrZ3peNNtGg=;
 b=nwOaWGjToYJrGsyLgzBtJwlW1mYWqWX2zq77d1yUmTrM+l4cpK60tdp5BIY2to6+k2tMUQ7dPbDDSA8/zPVY5qq3MK2fLJv6JuceMEGmYLgP9AENRHYixGwX+5Qwv+jLH/JiLTGgqlVIgtfxKoptQl0Wy0S9GTiR41R+wI+95MU=
Received: from TY2PR01MB3210.jpnprd01.prod.outlook.com (2603:1096:404:74::14)
 by TYAPR01MB5484.jpnprd01.prod.outlook.com (2603:1096:404:8033::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Wed, 23 Sep
 2020 07:24:39 +0000
Received: from TY2PR01MB3210.jpnprd01.prod.outlook.com
 ([fe80::108f:629c:d934:9206]) by TY2PR01MB3210.jpnprd01.prod.outlook.com
 ([fe80::108f:629c:d934:9206%7]) with mapi id 15.20.3412.020; Wed, 23 Sep 2020
 07:24:39 +0000
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
Subject: Re: [PATCH v7 05/14] mm,hwpoison: refactor madvise_inject_error
Thread-Topic: [PATCH v7 05/14] mm,hwpoison: refactor madvise_inject_error
Thread-Index: AQHWkOhLEh0JOw6tEEWKLIXa75NMVal1018A
Date:   Wed, 23 Sep 2020 07:24:39 +0000
Message-ID: <20200923072438.GB14664@hori.linux.bs1.fc.nec.co.jp>
References: <20200922135650.1634-1-osalvador@suse.de>
 <20200922135650.1634-6-osalvador@suse.de>
In-Reply-To: <20200922135650.1634-6-osalvador@suse.de>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=nec.com;
x-originating-ip: [165.225.110.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 41490ebc-d0bd-4ac3-81bb-08d85f91bb84
x-ms-traffictypediagnostic: TYAPR01MB5484:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYAPR01MB5484A342EA90968512A50515E7380@TYAPR01MB5484.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2512;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PuqpQkgPtWSvCx6BJBzjive2juA91WVYL4asNjZf1NjabXxubeQlbvhduxdq8Rim56GHxw9YkZW31k216oqaGPK/bm6F+yf2q55sGQT4WY9bPQCddP7mRUG8H67+Em/fHqKSEvr3JenqgGmvKwytvkFaHzeMybK1LVuqoxA6Ewpnm4zokSIuIcRmCjs21QBL+eWX4udWsx6cy7JAvjKADJ+EGoOtCcgy5g02iYjoZwOfo/y2JpXDCNpWCouLQ7bzjwLkSj8oZHkiecMo0b92Sy76QYu1KGnKm9ONYXEZQ12Z4+oBi2CLeS3bzNZkmH1KCZPw0MrrbVJVhgFENtJLgsdWEH4W7/ygQn0GeIUdYFkUQfVKRivPS6jVnxyddqua
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3210.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66556008)(71200400001)(498600001)(64756008)(6486002)(66446008)(2906002)(1076003)(8676002)(66476007)(85182001)(33656002)(76116006)(66946007)(54906003)(26005)(558084003)(86362001)(8936002)(6506007)(4326008)(186003)(9686003)(6512007)(5660300002)(55236004)(6916009)(142933001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: lugGFTnikX5ksxRPzqYYiAQKLvixaKE0OdZ71g4UjfcoPE4tmxEO43dv68y1+rfsnI3WCz/ojwSGzDGkQ8Ufsd+9MlafsV//oTA8JVzNi7QA4LpTJ514HJNiJsXEiMaF7oB5lH610Au8/MGeNFTSTWK3sdfWRixpCl6TlncqFnOnv4QeoyuLa4Cw8vfDMUVmmCC4lwftRodvXxvJee7whXQccuQqCZ3yRG7Y/AulcU7F6E2pm0wQOcX//V1SaAFim4CfhurZu8SzOe2TH3bQ9zBFzvpzM7w8lghWBvvr2aZEg0ogH5qVvAE0t2kwl1OmiMVxdcX749oaBNqOvHm8Skvqc68bHV+id8x76jnBcpoBa6TyAKM6hjIuT5kY5JRwMcIfU1UwZOWkugsJfGCb9zkTbAbWBr90j8b5Ounvlm9Iyvhsg4B6t0gP4MpAanq6DjAvqxp9zhbYGxV0b12qZ8tgJvEC0St9/8ll4ZmAx1Dd9bX7tUc8CzEIQOztTnakEltjij3pt19cl0FFTGcL2jtrDq8E/tDtbGDf9CH/xbICYoGin+ad4/xpIE3SUnkLXZBb/EEBH4WjG0W8etlTaPuymcNVK0dTEhF9JVsIRTM9WxF6ib0rLgU6pf7p+irO3UJ9rJcJtfwR4cMNMcFKmw==
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <D23BE73185959343871EB277A258EB94@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3210.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41490ebc-d0bd-4ac3-81bb-08d85f91bb84
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2020 07:24:39.3285
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0ibqd8tkUqTLi97QJcIXFE2GN+7xlUYaHtOmCKLQnzMALQ6jHIUYkvLVOvqnRK5aIK2qp29s8UhTlP3g+A0s5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5484
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 03:56:41PM +0200, Oscar Salvador wrote:
> Make a proper if-else condition for {hard,soft}-offline.
>=20
> [akpm: refactor comment]
> Signed-off-by: Oscar Salvador <osalvador@suse.de>

Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>=

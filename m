Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8A428D746
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 02:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbgJNAGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 20:06:18 -0400
Received: from mail-eopbgr1310053.outbound.protection.outlook.com ([40.107.131.53]:11258
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726168AbgJNAGS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 20:06:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hp2Tw05RlDSUn2SqPogAu9CfVu56xk202qRaamp2/3Fe1g6sTV+u3ZIObaf4jhLX7IyZ3ptThgs1IUOUJ3x1n9Tv8JLS70wsvTE58C6dkihDZ/KpDUhoi4XIWWBhrlwq8wXjnKCIY5wD5YkoGjvTszKx7uGR/N9HPE5/lQ1V1pG+92PG/Ex4G6hs87ixSLE1KriREFFvqLRTVQq3PA52NDYaLaz7wzkkvSP53BEA7+av4F3og40FoxYq0zTcYKNefr/Qf4SpBZ0zobcKjQp9Ot2xVQ66+bTDCz5Ay/LKzwGrqWQGuOeNB9KawLu+Bfbx/bBOCt606vXHdwZ0X5roLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b7Cngn1oX8IdejRMpPkX1TUzPu1k30KrkNt5woPALkA=;
 b=jkhew9aovVFGWoC0YuIMoXN6mGIzaCH8cJ++RSyR8o/TUMIvso8XCvkTwFPrverI+qq0PTl+megtES2ewFTx64z6phSC8DhXvzChKUVEqx0sMy4m+gt3lnupaNAWLk2juRBIb/hUTYfVNOaNl60X9KAkAD8XauL8fiI8nt3nz5apDnJ66bufKkQiwTcCDtKT3y5quFx4KvzvCfihAZQDhZtkvUnTxePpnbXy29XnLSKVLxf2F3nG1rCC77y7MGtbUWF/66bH6lAVXv31g7FezDj7qBNcFZlOatYJoA9yO69Ovge8ytxIrS6zugFv3e7sww3Diw4eXI1UTOtNAHDgww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=necglobal.onmicrosoft.com; s=selector1-necglobal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b7Cngn1oX8IdejRMpPkX1TUzPu1k30KrkNt5woPALkA=;
 b=GxUHBVydP+XUFhbJGQEsoKI7srVza2C4zDCjHHfkjtWyROOhqCXcbU2sVTiHEkcqc2/GcX5qXJ7A1kgJ4B6S3N5RjmIN2XfEsoWg5VzO8NeD+OAAMbuGFCEeGzFY3f8vS2H8E9v0hi8JN1WNaTUWmCTk5qanoKdGpM7FzlmPqIg=
Received: from TY2PR01MB3210.jpnprd01.prod.outlook.com (2603:1096:404:74::14)
 by TY2PR01MB3418.jpnprd01.prod.outlook.com (2603:1096:404:d0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Wed, 14 Oct
 2020 00:06:06 +0000
Received: from TY2PR01MB3210.jpnprd01.prod.outlook.com
 ([fe80::108f:629c:d934:9206]) by TY2PR01MB3210.jpnprd01.prod.outlook.com
 ([fe80::108f:629c:d934:9206%7]) with mapi id 15.20.3455.030; Wed, 14 Oct 2020
 00:06:06 +0000
From:   =?iso-2022-jp?B?SE9SSUdVQ0hJIE5BT1lBKBskQktZOH0hIUQ+TGkbKEIp?= 
        <naoya.horiguchi@nec.com>
To:     Oscar Salvador <osalvador@suse.de>
CC:     "n-horiguchi@ah.jp.nec.com" <n-horiguchi@ah.jp.nec.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 4/4] mm,hwpoison: drop unneeded pcplist draining
Thread-Topic: [PATCH v5 4/4] mm,hwpoison: drop unneeded pcplist draining
Thread-Index: AQHWoW89NxDWuW2O/UmVydOqXMCHaqmWOMAA
Date:   Wed, 14 Oct 2020 00:06:06 +0000
Message-ID: <20201014000606.GB6087@hori.linux.bs1.fc.nec.co.jp>
References: <20201013144447.6706-1-osalvador@suse.de>
 <20201013144447.6706-5-osalvador@suse.de>
In-Reply-To: <20201013144447.6706-5-osalvador@suse.de>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=nec.com;
x-originating-ip: [165.225.110.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ad9ee4fd-83c1-4913-8502-08d86fd4f298
x-ms-traffictypediagnostic: TY2PR01MB3418:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TY2PR01MB3418AA94D4C902CAF2D80766E7050@TY2PR01MB3418.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: guebxAi9da6IE1tAXCfBO6sPFJ++7Hx9uLwWCOMXunlW/JxMIk3aqf3/PgX2avAeXVn6oEk0jw1GxHIJx5pB2bW6Fzv8AUTtxrXhL+kE4Sd3ffu8qiju0xNelCL7Rj7uAY+TU3S2iLyFTxgeHGnchQje3sssnezxZ+1xQzTxy7u8XzzwGk3ybX1626/lkKIxUZ5tjGkiKDUmrzqoUbju8dAoFDftyd5LQwS4aRa88Ve0cnC3RT7Amv1qGjiB8KfiqtjCyQ9lKvDVqyQ/hcJnSOXtuICA7lPNRCYUFfz23Uh5rVtYivXqwI1PPFmjTcLzAB0hmm3bNNDGFhCZjJ25Yg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3210.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(39860400002)(346002)(376002)(136003)(6512007)(66476007)(9686003)(33656002)(316002)(478600001)(54906003)(83380400001)(4326008)(71200400001)(6506007)(66946007)(76116006)(86362001)(8936002)(66556008)(8676002)(26005)(55236004)(64756008)(66446008)(4744005)(1076003)(5660300002)(2906002)(6916009)(6486002)(85182001)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: InDCt/Vv7/9UO1bUS80y2FHpwdNKY5wyWQHnJHluOzGVFzqsiuDZ970bDTkoo2LVgHgnjQw8dQH05bQQpRviVqd+VvXkDzTpZV5E4M2XfrD0lflrictRbez2WoVzfzA4oBZ2fsCxPDAYvAGK2/ei+ve456GXvpFE+W1ES1YOaQmmU4Q5Uw/ipsg314r2n6gj13x4rjEWk7q3q+Z7+DlCTwTXo4IOjJjiyW5lDw1vZQP7mmubIzeLxLc9gocgMw8m0SxL8UViUC5j/aGPWUXLuT+I1kVkQiS8m37iA4Qs7Q3HI5HL47tnpGxrlBGLe0TT6Cc8jfbVl8GZgJ6aP101wRrNxv7xNj5FmMo57SpWT39D8R8o8ZjeSqoj/+3J+usbe+6a5nAV5ReaLnMtxuPgmsntqI9wVo56Td9jVI1IqegOnUxiXoNLL06DxaxpSqgG1t43ij2osXbbVjTrdpEnHI7EgpHlvkXHSIeZHpHRAPRzv9ppOQvPovuHc7gmdtlOCgvYjkL08YsyJN+dsTtmVcL6JaDqJDqOp5zVUs6IUZbCdDeBQsfLumSaYQirpoZRE/dvk67ol/RRo56FL8h4uHSdjOGxi27FyQrM3f4LC4WxeKCUXHo4rvsZpV0Bz5E4XO0NIbe9+v6Ffjq8sbjEUw==
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <E570CF54ED13D049B8D732D2BD7CC51E@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3210.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad9ee4fd-83c1-4913-8502-08d86fd4f298
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2020 00:06:06.6257
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bimMNNYea7KqjwvNiXQQurgJMsASkNIhhFFbuOT4twkcLGGCSH4CBFg8Hg+hx34FLg/c8eSz0Qjo6z30d4QndA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB3418
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 13, 2020 at 04:44:47PM +0200, Oscar Salvador wrote:
> memory_failure and soft_offline_path paths now drain pcplists by calling
> get_hwpoison_page.
>=20
> memory_failure flags the page as HWPoison before, so that page cannot
> longer go into a pcplist, and soft_offline_page only flags a page as
> HWPoison if 1) we took the page off a buddy freelist 2) the page was
> in-use and we migrated it 3) was a clean pagecache.
>=20
> Because of that, a page cannot longer be poisoned and be in a pcplist.
>=20
> Signed-off-by: Oscar Salvador <osalvador@suse.de>

Thank you!

Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>=

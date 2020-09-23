Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBAAB275242
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 09:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbgIWHYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 03:24:30 -0400
Received: from mail-eopbgr1400070.outbound.protection.outlook.com ([40.107.140.70]:30302
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726557AbgIWHYa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 03:24:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WFfhiG4wvcfOjLNGM87VA3e5PY4n5IdrYsxhWtOO0UomxlIPd44TgbNhdhhK3KvJpoIFd/2lbNv9eD/FJ7EnWc6yi3/FJ7YJ799v5NmhIAciyxHcbPukZmn3GCQQw2Uoyw1WaDjAJXWTOL9co5pxMxsAKo/tBHbXzOoPPV8gEljKKwud9WOG8cxMLVJ8U/DEynBNqTStn7kIbTwH5ycej8Wpi70fGfcwaM1kRh2GDz9Q8IKNzF1UjmHqoPOVRrCdnSfVFEnXEgDoKLT6WZb4JU+muw1eZ8G/BbqjjAkFio22eLI/nNBSV5NG7FwqJyS04dab5AEiPNc3IDJKLX2/5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fae5y8CztG+/NlnQnn5IPLfxiRoWrokaZ2I3tKKtZAk=;
 b=lj5jVaHAyYyoEFWbPCXbssxkA14REeia7PSxJ/0ojvMffFVSCPJ8ramHsXz8X7NnefXDBn44UxHJ24pfUMOfUuMZoi0MZpWJRVN+JRaFX8EeFaXqoswHjBcOK3xe5yDWnrrq5K+xcYNSER+/kiYg0NHaK23HTpw/3zbSzNZnpcozBq72+Kye95fQ/jSMTdtK52xdv5VASIV0knScqICnPo0D5NFhJgST7dzLRCbw0KbGVgy4A1q39UGZ+rlalEIfkJe5pcyQEB0rgAIGhQsZ2f8ZY0DiX9b5ywvppRa+QzB6PLfUS5dx27N3kWFc9bGM5xLTt7Y4FL3+PfGLhSvHpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=necglobal.onmicrosoft.com; s=selector1-necglobal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fae5y8CztG+/NlnQnn5IPLfxiRoWrokaZ2I3tKKtZAk=;
 b=sx6iKZD2DlIJl2iGQ7DQ8y2ev5W0RlpjkJdkFjslDlXwkenDcrVJYpN097xwNVLOMkAabcdlFu/yFVqjEd7lg/1NH4AHw3/Y2mALI7zJMZHjV2Y8BbFCHcM6p1nGy2ZcrqBMMuRSn9ldxX/ytxwN8/iKnm2JiMf/oZsQryBVwBo=
Received: from TY2PR01MB3210.jpnprd01.prod.outlook.com (2603:1096:404:74::14)
 by TYAPR01MB5484.jpnprd01.prod.outlook.com (2603:1096:404:8033::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Wed, 23 Sep
 2020 07:24:27 +0000
Received: from TY2PR01MB3210.jpnprd01.prod.outlook.com
 ([fe80::108f:629c:d934:9206]) by TY2PR01MB3210.jpnprd01.prod.outlook.com
 ([fe80::108f:629c:d934:9206%7]) with mapi id 15.20.3412.020; Wed, 23 Sep 2020
 07:24:27 +0000
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
Subject: Re: [PATCH v7 04/14] mm,hwpoison: unexport get_hwpoison_page and make
 it static
Thread-Topic: [PATCH v7 04/14] mm,hwpoison: unexport get_hwpoison_page and
 make it static
Thread-Index: AQHWkOhECxR7xesw+0qv0uU/neSYZal101EA
Date:   Wed, 23 Sep 2020 07:24:27 +0000
Message-ID: <20200923072426.GA14664@hori.linux.bs1.fc.nec.co.jp>
References: <20200922135650.1634-1-osalvador@suse.de>
 <20200922135650.1634-5-osalvador@suse.de>
In-Reply-To: <20200922135650.1634-5-osalvador@suse.de>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=nec.com;
x-originating-ip: [165.225.110.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aa3bac21-7f4b-4669-bdf3-08d85f91b496
x-ms-traffictypediagnostic: TYAPR01MB5484:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYAPR01MB5484982B62A0FE218397D4A7E7380@TYAPR01MB5484.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EpLnFM1SGD0LtvlTdQ2l+9z6x6it+ucMZB3BkrB4k8+X6Ai+qHbFJEAKPS+siCe7/eFwV4CMwDwAgZXgSUvqVg32rB3RC/Ztgz0Rvk5ROYN0FBYaMnVANEizOwuXWi5/jUgH/k3y7MoulPEbujg4Dd/EI2wDogSZ2auKzQShUtawDH5s4trACyYKnDtnuJNzlm9CQna5SKGL8+ChcWUtPONuy4P0qx9NDswa3iWQvnTJGgidLrS+NC2QePHsf3jPTrElA8Or7AY0MYF2Jw0OMYFe0KVLN1B8bwYWXTtYO7IngK6KZAAY8SKuV0u7v1LOHFK0RTRSDPKcR1/du9cvGcYPbCVby/gNvJK4uTjlg7hdXrB7hZYwswwMgot6QUHT
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3210.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(136003)(376002)(366004)(346002)(66556008)(71200400001)(64756008)(6486002)(66446008)(2906002)(1076003)(8676002)(66476007)(85182001)(33656002)(76116006)(66946007)(316002)(54906003)(26005)(558084003)(86362001)(8936002)(6506007)(4326008)(478600001)(186003)(83380400001)(9686003)(6512007)(5660300002)(55236004)(6916009)(142933001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: VR7k0weUXstkWDZlNT7el+dJT7iJDwHO+X0JlebcQWhYGzDahpqKEWXv8gk7hyKCPTGNxwzT9vCwFCiZQci5xbU7acL1p4FV4wNnc2iYdjBK22qe1EqIYKdpMaSiv8gQeaGp5OTe9yqKI0j5q4Ry+3p4liy2idSd/U4CJYGG9N1VBMUVOuzRGVo5lrziaF4+aeuHc1yTiepZe/DGaAzcNPe+ysN72JMWi4FqTCSBHKbhDVbw0ibRCwdze9/j1TPK/lQcgiSZSKI0oG7SV5pbrZL6z8Gq2E1ouDGR5Lt6p2owgjUZhCr2YZAFfdNhPoQUstuDFjqTCV4DA1oZiJgttsNtfkkqTHR+/7/O3Rw2d1CNLAZVVNo31rYqiu8kr73Uoai2CGpjUTmRAHy/jpDhpdBKz/8iiY4xnM6ME4Web84of9XJ/VPgElUF+jrccusenKPnCS13pbpE6x6q3wWZNEU74WALF0Z5xF22WpysJeHv/Xj6ZdRE4dJn2Ie9d9QJRf7KFYOOlYf8SD9iwLZe481Rai1wo9+zXevDgFgE3umap9H8ieKir2vIXOYXA5QI/p1YlxUqNj0Ehr3HRNHwC7/V8OhxKCPVjjbj5yh2JZLXPBo88nwbcFdqZfvTsR/9Uc/IJtHipa46Ht5FvUjKrw==
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <05417238B542DF40845999A67F8E7C09@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3210.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa3bac21-7f4b-4669-bdf3-08d85f91b496
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2020 07:24:27.6730
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /8YHTVfmwLnCnv1+DgV6raI3JoodsEpXmz1Ll0Fk58mmwZ9UyqHHQ0aEKn+2+IwnkhUU1kGFIlCj5BjgVD2E4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5484
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 03:56:40PM +0200, Oscar Salvador wrote:
> Since get_hwpoison_page is only used in memory-failure code now, let us
> un-export it and make it private to that code.
>=20
> Signed-off-by: Oscar Salvador <osalvador@suse.de>

Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>=

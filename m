Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA76D277DE2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 04:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbgIYCWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 22:22:30 -0400
Received: from mail-eopbgr1400089.outbound.protection.outlook.com ([40.107.140.89]:20623
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726448AbgIYCW3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 22:22:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T11vM3xI1CXx+rv6OmtJnjYl2nVYQh6bf8AMLPGLgkI9jWKF85f1wIdbNHiexKg0EWJCL06eRzq5C/QVsIzhQz5AvGgCDpUC/1U1hrdwGE/6r2EujmCPfjzHrWpYXamEYG9AIhGXHNh90PTUCLHmMkGXgrwcSjnpKApeWUovi3+1DLpXFrGci0c/7zptFIS5D+aUrrkQQbtJzHgFa/aHXq76+smmodC+hRAnOtUAETCNAlidieO+y3qvdU1svQO/ISVTXr/1+NFchII/8uyfBCRL+Q+wgCqiB+WkEMpGuvKPINXJL+UPKtjCrU6azvSDjxmID0qRkA53kj6qneTkHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AsPIWV0sDyEP2CXg1ZviRK2fYxAQ/6aBNf6IOfRnWCA=;
 b=Pix1yRDfxHYOYv76eOiVJDRnJgt6WheKUNIez5t34viHTI4YU/2kqv5RV7by6qLuOdPh/LaXjov7z5WbAP9Abm7GHoXQq5D1N+p7lNokw+28BmxUULEM3jEpmNuPtyRglzG39FvWlLHu7wdq4DndoJx02Vf73NVNcN/xa92eUjGFmwmXKItekOmO24euHcC5Z4BoccTwgL551eGmR/4vkZFgGdEJM/W2LFVgmXPAlWdt+XZ1bnRUK1j4wQCSlEATcPeOuXL5eZdbTTzAsctfmFoe19t/D3kcoP6GxErvMQiS58MOpY1HIGxDPObn6c7yjzOzl38oZ1bcmwP8u2pQ5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=necglobal.onmicrosoft.com; s=selector1-necglobal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AsPIWV0sDyEP2CXg1ZviRK2fYxAQ/6aBNf6IOfRnWCA=;
 b=QjWitDr/8f0kq0VF8sxvTmGRkm3jF96oj3wLEbDpHCVf6K23DyEecunNe0U8RMEu1D/Aig4JaqOGo+935rAPzDmN4HOYyE5VxLbPXXMnpOkjatjR04c8iI2t485ux9mUsulOnFmDfbiMLUNvPgN6NTB9JNB+PAIpxaRJF1KzQZU=
Received: from TY2PR01MB3210.jpnprd01.prod.outlook.com (2603:1096:404:74::14)
 by TYBPR01MB5486.jpnprd01.prod.outlook.com (2603:1096:404:802d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Fri, 25 Sep
 2020 02:22:27 +0000
Received: from TY2PR01MB3210.jpnprd01.prod.outlook.com
 ([fe80::108f:629c:d934:9206]) by TY2PR01MB3210.jpnprd01.prod.outlook.com
 ([fe80::108f:629c:d934:9206%7]) with mapi id 15.20.3412.020; Fri, 25 Sep 2020
 02:22:27 +0000
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
Subject: Re: [PATCH v4 5/7] mm,hwpoison: drain pcplists before bailing out for
 non-buddy zero-refcount page
Thread-Topic: [PATCH v4 5/7] mm,hwpoison: drain pcplists before bailing out
 for non-buddy zero-refcount page
Thread-Index: AQHWjMyLiefsQAYaPUOJQQGH511pNKl4q9OA
Date:   Fri, 25 Sep 2020 02:22:27 +0000
Message-ID: <20200925022227.GB31132@hori.linux.bs1.fc.nec.co.jp>
References: <20200917081049.27428-1-osalvador@suse.de>
 <20200917081049.27428-6-osalvador@suse.de>
In-Reply-To: <20200917081049.27428-6-osalvador@suse.de>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=nec.com;
x-originating-ip: [165.225.110.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 91e390ad-9812-42b1-2492-08d860f9d8e6
x-ms-traffictypediagnostic: TYBPR01MB5486:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYBPR01MB5486F30A07B8AAE2EC7CA568E7360@TYBPR01MB5486.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s6ImBIFAkj+e/4jFXO9t4WqCIaYK98kNQpH/Zydf3FQqAnjRKe+Rz5JSFHE37d1H0VinejpodsS+FqLn8fi2ETzrK96surfd6Lh6kI/zof/oYPANVgglbtn4KNzmzeNzGu0WTN2E1B81vfJal0+iQmLfho0LClrjHn5e50Kli6njFVPf/BtxENWZMtw4b/sIJBcbOIebLUucwlnsiVu9mRuTz+AWAqTOjehAVPhcQzC2vRT/ZDGsuR1hym8Y1pUaAZ0QYfN3kYoRrVLbkJrO2IWLB2515l5Oi8YR5A1nfTwDtj6bm9If6/SJKb9ZgEy/SvI02OPoU1NMfmNvC11inVDTT8RLUYu3QTe2HlLoyLzb3cVuiy1YOEXY039Fgsrhqw97R1dqL+W3h6e+5Zru3ehswoJyPFOYUjV1B2Zg914=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3210.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(136003)(366004)(396003)(346002)(186003)(4744005)(66946007)(71200400001)(26005)(85182001)(4326008)(55236004)(66476007)(316002)(66446008)(1076003)(66556008)(2906002)(76116006)(8936002)(6512007)(9686003)(64756008)(5660300002)(8676002)(6506007)(6916009)(478600001)(33656002)(54906003)(86362001)(6486002)(142933001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: xvlmQNQfUrenaMvMfeIyfATnEkyXxVcS/9Kwdx2WpTu65P3VZdHoFDCb/8/ntxoO+5HEatw0TmgXZV0gBDkakDHb0chTelPmj1vr8cKmiu7BMrm4Tftxzpxf+WBGcS/mqKS/PJJxRQhYogf3em2LBGdOBUoab2u1g0B/qYQBPhxLkxAC3c/8bJ59IxnJfY3KHveTDqf0kkCz6d6V1BXE/0gSjUmlO5u37P+ez7KLkWthiy1b0l0LcygR7LQhYkPj2ET7Ru56oiDNetg/u4y8cgUbrel1f9ijIhYAFHUb6CK/TXYT5hRCaWPtFqeL0pBzcCZ5019zPPTt7MzXQPDPEhZTyspmagmdZUXGQEqPDQx0ZSieLPe1yii4mi6RN2VhkhChvBDXRn3e272v9Nuzr200IQFBKhkGfMjZiVyNjU38W7LX7WfVPupBhXUkr4cwrksrpTsgbDHBHP5YSq2eruUMchzPObAQiKvBAS5fZV4CP9bQbx5ynHNAiFh1UoAhZsn5fX5Da0FFbslnLRsmMc7/84cnhDvSH0dL/FD2DA5O8nlDPTPJSM8xlGgh9amPVJRxm29c1hvRQbiNY/svfqVT06GvPLyEEm3sYx/XHJzw1N4BVrltZ7MWT1d4fVm1KdUkv2Bkhethxn9oQ3uxGw==
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <D17C0422B1AC984DBC15CB2510CC9E32@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3210.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91e390ad-9812-42b1-2492-08d860f9d8e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2020 02:22:27.4539
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ioB+13mxPN1VVr5IeJW44DGqpC5UrtRkydRLLEFPScihCswmV4NrWlih8HpLM2Mdhj2fmqLAGr7VxbT8tBDuEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYBPR01MB5486
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 17, 2020 at 10:10:47AM +0200, Oscar Salvador wrote:
> A page with 0-refcount and !PageBuddy could perfectly be a pcppage.
> Currently, we bail out with an error if we encounter such a page, meaning
> that we do not handle pcppages neither from hard-offline nor from
> soft-offline path.
>=20
> Fix this by draining pcplists whenever we find this kind of page and retr=
y
> the check again.  It might be that pcplists have been spilled into the
> buddy allocator and so we can handle it.
>=20
> Signed-off-by: Oscar Salvador <osalvador@suse.de>

Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>=

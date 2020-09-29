Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC6127C5D8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 13:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729979AbgI2Ljd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 07:39:33 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:42562 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730438AbgI2Li7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 07:38:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1601379538; x=1632915538;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=oN/iwRnumSz+ayb71eLOzqGXykKwOUHXWW7exat2grQ=;
  b=n0HghYyVfcU9OXNM41hVdMoIlZEolQETBEQMrFbG15B6bvAiOLja4hJ4
   H8nWt3APz7MhuwUI6Zocj2XVeNJK49FdSPa965+nhneSnmPI32v3dqmiD
   jpcMvMRPBBq7PskEDvsYCVAg5oOJeYIoMaU474Fn53A8G+Ve/2kjEDKSs
   Jkq38MbkuTHO0GmuEnLYCaJVBictBGiexLCPIseH71uLv1v8nw6Gyz169
   XG9W+eJYMCNee2AKxq7MvU4BOhFSLirm6C4YrgfR6NBx9PzKmVfj61hf6
   H4Cag+Lkdv49/Vv6Ap60PZJquOiK9g4qPJcuQNqTxfRngRWMN7gCl79Ss
   Q==;
IronPort-SDR: eoyVZWidkwCEfvtnnGiaeZieu7Bt/MKP5skyh2UFlq0omzYDWFCzvOuqRfakaMkXmRgKlRz1ZJ
 A8ewlMkL4385Ks1V6/7tXePqvKXrdD42J88oomYnJIgYtVuB8o+hZLMZyvBdctFz+a1EZnrDUl
 qMxC6ARVjjq0p5+bJgRoXWyhaoMQlzQyhO7/EFj4IfJSQZ4vC+4FdFyi/GntLbTvC6ECbIgjrL
 qhOoRDWp4DWKOLp20F+JJL2Pinef4+NR1dWPXr6H0947a4qaM0VnQtDu6IhrZy1PjSPQQtH8mg
 vhk=
X-IronPort-AV: E=Sophos;i="5.77,318,1596524400"; 
   d="scan'208";a="28038439"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Sep 2020 04:38:57 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 29 Sep 2020 04:38:47 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3
 via Frontend Transport; Tue, 29 Sep 2020 04:38:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OV3FYYnpAlVfHRVgbWRiiZS5AZbWrxqSGkl2xRCfriTG0r6VyK2rayd8WVtgMZh0u32xVvtADlIfoXpbeTl6DXkw69+yVzqddZrBbQDdFjM0spGg6ZrAsXoa/+MVNzgjGyF5QgDODOum41Q0iHusC0GPkZw8/nORm64GvHsJ1eoc0YRhtbqg8gCq0QcMrw1teVHltb9ul1/03jRSSDkTLh18VGvZzpJCdL1hLpR2iaOQfGkeFvs+1PC3u73yhO91T6tTRKbuZI2ang01LMT3oJcjz0URMw7fxF3sXVOuB28gAYkIkSXfASUMkmVVTB99sBFzhY1O1pCDGXtkXeALZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oN/iwRnumSz+ayb71eLOzqGXykKwOUHXWW7exat2grQ=;
 b=NvRHnbPO+FYnR7SS9pX31TGS25bLnrZD6S0yzRh98NyC4Cn+tMyTX97a9Z3qE23L1q1hJckjyJQe8py+GZs5hycuxWdjB5P61sOhSTJXrDoE6WpsxMc/nA22Bk56Vn6HnHF9Xr1Q9YW2CdGFh3KjXbR++Wdcmii+2zFGXMgs4AKmdyAPPj3xhU2TKqcdsjgERJdtfj4DIo7rcfs4LrE0NzoWWZU+AcSR6EMoZpGOqm+yPHPQ2b/VDZ9LYnrM7pWBZY611a0N0rL0huMdlaqE8P6aR8d+NJRTrNKqP491W5UTkbwF3/kQl3amn+QqhfPs47bj2xuOd2/SRNhpqG93Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oN/iwRnumSz+ayb71eLOzqGXykKwOUHXWW7exat2grQ=;
 b=oYZwAJYEwWPSgkKoq9avH/IHyv/nAn5+wfzChzktc0z6oeTa6Kp7T2OSU/XqA/g7RBRv8snCKT6fJSMtGP6JPgrvUE4tbK7RNywn+vFxxYoV4YGHDxQm5t/ZZLQYMvpciewh3Lp+5oIMDg4Fq/3ct8yHE34kGgdUSPk0H6RvD5A=
Received: from DM5PR11MB1914.namprd11.prod.outlook.com (2603:10b6:3:112::12)
 by DM6PR11MB3084.namprd11.prod.outlook.com (2603:10b6:5:6c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32; Tue, 29 Sep
 2020 11:38:55 +0000
Received: from DM5PR11MB1914.namprd11.prod.outlook.com
 ([fe80::f44a:f58e:c13b:947a]) by DM5PR11MB1914.namprd11.prod.outlook.com
 ([fe80::f44a:f58e:c13b:947a%4]) with mapi id 15.20.3433.032; Tue, 29 Sep 2020
 11:38:55 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <p.yadav@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <nsekhar@ti.com>, <boris.brezillon@collabora.com>
Subject: Re: [PATCH v13 02/15] mtd: spi-nor: core: add
 spi_nor_{read,write}_reg() helpers
Thread-Topic: [PATCH v13 02/15] mtd: spi-nor: core: add
 spi_nor_{read,write}_reg() helpers
Thread-Index: AQHWllUbpbr2eCvR/k2DO2tfqwxa1Q==
Date:   Tue, 29 Sep 2020 11:38:55 +0000
Message-ID: <8632e742-9526-fd80-8980-2792075f194c@microchip.com>
References: <20200916124418.833-1-p.yadav@ti.com>
 <20200916124418.833-3-p.yadav@ti.com>
In-Reply-To: <20200916124418.833-3-p.yadav@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [82.77.80.20]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b1ce23b7-682c-41a7-50e9-08d8646c3f4f
x-ms-traffictypediagnostic: DM6PR11MB3084:
x-microsoft-antispam-prvs: <DM6PR11MB30844032374C081004EACA37F0320@DM6PR11MB3084.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:660;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NXx2eHg/u/Tp7lzKDnWBtXswzb8ywfBneq9oREvuJJigsEn0WfEiAMEDXvPT28tHYLEJenes3J0eWUlL021vTzf5+kthOIKPWxF43EKnsZBGE44gKEgiKhC0uawdFkYROB7qelUTRtjQ8Gl+Ipw6fnBT/33MsbrjZexnMGa7uAgmYBv7d9EuWe51+zkuf41gl89EIIqLZJGSoYh2bXGoY0A3lE6ENqkAl5uYrKF50J00Sk4RAUFj0gjSSuWJfc8jNUPTcVncAK89iXPZovMZiHRseMa8eV+e7qoNzVLStzf1AuSLUQ+9WagwaZrfY4e7nyFUGR0uwR/d8RVuzpC6p2uzNdClFktwGK6cc2awj6ST0/d8CTvCtYe9DMOI6QkW
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1914.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2906002)(2616005)(54906003)(110136005)(31686004)(36756003)(6512007)(86362001)(31696002)(8676002)(53546011)(6506007)(4326008)(26005)(6486002)(186003)(8936002)(5660300002)(498600001)(4744005)(71200400001)(66946007)(64756008)(66446008)(66556008)(66476007)(91956017)(76116006)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 6bNLdBAkNJnROPfsk2n9VdMq2JWho+S0Rqj95hpOBYkCM6IiIKxqkRLPqSgks0jWx6EuQYfwk7yCNoVBELx26fim+Z843FETTzc36QlfGSgM5N64HtUh64QbZf0Ho49wCmchvXuPMzOoiITtvCdqWXsR2qMljoB4m1k/ugWJLQ8PkIpuF9o2Ls0mPKw6+SFSCcmUGwEQTLymxSOi1696C6xzYGP606lUSiIJp+U46HLUq052nGgCkanPSuvWfAl2S+zk5vQJTCgC1EgNOu5gK8+WYsnapQw4qJXl+2HgR4XVCNFbETaQsrNAU6/N2fA82E4ppu2vFh89KdQmailyu7y2m3MghXfx8XfJk565ghOpjcWpI5Fqiu3VUMhcvgeQniDZH+Jp7sTJCyO5fvh6uKOB0ydAZ6rcCRJD53h4yYSUcYgBIfP1Wx84SmjERWfcZB8MXm4Oc7l9DKAypax1/vW41YQn6v4579SRlF9dqJn8Sxd7yOKlGtIwlWKiT+mVlE8ndquZwYRG8mWNeRa8bp5Dq0a+G2N598ob+kvJ9Z2DrzxkxwDK/vYxeiVT6u8PPX3KEFkHcYJX4NM+ksn6j1XzFEgC2zDSJng3s3ByoxXkI+09dB/hwn5OQHhBilL6na00lJd6OXBwfxw4gcEqIg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <C8DD376693DDBF41B62859DF1FF59565@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1914.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1ce23b7-682c-41a7-50e9-08d8646c3f4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2020 11:38:55.3433
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BSq/gSOe1NwRWl53N1LFFGYEGzaBBaCAdiotSblgZuTGXsoJ+TnQHlVyL1OdSpw9FsdETUidY7l0bpS9RcMGwGj00FdcHl5vZ5+uJ7jicQs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3084
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOS8xNi8yMCAzOjQ0IFBNLCBQcmF0eXVzaCBZYWRhdiB3cm90ZToNCj4gVGhleSBhcmUgdGhp
biB3cmFwcGVycyBhcm91bmQgbm9yLT5jb250cm9sbGVyX29wcy0+e3JlYWQsd3JpdGV9X3JlZygp
Lg0KPiBJbiBhIGZ1dHVyZSBjb21taXQgRFRSIHN1cHBvcnQgd2lsbCBiZSBhZGRlZC4gVGhlc2Ug
b3BzIGNhbiBub3QgYmUNCj4gc3VwcG9ydGVkIGJ5IHRoZSB7cmVhZCx3cml0ZX1fcmVnKCkgaG9v
a3MgYW5kIHRoZXNlIGhlbHBlcnMgd2lsbCBtYWtlIGl0DQo+IGVhc2llciB0byByZWplY3QgdGhv
c2UgY2FsbHMuDQoNCjIvMTUgYW5kIDMvMTUgYXJlIGludHJvZHVjaW5nIHdyYXBwZXJzIGZvciB0
aGUgY29udHJvbGxlciBvcHMuIEhvdyBhYm91dA0Kc3F1YXNoaW5nIHRoZSBjb21taXRzIGFuZCB1
c2luZyB0aGUgc2FtZSBuYW1pbmcgc2NoZW1lPw0KDQpzcGlfbm9yX2NvbnRyb2xsZXJfb3BzX3ty
ZWFkX3JlZyx3cml0ZV9yZWcsZXJhc2V9DQo=

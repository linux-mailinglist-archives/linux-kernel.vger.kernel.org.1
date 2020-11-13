Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C08E2B17AF
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 09:59:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbgKMI7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 03:59:42 -0500
Received: from mail-eopbgr760077.outbound.protection.outlook.com ([40.107.76.77]:13027
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726184AbgKMI7k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 03:59:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LENovbgNmFy4GcWsp+Pw7wOT/7jPlmavNI0ds9076hGquij6Eix4vXiTzNPxz16fNZYazGQyXxIvjUOj7V/YmmQ6sBGP7QrVUwI/CVCldsdDj9vwH88Lh+1PF0Uvn36FV34lmhlLtX0AIbsJ1rU4FiivEnplw+X4U4DMy5GQ+MHotWuhYcqt91FBYbO0KJf+piUuX8Ng6ypmHdhrMcTZ+TioWFDRVumyTX9BPyDLnk/rltkgvYmErjm9ZVEn6CachzeZtVyUBY1XPXr5bkWN0KJhtCIaqaphfLyFl1CPtFMtd9Cyx5fpSeVAWpgHrc5u1YoXaTgK3W69BUMgFbY15A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sAbpZgVOlSnratarffnoXddLQ5n1UaOnb3loPsL2I1U=;
 b=Ai1cXDw6dWI/vGUbevknnuh8S9WKAUDT1NhF73Fe3x8AbaEhaL/ZDrAk8ReElelHvFloRE+OVV8/4WwYRNJtpPTCAz1N9N4jQtxQartqIeqjFx44saOUcbRtRYu/84DWy4k2jkGFGD2wcNtiydja/8xIkTt+jr6dxLweMYBVwteMofrA/3Jco3g6r0zlGJ0TJ1yoJlhFHral0hC24qHUaHcTgB+u2QmJIcZ73yLaD+rx4lDyO0zojUVeGUe6wK3JhM/vm8Fd8dEsOAVYgB7VxAsLleCokvFcZZIGe7C16oGVGjLEl6JXLMpgkKflPof1C2eQdXh8zAeN8PcRsjM3lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sAbpZgVOlSnratarffnoXddLQ5n1UaOnb3loPsL2I1U=;
 b=Z/kBPOXIAEMhjJQZA6hrvhMvQNtPWqVkLRVfhO3kSk2zDp5C0nizxajN6Vzhm8GniKan4SLQ5iJ6cfKiyA6UYZdLyAngDipYCaC5bjMUlQpyftL0oIEXfvvBBblXhy38bg9mSlOv44+54ItA+UCabJNSvIr1bFiZi1pJIhiHROc=
Received: from BYAPR11MB2632.namprd11.prod.outlook.com (2603:10b6:a02:c4::17)
 by BYAPR11MB2918.namprd11.prod.outlook.com (2603:10b6:a03:92::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.25; Fri, 13 Nov
 2020 08:59:38 +0000
Received: from BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::dc7e:c582:20a1:5bc7]) by BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::dc7e:c582:20a1:5bc7%6]) with mapi id 15.20.3541.025; Fri, 13 Nov 2020
 08:59:37 +0000
From:   "Zhang, Qiang" <Qiang.Zhang@windriver.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     "pmladek@suse.com" <pmladek@suse.com>,
        "tj@kernel.org" <tj@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Zhang, Qiang" <Qiang.Zhang@windriver.com>
Subject: =?gb2312?B?u9i4tDogW1BBVENIXSBrdGhyZWFkX3dvcmtlcjogQWRkIGZsdXNoIGRlbGF5?=
 =?gb2312?Q?ed_work_func?=
Thread-Topic: [PATCH] kthread_worker: Add flush delayed work func
Thread-Index: AQHWuAsDS+sR9Wac5EetEP/DfReRF6nFMDeAgABxhow=
Date:   Fri, 13 Nov 2020 08:59:37 +0000
Message-ID: <BYAPR11MB263258BCE554A9EFD2F3A8A7FFE60@BYAPR11MB2632.namprd11.prod.outlook.com>
References: <20201111091355.19476-1-qiang.zhang@windriver.com>,<20201112160135.2b5720c66b020472892f2366@linux-foundation.org>
In-Reply-To: <20201112160135.2b5720c66b020472892f2366@linux-foundation.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=windriver.com;
x-originating-ip: [60.247.85.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b6120edf-82c2-4e9c-c510-08d887b27336
x-ms-traffictypediagnostic: BYAPR11MB2918:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB291895653D9951A23C0CCA55FFE60@BYAPR11MB2918.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HoiaR2YEG5uekfKxIoXNmguxwhTVDfLly50PLtilA8og1rdsSHJKIBq3/HYsGzBNxxJar7jI980Vmg1JB5fAlgFHRcbijsjfMQsCvmAicrS382QVWOUcXJMgj+BjlFEki1c4tF3PSjV3S9y9xHHDpvcI4g18xxbQua7VtjM/+6NekSuR4K5pAiLcR+71TxfZrl2Oyus43eZxAZuHBsKy4xLYM/7sX/1GaT2yIn5fuBB+NbG1y9tEuVMcu6DXrdHlI+CXecyLfkHwSquo3DLlVk312V/UqTalLmZPrn7l+9WlSJl1ExtTEYhIe49ln0HJ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2632.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39850400004)(396003)(366004)(346002)(376002)(54906003)(224303003)(6506007)(478600001)(71200400001)(26005)(76116006)(316002)(91956017)(8936002)(2906002)(107886003)(6916009)(33656002)(66476007)(66946007)(5660300002)(55016002)(7696005)(4326008)(66556008)(66446008)(64756008)(9686003)(86362001)(186003)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: h+P09maV3vQ2QjXz1k7vZmi5NK7t59c8+vA2AMp3psf5k3eSzWSUwmejlySG1SThE/yijgDNkRX9CJ12QG7fPrQSOlDk8uQyQt/8m7qzKrF51PjfwlmAK95PHgado1m+sjXHRk/qaoVGcRYiWxxTDvngKMf0X2NZSZvFL3RwV9+oiaFhmV+fsrJO061QVMC04urwmUTZhE3V2xzutLVlpCWI3tLktVA3AzkxDzfoEqZ5SfKPyVBGUo3BcdmBEhARvj7mR6GNSsvW/iT3cMzd83RtoM4bkja2gf3i1CS7KUEXtELESIjbjIoiT6JNebXpwuVlxClBeA5i4tWA6UKbH9XBeA7/6eR0209cscKsziiEGjmmxedo6nFtrBR9gX3ekwsfWR16HnUSmCOvlMVnxBR80N2s+O7DZ8/qiPIzXXDi0kIzqH+ayxUzKwp/aR4w8+wSQzHUk99+6KGQlN701zz/IppqWuEf0HuspobF41sVoPQrB6pWJlXcfCZgLpbX89pfnkOjh9VR59UCw4Nh/H3eQUzBhHtskOJp8paadAx9iX0TcYgzxthr3lyj1zTNZ2O12AhPmPchucIvT0ZwwXjOf1j8VPXjOuAxMDlWfNzYmSnrq87LsYTpYd6LmBPMAVRUGowOqqvQgKkV6JnAgg==
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2632.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6120edf-82c2-4e9c-c510-08d887b27336
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2020 08:59:37.8613
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tg9P569d1lUlvSGiMXU4CxaVt7nt7cnmBe8wWJ4A8eY2Vwy43bLov2kLKNb8/tuyglpW0G04Q5U3Sgc3FRk33JQAmG2C8zhP1kKvyMLONRM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2918
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCreivP7IyzogQW5kcmV3
IE1vcnRvbiA8YWtwbUBsaW51eC1mb3VuZGF0aW9uLm9yZz4Kt6LLzcqxvOQ6IDIwMjDE6jEx1MIx
M8jVIDg6MDEKytW8/sjLOiBaaGFuZywgUWlhbmcKs63LzTogcG1sYWRla0BzdXNlLmNvbTsgdGpA
a2VybmVsLm9yZzsgbGludXgtbW1Aa3ZhY2sub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwu
b3JnCtb3zOI6IFJlOiBbUEFUQ0hdIGt0aHJlYWRfd29ya2VyOiBBZGQgZmx1c2ggZGVsYXllZCB3
b3JrIGZ1bmMKCltQbGVhc2Ugbm90ZSB0aGlzIGUtbWFpbCBpcyBmcm9tIGFuIEVYVEVSTkFMIGUt
bWFpbCBhZGRyZXNzXQoKT24gV2VkLCAxMSBOb3YgMjAyMCAxNzoxMzo1NSArMDgwMCBxaWFuZy56
aGFuZ0B3aW5kcml2ZXIuY29tIHdyb3RlOgoKPiBBZGQgJ2t0aHJlYWRfZmx1c2hfZGVsYXllZF93
b3JrJyBmdW5jLCB0aGUgcHJpbmNpcGxlIG9mCj4gdGhpcyBmdW5jIGlzIHdhaXQgZm9yIGEgZHdv
cmsgdG8gZmluaXNoIGV4ZWN1dGluZyB0aGUKPiBsYXN0IHF1ZXVlaW5nLgo+Cj5XZSdkIGxpa2Ug
dG8gc2VlIHNvbWUgY29kZSB3aGljaCBhY3R1YWxseSB1c2VzIHRoaXMgbmV3IGZ1bmN0aW9uCj5w
bGVhc2UuICBFaXRoZXIgaW4gdGhpcyBwYXRjaCBvciBhcyBvbmUgb3IgbW9yZSBmb2xsb3d1cCBw
YXRjaGVzLgo+Cj5idHcsIHdlIGNhbGwgaXQgImZ1bmN0aW9uIiwgbm90ICJmdW5jIi4gIEJ1dCBu
ZWl0aGVyIGlzIHJlYWxseSBuZWVkZWQgLQo+anVzdCB1c2UgKCkgdG8gaWRlbnRpZnkgYSBmdW5j
dGlvbi4gIGllOgoKPjogQWRkIGt0aHJlYWRfZmx1c2hfZGVsYXllZF93b3JrKCkuICBUaGUgcHJp
bmNpcGxlIG9mIHRoaXMgaXMgdG8gd2FpdCBmb3IKPjogYSBkd29yayB0byBmaW5pc2ggZXhlY3V0
aW5nIHRoZSBsYXN0IHF1ZXVlaW5nLgoKSSBkb24ndCBzZWUgaXQgYmVpbmcgdXNlZCBpbiB0aGUg
a2VybmVsIGNvZGUgc28gZmFyLCBhbmQgSSdtIG5vdCBzdXJlIGlmIGl0J3MgZ29pbmcgdG8gYmUg
dXNlZCBpbiBzdWJzZXF1ZW50IHNjZW5hcmlvcyAoaXQgbGlrZSBmbHVzaF9kZWxheWVkX3dvcmsg
aW4gd29ya3F1ZXVlIClvciB3aGV0aGVyIGl0J3MgY3VycmVudGx5IHVzaW5nICJrdGhyZWFkX3dv
cmsiIHNvbWUgY29kZSBuZWVkcyBpdC4KClRoYW5rcwoKUWlhbmcK

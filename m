Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2590826F8C5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 10:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbgIRI5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 04:57:36 -0400
Received: from mail-vi1eur05on2050.outbound.protection.outlook.com ([40.107.21.50]:39008
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726174AbgIRI5g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 04:57:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qP+PoG66LzGiz7Wl8fS4iASDir9Jj6CgFryZrQ9uIZo=;
 b=2pe7s8DfXx0Koe4h497Stff6DrOHxGXRJoC3/BuHpuwSSrYjR9TVHXPaTA+7GT+O/6n7L5ht7Eu5AeGUu0nqrDJJkplxkwJaIGGBKvINxr4VQ1FTVo8ArOXSbg/GZBQxZF6ukKCkOW3SNetjzH2gVTEktQipnYcjDVtYoBBDx7U=
Received: from AM6PR02CA0029.eurprd02.prod.outlook.com (2603:10a6:20b:6e::42)
 by DB6PR0801MB1973.eurprd08.prod.outlook.com (2603:10a6:4:73::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14; Fri, 18 Sep
 2020 08:57:29 +0000
Received: from VE1EUR03FT030.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:6e:cafe::10) by AM6PR02CA0029.outlook.office365.com
 (2603:10a6:20b:6e::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.13 via Frontend
 Transport; Fri, 18 Sep 2020 08:57:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT030.mail.protection.outlook.com (10.152.18.66) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.15 via Frontend Transport; Fri, 18 Sep 2020 08:57:29 +0000
Received: ("Tessian outbound e8cdb8c6f386:v64"); Fri, 18 Sep 2020 08:57:29 +0000
X-CR-MTA-TID: 64aa7808
Received: from 5594c1cb8f2f.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id D4E109D2-F4DE-4D04-95F2-1BA2CED578A0.1;
        Fri, 18 Sep 2020 08:57:24 +0000
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 5594c1cb8f2f.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 18 Sep 2020 08:57:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=goqWuVq7BRzYvXvw6uEFZn4SwUkgiiFpqjcCwlO4ouK4IbLoFx+9c3TrGPQ3QFqf4MeyX77Y6BX8+wvw+CBJFSUVBOskSJUqMGzIZ+OQ2cMCnGsqWc7hmi56rakHf8YkaERCJaXm3TabwOAbW2yWP6L3YGo3Lh1j4YI2SZbXmwc0zm3YsZsCKw3So1M2hGFohEkPIVe/hK8D5Ao+4RQXIy48qBr36x9urXGgLp1AosxSg1xjyabEaTa8atEA7CO4e5NgTgSw2tFoY86lzOGf456rk3Pe9qAf/wQqcNw4f8qZxRDtXIrzl2VJmOt5+yLx2S8QaLAq0H1EiwgE2uC8kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qP+PoG66LzGiz7Wl8fS4iASDir9Jj6CgFryZrQ9uIZo=;
 b=ofWAQWwzWzLau+rLVAxGQ1faN7jbGHXAUXIyJItXR2JeXesYAoG5jXcNqHl7MwW9WfoRdCWniNQMEJ2IZjLyyLr3oaew1BmuAbIzTpdLInu+W8u9JbmIFxuFV/6dhsqm9FjcVcycbOGQTtxcF0twEAp0obblgCuPfGEB2L3JWu2G61CpQyi7F7xzxrssPnqoK0WUIhzDjARdss/L7ZZSaHRT7gva+HF1M0JuSdl8ka0EOeA4GBfu1Y/QlOToghNNxEvO60nmzki9KjLU/S79VAXgBhYzKPqA5vJrHd7nKUCaSGjbYHy6QZr6bd2zIMMqiHq0EjlnLyMC+iFTtCTMiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qP+PoG66LzGiz7Wl8fS4iASDir9Jj6CgFryZrQ9uIZo=;
 b=2pe7s8DfXx0Koe4h497Stff6DrOHxGXRJoC3/BuHpuwSSrYjR9TVHXPaTA+7GT+O/6n7L5ht7Eu5AeGUu0nqrDJJkplxkwJaIGGBKvINxr4VQ1FTVo8ArOXSbg/GZBQxZF6ukKCkOW3SNetjzH2gVTEktQipnYcjDVtYoBBDx7U=
Received: from HE1PR0802MB2555.eurprd08.prod.outlook.com (2603:10a6:3:e0::7)
 by HE1PR0802MB2443.eurprd08.prod.outlook.com (2603:10a6:3:d7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14; Fri, 18 Sep
 2020 08:57:22 +0000
Received: from HE1PR0802MB2555.eurprd08.prod.outlook.com
 ([fe80::74f7:5759:4e9e:6e00]) by HE1PR0802MB2555.eurprd08.prod.outlook.com
 ([fe80::74f7:5759:4e9e:6e00%5]) with mapi id 15.20.3391.011; Fri, 18 Sep 2020
 08:57:22 +0000
From:   Jianyong Wu <Jianyong.Wu@arm.com>
To:     Dominique Martinet <asmadeus@codewreck.org>
CC:     "ericvh@gmail.com" <ericvh@gmail.com>,
        "lucho@ionkov.net" <lucho@ionkov.net>,
        "v9fs-developer@lists.sourceforge.net" 
        <v9fs-developer@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Justin He <Justin.He@arm.com>, Greg Kurz <groug@kaod.org>
Subject: RE: [PATCH RFC 4/4] 9p: fix race issue in fid contention.
Thread-Topic: [PATCH RFC 4/4] 9p: fix race issue in fid contention.
Thread-Index: AQHWinG9C+xn4SZNHU61ZAxGCD89xKluG5xQ
Date:   Fri, 18 Sep 2020 08:57:22 +0000
Message-ID: <HE1PR0802MB255560720A13BD59C11DEA00F43F0@HE1PR0802MB2555.eurprd08.prod.outlook.com>
References: <HE1PR0802MB255594D67D97733CFDFE777EF4230@HE1PR0802MB2555.eurprd08.prod.outlook.com>
 <HE1PR0802MB25555E7AAFA66DA3FE025D0AF4230@HE1PR0802MB2555.eurprd08.prod.outlook.com>
 <20200914083200.GA9259@nautica>
In-Reply-To: <20200914083200.GA9259@nautica>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: F223318B5B2BC14D81F6CD370B5A6DAD.0
x-checkrecipientchecked: true
Authentication-Results-Original: codewreck.org; dkim=none (message not signed)
 header.d=none;codewreck.org; dmarc=none action=none header.from=arm.com;
x-originating-ip: [203.126.0.113]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c2e53de2-700e-4f86-70ed-08d85bb0df8b
x-ms-traffictypediagnostic: HE1PR0802MB2443:|DB6PR0801MB1973:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0801MB19731B5F08A6837701224F45F43F0@DB6PR0801MB1973.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:10000;OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: ylQ/A7Z9M7yvoInY1m3aA1iV4NhYm6AHURwYccs/GxxxYAkVW/xt+9C//I9osFF7GlJFsEyWSgmMsMim2J4Vqm9GS533VFDr/iO/+vvOhlSrix3aQokhjkhjBtX5eVHT9dUQjDF4Y52DneOM4OmJ0rUT9LT3D5vWD1AGt+iW/UPKFwXUIc6WQMWyQW2AQRFlPoZo5tNjh5g7/DeEqSajRJcLLsjfiax13eh9hOg4552IO6ZoEBB/+XGBQJ+7S2AzbalBtJm0rdQJRwOBbOmlLvziQ4cwhmzGL/MlrAj2zNWj7+tl7YdTKwP8WeUCXoltcsW9aYCg3flZ5a0D5SY2Bw==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0802MB2555.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(396003)(376002)(39860400002)(136003)(54906003)(33656002)(8936002)(26005)(6916009)(478600001)(66476007)(186003)(66446008)(64756008)(66556008)(66946007)(5660300002)(76116006)(52536014)(2906002)(71200400001)(9686003)(4326008)(316002)(55016002)(83380400001)(6506007)(53546011)(7696005)(8676002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: AD0+7muDq6coMkaaDo3I5ZL8tkkuw68elYRR1Jyu5ZctI6PDb3eTWefqQCoSE0Hfl9F7jxHVuTCPABevyoXHrkATo2Q7X9bngVshvupNX0fmgOuYeBAX/y8GWAlhXVIOLIWq9IgUfyXk/UGomm388DJj5F7b/1VIKG92r9i/cYok+QNtN/5FXQsH+Q21EoFK813+vBj1ar2OLQkyh0vDnXj5HryobE+fU3ZdQHPx35visORaBsU6x+CnkmOTYfbQ7QnCwUnEzBwQEV06O1PgVIRrz3djfw26GfRB1qpsS+cSUXQFvtNbcitR3kwS6LXwORqAHPlYpdNuI5aQ55Vl9EmG4L5AV0Bj7fJpCBZsv/trt0MxVzYD97wln3QTETAoQHTgRW5NxBNOZUyf+pgu2pXVh6+Lf3WNlAnsl/bEs6v/tkCxxbGEgyGq11XnaNCzvdEf4rpMB7LOSyH9d6ZToUMlbns6Uga131h/7ra7Qcf12FDfK2n0e0km1EqyU3SU8yWSETX0eYlcK4Vu1zG358hYuFNdHIETMRDX2r1USjp1mJJzjlfV4awM4AUj/BsoK1tZnMVWZDuMkwpyfCqJrlZauRpXwhGfBhMEvHlVnRqZQ/k7GOmIMu67EMFiUdp/EgjAjWliYsSRBD3vu3w9iw==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0802MB2443
Original-Authentication-Results: codewreck.org; dkim=none (message not signed)
 header.d=none;codewreck.org; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT030.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 16052fd1-808d-4531-e7c3-08d85bb0db4e
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HCHT7adnSbELs5UROieb8vrfma4QxAoZnEowZbaMA/ci8MWkIrEieyYssbwKj0CSYSIeK9oJpHv6cbtH4+H1tMTlVGxFaFmvRZkSIQ+z5KHFT5dhrIw2jp+IedHP9fZTs8ZjrFgPdnVo5Ri/3hmE8F4d3/pbCVYLHmZsG0hkdvKxkXpPBRQrN+IzG7zHwkg90Ezcgm//T98p/aY0x1NUnIkqflUHtM/epJOgJnLn9QDLKeZ16AeiH8CODOmK8JYXZnoFnS8dmuUhlFqqigvcDN6oy174QeCsW9dQ3F7kXtYoapHe+o+WM2ihCPsuRGJgxoCo6OMK4WukYdbVojonz8MjNJnwX2h/xBMuzc6upBaNCnTSjyqV0qikVXaENNPVzVguSYE9/ScIDK1jYckROg==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(396003)(376002)(346002)(39860400002)(136003)(46966005)(70586007)(107886003)(70206006)(336012)(6506007)(54906003)(5660300002)(53546011)(2906002)(83380400001)(8936002)(36906005)(52536014)(82310400003)(356005)(7696005)(4326008)(6862004)(186003)(8676002)(81166007)(55016002)(316002)(82740400003)(47076004)(478600001)(26005)(86362001)(33656002)(9686003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2020 08:57:29.4654
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2e53de2-700e-4f86-70ed-08d85bb0df8b
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT030.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1973
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRG9taW5pcXVlLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IERv
bWluaXF1ZSBNYXJ0aW5ldCA8YXNtYWRldXNAY29kZXdyZWNrLm9yZz4NCj4gU2VudDogTW9uZGF5
LCBTZXB0ZW1iZXIgMTQsIDIwMjAgNDozMiBQTQ0KPiBUbzogSmlhbnlvbmcgV3UgPEppYW55b25n
Lld1QGFybS5jb20+DQo+IENjOiBlcmljdmhAZ21haWwuY29tOyBsdWNob0Bpb25rb3YubmV0OyB2
OWZzLQ0KPiBkZXZlbG9wZXJAbGlzdHMuc291cmNlZm9yZ2UubmV0OyBsaW51eC1rZXJuZWxAdmdl
ci5rZXJuZWwub3JnOyBKdXN0aW4gSGUNCj4gPEp1c3Rpbi5IZUBhcm0uY29tPjsgR3JlZyBLdXJ6
IDxncm91Z0BrYW9kLm9yZz4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCBSRkMgNC80XSA5cDogZml4
IHJhY2UgaXNzdWUgaW4gZmlkIGNvbnRlbnRpb24uDQo+DQo+IEppYW55b25nIFd1IHdyb3RlIG9u
IE1vbiwgU2VwIDE0LCAyMDIwOg0KPiA+ID4gTm90IGhhdmluZyBleGNlcHRpb25zIGZvciB0aGF0
IHdpbGwgYWxzbyBtYWtlIHRoZSBjb2RlIGFyb3VuZA0KPiA+ID4gZmlkX2F0b21pY19kZWMgbXVj
aCBzaW1wbGVyOiBqdXN0IGhhdmUgY2x1bmsgZG8gYW4gYXRvbWljIGRlYyBhbmQNCj4gPiA+IG9u
bHkgZG8gdGhlIGFjdHVhbCBjbHVuayBpZiB0aGF0IGhpdCB6ZXJvLCBhbmQgd2Ugc2hvdWxkIGJl
IGFibGUgdG8NCj4gPiA+IGdldCByaWQgb2YgdGhhdCBoZWxwZXI/DQo+ID4NCj4gPiBTb3JyeSwg
SSB0aGluayBhbHdheXMtb25lIHJlZmNvdW50ICB3b24ndCB3b3JrIGF0IHRoaXMgcG9pbnQsIGFz
IHRoZQ0KPiA+IGZpZCB3aWxsIGJlIGNsdW5rZWQgb25seSBieSBmaWxlIGNvbnRleHQgaXRzZWxm
IG5vdCB0aGUgZXZlcnkgY29uc3VtZXINCj4gPiBvZiBldmVyeSBmaWQuIFdlIGNhbid0IGRlY3Jl
YXNlIHRoZSByZWZjb3VudGVyIGF0IGp1c3Qgb25lIHN0YXRpYw0KPiA+IHBvaW50Lg0KPiA+IEFt
IEkgd3Jvbmc/DQo+DQo+IEkgZG9uJ3QgdW5kZXJzdGFuZCB0aGUgIldlIGNhbid0IGRlY3JlYXNl
IHRoZSByZWZjb3VudGVyIGF0IGp1c3Qgb25lIHN0YXRpYw0KPiBwb2ludCIuDQo+IEJhc2ljYWxs
eSBldmVyeXdoZXJlIHlvdSBhZGRlZCBhIGZpZF9hdG9taWNfZGVjKCkgd2lsbCBqdXN0IG5lZWQg
dG8gYmUNCj4gY2hhbmdlZCB0byBjbHVuayAtLSB0aGUgYmFzaWMgcnVsZSBvZiByZWZjb3VudGlu
ZyBpcyB0aGF0IGFueXdoZXJlIHlvdSB0YWtlIGENCj4gcmVmIHlvdSBuZWVkIHRvIHB1dCBpdCBi
YWNrLg0KPg0KPiBBbGwgdGhlc2UgcGxhY2VzIHRha2UgYSBmaWQgdG8gZG8gc29tZSBSUEMgYWxy
ZWFkeSBzbyBpdCdzIG5vdCBhIHByb2JsZW0gdG8gYWRkDQo+IGEgY2x1bmsgYW5kIGRvIG9uZSBt
b3JlOyBlc3BlY2lhbGx5IHNpbmNlIHRoZSAiY2x1bmsiIHdpbGwganVzdCBiZSBqdXN0IGEgZGVy
ZWYuDQo+IEZvciBjb25zaXN0ZW5jeSBJJ2QgYWR2b2NhdGUgZm9yIHRoZSBrcmVmIEFQSSBhcyB3
ZSB1c2UgdGhhdCBmb3IgcmVxdWVzdHMNCj4gYWxyZWFkeTsgaXQgbWlnaHQgYmUgYmV0dGVyIHRv
IHJlbmFtZSB0aGUgY2x1bmsgY2FsbHMgdG8gcDlfZmlkX3B1dCBvcg0KPiBzb21ldGhpbmcgYnV0
IEkgdGhpbmsgdGhhdCdzIG1vcmUgY2h1cm4gdGhhbiBpdCdzIHdvcnRoLi4uLg0KPg0KSWYgd2Ug
bW92ZSB0aGUgY291bnRlciBkZWNyZWFzZSBjb2RlIGludG8gcDlfY2xpZW50X2NsdW5rIGFuZCBw
dXQgaXQgaW5zdGVhZCBvZiBmaWRfYXRvbWljX2RlYywgd2UgbmVlZCBkZWxldGUgZmlkIG9mZiB0
aGUgaW5vZGUgd2hlcmUgaXQgc3RvcmVzIGluIHA5X2NsaWVudF9jbHVuay4NCkJ1dCB0aGVyZSBp
cyBubyB3YXkgY2FuIHdlIGFjcXVpcmUgdGhlIGlub2RlIGluIHA5X2NsaWVudF9jbHVuay4gRG8g
eW91IGhhdmUgYW55IGlkZWE/IEkgdGhpbmsgaW50cm9kdWNlIGFub3RoZXIgcGFyYW1ldGVyIGZv
ciBwOV9jbGllbnRfY2x1bmsNCklzIG5vdCBncmFjZWZ1bC4NCg0KVGhhbmtzDQpKaWFueW9uZyBX
dQ0KSU1QT1JUQU5UIE5PVElDRTogVGhlIGNvbnRlbnRzIG9mIHRoaXMgZW1haWwgYW5kIGFueSBh
dHRhY2htZW50cyBhcmUgY29uZmlkZW50aWFsIGFuZCBtYXkgYWxzbyBiZSBwcml2aWxlZ2VkLiBJ
ZiB5b3UgYXJlIG5vdCB0aGUgaW50ZW5kZWQgcmVjaXBpZW50LCBwbGVhc2Ugbm90aWZ5IHRoZSBz
ZW5kZXIgaW1tZWRpYXRlbHkgYW5kIGRvIG5vdCBkaXNjbG9zZSB0aGUgY29udGVudHMgdG8gYW55
IG90aGVyIHBlcnNvbiwgdXNlIGl0IGZvciBhbnkgcHVycG9zZSwgb3Igc3RvcmUgb3IgY29weSB0
aGUgaW5mb3JtYXRpb24gaW4gYW55IG1lZGl1bS4gVGhhbmsgeW91Lg0K

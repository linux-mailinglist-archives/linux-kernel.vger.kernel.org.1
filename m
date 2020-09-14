Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D77D4268B24
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 14:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbgINMis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 08:38:48 -0400
Received: from mail-am6eur05on2083.outbound.protection.outlook.com ([40.107.22.83]:52353
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726532AbgINMeu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 08:34:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q/QDiPqVLskhn0M3P1iXRnXZo+0i3kTRmqGAIlQowCI=;
 b=0kPj0UlJ4esp8RlIoptMGgC/9X6u9YrZCo7aNVFHvNMvZsY1lVwzPXsZn2mqlB98EHhd97s3SUoxi56HMMSKTWd5w3E+suUpRiSEjIFaawq+k8TJdehLCz/zU4NpYj58Aekr8IG/Wlf65EKzqzWUc9UJljbBugtKav/I/2mfPAw=
Received: from AM6PR10CA0083.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:209:8c::24)
 by AM6PR08MB4705.eurprd08.prod.outlook.com (2603:10a6:20b:cf::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Mon, 14 Sep
 2020 12:34:22 +0000
Received: from VE1EUR03FT019.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:209:8c:cafe::46) by AM6PR10CA0083.outlook.office365.com
 (2603:10a6:209:8c::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend
 Transport; Mon, 14 Sep 2020 12:34:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT019.mail.protection.outlook.com (10.152.18.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3370.16 via Frontend Transport; Mon, 14 Sep 2020 12:34:22 +0000
Received: ("Tessian outbound 195a290eb161:v64"); Mon, 14 Sep 2020 12:34:21 +0000
X-CR-MTA-TID: 64aa7808
Received: from a87934b0cf29.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id DF2797A0-17FA-477D-BA39-AA3C5950B1BD.1;
        Mon, 14 Sep 2020 12:34:16 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id a87934b0cf29.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 14 Sep 2020 12:34:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MXSE6vx2wYTFejcTFeuzk/PG4B2lfXS43xBasUdAAPSfEw5aKDhC0n4L5wNXFh91QcqxA6OLrgdaEsbuvmUfJdRCAhVbHncfplwAFd8MAkjMz6LNcfIf6sFdFVHPZ+4GsIj3jQtnvCFPeIaU6pGQkXOcgpexOaD3GYyajTlYrdRRf+jwAazzoyWpmuWozoI/T/OSkj5bzVItQUkUYlJzXbOhdfYyVHh0SUhWi/crS9cbVtHJUwzF9p32lT44lRU95AoeUC9PuMmdpSz0uSyznjv0I1hE6m0RKGLN4Fc0G0EBcW0ccSKRFXMd8oioDDWUSFF+tDi81HeZL3PkBqTdfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q/QDiPqVLskhn0M3P1iXRnXZo+0i3kTRmqGAIlQowCI=;
 b=CgjDX3fSS6SV2vvOLHXqiEGqL7nm/9iuyRSuS5QQDr0hQxmraguvlq7+Gy9D7OUrXDIsmEsnx+o6MYILfbQzHt/BcT9/S1JtCFhpwSCEEmat58Z9DLDv4BzaA3B4itgTJD7H6NEe5f2Xqwf9W5HnfWjozIoBpyS5h2UK8niUkNM7X1ANklGOZJ5UNTkXaS/U/ov7bqpdH1yIh8rUzd2CPK3egxfKftgSkraEHipheA0qUxVDHjKq3Nwa7y5rQF6Edx9ROGFEg8LmYwZdTiXo6zcQGcgnHGeJnsI5+Pm7eKelzfAxMqbDLxEgtHyqUHrbpCgvuYfZs+yRBH/rqI6lSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q/QDiPqVLskhn0M3P1iXRnXZo+0i3kTRmqGAIlQowCI=;
 b=0kPj0UlJ4esp8RlIoptMGgC/9X6u9YrZCo7aNVFHvNMvZsY1lVwzPXsZn2mqlB98EHhd97s3SUoxi56HMMSKTWd5w3E+suUpRiSEjIFaawq+k8TJdehLCz/zU4NpYj58Aekr8IG/Wlf65EKzqzWUc9UJljbBugtKav/I/2mfPAw=
Received: from HE1PR0802MB2555.eurprd08.prod.outlook.com (2603:10a6:3:e0::7)
 by HE1PR0801MB1977.eurprd08.prod.outlook.com (2603:10a6:3:4d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Mon, 14 Sep
 2020 12:34:15 +0000
Received: from HE1PR0802MB2555.eurprd08.prod.outlook.com
 ([fe80::74f7:5759:4e9e:6e00]) by HE1PR0802MB2555.eurprd08.prod.outlook.com
 ([fe80::74f7:5759:4e9e:6e00%5]) with mapi id 15.20.3370.019; Mon, 14 Sep 2020
 12:34:15 +0000
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
Thread-Index: AQHWinG9C+xn4SZNHU61ZAxGCD89xKloDjvw
Date:   Mon, 14 Sep 2020 12:34:15 +0000
Message-ID: <HE1PR0802MB2555512C87C5D662DCEEBDD1F4230@HE1PR0802MB2555.eurprd08.prod.outlook.com>
References: <HE1PR0802MB255594D67D97733CFDFE777EF4230@HE1PR0802MB2555.eurprd08.prod.outlook.com>
 <HE1PR0802MB25555E7AAFA66DA3FE025D0AF4230@HE1PR0802MB2555.eurprd08.prod.outlook.com>
 <20200914083200.GA9259@nautica>
In-Reply-To: <20200914083200.GA9259@nautica>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: D87666DDAB57AA46A5FAB1855FE59006.0
x-checkrecipientchecked: true
Authentication-Results-Original: codewreck.org; dkim=none (message not signed)
 header.d=none;codewreck.org; dmarc=none action=none header.from=arm.com;
x-originating-ip: [203.126.0.111]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 86ac55fa-d567-45f4-a44a-08d858aa821c
x-ms-traffictypediagnostic: HE1PR0801MB1977:|AM6PR08MB4705:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB47058B14D5879D8DD3CA567FF4230@AM6PR08MB4705.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:10000;OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: UuFYhS6Iej87x2ULBQOSLswCFBjSV0zHhtAlKo7zqhZVHzuR6bPa5ziwJSloHpwcGBGe0v36uvZQ9xL7hbnw4WiqxCSgiSOvF5t0PQOiWP3OuUy0vecMWj7n5OCGg1GlFft8oq65R61oS5YzgdM1Lc9QHWHdzPLnzPWiuMIvUBLfWKUPfx5L0DAVZzvOKLEugkZ9cwm8acVF6538bKYg2mC9hQCSvSkIut90CrRZuj6/lhp/EoyGOVnIxFFBx1NyzyQ0orNHZo2cXO762I8sgcOl4LDy9d8ihCUuORyqef7B7yPCdvt6D33PBPybrMbXPy2P5QOuR4bXDVwxlMl1Jg==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0802MB2555.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(366004)(396003)(376002)(136003)(5660300002)(55016002)(186003)(52536014)(66946007)(66556008)(26005)(64756008)(66476007)(66446008)(76116006)(478600001)(7696005)(6916009)(54906003)(6506007)(53546011)(4326008)(8676002)(8936002)(2906002)(33656002)(71200400001)(83380400001)(86362001)(316002)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: jA5b5PW+tdplcyPxlBi2tF7LeVaEkrxyzrrCNesNwxZKG8EK+A2wM2fhOmnT2qV6OWXBoFaEuqf+jsoiDQO8xod1PpsigUTg6QwRBH7wyfxGbQxJzG4PSXJjssJ6FNy0hceWjn3RZBJCfWehxr2NIy9xvki7yRH+6lZSJ+C4GU+T75bsLodHAEhl0+16Gs9Pg0KR4GqE2r4MKiU3OOMxLdg3d11NPWE6fgfLrzfIUGrzNHzHEgPiQt8Uf4SHl5ZKRdRhe3ee354TrikiaB2tZ4n6qqt4u+LEqrG8TqKlVdJ7uWjo+EBYMHKeBDRkN2nirBe0xL85q1+TIBgFz7ErccVsu3weP00yX7aTJPRrbQFP0DF9z4OsLgTQosHukuq2jRRUYMoVhzvgj6wds5y+pUvY5/RT3ZwmICZgmkRYqPAVVdiNCeITujMOxUtWj3eThr0ITfvJJ/iQc7KMmLPvWCg8uh8kHKeore9A2iwyi3L8I8UPvjcS/L4GUFd/tiq+bivotYsHYHwBGpx7c5uJVibZ4SYDGFJOsjn53xPC5cKFq0tYEOfdO+5wv8YnTSPmC7S63nb8aStYdk2YhkpaXFZtFtY+xFBlOwKk9MRg5ml8Eb3nzZIFdPhX/7eNn+N8WZfnZ9LGV3YEXFsqvf6RNw==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1977
Original-Authentication-Results: codewreck.org; dkim=none (message not signed)
 header.d=none;codewreck.org; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT019.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 473ecd10-b86c-4966-4660-08d858aa7dea
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8/CFUu3q8QW8POrzMcZXj+heepFwx40TOaczq0NB9GdJx07Gc6Slh05Y5A6cVh86v9qAHyd6rTrJcreccoU32UmNqqHEy2Qi8rZJRVAyA4IonPUsMQQe4K63jOGwqgh3+spmGFX1heXc5tTlOaGKh2k873SscBfUHI2BW5xWUM48tiPxb6hhsco9pzam8KYgSntXSdqnr1InzvV4PE/Jxkvkec/oXlp5arkOGduB0bOJtDXPIfKs1QSqXLNbW7abzuuJuYaQzZpsyA+/Wfaj9N+3sx+W0xC6s0F8mBYMM+MnNTBoNdabY/v2RONHlY6Is70hn9RCOyGvA1/6A49nrEz+gXbahgOhwBbM7iU78ZLlYdpEECbRN8qxCxM7CzT2O42aCRLHYhaBhuATaRiHPg==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(39860400002)(346002)(396003)(136003)(376002)(46966005)(52536014)(70586007)(6506007)(53546011)(26005)(478600001)(336012)(7696005)(186003)(9686003)(4326008)(55016002)(36906005)(8676002)(316002)(107886003)(2906002)(6862004)(8936002)(86362001)(70206006)(54906003)(83380400001)(47076004)(81166007)(82310400003)(82740400003)(33656002)(5660300002)(356005);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2020 12:34:22.2415
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86ac55fa-d567-45f4-a44a-08d858aa821c
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT019.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4705
Sender: linux-kernel-owner@vger.kernel.org
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
YWNrLg0KPg0KT2gsIG1heWJlIEkganVzdCBtaXNzIHlvdXIgcG9pbnQuIEl0IGlzIG9rIHRvICBw
dXQgdGhlIGZpZF9hdG9taWNfZGVjKCkgaW50byBwOV9jbGllbnRfY2x1bmsoKSBhbmQNCkxldCB0
aGUgY2x1bmsgcmVwbGFjZSB0aGUgcmVmY291bnQgZGVjLg0KDQo+IEFsbCB0aGVzZSBwbGFjZXMg
dGFrZSBhIGZpZCB0byBkbyBzb21lIFJQQyBhbHJlYWR5IHNvIGl0J3Mgbm90IGEgcHJvYmxlbSB0
byBhZGQNCj4gYSBjbHVuayBhbmQgZG8gb25lIG1vcmU7IGVzcGVjaWFsbHkgc2luY2UgdGhlICJj
bHVuayIgd2lsbCBqdXN0IGJlIGp1c3QgYSBkZXJlZi4NCj4gRm9yIGNvbnNpc3RlbmN5IEknZCBh
ZHZvY2F0ZSBmb3IgdGhlIGtyZWYgQVBJIGFzIHdlIHVzZSB0aGF0IGZvciByZXF1ZXN0cw0KPiBh
bHJlYWR5OyBpdCBtaWdodCBiZSBiZXR0ZXIgdG8gcmVuYW1lIHRoZSBjbHVuayBjYWxscyB0byBw
OV9maWRfcHV0IG9yDQo+IHNvbWV0aGluZyBidXQgSSB0aGluayB0aGF0J3MgbW9yZSBjaHVybiB0
aGFuIGl0J3Mgd29ydGguLi4uDQo+DQpPaywgSSBzZWUuDQo+DQo+IElzIHRoZXJlIGFueXdoZXJl
IHlvdSB0aGluayBjYW5ub3QgZG8gdGhhdD8NCj4NCk5vLg0KPiA+IFRoaXMgZW51bSB2YWx1ZSBp
cyBub3QgZnVuY3Rpb25hbGx5IG5lY2Vzc2FyeSwgYnV0IEkgdGhpbmsgaXQgY2FuDQo+ID4gcmVk
dWNlIHRoZSBjb250ZW50aW9uIG9mIGZpZCwgYXMgdGhlcmUgYXJlIHJlYWxseSBsb3RzIG9mIHNj
ZW5hcmlvcw0KPiA+IHRoYXQgZmlkIGZyb20gaW5vZGUgaXMgbm90IG5lY2Vzc2FyeS4NCj4NCj4g
SSByZWFsbHkgZG9uJ3QgdGhpbmsgaXQgbWFrZXMgdGhpbmdzIHNsb3dlciBpZiBkb25lIGNvcnJl
Y3RseSAoZS5nLiBubyB3YWl0aW5nIGFzDQo+IGN1cnJlbnRseSBkb25lIGJ1dCB0aGUgbGFzdCBk
ZXJlZiBkb2VzIHRoZSBhY3R1YWwgY2x1bmspLCBhbmQgd291bGQgcmF0aGVyDQo+IGtlZXAgY29k
ZSBzaW1wbGVyIHVubGVzcyB0aGUgZGlmZmVyZW5jZSBpcyBiaWcgKHNvIHdvdWxkIG5lZWQgdG8g
ZG8gYW4gYWN0dWFsDQo+IGJlbmNobWFyayBvZiBib3RoIGlmIHlvdSdyZSBjb252aW5jZWQgaXQg
aGVscHMpIC0tIHNvcnJ5Lg0KPg0KT2ssIGZhaXIgZW5vdWdoLg0KDQo+ID4+IElmIHBvc3NpYmxl
IHB1dCB0aGUgcGF0Y2ggZmlyc3QgaW4gdGhlIHNlcmllcyBzbyBjb21taXRzIGNhbiBiZQ0KPiA+
PiB0ZXN0ZWQgaW5kZXBlbmRlbnRseS4NCj4gPg0KPiA+IEFoLCB0aGlzIHBhdGNoIGRlcGVuZHMg
b24gdGhlIHByZXZpb3VzIHBhdGNoZXMsIGhvdyBjYW4gSSBwdXQgaXQgYXMNCj4gPiB0aGUgZmly
c3Qgb2YgdGhlIHNlcmllcz8NCj4NCj4gQmFzaWNhbGx5IGJ1aWxkIHRoZSBsb2dpYyBpbiB0aGUg
Zmlyc3QgcGF0Y2gsIHRoZW4gZWl0aGVyIGFwcGx5IHRoZSBvdGhlciB0aHJlZSBhcw0KPiBjbG9z
ZSBhcyB0aGV5IGN1cnJlbnRseSBhcmUgYXMgcG9zc2libGUgYW5kIGFkZCB0aGUgbWlzc2luZyBy
ZWZjYWxscyBpbiBhIG5ldw0KPiBwYXRjaCBvciBpbmNvcnBvcmF0ZSB0aGUgcmVmY291bnRpbmcg
aW4gdGhlbSBhcyB3ZWxsLg0KPiBJdCdzIGZpbmUgaWYgeW91IGtlZXAgaXQgaXQgbGFzdCwgdGhh
dCB3YXMganVzdCBhIGdyZWVkeSByZXF1ZXN0IG9uIG15IHBhcnQgdG8gYmUNCj4gYWJsZSB0byB0
ZXN0IGFzeW5jIGNsdW5rIG1vcmUgZWFzaWx5IDsgZm9yZ2V0IGFib3V0IGl0Lg0KDQpPaywga2Vl
cCB0aGlzIGluIG9yaWdpbmFsIHN0YXRlIGlzIGVhc3kgZm9yIG1lLg0KDQpUaGFua3MNCkppYW55
b25nDQo+DQo+IC0tDQo+IERvbWluaXF1ZQ0KSU1QT1JUQU5UIE5PVElDRTogVGhlIGNvbnRlbnRz
IG9mIHRoaXMgZW1haWwgYW5kIGFueSBhdHRhY2htZW50cyBhcmUgY29uZmlkZW50aWFsIGFuZCBt
YXkgYWxzbyBiZSBwcml2aWxlZ2VkLiBJZiB5b3UgYXJlIG5vdCB0aGUgaW50ZW5kZWQgcmVjaXBp
ZW50LCBwbGVhc2Ugbm90aWZ5IHRoZSBzZW5kZXIgaW1tZWRpYXRlbHkgYW5kIGRvIG5vdCBkaXNj
bG9zZSB0aGUgY29udGVudHMgdG8gYW55IG90aGVyIHBlcnNvbiwgdXNlIGl0IGZvciBhbnkgcHVy
cG9zZSwgb3Igc3RvcmUgb3IgY29weSB0aGUgaW5mb3JtYXRpb24gaW4gYW55IG1lZGl1bS4gVGhh
bmsgeW91Lg0K

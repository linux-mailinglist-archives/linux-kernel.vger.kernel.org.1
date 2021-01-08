Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 669C02EF1B6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 13:00:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbhAHL7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 06:59:47 -0500
Received: from mail-eopbgr760105.outbound.protection.outlook.com ([40.107.76.105]:29238
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725791AbhAHL7q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 06:59:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ti2GM6vaooXLu+pTf25/5n5ZJOxCJRnFeQ1gquEM6dVCrG90pBdNf3rp/uqbhdgJOBbHDdv/2Obd1ZcE5lht9JcXVLXEXFDd0VMoiTDdqQAtlP+/WG73Y0nWPHmKlv4Lsp7/2SVYHP0Pkr0Ts1mzyEyL5JgDY32Y14/bW5YOI16IF9aGra3kU8Y0muI/n7bWUhndV+/Fqm9/6iiLweUGUd99QCxp32glbCXpklF8FdLKVfNpvse1bW35Jx1gGmPPq1nXZASY2LyDyYsEYXmO2OJxgYSL38hktoltiYUW+Vs6VwyXW7OZgzzGc6P7Fny5zSGKY3pp+v1xVOo8WZ0REg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qBNz3RX153y95EpXqPj7nfxa9ELZ3AyYwuC02FkGcRc=;
 b=hriShjjYGcgywY8tdAQtA9L8k/EyN1jk8p1F7ADXedHSsnvW2J63QIMp3mqxrKn6yHQgzOaqMxCfWJFsTXeqrkPTMrYabDh5MGXdj+r7zDj2zwRqsP6DZdHQHGIPV8bIoy5PBgy3yofq1Nw4TgkOP9BfmRGz0xii7FMYqDJcRbnd2V6hP9yOW/RUiyn2R45k44la9bGn0wjd/6M2MsqsaygFWmAbuGYOJ1FDCe2oySsNmtxt0DNHKy5Fl5N0ds0hvUO96FhaNfb4h9z4BDfRP2g/Zt2Mi/oDaLOFHvdtB9wCsJBPKiwjSKarc0QP473msuGzEwpLvPvjl6LiWz0FBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qBNz3RX153y95EpXqPj7nfxa9ELZ3AyYwuC02FkGcRc=;
 b=EdqbJnTVNUXWn4yPbWKU20H4CNdZQ2wV0NRAy7wYB0AeB2QsTUWTWiAopk4n90T+6iYU2skUZpTlBQ4OUdh4n0uGj0zCGMOxYs326XSsdIVoFCAzLwRdU34fh1B+RDR6/+GFkzDb7dES2pE29B05uEstP+MgYcJ2aohLKEWkwkM=
Received: from CH2PR13MB3525.namprd13.prod.outlook.com (2603:10b6:610:21::29)
 by CH2PR13MB3479.namprd13.prod.outlook.com (2603:10b6:610:2a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.5; Fri, 8 Jan
 2021 11:58:57 +0000
Received: from CH2PR13MB3525.namprd13.prod.outlook.com
 ([fe80::f9a6:6c23:4015:b7fc]) by CH2PR13MB3525.namprd13.prod.outlook.com
 ([fe80::f9a6:6c23:4015:b7fc%6]) with mapi id 15.20.3763.004; Fri, 8 Jan 2021
 11:58:57 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "kurt@garloff.de" <kurt@garloff.de>,
        "NeilB@suse.de" <NeilB@suse.de>,
        "Anna.Schumaker@Netapp.com" <Anna.Schumaker@Netapp.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: NFS 4.2 client support broken on 5.10.5
Thread-Topic: NFS 4.2 client support broken on 5.10.5
Thread-Index: AQHW5bMpS0fYxbhnbEqIMGUjjRkIfKodn96A
Date:   Fri, 8 Jan 2021 11:58:57 +0000
Message-ID: <2f401e0a738b7acb926bd2375012e6384a2cd9b6.camel@hammerspace.com>
References: <ee320885-9a78-80b8-9341-7c631df60d3a@garloff.de>
In-Reply-To: <ee320885-9a78-80b8-9341-7c631df60d3a@garloff.de>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: garloff.de; dkim=none (message not signed)
 header.d=none;garloff.de; dmarc=none action=none header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e853809a-3e53-4817-7f8e-08d8b3ccc7a2
x-ms-traffictypediagnostic: CH2PR13MB3479:
x-microsoft-antispam-prvs: <CH2PR13MB347999F025C35BE2AB809589B8AE0@CH2PR13MB3479.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aAt2vHkZ9Ap59ZWgu5R0Jeq6KMzNdIPF4wNUG4Pi6zUkLTvko8gRFKDSLBCWuA51L+Ylxl4cnlKpXCuPd2XfSTvSwW02atqtWiHm3vI3fxYPBCYb1qFu2jQLdN/WBiaa/fn7CGRPhIkOvWUDfIbHtUNPEk4kFDwQ/RlNr/5uYibLzQ8vwfhVX/dbNF/9iDpzsVdKsnnylmxnSAb8OeprvuEZzdnar9Da70lYsLR6tcbIH3dvGINLcMx4MODq6TWDR2yzcjRgGMuvS7+q7E+WD60NkHjE8qG+UgAzBhWvnxES/MHTG/m0aspFwPlDGrXakbY+PdP/6RkxrW6ZEUCqpGv9qmCabcnAnslI89WCNQSvlTIv4a3yfRfin6oVFaqM2pmbyOk5EmC0m+Me2sJT+Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB3525.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(39840400004)(376002)(366004)(346002)(66946007)(66476007)(110136005)(64756008)(5660300002)(66556008)(66446008)(36756003)(76116006)(83380400001)(316002)(8676002)(186003)(26005)(6486002)(2906002)(71200400001)(86362001)(8936002)(6512007)(478600001)(2616005)(4326008)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?YkpmREZQd2xUSzNjbFZvcjdHNEd1TUhoWnV6OFRtZzVVUDJEazh6bFdOakVy?=
 =?utf-8?B?VkhVRWUzeHRreGUwQ2FpeDgzeG05ZElEazNKQm5objJYc0RZWmJoY0NYTXlu?=
 =?utf-8?B?Ynh3eVFOOGFVZ1FuT3Nmcks4NmpFUGxJN1ZIS0tyY3cySWJobEgzYXZRWU9u?=
 =?utf-8?B?emV2eDlFajBoSWNUQU9rQW5aSE1MUU9NQ1dKclJRdjVCaXV4c3Y0SnBvWnBB?=
 =?utf-8?B?ZE1DNzJXVllzdjZEd1NtVkRSTEtkR3pYMmhBVE9ud3Q0dXVGU0JjV0JYa3RS?=
 =?utf-8?B?b3R5RFVicWlmRGJyamVWcHRTTCtMV0lPSlB4cDl6eWE0Mk4vSEhFSFE3RDZV?=
 =?utf-8?B?WTAvVVJpYmhpNlNCczA1OFdKQkhhYS9TamY1ZExac3RMWVFOVUdJOE1keTlt?=
 =?utf-8?B?dnVLTDVxNDRIM3AzcVhLVHZWZWVEWGExRENwd2dWc3hsOXVCZTJvck9odXBQ?=
 =?utf-8?B?bjBvR0c3NVJ5TG1WK2NpYW1JSXlSamhrbXYzVXlDMlhSWXNmaWVpT0hUY0Y0?=
 =?utf-8?B?cUs1U0JBMmhncnczakd6V0R3NGo0eFJwVFVZQzNxLzRaWDlxWllSeE4wYVRs?=
 =?utf-8?B?enVxYTY5Ynp0Q0s3TTU2NzNReGdnL3RNRmc5dHJoaUtJSGt3WSthSE9BRGts?=
 =?utf-8?B?OXZxSHZHVlo3dkI0dXFjSk12NzdxOWx3Mld1UkR2K1c5S3ZoQ1RGRkRSWk5q?=
 =?utf-8?B?cGZqQm55NHEzMXVpbkV2ZGsvWU9pMWJYNThHUFFzWVRyT0ZyRU9CZ1RhL05r?=
 =?utf-8?B?RGJuUUplOHVlRzl6WEN5OVBoVEw2R0p6UTJNRG5pQ1RvVFIrOVBoUXZpdmkz?=
 =?utf-8?B?MlljWkJtdjZMdUtXUFlMZ0wyYXNiOWRMRER1UXE1bnIzN0Jrc2RHRERzbHhG?=
 =?utf-8?B?NERKME4yd0ZLcnFrL1hmQUIvRitiWlljZk5mYXZGOVErVXNKbHQ5UGEvWmpV?=
 =?utf-8?B?S1psUWw0ZnlJYXdwOUErVkZScWh5b0xMMXduZkZxckJka3pYbzBOV05vaVdx?=
 =?utf-8?B?K1NGbldlQVgvd084OTNQbDZ6NDg5R0JRRVlxSmw4SjZtbnpQcE9MSlhiN240?=
 =?utf-8?B?WE1yUUY3dmxDMmUxbXJ2cFV4NW95OW9mcy9KWHNnWWtDSG9pYlE2UmtIQ1Zj?=
 =?utf-8?B?ZHZXM3FIcnJLZjFtd0x0bWZiODNQN1grMWJQRWdyTjN1ODRDT1Y3SGZqZGFP?=
 =?utf-8?B?L2NlUy95RExoV0VQdEwrYTVkREZ5TUUxbVpnekFqUmNoV0JCSUVzWVgvMEF4?=
 =?utf-8?B?ajlkeVF4RCs2ejRFMVFRcUhQQ0ZXOTdzaGNHSWxSMGJ1aFlVT0lvZHYyNWJM?=
 =?utf-8?Q?FbGApAoYjD5JV5LL3EJSixmLO5Yf1L57ZC?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <9AC8EAF27667A04ABF7DCE35D7230527@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR13MB3525.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e853809a-3e53-4817-7f8e-08d8b3ccc7a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2021 11:58:57.6561
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4Jd9IEdXjYsDD+pA0myc6S+Ktx8jxWKdLP38mTsuQyFTrhmvWkfPDNZ5aSzLv4hPw7EMPyGnj6SyOaxgz1h9nA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3479
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIxLTAxLTA4IGF0IDEyOjQxICswMTAwLCBLdXJ0IEdhcmxvZmYgd3JvdGU6DQo+
IEhpIE5laWwsIEFubmEsIFRyb25kLA0KPiANCj4gY29tcGlsaW5nIGEga2VybmVsLCBJIHN1ZGRl
bmx5IHN0YXJ0ZWQgZ2V0dGluZyBlcnJvcnMgZnJvbSBvYmp0b29sDQo+IG9yYy4NCj4gKFRoaXMg
Zmlyc3Qgb2NjdXJzIG9uIGluaXQvbWFpbi5vLikNCj4gDQo+IEkgbG9va2VkIGF0IGFsbCBraW5k
IG9mIHRoaW5ncywgYmVmb3JlIEkgbm90aWNlZCB0aGF0IHRoaXMgd2FzIG5vdCBhDQo+IHRvb2xj
aGFpbiBpc3N1ZSAoZ2NjLTEwLjIuMSBzZWxmIGNvbXBpbGVkKSwgZ2NjIHBsdWdpbnMgKEkgdXNl
DQo+IHN0cnVjdGxlYWsgYW5kIHN0YWNrbGVhaykgbm9yIGFuIGlzc3VlIHdpdGggb2JqdG9vbCBv
ciBsaWJlbGYsDQo+IGJ1dCB0aGF0IHRoZXJlIHdhcyBhbiAtRUlPIGVycm9yLg0KPiANCj4gVGhl
IGtlcm5lbCB0cmVlIGlzIG9uIGFuIE5GUyBzaGFyZSwgYW5kIEkgcnVuIDUuMTAuNSBjbGllbnQg
a2VybmVsDQo+IGFnYWluc3QgdGhlIGtlcm5lbCBORlMgKDQuMikgc2VydmVyLCBydW5uaW5nIGEg
NS4xMC4zIGtlcm5lbC4NCj4gDQo+IFRoZSBpc3N1ZSBkb2VzIE5PVCBvY2N1ciBvbiBhIDUuMTAu
MyBjbGllbnQga2VybmVsLCBidXQgaXMgZWFzaWx5DQo+IHJlcHJvZHVjaWJsZSBvbiA1LjEwLjUu
IE5vdGUgdGhhdCA1LjEwLjUgb24gYSBsb2NhbCBmaWxlIHN5c3RlbSBvcg0KPiBhZ2FpbnN0IGFu
IE5GU3YzIHNlcnZlciBkb2VzIG5vdCBzaG93IHRoZSBpc3N1ZS4NCj4gDQo+IFRlc3QgcHJvZ3Jh
bSB0aGF0IHJlcHJvZHVjZXMgdGhpcyBvbiB0aGUgZmlyc3QgcHdyaXRlNjQoKSBpcw0KPiBhdHRh
Y2hlZC4NCj4gTm90ZSB0aGF0IHRoZSBjYWxsIHRvIGZ0cnVuY2F0ZSgpIGlzIHJlcXVpcmVkIHRv
IG1ha2UgdGhlIHByb2JsZW0NCj4gaGFwcGVuLg0KPiANCj4gSSBjb3VsZCBnbyBvbiBiaXNlY3Rp
bmcgdGhpcyB0byBhIHBhcnRpY3VsYXIgcGF0Y2gsIGJ1dCB5b3UnbGwNCj4gcHJvYmFibHkgYmUg
YWJsZSB0byBzZWUgcmlnaHQgYXdheSB3aGF0J3Mgd3JvbmcuDQo+IA0KPiBCZXN0LA0KPiANCg0K
SG1tLi4uIElmIHRoaXMgaXMgTkZTdjQuMiBkbyB5b3UgaGF2ZSBSRUFEX1BMVVMgdHVybmVkIG9u
IG9yIG9mZiBpbg0KLmNvbmZpZz8gSXQgcmVhbGx5IGlzIG5vdCBzYWZlIHRvIGVuYWJsZSBSRUFE
X1BMVVMgb24gNS4xMCBrZXJuZWxzDQpzaW5jZSB0aGF0IGNhbiBjYXVzZSByYW5kb20gbWVtb3J5
IGNvcnJ1cHRpb24uDQoNCi0tIA0KVHJvbmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1h
aW50YWluZXIsIEhhbW1lcnNwYWNlDQp0cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoN
Cg0K

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB5672EB4D5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 22:25:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731423AbhAEVXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 16:23:47 -0500
Received: from mail-bn7nam10on2069.outbound.protection.outlook.com ([40.107.92.69]:42760
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725817AbhAEVXq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 16:23:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aqHdZ1tdEv2F3l+lc1+4m+UWMRUo1cKKuSr2wWACdaW9US5Ij7+nGfmo/pajbpTlExerBZn9tDhMincwSLnP34DtbLxHKquMFdi2EkCiTOL/9wJ1LUxNm/m+3CdDTMsK1L0L3m6jMVb+aNpUvSYx+k9be9+LFnprTDr1AhoJHX/PPgr3p8x6/41bxg50c+wBMrmr4SAlt/ZmFhCNSa9OTZ9/VUcdgqk2z0HeB40W2fcTQd/8TzfhRoU9rFLzVQ1IMf3QugeuBMYSDMkZQ04ghl4h6k5s+fS680aFhSzJFqjGQGHfn5wAvVG8JS5Jlz4VJBeWs6UUT8UNR7YzzODyTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QexlCHaPZwIZZzzHk38AfEL6664KPkkoO1HJZlTKNBw=;
 b=EleDQT5K6tj7bW6FpZd8xLZLQCcGkWf/DswoPypJzWcG/xgdsQudES8GWpJ26BjwFOGW7FWWX7a6SNQzX8ij9VQKc4JiNfwGjOEzfrbFN2SrL4aNakLau6nx9Bf9g6koD9SfG0WLmjdEq7DwoO2fIoZkQUTiRPoeLUjmMtatAsfY65VNw8NC9D07Tx475of58DYrdmEX+GmkmiGOZRgtcLTt1U8dQj7NDiaQZgnLyIvcqUVc1kHGNzRhYvYcV23UuQJ/OEAMyAl71z3gbSPyZShYR1uAQz0k5NIsZO8aFqfsjlvVw4PdRsnbpGsn78Jdj1PPVTeIuAZ4+ESRFFQsSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QexlCHaPZwIZZzzHk38AfEL6664KPkkoO1HJZlTKNBw=;
 b=KiRg694MxDTC4IIGCF/zq0fx9W+PRO03FX164PbOCsgRYSpL2gndtp5hH6FlhwAaXXAP2jnhtpmOX/GjBbnAdigc2Rf5K6e7BbjPItAGhPdVTdZePBcnEu4bVhoUk10EDZDUumPcWfha2RNxGJ/lX+l+WTjLHPzP9E2gMeirP2U=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (2603:10b6:a03:4a::18)
 by BYAPR05MB4967.namprd05.prod.outlook.com (2603:10b6:a03:9e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.4; Tue, 5 Jan
 2021 21:22:51 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::d421:f99:8921:1ee7]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::d421:f99:8921:1ee7%6]) with mapi id 15.20.3742.006; Tue, 5 Jan 2021
 21:22:51 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Andrea Arcangeli <aarcange@redhat.com>
CC:     linux-mm <linux-mm@kvack.org>, lkml <linux-kernel@vger.kernel.org>,
        Yu Zhao <yuzhao@google.com>, Andy Lutomirski <luto@kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Pavel Emelyanov <xemul@openvz.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Minchan Kim <minchan@kernel.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH v2 2/2] fs/task_mmu: acquire mmap_lock for write on
 soft-dirty cleanup
Thread-Topic: [RFC PATCH v2 2/2] fs/task_mmu: acquire mmap_lock for write on
 soft-dirty cleanup
Thread-Index: AQHW44+JbpROBSsHEESP2++n26KnoaoZakUAgAAUXYCAAAwWAA==
Date:   Tue, 5 Jan 2021 21:22:51 +0000
Message-ID: <B1B85771-B211-4FCC-AEEF-BDFD37332C25@vmware.com>
References: <20201225092529.3228466-1-namit@vmware.com>
 <20201225092529.3228466-3-namit@vmware.com> <X/SuBxFfR+bncRhU@redhat.com>
 <15758743-B8E3-48C4-A13B-DFFEBF8AF435@vmware.com>
 <X/TOhyzggcBL64N2@redhat.com>
In-Reply-To: <X/TOhyzggcBL64N2@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=vmware.com;
x-originating-ip: [24.6.216.183]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b93d98e5-0de5-48d1-67fe-08d8b1c00edc
x-ms-traffictypediagnostic: BYAPR05MB4967:
x-microsoft-antispam-prvs: <BYAPR05MB49674F0B2BA62198C86DA8B2D0D10@BYAPR05MB4967.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gyLkvYHWtQrqlkhB5pFK+iS8UncJIvoMGWe9J7iNN0htu+auWLOo62o8E8vtFP+LG4AsPwomjSRue42q0ppRDwwf6O3Fq+DDFMbGTnnVqYcKWfNbsrQ9797h7AFjZ/W13sXQd8J8POdQytqKYKrIbOS9ZQiyZHBKMSVC0nQGz9capPquWes0x0cb1M3wTYrv4KAz0vdoFLRw7t0p+gY406VSE4BjhPW1+p4INQhYVpxtruEcCyGhmx+T4eXu5G67mG8zZS5ZpXTIKmn0REcBgZ3JBU6SpMFlrWGI7gdq2hyjXn+o7HWLC4U8WO0p7S7djC+xMIU80o/kOnG1Ux8r9nDGtSX+sKH/ZlPH5JHqJV8V9o9X0r+cfIjvn0NOAQkhosTzcgTEbaxtpXZz5m2iQNYeZWFmCAWLnWHe8IwdLamsV21EhmlBfNBiq/PeU497L7chgH45GD4drPs7yg82hCOclADIKM7pKWMRmhXy7OFm9SOszJfMc3dB+YA0YRv3TJbmeFl7Auqbpv0L9HWSDbYX60Hzzk3h0DvSsPPFVkA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR05MB4776.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(136003)(39860400002)(366004)(376002)(86362001)(71200400001)(2906002)(36756003)(6512007)(54906003)(5660300002)(6486002)(2616005)(7416002)(6506007)(316002)(53546011)(186003)(76116006)(966005)(8676002)(33656002)(64756008)(66946007)(66476007)(83380400001)(4326008)(6916009)(478600001)(8936002)(26005)(66446008)(66556008)(14143004)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?bGpoalFKbk1CNTQ1TGZqdGgzd1p4YVQySXBhWUVKOHluN01GWHlkVlFGekN4?=
 =?utf-8?B?K3czQUpMTVdWL2s5K05RMEEyMmVkTGJVSHAxZVFsZSsrRS9Fa2lPK1dqTkdq?=
 =?utf-8?B?cnFvSno0d2NxUmRiaFlTM2RjNUE0czZOQlJzRVlackgveGEzc0FmQy9MeFMx?=
 =?utf-8?B?L2libFRwS0RwaGJTRXNqWXFDb2lxY1hsZGpzaGNoSTlVVEVCTEFnclZYMFdt?=
 =?utf-8?B?am4vQnh2ZHV1L2xNa1c2T0JTN0RaTm1nTUhwMFFPQ2hGaWtPZGxscWRBYlVV?=
 =?utf-8?B?TFJMS3BPc2lCa0NEMG16WWJVelRnNHhLeWNtUHJ5QmFZUGd3VEliWXNiQVVz?=
 =?utf-8?B?VnNpRjIxRnJTTGhWUlZWNDZ0K21kYURQUXRwL1hiUjd3Y3B4OW9EM3BsTVFC?=
 =?utf-8?B?dnA4VTVkK1RETkZMWVhGMDVaSTIvT1FkYlpEY0NiK01Ma0hGN1p3RFJ6dzhS?=
 =?utf-8?B?aU5ZUmV5LytaS3hGVkVoSGQ1WFAyYW8rYjF3WEwrckFaZkI2MzJFeTJKSWFQ?=
 =?utf-8?B?d2lBaEcvd3RDc2l6TXN4T0hwQkpxU1BCR2dzUG9pZWlzNTdEUmkrUk5GUmpL?=
 =?utf-8?B?SWZuMTlnTkxRNG1OVXNUSHlnOVIveC9tamdXVDRBeC9RdFRoRFljVUFHeTNs?=
 =?utf-8?B?TS95djdrTG5Qc0loRktKa1d0L0JXbzFpdHExdlJlNE9Xa3d1eSs3bklleG9h?=
 =?utf-8?B?Nkk5V01COVZIdGpOMGtqUGpXL3h0WWZXNWx2c0twQXBuQUY4UUVkRFp2eUZx?=
 =?utf-8?B?MGdYVEtRNWdzVlRZVitPM0NUd0pDYytnek5SWGxUQ0ZXdFR3R242TTFXMnRY?=
 =?utf-8?B?Rm04aksweWNlT2l3dUVuVmk1cG5Wakp3bHRQdHBpV3d1NDJqZzNwU3EyV1JH?=
 =?utf-8?B?TmRueFJRc0R2TzE4SFhuQkFTMW5SR2JwdG1jV1FiMitFYU9KWlNDZUV2V0N4?=
 =?utf-8?B?b3RUdDQzMFAySDIwKzRST3ZNbDBubWxqcG5YZlhYak9EUEtkb3NGNncxNVFJ?=
 =?utf-8?B?cFdHTEJSRVAxK3Q2bDlwZEJwWkhDVWhIdnpvd3FiNDg4clFYZHhQNXpnbkdO?=
 =?utf-8?B?RmI0dUlNNTFYc1p2S3JaRnFPaktXOSt5d0tLRVFwWUl1Rm1QS0dFZVoyd0Er?=
 =?utf-8?B?bGRvYlBGQVhjbTVvNWxGNGd3Si9hL3QxKy9pOWszZVpiSERQeVBETjQ1Y3V1?=
 =?utf-8?B?VkZKY0hNMWhyNnNZaTAvRmNEb0RmdEZ3Snh1QzhHL3RuSExMazBRSjhrR0Jl?=
 =?utf-8?B?K0VhbGRSbTA5Q0l3NjlsNExzdEx6UldzUkcwUmRGQmtieTZrOFJycmdIWGls?=
 =?utf-8?Q?vcUXSiI/+Du0075x5waFp6qof+a9fJd4Eg?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <82556BF0410EBE48BB1B01D4E8AB1F9A@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR05MB4776.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b93d98e5-0de5-48d1-67fe-08d8b1c00edc
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2021 21:22:51.2818
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 03nnPdDGJdYDuhLu4tiCbgWlrBe7O4syzAh2z5WNqoLdIQNzekKWcLleDLhFp3bp5c2462n2/gaoGKYGw30LAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4967
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBKYW4gNSwgMjAyMSwgYXQgMTI6MzkgUE0sIEFuZHJlYSBBcmNhbmdlbGkgPGFhcmNhbmdl
QHJlZGhhdC5jb20+IHdyb3RlOg0KPiANCj4gT24gVHVlLCBKYW4gMDUsIDIwMjEgYXQgMDc6MjY6
NDNQTSArMDAwMCwgTmFkYXYgQW1pdCB3cm90ZToNCj4+PiBPbiBKYW4gNSwgMjAyMSwgYXQgMTA6
MjAgQU0sIEFuZHJlYSBBcmNhbmdlbGkgPGFhcmNhbmdlQHJlZGhhdC5jb20+IHdyb3RlOg0KPj4+
IA0KPj4+IE9uIEZyaSwgRGVjIDI1LCAyMDIwIGF0IDAxOjI1OjI5QU0gLTA4MDAsIE5hZGF2IEFt
aXQgd3JvdGU6DQo+Pj4+IEZpeGVzOiAwZjg5NzVlYzRkYjIgKCJtbTogc29mdC1kaXJ0eSBiaXRz
IGZvciB1c2VyIG1lbW9yeSBjaGFuZ2VzIHRyYWNraW5nIikNCj4+PiANCj4+PiBUYXJnZXRpbmcg
YSBiYWNrcG9ydCBkb3duIHRvIDIwMTMgd2hlbiBub3RoaW5nIGNvdWxkIHdyb25nIGluIHByYWN0
aWNlDQo+Pj4gd2l0aCBwYWdlX21hcGNvdW50IHNvdW5kcyBiYWNrd2FyZHMgYW5kIHVubmVjZXNz
YXJpbHkgcmlza3kuDQo+Pj4gDQo+Pj4gSW4gdGhlb3J5IGl0IHdhcyBhbHJlYWR5IGJyb2tlbiBh
bmQgaW4gdGhlb3J5DQo+Pj4gMDk4NTRiYTk0YzZhYWQ3ODg2OTk2YmZiZWUyNTMwYjNkOGE3ZjRm
NCBpcyBhYnNvbHV0ZWx5IHBlcmZlY3QgYW5kIHRoZQ0KPj4+IHByZXZpb3VzIGNvZGUgb2YgMjAx
MyBpcyBjb21wbGV0ZWx5IHdyb25nLCBidXQgaW4gcHJhY3RpY2UgdGhlIGNvZGUNCj4+PiBmcm9t
IDIwMTMgd29ya2VkIHBlcmZlY3RseSB1bnRpbCBBdWcgMjEgMjAyMC4NCj4+IA0KPj4gV2VsbOKA
piBJZiB5b3UgY29uc2lkZXIgdGhlIGJ1ZyB0aGF0IFdpbGwgcmVjZW50bHkgZml4ZWQgWzFdLCB0
aGVuIHNvZnQtZGlydHkNCj4+IHdhcyBicm9rZW4gKGZvciBhIGRpZmZlcmVudCwgeWV0IHJlbGF0
ZWQgcmVhc29uKSBzaW5jZSAwNzU4Y2Q4MzA0OTQNCj4+ICgiYXNtLWdlbmVyaWMvdGxiOiBhdm9p
ZCBwb3RlbnRpYWwgZG91YmxlIGZsdXNo4oCdKS4NCj4+IA0KPj4gVGhpcyBpcyBub3QgdG8gc2F5
IHRoYXQgSSBhcmd1ZSB0aGF0IHRoZSBwYXRjaCBzaG91bGQgYmUgYmFja3BvcnRlZCB0byAyMDEz
LA0KPj4ganVzdCB0byBzYXkgdGhhdCBtZW1vcnkgY29ycnVwdGlvbiBidWdzIGNhbiBiZSB1bm5v
dGljZWQuDQo+PiANCj4+IFsxXSBodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3Qv
bGludXgtbW0vcGF0Y2gvMjAyMDEyMTAxMjExMTAuMTAwOTQtMi13aWxsQGtlcm5lbC5vcmcvDQo+
IA0KPiBJcyB0aGlzIGEgZml4IG9yIGEgY2xlYW51cD8NCj4gDQo+IFRoZSBhYm92ZSBpcyBwcmVj
aXNlbHkgd2hhdCBJIHNhaWQgZWFybGllciB0aGF0IHRsYl9nYXRoZXIgaGFkIG5vDQo+IHJlYXNv
biB0byBzdGF5IGluIGNsZWFyX3JlZnMgYW5kIGl0IGhhZCB0byB1c2UgaW5jX3RsYl9mbHVzaF9w
ZW5kaW5nDQo+IGFzIG1wcm90ZWN0LCBidXQgaXQncyBub3QgYSBmaXg/IElzIGl0PyBJIHN1Z2dl
c3RlZCBpdCBhcyBhIHB1cmUNCj4gY2xlYW51cC4gU28gYWdhaW4gbm8gYmFja3BvcnQgcmVxdWly
ZWQuIFRoZSBjb21taXQgc2F5cyBmaXggdGhpcyBidXQNCj4gaXQgbWVhbnMgImNsZWFuIHRoaXMg
dXAiLg0KDQpJdCBpcyBhY3R1YWxseSBhIGZpeC4gSSB0aGluayB0aGUgY29tbWl0IGxvZyBpcyBu
b3QgZW50aXJlbHkgY29ycmVjdCBhbmQNCnNob3VsZCBpbmNsdWRlOg0KDQogIEZpeGVzOiAwNzU4
Y2Q4MzA0OTQgKCJhc20tZ2VuZXJpYy90bGI6IGF2b2lkIHBvdGVudGlhbCBkb3VibGUgZmx1c2ji
gJ0pLg0KDQpTaW5jZSAwNzU4Y2Q4MzA0OTQsIGNhbGxpbmcgdGxiX2ZpbmlzaF9tbXUoKSB3aXRo
b3V0IGFueSBwcmV2aW91cyBjYWxsIHRvDQpwdGVfZnJlZV90bGIoKSBhbmQgZnJpZW5kcyBkb2Vz
IG5vdCBmbHVzaCB0aGUgVExCLiBUaGUgc29mdC1kaXJ0eSBidWcNCnByb2R1Y2VyIHRoYXQgSSBz
ZW50IGZhaWxzIHdpdGhvdXQgdGhpcyBwYXRjaCBvZiBXaWxsLg0KDQo+IFNvIHNldHRpbmcgYSBG
aXhlcyBiYWNrIHRvIDIwMTMgdGhhdCB3b3VsZCBnbyBtZXNzIHdpdGggYWxsIHN0YWJsZQ0KPiB0
cmVlIGJ5IGFjdGl2ZWx5IGJhY2twb3J0aW5nIGEgcGVyZm9ybWFuY2UgcmVncmVzc2lvbnMgdG8g
Y2xlYXJfcmVmcw0KPiB0aGF0IGNhbiBicmVhayBydW50aW1lIHBlcmZvcm1hbmNlIHRvIGZpeCBh
IHBoaWxvc29waGljYWwgaXNzdWUgdGhhdA0KPiBpc24ndCBldmVuIGEgdGhlb3JldGljYWwgaXNz
dWUsIGRvZXNuJ3Qgc291bmQgaWRlYWwgdG8gbWUuDQoNClBvaW50IHRha2VuLg0KDQo+IA0KPj4g
VG8gc3VtbWFyaXplIG15IGFjdGlvbiBpdGVtcyBiYXNlZCB5b3VyIChhbmQgb3RoZXJzKSBmZWVk
YmFjayBvbiBib3RoDQo+PiBwYXRjaGVzOg0KPj4gDQo+PiAxLiBJIHdpbGwgYnJlYWsgdGhlIGZp
cnN0IHBhdGNoIGludG8gdHdvIGRpZmZlcmVudCBwYXRjaGVzLCBvbmUgd2l0aCB0aGUNCj4+IOKA
nG9wdGltaXphdGlvbuKAnSBmb3Igd3JpdGUtdW5wcm90ZWN0LCBiYXNlZCBvbiB5b3VyIGZlZWRi
YWNrLiBJdCB3aWxsIG5vdA0KPj4gYmUgYmFja3BvcnRlZC4NCj4+IA0KPj4gMi4gSSB3aWxsIHRy
eSB0byBhZGQgYSBwYXRjaCB0byBhdm9pZCBUTEIgZmx1c2hlcyBvbg0KPj4gdXNlcmZhdWx0ZmQt
d3JpdGV1bnByb3RlY3QuIEl0IHdpbGwgYWxzbyBub3QgYmUgYmFja3BvcnRlZC4NCj4gDQo+IEkg
dGhpbmsgMSBhbmQgMiBhYm92ZSBjb3VsZCBiZSBpbiB0aGUgc2FtZSBwYXRjaC4gTWl4aW5nIGFu
IHVmZmQtd3Agb3B0aW1pemF0aW9uIHdpdGggdGhlDQo+IGFjdHVhbCBmaXggdGhlIG1lbW9yeSBj
b3JydXB0aW9uIHdhc24ndCBpZGVhbCwgYnV0IGRvaW5nIHRoZSBzYW1lDQo+IG9wdGltaXphdGlv
biB0byBib3RoIHdycHJvdGVjdCBhbmQgdW4td3Jwcm90ZWN0IGluIHRoZSBzYW1lIHBhdGNoDQo+
IHNvdW5kcyBpZGVhbC4gVGhlIGNvbW1pdCBleHBsYW5hdGlvbiB3b3VsZCBiZSBpZGVudGljYWwg
YW5kIGl0IGNhbiBiZQ0KPiBkZS1kdXBsaWNhdGVkIHRoaXMgd2F5Lg0KPiANCj4gSSdkIHN1Z2dl
c3QgdG8gY29vcmRpbmF0ZSB3aXRoIFBldGVyIG9uIHRoYXQsIHNpbmNlIEkgd2Fzbid0IHBsYW5u
aW5nDQo+IHRvIHdvcmsgb24gdGhpcyBpZiBzb21lYm9keSBlbHNlIG9mZmVyZWQgdG8gZG8gaXQu
DQo+IA0KPj4gMy4gTGV0IG1lIGtub3cgaWYgeW91IHdhbnQgbWUgdG8gdXNlIHlvdXIgdmVyc2lv
biBvZiB0ZXN0aW5nDQo+PiBtbV90bGJfZmx1c2hfcGVuZGluZygpIGFuZCBjb25kaXRpb25hbGx5
IGZsdXNoaW5nLCB3YWl0IGZvciBuZXcgdmVyc2lvbiBmcm8NCj4+IHlvdSBvciBQZXRlciBvciB0
byBnbyB3aXRoIHRha2luZyBtbWFwX2xvY2sgZm9yIHdyaXRlLg0KPiANCj4gWWVzLCBhcyB5b3Ug
c3VnZ2VzdGVkLCBJJ20gdHJ5aW5nIHRvIGNsZWFuIGl0IHVwIGFuZCBzZW5kIGEgbmV3DQo+IHZl
cnNpb24uDQo+IA0KPiBVbHRpbWF0ZWx5IG15IHZpZXcgaXMgdGhlcmUgYXJlIGFuIGh1Z2UgbnVt
YmVyIG9mIGNhc2VzIHdoZXJlDQo+IG1tYXBfd3JpdGVfbG9jayBvciBzb21lIG90aGVyIGhlYXZ5
IGxvY2sgdGhhdCB3aWxsIHJlcXVpcmUNCj4gb2NjYXNpb25hbGx5IHRvIGJsb2NrIG9uIEkvTyBp
cyBiZXlvbmQgaW1wb3NzaWJsZSBub3QgdG8gdGFrZS4gRXZlbg0KPiBzcGVjdWxhdGl2ZSBwYWdl
IGZhdWx0cyBvbmx5IGF0dGFjayB0aGUgbG93IGhhbmdpbmcgYW5vbiBtZW1vcnkgYW5kDQo+IHRo
ZXJlJ3Mgc3RpbGwgTUFEVl9ET05UTkVFRC9GUkVFIGFuZCBvdGhlciBzdHVmZiB0aGF0IG1heSBo
YXZlIHRvIHJ1bg0KPiBpbiBwYXJhbGxlbCB3aXRoIFVGRkRJT19XUklURVBST1RFQ1QgYW5kIGNs
ZWFyX3JlZnMsIG5vdCBqdXN0IHBhZ2UNCj4gZmF1bHRzLg0KPiANCj4gQXMgYSByZW1pbmRlcjog
dGhlIG9ubHkgY2FzZSB3aGVuIG1vZGlmeWluZyB0aGUgdm1hcyBpcyBhbGxvd2VkIHVuZGVyDQo+
IG1tYXBfcmVhZF9sb2NrIChJIGFscmVhZHkgdHJpZWQgb25jZSB0byBtYWtlIGl0IHNhZmVyIGJ5
IGFkZGluZw0KPiBSRUFEX09OQ0UvV1JJVEVfT05DRSBidXQgd2Fzbid0IG1lcmdlZCBzZWUNCj4g
aHR0cHM6Ly93d3cuc3Bpbmljcy5uZXQvbGlzdHMvbGludXgtbW0vbXNnMTczNDIwLmh0bWwpLCBp
cyB3aGVuDQo+IHVwZGF0aW5nIHZtX2VuZC92bV9zdGFydCBpbiBncm93c2Rvd24vdXAsIHdoZXJl
IHRoZSB2bWEgaXMgZXh0ZW5kZWQNCj4gZG93biBvciB1cCBpbiB0aGUgcGFnZSBmYXVsdCB1bmRl
ciBvbmx5IG1tYXBfcmVhZF9sb2NrLg0KPiANCj4gSSdtIGRvaW5nIGFsbCBJIGNhbiB0byBkb2N1
bWVudCBhbmQgbWFrZSBpdCBtb3JlIGV4cGxpY2l0IHRoZQ0KPiBjb21wbGV4aXR5IHdlIGRlYWwg
d2l0aCBpbiB0aGUgY29kZSAoYXMgd2VsbCBhcyByZWR1Y2luZyB0aGUgZ2NjDQo+IGRlcGVuZGVu
Y3kgaW4gZW1pdHRpbmcgYXRvbWljIHdyaXRlcyB0byB1cGRhdGUgdm1fZW5kL3ZtX3N0YXJ0LCBh
cyB3ZQ0KPiBzaG91bGQgZG8gaW4gcHRlcyBhcyB3ZWxsIGluIHRoZW9yeSkuIEFzIHlvdSBtYXkg
bm90aWNlIGluIHRoZQ0KPiBmZWVkYmFjayBmcm9tIHRoZSBhYm92ZSBzdWJtaXNzaW9uIG5vdCBh
bGwgZXZlbiByZWFsaXplZCB0aGF0IHdlJ3JlDQo+IG1vZGlmeWluZyB2bWFzIGFscmVhZHkgdW5k
ZXIgbW1hcF9yZWFkX2xvY2suIFNvIGl0J2QgYmUgZ3JlYXQgdG8gZ2V0DQo+IGhlbHAgdG8gbWVy
Z2UgdGhhdCBSRUFEX09OQ0UvV1JJVEVfT05DRSBjbGVhbnVwIHRoYXQgaXMgc3RpbGwgdmFsaWQN
Cj4gYW5kIHBlbmRpbmcgZm9yIG1lcmdlIGJ1dCBpdCBuZWVkcyBmb3J3YXJkIHBvcnRpbmcuDQo+
IA0KPiBUaGlzIG9uZSwgZm9yIGJvdGggc29mdCBkaXJ0eSBhbmQgdWZmZF93cnByb3RlY3QsIGlz
IGEgd2FsayBpbiB0aGUNCj4gcGFyayB0byBvcHRpbWl6ZSBpbiBjb21wYXJpc29uIHRvIHRoZSB2
bWEgbW9kaWZpY2F0aW9ucy4NCg0KSSBhbSBzdXJlIHlvdSBhcmUgcmlnaHQuDQoNCj4gDQo+IEZy
b20gbXkgcG9pbnQgb2YgdmlldyBpbiBmYWN0LCBkb2luZyB0aGUgdGxiIGZsdXNoIG9yIHRoZSB3
YWl0IG9uIHRoZQ0KPiBhdG9taWMgdG8gYmUgcmVsZWFzZWQsIGRvZXMgbm90IGluY3JlYXNlIGtl
cm5lbCBjb21wbGV4aXR5IGNvbXBhcmVkIHRvDQo+IHdoYXQgd2UgaGFkIHVudGlsIG5vdy4NCg0K
SXQgaXMgYWxzbyBhYm91dCBwZXJmb3JtYW5jZSBkdWUgdG8gdW53YXJyYW50ZWQgVExCIGZsdXNo
ZXMuDQoNCkkgdGhpbmsgYXZvaWRpbmcgdGhlbSByZXF1aXJlcyBzb21lIGZpbmVyIGdyYW51bGFy
aXR5IGRldGVjdGlvbiBvZiBwZW5kaW5nDQpwYWdlLWZhdWx0cy4gQnV0IGFueWhvdywgSSBzdGls
bCBvd2Ugc29tZSBUTEIgb3B0aW1pemF0aW9uIHBhdGNoZXMgKGFuZCB2Mg0KZm9yIHVzZXJmYXVs
dGZkK2lvdXJpbmcpIGJlZm9yZSBJIGNhbiBldmVuIGxvb2sgYXQgdGhhdC4NCg0KSW4gYWRkaXRp
b24sIGFzIEkgc3RhdGVkIGJlZm9yZSwgaGF2aW5nIHNvbWUgY2xlYW4gaW50ZXJmYWNlcyB0aGF0
IHRlbGwNCndoZXRoZXIgYSBUTEIgZmx1c2ggaXMgbmVlZGVkIG9yIG5vdCB3b3VsZCBiZSBoZWxw
ZnVsIGFuZCBzaW1wbGVyIHRvIGZvbGxvdy4NCkZvciBpbnN0YW5jZSwgd2UgY2FuIGhhdmUgaXNf
cHRlX3Byb3RfZGVtb3Rpb24ob2xkcHJvdCwgbmV3cHJvdCkgdG8gZmlndXJlDQpvdXQgd2hldGhl
ciBhIFRMQiBmbHVzaCBpcyBuZWVkZWQgaW4gY2hhbmdlX3B0ZV9yYW5nZSgpIGFuZCBhdm9pZA0K
dW5uZWNlc3NhcnkgZmx1c2hlcyB3aGVuIHVucHJvdGVjdGluZyBwYWdlcyB3aXRoIGVpdGhlciBt
cHJvdGVjdCgpIG9yDQp1c2VyZmF1bHRmZC4NCg0K

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30F632EB377
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 20:27:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730842AbhAET1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 14:27:34 -0500
Received: from mail-eopbgr750073.outbound.protection.outlook.com ([40.107.75.73]:47750
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728174AbhAET1d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 14:27:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oaMgsyki136WVngHLecjY2WMWOC3I5gu7jdPPO2uRmJ6Xf0ocjkHK8GfNX2+lmBY6u4mt/Y6CdyJ8S+gw7adfdl4TLY7f78eqjKh+1jgUbg3stDNNsZs1SZIa1jPDZchweAGSpjNXqUNZjbU75L0S/EjCtrDVG3CJ6tK0uHZlGLVaSaBegfBJJZv4V5DMXBKMd/w7+UqZ2/HLCrT5qWsB2se2U31SaH3VXlAMljqtZ/yNg4tnDW6OD0q6g2hWSgvyFrcP6ouWByCccqzIihhAtHECMdWgQt+HBln6CXZoUyVlIuem3W9tKEKUnJ4OPtOvkVo9fQM/3gOJiqBmHHwnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=24hp1W9nA59Aw66gv2n9wrnA7XLMnTeJrXbOh5CFTPM=;
 b=HgfgOyshzEXnZUmsvXeFHawFxUqKyi7kvXZtPNES5t6l521wFONd9wBBkGRKhqxDXOFz4fLgzzTsXLOUak4Cla+vSJQauhVns+BoNSX8nSrsx6FOlOhegodfmYh0HmI0UY57NeRGWx67bajHgc4YaRZ8Cc1XiBw+7igxhWuTaU9ZNH7Zxq2lWko9+pBjCfV3vZeBYaXqdWl7U//k35BAZhB3fPXbJw9qYg50EN5wnio3ABPAF+yuNHsI7EF6fHXXOB8KAVLqtwnSjFtsT/VpgGQlcENEdqjWfM9XpRV7yUfmSv2odanvilgHnqgUa6NRI5A2/xHZ7qJraCQO2ZqGpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=24hp1W9nA59Aw66gv2n9wrnA7XLMnTeJrXbOh5CFTPM=;
 b=QPyYnZH+F2jCLZXd7AN1oGufW8joQx6r3K3sjLd4A4ATZXQ9H1LufPOSN0t50LSo0qZnA5eYHrTsH3tYp4C6F8lx8D/tzBj95930/btcac6MjSr6Ph7oyB6PeDh07wx1StBQUeUrX2RoPJ3c+Hp0+yQu2usMvtPhPx1wvBjuuSY=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (2603:10b6:a03:4a::18)
 by BY5PR05MB6883.namprd05.prod.outlook.com (2603:10b6:a03:1c9::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.2; Tue, 5 Jan
 2021 19:26:43 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::d421:f99:8921:1ee7]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::d421:f99:8921:1ee7%6]) with mapi id 15.20.3742.006; Tue, 5 Jan 2021
 19:26:43 +0000
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
Thread-Index: AQHW44+JbpROBSsHEESP2++n26KnoaoZakUA
Date:   Tue, 5 Jan 2021 19:26:43 +0000
Message-ID: <15758743-B8E3-48C4-A13B-DFFEBF8AF435@vmware.com>
References: <20201225092529.3228466-1-namit@vmware.com>
 <20201225092529.3228466-3-namit@vmware.com> <X/SuBxFfR+bncRhU@redhat.com>
In-Reply-To: <X/SuBxFfR+bncRhU@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=vmware.com;
x-originating-ip: [24.6.216.183]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2f1437d9-5f82-4c82-b335-08d8b1afd578
x-ms-traffictypediagnostic: BY5PR05MB6883:
x-microsoft-antispam-prvs: <BY5PR05MB6883F08B8D3B2BA815B6198AD0D10@BY5PR05MB6883.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aw9PQralW8co/zoL589nurIn3X0EirJPNI6kZO0pkYgxihuFeHbcW83EnKSo7KOsLMibOclpFhJkIfEkPvZSKIpb6ciOPIIqxcjTcqNkjaJOC2VY7CYxTJF/uXO4ZJkrV4q5cetMmCeT5tDvuy6KLcKRgIDVQMD7oabCDBKrP/pAUBB2j4dbxwmgmj41pN13Gsdi+ig1nepI30A/4sxn51a5bSI41ZMmytXui3dyrM/ixIuhoWp+8rcBWm2QGgoMBgskS8juxMGP9Oc1cCvaIVClTeEeHzOJbYCQ+kIohg6yAqcEomwG+QJg+r3dK290wXwJ5jMkQO2L0eKY9bg66/mP97QsvMDO4aTRbhNRyI4/mcKkJJdBMEdsekkz8cmxk6s90WyG1tpVK4Eqwk1iyoIu/1rGoAMlGsXWUkJ7NZBr5m010DWFuIHMcidX4wDIsx2umFUU1L+FK8AH3E+X4c9Te2UHfQqY5zEHuQqLFIhMlnEQ5YC9ZM5U/ZGPY2N0S32/nbaZWA63y4fuceJqArVXt5C4ruVGnzDzOGJ8Uzo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR05MB4776.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(376002)(346002)(396003)(136003)(6916009)(6506007)(8936002)(86362001)(478600001)(316002)(36756003)(33656002)(53546011)(83380400001)(966005)(2616005)(7416002)(2906002)(66946007)(64756008)(54906003)(4326008)(66446008)(66556008)(6512007)(76116006)(5660300002)(71200400001)(26005)(8676002)(6486002)(186003)(66476007)(14143004)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?RFlEQUh2TktPKzRGKzcwL09MNmNYRFErUENhNTNEQkx5UGlncDV1czhwemda?=
 =?utf-8?B?RFVvdDU4QVV5bUcvSEI2bm92cHNrWktlSFF1RjBwSitTSlpkU01YLzIybThn?=
 =?utf-8?B?V3NMQkN2aEFvTXdueWdrQWhVWEx6MW52cklhbm14bllhK216N1pxTFFyRG41?=
 =?utf-8?B?MGM1RTdiTUdKUktpTS9jTFE4NGgycU5iL1RwaXRTa3VDWmF1bDQzK0FNWEVv?=
 =?utf-8?B?WTZnUllkSElnNW4zbEVGSkw3ZUp2bTBSa0ZNd1JqWWxwODV0ZDJKaFVTTHky?=
 =?utf-8?B?dTJjQjRZYllheERHSEo0N1M2WlBHall2RVpsM2JRM0dVaklHZ0NjcG45Und0?=
 =?utf-8?B?WTlBbVBHdnJCM05YaWZ6RkQxRnRWOGVpVVE2YzBmRlFDUVNsdmNrRWRMbTdu?=
 =?utf-8?B?WlNidGVsMXhtYlJyUE5uV1o0Wm9GV0hOYUxOMDlLY1ZrbmNSWjJORFBrOVBU?=
 =?utf-8?B?eWZYdVVBRkNUVTR1L2xlM0xHY0JhM1A3TUJteExhNlA4YmQvRUdlOGJJYkN4?=
 =?utf-8?B?eGRHU0tnMUw1Y2ZvYk5oZm9DanpMRFovaHRqR1l6akRPODFucER1cWQxcGhD?=
 =?utf-8?B?WHZ4SFlER0pEdXVrcjJNVTV2MERBTTl0NEd0ckxaSm9Lbkp3bUM3SFVnb09r?=
 =?utf-8?B?clJteVI5QTFaUWhPeHpTL3lGdFZpaEhwK1crM0RMV3MrQnhIWGtQWDdjaXVz?=
 =?utf-8?B?c3RxeE16RzFFdm5FYTVyVFJWWlRoZFdZVUYxbWtMRVlUU1RkSnRFTkYwekY1?=
 =?utf-8?B?U2tiUk1JQStEYWJNRjVlb1RiaEF2cFVlczBaWGQwY1BEckR0N09DL1gvdHFW?=
 =?utf-8?B?Ry9ldExCaWJMRE1UUEJUSmh6ajlldG14emtWQU5UQ2pZcVpuUnJQTnVCNW5M?=
 =?utf-8?B?dVBzaUp0MjU0R29oOGZDaWw1K2lvamVKVDV0NFY1US9KL1l4bktGM1VLeVJP?=
 =?utf-8?B?OXpYZEVwRjR4SC9WaHdUVEM4YzV0WERtSnMyZCt0YTQzc2dnV1pseGFiUm5v?=
 =?utf-8?B?d2FVZFcrTU5iMlpMWjA4cnU5U1NvQmlIQm5iVU5qcmJPQVk0WDZjaFZOSzYv?=
 =?utf-8?B?OG92OE5XZVpvRlpneGdKdW5lR1p4eTFuaEFib0tjSEZ4dG51eENscGNsZzFH?=
 =?utf-8?B?N3FCVlFQbFVLd2pNM2l6akF4eDFnVWkwUTl1alRoZ0lNOGRJTUN5czNybFZX?=
 =?utf-8?B?QzhzcUFySncvQ2xiNHJwTmRQTWNwbWpKSUJ2eWkwRVppbzZUUkNGREoxQW95?=
 =?utf-8?B?MDdBdUgzUFc3WUZENUJYWGd4ZGxPMm5rYzFwZlJoVDVPNUlQWnJ1d05FRm04?=
 =?utf-8?Q?QP6gxVtsO3y/PGG8OmNRiyWO2XcKFlqSIl?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <CF68F4E66FA9194ABF686A83378B3712@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR05MB4776.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f1437d9-5f82-4c82-b335-08d8b1afd578
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2021 19:26:43.0856
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ol+btOwbNokLWr3qF7Mlj843WE8nCFN6fH8QEoLsX8ufFPeYNFKayi4QwECXnouHlbCdbQXNpCNh+XgnYOrReA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR05MB6883
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBKYW4gNSwgMjAyMSwgYXQgMTA6MjAgQU0sIEFuZHJlYSBBcmNhbmdlbGkgPGFhcmNhbmdl
QHJlZGhhdC5jb20+IHdyb3RlOg0KPiANCj4gT24gRnJpLCBEZWMgMjUsIDIwMjAgYXQgMDE6MjU6
MjlBTSAtMDgwMCwgTmFkYXYgQW1pdCB3cm90ZToNCj4+IEZpeGVzOiAwZjg5NzVlYzRkYjIgKCJt
bTogc29mdC1kaXJ0eSBiaXRzIGZvciB1c2VyIG1lbW9yeSBjaGFuZ2VzIHRyYWNraW5nIikNCj4g
DQo+IFRhcmdldGluZyBhIGJhY2twb3J0IGRvd24gdG8gMjAxMyB3aGVuIG5vdGhpbmcgY291bGQg
d3JvbmcgaW4gcHJhY3RpY2UNCj4gd2l0aCBwYWdlX21hcGNvdW50IHNvdW5kcyBiYWNrd2FyZHMg
YW5kIHVubmVjZXNzYXJpbHkgcmlza3kuDQo+IA0KPiBJbiB0aGVvcnkgaXQgd2FzIGFscmVhZHkg
YnJva2VuIGFuZCBpbiB0aGVvcnkNCj4gMDk4NTRiYTk0YzZhYWQ3ODg2OTk2YmZiZWUyNTMwYjNk
OGE3ZjRmNCBpcyBhYnNvbHV0ZWx5IHBlcmZlY3QgYW5kIHRoZQ0KPiBwcmV2aW91cyBjb2RlIG9m
IDIwMTMgaXMgY29tcGxldGVseSB3cm9uZywgYnV0IGluIHByYWN0aWNlIHRoZSBjb2RlDQo+IGZy
b20gMjAxMyB3b3JrZWQgcGVyZmVjdGx5IHVudGlsIEF1ZyAyMSAyMDIwLg0KDQpXZWxs4oCmIElm
IHlvdSBjb25zaWRlciB0aGUgYnVnIHRoYXQgV2lsbCByZWNlbnRseSBmaXhlZCBbMV0sIHRoZW4g
c29mdC1kaXJ0eQ0Kd2FzIGJyb2tlbiAoZm9yIGEgZGlmZmVyZW50LCB5ZXQgcmVsYXRlZCByZWFz
b24pIHNpbmNlIDA3NThjZDgzMDQ5NA0KKCJhc20tZ2VuZXJpYy90bGI6IGF2b2lkIHBvdGVudGlh
bCBkb3VibGUgZmx1c2jigJ0pLg0KDQpUaGlzIGlzIG5vdCB0byBzYXkgdGhhdCBJIGFyZ3VlIHRo
YXQgdGhlIHBhdGNoIHNob3VsZCBiZSBiYWNrcG9ydGVkIHRvIDIwMTMsDQpqdXN0IHRvIHNheSB0
aGF0IG1lbW9yeSBjb3JydXB0aW9uIGJ1Z3MgY2FuIGJlIHVubm90aWNlZC4NCg0KWzFdIGh0dHBz
Oi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC1tbS9wYXRjaC8yMDIwMTIxMDEy
MTExMC4xMDA5NC0yLXdpbGxAa2VybmVsLm9yZy8NCg0KPiANCj4gU2luY2Ugbm90aGluZyBhdCBh
bGwgY291bGQgZ28gd3JvbmcgaW4gc29mdCBkaXJ0eSBhbmQgdWZmZC13cCB1bnRpbA0KPiAwOTg1
NGJhOTRjNmFhZDc4ODY5OTZiZmJlZTI1MzBiM2Q4YTdmNGY0LCB0aGUgRml4ZXMgbmVlZCB0byB0
YXJnZXQNCj4gdGhhdCwgZGVmaW5pdGVseSBub3QgYSBwYXRjaCBmcm9tIDIwMTMuDQo+IA0KPiBU
aGlzIG1lYW5zIHRoZSBiYWNrcG9ydHMgd2lsbCBhcHBseSBjbGVhbiwgdGhleSBkb24ndCBuZWVk
IGEgc2ltcGxlDQo+IHNvbHV0aW9uIGJ1dCBvbmUgdGhhdCBkb2Vzbid0IHJlZ3Jlc3MgdGhlIHBl
cmZvcm1hbmNlIG9mIG9wZW4gc291cmNlDQo+IHZpcnR1YWwgbWFjaGluZXMgYW5kIG9wZW4gc291
cmNlIHByb2R1Y3RzIHVzaW5nIGNsZWFyX3JlZnMgYW5kIHVmZmQtd3ANCj4gaW4gZ2VuZXJhbC4N
Cg0KVG8gc3VtbWFyaXplIG15IGFjdGlvbiBpdGVtcyBiYXNlZCB5b3VyIChhbmQgb3RoZXJzKSBm
ZWVkYmFjayBvbiBib3RoDQpwYXRjaGVzOg0KDQoxLiBJIHdpbGwgYnJlYWsgdGhlIGZpcnN0IHBh
dGNoIGludG8gdHdvIGRpZmZlcmVudCBwYXRjaGVzLCBvbmUgd2l0aCB0aGUNCuKAnG9wdGltaXph
dGlvbuKAnSBmb3Igd3JpdGUtdW5wcm90ZWN0LCBiYXNlZCBvbiB5b3VyIGZlZWRiYWNrLiBJdCB3
aWxsIG5vdA0KYmUgYmFja3BvcnRlZC4NCg0KMi4gSSB3aWxsIHRyeSB0byBhZGQgYSBwYXRjaCB0
byBhdm9pZCBUTEIgZmx1c2hlcyBvbg0KdXNlcmZhdWx0ZmQtd3JpdGV1bnByb3RlY3QuIEl0IHdp
bGwgYWxzbyBub3QgYmUgYmFja3BvcnRlZC4NCg0KMy4gTGV0IG1lIGtub3cgaWYgeW91IHdhbnQg
bWUgdG8gdXNlIHlvdXIgdmVyc2lvbiBvZiB0ZXN0aW5nDQptbV90bGJfZmx1c2hfcGVuZGluZygp
IGFuZCBjb25kaXRpb25hbGx5IGZsdXNoaW5nLCB3YWl0IGZvciBuZXcgdmVyc2lvbiBmcm8NCnlv
dSBvciBQZXRlciBvciB0byBnbyB3aXRoIHRha2luZyBtbWFwX2xvY2sgZm9yIHdyaXRlLg0KDQpU
aGFua3MgYWdhaW4sDQpOYWRhdg==

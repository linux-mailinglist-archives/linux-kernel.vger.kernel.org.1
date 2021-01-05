Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3F262EA734
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 10:24:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbhAEJXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 04:23:44 -0500
Received: from mail-bn7nam10on2044.outbound.protection.outlook.com ([40.107.92.44]:16480
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725860AbhAEJXn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 04:23:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MpU6MQDXClEVp12pvqw8Kra0DFqpyC9uWM18uFEhxOkIKrZSeKn5fE+/Jv8Wf4ZZTxr6FmW3eMkY6BHKYUi4GfS1iXpKIJKwuqzWGm3DNQ5L0eGomUjO695/HCCaNvFZ4xbpKW1k7vpwYbm50hh4J/ZJ7UGxXzCRPujl9sFFpLowv1ImKsOO+k5H3G+Dco0cpAED6kOVC9cGO9QastNsrXh+IEHMLMzdb2+3Med3TAijYs4V1BOXPj3jGIBiAteyCYAq/gIEquGmdBybGy4X5cvlU/MXNs7q87CT4sVYrb4W+wYXsMRoCnxL63PKitd4PFLD/VqC595TfIwpZal+HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TFMFkIaQri7hLIIwZEf8loITm3UEbqD0h3DXPgg8d30=;
 b=b2x3x7ppS0iBuZxiDy0FPNtcMt43SZVeT1UvRMCedWVo4Ci+ndgDUqBiDH0t1J9npsxTFU8xaSwl+OfeEoSAh1P5IMuJoJkktz/MatrgQ4TcryK/uXM8GWT4lryN0lLzXa6HfDJhscDKIya5WJ004tkaiVCidaAlPhK/9l9jylLjkp6b86zkFg40W0Fmm0pMxXDdpH8pCJDltIMMGOBMR5wo3msg18s+gk0xc1e26BqeKmtG9UrGfMzXaffB9ud+URT1ehfW8G/en+1Mx520tfsfPKU93TWbT/aBGR2uAXY0Nca+aM7dRb03mYHH4f+ECVtQlqdoSrzLpu5W7RS7dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TFMFkIaQri7hLIIwZEf8loITm3UEbqD0h3DXPgg8d30=;
 b=JgCjAzwAeadCek0c3f2VgH0Bp1DNEaf1xXof/O77ELRbNdXrTjhebXNWVNpw1w0RnJdsVHcit2tVMyb8sNzOsWkwUIkJP7eJUmQqFFZeXFP/4YkKn7lfdXYS6ZJnY1oCuNWrYzg/D88ShM8WT4tp1QosmzqJOCs60Yc7umpUv+s=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (2603:10b6:a03:4a::18)
 by BY3PR05MB8083.namprd05.prod.outlook.com (2603:10b6:a03:36e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.4; Tue, 5 Jan
 2021 09:22:49 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::d421:f99:8921:1ee7]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::d421:f99:8921:1ee7%6]) with mapi id 15.20.3742.006; Tue, 5 Jan 2021
 09:22:49 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Andrea Arcangeli <aarcange@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yu Zhao <yuzhao@google.com>, Andy Lutomirski <luto@kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Pavel Emelyanov <xemul@openvz.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Minchan Kim <minchan@kernel.org>,
        Will Deacon <will@kernel.org>, Mel Gorman <mgorman@suse.de>
Subject: Re: [RFC PATCH v2 1/2] mm/userfaultfd: fix memory corruption due to
 writeprotect
Thread-Topic: [RFC PATCH v2 1/2] mm/userfaultfd: fix memory corruption due to
 writeprotect
Thread-Index: AQHW4pRwZnSKvT4iE02cPjpfTbkFJKoX2VMAgADjhICAAAamgA==
Date:   Tue, 5 Jan 2021 09:22:49 +0000
Message-ID: <66DCFCDB-1824-4A1F-B54B-F7C662E63A2B@vmware.com>
References: <20201225092529.3228466-1-namit@vmware.com>
 <20201225092529.3228466-2-namit@vmware.com>
 <20210104122227.GL3021@hirez.programming.kicks-ass.net>
 <X/NrdnoDHgFd0Ku1@redhat.com>
 <20210105085857.GE3040@hirez.programming.kicks-ass.net>
In-Reply-To: <20210105085857.GE3040@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=vmware.com;
x-originating-ip: [24.6.216.183]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ebfabf79-3f3f-44a1-c3a7-08d8b15b784a
x-ms-traffictypediagnostic: BY3PR05MB8083:
x-microsoft-antispam-prvs: <BY3PR05MB808344C6A9836079D2769F62D0D10@BY3PR05MB8083.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p653qTFEzt30stcwkOxuMC1LIue7ez8+CP5yfkI62gHN+wAEl+I8LezqsWF+QJTMMjv/7JnUA4IRFn4tfMMINJF+biJG+kM+OUiNNLUUX8ZbJ6zQqHIYugIY6+ePRmTm6Cuq/svlu0HsnDigX+ffQrppRZZZ7ILR253hbdc7QPaP32gF8DeX6uwaFfysT6W+I/w4oZIweRPgwhuObjNZiDhD2FvfA3ECK9sK7gy4NcAKjTiBmiqffIDGeKDB6JDgA3DDk3ZVQfXWBaLayPVhD1PBugDvJn1iXQ0M03c2EfPefmFHpqzgYTHiq9OCykqb0dZ8wngSejmvxllmdlLkhJ4f+K4EHUJxcZ2VgeichMZXlCUD8PvvVA1Kb1z1PVnXaCPExUet8hGFcwZ7Gru7xo3EMC47cmUd8HG8ubKuATZLzjAy+K7k/fcJHGm0A4FY
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR05MB4776.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(346002)(376002)(366004)(136003)(66946007)(8936002)(53546011)(54906003)(66476007)(2616005)(6916009)(33656002)(2906002)(76116006)(6512007)(7416002)(478600001)(8676002)(6506007)(86362001)(5660300002)(186003)(316002)(36756003)(71200400001)(83380400001)(66446008)(4326008)(66556008)(6486002)(64756008)(26005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?NkMweFVPaTJ1SGQ0eEdvR1dXTnNFK1A4SUFabmQ5RjNuVytFbjNsWjVZanNi?=
 =?utf-8?B?Y2llMXcyRjh1OUJmZVBWOGpXZjY0R2dqMTJXQVoxY2RlV05TMTMzbjZoT3Bh?=
 =?utf-8?B?QjlKdWRmWDV4TDdRbXordFg1RiswaUlqeVhBM1BHVkJMVXVLbVY2L1E2aFh4?=
 =?utf-8?B?Wmp5UTkvZjRjSmVTTnFtUHovL1UzclRWOVdiMWhEYi9SUkNGTTFNRzA4MkxK?=
 =?utf-8?B?ajRYNjVOYThCOGpRQmpPZXdGZC9yczZ2OTdyNEVSNVlucjVyWEFpTjZsOHli?=
 =?utf-8?B?QjcxUXRZZ2VLaC9qMCtrNFBHbW1vODBNT1NNS2JFbUo5VEE1WVRTL1N3dCtQ?=
 =?utf-8?B?VE53K3RuNzk3YWQrQ24yaGdIZHZNOGprNHlEVEF3Rm0zZG1jVEJqaUVXQTJS?=
 =?utf-8?B?S0ozaXViZmRHV2JCZHllYzdtVG5PNVNpUm5nTG04MTJsL1NLMkcraHNSbmdD?=
 =?utf-8?B?OGJwYk0xclZZY2xsemkxMnVXU2JTeVRvNjBOUFhDckxSNG1YdE1XbEJjVW8v?=
 =?utf-8?B?V3JzM1IrMFFJK1Y2dGovQTQyOHE1Vkl3QjM3M0dyWEp1WVRlVkxabG51NlRt?=
 =?utf-8?B?OTVHdWF6OU53V3BHdXNhQ1ZXanBYMjRKMUZyZkVaeEtwT2w1NFEwY0ZhK2hu?=
 =?utf-8?B?azFNblZEODVTWlBFdWY1MVpHWHNwVHhtOE95ZkFnUzZLZmtzVDRCVHFJOEdE?=
 =?utf-8?B?V0FzZWpIUFFVc3dManplMmVwaW9WaVJzTk90MnhRWjZjNDFLZmFZVmtzaStL?=
 =?utf-8?B?OWx4U0NjL0owdklzVG8ySVgyWlVYK1VaU3VuUk1QaUo4M3FaUnc2TWtnWnlB?=
 =?utf-8?B?bzFjOG5uNC9oc2NlN1R5bDArbGxJWEFpTWtYVWFHSkFIU0l3T3EzMnZYUHFF?=
 =?utf-8?B?aVJueW00S0F4N0ZlS0M4RDhydEdwbTBKMHovck9RQVkwclpPdURTQlhhaDR6?=
 =?utf-8?B?N2NzUXVwVy90ejZGQlcrVVJFK3Zpbk9PMnQ2eXV5QUd0U1A4RHhaYUtXbjV2?=
 =?utf-8?B?Q2l1bERSejIyclF1RWU1V3V6U0VmcWgrN2JkTEVnLzM5eFlOWXM2OGZ6UlNy?=
 =?utf-8?B?WkIzZUE0SnJrMFAya1p5SjZLdGJMZ0Mvdm8zWjNOQU42RkY2dlJlNXBxT1NN?=
 =?utf-8?B?REMvVW9oNWxDblFZKzVTK3ZMTndqN3o4SnZ3UVU2aFFpRmQ2dENVTjZWdklk?=
 =?utf-8?B?ajlQRE5MZ0tWeXRvTkpieHVyYmFzUDEyMkNhdW9nbnU5ZTc5MytuaC9Td1NC?=
 =?utf-8?B?UitEN2JyMFJkcmw3SXZCYm9XYm1Kc2syMWFPdFhCNGx1RzRiNWxjeEdFZlZU?=
 =?utf-8?Q?2Pa/LzvxY6UgYqNVcvQSlLLTSPRtRXuuWS?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <A03042FD8E7557449E83A84CD337D0B9@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR05MB4776.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebfabf79-3f3f-44a1-c3a7-08d8b15b784a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2021 09:22:49.0311
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aIQEW0lanWFbYWu6Fa1xEYQ3Pob9NVElQ0yMgrs7jvTXhTSAug3UShme7zSaB5B69ENWBxMOb8BoV+G3m7hCdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR05MB8083
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBKYW4gNSwgMjAyMSwgYXQgMTI6NTggQU0sIFBldGVyIFppamxzdHJhIDxwZXRlcnpAaW5m
cmFkZWFkLm9yZz4gd3JvdGU6DQo+IA0KPiBPbiBNb24sIEphbiAwNCwgMjAyMSBhdCAwMjoyNDoz
OFBNIC0wNTAwLCBBbmRyZWEgQXJjYW5nZWxpIHdyb3RlOg0KPj4gT24gTW9uLCBKYW4gMDQsIDIw
MjEgYXQgMDE6MjI6MjdQTSArMDEwMCwgUGV0ZXIgWmlqbHN0cmEgd3JvdGU6DQo+Pj4gT24gRnJp
LCBEZWMgMjUsIDIwMjAgYXQgMDE6MjU6MjhBTSAtMDgwMCwgTmFkYXYgQW1pdCB3cm90ZToNCj4+
PiANCj4+Pj4gVGhlIHNjZW5hcmlvIHRoYXQgaGFwcGVucyBpbiBzZWxmdGVzdHMvdm0vdXNlcmZh
dWx0ZmQgaXMgYXMgZm9sbG93czoNCj4+Pj4gDQo+Pj4+IGNwdTAJCQkJY3B1MQkJCWNwdTINCj4+
Pj4gLS0tLQkJCQktLS0tCQkJLS0tLQ0KPj4+PiAJCQkJCQkJWyBXcml0YWJsZSBQVEUNCj4+Pj4g
CQkJCQkJCSAgY2FjaGVkIGluIFRMQiBdDQo+Pj4+IHVzZXJmYXVsdGZkX3dyaXRlcHJvdGVjdCgp
DQo+Pj4+IFsgd3JpdGUtKnVucHJvdGVjdCogXQ0KPj4+PiBtd3JpdGVwcm90ZWN0X3JhbmdlKCkN
Cj4+Pj4gbW1hcF9yZWFkX2xvY2soKQ0KPj4+PiBjaGFuZ2VfcHJvdGVjdGlvbigpDQo+Pj4+IA0K
Pj4+PiBjaGFuZ2VfcHJvdGVjdGlvbl9yYW5nZSgpDQo+Pj4+IC4uLg0KPj4+PiBjaGFuZ2VfcHRl
X3JhbmdlKCkNCj4+Pj4gWyAqY2xlYXIqIOKAnHdyaXRl4oCdLWJpdCBdDQo+Pj4+IFsgZGVmZXIg
VExCIGZsdXNoZXMgXQ0KPj4+PiAJCQkJWyBwYWdlLWZhdWx0IF0NCj4+Pj4gCQkJCS4uLg0KPj4+
PiAJCQkJd3BfcGFnZV9jb3B5KCkNCj4+Pj4gCQkJCSBjb3dfdXNlcl9wYWdlKCkNCj4+Pj4gCQkJ
CSAgWyBjb3B5IHBhZ2UgXQ0KPj4+PiAJCQkJCQkJWyB3cml0ZSB0byBvbGQNCj4+Pj4gCQkJCQkJ
CSAgcGFnZSBdDQo+Pj4+IAkJCQkuLi4NCj4+Pj4gCQkJCSBzZXRfcHRlX2F0X25vdGlmeSgpDQo+
Pj4gDQo+Pj4gWXVjayENCj4+IA0KPj4gTm90ZSwgdGhlIGFib3ZlIHdhcyBwb3N0ZWQgYmVmb3Jl
IHdlIGZpZ3VyZWQgb3V0IHRoZSBkZXRhaWxzIHNvIGl0DQo+PiB3YXNuJ3Qgc2hvd2luZyB0aGUg
cmVhbCBkZWZlcnJlZCB0bGIgZmx1c2ggdGhhdCBjYXVzZWQgcHJvYmxlbXMgKHRoZQ0KPj4gb25l
IHNob3dlZCBvbiB0aGUgbGVmdCBjYXVzZXMgemVybyBpc3N1ZXMpLg0KPj4gDQo+PiBUaGUgcHJv
YmxlbWF0aWMgb25lIG5vdCBwaWN0dXJlZCBpcyB0aGUgb25lIG9mIHRoZSB3cnByb3RlY3QgdGhh
dCBoYXMNCj4+IHRvIGJlIHJ1bm5pbmcgaW4gYW5vdGhlciBDUFUgd2hpY2ggaXMgYWxzbyBpc24n
dCBwaWN0dXJlIGFib3ZlLiBNb3JlDQo+PiBhY2N1cmF0ZSB0cmFjZXMgYXJlIHBvc3RlZCBsYXRl
ciBpbiB0aGUgdGhyZWFkLg0KPiANCj4gTGV0cyBhc3N1bWUgQ1BVMCBkb2VzIGEgcmVhZC1sb2Nr
LCBXIC0+IFJPIHdpdGggZGVmZXJyZWQgZmx1c2guDQoNClRoaXMgaXMgdGhlIHNlY29uZCBzY2Vu
YXJpbyB0aGF0IGlzIG1lbnRpb25lZCBpbiB0aGUgcGF0Y2guIChUaGUgZmlyc3Qgb25lDQppcyBy
ZWxhdGl2ZWx5IGVhc3kgdG8gYWRkcmVzcyBieSBub3QgY2xlYXJpbmcgdGhlIHdyaXRlLWJpdCku
DQoNCj4+PiBJc24ndCB0aGlzIGFsbCByYXRoZXIgc2ltaWxhciB0byB0aGUgcHJvYmxlbSB0aGF0
IHJlc3VsdGVkIGluIHRoZQ0KPj4+IHRsYl9mbHVzaF9wZW5kaW5nIG1lc3M/DQo+Pj4gDQo+Pj4g
SSBzdGlsbCB0aGluayB0aGF0J3MgYWxsIGZ1bmRhbWVudGFsbHkgYnVnZ2VyZWQsIHRoZSBtdWNo
IHNhbmVyIHNvbHV0aW9uDQo+Pj4gKElNTykgd291bGQndmUgYmVlbiB0byBtYWtlIHRoaW5ncyB3
YWl0IGZvciB0aGUgcGVuZGluZyBmbHVzaCwgaW5zdGVhZA0KPj4gDQo+PiBIb3cgZG8gaW50ZW5k
IHlvdSB3YWl0IGluIFBUIGxvY2sgd2hpbGUgdGhlIHdyaXRlciBhbHNvIGhhcyB0byB0YWtlIFBU
DQo+PiBsb2NrIHJlcGVhdGVkbHkgYmVmb3JlIGl0IGNhbiBkbyB3YWtlX3VwX3Zhcj8NCj4+IA0K
Pj4gSWYgeW91IHJlbGVhc2UgdGhlIFBUIGxvY2sgYmVmb3JlIGNhbGxpbmcgd2FpdF90bGJfZmx1
c2hfcGVuZGluZyBpdA0KPj4gYWxsIGZhbGxzIGFwYXJ0IGFnYWluLg0KPiANCj4gSSBzdXBwb3Nl
IHlvdSBjYW4gY2hlY2sgZm9yIHBlbmRpbmcsIGlmIGZvdW5kLCByZWxlYXNlIGxvY2ssIHdhaXQg
Zm9yIDAsDQo+IGFuZCByZS10YWtlIHRoZSBmYXVsdD8NCg0KTXkgcGVyc29uYWwgdGFrZSBvbiB0
aGlzIGlzc3VlICh3aGljaCBmb3IgZnVsbCBkaXNjbG9zdXJlIEkgdGhpbmsgQW5kcmVhDQpkaXNh
Z3JlZXMgd2l0aCkgaXMgdGhhdCBpdCB0aGUgbW9zdCBpbXBvcnRhbnQgZW5oYW5jZW1lbnQgaXMg
dG8gcmVkdWNlIHRoZQ0KbnVtYmVyIG9mIGNhc2VzIHdoaWNoIHdlIG1pc3Rha2VubHkgdGhpbmsg
dGhhdCB3ZSBtdXN0IHdhaXQgZm9yIHBlbmRpbmcgVExCDQpmbHVzaC4gSXQgd2lsbCBub3QgYmUg
ZnJlZSB0aG91Z2guDQoNCkFzIHRvIHRoZSBlbmhhbmNlbWVudCB0aGF0IHlvdSBwcm9wb3NlOiBh
bHRob3VnaCBpdCBzZWVtcyBhcyBhIHZhbGlkDQplbmhhbmNlbWVudCB0byBtZSwgSSB0aGluayB0
aGF0IGl0IGlzIG1vcmUgcm9idXN0IHRvIG1ha2UgZm9yd2FyZCBwcm9ncmVzcw0Kd2hlbiBwb3Nz
aWJsZSAoYXMgZG9uZSB0b2RheSkuIFRoaXMgaXMgZXNwZWNpYWxseSBpbXBvcnRhbnQgaWYgdGhl
IHByb3Bvc2VkDQplbmhhbmNlbWVudCBjYW5ub3QgYmUgY2hlY2tlZCBieSBsb2NrZGVwLg0KDQo=

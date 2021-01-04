Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC01F2E9EF1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 21:41:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbhADUkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 15:40:36 -0500
Received: from mail-bn8nam11on2077.outbound.protection.outlook.com ([40.107.236.77]:46465
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725921AbhADUkf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 15:40:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NuDW5buKOuGn1BPMzwIO+5H6I+l1inyPSvFPFMYnxdC3a5MNNg3kb5zSvr1TImRMVYfz1/QxtoveUKdyLinBo3AW1StrkzCFnLTP+1Mr7UX9w0oWG97TJd+ncVPRLThcNuYa0qsmAke/hCOQE24IT6gKju54wsWm5vCgc6iSfRXaQkCxtuJnO9dPK+caK8z0qv1Wwxqo7LuPClMLk0ICD9UdlmlejMONfJjzn4VYcqqgGzyCNP34IokE4BYE9SplH9uo9xe2PQwCRHVRHVUrums9qRjhWbDoNUqM7po5ODhSIUSYB9Ya2gNB7xLhCG/zi/j9cLmVYi5PPXzqSnAasA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OOw8xC6KHsCd16uGRRCz9l7ndurUPLWwsJlkrCzuoIA=;
 b=c3dAw/vTc2wLXFWgrQ7Cuf8MxCsFzvZCxMnbr2XwVo2lEMYqJIDmx0XxAqWAZ2rEAi2jfGL964RiSyHHSHEOKwEMYPWLem/fgbOel5f/1RWdMTpHwPW14Yx6VC7U//BXQjqooauJCHek8TpSg9N/I62OYoUvSm9192YsPW/Ii18b1Oble5SIF9JBwqgi4So6pSYSJ1zvxbQEZ9cgvI+kdzU1lf9tEYpc3ikIxKrkyQhjRTOhFCUoSB5nmlyacn2RsxzHl2A2FSm0WLVPP8qbSZucwl1z8zB/7Rpav7LweSRP1r1EOw2+G2gSg1nN+ac7hTM7gFsPyiFPZLXngVljkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OOw8xC6KHsCd16uGRRCz9l7ndurUPLWwsJlkrCzuoIA=;
 b=XJ6q1OdSH7Ml+pN6qKPrI20+zc1tej6s/69MceWN2QgNAfwN63dSgwQAw6TZ/Y/DnW/BIdf1BlCbcVl2p0Rkt66tNg94ZNOkYkxUu3+KHhjD+KJWlh9+BpyyXu2QN/8AgWYMvrt8AvIRok9n41K+cbrHlDskbGv7Mt9dTYSsmQM=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (2603:10b6:a03:4a::18)
 by BYAPR05MB6344.namprd05.prod.outlook.com (2603:10b6:a03:e2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.4; Mon, 4 Jan
 2021 20:39:38 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::d421:f99:8921:1ee7]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::d421:f99:8921:1ee7%6]) with mapi id 15.20.3742.006; Mon, 4 Jan 2021
 20:39:37 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Andrea Arcangeli <aarcange@redhat.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        linux-mm <linux-mm@kvack.org>,
        lkml <linux-kernel@vger.kernel.org>, Yu Zhao <yuzhao@google.com>,
        Andy Lutomirski <luto@kernel.org>,
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
Thread-Index: AQHW4pRwZnSKvT4iE02cPjpfTbkFJKoX2VMAgAAC64CAAAyGAIAABYKA
Date:   Mon, 4 Jan 2021 20:39:37 +0000
Message-ID: <73EE9007-65AF-4416-9930-D992C74447A9@vmware.com>
References: <20201225092529.3228466-1-namit@vmware.com>
 <20201225092529.3228466-2-namit@vmware.com>
 <20210104122227.GL3021@hirez.programming.kicks-ass.net>
 <X/NrdnoDHgFd0Ku1@redhat.com>
 <A7AC77D2-6901-4225-911B-EDBF013DCA42@vmware.com>
 <X/N4aqRgyxffhMSs@redhat.com>
In-Reply-To: <X/N4aqRgyxffhMSs@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=vmware.com;
x-originating-ip: [24.6.216.183]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 01f04c5d-35a1-4c68-ba6a-08d8b0f0da9c
x-ms-traffictypediagnostic: BYAPR05MB6344:
x-microsoft-antispam-prvs: <BYAPR05MB6344F55ED25110700F8A119FD0D20@BYAPR05MB6344.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mhDKI1ttkSr2JtTkZmvuprQQGCKjyKCG6vDzg+fYY3isa5VzQS2epdCRYXGmFU6ylACbj98X+2qVkTbBeSEV0v8xPoXVOKAsdIE/j1oNcSLJ1rM9kc1L7Nbr6p++vbJdSqU/9o9Sb6DJNIW3hCPL7I00sQpXVO/MGcpw0ax53MtDRiLrC7ilPNHyC0w7b7eOEfwacLKv3x8XSIbENmvMyrO1xrTP+sQP/Hs5Eb5qHyAO5poCvzpM7vnmoVmPv9Q5ICxpGvQXsOq2IvG3Exv5c6AlsNWhhsYKuJ8Nj+NfTnSHWPTSbMOjLZlMDOpt4yGKssLX6llbD/v+QCUb2BsOxjW4bXJ8uh7UAdr1HREXSAMBHutiLTyjbb1PwVOU70X7aqoGFO8+vFWSGrgTptyjQXuSiyJ0i9ug19INbeadzggrT9YlGlNrXze/iqYB60YU
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR05MB4776.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(346002)(376002)(366004)(136003)(4326008)(6916009)(5660300002)(66446008)(64756008)(66556008)(66476007)(54906003)(478600001)(53546011)(66946007)(6506007)(76116006)(2906002)(316002)(8936002)(2616005)(36756003)(186003)(6512007)(6486002)(8676002)(7416002)(83380400001)(71200400001)(33656002)(86362001)(26005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?cy96aks0azBuWXVrN3pKWld1aituc0RFUG80S2tyZE1uOWpyVEV2Y1YzUUdo?=
 =?utf-8?B?UDdKUm5GaWtGb3VWcW15cTUwQ0Z3MVNlTTFrQ2ZtNmdEZ08wY1cwdHlZcEFx?=
 =?utf-8?B?dlNUU05xTHd4ay84eG1sVU1IaUROTkJsbS9YVnlxaysxYTVzd3R2MmJ1bUtI?=
 =?utf-8?B?NThiV3FvT29MdWxpSzRsZVpPd0dybVZXeStXM2k1bzY3ZHRqZmVlUUt3NG01?=
 =?utf-8?B?MU1uS0hLT3FzcnZUMFZXVWNoaEFwWXFHZ3Y2QTFlUE5vQkNYVHdQMU4xS0tW?=
 =?utf-8?B?bkpjVTNaa2NYdDB4dERSMzZqMnhlV0s0TzI2WGw1aWhtbUFJc0NmMWRRaUR3?=
 =?utf-8?B?U0N2WTJnYlQwTG9aNm1MdlkvRWR5YmEwY3BqaVdZazBUNE1TRjcyRXFWS2hr?=
 =?utf-8?B?blA4RDRWZHQ3TkJ1bjZkb1JPNzhVR1MrZkZIUDIrSE9qbzFpTzhkS0UxQzZN?=
 =?utf-8?B?ZEphOC9ZV1pFNEZRZjVPMlNydklma1Z2RDJSc2ZHQjM0dC9hT29tdmFTNGJZ?=
 =?utf-8?B?bGJWLyt5cUhsc05mOW9mdk5tWVdtajVRNURKR1VIZE9aNzI1ZGx3TjFST3Mx?=
 =?utf-8?B?dEhSbkxEWEF1akIrK0ZDOGsrUGVTWmlsYXBQb3U3WlVqSTNtekhsNXEwK21T?=
 =?utf-8?B?UkFtMnlwTXQ1VHp1SlVybitIM1hHL0lBZ2RaNFRWeXBuUkhFOXVnbVhkcTg0?=
 =?utf-8?B?bXZUN1VBcXVka3NZTmlSZTFwMkh3OW5uMmhaYnN2ODJ4SEtqZ3RQUFFlZzJv?=
 =?utf-8?B?VEZzcEl1MGZYVXlweDV4bEpMMEhlU1FVZ3JTQys0VXh0S1VXS2JIby9iMlEr?=
 =?utf-8?B?SDZsd0g1cEFzYTJBTzViUzUrZ05nbHVHQVhoYWJpU0luV3k1UmdhOVVXa1BO?=
 =?utf-8?B?c0I4d3VrVHhXYnpvRXVlblNQRFowOXh0RXYwRkNIR2NnRWxuWE52NFpDcFNj?=
 =?utf-8?B?NVFxTjVlbUdERXdpU2xISmF4WnFXMjBsc1hFR1ZZeWFtMUFIdDBKVE1FOWk5?=
 =?utf-8?B?UjNsVjZMUDRRUnFGcUZsRlkxWEtaTVByRVlkNUF3Y3FoS0V2aUw0MGJIM1My?=
 =?utf-8?B?NkR3dlVSS1ZUM0NZNWtWRHM4ZVc0d05kc1p2SUJOUGFPMVpoaXB2dWlaTmJ1?=
 =?utf-8?B?TFgvS0dyVHJKRXJJYjRFVkpYNGFCU0Z6TTZJd2w1dzg4VlhQK0pLSitzZlRz?=
 =?utf-8?B?NEFnRW1nY2hXTEZMa3NNL1JwQVR5ZHU2Tll5NHp5NEJTWENJTXFwWWYrQ21G?=
 =?utf-8?B?MFhJWTdFYVlVeElralFPUDZRSUYvd29icUJjV01XNDQrUWI0ZUh2WEN2MFNz?=
 =?utf-8?Q?NW3RYXwk4b3FcLr/aHYJ6LSYHCufAM0aDi?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <EC14EDC0A118FD4E9841EC42D0A8AFD1@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR05MB4776.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01f04c5d-35a1-4c68-ba6a-08d8b0f0da9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2021 20:39:37.7660
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cw/BRTvWLzIR7EWpm317k6PYBKcmGzX47pXqI1oPainocH2EqCdP7GIjOb3t9nvMMGZc2r+9T/k2n3kgjslGqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB6344
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBKYW4gNCwgMjAyMSwgYXQgMTI6MTkgUE0sIEFuZHJlYSBBcmNhbmdlbGkgPGFhcmNhbmdl
QHJlZGhhdC5jb20+IHdyb3RlOg0KPiANCj4gT24gTW9uLCBKYW4gMDQsIDIwMjEgYXQgMDc6MzU6
MDZQTSArMDAwMCwgTmFkYXYgQW1pdCB3cm90ZToNCj4+PiBPbiBKYW4gNCwgMjAyMSwgYXQgMTE6
MjQgQU0sIEFuZHJlYSBBcmNhbmdlbGkgPGFhcmNhbmdlQHJlZGhhdC5jb20+IHdyb3RlOg0KPj4+
IA0KPj4+IEhlbGxvLA0KPj4+IA0KPj4+IE9uIE1vbiwgSmFuIDA0LCAyMDIxIGF0IDAxOjIyOjI3
UE0gKzAxMDAsIFBldGVyIFppamxzdHJhIHdyb3RlOg0KPj4+PiBPbiBGcmksIERlYyAyNSwgMjAy
MCBhdCAwMToyNToyOEFNIC0wODAwLCBOYWRhdiBBbWl0IHdyb3RlOg0KPj4+PiANCj4+Pj4+IFRo
ZSBzY2VuYXJpbyB0aGF0IGhhcHBlbnMgaW4gc2VsZnRlc3RzL3ZtL3VzZXJmYXVsdGZkIGlzIGFz
IGZvbGxvd3M6DQo+Pj4+PiANCj4+Pj4+IGNwdTAJCQkJY3B1MQkJCWNwdTINCj4+Pj4+IC0tLS0J
CQkJLS0tLQkJCS0tLS0NCj4+Pj4+IAkJCQkJCQlbIFdyaXRhYmxlIFBURQ0KPj4+Pj4gCQkJCQkJ
CSAgY2FjaGVkIGluIFRMQiBdDQo+Pj4+PiB1c2VyZmF1bHRmZF93cml0ZXByb3RlY3QoKQ0KPj4+
Pj4gWyB3cml0ZS0qdW5wcm90ZWN0KiBdDQo+Pj4+PiBtd3JpdGVwcm90ZWN0X3JhbmdlKCkNCj4+
Pj4+IG1tYXBfcmVhZF9sb2NrKCkNCj4+Pj4+IGNoYW5nZV9wcm90ZWN0aW9uKCkNCj4+Pj4+IA0K
Pj4+Pj4gY2hhbmdlX3Byb3RlY3Rpb25fcmFuZ2UoKQ0KPj4+Pj4gLi4uDQo+Pj4+PiBjaGFuZ2Vf
cHRlX3JhbmdlKCkNCj4+Pj4+IFsgKmNsZWFyKiDigJx3cml0ZeKAnS1iaXQgXQ0KPj4+Pj4gWyBk
ZWZlciBUTEIgZmx1c2hlcyBdDQo+Pj4+PiAJCQkJWyBwYWdlLWZhdWx0IF0NCj4+Pj4+IAkJCQku
Li4NCj4+Pj4+IAkJCQl3cF9wYWdlX2NvcHkoKQ0KPj4+Pj4gCQkJCSBjb3dfdXNlcl9wYWdlKCkN
Cj4+Pj4+IAkJCQkgIFsgY29weSBwYWdlIF0NCj4+Pj4+IAkJCQkJCQlbIHdyaXRlIHRvIG9sZA0K
Pj4+Pj4gCQkJCQkJCSAgcGFnZSBdDQo+Pj4+PiAJCQkJLi4uDQo+Pj4+PiAJCQkJIHNldF9wdGVf
YXRfbm90aWZ5KCkNCj4+Pj4gDQo+Pj4+IFl1Y2shDQo+Pj4gDQo+Pj4gTm90ZSwgdGhlIGFib3Zl
IHdhcyBwb3N0ZWQgYmVmb3JlIHdlIGZpZ3VyZWQgb3V0IHRoZSBkZXRhaWxzIHNvIGl0DQo+Pj4g
d2Fzbid0IHNob3dpbmcgdGhlIHJlYWwgZGVmZXJyZWQgdGxiIGZsdXNoIHRoYXQgY2F1c2VkIHBy
b2JsZW1zICh0aGUNCj4+PiBvbmUgc2hvd2VkIG9uIHRoZSBsZWZ0IGNhdXNlcyB6ZXJvIGlzc3Vl
cykuDQo+PiANCj4+IEFjdHVhbGx5IGl0IHdhcyBwb3N0ZWQgYWZ0ZXIgKG5vdGUgdGhhdCB0aGlz
IGlzIHYyKS4gVGhlIGFmb3JlbWVudGlvbmVkDQo+PiBzY2VuYXJpbyB0aGF0IFBldGVyIHJlZ2Fy
ZHMgdG8gaXMgdGhlIG9uZSB0aGF0IEkgYWN0dWFsbHkgZW5jb3VudGVyZWQgKG5vdA0KPj4gdGhl
IHNlY29uZCBzY2VuYXJpbyB0aGF0IGlzIOKAnHRoZW9yZXRpY2Fs4oCdKS4gVGhpcyBzY2VuYXJp
byB0aGF0IFBldGVyIHJlZ2FyZHMNCj4+IGlzIGluZGVlZCBtb3JlIOKAnHN0dXBpZOKAnSBpbiB0
aGUgc2Vuc2UgdGhhdCB3ZSBzaG91bGQganVzdCBub3Qgd3JpdGUtcHJvdGVjdA0KPj4gdGhlIFBU
RSBvbiB1c2VyZmF1bHRmZCB3cml0ZS11bnByb3RlY3QuDQo+PiANCj4+IExldCBtZSBrbm93IGlm
IEkgbWFkZSBhbnkgbWlzdGFrZSBpbiB0aGUgZGVzY3JpcHRpb24uDQo+IA0KPiBJIGRpZG4ndCBz
YXkgdGhlcmUgaXMgYSBtaXN0YWtlLiBJIHNhaWQgaXQgaXMgbm90IHNob3dpbmcgdGhlIHJlYWwN
Cj4gZGVmZXJyZWQgdGxiIGZsdXNoIHRoYXQgY2F1c2UgcHJvYmxlbXMuDQo+IA0KPiBUaGUgaXNz
dWUgaGVyZSBpcyB0aGF0IHdlIGhhdmUgYSAiZGVmZXIgdGxiIGZsdXNoIiB0aGF0IHJ1bnMgYWZ0
ZXINCj4gIndyaXRlIHRvIG9sZCBwYWdlIi4NCj4gDQo+IElmIHlvdSBsb29rIGF0IHRoZSBhYm92
ZSwgeW91J3JlIGluZHVjZWQgdG8gdGhpbmsgdGhlICJkZWZlciB0bGINCj4gZmx1c2giIHRoYXQg
Y2F1c2VzIGlzc3VlcyBpcyB0aGUgb25lIGluIGNwdTAuIEl0J3Mgbm90LiBUaGF0IGlzDQo+IHRv
dGFsbHkgaGFybWxlc3MuDQoNCkkgZG8gbm90IHVuZGVyc3RhbmQgd2hhdCB5b3Ugc2F5LiBUaGUg
ZGVmZXJyZWQgVExCIGZsdXNoIG9uIGNwdTAgKmlzKiB0aGUNCnRoZSBvbmUgdGhhdCBjYXVzZXMg
dGhlIHByb2JsZW0uIFRoZSBQVEUgaXMgd3JpdGUtcHJvdGVjdGVkIChhbHRob3VnaCBpdCBpcw0K
YSB1c2VyZmF1bHRmZCB1bnByb3RlY3Qgb3BlcmF0aW9uKSwgY2F1c2luZyBjcHUxIHRvIGVuY291
bnRlciBhICNQRiwgaGFuZGxlDQp0aGUgcGFnZS1mYXVsdCAoYW5kIGNvcHkpLCB3aGlsZSBjcHUy
IGtlZXBzIHdyaXRpbmcgdG8gdGhlIHNvdXJjZSBwYWdlLiBJZg0KY3B1MCBkaWQgbm90IGRlZmVy
IHRoZSBUTEIgZmx1c2gsIHRoaXMgcHJvYmxlbSB3b3VsZCBub3QgaGFwcGVuLg0KDQo+Pj4gVGhl
IHByb2JsZW1hdGljIG9uZSBub3QgcGljdHVyZWQgaXMgdGhlIG9uZSBvZiB0aGUgd3Jwcm90ZWN0
IHRoYXQgaGFzDQo+Pj4gdG8gYmUgcnVubmluZyBpbiBhbm90aGVyIENQVSB3aGljaCBpcyBhbHNv
IGlzbid0IHBpY3R1cmUgYWJvdmUuIE1vcmUNCj4+PiBhY2N1cmF0ZSB0cmFjZXMgYXJlIHBvc3Rl
ZCBsYXRlciBpbiB0aGUgdGhyZWFkLg0KPj4gDQo+PiBJIHRoaW5rIEkgaW5jbHVkZWQgdGhpcyBz
Y2VuYXJpbyBhcyB3ZWxsIGluIHRoZSBjb21taXQgbG9nIChvZiB2MikuIExldCBtZQ0KPj4ga25v
dyBpZiBJIHNjcmV3ZWQgdXAgYW5kIHRoZSBkZXNjcmlwdGlvbiBpcyBub3QgY2xlYXIuDQo+IA0K
PiBJbnN0ZWFkIG9mIG5vdCBzaG93aW5nIHRoZSByZWFsICJkZWZlciB0bGIgZmx1c2giIGluIHRo
ZSB0cmFjZSBhbmQNCj4gdGhlbiBmaXhpbmcgaXQgdXAgaW4gdGhlIGNvbW1lbnQsIHdoeSBkb24n
dCB5b3UgdGFrZSB0aGUgdHJhY2Ugc2hvd2luZw0KPiB0aGUgcmVhbCBwcm9ibGVtYXRpYyAiZGVm
ZXIgdGxiIGZsdXNoIj8gTm8gbmVlZCB0byByZWludmVudCBpdC4NCg0KVGhlIHNjZW5hcmlvIHlv
dSBtZW50aW9uIGlzIGluZGVlZCBpZGVudGljYWwgdG8gdGhlIHNlY29uZCBzY2VuYXJpbyBJDQpt
ZW50aW9uIGluIHRoZSBjb21taXQgbG9nLiBJIHRoaW5rIHRoZSB2ZXJzaW9uIEkgaW5jbHVkZWQg
aXMgY2xlYXJlZCBzaW5jZQ0KaXQgc2hvd3MgdGhlIHdyaXRlIHRoYXQgdHJpZ2dlcnMgdGhlIGNv
cnJ1cHRpb24gaW5zdGVhZCBvZiBkaXNjdXNzaW5nDQrigJx3aW5kb3dz4oCdLCB3aGljaCBtaWdo
dCBiZSBsZXNzIGNsZWFyLiBSdW5uaW5nIGNvcHlfdXNlcl9wYWdlKCkgd2l0aCBzdGFsZQ0KVExC
IGlzIGJ5IGl0c2VsZiBub3QgYSBidWcgaWYgeW91IGRldGVjdCBpdCBsYXRlciAoZS5nLiwgdXNp
bmcgcHRlX3NhbWUoKSkuDQoNCk5vdGUgdGhhdCBteSBzZWNvbmQgc2NlbmFyaW8gaXMgYWxzbyBj
b25zaXN0ZW50IGluIHN0eWxlIHdpdGggdGhlIGZpcnN0DQpzY2VuYXJpby4NCg0KSSBhbSBub3Qg
bWFycmllZCB0byBteSBkZXNjcmlwdGlvbiBhbmQgaWYgeW91IChhbmQgb3RoZXJzKSBpbnNpc3Qg
SSB3b3VsZA0KY29weS1wYXN0ZSB5b3VyIHZlcnNpb24uDQoNCj4gVGhpcyBzaG93IHRoZSByZWFs
IGRlZmVycmVkIHRsYiBmbHVzaCwgeW91ciB2MiBkb2VzIG5vdCBpbmNsdWRlIGl0DQo+IGluc3Rl
YWQuDQoNCkFyZSB5b3UgdGFsa2luZyBhYm91dCB0aGUgZmlyc3Qgc2NlbmFyaW8gKHdyaXRlLXVu
cHJvdGVjdCksIHRoZSBzZWNvbmQgb25lDQood3JpdGUtcHJvdGVjdCBmb2xsb3dlZCBieSB3cml0
ZS11bnByb3RlY3QpLCBib3RoPyBJdCBzZWVtcyB0byBtZSB0aGF0IGFsbA0KdGhlIGRlZmVycmVk
IFRMQiBmbHVzaGVzIGFyZSBtZW50aW9uZWQgYXQgdGhlIHBvaW50IHRoZXkgYXJlIGRlZmVycmVk
LiBJIGNhbg0KYWRkIHRoZSBwb2ludCBpbiB3aGljaCB0aGV5IGFyZSBwZXJmb3JtZWQuDQoNCg==

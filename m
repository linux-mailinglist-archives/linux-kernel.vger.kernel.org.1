Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27E462D912C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 00:32:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbgLMXaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Dec 2020 18:30:14 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:2397 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbgLMXaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Dec 2020 18:30:14 -0500
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4CvLLg4SSvz4w7R;
        Mon, 14 Dec 2020 07:28:43 +0800 (CST)
Received: from dggemi759-chm.china.huawei.com (10.1.198.145) by
 DGGEMM406-HUB.china.huawei.com (10.3.20.214) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Mon, 14 Dec 2020 07:29:28 +0800
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggemi759-chm.china.huawei.com (10.1.198.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Mon, 14 Dec 2020 07:29:28 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2106.002;
 Mon, 14 Dec 2020 07:29:28 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     "Li, Aubrey" <aubrey.li@linux.intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
CC:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>, Jiang Biao <benbjiang@gmail.com>
Subject: RE: [RFC PATCH v8] sched/fair: select idle cpu from idle cpumask for
 task wakeup
Thread-Topic: [RFC PATCH v8] sched/fair: select idle cpu from idle cpumask for
 task wakeup
Thread-Index: AQHWzpZQLVKE01qtzUCZ8yTSyWT5lqnxe4YAgAADEoCAAAEKAIAAAJ0AgAQuBxA=
Date:   Sun, 13 Dec 2020 23:29:28 +0000
Message-ID: <121565627e944f8e9dde4080d19d5b02@hisilicon.com>
References: <20201210014359.183771-1-aubrey.li@linux.intel.com>
 <CAKfTPtAVC-ZJYexcYvVdO5gOJ2aXKzRpjLC797xoh5n4TWGU=Q@mail.gmail.com>
 <26c69935-e53d-32dc-0366-a1fb7f3c3d56@linux.intel.com>
 <CAKfTPtCrMAft5t8BrLxgLVoaLHoAmhTp3zgeB8Cu-7+fMSd2zw@mail.gmail.com>
 <698a61bf-6eea-8725-95c0-a5ea811e2bb4@linux.intel.com>
In-Reply-To: <698a61bf-6eea-8725-95c0-a5ea811e2bb4@linux.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.201.9]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGksIEF1YnJleSBbbWFp
bHRvOmF1YnJleS5saUBsaW51eC5pbnRlbC5jb21dDQo+IFNlbnQ6IFNhdHVyZGF5LCBEZWNlbWJl
ciAxMiwgMjAyMCA0OjI1IEFNDQo+IFRvOiBWaW5jZW50IEd1aXR0b3QgPHZpbmNlbnQuZ3VpdHRv
dEBsaW5hcm8ub3JnPg0KPiBDYzogSW5nbyBNb2xuYXIgPG1pbmdvQHJlZGhhdC5jb20+OyBQZXRl
ciBaaWpsc3RyYSA8cGV0ZXJ6QGluZnJhZGVhZC5vcmc+Ow0KPiBKdXJpIExlbGxpIDxqdXJpLmxl
bGxpQHJlZGhhdC5jb20+OyBNZWwgR29ybWFuIDxtZ29ybWFuQHRlY2hzaW5ndWxhcml0eS5uZXQ+
Ow0KPiBWYWxlbnRpbiBTY2huZWlkZXIgPHZhbGVudGluLnNjaG5laWRlckBhcm0uY29tPjsgUWFp
cyBZb3VzZWYNCj4gPHFhaXMueW91c2VmQGFybS5jb20+OyBEaWV0bWFyIEVnZ2VtYW5uIDxkaWV0
bWFyLmVnZ2VtYW5uQGFybS5jb20+OyBTdGV2ZW4NCj4gUm9zdGVkdCA8cm9zdGVkdEBnb29kbWlz
Lm9yZz47IEJlbiBTZWdhbGwgPGJzZWdhbGxAZ29vZ2xlLmNvbT47IFRpbSBDaGVuDQo+IDx0aW0u
Yy5jaGVuQGxpbnV4LmludGVsLmNvbT47IGxpbnV4LWtlcm5lbCA8bGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZz47DQo+IE1lbCBHb3JtYW4gPG1nb3JtYW5Ac3VzZS5kZT47IEppYW5nIEJpYW8g
PGJlbmJqaWFuZ0BnbWFpbC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUkZDIFBBVENIIHY4XSBzY2hl
ZC9mYWlyOiBzZWxlY3QgaWRsZSBjcHUgZnJvbSBpZGxlIGNwdW1hc2sgZm9yDQo+IHRhc2sgd2Fr
ZXVwDQo+IA0KPiBPbiAyMDIwLzEyLzExIDIzOjIyLCBWaW5jZW50IEd1aXR0b3Qgd3JvdGU6DQo+
ID4gT24gRnJpLCAxMSBEZWMgMjAyMCBhdCAxNjoxOSwgTGksIEF1YnJleSA8YXVicmV5LmxpQGxp
bnV4LmludGVsLmNvbT4gd3JvdGU6DQo+ID4+DQo+ID4+IE9uIDIwMjAvMTIvMTEgMjM6MDcsIFZp
bmNlbnQgR3VpdHRvdCB3cm90ZToNCj4gPj4+IE9uIFRodSwgMTAgRGVjIDIwMjAgYXQgMDI6NDQs
IEF1YnJleSBMaSA8YXVicmV5LmxpQGxpbnV4LmludGVsLmNvbT4gd3JvdGU6DQo+ID4+Pj4NCj4g
Pj4+PiBBZGQgaWRsZSBjcHVtYXNrIHRvIHRyYWNrIGlkbGUgY3B1cyBpbiBzY2hlZCBkb21haW4u
IEV2ZXJ5IHRpbWUNCj4gPj4+PiBhIENQVSBlbnRlcnMgaWRsZSwgdGhlIENQVSBpcyBzZXQgaW4g
aWRsZSBjcHVtYXNrIHRvIGJlIGEgd2FrZXVwDQo+ID4+Pj4gdGFyZ2V0LiBBbmQgaWYgdGhlIENQ
VSBpcyBub3QgaW4gaWRsZSwgdGhlIENQVSBpcyBjbGVhcmVkIGluIGlkbGUNCj4gPj4+PiBjcHVt
YXNrIGR1cmluZyBzY2hlZHVsZXIgdGljayB0byByYXRlbGltaXQgaWRsZSBjcHVtYXNrIHVwZGF0
ZS4NCj4gPj4+Pg0KPiA+Pj4+IFdoZW4gYSB0YXNrIHdha2VzIHVwIHRvIHNlbGVjdCBhbiBpZGxl
IGNwdSwgc2Nhbm5pbmcgaWRsZSBjcHVtYXNrDQo+ID4+Pj4gaGFzIGxvd2VyIGNvc3QgdGhhbiBz
Y2FubmluZyBhbGwgdGhlIGNwdXMgaW4gbGFzdCBsZXZlbCBjYWNoZSBkb21haW4sDQo+ID4+Pj4g
ZXNwZWNpYWxseSB3aGVuIHRoZSBzeXN0ZW0gaXMgaGVhdmlseSBsb2FkZWQuDQo+ID4+Pj4NCj4g
Pj4+PiBCZW5jaG1hcmtzIGluY2x1ZGluZyBoYWNrYmVuY2gsIHNjaGJlbmNoLCB1cGVyZiwgc3lz
YmVuY2ggbXlzcWwgYW5kDQo+ID4+Pj4ga2J1aWxkIGhhdmUgYmVlbiB0ZXN0ZWQgb24gYSB4ODYg
NCBzb2NrZXQgc3lzdGVtIHdpdGggMjQgY29yZXMgcGVyDQo+ID4+Pj4gc29ja2V0IGFuZCAyIGh5
cGVydGhyZWFkcyBwZXIgY29yZSwgdG90YWwgMTkyIENQVXMsIG5vIHJlZ3Jlc3Npb24NCj4gPj4+
PiBmb3VuZC4NCj4gPj4+Pg0KPiA+Pj4+IHY3LT52ODoNCj4gPj4+PiAtIHJlZmluZSB1cGRhdGVf
aWRsZV9jcHVtYXNrLCBubyBmdW5jdGlvbmFsaXR5IGNoYW5nZQ0KPiA+Pj4+IC0gZml4IGEgc3Vz
cGljaW91cyBSQ1UgdXNhZ2Ugd2FybmluZyB3aXRoIENPTkZJR19QUk9WRV9SQ1U9eQ0KPiA+Pj4+
DQo+ID4+Pj4gdjYtPnY3Og0KPiA+Pj4+IC0gcGxhY2UgdGhlIHdob2xlIGlkbGUgY3B1bWFzayBt
ZWNoYW5pc20gdW5kZXIgQ09ORklHX1NNUA0KPiA+Pj4+DQo+ID4+Pj4gdjUtPnY2Og0KPiA+Pj4+
IC0gZGVjb3VwbGUgaWRsZSBjcHVtYXNrIHVwZGF0ZSBmcm9tIHN0b3BfdGljayBzaWduYWwsIHNl
dCBpZGxlIENQVQ0KPiA+Pj4+ICAgaW4gaWRsZSBjcHVtYXNrIGV2ZXJ5IHRpbWUgdGhlIENQVSBl
bnRlcnMgaWRsZQ0KPiA+Pj4+DQo+ID4+Pj4gdjQtPnY1Og0KPiA+Pj4+IC0gYWRkIHVwZGF0ZV9p
ZGxlX2NwdW1hc2sgZm9yIHMyaWRsZSBjYXNlDQo+ID4+Pj4gLSBrZWVwIHRoZSBzYW1lIG9yZGVy
aW5nIG9mIHRpY2tfbm9oel9pZGxlX3N0b3BfdGljaygpIGFuZCB1cGRhdGVfDQo+ID4+Pj4gICBp
ZGxlX2NwdW1hc2soKSBldmVyeXdoZXJlDQo+ID4+Pj4NCj4gPj4+PiB2My0+djQ6DQo+ID4+Pj4g
LSBjaGFuZ2Ugc2V0dGluZyBpZGxlIGNwdW1hc2sgZnJvbSBldmVyeSBpZGxlIGVudHJ5IHRvIHRp
Y2tsZXNzIGlkbGUNCj4gPj4+PiAgIGlmIGNwdSBkcml2ZXIgaXMgYXZhaWxhYmxlDQo+ID4+Pj4g
LSBtb3ZlIGNsZWFyaW5nIGlkbGUgY3B1bWFzayB0byBzY2hlZHVsZXJfdGljayB0byBkZWNvdXBs
ZSBub2h6IG1vZGUNCj4gPj4+Pg0KPiA+Pj4+IHYyLT52MzoNCj4gPj4+PiAtIGNoYW5nZSBzZXR0
aW5nIGlkbGUgY3B1bWFzayB0byBldmVyeSBpZGxlIGVudHJ5LCBvdGhlcndpc2Ugc2NoYmVuY2gN
Cj4gPj4+PiAgIGhhcyBhIHJlZ3Jlc3Npb24gb2YgOTl0aCBwZXJjZW50aWxlIGxhdGVuY3kNCj4g
Pj4+PiAtIGNoYW5nZSBjbGVhcmluZyBpZGxlIGNwdW1hc2sgdG8gbm9oel9iYWxhbmNlcl9raWNr
KCksIHNvIHVwZGF0aW5nDQo+ID4+Pj4gICBpZGxlIGNwdW1hc2sgaXMgcmF0ZWxpbWl0ZWQgaW4g
dGhlIGlkbGUgZXhpdGluZyBwYXRoDQo+ID4+Pj4gLSBzZXQgU0NIRURfSURMRSBjcHUgaW4gaWRs
ZSBjcHVtYXNrIHRvIGFsbG93IGl0IGFzIGEgd2FrZXVwIHRhcmdldA0KPiA+Pj4+DQo+ID4+Pj4g
djEtPnYyOg0KPiA+Pj4+IC0gaWRsZSBjcHVtYXNrIGlzIHVwZGF0ZWQgaW4gdGhlIG5vaHogcm91
dGluZXMsIGJ5IGluaXRpYWxpemluZyBpZGxlDQo+ID4+Pj4gICBjcHVtYXNrIHdpdGggc2NoZWRf
ZG9tYWluX3NwYW4oc2QpLCBub2h6PW9mZiBjYXNlIHJlbWFpbnMgdGhlIG9yaWdpbmFsDQo+ID4+
Pj4gICBiZWhhdmlvcg0KPiA+Pj4+DQo+ID4+Pj4gQ2M6IFBldGVyIFppamxzdHJhIDxwZXRlcnpA
aW5mcmFkZWFkLm9yZz4NCj4gPj4+PiBDYzogTWVsIEdvcm1hbiA8bWdvcm1hbkBzdXNlLmRlPg0K
PiA+Pj4+IENjOiBWaW5jZW50IEd1aXR0b3QgPHZpbmNlbnQuZ3VpdHRvdEBsaW5hcm8ub3JnPg0K
PiA+Pj4+IENjOiBRYWlzIFlvdXNlZiA8cWFpcy55b3VzZWZAYXJtLmNvbT4NCj4gPj4+PiBDYzog
VmFsZW50aW4gU2NobmVpZGVyIDx2YWxlbnRpbi5zY2huZWlkZXJAYXJtLmNvbT4NCj4gPj4+PiBD
YzogSmlhbmcgQmlhbyA8YmVuYmppYW5nQGdtYWlsLmNvbT4NCj4gPj4+PiBDYzogVGltIENoZW4g
PHRpbS5jLmNoZW5AbGludXguaW50ZWwuY29tPg0KPiA+Pj4+IFNpZ25lZC1vZmYtYnk6IEF1YnJl
eSBMaSA8YXVicmV5LmxpQGxpbnV4LmludGVsLmNvbT4NCj4gPj4+DQo+ID4+PiBUaGlzIHZlcnNp
b24gbG9va3MgZ29vZCB0byBtZS4gSSBkb24ndCBzZWUgcmVncmVzc2lvbnMgb2YgdjUgYW55bW9y
ZQ0KPiA+Pj4gYW5kIHNlZSBzb21lIGltcHJvdmVtZW50cyBvbiBoZWF2eSBjYXNlcw0KPiA+Pg0K
PiA+PiB2NSBvciB2OD8NCj4gPg0KPiA+IHRoZSB2OCBsb29rcyBnb29kIHRvIG1lIGFuZCBJIGRv
bid0IHNlZSB0aGUgcmVncmVzc2lvbnMgdGhhdCBJIGhhdmUNCj4gPiBzZWVuIHdpdGggdGhlIHY1
IGFueW1vcmUNCj4gPg0KPiBTb3VuZHMgZ3JlYXQsIHRoYW5rcywgOikNCg0KDQpIaSBBdWJyZXks
DQoNClRoZSBwYXRjaCBsb29rcyBncmVhdC4gQnV0IEkgZGlkbid0IGZpbmQgYW55IGhhY2tiZW5j
aCBpbXByb3ZlbWVudA0Kb24ga3VucGVuZyA5MjAgd2hpY2ggaGFzIDI0IGNvcmVzIGZvciBlYWNo
IGxsYyBzcGFuLiBMbGMgc3BhbiBpcyBhbHNvDQpvbmUgbnVtYSBub2RlLiBUaGUgdG9wb2xvZ3kg
aXMgbGlrZToNCiMgbnVtYWN0bCAtLWhhcmR3YXJlDQphdmFpbGFibGU6IDQgbm9kZXMgKDAtMykN
Cm5vZGUgMCBjcHVzOiAwIDEgMiAzIDQgNSA2IDcgOCA5IDEwIDExIDEyIDEzIDE0IDE1IDE2IDE3
IDE4IDE5IDIwIDIxIDIyIDIzDQpub2RlIDAgc2l6ZTogMTI4NjY5IE1CDQpub2RlIDAgZnJlZTog
MTI2OTk1IE1CDQpub2RlIDEgY3B1czogMjQgMjUgMjYgMjcgMjggMjkgMzAgMzEgMzIgMzMgMzQg
MzUgMzYgMzcgMzggMzkgNDAgNDEgNDINCjQzIDQ0IDQ1IDQ2IDQ3DQpub2RlIDEgc2l6ZTogMTI4
OTk3IE1CDQpub2RlIDEgZnJlZTogMTI3NTM5IE1CDQpub2RlIDIgY3B1czogNDggNDkgNTAgNTEg
NTIgNTMgNTQgNTUgNTYgNTcgNTggNTkgNjAgNjEgNjIgNjMgNjQgNjUgNjYNCjY3IDY4IDY5IDcw
IDcxDQpub2RlIDIgc2l6ZTogMTI5MDIxIE1CDQpub2RlIDIgZnJlZTogMTI3MTA2IE1CDQpub2Rl
IDMgY3B1czogNzIgNzMgNzQgNzUgNzYgNzcgNzggNzkgODAgODEgODIgODMgODQgODUgODYgODcg
ODggODkgOTANCjkxIDkyIDkzIDk0IDk1DQpub2RlIDMgc2l6ZTogMTI3OTkzIE1CDQpub2RlIDMg
ZnJlZTogMTI2NzM5IE1CDQpub2RlIGRpc3RhbmNlczoNCm5vZGUgICAwICAgMSAgIDIgICAzDQog
IDA6ICAxMCAgMTIgIDIwICAyMg0KICAxOiAgMTIgIDEwICAyMiAgMjQNCiAgMjogIDIwICAyMiAg
MTAgIDEyDQogIDM6ICAyMiAgMjQgIDEyICAxMA0KDQpCZW5jaG1hcmsgY29tbWFuZDoNCm51bWFj
dGwgLU4gMC0xIGhhY2tiZW5jaCAtcCAtVCAtbCAyMDAwMCAtZyAkMQ0KDQpmb3IgZWFjaCBnLCBJ
IHJhbiAxMCB0aW1lcyB0byBnZXQgdGhlIGF2ZXJhZ2UgdGltZS4gQW5kIEkgdGVzdGVkDQpnIGZy
b20gMSB0byAxMC4NCg0KZyAgICAgMSAgICAgIDIgICAgICAzICAgICAgNCAgICAgIDUgICAgICA2
ICAgICAgIDcgICAgIDggICAgICAgIDkgICAgICAgMTANCncvbyAgIDEuNDczMyAxLjU5OTIgMS45
MzUzIDIuMTU2MyAyLjg0NDggMy4zMzA1IDMuOTYxNiA0LjQ4NzAgNS4wNzg2IDUuNjk4Mw0Kdy8g
ICAgMS40NzA5IDEuNjE1MiAxLjk0NzQgMi4xNTEyIDIuODI5OCAzLjI5OTggMy45NDcyIDQuNDgw
MyA1LjA0NjIgNS42NTA1DQoNCklzIGl0IGJlY2F1c2UgdGhlIGNvcmUgbnVtYmVyIGlzIHNtYWxs
IGluIGxsYyBzcGFuIGluIG15IHRlc3Q/DQoNClRoYW5rcw0KQmFycnkNCg==

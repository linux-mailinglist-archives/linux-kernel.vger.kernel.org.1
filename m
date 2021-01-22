Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E406C300204
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 12:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbhAVLwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 06:52:55 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:2962 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728338AbhAVLK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 06:10:57 -0500
Received: from DGGEMM402-HUB.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4DMc2Z3bTQz5K7x;
        Fri, 22 Jan 2021 19:08:54 +0800 (CST)
Received: from dggemi712-chm.china.huawei.com (10.3.20.111) by
 DGGEMM402-HUB.china.huawei.com (10.3.20.210) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Fri, 22 Jan 2021 19:09:51 +0800
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggemi712-chm.china.huawei.com (10.3.20.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Fri, 22 Jan 2021 19:09:50 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2106.002;
 Fri, 22 Jan 2021 19:09:50 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Meelis Roos <mroos@linux.ee>,
        LKML <linux-kernel@vger.kernel.org>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Mel Gorman <mgorman@suse.de>
Subject: RE: 5.11-rc4+git: Shortest NUMA path spans too many nodes
Thread-Topic: 5.11-rc4+git: Shortest NUMA path spans too many nodes
Thread-Index: AQHW7/0Khvz6gXM0E0axUubrsRfQgaoxp6MAgAAq5QCAAAveAIAACPeAgACrV8CAAFNVAIAAlTyg
Date:   Fri, 22 Jan 2021 11:09:50 +0000
Message-ID: <9d6c6d3ba6ac4272bf844034da4653fe@hisilicon.com>
References: <3ec17983-7959-eccd-af25-400056a5877d@linux.ee>
 <jhjmtx22uv7.mognet@arm.com> <8797fd78-4367-bc5c-3a35-43c544c745e4@linux.ee>
 <jhjh7na2lsj.mognet@arm.com> <f0818204-66d1-bf01-062e-0aeec9ce806d@arm.com>
 <353d255769b6463c862993e2329a9a8d@hisilicon.com>
 <99ecee86-8d96-c1e2-5b38-8f3dfcc38bd1@arm.com>
In-Reply-To: <99ecee86-8d96-c1e2-5b38-8f3dfcc38bd1@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.200.219]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGlldG1hciBFZ2dlbWFu
biBbbWFpbHRvOmRpZXRtYXIuZWdnZW1hbm5AYXJtLmNvbV0NCj4gU2VudDogRnJpZGF5LCBKYW51
YXJ5IDIyLCAyMDIxIDExOjA1IFBNDQo+IFRvOiBTb25nIEJhbyBIdWEgKEJhcnJ5IFNvbmcpIDxz
b25nLmJhby5odWFAaGlzaWxpY29uLmNvbT47IFZhbGVudGluIFNjaG5laWRlcg0KPiA8dmFsZW50
aW4uc2NobmVpZGVyQGFybS5jb20+OyBNZWVsaXMgUm9vcyA8bXJvb3NAbGludXguZWU+OyBMS01M
DQo+IDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPg0KPiBDYzogUGV0ZXIgWmlqbHN0cmEg
PHBldGVyekBpbmZyYWRlYWQub3JnPjsgVmluY2VudCBHdWl0dG90DQo+IDx2aW5jZW50Lmd1aXR0
b3RAbGluYXJvLm9yZz47IE1lbCBHb3JtYW4gPG1nb3JtYW5Ac3VzZS5kZT4NCj4gU3ViamVjdDog
UmU6IDUuMTEtcmM0K2dpdDogU2hvcnRlc3QgTlVNQSBwYXRoIHNwYW5zIHRvbyBtYW55IG5vZGVz
DQo+IA0KPiBPbiAyMS8wMS8yMDIxIDIyOjE3LCBTb25nIEJhbyBIdWEgKEJhcnJ5IFNvbmcpIHdy
b3RlOg0KPiA+DQo+ID4NCj4gPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4gRnJv
bTogRGlldG1hciBFZ2dlbWFubiBbbWFpbHRvOmRpZXRtYXIuZWdnZW1hbm5AYXJtLmNvbV0NCj4g
Pj4gU2VudDogRnJpZGF5LCBKYW51YXJ5IDIyLCAyMDIxIDc6NTQgQU0NCj4gPj4gVG86IFZhbGVu
dGluIFNjaG5laWRlciA8dmFsZW50aW4uc2NobmVpZGVyQGFybS5jb20+OyBNZWVsaXMgUm9vcw0K
PiA+PiA8bXJvb3NAbGludXguZWU+OyBMS01MIDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3Jn
Pg0KPiA+PiBDYzogUGV0ZXIgWmlqbHN0cmEgPHBldGVyekBpbmZyYWRlYWQub3JnPjsgVmluY2Vu
dCBHdWl0dG90DQo+ID4+IDx2aW5jZW50Lmd1aXR0b3RAbGluYXJvLm9yZz47IFNvbmcgQmFvIEh1
YSAoQmFycnkgU29uZykNCj4gPj4gPHNvbmcuYmFvLmh1YUBoaXNpbGljb24uY29tPjsgTWVsIEdv
cm1hbiA8bWdvcm1hbkBzdXNlLmRlPg0KPiA+PiBTdWJqZWN0OiBSZTogNS4xMS1yYzQrZ2l0OiBT
aG9ydGVzdCBOVU1BIHBhdGggc3BhbnMgdG9vIG1hbnkgbm9kZXMNCj4gPj4NCj4gPj4gT24gMjEv
MDEvMjAyMSAxOToyMSwgVmFsZW50aW4gU2NobmVpZGVyIHdyb3RlOg0KPiA+Pj4gT24gMjEvMDEv
MjEgMTk6MzksIE1lZWxpcyBSb29zIHdyb3RlOg0KPiANCj4gWy4uLl0NCj4gDQo+ID4+ICMgY2F0
IC9zeXMvZGV2aWNlcy9zeXN0ZW0vbm9kZS9ub2RlKi9kaXN0YW5jZQ0KPiA+PiAxMCAxMiAxMiAx
NCAxNCAxNCAxNCAxNg0KPiA+PiAxMiAxMCAxNCAxMiAxNCAxNCAxMiAxNA0KPiA+PiAxMiAxNCAx
MCAxNCAxMiAxMiAxNCAxNA0KPiA+PiAxNCAxMiAxNCAxMCAxMiAxMiAxNCAxNA0KPiA+PiAxNCAx
NCAxMiAxMiAxMCAxNCAxMiAxNA0KPiA+PiAxNCAxNCAxMiAxMiAxNCAxMCAxNCAxMg0KPiA+PiAx
NCAxMiAxNCAxNCAxMiAxNCAxMCAxMg0KPiA+PiAxNiAxNCAxNCAxNCAxNCAxMiAxMiAxMA0KPiA+
Pg0KPiA+PiBUaGUgJzE2JyBzZWVtcyB0byBiZSB0aGUgY3VscHJpdC4gSG93IGRvZXMgc3VjaCBh
IHRvcG8gbG9vayBsaWtlPw0KPiANCj4gTWF5YmUgbGlrZSB0aGlzOg0KPiANCj4gICAgICAgX19f
X19fX19fDQo+ICAgICAgIHwgICAgICAgfA0KPiAgICAgLi02ICAgMCAgIDQtLg0KPiAgICAgfCAg
XCAvIFwgLyAgfA0KPiAgICAgfCAgIDEgICAyICAgfA0KPiAgICAgfCAgIFwgICAgXCAgfA0KPiAg
ICAgLS03ICAzLS0tLTUgfA0KPiAgICAgICB8ICB8X19fX3xffA0KPiAgICAgICB8X19fX19fX3wN
Cj4gDQo+ID4NCj4gPiBPbmNlIHdlIGdldCBhIHRvcG9sb2d5IGxpa2UgdGhpczoNCj4gPg0KPiA+
DQo+ID4gICAgICAgICAgKy0tLS0tLSsgICAgICAgICArLS0tLS0tKyAgICAgICAgKy0tLS0tLS0r
ICAgICAgICstLS0tLS0rDQo+ID4gICAgICAgICAgfCBub2RlIHwgICAgICAgICB8bm9kZSAgfCAg
ICAgICAgfCBub2RlICB8ICAgICAgIHxub2RlICB8DQo+ID4gICAgICAgICAgfCAgICAgICstLS0t
LS0tLS0rICAgICAgKy0tLS0tLS0tKyAgICAgICArLS0tLS0tLSsgICAgICB8DQo+ID4gICAgICAg
ICAgKy0tLS0tLSsgICAgICAgICArLS0tLS0tKyAgICAgICAgKy0tLS0tLS0rICAgICAgICstLS0t
LS0rDQo+ID4NCj4gPiBXZSBjYW4gcmVwcm9kdWNlIHRoaXMgaXNzdWUuDQo+ID4gRm9yIGV4YW1w
bGUsIGV2ZXJ5IGNwdSB3aXRoIHRoZSBiZWxvdyBudW1hX2Rpc3RhbmNlIGNhbiBoYXZlDQo+ID4g
Imdyb3VwcyBkb24ndCBzcGFuIGRvbWFpbi0+c3BhbiI6DQo+ID4gbm9kZSAgIDAgICAxICAgMiAg
IDMNCj4gPiAgIDA6ICAxMCAgMTIgIDIwICAyMg0KPiA+ICAgMTogIDEyICAxMCAgMjIgIDI0DQo+
ID4gICAyOiAgMjAgIDIyICAxMCAgMTINCj4gPiAgIDM6ICAyMiAgMjQgIDEyICAxMA0KPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIDIgICAgIDIwICAgICAyDQo+IFNvIHRoaXMgc2hvdWxk
IGxvb2sgbGlrZTogMSAtLS0gMCAtLS0tIDIgLS0tIDMNCg0KWWVzLiBTbyBoZXJlIHdlIGFyZSBm
YWNpbmcgYW5vdGhlciBwcm9ibGVtOg0Ka2VybmVsL3NjaGVkL3RvcG9sb2d5LmMgaGFzIGFuIGFz
c3VtcHRpb24gdGhhdDoNCm5vZGVfZGlzdGFuY2UoMCxqKSBpbmNsdWRlcyBhbGwgZGlzdGFuY2Vz
IGluIA0Kbm9kZV9kaXN0YW5jZShpLGopLg0KDQp2b2lkIHNjaGVkX2luaXRfbnVtYSh2b2lkKQ0K
ew0KCS4uLg0KCSAqDQoJICogQXNzdW1lcyBub2RlX2Rpc3RhbmNlKDAsaikgaW5jbHVkZXMgYWxs
IGRpc3RhbmNlcyBpbg0KCSAqIG5vZGVfZGlzdGFuY2UoaSxqKSBpbiBvcmRlciB0byBhdm9pZCBj
dWJpYyB0aW1lLg0KCSAqLw0KCW5leHRfZGlzdGFuY2UgPSBjdXJyX2Rpc3RhbmNlOw0KCWZvciAo
aSA9IDA7IGkgPCBucl9ub2RlX2lkczsgaSsrKSB7DQoJCWZvciAoaiA9IDA7IGogPCBucl9ub2Rl
X2lkczsgaisrKSB7DQoJCQlmb3IgKGsgPSAwOyBrIDwgbnJfbm9kZV9pZHM7IGsrKykNCn0NCg0K
YnV0IG9idmlvdXNseSB3ZSBhcmUgbm90IHRoaXMgY2FzZS4gUmlnaHQgbm93LCB3ZSBhcmUgZ2V0
dGluZw0Kc29tZSBwZXJmb3JtYW5jZSBkZWNyZWFzZSBkdWUgdG8gdGhpcywgcHJvYmFibHkgSSds
bCBzdGFydCBhbm90aGVyDQp0aHJlYWQgZm9yIGl0Lg0KDQpUaGFua3MNCkJhcnJ5DQoNCg==

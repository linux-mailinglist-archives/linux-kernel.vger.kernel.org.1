Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3301F2E0169
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 21:07:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbgLUUGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 15:06:22 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:2404 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbgLUUGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 15:06:22 -0500
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4D09Rd3nj3z54gr;
        Tue, 22 Dec 2020 04:04:45 +0800 (CST)
Received: from dggemi759-chm.china.huawei.com (10.1.198.145) by
 DGGEMM403-HUB.china.huawei.com (10.3.20.211) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Tue, 22 Dec 2020 04:05:38 +0800
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggemi759-chm.china.huawei.com (10.1.198.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Tue, 22 Dec 2020 04:05:39 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2106.002;
 Tue, 22 Dec 2020 04:05:39 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Shakeel Butt <shakeelb@google.com>,
        Vitaly Wool <vitaly.wool@konsulko.com>
CC:     Minchan Kim <minchan@kernel.org>, Mike Galbraith <efault@gmx.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>,
        NitinGupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: RE: [PATCH] zsmalloc: do not use bit_spin_lock
Thread-Topic: [PATCH] zsmalloc: do not use bit_spin_lock
Thread-Index: AQHW1mZAeBjE5clI7UKUuMSOCQsyuqoBSTyAgAAghwCAAAhXgIAAhndA
Date:   Mon, 21 Dec 2020 20:05:39 +0000
Message-ID: <e5cd8a0a5df84081a11359ede6e746bc@hisilicon.com>
References: <18669bd607ae9efbf4e00e36532c7aa167d0fa12.camel@gmx.de>
 <20201220002228.38697-1-vitaly.wool@konsulko.com>
 <X+DaMSJE22nUC0tl@google.com>
 <CAM4kBBKnW6K-mbPno4SpvhUBiykP4zeFm_CNzssDkReURbuU7w@mail.gmail.com>
 <CALvZod69OtXkdOJPzuY5XfXz_ro0V7OmqW4OY9B_emqwroxW4w@mail.gmail.com>
In-Reply-To: <CALvZod69OtXkdOJPzuY5XfXz_ro0V7OmqW4OY9B_emqwroxW4w@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.200.103]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2hha2VlbCBCdXR0IFtt
YWlsdG86c2hha2VlbGJAZ29vZ2xlLmNvbV0NCj4gU2VudDogVHVlc2RheSwgRGVjZW1iZXIgMjIs
IDIwMjAgODo1MCBBTQ0KPiBUbzogVml0YWx5IFdvb2wgPHZpdGFseS53b29sQGtvbnN1bGtvLmNv
bT4NCj4gQ2M6IE1pbmNoYW4gS2ltIDxtaW5jaGFuQGtlcm5lbC5vcmc+OyBNaWtlIEdhbGJyYWl0
aCA8ZWZhdWx0QGdteC5kZT47IExLTUwNCj4gPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+
OyBsaW51eC1tbSA8bGludXgtbW1Aa3ZhY2sub3JnPjsgU29uZyBCYW8gSHVhDQo+IChCYXJyeSBT
b25nKSA8c29uZy5iYW8uaHVhQGhpc2lsaWNvbi5jb20+OyBTZWJhc3RpYW4gQW5kcnplaiBTaWV3
aW9yDQo+IDxiaWdlYXN5QGxpbnV0cm9uaXguZGU+OyBOaXRpbkd1cHRhIDxuZ3VwdGFAdmZsYXJl
Lm9yZz47IFNlcmdleSBTZW5vemhhdHNreQ0KPiA8c2VyZ2V5LnNlbm96aGF0c2t5LndvcmtAZ21h
aWwuY29tPjsgQW5kcmV3IE1vcnRvbg0KPiA8YWtwbUBsaW51eC1mb3VuZGF0aW9uLm9yZz4NCj4g
U3ViamVjdDogUmU6IFtQQVRDSF0genNtYWxsb2M6IGRvIG5vdCB1c2UgYml0X3NwaW5fbG9jaw0K
PiANCj4gT24gTW9uLCBEZWMgMjEsIDIwMjAgYXQgMTE6MjAgQU0gVml0YWx5IFdvb2wgPHZpdGFs
eS53b29sQGtvbnN1bGtvLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBPbiBNb24sIERlYyAyMSwgMjAy
MCBhdCA2OjI0IFBNIE1pbmNoYW4gS2ltIDxtaW5jaGFuQGtlcm5lbC5vcmc+IHdyb3RlOg0KPiA+
ID4NCj4gPiA+IE9uIFN1biwgRGVjIDIwLCAyMDIwIGF0IDAyOjIyOjI4QU0gKzAyMDAsIFZpdGFs
eSBXb29sIHdyb3RlOg0KPiA+ID4gPiB6c21hbGxvYyB0YWtlcyBiaXQgc3BpbmxvY2sgaW4gaXRz
IF9tYXAoKSBjYWxsYmFjayBhbmQgcmVsZWFzZXMgaXQNCj4gPiA+ID4gb25seSBpbiB1bm1hcCgp
IHdoaWNoIGlzIHVuc2FmZSBhbmQgbGVhZHMgdG8genN3YXAgY29tcGxhaW5pbmcNCj4gPiA+ID4g
YWJvdXQgc2NoZWR1bGluZyBpbiBhdG9taWMgY29udGV4dC4NCj4gPiA+ID4NCj4gPiA+ID4gVG8g
Zml4IHRoYXQgYW5kIHRvIGltcHJvdmUgUlQgcHJvcGVydGllcyBvZiB6c21hbGxvYywgcmVtb3Zl
IHRoYXQNCj4gPiA+ID4gYml0IHNwaW5sb2NrIGNvbXBsZXRlbHkgYW5kIHVzZSBhIGJpdCBmbGFn
IGluc3RlYWQuDQo+ID4gPg0KPiA+ID4gSSBkb24ndCB3YW50IHRvIHVzZSBzdWNoIG9wZW4gY29k
ZSBmb3IgdGhlIGxvY2suDQo+ID4gPg0KPiA+ID4gSSBzZWUgZnJvbSBNaWtlJ3MgcGF0Y2gsIHJl
Y2VudCB6c3dhcCBjaGFuZ2UgaW50cm9kdWNlZCB0aGUgbG9ja2RlcA0KPiA+ID4gc3BsYXQgYnVn
IGFuZCB5b3Ugd2FudCB0byBpbXByb3ZlIHpzbWFsbG9jIHRvIGZpeCB0aGUgenN3YXAgYnVnIGFu
ZA0KPiA+ID4gaW50cm9kdWNlIHRoaXMgcGF0Y2ggd2l0aCBhbGxvd2luZyBwcmVlbXB0aW9uIGVu
YWJsaW5nLg0KPiA+DQo+ID4gVGhpcyB1bmRlcnN0YW5kaW5nIGlzIHVwc2lkZSBkb3duLiBUaGUg
Y29kZSBpbiB6c3dhcCB5b3UgYXJlIHJlZmVycmluZw0KPiA+IHRvIGlzIG5vdCBidWdneS4gIFlv
dSBtYXkgY2xhaW0gdGhhdCBpdCBpcyBzdWJvcHRpbWFsIGJ1dCB0aGVyZSBpcw0KPiA+IG5vdGhp
bmcgd3JvbmcgaW4gdGFraW5nIGEgbXV0ZXguDQo+ID4NCj4gDQo+IElzIHRoaXMgc3Vib3B0aW1h
bCBmb3IgYWxsIG9yIGp1c3QgdGhlIGhhcmR3YXJlIGFjY2VsZXJhdG9ycz8gU29ycnksIEkNCj4g
YW0gbm90IHZlcnkgZmFtaWxpYXIgd2l0aCB0aGUgY3J5cHRvIEFQSS4gSWYgSSBzZWxlY3QgbHpv
IG9yIGx6NCBhcyBhDQo+IHpzd2FwIGNvbXByZXNzb3Igd2lsbCB0aGUgW2RlXWNvbXByZXNzaW9u
IGJlIGFzeW5jIG9yIHN5bmM/DQoNClJpZ2h0IG5vdywgaW4gY3J5cHRvIHN1YnN5c3RlbSwgbmV3
IGRyaXZlcnMgYXJlIHJlcXVpcmVkIHRvIHdyaXRlIGJhc2VkIG9uDQphc3luYyBBUElzLiBUaGUg
b2xkIHN5bmMgQVBJIGNhbid0IHdvcmsgaW4gbmV3IGFjY2VsZXJhdG9yIGRyaXZlcnMgYXMgdGhl
eQ0KYXJlIG5vdCBzdXBwb3J0ZWQgYXQgYWxsLg0KDQpPbGQgZHJpdmVycyBhcmUgdXNlZCB0byBz
eW5jLCBidXQgdGhleSd2ZSBnb3QgYXN5bmMgd3JhcHBlcnMgdG8gc3VwcG9ydCBhc3luYw0KQVBJ
cy4gRWcuDQpjcnlwdG86IGFjb21wIC0gYWRkIHN1cHBvcnQgZm9yIGx6NCB2aWEgc2NvbXANCmh0
dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xp
bnV4LmdpdC9jb21taXQvY3J5cHRvL2x6NC5jP2lkPThjZDkzMzBlMGE2MTVjOTMxMDM3ZDRkZWY5
OGI1Y2UwZDU0MGYwOGQNCg0KY3J5cHRvOiBhY29tcCAtIGFkZCBzdXBwb3J0IGZvciBsem8gdmlh
IHNjb21wDQpodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90
b3J2YWxkcy9saW51eC5naXQvY29tbWl0L2NyeXB0by9sem8uYz9pZD1hYzlkMmM0YjM5ZTAyMmQy
YzYxNDg2YmZjMzNiNzMwY2ZkMDI4OThlDQoNCnNvIHRoZXkgYXJlIHN1cHBvcnRpbmcgYXN5bmMg
QVBJcyBidXQgdGhleSBhcmUgc3RpbGwgd29ya2luZyBpbiBzeW5jIG1vZGUgYXMNCnRob3NlIG9s
ZCBkcml2ZXJzIGRvbid0IHNsZWVwLg0KDQo+IA0KPiA+ID4NCj4gaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvbGludXgtbW0vZmFlODVlNDQ0MGE4ZWY2ZjEzMTkyNDc2YmQzM2E0ODI2NDE2ZmM1OC4N
Cj4gY2FtZWxAZ214LmRlLw0KPiA+ID4NCj4gPiA+IHpzX1t1bi9tYXBdX29iamVjdCBpcyBkZXNp
Z25lZCB0byBiZSB1c2VkIGluIGZhc3QgcGF0aChpLmUuLA0KPiA+ID4genNfbWFwX29iamVjdC80
SyBwYWdlIGNvcHkvenNfdW5tYXBfb2JqZWN0KSBzbyB0aGUgc3BpbmxvY2sgaXMNCj4gPiA+IHBl
cmZlY3RseSBmaW5lIGZvciBBUEkgcG9pbnQgb2Ygdmlldy4gSG93ZXZlciwgenN3YXAgaW50cm9k
dWNlZA0KPiA+ID4gdXNpbmcgdGhlIEFQSSB3aXRoIG11dGV4X2xvY2svY3J5cHRvX3dhaXRfcmVx
IHdoZXJlIGFsbG93aW5nDQo+ID4gPiBwcmVlbXB0aW9uLCB3aGljaCB3YXMgd3JvbmcuDQo+ID4N
Cj4gPiBUYWtpbmcgYSBzcGlubG9jayBpbiBvbmUgY2FsbGJhY2sgYW5kIHJlbGVhc2luZyBpdCBp
biBhbm90aGVyIGlzDQo+ID4gdW5zYWZlIGFuZCBlcnJvciBwcm9uZS4gV2hhdCBpZiB1bm1hcCB3
YXMgY2FsbGVkIG9uIGNvbXBsZXRpb24gb2YgYQ0KPiA+IERNQS1saWtlIHRyYW5zZmVyIGZyb20g
YW5vdGhlciBjb250ZXh0LCBsaWtlIGEgdGhyZWFkZWQgSVJRIGhhbmRsZXI/DQo+ID4gSW4gdGhh
dCBjYXNlIHRoaXMgc3BpbmxvY2sgbWlnaHQgbmV2ZXIgYmUgcmVsZWFzZWQuDQo+ID4NCj4gPiBB
bnl3YXkgSSBjYW4gY29tZSB1cCB3aXRoIGEgenN3YXAgcGF0Y2ggZXhwbGljaXRseSBzdGF0aW5n
IHRoYXQNCj4gPiB6c21hbGxvYyBpcyBub3QgZnVsbHkgY29tcGxpYW50IHdpdGggenN3YXAgLyB6
cG9vbCBBUEkNCj4gDQo+IFRoZSBkb2N1bWVudGF0aW9uIG9mIHpwb29sX21hcF9oYW5kbGUoKSBj
bGVhcmx5IHN0YXRlcyAiVGhpcyBtYXkgaG9sZA0KPiBsb2NrcywgZGlzYWJsZSBpbnRlcnJ1cHRz
LCBhbmQvb3IgcHJlZW1wdGlvbiwgLi4uIiwgc28gaG93IGNvbWUNCj4genNtYWxsb2MgaXMgbm90
IGZ1bGx5IGNvbXBsaWFudD8NCg0KWmJ1ZCwgejNmb2xkIGhhdmVuJ3QgcmVhbGx5IGRvbmUgdGhp
cy4gSWYgd2UgaG9sZCBzcGlubG9jayBiZWZvcmUNCmVudGVyaW5nIHpzd2FwIGFuZCByZWxlYXNl
IHNwaW5sb2NrIGFmdGVyIGNhbGxpbmcgenN3YXAsIHRoaXMgd2lsbA0KcHV0IHpzd2FwIGluIGFu
IGF0b21pYyBjb250ZXh0IHdoaWNoIGlzbid0IG5lY2Vzc2FyaWx5IG5lZWRlZC4NCg0KPiANCj4g
PiB0byBhdm9pZA0KPiA+IGNvbmZ1c2lvbiBmb3IgdGhlIHRpbWUgYmVpbmcuIFdvdWxkIHRoYXQg
YmUgb2sgd2l0aCB5b3U/DQo+ID4NCj4gPiBCZXN0IHJlZ2FyZHMsDQo+ID4gICAgVml0YWx5DQo+
ID4NCg0KVGhhbmtzDQpCYXJyeQ0KDQo=

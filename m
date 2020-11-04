Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 464532A5EC3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 08:31:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729032AbgKDHa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 02:30:58 -0500
Received: from regular1.263xmail.com ([211.150.70.201]:40726 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726259AbgKDHa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 02:30:57 -0500
Received: from localhost (unknown [192.168.167.69])
        by regular1.263xmail.com (Postfix) with ESMTP id 7AFB6963;
        Wed,  4 Nov 2020 15:30:34 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from hp1216 (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P1240T139713990088448S1604475032549643_;
        Wed, 04 Nov 2020 15:30:33 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <aefef2fffce3b783601dee267a1d00f5>
X-RL-SENDER: zyf@rock-chips.com
X-SENDER: zyf@rock-chips.com
X-LOGIN-NAME: zyf@rock-chips.com
X-FST-TO: jbx6244@gmail.com
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
X-System-Flag: 0
Date:   Wed, 4 Nov 2020 15:30:32 +0800
Organization: =?utf-8?B?55Ge6Iqv5b6u55S15a2Q?=
From:   =?utf-8?B?6LW15Luq5bOw?= <yifeng.zhao@rock-chips.com>
To:     "Johan Jonker" <jbx6244@gmail.com>,
        "Miquel Raynal" <miquel.raynal@bootlin.com>
Cc:     richard <richard@nod.at>, vigneshr <vigneshr@ti.com>,
        robh+dt <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        =?utf-8?B?SGVpa29TdMO8Ym5lcg==?= <heiko@sntech.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-rockchip <linux-rockchip@lists.infradead.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: Re: [PATCH v13 2/8] mtd: rawnand: rockchip: NFC drivers for RK3308, RK2928 and others
References: <20201028095326.15562-1-yifeng.zhao@rock-chips.com>, 
        <20201028095326.15562-3-yifeng.zhao@rock-chips.com>, 
        <a8a7875b-f08b-62c6-a630-245687e0df3b@gmail.com>, 
        <e02e13a0-769d-6b73-c87e-5b7d75fd4254@rock-chips.com>, 
        <0b417fc2-3503-9bf6-914d-0f8b38df1914@gmail.com>, 
        <20201102140725.66e7dcb1@xps13>, 
        <5ad70fa0-05a9-e1e7-32cc-32933ff25ae9@gmail.com>, 
        <803e291f-67e0-f66c-6c9e-041db1b3847c@gmail.com>, 
        <20201102180039.757d3234@xps13>, 
        <cd349a1f-773d-096a-f0ae-90c5eb847769@gmail.com>
X-Priority: 3
X-Has-Attach: no
X-Mailer: Foxmail 7.2.18.111[cn]
Mime-Version: 1.0
Message-ID: <20201104152931632919186@rock-chips.com>
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAyMC8xMS8zIDE6MTEsIEpvaGFuIEpvbmtlciB3cm90ZToKPk9uIDExLzIvMjAgNjowMCBQ
TSwgTWlxdWVsIFJheW5hbCB3cm90ZToKPj4gSGkgSm9oYW4sCj4+Cj4+IEpvaGFuIEpvbmtlciA8
amJ4NjI0NEBnbWFpbC5jb20+IHdyb3RlIG9uIE1vbiwgMiBOb3YgMjAyMCAxNzozMToxOAo+PiAr
MDEwMDoKPj4KPj4+IE9uIDExLzIvMjAgMjoxMSBQTSwgSm9oYW4gSm9ua2VyIHdyb3RlOgo+Pj4+
IEhpLAo+Pj4+Cj4+Pj4gT24gMTEvMi8yMCAyOjA3IFBNLCBNaXF1ZWwgUmF5bmFsIHdyb3RlOgo+
Pj4+PiBIaSBKb2hhbiwgWWlmZW5nCj4+Pj4+Cj4+Pj4+IEpvaGFuIEpvbmtlciA8amJ4NjI0NEBn
bWFpbC5jb20+IHdyb3RlIG9uIE1vbiwgMiBOb3YgMjAyMCAxMzo1Nzo1Ngo+Pj4+PiArMDEwMDoK
Pj4+Pj4KPj4+Pj4+IEhpIFlpZmVuZywKPj4+Pj4+Cj4+Pj4+PiBEb24ndCBwb2tlIHdpdGggImVj
Yy0+Ynl0ZXMiIG9uZXMgaXQgaXMgc2V0IGluIHJrX25mY19lY2NfaW5pdCgpLiBJdAo+Pj4+Pj4g
d2lsbCBub3QgYmUgbm90ZWQgYnkgdGhlIE1URCBmcmFtZSB3b3JrIG9yIHVzZXJzcGFjZS4gSSB0
aGluayB0aGVyZSdzCj4+Pj4+PiBjdXJyZW50bHkgbm8gd2F5IHRvIGxldCB0aGUgdXNlciBrbm93
IHRoYXQgYSBkaWZmZXJlbnQgRUNDIG11c3QgYmUgdXNlZC4KPj4+Pj4+IE5laXRoZXIgY2FuIHRo
ZSB1c2VyIHNldCBFQ0Mgb24gdGhlIGZseS4KPj4+Pj4+Cj4+Pj4+PiBFeGFtcGxlIFIvVyBmbG93
Ogo+Pj4+Pj4KPj4+Pj4+wqDCoMKgwqDCoMKgwqDCoCBuYW5kX3NlbGVjdF90YXJnZXQoKQo+Pj4+
Pj4gY2hpcC0+ZWNjLndyaXRlX3BhZ2VfcmF3KCkKPj4+Pj4+IGNoaXAtPmVjYy53cml0ZV9wYWdl
KCkKPj4+Pj4+Cj4+Pj4+PiBbLi5dCj4+Pj4+Pgo+Pj4+Pj4gY2hpcC0+ZWNjLnJlYWRfcGFnZV9y
YXcoKQo+Pj4+Pj4gY2hpcC0+ZWNjLnJlYWRfcGFnZSgpCj4+Pj4+PsKgwqDCoMKgwqDCoMKgwqAg
bmFuZF9kZXNlbGVjdF90YXJnZXQoKQo+Pj4+Pj4KPj4+Pj4+IEEgd3JpdGUvcmVhZCB3aXRoOgo+
Pj4+Pj4KPj4+Pj4+IHJrX25mY19yZWFkX3BhZ2VfaHdlY2MoKQo+Pj4+Pj4gcmtfbmZjX3dyaXRl
X3BhZ2VfaHdlY2MoKQo+Pj4+Pj4KPj4+Pj4+IG9yCj4+Pj4+Pgo+Pj4+Pj4gcmtfbmZjX3JlYWRf
cGFnZV9yYXcoKQo+Pj4+Pj4gcmtfbmZjX3dyaXRlX3BhZ2VfcmF3KCkKPj4+Pj4+Cj4+Pj4+PiBt
dXN0IGVuZCB1cCB3aXRoIHRoZSBzYW1lIHJlc3VsdC4gSWYgd2UgY2FuJ3QgYXJjaGl2ZSB0aGF0
LCB0aGVuIHdlCj4+Pj4+PiBzaG91bGRuJ3Qgb2ZmZXIgUkFXIG1vZGUgdG8gdGhlIHVzZXIgZm9y
IG5vdy4gSWYgTWlxdWVsIGFncmVlcyB5b3UKPj4+Pj4+IHNob3VsZCBqdXN0IGdldCB0aGUgZHJp
dmVyIHJlYWR5IG5vdyB3aXRob3V0IHRoZXNlIDIgZnVuY3Rpb25zIGFuZCByb3VuZAo+Pj4+Pj4g
dGhpbmdzIHVwLgo+Pj4+Pgo+Pj4+PiBXaGF0IGFib3V0IGp1c3Qgbm90IHN1cHBvcnRpbmcgdGhl
IEJvb3RST00gYXJlYSBpZiBpdCB3YXMgbWFya2VkCj4+Pj4+ICJyZXNlcnZlZCIgYnkgdGhlIEJS
b20gaW4gdGhlIERUPwo+Pj4+Cj4+Pj4gU2hvdWxkIHdlIGp1c3QgZmlsbCB0aGUgYnVmZmVycyB3
aXRoICcweGZmJyBmb3IgYm9vdCBibG9ja3M/Cj4+Pgo+Pj4gKHBhcnQgMikgOykKPj4+IE15IGZh
dWx0Li4uLgo+Pj4gQmV0dGVyIHVzZToKPj4+Cj4+PsKgwqDCoMKgIGlmICgoY2hpcC0+b3B0aW9u
cyAmIE5BTkRfSVNfQk9PVF9NRURJVU0pICYmCj4+PsKgwqDCoMKgwqDCoMKgwqAgKHBhZ2UgPCAo
cGFnZXNfcGVyX2JsayAqIHJrbmFuZC0+Ym9vdF9ibGtzKSkpIHsKPj4+Cj4+PiByZXR1cm4gLUVJ
TzsKPj4+Cj4+PsKgwqDCoMKgIH0KPj4KPj4gWXVwLCBJIHdhcyBhYm91dCB0byB0ZWxsIHlvdSB0
aGF0IEkgd291bGQgcHJlZmVyIHJldHVybmluZyBhIG5pY2UKPj4gZXJyb3IsIHRoaXMgaXMgZmlu
ZSBJIGd1ZXNzLgo+Pgo+PiBBbnl3YXksIEkgdGhpbmsgcmVhZGluZyBiYWQgYmxvY2sgbWFya2Vy
cyBpcyBkb25lIGluIHJhdyBtb2RlLCBzbyBpZgo+PiByYXcgYWNjZXNzb3JzIHJlZnVzZSB0byBy
ZXR1cm4gdmFsaWQgdmFsdWVzIGZvciBib290IGJsb2NrcywgeW91IHdvbid0Cj4+IGJlIGFibGUg
dG8gYWNjZXNzIGl0IG5laXRoZXIgd2l0aCByYXcgbm9yIGNvcnJlY3RlZCBob29rcy4KPj4KPj4g
UGVyaGFwcyByZWZ1c2luZyB0aGUgYWNjZXNzIHRvIHRoZSByZWd1bGFyIHBhZ2UgYWNjZXNzIGlz
IG9rLCBidXQgbWF5YmUKPj4gd2Ugc2hvdWxkIGJlIGFibGUgdG8gYXQgbGVhc3QgcmVhZCB0aGVz
ZSBwYWdlcyBpbiByYXcgbW9kZQo+PiAoYW5kIG1vdmUgdGhlIEJCTSB0byBpdHMgcmlnaHQgbG9j
YXRpb24pLiBXaGF0IGRvIHlvdSB0aGluaz8KPgo+SSB0aGluayB0aGF0IHRoZSBwcm9ibGVtIHdp
dGggYXN5bW1ldHJpYyByZWFkIGFuZCB3cml0ZSBhY2Nlc3MgaXMgdGhhdCBhCj51c2VyIHJlYWRz
IGRhdGEgc3VjY2Vzc2Z1bCwgYnV0IHRoYXQgaXQgY2FuJ3Qgd3JpdGUgaXQgYmFjayBhZnRlciBp
dCdzCj5ibG9jayBpcyBlcmFzZWQuIFlvdSBzaG91bGRuJ3QgZ2l2ZSB0aGUgaWxsdXNpb24gdGhh
dCB0aGUgYm9vdCBST00KPmJsb2NrcyBjYW4gYmUgYWNjZXNzZWQgaW4gUkFXIG1vZGUuIFNvbWV0
aGluZyB3aXRoIHBlcmNlcHRpb24uLi5kb2VzCj51c2VyIHNwYWNlIGtub3duIHRoYXQgUm9ja2No
aXAncyBORkMgaXMgc3BlY2lhbC4uLgo+Cj4gCgpJcyBpdCBwb3NzaWJsZSB0byByZXR1cm4gYSBl
cnJvciB3aGVuIHRoZSBFQ0MgaXMgZGlmZmVyZW50IGJldHdlZW4gdGhlIGJvb3QgUk9NIGJsb2Nr
cyBhbmQgb3RoZXIgYmxvY2tzPwpJZiB0aGUgRUNDIGlzIHRoZSBzYW1lLCBhbmQgdGhlIE9PQiBs
YXlvdXQgaXMgdGhlIHNhbWUgYW5kIGRvZXMgbm90IG5lZWQgc3BlY2lhbCB0cmVhdG1lbnQuCgpz
dGF0aWMgaW50IHJrX25mY19yZWFkX3BhZ2VfcmF3KHN0cnVjdCBuYW5kX2NoaXAgKmNoaXAsIHU4
ICpidWYsIGludCBvb2Jfb24saW50IHBhZ2UpCnsKLi4uCsKgaWYgKChjaGlwLT5vcHRpb25zICYg
TkFORF9JU19CT09UX01FRElVTSkgJiYKwqAgwqAgwqAgwqAgKHBhZ2UgPCAocGFnZXNfcGVyX2Js
ayAqIHJrbmFuZC0+Ym9vdF9ibGtzKSkgJiYKCShya25hbmQtPmJvb3RfZWNjICE9IGVjYy0+c3Ry
ZW5ndGgpKSB7CgkJcmV0dXJuIC1FSU87CsKgIMKgIH0KLi4uCn0KCkFib3V0IHRoZSBCQk0sIHRo
ZSB1LWJvb3Qgd2lsbCBjcmVhdGUgQkJUIGF0IHRoZSBmaXJzdCBwb3dlciB1cC4KCWNoaXAtPmJi
dF9vcHRpb25zID0gTkFORF9CQlRfVVNFX0ZMQVNIIHwgTkFORF9CQlRfTk9fT09COwpJZiB1Ym9v
dCBkb2VzIG5vdCBjcmVhdGUgQkJULCB0aGVuIHRoZSBmcmFtZXdvcmsgd2lsbCBzY2FuIHRoZSBP
T0Igb2YgYWxsIGJsb2NrcyBhbmQgwqBjcmVhdGUgaXQuCkkgbW9kaWZpZWQgdGhlIHJlYWQgT09C
IGZ1bmN0aW9uIChlbmFibGUgRUNDKSDvvIxhbmQgaXQgY2FuIHJlYWQgdGhlIGNvcnJlY3QgYmFk
IGJsb2NrIG1hc2suCgpzdGF0aWMgaW50IHJrX25mY193cml0ZV9vb2Ioc3RydWN0IG5hbmRfY2hp
cCAqY2hpcCwgaW50IHBhZ2UpCnsKCXJldHVybiBya19uZmNfd3JpdGVfcGFnZV9od2VjYyhjaGlw
LCBOVUxMLCAxLCBwYWdlKTsKfQoKc3RhdGljIGludCBya19uZmNfcmVhZF9vb2Ioc3RydWN0IG5h
bmRfY2hpcCAqY2hpcCwgaW50IHBhZ2UpCnsKCXJldHVybiBya19uZmNfcmVhZF9wYWdlX2h3ZWNj
KGNoaXAsIE5VTEwsIDEsIHBhZ2UpOwp9CgpjaGlwLT5lY2MucmVhZF9vb2IgPSBya19uZmNfcmVh
ZF9vb2I7CmNoaXAtPmVjYy53cml0ZV9vb2IgPSBya19uZmNfd3JpdGVfb29iOwoKCgo+Pgo+PiBU
aGFua3MsCj4+IE1pcXXDqGwKPj4KPj4+Cj4+Pgo+Pj4+Cj4+Pj4+Cj4+Pj4+IFJhdyBhY2Nlc3Nv
cnMgaXMgcmVhbGx5IGEgbmljZSBhbmQgYmFzaWMgZmVhdHVyZSB0aGF0IEkgd291bGQgbGlrZSB0
bwo+Pj4+PiBoYXZlIGluIGV2ZXJ5IG5ldyBkcml2ZXIuCj4+Pj4+Cj4+Pj4+IFRoYW5rcywKPj4+
Pj4gTWlxdcOobAo+Pj4+Pgo+Pj4+Cj4+Pgo+Cj4KPgo+




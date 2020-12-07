Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 652DE2D0B4D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 08:49:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726164AbgLGHsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 02:48:02 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:2520 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbgLGHsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 02:48:02 -0500
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4CqFkh5433zQpLL;
        Mon,  7 Dec 2020 15:46:52 +0800 (CST)
Received: from dggpemm000002.china.huawei.com (7.185.36.174) by
 DGGEMM403-HUB.china.huawei.com (10.3.20.211) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Mon, 7 Dec 2020 15:47:19 +0800
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggpemm000002.china.huawei.com (7.185.36.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.1913.5; Mon, 7 Dec 2020 15:47:19 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.1913.007;
 Mon, 7 Dec 2020 15:47:19 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Will Deacon <will@kernel.org>
CC:     "steve.capper@arm.com" <steve.capper@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nsaenzjulienne@suse.de" <nsaenzjulienne@suse.de>,
        "liwei (CM)" <liwei213@huawei.com>, butao <butao@hisilicon.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        fengbaopeng <fengbaopeng2@hisilicon.com>
Subject: RE: [PATCH] arm64: mm: decrease the section size to reduce the memory
 reserved for the page map
Thread-Topic: [PATCH] arm64: mm: decrease the section size to reduce the
 memory reserved for the page map
Thread-Index: AQHWyd8Pm9rJc08RmUuZbQcVlySHKKnmQzeAgAAIcQCABJBfwP//39CAgACJBcA=
Date:   Mon, 7 Dec 2020 07:47:19 +0000
Message-ID: <cd6e9bd9210a43948a61ad41c5cb9208@hisilicon.com>
References: <20201204014443.43329-1-liwei213@huawei.com>
 <20201204111347.GA844@willie-the-truck>
 <20201204114400.GT123287@linux.ibm.com>
 <60cb36d5dfcb4f9c904a83b520ecfe84@hisilicon.com>
 <ae384eff-448f-a8d5-a45a-e8a9234d26bb@arm.com>
In-Reply-To: <ae384eff-448f-a8d5-a45a-e8a9234d26bb@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.201.26]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQW5zaHVtYW4gS2hhbmR1
YWwgW21haWx0bzphbnNodW1hbi5raGFuZHVhbEBhcm0uY29tXQ0KPiBTZW50OiBNb25kYXksIERl
Y2VtYmVyIDcsIDIwMjAgODozMSBQTQ0KPiBUbzogU29uZyBCYW8gSHVhIChCYXJyeSBTb25nKSA8
c29uZy5iYW8uaHVhQGhpc2lsaWNvbi5jb20+OyBNaWtlIFJhcG9wb3J0DQo+IDxycHB0QGxpbnV4
LmlibS5jb20+OyBXaWxsIERlYWNvbiA8d2lsbEBrZXJuZWwub3JnPg0KPiBDYzogc3RldmUuY2Fw
cGVyQGFybS5jb207IGNhdGFsaW4ubWFyaW5hc0Bhcm0uY29tOw0KPiBsaW51eC1rZXJuZWxAdmdl
ci5rZXJuZWwub3JnOyBuc2FlbnpqdWxpZW5uZUBzdXNlLmRlOyBsaXdlaSAoQ00pDQo+IDxsaXdl
aTIxM0BodWF3ZWkuY29tPjsgYnV0YW8gPGJ1dGFvQGhpc2lsaWNvbi5jb20+Ow0KPiBsaW51eC1h
cm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGZlbmdiYW9wZW5nDQo+IDxmZW5nYmFvcGVu
ZzJAaGlzaWxpY29uLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gYXJtNjQ6IG1tOiBkZWNy
ZWFzZSB0aGUgc2VjdGlvbiBzaXplIHRvIHJlZHVjZSB0aGUgbWVtb3J5DQo+IHJlc2VydmVkIGZv
ciB0aGUgcGFnZSBtYXANCj4gDQo+IA0KPiANCj4gT24gMTIvNy8yMCA3OjEwIEFNLCBTb25nIEJh
byBIdWEgKEJhcnJ5IFNvbmcpIHdyb3RlOg0KPiA+DQo+ID4NCj4gPj4gLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCj4gPj4gRnJvbTogTWlrZSBSYXBvcG9ydCBbbWFpbHRvOnJwcHRAbGludXgu
aWJtLmNvbV0NCj4gPj4gU2VudDogU2F0dXJkYXksIERlY2VtYmVyIDUsIDIwMjAgMTI6NDQgQU0N
Cj4gPj4gVG86IFdpbGwgRGVhY29uIDx3aWxsQGtlcm5lbC5vcmc+DQo+ID4+IENjOiBsaXdlaSAo
Q00pIDxsaXdlaTIxM0BodWF3ZWkuY29tPjsgY2F0YWxpbi5tYXJpbmFzQGFybS5jb207IGZlbmdi
YW9wZW5nDQo+ID4+IDxmZW5nYmFvcGVuZzJAaGlzaWxpY29uLmNvbT47IG5zYWVuemp1bGllbm5l
QHN1c2UuZGU7DQo+IHN0ZXZlLmNhcHBlckBhcm0uY29tOw0KPiA+PiBTb25nIEJhbyBIdWEgKEJh
cnJ5IFNvbmcpIDxzb25nLmJhby5odWFAaGlzaWxpY29uLmNvbT47DQo+ID4+IGxpbnV4LWFybS1r
ZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsg
YnV0YW8NCj4gPj4gPGJ1dGFvQGhpc2lsaWNvbi5jb20+DQo+ID4+IFN1YmplY3Q6IFJlOiBbUEFU
Q0hdIGFybTY0OiBtbTogZGVjcmVhc2UgdGhlIHNlY3Rpb24gc2l6ZSB0byByZWR1Y2UgdGhlIG1l
bW9yeQ0KPiA+PiByZXNlcnZlZCBmb3IgdGhlIHBhZ2UgbWFwDQo+ID4+DQo+ID4+IE9uIEZyaSwg
RGVjIDA0LCAyMDIwIGF0IDExOjEzOjQ3QU0gKzAwMDAsIFdpbGwgRGVhY29uIHdyb3RlOg0KPiA+
Pj4gT24gRnJpLCBEZWMgMDQsIDIwMjAgYXQgMDk6NDQ6NDNBTSArMDgwMCwgV2VpIExpIHdyb3Rl
Og0KPiA+Pj4+IEZvciB0aGUgbWVtb3J5IGhvbGUsIHNwYXJzZSBtZW1vcnkgbW9kZWwgdGhhdCBk
ZWZpbmUgU1BBUlNFTUVNX1ZNRU1NQVANCj4gPj4+PiBkbyBub3QgZnJlZSB0aGUgcmVzZXJ2ZWQg
bWVtb3J5IGZvciB0aGUgcGFnZSBtYXAsIGRlY3JlYXNlIHRoZSBzZWN0aW9uDQo+ID4+Pj4gc2l6
ZSBjYW4gcmVkdWNlIHRoZSB3YXN0ZSBvZiByZXNlcnZlZCBtZW1vcnkuDQo+ID4+Pj4NCj4gPj4+
PiBTaWduZWQtb2ZmLWJ5OiBXZWkgTGkgPGxpd2VpMjEzQGh1YXdlaS5jb20+DQo+ID4+Pj4gU2ln
bmVkLW9mZi1ieTogQmFvcGVuZyBGZW5nIDxmZW5nYmFvcGVuZzJAaGlzaWxpY29uLmNvbT4NCj4g
Pj4+PiBTaWduZWQtb2ZmLWJ5OiBYaWEgUWluZyA8c2FiZXJsaWx5LnhpYUBoaXNpbGljb24uY29t
Pg0KPiA+Pj4+IC0tLQ0KPiA+Pj4+ICBhcmNoL2FybTY0L2luY2x1ZGUvYXNtL3NwYXJzZW1lbS5o
IHwgMiArLQ0KPiA+Pj4+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRp
b24oLSkNCj4gPj4+Pg0KPiA+Pj4+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2luY2x1ZGUvYXNt
L3NwYXJzZW1lbS5oDQo+ID4+IGIvYXJjaC9hcm02NC9pbmNsdWRlL2FzbS9zcGFyc2VtZW0uaA0K
PiA+Pj4+IGluZGV4IDFmNDNmY2M3OTczOC4uODk2M2JkM2RlZjI4IDEwMDY0NA0KPiA+Pj4+IC0t
LSBhL2FyY2gvYXJtNjQvaW5jbHVkZS9hc20vc3BhcnNlbWVtLmgNCj4gPj4+PiArKysgYi9hcmNo
L2FybTY0L2luY2x1ZGUvYXNtL3NwYXJzZW1lbS5oDQo+ID4+Pj4gQEAgLTcsNyArNyw3IEBADQo+
ID4+Pj4NCj4gPj4+PiAgI2lmZGVmIENPTkZJR19TUEFSU0VNRU0NCj4gPj4+PiAgI2RlZmluZSBN
QVhfUEhZU01FTV9CSVRTCUNPTkZJR19BUk02NF9QQV9CSVRTDQo+ID4+Pj4gLSNkZWZpbmUgU0VD
VElPTl9TSVpFX0JJVFMJMzANCj4gPj4+PiArI2RlZmluZSBTRUNUSU9OX1NJWkVfQklUUwkyNw0K
PiA+Pj4NCj4gPj4+IFdlIGNob3NlICczMCcgdG8gYXZvaWQgcnVubmluZyBvdXQgb2YgYml0cyBp
biB0aGUgcGFnZSBmbGFncy4gV2hhdCBjaGFuZ2VkPw0KPiA+Pg0KPiA+PiBJIHRoaW5rIHRoYXQg
Zm9yIDY0LWJpdCB0aGVyZSBhcmUgc3RpbGwgcGxlbnR5IG9mIGZyZWUgYml0cy4gSSBkaWRuJ3QN
Cj4gPj4gY2hlY2sgbm93LCBidXQgd2hlbiBJIHBsYXllZCB3aXRoIFNQQVJTRU1FTSBvbiBtNjhr
IHRoZXJlIHdlcmUgOCBiaXRzDQo+ID4+IGZvciBzZWN0aW9uIG91dCBvZiAzMi4NCj4gPj4NCj4g
Pj4+IFdpdGggdGhpcyBwYXRjaCwgSSBjYW4gdHJpZ2dlcjoNCj4gPj4+DQo+ID4+PiAuL2luY2x1
ZGUvbGludXgvbW16b25lLmg6MTE3MDoyOiBlcnJvcjogQWxsb2NhdG9yIE1BWF9PUkRFUiBleGNl
ZWRzDQo+ID4+IFNFQ1RJT05fU0laRQ0KPiA+Pj4gI2Vycm9yIEFsbG9jYXRvciBNQVhfT1JERVIg
ZXhjZWVkcyBTRUNUSU9OX1NJWkUNCj4gPj4+DQo+ID4+PiBpZiBJIGJ1bXAgdXAgTlJfQ1BVUyBh
bmQgTk9ERVNfU0hJRlQuDQo+ID4+DQo+ID4+IEkgZG9uJ3QgdGhpbmsgaXQncyByZWxhdGVkIHRv
IE5SX0NQVVMgYW5kIE5PREVTX1NISUZULg0KPiA+PiBUaGlzIHNlZW1zIHJhdGhlciA2NEsgcGFn
ZXMgdGhhdCBjYXVzZSB0aGlzLg0KPiA+Pg0KPiA+PiBOb3QgdGhhdCBpcyBzaG91bGRuJ3QgYmUg
YWRkcmVzc2VkLg0KPiA+DQo+ID4gUmlnaHQgbm93LCBvbmx5IDRLIFBBR0VTIHdpbGwgZGVmaW5l
IEFSTTY0X1NXQVBQRVJfVVNFU19TRUNUSU9OX01BUFMuDQo+ID4gT3RoZXIgY2FzZXMgd2lsbCB1
c2Ugdm1lbW1hcF9wb3B1bGF0ZV9iYXNlcGFnZXMoKS4NCj4gPiBUaGUgb3JpZ2luYWwgcGF0Y2gg
c2hvdWxkIGJlIG9ubHkgYWRkcmVzc2luZyB0aGUgaXNzdWUgaW4gNEsgcGFnZXM6DQo+ID4gaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDIwMDgxMjAxMDY1NS45NjMzOS0xLWxpd2VpMjEz
QGh1YXdlaS5jb20vDQo+ID4NCj4gPiB3b3VsZCB3ZSBkbyBzb21ldGhpbmcgbGlrZSB0aGUgYmVs
b3c/DQo+ID4gI2lmZGVmIENPTkZJR19BUk02NF80S19QQUdFDQo+ID4gI2RlZmluZSBTRUNUSU9O
X1NJWkVfQklUUwkyNw0KPiA+ICNlbHNlDQo+ID4gI2RlZmluZSBTRUNUSU9OX1NJWkVfQklUUwkz
MA0KPiA+ICNlbmRpZg0KPiANCj4gVGhpcyBpcyBiaXQgYXJiaXRyYXJ5LiBQcm9iYWJseSAyNyBj
YW4gYmUgZnVydGhlciByZWR1Y2VkIGZvciA0SyBwYWdlIHNpemUuDQo+IEluc3RlYWQsIHdlIHNo
b3VsZCBtYWtlIFNFQ1RJT05fU0laRV9CSVRTIGV4cGxpY2l0bHkgZGVwZW5kIHVwb24gTUFYX09S
REVSLg0KPiBJT1cgc2VjdGlvbiBzaXplIHNob3VsZCBiZSB0aGUgc2FtZSBhcyB0aGUgaGlnaGVz
dCBvcmRlciBwYWdlIGluIHRoZSBidWRkeS4NCj4gQ09ORklHX0ZPUkNFX01BWF9aT05FT1JERVIg
aXMgYWx3YXlzIGRlZmluZWQgb24gYXJtNjQuIEEgcXVpY2sgdGVzdCBzaG93cw0KPiBTRUNUSU9O
X1NJWkVfQklUUyB3b3VsZCBiZSAyMiBvbiA0SyBwYWdlcyBhbmQgMjkgZm9yIDY0SyBwYWdlcy4g
QXMgYSBmYWxsDQo+IGJhY2sgU0VDVElPTl9TSVpFX0JJVFMgY2FuIHN0aWxsIGJlIDMwIGluIGNh
c2UgQ09ORklHX0ZPUkNFX01BWF9aT05FT1JERVINCj4gaXMgbm90IGRlZmluZWQuDQoNClRoaXMg
d2lsbCBicmVhayB0aGUgcG1kIG1hcHBpbmcgZm9yIHZtZW1tYXAuIEFzIGZvciBlYWNoIDEyOE0o
Ml4yNyksIHdlIGNhbg0KaGF2ZSAyTUIgcG1kIG1hcHBpbmcuDQoNCj4gDQo+IC0tLSBhL2FyY2gv
YXJtNjQvaW5jbHVkZS9hc20vc3BhcnNlbWVtLmgNCj4gKysrIGIvYXJjaC9hcm02NC9pbmNsdWRl
L2FzbS9zcGFyc2VtZW0uaA0KPiBAQCAtNyw3ICs3LDcgQEANCj4gDQo+ICAjaWZkZWYgQ09ORklH
X1NQQVJTRU1FTQ0KPiAgI2RlZmluZSBNQVhfUEhZU01FTV9CSVRTICAgICAgIENPTkZJR19BUk02
NF9QQV9CSVRTDQo+IC0jZGVmaW5lIFNFQ1RJT05fU0laRV9CSVRTICAgICAgMzANCj4gKyNkZWZp
bmUgU0VDVElPTl9TSVpFX0JJVFMgICAgICAoQ09ORklHX0ZPUkNFX01BWF9aT05FT1JERVIgLSAx
ICsgUEFHRV9TSElGVCkNCj4gICNlbmRpZg0KPiANCj4gICNlbmRpZg0KPiANCj4gQSBzaW1pbGFy
IGFwcHJvYWNoIGV4aXN0cyBvbiBpYTY0IHBsYXRmb3JtIGFzIHdlbGwuDQoNClRoYW5rcw0KQmFy
cnkNCg0K

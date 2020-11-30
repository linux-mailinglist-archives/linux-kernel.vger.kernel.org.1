Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFC1B2C895C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 17:24:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728822AbgK3QVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 11:21:36 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2180 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgK3QVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 11:21:35 -0500
Received: from fraeml734-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Cl9Qs39qzz67D9H;
        Tue,  1 Dec 2020 00:19:01 +0800 (CST)
Received: from lhreml721-chm.china.huawei.com (10.201.108.72) by
 fraeml734-chm.china.huawei.com (10.206.15.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 30 Nov 2020 17:20:54 +0100
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 lhreml721-chm.china.huawei.com (10.201.108.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Mon, 30 Nov 2020 16:20:53 +0000
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.1913.007; Mon, 30 Nov 2020 16:20:53 +0000
From:   Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To:     Marc Zyngier <maz@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        Linuxarm <linuxarm@huawei.com>
Subject: RE: [PATCH] irqchip/gic-v3: Check SRE bit for GICv2 legacy support
Thread-Topic: [PATCH] irqchip/gic-v3: Check SRE bit for GICv2 legacy support
Thread-Index: AQHWxwOHViTg3pRnhkK4BwcYBC9AoqngmnQAgAABpXCAACfogIAABzIw
Date:   Mon, 30 Nov 2020 16:20:53 +0000
Message-ID: <e93770e46c73413882584ebc3fe732e3@huawei.com>
References: <20201130102639.7504-1-shameerali.kolothum.thodi@huawei.com>
 <f8a97f360073fa495cae75acc11ecf4f@kernel.org>
 <85bb389a75f347d29ab3f75e4cfae060@huawei.com>
 <846387e4168f1a22638ad07ae670c531@kernel.org>
In-Reply-To: <846387e4168f1a22638ad07ae670c531@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.52.130.129]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFyYyBaeW5naWVyIFtt
YWlsdG86bWF6QGtlcm5lbC5vcmddDQo+IFNlbnQ6IDMwIE5vdmVtYmVyIDIwMjAgMTQ6NTcNCj4g
VG86IFNoYW1lZXJhbGkgS29sb3RodW0gVGhvZGkgPHNoYW1lZXJhbGkua29sb3RodW0udGhvZGlA
aHVhd2VpLmNvbT4NCj4gQ2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFy
bS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4gZXJpYy5hdWdlckByZWRoYXQuY29tOyBM
aW51eGFybSA8bGludXhhcm1AaHVhd2VpLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gaXJx
Y2hpcC9naWMtdjM6IENoZWNrIFNSRSBiaXQgZm9yIEdJQ3YyIGxlZ2FjeSBzdXBwb3J0DQo+IA0K
PiBIaSBTaGFtZWVyLA0KPiANCj4gT24gMjAyMC0xMS0zMCAxMzo1NSwgU2hhbWVlcmFsaSBLb2xv
dGh1bSBUaG9kaSB3cm90ZToNCj4gPiBIaSBNYXJjLA0KPiA+DQo+ID4+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+ID4+IEZyb206IE1hcmMgWnluZ2llciBbbWFpbHRvOm1hekBrZXJuZWwu
b3JnXQ0KPiA+PiBTZW50OiAzMCBOb3ZlbWJlciAyMDIwIDEyOjI4DQo+ID4+IFRvOiBTaGFtZWVy
YWxpIEtvbG90aHVtIFRob2RpIDxzaGFtZWVyYWxpLmtvbG90aHVtLnRob2RpQGh1YXdlaS5jb20+
DQo+ID4+IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiA+PiBsaW51eC1hcm0t
a2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+ID4+IGVyaWMuYXVnZXJAcmVkaGF0LmNvbTsg
TGludXhhcm0gPGxpbnV4YXJtQGh1YXdlaS5jb20+DQo+ID4+IFN1YmplY3Q6IFJlOiBbUEFUQ0hd
IGlycWNoaXAvZ2ljLXYzOiBDaGVjayBTUkUgYml0IGZvciBHSUN2MiBsZWdhY3kNCj4gPj4gc3Vw
cG9ydA0KPiA+Pg0KPiA+PiBIaSBTaGFtZWVyLA0KPiA+Pg0KPiA+PiBPbiAyMDIwLTExLTMwIDEw
OjI2LCBTaGFtZWVyIEtvbG90aHVtIHdyb3RlOg0KPiA+PiA+IEF0IHByZXNlbnQsIHRoZSBzdXBw
b3J0IGZvciBHSUN2MiBiYWNrd2FyZCBjb21wYXRpYmlsaXR5IG9uIEdJQ3YzL3Y0DQo+ID4+ID4g
aGFyZHdhcmUgaXMgZGV0ZXJtaW5lZCBiYXNlZCBvbiB3aGV0aGVyIERUL0FDUEkgcHJvdmlkZXMg
YSBtZW1vcnkNCj4gPj4gPiBtYXBwZWQgcGh5cyBiYXNlIGFkZHJlc3MgZm9yIEdJQyB2aXJ0dWFs
IENQVSBpbnRlcmZhY2UgcmVnaXN0ZXIoR0lDVikuDQo+ID4+ID4gVGhpcyBjcmVhdGVzIGEgcHJv
YmxlbSB0aGF0wqBhIFFlbXUgZ3Vlc3QgYm9vdCB3aXRoIGRlZmF1bHQgR0lDKEdJQ3YyKQ0KPiA+
Pg0KPiA+PiBUaGF0J2QgYmUgdHJ1ZSBvZiAqYW55KiBndWVzdCB1c2luZyBHSUN2Miwgbm90IGp1
c3Qgd2hlbiB1c2luZyBRRU1VIGFzDQo+ID4+IHRoZSBWTU0sIHJpZ2h0Pw0KPiA+DQo+ID4gWWVz
LCBJIHdvdWxkIHRoaW5rIHNvLg0KPiA+DQo+ID4+ID4gaGFuZ3Mgd2hlbiBmaXJtd2FyZSBmYWxz
ZWx5IHJlcG9ydHMgdGhpcyBhZGRyZXNzIG9uIHN5c3RlbXMgdGhhdCBkb24ndA0KPiA+PiA+IGhh
dmXCoHN1cHBvcnQgZm9yIGxlZ2FjecKgbW9kZS4NCj4gPj4NCj4gPj4gQW5kIEkgZ3Vlc3MgaXQg
aXNuJ3QganVzdCB0aGUgZ3Vlc3QgdGhhdCBoYW5ncywgYnV0IHRoZSB3aG9sZSBzeXN0ZW0NCj4g
Pj4gY2FuDQo+ID4+IGdvIHNvdXRoIChpdCB3b3VsZCBiZSB0b3RhbGx5IGxlZ2l0aW1hdGUgZm9y
IHRoZSBIVyB0byBkZWxpdmVyIGENCj4gPj4gU0Vycm9yKS4NCj4gPg0KPiA+IFNvIGZhciBJIGhh
dmVu4oCZdCBzZWVuIHRoYXQgaGFwcGVuaW5nLiBJIHdhcyBhYmxlIHRvIGtpbGwgdGhlIEd1ZXN0
IGFuZA0KPiA+IHJlY292ZXIuDQo+ID4gQnV0IHRoZSBhbm5veWluZyB0aGluZyBpcyBHdWVzdCBi
b290IGhhbmdzIGF0IHJhbmRvbSBwbGFjZXMgd2l0aG91dCBhbnkNCj4gPiBlcnJvciByZXBvcnRl
ZCBhbmQgcGVvcGxlIGVuZCB1cCBzcGVuZGluZyBsb3Qgb2YgdGltZSBvbmx5IHRvIGJlIHRvbGQN
Cj4gPiBsYXRlcg0KPiA+IHRoYXQgZ2ljLXZlcnNpb249MyBpcyBtaXNzaW5nIGZyb20gdGhlaXIg
c2NyaXB0cy4NCj4gDQo+IFRoYXQncyBwcmV0dHkgbHVja3kuIFRoZSBndWVzdCBoYXMgYmVlbiBy
ZWFkaW5nL3dyaXRpbmcgdG8gcmFuZG9tDQo+IHBsYWNlcywNCj4gYW5kIGRlcGVuZGluZyBvbiB3
aGVyZSB0aGlzIG1hcHMgaW4gdGhlIHBoeXNpY2FsIHNwYWNlLCBhbnl0aGluZyBjYW4NCj4gaGFw
cGVuLiBPdXQgIG9mIChtb3JiaWQpIGN1cmlvc2l0eSwgd2hhdCBpcyBhdCB0aGUgYWRkcmVzcyBw
b2ludGVkIHRvIGJ5DQo+IEdJQ0MgaW4gTUFEVD8NCg0KVGhpcyBpcyB3aGF0IGl0IHJlcG9ydHMs
DQoNClswMkNoIDAwNDQgICAxXSAgICAgICAgICAgICAgICBTdWJ0YWJsZSBUeXBlIDogMEIgW0dl
bmVyaWMgSW50ZXJydXB0IENvbnRyb2xsZXJdDQpbMDJEaCAwMDQ1ICAgMV0gICAgICAgICAgICAg
ICAgICAgICAgIExlbmd0aCA6IDUwDQouLi4NClswNENoIDAwNzYgICA4XSAgICAgICAgICAgICAg
ICAgQmFzZSBBZGRyZXNzIDogMDAwMDAwMDA5QjAwMDAwMA0KWzA1NGggMDA4NCAgIDhdICAgICBW
aXJ0dWFsIEdJQyBCYXNlIEFkZHJlc3MgOiAwMDAwMDAwMDlCMDIwMDAwDQpbMDVDaCAwMDkyICAg
OF0gIEh5cGVydmlzb3IgR0lDIEJhc2UgQWRkcmVzcyA6IDAwMDAwMDAwOUIwMTAwMDANClswNjRo
IDAxMDAgICA0XSAgICAgICAgVmlydHVhbCBHSUMgSW50ZXJydXB0IDogMDAwMDAwMTkNClswNjho
IDAxMDQgICA4XSAgIFJlZGlzdHJpYnV0b3IgQmFzZSBBZGRyZXNzIDogMDAwMDAwMDBBRTEwMDAw
MA0KWzA3MGggMDExMiAgIDhdICAgICAgICAgICAgICAgICAgICBBUk0gTVBJRFIgOiAwMDAwMDAw
MDAwMDgwMDAwDQpbMDc4aCAwMTIwICAgMV0gICAgICAgICAgICAgRWZmaWNpZW5jeSBDbGFzcyA6
IDE1DQpbMDc5aCAwMTIxICAgM10gICAgICAgICAgICAgICAgICAgICBSZXNlcnZlZCA6IDAwMTUw
MA0KDQo+ID4NCj4gPj4gPiBBcyBwZXIgR0lDdjMvdjQgc3BlYywgaW4gYW4gaW1wbGVtZW50YXRp
b24gdGhhdCBkb2VzIG5vdCBzdXBwb3J0IGxlZ2FjeQ0KPiA+PiA+IG9wZXJhdGlvbiwgYWZmaW5p
dHkgcm91dGluZyBhbmQgc3lzdGVtIHJlZ2lzdGVyIGFjY2VzcyBhcmUgcGVybWFuZW50bHkNCj4g
Pj4gPiBlbmFibGVkLiBUaGlzIG1lYW5zIHRoYXQgdGhlIGFzc29jaWF0ZWQgY29udHJvbCBiaXRz
IGFyZSBSQU8vV0kuIEhlbmNlDQo+ID4+ID4gdXNlIHRoZcKgSUNDX1NSRV9FTDEuU1JFIGJpdCB0
byBkZWNpZGUgd2hldGhlciBoYXJkd2FyZcKgc3VwcG9ydHMNCj4gR0lDdjINCj4gPj4gPiBtb2Rl
IGluIGFkZGl0aW9uIHRvIHRoZSBhYm92ZSBmaXJtd2FyZcKgYmFzZWQgY2hlY2suDQo+ID4+ID4N
Cj4gPj4gPiBTaWduZWQtb2ZmLWJ5OiBTaGFtZWVyIEtvbG90aHVtDQo+IDxzaGFtZWVyYWxpLmtv
bG90aHVtLnRob2RpQGh1YXdlaS5jb20+DQo+ID4+ID4gLS0tDQo+ID4+ID4gT24gSGlzaWxpY29u
IEQwNiwgVUVGSSBzZXRzIHRoZSBHSUMgTUFEVCBHSUNDIGdpY3ZfYmFzZV9hZGRyZXNzIGJ1dA0K
PiB0aGUNCj4gPj4gPiBHSUMgaW1wbGVtZW50YXRpb27CoG9uIHRoZXNlIGJvYXJkcyBkb2Vzbid0
IGhhdmUgdGhlIEdJQ3YyIGxlZ2FjeQ0KPiA+PiA+IHN1cHBvcnQuDQo+ID4+ID4gVGhpcyByZXN1
bHRzIGluLCBHdWVzdCBib290IGhhbmcgd2hlbiBRZW11IHVzZXMgdGhlIGRlZmF1bHQgR0lDIG9w
dGlvbi4NCj4gPj4NCj4gPj4gV2hhdCBhIGJvcmUuIElzIHRoaXMgZ2xvcmlvdXMgZmlybXdhcmUg
cmVhbGx5IG91dCBpbiB0aGUgd2lsZD8NCj4gPg0KPiA+IDooLiBJIGFtIGFmcmFpZCBpdCBpcy4N
Cj4gDQo+IE1laC4gV2UnbGwgaGF2ZSB0byBwYXBlciBvdmVyIGl0IHRoZW4uIEhvdyB1cmdlbnQg
aXMgdGhhdD8NCg0KSXQgaXMgbm90IHRoYXQgdXJnZW50IHVyZ2VudCBidXQgNS4xMCBzdXBwb3J0
IHdvdWxkIGJlIG5pY2UgOikNCg0KPiANCj4gWy4uLl0NCj4gDQo+ID4+IEhvdyBhYm91dCB0aGlz
IGluc3RlYWQ/IENvbXBsZXRlbHkgdW50ZXN0ZWQsIG9mIGNvdXJzZS4NCj4gPg0KPiA+IFRoYW5r
cyBmb3IgdGhhdC4gSSBqdXN0IHRlc3RlZCBhbmQgaXQgd29ya3MuDQo+IA0KPiBPSy4gSSdsbCBy
ZXdvcmsgaXQgYSBiaXQgYW5kIHBvc3QgaXQgYXMgYSBjb21wbGV0ZSBwYXRjaC4gSXMgdGhlcmUg
YW4NCj4gZXJyYXR1bSBudW1iZXIgb24geW91ciBzaWRlPw0KDQpTdXJlLiBJIGFtIG5vdCBzdXJl
IG9uIGVycmF0dW0sIGJ1dCB3aWxsIGNoZWNrIGludGVybmFsbHkgYW5kIGdldCBiYWNrIHRvIHlv
dQ0KaWYgdGhlcmUgaXMgb25lLg0KDQpUaGFua3MsDQpTaGFtZWVyDQo+IA0KPiBUaGFua3MsDQo+
IA0KPiAgICAgICAgICBNLg0KPiAtLQ0KPiBKYXp6IGlzIG5vdCBkZWFkLiBJdCBqdXN0IHNtZWxs
cyBmdW5ueS4uLg0K

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B412228AC6D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 05:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727155AbgJLDZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Oct 2020 23:25:06 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:53220 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726371AbgJLDZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Oct 2020 23:25:06 -0400
X-UUID: bdfb87fcbd6a45d0944ca2cfad11dd11-20201012
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=Bm72sr6Ouy/aEnxVTOQTJVItEbE2HZ45eGSUlY3+1i4=;
        b=iHV97fO7VS8aMf3ROYlU++JLJjIQsfA5n5ZaaYPFHZanI88tjH4NgEBLV0cNbGaLVhF2pQi281WgwsnOvCRYZTgcg8j3Q+Ll/rrvVEis9js4hUo3EHAmCIINN4uiq3blb/Nzty8xaYzSYD5SFcgXOo+ANpSeO1r3UB7/3K8wL+Y=;
X-UUID: bdfb87fcbd6a45d0944ca2cfad11dd11-20201012
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <neal.liu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1833974140; Mon, 12 Oct 2020 11:25:00 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 12 Oct 2020 11:24:57 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 12 Oct 2020 11:24:57 +0800
Message-ID: <1602473098.26774.5.camel@mtkswgap22>
Subject: Re: [PATCH v7 2/2] soc: mediatek: add mt6779 devapc driver
From:   Neal Liu <neal.liu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     Neal Liu <neal.liu@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>
Date:   Mon, 12 Oct 2020 11:24:58 +0800
In-Reply-To: <0ece983b-2e55-cf06-aca8-02a014fce090@gmail.com>
References: <1598497593-15781-1-git-send-email-neal.liu@mediatek.com>
         <1598497593-15781-3-git-send-email-neal.liu@mediatek.com>
         <c41ec664-73a0-3c63-a31c-48c89028dfac@gmail.com>
         <1602124514.28301.17.camel@mtkswgap22>
         <d8aec3a3-10b6-8c9e-6b2d-f9d9c0418b33@gmail.com>
         <1602149965.8784.6.camel@mtkswgap22>
         <0ece983b-2e55-cf06-aca8-02a014fce090@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: A57CB5B722B96A24B6BC4E4DA5FC2FE3FA559752A9CF0861603F1BE94AA214DC2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIwLTEwLTA5IGF0IDE0OjM0ICswMjAwLCBNYXR0aGlhcyBCcnVnZ2VyIHdyb3Rl
Og0KPiANCj4gT24gMDgvMTAvMjAyMCAxMTozOSwgTmVhbCBMaXUgd3JvdGU6DQo+ID4gT24gVGh1
LCAyMDIwLTEwLTA4IGF0IDEwOjQ1ICswMjAwLCBNYXR0aGlhcyBCcnVnZ2VyIHdyb3RlOg0KPiA+
Pg0KPiA+PiBPbiAwOC8xMC8yMDIwIDA0OjM1LCBOZWFsIExpdSB3cm90ZToNCj4gPj4+IE9uIFdl
ZCwgMjAyMC0xMC0wNyBhdCAxMjo0NCArMDIwMCwgTWF0dGhpYXMgQnJ1Z2dlciB3cm90ZToNCj4g
Pj4+Pg0KPiA+Pj4+IE9uIDI3LzA4LzIwMjAgMDU6MDYsIE5lYWwgTGl1IHdyb3RlOg0KPiBbLi4u
XQ0KPiANCj4gPj4+Pj4gK3N0YXRpYyBpbnQgbXRrX2RldmFwY19wcm9iZShzdHJ1Y3QgcGxhdGZv
cm1fZGV2aWNlICpwZGV2KQ0KPiA+Pj4+PiArew0KPiA+Pj4+PiArCXN0cnVjdCBkZXZpY2Vfbm9k
ZSAqbm9kZSA9IHBkZXYtPmRldi5vZl9ub2RlOw0KPiA+Pj4+PiArCXN0cnVjdCBtdGtfZGV2YXBj
X2NvbnRleHQgKmN0eDsNCj4gPj4+Pj4gKwl1MzIgZGV2YXBjX2lycTsNCj4gPj4+Pj4gKwlpbnQg
cmV0Ow0KPiA+Pj4+PiArDQo+ID4+Pj4+ICsJaWYgKElTX0VSUihub2RlKSkNCj4gPj4+Pj4gKwkJ
cmV0dXJuIC1FTk9ERVY7DQo+ID4+Pj4+ICsNCj4gPj4+Pj4gKwljdHggPSBkZXZtX2t6YWxsb2Mo
JnBkZXYtPmRldiwgc2l6ZW9mKCpjdHgpLCBHRlBfS0VSTkVMKTsNCj4gPj4+Pj4gKwlpZiAoIWN0
eCkNCj4gPj4+Pj4gKwkJcmV0dXJuIC1FTk9NRU07DQo+ID4+Pj4+ICsNCj4gPj4+Pj4gKwljdHgt
PmRhdGEgPSBvZl9kZXZpY2VfZ2V0X21hdGNoX2RhdGEoJnBkZXYtPmRldik7DQo+ID4+Pj4+ICsJ
Y3R4LT5kZXYgPSAmcGRldi0+ZGV2Ow0KPiA+Pj4+PiArDQo+ID4+Pj4+ICsJY3R4LT5pbmZyYV9i
YXNlID0gb2ZfaW9tYXAobm9kZSwgMCk7DQo+ID4+Pj4NCj4gPj4+PiBEb2VzIHRoaXMgbWVhbiB0
aGUgZGV2aWNlIGlzIHBhcnQgb2YgdGhlIGluZnJhY2ZnIGJsb2NrPw0KPiA+Pj4+IEkgd2Fzbid0
IGFibGUgdG8gZmluZCBhbnkgaW5mb3JtYXRpb24gYWJvdXQgaXQuDQo+ID4+Pg0KPiA+Pj4gSSdt
IG5vdCBzdXJlIHdoeSB5b3Ugd291bGQgYXNrIGluZnJhY2ZnIGJsb2NrLiBkZXZhcGMgaXMgcGFy
dHMgb2Ygb3VyDQo+ID4+PiBTb0MgaW5mcmEsIGl0J3MgZGlmZmVyZW50IHdpdGggaW5mcmFjZmcu
DQo+ID4+Pg0KPiA+Pg0KPiA+PiBJJ20gYXNraW5nIGJlY2F1c2UgSSB3YW50IHRvIHVuZGVyc3Rh
bmQgdGhlIEhXIGJldHRlci4gSSdtIG5vdCBhYmxlIHRvIGZpbmQgYW55DQo+ID4+IGluZm9ybWF0
aW9uIGluIHRoZSBkYXRhc2hlZXRzLiBJIHdhbnQgdG8gYXZvaWQgYSBzaXR1YXRpb24gYXMgd2Ug
aGFkIHdpdGggdGhlDQo+ID4+IE1NU1lTIHdoZXJlIGEgY2xvY2sgZHJpdmVyIHdhcyBzdWJtaXR0
ZWQgZmlyc3QgYW5kIGxhdGVyIG9uIHdlIHJlYWxpemVkIHRoYXQNCj4gPj4gTU1TWVMgaXMgbXVj
aCBtb3JlIHRoZW4gdGhhdCBhbmQgd2UgaGFkIHRvIHdvcmsgaGFyZCB0byBnZXQgdGhlIGRyaXZl
ciByaWdodC4NCj4gPj4NCj4gPj4gTm93IGl0J3MgaGFwcGVuaW5nIHdpdGggU0NQU1lTLCB3aGVy
ZSBhIGRyaXZlciB3aXRoIHRoZSBzY3BzeXMgY29tcGF0aWJsZSB3YXMNCj4gPj4gc2VuZCB5ZWFy
cyBhZ28uIEJ1dCBTQ1BTWVMgaXMgbXVjaCBtb3JlIHRoZW4gdGhlIGRyaXZlciBzdWJtaXR0ZWQu
IEluIHRoaXMgY2FzZQ0KPiA+PiB3ZSBvcHRlZCB0byB3cml0ZSBhIG5ldyBkcml2ZXIsIGJ1dCBt
b3ZpbmcgZnJvbSBvbmUgZHJpdmVyIHRvIGFub3RoZXIgb25lIGlzDQo+ID4+IHBhaW5mdWxsIGFu
ZCBmdWxsIG9mIHByb2JsZW1zLiBGb3IgdGhhdCBJIHdhbnQgdG8gbWFrZSBzdXJlIHdlIGZ1bGx5
IHVuZGVyc3RhbmQNCj4gPj4gRGV2aWNlIEFQQyAoYnkgdGhlIHdheSwgd2hhdCBkb2VzIEFQQyBz
dGFuZHMgZm9yPykuIElzIGl0IGEgdG90YWxseSBpbmRlcGVuZGVudA0KPiA+PiBIVyBibG9jayBv
ciBpcyBpdCBwYXJ0IG9mIGEgc3Vic3lzdGVtLCBsaWtlIGZvciBleGFtcGxlIFNDUD8NCj4gPj4N
Cj4gPj4gUmVnYXJkcywNCj4gPj4gTWF0dGhpYXMNCj4gPiANCj4gPiBJdCdzIGEgdG90YWxseSBp
bmRlcGVuZGVudCBIVyBibG9jayBpbnN0ZWFkIG9mIGEgc3Vic3lzdGVtLg0KPiA+IEkgdGhpbmsg
aXQncyBtb3JlIHNpbXBsZSB0aGFuIE1NU1lTIG9yIFNDUFNZUy4gQnV0IGlmIHlvdSB3b3VsZCBs
aWtlIHRvDQo+ID4gdW5kZXJzdGFuZCBtb3JlIGFib3V0IHRoaXMgSFcsIHdlIGNvdWxkIGZpbmQg
YW5vdGhlciB3YXkvY2hhbm5lbCB0bw0KPiA+IGludHJvZHVjZSBpdC4NCj4gPiANCj4gDQo+IElm
IGl0J3MgYSBpbmRlcGVuZGVudCBIVyBibG9jaywgdGhlbiB3ZSBhcmUgZ29vZC4gTm8gZnVydGhl
ciBpbmZvcm1hdGlvbiBuZWVkZWQgDQo+IGJ5IG1lLiBJJ2QganVzdCBhZHZpc2UgdG8gcmVuYW1l
IHRoZSBpbmZyYV9iYXNlIHRvIHNvbWV0aGluZyBsaWtlIGJhc2UsIGFzIGl0IA0KPiBtYWRlIG1l
IGNvbmZ1c2UuDQo+IA0KPiBUaGFua3MhDQo+IE1hdHRoaWFzDQoNCllvdSBjYW4gaW1hZ2luZSB0
aGF0IGluZnJhX2Jhc2UgbWVhbnMgaW5mcmEgZGV2YXBjIGJhc2UgYWRkcmVzcyBmb3INCk1UNjc3
OS4gSW4gNUcgcGxhdGZvcm1zLCBNZWRpYVRlayBpbmZyYXN0cnVjdHVyZSB3b3VsZCBzZXBhcmF0
ZSBpbnRvDQptdWx0aXBsZSBwYXJ0cywgc28gZG9lcyBkZXZhcGMgSFcuIEFuZCBkZXZhcGMgd291
bGQgYmUgbGlrZToNCmluZnJhX2Jhc2UsIHBlcmlfYmFzZSwgcGVyaTJfYmFzZSwgLi4uDQoNClRo
YW5rcy4NCg0K


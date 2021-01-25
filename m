Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E81E30235E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 10:49:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727172AbhAYJru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 04:47:50 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:33490 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726650AbhAYJ32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 04:29:28 -0500
X-UUID: 3fac2dd4c4fe4607bc7096152e2f7cd3-20210125
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=lhVwgct1qLRIqISTHiQUau/q2BPFUpBPawwGht04g0o=;
        b=SKEgW8zXP0ydAJxkwqOm2wmDOtkeG8o4peHVMWbXBE8XM/dgDr4AK5zkBo6Q1nHT9S2aJH/XpSATHnSDh1Mv7qhHIMkzEzGf4i32BKe+9V6KdZ6HG2hdWTrCB3wnip0uMqgSetFq6zatzti1jQvFXI4mackqEd8EYx4O1dP1YkE=;
X-UUID: 3fac2dd4c4fe4607bc7096152e2f7cd3-20210125
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 164757872; Mon, 25 Jan 2021 17:28:09 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 25 Jan
 2021 17:28:05 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 25 Jan 2021 17:28:05 +0800
Message-ID: <1611566885.5302.4.camel@mhfsdcap03>
Subject: Re: [PATCH 2/3] memory: mtk-smi: Add module_exit and module_license
From:   Yong Wu <yong.wu@mediatek.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>, Tomasz Figa <tfiga@google.com>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <youlin.pei@mediatek.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        <anan.sun@mediatek.com>, <yi.kuo@mediatek.com>
Date:   Mon, 25 Jan 2021 17:28:05 +0800
In-Reply-To: <20210125084051.ipgeu2ksucdag2u4@kozik-lap>
References: <20210121062429.26504-1-yong.wu@mediatek.com>
         <20210121062429.26504-3-yong.wu@mediatek.com>
         <20210122213427.mwjyjn2wsgnko7mk@kozik-lap>
         <1611557381.3184.21.camel@mhfsdcap03>
         <20210125084051.ipgeu2ksucdag2u4@kozik-lap>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: CC098342C3475A3A19CA0E3E9BC4E530FBE4967BF1BA6A79FDA7BE926AEE12612000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIxLTAxLTI1IGF0IDA5OjQwICswMTAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiBPbiBNb24sIEphbiAyNSwgMjAyMSBhdCAwMjo0OTo0MVBNICswODAwLCBZb25nIFd1
IHdyb3RlOg0KPiA+IE9uIEZyaSwgMjAyMS0wMS0yMiBhdCAyMjozNCArMDEwMCwgS3J6eXN6dG9m
IEtvemxvd3NraSB3cm90ZToNCj4gPiA+IE9uIFRodSwgSmFuIDIxLCAyMDIxIGF0IDAyOjI0OjI4
UE0gKzA4MDAsIFlvbmcgV3Ugd3JvdGU6DQo+ID4gPiA+IFRoZSBjb25maWcgTVRLX1NNSSBhbHdh
eXMgZGVwZW5kcyBvbiBNVEtfSU9NTVUgd2hpY2ggaXMgYnVpbHQtaW4NCj4gPiA+ID4gY3VycmVu
dGx5LiBUaHVzIHdlIGRvbid0IGhhdmUgbW9kdWxlX2V4aXQgYmVmb3JlLiBUaGlzIHBhdGNoIGFk
ZHMNCj4gPiA+ID4gbW9kdWxlX2V4aXQgYW5kIG1vZHVsZV9saWNlbnNlLiBJdCBpcyBhIHByZXBh
cmluZyBwYXRjaCBmb3Igc3VwcG9ydGluZw0KPiA+ID4gPiBNVEtfU01JIGNvdWxkIGJlZW4gYnVp
bHQgYXMgYSBtb2R1bGUuDQo+ID4gPiA+IA0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBZb25nIFd1
IDx5b25nLnd1QG1lZGlhdGVrLmNvbT4NCj4gPiA+ID4gLS0tDQo+ID4gPiA+ICBkcml2ZXJzL21l
bW9yeS9tdGstc21pLmMgfCAxMCArKysrKysrKysrDQo+ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwg
MTAgaW5zZXJ0aW9ucygrKQ0KPiA+ID4gPiANCj4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
bWVtb3J5L210ay1zbWkuYyBiL2RyaXZlcnMvbWVtb3J5L210ay1zbWkuYw0KPiA+ID4gPiBpbmRl
eCBlMmFlYmQyYmZhOGUuLmFhMmEyNWFiZjA0ZiAxMDA2NDQNCj4gPiA+ID4gLS0tIGEvZHJpdmVy
cy9tZW1vcnkvbXRrLXNtaS5jDQo+ID4gPiA+ICsrKyBiL2RyaXZlcnMvbWVtb3J5L210ay1zbWku
Yw0KPiA+ID4gPiBAQCAtNTk3LDMgKzU5NywxMyBAQCBzdGF0aWMgaW50IF9faW5pdCBtdGtfc21p
X2luaXQodm9pZCkNCj4gPiA+ID4gIAlyZXR1cm4gcGxhdGZvcm1fcmVnaXN0ZXJfZHJpdmVycyhz
bWlkcml2ZXJzLCBBUlJBWV9TSVpFKHNtaWRyaXZlcnMpKTsNCj4gPiA+ID4gIH0NCj4gPiA+ID4g
IG1vZHVsZV9pbml0KG10a19zbWlfaW5pdCk7DQo+ID4gPiA+ICsNCj4gPiA+ID4gK3N0YXRpYyB2
b2lkIF9fZXhpdCBtdGtfc21pX2V4aXQodm9pZCkNCj4gPiA+ID4gK3sNCj4gPiA+ID4gKwlwbGF0
Zm9ybV91bnJlZ2lzdGVyX2RyaXZlcnMoc21pZHJpdmVycywgQVJSQVlfU0laRShzbWlkcml2ZXJz
KSk7DQo+ID4gPiA+ICt9DQo+ID4gPiA+ICttb2R1bGVfZXhpdChtdGtfc21pX2V4aXQpOw0KPiA+
ID4gPiArDQo+ID4gPiA+ICtNT0RVTEVfREVTQ1JJUFRJT04oIk1lZGlhVGVrIFNNSSBkcml2ZXIi
KTsNCj4gPiA+ID4gK01PRFVMRV9BTElBUygicGxhdGZvcm06TWVkaWFUZWstU01JIik7DQo+ID4g
PiANCj4gPiA+IERyaXZlcnMgZG8gbm90IHVzZSBjYXBpdGFsIGxldHRlcnMsIHNvIEkgaGF2ZSBk
b3VidHMgd2hldGhlciB0aGlzIGFsaWFzDQo+ID4gPiBpcyBjb3JyZWN0Lg0KPiA+IA0KPiA+IEkg
ZGlkbid0IGNhcmUgdGhlIHVwcGVyL2xvd2VyLWNhc2UuIEkgd2lsbCBjaGFuZ2UgdG8gbG93ZXIg
Y2FzZSBpbiBuZXh0DQo+ID4gdGltZS4NCj4gDQo+IFRoZW4gd2h5IGRvIHlvdSBuZWVkIHRoZSBh
bGlhcz8gVGhlIG5hbWUgZG9lcyBub3QgbWF0Y2ggZHJpdmVyIG5hbWUsIHNvDQo+IHdoYXQncyB0
aGUgcHVycG9zZSBvZiB0aGlzIGFsaWFzLw0KDQpJIHRoaW5rIGl0IGlzIG5vdCBzbyBuZWNlc3Nh
cnkgZm9yIHVzLiBJIHdpbGwgZGVsZXRlIHRoaXMgbGluZSBpbiBuZXh0DQp2ZXJzaW9uLg0KDQpP
bmx5IGN1cmlvdXMgd2hhdCdzIGFsaWFzIGlzIGZpdCBpbiBvdXIgY2FzZT8gbm9ybWFsbHkgaXQg
c2hvdWxkIGJlIHRoZQ0KZmlsZSBuYW1lOiBtdGstc21pPw0KDQo+IA0KPiA+IA0KPiA+IE1PRFVM
RV9BTElBUygicGxhdGZvcm06TWVkaWFUZWstc21pIikNCj4gPiANCj4gPiA+IA0KPiA+ID4gQWRk
aW5nIGFsbCB0aGVzZSBzaG91bGQgYmUgc3F1YXNoZWQgd2l0aCBjaGFuZ2luZyBLY29uZmlnIGlu
dG8gdHJpc3RhdGUuDQo+ID4gPiBJdCBkb2VzIG5vdCBoYXZlIHNlbnNlIG9uIGl0cyBvd24uDQo+
ID4gDQo+ID4gVGhhbmtzICB2ZXJ5IG11Y2ggZm9yIHJldmlldy4NCj4gPiANCj4gPiBPbmx5IGNv
bmZpcm06IFNxdWFzaCB3aG9sZSB0aGlzIHBhdGNoIG9yIG9ubHkgc3F1YXNoIHRoZSBNT0RVTEVf
eCBpbnRvDQo+ID4gdGhlIG5leHQgcGF0Y2g/DQo+IA0KPiBUaGlzIGVudGlyZSBwYXRjaCAyLzMg
c2hvdWxkIGJlIHdpdGggMy8zLg0KDQpUaGFua3MgZm9yIHRoZSBjb25maXJtLg0KDQo+IA0KPiBC
ZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KDQo=


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2CE23046FF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 19:50:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389951AbhAZRQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 12:16:09 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:39846 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726814AbhAZGNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 01:13:22 -0500
X-UUID: 9c99fcd34f814aa088a45e48dfc6c84a-20210126
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=2hSKPuelvgSnXJYZEXWh9wgPzMnweZ+FfzYCevNXc1E=;
        b=LlRFfdTTXboe/PRIPzD4V1rdiw98ADeknhH1DEpOscPqtRrTFP2tBBGfKzJMcSq6yy08NXdB1z+nYSmJY8yJ0Xjcss21SnNgUH9QhFELJLDgmzzvidcPgpPS1VyDsg7hn9/ybBPyHszLfyEyeNTjNyVIt5it+EcRx8kMZxMyqjg=;
X-UUID: 9c99fcd34f814aa088a45e48dfc6c84a-20210126
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1287511789; Tue, 26 Jan 2021 14:12:09 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 26 Jan
 2021 14:12:04 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 26 Jan 2021 14:12:04 +0800
Message-ID: <1611641524.5302.10.camel@mhfsdcap03>
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
Date:   Tue, 26 Jan 2021 14:12:04 +0800
In-Reply-To: <20210125104033.2ewzumhmagmouvo5@kozik-lap>
References: <20210121062429.26504-1-yong.wu@mediatek.com>
         <20210121062429.26504-3-yong.wu@mediatek.com>
         <20210122213427.mwjyjn2wsgnko7mk@kozik-lap>
         <1611557381.3184.21.camel@mhfsdcap03>
         <20210125084051.ipgeu2ksucdag2u4@kozik-lap>
         <1611566885.5302.4.camel@mhfsdcap03>
         <20210125104033.2ewzumhmagmouvo5@kozik-lap>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 8CD6A93D9A786D93DC46E5015D38F6B1D57C4AF0878B687D987EA2D78D9546862000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIxLTAxLTI1IGF0IDExOjQwICswMTAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiBPbiBNb24sIEphbiAyNSwgMjAyMSBhdCAwNToyODowNVBNICswODAwLCBZb25nIFd1
IHdyb3RlOg0KPiA+IE9uIE1vbiwgMjAyMS0wMS0yNSBhdCAwOTo0MCArMDEwMCwgS3J6eXN6dG9m
IEtvemxvd3NraSB3cm90ZToNCj4gPiA+IE9uIE1vbiwgSmFuIDI1LCAyMDIxIGF0IDAyOjQ5OjQx
UE0gKzA4MDAsIFlvbmcgV3Ugd3JvdGU6DQo+ID4gPiA+IE9uIEZyaSwgMjAyMS0wMS0yMiBhdCAy
MjozNCArMDEwMCwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gPiA+ID4gPiBPbiBUaHUs
IEphbiAyMSwgMjAyMSBhdCAwMjoyNDoyOFBNICswODAwLCBZb25nIFd1IHdyb3RlOg0KPiA+ID4g
PiA+ID4gVGhlIGNvbmZpZyBNVEtfU01JIGFsd2F5cyBkZXBlbmRzIG9uIE1US19JT01NVSB3aGlj
aCBpcyBidWlsdC1pbg0KPiA+ID4gPiA+ID4gY3VycmVudGx5LiBUaHVzIHdlIGRvbid0IGhhdmUg
bW9kdWxlX2V4aXQgYmVmb3JlLiBUaGlzIHBhdGNoIGFkZHMNCj4gPiA+ID4gPiA+IG1vZHVsZV9l
eGl0IGFuZCBtb2R1bGVfbGljZW5zZS4gSXQgaXMgYSBwcmVwYXJpbmcgcGF0Y2ggZm9yIHN1cHBv
cnRpbmcNCj4gPiA+ID4gPiA+IE1US19TTUkgY291bGQgYmVlbiBidWlsdCBhcyBhIG1vZHVsZS4N
Cj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogWW9uZyBXdSA8eW9uZy53
dUBtZWRpYXRlay5jb20+DQo+ID4gPiA+ID4gPiAtLS0NCj4gPiA+ID4gPiA+ICBkcml2ZXJzL21l
bW9yeS9tdGstc21pLmMgfCAxMCArKysrKysrKysrDQo+ID4gPiA+ID4gPiAgMSBmaWxlIGNoYW5n
ZWQsIDEwIGluc2VydGlvbnMoKykNCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvbWVtb3J5L210ay1zbWkuYyBiL2RyaXZlcnMvbWVtb3J5L210ay1zbWkuYw0K
PiA+ID4gPiA+ID4gaW5kZXggZTJhZWJkMmJmYThlLi5hYTJhMjVhYmYwNGYgMTAwNjQ0DQo+ID4g
PiA+ID4gPiAtLS0gYS9kcml2ZXJzL21lbW9yeS9tdGstc21pLmMNCj4gPiA+ID4gPiA+ICsrKyBi
L2RyaXZlcnMvbWVtb3J5L210ay1zbWkuYw0KPiA+ID4gPiA+ID4gQEAgLTU5NywzICs1OTcsMTMg
QEAgc3RhdGljIGludCBfX2luaXQgbXRrX3NtaV9pbml0KHZvaWQpDQo+ID4gPiA+ID4gPiAgCXJl
dHVybiBwbGF0Zm9ybV9yZWdpc3Rlcl9kcml2ZXJzKHNtaWRyaXZlcnMsIEFSUkFZX1NJWkUoc21p
ZHJpdmVycykpOw0KPiA+ID4gPiA+ID4gIH0NCj4gPiA+ID4gPiA+ICBtb2R1bGVfaW5pdChtdGtf
c21pX2luaXQpOw0KPiA+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ID4gK3N0YXRpYyB2b2lkIF9fZXhp
dCBtdGtfc21pX2V4aXQodm9pZCkNCj4gPiA+ID4gPiA+ICt7DQo+ID4gPiA+ID4gPiArCXBsYXRm
b3JtX3VucmVnaXN0ZXJfZHJpdmVycyhzbWlkcml2ZXJzLCBBUlJBWV9TSVpFKHNtaWRyaXZlcnMp
KTsNCj4gPiA+ID4gPiA+ICt9DQo+ID4gPiA+ID4gPiArbW9kdWxlX2V4aXQobXRrX3NtaV9leGl0
KTsNCj4gPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiA+ICtNT0RVTEVfREVTQ1JJUFRJT04oIk1lZGlh
VGVrIFNNSSBkcml2ZXIiKTsNCj4gPiA+ID4gPiA+ICtNT0RVTEVfQUxJQVMoInBsYXRmb3JtOk1l
ZGlhVGVrLVNNSSIpOw0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IERyaXZlcnMgZG8gbm90IHVzZSBj
YXBpdGFsIGxldHRlcnMsIHNvIEkgaGF2ZSBkb3VidHMgd2hldGhlciB0aGlzIGFsaWFzDQo+ID4g
PiA+ID4gaXMgY29ycmVjdC4NCj4gPiA+ID4gDQo+ID4gPiA+IEkgZGlkbid0IGNhcmUgdGhlIHVw
cGVyL2xvd2VyLWNhc2UuIEkgd2lsbCBjaGFuZ2UgdG8gbG93ZXIgY2FzZSBpbiBuZXh0DQo+ID4g
PiA+IHRpbWUuDQo+ID4gPiANCj4gPiA+IFRoZW4gd2h5IGRvIHlvdSBuZWVkIHRoZSBhbGlhcz8g
VGhlIG5hbWUgZG9lcyBub3QgbWF0Y2ggZHJpdmVyIG5hbWUsIHNvDQo+ID4gPiB3aGF0J3MgdGhl
IHB1cnBvc2Ugb2YgdGhpcyBhbGlhcy8NCj4gPiANCj4gPiBJIHRoaW5rIGl0IGlzIG5vdCBzbyBu
ZWNlc3NhcnkgZm9yIHVzLiBJIHdpbGwgZGVsZXRlIHRoaXMgbGluZSBpbiBuZXh0DQo+ID4gdmVy
c2lvbi4NCj4gPiANCj4gPiBPbmx5IGN1cmlvdXMgd2hhdCdzIGFsaWFzIGlzIGZpdCBpbiBvdXIg
Y2FzZT8gbm9ybWFsbHkgaXQgc2hvdWxkIGJlIHRoZQ0KPiA+IGZpbGUgbmFtZTogbXRrLXNtaT8N
Cj4gDQo+IElmIGF1dG9sb2FkaW5nIG9mIHlvdXIgbW9kdWxlIHdvcmtzLCB0aGVuIHJlbW92ZSBp
dC4gVGhlIGFsaWFzIGlzDQo+IG5lY2Vzc2FyeSBmb3Igc29tZSBjYXNlcyB3aGVuIGEgZGV2aWNl
IHRhYmxlIGlzIG1pc3NpbmcgKGUuZy4gcGxhdGZvcm0NCj4gZHJpdmVyIGlzIG1hdGNoZWQgdmlh
IGRldmljZXRyZWUgYnV0IG5vdCBoYXZpbmcgdGhlIHBsYXRmb3JtX2RldmljZV9pZA0KPiB0YWJs
ZSkgb3IgbWF0Y2hpbmcgaXMgZG9uZSB2aWEgZGlmZmVyZW50IG1ldGhvZCAoZS5nLiBkcml2ZXIg
aXMgbWF0Y2hlZA0KPiBmcm9tIE1GRCB2aWEgZGV2aWNldHJlZSBjb21wYXRpYmxlIGV2ZW4gdGhv
dWdoIHRoZXJlIGlzIGENCj4gcGxhdGZvcm1fZGV2aWNlX2lkIHRhYmxlKS4NCg0KVGhhbmtzIGZv
ciBleHBsYWluYXRpb24gc28gZGV0YWlsbHkuIHYyIGlzIHNlbnQganVzdCBub3cuDQoNCj4gDQo+
IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQoNCg==


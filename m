Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E35702CE561
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 02:48:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbgLDBry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 20:47:54 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:45333 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725849AbgLDBry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 20:47:54 -0500
X-UUID: 371c7f390b89419292440261733b9643-20201204
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=JDygK9+MlAzqYjO/vOov/ICG+of3dViKIL//ICXqI+c=;
        b=ZISH7iwdaGKul0mGgngyE8y6gio1Bwm2KXBv6OiHW38Sf9eGFLrKaH+MeuztTNfkWur7yGP7ZRir+2IEB38vo3qfNpK0K1BUh8esawEkaL/ous9/6jeL6FbTjg34ZHEYA6shlfAh+l5ZoBILX4CmnlhTyxH2mVKHKhvJoeHe9d4=;
X-UUID: 371c7f390b89419292440261733b9643-20201204
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 87168100; Fri, 04 Dec 2020 09:47:08 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by mtkmbs05n1.mediatek.inc
 (172.21.101.15) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 4 Dec
 2020 09:47:05 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 4 Dec 2020 09:47:04 +0800
Message-ID: <1607046425.7284.17.camel@mhfsdcap03>
Subject: Re: [PATCH] phy: mediatek: allow compile-testing the hdmi phy
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Arnd Bergmann <arnd@kernel.org>
CC:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        CK Hu <ck.hu@mediatek.com>, Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Date:   Fri, 4 Dec 2020 09:47:05 +0800
In-Reply-To: <20201203225418.1477560-1-arnd@kernel.org>
References: <20201203225418.1477560-1-arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIwLTEyLTAzIGF0IDIzOjU0ICswMTAwLCBBcm5kIEJlcmdtYW5uIHdyb3RlOg0K
PiBGcm9tOiBBcm5kIEJlcmdtYW5uIDxhcm5kQGFybmRiLmRlPg0KPiANCj4gQ29tcGlsZS10ZXN0
aW5nIHRoZSBEUk1fTUVESUFURUtfSERNSSBkcml2ZXIgbGVhZHMgdG8gYSBoYXJtbGVzcw0KPiB3
YXJuaW5nOg0KPiANCj4gV0FSTklORzogdW5tZXQgZGlyZWN0IGRlcGVuZGVuY2llcyBkZXRlY3Rl
ZCBmb3IgUEhZX01US19IRE1JDQo+ICAgRGVwZW5kcyBvbiBbbl06IEFSQ0hfTUVESUFURUsgWz1u
XSAmJiBPRiBbPXldDQo+ICAgU2VsZWN0ZWQgYnkgW3ldOg0KPiAgIC0gRFJNX01FRElBVEVLX0hE
TUkgWz15XSAmJiBIQVNfSU9NRU0gWz15XSAmJiBEUk1fTUVESUFURUsgWz15XQ0KPiANCj4gVGhl
IGRyaXZlciBidWlsZHMgZmluZSwgc28gYWxsb3cgY29tcGlsZS10ZXN0aW5nIGl0IGFzIHdlbGwN
Cj4gdG8gZ2V0IHJpZCBvZiB0aGUgd2FybmluZy4NCj4gDQo+IEZpeGVzOiBiMjhiZTU5YTJlMjYg
KCJwaHk6IG1lZGlhdGVrOiBNb3ZlIG10a19oZG1pX3BoeSBkcml2ZXIgaW50byBkcml2ZXJzL3Bo
eS9tZWRpYXRlayBmb2xkZXIiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBBcm5kIEJlcmdtYW5uIDxhcm5k
QGFybmRiLmRlPg0KPiAtLS0NCj4gIGRyaXZlcnMvcGh5L21lZGlhdGVrL0tjb25maWcgfCA0ICsr
Ky0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4g
DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BoeS9tZWRpYXRlay9LY29uZmlnIGIvZHJpdmVycy9w
aHkvbWVkaWF0ZWsvS2NvbmZpZw0KPiBpbmRleCA2NWVkMjZlNDBjOWYuLjI5YTg1YjI3MzhmOCAx
MDA2NDQNCj4gLS0tIGEvZHJpdmVycy9waHkvbWVkaWF0ZWsvS2NvbmZpZw0KPiArKysgYi9kcml2
ZXJzL3BoeS9tZWRpYXRlay9LY29uZmlnDQo+IEBAIC00MCw3ICs0MCw5IEBAIGNvbmZpZyBQSFlf
TVRLX1hTUEhZDQo+ICANCj4gIGNvbmZpZyBQSFlfTVRLX0hETUkNCj4gIAl0cmlzdGF0ZSAiTWVk
aWFUZWsgSERNSS1QSFkgRHJpdmVyIg0KPiAtCWRlcGVuZHMgb24gQVJDSF9NRURJQVRFSyAmJiBP
Rg0KPiArCWRlcGVuZHMgb24gQVJDSF9NRURJQVRFSyB8fCBDT01QSUxFX1RFU1QNCj4gKwlkZXBl
bmRzIG9uIENPTU1PTl9DTEsNClNlZW1zIG5vIG5lZWQgYWRkIENPTU1PTl9DTEsgaGVyZQ0KDQo+
ICsJZGVwZW5kcyBvbiBPRg0KPiAgCXNlbGVjdCBHRU5FUklDX1BIWQ0KPiAgCWhlbHANCj4gIAkg
IFN1cHBvcnQgSERNSSBQSFkgZm9yIE1lZGlhdGVrIFNvQ3MuDQoNCg==


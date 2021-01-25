Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D704302243
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 07:55:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbhAYGwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 01:52:30 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:3763 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727166AbhAYGun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 01:50:43 -0500
X-UUID: fd0e93103f1d4f8aa52a818e05d5f6e2-20210125
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=chRfsW5UPIrsCGcAQg3ddEyEhCQ/dYzTCA0hmQUJvJM=;
        b=rMrwSTwP2W56HGFPRjZmlZq/VLfheKcS+MDIESU2q1A6ZEZDmiosT7W0VznAkk7StXa+S2Sz2sQQadLpXZFrDKro8DYdRe4wrEsjuHDtULew9ab+3u60u0PWrHybXPGGHIY5uY63Bfxnuf2FwV8WI+8pQXcpiKAqka6QBE2XqV8=;
X-UUID: fd0e93103f1d4f8aa52a818e05d5f6e2-20210125
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 3668096; Mon, 25 Jan 2021 14:49:46 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 25 Jan
 2021 14:49:42 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 25 Jan 2021 14:49:41 +0800
Message-ID: <1611557381.3184.21.camel@mhfsdcap03>
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
Date:   Mon, 25 Jan 2021 14:49:41 +0800
In-Reply-To: <20210122213427.mwjyjn2wsgnko7mk@kozik-lap>
References: <20210121062429.26504-1-yong.wu@mediatek.com>
         <20210121062429.26504-3-yong.wu@mediatek.com>
         <20210122213427.mwjyjn2wsgnko7mk@kozik-lap>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 1FA87B06CC3B3754A9FB2810156820CA7B9663E05E7BC37A175827580DDF19EC2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIxLTAxLTIyIGF0IDIyOjM0ICswMTAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiBPbiBUaHUsIEphbiAyMSwgMjAyMSBhdCAwMjoyNDoyOFBNICswODAwLCBZb25nIFd1
IHdyb3RlOg0KPiA+IFRoZSBjb25maWcgTVRLX1NNSSBhbHdheXMgZGVwZW5kcyBvbiBNVEtfSU9N
TVUgd2hpY2ggaXMgYnVpbHQtaW4NCj4gPiBjdXJyZW50bHkuIFRodXMgd2UgZG9uJ3QgaGF2ZSBt
b2R1bGVfZXhpdCBiZWZvcmUuIFRoaXMgcGF0Y2ggYWRkcw0KPiA+IG1vZHVsZV9leGl0IGFuZCBt
b2R1bGVfbGljZW5zZS4gSXQgaXMgYSBwcmVwYXJpbmcgcGF0Y2ggZm9yIHN1cHBvcnRpbmcNCj4g
PiBNVEtfU01JIGNvdWxkIGJlZW4gYnVpbHQgYXMgYSBtb2R1bGUuDQo+ID4gDQo+ID4gU2lnbmVk
LW9mZi1ieTogWW9uZyBXdSA8eW9uZy53dUBtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4gIGRy
aXZlcnMvbWVtb3J5L210ay1zbWkuYyB8IDEwICsrKysrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5n
ZWQsIDEwIGluc2VydGlvbnMoKykNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tZW1v
cnkvbXRrLXNtaS5jIGIvZHJpdmVycy9tZW1vcnkvbXRrLXNtaS5jDQo+ID4gaW5kZXggZTJhZWJk
MmJmYThlLi5hYTJhMjVhYmYwNGYgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9tZW1vcnkvbXRr
LXNtaS5jDQo+ID4gKysrIGIvZHJpdmVycy9tZW1vcnkvbXRrLXNtaS5jDQo+ID4gQEAgLTU5Nywz
ICs1OTcsMTMgQEAgc3RhdGljIGludCBfX2luaXQgbXRrX3NtaV9pbml0KHZvaWQpDQo+ID4gIAly
ZXR1cm4gcGxhdGZvcm1fcmVnaXN0ZXJfZHJpdmVycyhzbWlkcml2ZXJzLCBBUlJBWV9TSVpFKHNt
aWRyaXZlcnMpKTsNCj4gPiAgfQ0KPiA+ICBtb2R1bGVfaW5pdChtdGtfc21pX2luaXQpOw0KPiA+
ICsNCj4gPiArc3RhdGljIHZvaWQgX19leGl0IG10a19zbWlfZXhpdCh2b2lkKQ0KPiA+ICt7DQo+
ID4gKwlwbGF0Zm9ybV91bnJlZ2lzdGVyX2RyaXZlcnMoc21pZHJpdmVycywgQVJSQVlfU0laRShz
bWlkcml2ZXJzKSk7DQo+ID4gK30NCj4gPiArbW9kdWxlX2V4aXQobXRrX3NtaV9leGl0KTsNCj4g
PiArDQo+ID4gK01PRFVMRV9ERVNDUklQVElPTigiTWVkaWFUZWsgU01JIGRyaXZlciIpOw0KPiA+
ICtNT0RVTEVfQUxJQVMoInBsYXRmb3JtOk1lZGlhVGVrLVNNSSIpOw0KPiANCj4gRHJpdmVycyBk
byBub3QgdXNlIGNhcGl0YWwgbGV0dGVycywgc28gSSBoYXZlIGRvdWJ0cyB3aGV0aGVyIHRoaXMg
YWxpYXMNCj4gaXMgY29ycmVjdC4NCg0KSSBkaWRuJ3QgY2FyZSB0aGUgdXBwZXIvbG93ZXItY2Fz
ZS4gSSB3aWxsIGNoYW5nZSB0byBsb3dlciBjYXNlIGluIG5leHQNCnRpbWUuDQoNCk1PRFVMRV9B
TElBUygicGxhdGZvcm06TWVkaWFUZWstc21pIikNCg0KPiANCj4gQWRkaW5nIGFsbCB0aGVzZSBz
aG91bGQgYmUgc3F1YXNoZWQgd2l0aCBjaGFuZ2luZyBLY29uZmlnIGludG8gdHJpc3RhdGUuDQo+
IEl0IGRvZXMgbm90IGhhdmUgc2Vuc2Ugb24gaXRzIG93bi4NCg0KVGhhbmtzICB2ZXJ5IG11Y2gg
Zm9yIHJldmlldy4NCg0KT25seSBjb25maXJtOiBTcXVhc2ggd2hvbGUgdGhpcyBwYXRjaCBvciBv
bmx5IHNxdWFzaCB0aGUgTU9EVUxFX3ggaW50bw0KdGhlIG5leHQgcGF0Y2g/DQoNCj4gDQo+IEJl
c3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQoNCg==


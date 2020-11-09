Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9F3C2AAECF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 02:47:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729035AbgKIBrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 20:47:16 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:20611 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727979AbgKIBrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 20:47:16 -0500
X-UUID: ddfddffd2ea0464d873a0b59667f16e6-20201109
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=P2/u2G2PWkxrVDOi7euvixdoAYgr4i4zVGrK1c98XqI=;
        b=bW6/AYYJ6dsXDslM5kKRFAy0RAuZ8lA20HPypc+46xtn2jRAvNHpwUR5TLHeO4pCh3zkYX/xcpa5sRu2dwXIhQJClxcNiUPNsek+1MxvHCa9ZmMuHhXYbi/upqwqmnpyKO4Qi/1cxI4g694YtN0elmY8KsqCbqhcuvxlAhVii0E=;
X-UUID: ddfddffd2ea0464d873a0b59667f16e6-20201109
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1578670776; Mon, 09 Nov 2020 09:47:12 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS32N1.mediatek.inc
 (172.27.4.71) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 9 Nov
 2020 09:47:10 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 9 Nov 2020 09:47:10 +0800
Message-ID: <1604886429.31607.20.camel@mhfsdcap03>
Subject: Re: [PATCH 3/3] MAINTAINERS: add files for Mediatek DRM drivers
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, Vinod Koul <vkoul@kernel.org>
Date:   Mon, 9 Nov 2020 09:47:09 +0800
In-Reply-To: <CAAOTY__ZRLubBfNtMFMax8SubM9f9iKLXGzS+bXseXcd9V0Smg@mail.gmail.com>
References: <20201029152702.533-1-chunkuang.hu@kernel.org>
         <20201029152702.533-4-chunkuang.hu@kernel.org>
         <CAAOTY__ZRLubBfNtMFMax8SubM9f9iKLXGzS+bXseXcd9V0Smg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 18D2AF7C1A1FFBD221F4820A9D115C9E1FA2F4AA454C834A65245B32E995E8E02000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU3VuLCAyMDIwLTExLTA4IGF0IDExOjA0ICswODAwLCBDaHVuLUt1YW5nIEh1IHdyb3RlOg0K
PiArIFZpbm9kOg0KPiANCj4gSGksIENodW5mZW5nOg0KPiANCj4gQ2h1bi1LdWFuZyBIdSA8Y2h1
bmt1YW5nLmh1QGtlcm5lbC5vcmc+IOaWvCAyMDIw5bm0MTDmnIgyOeaXpSDpgLHlm5sg5LiL5Y2I
MTE6Mjjlr6vpgZPvvJoNCj4gPg0KPiA+IE1lZGlhdGVrIE1JUEkgRFNJIHBoeSBkcml2ZXIgaXMg
bW92ZWQgZnJvbSBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsgdG8NCj4gPiBkcml2ZXJzL3BoeS9t
ZWRpYXRlaywgc28gYWRkIHRoZSBuZXcgZm9sZGVyIHRvIHRoZSBNZWRpYXRlayBEUk0gZHJpdmVy
cycNCj4gPiBpbmZvcm1hdGlvbi4NCj4gDQo+IFdvdWxkIHlvdSBsaWtlIHRoaXMgcGF0Y2g/IElm
IHNvLCB5b3UgY291bGQgZ2l2ZSBhbiBhY2tlZC1ieSB0YWcgb24NCj4gdGhpcyBwYXRjaCwgc28g
SSBjb3VsZCBhcHBsaWVkIHRoZSB3aG9sZSBzZXJpZXMgaW50byBteSB0cmVlLg0KQWNrZWQtYnk6
IENodW5mZW5nIFl1biA8Y2h1bmZlbmcueXVuQG1lZGlhdGVrLmNvbT4NCg0KVGhhbmtzDQoNCj4g
DQo+IFJlZ2FyZHMsDQo+IENodW4tS3VhbmcuDQo+IA0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTog
Q2h1bi1LdWFuZyBIdSA8Y2h1bmt1YW5nLmh1QGtlcm5lbC5vcmc+DQo+ID4gLS0tDQo+ID4gIE1B
SU5UQUlORVJTIHwgMSArDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPiA+
DQo+ID4gZGlmZiAtLWdpdCBhL01BSU5UQUlORVJTIGIvTUFJTlRBSU5FUlMNCj4gPiBpbmRleCBl
NzM2MzZiNzVmMjkuLjE0ZjUwMThjMDFiNiAxMDA2NDQNCj4gPiAtLS0gYS9NQUlOVEFJTkVSUw0K
PiA+ICsrKyBiL01BSU5UQUlORVJTDQo+ID4gQEAgLTU4NjcsNiArNTg2Nyw3IEBAIFM6ICAgICAg
ICBTdXBwb3J0ZWQNCj4gPiAgRjogICAgIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9kaXNwbGF5L21lZGlhdGVrLw0KPiA+ICBGOiAgICAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVr
Lw0KPiA+ICBGOiAgICAgZHJpdmVycy9waHkvbWVkaWF0ZWsvcGh5LW10ay1oZG1pKg0KPiA+ICtG
OiAgICAgZHJpdmVycy9waHkvbWVkaWF0ZWsvcGh5LW10ay1taXBpKg0KPiA+DQo+ID4gIERSTSBE
UklWRVJTIEZPUiBOVklESUEgVEVHUkENCj4gPiAgTTogICAgIFRoaWVycnkgUmVkaW5nIDx0aGll
cnJ5LnJlZGluZ0BnbWFpbC5jb20+DQo+ID4gLS0NCj4gPiAyLjE3LjENCj4gPg0KDQo=


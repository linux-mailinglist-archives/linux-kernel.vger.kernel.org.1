Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 530BF2E2661
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Dec 2020 12:30:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728402AbgLXL2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Dec 2020 06:28:30 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:59402 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726591AbgLXL23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Dec 2020 06:28:29 -0500
X-UUID: ebeceb543e594724afb82df797d9e1e0-20201224
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=DiOcFw9Kf9pbbQaIqyaauDc19jifokyiHRLy79w4/TI=;
        b=jwcGv8V43FrvfSVlCDjy+v1PddpLpwqrdatyeFgTUsxMHZ7DOEIRDg2rNsyMywODMyJqp2ornAd8rbcdfkf1vZFL67YGqgwLiZiOuEdFuMXUIG8PFhCPJEhu1ZWbk55eAxZurHzXOvaE5Cn5k3dm+9z3iaBYw8glN8H0Q1qe2Jo=;
X-UUID: ebeceb543e594724afb82df797d9e1e0-20201224
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 626282406; Thu, 24 Dec 2020 19:27:38 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS32N1.mediatek.inc
 (172.27.4.71) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 24 Dec
 2020 19:27:36 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 24 Dec 2020 19:27:36 +0800
Message-ID: <1608809257.26323.259.camel@mhfsdcap03>
Subject: Re: [PATCH v3 1/7] iommu: Move iotlb_sync_map out from __iommu_map
From:   Yong Wu <yong.wu@mediatek.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        "Robin Murphy" <robin.murphy@arm.com>, <youlin.pei@mediatek.com>,
        <anan.sun@mediatek.com>, Nicolas Boichat <drinkcat@chromium.org>,
        <srv_heupstream@mediatek.com>, <chao.hao@mediatek.com>,
        <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "Tomasz Figa" <tfiga@google.com>,
        <iommu@lists.linux-foundation.org>,
        <linux-mediatek@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Greg Kroah-Hartman <gregkh@google.com>,
        <kernel-team@android.com>, <linux-arm-kernel@lists.infradead.org>
Date:   Thu, 24 Dec 2020 19:27:37 +0800
In-Reply-To: <20201223085153.GA30643@infradead.org>
References: <20201216103607.23050-1-yong.wu@mediatek.com>
         <20201216103607.23050-2-yong.wu@mediatek.com>
         <20201223085153.GA30643@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: FBCE9ED43BF43E3D7C20C416E2E03E98E6E841E4758068BCA32988C6FE2A5E212000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIwLTEyLTIzIGF0IDA4OjUxICswMDAwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90
ZToNCj4gT24gV2VkLCBEZWMgMTYsIDIwMjAgYXQgMDY6MzY6MDFQTSArMDgwMCwgWW9uZyBXdSB3
cm90ZToNCj4gPiBJbiB0aGUgZW5kIG9mIF9faW9tbXVfbWFwLCBJdCBhbHdheSBjYWxsIGlvdGxi
X3N5bmNfbWFwLg0KPiA+IFRoaXMgcGF0Y2ggbW92ZXMgaW90bGJfc3luY19tYXAgb3V0IGZyb20g
X19pb21tdV9tYXAgc2luY2UgaXQgaXMNCj4gPiB1bm5lY2Vzc2FyeSB0byBjYWxsIHRoaXMgZm9y
IGVhY2ggc2cgc2VnbWVudCBlc3BlY2lhbGx5IGlvdGxiX3N5bmNfbWFwDQo+ID4gaXMgZmx1c2gg
dGxiIGFsbCBjdXJyZW50bHkuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogWW9uZyBXdSA8eW9u
Zy53dUBtZWRpYXRlay5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6IFJvYmluIE11cnBoeSA8cm9iaW4u
bXVycGh5QGFybS5jb20+DQo+IA0KPiBXaGF0IGFib3V0IGFkZGluZyBhIGxpdHRsZSBoZWxwZXIg
dGhhdCBkb2VzIHRoZSBOVUxMIGNoZWNrIGFuZCBtZXRob2QNCj4gY2FsbCBpbnN0ZWFkIG9mIGR1
cGxpY2F0aW5nIGl0IGFsbCBvdmVyPw0KDQpUaGFua3MgZm9yIHRoZSByZXZpZXcuIE9mIGNvdXJz
ZSBPSy4NCg0KVGhlbiB0aGUgY29kZSBsaWtlIGJlbG93LiANCihJZiB0aGUgaGVscGVyIG5hbWUg
Il9pb21tdV9tYXAiIGlzIG5vdCBnb29kLCBwbGVhc2UgdGVsbCBtZS4pDQoNCitzdGF0aWMgaW50
IF9pb21tdV9tYXAoc3RydWN0IGlvbW11X2RvbWFpbiAqZG9tYWluLCB1bnNpZ25lZCBsb25nIGlv
dmEsDQorCQkgICAgICAgcGh5c19hZGRyX3QgcGFkZHIsIHNpemVfdCBzaXplLCBpbnQgcHJvdCwg
Z2ZwX3QgZ2ZwKQ0KK3sNCisJY29uc3Qgc3RydWN0IGlvbW11X29wcyAqb3BzID0gZG9tYWluLT5v
cHM7DQorCWludCByZXQ7DQorDQorCXJldCA9IF9faW9tbXVfbWFwKGRvbWFpbiwgaW92YSwgcGFk
ZHIsIHNpemUsIHByb3QsIGdmcCk7DQorCWlmIChyZXQgPT0gMCAmJiBvcHMtPmlvdGxiX3N5bmNf
bWFwKQ0KKwkJb3BzLT5pb3RsYl9zeW5jX21hcChkb21haW4pOw0KKwlyZXR1cm4gcmV0Ow0KK30N
CisNCiBpbnQgaW9tbXVfbWFwKHN0cnVjdCBpb21tdV9kb21haW4gKmRvbWFpbiwgdW5zaWduZWQg
bG9uZyBpb3ZhLA0KIAkgICAgICBwaHlzX2FkZHJfdCBwYWRkciwgc2l6ZV90IHNpemUsIGludCBw
cm90KQ0KIHsNCiAJbWlnaHRfc2xlZXAoKTsNCi0JcmV0dXJuIF9faW9tbXVfbWFwKGRvbWFpbiwg
aW92YSwgcGFkZHIsIHNpemUsIHByb3QsIEdGUF9LRVJORUwpOw0KKwlyZXR1cm4gX2lvbW11X21h
cChkb21haW4sIGlvdmEsIHBhZGRyLCBzaXplLCBwcm90LCBHRlBfS0VSTkVMKTsNCiB9DQogRVhQ
T1JUX1NZTUJPTF9HUEwoaW9tbXVfbWFwKTsNCiANCiBpbnQgaW9tbXVfbWFwX2F0b21pYyhzdHJ1
Y3QgaW9tbXVfZG9tYWluICpkb21haW4sIHVuc2lnbmVkIGxvbmcgaW92YSwNCiAJICAgICAgcGh5
c19hZGRyX3QgcGFkZHIsIHNpemVfdCBzaXplLCBpbnQgcHJvdCkNCiB7DQotCXJldHVybiBfX2lv
bW11X21hcChkb21haW4sIGlvdmEsIHBhZGRyLCBzaXplLCBwcm90LCBHRlBfQVRPTUlDKTsNCisJ
cmV0dXJuIF9pb21tdV9tYXAoZG9tYWluLCBpb3ZhLCBwYWRkciwgc2l6ZSwgcHJvdCwgR0ZQX0FU
T01JQyk7DQogfQ0KIEVYUE9SVF9TWU1CT0xfR1BMKGlvbW11X21hcF9hdG9taWMpOw0KDQo=


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF10304976
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 21:02:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732844AbhAZF2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 00:28:03 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:64656 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727331AbhAYKMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 05:12:44 -0500
X-UUID: d00b039ff7fc4da48cc5d66e8a1fd2c7-20210125
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=y2RDQNIxeBbr5oP9MQDxQ2RnX+SiaVSuN0aKLK4cDXM=;
        b=gLX+kveBxzWW8RV3tiF5QN0UxdfmN7/caF+k+1COnfxq0yOYWrMGjOO72MProaUbXwJVfNLwYUs5ry65eGDhtMou/7BexP1I5T+/5kwWC2n2qQBCsebSvCnUZVodLaGaqLL/rGBW9EijtNy3xeDX3972NtSbOpICq0pGIue0/BY=;
X-UUID: d00b039ff7fc4da48cc5d66e8a1fd2c7-20210125
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1075218079; Mon, 25 Jan 2021 18:11:06 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 25 Jan
 2021 18:11:00 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 25 Jan 2021 18:11:00 +0800
Message-ID: <1611569460.5302.7.camel@mhfsdcap03>
Subject: Re: [PATCH 3/3] memory: mtk-smi: Switch MTK_SMI to tristate
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
Date:   Mon, 25 Jan 2021 18:11:00 +0800
In-Reply-To: <20210125084450.wurwhi2hbbuueapy@kozik-lap>
References: <20210121062429.26504-1-yong.wu@mediatek.com>
         <20210121062429.26504-4-yong.wu@mediatek.com>
         <20210122213558.qnboqc4obdmipxs4@kozik-lap>
         <1611557384.3184.22.camel@mhfsdcap03>
         <20210125084450.wurwhi2hbbuueapy@kozik-lap>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: C65905790A739B480B6FC175A3CD459FDCB438FD07C4250FE662618E0D5C5FF12000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIxLTAxLTI1IGF0IDA5OjQ0ICswMTAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiBPbiBNb24sIEphbiAyNSwgMjAyMSBhdCAwMjo0OTo0NFBNICswODAwLCBZb25nIFd1
IHdyb3RlOg0KPiA+IE9uIEZyaSwgMjAyMS0wMS0yMiBhdCAyMjozNSArMDEwMCwgS3J6eXN6dG9m
IEtvemxvd3NraSB3cm90ZToNCj4gPiA+IE9uIFRodSwgSmFuIDIxLCAyMDIxIGF0IDAyOjI0OjI5
UE0gKzA4MDAsIFlvbmcgV3Ugd3JvdGU6DQo+ID4gPiA+IFRoaXMgcGF0Y2ggc3dpdGNoZXMgTVRL
X1NNSSB0byB0cmlzdGF0ZS4gU3VwcG9ydCBpdCBjb3VsZCBiZSAnbScuDQo+ID4gPiA+IA0KPiA+
ID4gPiBNZWFud2hpbGUsIEZpeCBhIGJ1aWxkIGlzc3VlIHdoaWxlIE1US19TTUkgaXMgYnVpbHQg
YXMgbW9kdWxlLg0KPiA+ID4gDQo+ID4gPiBzL0ZpeC9maXguDQo+ID4gPiANCj4gPiA+IFdoYXQg
ZXJyb3IgaXMgYmVpbmcgZml4ZWQgaGVyZT8gSG93IGNhbiBJIHJlcHJvZHVjZSBpdD8gQXJlbid0
IHlvdSBqdXN0DQo+ID4gPiBhZGp1c3RpbmcgaXQgdG8gYmVpbmcgYnVpbGRhYmxlIGJ5IG1vZHVs
ZT8NCj4gPiANCj4gPiBTb3JyeSwgSSBkaWRuJ3QgY29weSB0aGUgZmFpbCBsb2cgaGVyZS4gVGhp
cyBpcyB0aGUgYnVpbGQgbG9nOg0KPiA+IA0KPiA+IEluIGZpbGUgaW5jbHVkZWQgZnJvbSAuLi4v
ZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYzozNDowOg0KPiA+IC4uLi9kcml2ZXJzL2lvbW11L210
a19pb21tdS5oOjg0OjI4OiBlcnJvcjogYXJyYXkgdHlwZSBoYXMgaW5jb21wbGV0ZQ0KPiA+IGVs
ZW1lbnQgdHlwZSAnc3RydWN0IG10a19zbWlfbGFyYl9pb21tdScNCj4gPiAgIHN0cnVjdCBtdGtf
c21pX2xhcmJfaW9tbXUgbGFyYl9pbXVbTVRLX0xBUkJfTlJfTUFYXTsNCj4gPiANCj4gPiBPdXIg
aW9tbXUgZHJpdmVyIHdpbGwgdXNlIHRoaXMgc3RydWN0dXJlLiBidXQgaXQgd2FzIGNvbnRhaW5l
ZCBieQ0KPiA+ICIjaWZkZWYgQ09ORklHX01US19TTUkiLiB0aHVzIEkgY2hhbmdlIGl0IHRvICIj
aWYNCj4gPiBJU19FTkFCTEVEKENPTkZJR19NVEtfU01JKSINCj4gPiANCj4gPiBJZiByZXByb2R1
Y2luZyBpdCwgd2Ugc2hvdWxkIGNoYW5nZSBtdGstaW9tbXUgdG8gbW9kdWxlX2luaXRbMV0uIGFu
ZA0KPiA+IHN3aXRjaCBrY29uZmlnIE1US19JT01NVSB0byB0cmlzdGF0ZSwgdGhlbiBjaGFuZ2Ug
dGhlIENPTkZJR19NVEtfSU9NTVUNCj4gPiB0byBtLiB3ZSBjb3VsZCBnZXQgdGhlIGZhaWwgbG9n
Lg0KPiA+IA0KPiA+IEluIHRoaXMgY2FzZSwgU2hvdWxkIEkgc3F1YXNoIHRoaXMgY2hhbmdlIGlu
dG8gdGhpcyBwYXRjaD8gSSB0aG91Z2ggdGhpcw0KPiA+IGlzIGEgcHJlcGFyaW5nIHBhdGNoIGFu
ZCB0aGUgZmFpbCBpcyBjYXVzZWQgYnkgTVRLX1NNSS4gdGh1cyBJIHNxdWFzaA0KPiA+IHRoYXQg
aW50byB0aGlzIHBhdGNoLiBvciBjaGFuZ2UgaXQgYXMgYSBpbmRlcGVuZGVudCBwYXRjaCBhbmQg
c2VuZCB3aGVuDQo+ID4gSSBjaGFuZ2UgTVRLX0lPTU1VIHRvIHRyaXN0YXRlPw0KPiANCj4gSWYg
SSB1bmRlcnN0YW5kIGNvcnJlY3RseSwgdGhlcmUgaXMgbm8gZXJyb3IgYmVmb3JlIHRoaXMgcGF0
Y2guIEluIHN1Y2gNCj4gY2FzZSBqdXN0IGRvbid0IG1lbnRpb24gdGhlIGVycm9yIHRvIGZpeCwg
YmVjYXVzZSBpdCBpcyBzaW1wbHkgcGFydCBvZg0KPiBtYWtpbmcgdGhpbmdzIG1vZHVsYXIuDQoN
Clllcy4gTm8gZXJyb3IgYmVmb3JlIHRoaXMgcGF0Y2guDQoNCkFwcHJlY2lhdGUgZm9yIHlvdXIg
aGVscC4gSSB3aWxsIHJlbW92ZSB0aGlzIGluIHRoZSBjb21tZW50IG1lc3NhZ2UgaW4NCnRoZSBu
ZXh0IHZlcnNpb24uDQoNCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQo+IA0KDQo=


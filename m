Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8D02C36BE
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 03:31:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgKYCYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 21:24:13 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:45950 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725287AbgKYCYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 21:24:13 -0500
X-UUID: 33427ef041924e9da7fc4557534255af-20201125
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=WL55vboZZ3dXagtqBYzxQcXVcZpJORx9ydPC+NvFj5k=;
        b=NCA0F+algkuaRNJd7Fkwdgw4rplW6l5UI7bv4703xoMuEOiKgrkM+AwGbxk4aBoaGydjlmPfHti0OUjT0HB+Q/rlHf8gJ3m2eLViNi/Rq0Xi0AA9p7IOM1ZHhUDB0IwRXhnMzQikLhm3eAYqaXjMjs4ObduEceJkwJ07sWBtMQs=;
X-UUID: 33427ef041924e9da7fc4557534255af-20201125
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 895069048; Wed, 25 Nov 2020 10:24:08 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS32N2.mediatek.inc
 (172.27.4.72) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 25 Nov
 2020 10:24:04 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 25 Nov 2020 10:24:04 +0800
Message-ID: <1606271044.32484.20.camel@mhfsdcap03>
Subject: Re: [PATCH] phy/mediatek: Make PHY_MTK_XSPHY depend on HAS_IOMEM
 and OF_ADDRESS to fix build errors
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
CC:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Xuefeng Li <lixuefeng@loongson.cn>
Date:   Wed, 25 Nov 2020 10:24:04 +0800
In-Reply-To: <1606211233-7425-1-git-send-email-yangtiezhu@loongson.cn>
References: <1606211233-7425-1-git-send-email-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 9FB0A06CCF3590F0103C7A554F82C24ADD8313A5CDDE3B0898BB4E8F8795A64D2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVGllemh1LA0KDQpPbiBUdWUsIDIwMjAtMTEtMjQgYXQgMTc6NDcgKzA4MDAsIFRpZXpodSBZ
YW5nIHdyb3RlOg0KPiBkZXZtX2lvcmVtYXBfcmVzb3VyY2UoKSB3aWxsIGJlIG5vdCBidWlsdCBp
biBsaWIvZGV2cmVzLmMgaWYNCj4gQ09ORklHX0hBU19JT01FTSBpcyBub3Qgc2V0LCBvZl9hZGRy
ZXNzX3RvX3Jlc291cmNlKCkgd2lsbCBiZQ0KPiBub3QgYnVpbHQgaW4gZHJpdmVycy9vZi9hZGRy
ZXNzLmMgaWYgQ09ORklHX09GX0FERFJFU1MgaXMgbm90DQo+IHNldCwgYW5kIHRoZW4gdGhlcmUg
ZXhpc3RzIHR3byBidWlsZCBlcnJvcnMgYWJvdXQgdW5kZWZpbmVkDQo+IHJlZmVyZW5jZSB0byAi
ZGV2bV9pb3JlbWFwX3Jlc291cmNlIiBhbmQgIm9mX2FkZHJlc3NfdG9fcmVzb3VyY2UiDQo+IGlu
IHBoeS1tdGsteHNwaHkuYyB1bmRlciBDT01QSUxFX1RFU1QgYW5kIENPTkZJR19QSFlfTVRLX1hT
UEhZLA0KPiBtYWtlIFBIWV9NVEtfWFNQSFkgZGVwZW5kIG9uIEhBU19JT01FTSBhbmQgT0ZfQURE
UkVTUyB0byBmaXggaXQuDQo+IA0KPiBSZXBvcnRlZC1ieToga2VybmVsIHRlc3Qgcm9ib3QgPGxr
cEBpbnRlbC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFRpZXpodSBZYW5nIDx5YW5ndGllemh1QGxv
b25nc29uLmNuPg0KPiAtLS0NCj4gIGRyaXZlcnMvcGh5L21lZGlhdGVrL0tjb25maWcgfCAyICsr
DQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9waHkvbWVkaWF0ZWsvS2NvbmZpZyBiL2RyaXZlcnMvcGh5L21lZGlhdGVrL0tjb25m
aWcNCj4gaW5kZXggNTBjNWU5My4uNjZkZjA0NSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9waHkv
bWVkaWF0ZWsvS2NvbmZpZw0KPiArKysgYi9kcml2ZXJzL3BoeS9tZWRpYXRlay9LY29uZmlnDQo+
IEBAIC0zMCw2ICszMCw4IEBAIGNvbmZpZyBQSFlfTVRLX1hTUEhZDQo+ICAJdHJpc3RhdGUgIk1l
ZGlhVGVrIFhTLVBIWSBEcml2ZXIiDQo+ICAJZGVwZW5kcyBvbiBBUkNIX01FRElBVEVLIHx8IENP
TVBJTEVfVEVTVA0KPiAgCWRlcGVuZHMgb24gT0YNCj4gKwlkZXBlbmRzIG9uIEhBU19JT01FTQ0K
PiArCWRlcGVuZHMgb24gT0ZfQUREUkVTUw0KV2h5IG5vdCBhZGQgdGhlbSBpbnRvIGRlY29uZmln
IGJ1dCBoZXJlPyBJbiBmYWN0IEkgZG9uJ3Qga25vdyB3aGljaCB3YXkNCmlzIGJldHRlciBhbmQg
Zm9sbG93IHRoZSBrZXJuZWwgcnVsZS4NCg0KVmlub2QgYW5kIEtpc2hvbiwgZG8geW91IGhhdmUg
YW55IHN1Z2dlc3Rpb24gYWJvdXQgdGhpcz8NCg0KPiAgCXNlbGVjdCBHRU5FUklDX1BIWQ0KPiAg
CWhlbHANCj4gIAkgIEVuYWJsZSB0aGlzIHRvIHN1cHBvcnQgdGhlIFN1cGVyU3BlZWRQbHVzIFhT
LVBIWSB0cmFuc2NlaXZlciBmb3INCg0K


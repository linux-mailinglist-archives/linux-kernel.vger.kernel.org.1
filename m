Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBA002844CB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 06:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgJFE1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 00:27:08 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:47901 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725945AbgJFE1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 00:27:08 -0400
X-UUID: 3183a9b802d14886b6c434936fa1fa91-20201006
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=F3q8g07MfBf3wWRXqT3A3dyLSwe2uEIEqVCHGrlInMs=;
        b=lzgHnzMd4LPi1c4revL5Qjp1cHT8mEqYc5bsGwxTfIWD2r9GKussY2Eiit11KUdBgZzoTulQOJUiY5E64t47U1LK0lcF6olSX3Isa/EpOvKuujLah63tLi1rpQLi/GfQIt8uPZYtaaIHw7crJNlyOYSa6qqOMl5VaO6DXAuoqv0=;
X-UUID: 3183a9b802d14886b6c434936fa1fa91-20201006
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 439787702; Tue, 06 Oct 2020 12:26:47 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS32N2.mediatek.inc
 (172.27.4.72) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 6 Oct
 2020 12:26:46 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 6 Oct 2020 12:26:44 +0800
Message-ID: <1601958405.26323.24.camel@mhfsdcap03>
Subject: Re: [PATCH v3 06/24] dt-bindings: mediatek: Add binding for mt8192
 IOMMU
From:   Yong Wu <yong.wu@mediatek.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
CC:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Tomasz Figa <tfiga@google.com>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <youlin.pei@mediatek.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        <anan.sun@mediatek.com>, <chao.hao@mediatek.com>,
        <ming-fan.chen@mediatek.com>,
        Greg Kroah-Hartman <gregkh@google.com>,
        <kernel-team@android.com>
Date:   Tue, 6 Oct 2020 12:26:45 +0800
In-Reply-To: <20201002111014.GE6888@pi3>
References: <20200930070647.10188-1-yong.wu@mediatek.com>
         <20200930070647.10188-7-yong.wu@mediatek.com> <20201002111014.GE6888@pi3>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 1485479E20C5DFD0AF7462D3F5BFACAB78FE123516FD431872321E09329134412000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgS3J6eXN6dG9mLA0KDQpPbiBGcmksIDIwMjAtMTAtMDIgYXQgMTM6MTAgKzAyMDAsIEtyenlz
enRvZiBLb3psb3dza2kgd3JvdGU6DQo+IE9uIFdlZCwgU2VwIDMwLCAyMDIwIGF0IDAzOjA2OjI5
UE0gKzA4MDAsIFlvbmcgV3Ugd3JvdGU6DQo+ID4gVGhpcyBwYXRjaCBhZGRzIGRlY3JpcHRpb25z
IGZvciBtdDgxOTIgSU9NTVUgYW5kIFNNSS4NCj4gPiANCj4gPiBtdDgxOTIgYWxzbyBpcyBNVEsg
SU9NTVUgZ2VuMiB3aGljaCB1c2VzIEFSTSBTaG9ydC1EZXNjcmlwdG9yIHRyYW5zbGF0aW9uDQo+
ID4gdGFibGUgZm9ybWF0LiBUaGUgTTRVLVNNSSBIVyBkaWFncmFtIGlzIGFzIGJlbG93Og0KPiA+
IA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgRU1JDQo+ID4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgfA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgTTRVDQo+ID4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgfA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAtLS0t
LS0tLS0tLS0NCj4gPiAgICAgICAgICAgICAgICAgICAgICAgIFNNSSBDb21tb24NCj4gPiAgICAg
ICAgICAgICAgICAgICAgICAgLS0tLS0tLS0tLS0tDQo+ID4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgfA0KPiA+ICAgKy0tLS0tLS0rLS0tLS0tKy0tLS0tLSstLS0tLS0tLS0tLS0tLS0tLS0t
LS0tKy0tLS0tLS0rDQo+ID4gICB8ICAgICAgIHwgICAgICB8ICAgICAgfCAgICAgICAuLi4uLi4g
ICAgICAgICB8ICAgICAgIHwNCj4gPiAgIHwgICAgICAgfCAgICAgIHwgICAgICB8ICAgICAgICAg
ICAgICAgICAgICAgIHwgICAgICAgfA0KPiA+IGxhcmIwICAgbGFyYjEgIGxhcmIyICBsYXJiNCAg
ICAgLi4uLi4uICAgICAgbGFyYjE5ICAgbGFyYjIwDQo+ID4gZGlzcDAgICBkaXNwMSAgIG1kcCAg
ICB2ZGVjICAgICAgICAgICAgICAgICAgIElQRSAgICAgIElQRQ0KPiA+IA0KPiA+IEFsbCB0aGUg
Y29ubmVjdGlvbnMgYXJlIEhXIGZpeGVkLCBTVyBjYW4gTk9UIGFkanVzdCBpdC4NCj4gPiANCj4g
PiBtdDgxOTIgTTRVIHN1cHBvcnQgMH4xNkdCIGlvdmEgcmFuZ2UuIHdlIHByZWFzc2lnbiBkaWZm
ZXJlbnQgZW5naW5lcw0KPiA+IGludG8gZGlmZmVyZW50IGlvdmEgcmFuZ2VzOg0KPiA+IA0KPiA+
IGRvbWFpbi1pZCAgbW9kdWxlICAgICBpb3ZhLXJhbmdlICAgICAgICAgICAgICAgICAgbGFyYnMN
Cj4gPiAgICAwICAgICAgIGRpc3AgICAgICAgIDAgfiA0RyAgICAgICAgICAgICAgICAgICAgICBs
YXJiMC8xDQo+ID4gICAgMSAgICAgICB2Y29kZWMgICAgICA0RyB+IDhHICAgICAgICAgICAgICAg
ICAgICAgbGFyYjQvNS83DQo+ID4gICAgMiAgICAgICBjYW0vbWRwICAgICA4RyB+IDEyRyAgICAg
ICAgICAgICBsYXJiMi85LzExLzEzLzE0LzE2LzE3LzE4LzE5LzIwDQo+ID4gICAgMyAgICAgICBD
Q1UwICAgIDB4NDAwMF8wMDAwIH4gMHg0M2ZmX2ZmZmYgICAgIGxhcmIxMzogcG9ydCA5LzEwDQo+
ID4gICAgNCAgICAgICBDQ1UxICAgIDB4NDQwMF8wMDAwIH4gMHg0N2ZmX2ZmZmYgICAgIGxhcmIx
NDogcG9ydCA0LzUNCj4gPiANCj4gPiBUaGUgaW92YSByYW5nZSBmb3IgQ0NVMC8xKGNhbWVyYSBj
b250cm9sIHVuaXQpIGlzIEhXIHJlcXVpcmVtZW50Lg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6
IFlvbmcgV3UgPHlvbmcud3VAbWVkaWF0ZWsuY29tPg0KPiA+IFJldmlld2VkLWJ5OiBSb2IgSGVy
cmluZyA8cm9iaEBrZXJuZWwub3JnPg0KPiA+IC0tLQ0KPiA+ICAuLi4vYmluZGluZ3MvaW9tbXUv
bWVkaWF0ZWssaW9tbXUueWFtbCAgICAgICAgfCAgIDkgKy0NCj4gPiAgLi4uL21lZGlhdGVrLHNt
aS1jb21tb24ueWFtbCAgICAgICAgICAgICAgICAgIHwgICA1ICstDQo+ID4gIC4uLi9tZW1vcnkt
Y29udHJvbGxlcnMvbWVkaWF0ZWssc21pLWxhcmIueWFtbCB8ICAgMyArLQ0KPiA+ICBpbmNsdWRl
L2R0LWJpbmRpbmdzL21lbW9yeS9tdDgxOTItbGFyYi1wb3J0LmggfCAyMzkgKysrKysrKysrKysr
KysrKysrDQo+ID4gIDQgZmlsZXMgY2hhbmdlZCwgMjUxIGluc2VydGlvbnMoKyksIDUgZGVsZXRp
b25zKC0pDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL2R0LWJpbmRpbmdzL21lbW9y
eS9tdDgxOTItbGFyYi1wb3J0LmgNCj4gDQo+IEkgc2VlIGl0IGRlcGVuZHMgb24gcHJldmlvdXMg
cGF0Y2hlcyBidXQgZG9lcyBpdCBoYXZlIHRvIGJlIHdpdGhpbiBvbmUNCj4gY29tbWl0PyBJcyBp
dCBub3QgYmlzZWN0YWJsZT8gVGhlIG1lbW9yeSBjaGFuZ2VzL2JpbmRpbmdzIGNvdWxkIGdvIHZp
YQ0KPiBtZW1vcnkgdHJlZSBpZiB0aGlzIGlzIHNwbGl0Lg0KDQpUaGFua3MgZm9yIHRoZSB2aWV3
Lg0KDQpJIGNhbiBzcGxpdCB0aGlzIGludG8gdHdvIHBhdGNoc2V0IGluIG5leHQgdmVyc2lvbiwg
b25lIGlzIGZvciBpb21tdSBhbmQNCnRoZSBvdGhlciBpcyBmb3Igc21pLg0KDQpPbmx5IHRoZSBw
YXRjaCBbMTgvMjRdIGNoYW5nZSBib3RoIHRoZSBjb2RlKGlvbW11IGFuZCBzbWkpLiBJIGRvbid0
IHBsYW4NCnRvIHNwbGl0IGl0LCBhbmQgdGhlIHNtaSBwYXRjaFsyNC8yNF0gZG9uJ3QgZGVwZW5k
IG9uIGl0KHdvbid0DQpjb25mbGljdCkuDQoNCnNpbmNlIDE4LzI0IGFsc28gdG91Y2ggdGhlIHNt
aSBjb2RlLCBJIGV4cGVjdCBpdCBjb3VsZCBnZXQgQWNrZWQtYnkgZnJvbQ0KeW91IG9yIE1hdHRo
aWFzLCB0aGVuIEpvZXJnIGNvdWxkIHRha2UgaXQuDQoNClRoYW5rcy4NCg0KPiANCj4gQmVzdCBy
ZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg0K


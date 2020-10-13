Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65B0728C991
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 09:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390453AbgJMHxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 03:53:18 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:44443 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2390434AbgJMHxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 03:53:17 -0400
X-UUID: 08507b90f26c4ecab32543976e863125-20201013
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=hSQpx7aGiFaBvdW2xKyY2Ng20CMPICvnjIERCoViN0I=;
        b=NfBmMAeSCOJXXulcR1a0zazmOI998zqF+5u06u0xaBN+d0w/Rm4YTFs5ffJPaGehuk+KJ2ZFoLK7U5gTz22mSa07titI7bYt1+l3FQFdyfUzEVoKToXcLSMpKT4+ngMNCN/K3/OPxVYgo7hyQSbqOpaPG60t5ZJIfUeiBtJ1CfM=;
X-UUID: 08507b90f26c4ecab32543976e863125-20201013
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1838484348; Tue, 13 Oct 2020 15:53:12 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS32N1.mediatek.inc
 (172.27.4.71) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 13 Oct
 2020 15:53:10 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 13 Oct 2020 15:53:09 +0800
Message-ID: <1602575589.26323.58.camel@mhfsdcap03>
Subject: Re: [PATCH v3 01/24] dt-bindings: iommu: mediatek: Convert IOMMU to
 DT schema
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <youlin.pei@mediatek.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        <anan.sun@mediatek.com>, <chao.hao@mediatek.com>,
        <ming-fan.chen@mediatek.com>,
        Greg Kroah-Hartman <gregkh@google.com>,
        <kernel-team@android.com>
Date:   Tue, 13 Oct 2020 15:53:09 +0800
In-Reply-To: <CAJKOXPedQdOYque5igJ0_v_-_0L4S+NW6puUw-kWc+zWM96i_Q@mail.gmail.com>
References: <20200930070647.10188-1-yong.wu@mediatek.com>
         <20200930070647.10188-2-yong.wu@mediatek.com> <20201002110709.GC6888@pi3>
         <1601958415.26323.25.camel@mhfsdcap03>
         <CAJKOXPedQdOYque5igJ0_v_-_0L4S+NW6puUw-kWc+zWM96i_Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: F0136768EC9E69320BFE32C8620BE1722F1A041A55A2EB7E73DFE4BD0D6C98E72000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIwLTEwLTEyIGF0IDE5OjA4ICswMjAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiBPbiBUdWUsIDYgT2N0IDIwMjAgYXQgMDY6MjcsIFlvbmcgV3UgPHlvbmcud3VAbWVk
aWF0ZWsuY29tPiB3cm90ZToNCj4gPg0KPiA+IE9uIEZyaSwgMjAyMC0xMC0wMiBhdCAxMzowNyAr
MDIwMCwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gPiA+IE9uIFdlZCwgU2VwIDMwLCAy
MDIwIGF0IDAzOjA2OjI0UE0gKzA4MDAsIFlvbmcgV3Ugd3JvdGU6DQo+ID4gPiA+IENvbnZlcnQg
TWVkaWFUZWsgSU9NTVUgdG8gRFQgc2NoZW1hLg0KPiA+ID4gPg0KPiA+ID4gPiBTaWduZWQtb2Zm
LWJ5OiBZb25nIFd1IDx5b25nLnd1QG1lZGlhdGVrLmNvbT4NCj4gPiA+ID4gLS0tDQo+ID4gPiA+
ICAuLi4vYmluZGluZ3MvaW9tbXUvbWVkaWF0ZWssaW9tbXUudHh0ICAgICAgICAgfCAxMDMgLS0t
LS0tLS0tLS0tDQo+ID4gPiA+ICAuLi4vYmluZGluZ3MvaW9tbXUvbWVkaWF0ZWssaW9tbXUueWFt
bCAgICAgICAgfCAxNTQgKysrKysrKysrKysrKysrKysrDQo+ID4gPiA+ICAyIGZpbGVzIGNoYW5n
ZWQsIDE1NCBpbnNlcnRpb25zKCspLCAxMDMgZGVsZXRpb25zKC0pDQo+ID4gPiA+ICBkZWxldGUg
bW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lvbW11L21lZGlh
dGVrLGlvbW11LnR4dA0KPiA+ID4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9pb21tdS9tZWRpYXRlayxpb21tdS55YW1sDQo+ID4gPiA+DQo+
ID4NCj4gPiBbLi4uXQ0KPiA+DQo+ID4gPiA+ICtwcm9wZXJ0aWVzOg0KPiA+ID4gPiArICBjb21w
YXRpYmxlOg0KPiA+ID4gPiArICAgIG9uZU9mOg0KPiA+ID4gPiArICAgICAgLSBlbnVtOg0KPiA+
ID4gPiArICAgICAgICAgIC0gbWVkaWF0ZWssbXQyNzAxLW00dSAjIG10MjcwMSBnZW5lcmF0aW9u
IG9uZSBIVw0KPiA+ID4gPiArICAgICAgICAgIC0gbWVkaWF0ZWssbXQyNzEyLW00dSAjIG10Mjcx
MiBnZW5lcmF0aW9uIHR3byBIVw0KPiA+ID4gPiArICAgICAgICAgIC0gbWVkaWF0ZWssbXQ2Nzc5
LW00dSAjIG10Njc3OSBnZW5lcmF0aW9uIHR3byBIVw0KPiA+ID4gPiArICAgICAgICAgIC0gbWVk
aWF0ZWssbXQ4MTczLW00dSAjIG10ODE3MyBnZW5lcmF0aW9uIHR3byBIVw0KPiA+ID4gPiArICAg
ICAgICAgIC0gbWVkaWF0ZWssbXQ4MTgzLW00dSAjIG10ODE4MyBnZW5lcmF0aW9uIHR3byBIVw0K
PiA+ID4gPiArDQo+ID4gPiA+ICsgICAgICAtIGRlc2NyaXB0aW9uOiBtdDc2MjMgZ2VuZXJhdGlv
biBvbmUgSFcNCj4gPiA+ID4gKyAgICAgICAgaXRlbXM6DQo+ID4gPiA+ICsgICAgICAgICAgLSBj
b25zdDogbWVkaWF0ZWssbXQ3NjIzLW00dQ0KPiA+ID4gPiArICAgICAgICAgIC0gY29uc3Q6IG1l
ZGlhdGVrLG10MjcwMS1tNHUNCj4gPiA+ID4gKw0KPiA+ID4gPiArICByZWc6DQo+ID4gPiA+ICsg
ICAgbWF4SXRlbXM6IDENCj4gPiA+ID4gKw0KPiA+ID4gPiArICBpbnRlcnJ1cHRzOg0KPiA+ID4g
PiArICAgIG1heEl0ZW1zOiAxDQo+ID4gPiA+ICsNCj4gPiA+ID4gKyAgY2xvY2tzOg0KPiA+ID4g
PiArICAgIGRlc2NyaXB0aW9uOiB8DQo+ID4gPiA+ICsgICAgICBiY2xrIGlzIG9wdGlvbmFsLiBo
ZXJlIGlzIHRoZSBsaXN0IHdoaWNoIHJlcXVpcmUgdGhpcyBiY2xrOg0KPiA+ID4gPiArICAgICAg
bXQyNzAxLCBtdDI3MTIsIG10NzYyMyBhbmQgbXQ4MTczLg0KPiA+ID4NCj4gPiA+IFNpbWlsYXJs
eSB0byBteSBjb21tZW50IGluIG90aGVyIHBhdGNoLCB0aGlzIHNob3VsZCBiZSBwYXJ0IG9mIHNj
aGVtYQ0KPiA+ID4gd2l0aGluICdpZi10aGVuJy4NCj4gPg0KPiA+IFRoYW5rcyBmb3IgdGhlIHJl
dmlldy4NCj4gPg0KPiA+IEkgd2lsbCBjaGFuZ2UgbGlrZSB0aGlzOg0KPiA+DQo+ID4gPT09PT09
PT09PT09PQ0KPiA+ICAgY2xvY2tzOg0KPiA+ICAgICBpdGVtczoNCj4gPiAgICAgICAtIGRlc2Ny
aXB0aW9uOiBiY2xrIGlzIHRoZSBibG9jayBjbG9jay4NCj4gPg0KPiA+ICAgY2xvY2stbmFtZXM6
DQo+ID4gICAgIGl0ZW1zOg0KPiA+ICAgICAgIC0gY29uc3Q6IGJjbGsNCj4gPg0KPiA+IHJlcXVp
cmVkOg0KPiA+ICAgLSBjb21wYXRpYmxlDQo+ID4gICAtIHJlZw0KPiA+ICAgLSBpbnRlcnJ1cHRz
DQo+ID4gICAtIG1lZGlhdGVrLGxhcmJzDQo+ID4gICAtICcjaW9tbXUtY2VsbHMnDQo+ID4gaWY6
DQo+ID4gICBwcm9wZXJ0aWVzOg0KPiA+ICAgICBjb21wYXRpYmxlOg0KPiA+ICAgICAgIGNvbnRh
aW5zOg0KPiA+ICAgICAgICAgZW51bToNCj4gPiAgICAgICAgICAgLSBtZWRpYXRlayxtdDI3MDEt
bTR1DQo+ID4gICAgICAgICAgIC0gbWVkaWF0ZWssbXQyNzEyLW00dQ0KPiA+ICAgICAgICAgICAt
IG1lZGlhdGVrLG10ODE3My1tNHUNCj4gPg0KPiA+IHRoZW46DQo+ID4gIHJlcXVpcmVkOg0KPiA+
ICAgIC0gY2xvY2tzDQo+ID4gPT09PT09PT09PT09PT0NCj4gPg0KPiA+IElmIHRoaXMgaXMgbm90
IHJpZ2h0LCBwbGVhc2UgdGVsbCBtZS4NCj4gPiAoZHRfYmluZGluZ19jaGVjayBpcyBvay4pDQo+
IA0KPiBMb29rcyBmaW5lLCBleGNlcHQgImlmIiBzaG91bGQgYmUgcGFydCBvZiBzb21lICJhbGxP
ZiIgYmxvY2suDQoNClRoYW5rcyB2ZXJ5IG11Y2ggZm9yIHRoZSByZXZpZXcuDQpJIHdpbGwgYWRk
ICJhbGxPZiIgaW4gbmV4dCB2ZXJzaW9uLg0KDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlz
enRvZg0KDQo=


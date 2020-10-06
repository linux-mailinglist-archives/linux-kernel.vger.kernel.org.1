Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB4CE2844F3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 06:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbgJFEcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 00:32:12 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:21965 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725874AbgJFEcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 00:32:11 -0400
X-Greylist: delayed 305 seconds by postgrey-1.27 at vger.kernel.org; Tue, 06 Oct 2020 00:32:10 EDT
X-UUID: fe44045d466046c2aa4dbc44ea12eb0b-20201006
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=+pxD8I7KLNWeEZpM4bXar+ZxPMehQGOOhOWN3s3N3JU=;
        b=GzLo7leMLv2dfhFmyPQRF6WxaRUhzbUAB4qUkyU1Pzmy+n14iptRg2Iv7tHKv7/EYySuOuMjSu/HiePs8kA1CaxalvYlSeqiu9BDT/gT6lqBa/ZH0lsrHfJtQ/SbRirnONWccZOE0jZWRrstLecyZJsozmiqnhwXsmMsdumCvz8=;
X-UUID: fe44045d466046c2aa4dbc44ea12eb0b-20201006
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 538139451; Tue, 06 Oct 2020 12:26:57 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 6 Oct
 2020 12:26:55 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 6 Oct 2020 12:26:54 +0800
Message-ID: <1601958415.26323.25.camel@mhfsdcap03>
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
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <youlin.pei@mediatek.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        <anan.sun@mediatek.com>, <chao.hao@mediatek.com>,
        <ming-fan.chen@mediatek.com>,
        Greg Kroah-Hartman <gregkh@google.com>,
        <kernel-team@android.com>
Date:   Tue, 6 Oct 2020 12:26:55 +0800
In-Reply-To: <20201002110709.GC6888@pi3>
References: <20200930070647.10188-1-yong.wu@mediatek.com>
         <20200930070647.10188-2-yong.wu@mediatek.com> <20201002110709.GC6888@pi3>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 9A9DF6700EE416CA650EB803451E471F73CB22B3E312AC0B29EBEE4AED21DE852000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIwLTEwLTAyIGF0IDEzOjA3ICswMjAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiBPbiBXZWQsIFNlcCAzMCwgMjAyMCBhdCAwMzowNjoyNFBNICswODAwLCBZb25nIFd1
IHdyb3RlOg0KPiA+IENvbnZlcnQgTWVkaWFUZWsgSU9NTVUgdG8gRFQgc2NoZW1hLg0KPiA+IA0K
PiA+IFNpZ25lZC1vZmYtYnk6IFlvbmcgV3UgPHlvbmcud3VAbWVkaWF0ZWsuY29tPg0KPiA+IC0t
LQ0KPiA+ICAuLi4vYmluZGluZ3MvaW9tbXUvbWVkaWF0ZWssaW9tbXUudHh0ICAgICAgICAgfCAx
MDMgLS0tLS0tLS0tLS0tDQo+ID4gIC4uLi9iaW5kaW5ncy9pb21tdS9tZWRpYXRlayxpb21tdS55
YW1sICAgICAgICB8IDE1NCArKysrKysrKysrKysrKysrKysNCj4gPiAgMiBmaWxlcyBjaGFuZ2Vk
LCAxNTQgaW5zZXJ0aW9ucygrKSwgMTAzIGRlbGV0aW9ucygtKQ0KPiA+ICBkZWxldGUgbW9kZSAx
MDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lvbW11L21lZGlhdGVrLGlv
bW11LnR4dA0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL2lvbW11L21lZGlhdGVrLGlvbW11LnlhbWwNCj4gPiANCg0KWy4uLl0NCg0KPiA+
ICtwcm9wZXJ0aWVzOg0KPiA+ICsgIGNvbXBhdGlibGU6DQo+ID4gKyAgICBvbmVPZjoNCj4gPiAr
ICAgICAgLSBlbnVtOg0KPiA+ICsgICAgICAgICAgLSBtZWRpYXRlayxtdDI3MDEtbTR1ICMgbXQy
NzAxIGdlbmVyYXRpb24gb25lIEhXDQo+ID4gKyAgICAgICAgICAtIG1lZGlhdGVrLG10MjcxMi1t
NHUgIyBtdDI3MTIgZ2VuZXJhdGlvbiB0d28gSFcNCj4gPiArICAgICAgICAgIC0gbWVkaWF0ZWss
bXQ2Nzc5LW00dSAjIG10Njc3OSBnZW5lcmF0aW9uIHR3byBIVw0KPiA+ICsgICAgICAgICAgLSBt
ZWRpYXRlayxtdDgxNzMtbTR1ICMgbXQ4MTczIGdlbmVyYXRpb24gdHdvIEhXDQo+ID4gKyAgICAg
ICAgICAtIG1lZGlhdGVrLG10ODE4My1tNHUgIyBtdDgxODMgZ2VuZXJhdGlvbiB0d28gSFcNCj4g
PiArDQo+ID4gKyAgICAgIC0gZGVzY3JpcHRpb246IG10NzYyMyBnZW5lcmF0aW9uIG9uZSBIVw0K
PiA+ICsgICAgICAgIGl0ZW1zOg0KPiA+ICsgICAgICAgICAgLSBjb25zdDogbWVkaWF0ZWssbXQ3
NjIzLW00dQ0KPiA+ICsgICAgICAgICAgLSBjb25zdDogbWVkaWF0ZWssbXQyNzAxLW00dQ0KPiA+
ICsNCj4gPiArICByZWc6DQo+ID4gKyAgICBtYXhJdGVtczogMQ0KPiA+ICsNCj4gPiArICBpbnRl
cnJ1cHRzOg0KPiA+ICsgICAgbWF4SXRlbXM6IDENCj4gPiArDQo+ID4gKyAgY2xvY2tzOg0KPiA+
ICsgICAgZGVzY3JpcHRpb246IHwNCj4gPiArICAgICAgYmNsayBpcyBvcHRpb25hbC4gaGVyZSBp
cyB0aGUgbGlzdCB3aGljaCByZXF1aXJlIHRoaXMgYmNsazoNCj4gPiArICAgICAgbXQyNzAxLCBt
dDI3MTIsIG10NzYyMyBhbmQgbXQ4MTczLg0KPiANCj4gU2ltaWxhcmx5IHRvIG15IGNvbW1lbnQg
aW4gb3RoZXIgcGF0Y2gsIHRoaXMgc2hvdWxkIGJlIHBhcnQgb2Ygc2NoZW1hDQo+IHdpdGhpbiAn
aWYtdGhlbicuDQoNClRoYW5rcyBmb3IgdGhlIHJldmlldy4NCg0KSSB3aWxsIGNoYW5nZSBsaWtl
IHRoaXM6DQoNCj09PT09PT09PT09PT0NCiAgY2xvY2tzOg0KICAgIGl0ZW1zOg0KICAgICAgLSBk
ZXNjcmlwdGlvbjogYmNsayBpcyB0aGUgYmxvY2sgY2xvY2suDQoNCiAgY2xvY2stbmFtZXM6DQog
ICAgaXRlbXM6DQogICAgICAtIGNvbnN0OiBiY2xrDQoNCnJlcXVpcmVkOg0KICAtIGNvbXBhdGli
bGUNCiAgLSByZWcNCiAgLSBpbnRlcnJ1cHRzDQogIC0gbWVkaWF0ZWssbGFyYnMNCiAgLSAnI2lv
bW11LWNlbGxzJw0KaWY6DQogIHByb3BlcnRpZXM6DQogICAgY29tcGF0aWJsZToNCiAgICAgIGNv
bnRhaW5zOg0KICAgICAgICBlbnVtOg0KICAgICAgICAgIC0gbWVkaWF0ZWssbXQyNzAxLW00dQ0K
ICAgICAgICAgIC0gbWVkaWF0ZWssbXQyNzEyLW00dQ0KICAgICAgICAgIC0gbWVkaWF0ZWssbXQ4
MTczLW00dQ0KDQp0aGVuOg0KIHJlcXVpcmVkOg0KICAgLSBjbG9ja3MNCj09PT09PT09PT09PT09
DQoNCklmIHRoaXMgaXMgbm90IHJpZ2h0LCBwbGVhc2UgdGVsbCBtZS4NCihkdF9iaW5kaW5nX2No
ZWNrIGlzIG9rLikNCg0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg0K


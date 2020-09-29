Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2BC27CFFF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 15:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730462AbgI2NyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 09:54:17 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:2892 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727328AbgI2NyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 09:54:13 -0400
X-UUID: be755ad52f7f4df3a38c6f5a8705de53-20200929
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=3R2Pn+c7IE5Q3v0Jn/QXjb/p34wUQS/L7+BGyE+G9mI=;
        b=WeXwrHISHquz3QzyPWAaKebf0s5B9znLqBP5oWJZKPFciFAx1xExB17GCi8eOAKowVSv/8jgedrEgxXINPcIHAcagNJB0yPG3ZVPe23kBLzzQOiSC5bcKP/Vxki9AAWwsdZXknoF3UZdfk69iCnrnlEhPCZhG5btdW5PeChzgvE=;
X-UUID: be755ad52f7f4df3a38c6f5a8705de53-20200929
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <crystal.guo@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 462118723; Tue, 29 Sep 2020 21:54:00 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 29 Sep
 2020 21:53:59 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 29 Sep 2020 21:53:58 +0800
Message-ID: <1601387640.14806.37.camel@mhfsdcap03>
Subject: Re: [v4,3/4] reset-controller: ti: introduce a new reset handler
From:   Crystal Guo <crystal.guo@mediatek.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Suman Anna <s-anna@ti.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
CC:     srv_heupstream <srv_heupstream@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Seiya Wang =?UTF-8?Q?=28=E7=8E=8B=E8=BF=BA=E5=90=9B=29?= 
        <seiya.wang@mediatek.com>,
        Stanley Chu =?UTF-8?Q?=28=E6=9C=B1=E5=8E=9F=E9=99=9E=29?= 
        <stanley.chu@mediatek.com>,
        Yingjoe Chen =?UTF-8?Q?=28=E9=99=B3=E8=8B=B1=E6=B4=B2=29?= 
        <Yingjoe.Chen@mediatek.com>,
        Fan Chen =?UTF-8?Q?=28=E9=99=B3=E5=87=A1=29?= 
        <fan.chen@mediatek.com>,
        "Yong Liang =?UTF-8?Q?=28=E6=A2=81=E5=8B=87=29?=" 
        <Yong.Liang@mediatek.com>
Date:   Tue, 29 Sep 2020 21:54:00 +0800
In-Reply-To: <1600092019.14806.32.camel@mhfsdcap03>
References: <20200817030324.5690-1-crystal.guo@mediatek.com>
         <20200817030324.5690-4-crystal.guo@mediatek.com>
         <3a5decee-5f31-e27d-a120-1f835241a87c@ti.com>
         <1599620279.14806.18.camel@mhfsdcap03>
         <096362e9-dee8-4e7a-2518-47328068c2fd@ti.com>
         <1599792140.14806.22.camel@mhfsdcap03>
         <9d72aaef-49fe-ebb6-215d-05ad3ab27af4@ti.com>
         <1599804422.14806.27.camel@mhfsdcap03>
         <dae4ab91ec20e72963f2658efca4874a35dd739e.camel@pengutronix.de>
         <407863ba-e336-11fc-297d-f1be1f58adaa@ti.com>
         <1600092019.14806.32.camel@mhfsdcap03>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 4D3137281912B1B8192E5255475BC4C9F56539D105696DE295B344C9EB617AE12000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIwLTA5LTE0IGF0IDIyOjAwICswODAwLCBDcnlzdGFsIEd1byB3cm90ZToNCj4g
T24gRnJpLCAyMDIwLTA5LTExIGF0IDIyOjQ0ICswODAwLCBTdW1hbiBBbm5hIHdyb3RlOg0KPiA+
IE9uIDkvMTEvMjAgOToyNiBBTSwgUGhpbGlwcCBaYWJlbCB3cm90ZToNCj4gPiA+IEhpIENyeXN0
YWwsDQo+ID4gPiANCj4gPiA+IE9uIEZyaSwgMjAyMC0wOS0xMSBhdCAxNDowNyArMDgwMCwgQ3J5
c3RhbCBHdW8gd3JvdGU6DQo+ID4gPiBbLi4uXQ0KPiA+ID4+IFNob3VsZCBJIGFkZCB0aGUgU29D
LXNwZWNpZmljIGRhdGEgYXMgZm9sbG93cz8NCj4gPiA+PiBUaGlzIG1heSBhbHNvIG1vZGlmeSB0
aGUgdGkgb3JpZ2luYWwgY29kZSwgaXMgaXQgT0s/DQo+ID4gPj4NCj4gPiA+PiArICAgICAgIGRh
dGEtPnJlc2V0X2RhdGEgPSBvZl9kZXZpY2VfZ2V0X21hdGNoX2RhdGEoJnBkZXYtPmRldik7DQo+
ID4gPj4gKw0KPiA+ID4+ICsgICAgICAgbGlzdCA9IG9mX2dldF9wcm9wZXJ0eShucCwgZGF0YS0+
cmVzZXRfZGF0YS0+cmVzZXRfYml0cywgJnNpemUpOw0KPiA+ID4+DQo+ID4gPj4gK3N0YXRpYyBj
b25zdCBzdHJ1Y3QgY29tbW9uX3Jlc2V0X2RhdGEgdGlfcmVzZXRfZGF0YSA9IHsNCj4gPiA+PiAr
ICAgICAgIC5yZXNldF9vcF9hdmFpbGFibGUgPSBmYWxzZSwNCj4gPiA+PiArICAgICAgIC5yZXNl
dF9iaXRzID0gInRpLCByZXNldC1iaXRzIiwNCj4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBeDQo+ID4gPiBUaGF0IHNwYWNlIGRvZXNuJ3QgYmVsb25nIHRoZXJlLg0KPiA+ID4gDQo+
ID4gPj4gK307DQo+ID4gPj4gKw0KPiA+ID4+ICtzdGF0aWMgY29uc3Qgc3RydWN0IGNvbW1vbl9y
ZXNldF9kYXRhIG1lZGlhdGVrX3Jlc2V0X2RhdGEgPSB7DQo+ID4gPj4gKyAgICAgICAucmVzZXRf
b3BfYXZhaWxhYmxlID0gdHJ1ZSwNCj4gPiA+PiArICAgICAgIC5yZXNldF9iaXRzID0gIm1lZGlh
dGVrLCByZXNldC1iaXRzIiwNCj4gPiA+PiArfTsNCj4gPiA+IA0KPiA+ID4gSSB1bmRlcnN0YW5k
IFJvYnMgY29tbWVudHMgYXMgbWVhbmluZyAidGkscmVzZXQtYml0cyIgc2hvdWxkIGhhdmUgYmVl
bg0KPiA+ID4gY2FsbGVkICJyZXNldC1iaXRzIiBpbiB0aGUgZmlyc3QgcGxhY2UsIGFuZCB5b3Ug
c2hvdWxkbid0IHJlcGVhdCBhZGRpbmcNCj4gPiA+IHRoZSB2ZW5kb3IgcHJlZml4LCBhcyB0aGF0
IGlzIGltcGxpZWQgYnkgdGhlIGNvbXBhdGlibGUuIFNvIHRoaXMgc2hvdWxkDQo+ID4gPiBwcm9i
YWJseSBiZSBqdXN0ICJyZXNldC1iaXRzIi4NCj4gPiANCj4gPiBIbW0sIG5vdCBzdXJlIGFib3V0
IHRoYXQuIEkgdGhpbmsgUm9iIHdhbnRzIHRoZSByZXNldCBkYXRhIGl0c2VsZiB0byBiZSBhZGRl
ZCBpbg0KPiA+IHRoZSBkcml2ZXIgYXMgaXMgYmVpbmcgZG9uZSBvbiBzb21lIG90aGVyIFNvQ3Mg
KGVnOiBsaWtlIGluIHJlc2V0LXFjb20tcGRjLmMpLg0KPiA+IA0KPiA+IHJlZ2FyZHMNCj4gPiBT
dW1hbg0KPiA+IA0KPiBIaSBSb2IsDQo+IA0KPiBDYW4geW91IGhlbHAgdG8gY29tbWVudCBhYm91
dCB0aGlzIHBvaW50Pw0KPiBNb2RpZnkgInRpLHJlc2V0LWJpdHMiIHRvICJyZXNldC1iaXRzIiBv
ciBhZGQgIm1lZGlhdGVrLHJlc2V0LWJpdHMiID8NCj4gDQo+IE1hbnkgdGhhbmtzfg0KPiBDcnlz
dGFsDQo+IA0KPiA+ID4gDQo+ID4gPiBPdGhlcndpc2UgdGhpcyBsb29rcyBsaWtlIGl0IHNob3Vs
ZCB3b3JrLg0KPiA+ID4gDQo+ID4gPiByZWdhcmRzDQo+ID4gPiBQaGlsaXBwDQo+ID4gPiANCj4g
PiANCg0KRGVhcnMsDQoNCkkgaGF2ZSB1cGxvYWRlZCB0aGUgY2hhbmdlcyBhdA0KaHR0cHM6Ly9w
YXRjaHdvcmsua2VybmVsLm9yZy9jb3Zlci8xMTgwNTkzNy8NClBsZWFzZSBoZWxwIG1lIHRvIHJl
dmlldywgbWFueSB0aGFua3N+fg0KDQpyZWdhcmRzDQpDcnlzdGFsDQo+IA0KDQo=


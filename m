Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B57B42AEBA5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 09:29:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbgKKI2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 03:28:45 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:57013 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725960AbgKKI2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 03:28:42 -0500
X-UUID: defb1df1a22a4d7f8a877e903b266659-20201111
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=d6BGvimYsRbgD3d8ny44iq6sJXu6PegVN2AnQ3w5TEc=;
        b=krMF2l+neXNuWnq+t2dSN+R1efZ7F0OyfD/KdgBWx37QI7IgEoUgjJhwu5J6DyDGSqGSPSOhL8Lt9HfHNGMjohnQz6kGiyxzrr8zi+qPavffW+/nTuY+zZU6U8PzrGo9nWVaChjtSB1eLoG+kWzn1zDeZHMKEDCzXvz0pBrqMos=;
X-UUID: defb1df1a22a4d7f8a877e903b266659-20201111
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1176421295; Wed, 11 Nov 2020 16:28:38 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 11 Nov 2020 16:28:35 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 11 Nov 2020 16:28:36 +0800
Message-ID: <1605083317.32073.5.camel@mtkswgap22>
Subject: Re: [v6,1/3] dt-binding: reset-controller: mediatek: add YAML
 schemas
From:   Stanley Chu <stanley.chu@mediatek.com>
To:     Crystal Guo <crystal.guo@mediatek.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        Suman Anna <s-anna@ti.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "s-anna@ti.com" <s-anna@ti.com>,
        Seiya Wang =?UTF-8?Q?=28=E7=8E=8B=E8=BF=BA=E5=90=9B=29?= 
        <seiya.wang@mediatek.com>,
        Yingjoe Chen =?UTF-8?Q?=28=E9=99=B3=E8=8B=B1=E6=B4=B2=29?= 
        <Yingjoe.Chen@mediatek.com>,
        Fan Chen =?UTF-8?Q?=28=E9=99=B3=E5=87=A1=29?= 
        <fan.chen@mediatek.com>,
        Yong Liang =?UTF-8?Q?=28=E6=A2=81=E5=8B=87=29?= 
        <Yong.Liang@mediatek.com>
Date:   Wed, 11 Nov 2020 16:28:37 +0800
In-Reply-To: <1602682204.14806.53.camel@mhfsdcap03>
References: <20200930022159.5559-1-crystal.guo@mediatek.com>
         <20200930022159.5559-2-crystal.guo@mediatek.com>
         <1602682204.14806.53.camel@mhfsdcap03>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWF0dGhpYXMsIFBoaWxpcHAsIFN1bWFuLA0KDQpTaW5jZSBhbG1vc3Qgb25lIG1vbnRoIHBl
bmRpbmcgd2l0aCB0aGlzIHBhdGNoIHNlcmllcywganVzdCBhIGdlbnRsZQ0KcGluZyB0aGF0IHdv
dWxkIHlvdSBoYXZlIGZ1cnRoZXIgc3VnZ2VzdGlvbnMgb24gdGhpcyBzZXJpZXM/DQoNCldlIGFy
ZSBsb29raW5nIGZvciB0aGlzIHNlcmllcyBiZWluZyBtZXJnZWQgc29vbi4NCg0KVGhhbmtzDQoN
Ck9uIFdlZCwgMjAyMC0xMC0xNCBhdCAyMTozMCArMDgwMCwgQ3J5c3RhbCBHdW8gd3JvdGU6DQo+
IEhpIE1haW50YWluZXJzLA0KPiANCj4gR2VudGxlIHBpbmcgZm9yIHRoaXMgcGF0Y2ggc2V0Lg0K
PiANCj4gTWFueSB0aGFua3MNCj4gQ3J5c3RhbA0KPiANCj4gT24gV2VkLCAyMDIwLTA5LTMwIGF0
IDEwOjIxICswODAwLCBDcnlzdGFsIEd1byB3cm90ZToNCj4gPiBBZGQgYSBZQU1MIGRvY3VtZW50
YXRpb24gZm9yIE1lZGlhdGVrLCB3aGljaCB1c2VzIHRpIHJlc2V0LWNvbnRyb2xsZXINCj4gPiBk
cml2ZXIgZGlyZWN0bHkuIFRoZSBUSSByZXNldCBjb250cm9sbGVyIHByb3ZpZGVzIGEgY29tbW9u
IHJlc2V0DQo+ID4gbWFuYWdlbWVudCwgYW5kIGlzIHN1aXRhYmxlIGZvciBNZWRpYXRlayBTb0Nz
Lg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IENyeXN0YWwgR3VvIDxjcnlzdGFsLmd1b0BtZWRp
YXRlay5jb20+DQo+ID4gLS0tDQo+ID4gIC4uLi9iaW5kaW5ncy9yZXNldC9tZWRpYXRlay1zeXNj
b24tcmVzZXQueWFtbCB8IDUxICsrKysrKysrKysrKysrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5n
ZWQsIDUxIGluc2VydGlvbnMoKykNCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9yZXNldC9tZWRpYXRlay1zeXNjb24tcmVzZXQueWFtbA0K
PiA+IA0KPiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
cmVzZXQvbWVkaWF0ZWstc3lzY29uLXJlc2V0LnlhbWwgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvcmVzZXQvbWVkaWF0ZWstc3lzY29uLXJlc2V0LnlhbWwNCj4gPiBuZXcgZmls
ZSBtb2RlIDEwMDY0NA0KPiA+IGluZGV4IDAwMDAwMDAwMDAwMC4uNzg3MTU1MGMzYzY5DQo+ID4g
LS0tIC9kZXYvbnVsbA0KPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9yZXNldC9tZWRpYXRlay1zeXNjb24tcmVzZXQueWFtbA0KPiA+IEBAIC0wLDAgKzEsNTEgQEAN
Cj4gPiArIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogKEdQTC0yLjAtb25seSBPUiBCU0QtMi1D
bGF1c2UpDQo+ID4gKyVZQU1MIDEuMg0KPiA+ICstLS0NCj4gPiArJGlkOiBodHRwOi8vZGV2aWNl
dHJlZS5vcmcvc2NoZW1hcy9yZXNldC9tZWRpYXRlay1zeXNjb24tcmVzZXQueWFtbCMNCj4gPiAr
JHNjaGVtYTogaHR0cDovL2RldmljZXRyZWUub3JnL21ldGEtc2NoZW1hcy9jb3JlLnlhbWwjDQo+
ID4gKw0KPiA+ICt0aXRsZTogTWVkaWF0ZWsgUmVzZXQgQ29udHJvbGxlcg0KPiA+ICsNCj4gPiAr
bWFpbnRhaW5lcnM6DQo+ID4gKyAgLSBDcnlzdGFsIEd1byA8Y3J5c3RhbC5ndW9AbWVkaWF0ZWsu
Y29tPg0KPiA+ICsNCj4gPiArZGVzY3JpcHRpb246DQo+ID4gKyAgVGhlIGJpbmRpbmdzIGRlc2Ny
aWJlIHRoZSByZXNldC1jb250cm9sbGVyIGZvciBNZWRpYXRlayBTb0NzLA0KPiA+ICsgIHdoaWNo
IGlzIGJhc2VkIG9uIFRJIHJlc2V0IGNvbnRyb2xsZXIuIEZvciBtb3JlIGRldGFpbCwgcGxlYXNl
DQo+ID4gKyAgdmlzaXQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Jlc2V0L3Rp
LXN5c2Nvbi1yZXNldC50eHQuDQo+ID4gKw0KPiA+ICtwcm9wZXJ0aWVzOg0KPiA+ICsgIGNvbXBh
dGlibGU6DQo+ID4gKyAgICBjb25zdDogbWVkaWF0ZWssc3lzY29uLXJlc2V0DQo+ID4gKw0KPiA+
ICsgICcjcmVzZXQtY2VsbHMnOg0KPiA+ICsgICAgY29uc3Q6IDENCj4gPiArDQo+ID4gKyAgbWVk
aWF0ZWsscmVzZXQtYml0czoNCj4gPiArICAgIGRlc2NyaXB0aW9uOiA+DQo+ID4gKyAgICAgIENv
bnRhaW5zIHRoZSByZXNldCBjb250cm9sIHJlZ2lzdGVyIGluZm9ybWF0aW9uLCBwbGVhc2UgcmVm
ZXIgdG8NCj4gPiArICAgICAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Jlc2V0
L3RpLXN5c2Nvbi1yZXNldC50eHQuDQo+ID4gKw0KPiA+ICtyZXF1aXJlZDoNCj4gPiArICAtIGNv
bXBhdGlibGUNCj4gPiArICAtICcjcmVzZXQtY2VsbHMnDQo+ID4gKyAgLSBtZWRpYXRlayxyZXNl
dC1iaXRzDQo+ID4gKw0KPiA+ICthZGRpdGlvbmFsUHJvcGVydGllczogZmFsc2UNCj4gPiArDQo+
ID4gK2V4YW1wbGVzOg0KPiA+ICsgIC0gfA0KPiA+ICsgICAgI2luY2x1ZGUgPGR0LWJpbmRpbmdz
L3Jlc2V0L3RpLXN5c2Nvbi5oPg0KPiA+ICsgICAgaW5mcmFjZmc6IGluZnJhY2ZnQDEwMDAxMDAw
IHsNCj4gPiArICAgICAgICBjb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE5Mi1pbmZyYWNmZyIs
ICJzeXNjb24iLCAic2ltcGxlLW1mZCI7DQo+ID4gKyAgICAgICAgcmVnID0gPDAgMHgxMDAwMTAw
MD47DQo+ID4gKyAgICAgICAgI2Nsb2NrLWNlbGxzID0gPDE+Ow0KPiA+ICsNCj4gPiArICAgICAg
ICBpbmZyYWNmZ19yc3Q6IHJlc2V0LWNvbnRyb2xsZXIgew0KPiA+ICsgICAgICAgICAgICBjb21w
YXRpYmxlID0gIm1lZGlhdGVrLHN5c2Nvbi1yZXNldCI7DQo+ID4gKyAgICAgICAgICAgICNyZXNl
dC1jZWxscyA9IDwxPjsNCj4gPiArICAgICAgICAgICAgbWVkaWF0ZWsscmVzZXQtYml0cyA9IDwN
Cj4gPiArICAgICAgICAgICAgICAgMHgxNDAgMTUgMHgxNDQgMTUgMCAwIChBU1NFUlRfU0VUIHwg
REVBU1NFUlRfU0VUIHwgU1RBVFVTX05PTkUpDQo+ID4gKyAgICAgICAgICAgID47DQo+ID4gKyAg
ICAgICAgfTsNCj4gPiArICAgIH07DQo+IA0KPiANCg0K


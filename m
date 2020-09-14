Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1AB268CC4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 16:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbgINOEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 10:04:15 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:5478 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726537AbgINOCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 10:02:30 -0400
X-UUID: a20d357e455d4bcb9f7b0afd4d2f3b0e-20200914
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=cLdj0X30p6O5aAOutE1K4/oxJCAmQzrpPvIelAe8dXw=;
        b=IvfVSwBvruvn11Wu7+kq5CSUIP1IVhSi/mjYCh7xR+v94CD55Tv6cY94A1hcrm4h4N7D55M0ZlzHBH2TZoVlnkOMFN8zfxMJqLkCM2D9C5ByWQpCaunamMrmdeFyFZGwSQq75EaoqRlpEzVdQvSZWOliNcUVi0NYC5pANZlZJDQ=;
X-UUID: a20d357e455d4bcb9f7b0afd4d2f3b0e-20200914
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <crystal.guo@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1162671277; Mon, 14 Sep 2020 22:02:22 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 14 Sep
 2020 22:02:20 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 14 Sep 2020 22:02:20 +0800
Message-ID: <1600092019.14806.32.camel@mhfsdcap03>
Subject: Re: [v4,3/4] reset-controller: ti: introduce a new reset handler
From:   Crystal Guo <crystal.guo@mediatek.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     Suman Anna <s-anna@ti.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        srv_heupstream <srv_heupstream@mediatek.com>,
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
Date:   Mon, 14 Sep 2020 22:00:19 +0800
In-Reply-To: <407863ba-e336-11fc-297d-f1be1f58adaa@ti.com>
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
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 45A69AB5EB0307C47D3EE730CE03B37B6DC73E1E5FF7A7ED01BBCA588A5E68AB2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIwLTA5LTExIGF0IDIyOjQ0ICswODAwLCBTdW1hbiBBbm5hIHdyb3RlOg0KPiBP
biA5LzExLzIwIDk6MjYgQU0sIFBoaWxpcHAgWmFiZWwgd3JvdGU6DQo+ID4gSGkgQ3J5c3RhbCwN
Cj4gPiANCj4gPiBPbiBGcmksIDIwMjAtMDktMTEgYXQgMTQ6MDcgKzA4MDAsIENyeXN0YWwgR3Vv
IHdyb3RlOg0KPiA+IFsuLi5dDQo+ID4+IFNob3VsZCBJIGFkZCB0aGUgU29DLXNwZWNpZmljIGRh
dGEgYXMgZm9sbG93cz8NCj4gPj4gVGhpcyBtYXkgYWxzbyBtb2RpZnkgdGhlIHRpIG9yaWdpbmFs
IGNvZGUsIGlzIGl0IE9LPw0KPiA+Pg0KPiA+PiArICAgICAgIGRhdGEtPnJlc2V0X2RhdGEgPSBv
Zl9kZXZpY2VfZ2V0X21hdGNoX2RhdGEoJnBkZXYtPmRldik7DQo+ID4+ICsNCj4gPj4gKyAgICAg
ICBsaXN0ID0gb2ZfZ2V0X3Byb3BlcnR5KG5wLCBkYXRhLT5yZXNldF9kYXRhLT5yZXNldF9iaXRz
LCAmc2l6ZSk7DQo+ID4+DQo+ID4+ICtzdGF0aWMgY29uc3Qgc3RydWN0IGNvbW1vbl9yZXNldF9k
YXRhIHRpX3Jlc2V0X2RhdGEgPSB7DQo+ID4+ICsgICAgICAgLnJlc2V0X29wX2F2YWlsYWJsZSA9
IGZhbHNlLA0KPiA+PiArICAgICAgIC5yZXNldF9iaXRzID0gInRpLCByZXNldC1iaXRzIiwNCj4g
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXg0KPiA+IFRoYXQgc3BhY2UgZG9lc24ndCBi
ZWxvbmcgdGhlcmUuDQo+ID4gDQo+ID4+ICt9Ow0KPiA+PiArDQo+ID4+ICtzdGF0aWMgY29uc3Qg
c3RydWN0IGNvbW1vbl9yZXNldF9kYXRhIG1lZGlhdGVrX3Jlc2V0X2RhdGEgPSB7DQo+ID4+ICsg
ICAgICAgLnJlc2V0X29wX2F2YWlsYWJsZSA9IHRydWUsDQo+ID4+ICsgICAgICAgLnJlc2V0X2Jp
dHMgPSAibWVkaWF0ZWssIHJlc2V0LWJpdHMiLA0KPiA+PiArfTsNCj4gPiANCj4gPiBJIHVuZGVy
c3RhbmQgUm9icyBjb21tZW50cyBhcyBtZWFuaW5nICJ0aSxyZXNldC1iaXRzIiBzaG91bGQgaGF2
ZSBiZWVuDQo+ID4gY2FsbGVkICJyZXNldC1iaXRzIiBpbiB0aGUgZmlyc3QgcGxhY2UsIGFuZCB5
b3Ugc2hvdWxkbid0IHJlcGVhdCBhZGRpbmcNCj4gPiB0aGUgdmVuZG9yIHByZWZpeCwgYXMgdGhh
dCBpcyBpbXBsaWVkIGJ5IHRoZSBjb21wYXRpYmxlLiBTbyB0aGlzIHNob3VsZA0KPiA+IHByb2Jh
Ymx5IGJlIGp1c3QgInJlc2V0LWJpdHMiLg0KPiANCj4gSG1tLCBub3Qgc3VyZSBhYm91dCB0aGF0
LiBJIHRoaW5rIFJvYiB3YW50cyB0aGUgcmVzZXQgZGF0YSBpdHNlbGYgdG8gYmUgYWRkZWQgaW4N
Cj4gdGhlIGRyaXZlciBhcyBpcyBiZWluZyBkb25lIG9uIHNvbWUgb3RoZXIgU29DcyAoZWc6IGxp
a2UgaW4gcmVzZXQtcWNvbS1wZGMuYykuDQo+IA0KPiByZWdhcmRzDQo+IFN1bWFuDQo+IA0KSGkg
Um9iLA0KDQpDYW4geW91IGhlbHAgdG8gY29tbWVudCBhYm91dCB0aGlzIHBvaW50Pw0KTW9kaWZ5
ICJ0aSxyZXNldC1iaXRzIiB0byAicmVzZXQtYml0cyIgb3IgYWRkICJtZWRpYXRlayxyZXNldC1i
aXRzIiA/DQoNCk1hbnkgdGhhbmtzfg0KQ3J5c3RhbA0KDQo+ID4gDQo+ID4gT3RoZXJ3aXNlIHRo
aXMgbG9va3MgbGlrZSBpdCBzaG91bGQgd29yay4NCj4gPiANCj4gPiByZWdhcmRzDQo+ID4gUGhp
bGlwcA0KPiA+IA0KPiANCg0K


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF472CBB3B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 12:10:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbgLBLIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 06:08:00 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:45282 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725885AbgLBLIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 06:08:00 -0500
X-UUID: ea2c6cffd1b341a0951db0824db34afc-20201202
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=760UWcQjn2gcgFpRL7UilO2rZNCmADv37JpOgMvIh4Y=;
        b=rh/upvV2O4pXoF3EAQfOfa23iCqIJa/hWBP+Mf5WIF22nVXhd0ftJaoVGpPlSLdNjlGJNeF2fYGN6ddXIXKrJ46VZ1IFJMJke9taw0MIT9bnOBAqKKaL9byIXnoz3J8AD2SIeryMabdmvIAJa7w3ZjSw3yTIJ9rpHrD4915VECo=;
X-UUID: ea2c6cffd1b341a0951db0824db34afc-20201202
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <crystal.guo@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1074444903; Wed, 02 Dec 2020 19:07:14 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 2 Dec
 2020 19:06:41 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 2 Dec 2020 19:06:40 +0800
Message-ID: <1606907202.14806.65.camel@mhfsdcap03>
Subject: Re: [v6, 3/3] reset-controller: ti: force the write operation when
 assert or deassert
From:   Crystal Guo <crystal.guo@mediatek.com>
To:     Ikjoon Jang <ikjn@chromium.org>
CC:     "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Yong Liang =?UTF-8?Q?=28=E6=A2=81=E5=8B=87=29?= 
        <Yong.Liang@mediatek.com>,
        Stanley Chu =?UTF-8?Q?=28=E6=9C=B1=E5=8E=9F=E9=99=9E=29?= 
        <stanley.chu@mediatek.com>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Seiya Wang =?UTF-8?Q?=28=E7=8E=8B=E8=BF=BA=E5=90=9B=29?= 
        <seiya.wang@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Fan Chen =?UTF-8?Q?=28=E9=99=B3=E5=87=A1=29?= 
        <fan.chen@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        Yingjoe Chen =?UTF-8?Q?=28=E9=99=B3=E8=8B=B1=E6=B4=B2=29?= 
        <Yingjoe.Chen@mediatek.com>, "s-anna@ti.com" <s-anna@ti.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Date:   Wed, 2 Dec 2020 19:06:42 +0800
In-Reply-To: <20201130111340.GA3042402@chromium.org>
References: <20200930022159.5559-1-crystal.guo@mediatek.com>
         <20200930022159.5559-4-crystal.guo@mediatek.com>
         <20201130111340.GA3042402@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 30A9654AF1CD9EA4FBA4BE9BFA52EA70554F9FC4BBB7FB01E220F307C0ED74462000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIwLTExLTMwIGF0IDE5OjEzICswODAwLCBJa2pvb24gSmFuZyB3cm90ZToNCj4g
T24gV2VkLCBTZXAgMzAsIDIwMjAgYXQgMTA6MjE6NTlBTSArMDgwMCwgQ3J5c3RhbCBHdW8gd3Jv
dGU6DQo+ID4gRm9yY2UgdGhlIHdyaXRlIG9wZXJhdGlvbiBpbiBjYXNlIHRoZSByZWFkIGFscmVh
ZHkgaGFwcGVucw0KPiA+IHRvIHJldHVybiB0aGUgY29ycmVjdCB2YWx1ZS4NCj4gPiANCj4gPiBT
aWduZWQtb2ZmLWJ5OiBDcnlzdGFsIEd1byA8Y3J5c3RhbC5ndW9AbWVkaWF0ZWsuY29tPg0KPiA+
IC0tLQ0KPiA+ICBkcml2ZXJzL3Jlc2V0L3Jlc2V0LXRpLXN5c2Nvbi5jIHwgNCArKy0tDQo+ID4g
IDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4gDQo+
ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcmVzZXQvcmVzZXQtdGktc3lzY29uLmMgYi9kcml2ZXJz
L3Jlc2V0L3Jlc2V0LXRpLXN5c2Nvbi5jDQo+ID4gaW5kZXggNWQxZjgzMDZjZDRmLi5jMzQzOTRm
MWU5ZTIgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9yZXNldC9yZXNldC10aS1zeXNjb24uYw0K
PiA+ICsrKyBiL2RyaXZlcnMvcmVzZXQvcmVzZXQtdGktc3lzY29uLmMNCj4gPiBAQCAtOTcsNyAr
OTcsNyBAQCBzdGF0aWMgaW50IHRpX3N5c2Nvbl9yZXNldF9hc3NlcnQoc3RydWN0IHJlc2V0X2Nv
bnRyb2xsZXJfZGV2ICpyY2RldiwNCj4gPiAgCW1hc2sgPSBCSVQoY29udHJvbC0+YXNzZXJ0X2Jp
dCk7DQo+ID4gIAl2YWx1ZSA9IChjb250cm9sLT5mbGFncyAmIEFTU0VSVF9TRVQpID8gbWFzayA6
IDB4MDsNCj4gPiAgDQo+ID4gLQlyZXR1cm4gcmVnbWFwX3VwZGF0ZV9iaXRzKGRhdGEtPnJlZ21h
cCwgY29udHJvbC0+YXNzZXJ0X29mZnNldCwgbWFzaywgdmFsdWUpOw0KPiA+ICsJcmV0dXJuIHJl
Z21hcF93cml0ZV9iaXRzKGRhdGEtPnJlZ21hcCwgY29udHJvbC0+YXNzZXJ0X29mZnNldCwgbWFz
aywgdmFsdWUpOw0KPiA+ICB9DQo+IA0KPiBJIGRvbid0IHRoaW5rIHRoZXJlIGFyZSBubyByZXNl
dCBjb250cm9sbGVycyB3aXRoIGNhY2hlZCByZWdtYXAsDQo+IHRodXMgSSBkb24ndCB0aGluayB0
aGlzIGlzIG5lZWRlZC4NCj4gQXJlIHRoZXJlIGFueSBzcGVjaWZpYyByZWFzb25zIGJlaGluZCB0
aGlzLCB3aGF0IEkndmUgbWlzc2VkIGhlcmU/DQo+IA0KPiBXZSBuZWVkIHRvIGJlIHN1cmUgdGhh
dCBhbGwgb3RoZXIgZGV2aWNlcyB1c2luZyB0aGlzIGRyaXZlcg0KPiBzaG91bGQgaGF2ZSBubyBz
aWRlIGVmZmVjdHMgb24gd3JpdGUuDQo+IA0KPiBJIGNhbiB0aGluayBvZiBhIHdlaXJkIGNvbnRy
b2xsZXIgZG9pbmcgdW53YW50ZWQgdGhpbmdzIGludGVybmFsbHkNCj4gb24gZXZlcnkgd3JpdGUg
ZGlzcmVnYXJkaW5nIHRoZSBjdXJyZW50IHN0YXRlLiAob3IgaXMgdGhpcyBvdmVybHkNCj4gcGFy
YW5vaWQ/KQ0KPiANClRoZSBzcGVjaWZpYyByZWFzb24gaXMgdGhhdCwgdGhlIGNsZWFyIGJpdCBt
YXkga2VlcCB0aGUgc2FtZSB2YWx1ZSB3aXRoDQp0aGUgc2V0IGJpdCwgYnV0IHRoZSBjbGVhciBv
cGVyYXRpb24gY2FuIGJlIG9ubHkgYmUgY29tcGxldGVkIGJ5IHdyaXRpbmcNCjEgdG8gdGhlIGNs
ZWFyIGJpdCwgbm90IGp1c3Qgd2l0aCB0aGUgY3VycmVudCBmYWtlIHN0YXRlICIxIi4NCg0KPiA+
ICANCj4gPiAgLyoqDQo+ID4gQEAgLTEyOCw3ICsxMjgsNyBAQCBzdGF0aWMgaW50IHRpX3N5c2Nv
bl9yZXNldF9kZWFzc2VydChzdHJ1Y3QgcmVzZXRfY29udHJvbGxlcl9kZXYgKnJjZGV2LA0KPiA+
ICAJbWFzayA9IEJJVChjb250cm9sLT5kZWFzc2VydF9iaXQpOw0KPiA+ICAJdmFsdWUgPSAoY29u
dHJvbC0+ZmxhZ3MgJiBERUFTU0VSVF9TRVQpID8gbWFzayA6IDB4MDsNCj4gPiAgDQo+ID4gLQly
ZXR1cm4gcmVnbWFwX3VwZGF0ZV9iaXRzKGRhdGEtPnJlZ21hcCwgY29udHJvbC0+ZGVhc3NlcnRf
b2Zmc2V0LCBtYXNrLCB2YWx1ZSk7DQo+ID4gKwlyZXR1cm4gcmVnbWFwX3dyaXRlX2JpdHMoZGF0
YS0+cmVnbWFwLCBjb250cm9sLT5kZWFzc2VydF9vZmZzZXQsIG1hc2ssIHZhbHVlKTsNCj4gPiAg
fQ0KPiA+ICANCj4gPiAgLyoqDQoNCg==


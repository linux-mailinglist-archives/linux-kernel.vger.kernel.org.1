Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52CB22B75E0
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 06:28:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgKRFVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 00:21:44 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:52670 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726385AbgKRFVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 00:21:44 -0500
X-UUID: 4e46af33476348b9bea50bdcdbb16ff7-20201118
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=+7P9mBeoEEXeFr17rEhjdhoY8h80YhME3cFw6QX94Yo=;
        b=VI97rdeVCnYOus2bqCPCNpKfmYPYlzMlBe+pp/ZEk81sp7y8ar0753kts/a1Muoi+PuT3iUQ9oTtQ+17IQWxijILC3ci9mlwXAARsRuCCadBplMORfsvW3F3iok8ePKMcfvD/+yre96cTv4x1ZZZ2Reduimd6dz2FZ3Bup9jOQ8=;
X-UUID: 4e46af33476348b9bea50bdcdbb16ff7-20201118
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2002945904; Wed, 18 Nov 2020 13:21:42 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 18 Nov 2020 13:21:41 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 18 Nov 2020 13:21:40 +0800
Message-ID: <1605676900.25459.2.camel@mtksdaap41>
Subject: Re: [PATCH v5 07/24] clk: mediatek: Fix asymmetrical PLL enable and
 disable control
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Ikjoon Jang <ikjn@chromium.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        <srv_heupstream@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        "Yingjoe Chen" <yingjoe.chen@mediatek.com>,
        <linux-clk@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Date:   Wed, 18 Nov 2020 13:21:40 +0800
In-Reply-To: <20201118035502.GB1049148@chromium.org>
References: <1604887429-29445-1-git-send-email-weiyi.lu@mediatek.com>
         <1604887429-29445-8-git-send-email-weiyi.lu@mediatek.com>
         <20201118035502.GB1049148@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIwLTExLTE4IGF0IDExOjU1ICswODAwLCBJa2pvb24gSmFuZyB3cm90ZToNCj4g
T24gTW9uLCBOb3YgMDksIDIwMjAgYXQgMTA6MDM6MzJBTSArMDgwMCwgV2VpeWkgTHUgd3JvdGU6
DQo+ID4gSW4gZmFjdCwgdGhlIGVuX21hc2sgaXMgYSBjb21iaW5hdGlvbiBvZiBkaXZpZGVyIGVu
YWJsZSBtYXNrDQo+ID4gYW5kIHBsbCBlbmFibGUgYml0KGJpdDApLg0KPiA+IEJlZm9yZSB0aGlz
IHBhdGNoLCB3ZSBlbmFibGVkIGJvdGggZGl2aWRlciBtYXNrIGFuZCBiaXQwIGluIHByZXBhcmUo
KSwNCj4gPiBidXQgb25seSBjbGVhcmVkIHRoZSBiaXQwIGluIHVucHJlcGFyZSgpLg0KPiA+IElu
IHRoZSBmdXR1cmUsIHdlIGhvcGUgZW5fbWFzayB3aWxsIG9ubHkgYmUgdXNlZCBhcyBkaXZpZGVy
IGVuYWJsZSBtYXNrLg0KPiA+IFRoZSBlbmFibGUgcmVnaXN0ZXIoQ09OMCkgd2lsbCBiZSBzZXQg
aW4gMiBzdGVwczoNCj4gPiBmaXJzdCBpcyBkaXZpZGVyIG1hc2ssIGFuZCB0aGVuIGJpdDAgZHVy
aW5nIHByZXBhcmUoKSwgYW5kIHZpY2UgdmVyc2EuDQo+ID4gQnV0IGNvbnNpZGVyaW5nIGJhY2t3
YXJkIGNvbXBhdGliaWxpdHksIGF0IHRoaXMgc3RhZ2Ugd2UgYWxsb3cgZW5fbWFzaw0KPiA+IHRv
IGJlIGEgY29tYmluYXRpb24gb3IgYSBwdXJlIGRpdmlkZXIgZW5hYmxlIG1hc2suDQo+ID4gQW5k
IHRoZW4gd2Ugd2lsbCBtYWtlIGVuX21hc2sgYSBwdXJlIGRpdmlkZXIgZW5hYmxlIG1hc2sgaW4g
YW5vdGhlcg0KPiA+IGZvbGxvd2luZyBwYXRjaCBzZXJpZXMuDQo+IA0KPiBJIGhhdmUgYSBxdWVz
dGlvbiBvbiB0aGlzOiBBcmUgdGhlcmUgYW55IHBvc3NpYmxlIHByb2JsZW1zIG9uIGNvbnRyb2xs
aW5nDQo+IGRpdmlkZXJfZW4gYW5kIGJpdDAgYXQgdGhlIHNhbWUgdGltZT8gT3IgaXMgdGhpcyBv
bmx5IGZvciBjbGVhbnVwcz8NCj4gDQoNClllcywgdGhpcyBpcyBvbmx5IGZvciBjbGVhbnVwcyBh
bmQgY29udHJvbGxpbmcgZGl2aWRlcl9lbiBhbmQgYml0MCBhdA0KdGhlIHNhbWUgdGltZSB3aWxs
IG5vdCBjYXVzZSBhbnkgcHJvYmxlbS4NCg0KPiBJZiBtdGtfcGxsX2RhdGE6OmVuX21hc2sgaXMg
bm90IGFsbG93ZWQgdG8gY29udHJvbCB3aXRoIGJpdDAgdG9nZXRoZXIsDQo+IEkgZ3Vlc3MgcmVn
aXN0ZXJfcGxsKCkgYWxzbyBuZWVkcyB0byBjaGVjayBlbl9tYXNrOjpiaXQwIGlzIGNsZWFyZWQ/
DQo+IA0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IFdlaXlpIEx1IDx3ZWl5aS5sdUBtZWRpYXRl
ay5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvY2xrL21lZGlhdGVrL2Nsay1wbGwuYyB8IDIw
ICsrKysrKysrKysrKysrKystLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxNiBpbnNlcnRpb25z
KCspLCA0IGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Nsay9t
ZWRpYXRlay9jbGstcGxsLmMgYi9kcml2ZXJzL2Nsay9tZWRpYXRlay9jbGstcGxsLmMNCj4gPiBp
bmRleCBmNDQwZjJjZC4uMTFlZDVkMSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2Nsay9tZWRp
YXRlay9jbGstcGxsLmMNCj4gPiArKysgYi9kcml2ZXJzL2Nsay9tZWRpYXRlay9jbGstcGxsLmMN
Cj4gPiBAQCAtMjM4LDYgKzIzOCw3IEBAIHN0YXRpYyBpbnQgbXRrX3BsbF9wcmVwYXJlKHN0cnVj
dCBjbGtfaHcgKmh3KQ0KPiA+ICB7DQo+ID4gIAlzdHJ1Y3QgbXRrX2Nsa19wbGwgKnBsbCA9IHRv
X210a19jbGtfcGxsKGh3KTsNCj4gPiAgCXUzMiByOw0KPiA+ICsJdTMyIGRpdl9lbl9tYXNrOw0K
PiA+ICANCj4gPiAgCXIgPSByZWFkbChwbGwtPnB3cl9hZGRyKSB8IENPTjBfUFdSX09OOw0KPiA+
ICAJd3JpdGVsKHIsIHBsbC0+cHdyX2FkZHIpOw0KPiA+IEBAIC0yNDcsMTAgKzI0OCwxNSBAQCBz
dGF0aWMgaW50IG10a19wbGxfcHJlcGFyZShzdHJ1Y3QgY2xrX2h3ICpodykNCj4gPiAgCXdyaXRl
bChyLCBwbGwtPnB3cl9hZGRyKTsNCj4gPiAgCXVkZWxheSgxKTsNCj4gPiAgDQo+ID4gLQlyID0g
cmVhZGwocGxsLT5iYXNlX2FkZHIgKyBSRUdfQ09OMCk7DQo+ID4gLQlyIHw9IHBsbC0+ZGF0YS0+
ZW5fbWFzazsNCj4gPiArCXIgPSByZWFkbChwbGwtPmJhc2VfYWRkciArIFJFR19DT04wKSB8IENP
TjBfQkFTRV9FTjsNCj4gPiAgCXdyaXRlbChyLCBwbGwtPmJhc2VfYWRkciArIFJFR19DT04wKTsN
Cj4gPiAgDQo+ID4gKwlkaXZfZW5fbWFzayA9IHBsbC0+ZGF0YS0+ZW5fbWFzayAmIH5DT04wX0JB
U0VfRU47DQo+ID4gKwlpZiAoZGl2X2VuX21hc2spIHsNCj4gPiArCQlyID0gcmVhZGwocGxsLT5i
YXNlX2FkZHIgKyBSRUdfQ09OMCkgfCBkaXZfZW5fbWFzazsNCj4gPiArCQl3cml0ZWwociwgcGxs
LT5iYXNlX2FkZHIgKyBSRUdfQ09OMCk7DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICAJX19tdGtfcGxs
X3R1bmVyX2VuYWJsZShwbGwpOw0KPiA+ICANCj4gPiAgCXVkZWxheSgyMCk7DQo+ID4gQEAgLTI2
OCw2ICsyNzQsNyBAQCBzdGF0aWMgdm9pZCBtdGtfcGxsX3VucHJlcGFyZShzdHJ1Y3QgY2xrX2h3
ICpodykNCj4gPiAgew0KPiA+ICAJc3RydWN0IG10a19jbGtfcGxsICpwbGwgPSB0b19tdGtfY2xr
X3BsbChodyk7DQo+ID4gIAl1MzIgcjsNCj4gPiArCXUzMiBkaXZfZW5fbWFzazsNCj4gPiAgDQo+
ID4gIAlpZiAocGxsLT5kYXRhLT5mbGFncyAmIEhBVkVfUlNUX0JBUikgew0KPiA+ICAJCXIgPSBy
ZWFkbChwbGwtPmJhc2VfYWRkciArIFJFR19DT04wKTsNCj4gPiBAQCAtMjc3LDggKzI4NCwxMyBA
QCBzdGF0aWMgdm9pZCBtdGtfcGxsX3VucHJlcGFyZShzdHJ1Y3QgY2xrX2h3ICpodykNCj4gPiAg
DQo+ID4gIAlfX210a19wbGxfdHVuZXJfZGlzYWJsZShwbGwpOw0KPiA+ICANCj4gPiAtCXIgPSBy
ZWFkbChwbGwtPmJhc2VfYWRkciArIFJFR19DT04wKTsNCj4gPiAtCXIgJj0gfkNPTjBfQkFTRV9F
TjsNCj4gPiArCWRpdl9lbl9tYXNrID0gcGxsLT5kYXRhLT5lbl9tYXNrICYgfkNPTjBfQkFTRV9F
TjsNCj4gPiArCWlmIChkaXZfZW5fbWFzaykgew0KPiA+ICsJCXIgPSByZWFkbChwbGwtPmJhc2Vf
YWRkciArIFJFR19DT04wKSAmIH5kaXZfZW5fbWFzazsNCj4gPiArCQl3cml0ZWwociwgcGxsLT5i
YXNlX2FkZHIgKyBSRUdfQ09OMCk7DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJciA9IHJlYWRsKHBs
bC0+YmFzZV9hZGRyICsgUkVHX0NPTjApICYgfkNPTjBfQkFTRV9FTjsNCj4gPiAgCXdyaXRlbChy
LCBwbGwtPmJhc2VfYWRkciArIFJFR19DT04wKTsNCj4gPiAgDQo+ID4gIAlyID0gcmVhZGwocGxs
LT5wd3JfYWRkcikgfCBDT04wX0lTT19FTjsNCj4gPiAtLSANCj4gPiAxLjguMS4xLmRpcnR5DQo+
ID4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCj4gPiBs
aW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdA0KPiA+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMu
aW5mcmFkZWFkLm9yZw0KPiA+IGh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlz
dGluZm8vbGludXgtYXJtLWtlcm5lbA0KDQo=


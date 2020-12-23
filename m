Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2D172E115A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 02:24:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbgLWBYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 20:24:37 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:57124 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726361AbgLWBYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 20:24:37 -0500
X-UUID: cd6e133c2ca74fb19d15eb2175488ee9-20201223
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:Reply-To:From:Subject:Message-ID; bh=xZSMGNycrUGCDcc+7tKfKZ1TjnIFUd/ecXWYJopv86Q=;
        b=MuTzwgtTPxToCm+XYb+xNDDKmBwf6e6AcEaKd281ns+cFVWwPM+DZ5aNJ/VpSbpa+St5LwuoDMNFaLkcyTDj/aGf6oYI/Ye/uPAMqI6YUt56z2z0xu8ZGaKzahxVJhYgU5TFheDgDqk3DxRkBgmlDCYGsHtSApPpOVRqFo2ivtY=;
X-UUID: cd6e133c2ca74fb19d15eb2175488ee9-20201223
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2041247052; Wed, 23 Dec 2020 09:23:53 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by mtkmbs05n2.mediatek.inc
 (172.21.101.140) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 23 Dec
 2020 09:23:51 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 23 Dec 2020 09:23:46 +0800
Message-ID: <1608686629.18252.8.camel@mhfsdcap03>
Subject: Re: [PATCH v2, 07/17] drm/mediatek: add disp config and mm 26mhz
 clock into mutex device
From:   Yongqiang Niu <yongqiang.niu@mediatek.com>
Reply-To: Yongqiang Niu <yongqiang.niu@mediatek.com>
To:     Nicolas Boichat <drinkcat@chromium.org>
CC:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        "Rob Herring" <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        lkml <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
Date:   Wed, 23 Dec 2020 09:23:49 +0800
In-Reply-To: <CANMq1KCbmW4kbY5rbuogr9JJD5c5=-qatFs-EaWbuAxSzWmnLQ@mail.gmail.com>
References: <1607746317-4696-1-git-send-email-yongqiang.niu@mediatek.com>
         <1607746317-4696-8-git-send-email-yongqiang.niu@mediatek.com>
         <CANMq1KCbmW4kbY5rbuogr9JJD5c5=-qatFs-EaWbuAxSzWmnLQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIwLTEyLTE1IGF0IDIxOjM3ICswODAwLCBOaWNvbGFzIEJvaWNoYXQgd3JvdGU6
DQo+IE9uIFNhdCwgRGVjIDEyLCAyMDIwIGF0IDEyOjEyIFBNIFlvbmdxaWFuZyBOaXUNCj4gPHlv
bmdxaWFuZy5uaXVAbWVkaWF0ZWsuY29tPiB3cm90ZToNCj4gPg0KPiA+IHRoZXJlIGFyZSAyIG1v
cmUgY2xvY2sgbmVlZCBlbmFibGUgZm9yIGRpc3BsYXkuDQo+ID4gcGFyc2VyIHRoZXNlIGNsb2Nr
IHdoZW4gbXV0ZXggZGV2aWNlIHByb2JlLA0KPiA+IGVuYWJsZSBhbmQgZGlzYWJsZSB3aGVuIG11
dGV4IG9uL29mZg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogWW9uZ3FpYW5nIE5pdSA8eW9uZ3Fp
YW5nLm5pdUBtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvZ3B1L2RybS9tZWRp
YXRlay9tdGtfZHJtX2RkcC5jIHwgNDkgKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0t
LQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNDEgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkN
Cj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9k
ZHAuYyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2RkcC5jDQo+ID4gaW5kZXgg
NjA3ODhjMS4uZGU2MThhMSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0
ZWsvbXRrX2RybV9kZHAuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtf
ZHJtX2RkcC5jDQo+ID4gQEAgLTExOCw3ICsxMTgsNyBAQCBzdHJ1Y3QgbXRrX2RkcF9kYXRhIHsN
Cj4gPg0KPiA+ICBzdHJ1Y3QgbXRrX2RkcCB7DQo+ID4gICAgICAgICBzdHJ1Y3QgZGV2aWNlICAg
ICAgICAgICAgICAgICAgICpkZXY7DQo+ID4gLSAgICAgICBzdHJ1Y3QgY2xrICAgICAgICAgICAg
ICAgICAgICAgICpjbGs7DQo+ID4gKyAgICAgICBzdHJ1Y3QgY2xrICAgICAgICAgICAgICAgICAg
ICAgICpjbGtbM107DQo+ID4gICAgICAgICB2b2lkIF9faW9tZW0gICAgICAgICAgICAgICAgICAg
ICpyZWdzOw0KPiA+ICAgICAgICAgc3RydWN0IG10a19kaXNwX211dGV4ICAgICAgICAgICBtdXRl
eFsxMF07DQo+ID4gICAgICAgICBjb25zdCBzdHJ1Y3QgbXRrX2RkcF9kYXRhICAgICAgICpkYXRh
Ow0KPiA+IEBAIC0yNTcsMTQgKzI1NywzOSBAQCBpbnQgbXRrX2Rpc3BfbXV0ZXhfcHJlcGFyZShz
dHJ1Y3QgbXRrX2Rpc3BfbXV0ZXggKm11dGV4KQ0KPiA+ICB7DQo+ID4gICAgICAgICBzdHJ1Y3Qg
bXRrX2RkcCAqZGRwID0gY29udGFpbmVyX29mKG11dGV4LCBzdHJ1Y3QgbXRrX2RkcCwNCj4gPiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbXV0ZXhbbXV0ZXgtPmlk
XSk7DQo+ID4gLSAgICAgICByZXR1cm4gY2xrX3ByZXBhcmVfZW5hYmxlKGRkcC0+Y2xrKTsNCj4g
PiArICAgICAgIGludCByZXQ7DQo+ID4gKyAgICAgICBpbnQgaTsNCj4gPiArDQo+ID4gKyAgICAg
ICBmb3IgKGkgPSAwOyBpIDwgQVJSQVlfU0laRShkZHAtPmNsayk7IGkrKykgew0KPiA+ICsgICAg
ICAgICAgICAgICBpZiAoSVNfRVJSKGRkcC0+Y2xrW2ldKSkNCj4gPiArICAgICAgICAgICAgICAg
ICAgICAgICBjb250aW51ZTsNCj4gPiArICAgICAgICAgICAgICAgcmV0ID0gY2xrX3ByZXBhcmVf
ZW5hYmxlKGRkcC0+Y2xrW2ldKTsNCj4gPiArICAgICAgICAgICAgICAgaWYgKHJldCkgew0KPiA+
ICsgICAgICAgICAgICAgICAgICAgICAgIHByX2VycigiZmFpbGVkIHRvIGVuYWJsZSBjbG9jaywg
ZXJyICVkLiBpOiVkXG4iLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmV0
LCBpKTsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBnb3RvIGVycjsNCj4gPiArICAgICAg
ICAgICAgICAgfQ0KPiA+ICsgICAgICAgfQ0KPiA+ICsNCj4gPiArICAgICAgIHJldHVybiAwOw0K
PiA+ICsNCj4gPiArZXJyOg0KPiA+ICsgICAgICAgd2hpbGUgKC0taSA+PSAwKQ0KPiA+ICsgICAg
ICAgICAgICAgICBjbGtfZGlzYWJsZV91bnByZXBhcmUoZGRwLT5jbGtbaV0pOw0KPiA+ICsgICAg
ICAgcmV0dXJuIHJldDsNCj4gPiAgfQ0KPiA+DQo+ID4gIHZvaWQgbXRrX2Rpc3BfbXV0ZXhfdW5w
cmVwYXJlKHN0cnVjdCBtdGtfZGlzcF9tdXRleCAqbXV0ZXgpDQo+ID4gIHsNCj4gPiAgICAgICAg
IHN0cnVjdCBtdGtfZGRwICpkZHAgPSBjb250YWluZXJfb2YobXV0ZXgsIHN0cnVjdCBtdGtfZGRw
LA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBtdXRleFtt
dXRleC0+aWRdKTsNCj4gPiAtICAgICAgIGNsa19kaXNhYmxlX3VucHJlcGFyZShkZHAtPmNsayk7
DQo+ID4gKyAgICAgICBpbnQgaTsNCj4gPiArDQo+ID4gKyAgICAgICAgZm9yIChpID0gMDsgaSA8
IEFSUkFZX1NJWkUoZGRwLT5jbGspOyBpKyspIHsNCj4gPiArICAgICAgICAgICAgICAgaWYgKElT
X0VSUihkZHAtPmNsa1tpXSkpDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgY29udGludWU7
DQo+ID4gKyAgICAgICAgICAgICAgIGNsa19kaXNhYmxlX3VucHJlcGFyZShkZHAtPmNsa1tpXSk7
DQo+ID4gKyAgICAgICB9DQo+ID4gIH0NCj4gPg0KPiA+ICB2b2lkIG10a19kaXNwX211dGV4X2Fk
ZF9jb21wKHN0cnVjdCBtdGtfZGlzcF9tdXRleCAqbXV0ZXgsDQo+ID4gQEAgLTQxNSwxMSArNDQw
LDE5IEBAIHN0YXRpYyBpbnQgbXRrX2RkcF9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpw
ZGV2KQ0KPiA+ICAgICAgICAgZGRwLT5kYXRhID0gb2ZfZGV2aWNlX2dldF9tYXRjaF9kYXRhKGRl
dik7DQo+ID4NCj4gPiAgICAgICAgIGlmICghZGRwLT5kYXRhLT5ub19jbGspIHsNCj4gPiAtICAg
ICAgICAgICAgICAgZGRwLT5jbGsgPSBkZXZtX2Nsa19nZXQoZGV2LCBOVUxMKTsNCj4gPiAtICAg
ICAgICAgICAgICAgaWYgKElTX0VSUihkZHAtPmNsaykpIHsNCj4gPiAtICAgICAgICAgICAgICAg
ICAgICAgICBpZiAoUFRSX0VSUihkZHAtPmNsaykgIT0gLUVQUk9CRV9ERUZFUikNCj4gPiAtICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRldl9lcnIoZGV2LCAiRmFpbGVkIHRvIGdldCBj
bG9ja1xuIik7DQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIFBUUl9FUlIoZGRw
LT5jbGspOw0KPiA+ICsgICAgICAgICAgICAgICBpbnQgcmV0Ow0KPiA+ICsNCj4gPiArICAgICAg
ICAgICAgICAgZm9yIChpID0gMDsgaSA8IEFSUkFZX1NJWkUoZGRwLT5jbGspOyBpKyspIHsNCj4g
PiArICAgICAgICAgICAgICAgICAgICAgICBkZHAtPmNsa1tpXSA9IG9mX2Nsa19nZXQoZGV2LT5v
Zl9ub2RlLCBpKTsNCj4gPiArDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgaWYgKElTX0VS
UihkZHAtPmNsa1tpXSkpIHsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJl
dCA9IFBUUl9FUlIoZGRwLT5jbGtbaV0pOw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgaWYgKHJldCAhPSBFUFJPQkVfREVGRVIpDQo+ID4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIGRldl9lcnIoZGV2LCAiRmFpbGVkIHRvIGdldCBjbG9jayAlZFxu
IiwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBy
ZXQpOw0KPiA+ICsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiBy
ZXQ7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgfQ0KPiANCj4gVXNlIG9mX2Nsa19idWxr
X2dldF9hbGwgaW5zdGVhZD8NCj4gDQo+IGRkcC0+bnVtX2Nsa3MgPSBvZl9jbGtfYnVsa19nZXRf
YWxsKGRldi0+b2Zfbm9kZSwgJmRkcC0+Y2xrcyk7DQo+IC4uLg0KPiANCj4gVGhlbiB0aGUgY2Fs
bHMgYWJvdmUgY2FuIGJlIGNsa19idWxrX2VuYWJsZS9jbGtfYnVsa19kaXNhYmxlIHVzaW5nDQo+
IG51bV9jbGtzIGFuZCBjbGtzLg0KPiANCg0Kd2lsbCBiZSBmaXhlZCBpbiBuZXh0IHZlcnNpb24N
Cj4gDQo+ID4gICAgICAgICAgICAgICAgIH0NCj4gPiAgICAgICAgIH0NCj4gPg0KPiA+IC0tDQo+
ID4gMS44LjEuMS5kaXJ0eQ0KPiA+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fDQo+ID4gTGludXgtbWVkaWF0ZWsgbWFpbGluZyBsaXN0DQo+ID4gTGludXgt
bWVkaWF0ZWtAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiA+IGh0dHA6Ly9saXN0cy5pbmZyYWRlYWQu
b3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbWVkaWF0ZWsNCg0K


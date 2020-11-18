Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1E1D2B7CF4
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 12:45:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgKRLmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 06:42:08 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:56807 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726156AbgKRLmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 06:42:07 -0500
X-UUID: f1e27877f04f4556a64f568c17419b0f-20201118
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=TsP3P6+jsD2R9/50TQeqW2f928Hda5KezmSySNP5YZI=;
        b=ujTmcymNeKqa8BInRcAtNURiLmZ79nuecQPKK3XgC4laFZzBIhn0wg7lT3tBB2lcrT4q/vQheRTAu/YPHOygFdc2ZErqT3/1+3lDF2q8DLM+iK63lOXSzFQGODLjsHTra75XZWrN4Ni0WiYVRB/WB+54nksSgqt1OfQMzTGR1G8=;
X-UUID: f1e27877f04f4556a64f568c17419b0f-20201118
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <hsin-hsiung.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1353141535; Wed, 18 Nov 2020 19:42:02 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 18 Nov 2020 19:42:01 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 18 Nov 2020 19:42:00 +0800
Message-ID: <1605699721.24420.4.camel@mtksdaap41>
Subject: Re: [PATCH v3 4/4] soc: mediatek: pwrap: add pwrap driver for
 MT6873/8192 SoCs
From:   Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
To:     Fei Shao <fshao@chromium.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Argus Lin <argus.lin@mediatek.com>, <drinkcat@chromium.org>,
        <devicetree@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <hsin-hsiung.wang@mediatek.com>
Date:   Wed, 18 Nov 2020 19:42:01 +0800
In-Reply-To: <CAJ66y9HCTEYcuGpd_C4bZdD3PDOytUW00-PK6u9F6=v67CCXAg@mail.gmail.com>
References: <1600686235-27979-1-git-send-email-hsin-hsiung.wang@mediatek.com>
         <1600686235-27979-5-git-send-email-hsin-hsiung.wang@mediatek.com>
         <CAJ66y9HCTEYcuGpd_C4bZdD3PDOytUW00-PK6u9F6=v67CCXAg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCk9uIFR1ZSwgMjAyMC0wOS0yMiBhdCAxNzo0OSArMDgwMCwgRmVpIFNoYW8gd3JvdGU6
DQo+IE9uIE1vbiwgU2VwIDIxLCAyMDIwIGF0IDExOjAzIEFNIEhzaW4tSHNpdW5nIFdhbmcNCj4g
PGhzaW4taHNpdW5nLndhbmdAbWVkaWF0ZWsuY29tPiB3cm90ZToNCj4gPg0KPiA+IE1UNjg3My84
MTkyIGFyZSBoaWdobHkgaW50ZWdyYXRlZCBTb0NzIGFuZCB1c2UgUE1JQ19NVDYzNTkgZm9yDQo+
ID4gcG93ZXIgbWFuYWdlbWVudC4gVGhpcyBwYXRjaCBhZGRzIHB3cmFwIG1hc3RlciBkcml2ZXIg
dG8NCj4gPiBhY2Nlc3MgUE1JQ19NVDYzNTkuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBIc2lu
LUhzaXVuZyBXYW5nIDxoc2luLWhzaXVuZy53YW5nQG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4g
PiAgZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLXBtaWMtd3JhcC5jIHwgMjkgKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDI5IGluc2VydGlvbnMoKykN
Cj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstcG1pYy13cmFw
LmMgYi9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstcG1pYy13cmFwLmMNCj4gPiBpbmRleCAxNDli
ZjAyLi5jNzNlOTJiIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1w
bWljLXdyYXAuYw0KPiA+ICsrKyBiL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1wbWljLXdyYXAu
Yw0KPiA+IEBAIC02MzIsNiArNjMyLDE3IEBAIHN0YXRpYyBpbnQgbXQ2Nzk3X3JlZ3NbXSA9IHsN
Cj4gPiAgICAgICAgIFtQV1JBUF9EQ01fREJDX1BSRF0gPSAgICAgICAgICAgMHgxRDQsDQo+ID4g
IH07DQo+ID4NCj4gPiArc3RhdGljIGludCBtdDY4NzNfcmVnc1tdID0gew0KPiA+ICsgICAgICAg
W1BXUkFQX0lOSVRfRE9ORTJdID0gICAgICAgICAgICAweDAsDQo+ID4gKyAgICAgICBbUFdSQVBf
VElNRVJfRU5dID0gICAgICAgICAgICAgIDB4M0UwLA0KPiA+ICsgICAgICAgW1BXUkFQX0lOVF9F
Tl0gPSAgICAgICAgICAgICAgICAweDQ0OCwNCj4gPiArICAgICAgIFtQV1JBUF9XQUNTMl9DTURd
ID0gICAgICAgICAgICAgMHhDODAsDQo+ID4gKyAgICAgICBbUFdSQVBfU1dJTkZfMl9XREFUQV8z
MV8wXSA9ICAgIDB4Qzg0LA0KPiA+ICsgICAgICAgW1BXUkFQX1NXSU5GXzJfUkRBVEFfMzFfMF0g
PSAgICAweEM5NCwNCj4gPiArICAgICAgIFtQV1JBUF9XQUNTMl9WTERDTFJdID0gICAgICAgICAg
MHhDQTQsDQo+ID4gKyAgICAgICBbUFdSQVBfV0FDUzJfUkRBVEFdID0gICAgICAgICAgIDB4Q0E4
LA0KPiA+ICt9Ow0KPiA+ICsNCj4gPiAgc3RhdGljIGludCBtdDc2MjJfcmVnc1tdID0gew0KPiA+
ICAgICAgICAgW1BXUkFQX01VWF9TRUxdID0gICAgICAgICAgICAgICAweDAsDQo+ID4gICAgICAg
ICBbUFdSQVBfV1JBUF9FTl0gPSAgICAgICAgICAgICAgIDB4NCwNCj4gPiBAQCAtMTA1MCw2ICsx
MDYxLDcgQEAgZW51bSBwd3JhcF90eXBlIHsNCj4gPiAgICAgICAgIFBXUkFQX01UNjc2NSwNCj4g
PiAgICAgICAgIFBXUkFQX01UNjc3OSwNCj4gPiAgICAgICAgIFBXUkFQX01UNjc5NywNCj4gPiAr
ICAgICAgIFBXUkFQX01UNjg3MywNCj4gPiAgICAgICAgIFBXUkFQX01UNzYyMiwNCj4gPiAgICAg
ICAgIFBXUkFQX01UODEzNSwNCj4gPiAgICAgICAgIFBXUkFQX01UODE3MywNCj4gPiBAQCAtMTUx
Miw2ICsxNTI0LDcgQEAgc3RhdGljIGludCBwd3JhcF9pbml0X2NpcGhlcihzdHJ1Y3QgcG1pY193
cmFwcGVyICp3cnApDQo+ID4gICAgICAgICBjYXNlIFBXUkFQX01UNzYyMjoNCj4gPiAgICAgICAg
ICAgICAgICAgcHdyYXBfd3JpdGVsKHdycCwgMCwgUFdSQVBfQ0lQSEVSX0VOKTsNCj4gPiAgICAg
ICAgICAgICAgICAgYnJlYWs7DQo+ID4gKyAgICAgICBjYXNlIFBXUkFQX01UNjg3MzoNCj4gPiAg
ICAgICAgIGNhc2UgUFdSQVBfTVQ4MTgzOg0KPiA+ICAgICAgICAgICAgICAgICBicmVhazsNCj4g
PiAgICAgICAgIH0NCj4gPiBAQCAtMTk0OCw2ICsxOTYxLDE5IEBAIHN0YXRpYyBjb25zdCBzdHJ1
Y3QgcG1pY193cmFwcGVyX3R5cGUgcHdyYXBfbXQ2Nzk3ID0gew0KPiA+ICAgICAgICAgLmluaXRf
c29jX3NwZWNpZmljID0gTlVMTCwNCj4gPiAgfTsNCj4gPg0KPiA+ICtzdGF0aWMgc3RydWN0IHBt
aWNfd3JhcHBlcl90eXBlIHB3cmFwX210Njg3MyA9IHsNCj4gc3RhdGljIGNvbnN0IHN0cnVjdC4N
Cj4gDQoNClRoYW5rcywgSSB3aWxsIHVwZGF0ZSBpdCBpbiBuZXh0IHBhdGNoLg0KDQo+ID4gKyAg
ICAgICAucmVncyA9IG10Njg3M19yZWdzLA0KPiA+ICsgICAgICAgLnR5cGUgPSBQV1JBUF9NVDY4
NzMsDQo+ID4gKyAgICAgICAuYXJiX2VuX2FsbCA9IDB4Nzc3ZiwNCj4gPiArICAgICAgIC5pbnRf
ZW5fYWxsID0gQklUKDQpIHwgQklUKDUpLA0KPiA+ICsgICAgICAgLmludDFfZW5fYWxsID0gMCwN
Cj4gPiArICAgICAgIC5zcGlfdyA9IFBXUkFQX01BTl9DTURfU1BJX1dSSVRFLA0KPiA+ICsgICAg
ICAgLndkdF9zcmMgPSBQV1JBUF9XRFRfU1JDX01BU0tfQUxMLA0KPiA+ICsgICAgICAgLmNhcHMg
PSBQV1JBUF9DQVBfQVJCLA0KPiA+ICsgICAgICAgLmluaXRfcmVnX2Nsb2NrID0gcHdyYXBfY29t
bW9uX2luaXRfcmVnX2Nsb2NrLA0KPiA+ICsgICAgICAgLmluaXRfc29jX3NwZWNpZmljID0gTlVM
TCwNCj4gPiArfTsNCj4gPiArDQo+ID4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgcG1pY193cmFwcGVy
X3R5cGUgcHdyYXBfbXQ3NjIyID0gew0KPiA+ICAgICAgICAgLnJlZ3MgPSBtdDc2MjJfcmVncywN
Cj4gPiAgICAgICAgIC50eXBlID0gUFdSQVBfTVQ3NjIyLA0KPiA+IEBAIC0yMDI2LDYgKzIwNTIs
OSBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBvZl9wd3JhcF9tYXRjaF90Ymxb
XSA9IHsNCj4gPiAgICAgICAgICAgICAgICAgLmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ2Nzk3
LXB3cmFwIiwNCj4gPiAgICAgICAgICAgICAgICAgLmRhdGEgPSAmcHdyYXBfbXQ2Nzk3LA0KPiA+
ICAgICAgICAgfSwgew0KPiA+ICsgICAgICAgICAgICAgICAuY29tcGF0aWJsZSA9ICJtZWRpYXRl
ayxtdDY4NzMtcHdyYXAiLA0KPiA+ICsgICAgICAgICAgICAgICAuZGF0YSA9ICZwd3JhcF9tdDY4
NzMsDQo+ID4gKyAgICAgICB9LCB7DQo+ID4gICAgICAgICAgICAgICAgIC5jb21wYXRpYmxlID0g
Im1lZGlhdGVrLG10NzYyMi1wd3JhcCIsDQo+ID4gICAgICAgICAgICAgICAgIC5kYXRhID0gJnB3
cmFwX210NzYyMiwNCj4gPiAgICAgICAgIH0sIHsNCg0K


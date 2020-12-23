Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 315CD2E10CD
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 01:35:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726039AbgLWAeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 19:34:03 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:32923 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725300AbgLWAeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 19:34:03 -0500
X-UUID: b4139c22d19b47bd91bc50bd861e5b0e-20201223
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:Reply-To:From:Subject:Message-ID; bh=nFTEuMzoRWG8Gam4dwBb/ELgnkKPHK0rpDb9IHH32fw=;
        b=Nnh9/B15F7H9REEscR21dw2UKihYFkAqzS/mkSjTSzTuLGUHF5m+1GqAtYwSb+bO2kbTvpzXKHRH3utfVxNWe9nAALA011aeUph5ZveRFxe64O5zswWKj/oaAbfeQMbQF71B4IiasEaFVGcvuAOBdUgx0XkWZBJQiK4Bd+Fwqzw=;
X-UUID: b4139c22d19b47bd91bc50bd861e5b0e-20201223
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 773939318; Wed, 23 Dec 2020 08:33:17 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by mtkmbs07n1.mediatek.inc
 (172.21.101.16) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 23 Dec
 2020 08:33:17 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 23 Dec 2020 08:33:11 +0800
Message-ID: <1608683595.18252.0.camel@mhfsdcap03>
Subject: Re: [PATCH v1, 3/5] mailbox: mediatek: add control_by_sw private
 data
From:   Yongqiang Niu <yongqiang.niu@mediatek.com>
Reply-To: Yongqiang Niu <yongqiang.niu@mediatek.com>
To:     Nicolas Boichat <drinkcat@chromium.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        CK Hu <ck.hu@mediatek.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        "Dennis YC Hsieh" <dennis-yc.hsieh@mediatek.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>
Date:   Wed, 23 Dec 2020 08:33:15 +0800
In-Reply-To: <CANMq1KDWwfijinZq0b8BVqvYBj1fOHFpfMPLbzj0JR8z9LKypw@mail.gmail.com>
References: <1607141728-17307-1-git-send-email-yongqiang.niu@mediatek.com>
         <1607141728-17307-4-git-send-email-yongqiang.niu@mediatek.com>
         <CANMq1KDWwfijinZq0b8BVqvYBj1fOHFpfMPLbzj0JR8z9LKypw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCAyMDIwLTEyLTA1IGF0IDE1OjM1ICswODAwLCBOaWNvbGFzIEJvaWNoYXQgd3JvdGU6
DQo+IE9uIFNhdCwgRGVjIDUsIDIwMjAgYXQgMTI6MTggUE0gWW9uZ3FpYW5nIE5pdQ0KPiA8eW9u
Z3FpYW5nLm5pdUBtZWRpYXRlay5jb20+IHdyb3RlOg0KPiA+DQo+ID4gYWRkIGNvbnRyb2xfYnlf
c3cgcHJpdmF0ZSBkYXRhDQo+IA0KPiBDYW4geW91IGRlc2NyaWJlIGluIGEgYml0IG1vcmUgZGV0
YWlscyB3aGF0IHRoaXMgbWVhbnM/DQoNCmdjZSB3b3JrcyB3ZWxsIHdpdGhvdXQgdGhpcyBwYXRj
aCwgYW5kIGl0IHdpbGwgYmUgcmVtb3ZlZCBpbg0KbmV4dCB2ZXJzaW9uDQo+IA0KPiA+DQo+ID4g
U2lnbmVkLW9mZi1ieTogWW9uZ3FpYW5nIE5pdSA8eW9uZ3FpYW5nLm5pdUBtZWRpYXRlay5jb20+
DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmMgfCA3ICsr
KysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmMgYi9kcml2ZXJzL21h
aWxib3gvbXRrLWNtZHEtbWFpbGJveC5jDQo+ID4gaW5kZXggNTY2NWI2ZS4uMWMwMWZlMCAxMDA2
NDQNCj4gPiAtLS0gYS9kcml2ZXJzL21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5jDQo+ID4gKysr
IGIvZHJpdmVycy9tYWlsYm94L210ay1jbWRxLW1haWxib3guYw0KPiA+IEBAIC0zNiw2ICszNiw4
IEBADQo+ID4gICNkZWZpbmUgQ01EUV9USFJfV0FJVF9UT0tFTiAgICAgICAgICAgIDB4MzANCj4g
PiAgI2RlZmluZSBDTURRX1RIUl9QUklPUklUWSAgICAgICAgICAgICAgMHg0MA0KPiA+DQo+ID4g
KyNkZWZpbmUgR0NFX0dDVExfVkFMVUUgICAgICAgICAgICAgICAgIDB4NDgNCj4gPiArDQo+ID4g
ICNkZWZpbmUgQ01EUV9USFJfQUNUSVZFX1NMT1RfQ1lDTEVTICAgIDB4MzIwMA0KPiA+ICAjZGVm
aW5lIENNRFFfVEhSX0VOQUJMRUQgICAgICAgICAgICAgICAweDENCj4gPiAgI2RlZmluZSBDTURR
X1RIUl9ESVNBQkxFRCAgICAgICAgICAgICAgMHgwDQo+ID4gQEAgLTc2LDExICs3OCwxMyBAQCBz
dHJ1Y3QgY21kcSB7DQo+ID4gICAgICAgICBzdHJ1Y3QgY2xrICAgICAgICAgICAgICAqY2xvY2s7
DQo+ID4gICAgICAgICBib29sICAgICAgICAgICAgICAgICAgICBzdXNwZW5kZWQ7DQo+ID4gICAg
ICAgICB1OCAgICAgICAgICAgICAgICAgICAgICBzaGlmdF9wYTsNCj4gPiArICAgICAgIGJvb2wg
ICAgICAgICAgICAgICAgICAgIGNvbnRyb2xfYnlfc3c7DQo+ID4gIH07DQo+ID4NCj4gPiAgc3Ry
dWN0IGdjZV9wbGF0IHsNCj4gPiAgICAgICAgIHUzMiB0aHJlYWRfbnI7DQo+ID4gICAgICAgICB1
OCBzaGlmdDsNCj4gPiArICAgICAgIGJvb2wgY29udHJvbF9ieV9zdzsNCj4gPiAgfTsNCj4gPg0K
PiA+ICB1OCBjbWRxX2dldF9zaGlmdF9wYShzdHJ1Y3QgbWJveF9jaGFuICpjaGFuKQ0KPiA+IEBA
IC0xMjEsNiArMTI1LDggQEAgc3RhdGljIHZvaWQgY21kcV9pbml0KHN0cnVjdCBjbWRxICpjbWRx
KQ0KPiA+ICAgICAgICAgaW50IGk7DQo+ID4NCj4gPiAgICAgICAgIFdBUk5fT04oY2xrX2VuYWJs
ZShjbWRxLT5jbG9jaykgPCAwKTsNCj4gPiArICAgICAgIGlmIChjbWRxLT5jb250cm9sX2J5X3N3
KQ0KPiA+ICsgICAgICAgICAgICAgICB3cml0ZWwoMHg3LCBjbWRxLT5iYXNlICsgR0NFX0dDVExf
VkFMVUUpOw0KPiANCj4gV2hhdCBpcyAweDc/IERlZmluZSBhIG1hY3JvIGZvciB0aGVzZSBiaXRz
Pw0KPiANCj4gPiAgICAgICAgIHdyaXRlbChDTURRX1RIUl9BQ1RJVkVfU0xPVF9DWUNMRVMsIGNt
ZHEtPmJhc2UgKyBDTURRX1RIUl9TTE9UX0NZQ0xFUyk7DQo+ID4gICAgICAgICBmb3IgKGkgPSAw
OyBpIDw9IENNRFFfTUFYX0VWRU5UOyBpKyspDQo+ID4gICAgICAgICAgICAgICAgIHdyaXRlbChp
LCBjbWRxLT5iYXNlICsgQ01EUV9TWU5DX1RPS0VOX1VQREFURSk7DQo+ID4gQEAgLTUzNiw2ICs1
NDIsNyBAQCBzdGF0aWMgaW50IGNtZHFfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRl
dikNCj4gPg0KPiA+ICAgICAgICAgY21kcS0+dGhyZWFkX25yID0gcGxhdF9kYXRhLT50aHJlYWRf
bnI7DQo+ID4gICAgICAgICBjbWRxLT5zaGlmdF9wYSA9IHBsYXRfZGF0YS0+c2hpZnQ7DQo+ID4g
KyAgICAgICBjbWRxLT5jb250cm9sX2J5X3N3ID0gcGxhdF9kYXRhLT5jb250cm9sX2J5X3N3Ow0K
PiA+ICAgICAgICAgY21kcS0+aXJxX21hc2sgPSBHRU5NQVNLKGNtZHEtPnRocmVhZF9uciAtIDEs
IDApOw0KPiA+ICAgICAgICAgZXJyID0gZGV2bV9yZXF1ZXN0X2lycShkZXYsIGNtZHEtPmlycSwg
Y21kcV9pcnFfaGFuZGxlciwgSVJRRl9TSEFSRUQsDQo+ID4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICJtdGtfY21kcSIsIGNtZHEpOw0KPiA+IC0tDQo+ID4gMS44LjEuMS5kaXJ0eQ0K
PiA+DQoNCg==


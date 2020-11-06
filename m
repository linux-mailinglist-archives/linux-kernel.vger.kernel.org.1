Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD752A92F4
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 10:40:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgKFJkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 04:40:14 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:60725 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726139AbgKFJkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 04:40:13 -0500
X-UUID: 98e6f12c83284343b59c84fff5705688-20201106
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=hwcTnf+x5JkMX4z/81xeJjmzHGsQ5Nx2TTLtSPHzhSo=;
        b=QExinJOCt6PZPLpMdjxVoWAuhBkFexuBf6vhcx7bHETl+mSd4p0SGaXvWMOYGNN6sVbHhhVMUl5DWj/K7ldSMS/PVCxWfKFI2h9h1zYOnfNmOhdoJ7Xld3FdCl+EQo/XB9jclgpUie7EQhytzm7ShD/AG3E2q28kHQfF8/bqpJ0=;
X-UUID: 98e6f12c83284343b59c84fff5705688-20201106
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <macpaul.lin@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 817783204; Fri, 06 Nov 2020 17:29:48 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 6 Nov 2020 17:29:46 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 6 Nov 2020 17:29:46 +0800
Message-ID: <1604654987.24301.23.camel@mtkswgap22>
Subject: Re: [PATCH 1/2] dt-bindings: usb: mediatek,mtk-xhci: add
 keep-clock-on
From:   Macpaul Lin <macpaul.lin@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        "Chunfeng Yun" <chunfeng.yun@mediatek.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Ainge Hsu <ainge.hsu@mediatek.com>,
        Eddie Hung <eddie.hung@mediatek.com>,
        "Mediatek WSD Upstream" <wsd_upstream@mediatek.com>,
        Macpaul Lin <macpaul@gmail.com>
Date:   Fri, 6 Nov 2020 17:29:47 +0800
In-Reply-To: <20201104223926.GA54259@bogus>
References: <1604301530-31546-1-git-send-email-macpaul.lin@mediatek.com>
         <20201104223926.GA54259@bogus>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIwLTExLTA0IGF0IDE2OjM5IC0wNjAwLCBSb2IgSGVycmluZyB3cm90ZToNCj4g
T24gTW9uLCBOb3YgMDIsIDIwMjAgYXQgMDM6MTg6NDhQTSArMDgwMCwgTWFjcGF1bCBMaW4gd3Jv
dGU6DQo+ID4gT3B0aW9uICJtZWRpYXRlayxrZWVwLWNsb2NrLW9uIiBtZWFucyB0byBrZWVwIGNs
b2NrIG9uIGR1cmluZyBzeXN0ZW0NCj4gPiBzdXNwZW5kIGFuZCByZXN1bWUuIFNvbWUgcGxhdGZv
cm0gd2lsbCBmbHVzaCByZWdpc3RlciBzZXR0aW5ncyBpZiBjbG9jayBoYXMNCj4gPiBiZWVuIGRp
c2FibGVkIHdoZW4gc3lzdGVtIGlzIHN1c3BlbmRlZC4gU2V0IHRoaXMgb3B0aW9uIHRvIGF2b2lk
IGNsb2NrIG9mZi4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBNYWNwYXVsIExpbiA8bWFjcGF1
bC5saW5AbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICAuLi4vZGV2aWNldHJlZS9iaW5kaW5n
cy91c2IvbWVkaWF0ZWssbXRrLXhoY2kueWFtbCB8ICAgIDcgKysrKysrKw0KPiA+ICAxIGZpbGUg
Y2hhbmdlZCwgNyBpbnNlcnRpb25zKCspDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL0RvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy91c2IvbWVkaWF0ZWssbXRrLXhoY2kueWFtbCBiL0Rv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy91c2IvbWVkaWF0ZWssbXRrLXhoY2kueWFt
bA0KPiA+IGluZGV4IGVhNjk2YzguLmE5NTZkZGUgMTAwNjQ0DQo+ID4gLS0tIGEvRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3VzYi9tZWRpYXRlayxtdGsteGhjaS55YW1sDQo+ID4g
KysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3VzYi9tZWRpYXRlayxtdGst
eGhjaS55YW1sDQo+ID4gQEAgLTEwNCw2ICsxMDQsMTIgQEAgcHJvcGVydGllczoNCj4gPiAgICAg
IGRlc2NyaXB0aW9uOiBlbmFibGUgVVNCIHJlbW90ZSB3YWtldXAsIHNlZSBwb3dlci93YWtldXAt
c291cmNlLnR4dA0KPiA+ICAgICAgdHlwZTogYm9vbGVhbg0KPiA+ICANCj4gPiArICBtZWRpYXRl
ayxrZWVwLWNsb2NrLW9uOg0KPiA+ICsgICAgZGVzY3JpcHRpb246IHwNCj4gPiArICAgICAgS2Vl
cCBjbG9jayBvbiBkdXJpbmcgc3lzdGVtIHN1c3BlbmQgYW5kIHJlc3VtZS4gU29tZSBwbGF0Zm9y
bSB3aWxsIGZsdXNoDQo+ID4gKyAgICAgIHJlZ2lzdGVyIHNldHRpbmdzIGlmIGNsb2NrIGhhcyBi
ZWVuIGRpc2FibGVkIHdoZW4gc3lzdGVtIGlzIHN1c3BlbmRlZC4NCj4gPiArICAgIHR5cGU6IGJv
b2xlYW4NCj4gPiArDQo+IA0KPiBUaGlzIHNob3VsZCBiZSBpbXBsaWVkIGJ5IHRoZSBjb21wYXRp
YmxlIHN0cmluZy4NCg0KVGhpcyBzaG91bGQgYmUgYW4gcHJvcGVydHkgYWNjb3JkaW5nIHRvIHN5
c3RlbS13aWRlIGRlc2lnbi4NCg0KTXRrLXhoY2kgbWF5IGJlIGFwcGxpZWQgdG8gZGlmZmVyZW50
IHByb2R1Y3QgbGluZXMgZm9yIHRoZSBzYW1lIHBsYXRmb3JtDQooSUMpLiBTdXNwZW5kIG9uIHBo
b25lIHN5c3RlbSBpcyBkaWZmZXJlbnQgdG8gdGFibGV0IG9yIGxhcHRvcC4gUGhvbmUncw0KcG93
ZXIgbWFuYWdlbWVudCBtb2R1bGUgd2lsbCB0dXJuIG9mZiBYSENJJ3MgcG93ZXIgb25jZSB0aGUg
Y2xvY2sgaGFzDQpiZWVuIHR1cm5lZCBvZmYuIEZvciBleGFtcGxlLCB0aGUgaGVhZHNldCBwbHVn
Z2VkIGludG8gcGhvbmUgd29uJ3QgZG8NCmRpc2Nvbm5lY3QgYW5kIHJlLWVudW1lcmF0aW9uIGR1
cmluZyBzeXN0ZW0gc3VzcGVuZC4gQ2xpY2sgYSBidXR0b24gb24NCnRoZSBoZWFkc2V0IHRvIHdh
a2UtdXAgcGhvbmUgaXMgbmVjZXNzYXJ5LCBhbmQgdGhlbiwgWEhDSSBuZWVkcyByZWFkeSB0bw0K
d29yayBpbW1lZGlhdGVseS4NCg0KSWYgdGhlIElDIGhhcyBiZWVuIGFwcGxpZWQgdG8gYSB0YWJs
ZXQgb3IgbGFwdG9wIHByb2R1Y3QuIFdoZW4gc3lzdGVtIGlzDQpzdXNwZW5kaW5nLCB0aGUgaGVh
ZHNldCB3aWxsIGJlIGRpc2Nvbm5lY3RlZC4gVGhlIGhlYWRzZXQgd2lsbCBkbw0KcmUtZW51bWVy
YXRlIHdoZW4gc3lzdGVtIGlzIHdha2luZyB1cC4gSW4gdGhpcyBraW5kIG9mIGFwcGxpY2F0aW9u
cywgdGhlDQpwb3dlciBvZiBYSENJIGNhbiBiZSB0dXJuZWQgb2ZmIHdpdGggY2xvY2suDQoNCj4g
PiAgICBtZWRpYXRlayxzeXNjb24td2FrZXVwOg0KPiA+ICAgICAgJHJlZjogL3NjaGVtYXMvdHlw
ZXMueWFtbCMvZGVmaW5pdGlvbnMvcGhhbmRsZS1hcnJheQ0KPiA+ICAgICAgbWF4SXRlbXM6IDEN
Cj4gPiBAQCAtMTc1LDYgKzE4MSw3IEBAIGV4YW1wbGVzOg0KPiA+ICAgICAgICAgIGltb2QtaW50
ZXJ2YWwtbnMgPSA8MTAwMDA+Ow0KPiA+ICAgICAgICAgIG1lZGlhdGVrLHN5c2Nvbi13YWtldXAg
PSA8JnBlcmljZmcgMHg0MDAgMT47DQo+ID4gICAgICAgICAgd2FrZXVwLXNvdXJjZTsNCj4gPiAr
ICAgICAgICBtZWRpYXRlayxrZWVwLWNsb2NrLW9uOw0KPiA+ICAgICAgICAgIHVzYjMtbHBtLWNh
cGFibGU7DQo+ID4gICAgICB9Ow0KPiA+ICAuLi4NCj4gPiAtLSANCj4gPiAxLjcuOS41DQoNCkFm
dGVyIGEgZGlzY3Vzc2lvbiB3aXRoIENodW5mZW5nLCBJJ2xsIHNlbmQgYSBuZXcgdmVyc2lvbiBm
b3IgDQpEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdXNiL21lZGlhdGVrLG10ay14
aGNpLnR4dCBiZWNhdXNlIHRoZQ0KWUFNTCBmaWxlIHN0aWxsIG5lZWQgdG8gYmUgcmV2aXNlZC4g
VGhlIHByb3BlcnR5DQoibWVkaWF0ZWssa2VlcC1jbG9jay1vbiIgd2lsbCBiZSByZW5hbWVkIHRv
ICJtZWRpYXRlayxzdHItY2xvY2stb24iIGZvcg0KaW1wbHlpbmcgaXQgcmVsYXRlcyB0byBzdXNw
ZW5kL3Jlc3VtZSBjYXBhYmlsaXR5Lg0KDQpUaGFua3MuDQpNYWNwYXVsIExpbg0K


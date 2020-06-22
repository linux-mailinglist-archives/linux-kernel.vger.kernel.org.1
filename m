Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB88202E6C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jun 2020 04:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731076AbgFVChH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Jun 2020 22:37:07 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:41375 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731032AbgFVChG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 22:37:06 -0400
X-UUID: 11e8f40cb6fb4ec8891f034011c311c3-20200622
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=3L2iJRLFz0cWplF3YyvVHCZSfWtaCZG+LYZCcDp7xIo=;
        b=XdcRkVR51MYtCRyOm6g8Z2uIEq2FZNuPi3xmoer3blxqdeD8/62TjaUeyzObS3a5An1O2scvBT9BRc1K/vXJxV7+jRS6nHaG+cb466vkT7A25bSn1CSBpfeM/F5gD2crPuQm3bYmeM9C6TDYV/xoD0w2pALLcS/OIlY1+N8pMNc=;
X-UUID: 11e8f40cb6fb4ec8891f034011c311c3-20200622
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <bibby.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 323343844; Mon, 22 Jun 2020 10:37:05 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 22 Jun 2020 10:36:49 +0800
Received: from [172.21.77.4] (172.21.77.4) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 22 Jun 2020 10:36:40 +0800
Message-ID: <1592793410.11692.5.camel@mtksdaap41>
Subject: Re: [PATCH v7 4/4] mailbox: mediatek: cmdq: clear task in channel
 before shutdown
From:   Bibby Hsieh <bibby.hsieh@mediatek.com>
To:     Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        CK Hu <ck.hu@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        HS Liao <hs.liao@mediatek.com>
Date:   Mon, 22 Jun 2020 10:36:50 +0800
In-Reply-To: <1592745731-14614-5-git-send-email-dennis-yc.hsieh@mediatek.com>
References: <1592745731-14614-1-git-send-email-dennis-yc.hsieh@mediatek.com>
         <1592745731-14614-5-git-send-email-dennis-yc.hsieh@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: EAE0CFC385DA52FD097CAAFA54CAE7070AA1C8B7CEE452C921733A983F9C1ED12000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UmV2aWV3ZWQtYnk6IEJpYmJ5IEhzaWVoIDxiaWJieS5oc2llaEBtZWRpYXRlay5jb20+DQoNClRo
YW5rcy4NCg0KT24gU3VuLCAyMDIwLTA2LTIxIGF0IDIxOjIyICswODAwLCBEZW5uaXMgWUMgSHNp
ZWggd3JvdGU6DQo+IERvIHN1Y2Nlc3MgY2FsbGJhY2sgaW4gY2hhbm5lbCB3aGVuIHNodXRkb3du
LiBGb3IgdGhvc2UgdGFzayBub3QgZmluaXNoLA0KPiBjYWxsYmFjayB3aXRoIGVycm9yIGNvZGUg
dGh1cyBjbGllbnQgaGFzIGNoYW5jZSB0byBjbGVhbnVwIG9yIHJlc2V0Lg0KPiANCj4gU2lnbmVk
LW9mZi1ieTogRGVubmlzIFlDIEhzaWVoIDxkZW5uaXMteWMuaHNpZWhAbWVkaWF0ZWsuY29tPg0K
PiBSZXZpZXdlZC1ieTogQ0sgSHUgPGNrLmh1QG1lZGlhdGVrLmNvbT4NCj4gLS0tDQo+ICBkcml2
ZXJzL21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5jIHwgICAzOCArKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCAzOCBpbnNlcnRpb25zKCspDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tYWlsYm94L210ay1jbWRxLW1haWxib3guYyBiL2Ry
aXZlcnMvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmMNCj4gaW5kZXggOTk5NGFjOTQyNmQ2Li5i
NTZkMzQwYzg5ODIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbWFpbGJveC9tdGstY21kcS1tYWls
Ym94LmMNCj4gKysrIGIvZHJpdmVycy9tYWlsYm94L210ay1jbWRxLW1haWxib3guYw0KPiBAQCAt
Mzg3LDYgKzM4NywxMiBAQCBzdGF0aWMgaW50IGNtZHFfbWJveF9zZW5kX2RhdGEoc3RydWN0IG1i
b3hfY2hhbiAqY2hhbiwgdm9pZCAqZGF0YSkNCj4gIA0KPiAgCWlmIChsaXN0X2VtcHR5KCZ0aHJl
YWQtPnRhc2tfYnVzeV9saXN0KSkgew0KPiAgCQlXQVJOX09OKGNsa19lbmFibGUoY21kcS0+Y2xv
Y2spIDwgMCk7DQo+ICsJCS8qDQo+ICsJCSAqIFRoZSB0aHJlYWQgcmVzZXQgd2lsbCBjbGVhciB0
aHJlYWQgcmVsYXRlZCByZWdpc3RlciB0byAwLA0KPiArCQkgKiBpbmNsdWRpbmcgcGMsIGVuZCwg
cHJpb3JpdHksIGlycSwgc3VzcGVuZCBhbmQgZW5hYmxlLiBUaHVzDQo+ICsJCSAqIHNldCBDTURR
X1RIUl9FTkFCTEVEIHRvIENNRFFfVEhSX0VOQUJMRV9UQVNLIHdpbGwgZW5hYmxlDQo+ICsJCSAq
IHRocmVhZCBhbmQgbWFrZSBpdCBydW5uaW5nLg0KPiArCQkgKi8NCj4gIAkJV0FSTl9PTihjbWRx
X3RocmVhZF9yZXNldChjbWRxLCB0aHJlYWQpIDwgMCk7DQo+ICANCj4gIAkJd3JpdGVsKHRhc2st
PnBhX2Jhc2UgPj4gY21kcS0+c2hpZnRfcGEsDQo+IEBAIC00NTAsNiArNDU2LDM4IEBAIHN0YXRp
YyBpbnQgY21kcV9tYm94X3N0YXJ0dXAoc3RydWN0IG1ib3hfY2hhbiAqY2hhbikNCj4gIA0KPiAg
c3RhdGljIHZvaWQgY21kcV9tYm94X3NodXRkb3duKHN0cnVjdCBtYm94X2NoYW4gKmNoYW4pDQo+
ICB7DQo+ICsJc3RydWN0IGNtZHFfdGhyZWFkICp0aHJlYWQgPSAoc3RydWN0IGNtZHFfdGhyZWFk
ICopY2hhbi0+Y29uX3ByaXY7DQo+ICsJc3RydWN0IGNtZHEgKmNtZHEgPSBkZXZfZ2V0X2RydmRh
dGEoY2hhbi0+bWJveC0+ZGV2KTsNCj4gKwlzdHJ1Y3QgY21kcV90YXNrICp0YXNrLCAqdG1wOw0K
PiArCXVuc2lnbmVkIGxvbmcgZmxhZ3M7DQo+ICsNCj4gKwlzcGluX2xvY2tfaXJxc2F2ZSgmdGhy
ZWFkLT5jaGFuLT5sb2NrLCBmbGFncyk7DQo+ICsJaWYgKGxpc3RfZW1wdHkoJnRocmVhZC0+dGFz
a19idXN5X2xpc3QpKQ0KPiArCQlnb3RvIGRvbmU7DQo+ICsNCj4gKwlXQVJOX09OKGNtZHFfdGhy
ZWFkX3N1c3BlbmQoY21kcSwgdGhyZWFkKSA8IDApOw0KPiArDQo+ICsJLyogbWFrZSBzdXJlIGV4
ZWN1dGVkIHRhc2tzIGhhdmUgc3VjY2VzcyBjYWxsYmFjayAqLw0KPiArCWNtZHFfdGhyZWFkX2ly
cV9oYW5kbGVyKGNtZHEsIHRocmVhZCk7DQo+ICsJaWYgKGxpc3RfZW1wdHkoJnRocmVhZC0+dGFz
a19idXN5X2xpc3QpKQ0KPiArCQlnb3RvIGRvbmU7DQo+ICsNCj4gKwlsaXN0X2Zvcl9lYWNoX2Vu
dHJ5X3NhZmUodGFzaywgdG1wLCAmdGhyZWFkLT50YXNrX2J1c3lfbGlzdCwNCj4gKwkJCQkgbGlz
dF9lbnRyeSkgew0KPiArCQljbWRxX3Rhc2tfZXhlY19kb25lKHRhc2ssIENNRFFfQ0JfRVJST1Ip
Ow0KPiArCQlrZnJlZSh0YXNrKTsNCj4gKwl9DQo+ICsNCj4gKwljbWRxX3RocmVhZF9kaXNhYmxl
KGNtZHEsIHRocmVhZCk7DQo+ICsJY2xrX2Rpc2FibGUoY21kcS0+Y2xvY2spOw0KPiArZG9uZToN
Cj4gKwkvKg0KPiArCSAqIFRoZSB0aHJlYWQtPnRhc2tfYnVzeV9saXN0IGVtcHR5IG1lYW5zIHRo
cmVhZCBhbHJlYWR5IGRpc2FibGUuIFRoZQ0KPiArCSAqIGNtZHFfbWJveF9zZW5kX2RhdGEoKSBh
bHdheXMgcmVzZXQgdGhyZWFkIHdoaWNoIGNsZWFyIGRpc2FibGUgYW5kDQo+ICsJICogc3VzcGVu
ZCBzdGF0dWUgd2hlbiBmaXJzdCBwa3Qgc2VuZCB0byBjaGFubmVsLCBzbyB0aGVyZSBpcyBubyBu
ZWVkDQo+ICsJICogdG8gZG8gYW55IG9wZXJhdGlvbiBoZXJlLCBvbmx5IHVubG9jayBhbmQgbGVh
dmUuDQo+ICsJICovDQo+ICsJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmdGhyZWFkLT5jaGFuLT5s
b2NrLCBmbGFncyk7DQo+ICB9DQo+ICANCj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbWJveF9jaGFu
X29wcyBjbWRxX21ib3hfY2hhbl9vcHMgPSB7DQoNCg==


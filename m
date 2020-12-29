Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 539752E6FD4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 12:08:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbgL2LHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 06:07:13 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:6801 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726209AbgL2LHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 06:07:12 -0500
X-UUID: 75617dd10cbf41aa8a8aa93cbb70916a-20201229
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=zfneozaYhu5jrm9Q37fk5lPpqTHzSi4uBaXsfUw6RZ4=;
        b=X+VtajVVr1i7nGvkkzSQLloRasRFyxUOGpUfSdJxREgqwpZ6gmOhtWoJJ3oDds8qijzQAZYPbFcgZI1opp22jBsXFvJZF3Ce3vrTlunQ2pI9h/dr0Y+Rf6uo0+vAjcXB0uUgv0BCx4+lWDNQKG8BxsWZXoRh3qzhiS48DW9gRKY=;
X-UUID: 75617dd10cbf41aa8a8aa93cbb70916a-20201229
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 794393449; Tue, 29 Dec 2020 19:06:28 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 29 Dec
 2020 19:06:18 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 29 Dec 2020 19:06:18 +0800
Message-ID: <1609239977.26323.292.camel@mhfsdcap03>
Subject: Re: [PATCH v5 18/27] iommu/mediatek: Add power-domain operation
From:   Yong Wu <yong.wu@mediatek.com>
To:     Tomasz Figa <tfiga@chromium.org>
CC:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, <youlin.pei@mediatek.com>,
        <devicetree@vger.kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        <srv_heupstream@mediatek.com>, <chao.hao@mediatek.com>,
        <linux-kernel@vger.kernel.org>, Evan Green <evgreen@chromium.org>,
        Tomasz Figa <tfiga@google.com>,
        <iommu@lists.linux-foundation.org>,
        <linux-mediatek@lists.infradead.org>,
        Krzysztof Kozlowski <krzk@kernel.org>, <anan.sun@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Tue, 29 Dec 2020 19:06:17 +0800
In-Reply-To: <X+MBcmzQn9iQWlVZ@chromium.org>
References: <20201209080102.26626-1-yong.wu@mediatek.com>
         <X+MBcmzQn9iQWlVZ@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: D6856EB35728775B524D669116D09ECF5C09C39014423CFC3B03E7EB5EA35C712000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIwLTEyLTIzIGF0IDE3OjM2ICswOTAwLCBUb21hc3ogRmlnYSB3cm90ZToNCj4g
T24gV2VkLCBEZWMgMDksIDIwMjAgYXQgMDQ6MDA6NTNQTSArMDgwMCwgWW9uZyBXdSB3cm90ZToN
Cj4gPiBJbiB0aGUgcHJldmlvdXMgU29DLCB0aGUgTTRVIEhXIGlzIGluIHRoZSBFTUkgcG93ZXIg
ZG9tYWluIHdoaWNoIGlzDQo+ID4gYWx3YXlzIG9uLiB0aGUgbGF0ZXN0IE00VSBpcyBpbiB0aGUg
ZGlzcGxheSBwb3dlciBkb21haW4gd2hpY2ggbWF5IGJlDQo+ID4gdHVybmVkIG9uL29mZiwgdGh1
cyB3ZSBoYXZlIHRvIGFkZCBwbV9ydW50aW1lIGludGVyZmFjZSBmb3IgaXQuDQo+ID4gDQo+ID4g
V2hlbiB0aGUgZW5naW5lIHdvcmssIHRoZSBlbmdpbmUgYWx3YXlzIGVuYWJsZSB0aGUgcG93ZXIg
YW5kIGNsb2NrcyBmb3INCj4gPiBzbWktbGFyYi9zbWktY29tbW9uLCB0aGVuIHRoZSBNNFUncyBw
b3dlciB3aWxsIGFsd2F5cyBiZSBwb3dlcmVkIG9uDQo+ID4gYXV0b21hdGljYWxseSB2aWEgdGhl
IGRldmljZSBsaW5rIHdpdGggc21pLWNvbW1vbi4NCj4gPiANCj4gPiBOb3RlOiB3ZSBkb24ndCBl
bmFibGUgdGhlIE00VSBwb3dlciBpbiBpb21tdV9tYXAvdW5tYXAgZm9yIHRsYiBmbHVzaC4NCj4g
PiBJZiBpdHMgcG93ZXIgYWxyZWFkeSBpcyBvbiwgb2YgY291cnNlIGl0IGlzIG9rLiBpZiB0aGUg
cG93ZXIgaXMgb2ZmLA0KPiA+IHRoZSBtYWluIHRsYiB3aWxsIGJlIHJlc2V0IHdoaWxlIE00VSBw
b3dlciBvbiwgdGh1cyB0aGUgdGxiIGZsdXNoIHdoaWxlDQo+ID4gbTR1IHBvd2VyIG9mZiBpcyB1
bm5lY2Vzc2FyeSwganVzdCBza2lwIGl0Lg0KPiA+IA0KPiA+IFRoZXJlIHdpbGwgYmUgb25lIGNh
c2UgdGhhdCBwbSBydW5jdGltZSBzdGF0dXMgaXMgbm90IGV4cGVjdGVkIHdoZW4gdGxiDQo+ID4g
Zmx1c2guIEFmdGVyIGJvb3QsIHRoZSBkaXNwbGF5IG1heSBjYWxsIGRtYV9hbGxvY19hdHRycyBi
ZWZvcmUgaXQgY2FsbA0KPiA+IHBtX3J1bnRpbWVfZ2V0KGRpc3AtZGV2KSwgdGhlbiB0aGUgbTR1
J3MgcG0gc3RhdHVzIGlzIG5vdCBhY3RpdmUgaW5zaWRlDQo+ID4gdGhlIGRtYV9hbGxvY19hdHRy
cy4gU2luY2UgaXQgb25seSBoYXBwZW5zIGFmdGVyIGJvb3QsIHRoZSB0bGIgaXMgY2xlYW4NCj4g
PiBhdCB0aGF0IHRpbWUsIEkgYWxzbyB0aGluayB0aGlzIGlzIG9rLg0KPiA+IA0KPiA+IFNpZ25l
ZC1vZmYtYnk6IFlvbmcgV3UgPHlvbmcud3VAbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICBk
cml2ZXJzL2lvbW11L210a19pb21tdS5jIHwgNDEgKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrLS0tLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAzNSBpbnNlcnRpb25zKCspLCA2IGRl
bGV0aW9ucygtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L210a19pb21t
dS5jIGIvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYw0KPiA+IGluZGV4IDZmZTNlZTJiMmJmNS4u
MGU5YzAzY2JhYjMyIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMN
Cj4gPiArKysgYi9kcml2ZXJzL2lvbW11L210a19pb21tdS5jDQo+ID4gQEAgLTE4NCw2ICsxODQs
OCBAQCBzdGF0aWMgdm9pZCBtdGtfaW9tbXVfdGxiX2ZsdXNoX2FsbCh2b2lkICpjb29raWUpDQo+
ID4gIAlzdHJ1Y3QgbXRrX2lvbW11X2RhdGEgKmRhdGEgPSBjb29raWU7DQo+ID4gIA0KPiA+ICAJ
Zm9yX2VhY2hfbTR1KGRhdGEpIHsNCj4gPiArCQlpZiAoIXBtX3J1bnRpbWVfYWN0aXZlKGRhdGEt
PmRldikpDQo+ID4gKwkJCWNvbnRpbnVlOw0KPiANCj4gSXMgaXQgZ3VhcmFudGVlZCB0aGF0IHRo
ZSBzdGF0dXMgaXMgYWN0aXZlIGluIHRoZSBjaGVjayBhYm92ZSwgYnV0IHRoZW4NCj4gdGhlIHBy
b2Nlc3MgaXMgcHJlZW1wdGVkIGFuZCBpdCBnb2VzIGRvd24gaGVyZT8NCj4gDQo+IFNob3VsZG4n
dCB3ZSBkbyBzb21ldGhpbmcgbGlrZSBiZWxvdz8NCj4gDQo+ICAgICAgICAgcmV0ID0gcG1fcnVu
dGltZV9nZXRfaWZfYWN0aXZlKCk7DQo+ICAgICAgICAgaWYgKCFyZXQpDQo+ICAgICAgICAgICAg
ICAgICBjb250aW51ZTsNCj4gICAgICAgICBpZiAocmV0IDwgMCkNCj4gICAgICAgICAgICAgICAg
IC8vIGhhbmRsZSBlcnJvcg0KPiAgICAgICAgIA0KPiAgICAgICAgIC8vIEZsdXNoDQo+ICAgICAg
ICAgDQo+ICAgICAgICAgcG1fcnVudGltZV9wdXQoKTsNCg0KTWFrZSBzZW5zZS4gVGhhbmtzLiBU
aGVyZSBpcyBhIGNvbW1lbnQgaW4gYXJtX3NtbXUuYyAiYXZvaWQgdG91Y2hpbmcNCmRldi0+cG93
ZXIubG9jayBpbiBmYXN0cGF0aHMiLiBUbyBhdm9pZCB0aGlzIGhlcmUgdG9vKHdlIGhhdmUgbWFu
eSBTb0MNCmRvbid0IGhhdmUgcG93ZXItZG9tYWluKS4gdGhlbiB0aGUgY29kZSB3aWxsIGJlIGxp
a2U6DQoNCglib29sIGhhc19wbSA9ICEhZGF0YS0+ZGV2LT5wbV9kb21haW47DQoNCglpZiAoaGFz
X3BtKSB7DQoJCWlmIChwbV9ydW50aW1lX2dldF9pZl9pbl91c2UoZGF0YS0+ZGV2KSA8PSAwKQ0K
CQkJY29udGludWU7DQoJfQ0KDQoJeHh4eA0KDQoJaWYgKGhhc19wbSkNCgkJcG1fcnVudGltZV9w
dXQoZGF0YS0+ZGV2KTsNCj4gDQo+IFNpbWlsYXIgY29tbWVudCB0byB0aGUgb3RoZXIgcGxhY2Vz
IGJlaW5nIGNoYW5nZWQgYnkgdGhpcyBwYXRjaC4NCj4gDQo+ID4gIAkJd3JpdGVsX3JlbGF4ZWQo
Rl9JTlZMRF9FTjEgfCBGX0lOVkxEX0VOMCwNCj4gPiAgCQkJICAgICAgIGRhdGEtPmJhc2UgKyBk
YXRhLT5wbGF0X2RhdGEtPmludl9zZWxfcmVnKTsNCj4gPiAgCQl3cml0ZWxfcmVsYXhlZChGX0FM
TF9JTlZMRCwgZGF0YS0+YmFzZSArIFJFR19NTVVfSU5WQUxJREFURSk7DQo+ID4gQEAgLTIwMCw2
ICsyMDIsMTAgQEAgc3RhdGljIHZvaWQgbXRrX2lvbW11X3RsYl9mbHVzaF9yYW5nZV9zeW5jKHVu
c2lnbmVkIGxvbmcgaW92YSwgc2l6ZV90IHNpemUsDQo+ID4gIAl1MzIgdG1wOw0KPiA+ICANCj4g
PiAgCWZvcl9lYWNoX200dShkYXRhKSB7DQo+ID4gKwkJLyogc2tpcCB0bGIgZmx1c2ggd2hlbiBw
bSBpcyBub3QgYWN0aXZlLiAqLw0KPiA+ICsJCWlmICghcG1fcnVudGltZV9hY3RpdmUoZGF0YS0+
ZGV2KSkNCj4gPiArCQkJY29udGludWU7DQo+ID4gKw0KPiA+ICAJCXNwaW5fbG9ja19pcnFzYXZl
KCZkYXRhLT50bGJfbG9jaywgZmxhZ3MpOw0KPiA+ICAJCXdyaXRlbF9yZWxheGVkKEZfSU5WTERf
RU4xIHwgRl9JTlZMRF9FTjAsDQo+ID4gIAkJCSAgICAgICBkYXRhLT5iYXNlICsgZGF0YS0+cGxh
dF9kYXRhLT5pbnZfc2VsX3JlZyk7DQpbc25pcF0NCg==


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0562FAEE5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 03:47:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394490AbhASCqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 21:46:51 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:12701 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728372AbhASCqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 21:46:32 -0500
X-UUID: 8b86654361fa431290aeeeadbb33294e-20210119
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=nkY5HVAfuNiTv1kPd0LeWdjKcUU6stCZlV+8WtTpNvA=;
        b=FOeaHVb8aeW63jvuzSs/kfrgylBEPRshKawX1TZLZfafGIN52+yEo6lfm8lNHuDrTKTB0+DIlTu/8idQqltj48bdJx73Sjo1gA7hR3bQBSwJRH12lf/HEBWz/4XPGIV2WZTsuPXg9XgoCvXpwkccuUmVpK9LNdIZkeZdfZGQBts=;
X-UUID: 8b86654361fa431290aeeeadbb33294e-20210119
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 611064642; Tue, 19 Jan 2021 10:45:45 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 19 Jan
 2021 10:45:43 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 19 Jan 2021 10:45:42 +0800
Message-ID: <1611024342.11995.14.camel@mhfsdcap03>
Subject: Re: [PATCH next 11/15] arm64: dts: mediatek: mt7622: harmonize node
 names and compatibles
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Sergei Shtylyov <sergei.shtylyov@gmail.com>
CC:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Min Guo <min.guo@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-usb@vger.kernel.org>
Date:   Tue, 19 Jan 2021 10:45:42 +0800
In-Reply-To: <8f859d54-f9f8-d7c9-db66-89860124b539@gmail.com>
References: <20210116090656.11752-1-chunfeng.yun@mediatek.com>
         <20210116090656.11752-11-chunfeng.yun@mediatek.com>
         <8f859d54-f9f8-d7c9-db66-89860124b539@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 413E3955A7FABB03405605F12E3C87305ECF06DF62AEE3A661B158243F74BBA22000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCAyMDIxLTAxLTE2IGF0IDEyOjM2ICswMzAwLCBTZXJnZWkgU2h0eWx5b3Ygd3JvdGU6
DQo+IEhlbGxvIQ0KPiANCj4gT24gMTYuMDEuMjAyMSAxMjowNiwgQ2h1bmZlbmcgWXVuIHdyb3Rl
Og0KPiANCj4gPiBUaGlzIGlzIHVzZWQgdG8gZml4IGR0YnNfY2hlY2sgd2FybmluZw0KPiA+IA0K
PiA+IFNpZ25lZC1vZmYtYnk6IENodW5mZW5nIFl1biA8Y2h1bmZlbmcueXVuQG1lZGlhdGVrLmNv
bT4NCj4gPiAtLS0NCj4gPiAgIGFyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ3NjIyLmR0
c2kgfCA5ICsrKysrLS0tLQ0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwg
NCBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0
cy9tZWRpYXRlay9tdDc2MjIuZHRzaSBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ3
NjIyLmR0c2kNCj4gPiBpbmRleCA1YjllYzAzMmNlOGQuLjRjZmEwOWIwY2EzYyAxMDA2NDQNCj4g
PiAtLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210NzYyMi5kdHNpDQo+ID4gKysr
IGIvYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDc2MjIuZHRzaQ0KPiA+IEBAIC03NDAs
OCArNzQwLDggQEANCj4gPiAgIAkJc3RhdHVzID0gImRpc2FibGVkIjsNCj4gPiAgIAl9Ow0KPiA+
ICAgDQo+ID4gLQl1M3BoeTogdXNiLXBoeUAxYTBjNDAwMCB7DQo+ID4gLQkJY29tcGF0aWJsZSA9
ICJtZWRpYXRlayxtdDc2MjItdTNwaHkiLA0KPiA+ICsJdTNwaHk6IHQtcGh5QDFhMGM0MDAwIHsN
Cj4gDQo+ICAgICBXaGF0IGlzICJ0LXBoeSI/IFBlcmhhcHMgeW91IHNob3VsZCBoYXZlIHVzZWQg
anVzdCAicGh5IiBoZXJlLi4uDQpBdCBmaXJzdCBJIHVzZSAicGh5IiwgYnV0IGl0IGNhdXNlcyBk
dF9iaW5kaW5nX2NoZWNrIGZhaWw6DQoiJyNwaHktY2VsbHMnIGlzIGEgcmVxdWlyZWQgcHJvcGVy
dHkiDQoNCkR1ZSB0byB3ZSBvbmx5IG5lZWQgYWRkICcjcGh5LWNlbGxzJyBmb3IgZWFjaCBzdWJu
b2RlICh1c2ItcGh5LCBwY2llLXBoeQ0Kb3Igc2F0YS1waHkpLCBidXQgbm90IGZvciBwYXJlbnQg
b25lLCBJIGNoYW5nZSB0aGUgcGFyZW50IG5vZGUgbmFtZSBhcw0KInQtcGh5IiB3aGljaCBpcyBh
IGdsdWUgbGF5ZXIgbm9kZSwgbm90IGEgcmVhbCBwaHkuDQpJIGFsc28gcHJlZmVyIHRvICJwaHki
LCBidXQgc2VlbXMgZHRfYmluZGluZ19jaGVjayBjYW4ndCBkaXN0aW5ndWlzaA0KdGhpcyBjYXNl
Lg0KDQpUaGFua3MNCg0KPiANCj4gPiArCQljb21wYXRpYmxlID0gIm1lZGlhdGVrLG10NzYyMi10
cGh5IiwNCj4gPiAgIAkJCSAgICAgIm1lZGlhdGVrLGdlbmVyaWMtdHBoeS12MSI7DQo+ID4gICAJ
CXJlZyA9IDwwIDB4MWEwYzQwMDAgMCAweDcwMD47DQo+ID4gICAJCSNhZGRyZXNzLWNlbGxzID0g
PDI+Ow0KPiA+IEBAIC04NzUsOCArODc1LDkgQEANCj4gPiAgIAkJc3RhdHVzID0gImRpc2FibGVk
IjsNCj4gPiAgIAl9Ow0KPiA+ICAgDQo+ID4gLQlzYXRhX3BoeTogc2F0YS1waHlAMWEyNDMwMDAg
ew0KPiA+IC0JCWNvbXBhdGlibGUgPSAibWVkaWF0ZWssZ2VuZXJpYy10cGh5LXYxIjsNCj4gPiAr
CXNhdGFfcGh5OiB0LXBoeUAxYTI0MzAwMCB7DQo+IA0KPiAgICAgU2FtZSBoZXJlLi4uDQo+IA0K
PiA+ICsJCWNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ3NjIyLXRwaHkiLA0KPiA+ICsJCQkgICAg
ICJtZWRpYXRlayxnZW5lcmljLXRwaHktdjEiOw0KPiA+ICAgCQkjYWRkcmVzcy1jZWxscyA9IDwy
PjsNCj4gPiAgIAkJI3NpemUtY2VsbHMgPSA8Mj47DQo+ID4gICAJCXJhbmdlczsNCj4gDQo+IE1C
UiwgU2VyZ2VpDQoNCg==


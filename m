Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EED22F0B09
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 03:32:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbhAKCcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 21:32:04 -0500
Received: from mg.richtek.com ([220.130.44.152]:53990 "EHLO mg.richtek.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725797AbhAKCcD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 21:32:03 -0500
X-Greylist: delayed 755 seconds by postgrey-1.27 at vger.kernel.org; Sun, 10 Jan 2021 21:32:02 EST
X-MailGates: (compute_score:DELIVER,40,3)
Received: from 192.168.8.21
        by mg.richtek.com with MailGates ESMTP Server V3.0(14680:0:AUTH_RELAY)
        (envelope-from <prvs=16440423B5=gene_chen@richtek.com>); Mon, 11 Jan 2021 10:20:00 +0800 (CST)
X-MailGates: (compute_score:DELIVER,40,3)
Received: from 192.168.10.46
        by mg.richtek.com with MailGates ESMTP Server V5.0(31720:0:AUTH_RELAY)
        (envelope-from <gene_chen@richtek.com>); Mon, 11 Jan 2021 10:18:38 +0800 (CST)
Received: from ex3.rt.l (192.168.10.46) by ex3.rt.l (192.168.10.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2; Mon, 11 Jan 2021
 10:18:37 +0800
Received: from ex3.rt.l ([fe80::ede0:40a5:8f78:963e]) by ex3.rt.l
 ([fe80::ede0:40a5:8f78:963e%2]) with mapi id 15.02.0721.002; Mon, 11 Jan 2021
 10:18:37 +0800
From:   =?big5?B?Z2VuZV9jaGVuKLOvq1SmdCk=?= <gene_chen@richtek.com>
To:     "matthias.bgg@kernel.org" <matthias.bgg@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
CC:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        Axel Lin <axel.lin@ingics.com>,
        Chen Zhong <chen.zhong@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matthias Brugger <mbrugger@suse.com>
Subject: RE: [PATCH v2 1/3] regulator: mt6360: Add OF match table
Thread-Topic: [PATCH v2 1/3] regulator: mt6360: Add OF match table
Thread-Index: AQHW5npC+XF/5MJAH0KucysXeIoCtKohsLzg
Date:   Mon, 11 Jan 2021 02:18:37 +0000
Message-ID: <b358179732f940f883c12dd1276f855a@richtek.com>
References: <20210109112612.1221-1-matthias.bgg@kernel.org>
In-Reply-To: <20210109112612.1221-1-matthias.bgg@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a3ddd8ac-892b-4cc6-a0cb-b80b2278ba98_Enabled=true;
 MSIP_Label_a3ddd8ac-892b-4cc6-a0cb-b80b2278ba98_SetDate=2021-01-11T02:18:37Z;
 MSIP_Label_a3ddd8ac-892b-4cc6-a0cb-b80b2278ba98_Method=Standard;
 MSIP_Label_a3ddd8ac-892b-4cc6-a0cb-b80b2278ba98_Name=Internal Use - External;
 MSIP_Label_a3ddd8ac-892b-4cc6-a0cb-b80b2278ba98_SiteId=d08c63e8-86ee-4e34-a1e5-44338373f4b1;
 MSIP_Label_a3ddd8ac-892b-4cc6-a0cb-b80b2278ba98_ActionId=01d0c99e-75e5-4e11-82ba-a30436d16e68;
 MSIP_Label_a3ddd8ac-892b-4cc6-a0cb-b80b2278ba98_ContentBits=1
x-originating-ip: [192.168.94.12]
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WyBJbnRlcm5hbCBVc2UgLSBFeHRlcm5hbCBdDQoNCkhpIE1hdHRoaWFzLA0KDQpJIGRpc2N1c3Nl
ZCBPRiBtYXRjaCB0YWJsZSB3aXRoIE1hcmsgaW4gcHJldmlvdXMgbWFpbCBpbiBvdXIgUEFUQ0gg
djMsDQpNRkQgc2hvdWxkIGp1c3QgaW5zdGFudGlhdGUgdGhlIHBsYXRmb3JtIGRldmljZS4NCg0K
PiBNYXJrIEJyb3duIDxicm9vbmllQGtlcm5lbC5vcmc+IKnzIDIwMjCmfjik6zIwpOkgtmelfCCk
VaTINzo0NbxnuUShRw0KDQo+ID4gVGhpcyBkZXZpY2Ugb25seSBleGlzdHMgaW4gdGhlIGNvbnRl
eHQgb2YgYSBzaW5nbGUgcGFyZW50IGRldmljZSwgdGhlcmUNCj4gPiBzaG91bGQgYmUgbm8gbmVl
ZCBmb3IgYSBjb21wYXRpYmxlIHN0cmluZyBoZXJlIC0gdGhpcyBpcyBqdXN0IGEgZGV0YWlsDQo+
ID4gb2YgaG93IExpbnV4IGRvZXMgdGhpbmdzLiAgVGhlIE1GRCBzaG91bGQganVzdCBpbnN0bnRp
YXRlIHRoZSBwbGF0Zm9ybQ0KPiA+IGRldmljZS4NCg0KPiBUcnlpbmcgdG8gYXV0b2xvYWQgbW9k
dWxlIHdpdGhvdXQgb2ZfaWRfdGFibGUgd2lsbCBjYXVzZSBydW4tdGltZSBlcnJvcjoNCj4gdWV2
ZW50ZDogTG9hZFdpdGhBbGlhc2VzIHdhcyB1bmFibGUgdG8gbG9hZA0KPiBvZjpOcmVndWxhdG9y
VChudWxsKUNtZWRpYXRlayxtdDYzNjAtcmVndWxhdG9yDQoNCllvdSBzaG91bGRuJ3QgaGF2ZSB0
aGlzIGRlc2NyaWJlZCBpbiB0aGUgZGV2aWNlIHRyZWUgYXQgYWxsLCBsaWtlIEkgc2F5DQp0aGUg
TUZEIHNob3VsZCBqdXN0IGluc3RhbnRpYXRlIHRoZSBwbGF0Zm9ybSBkZXZpY2UuDQoNCj4gLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogbWF0dGhpYXMuYmdnQGtlcm5lbC5vcmcg
PG1hdHRoaWFzLmJnZ0BrZXJuZWwub3JnPg0KPiBTZW50OiBTYXR1cmRheSwgSmFudWFyeSA5LCAy
MDIxIDc6MjYgUE0NCj4gVG86IExpYW0gR2lyZHdvb2QgPGxnaXJkd29vZEBnbWFpbC5jb20+OyBN
YXJrIEJyb3duDQo+IDxicm9vbmllQGtlcm5lbC5vcmc+DQo+IENjOiBIc2luLUhzaXVuZyBXYW5n
IDxoc2luLWhzaXVuZy53YW5nQG1lZGlhdGVrLmNvbT47IEF4ZWwgTGluDQo+IDxheGVsLmxpbkBp
bmdpY3MuY29tPjsgQ2hlbiBaaG9uZyA8Y2hlbi56aG9uZ0BtZWRpYXRlay5jb20+Ow0KPiBnZW5l
X2NoZW4os6+rVKZ0KSA8Z2VuZV9jaGVuQHJpY2h0ZWsuY29tPjsgbGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZzsNCj4gbGludXgtbWVkaWF0ZWtAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgt
YXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiBNYXR0aGlhcyBCcnVnZ2VyIDxtYXR0
aGlhcy5iZ2dAZ21haWwuY29tPjsgTWF0dGkgVmFpdHRpbmVuDQo+IDxtYXR0aS52YWl0dGluZW5A
Zmkucm9obWV1cm9wZS5jb20+OyBNYXR0aGlhcyBCcnVnZ2VyDQo+IDxtYnJ1Z2dlckBzdXNlLmNv
bT4NCj4gU3ViamVjdDogW1BBVENIIHYyIDEvM10gcmVndWxhdG9yOiBtdDYzNjA6IEFkZCBPRiBt
YXRjaCB0YWJsZQ0KPg0KPiBGcm9tOiBNYXR0aGlhcyBCcnVnZ2VyIDxtYnJ1Z2dlckBzdXNlLmNv
bT4NCj4NCj4gQmluZGluZyBkb2N1bWVudGF0aW9uIG1lbnRpb25zIHRoYXQgYSBjb21wYXRpYmxl
IGlzIHJlcXVpcmVkIGZvciB0aGUNCj4gTVQ2MzYwIGRldmljZSBub2RlLCBidXQgdGhlIGRyaXZl
ciBkb2Vzbid0IHByb3ZpZGUgYSBPRiBtYXRjaCB0YWJsZS4NCj4NCj4gRml4ZXM6IGQzMjE1NzFk
NWU0YyAoInJlZ3VsYXRvcjogbXQ2MzYwOiBBZGQgc3VwcG9ydCBmb3IgTVQ2MzYwIHJlZ3VsYXRv
ciIpDQo+IFNpZ25lZC1vZmYtYnk6IE1hdHRoaWFzIEJydWdnZXIgPG1icnVnZ2VyQHN1c2UuY29t
Pg0KPg0KPiAtLS0NCj4NCj4gQ2hhbmdlcyBpbiB2MjoNCj4gLSBjaGVjayBmb3IgQ09ORklHX09G
DQo+IC0gYWRkIEZpeGVzIHRhZw0KPg0KPiAgZHJpdmVycy9yZWd1bGF0b3IvbXQ2MzYwLXJlZ3Vs
YXRvci5jIHwgOSArKysrKysrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKykN
Cj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcmVndWxhdG9yL210NjM2MC1yZWd1bGF0b3IuYw0K
PiBiL2RyaXZlcnMvcmVndWxhdG9yL210NjM2MC1yZWd1bGF0b3IuYw0KPiBpbmRleCAxNTMwOGVl
MjljMTMuLmY3YjI1MTRmZWFiZiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9yZWd1bGF0b3IvbXQ2
MzYwLXJlZ3VsYXRvci5jDQo+ICsrKyBiL2RyaXZlcnMvcmVndWxhdG9yL210NjM2MC1yZWd1bGF0
b3IuYw0KPiBAQCAtNDQ1LDkgKzQ0NSwxOCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHBsYXRmb3Jt
X2RldmljZV9pZA0KPiBtdDYzNjBfcmVndWxhdG9yX2lkX3RhYmxlW10gPSB7ICB9OyAgTU9EVUxF
X0RFVklDRV9UQUJMRShwbGF0Zm9ybSwNCj4gbXQ2MzYwX3JlZ3VsYXRvcl9pZF90YWJsZSk7DQo+
DQo+ICsjaWZkZWYgQ09ORklHX09GDQo+ICtzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9p
ZCBtdDYzNjBfb2ZfbWF0Y2hbXSA9IHsNCj4gK3sgLmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ2
MzYwLXJlZ3VsYXRvciIsIH0sDQo+ICt7IC8qIHNlbnRpbmVsICovIH0sDQo+ICt9Ow0KPiArTU9E
VUxFX0RFVklDRV9UQUJMRShvZiwgbXQ2MzYwX29mX21hdGNoKTsgI2VuZGlmDQo+ICsNCj4gIHN0
YXRpYyBzdHJ1Y3QgcGxhdGZvcm1fZHJpdmVyIG10NjM2MF9yZWd1bGF0b3JfZHJpdmVyID0gew0K
PiAgLmRyaXZlciA9IHsNCj4gIC5uYW1lID0gIm10NjM2MC1yZWd1bGF0b3IiLA0KPiArLm9mX21h
dGNoX3RhYmxlID0gb2ZfbWF0Y2hfcHRyKG10NjM2MF9vZl9tYXRjaCksDQo+ICB9LA0KPiAgLnBy
b2JlID0gbXQ2MzYwX3JlZ3VsYXRvcl9wcm9iZSwNCj4gIC5pZF90YWJsZSA9IG10NjM2MF9yZWd1
bGF0b3JfaWRfdGFibGUsDQo+IC0tDQo+IDIuMjkuMg0KKioqKioqKioqKioqKiBFbWFpbCBDb25m
aWRlbnRpYWxpdHkgTm90aWNlICoqKioqKioqKioqKioqKioqKioqDQoNClRoZSBpbmZvcm1hdGlv
biBjb250YWluZWQgaW4gdGhpcyBlLW1haWwgbWVzc2FnZSAoaW5jbHVkaW5nIGFueSBhdHRhY2ht
ZW50cykgbWF5IGJlIGNvbmZpZGVudGlhbCwgcHJvcHJpZXRhcnksIHByaXZpbGVnZWQsIG9yIG90
aGVyd2lzZSBleGVtcHQgZnJvbSBkaXNjbG9zdXJlIHVuZGVyIGFwcGxpY2FibGUgbGF3cy4gSXQg
aXMgaW50ZW5kZWQgdG8gYmUgY29udmV5ZWQgb25seSB0byB0aGUgZGVzaWduYXRlZCByZWNpcGll
bnQocykuIEFueSB1c2UsIGRpc3NlbWluYXRpb24sIGRpc3RyaWJ1dGlvbiwgcHJpbnRpbmcsIHJl
dGFpbmluZyBvciBjb3B5aW5nIG9mIHRoaXMgZS1tYWlsIChpbmNsdWRpbmcgaXRzIGF0dGFjaG1l
bnRzKSBieSB1bmludGVuZGVkIHJlY2lwaWVudChzKSBpcyBzdHJpY3RseSBwcm9oaWJpdGVkIGFu
ZCBtYXkgYmUgdW5sYXdmdWwuIElmIHlvdSBhcmUgbm90IGFuIGludGVuZGVkIHJlY2lwaWVudCBv
ZiB0aGlzIGUtbWFpbCwgb3IgYmVsaWV2ZSB0aGF0IHlvdSBoYXZlIHJlY2VpdmVkIHRoaXMgZS1t
YWlsIGluIGVycm9yLCBwbGVhc2Ugbm90aWZ5IHRoZSBzZW5kZXIgaW1tZWRpYXRlbHkgKGJ5IHJl
cGx5aW5nIHRvIHRoaXMgZS1tYWlsKSwgZGVsZXRlIGFueSBhbmQgYWxsIGNvcGllcyBvZiB0aGlz
IGUtbWFpbCAoaW5jbHVkaW5nIGFueSBhdHRhY2htZW50cykgZnJvbSB5b3VyIHN5c3RlbSwgYW5k
IGRvIG5vdCBkaXNjbG9zZSB0aGUgY29udGVudCBvZiB0aGlzIGUtbWFpbCB0byBhbnkgb3RoZXIg
cGVyc29uLiBUaGFuayB5b3UhDQo=

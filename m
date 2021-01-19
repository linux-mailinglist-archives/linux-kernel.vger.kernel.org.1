Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFEA22FB353
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 08:40:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731287AbhASHj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 02:39:27 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:2095 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730012AbhASHjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 02:39:05 -0500
X-UUID: 08f0aad841294f2ba5a875879051e5fe-20210119
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=umF0/4THUCkSbBZUhmq56lfHoNBXzIPnzphItGv/KMI=;
        b=uoiTEcHxGC64lJXUJBfDRQNPGziRFltn+5ywxrdNMuiHtk5nfOGoPW34Cl3XfMkZHILw5Y4IcbiF5HnqUi4qVpKGbN6fZ57Vn9a55Wp4oipVxygjcvT7df7nn4jX3EDw7skviLs7ipm2c2yI0RhBqsCrVGtK2ZaC86ItRguHUiE=;
X-UUID: 08f0aad841294f2ba5a875879051e5fe-20210119
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 23337932; Tue, 19 Jan 2021 15:37:57 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS32N1.mediatek.inc
 (172.27.4.71) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 19 Jan
 2021 15:37:55 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 19 Jan 2021 15:37:54 +0800
Message-ID: <1611041874.12761.13.camel@mhfsdcap03>
Subject: Re: [PATCH 1/2] usb typec: tcpci: mt6360: Add vsafe0v support and
 external vbus supply control
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     ChiYuan Huang <u0084500@gmail.com>
CC:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        <matthias.bgg@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        cy_huang <cy_huang@richtek.com>, <gene_chen@richtek.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Date:   Tue, 19 Jan 2021 15:37:54 +0800
In-Reply-To: <CADiBU38g_E+iH4jTwQfPvJh4=WRH4vzQ12oubGg47gj+CpTU0A@mail.gmail.com>
References: <1610720001-15300-1-git-send-email-u0084500@gmail.com>
         <3a4a88a9-f0e3-2b65-9df4-6c1d4e3f1c14@roeck-us.net>
         <CADiBU38g_E+iH4jTwQfPvJh4=WRH4vzQ12oubGg47gj+CpTU0A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 6EE5827DE37D4448BF61698E731BEF2DC0EBC05DC3114276BD0A92C72F7ECB172000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIxLTAxLTE4IGF0IDE2OjI4ICswODAwLCBDaGlZdWFuIEh1YW5nIHdyb3RlOg0K
PiBHdWVudGVyIFJvZWNrIDxsaW51eEByb2Vjay11cy5uZXQ+IOaWvCAyMDIx5bm0MeaciDE45pel
IOmAseS4gCDkuIrljYgxOjQz5a+r6YGT77yaDQo+ID4NCj4gPiBPbiAxLzE1LzIxIDY6MTMgQU0s
IGN5X2h1YW5nIHdyb3RlOg0KPiA+ID4gRnJvbTogQ2hpWXVhbiBIdWFuZyA8Y3lfaHVhbmdAcmlj
aHRlay5jb20+DQo+ID4gPg0KPiA+ID4gTVQ2MzYwIG5vdCBzdXBwb3J0IGZvciBUQ1BDIGNvbW1h
bmQgdG8gY29udHJvbCBzb3VyY2UgYW5kIHNpbmsuDQo+ID4NCj4gPiBkb2VzIG5vdA0KPiA+DQo+
IEFjaw0KPiA+ID4gVXNlcyBleHRlcm5hbCA1ViB2YnVzIHJlZ3VsYXRvciBhcyB0aGUgdmJ1cyBz
b3VyY2UgY29udHJvbC4NCj4gPiA+DQo+ID4gVXNlDQo+ID4NCj4gQWNrDQo+ID4gPiBBbHNvIGFk
ZHMgdGhlIGNhcGFiaWxpdHkgdG8gcmVwb3J0IHZzYWZlMHYuDQo+ID4gPg0KPiA+IGFkZA0KPiA+
DQo+IEFjaw0KPiA+IFNvIGZhciB0aGlzIGRyaXZlciB3b3JrcyB3aXRob3V0IHJlZ3VsYXRvci4g
VW5sZXNzIEkgYW0gbWlzc2luZyBzb21ldGhpbmcsDQo+ID4gdGhpcyBwYXRjaCBtYWtlcyByZWd1
bGF0b3Igc3VwcG9ydCBtYW5kYXRvcnksIG1lYW5pbmcgZXhpc3RpbmcgY29kZSB3aWxsIGZhaWwu
DQo+ID4gSSBhbSBub3Qgc3VyZSBpZiB0aGF0IGlzIGFwcHJvcHJpYXRlL2FjY2VwdGFibGUuIENh
biB3ZSBiZSBzdXJlIHRoYXQgdGhpcyB3aWxsDQo+ID4gd29yayBmb3IgZXhpc3RpbmcgdXNlcnMg
b2YgdGhpcyBkcml2ZXIgPw0KPiA+DQo+IFllcywgSSBhbHJlYWR5IGNoZWNrZWQgYWxsIHRoZSBz
cmMvc25rIGZ1bmN0aW9uYWxpdHkgYmFzZWQgb24gIHRoZQ0KPiBsYXRlc3QgdHlwZWMgY29kZS4N
Cj4gSXQnbGwgYmUgY29tbW9uIGZvciBvdXIgVENQQy4gSXQgZGlkbid0IHN1cHBvcnQgZm9yIFRD
UEMgY29tbWFuZC4NCj4gRnJvbSB0aGUgcmVjZW50IHBhdGNoZXMsIGFjdHVhbGx5LCBJIGhhdmUg
dGhlIGxvY2FsIGNoYW5nZSB0byB0ZXN0IHRoZQ0KPiBzcmMgY2FwYWJpbGl0eS4NCj4gQnV0IEkg
ZGlkbid0IHN1Ym1pdCBpdC4gSXQncyBhbG1vc3QgdGhlIHNhbWUgdG8gYWRkIHNldF92YnVzIGNh
bGxiYWNrLg0KPiBUaGF0J3Mgd2h5IEkgc3VibWl0IHRoaXMgY2hhbmdlIGFmdGVyIHRjcGNpICdz
ZXRfdmJ1cyBjYWxsYmFjaycgaXMgYWRkZWQuDQo+IA0KPiA+IFRoYW5rcywNCj4gPiBHdWVudGVy
DQo+ID4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IENoaVl1YW4gSHVhbmcgPGN5X2h1YW5nQHJpY2h0
ZWsuY29tPg0KPiA+ID4gLS0tDQo+ID4gPiAgZHJpdmVycy91c2IvdHlwZWMvdGNwbS90Y3BjaV9t
dDYzNjAuYyB8IDI5ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gPiAgMSBmaWxl
IGNoYW5nZWQsIDI5IGluc2VydGlvbnMoKykNCj4gPiA+DQo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy91c2IvdHlwZWMvdGNwbS90Y3BjaV9tdDYzNjAuYyBiL2RyaXZlcnMvdXNiL3R5cGVjL3Rj
cG0vdGNwY2lfbXQ2MzYwLmMNCj4gPiA+IGluZGV4IGYxYmQ5ZTAuLjBlZGY0YjYgMTAwNjQ0DQo+
ID4gPiAtLS0gYS9kcml2ZXJzL3VzYi90eXBlYy90Y3BtL3RjcGNpX210NjM2MC5jDQo+ID4gPiAr
KysgYi9kcml2ZXJzL3VzYi90eXBlYy90Y3BtL3RjcGNpX210NjM2MC5jDQo+ID4gPiBAQCAtMTEs
NiArMTEsNyBAQA0KPiA+ID4gICNpbmNsdWRlIDxsaW51eC9vZi5oPg0KPiA+ID4gICNpbmNsdWRl
IDxsaW51eC9wbGF0Zm9ybV9kZXZpY2UuaD4NCj4gPiA+ICAjaW5jbHVkZSA8bGludXgvcmVnbWFw
Lmg+DQo+ID4gPiArI2luY2x1ZGUgPGxpbnV4L3JlZ3VsYXRvci9jb25zdW1lci5oPg0KPiA+ID4g
ICNpbmNsdWRlIDxsaW51eC91c2IvdGNwbS5oPg0KPiA+ID4NCj4gPiA+ICAjaW5jbHVkZSAidGNw
Y2kuaCINCj4gPiA+IEBAIC0zNiw2ICszNyw3IEBAIHN0cnVjdCBtdDYzNjBfdGNwY19pbmZvIHsN
Cj4gPiA+ICAgICAgIHN0cnVjdCB0Y3BjaV9kYXRhIHRkYXRhOw0KPiA+ID4gICAgICAgc3RydWN0
IHRjcGNpICp0Y3BjaTsNCj4gPiA+ICAgICAgIHN0cnVjdCBkZXZpY2UgKmRldjsNCj4gPiA+ICsg
ICAgIHN0cnVjdCByZWd1bGF0b3IgKnZidXM7DQo+ID4gPiAgICAgICBpbnQgaXJxOw0KPiA+ID4g
IH07DQo+ID4gPg0KPiA+ID4gQEAgLTUxLDYgKzUzLDI3IEBAIHN0YXRpYyBpbmxpbmUgaW50IG10
NjM2MF90Y3BjX3dyaXRlMTYoc3RydWN0IHJlZ21hcCAqcmVnbWFwLA0KPiA+ID4gICAgICAgcmV0
dXJuIHJlZ21hcF9yYXdfd3JpdGUocmVnbWFwLCByZWcsICZ2YWwsIHNpemVvZih1MTYpKTsNCj4g
PiA+ICB9DQo+ID4gPg0KPiA+ID4gK3N0YXRpYyBpbnQgbXQ2MzYwX3RjcGNfc2V0X3ZidXMoc3Ry
dWN0IHRjcGNpICp0Y3BjaSwgc3RydWN0IHRjcGNpX2RhdGEgKmRhdGEsIGJvb2wgc3JjLCBib29s
IHNuaykNCj4gPiA+ICt7DQo+ID4gPiArICAgICBzdHJ1Y3QgbXQ2MzYwX3RjcGNfaW5mbyAqbXRp
ID0gY29udGFpbmVyX29mKGRhdGEsIHN0cnVjdCBtdDYzNjBfdGNwY19pbmZvLCB0ZGF0YSk7DQo+
ID4gPiArICAgICBpbnQgcmV0Ow0KPiA+ID4gKw0KPiA+ID4gKyAgICAgLyogVG8gY29ycmVjdGx5
IGhhbmRsZSB0aGUgYWxyZWFkeSBlbmFibGVkIHZidXMgYW5kIGRpc2FibGUgaXRzIHN1cHBseSBm
aXJzdCAqLw0KPiA+ID4gKyAgICAgaWYgKHJlZ3VsYXRvcl9pc19lbmFibGVkKG10aS0+dmJ1cykp
IHsNCj4gPiA+ICsgICAgICAgICAgICAgcmV0ID0gcmVndWxhdG9yX2Rpc2FibGUobXRpLT52YnVz
KTsNCj4gPiA+ICsgICAgICAgICAgICAgaWYgKHJldCkNCj4gPiA+ICsgICAgICAgICAgICAgICAg
ICAgICByZXR1cm4gcmV0Ow0KPiA+ID4gKyAgICAgfQ0KPiA+DQo+ID4gSXMgaXQgcmVhbGx5IGEg
Z29vZCBpZGVhIHRvIGRpc2FibGUgdmJ1cyBpZiBpdCBoYXBwZW5zIHRvIGJlIGFscmVhZHkgZW5h
YmxlZA0KPiA+IGFuZCB0aGVyZSBpcyAoYW5vdGhlciA/KSByZXF1ZXN0IHRvIGVuYWJsZSBpdCA/
DQo+ID4NCj4gWWVzLCBmb3IgIHRoZSBzdGF0ZSBjaGFuZ2UgZnJvbSBzcmNfYXR0YWNoX3dhaXQg
dG8gc3JjX2F0dGFjaCwNCj4gSXQgbmVlZCB0byBtZWV0IHRoZSByZXF1aXJlbWVudCB0aGF0ICB0
aGUgdmJ1cyBpcyBhdCB2c2FmZTB2Lg0KPiBTbyB0byBkaXNhYmxlIGl0IGZpcnN0IGlzIG5lZWRl
ZC4NCj4gQW5kIHRvIHByZXZlbnQgb3RoZXIgdXNlcnMgZnJvbSBlbmFibGluZy9kaXNhYmxpbmcg
ZXh0ZXJuYWwgdmJ1cw0KPiByZWd1bGF0b3IgaW4gYW55IGNhc2UuDQo+IEkgdGhpbmsgd2UgbWF5
IGNoYW5nZSByZWd1bGF0b3JfZ2V0ICB0byAncmVndWxhdG9yX2dldF9leGNsdXNpdmUnLg0KPiBG
cm9tIHRoZSBkZXNpZ24sIDV2IHJlZ3VsYXRvciBvbmx5IGNhbiBiZSBjb250cm9sbGVkIHZpYSB0
eXBlYyBmcmFtZXdvcmsuDQo+IElmIG90aGVyIHVzZXIgdG91Y2ggaXQsIGl0J2xsIGFmZmVjdCB0
aGUgdHlwZWMgc3RhdGUgdHJhbnNpdGlvbi4NCkhvdyBhYm91dCB0byBwcm9jZXNzIHRoZSBjYXNl
IHRoYXQgZXZlbiBzd2l0Y2ggdXNiIGNvbnRyb2xsZXIgdG8gZGV2aWNlDQptb2RlLCBwbGF0Zm9y
bSBhbHNvIG5lZWQgdG8ga2VlcCB2YnVzIG9uPyBlLmcuIElwaG9uZSBDYXJwbGF5DQoNCg0KPiA+
ID4gKw0KPiA+ID4gKyAgICAgaWYgKHNyYykgew0KPiA+ID4gKyAgICAgICAgICAgICByZXQgPSBy
ZWd1bGF0b3JfZW5hYmxlKG10aS0+dmJ1cyk7DQo+ID4gPiArICAgICAgICAgICAgIGlmIChyZXQp
DQo+ID4gPiArICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4gPiA+ICsgICAgIH0N
Cj4gPiA+ICsNCj4gPiA+ICsgICAgIHJldHVybiAwOw0KPiA+ID4gK30NCj4gPiA+ICsNCj4gPiA+
ICBzdGF0aWMgaW50IG10NjM2MF90Y3BjX2luaXQoc3RydWN0IHRjcGNpICp0Y3BjaSwgc3RydWN0
IHRjcGNpX2RhdGEgKnRkYXRhKQ0KPiA+ID4gIHsNCj4gPiA+ICAgICAgIHN0cnVjdCByZWdtYXAg
KnJlZ21hcCA9IHRkYXRhLT5yZWdtYXA7DQo+ID4gPiBAQCAtMTM4LDcgKzE2MSwxMyBAQCBzdGF0
aWMgaW50IG10NjM2MF90Y3BjX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+
ID4gPiAgICAgICBpZiAobXRpLT5pcnEgPCAwKQ0KPiA+ID4gICAgICAgICAgICAgICByZXR1cm4g
bXRpLT5pcnE7DQo+ID4gPg0KPiA+ID4gKyAgICAgbXRpLT52YnVzID0gZGV2bV9yZWd1bGF0b3Jf
Z2V0KCZwZGV2LT5kZXYsICJ2YnVzIik7DQo+ID4gPiArICAgICBpZiAoSVNfRVJSKG10aS0+dmJ1
cykpDQo+ID4gPiArICAgICAgICAgICAgIHJldHVybiBQVFJfRVJSKG10aS0+dmJ1cyk7DQo+ID4g
PiArDQo+ID4gPiAgICAgICBtdGktPnRkYXRhLmluaXQgPSBtdDYzNjBfdGNwY19pbml0Ow0KPiA+
ID4gKyAgICAgbXRpLT50ZGF0YS5zZXRfdmJ1cyA9IG10NjM2MF90Y3BjX3NldF92YnVzOw0KPiA+
ID4gKyAgICAgbXRpLT50ZGF0YS52YnVzX3ZzYWZlMHYgPSAxOw0KPiA+ID4gICAgICAgbXRpLT50
Y3BjaSA9IHRjcGNpX3JlZ2lzdGVyX3BvcnQoJnBkZXYtPmRldiwgJm10aS0+dGRhdGEpOw0KPiA+
ID4gICAgICAgaWYgKElTX0VSUihtdGktPnRjcGNpKSkgew0KPiA+ID4gICAgICAgICAgICAgICBk
ZXZfZXJyKCZwZGV2LT5kZXYsICJGYWlsZWQgdG8gcmVnaXN0ZXIgdGNwY2kgcG9ydFxuIik7DQo+
ID4gPg0KPiA+DQoNCg==


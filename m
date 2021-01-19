Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09CA02FB31A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 08:36:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730952AbhASHfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 02:35:51 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:53635 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730001AbhASHek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 02:34:40 -0500
X-UUID: 408a52bca56c41948f86ab33c965aefb-20210119
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=ozSZxzeJfhdjy2ScWm8VmcjVBqWPRVRu2nraPSlGiUk=;
        b=GdHdxpLGzdPF8aKZs7EAtd6Fa6nHk3A47YIa1kxpdgXJ8v+3PGwyh4OALpNZ1qjEQFENEZIJ8TAVbnT68B25gXJlwIiJI+zpMFj5D8naYdU3yKqLR/EAYAnIMYqGJ6AVFsW13ZwkIuVF+p+Yl7v5zmcZv4uSrkkubPtMcp6oHNk=;
X-UUID: 408a52bca56c41948f86ab33c965aefb-20210119
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 861298066; Tue, 19 Jan 2021 15:33:37 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33N2.mediatek.inc
 (172.27.4.76) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 19 Jan
 2021 15:33:33 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 19 Jan 2021 15:33:32 +0800
Message-ID: <1611041612.12761.9.camel@mhfsdcap03>
Subject: Re: [PATCH 1/2] usb typec: tcpci: mt6360: Add vsafe0v support and
 external vbus supply control
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     cy_huang <u0084500@gmail.com>, <heikki.krogerus@linux.intel.com>,
        <matthias.bgg@gmail.com>, <robh+dt@kernel.org>,
        <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <cy_huang@richtek.com>,
        <gene_chen@richtek.com>, <devicetree@vger.kernel.org>
Date:   Tue, 19 Jan 2021 15:33:32 +0800
In-Reply-To: <3a4a88a9-f0e3-2b65-9df4-6c1d4e3f1c14@roeck-us.net>
References: <1610720001-15300-1-git-send-email-u0084500@gmail.com>
         <3a4a88a9-f0e3-2b65-9df4-6c1d4e3f1c14@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 583FC9A2C187E83C1BC85024308FDD8A9E0CF797AFAB7AE22F1756187A572C6B2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU3VuLCAyMDIxLTAxLTE3IGF0IDA5OjQzIC0wODAwLCBHdWVudGVyIFJvZWNrIHdyb3RlOg0K
PiBPbiAxLzE1LzIxIDY6MTMgQU0sIGN5X2h1YW5nIHdyb3RlOg0KPiA+IEZyb206IENoaVl1YW4g
SHVhbmcgPGN5X2h1YW5nQHJpY2h0ZWsuY29tPg0KPiA+IA0KPiA+IE1UNjM2MCBub3Qgc3VwcG9y
dCBmb3IgVENQQyBjb21tYW5kIHRvIGNvbnRyb2wgc291cmNlIGFuZCBzaW5rLg0KPiANCj4gZG9l
cyBub3QNCj4gDQo+ID4gVXNlcyBleHRlcm5hbCA1ViB2YnVzIHJlZ3VsYXRvciBhcyB0aGUgdmJ1
cyBzb3VyY2UgY29udHJvbC4NCj4gPiANCj4gVXNlDQo+IA0KPiA+IEFsc28gYWRkcyB0aGUgY2Fw
YWJpbGl0eSB0byByZXBvcnQgdnNhZmUwdi4NCj4gPiANCj4gYWRkDQo+IA0KPiBTbyBmYXIgdGhp
cyBkcml2ZXIgd29ya3Mgd2l0aG91dCByZWd1bGF0b3IuIFVubGVzcyBJIGFtIG1pc3Npbmcgc29t
ZXRoaW5nLA0KPiB0aGlzIHBhdGNoIG1ha2VzIHJlZ3VsYXRvciBzdXBwb3J0IG1hbmRhdG9yeSwg
bWVhbmluZyBleGlzdGluZyBjb2RlIHdpbGwgZmFpbC4NCklmIGRvbid0IHByb3ZpZGUgdmJ1cy1z
dXBwbHkgaW4gRFRTLCByZWd1bGF0b3IgZnJhbWV3b3JrIHdpbGwgcHJvdmlkZSBhDQpkdW1teSBy
ZWd1bGF0b3IsIHNvIHRoZSBjb2RlIHdpbGwgbm90IGZhaWwuDQo+IEkgYW0gbm90IHN1cmUgaWYg
dGhhdCBpcyBhcHByb3ByaWF0ZS9hY2NlcHRhYmxlLiBDYW4gd2UgYmUgc3VyZSB0aGF0IHRoaXMg
d2lsbA0KPiB3b3JrIGZvciBleGlzdGluZyB1c2VycyBvZiB0aGlzIGRyaXZlciA/DQoNCj4gDQo+
IFRoYW5rcywNCj4gR3VlbnRlcg0KPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBDaGlZdWFuIEh1YW5n
IDxjeV9odWFuZ0ByaWNodGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy91c2IvdHlwZWMv
dGNwbS90Y3BjaV9tdDYzNjAuYyB8IDI5ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+
ID4gIDEgZmlsZSBjaGFuZ2VkLCAyOSBpbnNlcnRpb25zKCspDQo+ID4gDQo+ID4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvdXNiL3R5cGVjL3RjcG0vdGNwY2lfbXQ2MzYwLmMgYi9kcml2ZXJzL3VzYi90
eXBlYy90Y3BtL3RjcGNpX210NjM2MC5jDQo+ID4gaW5kZXggZjFiZDllMC4uMGVkZjRiNiAxMDA2
NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3VzYi90eXBlYy90Y3BtL3RjcGNpX210NjM2MC5jDQo+ID4g
KysrIGIvZHJpdmVycy91c2IvdHlwZWMvdGNwbS90Y3BjaV9tdDYzNjAuYw0KPiA+IEBAIC0xMSw2
ICsxMSw3IEBADQo+ID4gICNpbmNsdWRlIDxsaW51eC9vZi5oPg0KPiA+ICAjaW5jbHVkZSA8bGlu
dXgvcGxhdGZvcm1fZGV2aWNlLmg+DQo+ID4gICNpbmNsdWRlIDxsaW51eC9yZWdtYXAuaD4NCj4g
PiArI2luY2x1ZGUgPGxpbnV4L3JlZ3VsYXRvci9jb25zdW1lci5oPg0KPiA+ICAjaW5jbHVkZSA8
bGludXgvdXNiL3RjcG0uaD4NCj4gPiAgDQo+ID4gICNpbmNsdWRlICJ0Y3BjaS5oIg0KPiA+IEBA
IC0zNiw2ICszNyw3IEBAIHN0cnVjdCBtdDYzNjBfdGNwY19pbmZvIHsNCj4gPiAgCXN0cnVjdCB0
Y3BjaV9kYXRhIHRkYXRhOw0KPiA+ICAJc3RydWN0IHRjcGNpICp0Y3BjaTsNCj4gPiAgCXN0cnVj
dCBkZXZpY2UgKmRldjsNCj4gPiArCXN0cnVjdCByZWd1bGF0b3IgKnZidXM7DQo+ID4gIAlpbnQg
aXJxOw0KPiA+ICB9Ow0KPiA+ICANCj4gPiBAQCAtNTEsNiArNTMsMjcgQEAgc3RhdGljIGlubGlu
ZSBpbnQgbXQ2MzYwX3RjcGNfd3JpdGUxNihzdHJ1Y3QgcmVnbWFwICpyZWdtYXAsDQo+ID4gIAly
ZXR1cm4gcmVnbWFwX3Jhd193cml0ZShyZWdtYXAsIHJlZywgJnZhbCwgc2l6ZW9mKHUxNikpOw0K
PiA+ICB9DQo+ID4gIA0KPiA+ICtzdGF0aWMgaW50IG10NjM2MF90Y3BjX3NldF92YnVzKHN0cnVj
dCB0Y3BjaSAqdGNwY2ksIHN0cnVjdCB0Y3BjaV9kYXRhICpkYXRhLCBib29sIHNyYywgYm9vbCBz
bmspDQo+ID4gK3sNCj4gPiArCXN0cnVjdCBtdDYzNjBfdGNwY19pbmZvICptdGkgPSBjb250YWlu
ZXJfb2YoZGF0YSwgc3RydWN0IG10NjM2MF90Y3BjX2luZm8sIHRkYXRhKTsNCj4gPiArCWludCBy
ZXQ7DQo+ID4gKw0KPiA+ICsJLyogVG8gY29ycmVjdGx5IGhhbmRsZSB0aGUgYWxyZWFkeSBlbmFi
bGVkIHZidXMgYW5kIGRpc2FibGUgaXRzIHN1cHBseSBmaXJzdCAqLw0KPiA+ICsJaWYgKHJlZ3Vs
YXRvcl9pc19lbmFibGVkKG10aS0+dmJ1cykpIHsNCj4gPiArCQlyZXQgPSByZWd1bGF0b3JfZGlz
YWJsZShtdGktPnZidXMpOw0KPiA+ICsJCWlmIChyZXQpDQo+ID4gKwkJCXJldHVybiByZXQ7DQo+
ID4gKwl9DQo+IA0KPiBJcyBpdCByZWFsbHkgYSBnb29kIGlkZWEgdG8gZGlzYWJsZSB2YnVzIGlm
IGl0IGhhcHBlbnMgdG8gYmUgYWxyZWFkeSBlbmFibGVkDQo+IGFuZCB0aGVyZSBpcyAoYW5vdGhl
ciA/KSByZXF1ZXN0IHRvIGVuYWJsZSBpdCA/DQo+IA0KPiA+ICsNCj4gPiArCWlmIChzcmMpIHsN
Cj4gPiArCQlyZXQgPSByZWd1bGF0b3JfZW5hYmxlKG10aS0+dmJ1cyk7DQo+ID4gKwkJaWYgKHJl
dCkNCj4gPiArCQkJcmV0dXJuIHJldDsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwlyZXR1cm4gMDsN
Cj4gPiArfQ0KPiA+ICsNCj4gPiAgc3RhdGljIGludCBtdDYzNjBfdGNwY19pbml0KHN0cnVjdCB0
Y3BjaSAqdGNwY2ksIHN0cnVjdCB0Y3BjaV9kYXRhICp0ZGF0YSkNCj4gPiAgew0KPiA+ICAJc3Ry
dWN0IHJlZ21hcCAqcmVnbWFwID0gdGRhdGEtPnJlZ21hcDsNCj4gPiBAQCAtMTM4LDcgKzE2MSwx
MyBAQCBzdGF0aWMgaW50IG10NjM2MF90Y3BjX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2Ug
KnBkZXYpDQo+ID4gIAlpZiAobXRpLT5pcnEgPCAwKQ0KPiA+ICAJCXJldHVybiBtdGktPmlycTsN
Cj4gPiAgDQo+ID4gKwltdGktPnZidXMgPSBkZXZtX3JlZ3VsYXRvcl9nZXQoJnBkZXYtPmRldiwg
InZidXMiKTsNCj4gPiArCWlmIChJU19FUlIobXRpLT52YnVzKSkNCj4gPiArCQlyZXR1cm4gUFRS
X0VSUihtdGktPnZidXMpOw0KPiA+ICsNCj4gPiAgCW10aS0+dGRhdGEuaW5pdCA9IG10NjM2MF90
Y3BjX2luaXQ7DQo+ID4gKwltdGktPnRkYXRhLnNldF92YnVzID0gbXQ2MzYwX3RjcGNfc2V0X3Zi
dXM7DQo+ID4gKwltdGktPnRkYXRhLnZidXNfdnNhZmUwdiA9IDE7DQo+ID4gIAltdGktPnRjcGNp
ID0gdGNwY2lfcmVnaXN0ZXJfcG9ydCgmcGRldi0+ZGV2LCAmbXRpLT50ZGF0YSk7DQo+ID4gIAlp
ZiAoSVNfRVJSKG10aS0+dGNwY2kpKSB7DQo+ID4gIAkJZGV2X2VycigmcGRldi0+ZGV2LCAiRmFp
bGVkIHRvIHJlZ2lzdGVyIHRjcGNpIHBvcnRcbiIpOw0KPiA+IA0KPiANCg0K


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45D902AFE2D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 06:36:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728813AbgKLFey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 00:34:54 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:11035 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727936AbgKLCm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 21:42:28 -0500
X-UUID: 9be016932b0b47b695a8a04d0e8f8134-20201112
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=2akmVV9MmjilHzebTF46wwbdEe3nnOXuaGxT3mDFxZs=;
        b=B7i1qKrUtHcI/SrwT5pZORy4ir14B95DBrTr40zBuN/emudAM9UljPzdzwIxIU/KipAoPdnBqq69O4YtWo0SayqRd9mCp/cVg8pqHfY55ZKSB3xDznpBQJzrWb2xopkGnj2phZeALos97dcKsTy7u7el/w3Lg5rwWjTpp2N/hDw=;
X-UUID: 9be016932b0b47b695a8a04d0e8f8134-20201112
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1625091449; Thu, 12 Nov 2020 10:42:21 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 12 Nov
 2020 10:42:19 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 12 Nov 2020 10:42:19 +0800
Message-ID: <1605148938.26323.127.camel@mhfsdcap03>
Subject: Re: [PATCH v4 13/24] iommu/mediatek: Add device link for smi-common
 and m4u
From:   Yong Wu <yong.wu@mediatek.com>
To:     Nicolas Boichat <drinkcat@chromium.org>
CC:     <youlin.pei@mediatek.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@google.com>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        <chao.hao@mediatek.com>, Will Deacon <will@kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Tomasz Figa <tfiga@google.com>,
        <iommu@lists.linux-foundation.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Evan Green <evgreen@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <kernel-team@android.com>, <anan.sun@mediatek.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "linux-arm Mailing List" <linux-arm-kernel@lists.infradead.org>
Date:   Thu, 12 Nov 2020 10:42:18 +0800
In-Reply-To: <CANMq1KBrnhAbGdKbsSmFJWONe-mkG6TJsN_jp2xuJ=4MiPyapQ@mail.gmail.com>
References: <20201111123838.15682-1-yong.wu@mediatek.com>
         <20201111123838.15682-14-yong.wu@mediatek.com>
         <CANMq1KBrnhAbGdKbsSmFJWONe-mkG6TJsN_jp2xuJ=4MiPyapQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 9DD61C76332B6A687D16ACA0116BA587755327AA8BAE00AF0ECEE2DBB83A02B42000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIwLTExLTEyIGF0IDA5OjEwICswODAwLCBOaWNvbGFzIEJvaWNoYXQgd3JvdGU6
DQo+IE9uIFdlZCwgTm92IDExLCAyMDIwIGF0IDg6NDAgUE0gWW9uZyBXdSA8eW9uZy53dUBtZWRp
YXRlay5jb20+IHdyb3RlOg0KPiA+DQo+ID4gSW4gdGhlIGxhc3Rlc3QgU29DLCBNNFUgaGFzIGl0
cyBzcGVjaWFsIHBvd2VyIGRvbWFpbi4gdGh1cywgSWYgdGhlIGVuZ2luZQ0KPiA+IGJlZ2luIHRv
IHdvcmssIGl0IHNob3VsZCBoZWxwIGVuYWJsZSB0aGUgcG93ZXIgZm9yIE00VSBmaXJzdGx5Lg0K
PiA+IEN1cnJlbnRseSBpZiB0aGUgZW5naW5lIHdvcmssIGl0IGFsd2F5cyBlbmFibGUgdGhlIHBv
d2VyL2Nsb2NrcyBmb3INCj4gPiBzbWktbGFyYnMvc21pLWNvbW1vbi4gVGhpcyBwYXRjaCBhZGRz
IGRldmljZV9saW5rIGZvciBzbWktY29tbW9uIGFuZCBNNFUuDQo+ID4gdGhlbiwgaWYgc21pLWNv
bW1vbiBwb3dlciBpcyBlbmFibGVkLCB0aGUgTTRVIHBvd2VyIGFsc28gaXMgcG93ZXJlZCBvbg0K
PiA+IGF1dG9tYXRpY2FsbHkuDQo+ID4NCj4gPiBOb3JtYWxseSBNNFUgY29ubmVjdCB3aXRoIHNl
dmVyYWwgc21pLWxhcmJzIGFuZCB0aGVpciBzbWktY29tbW9uIGFsd2F5cw0KPiA+IGFyZSB0aGUg
c2FtZSwgSW4gdGhpcyBwYXRjaCBpdCBnZXQgc21pLWNvbW1vbiBkZXYgZnJvbSB0aGUgZmlyc3Qg
c21pLWxhcmINCj4gPiBkZXZpY2UoaT09MCksIHRoZW4gYWRkIHRoZSBkZXZpY2VfbGluayBvbmx5
IHdoaWxlIG00dSBoYXMgcG93ZXItZG9tYWluLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogWW9u
ZyBXdSA8eW9uZy53dUBtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvaW9tbXUv
bXRrX2lvbW11LmMgfCAzNiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0NCj4g
PiAgZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuaCB8ICAxICsNCj4gPiAgMiBmaWxlcyBjaGFuZ2Vk
LCAzNCBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMgYi9kcml2ZXJzL2lvbW11L210a19pb21tdS5jDQo+
ID4gaW5kZXggY2ZkZjVjZTY5NmZkLi40Y2U3ZTA4ODNlNGQgMTAwNjQ0DQo+ID4gLS0tIGEvZHJp
dmVycy9pb21tdS9tdGtfaW9tbXUuYw0KPiA+ICsrKyBiL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11
LmMNCj4gPiBAQCAtMjAsNiArMjAsNyBAQA0KPiA+ICAjaW5jbHVkZSA8bGludXgvb2ZfaXJxLmg+
DQo+ID4gICNpbmNsdWRlIDxsaW51eC9vZl9wbGF0Zm9ybS5oPg0KPiA+ICAjaW5jbHVkZSA8bGlu
dXgvcGxhdGZvcm1fZGV2aWNlLmg+DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9wbV9ydW50aW1lLmg+
DQo+ID4gICNpbmNsdWRlIDxsaW51eC9yZWdtYXAuaD4NCj4gPiAgI2luY2x1ZGUgPGxpbnV4L3Ns
YWIuaD4NCj4gPiAgI2luY2x1ZGUgPGxpbnV4L3NwaW5sb2NrLmg+DQo+ID4gQEAgLTcwNSw3ICs3
MDYsNyBAQCBzdGF0aWMgaW50IG10a19pb21tdV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNl
ICpwZGV2KQ0KPiA+ICAgICAgICAgICAgICAgICByZXR1cm4gbGFyYl9ucjsNCj4gPg0KPiA+ICAg
ICAgICAgZm9yIChpID0gMDsgaSA8IGxhcmJfbnI7IGkrKykgew0KPiA+IC0gICAgICAgICAgICAg
ICBzdHJ1Y3QgZGV2aWNlX25vZGUgKmxhcmJub2RlOw0KPiA+ICsgICAgICAgICAgICAgICBzdHJ1
Y3QgZGV2aWNlX25vZGUgKmxhcmJub2RlLCAqc21pY29tbV9ub2RlOw0KPiA+ICAgICAgICAgICAg
ICAgICBzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwbGFyYmRldjsNCj4gPiAgICAgICAgICAgICAg
ICAgdTMyIGlkOw0KPiA+DQo+ID4gQEAgLTczMSw2ICs3MzIsMjYgQEAgc3RhdGljIGludCBtdGtf
aW9tbXVfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gPg0KPiA+ICAgICAg
ICAgICAgICAgICBjb21wb25lbnRfbWF0Y2hfYWRkX3JlbGVhc2UoZGV2LCAmbWF0Y2gsIHJlbGVh
c2Vfb2YsDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBj
b21wYXJlX29mLCBsYXJibm9kZSk7DQo+ID4gKyAgICAgICAgICAgICAgIGlmICghaSkgew0KPiAN
Cj4gTWF5YmUgbW9yZSBvZiBhIHN0eWxlIHByZWZlcmVuY2UsIGJ1dCBzaW5jZSB5b3UgYXJlIGFj
dHVhbGx5IGNvbXBhcmluZw0KPiBhbiBpbnRlZ2VyLCBJIHByZWZlciBzZWVpbmcgaSA9PSAwLg0K
PiANCj4gQWxzbywgbWlnaHQgYmUgbmljZXIgdG8gZG8NCj4gDQo+IGlmIChpICE9IDApDQo+ICAg
IGNvbnRpbnVlOw0KPiANCj4gQW5kIGRlLWluZGVudCB0aGUgcmVzdC4NCg0KVGhhbmtzLiB3aWxs
IGZpeC4NCg0KPiANCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBzbWljb21tX25vZGUgPSBv
Zl9wYXJzZV9waGFuZGxlKGxhcmJub2RlLCAibWVkaWF0ZWssc21pIiwgMCk7DQo+ID4gKyAgICAg
ICAgICAgICAgICAgICAgICAgaWYgKCFzbWljb21tX25vZGUpDQo+ID4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4gPiArDQo+ID4gKyAgICAgICAgICAg
ICAgICAgICAgICAgcGxhcmJkZXYgPSBvZl9maW5kX2RldmljZV9ieV9ub2RlKHNtaWNvbW1fbm9k
ZSk7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgb2Zfbm9kZV9wdXQoc21pY29tbV9ub2Rl
KTsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBkYXRhLT5zbWljb21tX2RldiA9ICZwbGFy
YmRldi0+ZGV2Ow0KPiA+ICsgICAgICAgICAgICAgICB9DQo+ID4gKyAgICAgICB9DQo+ID4gKw0K
PiA+ICsgICAgICAgaWYgKGRldi0+cG1fZG9tYWluKSB7DQo+ID4gKyAgICAgICAgICAgICAgIHN0
cnVjdCBkZXZpY2VfbGluayAqbGluazsNCj4gPiArDQo+ID4gKyAgICAgICAgICAgICAgIGxpbmsg
PSBkZXZpY2VfbGlua19hZGQoZGF0YS0+c21pY29tbV9kZXYsIGRldiwNCj4gPiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBETF9GTEFHX1NUQVRFTEVTUyB8IERMX0ZMQUdf
UE1fUlVOVElNRSk7DQo+ID4gKyAgICAgICAgICAgICAgIGlmICghbGluaykgew0KPiA+ICsgICAg
ICAgICAgICAgICAgICAgICAgIGRldl9lcnIoZGV2LCAiVW5hYmxlIGxpbmsgJXMuXG4iLCBkZXZf
bmFtZShkYXRhLT5zbWljb21tX2RldikpOw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIHJl
dHVybiAtRUlOVkFMOw0KPiA+ICsgICAgICAgICAgICAgICB9DQo+ID4gICAgICAgICB9DQo+ID4N
Cj4gPiAgICAgICAgIHBsYXRmb3JtX3NldF9kcnZkYXRhKHBkZXYsIGRhdGEpOw0KPiA+IEBAIC03
MzgsMTQgKzc1OSwxNCBAQCBzdGF0aWMgaW50IG10a19pb21tdV9wcm9iZShzdHJ1Y3QgcGxhdGZv
cm1fZGV2aWNlICpwZGV2KQ0KPiA+ICAgICAgICAgcmV0ID0gaW9tbXVfZGV2aWNlX3N5c2ZzX2Fk
ZCgmZGF0YS0+aW9tbXUsIGRldiwgTlVMTCwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIm10ay1pb21tdS4lcGEiLCAmaW9hZGRyKTsNCj4gPiAgICAgICAgIGlmIChy
ZXQpDQo+ID4gLSAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+ID4gKyAgICAgICAgICAgICAg
IGdvdG8gb3V0X2xpbmtfcmVtb3ZlOw0KPiA+DQo+ID4gICAgICAgICBpb21tdV9kZXZpY2Vfc2V0
X29wcygmZGF0YS0+aW9tbXUsICZtdGtfaW9tbXVfb3BzKTsNCj4gPiAgICAgICAgIGlvbW11X2Rl
dmljZV9zZXRfZndub2RlKCZkYXRhLT5pb21tdSwgJnBkZXYtPmRldi5vZl9ub2RlLT5md25vZGUp
Ow0KPiA+DQo+ID4gICAgICAgICByZXQgPSBpb21tdV9kZXZpY2VfcmVnaXN0ZXIoJmRhdGEtPmlv
bW11KTsNCj4gPiAgICAgICAgIGlmIChyZXQpDQo+ID4gLSAgICAgICAgICAgICAgIHJldHVybiBy
ZXQ7DQo+ID4gKyAgICAgICAgICAgICAgIGdvdG8gb3V0X3N5c2ZzX3JlbW92ZTsNCj4gDQo+IFRl
Y2huaWNhbGx5LCB0aGlzIGNoYW5nZSBpcyB1bnJlbGF0ZWQuDQoNClNoYXJwIGV5ZS4gUmlnaHQu
IEkgdGhvdWdodCBpdCB3YXMgc21hbGwgZW5vdWdoIHRvIHNxdWFzaCBoZXJlLg0KDQpJIHdpbGwg
dXNlIGEgbmV3IHBhdGNoIHRvIGZpeCB0aGlzKGFkZCBmaXhlcyB0YWcsIGFuZCBubyBuZWVkIGFk
ZA0KY2Mtc3RhYmxlIEkgdGhpbmsuKS4NCg0KPiANCj4gPg0KPiA+ICAgICAgICAgc3Bpbl9sb2Nr
X2luaXQoJmRhdGEtPnRsYl9sb2NrKTsNCj4gPiAgICAgICAgIGxpc3RfYWRkX3RhaWwoJmRhdGEt
Pmxpc3QsICZtNHVsaXN0KTsNCj4gPiBAQCAtNzU0LDYgKzc3NSwxMyBAQCBzdGF0aWMgaW50IG10
a19pb21tdV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+ICAgICAgICAg
ICAgICAgICBidXNfc2V0X2lvbW11KCZwbGF0Zm9ybV9idXNfdHlwZSwgJm10a19pb21tdV9vcHMp
Ow0KPiA+DQo+ID4gICAgICAgICByZXR1cm4gY29tcG9uZW50X21hc3Rlcl9hZGRfd2l0aF9tYXRj
aChkZXYsICZtdGtfaW9tbXVfY29tX29wcywgbWF0Y2gpOw0KPiA+ICsNCj4gPiArb3V0X3N5c2Zz
X3JlbW92ZToNCj4gPiArICAgICAgIGlvbW11X2RldmljZV9zeXNmc19yZW1vdmUoJmRhdGEtPmlv
bW11KTsNCj4gPiArb3V0X2xpbmtfcmVtb3ZlOg0KPiA+ICsgICAgICAgaWYgKGRldi0+cG1fZG9t
YWluKQ0KPiA+ICsgICAgICAgICAgICAgICBkZXZpY2VfbGlua19yZW1vdmUoZGF0YS0+c21pY29t
bV9kZXYsIGRldik7DQo+ID4gKyAgICAgICByZXR1cm4gcmV0Ow0KPiA+ICB9DQo+ID4NCj4gPiAg
c3RhdGljIGludCBtdGtfaW9tbXVfcmVtb3ZlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYp
DQo+ID4gQEAgLTc2Nyw2ICs3OTUsOCBAQCBzdGF0aWMgaW50IG10a19pb21tdV9yZW1vdmUoc3Ry
dWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gPiAgICAgICAgICAgICAgICAgYnVzX3NldF9p
b21tdSgmcGxhdGZvcm1fYnVzX3R5cGUsIE5VTEwpOw0KPiA+DQo+ID4gICAgICAgICBjbGtfZGlz
YWJsZV91bnByZXBhcmUoZGF0YS0+YmNsayk7DQo+ID4gKyAgICAgICBpZiAocGRldi0+ZGV2LnBt
X2RvbWFpbikNCj4gPiArICAgICAgICAgICAgICAgZGV2aWNlX2xpbmtfcmVtb3ZlKGRhdGEtPnNt
aWNvbW1fZGV2LCAmcGRldi0+ZGV2KTsNCj4gPiAgICAgICAgIGRldm1fZnJlZV9pcnEoJnBkZXYt
PmRldiwgZGF0YS0+aXJxLCBkYXRhKTsNCj4gPiAgICAgICAgIGNvbXBvbmVudF9tYXN0ZXJfZGVs
KCZwZGV2LT5kZXYsICZtdGtfaW9tbXVfY29tX29wcyk7DQo+ID4gICAgICAgICByZXR1cm4gMDsN
Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuaCBiL2RyaXZlcnMvaW9t
bXUvbXRrX2lvbW11LmgNCj4gPiBpbmRleCBkMGM5MzY1MmJkYmUuLjVlMDNhMDI5YzRkYyAxMDA2
NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2lvbW11L210a19pb21tdS5oDQo+ID4gKysrIGIvZHJpdmVy
cy9pb21tdS9tdGtfaW9tbXUuaA0KPiA+IEBAIC02OCw2ICs2OCw3IEBAIHN0cnVjdCBtdGtfaW9t
bXVfZGF0YSB7DQo+ID4NCj4gPiAgICAgICAgIHN0cnVjdCBpb21tdV9kZXZpY2UgICAgICAgICAg
ICAgaW9tbXU7DQo+ID4gICAgICAgICBjb25zdCBzdHJ1Y3QgbXRrX2lvbW11X3BsYXRfZGF0YSAq
cGxhdF9kYXRhOw0KPiA+ICsgICAgICAgc3RydWN0IGRldmljZSAgICAgICAgICAgICAgICAgICAq
c21pY29tbV9kZXY7DQo+ID4NCj4gPiAgICAgICAgIHN0cnVjdCBkbWFfaW9tbXVfbWFwcGluZyAg
ICAgICAgKm1hcHBpbmc7IC8qIEZvciBtdGtfaW9tbXVfdjEuYyAqLw0KPiA+DQo+ID4gLS0NCj4g
PiAyLjE4LjANCj4gPg0KPiANCj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18NCj4gTGludXgtbWVkaWF0ZWsgbWFpbGluZyBsaXN0DQo+IExpbnV4LW1lZGlh
dGVrQGxpc3RzLmluZnJhZGVhZC5vcmcNCj4gaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFp
bG1hbi9saXN0aW5mby9saW51eC1tZWRpYXRlaw0KDQo=


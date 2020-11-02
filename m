Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 577282A2B43
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 14:11:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728687AbgKBNLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 08:11:53 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:33762 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728253AbgKBNLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 08:11:52 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A2D7b50013804;
        Mon, 2 Nov 2020 14:11:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=3HdWeV86WFx+GNisUbqL+zoSdGCvnlJejFltoMy+vQU=;
 b=SRrw2FLjkvhTEkZ8bIGQ3gOHbhUje9oibhSup1WRLMzuu3cH4W7PetjFjlaXv4NqgK1s
 psTvk2hhdmxxn5k0PqQ4tZfuEBGS5046vAMS6Wh0tuSrC/Kgzb7O8Hqe+bt3O5XkN81Q
 2pQrxNON6XgVNMPbgozIyYChuAeJCRTLr7niEUAimNhwUiw0kfhpgZ4ol93rYn+F53F2
 IHDVRGa4IERGzSbNdIAJHl+lxCeZ1Ij6orFytzJzvhJh6N9xn/TCp/m9XKfrGAFURBa1
 f0lNjKVZCY1B4ns5116jL4g0027G10r2KwfaAkmtpUS1gkK9NBmBOhmQzbHwhMztNY6/ dg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 34gywqjs82-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Nov 2020 14:11:42 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2666010002A;
        Mon,  2 Nov 2020 14:11:41 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 180102B4D0F;
        Mon,  2 Nov 2020 14:11:41 +0100 (CET)
Received: from SFHDAG1NODE3.st.com (10.75.127.3) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 2 Nov
 2020 14:11:40 +0100
Received: from SFHDAG1NODE3.st.com ([fe80::ad8b:a44d:504a:670d]) by
 SFHDAG1NODE3.st.com ([fe80::ad8b:a44d:504a:670d%20]) with mapi id
 15.00.1473.003; Mon, 2 Nov 2020 14:11:40 +0100
From:   Fabien DESSENNE <fabien.dessenne@st.com>
To:     Martin Kaiser <martin@kaiser.cx>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>
CC:     "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2 3/3] mailbox: stm32-ipcc: cast void pointers to
 unsigned long
Thread-Topic: [PATCH v2 3/3] mailbox: stm32-ipcc: cast void pointers to
 unsigned long
Thread-Index: AQHWsGW/jAuCDkDpAEiDXEawNcFXqam0wcUA
Date:   Mon, 2 Nov 2020 13:11:40 +0000
Message-ID: <948c95e9-dcaa-fde7-05ca-e8587180f57e@st.com>
References: <20201024133154.22767-1-martin@kaiser.cx>
 <20201101154231.14250-1-martin@kaiser.cx>
 <20201101154231.14250-3-martin@kaiser.cx>
In-Reply-To: <20201101154231.14250-3-martin@kaiser.cx>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.51]
Content-Type: text/plain; charset="utf-8"
Content-ID: <BCBF61D4304480408F28CAC457EC1AD9@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-02_07:2020-11-02,2020-11-02 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWFydGluDQoNCg0KVGhhbmsgeW91IGZvciB0aGUgcGF0Y2guDQoNCg0KRmFiaWVuDQoNCg0K
T24gMDEvMTEvMjAyMCA0OjQyIHBtLCBNYXJ0aW4gS2Fpc2VyIHdyb3RlOg0KPiBOb3cgdGhhdCB0
aGUgZHJpdmVyIGNhbiBiZSBlbmFibGVkIGJ5IENPTVBJTEVfVEVTVCwgd2Ugc2VlIHdhcm5pbmdz
IG9uDQo+IDY0Yml0IHBsYXRmb3JtcyB3aGVuIHZvaWQgcG9pbnRlcnMgYXJlIGNhc3QgdG8gdW5z
aWduZWQgaW50IChhbmQNCj4gdmljZSB2ZXJzYSkuDQo+DQo+IHdhcm5pbmc6IGNhc3QgdG8gc21h
bGxlciBpbnRlZ2VyIHR5cGUgJ3Vuc2lnbmVkIGludCcgZnJvbSAndm9pZCAqJw0KPiAgICAgICAg
ICAgICB1bnNpZ25lZCBpbnQgY2hhbiA9ICh1bnNpZ25lZCBpbnQpbGluay0+Y29uX3ByaXY7DQo+
IC4uLg0KPiB3YXJuaW5nOiBjYXN0IHRvICd2b2lkIConIGZyb20gc21hbGxlciBpbnRlZ2VyIHR5
cGUgJ3Vuc2lnbmVkIGludCcNCj4gICAgICAgICAgICAgaXBjYy0+Y29udHJvbGxlci5jaGFuc1tp
XS5jb25fcHJpdiA9ICh2b2lkICopaTsNCj4NCj4gVXBkYXRlIHRoZXNlIGNhc3RzIHRvIHVzZSB1
bnNpZ25lZCBsb25nIHZhcmlhYmxlcywgd2hpY2ggYXJlIHRoZSBzYW1lDQo+IHNpemUgYXMgcG9p
bnRlcnMgb24gYWxsIHBsYXRmb3Jtcy4NCj4NCj4gUmVwb3J0ZWQtYnk6IGtlcm5lbCB0ZXN0IHJv
Ym90IDxsa3BAaW50ZWwuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBNYXJ0aW4gS2Fpc2VyIDxtYXJ0
aW5Aa2Fpc2VyLmN4Pg0KDQoNClJldmlld2VkLWJ5OiBGYWJpZW4gRGVzc2VubmU8ZmFiaWVuLmRl
c3Nlbm5lQHN0LmNvbT4NCg0KDQo+IC0tLQ0KPiBjaGFuZ2VzIGluIHYyDQo+IC0gYWRkZWQgdGhp
cyBwYXRjaCB0byBmaXggQ09NUElMRV9URVNUIHdhcm5pbmdzDQo+DQo+ICAgZHJpdmVycy9tYWls
Ym94L3N0bTMyLWlwY2MuYyB8IDEyICsrKysrKy0tLS0tLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA2
IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L21haWxib3gvc3RtMzItaXBjYy5jIGIvZHJpdmVycy9tYWlsYm94L3N0bTMyLWlwY2MuYw0KPiBp
bmRleCBhYjhmZTU2YWY5NDguLmI4NGUwNTg3OTM3YyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9t
YWlsYm94L3N0bTMyLWlwY2MuYw0KPiArKysgYi9kcml2ZXJzL21haWxib3gvc3RtMzItaXBjYy5j
DQo+IEBAIC0xNDQsMTEgKzE0NCwxMSBAQCBzdGF0aWMgaXJxcmV0dXJuX3Qgc3RtMzJfaXBjY190
eF9pcnEoaW50IGlycSwgdm9pZCAqZGF0YSkNCj4gICANCj4gICBzdGF0aWMgaW50IHN0bTMyX2lw
Y2Nfc2VuZF9kYXRhKHN0cnVjdCBtYm94X2NoYW4gKmxpbmssIHZvaWQgKmRhdGEpDQo+ICAgew0K
PiAtCXVuc2lnbmVkIGludCBjaGFuID0gKHVuc2lnbmVkIGludClsaW5rLT5jb25fcHJpdjsNCj4g
Kwl1bnNpZ25lZCBsb25nIGNoYW4gPSAodW5zaWduZWQgbG9uZylsaW5rLT5jb25fcHJpdjsNCj4g
ICAJc3RydWN0IHN0bTMyX2lwY2MgKmlwY2MgPSBjb250YWluZXJfb2YobGluay0+bWJveCwgc3Ry
dWN0IHN0bTMyX2lwY2MsDQo+ICAgCQkJCQkgICAgICAgY29udHJvbGxlcik7DQo+ICAgDQo+IC0J
ZGV2X2RiZyhpcGNjLT5jb250cm9sbGVyLmRldiwgIiVzOiBjaGFuOiVkXG4iLCBfX2Z1bmNfXywg
Y2hhbik7DQo+ICsJZGV2X2RiZyhpcGNjLT5jb250cm9sbGVyLmRldiwgIiVzOiBjaGFuOiVsdVxu
IiwgX19mdW5jX18sIGNoYW4pOw0KPiAgIA0KPiAgIAkvKiBzZXQgY2hhbm5lbCBuIG9jY3VwaWVk
ICovDQo+ICAgCXN0bTMyX2lwY2Nfc2V0X2JpdHMoJmlwY2MtPmxvY2ssIGlwY2MtPnJlZ19wcm9j
ICsgSVBDQ19YU0NSLA0KPiBAQCAtMTYzLDcgKzE2Myw3IEBAIHN0YXRpYyBpbnQgc3RtMzJfaXBj
Y19zZW5kX2RhdGEoc3RydWN0IG1ib3hfY2hhbiAqbGluaywgdm9pZCAqZGF0YSkNCj4gICANCj4g
ICBzdGF0aWMgaW50IHN0bTMyX2lwY2Nfc3RhcnR1cChzdHJ1Y3QgbWJveF9jaGFuICpsaW5rKQ0K
PiAgIHsNCj4gLQl1bnNpZ25lZCBpbnQgY2hhbiA9ICh1bnNpZ25lZCBpbnQpbGluay0+Y29uX3By
aXY7DQo+ICsJdW5zaWduZWQgbG9uZyBjaGFuID0gKHVuc2lnbmVkIGxvbmcpbGluay0+Y29uX3By
aXY7DQo+ICAgCXN0cnVjdCBzdG0zMl9pcGNjICppcGNjID0gY29udGFpbmVyX29mKGxpbmstPm1i
b3gsIHN0cnVjdCBzdG0zMl9pcGNjLA0KPiAgIAkJCQkJICAgICAgIGNvbnRyb2xsZXIpOw0KPiAg
IAlpbnQgcmV0Ow0KPiBAQCAtMTgzLDcgKzE4Myw3IEBAIHN0YXRpYyBpbnQgc3RtMzJfaXBjY19z
dGFydHVwKHN0cnVjdCBtYm94X2NoYW4gKmxpbmspDQo+ICAgDQo+ICAgc3RhdGljIHZvaWQgc3Rt
MzJfaXBjY19zaHV0ZG93bihzdHJ1Y3QgbWJveF9jaGFuICpsaW5rKQ0KPiAgIHsNCj4gLQl1bnNp
Z25lZCBpbnQgY2hhbiA9ICh1bnNpZ25lZCBpbnQpbGluay0+Y29uX3ByaXY7DQo+ICsJdW5zaWdu
ZWQgbG9uZyBjaGFuID0gKHVuc2lnbmVkIGxvbmcpbGluay0+Y29uX3ByaXY7DQo+ICAgCXN0cnVj
dCBzdG0zMl9pcGNjICppcGNjID0gY29udGFpbmVyX29mKGxpbmstPm1ib3gsIHN0cnVjdCBzdG0z
Ml9pcGNjLA0KPiAgIAkJCQkJICAgICAgIGNvbnRyb2xsZXIpOw0KPiAgIA0KPiBAQCAtMjA2LDcg
KzIwNiw3IEBAIHN0YXRpYyBpbnQgc3RtMzJfaXBjY19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2
aWNlICpwZGV2KQ0KPiAgIAlzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wID0gZGV2LT5vZl9ub2RlOw0K
PiAgIAlzdHJ1Y3Qgc3RtMzJfaXBjYyAqaXBjYzsNCj4gICAJc3RydWN0IHJlc291cmNlICpyZXM7
DQo+IC0JdW5zaWduZWQgaW50IGk7DQo+ICsJdW5zaWduZWQgbG9uZyBpOw0KPiAgIAlpbnQgcmV0
Ow0KPiAgIAl1MzIgaXBfdmVyOw0KPiAgIAlzdGF0aWMgY29uc3QgY2hhciAqIGNvbnN0IGlycV9u
YW1lW10gPSB7InJ4IiwgInR4In07DQo+IEBAIC0yNjUsNyArMjY1LDcgQEAgc3RhdGljIGludCBz
dG0zMl9pcGNjX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICAgCQkJCQkJ
aXJxX3RocmVhZFtpXSwgSVJRRl9PTkVTSE9ULA0KPiAgIAkJCQkJCWRldl9uYW1lKGRldiksIGlw
Y2MpOw0KPiAgIAkJaWYgKHJldCkgew0KPiAtCQkJZGV2X2VycihkZXYsICJmYWlsZWQgdG8gcmVx
dWVzdCBpcnEgJWQgKCVkKVxuIiwgaSwgcmV0KTsNCj4gKwkJCWRldl9lcnIoZGV2LCAiZmFpbGVk
IHRvIHJlcXVlc3QgaXJxICVsdSAoJWQpXG4iLCBpLCByZXQpOw0KPiAgIAkJCWdvdG8gZXJyX2Ns
azsNCj4gICAJCX0NCj4gICAJfQ==

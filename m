Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7652753DE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 10:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbgIWIzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 04:55:53 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:35014 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726244AbgIWIzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 04:55:53 -0400
X-UUID: 2bf97a6600f943e4adc8bbc6c2fdc2ca-20200923
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=NhDFo4XEQ22ht9DWcD1rv2Z1SL8D0UP7rC77FJzJezA=;
        b=a6aUI9n4gihndt34QAfgg9trnivH32mBxcjCYy7Wf/46W1qFe4NSGYQo9JhBkhwJzgTnh1r/dVv/VyB7I8pRechZVPHOfituOvccu4otXlQQ1OhH6dVwzFbONEqpHh78wDc1rlGuufqoDeIo2hoaXDSbMEvvjKZ7dz/lZ52cnPY=;
X-UUID: 2bf97a6600f943e4adc8bbc6c2fdc2ca-20200923
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1074763504; Wed, 23 Sep 2020 16:55:48 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 23 Sep
 2020 16:55:45 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 23 Sep 2020 16:55:46 +0800
Message-ID: <1600851204.21970.0.camel@mhfsdcap03>
Subject: Re: [PATCH v4 04/11] usb: xhci-rcar: convert to
 readl_poll_timeout_atomic()
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
CC:     Mathias Nyman <mathias.nyman@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        "Jann Horn" <jannh@google.com>, Jason Yan <yanaijie@huawei.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Chuhong Yuan <hslester96@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>,
        Saurav Girepunje <saurav.girepunje@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>
Date:   Wed, 23 Sep 2020 16:53:24 +0800
In-Reply-To: <TY2PR01MB3692184CBB3C12EE8A02BA48D8380@TY2PR01MB3692.jpnprd01.prod.outlook.com>
References: <1600668815-12135-1-git-send-email-chunfeng.yun@mediatek.com>
         <1600668815-12135-4-git-send-email-chunfeng.yun@mediatek.com>
         <TY2PR01MB3692184CBB3C12EE8A02BA48D8380@TY2PR01MB3692.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: FE3AB98C311EFA98981F2CBA12670AB0267560B3D3B7CB0206D39F82BE2A85D52000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIwLTA5LTIzIGF0IDA4OjQ3ICswMDAwLCBZb3NoaWhpcm8gU2hpbW9kYSB3cm90
ZToNCj4gSGkgQ2h1bmdlbmcsDQo+IA0KPiBUaGFuayB5b3UgZm9yIHRoZSBwYXRjaCENCj4gDQo+
ID4gRnJvbTogQ2h1bmZlbmcgWXVuLCBTZW50OiBNb25kYXksIFNlcHRlbWJlciAyMSwgMjAyMCAz
OjEzIFBNDQo+ID4gDQo+ID4gVXNlIHJlYWRsX3BvbGxfdGltZW91dF9hdG9taWMoKSB0byBzaW1w
bGlmeSBjb2RlDQo+ID4gDQo+ID4gQ2M6IE1hdGhpYXMgTnltYW4gPG1hdGhpYXMubnltYW5AbGlu
dXguaW50ZWwuY29tPg0KPiA+IENjOiBZb3NoaWhpcm8gU2hpbW9kYSA8eW9zaGloaXJvLnNoaW1v
ZGEudWhAcmVuZXNhcy5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogQ2h1bmZlbmcgWXVuIDxjaHVu
ZmVuZy55dW5AbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+IHY0OiBjaGFuZ2VzDQo+ID4gICAg
IDEuIHJlbW92ZSB1bm5lY2Vzc2FyeSBwYXJlbnRoZXNlcyBzdWdnZXN0ZWQgYnkgWW9zaGloaXJv
DQo+ID4gICAgIDIuIGZpeCB0aGUgd3JvbmcgcmV0dXJuIHZhbHVlIHN1Z2dlc3RlZCBieSBZb3No
aWhpcm8gJiBEYW5pZWwNCj4gPiANCj4gPiB2Mn52Mzogbm8gY2hhbmdlcw0KPiA+IC0tLQ0KPiA+
ICBkcml2ZXJzL3VzYi9ob3N0L3hoY2ktcmNhci5jIHwgNDMgKysrKysrKysrKysrLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTIgaW5zZXJ0aW9u
cygrKSwgMzEgZGVsZXRpb25zKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNi
L2hvc3QveGhjaS1yY2FyLmMgYi9kcml2ZXJzL3VzYi9ob3N0L3hoY2ktcmNhci5jDQo+ID4gaW5k
ZXggYzEwMjVkMy4uMWJjNGZlNyAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3VzYi9ob3N0L3ho
Y2ktcmNhci5jDQo+ID4gKysrIGIvZHJpdmVycy91c2IvaG9zdC94aGNpLXJjYXIuYw0KPiA+IEBA
IC02LDYgKzYsNyBAQA0KPiA+ICAgKi8NCj4gPiANCj4gPiAgI2luY2x1ZGUgPGxpbnV4L2Zpcm13
YXJlLmg+DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9pb3BvbGwuaD4NCj4gPiAgI2luY2x1ZGUgPGxp
bnV4L21vZHVsZS5oPg0KPiA+ICAjaW5jbHVkZSA8bGludXgvcGxhdGZvcm1fZGV2aWNlLmg+DQo+
ID4gICNpbmNsdWRlIDxsaW51eC9vZi5oPg0KPiA+IEBAIC0xMjcsOCArMTI4LDcgQEAgc3RhdGlj
IGludCB4aGNpX3JjYXJfZG93bmxvYWRfZmlybXdhcmUoc3RydWN0IHVzYl9oY2QgKmhjZCkNCj4g
PiAgCXZvaWQgX19pb21lbSAqcmVncyA9IGhjZC0+cmVnczsNCj4gPiAgCXN0cnVjdCB4aGNpX3Bs
YXRfcHJpdiAqcHJpdiA9IGhjZF90b194aGNpX3ByaXYoaGNkKTsNCj4gPiAgCWNvbnN0IHN0cnVj
dCBmaXJtd2FyZSAqZnc7DQo+ID4gLQlpbnQgcmV0dmFsLCBpbmRleCwgaiwgdGltZTsNCj4gPiAt
CWludCB0aW1lb3V0ID0gMTAwMDA7DQo+ID4gKwlpbnQgcmV0dmFsLCBpbmRleCwgajsNCj4gPiAg
CXUzMiBkYXRhLCB2YWwsIHRlbXA7DQo+ID4gIAl1MzIgcXVpcmtzID0gMDsNCj4gPiAgCWNvbnN0
IHN0cnVjdCBzb2NfZGV2aWNlX2F0dHJpYnV0ZSAqYXR0cjsNCj4gPiBAQCAtMTY2LDMyICsxNjYs
MTkgQEAgc3RhdGljIGludCB4aGNpX3JjYXJfZG93bmxvYWRfZmlybXdhcmUoc3RydWN0IHVzYl9o
Y2QgKmhjZCkNCj4gPiAgCQl0ZW1wIHw9IFJDQVJfVVNCM19ETF9DVFJMX0ZXX1NFVF9EQVRBMDsN
Cj4gPiAgCQl3cml0ZWwodGVtcCwgcmVncyArIFJDQVJfVVNCM19ETF9DVFJMKTsNCj4gPiANCj4g
PiAtCQlmb3IgKHRpbWUgPSAwOyB0aW1lIDwgdGltZW91dDsgdGltZSsrKSB7DQo+ID4gLQkJCXZh
bCA9IHJlYWRsKHJlZ3MgKyBSQ0FSX1VTQjNfRExfQ1RSTCk7DQo+ID4gLQkJCWlmICgodmFsICYg
UkNBUl9VU0IzX0RMX0NUUkxfRldfU0VUX0RBVEEwKSA9PSAwKQ0KPiA+IC0JCQkJYnJlYWs7DQo+
ID4gLQkJCXVkZWxheSgxKTsNCj4gPiAtCQl9DQo+ID4gLQkJaWYgKHRpbWUgPT0gdGltZW91dCkg
ew0KPiA+IC0JCQlyZXR2YWwgPSAtRVRJTUVET1VUOw0KPiA+ICsJCXJldHZhbCA9IHJlYWRsX3Bv
bGxfdGltZW91dF9hdG9taWMocmVncyArIFJDQVJfVVNCM19ETF9DVFJMLA0KPiA+ICsJCQkJdmFs
LCAhKHZhbCAmIFJDQVJfVVNCM19ETF9DVFJMX0ZXX1NFVF9EQVRBMCksDQo+ID4gKwkJCQkxLCAx
MDAwMCk7DQo+ID4gKwkJaWYgKHJldHZhbCA8IDApDQo+ID4gIAkJCWJyZWFrOw0KPiA+IC0JCX0N
Cj4gPiAgCX0NCj4gPiANCj4gPiAgCXRlbXAgPSByZWFkbChyZWdzICsgUkNBUl9VU0IzX0RMX0NU
UkwpOw0KPiA+ICAJdGVtcCAmPSB+UkNBUl9VU0IzX0RMX0NUUkxfRU5BQkxFOw0KPiA+ICAJd3Jp
dGVsKHRlbXAsIHJlZ3MgKyBSQ0FSX1VTQjNfRExfQ1RSTCk7DQo+ID4gDQo+ID4gLQlmb3IgKHRp
bWUgPSAwOyB0aW1lIDwgdGltZW91dDsgdGltZSsrKSB7DQo+ID4gLQkJdmFsID0gcmVhZGwocmVn
cyArIFJDQVJfVVNCM19ETF9DVFJMKTsNCj4gPiAtCQlpZiAodmFsICYgUkNBUl9VU0IzX0RMX0NU
UkxfRldfU1VDQ0VTUykgew0KPiA+IC0JCQlyZXR2YWwgPSAwOw0KPiA+IC0JCQlicmVhazsNCj4g
PiAtCQl9DQo+ID4gLQkJdWRlbGF5KDEpOw0KPiA+IC0JfQ0KPiA+IC0JaWYgKHRpbWUgPT0gdGlt
ZW91dCkNCj4gPiAtCQlyZXR2YWwgPSAtRVRJTUVET1VUOw0KPiA+ICsJcmV0dmFsID0gcmVhZGxf
cG9sbF90aW1lb3V0X2F0b21pYygocmVncyArIFJDQVJfVVNCM19ETF9DVFJMKSwNCj4gDQo+IFdl
IGNhbiBhbHNvIHJlbW92ZSB0aGVzZSB1bm5lY2Vzc2FyeSBwYXJlbnRoZXNlcyBsaWtlIGJlbG93
Lg0KT2ssIHdpbGwgcmVtb3ZlIGl0LCB0aGFua3MgYSBsb3QNCg0KPiANCj4gKwlyZXR2YWwgPSBy
ZWFkbF9wb2xsX3RpbWVvdXRfYXRvbWljKHJlZ3MgKyBSQ0FSX1VTQjNfRExfQ1RSTCwNCj4gDQo+
IEFmdGVyIGZpeGVkIHRoaXM6DQo+IA0KPiBSZXZpZXdlZC1ieTogWW9zaGloaXJvIFNoaW1vZGEg
PHlvc2hpaGlyby5zaGltb2RhLnVoQHJlbmVzYXMuY29tPg0KPiANCj4gQmVzdCByZWdhcmRzLA0K
PiBZb3NoaWhpcm8gU2hpbW9kYQ0KPiANCg0K


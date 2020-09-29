Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFB7327BCCC
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 08:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbgI2GJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 02:09:18 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:32423 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725536AbgI2GJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 02:09:18 -0400
X-UUID: 5cb306fc32e44857b8753bef7d6e108d-20200929
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=Xw4yksfYd5fXr4ldEJmpjXvMZXzn7kJ9Yq/JIUXEB8A=;
        b=h1SlIvBrn9lBXhxKTcgPYwhHJZxQLtaLCov5kTs4Yczouf5oxuVdn56TKHwj8gU4DjZWTV2GOoeTt2pu/nuKD3jrnUefXTlk+zQn/9f+Aiu7rJmQWIcyzeincgwO/lNcVpEagEf5dubDANHY7+ldZ2O1XVEaZosC12Ys4hU5GTo=;
X-UUID: 5cb306fc32e44857b8753bef7d6e108d-20200929
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2137786154; Tue, 29 Sep 2020 14:09:13 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 29 Sep
 2020 14:09:12 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 29 Sep 2020 14:09:12 +0800
Message-ID: <1601359599.29336.49.camel@mhfsdcap03>
Subject: Re: [PATCH] dt-bindings: usb: add properties for hard wired devices
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Tue, 29 Sep 2020 14:06:39 +0800
In-Reply-To: <20200928181247.GA3008733@bogus>
References: <20200928063950.64722-1-chunfeng.yun@mediatek.com>
         <20200928181247.GA3008733@bogus>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: F8EFEE97F27DC64FB443E5232A9A52AC9BC551E88AE8507045FC3C02669586062000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIwLTA5LTI4IGF0IDEzOjEyIC0wNTAwLCBSb2IgSGVycmluZyB3cm90ZToNCj4g
T24gTW9uLCBTZXAgMjgsIDIwMjAgYXQgMDI6Mzk6NTBQTSArMDgwMCwgQ2h1bmZlbmcgWXVuIHdy
b3RlOg0KPiA+IEFkZCBzb21lIG9wdGlvbmFsIHByb3BlcnRpZXMgd2hpY2ggYXJlIG5lZWRlZCBm
b3IgaGFyZCB3aXJlZCBkZXZpY2VzDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogQ2h1bmZlbmcg
WXVuIDxjaHVuZmVuZy55dW5AbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICBEb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdXNiL3VzYi1oY2QueWFtbCB8IDExICsrKysrKysrKysr
DQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspDQo+ID4gDQo+ID4gZGlmZiAt
LWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy91c2IvdXNiLWhjZC55YW1s
IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3VzYi91c2ItaGNkLnlhbWwNCj4g
PiBpbmRleCA3MjYzYjdmMmI1MTAuLjExOTRhODI4ODdlNyAxMDA2NDQNCj4gPiAtLS0gYS9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdXNiL3VzYi1oY2QueWFtbA0KPiA+ICsrKyBi
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy91c2IvdXNiLWhjZC55YW1sDQo+ID4g
QEAgLTIyLDYgKzIyLDE3IEBAIHByb3BlcnRpZXM6DQo+ID4gICAgICBkZXNjcmlwdGlvbjoNCj4g
PiAgICAgICAgTmFtZSBzcGVjaWZpZXIgZm9yIHRoZSBVU0IgUEhZDQo+ID4gIA0KPiA+ICsgICIj
YWRkcmVzcy1jZWxscyI6DQo+ID4gKyAgICBjb25zdDogMQ0KPiA+ICsNCj4gPiArICAiI3NpemUt
Y2VsbHMiOg0KPiA+ICsgICAgY29uc3Q6IDANCj4gPiArDQo+ID4gK3BhdHRlcm5Qcm9wZXJ0aWVz
Og0KPiA+ICsgICJeaHVifGRldmljZUBbMC05YS1mXSskIjoNCj4gDQo+IENvdWxkIGJlIGFueSBj
bGFzcyBvZiBkZXZpY2UsIHNvICdAWzAtOWEtZl0rJCcNCllvdSBtZWFuIHdlIHdpbGwgdXNlIGRp
ZmZlcmVudCBzdGFuZGFyZCBub2RlIG5hbWUgZm9yIGVhY2ggdXNiIGNsYXNzPw0KZS5nLg0KVXNl
ICdldGhlcm5ldEAqJyBmb3IgYSB1c2IgZXRoZXJuZXQgYWRhcHRlciwgYW5kIHVzZSAnY2FtZXJh
QConIGZvciBhDQp1c2IgY2FtZXJhIHNlbnNvcj8NCg0KPiANCj4gPiArICAgIHR5cGU6IG9iamVj
dA0KPiA+ICsgICAgZGVzY3JpcHRpb246IFRoZSBoYXJkIHdpcmVkIFVTQiBkZXZpY2VzLiBTZWUg
dXNiL3VzYi1kZXZpY2UudHh0DQo+IA0KPiBJZGVhbGx5LCB3ZSdkIGNvbnZlcnQgdXNiLWRldmlj
ZS50eHQgdG8gc2NoZW1hIGFuZCByZWZlcmVuY2UgaXQgaGVyZS4NCk9rLCBJJ2xsIHRyeSB0byBk
byBpdC4NCg0KQlRXOiBEb2VzIHRoZSBjb21wYXRpYmxlIHN1cHBvcnQgcGF0dGVybj8gSXMgdGhl
cmUgYW55IGV4YW1wbGUgSSBjYW4NCnJlZmVyIHRvPw0KDQpUaGFua3MNCg0KPiANCj4gPiArDQo+
ID4gIGV4YW1wbGVzOg0KPiA+ICAgIC0gfA0KPiA+ICAgICAgdXNiIHsNCj4gPiAtLSANCj4gPiAy
LjE4LjANCg0K


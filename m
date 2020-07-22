Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C51A4228F22
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jul 2020 06:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbgGVE0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jul 2020 00:26:08 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:64366 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726607AbgGVE0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 00:26:08 -0400
X-UUID: 2baed5a44c8c40ec9aa0a3e70e250e44-20200722
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=GWVeRuD9gmf3IP/ZtIdGMOtS8Q7B5XBZWmUJ38WKNSo=;
        b=QdycRie8uOFBxVVTNFzc3xxme+2QFN/eSv60cy7c+ilznZ453tMfy+EDT73Syb5YsHFIaB/hcE2wy99dHsKl3W9z8BDXI8d+WULis4IHHwwkgDmGKpPMYTN+KMeXGhG5iPingvi1u95ntDpIUuS3ZUfJYwQpSYetL1RG29G0j7w=;
X-UUID: 2baed5a44c8c40ec9aa0a3e70e250e44-20200722
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <hsin-hsiung.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 347078801; Wed, 22 Jul 2020 12:26:03 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 22 Jul 2020 12:26:01 +0800
Received: from [172.21.77.4] (172.21.77.4) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 22 Jul 2020 12:26:01 +0800
Message-ID: <1595391961.8456.1.camel@mtksdaap41>
Subject: Re: [PATCH 3/3] soc: mediatek: pwrap: add pwrap driver for
 MT6873/8192 SoCs
From:   Hsin-hsiung Wang <hsin-hsiung.wang@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Argus Lin <argus.lin@mediatek.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <srv_heupstream@mediatek.com>
Date:   Wed, 22 Jul 2020 12:26:01 +0800
In-Reply-To: <e80b2e38-1324-a038-5647-6f595381ba47@gmail.com>
References: <1594720432-19586-1-git-send-email-hsin-hsiung.wang@mediatek.com>
         <1594720432-19586-4-git-send-email-hsin-hsiung.wang@mediatek.com>
         <e80b2e38-1324-a038-5647-6f595381ba47@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCk9uIFdlZCwgMjAyMC0wNy0yMiBhdCAwMDo1MSArMDIwMCwgTWF0dGhpYXMgQnJ1Z2dl
ciB3cm90ZToNCj4gDQo+IE9uIDE0LzA3LzIwMjAgMTE6NTMsIEhzaW4tSHNpdW5nIFdhbmcgd3Jv
dGU6DQo+ID4gTVQ2ODczLzgxOTIgYXJlIGhpZ2hseSBpbnRlZ3JhdGVkIFNvQ3MgYW5kIHVzZSBQ
TUlDX01UNjM1OSBmb3INCj4gPiBwb3dlciBtYW5hZ2VtZW50LiBUaGlzIHBhdGNoIGFkZHMgcHdy
YXAgbWFzdGVyIGRyaXZlciB0bw0KPiA+IGFjY2VzcyBQTUlDX01UNjM1OS4NCj4gPiANCj4gPiBT
aWduZWQtb2ZmLWJ5OiBIc2luLUhzaXVuZyBXYW5nIDxoc2luLWhzaXVuZy53YW5nQG1lZGlhdGVr
LmNvbT4NCj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMvc29jL21lZGlhdGVrL210ay1wbWljLXdyYXAu
YyB8IDk4ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLQ0KPiA+ICAgMSBmaWxl
IGNoYW5nZWQsIDg3IGluc2VydGlvbnMoKyksIDExIGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstcG1pYy13cmFwLmMgYi9kcml2ZXJz
L3NvYy9tZWRpYXRlay9tdGstcG1pYy13cmFwLmMNCj4gPiBpbmRleCBjODk3MjA1Li42ZTdmNzk2
ZiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstcG1pYy13cmFwLmMN
Cj4gPiArKysgYi9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstcG1pYy13cmFwLmMNCj4gPiBAQCAt
MjQsMTEgKzI0LDEzIEBADQo+ID4gICAjZGVmaW5lIFBXUkFQX01UODEzNV9CUklER0VfV0RUX1NS
Q19FTgkJMHg1NA0KPiA+ICAgDQo+ID4gICAvKiBtYWNybyBmb3Igd3JhcHBlciBzdGF0dXMgKi8N
Cj4gPiArI2RlZmluZSBQV1JBUF9HRVRfU1dJTkZfMl9GU00oeCkJKCgoeCkgPj4gMSkgJiAweDAw
MDAwMDA3KQ0KPiA+ICAgI2RlZmluZSBQV1JBUF9HRVRfV0FDU19SREFUQSh4KQkJKCgoeCkgPj4g
MCkgJiAweDAwMDBmZmZmKQ0KPiA+ICAgI2RlZmluZSBQV1JBUF9HRVRfV0FDU19GU00oeCkJCSgo
KHgpID4+IDE2KSAmIDB4MDAwMDAwMDcpDQo+ID4gICAjZGVmaW5lIFBXUkFQX0dFVF9XQUNTX1JF
USh4KQkJKCgoeCkgPj4gMTkpICYgMHgwMDAwMDAwMSkNCj4gPiAgICNkZWZpbmUgUFdSQVBfU1RB
VEVfU1lOQ19JRExFMAkJQklUKDIwKQ0KPiA+ICAgI2RlZmluZSBQV1JBUF9TVEFURV9JTklUX0RP
TkUwCQlCSVQoMjEpDQo+ID4gKyNkZWZpbmUgUFdSQVBfU1RBVEVfSU5JVF9ET05FMQkJQklUKDE1
KQ0KPiA+ICAgDQo+ID4gICAvKiBtYWNybyBmb3IgV0FDUyBGU00gKi8NCj4gPiAgICNkZWZpbmUg
UFdSQVBfV0FDU19GU01fSURMRQkJMHgwMA0KPiA+IEBAIC03NCw2ICs3Niw3IEBADQo+ID4gICAj
ZGVmaW5lIFBXUkFQX0NBUF9EQ00JCUJJVCgyKQ0KPiA+ICAgI2RlZmluZSBQV1JBUF9DQVBfSU5U
MV9FTglCSVQoMykNCj4gPiAgICNkZWZpbmUgUFdSQVBfQ0FQX1dEVF9TUkMxCUJJVCg0KQ0KPiA+
ICsjZGVmaW5lIFBXUkFQX0NBUF9BUkIJCUJJVCg1KQ0KPiANCj4gVGhpcyBjb21taXQgc2hvdWxk
IGJlIHR3byBwYXRjaGVzIChhdCBsZWFzdCkuIE9uZSBhZGRpbmcgUFdSQVBfQ0FQX0FSQiBhbmQg
dGhlbiANCj4gYW5vdGhlciBvbmUgYWRkaW5nIE1UNjg3MyBzdXBwb3J0Lg0KPiANCj4gUmVnYXJk
cywNCj4gTWF0dGhpYXMNCj4gDQoNClRoYW5rcyBmb3IgdGhlIGNvbW1lbnQuIEkgd2lsbCB1cGRh
dGUgaXQgaW4gbmV4dCBwYXRjaC4NCg0KPiA+ICAgDQo+ID4gICAvKiBkZWZpbmVzIGZvciBzbGF2
ZSBkZXZpY2Ugd3JhcHBlciByZWdpc3RlcnMgKi8NCj4gPiAgIGVudW0gZGV3X3JlZ3Mgew0KDQpb
RGVsZXRlXQ0KDQo=


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5825D2C36DA
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 03:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726929AbgKYCdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 21:33:36 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:64514 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725952AbgKYCdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 21:33:36 -0500
X-UUID: cd64df1ea4064c21b8a4df535923749a-20201125
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=d3nr/xPB4/Ytmie+cSNJY9sU92H7/I+2d3g8d6Ae3Dw=;
        b=hdzdf2N1UKhfpIXPW571fE+ZE//9Evis6CiDaxJgUPiMzjrsLzuMtFINiUrTY9QUDO76yXpEhdiy4C0VyAyvFHtr3DWvsza01ng2Ua33CGPVXfFSN03QF3Ox8Go45ksVec3KoJVFq8DfCVjx/vjEug67BxMfyqkOm5oCNTzeQNg=;
X-UUID: cd64df1ea4064c21b8a4df535923749a-20201125
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2029650414; Wed, 25 Nov 2020 10:33:30 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 25 Nov
 2020 10:33:30 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 25 Nov 2020 10:33:29 +0800
Message-ID: <1606271609.7284.2.camel@mhfsdcap03>
Subject: Re: [PATCH] usb: mtu3: replace spin_lock_irqsave by spin_lock in
 hard IRQ
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Tian Tao <tiantao6@hisilicon.com>
CC:     <gregkh@linuxfoundation.org>, <matthias.bgg@gmail.com>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Date:   Wed, 25 Nov 2020 10:33:29 +0800
In-Reply-To: <1605515682-23771-1-git-send-email-tiantao6@hisilicon.com>
References: <1605515682-23771-1-git-send-email-tiantao6@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 38AEA4F68145BA0AE654977F218C7D5F37B2304FC5A015F89CA984A57FCCDBFB2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVGFvLA0KT24gTW9uLCAyMDIwLTExLTE2IGF0IDE2OjM0ICswODAwLCBUaWFuIFRhbyB3cm90
ZToNCj4gVGhlIGNvZGUgaGFzIGJlZW4gaW4gYSBpcnEtZGlzYWJsZWQgY29udGV4dCBzaW5jZSBp
dCBpcyBoYXJkIElSUS4gVGhlcmUNCj4gaXMgbm8gbmVjZXNzaXR5IHRvIGRvIGl0IGFnYWluLg0K
PiANCj4gU2lnbmVkLW9mZi1ieTogVGlhbiBUYW8gPHRpYW50YW82QGhpc2lsaWNvbi5jb20+DQo+
IC0tLQ0KPiAgZHJpdmVycy91c2IvbXR1My9tdHUzX2NvcmUuYyB8IDUgKystLS0NCj4gIDEgZmls
ZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy91c2IvbXR1My9tdHUzX2NvcmUuYyBiL2RyaXZlcnMvdXNiL210dTMvbXR1
M19jb3JlLmMNCj4gaW5kZXggYjNiNDU5OS4uYTZkNzY4NCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVy
cy91c2IvbXR1My9tdHUzX2NvcmUuYw0KPiArKysgYi9kcml2ZXJzL3VzYi9tdHUzL210dTNfY29y
ZS5jDQo+IEBAIC03NDUsMTAgKzc0NSw5IEBAIHN0YXRpYyBpcnFyZXR1cm5fdCBtdHUzX3UyX2Nv
bW1vbl9pc3Ioc3RydWN0IG10dTMgKm10dSkNCj4gIHN0YXRpYyBpcnFyZXR1cm5fdCBtdHUzX2ly
cShpbnQgaXJxLCB2b2lkICpkYXRhKQ0KPiAgew0KPiAgCXN0cnVjdCBtdHUzICptdHUgPSAoc3Ry
dWN0IG10dTMgKilkYXRhOw0KPiAtCXVuc2lnbmVkIGxvbmcgZmxhZ3M7DQo+ICAJdTMyIGxldmVs
MTsNCj4gIA0KPiAtCXNwaW5fbG9ja19pcnFzYXZlKCZtdHUtPmxvY2ssIGZsYWdzKTsNCj4gKwlz
cGluX2xvY2soJm10dS0+bG9jayk7DQpTb3JyeSBmb3IgbGF0ZSByZXBseSwgSSBwcmVmZXIgdG8g
bGVhdmUgdGhlIGNvZGUgdW5jaGFuZ2VkLg0KDQpUaGFua3MNCg0KPiAgDQo+ICAJLyogVTNEX0xW
MUlTUiBpcyBSVSAqLw0KPiAgCWxldmVsMSA9IG10dTNfcmVhZGwobXR1LT5tYWNfYmFzZSwgVTNE
X0xWMUlTUik7DQo+IEBAIC03NjksNyArNzY4LDcgQEAgc3RhdGljIGlycXJldHVybl90IG10dTNf
aXJxKGludCBpcnEsIHZvaWQgKmRhdGEpDQo+ICAJaWYgKGxldmVsMSAmIFFNVV9JTlRSKQ0KPiAg
CQltdHUzX3FtdV9pc3IobXR1KTsNCj4gIA0KPiAtCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJm10
dS0+bG9jaywgZmxhZ3MpOw0KPiArCXNwaW5fdW5sb2NrKCZtdHUtPmxvY2spOw0KPiAgDQo+ICAJ
cmV0dXJuIElSUV9IQU5ETEVEOw0KPiAgfQ0KDQo=


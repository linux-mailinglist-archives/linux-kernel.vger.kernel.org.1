Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 844E92B7445
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 03:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbgKRCll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 21:41:41 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:47500 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725774AbgKRCll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 21:41:41 -0500
X-UUID: 3dcbb7d111ef483a845f226cd09a84d9-20201118
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=+WZEfb7k1YczY34xv0fToQ3dUxzEeZQPIUHuAbvFbuk=;
        b=P350qQqV1KteqSvrE2hxhSoVXCItho1t/zVls4ZcITHhiBvbfugiY3jcZtZfnth+nm7bHw40RJVQTbkxtGkTkj078s4ZQ5Jo1mok/xsYmblNqnabNlvf6BqhX00GSXTl0/TCAyjYVQCWsUqriEZVHh6lhd08IvtD5a88edRmQT8=;
X-UUID: 3dcbb7d111ef483a845f226cd09a84d9-20201118
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <yingjoe.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 267864660; Wed, 18 Nov 2020 10:41:36 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 18 Nov 2020 10:41:35 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 18 Nov 2020 10:41:34 +0800
Message-ID: <1605667293.8636.5.camel@mtksdaap41>
Subject: Re: [PATCH v5 14/24] clk: mediatek: Add MT8192 imp i2c wrapper
 clock support
From:   Yingjoe Chen <yingjoe.chen@mediatek.com>
To:     Weiyi Lu <weiyi.lu@mediatek.com>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <srv_heupstream@mediatek.com>
Date:   Wed, 18 Nov 2020 10:41:33 +0800
In-Reply-To: <1604887429-29445-15-git-send-email-weiyi.lu@mediatek.com>
References: <1604887429-29445-1-git-send-email-weiyi.lu@mediatek.com>
         <1604887429-29445-15-git-send-email-weiyi.lu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIwLTExLTA5IGF0IDEwOjAzICswODAwLCBXZWl5aSBMdSB3cm90ZToNCj4gQWRk
IE1UODE5MiBpbXAgaTJjIHdyYXBwZXIgY2xvY2sgcHJvdmlkZXINCj4gDQo+IFNpZ25lZC1vZmYt
Ynk6IFdlaXlpIEx1IDx3ZWl5aS5sdUBtZWRpYXRlay5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9j
bGsvbWVkaWF0ZWsvS2NvbmZpZyAgICAgICAgICAgICAgICAgICB8ICAgNiArKw0KPiAgZHJpdmVy
cy9jbGsvbWVkaWF0ZWsvTWFrZWZpbGUgICAgICAgICAgICAgICAgICB8ICAgMSArDQo+ICBkcml2
ZXJzL2Nsay9tZWRpYXRlay9jbGstbXQ4MTkyLWltcF9paWNfd3JhcC5jIHwgMTE5ICsrKysrKysr
KysrKysrKysrKysrKysrKysNCj4gIDMgZmlsZXMgY2hhbmdlZCwgMTI2IGluc2VydGlvbnMoKykN
Cj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2Nsay9tZWRpYXRlay9jbGstbXQ4MTkyLWlt
cF9paWNfd3JhcC5jDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jbGsvbWVkaWF0ZWsvS2Nv
bmZpZyBiL2RyaXZlcnMvY2xrL21lZGlhdGVrL0tjb25maWcNCj4gaW5kZXggZWI1NDlmOC4uOGFj
YzdkNiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9jbGsvbWVkaWF0ZWsvS2NvbmZpZw0KPiArKysg
Yi9kcml2ZXJzL2Nsay9tZWRpYXRlay9LY29uZmlnDQo+IEBAIC01MTUsNiArNTE1LDEyIEBAIGNv
bmZpZyBDT01NT05fQ0xLX01UODE5Ml9JTUdTWVMNCj4gIAloZWxwDQo+ICAJICBUaGlzIGRyaXZl
ciBzdXBwb3J0cyBNZWRpYVRlayBNVDgxOTIgaW1nc3lzIGFuZCBpbWdzeXMyIGNsb2Nrcy4NCj4g
IA0KPiArY29uZmlnIENPTU1PTl9DTEtfTVQ4MTkyX0lNUF9JSUNfV1JBUA0KPiArCWJvb2wgIkNs
b2NrIGRyaXZlciBmb3IgTWVkaWFUZWsgTVQ4MTkyIGltcF9paWNfd3JhcCINCj4gKwlkZXBlbmRz
IG9uIENPTU1PTl9DTEtfTVQ4MTkyDQo+ICsJaGVscA0KPiArCSAgVGhpcyBkcml2ZXIgc3VwcG9y
dHMgTWVkaWFUZWsgTVQ4MTkyIGltcF9paWNfd3JhcCBjbG9ja3MuDQo+ICsNCj4gIGNvbmZpZyBD
T01NT05fQ0xLX01UODUxNg0KPiAgCWJvb2wgIkNsb2NrIGRyaXZlciBmb3IgTWVkaWFUZWsgTVQ4
NTE2Ig0KPiAgCWRlcGVuZHMgb24gQVJDSF9NRURJQVRFSyB8fCBDT01QSUxFX1RFU1QNCg0KPC4u
Lj4NCg0KPiArDQo+ICtzdGF0aWMgc3RydWN0IHBsYXRmb3JtX2RyaXZlciBjbGtfbXQ4MTkyX2lt
cF9paWNfd3JhcF9kcnYgPSB7DQo+ICsJLnByb2JlID0gbXRrX2Nsa19zaW1wbGVfcHJvYmUsDQoN
Ckdvb2QgdG8gaGF2ZSB0aGlzIGdlbmVyaWMgcHJvYmUgZnVuY3Rpb24uIE5vdyBzZXZlcmFsIG10
ayBjbGsgZHJpdmVycw0KYXJlIGp1c3QgYSBmZXcgZGF0YS4NCg0KQnV0IHRoaXMgc2VyaWVzIHN0
aWxsIGFkZCA+MTAgY29uZmlncyBmb3IgbXQ4MTkyIGNsb2NrIGRyaXZlcnMuIFdoeSBkbw0Kd2Ug
bmVlZCBzZXBhcmF0ZSBjb25maWdzIGZvciBjbG9ja3Mgb2YgZGlmZmVyZW50IGRvbWFpbj8gSSBk
b24ndCB0aGluaw0KdGhleSBuZWVkIGxvdHMgb2YgcmVzb3VyY2UuIFdlIHNob3VsZCByZXZpZXcg
dGhlIHJhdGlvbmFsZSBhbmQgcmVkdWNlDQp0aGUgbnVtYmVycy4gDQoNCg0KSm9lLkMNCg0K


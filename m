Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D89142AAF0E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 03:09:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729232AbgKICJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 21:09:48 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:58255 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729124AbgKICJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 21:09:23 -0500
X-UUID: 188336fb9ad940e6a95966cac9edb1fc-20201109
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=d6l7X0D9mFaPMITY5GjptKADXM4I1L0bpxI3MpyN6Is=;
        b=HaH2Y7BzjBnE2f1/wY21MMk5Lw3aj+tH+ut7hKUl4w3XohVyVlDvYk2EgCk/8wNWqrmhVDwrHy3hsXJ+hu1EW/ps7augp/59DBSH8JZG/XQVozObbfY2M3Q4ln1cohPzEivwtgfhd0E1BM/0UHEeVgW15mFt3TU5E4Un8jOJk/Y=;
X-UUID: 188336fb9ad940e6a95966cac9edb1fc-20201109
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 676088100; Mon, 09 Nov 2020 10:03:52 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 9 Nov 2020 10:03:53 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 9 Nov 2020 10:03:52 +0800
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <srv_heupstream@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>
Subject: [PATCH v5 07/24] clk: mediatek: Fix asymmetrical PLL enable and disable control
Date:   Mon, 9 Nov 2020 10:03:32 +0800
Message-ID: <1604887429-29445-8-git-send-email-weiyi.lu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1604887429-29445-1-git-send-email-weiyi.lu@mediatek.com>
References: <1604887429-29445-1-git-send-email-weiyi.lu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SW4gZmFjdCwgdGhlIGVuX21hc2sgaXMgYSBjb21iaW5hdGlvbiBvZiBkaXZpZGVyIGVuYWJsZSBt
YXNrDQphbmQgcGxsIGVuYWJsZSBiaXQoYml0MCkuDQpCZWZvcmUgdGhpcyBwYXRjaCwgd2UgZW5h
YmxlZCBib3RoIGRpdmlkZXIgbWFzayBhbmQgYml0MCBpbiBwcmVwYXJlKCksDQpidXQgb25seSBj
bGVhcmVkIHRoZSBiaXQwIGluIHVucHJlcGFyZSgpLg0KSW4gdGhlIGZ1dHVyZSwgd2UgaG9wZSBl
bl9tYXNrIHdpbGwgb25seSBiZSB1c2VkIGFzIGRpdmlkZXIgZW5hYmxlIG1hc2suDQpUaGUgZW5h
YmxlIHJlZ2lzdGVyKENPTjApIHdpbGwgYmUgc2V0IGluIDIgc3RlcHM6DQpmaXJzdCBpcyBkaXZp
ZGVyIG1hc2ssIGFuZCB0aGVuIGJpdDAgZHVyaW5nIHByZXBhcmUoKSwgYW5kIHZpY2UgdmVyc2Eu
DQpCdXQgY29uc2lkZXJpbmcgYmFja3dhcmQgY29tcGF0aWJpbGl0eSwgYXQgdGhpcyBzdGFnZSB3
ZSBhbGxvdyBlbl9tYXNrDQp0byBiZSBhIGNvbWJpbmF0aW9uIG9yIGEgcHVyZSBkaXZpZGVyIGVu
YWJsZSBtYXNrLg0KQW5kIHRoZW4gd2Ugd2lsbCBtYWtlIGVuX21hc2sgYSBwdXJlIGRpdmlkZXIg
ZW5hYmxlIG1hc2sgaW4gYW5vdGhlcg0KZm9sbG93aW5nIHBhdGNoIHNlcmllcy4NCg0KU2lnbmVk
LW9mZi1ieTogV2VpeWkgTHUgPHdlaXlpLmx1QG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGRyaXZlcnMv
Y2xrL21lZGlhdGVrL2Nsay1wbGwuYyB8IDIwICsrKysrKysrKysrKysrKystLS0tDQogMSBmaWxl
IGNoYW5nZWQsIDE2IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQg
YS9kcml2ZXJzL2Nsay9tZWRpYXRlay9jbGstcGxsLmMgYi9kcml2ZXJzL2Nsay9tZWRpYXRlay9j
bGstcGxsLmMNCmluZGV4IGY0NDBmMmNkLi4xMWVkNWQxIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9j
bGsvbWVkaWF0ZWsvY2xrLXBsbC5jDQorKysgYi9kcml2ZXJzL2Nsay9tZWRpYXRlay9jbGstcGxs
LmMNCkBAIC0yMzgsNiArMjM4LDcgQEAgc3RhdGljIGludCBtdGtfcGxsX3ByZXBhcmUoc3RydWN0
IGNsa19odyAqaHcpDQogew0KIAlzdHJ1Y3QgbXRrX2Nsa19wbGwgKnBsbCA9IHRvX210a19jbGtf
cGxsKGh3KTsNCiAJdTMyIHI7DQorCXUzMiBkaXZfZW5fbWFzazsNCiANCiAJciA9IHJlYWRsKHBs
bC0+cHdyX2FkZHIpIHwgQ09OMF9QV1JfT047DQogCXdyaXRlbChyLCBwbGwtPnB3cl9hZGRyKTsN
CkBAIC0yNDcsMTAgKzI0OCwxNSBAQCBzdGF0aWMgaW50IG10a19wbGxfcHJlcGFyZShzdHJ1Y3Qg
Y2xrX2h3ICpodykNCiAJd3JpdGVsKHIsIHBsbC0+cHdyX2FkZHIpOw0KIAl1ZGVsYXkoMSk7DQog
DQotCXIgPSByZWFkbChwbGwtPmJhc2VfYWRkciArIFJFR19DT04wKTsNCi0JciB8PSBwbGwtPmRh
dGEtPmVuX21hc2s7DQorCXIgPSByZWFkbChwbGwtPmJhc2VfYWRkciArIFJFR19DT04wKSB8IENP
TjBfQkFTRV9FTjsNCiAJd3JpdGVsKHIsIHBsbC0+YmFzZV9hZGRyICsgUkVHX0NPTjApOw0KIA0K
KwlkaXZfZW5fbWFzayA9IHBsbC0+ZGF0YS0+ZW5fbWFzayAmIH5DT04wX0JBU0VfRU47DQorCWlm
IChkaXZfZW5fbWFzaykgew0KKwkJciA9IHJlYWRsKHBsbC0+YmFzZV9hZGRyICsgUkVHX0NPTjAp
IHwgZGl2X2VuX21hc2s7DQorCQl3cml0ZWwociwgcGxsLT5iYXNlX2FkZHIgKyBSRUdfQ09OMCk7
DQorCX0NCisNCiAJX19tdGtfcGxsX3R1bmVyX2VuYWJsZShwbGwpOw0KIA0KIAl1ZGVsYXkoMjAp
Ow0KQEAgLTI2OCw2ICsyNzQsNyBAQCBzdGF0aWMgdm9pZCBtdGtfcGxsX3VucHJlcGFyZShzdHJ1
Y3QgY2xrX2h3ICpodykNCiB7DQogCXN0cnVjdCBtdGtfY2xrX3BsbCAqcGxsID0gdG9fbXRrX2Ns
a19wbGwoaHcpOw0KIAl1MzIgcjsNCisJdTMyIGRpdl9lbl9tYXNrOw0KIA0KIAlpZiAocGxsLT5k
YXRhLT5mbGFncyAmIEhBVkVfUlNUX0JBUikgew0KIAkJciA9IHJlYWRsKHBsbC0+YmFzZV9hZGRy
ICsgUkVHX0NPTjApOw0KQEAgLTI3Nyw4ICsyODQsMTMgQEAgc3RhdGljIHZvaWQgbXRrX3BsbF91
bnByZXBhcmUoc3RydWN0IGNsa19odyAqaHcpDQogDQogCV9fbXRrX3BsbF90dW5lcl9kaXNhYmxl
KHBsbCk7DQogDQotCXIgPSByZWFkbChwbGwtPmJhc2VfYWRkciArIFJFR19DT04wKTsNCi0JciAm
PSB+Q09OMF9CQVNFX0VOOw0KKwlkaXZfZW5fbWFzayA9IHBsbC0+ZGF0YS0+ZW5fbWFzayAmIH5D
T04wX0JBU0VfRU47DQorCWlmIChkaXZfZW5fbWFzaykgew0KKwkJciA9IHJlYWRsKHBsbC0+YmFz
ZV9hZGRyICsgUkVHX0NPTjApICYgfmRpdl9lbl9tYXNrOw0KKwkJd3JpdGVsKHIsIHBsbC0+YmFz
ZV9hZGRyICsgUkVHX0NPTjApOw0KKwl9DQorDQorCXIgPSByZWFkbChwbGwtPmJhc2VfYWRkciAr
IFJFR19DT04wKSAmIH5DT04wX0JBU0VfRU47DQogCXdyaXRlbChyLCBwbGwtPmJhc2VfYWRkciAr
IFJFR19DT04wKTsNCiANCiAJciA9IHJlYWRsKHBsbC0+cHdyX2FkZHIpIHwgQ09OMF9JU09fRU47
DQotLSANCjEuOC4xLjEuZGlydHkNCg==


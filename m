Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01D331E6811
	for <lists+linux-kernel@lfdr.de>; Thu, 28 May 2020 19:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405368AbgE1RFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 May 2020 13:05:19 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:31229 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2405191AbgE1RFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 13:05:15 -0400
X-UUID: 292e1fd87dec4704a1204d43386f66b4-20200529
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=D+dXiJm3APaX+tyDPhHiGjNPGNdy177jnTfCoMxdsUw=;
        b=Lq0CgPByFfW5Typs9hswM3N6rE9eK5Snih8E9g4jpe+JdtGlTzhLBGjYM4APwtKzr9/g86CXb+NV7ShsDyHl5UrgMbgHpcbc62wGnTUZ4sx+JAUhj0/fukylbZz5KArZxR3ZKD0WewuiZh12PrWhYwiRzDm3QAgURdDqaWzh2dA=;
X-UUID: 292e1fd87dec4704a1204d43386f66b4-20200529
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1406105919; Fri, 29 May 2020 01:05:11 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 29 May 2020 01:05:08 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 29 May 2020 01:05:08 +0800
From:   Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>, <dri-devel@lists.freedesktop.org>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        HS Liao <hs.liao@mediatek.com>,
        Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>
Subject: [PATCH v6 04/16] mailbox: mediatek: cmdq: clear task in channel before shutdown
Date:   Fri, 29 May 2020 01:04:40 +0800
Message-ID: <1590685491-17107-6-git-send-email-dennis-yc.hsieh@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1590685491-17107-1-git-send-email-dennis-yc.hsieh@mediatek.com>
References: <1590685491-17107-1-git-send-email-dennis-yc.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RG8gc3VjY2VzcyBjYWxsYmFjayBpbiBjaGFubmVsIHdoZW4gc2h1dGRvd24uIEZvciB0aG9zZSB0
YXNrIG5vdCBmaW5pc2gsDQpjYWxsYmFjayB3aXRoIGVycm9yIGNvZGUgdGh1cyBjbGllbnQgaGFz
IGNoYW5jZSB0byBjbGVhbnVwIG9yIHJlc2V0Lg0KDQpTaWduZWQtb2ZmLWJ5OiBEZW5uaXMgWUMg
SHNpZWggPGRlbm5pcy15Yy5oc2llaEBtZWRpYXRlay5jb20+DQpSZXZpZXdlZC1ieTogQ0sgSHUg
PGNrLmh1QG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGRyaXZlcnMvbWFpbGJveC9tdGstY21kcS1tYWls
Ym94LmMgfCAzOCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCiAxIGZpbGUgY2hhbmdl
ZCwgMzggaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9tYWlsYm94L210ay1j
bWRxLW1haWxib3guYyBiL2RyaXZlcnMvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmMNCmluZGV4
IDk5OTRhYzk0MjZkNi4uYjU2ZDM0MGM4OTgyIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9tYWlsYm94
L210ay1jbWRxLW1haWxib3guYw0KKysrIGIvZHJpdmVycy9tYWlsYm94L210ay1jbWRxLW1haWxi
b3guYw0KQEAgLTM4Nyw2ICszODcsMTIgQEAgc3RhdGljIGludCBjbWRxX21ib3hfc2VuZF9kYXRh
KHN0cnVjdCBtYm94X2NoYW4gKmNoYW4sIHZvaWQgKmRhdGEpDQogDQogCWlmIChsaXN0X2VtcHR5
KCZ0aHJlYWQtPnRhc2tfYnVzeV9saXN0KSkgew0KIAkJV0FSTl9PTihjbGtfZW5hYmxlKGNtZHEt
PmNsb2NrKSA8IDApOw0KKwkJLyoNCisJCSAqIFRoZSB0aHJlYWQgcmVzZXQgd2lsbCBjbGVhciB0
aHJlYWQgcmVsYXRlZCByZWdpc3RlciB0byAwLA0KKwkJICogaW5jbHVkaW5nIHBjLCBlbmQsIHBy
aW9yaXR5LCBpcnEsIHN1c3BlbmQgYW5kIGVuYWJsZS4gVGh1cw0KKwkJICogc2V0IENNRFFfVEhS
X0VOQUJMRUQgdG8gQ01EUV9USFJfRU5BQkxFX1RBU0sgd2lsbCBlbmFibGUNCisJCSAqIHRocmVh
ZCBhbmQgbWFrZSBpdCBydW5uaW5nLg0KKwkJICovDQogCQlXQVJOX09OKGNtZHFfdGhyZWFkX3Jl
c2V0KGNtZHEsIHRocmVhZCkgPCAwKTsNCiANCiAJCXdyaXRlbCh0YXNrLT5wYV9iYXNlID4+IGNt
ZHEtPnNoaWZ0X3BhLA0KQEAgLTQ1MCw2ICs0NTYsMzggQEAgc3RhdGljIGludCBjbWRxX21ib3hf
c3RhcnR1cChzdHJ1Y3QgbWJveF9jaGFuICpjaGFuKQ0KIA0KIHN0YXRpYyB2b2lkIGNtZHFfbWJv
eF9zaHV0ZG93bihzdHJ1Y3QgbWJveF9jaGFuICpjaGFuKQ0KIHsNCisJc3RydWN0IGNtZHFfdGhy
ZWFkICp0aHJlYWQgPSAoc3RydWN0IGNtZHFfdGhyZWFkICopY2hhbi0+Y29uX3ByaXY7DQorCXN0
cnVjdCBjbWRxICpjbWRxID0gZGV2X2dldF9kcnZkYXRhKGNoYW4tPm1ib3gtPmRldik7DQorCXN0
cnVjdCBjbWRxX3Rhc2sgKnRhc2ssICp0bXA7DQorCXVuc2lnbmVkIGxvbmcgZmxhZ3M7DQorDQor
CXNwaW5fbG9ja19pcnFzYXZlKCZ0aHJlYWQtPmNoYW4tPmxvY2ssIGZsYWdzKTsNCisJaWYgKGxp
c3RfZW1wdHkoJnRocmVhZC0+dGFza19idXN5X2xpc3QpKQ0KKwkJZ290byBkb25lOw0KKw0KKwlX
QVJOX09OKGNtZHFfdGhyZWFkX3N1c3BlbmQoY21kcSwgdGhyZWFkKSA8IDApOw0KKw0KKwkvKiBt
YWtlIHN1cmUgZXhlY3V0ZWQgdGFza3MgaGF2ZSBzdWNjZXNzIGNhbGxiYWNrICovDQorCWNtZHFf
dGhyZWFkX2lycV9oYW5kbGVyKGNtZHEsIHRocmVhZCk7DQorCWlmIChsaXN0X2VtcHR5KCZ0aHJl
YWQtPnRhc2tfYnVzeV9saXN0KSkNCisJCWdvdG8gZG9uZTsNCisNCisJbGlzdF9mb3JfZWFjaF9l
bnRyeV9zYWZlKHRhc2ssIHRtcCwgJnRocmVhZC0+dGFza19idXN5X2xpc3QsDQorCQkJCSBsaXN0
X2VudHJ5KSB7DQorCQljbWRxX3Rhc2tfZXhlY19kb25lKHRhc2ssIENNRFFfQ0JfRVJST1IpOw0K
KwkJa2ZyZWUodGFzayk7DQorCX0NCisNCisJY21kcV90aHJlYWRfZGlzYWJsZShjbWRxLCB0aHJl
YWQpOw0KKwljbGtfZGlzYWJsZShjbWRxLT5jbG9jayk7DQorZG9uZToNCisJLyoNCisJICogVGhl
IHRocmVhZC0+dGFza19idXN5X2xpc3QgZW1wdHkgbWVhbnMgdGhyZWFkIGFscmVhZHkgZGlzYWJs
ZS4gVGhlDQorCSAqIGNtZHFfbWJveF9zZW5kX2RhdGEoKSBhbHdheXMgcmVzZXQgdGhyZWFkIHdo
aWNoIGNsZWFyIGRpc2FibGUgYW5kDQorCSAqIHN1c3BlbmQgc3RhdHVlIHdoZW4gZmlyc3QgcGt0
IHNlbmQgdG8gY2hhbm5lbCwgc28gdGhlcmUgaXMgbm8gbmVlZA0KKwkgKiB0byBkbyBhbnkgb3Bl
cmF0aW9uIGhlcmUsIG9ubHkgdW5sb2NrIGFuZCBsZWF2ZS4NCisJICovDQorCXNwaW5fdW5sb2Nr
X2lycXJlc3RvcmUoJnRocmVhZC0+Y2hhbi0+bG9jaywgZmxhZ3MpOw0KIH0NCiANCiBzdGF0aWMg
Y29uc3Qgc3RydWN0IG1ib3hfY2hhbl9vcHMgY21kcV9tYm94X2NoYW5fb3BzID0gew0KLS0gDQoy
LjE4LjANCg==


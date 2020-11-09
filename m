Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD9F2AAEEE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 03:04:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729126AbgKICEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 21:04:08 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:57267 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729074AbgKICEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 21:04:04 -0500
X-UUID: 066baf9ac06942e1b7c69b9bd1d765af-20201109
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Fr/oAjVsUXoh2uMqZgXoIP07p10O74AAWu3DUCs8Ooc=;
        b=ZMOYBcLE1pvquTTtlgNErmcqPYLpQTsY0V3LTdkfCfc+kSRG6LL7uOiJicNY85zYnWhQu27MYJW+ML1N5dsT5CqUJ+lPAgKME0aR9s7p8A3Uh1qnJcb4ukbU4cdFeOrvnv12aqqjQPUxAam+995hY6hKYcTenpcVlQebVYtKjsk=;
X-UUID: 066baf9ac06942e1b7c69b9bd1d765af-20201109
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 773572077; Mon, 09 Nov 2020 10:03:53 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 9 Nov 2020 10:03:53 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 9 Nov 2020 10:03:53 +0800
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <srv_heupstream@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>
Subject: [PATCH v5 13/24] clk: mediatek: Add MT8192 imgsys clock support
Date:   Mon, 9 Nov 2020 10:03:38 +0800
Message-ID: <1604887429-29445-14-git-send-email-weiyi.lu@mediatek.com>
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

QWRkIE1UODE5MiBpbWdzeXMgYW5kIGltZ3N5czIgY2xvY2sgcHJvdmlkZXJzDQoNClNpZ25lZC1v
ZmYtYnk6IFdlaXlpIEx1IDx3ZWl5aS5sdUBtZWRpYXRlay5jb20+DQotLS0NCiBkcml2ZXJzL2Ns
ay9tZWRpYXRlay9LY29uZmlnICAgICAgICAgIHwgIDYgKysrDQogZHJpdmVycy9jbGsvbWVkaWF0
ZWsvTWFrZWZpbGUgICAgICAgICB8ICAxICsNCiBkcml2ZXJzL2Nsay9tZWRpYXRlay9jbGstbXQ4
MTkyLWltZy5jIHwgNzAgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCiAzIGZp
bGVzIGNoYW5nZWQsIDc3IGluc2VydGlvbnMoKykNCiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVy
cy9jbGsvbWVkaWF0ZWsvY2xrLW10ODE5Mi1pbWcuYw0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9j
bGsvbWVkaWF0ZWsvS2NvbmZpZyBiL2RyaXZlcnMvY2xrL21lZGlhdGVrL0tjb25maWcNCmluZGV4
IGE3NWI3ZWMuLmViNTQ5ZjggMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2Nsay9tZWRpYXRlay9LY29u
ZmlnDQorKysgYi9kcml2ZXJzL2Nsay9tZWRpYXRlay9LY29uZmlnDQpAQCAtNTA5LDYgKzUwOSwx
MiBAQCBjb25maWcgQ09NTU9OX0NMS19NVDgxOTJfQ0FNU1lTDQogCWhlbHANCiAJICBUaGlzIGRy
aXZlciBzdXBwb3J0cyBNZWRpYVRlayBNVDgxOTIgY2Ftc3lzIGFuZCBjYW1zeXNfcmF3IGNsb2Nr
cy4NCiANCitjb25maWcgQ09NTU9OX0NMS19NVDgxOTJfSU1HU1lTDQorCWJvb2wgIkNsb2NrIGRy
aXZlciBmb3IgTWVkaWFUZWsgTVQ4MTkyIGltZ3N5cyINCisJZGVwZW5kcyBvbiBDT01NT05fQ0xL
X01UODE5Mg0KKwloZWxwDQorCSAgVGhpcyBkcml2ZXIgc3VwcG9ydHMgTWVkaWFUZWsgTVQ4MTky
IGltZ3N5cyBhbmQgaW1nc3lzMiBjbG9ja3MuDQorDQogY29uZmlnIENPTU1PTl9DTEtfTVQ4NTE2
DQogCWJvb2wgIkNsb2NrIGRyaXZlciBmb3IgTWVkaWFUZWsgTVQ4NTE2Ig0KIAlkZXBlbmRzIG9u
IEFSQ0hfTUVESUFURUsgfHwgQ09NUElMRV9URVNUDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9jbGsv
bWVkaWF0ZWsvTWFrZWZpbGUgYi9kcml2ZXJzL2Nsay9tZWRpYXRlay9NYWtlZmlsZQ0KaW5kZXgg
OTRiZjdhMC4uOTEzOTJjYiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvY2xrL21lZGlhdGVrL01ha2Vm
aWxlDQorKysgYi9kcml2ZXJzL2Nsay9tZWRpYXRlay9NYWtlZmlsZQ0KQEAgLTcwLDUgKzcwLDYg
QEAgb2JqLSQoQ09ORklHX0NPTU1PTl9DTEtfTVQ4MTgzX1ZFTkNTWVMpICs9IGNsay1tdDgxODMt
dmVuYy5vDQogb2JqLSQoQ09ORklHX0NPTU1PTl9DTEtfTVQ4MTkyKSArPSBjbGstbXQ4MTkyLm8N
CiBvYmotJChDT05GSUdfQ09NTU9OX0NMS19NVDgxOTJfQVVEU1lTKSArPSBjbGstbXQ4MTkyLWF1
ZC5vDQogb2JqLSQoQ09ORklHX0NPTU1PTl9DTEtfTVQ4MTkyX0NBTVNZUykgKz0gY2xrLW10ODE5
Mi1jYW0ubw0KK29iai0kKENPTkZJR19DT01NT05fQ0xLX01UODE5Ml9JTUdTWVMpICs9IGNsay1t
dDgxOTItaW1nLm8NCiBvYmotJChDT05GSUdfQ09NTU9OX0NMS19NVDg1MTYpICs9IGNsay1tdDg1
MTYubw0KIG9iai0kKENPTkZJR19DT01NT05fQ0xLX01UODUxNl9BVURTWVMpICs9IGNsay1tdDg1
MTYtYXVkLm8NCmRpZmYgLS1naXQgYS9kcml2ZXJzL2Nsay9tZWRpYXRlay9jbGstbXQ4MTkyLWlt
Zy5jIGIvZHJpdmVycy9jbGsvbWVkaWF0ZWsvY2xrLW10ODE5Mi1pbWcuYw0KbmV3IGZpbGUgbW9k
ZSAxMDA2NDQNCmluZGV4IDAwMDAwMDAuLjI0YjQxNDMNCi0tLSAvZGV2L251bGwNCisrKyBiL2Ry
aXZlcnMvY2xrL21lZGlhdGVrL2Nsay1tdDgxOTItaW1nLmMNCkBAIC0wLDAgKzEsNzAgQEANCisv
LyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vbmx5DQorLy8NCisvLyBDb3B5cmln
aHQgKGMpIDIwMjAgTWVkaWFUZWsgSW5jLg0KKy8vIEF1dGhvcjogV2VpeWkgTHUgPHdlaXlpLmx1
QG1lZGlhdGVrLmNvbT4NCisNCisjaW5jbHVkZSA8bGludXgvY2xrLXByb3ZpZGVyLmg+DQorI2lu
Y2x1ZGUgPGxpbnV4L29mX2RldmljZS5oPg0KKyNpbmNsdWRlIDxsaW51eC9wbGF0Zm9ybV9kZXZp
Y2UuaD4NCisNCisjaW5jbHVkZSAiY2xrLW10ay5oIg0KKyNpbmNsdWRlICJjbGstZ2F0ZS5oIg0K
Kw0KKyNpbmNsdWRlIDxkdC1iaW5kaW5ncy9jbG9jay9tdDgxOTItY2xrLmg+DQorDQorc3RhdGlj
IGNvbnN0IHN0cnVjdCBtdGtfZ2F0ZV9yZWdzIGltZ19jZ19yZWdzID0gew0KKwkuc2V0X29mcyA9
IDB4NCwNCisJLmNscl9vZnMgPSAweDgsDQorCS5zdGFfb2ZzID0gMHgwLA0KK307DQorDQorI2Rl
ZmluZSBHQVRFX0lNRyhfaWQsIF9uYW1lLCBfcGFyZW50LCBfc2hpZnQpCVwNCisJR0FURV9NVEso
X2lkLCBfbmFtZSwgX3BhcmVudCwgJmltZ19jZ19yZWdzLCBfc2hpZnQsICZtdGtfY2xrX2dhdGVf
b3BzX3NldGNscikNCisNCitzdGF0aWMgY29uc3Qgc3RydWN0IG10a19nYXRlIGltZ19jbGtzW10g
PSB7DQorCUdBVEVfSU1HKENMS19JTUdfTEFSQjksICJpbWdfbGFyYjkiLCAiaW1nMV9zZWwiLCAw
KSwNCisJR0FURV9JTUcoQ0xLX0lNR19MQVJCMTAsICJpbWdfbGFyYjEwIiwgImltZzFfc2VsIiwg
MSksDQorCUdBVEVfSU1HKENMS19JTUdfRElQLCAiaW1nX2RpcCIsICJpbWcxX3NlbCIsIDIpLA0K
KwlHQVRFX0lNRyhDTEtfSU1HX0dBTFMsICJpbWdfZ2FscyIsICJpbWcxX3NlbCIsIDEyKSwNCit9
Ow0KKw0KK3N0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2dhdGUgaW1nMl9jbGtzW10gPSB7DQorCUdB
VEVfSU1HKENMS19JTUcyX0xBUkIxMSwgImltZzJfbGFyYjExIiwgImltZzFfc2VsIiwgMCksDQor
CUdBVEVfSU1HKENMS19JTUcyX0xBUkIxMiwgImltZzJfbGFyYjEyIiwgImltZzFfc2VsIiwgMSks
DQorCUdBVEVfSU1HKENMS19JTUcyX01GQiwgImltZzJfbWZiIiwgImltZzFfc2VsIiwgNiksDQor
CUdBVEVfSU1HKENMS19JTUcyX1dQRSwgImltZzJfd3BlIiwgImltZzFfc2VsIiwgNyksDQorCUdB
VEVfSU1HKENMS19JTUcyX01TUywgImltZzJfbXNzIiwgImltZzFfc2VsIiwgOCksDQorCUdBVEVf
SU1HKENMS19JTUcyX0dBTFMsICJpbWcyX2dhbHMiLCAiaW1nMV9zZWwiLCAxMiksDQorfTsNCisN
CitzdGF0aWMgY29uc3Qgc3RydWN0IG10a19jbGtfZGVzYyBpbWdfZGVzYyA9IHsNCisJLmNsa3Mg
PSBpbWdfY2xrcywNCisJLm51bV9jbGtzID0gQVJSQVlfU0laRShpbWdfY2xrcyksDQorfTsNCisN
CitzdGF0aWMgY29uc3Qgc3RydWN0IG10a19jbGtfZGVzYyBpbWcyX2Rlc2MgPSB7DQorCS5jbGtz
ID0gaW1nMl9jbGtzLA0KKwkubnVtX2Nsa3MgPSBBUlJBWV9TSVpFKGltZzJfY2xrcyksDQorfTsN
CisNCitzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBvZl9tYXRjaF9jbGtfbXQ4MTky
X2ltZ1tdID0gew0KKwl7DQorCQkuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxOTItaW1nc3lz
IiwNCisJCS5kYXRhID0gJmltZ19kZXNjLA0KKwl9LCB7DQorCQkuY29tcGF0aWJsZSA9ICJtZWRp
YXRlayxtdDgxOTItaW1nc3lzMiIsDQorCQkuZGF0YSA9ICZpbWcyX2Rlc2MsDQorCX0sIHsNCisJ
CS8qIHNlbnRpbmVsICovDQorCX0NCit9Ow0KKw0KK3N0YXRpYyBzdHJ1Y3QgcGxhdGZvcm1fZHJp
dmVyIGNsa19tdDgxOTJfaW1nX2RydiA9IHsNCisJLnByb2JlID0gbXRrX2Nsa19zaW1wbGVfcHJv
YmUsDQorCS5kcml2ZXIgPSB7DQorCQkubmFtZSA9ICJjbGstbXQ4MTkyLWltZyIsDQorCQkub2Zf
bWF0Y2hfdGFibGUgPSBvZl9tYXRjaF9jbGtfbXQ4MTkyX2ltZywNCisJfSwNCit9Ow0KKw0KK2J1
aWx0aW5fcGxhdGZvcm1fZHJpdmVyKGNsa19tdDgxOTJfaW1nX2Rydik7DQotLSANCjEuOC4xLjEu
ZGlydHkNCg==


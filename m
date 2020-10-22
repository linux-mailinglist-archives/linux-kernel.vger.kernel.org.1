Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB505295ECE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 14:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2898295AbgJVMnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 08:43:16 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:44200 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2439613AbgJVMnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 08:43:14 -0400
X-UUID: 11aba410b8af40e9b0ca4eddf9fecd24-20201022
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=CrkNA8CWgdGfdzmNmP0Mx4SbrCnJU5z3LzWlm7srplY=;
        b=i8sosWgeybPWcU/PhlBMxpkhE0BJwMwr9TrgWaRWMRYHtxucf9AvwmCk63IHja+iCqvIdbW6VMA3hApHZvag1deNZnpEX8zo8Km8iKsvPBzoRr+EPDGK1szqlB6My9Kt1VBERPJrF7dQ+94kHiiwDkUOzZ7ed0wA3LvNUez8r2I=;
X-UUID: 11aba410b8af40e9b0ca4eddf9fecd24-20201022
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 30453470; Thu, 22 Oct 2020 20:37:55 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 22 Oct 2020 20:37:53 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 22 Oct 2020 20:37:53 +0800
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <srv_heupstream@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>
Subject: [PATCH v4 17/34] clk: mediatek: Add MT8192 imgsys clock support
Date:   Thu, 22 Oct 2020 20:37:10 +0800
Message-ID: <1603370247-30437-18-git-send-email-weiyi.lu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1603370247-30437-1-git-send-email-weiyi.lu@mediatek.com>
References: <1603370247-30437-1-git-send-email-weiyi.lu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIE1UODE5MiBpbWdzeXMgY2xvY2sgcHJvdmlkZXINCg0KU2lnbmVkLW9mZi1ieTogV2VpeWkg
THUgPHdlaXlpLmx1QG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGRyaXZlcnMvY2xrL21lZGlhdGVrL0tj
b25maWcgICAgICAgICAgfCAgNiArKysrDQogZHJpdmVycy9jbGsvbWVkaWF0ZWsvTWFrZWZpbGUg
ICAgICAgICB8ICAxICsNCiBkcml2ZXJzL2Nsay9tZWRpYXRlay9jbGstbXQ4MTkyLWltZy5jIHwg
NjAgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCiAzIGZpbGVzIGNoYW5nZWQs
IDY3IGluc2VydGlvbnMoKykNCiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9jbGsvbWVkaWF0
ZWsvY2xrLW10ODE5Mi1pbWcuYw0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9jbGsvbWVkaWF0ZWsv
S2NvbmZpZyBiL2RyaXZlcnMvY2xrL21lZGlhdGVrL0tjb25maWcNCmluZGV4IDRjMThhMDguLmFm
ZDAyOGIgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2Nsay9tZWRpYXRlay9LY29uZmlnDQorKysgYi9k
cml2ZXJzL2Nsay9tZWRpYXRlay9LY29uZmlnDQpAQCAtNDc5LDYgKzQ3OSwxMiBAQCBjb25maWcg
Q09NTU9OX0NMS19NVDgxOTJfQ0FNU1lTX1JBV0MNCiAJaGVscA0KIAkgIFRoaXMgZHJpdmVyIHN1
cHBvcnRzIE1lZGlhVGVrIE1UODE5MiBjYW1zeXNfcmF3YyBjbG9ja3MuDQogDQorY29uZmlnIENP
TU1PTl9DTEtfTVQ4MTkyX0lNR1NZUw0KKwlib29sICJDbG9jayBkcml2ZXIgZm9yIE1lZGlhVGVr
IE1UODE5MiBpbWdzeXMiDQorCWRlcGVuZHMgb24gQ09NTU9OX0NMS19NVDgxOTINCisJaGVscA0K
KwkgIFRoaXMgZHJpdmVyIHN1cHBvcnRzIE1lZGlhVGVrIE1UODE5MiBpbWdzeXMgY2xvY2tzLg0K
Kw0KIGNvbmZpZyBDT01NT05fQ0xLX01UODUxNg0KIAlib29sICJDbG9jayBkcml2ZXIgZm9yIE1l
ZGlhVGVrIE1UODUxNiINCiAJZGVwZW5kcyBvbiBBUkNIX01FRElBVEVLIHx8IENPTVBJTEVfVEVT
VA0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL21lZGlhdGVrL01ha2VmaWxlIGIvZHJpdmVycy9j
bGsvbWVkaWF0ZWsvTWFrZWZpbGUNCmluZGV4IDA3YWEyYmQuLjFmODdiZWMgMTAwNjQ0DQotLS0g
YS9kcml2ZXJzL2Nsay9tZWRpYXRlay9NYWtlZmlsZQ0KKysrIGIvZHJpdmVycy9jbGsvbWVkaWF0
ZWsvTWFrZWZpbGUNCkBAIC02Nyw1ICs2Nyw2IEBAIG9iai0kKENPTkZJR19DT01NT05fQ0xLX01U
ODE5Ml9DQU1TWVMpICs9IGNsay1tdDgxOTItY2FtLm8NCiBvYmotJChDT05GSUdfQ09NTU9OX0NM
S19NVDgxOTJfQ0FNU1lTX1JBV0EpICs9IGNsay1tdDgxOTItY2FtX3Jhd2Eubw0KIG9iai0kKENP
TkZJR19DT01NT05fQ0xLX01UODE5Ml9DQU1TWVNfUkFXQikgKz0gY2xrLW10ODE5Mi1jYW1fcmF3
Yi5vDQogb2JqLSQoQ09ORklHX0NPTU1PTl9DTEtfTVQ4MTkyX0NBTVNZU19SQVdDKSArPSBjbGst
bXQ4MTkyLWNhbV9yYXdjLm8NCitvYmotJChDT05GSUdfQ09NTU9OX0NMS19NVDgxOTJfSU1HU1lT
KSArPSBjbGstbXQ4MTkyLWltZy5vDQogb2JqLSQoQ09ORklHX0NPTU1PTl9DTEtfTVQ4NTE2KSAr
PSBjbGstbXQ4NTE2Lm8NCiBvYmotJChDT05GSUdfQ09NTU9OX0NMS19NVDg1MTZfQVVEU1lTKSAr
PSBjbGstbXQ4NTE2LWF1ZC5vDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9jbGsvbWVkaWF0ZWsvY2xr
LW10ODE5Mi1pbWcuYyBiL2RyaXZlcnMvY2xrL21lZGlhdGVrL2Nsay1tdDgxOTItaW1nLmMNCm5l
dyBmaWxlIG1vZGUgMTAwNjQ0DQppbmRleCAwMDAwMDAwLi45YTc0MWIwDQotLS0gL2Rldi9udWxs
DQorKysgYi9kcml2ZXJzL2Nsay9tZWRpYXRlay9jbGstbXQ4MTkyLWltZy5jDQpAQCAtMCwwICsx
LDYwIEBADQorLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb25seQ0KKy8vDQor
Ly8gQ29weXJpZ2h0IChjKSAyMDIwIE1lZGlhVGVrIEluYy4NCisvLyBBdXRob3I6IFdlaXlpIEx1
IDx3ZWl5aS5sdUBtZWRpYXRlay5jb20+DQorDQorI2luY2x1ZGUgPGxpbnV4L2Nsay1wcm92aWRl
ci5oPg0KKyNpbmNsdWRlIDxsaW51eC9wbGF0Zm9ybV9kZXZpY2UuaD4NCisNCisjaW5jbHVkZSAi
Y2xrLW10ay5oIg0KKyNpbmNsdWRlICJjbGstZ2F0ZS5oIg0KKw0KKyNpbmNsdWRlIDxkdC1iaW5k
aW5ncy9jbG9jay9tdDgxOTItY2xrLmg+DQorDQorc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfZ2F0
ZV9yZWdzIGltZ19jZ19yZWdzID0gew0KKwkuc2V0X29mcyA9IDB4NCwNCisJLmNscl9vZnMgPSAw
eDgsDQorCS5zdGFfb2ZzID0gMHgwLA0KK307DQorDQorI2RlZmluZSBHQVRFX0lNRyhfaWQsIF9u
YW1lLCBfcGFyZW50LCBfc2hpZnQpCVwNCisJR0FURV9NVEsoX2lkLCBfbmFtZSwgX3BhcmVudCwg
JmltZ19jZ19yZWdzLCBfc2hpZnQsICZtdGtfY2xrX2dhdGVfb3BzX3NldGNscikNCisNCitzdGF0
aWMgY29uc3Qgc3RydWN0IG10a19nYXRlIGltZ19jbGtzW10gPSB7DQorCUdBVEVfSU1HKENMS19J
TUdfTEFSQjksICJpbWdfbGFyYjkiLCAiaW1nMV9zZWwiLCAwKSwNCisJR0FURV9JTUcoQ0xLX0lN
R19MQVJCMTAsICJpbWdfbGFyYjEwIiwgImltZzFfc2VsIiwgMSksDQorCUdBVEVfSU1HKENMS19J
TUdfRElQLCAiaW1nX2RpcCIsICJpbWcxX3NlbCIsIDIpLA0KKwlHQVRFX0lNRyhDTEtfSU1HX0dB
TFMsICJpbWdfZ2FscyIsICJpbWcxX3NlbCIsIDEyKSwNCit9Ow0KKw0KK3N0YXRpYyBpbnQgY2xr
X210ODE5Ml9pbWdfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCit7DQorCXN0
cnVjdCBjbGtfb25lY2VsbF9kYXRhICpjbGtfZGF0YTsNCisJc3RydWN0IGRldmljZV9ub2RlICpu
b2RlID0gcGRldi0+ZGV2Lm9mX25vZGU7DQorCWludCByOw0KKw0KKwljbGtfZGF0YSA9IG10a19h
bGxvY19jbGtfZGF0YShDTEtfSU1HX05SX0NMSyk7DQorCWlmICghY2xrX2RhdGEpDQorCQlyZXR1
cm4gLUVOT01FTTsNCisNCisJciA9IG10a19jbGtfcmVnaXN0ZXJfZ2F0ZXMobm9kZSwgaW1nX2Ns
a3MsIEFSUkFZX1NJWkUoaW1nX2Nsa3MpLCBjbGtfZGF0YSk7DQorCWlmIChyKQ0KKwkJcmV0dXJu
IHI7DQorDQorCXJldHVybiBvZl9jbGtfYWRkX3Byb3ZpZGVyKG5vZGUsIG9mX2Nsa19zcmNfb25l
Y2VsbF9nZXQsIGNsa19kYXRhKTsNCit9DQorDQorc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZp
Y2VfaWQgb2ZfbWF0Y2hfY2xrX210ODE5Ml9pbWdbXSA9IHsNCisJeyAuY29tcGF0aWJsZSA9ICJt
ZWRpYXRlayxtdDgxOTItaW1nc3lzIiwgfSwNCisJe30NCit9Ow0KKw0KK3N0YXRpYyBzdHJ1Y3Qg
cGxhdGZvcm1fZHJpdmVyIGNsa19tdDgxOTJfaW1nX2RydiA9IHsNCisJLnByb2JlID0gY2xrX210
ODE5Ml9pbWdfcHJvYmUsDQorCS5kcml2ZXIgPSB7DQorCQkubmFtZSA9ICJjbGstbXQ4MTkyLWlt
ZyIsDQorCQkub2ZfbWF0Y2hfdGFibGUgPSBvZl9tYXRjaF9jbGtfbXQ4MTkyX2ltZywNCisJfSwN
Cit9Ow0KKw0KK2J1aWx0aW5fcGxhdGZvcm1fZHJpdmVyKGNsa19tdDgxOTJfaW1nX2Rydik7DQot
LSANCjEuOC4xLjEuZGlydHkNCg==


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3DE295EEB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 14:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2898737AbgJVMoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 08:44:08 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:44187 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2505972AbgJVMnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 08:43:15 -0400
X-UUID: caed0c48b64c4a2a86e16df9398158ac-20201022
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=umJ+B7G8uBrs1AH7lu+KiWUNLiA2sEVEMyWkU8lAiu0=;
        b=hJc/h75pHpKJjxN84Zcwijt7yMXDaS9YfcUcBcLS8J0V9SrqZeKu8MAMlklG/zMVhRlqLxT94JyrTts1NwB/V0Xxy1IXJbAkOWgWhkItMqVmo2gOiUlraCD9edSSn2h/Hp+Em4wLXIJoG3c0pJT0BI9+BjWJWgorsJC6Yc/yCr4=;
X-UUID: caed0c48b64c4a2a86e16df9398158ac-20201022
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1630510094; Thu, 22 Oct 2020 20:37:55 +0800
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
Subject: [PATCH v4 15/34] clk: mediatek: Add MT8192 camsys rawb clock support
Date:   Thu, 22 Oct 2020 20:37:08 +0800
Message-ID: <1603370247-30437-16-git-send-email-weiyi.lu@mediatek.com>
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

QWRkIE1UODE5MiBjYW1zeXMgcmF3YiBjbG9jayBwcm92aWRlcg0KDQpTaWduZWQtb2ZmLWJ5OiBX
ZWl5aSBMdSA8d2VpeWkubHVAbWVkaWF0ZWsuY29tPg0KLS0tDQogZHJpdmVycy9jbGsvbWVkaWF0
ZWsvS2NvbmZpZyAgICAgICAgICAgICAgIHwgIDYgKysrDQogZHJpdmVycy9jbGsvbWVkaWF0ZWsv
TWFrZWZpbGUgICAgICAgICAgICAgIHwgIDEgKw0KIGRyaXZlcnMvY2xrL21lZGlhdGVrL2Nsay1t
dDgxOTItY2FtX3Jhd2IuYyB8IDU5ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KIDMg
ZmlsZXMgY2hhbmdlZCwgNjYgaW5zZXJ0aW9ucygrKQ0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2
ZXJzL2Nsay9tZWRpYXRlay9jbGstbXQ4MTkyLWNhbV9yYXdiLmMNCg0KZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvY2xrL21lZGlhdGVrL0tjb25maWcgYi9kcml2ZXJzL2Nsay9tZWRpYXRlay9LY29uZmln
DQppbmRleCAyMzBlM2Y3Li4zNGIzYTUyIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9jbGsvbWVkaWF0
ZWsvS2NvbmZpZw0KKysrIGIvZHJpdmVycy9jbGsvbWVkaWF0ZWsvS2NvbmZpZw0KQEAgLTQ2Nyw2
ICs0NjcsMTIgQEAgY29uZmlnIENPTU1PTl9DTEtfTVQ4MTkyX0NBTVNZU19SQVdBDQogCWhlbHAN
CiAJICBUaGlzIGRyaXZlciBzdXBwb3J0cyBNZWRpYVRlayBNVDgxOTIgY2Ftc3lzX3Jhd2EgY2xv
Y2tzLg0KIA0KK2NvbmZpZyBDT01NT05fQ0xLX01UODE5Ml9DQU1TWVNfUkFXQg0KKwlib29sICJD
bG9jayBkcml2ZXIgZm9yIE1lZGlhVGVrIE1UODE5MiBjYW1zeXNfcmF3YiINCisJZGVwZW5kcyBv
biBDT01NT05fQ0xLX01UODE5Mg0KKwloZWxwDQorCSAgVGhpcyBkcml2ZXIgc3VwcG9ydHMgTWVk
aWFUZWsgTVQ4MTkyIGNhbXN5c19yYXdiIGNsb2Nrcy4NCisNCiBjb25maWcgQ09NTU9OX0NMS19N
VDg1MTYNCiAJYm9vbCAiQ2xvY2sgZHJpdmVyIGZvciBNZWRpYVRlayBNVDg1MTYiDQogCWRlcGVu
ZHMgb24gQVJDSF9NRURJQVRFSyB8fCBDT01QSUxFX1RFU1QNCmRpZmYgLS1naXQgYS9kcml2ZXJz
L2Nsay9tZWRpYXRlay9NYWtlZmlsZSBiL2RyaXZlcnMvY2xrL21lZGlhdGVrL01ha2VmaWxlDQpp
bmRleCBjZjFlYzc4Li5hMGJjYjAwIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9jbGsvbWVkaWF0ZWsv
TWFrZWZpbGUNCisrKyBiL2RyaXZlcnMvY2xrL21lZGlhdGVrL01ha2VmaWxlDQpAQCAtNjUsNSAr
NjUsNiBAQCBvYmotJChDT05GSUdfQ09NTU9OX0NMS19NVDgxOTIpICs9IGNsay1tdDgxOTIubw0K
IG9iai0kKENPTkZJR19DT01NT05fQ0xLX01UODE5Ml9BVURTWVMpICs9IGNsay1tdDgxOTItYXVk
Lm8NCiBvYmotJChDT05GSUdfQ09NTU9OX0NMS19NVDgxOTJfQ0FNU1lTKSArPSBjbGstbXQ4MTky
LWNhbS5vDQogb2JqLSQoQ09ORklHX0NPTU1PTl9DTEtfTVQ4MTkyX0NBTVNZU19SQVdBKSArPSBj
bGstbXQ4MTkyLWNhbV9yYXdhLm8NCitvYmotJChDT05GSUdfQ09NTU9OX0NMS19NVDgxOTJfQ0FN
U1lTX1JBV0IpICs9IGNsay1tdDgxOTItY2FtX3Jhd2Iubw0KIG9iai0kKENPTkZJR19DT01NT05f
Q0xLX01UODUxNikgKz0gY2xrLW10ODUxNi5vDQogb2JqLSQoQ09ORklHX0NPTU1PTl9DTEtfTVQ4
NTE2X0FVRFNZUykgKz0gY2xrLW10ODUxNi1hdWQubw0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xr
L21lZGlhdGVrL2Nsay1tdDgxOTItY2FtX3Jhd2IuYyBiL2RyaXZlcnMvY2xrL21lZGlhdGVrL2Ns
ay1tdDgxOTItY2FtX3Jhd2IuYw0KbmV3IGZpbGUgbW9kZSAxMDA2NDQNCmluZGV4IDAwMDAwMDAu
LmIzODU1ZjcNCi0tLSAvZGV2L251bGwNCisrKyBiL2RyaXZlcnMvY2xrL21lZGlhdGVrL2Nsay1t
dDgxOTItY2FtX3Jhd2IuYw0KQEAgLTAsMCArMSw1OSBAQA0KKy8vIFNQRFgtTGljZW5zZS1JZGVu
dGlmaWVyOiBHUEwtMi4wLW9ubHkNCisvLw0KKy8vIENvcHlyaWdodCAoYykgMjAyMCBNZWRpYVRl
ayBJbmMuDQorLy8gQXV0aG9yOiBXZWl5aSBMdSA8d2VpeWkubHVAbWVkaWF0ZWsuY29tPg0KKw0K
KyNpbmNsdWRlIDxsaW51eC9jbGstcHJvdmlkZXIuaD4NCisjaW5jbHVkZSA8bGludXgvcGxhdGZv
cm1fZGV2aWNlLmg+DQorDQorI2luY2x1ZGUgImNsay1tdGsuaCINCisjaW5jbHVkZSAiY2xrLWdh
dGUuaCINCisNCisjaW5jbHVkZSA8ZHQtYmluZGluZ3MvY2xvY2svbXQ4MTkyLWNsay5oPg0KKw0K
K3N0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2dhdGVfcmVncyBjYW1fcmF3Yl9jZ19yZWdzID0gew0K
Kwkuc2V0X29mcyA9IDB4NCwNCisJLmNscl9vZnMgPSAweDgsDQorCS5zdGFfb2ZzID0gMHgwLA0K
K307DQorDQorI2RlZmluZSBHQVRFX0NBTV9SQVdCKF9pZCwgX25hbWUsIF9wYXJlbnQsIF9zaGlm
dCkJXA0KKwlHQVRFX01USyhfaWQsIF9uYW1lLCBfcGFyZW50LCAmY2FtX3Jhd2JfY2dfcmVncywg
X3NoaWZ0LCAmbXRrX2Nsa19nYXRlX29wc19zZXRjbHIpDQorDQorc3RhdGljIGNvbnN0IHN0cnVj
dCBtdGtfZ2F0ZSBjYW1fcmF3Yl9jbGtzW10gPSB7DQorCUdBVEVfQ0FNX1JBV0IoQ0xLX0NBTV9S
QVdCX0xBUkJYLCAiY2FtX3Jhd2JfbGFyYngiLCAiY2FtX3NlbCIsIDApLA0KKwlHQVRFX0NBTV9S
QVdCKENMS19DQU1fUkFXQl9DQU0sICJjYW1fcmF3Yl9jYW0iLCAiY2FtX3NlbCIsIDEpLA0KKwlH
QVRFX0NBTV9SQVdCKENMS19DQU1fUkFXQl9DQU1URywgImNhbV9yYXdiX2NhbXRnIiwgImNhbV9z
ZWwiLCAyKSwNCit9Ow0KKw0KK3N0YXRpYyBpbnQgY2xrX210ODE5Ml9jYW1fcmF3Yl9wcm9iZShz
dHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KK3sNCisJc3RydWN0IGNsa19vbmVjZWxsX2Rh
dGEgKmNsa19kYXRhOw0KKwlzdHJ1Y3QgZGV2aWNlX25vZGUgKm5vZGUgPSBwZGV2LT5kZXYub2Zf
bm9kZTsNCisJaW50IHI7DQorDQorCWNsa19kYXRhID0gbXRrX2FsbG9jX2Nsa19kYXRhKENMS19D
QU1fUkFXQl9OUl9DTEspOw0KKwlpZiAoIWNsa19kYXRhKQ0KKwkJcmV0dXJuIC1FTk9NRU07DQor
DQorCXIgPSBtdGtfY2xrX3JlZ2lzdGVyX2dhdGVzKG5vZGUsIGNhbV9yYXdiX2Nsa3MsIEFSUkFZ
X1NJWkUoY2FtX3Jhd2JfY2xrcyksIGNsa19kYXRhKTsNCisJaWYgKHIpDQorCQlyZXR1cm4gcjsN
CisNCisJcmV0dXJuIG9mX2Nsa19hZGRfcHJvdmlkZXIobm9kZSwgb2ZfY2xrX3NyY19vbmVjZWxs
X2dldCwgY2xrX2RhdGEpOw0KK30NCisNCitzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9p
ZCBvZl9tYXRjaF9jbGtfbXQ4MTkyX2NhbV9yYXdiW10gPSB7DQorCXsgLmNvbXBhdGlibGUgPSAi
bWVkaWF0ZWssbXQ4MTkyLWNhbXN5c19yYXdiIiwgfSwNCisJe30NCit9Ow0KKw0KK3N0YXRpYyBz
dHJ1Y3QgcGxhdGZvcm1fZHJpdmVyIGNsa19tdDgxOTJfY2FtX3Jhd2JfZHJ2ID0gew0KKwkucHJv
YmUgPSBjbGtfbXQ4MTkyX2NhbV9yYXdiX3Byb2JlLA0KKwkuZHJpdmVyID0gew0KKwkJLm5hbWUg
PSAiY2xrLW10ODE5Mi1jYW1fcmF3YiIsDQorCQkub2ZfbWF0Y2hfdGFibGUgPSBvZl9tYXRjaF9j
bGtfbXQ4MTkyX2NhbV9yYXdiLA0KKwl9LA0KK307DQorDQorYnVpbHRpbl9wbGF0Zm9ybV9kcml2
ZXIoY2xrX210ODE5Ml9jYW1fcmF3Yl9kcnYpOw0KLS0gDQoxLjguMS4xLmRpcnR5DQo=


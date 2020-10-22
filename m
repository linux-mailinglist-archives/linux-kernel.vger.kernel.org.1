Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A040295E87
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 14:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2898367AbgJVMiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 08:38:15 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:33701 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2898324AbgJVMiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 08:38:00 -0400
X-UUID: 8df6d87e52aa4d4aa86956b8aa82c127-20201022
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=94ERqEezAl61WLflohrVVCYOOOkHB1z2OaNseGbFxoA=;
        b=k/H4bVoYIknNx4i9TnKNeoS4pcGeRN+UHubq1ZEzhLgRmZhilGytG7lu1p/kx7wVF2Zx9SFILhAYv9LcsVAlyKqOL9zpDI21JlcoVpu/Gs/3LsyVxlvVNbcYczLGppTFhkwRfeacy5tQmds2ubALa9SIk7t+q0P4csOOhG7bySs=;
X-UUID: 8df6d87e52aa4d4aa86956b8aa82c127-20201022
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1111283399; Thu, 22 Oct 2020 20:37:54 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
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
Subject: [PATCH v4 16/34] clk: mediatek: Add MT8192 camsys rawc clock support
Date:   Thu, 22 Oct 2020 20:37:09 +0800
Message-ID: <1603370247-30437-17-git-send-email-weiyi.lu@mediatek.com>
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

QWRkIE1UODE5MiBjYW1zeXMgcmF3YyBjbG9jayBwcm92aWRlcg0KDQpTaWduZWQtb2ZmLWJ5OiBX
ZWl5aSBMdSA8d2VpeWkubHVAbWVkaWF0ZWsuY29tPg0KLS0tDQogZHJpdmVycy9jbGsvbWVkaWF0
ZWsvS2NvbmZpZyAgICAgICAgICAgICAgIHwgIDYgKysrDQogZHJpdmVycy9jbGsvbWVkaWF0ZWsv
TWFrZWZpbGUgICAgICAgICAgICAgIHwgIDEgKw0KIGRyaXZlcnMvY2xrL21lZGlhdGVrL2Nsay1t
dDgxOTItY2FtX3Jhd2MuYyB8IDU5ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KIDMg
ZmlsZXMgY2hhbmdlZCwgNjYgaW5zZXJ0aW9ucygrKQ0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2
ZXJzL2Nsay9tZWRpYXRlay9jbGstbXQ4MTkyLWNhbV9yYXdjLmMNCg0KZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvY2xrL21lZGlhdGVrL0tjb25maWcgYi9kcml2ZXJzL2Nsay9tZWRpYXRlay9LY29uZmln
DQppbmRleCAzNGIzYTUyLi40YzE4YTA4IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9jbGsvbWVkaWF0
ZWsvS2NvbmZpZw0KKysrIGIvZHJpdmVycy9jbGsvbWVkaWF0ZWsvS2NvbmZpZw0KQEAgLTQ3Myw2
ICs0NzMsMTIgQEAgY29uZmlnIENPTU1PTl9DTEtfTVQ4MTkyX0NBTVNZU19SQVdCDQogCWhlbHAN
CiAJICBUaGlzIGRyaXZlciBzdXBwb3J0cyBNZWRpYVRlayBNVDgxOTIgY2Ftc3lzX3Jhd2IgY2xv
Y2tzLg0KIA0KK2NvbmZpZyBDT01NT05fQ0xLX01UODE5Ml9DQU1TWVNfUkFXQw0KKwlib29sICJD
bG9jayBkcml2ZXIgZm9yIE1lZGlhVGVrIE1UODE5MiBjYW1zeXNfcmF3YyINCisJZGVwZW5kcyBv
biBDT01NT05fQ0xLX01UODE5Mg0KKwloZWxwDQorCSAgVGhpcyBkcml2ZXIgc3VwcG9ydHMgTWVk
aWFUZWsgTVQ4MTkyIGNhbXN5c19yYXdjIGNsb2Nrcy4NCisNCiBjb25maWcgQ09NTU9OX0NMS19N
VDg1MTYNCiAJYm9vbCAiQ2xvY2sgZHJpdmVyIGZvciBNZWRpYVRlayBNVDg1MTYiDQogCWRlcGVu
ZHMgb24gQVJDSF9NRURJQVRFSyB8fCBDT01QSUxFX1RFU1QNCmRpZmYgLS1naXQgYS9kcml2ZXJz
L2Nsay9tZWRpYXRlay9NYWtlZmlsZSBiL2RyaXZlcnMvY2xrL21lZGlhdGVrL01ha2VmaWxlDQpp
bmRleCBhMGJjYjAwLi4wN2FhMmJkIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9jbGsvbWVkaWF0ZWsv
TWFrZWZpbGUNCisrKyBiL2RyaXZlcnMvY2xrL21lZGlhdGVrL01ha2VmaWxlDQpAQCAtNjYsNSAr
NjYsNiBAQCBvYmotJChDT05GSUdfQ09NTU9OX0NMS19NVDgxOTJfQVVEU1lTKSArPSBjbGstbXQ4
MTkyLWF1ZC5vDQogb2JqLSQoQ09ORklHX0NPTU1PTl9DTEtfTVQ4MTkyX0NBTVNZUykgKz0gY2xr
LW10ODE5Mi1jYW0ubw0KIG9iai0kKENPTkZJR19DT01NT05fQ0xLX01UODE5Ml9DQU1TWVNfUkFX
QSkgKz0gY2xrLW10ODE5Mi1jYW1fcmF3YS5vDQogb2JqLSQoQ09ORklHX0NPTU1PTl9DTEtfTVQ4
MTkyX0NBTVNZU19SQVdCKSArPSBjbGstbXQ4MTkyLWNhbV9yYXdiLm8NCitvYmotJChDT05GSUdf
Q09NTU9OX0NMS19NVDgxOTJfQ0FNU1lTX1JBV0MpICs9IGNsay1tdDgxOTItY2FtX3Jhd2Mubw0K
IG9iai0kKENPTkZJR19DT01NT05fQ0xLX01UODUxNikgKz0gY2xrLW10ODUxNi5vDQogb2JqLSQo
Q09ORklHX0NPTU1PTl9DTEtfTVQ4NTE2X0FVRFNZUykgKz0gY2xrLW10ODUxNi1hdWQubw0KZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvY2xrL21lZGlhdGVrL2Nsay1tdDgxOTItY2FtX3Jhd2MuYyBiL2Ry
aXZlcnMvY2xrL21lZGlhdGVrL2Nsay1tdDgxOTItY2FtX3Jhd2MuYw0KbmV3IGZpbGUgbW9kZSAx
MDA2NDQNCmluZGV4IDAwMDAwMDAuLjA1NDM2MWQNCi0tLSAvZGV2L251bGwNCisrKyBiL2RyaXZl
cnMvY2xrL21lZGlhdGVrL2Nsay1tdDgxOTItY2FtX3Jhd2MuYw0KQEAgLTAsMCArMSw1OSBAQA0K
Ky8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9ubHkNCisvLw0KKy8vIENvcHly
aWdodCAoYykgMjAyMCBNZWRpYVRlayBJbmMuDQorLy8gQXV0aG9yOiBXZWl5aSBMdSA8d2VpeWku
bHVAbWVkaWF0ZWsuY29tPg0KKw0KKyNpbmNsdWRlIDxsaW51eC9jbGstcHJvdmlkZXIuaD4NCisj
aW5jbHVkZSA8bGludXgvcGxhdGZvcm1fZGV2aWNlLmg+DQorDQorI2luY2x1ZGUgImNsay1tdGsu
aCINCisjaW5jbHVkZSAiY2xrLWdhdGUuaCINCisNCisjaW5jbHVkZSA8ZHQtYmluZGluZ3MvY2xv
Y2svbXQ4MTkyLWNsay5oPg0KKw0KK3N0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2dhdGVfcmVncyBj
YW1fcmF3Y19jZ19yZWdzID0gew0KKwkuc2V0X29mcyA9IDB4NCwNCisJLmNscl9vZnMgPSAweDgs
DQorCS5zdGFfb2ZzID0gMHgwLA0KK307DQorDQorI2RlZmluZSBHQVRFX0NBTV9SQVdDKF9pZCwg
X25hbWUsIF9wYXJlbnQsIF9zaGlmdCkJXA0KKwlHQVRFX01USyhfaWQsIF9uYW1lLCBfcGFyZW50
LCAmY2FtX3Jhd2NfY2dfcmVncywgX3NoaWZ0LCAmbXRrX2Nsa19nYXRlX29wc19zZXRjbHIpDQor
DQorc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfZ2F0ZSBjYW1fcmF3Y19jbGtzW10gPSB7DQorCUdB
VEVfQ0FNX1JBV0MoQ0xLX0NBTV9SQVdDX0xBUkJYLCAiY2FtX3Jhd2NfbGFyYngiLCAiY2FtX3Nl
bCIsIDApLA0KKwlHQVRFX0NBTV9SQVdDKENMS19DQU1fUkFXQ19DQU0sICJjYW1fcmF3Y19jYW0i
LCAiY2FtX3NlbCIsIDEpLA0KKwlHQVRFX0NBTV9SQVdDKENMS19DQU1fUkFXQ19DQU1URywgImNh
bV9yYXdjX2NhbXRnIiwgImNhbV9zZWwiLCAyKSwNCit9Ow0KKw0KK3N0YXRpYyBpbnQgY2xrX210
ODE5Ml9jYW1fcmF3Y19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KK3sNCisJ
c3RydWN0IGNsa19vbmVjZWxsX2RhdGEgKmNsa19kYXRhOw0KKwlzdHJ1Y3QgZGV2aWNlX25vZGUg
Km5vZGUgPSBwZGV2LT5kZXYub2Zfbm9kZTsNCisJaW50IHI7DQorDQorCWNsa19kYXRhID0gbXRr
X2FsbG9jX2Nsa19kYXRhKENMS19DQU1fUkFXQ19OUl9DTEspOw0KKwlpZiAoIWNsa19kYXRhKQ0K
KwkJcmV0dXJuIC1FTk9NRU07DQorDQorCXIgPSBtdGtfY2xrX3JlZ2lzdGVyX2dhdGVzKG5vZGUs
IGNhbV9yYXdjX2Nsa3MsIEFSUkFZX1NJWkUoY2FtX3Jhd2NfY2xrcyksIGNsa19kYXRhKTsNCisJ
aWYgKHIpDQorCQlyZXR1cm4gcjsNCisNCisJcmV0dXJuIG9mX2Nsa19hZGRfcHJvdmlkZXIobm9k
ZSwgb2ZfY2xrX3NyY19vbmVjZWxsX2dldCwgY2xrX2RhdGEpOw0KK30NCisNCitzdGF0aWMgY29u
c3Qgc3RydWN0IG9mX2RldmljZV9pZCBvZl9tYXRjaF9jbGtfbXQ4MTkyX2NhbV9yYXdjW10gPSB7
DQorCXsgLmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTkyLWNhbXN5c19yYXdjIiwgfSwNCisJ
e30NCit9Ow0KKw0KK3N0YXRpYyBzdHJ1Y3QgcGxhdGZvcm1fZHJpdmVyIGNsa19tdDgxOTJfY2Ft
X3Jhd2NfZHJ2ID0gew0KKwkucHJvYmUgPSBjbGtfbXQ4MTkyX2NhbV9yYXdjX3Byb2JlLA0KKwku
ZHJpdmVyID0gew0KKwkJLm5hbWUgPSAiY2xrLW10ODE5Mi1jYW1fcmF3YyIsDQorCQkub2ZfbWF0
Y2hfdGFibGUgPSBvZl9tYXRjaF9jbGtfbXQ4MTkyX2NhbV9yYXdjLA0KKwl9LA0KK307DQorDQor
YnVpbHRpbl9wbGF0Zm9ybV9kcml2ZXIoY2xrX210ODE5Ml9jYW1fcmF3Y19kcnYpOw0KLS0gDQox
LjguMS4xLmRpcnR5DQo=


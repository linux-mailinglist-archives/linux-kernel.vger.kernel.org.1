Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8311295EAE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 14:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505175AbgJVMjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 08:39:25 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:33701 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2898340AbgJVMiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 08:38:06 -0400
X-UUID: 4a5422d6263d4fcba56d57406cc6257a-20201022
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=TDOx6fhXaJsF0Fpoms+4Z1zLKnR/5sMBUH/V/FKsR+o=;
        b=NGPi9b2wl2SzT8Ux4RjZfZKS7+tKPgwuScIV6H3W9JNs36SZiHGKEDDKzNyR/BsdLVfHraCdVtbJ2FRisr4qj05U3ugW08GvHkIRK3YDZZ+n2ma5oCfpmnSP1lZsKYWVxHn7QV8NXDyD8jbW/707GMcuJcjd1bAZW9ucwcVf3lo=;
X-UUID: 4a5422d6263d4fcba56d57406cc6257a-20201022
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1493274751; Thu, 22 Oct 2020 20:37:54 +0800
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
Subject: [PATCH v4 14/34] clk: mediatek: Add MT8192 camsys rawa clock support
Date:   Thu, 22 Oct 2020 20:37:07 +0800
Message-ID: <1603370247-30437-15-git-send-email-weiyi.lu@mediatek.com>
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

QWRkIE1UODE5MiBjYW1zeXMgcmF3YSBjbG9jayBwcm92aWRlcg0KDQpTaWduZWQtb2ZmLWJ5OiBX
ZWl5aSBMdSA8d2VpeWkubHVAbWVkaWF0ZWsuY29tPg0KLS0tDQogZHJpdmVycy9jbGsvbWVkaWF0
ZWsvS2NvbmZpZyAgICAgICAgICAgICAgIHwgIDYgKysrDQogZHJpdmVycy9jbGsvbWVkaWF0ZWsv
TWFrZWZpbGUgICAgICAgICAgICAgIHwgIDEgKw0KIGRyaXZlcnMvY2xrL21lZGlhdGVrL2Nsay1t
dDgxOTItY2FtX3Jhd2EuYyB8IDU5ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KIDMg
ZmlsZXMgY2hhbmdlZCwgNjYgaW5zZXJ0aW9ucygrKQ0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2
ZXJzL2Nsay9tZWRpYXRlay9jbGstbXQ4MTkyLWNhbV9yYXdhLmMNCg0KZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvY2xrL21lZGlhdGVrL0tjb25maWcgYi9kcml2ZXJzL2Nsay9tZWRpYXRlay9LY29uZmln
DQppbmRleCAwY2I5ZjczLi4yMzBlM2Y3IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9jbGsvbWVkaWF0
ZWsvS2NvbmZpZw0KKysrIGIvZHJpdmVycy9jbGsvbWVkaWF0ZWsvS2NvbmZpZw0KQEAgLTQ2MSw2
ICs0NjEsMTIgQEAgY29uZmlnIENPTU1PTl9DTEtfTVQ4MTkyX0NBTVNZUw0KIAloZWxwDQogCSAg
VGhpcyBkcml2ZXIgc3VwcG9ydHMgTWVkaWFUZWsgTVQ4MTkyIGNhbXN5cyBjbG9ja3MuDQogDQor
Y29uZmlnIENPTU1PTl9DTEtfTVQ4MTkyX0NBTVNZU19SQVdBDQorCWJvb2wgIkNsb2NrIGRyaXZl
ciBmb3IgTWVkaWFUZWsgTVQ4MTkyIGNhbXN5c19yYXdhIg0KKwlkZXBlbmRzIG9uIENPTU1PTl9D
TEtfTVQ4MTkyDQorCWhlbHANCisJICBUaGlzIGRyaXZlciBzdXBwb3J0cyBNZWRpYVRlayBNVDgx
OTIgY2Ftc3lzX3Jhd2EgY2xvY2tzLg0KKw0KIGNvbmZpZyBDT01NT05fQ0xLX01UODUxNg0KIAli
b29sICJDbG9jayBkcml2ZXIgZm9yIE1lZGlhVGVrIE1UODUxNiINCiAJZGVwZW5kcyBvbiBBUkNI
X01FRElBVEVLIHx8IENPTVBJTEVfVEVTVA0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL21lZGlh
dGVrL01ha2VmaWxlIGIvZHJpdmVycy9jbGsvbWVkaWF0ZWsvTWFrZWZpbGUNCmluZGV4IGY0NDY4
MzQuLmNmMWVjNzggMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2Nsay9tZWRpYXRlay9NYWtlZmlsZQ0K
KysrIGIvZHJpdmVycy9jbGsvbWVkaWF0ZWsvTWFrZWZpbGUNCkBAIC02NCw1ICs2NCw2IEBAIG9i
ai0kKENPTkZJR19DT01NT05fQ0xLX01UODE4M19WRU5DU1lTKSArPSBjbGstbXQ4MTgzLXZlbmMu
bw0KIG9iai0kKENPTkZJR19DT01NT05fQ0xLX01UODE5MikgKz0gY2xrLW10ODE5Mi5vDQogb2Jq
LSQoQ09ORklHX0NPTU1PTl9DTEtfTVQ4MTkyX0FVRFNZUykgKz0gY2xrLW10ODE5Mi1hdWQubw0K
IG9iai0kKENPTkZJR19DT01NT05fQ0xLX01UODE5Ml9DQU1TWVMpICs9IGNsay1tdDgxOTItY2Ft
Lm8NCitvYmotJChDT05GSUdfQ09NTU9OX0NMS19NVDgxOTJfQ0FNU1lTX1JBV0EpICs9IGNsay1t
dDgxOTItY2FtX3Jhd2Eubw0KIG9iai0kKENPTkZJR19DT01NT05fQ0xLX01UODUxNikgKz0gY2xr
LW10ODUxNi5vDQogb2JqLSQoQ09ORklHX0NPTU1PTl9DTEtfTVQ4NTE2X0FVRFNZUykgKz0gY2xr
LW10ODUxNi1hdWQubw0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL21lZGlhdGVrL2Nsay1tdDgx
OTItY2FtX3Jhd2EuYyBiL2RyaXZlcnMvY2xrL21lZGlhdGVrL2Nsay1tdDgxOTItY2FtX3Jhd2Eu
Yw0KbmV3IGZpbGUgbW9kZSAxMDA2NDQNCmluZGV4IDAwMDAwMDAuLjAyZWZkNjgNCi0tLSAvZGV2
L251bGwNCisrKyBiL2RyaXZlcnMvY2xrL21lZGlhdGVrL2Nsay1tdDgxOTItY2FtX3Jhd2EuYw0K
QEAgLTAsMCArMSw1OSBAQA0KKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9u
bHkNCisvLw0KKy8vIENvcHlyaWdodCAoYykgMjAyMCBNZWRpYVRlayBJbmMuDQorLy8gQXV0aG9y
OiBXZWl5aSBMdSA8d2VpeWkubHVAbWVkaWF0ZWsuY29tPg0KKw0KKyNpbmNsdWRlIDxsaW51eC9j
bGstcHJvdmlkZXIuaD4NCisjaW5jbHVkZSA8bGludXgvcGxhdGZvcm1fZGV2aWNlLmg+DQorDQor
I2luY2x1ZGUgImNsay1tdGsuaCINCisjaW5jbHVkZSAiY2xrLWdhdGUuaCINCisNCisjaW5jbHVk
ZSA8ZHQtYmluZGluZ3MvY2xvY2svbXQ4MTkyLWNsay5oPg0KKw0KK3N0YXRpYyBjb25zdCBzdHJ1
Y3QgbXRrX2dhdGVfcmVncyBjYW1fcmF3YV9jZ19yZWdzID0gew0KKwkuc2V0X29mcyA9IDB4NCwN
CisJLmNscl9vZnMgPSAweDgsDQorCS5zdGFfb2ZzID0gMHgwLA0KK307DQorDQorI2RlZmluZSBH
QVRFX0NBTV9SQVdBKF9pZCwgX25hbWUsIF9wYXJlbnQsIF9zaGlmdCkJXA0KKwlHQVRFX01USyhf
aWQsIF9uYW1lLCBfcGFyZW50LCAmY2FtX3Jhd2FfY2dfcmVncywgX3NoaWZ0LCAmbXRrX2Nsa19n
YXRlX29wc19zZXRjbHIpDQorDQorc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfZ2F0ZSBjYW1fcmF3
YV9jbGtzW10gPSB7DQorCUdBVEVfQ0FNX1JBV0EoQ0xLX0NBTV9SQVdBX0xBUkJYLCAiY2FtX3Jh
d2FfbGFyYngiLCAiY2FtX3NlbCIsIDApLA0KKwlHQVRFX0NBTV9SQVdBKENMS19DQU1fUkFXQV9D
QU0sICJjYW1fcmF3YV9jYW0iLCAiY2FtX3NlbCIsIDEpLA0KKwlHQVRFX0NBTV9SQVdBKENMS19D
QU1fUkFXQV9DQU1URywgImNhbV9yYXdhX2NhbXRnIiwgImNhbV9zZWwiLCAyKSwNCit9Ow0KKw0K
K3N0YXRpYyBpbnQgY2xrX210ODE5Ml9jYW1fcmF3YV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2
aWNlICpwZGV2KQ0KK3sNCisJc3RydWN0IGNsa19vbmVjZWxsX2RhdGEgKmNsa19kYXRhOw0KKwlz
dHJ1Y3QgZGV2aWNlX25vZGUgKm5vZGUgPSBwZGV2LT5kZXYub2Zfbm9kZTsNCisJaW50IHI7DQor
DQorCWNsa19kYXRhID0gbXRrX2FsbG9jX2Nsa19kYXRhKENMS19DQU1fUkFXQV9OUl9DTEspOw0K
KwlpZiAoIWNsa19kYXRhKQ0KKwkJcmV0dXJuIC1FTk9NRU07DQorDQorCXIgPSBtdGtfY2xrX3Jl
Z2lzdGVyX2dhdGVzKG5vZGUsIGNhbV9yYXdhX2Nsa3MsIEFSUkFZX1NJWkUoY2FtX3Jhd2FfY2xr
cyksIGNsa19kYXRhKTsNCisJaWYgKHIpDQorCQlyZXR1cm4gcjsNCisNCisJcmV0dXJuIG9mX2Ns
a19hZGRfcHJvdmlkZXIobm9kZSwgb2ZfY2xrX3NyY19vbmVjZWxsX2dldCwgY2xrX2RhdGEpOw0K
K30NCisNCitzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBvZl9tYXRjaF9jbGtfbXQ4
MTkyX2NhbV9yYXdhW10gPSB7DQorCXsgLmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTkyLWNh
bXN5c19yYXdhIiwgfSwNCisJe30NCit9Ow0KKw0KK3N0YXRpYyBzdHJ1Y3QgcGxhdGZvcm1fZHJp
dmVyIGNsa19tdDgxOTJfY2FtX3Jhd2FfZHJ2ID0gew0KKwkucHJvYmUgPSBjbGtfbXQ4MTkyX2Nh
bV9yYXdhX3Byb2JlLA0KKwkuZHJpdmVyID0gew0KKwkJLm5hbWUgPSAiY2xrLW10ODE5Mi1jYW1f
cmF3YSIsDQorCQkub2ZfbWF0Y2hfdGFibGUgPSBvZl9tYXRjaF9jbGtfbXQ4MTkyX2NhbV9yYXdh
LA0KKwl9LA0KK307DQorDQorYnVpbHRpbl9wbGF0Zm9ybV9kcml2ZXIoY2xrX210ODE5Ml9jYW1f
cmF3YV9kcnYpOw0KLS0gDQoxLjguMS4xLmRpcnR5DQo=


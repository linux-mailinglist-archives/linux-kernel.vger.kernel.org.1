Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 847A9295ED7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 14:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2898685AbgJVMng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 08:43:36 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:44187 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2506353AbgJVMnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 08:43:31 -0400
X-UUID: 0d7b480edb7247c28564798f031850ee-20201022
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=+NWnL0gLpX7Ip8SQczwvHvPP/3YKYMmdM76PpJzv7qw=;
        b=NDMphSYG7HgKUnJ6HPSFIBmWdEKZAaWGXGWEonxfrkFW+wcBAE6zS5da/VoMHTI1/zmtOjxbNjgZDeZf5zoNUcFxTLndtYYXGv/r0B/12Yb46XNAUbrpdl6T/Ltlt75K8ch7QvC/7yeaO91F9U07L1eFHvRCQzeSGAwOmgblDH0=;
X-UUID: 0d7b480edb7247c28564798f031850ee-20201022
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1109368234; Thu, 22 Oct 2020 20:37:59 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 22 Oct 2020 20:37:57 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 22 Oct 2020 20:37:57 +0800
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <srv_heupstream@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>
Subject: [PATCH v4 34/34] clk: mediatek: Add MT8192 vencsys clock support
Date:   Thu, 22 Oct 2020 20:37:27 +0800
Message-ID: <1603370247-30437-35-git-send-email-weiyi.lu@mediatek.com>
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

QWRkIE1UODE5MiB2ZW5jc3lzIGNsb2NrIHByb3ZpZGVyDQoNClNpZ25lZC1vZmYtYnk6IFdlaXlp
IEx1IDx3ZWl5aS5sdUBtZWRpYXRlay5jb20+DQotLS0NCiBkcml2ZXJzL2Nsay9tZWRpYXRlay9L
Y29uZmlnICAgICAgICAgICB8ICA2ICsrKysNCiBkcml2ZXJzL2Nsay9tZWRpYXRlay9NYWtlZmls
ZSAgICAgICAgICB8ICAxICsNCiBkcml2ZXJzL2Nsay9tZWRpYXRlay9jbGstbXQ4MTkyLXZlbmMu
YyB8IDYwICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCiAzIGZpbGVzIGNoYW5n
ZWQsIDY3IGluc2VydGlvbnMoKykNCiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9jbGsvbWVk
aWF0ZWsvY2xrLW10ODE5Mi12ZW5jLmMNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL21lZGlh
dGVrL0tjb25maWcgYi9kcml2ZXJzL2Nsay9tZWRpYXRlay9LY29uZmlnDQppbmRleCA3NGY0ZjAw
Li5hMDUxM2IxIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9jbGsvbWVkaWF0ZWsvS2NvbmZpZw0KKysr
IGIvZHJpdmVycy9jbGsvbWVkaWF0ZWsvS2NvbmZpZw0KQEAgLTU4MSw2ICs1ODEsMTIgQEAgY29u
ZmlnIENPTU1PTl9DTEtfTVQ4MTkyX1ZERUNTWVNfU09DDQogCWhlbHANCiAJICBUaGlzIGRyaXZl
ciBzdXBwb3J0cyBNZWRpYVRlayBNVDgxOTIgdmRlY3N5c19zb2MgY2xvY2tzLg0KIA0KK2NvbmZp
ZyBDT01NT05fQ0xLX01UODE5Ml9WRU5DU1lTDQorCWJvb2wgIkNsb2NrIGRyaXZlciBmb3IgTWVk
aWFUZWsgTVQ4MTkyIHZlbmNzeXMiDQorCWRlcGVuZHMgb24gQ09NTU9OX0NMS19NVDgxOTINCisJ
aGVscA0KKwkgIFRoaXMgZHJpdmVyIHN1cHBvcnRzIE1lZGlhVGVrIE1UODE5MiB2ZW5jc3lzIGNs
b2Nrcy4NCisNCiBjb25maWcgQ09NTU9OX0NMS19NVDg1MTYNCiAJYm9vbCAiQ2xvY2sgZHJpdmVy
IGZvciBNZWRpYVRlayBNVDg1MTYiDQogCWRlcGVuZHMgb24gQVJDSF9NRURJQVRFSyB8fCBDT01Q
SUxFX1RFU1QNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2Nsay9tZWRpYXRlay9NYWtlZmlsZSBiL2Ry
aXZlcnMvY2xrL21lZGlhdGVrL01ha2VmaWxlDQppbmRleCAyODliN2U2Li4zZTY2MGFjIDEwMDY0
NA0KLS0tIGEvZHJpdmVycy9jbGsvbWVkaWF0ZWsvTWFrZWZpbGUNCisrKyBiL2RyaXZlcnMvY2xr
L21lZGlhdGVrL01ha2VmaWxlDQpAQCAtODQsNSArODQsNiBAQCBvYmotJChDT05GSUdfQ09NTU9O
X0NMS19NVDgxOTJfTVNEQykgKz0gY2xrLW10ODE5Mi1tc2RjLm8NCiBvYmotJChDT05GSUdfQ09N
TU9OX0NMS19NVDgxOTJfU0NQX0FEU1ApICs9IGNsay1tdDgxOTItc2NwX2Fkc3Aubw0KIG9iai0k
KENPTkZJR19DT01NT05fQ0xLX01UODE5Ml9WREVDU1lTKSArPSBjbGstbXQ4MTkyLXZkZWMubw0K
IG9iai0kKENPTkZJR19DT01NT05fQ0xLX01UODE5Ml9WREVDU1lTX1NPQykgKz0gY2xrLW10ODE5
Mi12ZGVjX3NvYy5vDQorb2JqLSQoQ09ORklHX0NPTU1PTl9DTEtfTVQ4MTkyX1ZFTkNTWVMpICs9
IGNsay1tdDgxOTItdmVuYy5vDQogb2JqLSQoQ09ORklHX0NPTU1PTl9DTEtfTVQ4NTE2KSArPSBj
bGstbXQ4NTE2Lm8NCiBvYmotJChDT05GSUdfQ09NTU9OX0NMS19NVDg1MTZfQVVEU1lTKSArPSBj
bGstbXQ4NTE2LWF1ZC5vDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9jbGsvbWVkaWF0ZWsvY2xrLW10
ODE5Mi12ZW5jLmMgYi9kcml2ZXJzL2Nsay9tZWRpYXRlay9jbGstbXQ4MTkyLXZlbmMuYw0KbmV3
IGZpbGUgbW9kZSAxMDA2NDQNCmluZGV4IDAwMDAwMDAuLjQ3MzkzNTQNCi0tLSAvZGV2L251bGwN
CisrKyBiL2RyaXZlcnMvY2xrL21lZGlhdGVrL2Nsay1tdDgxOTItdmVuYy5jDQpAQCAtMCwwICsx
LDYwIEBADQorLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb25seQ0KKy8vDQor
Ly8gQ29weXJpZ2h0IChjKSAyMDIwIE1lZGlhVGVrIEluYy4NCisvLyBBdXRob3I6IFdlaXlpIEx1
IDx3ZWl5aS5sdUBtZWRpYXRlay5jb20+DQorDQorI2luY2x1ZGUgPGxpbnV4L2Nsay1wcm92aWRl
ci5oPg0KKyNpbmNsdWRlIDxsaW51eC9wbGF0Zm9ybV9kZXZpY2UuaD4NCisNCisjaW5jbHVkZSAi
Y2xrLW10ay5oIg0KKyNpbmNsdWRlICJjbGstZ2F0ZS5oIg0KKw0KKyNpbmNsdWRlIDxkdC1iaW5k
aW5ncy9jbG9jay9tdDgxOTItY2xrLmg+DQorDQorc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfZ2F0
ZV9yZWdzIHZlbmNfY2dfcmVncyA9IHsNCisJLnNldF9vZnMgPSAweDQsDQorCS5jbHJfb2ZzID0g
MHg4LA0KKwkuc3RhX29mcyA9IDB4MCwNCit9Ow0KKw0KKyNkZWZpbmUgR0FURV9WRU5DKF9pZCwg
X25hbWUsIF9wYXJlbnQsIF9zaGlmdCkJXA0KKwlHQVRFX01USyhfaWQsIF9uYW1lLCBfcGFyZW50
LCAmdmVuY19jZ19yZWdzLCBfc2hpZnQsICZtdGtfY2xrX2dhdGVfb3BzX3NldGNscl9pbnYpDQor
DQorc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfZ2F0ZSB2ZW5jX2Nsa3NbXSA9IHsNCisJR0FURV9W
RU5DKENMS19WRU5DX1NFVDBfTEFSQiwgInZlbmNfc2V0MF9sYXJiIiwgInZlbmNfc2VsIiwgMCks
DQorCUdBVEVfVkVOQyhDTEtfVkVOQ19TRVQxX1ZFTkMsICJ2ZW5jX3NldDFfdmVuYyIsICJ2ZW5j
X3NlbCIsIDQpLA0KKwlHQVRFX1ZFTkMoQ0xLX1ZFTkNfU0VUMl9KUEdFTkMsICJ2ZW5jX3NldDJf
anBnZW5jIiwgInZlbmNfc2VsIiwgOCksDQorCUdBVEVfVkVOQyhDTEtfVkVOQ19TRVQ1X0dBTFMs
ICJ2ZW5jX3NldDVfZ2FscyIsICJ2ZW5jX3NlbCIsIDI4KSwNCit9Ow0KKw0KK3N0YXRpYyBpbnQg
Y2xrX210ODE5Ml92ZW5jX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQorew0K
KwlzdHJ1Y3QgY2xrX29uZWNlbGxfZGF0YSAqY2xrX2RhdGE7DQorCXN0cnVjdCBkZXZpY2Vfbm9k
ZSAqbm9kZSA9IHBkZXYtPmRldi5vZl9ub2RlOw0KKwlpbnQgcjsNCisNCisJY2xrX2RhdGEgPSBt
dGtfYWxsb2NfY2xrX2RhdGEoQ0xLX1ZFTkNfTlJfQ0xLKTsNCisJaWYgKCFjbGtfZGF0YSkNCisJ
CXJldHVybiAtRU5PTUVNOw0KKw0KKwlyID0gbXRrX2Nsa19yZWdpc3Rlcl9nYXRlcyhub2RlLCB2
ZW5jX2Nsa3MsIEFSUkFZX1NJWkUodmVuY19jbGtzKSwgY2xrX2RhdGEpOw0KKwlpZiAocikNCisJ
CXJldHVybiByOw0KKw0KKwlyZXR1cm4gb2ZfY2xrX2FkZF9wcm92aWRlcihub2RlLCBvZl9jbGtf
c3JjX29uZWNlbGxfZ2V0LCBjbGtfZGF0YSk7DQorfQ0KKw0KK3N0YXRpYyBjb25zdCBzdHJ1Y3Qg
b2ZfZGV2aWNlX2lkIG9mX21hdGNoX2Nsa19tdDgxOTJfdmVuY1tdID0gew0KKwl7IC5jb21wYXRp
YmxlID0gIm1lZGlhdGVrLG10ODE5Mi12ZW5jc3lzIiwgfSwNCisJe30NCit9Ow0KKw0KK3N0YXRp
YyBzdHJ1Y3QgcGxhdGZvcm1fZHJpdmVyIGNsa19tdDgxOTJfdmVuY19kcnYgPSB7DQorCS5wcm9i
ZSA9IGNsa19tdDgxOTJfdmVuY19wcm9iZSwNCisJLmRyaXZlciA9IHsNCisJCS5uYW1lID0gImNs
ay1tdDgxOTItdmVuYyIsDQorCQkub2ZfbWF0Y2hfdGFibGUgPSBvZl9tYXRjaF9jbGtfbXQ4MTky
X3ZlbmMsDQorCX0sDQorfTsNCisNCitidWlsdGluX3BsYXRmb3JtX2RyaXZlcihjbGtfbXQ4MTky
X3ZlbmNfZHJ2KTsNCi0tIA0KMS44LjEuMS5kaXJ0eQ0K


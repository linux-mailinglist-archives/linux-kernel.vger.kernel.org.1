Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 223D2295ED4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 14:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2898661AbgJVMn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 08:43:29 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:44187 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2506307AbgJVMnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 08:43:22 -0400
X-UUID: 7f4a1415cc564bffa4033bb9fd818517-20201022
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=3Nd8edz5EroRY4Fw7PU6EzlKt9/wLguZKzRfZzQypwg=;
        b=egt3Hd2CqKZFu9q7xJbqV0g4SzR2T0WyDhVMqiySpkDapOy7MiInLL7PLBpg8wKQYJTBe+2Z803MSJrGHzwiEZfzrG/z7QYiWsUCHktsUfgQz7rY/BHefbAgrPL5h8lBIe1EtXjONcAc7mhYurZV9MYkrF6ae4Opbri+VtwT2p4=;
X-UUID: 7f4a1415cc564bffa4033bb9fd818517-20201022
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1589635961; Thu, 22 Oct 2020 20:37:58 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 22 Oct 2020 20:37:56 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 22 Oct 2020 20:37:56 +0800
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <srv_heupstream@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>
Subject: [PATCH v4 27/34] clk: mediatek: Add MT8192 mfgcfg clock support
Date:   Thu, 22 Oct 2020 20:37:20 +0800
Message-ID: <1603370247-30437-28-git-send-email-weiyi.lu@mediatek.com>
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

QWRkIE1UODE5MiBtZmdjZmcgY2xvY2sgcHJvdmlkZXINCg0KU2lnbmVkLW9mZi1ieTogV2VpeWkg
THUgPHdlaXlpLmx1QG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGRyaXZlcnMvY2xrL21lZGlhdGVrL0tj
b25maWcgICAgICAgICAgfCAgNiArKysrDQogZHJpdmVycy9jbGsvbWVkaWF0ZWsvTWFrZWZpbGUg
ICAgICAgICB8ICAxICsNCiBkcml2ZXJzL2Nsay9tZWRpYXRlay9jbGstbXQ4MTkyLW1mZy5jIHwg
NTcgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCiAzIGZpbGVzIGNoYW5nZWQs
IDY0IGluc2VydGlvbnMoKykNCiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9jbGsvbWVkaWF0
ZWsvY2xrLW10ODE5Mi1tZmcuYw0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9jbGsvbWVkaWF0ZWsv
S2NvbmZpZyBiL2RyaXZlcnMvY2xrL21lZGlhdGVrL0tjb25maWcNCmluZGV4IGVmMDRkNTQuLjM0
ZjliMGQgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2Nsay9tZWRpYXRlay9LY29uZmlnDQorKysgYi9k
cml2ZXJzL2Nsay9tZWRpYXRlay9LY29uZmlnDQpAQCAtNTM5LDYgKzUzOSwxMiBAQCBjb25maWcg
Q09NTU9OX0NMS19NVDgxOTJfTURQU1lTDQogCWhlbHANCiAJICBUaGlzIGRyaXZlciBzdXBwb3J0
cyBNZWRpYVRlayBNVDgxOTIgbWRwc3lzIGNsb2Nrcy4NCiANCitjb25maWcgQ09NTU9OX0NMS19N
VDgxOTJfTUZHQ0ZHDQorCWJvb2wgIkNsb2NrIGRyaXZlciBmb3IgTWVkaWFUZWsgTVQ4MTkyIG1m
Z2NmZyINCisJZGVwZW5kcyBvbiBDT01NT05fQ0xLX01UODE5Mg0KKwloZWxwDQorCSAgVGhpcyBk
cml2ZXIgc3VwcG9ydHMgTWVkaWFUZWsgTVQ4MTkyIG1mZ2NmZyBjbG9ja3MuDQorDQogY29uZmln
IENPTU1PTl9DTEtfTVQ4NTE2DQogCWJvb2wgIkNsb2NrIGRyaXZlciBmb3IgTWVkaWFUZWsgTVQ4
NTE2Ig0KIAlkZXBlbmRzIG9uIEFSQ0hfTUVESUFURUsgfHwgQ09NUElMRV9URVNUDQpkaWZmIC0t
Z2l0IGEvZHJpdmVycy9jbGsvbWVkaWF0ZWsvTWFrZWZpbGUgYi9kcml2ZXJzL2Nsay9tZWRpYXRl
ay9NYWtlZmlsZQ0KaW5kZXggMGU1YzVkOC4uYTJiYjAwOSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMv
Y2xrL21lZGlhdGVrL01ha2VmaWxlDQorKysgYi9kcml2ZXJzL2Nsay9tZWRpYXRlay9NYWtlZmls
ZQ0KQEAgLTc3LDUgKzc3LDYgQEAgb2JqLSQoQ09ORklHX0NPTU1PTl9DTEtfTVQ4MTkyX0lNUF9J
SUNfV1JBUF9XKSArPSBjbGstbXQ4MTkyLWltcF9paWNfd3JhcF93Lm8NCiBvYmotJChDT05GSUdf
Q09NTU9OX0NMS19NVDgxOTJfSU1QX0lJQ19XUkFQX1dTKSArPSBjbGstbXQ4MTkyLWltcF9paWNf
d3JhcF93cy5vDQogb2JqLSQoQ09ORklHX0NPTU1PTl9DTEtfTVQ4MTkyX0lQRVNZUykgKz0gY2xr
LW10ODE5Mi1pcGUubw0KIG9iai0kKENPTkZJR19DT01NT05fQ0xLX01UODE5Ml9NRFBTWVMpICs9
IGNsay1tdDgxOTItbWRwLm8NCitvYmotJChDT05GSUdfQ09NTU9OX0NMS19NVDgxOTJfTUZHQ0ZH
KSArPSBjbGstbXQ4MTkyLW1mZy5vDQogb2JqLSQoQ09ORklHX0NPTU1PTl9DTEtfTVQ4NTE2KSAr
PSBjbGstbXQ4NTE2Lm8NCiBvYmotJChDT05GSUdfQ09NTU9OX0NMS19NVDg1MTZfQVVEU1lTKSAr
PSBjbGstbXQ4NTE2LWF1ZC5vDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9jbGsvbWVkaWF0ZWsvY2xr
LW10ODE5Mi1tZmcuYyBiL2RyaXZlcnMvY2xrL21lZGlhdGVrL2Nsay1tdDgxOTItbWZnLmMNCm5l
dyBmaWxlIG1vZGUgMTAwNjQ0DQppbmRleCAwMDAwMDAwLi5hZTZiMzgzDQotLS0gL2Rldi9udWxs
DQorKysgYi9kcml2ZXJzL2Nsay9tZWRpYXRlay9jbGstbXQ4MTkyLW1mZy5jDQpAQCAtMCwwICsx
LDU3IEBADQorLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb25seQ0KKy8vDQor
Ly8gQ29weXJpZ2h0IChjKSAyMDIwIE1lZGlhVGVrIEluYy4NCisvLyBBdXRob3I6IFdlaXlpIEx1
IDx3ZWl5aS5sdUBtZWRpYXRlay5jb20+DQorDQorI2luY2x1ZGUgPGxpbnV4L2Nsay1wcm92aWRl
ci5oPg0KKyNpbmNsdWRlIDxsaW51eC9wbGF0Zm9ybV9kZXZpY2UuaD4NCisNCisjaW5jbHVkZSAi
Y2xrLW10ay5oIg0KKyNpbmNsdWRlICJjbGstZ2F0ZS5oIg0KKw0KKyNpbmNsdWRlIDxkdC1iaW5k
aW5ncy9jbG9jay9tdDgxOTItY2xrLmg+DQorDQorc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfZ2F0
ZV9yZWdzIG1mZ19jZ19yZWdzID0gew0KKwkuc2V0X29mcyA9IDB4NCwNCisJLmNscl9vZnMgPSAw
eDgsDQorCS5zdGFfb2ZzID0gMHgwLA0KK307DQorDQorI2RlZmluZSBHQVRFX01GRyhfaWQsIF9u
YW1lLCBfcGFyZW50LCBfc2hpZnQpCVwNCisJR0FURV9NVEsoX2lkLCBfbmFtZSwgX3BhcmVudCwg
Jm1mZ19jZ19yZWdzLCBfc2hpZnQsICZtdGtfY2xrX2dhdGVfb3BzX3NldGNscikNCisNCitzdGF0
aWMgY29uc3Qgc3RydWN0IG10a19nYXRlIG1mZ19jbGtzW10gPSB7DQorCUdBVEVfTUZHKENMS19N
RkdfQkczRCwgIm1mZ19iZzNkIiwgIm1mZ19wbGxfc2VsIiwgMCksDQorfTsNCisNCitzdGF0aWMg
aW50IGNsa19tdDgxOTJfbWZnX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQor
ew0KKwlzdHJ1Y3QgY2xrX29uZWNlbGxfZGF0YSAqY2xrX2RhdGE7DQorCXN0cnVjdCBkZXZpY2Vf
bm9kZSAqbm9kZSA9IHBkZXYtPmRldi5vZl9ub2RlOw0KKwlpbnQgcjsNCisNCisJY2xrX2RhdGEg
PSBtdGtfYWxsb2NfY2xrX2RhdGEoQ0xLX01GR19OUl9DTEspOw0KKwlpZiAoIWNsa19kYXRhKQ0K
KwkJcmV0dXJuIC1FTk9NRU07DQorDQorCXIgPSBtdGtfY2xrX3JlZ2lzdGVyX2dhdGVzKG5vZGUs
IG1mZ19jbGtzLCBBUlJBWV9TSVpFKG1mZ19jbGtzKSwgY2xrX2RhdGEpOw0KKwlpZiAocikNCisJ
CXJldHVybiByOw0KKw0KKwlyZXR1cm4gb2ZfY2xrX2FkZF9wcm92aWRlcihub2RlLCBvZl9jbGtf
c3JjX29uZWNlbGxfZ2V0LCBjbGtfZGF0YSk7DQorfQ0KKw0KK3N0YXRpYyBjb25zdCBzdHJ1Y3Qg
b2ZfZGV2aWNlX2lkIG9mX21hdGNoX2Nsa19tdDgxOTJfbWZnW10gPSB7DQorCXsgLmNvbXBhdGli
bGUgPSAibWVkaWF0ZWssbXQ4MTkyLW1mZ2NmZyIsIH0sDQorCXt9DQorfTsNCisNCitzdGF0aWMg
c3RydWN0IHBsYXRmb3JtX2RyaXZlciBjbGtfbXQ4MTkyX21mZ19kcnYgPSB7DQorCS5wcm9iZSA9
IGNsa19tdDgxOTJfbWZnX3Byb2JlLA0KKwkuZHJpdmVyID0gew0KKwkJLm5hbWUgPSAiY2xrLW10
ODE5Mi1tZmciLA0KKwkJLm9mX21hdGNoX3RhYmxlID0gb2ZfbWF0Y2hfY2xrX210ODE5Ml9tZmcs
DQorCX0sDQorfTsNCisNCitidWlsdGluX3BsYXRmb3JtX2RyaXZlcihjbGtfbXQ4MTkyX21mZ19k
cnYpOw0KLS0gDQoxLjguMS4xLmRpcnR5DQo=


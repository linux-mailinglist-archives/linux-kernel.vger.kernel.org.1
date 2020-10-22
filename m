Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 194FB295EA8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 14:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2898294AbgJVMhv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 08:37:51 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:33545 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2898284AbgJVMhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 08:37:50 -0400
X-UUID: bdfb4d33aa8c4240b2d89c4d6941ad59-20201022
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=8BjKNcZMoHnW3Ca0V7ucDH/EYdJ9P9beBOvuF8WRA7I=;
        b=mTunhcZt9qz9X4u6Oi4CoEeXJGNOZJtKNSKjwaRzsLiOknOsSxs2A0cZk/5DwFzkNWIzAZKmOYBr4fb58i+Z24Tgbyee/XrGeCQxDyxfEKefAtCdg+EvaqhS4KrixnjDAIBNftlvsK3GfPtywG6GEt+c8wNORgmrnuQqKftYPtM=;
X-UUID: bdfb4d33aa8c4240b2d89c4d6941ad59-20201022
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 480441456; Thu, 22 Oct 2020 20:37:46 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 22 Oct 2020 20:37:44 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 22 Oct 2020 20:37:44 +0800
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <srv_heupstream@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>
Subject: [PATCH v4 01/34] dt-bindings: ARM: Mediatek: Add new document bindings of camsys raw controller
Date:   Thu, 22 Oct 2020 20:36:54 +0800
Message-ID: <1603370247-30437-2-git-send-email-weiyi.lu@mediatek.com>
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

VGhpcyBwYXRjaCBhZGRzIHRoZSBuZXcgYmluZGluZyBkb2N1bWVudGF0aW9uIG9mIGNhbXN5cyBy
YXcgY29udHJvbGxlcg0KZm9yIE1lZGlhdGVrIE1UODE5Mi4NCg0KU2lnbmVkLW9mZi1ieTogV2Vp
eWkgTHUgPHdlaXlpLmx1QG1lZGlhdGVrLmNvbT4NCi0tLQ0KIC4uLi9iaW5kaW5ncy9hcm0vbWVk
aWF0ZWsvbWVkaWF0ZWssY2Ftc3lzLXJhdy55YW1sIHwgNTQgKysrKysrKysrKysrKysrKysrKysr
Kw0KIDEgZmlsZSBjaGFuZ2VkLCA1NCBpbnNlcnRpb25zKCspDQogY3JlYXRlIG1vZGUgMTAwNjQ0
IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vbWVkaWF0ZWsvbWVkaWF0ZWss
Y2Ftc3lzLXJhdy55YW1sDQoNCmRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvYXJtL21lZGlhdGVrL21lZGlhdGVrLGNhbXN5cy1yYXcueWFtbCBiL0RvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vbWVkaWF0ZWsvbWVkaWF0ZWssY2Ftc3lzLXJh
dy55YW1sDQpuZXcgZmlsZSBtb2RlIDEwMDY0NA0KaW5kZXggMDAwMDAwMC4uZWIzOTVmZg0KLS0t
IC9kZXYvbnVsbA0KKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9t
ZWRpYXRlay9tZWRpYXRlayxjYW1zeXMtcmF3LnlhbWwNCkBAIC0wLDAgKzEsNTQgQEANCisjIFNQ
RFgtTGljZW5zZS1JZGVudGlmaWVyOiAoR1BMLTIuMCBPUiBCU0QtMi1DbGF1c2UpDQorJVlBTUwg
MS4yDQorLS0tDQorJGlkOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvc2NoZW1hcy9hcm0vbWVkaWF0
ZWsvbWVkaWF0ZWssY2Ftc3lzLXJhdy55YW1sIw0KKyRzY2hlbWE6IGh0dHA6Ly9kZXZpY2V0cmVl
Lm9yZy9tZXRhLXNjaGVtYXMvY29yZS55YW1sIw0KKw0KK3RpdGxlOiBNZWRpYVRlayBDQU1TWVMg
UkFXIENvbnRyb2xsZXINCisNCittYWludGFpbmVyczoNCisgIC0gV2VpeWkgTHUgPHdlaXlpLmx1
QG1lZGlhdGVrLmNvbT4NCisNCitkZXNjcmlwdGlvbjoNCisgIFRoZSBNZWRpYXRlayBjYW1zeXMg
cmF3IGNvbnRyb2xsZXIgcHJvdmlkZXMgZnVuY3Rpb25hbCBjb25maWd1cmF0aW9ucyBhbmQgY2xv
Y2tzIHRvIHRoZSBzeXN0ZW0uDQorDQorcHJvcGVydGllczoNCisgIGNvbXBhdGlibGU6DQorICAg
IGl0ZW1zOg0KKyAgICAgIC0gZW51bToNCisgICAgICAgICAgLSBtZWRpYXRlayxtdDgxOTItY2Ft
c3lzX3Jhd2ENCisgICAgICAgICAgLSBtZWRpYXRlayxtdDgxOTItY2Ftc3lzX3Jhd2INCisgICAg
ICAgICAgLSBtZWRpYXRlayxtdDgxOTItY2Ftc3lzX3Jhd2MNCisgICAgICAtIGNvbnN0OiBzeXNj
b24NCisNCisgIHJlZzoNCisgICAgbWF4SXRlbXM6IDENCisNCisgICcjY2xvY2stY2VsbHMnOg0K
KyAgICBjb25zdDogMQ0KKw0KK3JlcXVpcmVkOg0KKyAgLSBjb21wYXRpYmxlDQorICAtIHJlZw0K
Kw0KK2V4YW1wbGVzOg0KKyAgLSB8DQorICAgIGNhbXN5c19yYXdhOiBzeXNjb25AMWEwNGYwMDAg
ew0KKyAgICAgICAgY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxOTItY2Ftc3lzX3Jhd2EiLCAi
c3lzY29uIjsNCisgICAgICAgIHJlZyA9IDwwIDB4MWEwNGYwMDAgMCAweDEwMDA+Ow0KKyAgICAg
ICAgI2Nsb2NrLWNlbGxzID0gPDE+Ow0KKyAgICB9Ow0KKw0KKyAgLSB8DQorICAgIGNhbXN5c19y
YXdiOiBzeXNjb25AMWEwNmYwMDAgew0KKyAgICAgICAgY29tcGF0aWJsZSA9ICJtZWRpYXRlayxt
dDgxOTItY2Ftc3lzX3Jhd2IiLCAic3lzY29uIjsNCisgICAgICAgIHJlZyA9IDwwIDB4MWEwNmYw
MDAgMCAweDEwMDA+Ow0KKyAgICAgICAgI2Nsb2NrLWNlbGxzID0gPDE+Ow0KKyAgICB9Ow0KKw0K
KyAgLSB8DQorICAgIGNhbXN5c19yYXdjOiBzeXNjb25AMWEwOGYwMDAgew0KKyAgICAgICAgY29t
cGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxOTItY2Ftc3lzX3Jhd2MiLCAic3lzY29uIjsNCisgICAg
ICAgIHJlZyA9IDwwIDB4MWEwOGYwMDAgMCAweDEwMDA+Ow0KKyAgICAgICAgI2Nsb2NrLWNlbGxz
ID0gPDE+Ow0KKyAgICB9Ow0KLS0gDQoxLjguMS4xLmRpcnR5DQo=


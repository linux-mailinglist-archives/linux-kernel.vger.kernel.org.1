Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA6C2DBFCE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 12:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725881AbgLPLwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 06:52:14 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:52884 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725813AbgLPLwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 06:52:14 -0500
X-UUID: 9d68a3093b0846b9afcb0e9a55e1e1a4-20201216
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=uZ8IiL/fzdanWEFXnYLIQv+1Tb9+DTkbQHMVp3WgntA=;
        b=g9KXf9rwP4CunePP+M1jTWdubVKoW3I33pHJ+jLZRL2Dr/YsPpVpVr+q/90bfJ1L2BanMdix+gReKx6u57LDZFVsqVomzoAQ9ClmxyxkN65Y6oEZj6sKguPVYAT8lVNg6pAHY0gtgVGUXXqVAcZnkusvYnlsl9OnWumh8mbk7bI=;
X-UUID: 9d68a3093b0846b9afcb0e9a55e1e1a4-20201216
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1606420764; Wed, 16 Dec 2020 19:51:27 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 16 Dec 2020 19:51:26 +0800
Received: from mtkslt301.mediatek.inc (10.21.14.114) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 16 Dec 2020 19:51:25 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>
CC:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Hsin-Yi Wang <hsinyi@chromium.org>,
        Ikjoon Jang <ikjn@chromium.org>
Subject: [PATCH 1/3] dt-bindings: usb: mtk-xhci: add a new property for broken streams
Date:   Wed, 16 Dec 2020 19:51:23 +0800
Message-ID: <20201216115125.5886-1-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 543A3BC3B3871456BBC367ADBF6CC8A1ECEF19BEE1819E94475040288A10DC482000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIDAuOTYgeEhDSSBjb250cm9sbGVyIG9uIHNvbWUgcGxhdGZvcm1zIGRvZXMgbm90IHN1cHBv
cnQNCmJ1bGsgc3RyZWFtIGV2ZW4gSENDUEFSQU1TIHNheXMgc3VwcG9ydGluZywgZHVlIHRvIE1h
eFBTQVNpemUNCmlzIHNldCBhIG5vbi16ZXJvIGRlZmF1bHQgdmFsdWUgYnkgbWlzdGFrZSwgc28g
YWRkIGEgbmV3DQpwcm9wZXJ0eSAibWVkaWF0ZWssYnJva2VuX3N0cmVhbXNfcXVpcmsiIHRvIGZp
eCBpdC4NCg0KU2lnbmVkLW9mZi1ieTogQ2h1bmZlbmcgWXVuIDxjaHVuZmVuZy55dW5AbWVkaWF0
ZWsuY29tPg0KLS0tDQp0aGlzIHBhdGNoIGRlcGVuZHMgb246DQogIGh0dHBzOi8vcGF0Y2h3b3Jr
Lmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC1tZWRpYXRlay9saXN0Lz9zZXJpZXM9NDAyNzczDQog
IFt2NCwwOS8xMV0gZHQtYmluZGluZ3M6IHVzYjogY29udmVydCBtZWRpYXRlaywgbXRrLXhoY2ku
dHh0IHRvIFlBTUwgc2NoZW1hDQotLS0NCiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvdXNiL21lZGlhdGVrLG10ay14aGNpLnlhbWwgfCA1ICsrKysrDQogMSBmaWxlIGNoYW5nZWQs
IDUgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL3VzYi9tZWRpYXRlayxtdGsteGhjaS55YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL3VzYi9tZWRpYXRlayxtdGsteGhjaS55YW1sDQppbmRleCBlNWUwM2Y5
MDI4MDIuLjMzMGY3Mjk0YmYzNCAxMDA2NDQNCi0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy91c2IvbWVkaWF0ZWssbXRrLXhoY2kueWFtbA0KKysrIGIvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL3VzYi9tZWRpYXRlayxtdGsteGhjaS55YW1sDQpAQCAtMTIw
LDYgKzEyMCwxMSBAQCBwcm9wZXJ0aWVzOg0KICAgICBkZXNjcmlwdGlvbjogVGhlIG1hc2sgdG8g
ZGlzYWJsZSB1M3BvcnRzLCBiaXQwIGZvciB1M3BvcnQwLA0KICAgICAgIGJpdDEgZm9yIHUzcG9y
dDEsIC4uLiBldGMNCiANCisgIG1lZGlhdGVrLGJyb2tlbl9zdHJlYW1zX3F1aXJrOg0KKyAgICBk
ZXNjcmlwdGlvbjogc2V0IGlmIHRoZSBjb250cm9sbGVyIGRvZXNuJ3Qgc3VwcG9ydCBidWxrIHN0
cmVhbSBidXQNCisgICAgICBIQ0NQQVJBTVMgc2F5cyBzdXBwb3J0Lg0KKyAgICB0eXBlOiBib29s
ZWFuDQorDQogICAiI2FkZHJlc3MtY2VsbHMiOg0KICAgICBjb25zdDogMQ0KIA0KLS0gDQoyLjE4
LjANCg==


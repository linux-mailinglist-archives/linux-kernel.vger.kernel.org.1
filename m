Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51BA12AAF2C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 03:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729272AbgKICNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 21:13:53 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:34079 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729122AbgKICNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 21:13:50 -0500
X-UUID: cc31ee484efa45f1b6ab59b19aaaa165-20201109
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=QlhqHmExJr7bFeJvbeIelmUzxCN0Mr1DDN2ACbWyT0M=;
        b=lsng0K1QC1fgRrwd4jPFg2pG1EbIjvfXhScLFXv6IdHYrkUgDBE2deEeL8DxOh/pckrpbhBXj+XI3bXILoocO+gUMWe4nKimNGcEWoebYRxzb+uKmZsJ3D+J6tfnMWj4gXCnuTKIbrNRWd/EzB28pMQi6R01Ut4tw73iFwkhdhI=;
X-UUID: cc31ee484efa45f1b6ab59b19aaaa165-20201109
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2127836350; Mon, 09 Nov 2020 10:13:46 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 9 Nov 2020 10:13:45 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 9 Nov 2020 10:13:37 +0800
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <srv_heupstream@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>
Subject: [PATCH v2 08/13] clk: mediatek: Clean up the pll_en_bit from en_mask on MT8135
Date:   Mon, 9 Nov 2020 10:13:23 +0800
Message-ID: <1604888008-30555-9-git-send-email-weiyi.lu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1604888008-30555-1-git-send-email-weiyi.lu@mediatek.com>
References: <1604888008-30555-1-git-send-email-weiyi.lu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cmVtb3ZlIHBsbF9lbl9iaXQoYml0MCkgZnJvbSBlbl9tYXNrIHRvIG1ha2UgZW5fbWFzayBhIHB1
cmUgZW5fbWFzaw0KdGhhdCBvbmx5IHVzZWQgZm9yIHBsbCBkaXZpZGVycy4NCg0KU2lnbmVkLW9m
Zi1ieTogV2VpeWkgTHUgPHdlaXlpLmx1QG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGRyaXZlcnMvY2xr
L21lZGlhdGVrL2Nsay1tdDgxMzUuYyB8IDIwICsrKysrKysrKystLS0tLS0tLS0tDQogMSBmaWxl
IGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDEwIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0
IGEvZHJpdmVycy9jbGsvbWVkaWF0ZWsvY2xrLW10ODEzNS5jIGIvZHJpdmVycy9jbGsvbWVkaWF0
ZWsvY2xrLW10ODEzNS5jDQppbmRleCA5YjRiNjQ1Li5hMWQ0NjJmIDEwMDY0NA0KLS0tIGEvZHJp
dmVycy9jbGsvbWVkaWF0ZWsvY2xrLW10ODEzNS5jDQorKysgYi9kcml2ZXJzL2Nsay9tZWRpYXRl
ay9jbGstbXQ4MTM1LmMNCkBAIC02MTEsMTYgKzYxMSwxNiBAQCBzdGF0aWMgdm9pZCBfX2luaXQg
bXRrX3BlcmljZmdfaW5pdChzdHJ1Y3QgZGV2aWNlX25vZGUgKm5vZGUpDQogCX0NCiANCiBzdGF0
aWMgY29uc3Qgc3RydWN0IG10a19wbGxfZGF0YSBwbGxzW10gPSB7DQotCVBMTChDTEtfQVBNSVhF
RF9BUk1QTEwxLCAiYXJtcGxsMSIsIDB4MjAwLCAweDIxOCwgMHg4MDAwMDAwMSwgMCwgMjEsIDB4
MjA0LCAyNCwgMHgwLCAweDIwNCwgMCksDQotCVBMTChDTEtfQVBNSVhFRF9BUk1QTEwyLCAiYXJt
cGxsMiIsIDB4MmNjLCAweDJlNCwgMHg4MDAwMDAwMSwgMCwgMjEsIDB4MmQwLCAyNCwgMHgwLCAw
eDJkMCwgMCksDQotCVBMTChDTEtfQVBNSVhFRF9NQUlOUExMLCAibWFpbnBsbCIsIDB4MjFjLCAw
eDIzNCwgMHhmMDAwMDAwMSwgSEFWRV9SU1RfQkFSLCAyMSwgMHgyMWMsIDYsIDB4MCwgMHgyMjAs
IDApLA0KLQlQTEwoQ0xLX0FQTUlYRURfVU5JVlBMTCwgInVuaXZwbGwiLCAweDIzOCwgMHgyNTAs
IDB4ZjMwMDAwMDEsIEhBVkVfUlNUX0JBUiwgNywgMHgyMzgsIDYsIDB4MCwgMHgyMzgsIDkpLA0K
LQlQTEwoQ0xLX0FQTUlYRURfTU1QTEwsICJtbXBsbCIsIDB4MjU0LCAweDI2YywgMHhmMDAwMDAw
MSwgSEFWRV9SU1RfQkFSLCAyMSwgMHgyNTQsIDYsIDB4MCwgMHgyNTgsIDApLA0KLQlQTEwoQ0xL
X0FQTUlYRURfTVNEQ1BMTCwgIm1zZGNwbGwiLCAweDI3OCwgMHgyOTAsIDB4ODAwMDAwMDEsIDAs
IDIxLCAweDI3OCwgNiwgMHgwLCAweDI3YywgMCksDQotCVBMTChDTEtfQVBNSVhFRF9UVkRQTEws
ICJ0dmRwbGwiLCAweDI5NCwgMHgyYWMsIDB4ODAwMDAwMDEsIDAsIDMxLCAweDI5NCwgNiwgMHgw
LCAweDI5OCwgMCksDQotCVBMTChDTEtfQVBNSVhFRF9MVkRTUExMLCAibHZkc3BsbCIsIDB4MmIw
LCAweDJjOCwJMHg4MDAwMDAwMSwgMCwgMjEsIDB4MmIwLCA2LCAweDAsIDB4MmI0LCAwKSwNCi0J
UExMKENMS19BUE1JWEVEX0FVRFBMTCwgImF1ZHBsbCIsIDB4MmU4LCAweDMwMCwgMHg4MDAwMDAw
MSwgMCwgMzEsIDB4MmU4LCA2LCAweDJmOCwgMHgyZWMsIDApLA0KLQlQTEwoQ0xLX0FQTUlYRURf
VkRFQ1BMTCwgInZkZWNwbGwiLCAweDMwNCwgMHgzMWMsCTB4ODAwMDAwMDEsIDAsIDIxLCAweDJi
MCwgNiwgMHgwLCAweDMwOCwgMCksDQorCVBMTChDTEtfQVBNSVhFRF9BUk1QTEwxLCAiYXJtcGxs
MSIsIDB4MjAwLCAweDIxOCwgMHg4MDAwMDAwMCwgMCwgMjEsIDB4MjA0LCAyNCwgMHgwLCAweDIw
NCwgMCksDQorCVBMTChDTEtfQVBNSVhFRF9BUk1QTEwyLCAiYXJtcGxsMiIsIDB4MmNjLCAweDJl
NCwgMHg4MDAwMDAwMCwgMCwgMjEsIDB4MmQwLCAyNCwgMHgwLCAweDJkMCwgMCksDQorCVBMTChD
TEtfQVBNSVhFRF9NQUlOUExMLCAibWFpbnBsbCIsIDB4MjFjLCAweDIzNCwgMHhmMDAwMDAwMCwg
SEFWRV9SU1RfQkFSLCAyMSwgMHgyMWMsIDYsIDB4MCwgMHgyMjAsIDApLA0KKwlQTEwoQ0xLX0FQ
TUlYRURfVU5JVlBMTCwgInVuaXZwbGwiLCAweDIzOCwgMHgyNTAsIDB4ZjMwMDAwMDAsIEhBVkVf
UlNUX0JBUiwgNywgMHgyMzgsIDYsIDB4MCwgMHgyMzgsIDkpLA0KKwlQTEwoQ0xLX0FQTUlYRURf
TU1QTEwsICJtbXBsbCIsIDB4MjU0LCAweDI2YywgMHhmMDAwMDAwMCwgSEFWRV9SU1RfQkFSLCAy
MSwgMHgyNTQsIDYsIDB4MCwgMHgyNTgsIDApLA0KKwlQTEwoQ0xLX0FQTUlYRURfTVNEQ1BMTCwg
Im1zZGNwbGwiLCAweDI3OCwgMHgyOTAsIDB4ODAwMDAwMDAsIDAsIDIxLCAweDI3OCwgNiwgMHgw
LCAweDI3YywgMCksDQorCVBMTChDTEtfQVBNSVhFRF9UVkRQTEwsICJ0dmRwbGwiLCAweDI5NCwg
MHgyYWMsIDB4ODAwMDAwMDAsIDAsIDMxLCAweDI5NCwgNiwgMHgwLCAweDI5OCwgMCksDQorCVBM
TChDTEtfQVBNSVhFRF9MVkRTUExMLCAibHZkc3BsbCIsIDB4MmIwLCAweDJjOCwgMHg4MDAwMDAw
MCwgMCwgMjEsIDB4MmIwLCA2LCAweDAsIDB4MmI0LCAwKSwNCisJUExMKENMS19BUE1JWEVEX0FV
RFBMTCwgImF1ZHBsbCIsIDB4MmU4LCAweDMwMCwgMHg4MDAwMDAwMCwgMCwgMzEsIDB4MmU4LCA2
LCAweDJmOCwgMHgyZWMsIDApLA0KKwlQTEwoQ0xLX0FQTUlYRURfVkRFQ1BMTCwgInZkZWNwbGwi
LCAweDMwNCwgMHgzMWMsIDB4ODAwMDAwMDAsIDAsIDIxLCAweDJiMCwgNiwgMHgwLCAweDMwOCwg
MCksDQogfTsNCiANCiBzdGF0aWMgdm9pZCBfX2luaXQgbXRrX2FwbWl4ZWRzeXNfaW5pdChzdHJ1
Y3QgZGV2aWNlX25vZGUgKm5vZGUpDQotLSANCjEuOC4xLjEuZGlydHkNCg==


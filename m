Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91C102AAF21
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 03:13:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729096AbgKICNj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 21:13:39 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:38098 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727979AbgKICNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 21:13:39 -0500
X-UUID: 8a66fb0d62a94e6cbccb0f359751fadb-20201109
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=EUkS5vMfyxWNPzqJNif1jjSdSlifFVaP4B0ZERrWUm4=;
        b=NKVln1wvqb29v078sikiS8YZjefEI6nBgITYiubc4kYYIL5t38j+49VejwwNUZXred9H0AMqY/oq4/UcZhsB4m3+PnOP4eAL9A0NP80t6xQy79XWl0e852K4hRqEeMz6YMp2TqoQAn5hNpHEVrqsnxAZ17+C6Si0fncerHXS1xc=;
X-UUID: 8a66fb0d62a94e6cbccb0f359751fadb-20201109
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 921247070; Mon, 09 Nov 2020 10:13:37 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 9 Nov 2020 10:13:38 +0800
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
Subject: [PATCH v2 06/13] clk: mediatek: Clean up the pll_en_bit from en_mask on MT7622
Date:   Mon, 9 Nov 2020 10:13:21 +0800
Message-ID: <1604888008-30555-7-git-send-email-weiyi.lu@mediatek.com>
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
L21lZGlhdGVrL2Nsay1tdDc2MjIuYyB8IDE4ICsrKysrKysrKy0tLS0tLS0tLQ0KIDEgZmlsZSBj
aGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9k
cml2ZXJzL2Nsay9tZWRpYXRlay9jbGstbXQ3NjIyLmMgYi9kcml2ZXJzL2Nsay9tZWRpYXRlay9j
bGstbXQ3NjIyLmMNCmluZGV4IGVmNTk0N2UxLi4yZmRiMjdhIDEwMDY0NA0KLS0tIGEvZHJpdmVy
cy9jbGsvbWVkaWF0ZWsvY2xrLW10NzYyMi5jDQorKysgYi9kcml2ZXJzL2Nsay9tZWRpYXRlay9j
bGstbXQ3NjIyLmMNCkBAIC0zMjgsMjMgKzMyOCwyMyBAQA0KIH07DQogDQogc3RhdGljIGNvbnN0
IHN0cnVjdCBtdGtfcGxsX2RhdGEgcGxsc1tdID0gew0KLQlQTEwoQ0xLX0FQTUlYRURfQVJNUExM
LCAiYXJtcGxsIiwgMHgwMjAwLCAweDAyMEMsIDB4MDAwMDAwMDEsDQorCVBMTChDTEtfQVBNSVhF
RF9BUk1QTEwsICJhcm1wbGwiLCAweDAyMDAsIDB4MDIwQywgMCwNCiAJICAgIFBMTF9BTywgMjEs
IDB4MDIwNCwgMjQsIDAsIDB4MDIwNCwgMCksDQotCVBMTChDTEtfQVBNSVhFRF9NQUlOUExMLCAi
bWFpbnBsbCIsIDB4MDIxMCwgMHgwMjFDLCAweDAwMDAwMDAxLA0KKwlQTEwoQ0xLX0FQTUlYRURf
TUFJTlBMTCwgIm1haW5wbGwiLCAweDAyMTAsIDB4MDIxQywgMCwNCiAJICAgIEhBVkVfUlNUX0JB
UiwgMjEsIDB4MDIxNCwgMjQsIDAsIDB4MDIxNCwgMCksDQotCVBMTChDTEtfQVBNSVhFRF9VTklW
MlBMTCwgInVuaXYycGxsIiwgMHgwMjIwLCAweDAyMkMsIDB4MDAwMDAwMDEsDQorCVBMTChDTEtf
QVBNSVhFRF9VTklWMlBMTCwgInVuaXYycGxsIiwgMHgwMjIwLCAweDAyMkMsIDAsDQogCSAgICBI
QVZFX1JTVF9CQVIsIDcsIDB4MDIyNCwgMjQsIDAsIDB4MDIyNCwgMTQpLA0KLQlQTEwoQ0xLX0FQ
TUlYRURfRVRIMVBMTCwgImV0aDFwbGwiLCAweDAzMDAsIDB4MDMxMCwgMHgwMDAwMDAwMSwNCisJ
UExMKENMS19BUE1JWEVEX0VUSDFQTEwsICJldGgxcGxsIiwgMHgwMzAwLCAweDAzMTAsIDAsDQog
CSAgICAwLCAyMSwgMHgwMzAwLCAxLCAwLCAweDAzMDQsIDApLA0KLQlQTEwoQ0xLX0FQTUlYRURf
RVRIMlBMTCwgImV0aDJwbGwiLCAweDAzMTQsIDB4MDMyMCwgMHgwMDAwMDAwMSwNCisJUExMKENM
S19BUE1JWEVEX0VUSDJQTEwsICJldGgycGxsIiwgMHgwMzE0LCAweDAzMjAsIDAsDQogCSAgICAw
LCAyMSwgMHgwMzE0LCAxLCAwLCAweDAzMTgsIDApLA0KLQlQTEwoQ0xLX0FQTUlYRURfQVVEMVBM
TCwgImF1ZDFwbGwiLCAweDAzMjQsIDB4MDMzMCwgMHgwMDAwMDAwMSwNCisJUExMKENMS19BUE1J
WEVEX0FVRDFQTEwsICJhdWQxcGxsIiwgMHgwMzI0LCAweDAzMzAsIDAsDQogCSAgICAwLCAzMSwg
MHgwMzI0LCAxLCAwLCAweDAzMjgsIDApLA0KLQlQTEwoQ0xLX0FQTUlYRURfQVVEMlBMTCwgImF1
ZDJwbGwiLCAweDAzMzQsIDB4MDM0MCwgMHgwMDAwMDAwMSwNCisJUExMKENMS19BUE1JWEVEX0FV
RDJQTEwsICJhdWQycGxsIiwgMHgwMzM0LCAweDAzNDAsIDAsDQogCSAgICAwLCAzMSwgMHgwMzM0
LCAxLCAwLCAweDAzMzgsIDApLA0KLQlQTEwoQ0xLX0FQTUlYRURfVFJHUExMLCAidHJncGxsIiwg
MHgwMzQ0LCAweDAzNTQsIDB4MDAwMDAwMDEsDQorCVBMTChDTEtfQVBNSVhFRF9UUkdQTEwsICJ0
cmdwbGwiLCAweDAzNDQsIDB4MDM1NCwgMCwNCiAJICAgIDAsIDIxLCAweDAzNDQsIDEsIDAsIDB4
MDM0OCwgMCksDQotCVBMTChDTEtfQVBNSVhFRF9TR01JUExMLCAic2dtaXBsbCIsIDB4MDM1OCwg
MHgwMzY4LCAweDAwMDAwMDAxLA0KKwlQTEwoQ0xLX0FQTUlYRURfU0dNSVBMTCwgInNnbWlwbGwi
LCAweDAzNTgsIDB4MDM2OCwgMCwNCiAJICAgIDAsIDIxLCAweDAzNTgsIDEsIDAsIDB4MDM1Qywg
MCksDQogfTsNCiANCi0tIA0KMS44LjEuMS5kaXJ0eQ0K


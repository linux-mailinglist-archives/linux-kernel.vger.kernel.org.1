Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEDBA295F06
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 14:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2899031AbgJVM4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 08:56:12 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:44034 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2899019AbgJVM4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 08:56:11 -0400
X-UUID: 77d5e81c11a241a697448bb15ca100ee-20201022
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=EUkS5vMfyxWNPzqJNif1jjSdSlifFVaP4B0ZERrWUm4=;
        b=gj7wZ/C5XBtIx2j5OUHPIXtG4vYYnE9Zv/5S4K5DVDOi+GD4owcHjxjy4IzSEHD0PopGUMwV0GsrkC4gq31PkyorpaqBXaR4/2+o1UhU1ruPAcgYBqrZeAvq1mkaNYjiap99SDKOJavsryL+O/D+JdGKYfO7NSoe7ESBhQW5HMQ=;
X-UUID: 77d5e81c11a241a697448bb15ca100ee-20201022
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1756904148; Thu, 22 Oct 2020 20:56:08 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 22 Oct 2020 20:56:07 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 22 Oct 2020 20:56:07 +0800
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <srv_heupstream@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>
Subject: [PATCH 06/12] clk: mediatek: Clean up the pll_en_bit from en_mask on MT7622
Date:   Thu, 22 Oct 2020 20:55:59 +0800
Message-ID: <1603371365-30863-7-git-send-email-weiyi.lu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1603371365-30863-1-git-send-email-weiyi.lu@mediatek.com>
References: <1603371365-30863-1-git-send-email-weiyi.lu@mediatek.com>
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


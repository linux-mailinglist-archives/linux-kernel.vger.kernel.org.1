Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B832295F19
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 14:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2899121AbgJVM4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 08:56:52 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:51623 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2899036AbgJVM4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 08:56:15 -0400
X-UUID: e2e1ffa7ef714839a3c6c46639f1c6db-20201022
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=mLVJZzUdKWNQx6sboJRMvv57fSyk79wYYBx5PcMMYdM=;
        b=QJ1IsxGBHm8yWj8TDeRs3Ewn94nrJiCPtfkHbzYDOCc+7xMHiRkoRahSN0qobqDyIAXOfPyYQNiEPO/TseiF8S7TRbBDSZ+qsr40HBlh+WG5VsEsbwAb/+CYATM/4bXV/peojFWTYYU+zDw1HpbiuoRmsScrO4vYa68zi2lateQ=;
X-UUID: e2e1ffa7ef714839a3c6c46639f1c6db-20201022
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1741842927; Thu, 22 Oct 2020 20:56:08 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
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
Subject: [PATCH 05/12] clk: mediatek: Clean up the pll_en_bit from en_mask on MT6797
Date:   Thu, 22 Oct 2020 20:55:58 +0800
Message-ID: <1603371365-30863-6-git-send-email-weiyi.lu@mediatek.com>
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
L21lZGlhdGVrL2Nsay1tdDY3OTcuYyB8IDIwICsrKysrKysrKystLS0tLS0tLS0tDQogMSBmaWxl
IGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDEwIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0
IGEvZHJpdmVycy9jbGsvbWVkaWF0ZWsvY2xrLW10Njc5Ny5jIGIvZHJpdmVycy9jbGsvbWVkaWF0
ZWsvY2xrLW10Njc5Ny5jDQppbmRleCBmMzUzODlhLi40Mzk1NDIzIDEwMDY0NA0KLS0tIGEvZHJp
dmVycy9jbGsvbWVkaWF0ZWsvY2xrLW10Njc5Ny5jDQorKysgYi9kcml2ZXJzL2Nsay9tZWRpYXRl
ay9jbGstbXQ2Nzk3LmMNCkBAIC02MzgsMjUgKzYzOCwyNSBAQCBzdGF0aWMgaW50IG10a19pbmZy
YXN5c19pbml0KHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQogCQkJTlVMTCkNCiANCiBz
dGF0aWMgY29uc3Qgc3RydWN0IG10a19wbGxfZGF0YSBwbGxzW10gPSB7DQotCVBMTChDTEtfQVBN
SVhFRF9NQUlOUExMLCAibWFpbnBsbCIsIDB4MDIyMCwgMHgwMjJDLCAweEYwMDAwMTAxLCBQTExf
QU8sDQorCVBMTChDTEtfQVBNSVhFRF9NQUlOUExMLCAibWFpbnBsbCIsIDB4MDIyMCwgMHgwMjJD
LCAweEYwMDAwMTAwLCBQTExfQU8sDQogCSAgICAyMSwgMHgyMjAsIDQsIDB4MCwgMHgyMjQsIDAp
LA0KLQlQTEwoQ0xLX0FQTUlYRURfVU5JVlBMTCwgInVuaXZwbGwiLCAweDAyMzAsIDB4MDIzQywg
MHhGRTAwMDAxMSwgMCwgNywNCisJUExMKENMS19BUE1JWEVEX1VOSVZQTEwsICJ1bml2cGxsIiwg
MHgwMjMwLCAweDAyM0MsIDB4RkUwMDAwMTAsIDAsIDcsDQogCSAgICAweDIzMCwgNCwgMHgwLCAw
eDIzNCwgMTQpLA0KLQlQTEwoQ0xLX0FQTUlYRURfTUZHUExMLCAibWZncGxsIiwgMHgwMjQwLCAw
eDAyNEMsIDB4MDAwMDAxMDEsIDAsIDIxLA0KKwlQTEwoQ0xLX0FQTUlYRURfTUZHUExMLCAibWZn
cGxsIiwgMHgwMjQwLCAweDAyNEMsIDB4MDAwMDAxMDAsIDAsIDIxLA0KIAkgICAgMHgyNDQsIDI0
LCAweDAsIDB4MjQ0LCAwKSwNCi0JUExMKENMS19BUE1JWEVEX01TRENQTEwsICJtc2RjcGxsIiwg
MHgwMjUwLCAweDAyNUMsIDB4MDAwMDAxMjEsIDAsIDIxLA0KKwlQTEwoQ0xLX0FQTUlYRURfTVNE
Q1BMTCwgIm1zZGNwbGwiLCAweDAyNTAsIDB4MDI1QywgMHgwMDAwMDEyMCwgMCwgMjEsDQogCSAg
ICAweDI1MCwgNCwgMHgwLCAweDI1NCwgMCksDQotCVBMTChDTEtfQVBNSVhFRF9JTUdQTEwsICJp
bWdwbGwiLCAweDAyNjAsIDB4MDI2QywgMHgwMDAwMDEyMSwgMCwgMjEsDQorCVBMTChDTEtfQVBN
SVhFRF9JTUdQTEwsICJpbWdwbGwiLCAweDAyNjAsIDB4MDI2QywgMHgwMDAwMDEyMCwgMCwgMjEs
DQogCSAgICAweDI2MCwgNCwgMHgwLCAweDI2NCwgMCksDQotCVBMTChDTEtfQVBNSVhFRF9UVkRQ
TEwsICJ0dmRwbGwiLCAweDAyNzAsIDB4MDI3QywgMHhDMDAwMDEyMSwgMCwgMjEsDQorCVBMTChD
TEtfQVBNSVhFRF9UVkRQTEwsICJ0dmRwbGwiLCAweDAyNzAsIDB4MDI3QywgMHhDMDAwMDEyMCwg
MCwgMjEsDQogCSAgICAweDI3MCwgNCwgMHgwLCAweDI3NCwgMCksDQotCVBMTChDTEtfQVBNSVhF
RF9DT0RFQ1BMTCwgImNvZGVjcGxsIiwgMHgwMjkwLCAweDAyOUMsIDB4MDAwMDAxMjEsIDAsIDIx
LA0KKwlQTEwoQ0xLX0FQTUlYRURfQ09ERUNQTEwsICJjb2RlY3BsbCIsIDB4MDI5MCwgMHgwMjlD
LCAweDAwMDAwMTIwLCAwLCAyMSwNCiAJICAgIDB4MjkwLCA0LCAweDAsIDB4Mjk0LCAwKSwNCi0J
UExMKENMS19BUE1JWEVEX1ZERUNQTEwsICJ2ZGVjcGxsIiwgMHgwMkU0LCAweDAyRjAsIDB4MDAw
MDAxMjEsIDAsIDIxLA0KKwlQTEwoQ0xLX0FQTUlYRURfVkRFQ1BMTCwgInZkZWNwbGwiLCAweDAy
RTQsIDB4MDJGMCwgMHgwMDAwMDEyMCwgMCwgMjEsDQogCSAgICAweDJFNCwgNCwgMHgwLCAweDJF
OCwgMCksDQotCVBMTChDTEtfQVBNSVhFRF9BUExMMSwgImFwbGwxIiwgMHgwMkEwLCAweDAyQjAs
IDB4MDAwMDAxMzEsIDAsIDMxLA0KKwlQTEwoQ0xLX0FQTUlYRURfQVBMTDEsICJhcGxsMSIsIDB4
MDJBMCwgMHgwMkIwLCAweDAwMDAwMTMwLCAwLCAzMSwNCiAJICAgIDB4MkEwLCA0LCAweDJBOCwg
MHgyQTQsIDApLA0KLQlQTEwoQ0xLX0FQTUlYRURfQVBMTDIsICJhcGxsMiIsIDB4MDJCNCwgMHgw
MkM0LCAweDAwMDAwMTMxLCAwLCAzMSwNCisJUExMKENMS19BUE1JWEVEX0FQTEwyLCAiYXBsbDIi
LCAweDAyQjQsIDB4MDJDNCwgMHgwMDAwMDEzMCwgMCwgMzEsDQogCSAgICAweDJCNCwgNCwgMHgy
QkMsIDB4MkI4LCAwKSwNCiB9Ow0KIA0KLS0gDQoxLjguMS4xLmRpcnR5DQo=


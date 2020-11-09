Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 537992AAF38
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 03:14:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729161AbgKICNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 21:13:44 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:38098 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729050AbgKICNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 21:13:41 -0500
X-UUID: bd82b6f2121f4cca98a2b4986c725dd5-20201109
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=KWoaUsgI+zjVJXwTc8Wv7WIGoNFF40Fig+xVi6bBjS0=;
        b=eTJjZYS+oR6IsN5IC20p+Zuq2fc9/8GVUb+xz+m86DhNBPaEk21gIj3UnUmyGRHzGYSTShM+x1avAqrIzSEr2hJ3G4VpCvv2pRtzFjqtmQG9o14DAnHRln2eqbpSwGsvbNkf0exrYn9WbyKF3+6ldB5rjfQ3fta4EcpNPyNEvCg=;
X-UUID: bd82b6f2121f4cca98a2b4986c725dd5-20201109
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 607993870; Mon, 09 Nov 2020 10:13:37 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 9 Nov 2020 10:13:37 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 9 Nov 2020 10:13:36 +0800
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <srv_heupstream@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>
Subject: [PATCH v2 02/13] clk: mediatek: Clean up the pll_en_bit from en_mask on MT2712
Date:   Mon, 9 Nov 2020 10:13:17 +0800
Message-ID: <1604888008-30555-3-git-send-email-weiyi.lu@mediatek.com>
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
L21lZGlhdGVrL2Nsay1tdDI3MTIuYyB8IDMwICsrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0t
LQ0KIDEgZmlsZSBjaGFuZ2VkLCAxNSBpbnNlcnRpb25zKCspLCAxNSBkZWxldGlvbnMoLSkNCg0K
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL21lZGlhdGVrL2Nsay1tdDI3MTIuYyBiL2RyaXZlcnMv
Y2xrL21lZGlhdGVrL2Nsay1tdDI3MTIuYw0KaW5kZXggYTNiZDlhMS4uZmQ4MTE2MiAxMDA2NDQN
Ci0tLSBhL2RyaXZlcnMvY2xrL21lZGlhdGVrL2Nsay1tdDI3MTIuYw0KKysrIGIvZHJpdmVycy9j
bGsvbWVkaWF0ZWsvY2xrLW10MjcxMi5jDQpAQCAtMTIyMiwzOCArMTIyMiwzOCBAQA0KIH07DQog
DQogc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfcGxsX2RhdGEgcGxsc1tdID0gew0KLQlQTEwoQ0xL
X0FQTUlYRURfTUFJTlBMTCwgIm1haW5wbGwiLCAweDAyMzAsIDB4MDIzQywgMHhmMDAwMDEwMSwN
CisJUExMKENMS19BUE1JWEVEX01BSU5QTEwsICJtYWlucGxsIiwgMHgwMjMwLCAweDAyM0MsIDB4
ZjAwMDAxMDAsDQogCQlIQVZFX1JTVF9CQVIsIDMxLCAweDAyMzAsIDQsIDAsIDAsIDAsIDB4MDIz
NCwgMCksDQotCVBMTChDTEtfQVBNSVhFRF9VTklWUExMLCAidW5pdnBsbCIsIDB4MDI0MCwgMHgw
MjRDLCAweGZlMDAwMTAxLA0KKwlQTEwoQ0xLX0FQTUlYRURfVU5JVlBMTCwgInVuaXZwbGwiLCAw
eDAyNDAsIDB4MDI0QywgMHhmZTAwMDEwMCwNCiAJCUhBVkVfUlNUX0JBUiwgMzEsIDB4MDI0MCwg
NCwgMCwgMCwgMCwgMHgwMjQ0LCAwKSwNCi0JUExMKENMS19BUE1JWEVEX1ZDT0RFQ1BMTCwgInZj
b2RlY3BsbCIsIDB4MDMyMCwgMHgwMzJDLCAweGMwMDAwMTAxLA0KKwlQTEwoQ0xLX0FQTUlYRURf
VkNPREVDUExMLCAidmNvZGVjcGxsIiwgMHgwMzIwLCAweDAzMkMsIDB4YzAwMDAxMDAsDQogCQkw
LCAzMSwgMHgwMzIwLCA0LCAwLCAwLCAwLCAweDAzMjQsIDApLA0KLQlQTEwoQ0xLX0FQTUlYRURf
VkVOQ1BMTCwgInZlbmNwbGwiLCAweDAyODAsIDB4MDI4QywgMHgwMDAwMDEwMSwNCisJUExMKENM
S19BUE1JWEVEX1ZFTkNQTEwsICJ2ZW5jcGxsIiwgMHgwMjgwLCAweDAyOEMsIDB4MDAwMDAxMDAs
DQogCQkwLCAzMSwgMHgwMjgwLCA0LCAwLCAwLCAwLCAweDAyODQsIDApLA0KLQlQTEwoQ0xLX0FQ
TUlYRURfQVBMTDEsICJhcGxsMSIsIDB4MDMzMCwgMHgwMzQwLCAweDAwMDAwMTAxLA0KKwlQTEwo
Q0xLX0FQTUlYRURfQVBMTDEsICJhcGxsMSIsIDB4MDMzMCwgMHgwMzQwLCAweDAwMDAwMTAwLA0K
IAkJMCwgMzEsIDB4MDMzMCwgNCwgMHgwMzM4LCAweDAwMTQsIDAsIDB4MDMzNCwgMCksDQotCVBM
TChDTEtfQVBNSVhFRF9BUExMMiwgImFwbGwyIiwgMHgwMzUwLCAweDAzNjAsIDB4MDAwMDAxMDEs
DQorCVBMTChDTEtfQVBNSVhFRF9BUExMMiwgImFwbGwyIiwgMHgwMzUwLCAweDAzNjAsIDB4MDAw
MDAxMDAsDQogCQkwLCAzMSwgMHgwMzUwLCA0LCAweDAzNTgsIDB4MDAxNCwgMSwgMHgwMzU0LCAw
KSwNCi0JUExMKENMS19BUE1JWEVEX0xWRFNQTEwsICJsdmRzcGxsIiwgMHgwMzcwLCAweDAzN2Ms
IDB4MDAwMDAxMDEsDQorCVBMTChDTEtfQVBNSVhFRF9MVkRTUExMLCAibHZkc3BsbCIsIDB4MDM3
MCwgMHgwMzdjLCAweDAwMDAwMTAwLA0KIAkJMCwgMzEsIDB4MDM3MCwgNCwgMCwgMCwgMCwgMHgw
Mzc0LCAwKSwNCi0JUExMKENMS19BUE1JWEVEX0xWRFNQTEwyLCAibHZkc3BsbDIiLCAweDAzOTAs
IDB4MDM5QywgMHgwMDAwMDEwMSwNCisJUExMKENMS19BUE1JWEVEX0xWRFNQTEwyLCAibHZkc3Bs
bDIiLCAweDAzOTAsIDB4MDM5QywgMHgwMDAwMDEwMCwNCiAJCTAsIDMxLCAweDAzOTAsIDQsIDAs
IDAsIDAsIDB4MDM5NCwgMCksDQotCVBMTChDTEtfQVBNSVhFRF9NU0RDUExMLCAibXNkY3BsbCIs
IDB4MDI3MCwgMHgwMjdDLCAweDAwMDAwMTAxLA0KKwlQTEwoQ0xLX0FQTUlYRURfTVNEQ1BMTCwg
Im1zZGNwbGwiLCAweDAyNzAsIDB4MDI3QywgMHgwMDAwMDEwMCwNCiAJCTAsIDMxLCAweDAyNzAs
IDQsIDAsIDAsIDAsIDB4MDI3NCwgMCksDQotCVBMTChDTEtfQVBNSVhFRF9NU0RDUExMMiwgIm1z
ZGNwbGwyIiwgMHgwNDEwLCAweDA0MUMsIDB4MDAwMDAxMDEsDQorCVBMTChDTEtfQVBNSVhFRF9N
U0RDUExMMiwgIm1zZGNwbGwyIiwgMHgwNDEwLCAweDA0MUMsIDB4MDAwMDAxMDAsDQogCQkwLCAz
MSwgMHgwNDEwLCA0LCAwLCAwLCAwLCAweDA0MTQsIDApLA0KLQlQTEwoQ0xLX0FQTUlYRURfVFZE
UExMLCAidHZkcGxsIiwgMHgwMjkwLCAweDAyOUMsIDB4YzAwMDAxMDEsDQorCVBMTChDTEtfQVBN
SVhFRF9UVkRQTEwsICJ0dmRwbGwiLCAweDAyOTAsIDB4MDI5QywgMHhjMDAwMDEwMCwNCiAJCTAs
IDMxLCAweDAyOTAsIDQsIDAsIDAsIDAsIDB4MDI5NCwgMCksDQotCVBMTF9CKENMS19BUE1JWEVE
X01NUExMLCAibW1wbGwiLCAweDAyNTAsIDB4MDI2MCwgMHgwMDAwMDEwMSwNCisJUExMX0IoQ0xL
X0FQTUlYRURfTU1QTEwsICJtbXBsbCIsIDB4MDI1MCwgMHgwMjYwLCAweDAwMDAwMTAwLA0KIAkJ
MCwgMzEsIDB4MDI1MCwgNCwgMCwgMCwgMCwgMHgwMjU0LCAwLA0KIAkJbW1wbGxfZGl2X3RhYmxl
KSwNCi0JUExMX0IoQ0xLX0FQTUlYRURfQVJNQ0EzNVBMTCwgImFybWNhMzVwbGwiLCAweDAxMDAs
IDB4MDExMCwgMHhmMDAwMDEwMSwNCisJUExMX0IoQ0xLX0FQTUlYRURfQVJNQ0EzNVBMTCwgImFy
bWNhMzVwbGwiLCAweDAxMDAsIDB4MDExMCwgMHhmMDAwMDEwMCwNCiAJCUhBVkVfUlNUX0JBUiwg
MzEsIDB4MDEwMCwgNCwgMCwgMCwgMCwgMHgwMTA0LCAwLA0KIAkJYXJtY2EzNXBsbF9kaXZfdGFi
bGUpLA0KLQlQTExfQihDTEtfQVBNSVhFRF9BUk1DQTcyUExMLCAiYXJtY2E3MnBsbCIsIDB4MDIx
MCwgMHgwMjIwLCAweDAwMDAwMTAxLA0KKwlQTExfQihDTEtfQVBNSVhFRF9BUk1DQTcyUExMLCAi
YXJtY2E3MnBsbCIsIDB4MDIxMCwgMHgwMjIwLCAweDAwMDAwMTAwLA0KIAkJMCwgMzEsIDB4MDIx
MCwgNCwgMCwgMCwgMCwgMHgwMjE0LCAwLA0KIAkJYXJtY2E3MnBsbF9kaXZfdGFibGUpLA0KLQlQ
TEwoQ0xLX0FQTUlYRURfRVRIRVJQTEwsICJldGhlcnBsbCIsIDB4MDMwMCwgMHgwMzBDLCAweGMw
MDAwMTAxLA0KKwlQTEwoQ0xLX0FQTUlYRURfRVRIRVJQTEwsICJldGhlcnBsbCIsIDB4MDMwMCwg
MHgwMzBDLCAweGMwMDAwMTAwLA0KIAkJMCwgMzEsIDB4MDMwMCwgNCwgMCwgMCwgMCwgMHgwMzA0
LCAwKSwNCiB9Ow0KIA0KLS0gDQoxLjguMS4xLmRpcnR5DQo=


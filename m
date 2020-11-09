Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A62672AAF2F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 03:14:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729321AbgKICOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 21:14:09 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:34079 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729172AbgKICNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 21:13:52 -0500
X-UUID: 4e2c6894f24a422ca960d87c9d6e043a-20201109
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=w61CFNaGLH0hjI+CBsp+FXs3bqb0Iytunpyrf4ubk20=;
        b=TzwXVvWLYYbXnT6ATHH/Xlp6K/A7r+o9eNCOPCzGkzNTctl31Kgq/gqIB85gQUeSIkJVJJ0Q4+23UvYX35sRWtBlverh8UqksrnjdvaRwCnMRwsaPWWAazqW1bsDINZbmt2am0YihHNWjVdQhtUz20VYR9A1ql8qrBadfNAE7ig=;
X-UUID: 4e2c6894f24a422ca960d87c9d6e043a-20201109
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1528079688; Mon, 09 Nov 2020 10:13:46 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 9 Nov 2020 10:13:45 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 9 Nov 2020 10:13:44 +0800
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <srv_heupstream@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>
Subject: [PATCH v2 09/13] clk: mediatek: Clean up the pll_en_bit from en_mask on MT8167
Date:   Mon, 9 Nov 2020 10:13:24 +0800
Message-ID: <1604888008-30555-10-git-send-email-weiyi.lu@mediatek.com>
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
L21lZGlhdGVrL2Nsay1tdDgxNjcuYyB8IDE2ICsrKysrKysrLS0tLS0tLS0NCiAxIGZpbGUgY2hh
bmdlZCwgOCBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9jbGsvbWVkaWF0ZWsvY2xrLW10ODE2Ny5jIGIvZHJpdmVycy9jbGsvbWVkaWF0ZWsvY2xr
LW10ODE2Ny5jDQppbmRleCBlNWVhMTBlLi4xODBlMjRhIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9j
bGsvbWVkaWF0ZWsvY2xrLW10ODE2Ny5jDQorKysgYi9kcml2ZXJzL2Nsay9tZWRpYXRlay9jbGst
bXQ4MTY3LmMNCkBAIC0xMDE2LDIxICsxMDE2LDIxIEBAIHN0YXRpYyB2b2lkIF9faW5pdCBtdGtf
aW5mcmFjZmdfaW5pdChzdHJ1Y3QgZGV2aWNlX25vZGUgKm5vZGUpDQogfTsNCiANCiBzdGF0aWMg
Y29uc3Qgc3RydWN0IG10a19wbGxfZGF0YSBwbGxzW10gPSB7DQotCVBMTChDTEtfQVBNSVhFRF9B
Uk1QTEwsICJhcm1wbGwiLCAweDAxMDAsIDB4MDExMCwgMHgwMDAwMDAwMSwgMCwNCisJUExMKENM
S19BUE1JWEVEX0FSTVBMTCwgImFybXBsbCIsIDB4MDEwMCwgMHgwMTEwLCAwLCAwLA0KIAkJMjEs
IDB4MDEwNCwgMjQsIDAsIDB4MDEwNCwgMCksDQotCVBMTChDTEtfQVBNSVhFRF9NQUlOUExMLCAi
bWFpbnBsbCIsIDB4MDEyMCwgMHgwMTMwLCAweDAwMDAwMDAxLA0KKwlQTEwoQ0xLX0FQTUlYRURf
TUFJTlBMTCwgIm1haW5wbGwiLCAweDAxMjAsIDB4MDEzMCwgMCwNCiAJCUhBVkVfUlNUX0JBUiwg
MjEsIDB4MDEyNCwgMjQsIDAsIDB4MDEyNCwgMCksDQotCVBMTChDTEtfQVBNSVhFRF9VTklWUExM
LCAidW5pdnBsbCIsIDB4MDE0MCwgMHgwMTUwLCAweDMwMDAwMDAxLA0KKwlQTEwoQ0xLX0FQTUlY
RURfVU5JVlBMTCwgInVuaXZwbGwiLCAweDAxNDAsIDB4MDE1MCwgMHgzMDAwMDAwMCwNCiAJCUhB
VkVfUlNUX0JBUiwgNywgMHgwMTQ0LCAyNCwgMCwgMHgwMTQ0LCAwKSwNCi0JUExMX0IoQ0xLX0FQ
TUlYRURfTU1QTEwsICJtbXBsbCIsIDB4MDE2MCwgMHgwMTcwLCAweDAwMDAwMDAxLCAwLA0KKwlQ
TExfQihDTEtfQVBNSVhFRF9NTVBMTCwgIm1tcGxsIiwgMHgwMTYwLCAweDAxNzAsIDAsIDAsDQog
CQkyMSwgMHgwMTY0LCAyNCwgMCwgMHgwMTY0LCAwLCBtbXBsbF9kaXZfdGFibGUpLA0KLQlQTEwo
Q0xLX0FQTUlYRURfQVBMTDEsICJhcGxsMSIsIDB4MDE4MCwgMHgwMTkwLCAweDAwMDAwMDAxLCAw
LA0KKwlQTEwoQ0xLX0FQTUlYRURfQVBMTDEsICJhcGxsMSIsIDB4MDE4MCwgMHgwMTkwLCAwLCAw
LA0KIAkJMzEsIDB4MDE4MCwgMSwgMHgwMTk0LCAweDAxODQsIDApLA0KLQlQTEwoQ0xLX0FQTUlY
RURfQVBMTDIsICJhcGxsMiIsIDB4MDFBMCwgMHgwMUIwLCAweDAwMDAwMDAxLCAwLA0KKwlQTEwo
Q0xLX0FQTUlYRURfQVBMTDIsICJhcGxsMiIsIDB4MDFBMCwgMHgwMUIwLCAwLCAwLA0KIAkJMzEs
IDB4MDFBMCwgMSwgMHgwMUI0LCAweDAxQTQsIDApLA0KLQlQTEwoQ0xLX0FQTUlYRURfVFZEUExM
LCAidHZkcGxsIiwgMHgwMUMwLCAweDAxRDAsIDB4MDAwMDAwMDEsIDAsDQorCVBMTChDTEtfQVBN
SVhFRF9UVkRQTEwsICJ0dmRwbGwiLCAweDAxQzAsIDB4MDFEMCwgMCwgMCwNCiAJCTIxLCAweDAx
QzQsIDI0LCAwLCAweDAxQzQsIDApLA0KLQlQTEwoQ0xLX0FQTUlYRURfTFZEU1BMTCwgImx2ZHNw
bGwiLCAweDAxRTAsIDB4MDFGMCwgMHgwMDAwMDAwMSwgMCwNCisJUExMKENMS19BUE1JWEVEX0xW
RFNQTEwsICJsdmRzcGxsIiwgMHgwMUUwLCAweDAxRjAsIDAsIDAsDQogCQkyMSwgMHgwMUU0LCAy
NCwgMCwgMHgwMUU0LCAwKSwNCiB9Ow0KIA0KLS0gDQoxLjguMS4xLmRpcnR5DQo=


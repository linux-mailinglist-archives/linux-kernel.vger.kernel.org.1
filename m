Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35EE4295F0A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 14:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2899052AbgJVM4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 08:56:16 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:51623 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2899028AbgJVM4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 08:56:12 -0400
X-UUID: 6df8d1dba3e249db85cb0f4c3789249e-20201022
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=wi2FfHDUviFWRGjbJAxecTKg5y6KMeXLiAAcMbDHRS8=;
        b=H5eAbHi9UnHN3yqqAL8iwD9G1iuGrQK2Nz7blG7wpEyvw2vLZFGnBCyzc9D+BGkTWQM5j6YZ/3qnkEfbCz9KkF68vsqy49ewis9T4t5CcKvgC164LVFTqryaxfpnMHl0ChxpiAXNF6zoIeJHNY5cAaXUMHwvcEwvrzDwyqxiesE=;
X-UUID: 6df8d1dba3e249db85cb0f4c3789249e-20201022
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2008863727; Thu, 22 Oct 2020 20:56:08 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 22 Oct 2020 20:56:06 +0800
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
Subject: [PATCH 01/12] clk: mediatek: Clean up the pll_en_bit from en_mask on MT2701
Date:   Thu, 22 Oct 2020 20:55:54 +0800
Message-ID: <1603371365-30863-2-git-send-email-weiyi.lu@mediatek.com>
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
L21lZGlhdGVrL2Nsay1tdDI3MDEuYyB8IDI2ICsrKysrKysrKysrKystLS0tLS0tLS0tLS0tDQog
MSBmaWxlIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKyksIDEzIGRlbGV0aW9ucygtKQ0KDQpkaWZm
IC0tZ2l0IGEvZHJpdmVycy9jbGsvbWVkaWF0ZWsvY2xrLW10MjcwMS5jIGIvZHJpdmVycy9jbGsv
bWVkaWF0ZWsvY2xrLW10MjcwMS5jDQppbmRleCA2OTViZTBmLi40NjJhOTk4IDEwMDY0NA0KLS0t
IGEvZHJpdmVycy9jbGsvbWVkaWF0ZWsvY2xrLW10MjcwMS5jDQorKysgYi9kcml2ZXJzL2Nsay9t
ZWRpYXRlay9jbGstbXQyNzAxLmMNCkBAIC05MzQsMzEgKzkzNCwzMSBAQCBzdGF0aWMgaW50IG10
a19wZXJpY2ZnX2luaXQoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCiAJfQ0KIA0KIHN0
YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX3BsbF9kYXRhIGFwbWl4ZWRfcGxsc1tdID0gew0KLQlQTEwo
Q0xLX0FQTUlYRURfQVJNUExMLCAiYXJtcGxsIiwgMHgyMDAsIDB4MjBjLCAweDgwMDAwMDAxLA0K
KwlQTEwoQ0xLX0FQTUlYRURfQVJNUExMLCAiYXJtcGxsIiwgMHgyMDAsIDB4MjBjLCAweDgwMDAw
MDAwLA0KIAkJCVBMTF9BTywgMjEsIDB4MjA0LCAyNCwgMHgwLCAweDIwNCwgMCksDQotCVBMTChD
TEtfQVBNSVhFRF9NQUlOUExMLCAibWFpbnBsbCIsIDB4MjEwLCAweDIxYywgMHhmMDAwMDAwMSwN
CisJUExMKENMS19BUE1JWEVEX01BSU5QTEwsICJtYWlucGxsIiwgMHgyMTAsIDB4MjFjLCAweGYw
MDAwMDAwLA0KIAkJICBIQVZFX1JTVF9CQVIsIDIxLCAweDIxMCwgNCwgMHgwLCAweDIxNCwgMCks
DQotCVBMTChDTEtfQVBNSVhFRF9VTklWUExMLCAidW5pdnBsbCIsIDB4MjIwLCAweDIyYywgMHhm
MzAwMDAwMSwNCisJUExMKENMS19BUE1JWEVEX1VOSVZQTEwsICJ1bml2cGxsIiwgMHgyMjAsIDB4
MjJjLCAweGYzMDAwMDAwLA0KIAkJICBIQVZFX1JTVF9CQVIsIDcsIDB4MjIwLCA0LCAweDAsIDB4
MjI0LCAxNCksDQotCVBMTChDTEtfQVBNSVhFRF9NTVBMTCwgIm1tcGxsIiwgMHgyMzAsIDB4MjNj
LCAweDAwMDAwMDAxLCAwLA0KKwlQTEwoQ0xLX0FQTUlYRURfTU1QTEwsICJtbXBsbCIsIDB4MjMw
LCAweDIzYywgMCwgMCwNCiAJCQkJMjEsIDB4MjMwLCA0LCAweDAsIDB4MjM0LCAwKSwNCi0JUExM
KENMS19BUE1JWEVEX01TRENQTEwsICJtc2RjcGxsIiwgMHgyNDAsIDB4MjRjLCAweDAwMDAwMDAx
LCAwLA0KKwlQTEwoQ0xLX0FQTUlYRURfTVNEQ1BMTCwgIm1zZGNwbGwiLCAweDI0MCwgMHgyNGMs
IDAsIDAsDQogCQkJCTIxLCAweDI0MCwgNCwgMHgwLCAweDI0NCwgMCksDQotCVBMTChDTEtfQVBN
SVhFRF9UVkRQTEwsICJ0dmRwbGwiLCAweDI1MCwgMHgyNWMsIDB4MDAwMDAwMDEsIDAsDQorCVBM
TChDTEtfQVBNSVhFRF9UVkRQTEwsICJ0dmRwbGwiLCAweDI1MCwgMHgyNWMsIDAsIDAsDQogCQkJ
CTIxLCAweDI1MCwgNCwgMHgwLCAweDI1NCwgMCksDQotCVBMTChDTEtfQVBNSVhFRF9BVUQxUExM
LCAiYXVkMXBsbCIsIDB4MjcwLCAweDI3YywgMHgwMDAwMDAwMSwgMCwNCisJUExMKENMS19BUE1J
WEVEX0FVRDFQTEwsICJhdWQxcGxsIiwgMHgyNzAsIDB4MjdjLCAwLCAwLA0KIAkJCQkzMSwgMHgy
NzAsIDQsIDB4MCwgMHgyNzQsIDApLA0KLQlQTEwoQ0xLX0FQTUlYRURfVFJHUExMLCAidHJncGxs
IiwgMHgyODAsIDB4MjhjLCAweDAwMDAwMDAxLCAwLA0KKwlQTEwoQ0xLX0FQTUlYRURfVFJHUExM
LCAidHJncGxsIiwgMHgyODAsIDB4MjhjLCAwLCAwLA0KIAkJCQkzMSwgMHgyODAsIDQsIDB4MCwg
MHgyODQsIDApLA0KLQlQTEwoQ0xLX0FQTUlYRURfRVRIUExMLCAiZXRocGxsIiwgMHgyOTAsIDB4
MjljLCAweDAwMDAwMDAxLCAwLA0KKwlQTEwoQ0xLX0FQTUlYRURfRVRIUExMLCAiZXRocGxsIiwg
MHgyOTAsIDB4MjljLCAwLCAwLA0KIAkJCQkzMSwgMHgyOTAsIDQsIDB4MCwgMHgyOTQsIDApLA0K
LQlQTEwoQ0xLX0FQTUlYRURfVkRFQ1BMTCwgInZkZWNwbGwiLCAweDJhMCwgMHgyYWMsIDB4MDAw
MDAwMDEsIDAsDQorCVBMTChDTEtfQVBNSVhFRF9WREVDUExMLCAidmRlY3BsbCIsIDB4MmEwLCAw
eDJhYywgMCwgMCwNCiAJCQkJMzEsIDB4MmEwLCA0LCAweDAsIDB4MmE0LCAwKSwNCi0JUExMKENM
S19BUE1JWEVEX0hBRERTMlBMTCwgImhhZGRzMnBsbCIsIDB4MmIwLCAweDJiYywgMHgwMDAwMDAw
MSwgMCwNCisJUExMKENMS19BUE1JWEVEX0hBRERTMlBMTCwgImhhZGRzMnBsbCIsIDB4MmIwLCAw
eDJiYywgMCwgMCwNCiAJCQkJMzEsIDB4MmIwLCA0LCAweDAsIDB4MmI0LCAwKSwNCi0JUExMKENM
S19BUE1JWEVEX0FVRDJQTEwsICJhdWQycGxsIiwgMHgyYzAsIDB4MmNjLCAweDAwMDAwMDAxLCAw
LA0KKwlQTEwoQ0xLX0FQTUlYRURfQVVEMlBMTCwgImF1ZDJwbGwiLCAweDJjMCwgMHgyY2MsIDAs
IDAsDQogCQkJCTMxLCAweDJjMCwgNCwgMHgwLCAweDJjNCwgMCksDQotCVBMTChDTEtfQVBNSVhF
RF9UVkQyUExMLCAidHZkMnBsbCIsIDB4MmQwLCAweDJkYywgMHgwMDAwMDAwMSwgMCwNCisJUExM
KENMS19BUE1JWEVEX1RWRDJQTEwsICJ0dmQycGxsIiwgMHgyZDAsIDB4MmRjLCAwLCAwLA0KIAkJ
CQkyMSwgMHgyZDAsIDQsIDB4MCwgMHgyZDQsIDApLA0KIH07DQogDQotLSANCjEuOC4xLjEuZGly
dHkNCg==


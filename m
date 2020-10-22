Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2987295F0D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 14:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2899075AbgJVM4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 08:56:23 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:44046 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2899043AbgJVM4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 08:56:18 -0400
X-UUID: 319337d1233643d68ccbd1ffc1046892-20201022
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=rwnBsHN138S5oyNetT4l7pYmHpooTVTrjRW8CEExl3c=;
        b=sSFI5ILsCvfTUR7JqmruVQk/4wAvtVt5J0oySbRAZOQdEbAocjH2A0uzn6fpVXhi300wZ+URero7MkPl+0abyETO5LaULk4/2aJ+gylEzoyzx6ejI5S+Kf9lFHj9dYPqspfrBsVRhqnvlA8bTFEjB0MQmFrb4jLr/qsjWcJmGVI=;
X-UUID: 319337d1233643d68ccbd1ffc1046892-20201022
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 598620005; Thu, 22 Oct 2020 20:56:10 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 22 Oct 2020 20:56:08 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 22 Oct 2020 20:56:08 +0800
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <srv_heupstream@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>
Subject: [PATCH 09/12] clk: mediatek: Clean up the pll_en_bit from en_mask on MT8173
Date:   Thu, 22 Oct 2020 20:56:02 +0800
Message-ID: <1603371365-30863-10-git-send-email-weiyi.lu@mediatek.com>
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
L21lZGlhdGVrL2Nsay1tdDgxNzMuYyB8IDI4ICsrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0N
CiAxIGZpbGUgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKSwgMTQgZGVsZXRpb25zKC0pDQoNCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL2Nsay9tZWRpYXRlay9jbGstbXQ4MTczLmMgYi9kcml2ZXJzL2Ns
ay9tZWRpYXRlay9jbGstbXQ4MTczLmMNCmluZGV4IDhmODk4YWMuLmYzMDllNzggMTAwNjQ0DQot
LS0gYS9kcml2ZXJzL2Nsay9tZWRpYXRlay9jbGstbXQ4MTczLmMNCisrKyBiL2RyaXZlcnMvY2xr
L21lZGlhdGVrL2Nsay1tdDgxNzMuYw0KQEAgLTk3MiwyMCArOTcyLDIwIEBAIHN0cnVjdCBtdGtf
Y2xrX3VzYiB7DQogfTsNCiANCiBzdGF0aWMgY29uc3Qgc3RydWN0IG10a19wbGxfZGF0YSBwbGxz
W10gPSB7DQotCVBMTChDTEtfQVBNSVhFRF9BUk1DQTE1UExMLCAiYXJtY2ExNXBsbCIsIDB4MjAw
LCAweDIwYywgMHgwMDAwMDAwMSwgMCwgMjEsIDB4MjA0LCAyNCwgMHgwLCAweDIwNCwgMCksDQot
CVBMTChDTEtfQVBNSVhFRF9BUk1DQTdQTEwsICJhcm1jYTdwbGwiLCAweDIxMCwgMHgyMWMsIDB4
MDAwMDAwMDEsIDAsIDIxLCAweDIxNCwgMjQsIDB4MCwgMHgyMTQsIDApLA0KLQlQTEwoQ0xLX0FQ
TUlYRURfTUFJTlBMTCwgIm1haW5wbGwiLCAweDIyMCwgMHgyMmMsIDB4ZjAwMDAxMDEsIEhBVkVf
UlNUX0JBUiwgMjEsIDB4MjIwLCA0LCAweDAsIDB4MjI0LCAwKSwNCi0JUExMKENMS19BUE1JWEVE
X1VOSVZQTEwsICJ1bml2cGxsIiwgMHgyMzAsIDB4MjNjLCAweGZlMDAwMDAxLCBIQVZFX1JTVF9C
QVIsIDcsIDB4MjMwLCA0LCAweDAsIDB4MjM0LCAxNCksDQotCVBMTF9CKENMS19BUE1JWEVEX01N
UExMLCAibW1wbGwiLCAweDI0MCwgMHgyNGMsIDB4MDAwMDAwMDEsIDAsIDIxLCAweDI0NCwgMjQs
IDB4MCwgMHgyNDQsIDAsIG1tcGxsX2Rpdl90YWJsZSksDQotCVBMTChDTEtfQVBNSVhFRF9NU0RD
UExMLCAibXNkY3BsbCIsIDB4MjUwLCAweDI1YywgMHgwMDAwMDAwMSwgMCwgMjEsIDB4MjUwLCA0
LCAweDAsIDB4MjU0LCAwKSwNCi0JUExMKENMS19BUE1JWEVEX1ZFTkNQTEwsICJ2ZW5jcGxsIiwg
MHgyNjAsIDB4MjZjLCAweDAwMDAwMDAxLCAwLCAyMSwgMHgyNjAsIDQsIDB4MCwgMHgyNjQsIDAp
LA0KLQlQTEwoQ0xLX0FQTUlYRURfVFZEUExMLCAidHZkcGxsIiwgMHgyNzAsIDB4MjdjLCAweDAw
MDAwMDAxLCAwLCAyMSwgMHgyNzAsIDQsIDB4MCwgMHgyNzQsIDApLA0KLQlQTEwoQ0xLX0FQTUlY
RURfTVBMTCwgIm1wbGwiLCAweDI4MCwgMHgyOGMsIDB4MDAwMDAwMDEsIDAsIDIxLCAweDI4MCwg
NCwgMHgwLCAweDI4NCwgMCksDQotCVBMTChDTEtfQVBNSVhFRF9WQ09ERUNQTEwsICJ2Y29kZWNw
bGwiLCAweDI5MCwgMHgyOWMsIDB4MDAwMDAwMDEsIDAsIDIxLCAweDI5MCwgNCwgMHgwLCAweDI5
NCwgMCksDQotCVBMTChDTEtfQVBNSVhFRF9BUExMMSwgImFwbGwxIiwgMHgyYTAsIDB4MmIwLCAw
eDAwMDAwMDAxLCAwLCAzMSwgMHgyYTAsIDQsIDB4MmE0LCAweDJhNCwgMCksDQotCVBMTChDTEtf
QVBNSVhFRF9BUExMMiwgImFwbGwyIiwgMHgyYjQsIDB4MmM0LCAweDAwMDAwMDAxLCAwLCAzMSwg
MHgyYjQsIDQsIDB4MmI4LCAweDJiOCwgMCksDQotCVBMTChDTEtfQVBNSVhFRF9MVkRTUExMLCAi
bHZkc3BsbCIsIDB4MmQwLCAweDJkYywgMHgwMDAwMDAwMSwgMCwgMjEsIDB4MmQwLCA0LCAweDAs
IDB4MmQ0LCAwKSwNCi0JUExMKENMS19BUE1JWEVEX01TRENQTEwyLCAibXNkY3BsbDIiLCAweDJm
MCwgMHgyZmMsIDB4MDAwMDAwMDEsIDAsIDIxLCAweDJmMCwgNCwgMHgwLCAweDJmNCwgMCksDQor
CVBMTChDTEtfQVBNSVhFRF9BUk1DQTE1UExMLCAiYXJtY2ExNXBsbCIsIDB4MjAwLCAweDIwYywg
MCwgMCwgMjEsIDB4MjA0LCAyNCwgMHgwLCAweDIwNCwgMCksDQorCVBMTChDTEtfQVBNSVhFRF9B
Uk1DQTdQTEwsICJhcm1jYTdwbGwiLCAweDIxMCwgMHgyMWMsIDAsIDAsIDIxLCAweDIxNCwgMjQs
IDB4MCwgMHgyMTQsIDApLA0KKwlQTEwoQ0xLX0FQTUlYRURfTUFJTlBMTCwgIm1haW5wbGwiLCAw
eDIyMCwgMHgyMmMsIDB4ZjAwMDAxMDAsIEhBVkVfUlNUX0JBUiwgMjEsIDB4MjIwLCA0LCAweDAs
IDB4MjI0LCAwKSwNCisJUExMKENMS19BUE1JWEVEX1VOSVZQTEwsICJ1bml2cGxsIiwgMHgyMzAs
IDB4MjNjLCAweGZlMDAwMDAwLCBIQVZFX1JTVF9CQVIsIDcsIDB4MjMwLCA0LCAweDAsIDB4MjM0
LCAxNCksDQorCVBMTF9CKENMS19BUE1JWEVEX01NUExMLCAibW1wbGwiLCAweDI0MCwgMHgyNGMs
IDAsIDAsIDIxLCAweDI0NCwgMjQsIDB4MCwgMHgyNDQsIDAsIG1tcGxsX2Rpdl90YWJsZSksDQor
CVBMTChDTEtfQVBNSVhFRF9NU0RDUExMLCAibXNkY3BsbCIsIDB4MjUwLCAweDI1YywgMCwgMCwg
MjEsIDB4MjUwLCA0LCAweDAsIDB4MjU0LCAwKSwNCisJUExMKENMS19BUE1JWEVEX1ZFTkNQTEws
ICJ2ZW5jcGxsIiwgMHgyNjAsIDB4MjZjLCAwLCAwLCAyMSwgMHgyNjAsIDQsIDB4MCwgMHgyNjQs
IDApLA0KKwlQTEwoQ0xLX0FQTUlYRURfVFZEUExMLCAidHZkcGxsIiwgMHgyNzAsIDB4MjdjLCAw
LCAwLCAyMSwgMHgyNzAsIDQsIDB4MCwgMHgyNzQsIDApLA0KKwlQTEwoQ0xLX0FQTUlYRURfTVBM
TCwgIm1wbGwiLCAweDI4MCwgMHgyOGMsIDAsIDAsIDIxLCAweDI4MCwgNCwgMHgwLCAweDI4NCwg
MCksDQorCVBMTChDTEtfQVBNSVhFRF9WQ09ERUNQTEwsICJ2Y29kZWNwbGwiLCAweDI5MCwgMHgy
OWMsIDAsIDAsIDIxLCAweDI5MCwgNCwgMHgwLCAweDI5NCwgMCksDQorCVBMTChDTEtfQVBNSVhF
RF9BUExMMSwgImFwbGwxIiwgMHgyYTAsIDB4MmIwLCAwLCAwLCAzMSwgMHgyYTAsIDQsIDB4MmE0
LCAweDJhNCwgMCksDQorCVBMTChDTEtfQVBNSVhFRF9BUExMMiwgImFwbGwyIiwgMHgyYjQsIDB4
MmM0LCAwLCAwLCAzMSwgMHgyYjQsIDQsIDB4MmI4LCAweDJiOCwgMCksDQorCVBMTChDTEtfQVBN
SVhFRF9MVkRTUExMLCAibHZkc3BsbCIsIDB4MmQwLCAweDJkYywgMCwgMCwgMjEsIDB4MmQwLCA0
LCAweDAsIDB4MmQ0LCAwKSwNCisJUExMKENMS19BUE1JWEVEX01TRENQTEwyLCAibXNkY3BsbDIi
LCAweDJmMCwgMHgyZmMsIDAsIDAsIDIxLCAweDJmMCwgNCwgMHgwLCAweDJmNCwgMCksDQogfTsN
CiANCiBzdGF0aWMgdm9pZCBfX2luaXQgbXRrX2FwbWl4ZWRzeXNfaW5pdChzdHJ1Y3QgZGV2aWNl
X25vZGUgKm5vZGUpDQotLSANCjEuOC4xLjEuZGlydHkNCg==


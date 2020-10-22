Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1A5295F16
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 14:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2899111AbgJVM4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 08:56:45 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:44034 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2899026AbgJVM4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 08:56:16 -0400
X-UUID: 725ac7993a174b16adbb254b3442a96f-20201022
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=ARo+aZnxsWHz4UuONZ9dF73YwZqt8F6SqOJGyOAxrEk=;
        b=UZcMFek5XJZ+r3ojUz/4l89RXia9hwKriunAsDyvDz+YAGaEQS6gqvxNDHNoZ6MCWSOv/cISh05ldLnoaoI9gIJYMtjSk9jNMCGK08Rajig06gO7HqGOd4OqK+7ttsa2kGnu6MzT9dXOWAoqtBbG7TXKp1tB22WtRauEPpscyGM=;
X-UUID: 725ac7993a174b16adbb254b3442a96f-20201022
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1381466866; Thu, 22 Oct 2020 20:56:10 +0800
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
Subject: [PATCH 11/12] clk: mediatek: Clean up the pll_en_bit from en_mask on MT8516
Date:   Thu, 22 Oct 2020 20:56:04 +0800
Message-ID: <1603371365-30863-12-git-send-email-weiyi.lu@mediatek.com>
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
L21lZGlhdGVrL2Nsay1tdDg1MTYuYyB8IDEyICsrKysrKy0tLS0tLQ0KIDEgZmlsZSBjaGFuZ2Vk
LCA2IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJz
L2Nsay9tZWRpYXRlay9jbGstbXQ4NTE2LmMgYi9kcml2ZXJzL2Nsay9tZWRpYXRlay9jbGstbXQ4
NTE2LmMNCmluZGV4IDlkNDI2MWUuLmVjMjE1ZTUgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2Nsay9t
ZWRpYXRlay9jbGstbXQ4NTE2LmMNCisrKyBiL2RyaXZlcnMvY2xrL21lZGlhdGVrL2Nsay1tdDg1
MTYuYw0KQEAgLTc3MCwxNyArNzcwLDE3IEBAIHN0YXRpYyB2b2lkIF9faW5pdCBtdGtfaW5mcmFj
ZmdfaW5pdChzdHJ1Y3QgZGV2aWNlX25vZGUgKm5vZGUpDQogfTsNCiANCiBzdGF0aWMgY29uc3Qg
c3RydWN0IG10a19wbGxfZGF0YSBwbGxzW10gPSB7DQotCVBMTChDTEtfQVBNSVhFRF9BUk1QTEws
ICJhcm1wbGwiLCAweDAxMDAsIDB4MDExMCwgMHgwMDAwMDAwMSwgMCwNCisJUExMKENMS19BUE1J
WEVEX0FSTVBMTCwgImFybXBsbCIsIDB4MDEwMCwgMHgwMTEwLCAwLCAwLA0KIAkJMjEsIDB4MDEw
NCwgMjQsIDAsIDB4MDEwNCwgMCksDQotCVBMTChDTEtfQVBNSVhFRF9NQUlOUExMLCAibWFpbnBs
bCIsIDB4MDEyMCwgMHgwMTMwLCAweDAwMDAwMDAxLA0KKwlQTEwoQ0xLX0FQTUlYRURfTUFJTlBM
TCwgIm1haW5wbGwiLCAweDAxMjAsIDB4MDEzMCwgMCwNCiAJCUhBVkVfUlNUX0JBUiwgMjEsIDB4
MDEyNCwgMjQsIDAsIDB4MDEyNCwgMCksDQotCVBMTChDTEtfQVBNSVhFRF9VTklWUExMLCAidW5p
dnBsbCIsIDB4MDE0MCwgMHgwMTUwLCAweDMwMDAwMDAxLA0KKwlQTEwoQ0xLX0FQTUlYRURfVU5J
VlBMTCwgInVuaXZwbGwiLCAweDAxNDAsIDB4MDE1MCwgMHgzMDAwMDAwMCwNCiAJCUhBVkVfUlNU
X0JBUiwgNywgMHgwMTQ0LCAyNCwgMCwgMHgwMTQ0LCAwKSwNCi0JUExMX0IoQ0xLX0FQTUlYRURf
TU1QTEwsICJtbXBsbCIsIDB4MDE2MCwgMHgwMTcwLCAweDAwMDAwMDAxLCAwLA0KKwlQTExfQihD
TEtfQVBNSVhFRF9NTVBMTCwgIm1tcGxsIiwgMHgwMTYwLCAweDAxNzAsIDAsIDAsDQogCQkyMSwg
MHgwMTY0LCAyNCwgMCwgMHgwMTY0LCAwLCBtbXBsbF9kaXZfdGFibGUpLA0KLQlQTEwoQ0xLX0FQ
TUlYRURfQVBMTDEsICJhcGxsMSIsIDB4MDE4MCwgMHgwMTkwLCAweDAwMDAwMDAxLCAwLA0KKwlQ
TEwoQ0xLX0FQTUlYRURfQVBMTDEsICJhcGxsMSIsIDB4MDE4MCwgMHgwMTkwLCAwLCAwLA0KIAkJ
MzEsIDB4MDE4MCwgMSwgMHgwMTk0LCAweDAxODQsIDApLA0KLQlQTEwoQ0xLX0FQTUlYRURfQVBM
TDIsICJhcGxsMiIsIDB4MDFBMCwgMHgwMUIwLCAweDAwMDAwMDAxLCAwLA0KKwlQTEwoQ0xLX0FQ
TUlYRURfQVBMTDIsICJhcGxsMiIsIDB4MDFBMCwgMHgwMUIwLCAwLCAwLA0KIAkJMzEsIDB4MDFB
MCwgMSwgMHgwMUI0LCAweDAxQTQsIDApLA0KIH07DQogDQotLSANCjEuOC4xLjEuZGlydHkNCg==


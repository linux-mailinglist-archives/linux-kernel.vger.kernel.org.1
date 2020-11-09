Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 389512AAF2E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 03:14:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729304AbgKICOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 21:14:00 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:34079 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729267AbgKICNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 21:13:55 -0500
X-UUID: 99b1305eb7154944b95ff5ce76da57b5-20201109
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=ARo+aZnxsWHz4UuONZ9dF73YwZqt8F6SqOJGyOAxrEk=;
        b=berhmkBz4a29ZW5/El8UFJmva8NuOhmoeQP1XllJnisFZ0AKiBSHYJoWnjFEIDsyIVdqWCuDkSJv3R+eEcqT70IQL0MXzqz8THpGvc+M112Glap2ylxSRyHonnIY747PnTPWvlgmwA8zjazbIG0RrCCA5hLAlSjAxw+DfnZrS8o=;
X-UUID: 99b1305eb7154944b95ff5ce76da57b5-20201109
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1250100646; Mon, 09 Nov 2020 10:13:46 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 9 Nov 2020 10:13:45 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 9 Nov 2020 10:13:45 +0800
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <srv_heupstream@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>
Subject: [PATCH v2 12/13] clk: mediatek: Clean up the pll_en_bit from en_mask on MT8516
Date:   Mon, 9 Nov 2020 10:13:27 +0800
Message-ID: <1604888008-30555-13-git-send-email-weiyi.lu@mediatek.com>
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


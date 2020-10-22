Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2E7295F0C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 14:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2899063AbgJVM4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 08:56:19 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:51600 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2899018AbgJVM4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 08:56:13 -0400
X-UUID: af2a9ba28c844719a4ac5da699394901-20201022
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=mh+ISXKN8d9oHbYFJXAvpOzPVOlrEqQUwJPxEwsLThg=;
        b=aqjfZs4CdmlB69taOgmdy5yE/0mjlvFfq6+Qqlt/u8+7HQEv9aWVaZuLx6VW1Wp9Nu97lPUM0LehRdszZncURgfdQEi1p/DoCJ/R1qMVfhxtzfrLGpV/KXE1MiaXEnpNSyUnIq4fxQMcg+6x8hgEMRE8FQGKZChYAfO91Fpj1+A=;
X-UUID: af2a9ba28c844719a4ac5da699394901-20201022
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 975464459; Thu, 22 Oct 2020 20:56:08 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 22 Oct 2020 20:56:07 +0800
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
Subject: [PATCH 07/12] clk: mediatek: Clean up the pll_en_bit from en_mask on MT7629
Date:   Thu, 22 Oct 2020 20:56:00 +0800
Message-ID: <1603371365-30863-8-git-send-email-weiyi.lu@mediatek.com>
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
L21lZGlhdGVrL2Nsay1tdDc2MjkuYyB8IDEyICsrKysrKy0tLS0tLQ0KIDEgZmlsZSBjaGFuZ2Vk
LCA2IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJz
L2Nsay9tZWRpYXRlay9jbGstbXQ3NjI5LmMgYi9kcml2ZXJzL2Nsay9tZWRpYXRlay9jbGstbXQ3
NjI5LmMNCmluZGV4IGI3M2JkZjEuLmUyMTA1ZWEgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2Nsay9t
ZWRpYXRlay9jbGstbXQ3NjI5LmMNCisrKyBiL2RyaXZlcnMvY2xrL21lZGlhdGVrL2Nsay1tdDc2
MjkuYw0KQEAgLTMzNSwxNyArMzM1LDE3IEBADQogfTsNCiANCiBzdGF0aWMgY29uc3Qgc3RydWN0
IG10a19wbGxfZGF0YSBwbGxzW10gPSB7DQotCVBMTChDTEtfQVBNSVhFRF9BUk1QTEwsICJhcm1w
bGwiLCAweDAyMDAsIDB4MDIwQywgMHgwMDAwMDAwMSwNCisJUExMKENMS19BUE1JWEVEX0FSTVBM
TCwgImFybXBsbCIsIDB4MDIwMCwgMHgwMjBDLCAwLA0KIAkgICAgMCwgMjEsIDB4MDIwNCwgMjQs
IDAsIDB4MDIwNCwgMCksDQotCVBMTChDTEtfQVBNSVhFRF9NQUlOUExMLCAibWFpbnBsbCIsIDB4
MDIxMCwgMHgwMjFDLCAweDAwMDAwMDAxLA0KKwlQTEwoQ0xLX0FQTUlYRURfTUFJTlBMTCwgIm1h
aW5wbGwiLCAweDAyMTAsIDB4MDIxQywgMCwNCiAJICAgIEhBVkVfUlNUX0JBUiwgMjEsIDB4MDIx
NCwgMjQsIDAsIDB4MDIxNCwgMCksDQotCVBMTChDTEtfQVBNSVhFRF9VTklWMlBMTCwgInVuaXYy
cGxsIiwgMHgwMjIwLCAweDAyMkMsIDB4MDAwMDAwMDEsDQorCVBMTChDTEtfQVBNSVhFRF9VTklW
MlBMTCwgInVuaXYycGxsIiwgMHgwMjIwLCAweDAyMkMsIDAsDQogCSAgICBIQVZFX1JTVF9CQVIs
IDcsIDB4MDIyNCwgMjQsIDAsIDB4MDIyNCwgMTQpLA0KLQlQTEwoQ0xLX0FQTUlYRURfRVRIMVBM
TCwgImV0aDFwbGwiLCAweDAzMDAsIDB4MDMxMCwgMHgwMDAwMDAwMSwNCisJUExMKENMS19BUE1J
WEVEX0VUSDFQTEwsICJldGgxcGxsIiwgMHgwMzAwLCAweDAzMTAsIDAsDQogCSAgICAwLCAyMSwg
MHgwMzAwLCAxLCAwLCAweDAzMDQsIDApLA0KLQlQTEwoQ0xLX0FQTUlYRURfRVRIMlBMTCwgImV0
aDJwbGwiLCAweDAzMTQsIDB4MDMyMCwgMHgwMDAwMDAwMSwNCisJUExMKENMS19BUE1JWEVEX0VU
SDJQTEwsICJldGgycGxsIiwgMHgwMzE0LCAweDAzMjAsIDAsDQogCSAgICAwLCAyMSwgMHgwMzE0
LCAxLCAwLCAweDAzMTgsIDApLA0KLQlQTEwoQ0xLX0FQTUlYRURfU0dNSVBMTCwgInNnbWlwbGwi
LCAweDAzNTgsIDB4MDM2OCwgMHgwMDAwMDAwMSwNCisJUExMKENMS19BUE1JWEVEX1NHTUlQTEws
ICJzZ21pcGxsIiwgMHgwMzU4LCAweDAzNjgsIDAsDQogCSAgICAwLCAyMSwgMHgwMzU4LCAxLCAw
LCAweDAzNUMsIDApLA0KIH07DQogDQotLSANCjEuOC4xLjEuZGlydHkNCg==


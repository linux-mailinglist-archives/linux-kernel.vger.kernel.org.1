Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C52F27801E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 08:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbgIYGBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 02:01:40 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:52571 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726990AbgIYGB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 02:01:28 -0400
X-UUID: 5d416aaf3f9445a49a623d9098491a00-20200925
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=+oTHt2LzYblbY+vX51iAcdTzDqC6useFBgdVG8Gw6/4=;
        b=c8eIREH/lT4Dm8i7GRGGL0lMZDS4z8A2WkAJKPB5McBcr0NsnXz2wqveJJY05Tu7ECphr5n0EHCkuUPrCfaTfxWJAwmUZGEbQ1w7rCqOdQQ7lzDjMwGct0oAt5tc4wMHfP5E1u0+mIpRsANuYorhKT0b/VwS1bY9JeHNSDBJvH4=;
X-UUID: 5d416aaf3f9445a49a623d9098491a00-20200925
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2106360181; Fri, 25 Sep 2020 14:01:21 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 MTKMBS31DR.mediatek.inc (172.27.6.102) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 25 Sep 2020 14:01:15 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 25 Sep 2020 14:01:15 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Felipe Balbi <balbi@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Al Cooper <alcooperx@gmail.com>,
        Sasi Kumar <sasi.kumar@broadcom.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH 01/11] usb: gadget: bdc: fix improper SPDX comment style for header file
Date:   Fri, 25 Sep 2020 13:58:09 +0800
Message-ID: <1601013499-28920-1-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 87EE5C38265DE706316B00379C1EEF46FF414D331F643A1C35CE186830F09DEE2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rm9yIEMgaGVhZGVyIGZpbGVzIERvY3VtZW50YXRpb24vcHJvY2Vzcy9saWNlbnNlLXJ1bGVzLnJz
dA0KbWFuZGF0ZXMgQy1saWtlIGNvbW1lbnRzIChvcHBvc2VkIHRvIEMgc291cmNlIGZpbGVzIHdo
ZXJlDQpDKysgc3R5bGUgc2hvdWxkIGJlIHVzZWQpLg0KDQpDaGFuZ2UtSWQ6IEk3MGFkMjAzOGUy
MGJhOTI0OTcwMjhkNjg3YzYyZDYzYzlmZjkzOTkxDQpDYzogRmxvcmlhbiBGYWluZWxsaSA8Zi5m
YWluZWxsaUBnbWFpbC5jb20+DQpTaWduZWQtb2ZmLWJ5OiBDaHVuZmVuZyBZdW4gPGNodW5mZW5n
Lnl1bkBtZWRpYXRlay5jb20+DQpBY2tlZC1ieTogRmxvcmlhbiBGYWluZWxsaSA8Zi5mYWluZWxs
aUBnbWFpbC5jb20+DQotLS0NCiBkcml2ZXJzL3VzYi9nYWRnZXQvdWRjL2JkYy9iZGMuaCAgICAg
fCAyICstDQogZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9iZGMvYmRjX2NtZC5oIHwgMiArLQ0KIGRy
aXZlcnMvdXNiL2dhZGdldC91ZGMvYmRjL2JkY19kYmcuaCB8IDIgKy0NCiBkcml2ZXJzL3VzYi9n
YWRnZXQvdWRjL2JkYy9iZGNfZXAuaCAgfCAyICstDQogNCBmaWxlcyBjaGFuZ2VkLCA0IGluc2Vy
dGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9nYWRn
ZXQvdWRjL2JkYy9iZGMuaCBiL2RyaXZlcnMvdXNiL2dhZGdldC91ZGMvYmRjL2JkYy5oDQppbmRl
eCBhYzc1ZTI1Li5mY2JhNzdlIDEwMDY0NA0KLS0tIGEvZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9i
ZGMvYmRjLmgNCisrKyBiL2RyaXZlcnMvdXNiL2dhZGdldC91ZGMvYmRjL2JkYy5oDQpAQCAtMSw0
ICsxLDQgQEANCi0vLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMCsNCisvKiBTUERY
LUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMCsgKi8NCiAvKg0KICAqIGJkYy5oIC0gaGVhZGVy
IGZvciB0aGUgQlJDTSBCREMgVVNCMy4wIGRldmljZSBjb250cm9sbGVyDQogICoNCmRpZmYgLS1n
aXQgYS9kcml2ZXJzL3VzYi9nYWRnZXQvdWRjL2JkYy9iZGNfY21kLmggYi9kcml2ZXJzL3VzYi9n
YWRnZXQvdWRjL2JkYy9iZGNfY21kLmgNCmluZGV4IDI5Y2M5ODguLjM3M2U2NzQgMTAwNjQ0DQot
LS0gYS9kcml2ZXJzL3VzYi9nYWRnZXQvdWRjL2JkYy9iZGNfY21kLmgNCisrKyBiL2RyaXZlcnMv
dXNiL2dhZGdldC91ZGMvYmRjL2JkY19jbWQuaA0KQEAgLTEsNCArMSw0IEBADQotLy8gU1BEWC1M
aWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjArDQorLyogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6
IEdQTC0yLjArICovDQogLyoNCiAgKiBiZGNfY21kLmggLSBoZWFkZXIgZm9yIHRoZSBCREMgZGVi
dWcgZnVuY3Rpb25zDQogICoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9nYWRnZXQvdWRjL2Jk
Yy9iZGNfZGJnLmggYi9kcml2ZXJzL3VzYi9nYWRnZXQvdWRjL2JkYy9iZGNfZGJnLmgNCmluZGV4
IDM3M2Q1YWIuLjg1OWQ1ODggMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3VzYi9nYWRnZXQvdWRjL2Jk
Yy9iZGNfZGJnLmgNCisrKyBiL2RyaXZlcnMvdXNiL2dhZGdldC91ZGMvYmRjL2JkY19kYmcuaA0K
QEAgLTEsNCArMSw0IEBADQotLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjArDQor
LyogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjArICovDQogLyoNCiAgKiBiZGNfZGJn
LmggLSBoZWFkZXIgZm9yIHRoZSBCREMgZGVidWcgZnVuY3Rpb25zDQogICoNCmRpZmYgLS1naXQg
YS9kcml2ZXJzL3VzYi9nYWRnZXQvdWRjL2JkYy9iZGNfZXAuaCBiL2RyaXZlcnMvdXNiL2dhZGdl
dC91ZGMvYmRjL2JkY19lcC5oDQppbmRleCBhMzdmZjgwMy4uNWJiZDczZiAxMDA2NDQNCi0tLSBh
L2RyaXZlcnMvdXNiL2dhZGdldC91ZGMvYmRjL2JkY19lcC5oDQorKysgYi9kcml2ZXJzL3VzYi9n
YWRnZXQvdWRjL2JkYy9iZGNfZXAuaA0KQEAgLTEsNCArMSw0IEBADQotLy8gU1BEWC1MaWNlbnNl
LUlkZW50aWZpZXI6IEdQTC0yLjArDQorLyogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0y
LjArICovDQogLyoNCiAgKiBiZGNfZXAuaCAtIGhlYWRlciBmb3IgdGhlIEJEQyBkZWJ1ZyBmdW5j
dGlvbnMNCiAgKg0KLS0gDQoxLjguMS4xLmRpcnR5DQo=


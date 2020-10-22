Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 166F4295F11
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 14:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2899095AbgJVM4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 08:56:31 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:44034 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2899056AbgJVM4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 08:56:20 -0400
X-UUID: 2f0e1791af684884892d04781f050fdb-20201022
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=xh4EuY2RcMtqZ5iWsGVDnw7AsLhcg0mrhQQvuCBZqTk=;
        b=MzV/8vk3RkhRLsBMggthw+rlWF72y16T/DBtsiF7Uv8BvoWbdnL08+vj7HNxsiJ5zIJ8SxN/AMTtWxa3vZx5ZnIjDbNaoWy1vGE52UUM3RwYP5YcyD7thmSyENSH4dI8Oh4tV4uKQLx6TDZ7r6xFMdX4hoc64/6JQyxTN3nYqMM=;
X-UUID: 2f0e1791af684884892d04781f050fdb-20201022
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 513383610; Thu, 22 Oct 2020 20:56:13 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
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
Subject: [PATCH 12/12] clk: mediatek: limit en_mask to a pure div_en_mask
Date:   Thu, 22 Oct 2020 20:56:05 +0800
Message-ID: <1603371365-30863-13-git-send-email-weiyi.lu@mediatek.com>
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

QmVjYXVzZSBhbGwgcGxsIGRhdGEgaGFzIGJlZW4gdXBkYXRlZC4gV2Ugbm8gbG9uZ2VyIGFsbG93
DQplbl9tYXNrIGlzIGEgY29tYmluYXRpb24gb2YgcGxsX2VuX2JpdCBhbmQgZGl2X2VuX21hc2su
DQoNClNpZ25lZC1vZmYtYnk6IFdlaXlpIEx1IDx3ZWl5aS5sdUBtZWRpYXRlay5jb20+DQotLS0N
CiBkcml2ZXJzL2Nsay9tZWRpYXRlay9jbGstcGxsLmMgfCAxMiArKysrLS0tLS0tLS0NCiAxIGZp
bGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0
IGEvZHJpdmVycy9jbGsvbWVkaWF0ZWsvY2xrLXBsbC5jIGIvZHJpdmVycy9jbGsvbWVkaWF0ZWsv
Y2xrLXBsbC5jDQppbmRleCAxMWVkNWQxLi5lMGIwMGJjIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9j
bGsvbWVkaWF0ZWsvY2xrLXBsbC5jDQorKysgYi9kcml2ZXJzL2Nsay9tZWRpYXRlay9jbGstcGxs
LmMNCkBAIC0yMzgsNyArMjM4LDYgQEAgc3RhdGljIGludCBtdGtfcGxsX3ByZXBhcmUoc3RydWN0
IGNsa19odyAqaHcpDQogew0KIAlzdHJ1Y3QgbXRrX2Nsa19wbGwgKnBsbCA9IHRvX210a19jbGtf
cGxsKGh3KTsNCiAJdTMyIHI7DQotCXUzMiBkaXZfZW5fbWFzazsNCiANCiAJciA9IHJlYWRsKHBs
bC0+cHdyX2FkZHIpIHwgQ09OMF9QV1JfT047DQogCXdyaXRlbChyLCBwbGwtPnB3cl9hZGRyKTsN
CkBAIC0yNTEsOSArMjUwLDggQEAgc3RhdGljIGludCBtdGtfcGxsX3ByZXBhcmUoc3RydWN0IGNs
a19odyAqaHcpDQogCXIgPSByZWFkbChwbGwtPmJhc2VfYWRkciArIFJFR19DT04wKSB8IENPTjBf
QkFTRV9FTjsNCiAJd3JpdGVsKHIsIHBsbC0+YmFzZV9hZGRyICsgUkVHX0NPTjApOw0KIA0KLQlk
aXZfZW5fbWFzayA9IHBsbC0+ZGF0YS0+ZW5fbWFzayAmIH5DT04wX0JBU0VfRU47DQotCWlmIChk
aXZfZW5fbWFzaykgew0KLQkJciA9IHJlYWRsKHBsbC0+YmFzZV9hZGRyICsgUkVHX0NPTjApIHwg
ZGl2X2VuX21hc2s7DQorCWlmIChwbGwtPmRhdGEtPmVuX21hc2spIHsNCisJCXIgPSByZWFkbChw
bGwtPmJhc2VfYWRkciArIFJFR19DT04wKSB8IHBsbC0+ZGF0YS0+ZW5fbWFzazsNCiAJCXdyaXRl
bChyLCBwbGwtPmJhc2VfYWRkciArIFJFR19DT04wKTsNCiAJfQ0KIA0KQEAgLTI3NCw3ICsyNzIs
NiBAQCBzdGF0aWMgdm9pZCBtdGtfcGxsX3VucHJlcGFyZShzdHJ1Y3QgY2xrX2h3ICpodykNCiB7
DQogCXN0cnVjdCBtdGtfY2xrX3BsbCAqcGxsID0gdG9fbXRrX2Nsa19wbGwoaHcpOw0KIAl1MzIg
cjsNCi0JdTMyIGRpdl9lbl9tYXNrOw0KIA0KIAlpZiAocGxsLT5kYXRhLT5mbGFncyAmIEhBVkVf
UlNUX0JBUikgew0KIAkJciA9IHJlYWRsKHBsbC0+YmFzZV9hZGRyICsgUkVHX0NPTjApOw0KQEAg
LTI4NCw5ICsyODEsOCBAQCBzdGF0aWMgdm9pZCBtdGtfcGxsX3VucHJlcGFyZShzdHJ1Y3QgY2xr
X2h3ICpodykNCiANCiAJX19tdGtfcGxsX3R1bmVyX2Rpc2FibGUocGxsKTsNCiANCi0JZGl2X2Vu
X21hc2sgPSBwbGwtPmRhdGEtPmVuX21hc2sgJiB+Q09OMF9CQVNFX0VOOw0KLQlpZiAoZGl2X2Vu
X21hc2spIHsNCi0JCXIgPSByZWFkbChwbGwtPmJhc2VfYWRkciArIFJFR19DT04wKSAmIH5kaXZf
ZW5fbWFzazsNCisJaWYgKHBsbC0+ZGF0YS0+ZW5fbWFzaykgew0KKwkJciA9IHJlYWRsKHBsbC0+
YmFzZV9hZGRyICsgUkVHX0NPTjApICYgfnBsbC0+ZGF0YS0+ZW5fbWFzazsNCiAJCXdyaXRlbChy
LCBwbGwtPmJhc2VfYWRkciArIFJFR19DT04wKTsNCiAJfQ0KIA0KLS0gDQoxLjguMS4xLmRpcnR5
DQo=


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68B063002AD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 13:17:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbhAVMNn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 07:13:43 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:4802 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727873AbhAVMEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 07:04:36 -0500
X-UUID: 1d01b47f91d34447bb6b8096145a337a-20210122
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=G2eE9wL7HhcizK3EFDY9U/ufvtSBlmAXs764fz6NoKg=;
        b=XnfSmWYMzaVm8hYue9f5T2eDf9KR4MQLCbIN3J2iDZLAsu14lb3FdKmplzsSMKyeq2H6SjMA2XNcrpC96v+McIdYbe889J3qul/Om2eHDH6FHwnkBUgI0TRJrLwDDxkpcto6lYH3bQxgHEVBN/g4AiIfKAYl5u//FtfP3eHvGrk=;
X-UUID: 1d01b47f91d34447bb6b8096145a337a-20210122
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1887820331; Fri, 22 Jan 2021 20:03:44 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 22 Jan 2021 20:03:42 +0800
Received: from mtkslt301.mediatek.inc (10.21.14.114) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 22 Jan 2021 20:03:41 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Min Guo <min.guo@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-usb@vger.kernel.org>
Subject: [PATCH next v2 10/17] arm64: dts: mediatek: mt8173: fix dtbs_check warning
Date:   Fri, 22 Jan 2021 20:03:16 +0800
Message-ID: <20210122120323.4337-10-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210122120323.4337-1-chunfeng.yun@mediatek.com>
References: <20210122120323.4337-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: B19C3F9572A0FEF8FAAE59C22C448E3782D28DF4841214FB181B3E4263AA14882000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGFybW9uaXplIG5vZGVzIG5hbWVzLCBjb21wYXRpYmxlcyBhbmQgcmVtb3ZlIHVudXNlZCBwcm9w
ZXJ0eS4NCg0KU2lnbmVkLW9mZi1ieTogQ2h1bmZlbmcgWXVuIDxjaHVuZmVuZy55dW5AbWVkaWF0
ZWsuY29tPg0KLS0tDQp2Mjogbm8gY2hhbmdlcw0KLS0tDQogYXJjaC9hcm02NC9ib290L2R0cy9t
ZWRpYXRlay9tdDgxNzMtZXZiLmR0cyB8ICA0ICstLS0NCiBhcmNoL2FybTY0L2Jvb3QvZHRzL21l
ZGlhdGVrL210ODE3My5kdHNpICAgIHwgMTMgKysrKysrKy0tLS0tLQ0KIDIgZmlsZXMgY2hhbmdl
ZCwgOCBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvYXJjaC9h
cm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgxNzMtZXZiLmR0cyBiL2FyY2gvYXJtNjQvYm9vdC9k
dHMvbWVkaWF0ZWsvbXQ4MTczLWV2Yi5kdHMNCmluZGV4IDZkZmZhZGEyZTY2Yi4uMGNlODFjNGZl
ODFlIDEwMDY0NA0KLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgxNzMtZXZi
LmR0cw0KKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgxNzMtZXZiLmR0cw0K
QEAgLTUxNiwxMCArNTE2LDggQEANCiAJZXh0Y29uID0gPCZleHRjb25fdXNiPjsNCiAJZHJfbW9k
ZSA9ICJvdGciOw0KIAl3YWtldXAtc291cmNlOw0KLQlwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQi
LCAiaWRfZmxvYXQiLCAiaWRfZ3JvdW5kIjsNCisJcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IjsN
CiAJcGluY3RybC0wID0gPCZ1c2JfaWRfcGluc19mbG9hdD47DQotCXBpbmN0cmwtMSA9IDwmdXNi
X2lkX3BpbnNfZmxvYXQ+Ow0KLQlwaW5jdHJsLTIgPSA8JnVzYl9pZF9waW5zX2dyb3VuZD47DQog
CXN0YXR1cyA9ICJva2F5IjsNCiB9Ow0KIA0KZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9k
dHMvbWVkaWF0ZWsvbXQ4MTczLmR0c2kgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210
ODE3My5kdHNpDQppbmRleCA3ZmE4NzBlNDM4NmEuLjc1MDQwYTgyMGYwZCAxMDA2NDQNCi0tLSBh
L2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4MTczLmR0c2kNCisrKyBiL2FyY2gvYXJt
NjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4MTczLmR0c2kNCkBAIC02MzEsNyArNjMxLDcgQEANCiAJ
CQkjbWJveC1jZWxscyA9IDwyPjsNCiAJCX07DQogDQotCQltaXBpX3R4MDogbWlwaS1kcGh5QDEw
MjE1MDAwIHsNCisJCW1pcGlfdHgwOiBkc2ktcGh5QDEwMjE1MDAwIHsNCiAJCQljb21wYXRpYmxl
ID0gIm1lZGlhdGVrLG10ODE3My1taXBpLXR4IjsNCiAJCQlyZWcgPSA8MCAweDEwMjE1MDAwIDAg
MHgxMDAwPjsNCiAJCQljbG9ja3MgPSA8JmNsazI2bT47DQpAQCAtNjQxLDcgKzY0MSw3IEBADQog
CQkJc3RhdHVzID0gImRpc2FibGVkIjsNCiAJCX07DQogDQotCQltaXBpX3R4MTogbWlwaS1kcGh5
QDEwMjE2MDAwIHsNCisJCW1pcGlfdHgxOiBkc2ktcGh5QDEwMjE2MDAwIHsNCiAJCQljb21wYXRp
YmxlID0gIm1lZGlhdGVrLG10ODE3My1taXBpLXR4IjsNCiAJCQlyZWcgPSA8MCAweDEwMjE2MDAw
IDAgMHgxMDAwPjsNCiAJCQljbG9ja3MgPSA8JmNsazI2bT47DQpAQCAtOTI2LDcgKzkyNiw3IEBA
DQogCQl9Ow0KIA0KIAkJc3N1c2I6IHVzYkAxMTI3MTAwMCB7DQotCQkJY29tcGF0aWJsZSA9ICJt
ZWRpYXRlayxtdDgxNzMtbXR1MyI7DQorCQkJY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxNzMt
bXR1MyIsICJtZWRpYXRlayxtdHUzIjsNCiAJCQlyZWcgPSA8MCAweDExMjcxMDAwIDAgMHgzMDAw
PiwNCiAJCQkgICAgICA8MCAweDExMjgwNzAwIDAgMHgwMTAwPjsNCiAJCQlyZWctbmFtZXMgPSAi
bWFjIiwgImlwcGMiOw0KQEAgLTk0Myw4ICs5NDMsOSBAQA0KIAkJCXJhbmdlczsNCiAJCQlzdGF0
dXMgPSAiZGlzYWJsZWQiOw0KIA0KLQkJCXVzYl9ob3N0OiB4aGNpQDExMjcwMDAwIHsNCi0JCQkJ
Y29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxNzMteGhjaSI7DQorCQkJdXNiX2hvc3Q6IHVzYkAx
MTI3MDAwMCB7DQorCQkJCWNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTczLXhoY2kiLA0KKwkJ
CQkJICAgICAibWVkaWF0ZWssbXRrLXhoY2kiOw0KIAkJCQlyZWcgPSA8MCAweDExMjcwMDAwIDAg
MHgxMDAwPjsNCiAJCQkJcmVnLW5hbWVzID0gIm1hYyI7DQogCQkJCWludGVycnVwdHMgPSA8R0lD
X1NQSSAxMTUgSVJRX1RZUEVfTEVWRUxfTE9XPjsNCkBAIC05NTUsNyArOTU2LDcgQEANCiAJCQl9
Ow0KIAkJfTsNCiANCi0JCXUzcGh5OiB1c2ItcGh5QDExMjkwMDAwIHsNCisJCXUzcGh5OiB0LXBo
eUAxMTI5MDAwMCB7DQogCQkJY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxNzMtdTNwaHkiOw0K
IAkJCXJlZyA9IDwwIDB4MTEyOTAwMDAgMCAweDgwMD47DQogCQkJI2FkZHJlc3MtY2VsbHMgPSA8
Mj47DQotLSANCjIuMTguMA0K


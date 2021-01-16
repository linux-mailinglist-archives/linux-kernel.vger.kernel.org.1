Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA5352F8C6C
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 10:08:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbhAPJIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jan 2021 04:08:09 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:37409 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725964AbhAPJIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jan 2021 04:08:07 -0500
X-UUID: 44dd7e5b6f204b0ba8a5a28406672d24-20210116
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=8JjP4iNPckNptA5IN5iH1mM9RqPYMtG6rWxQIJkZciM=;
        b=Za0Ypw/OSe0g9BFavmUn2VD1DwIcZ02H+yoAPpXxSsiNwz1yhEYWIu3h7ohP7mvb3z329J/AUuzQ/KG4+wmLUTOJaU1ECFV5hKKS8YCLwQaii0yNAd8/RbGqQGdbgb0/uHMnsNpS8scDB2isvQd/1M4iP76iB7Ovo9kN6XxNTJk=;
X-UUID: 44dd7e5b6f204b0ba8a5a28406672d24-20210116
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1212313793; Sat, 16 Jan 2021 17:07:02 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 16 Jan 2021 17:07:00 +0800
Received: from mtkslt301.mediatek.inc (10.21.14.114) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 16 Jan 2021 17:07:01 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Min Guo <min.guo@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-usb@vger.kernel.org>
Subject: [PATCH next 08/15] arm64: dts: mediatek: mt8173: fix dtbs_check warning
Date:   Sat, 16 Jan 2021 17:06:49 +0800
Message-ID: <20210116090656.11752-8-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210116090656.11752-1-chunfeng.yun@mediatek.com>
References: <20210116090656.11752-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: E09C197600F0E8FABD52C69DD3EE42E17E51B0BED898CD66137B451FA32132EC2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGFybW9uaXplIG5vZGVzIG5hbWVzLCBjb21wYXRpYmxlcyBhbmQgcmVtb3ZlIHVudXNlZCBwcm9w
ZXJ0eS4NCg0KU2lnbmVkLW9mZi1ieTogQ2h1bmZlbmcgWXVuIDxjaHVuZmVuZy55dW5AbWVkaWF0
ZWsuY29tPg0KLS0tDQogYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgxNzMtZXZiLmR0
cyB8ICA0ICstLS0NCiBhcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210ODE3My5kdHNpICAg
IHwgMTMgKysrKysrKy0tLS0tLQ0KIDIgZmlsZXMgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCA5
IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRl
ay9tdDgxNzMtZXZiLmR0cyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4MTczLWV2
Yi5kdHMNCmluZGV4IDZkZmZhZGEyZTY2Yi4uMGNlODFjNGZlODFlIDEwMDY0NA0KLS0tIGEvYXJj
aC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgxNzMtZXZiLmR0cw0KKysrIGIvYXJjaC9hcm02
NC9ib290L2R0cy9tZWRpYXRlay9tdDgxNzMtZXZiLmR0cw0KQEAgLTUxNiwxMCArNTE2LDggQEAN
CiAJZXh0Y29uID0gPCZleHRjb25fdXNiPjsNCiAJZHJfbW9kZSA9ICJvdGciOw0KIAl3YWtldXAt
c291cmNlOw0KLQlwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiLCAiaWRfZmxvYXQiLCAiaWRfZ3Jv
dW5kIjsNCisJcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IjsNCiAJcGluY3RybC0wID0gPCZ1c2Jf
aWRfcGluc19mbG9hdD47DQotCXBpbmN0cmwtMSA9IDwmdXNiX2lkX3BpbnNfZmxvYXQ+Ow0KLQlw
aW5jdHJsLTIgPSA8JnVzYl9pZF9waW5zX2dyb3VuZD47DQogCXN0YXR1cyA9ICJva2F5IjsNCiB9
Ow0KIA0KZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4MTczLmR0
c2kgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210ODE3My5kdHNpDQppbmRleCA3ZmE4
NzBlNDM4NmEuLjc1MDQwYTgyMGYwZCAxMDA2NDQNCi0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMv
bWVkaWF0ZWsvbXQ4MTczLmR0c2kNCisrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsv
bXQ4MTczLmR0c2kNCkBAIC02MzEsNyArNjMxLDcgQEANCiAJCQkjbWJveC1jZWxscyA9IDwyPjsN
CiAJCX07DQogDQotCQltaXBpX3R4MDogbWlwaS1kcGh5QDEwMjE1MDAwIHsNCisJCW1pcGlfdHgw
OiBkc2ktcGh5QDEwMjE1MDAwIHsNCiAJCQljb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE3My1t
aXBpLXR4IjsNCiAJCQlyZWcgPSA8MCAweDEwMjE1MDAwIDAgMHgxMDAwPjsNCiAJCQljbG9ja3Mg
PSA8JmNsazI2bT47DQpAQCAtNjQxLDcgKzY0MSw3IEBADQogCQkJc3RhdHVzID0gImRpc2FibGVk
IjsNCiAJCX07DQogDQotCQltaXBpX3R4MTogbWlwaS1kcGh5QDEwMjE2MDAwIHsNCisJCW1pcGlf
dHgxOiBkc2ktcGh5QDEwMjE2MDAwIHsNCiAJCQljb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE3
My1taXBpLXR4IjsNCiAJCQlyZWcgPSA8MCAweDEwMjE2MDAwIDAgMHgxMDAwPjsNCiAJCQljbG9j
a3MgPSA8JmNsazI2bT47DQpAQCAtOTI2LDcgKzkyNiw3IEBADQogCQl9Ow0KIA0KIAkJc3N1c2I6
IHVzYkAxMTI3MTAwMCB7DQotCQkJY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxNzMtbXR1MyI7
DQorCQkJY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxNzMtbXR1MyIsICJtZWRpYXRlayxtdHUz
IjsNCiAJCQlyZWcgPSA8MCAweDExMjcxMDAwIDAgMHgzMDAwPiwNCiAJCQkgICAgICA8MCAweDEx
MjgwNzAwIDAgMHgwMTAwPjsNCiAJCQlyZWctbmFtZXMgPSAibWFjIiwgImlwcGMiOw0KQEAgLTk0
Myw4ICs5NDMsOSBAQA0KIAkJCXJhbmdlczsNCiAJCQlzdGF0dXMgPSAiZGlzYWJsZWQiOw0KIA0K
LQkJCXVzYl9ob3N0OiB4aGNpQDExMjcwMDAwIHsNCi0JCQkJY29tcGF0aWJsZSA9ICJtZWRpYXRl
ayxtdDgxNzMteGhjaSI7DQorCQkJdXNiX2hvc3Q6IHVzYkAxMTI3MDAwMCB7DQorCQkJCWNvbXBh
dGlibGUgPSAibWVkaWF0ZWssbXQ4MTczLXhoY2kiLA0KKwkJCQkJICAgICAibWVkaWF0ZWssbXRr
LXhoY2kiOw0KIAkJCQlyZWcgPSA8MCAweDExMjcwMDAwIDAgMHgxMDAwPjsNCiAJCQkJcmVnLW5h
bWVzID0gIm1hYyI7DQogCQkJCWludGVycnVwdHMgPSA8R0lDX1NQSSAxMTUgSVJRX1RZUEVfTEVW
RUxfTE9XPjsNCkBAIC05NTUsNyArOTU2LDcgQEANCiAJCQl9Ow0KIAkJfTsNCiANCi0JCXUzcGh5
OiB1c2ItcGh5QDExMjkwMDAwIHsNCisJCXUzcGh5OiB0LXBoeUAxMTI5MDAwMCB7DQogCQkJY29t
cGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxNzMtdTNwaHkiOw0KIAkJCXJlZyA9IDwwIDB4MTEyOTAw
MDAgMCAweDgwMD47DQogCQkJI2FkZHJlc3MtY2VsbHMgPSA8Mj47DQotLSANCjIuMTguMA0K


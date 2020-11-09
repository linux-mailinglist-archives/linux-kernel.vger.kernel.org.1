Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98E9A2AAF22
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 03:13:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729120AbgKICNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 21:13:41 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:38108 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729039AbgKICNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 21:13:40 -0500
X-UUID: 5cd194328ba34224b95f365358a9468a-20201109
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=QKYXBw3xj3qXNRxnbKjODyTeTt27HBcwJuuhlnsqFP0=;
        b=Y1Yb2fKerY5SlFSeLmmT5ahXGORU9ZhEkFk4AA8kWzMhUyz4SPyzzoTPpki594gQ1Fe1fi5yN+KcIMLzBAXYI+TfqY6SuW/IhZpjhCyBscNA0NsRTBd1l0mgZzM42gk/um3SAT29CzZbzV9x7IU6YiHNIwmNVNfgEJ5M5ZOSIPE=;
X-UUID: 5cd194328ba34224b95f365358a9468a-20201109
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1590705612; Mon, 09 Nov 2020 10:13:37 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 9 Nov 2020 10:13:37 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 9 Nov 2020 10:13:30 +0800
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <srv_heupstream@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>
Subject: [PATCH v2 00/13] Clean up the pll_en_bit from en_mask on all the MediaTek clock drivers 
Date:   Mon, 9 Nov 2020 10:13:15 +0800
Message-ID: <1604888008-30555-1-git-send-email-weiyi.lu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBzZXJpZXMgaXMgYmFzZWQgb24gdjUuMTAtcmMxIGFuZA0KW3Y1LDA3LzI0XSBjbGs6IG1l
ZGlhdGVrOiBGaXggYXN5bW1ldHJpY2FsIFBMTCBlbmFibGUgYW5kIGRpc2FibGUgY29udHJvbFsx
XSBpbiBNZWRpYXRlayBNVDgxOTIgY2xvY2sgc3VwcG9ydCBzZXJpZXMNCg0KWzFdIGh0dHBzOi8v
cGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC1tZWRpYXRlay9wYXRjaC8xNjA0ODg3
NDI5LTI5NDQ1LTgtZ2l0LXNlbmQtZW1haWwtd2VpeWkubHVAbWVkaWF0ZWsuY29tLw0KDQpjaGFu
Z2Ugc2luY2UgdjE6DQotIGFkZCBwYXRjaCBmb3IgTVQ4MTY3DQoNCldlaXlpIEx1ICgxMyk6DQog
IGNsazogbWVkaWF0ZWs6IENsZWFuIHVwIHRoZSBwbGxfZW5fYml0IGZyb20gZW5fbWFzayBvbiBN
VDI3MDENCiAgY2xrOiBtZWRpYXRlazogQ2xlYW4gdXAgdGhlIHBsbF9lbl9iaXQgZnJvbSBlbl9t
YXNrIG9uIE1UMjcxMg0KICBjbGs6IG1lZGlhdGVrOiBDbGVhbiB1cCB0aGUgcGxsX2VuX2JpdCBm
cm9tIGVuX21hc2sgb24gTVQ2NzY1DQogIGNsazogbWVkaWF0ZWs6IENsZWFuIHVwIHRoZSBwbGxf
ZW5fYml0IGZyb20gZW5fbWFzayBvbiBNVDY3NzkNCiAgY2xrOiBtZWRpYXRlazogQ2xlYW4gdXAg
dGhlIHBsbF9lbl9iaXQgZnJvbSBlbl9tYXNrIG9uIE1UNjc5Nw0KICBjbGs6IG1lZGlhdGVrOiBD
bGVhbiB1cCB0aGUgcGxsX2VuX2JpdCBmcm9tIGVuX21hc2sgb24gTVQ3NjIyDQogIGNsazogbWVk
aWF0ZWs6IENsZWFuIHVwIHRoZSBwbGxfZW5fYml0IGZyb20gZW5fbWFzayBvbiBNVDc2MjkNCiAg
Y2xrOiBtZWRpYXRlazogQ2xlYW4gdXAgdGhlIHBsbF9lbl9iaXQgZnJvbSBlbl9tYXNrIG9uIE1U
ODEzNQ0KICBjbGs6IG1lZGlhdGVrOiBDbGVhbiB1cCB0aGUgcGxsX2VuX2JpdCBmcm9tIGVuX21h
c2sgb24gTVQ4MTY3DQogIGNsazogbWVkaWF0ZWs6IENsZWFuIHVwIHRoZSBwbGxfZW5fYml0IGZy
b20gZW5fbWFzayBvbiBNVDgxNzMNCiAgY2xrOiBtZWRpYXRlazogQ2xlYW4gdXAgdGhlIHBsbF9l
bl9iaXQgZnJvbSBlbl9tYXNrIG9uIE1UODE4Mw0KICBjbGs6IG1lZGlhdGVrOiBDbGVhbiB1cCB0
aGUgcGxsX2VuX2JpdCBmcm9tIGVuX21hc2sgb24gTVQ4NTE2DQogIGNsazogbWVkaWF0ZWs6IHVz
ZSBlbl9tYXNrIGFzIGEgcHVyZSBkaXZfZW5fbWFzaw0KDQogZHJpdmVycy9jbGsvbWVkaWF0ZWsv
Y2xrLW10MjcwMS5jIHwgMjYgKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0NCiBkcml2ZXJzL2Ns
ay9tZWRpYXRlay9jbGstbXQyNzEyLmMgfCAzMCArKysrKysrKysrKysrKystLS0tLS0tLS0tLS0t
LS0NCiBkcml2ZXJzL2Nsay9tZWRpYXRlay9jbGstbXQ2NzY1LmMgfCAyMCArKysrKysrKysrLS0t
LS0tLS0tLQ0KIGRyaXZlcnMvY2xrL21lZGlhdGVrL2Nsay1tdDY3NzkuYyB8IDI0ICsrKysrKysr
KysrKy0tLS0tLS0tLS0tLQ0KIGRyaXZlcnMvY2xrL21lZGlhdGVrL2Nsay1tdDY3OTcuYyB8IDIw
ICsrKysrKysrKystLS0tLS0tLS0tDQogZHJpdmVycy9jbGsvbWVkaWF0ZWsvY2xrLW10NzYyMi5j
IHwgMTggKysrKysrKysrLS0tLS0tLS0tDQogZHJpdmVycy9jbGsvbWVkaWF0ZWsvY2xrLW10NzYy
OS5jIHwgMTIgKysrKysrLS0tLS0tDQogZHJpdmVycy9jbGsvbWVkaWF0ZWsvY2xrLW10ODEzNS5j
IHwgMjAgKysrKysrKysrKy0tLS0tLS0tLS0NCiBkcml2ZXJzL2Nsay9tZWRpYXRlay9jbGstbXQ4
MTY3LmMgfCAxNiArKysrKysrKy0tLS0tLS0tDQogZHJpdmVycy9jbGsvbWVkaWF0ZWsvY2xrLW10
ODE3My5jIHwgMjggKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLQ0KIGRyaXZlcnMvY2xrL21l
ZGlhdGVrL2Nsay1tdDgxODMuYyB8IDIyICsrKysrKysrKysrLS0tLS0tLS0tLS0NCiBkcml2ZXJz
L2Nsay9tZWRpYXRlay9jbGstbXQ4NTE2LmMgfCAxMiArKysrKystLS0tLS0NCiBkcml2ZXJzL2Ns
ay9tZWRpYXRlay9jbGstcGxsLmMgICAgfCAxMiArKysrLS0tLS0tLS0NCiAxMyBmaWxlcyBjaGFu
Z2VkLCAxMjggaW5zZXJ0aW9ucygrKSwgMTMyIGRlbGV0aW9ucygtKQ0K


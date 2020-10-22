Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9539A295F08
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 14:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2899040AbgJVM4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 08:56:14 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:44046 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2899026AbgJVM4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 08:56:12 -0400
X-UUID: ada377b4dd8645d09b260f125417036b-20201022
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=ovUUUcqhJC9H5EtfgPHi7yKW/d7yDwoYEfaWYv3LJUw=;
        b=WR2E9cNT7cQN5gj340ED1PUpcM6E3aS7Gf4+nIcD9rswevQTix1dr1lbHRlmt6/wm9zHo5lmVK50hHmm2hqkvSpT87QUqtxB+OpdgCHgiLhbYjVVSqC6ojd+lz268POzjiRnuxsgqAZ5RXrIusZDG1JMkAKXfsiz36DJNvNRsvM=;
X-UUID: ada377b4dd8645d09b260f125417036b-20201022
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 997616852; Thu, 22 Oct 2020 20:56:08 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 22 Oct 2020 20:56:06 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 22 Oct 2020 20:56:06 +0800
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <srv_heupstream@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>
Subject: [PATCH 00/12] Clean up the pll_en_bit from en_mask on all the MediaTek clock drivers
Date:   Thu, 22 Oct 2020 20:55:53 +0800
Message-ID: <1603371365-30863-1-git-send-email-weiyi.lu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBzZXJpZXMgaXMgYmFzZWQgb24gdjUuOS1yYzEgYW5kDQpbdjQsMDkvMzRdIGNsazogbWVk
aWF0ZWs6IEZpeCBhc3ltbWV0cmljYWwgUExMIGVuYWJsZSBhbmQgZGlzYWJsZSBjb250cm9sWzFd
DQppbiBNZWRpYXRlayBNVDgxOTIgY2xvY2sgc3VwcG9ydCBzZXJpZXMNCg0KWzFdIGh0dHBzOi8v
cGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC1tZWRpYXRlay9wYXRjaC8xNjAzMzcw
MjQ3LTMwNDM3LTEwLWdpdC1zZW5kLWVtYWlsLXdlaXlpLmx1QG1lZGlhdGVrLmNvbS8NCg0KV2Vp
eWkgTHUgKDEyKToNCiAgY2xrOiBtZWRpYXRlazogQ2xlYW4gdXAgdGhlIHBsbF9lbl9iaXQgZnJv
bSBlbl9tYXNrIG9uIE1UMjcwMQ0KICBjbGs6IG1lZGlhdGVrOiBDbGVhbiB1cCB0aGUgcGxsX2Vu
X2JpdCBmcm9tIGVuX21hc2sgb24gTVQyNzEyDQogIGNsazogbWVkaWF0ZWs6IENsZWFuIHVwIHRo
ZSBwbGxfZW5fYml0IGZyb20gZW5fbWFzayBvbiBNVDY3NjUNCiAgY2xrOiBtZWRpYXRlazogQ2xl
YW4gdXAgdGhlIHBsbF9lbl9iaXQgZnJvbSBlbl9tYXNrIG9uIE1UNjc3OQ0KICBjbGs6IG1lZGlh
dGVrOiBDbGVhbiB1cCB0aGUgcGxsX2VuX2JpdCBmcm9tIGVuX21hc2sgb24gTVQ2Nzk3DQogIGNs
azogbWVkaWF0ZWs6IENsZWFuIHVwIHRoZSBwbGxfZW5fYml0IGZyb20gZW5fbWFzayBvbiBNVDc2
MjINCiAgY2xrOiBtZWRpYXRlazogQ2xlYW4gdXAgdGhlIHBsbF9lbl9iaXQgZnJvbSBlbl9tYXNr
IG9uIE1UNzYyOQ0KICBjbGs6IG1lZGlhdGVrOiBDbGVhbiB1cCB0aGUgcGxsX2VuX2JpdCBmcm9t
IGVuX21hc2sgb24gTVQ4MTM1DQogIGNsazogbWVkaWF0ZWs6IENsZWFuIHVwIHRoZSBwbGxfZW5f
Yml0IGZyb20gZW5fbWFzayBvbiBNVDgxNzMNCiAgY2xrOiBtZWRpYXRlazogQ2xlYW4gdXAgdGhl
IHBsbF9lbl9iaXQgZnJvbSBlbl9tYXNrIG9uIE1UODE4Mw0KICBjbGs6IG1lZGlhdGVrOiBDbGVh
biB1cCB0aGUgcGxsX2VuX2JpdCBmcm9tIGVuX21hc2sgb24gTVQ4NTE2DQogIGNsazogbWVkaWF0
ZWs6IGxpbWl0IGVuX21hc2sgdG8gYSBwdXJlIGRpdl9lbl9tYXNrDQoNCiBkcml2ZXJzL2Nsay9t
ZWRpYXRlay9jbGstbXQyNzAxLmMgfCAyNiArKysrKysrKysrKysrLS0tLS0tLS0tLS0tLQ0KIGRy
aXZlcnMvY2xrL21lZGlhdGVrL2Nsay1tdDI3MTIuYyB8IDMwICsrKysrKysrKysrKysrKy0tLS0t
LS0tLS0tLS0tLQ0KIGRyaXZlcnMvY2xrL21lZGlhdGVrL2Nsay1tdDY3NjUuYyB8IDIwICsrKysr
KysrKystLS0tLS0tLS0tDQogZHJpdmVycy9jbGsvbWVkaWF0ZWsvY2xrLW10Njc3OS5jIHwgMjQg
KysrKysrKysrKysrLS0tLS0tLS0tLS0tDQogZHJpdmVycy9jbGsvbWVkaWF0ZWsvY2xrLW10Njc5
Ny5jIHwgMjAgKysrKysrKysrKy0tLS0tLS0tLS0NCiBkcml2ZXJzL2Nsay9tZWRpYXRlay9jbGst
bXQ3NjIyLmMgfCAxOCArKysrKysrKystLS0tLS0tLS0NCiBkcml2ZXJzL2Nsay9tZWRpYXRlay9j
bGstbXQ3NjI5LmMgfCAxMiArKysrKystLS0tLS0NCiBkcml2ZXJzL2Nsay9tZWRpYXRlay9jbGst
bXQ4MTM1LmMgfCAyMCArKysrKysrKysrLS0tLS0tLS0tLQ0KIGRyaXZlcnMvY2xrL21lZGlhdGVr
L2Nsay1tdDgxNzMuYyB8IDI4ICsrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0NCiBkcml2ZXJz
L2Nsay9tZWRpYXRlay9jbGstbXQ4MTgzLmMgfCAyMiArKysrKysrKysrKy0tLS0tLS0tLS0tDQog
ZHJpdmVycy9jbGsvbWVkaWF0ZWsvY2xrLW10ODUxNi5jIHwgMTIgKysrKysrLS0tLS0tDQogZHJp
dmVycy9jbGsvbWVkaWF0ZWsvY2xrLXBsbC5jICAgIHwgMTIgKysrKy0tLS0tLS0tDQogMTIgZmls
ZXMgY2hhbmdlZCwgMTIwIGluc2VydGlvbnMoKyksIDEyNCBkZWxldGlvbnMoLSkNCg==


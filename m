Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97BD82A252E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 08:29:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728092AbgKBH31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 02:29:27 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:54779 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727743AbgKBH30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 02:29:26 -0500
X-UUID: 61977ac1706346fc9e706c7ab32b53f0-20201102
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=EwMAk6C90zx3ggLjTVwBgHjheE+if1MCBTaw2ieul20=;
        b=MJI4YynXNnuMC61TASrV2gd2iOeqQ1Sf9E/FmvR4m3nq0/0Scz6pyi2e+eARahtjaC9vg/mE3h+UizLw4xU/2AmYoDnkgGzORyNHLxZSO8wn5SQ+W7jdErVnW2RAbnwv57vZlsuNupFabzzh90Y5EKGShM1bajzRwUIm1dX/dxg=;
X-UUID: 61977ac1706346fc9e706c7ab32b53f0-20201102
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <macpaul.lin@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 436479442; Mon, 02 Nov 2020 15:19:03 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 2 Nov 2020 15:19:01 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 2 Nov 2020 15:19:01 +0800
From:   Macpaul Lin <macpaul.lin@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Ainge Hsu <ainge.hsu@mediatek.com>,
        Eddie Hung <eddie.hung@mediatek.com>,
        Mediatek WSD Upstream <wsd_upstream@mediatek.com>,
        Macpaul Lin <macpaul.lin@mediatek.com>,
        Macpaul Lin <macpaul@gmail.com>
Subject: [PATCH 2/2] usb: host: XHCI: xhci-mtk.c: support mediatek,keep-clock-on
Date:   Mon, 2 Nov 2020 15:18:49 +0800
Message-ID: <1604301530-31546-2-git-send-email-macpaul.lin@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1604301530-31546-1-git-send-email-macpaul.lin@mediatek.com>
References: <1604301530-31546-1-git-send-email-macpaul.lin@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U29tZSBwbGF0Zm9ybSBkb3NlIG5vdCBzdXBwb3J0IHR1cm4gb2ZmIGNsb2NrIHdoZW4gc3lzdGVt
IHN1c3BlbmRpbmcuDQpXZSBhZGQgYW4gb3B0aW9uICJtZWRpYXRlayxrZWVwLWNsb2NrLW9uIiBm
b3IgZGlzdGlucXVpc2ggdGhlc2UgcGxhdGZvcm1zLg0KV2hlbiAibWVkaWF0ZWssa2VlcC1jbG9j
ay1vbiIgaGFzIGJlZW4gc2V0LCB4aGNpLW10ayBkcml2ZXIgd2lsbCBza2lwDQp0dXJuaW5nIGNs
b2NrIG9uIGFuZCBvZmYgZHVyaW5nIHN5c3RlbSBzdXNwZW5kIGFuZCByZXN1bWUuDQoNClNpZ25l
ZC1vZmYtYnk6IE1hY3BhdWwgTGluIDxtYWNwYXVsLmxpbkBtZWRpYXRlay5jb20+DQotLS0NCiBk
cml2ZXJzL3VzYi9ob3N0L3hoY2ktbXRrLmMgfCAgICA5ICsrKysrKystLQ0KIGRyaXZlcnMvdXNi
L2hvc3QveGhjaS1tdGsuaCB8ICAgIDEgKw0KIDIgZmlsZXMgY2hhbmdlZCwgOCBpbnNlcnRpb25z
KCspLCAyIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvaG9zdC94aGNp
LW10ay5jIGIvZHJpdmVycy91c2IvaG9zdC94aGNpLW10ay5jDQppbmRleCA0MzExZDRjLi5jNmMy
ODA0IDEwMDY0NA0KLS0tIGEvZHJpdmVycy91c2IvaG9zdC94aGNpLW10ay5jDQorKysgYi9kcml2
ZXJzL3VzYi9ob3N0L3hoY2ktbXRrLmMNCkBAIC00NjQsNiArNDY0LDkgQEAgc3RhdGljIGludCB4
aGNpX210a19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KIAlvZl9wcm9wZXJ0
eV9yZWFkX3UzMihub2RlLCAibWVkaWF0ZWssdTNwLWRpcy1tc2siLA0KIAkJCSAgICAgJm10ay0+
dTNwX2Rpc19tc2spOw0KIA0KKwkvKiBrZWVwIGNsb2NrIG9uIHdoZW4gc3VzcGVuZGluZyBvbiBz
b21lIHBsYXRmb3JtICovDQorCW10ay0+a2VlcF9jbGtfb24gPSBvZl9wcm9wZXJ0eV9yZWFkX2Jv
b2wobm9kZSwgIm1lZGlhdGVrLGtlZXAtY2xvY2stb24iKTsNCisNCiAJcmV0ID0gdXNiX3dha2V1
cF9vZl9wcm9wZXJ0eV9wYXJzZShtdGssIG5vZGUpOw0KIAlpZiAocmV0KSB7DQogCQlkZXZfZXJy
KGRldiwgImZhaWxlZCB0byBwYXJzZSB1d2sgcHJvcGVydHlcbiIpOw0KQEAgLTYyNCw3ICs2Mjcs
OCBAQCBzdGF0aWMgaW50IF9fbWF5YmVfdW51c2VkIHhoY2lfbXRrX3N1c3BlbmQoc3RydWN0IGRl
dmljZSAqZGV2KQ0KIAlkZWxfdGltZXJfc3luYygmeGhjaS0+c2hhcmVkX2hjZC0+cmhfdGltZXIp
Ow0KIA0KIAl4aGNpX210a19ob3N0X2Rpc2FibGUobXRrKTsNCi0JeGhjaV9tdGtfY2xrc19kaXNh
YmxlKG10ayk7DQorCWlmICghbXRrLT5rZWVwX2Nsa19vbikNCisJCXhoY2lfbXRrX2Nsa3NfZGlz
YWJsZShtdGspOw0KIAl1c2Jfd2FrZXVwX3NldChtdGssIHRydWUpOw0KIAlyZXR1cm4gMDsNCiB9
DQpAQCAtNjM2LDcgKzY0MCw4IEBAIHN0YXRpYyBpbnQgX19tYXliZV91bnVzZWQgeGhjaV9tdGtf
cmVzdW1lKHN0cnVjdCBkZXZpY2UgKmRldikNCiAJc3RydWN0IHhoY2lfaGNkICp4aGNpID0gaGNk
X3RvX3hoY2koaGNkKTsNCiANCiAJdXNiX3dha2V1cF9zZXQobXRrLCBmYWxzZSk7DQotCXhoY2lf
bXRrX2Nsa3NfZW5hYmxlKG10ayk7DQorCWlmICghbXRrLT5rZWVwX2Nsa19vbikNCisJCXhoY2lf
bXRrX2Nsa3NfZW5hYmxlKG10ayk7DQogCXhoY2lfbXRrX2hvc3RfZW5hYmxlKG10ayk7DQogDQog
CXhoY2lfZGJnKHhoY2ksICIlczogcmVzdGFydCBwb3J0IHBvbGxpbmdcbiIsIF9fZnVuY19fKTsN
CmRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9ob3N0L3hoY2ktbXRrLmggYi9kcml2ZXJzL3VzYi9o
b3N0L3hoY2ktbXRrLmgNCmluZGV4IGE5M2NmZTguLjM3NjM5YzUgMTAwNjQ0DQotLS0gYS9kcml2
ZXJzL3VzYi9ob3N0L3hoY2ktbXRrLmgNCisrKyBiL2RyaXZlcnMvdXNiL2hvc3QveGhjaS1tdGsu
aA0KQEAgLTE1Miw2ICsxNTIsNyBAQCBzdHJ1Y3QgeGhjaV9oY2RfbXRrIHsNCiAJc3RydWN0IHJl
Z21hcCAqdXdrOw0KIAl1MzIgdXdrX3JlZ19iYXNlOw0KIAl1MzIgdXdrX3ZlcnM7DQorCWJvb2wg
a2VlcF9jbGtfb247DQogfTsNCiANCiBzdGF0aWMgaW5saW5lIHN0cnVjdCB4aGNpX2hjZF9tdGsg
KmhjZF90b19tdGsoc3RydWN0IHVzYl9oY2QgKmhjZCkNCi0tIA0KMS43LjkuNQ0K


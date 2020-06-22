Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF5BE202FDE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jun 2020 08:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbgFVGlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 02:41:05 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:20575 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726028AbgFVGlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 02:41:03 -0400
X-UUID: 7b05f865f66a42bbbfa730f64c52b37a-20200622
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=IFBpKCBLntnrD936dW2wE51Gs3HdrtGpolS+5RFA77U=;
        b=MxoTJmLj9/bXaN81qAccckbS37+vsEFRsYBD0ZS5xnMMJv1tlmBUsmo26p9CO3l/Vo0yZ+8xhO9grFA9lmTl31DkkyuaURQhs5S19NGTEn0FizyU25P56yxJcPKFou80VbTzkRt6BkejZMBRc04jwW05oFI1gcTsoEbf0hRYb5o=;
X-UUID: 7b05f865f66a42bbbfa730f64c52b37a-20200622
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <wen.su@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1335887036; Mon, 22 Jun 2020 14:40:57 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 22 Jun 2020 14:40:53 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 22 Jun 2020 14:40:53 +0800
From:   Wen Su <Wen.Su@mediatek.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <wsd_upstream@mediatek.com>, <wen.su@mediatek.com>
Subject: [RESEND v2 1/4] dt-bindings: regulator: Add document for MT6359 regulator
Date:   Mon, 22 Jun 2020 14:40:47 +0800
Message-ID: <1592808050-14260-2-git-send-email-Wen.Su@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1592808050-14260-1-git-send-email-Wen.Su@mediatek.com>
References: <1592808050-14260-1-git-send-email-Wen.Su@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: C923A1491BBD0153512F342C315C7C017D070D2A1FAD6CFF0ACB921A512E0B0C2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogIldlbiBTdSIgPHdlbi5zdUBtZWRpYXRlay5jb20+DQoNCmFkZCBkdC1iaW5kaW5nIGRv
Y3VtZW50IGZvciBNZWRpYVRlayBNVDYzNTkgUE1JQw0KDQpTaWduZWQtb2ZmLWJ5OiBXZW4gU3Ug
PHdlbi5zdUBtZWRpYXRlay5jb20+DQpSZXZpZXdlZC1ieTogUm9iIEhlcnJpbmcgPHJvYmhAa2Vy
bmVsLm9yZz4NCi0tLQ0KIC4uLi9iaW5kaW5ncy9yZWd1bGF0b3IvbXQ2MzU5LXJlZ3VsYXRvci50
eHQgICAgICAgIHwgNTggKysrKysrKysrKysrKysrKysrKysrKw0KIDEgZmlsZSBjaGFuZ2VkLCA1
OCBpbnNlcnRpb25zKCspDQogY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9yZWd1bGF0b3IvbXQ2MzU5LXJlZ3VsYXRvci50eHQNCg0KZGlmZiAtLWdp
dCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9yZWd1bGF0b3IvbXQ2MzU5LXJl
Z3VsYXRvci50eHQgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcmVndWxhdG9y
L210NjM1OS1yZWd1bGF0b3IudHh0DQpuZXcgZmlsZSBtb2RlIDEwMDY0NA0KaW5kZXggMDAwMDAw
MC4uYzg2YWFhOQ0KLS0tIC9kZXYvbnVsbA0KKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL3JlZ3VsYXRvci9tdDYzNTktcmVndWxhdG9yLnR4dA0KQEAgLTAsMCArMSw1OCBA
QA0KK01lZGlhdGVrIE1UNjM1OSBSZWd1bGF0b3INCisNCitSZXF1aXJlZCBwcm9wZXJ0aWVzOg0K
Ky0gY29tcGF0aWJsZTogIm1lZGlhdGVrLG10NjM1OS1yZWd1bGF0b3IiDQorLSBtdDYzNTlyZWd1
bGF0b3I6IExpc3Qgb2YgcmVndWxhdG9ycyBwcm92aWRlZCBieSB0aGlzIGNvbnRyb2xsZXIuIEl0
IGlzIG5hbWVkDQorICBhY2NvcmRpbmcgdG8gaXRzIHJlZ3VsYXRvciB0eXBlLCBidWNrXzxuYW1l
PiBhbmQgbGRvXzxuYW1lPi4NCisgIFRoZSBkZWZpbml0aW9uIGZvciBlYWNoIG9mIHRoZXNlIG5v
ZGVzIGlzIGRlZmluZWQgdXNpbmcgdGhlIHN0YW5kYXJkIGJpbmRpbmcNCisgIGZvciByZWd1bGF0
b3JzIGF0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9yZWd1bGF0b3IvcmVndWxh
dG9yLnR4dC4NCisNCitUaGUgdmFsaWQgbmFtZXMgZm9yIHJlZ3VsYXRvcnMgYXJlOg0KK0JVQ0s6
DQorICBidWNrX3ZzMSwgYnVja192Z3B1MTEsIGJ1Y2tfdm1vZGVtLCBidWNrX3ZwdSwgYnVja192
Y29yZSwgYnVja192czIsDQorICBidWNrX3ZwYSwgYnVja192cHJvYzIsIGJ1Y2tfdnByb2MxLCBi
dWNrX3Zjb3JlX3NzaHViDQorTERPOg0KKyAgbGRvX3ZhdWQxOCwgbGRvX3ZzaW0xLCBsZG9fdmli
ciwgbGRvX3ZyZjEyLCBsZG9fdnVzYiwgbGRvX3ZzcmFtX3Byb2MyLA0KKyAgbGRvX3ZpbzE4LCBs
ZG9fdmNhbWlvLCBsZG9fdmNuMTgsIGxkb192ZmUyOCwgbGRvX3ZjbjEzLCBsZG9fdmNuMzNfMV9i
dCwNCisgIGxkb192Y24xM18xX3dpZmksIGxkb192YXV4MTgsIGxkb192c3JhbV9vdGhlcnMsIGxk
b192ZWZ1c2UsIGxkb192eG8yMiwNCisgIGxkb192cmZjaywgbGRvX3ZiaWYyOCwgbGRvX3ZpbzI4
LCBsZG9fdmVtYywgbGRvX3ZjbjMzXzJfYnQsIGxkb192Y24zM18yX3dpZmksDQorICBsZG9fdmEx
MiwgbGRvX3ZhMDksIGxkb192cmYxOCwgbGRvX3ZzcmFtX21kLCBsZG9fdnVmcywgbGRvX3ZtMTgs
IGxkb192YmJjaywNCisgIGxkb192c3JhbV9wcm9jMSwgbGRvX3ZzaW0yLCBsZG9fdnNyYW1fb3Ro
ZXJzX3NzaHViDQorDQorRXhhbXBsZToNCisJcG1pYyB7DQorCQljb21wYXRpYmxlID0gIm1lZGlh
dGVrLG10NjM1OSI7DQorDQorCQltdDYzNTlyZWd1bGF0b3I6IG10NjM1OXJlZ3VsYXRvciB7DQor
CQkJY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDYzNTktcmVndWxhdG9yIjsNCisNCisJCQltdDYz
NTlfdnMxX2J1Y2tfcmVnOiBidWNrX3ZzMSB7DQorCQkJCXJlZ3VsYXRvci1uYW1lID0gInZzMSI7
DQorCQkJCXJlZ3VsYXRvci1taW4tbWljcm92b2x0ID0gPDgwMDAwMD47DQorCQkJCXJlZ3VsYXRv
ci1tYXgtbWljcm92b2x0ID0gPDIyMDAwMDA+Ow0KKwkJCQlyZWd1bGF0b3ItZW5hYmxlLXJhbXAt
ZGVsYXkgPSA8MD47DQorCQkJCXJlZ3VsYXRvci1hbHdheXMtb247DQorCQkJfTsNCisJCQltdDYz
NTlfdmdwdTExX2J1Y2tfcmVnOiBidWNrX3ZncHUxMSB7DQorCQkJCXJlZ3VsYXRvci1uYW1lID0g
InZncHUxMSI7DQorCQkJCXJlZ3VsYXRvci1taW4tbWljcm92b2x0ID0gPDQwMDAwMD47DQorCQkJ
CXJlZ3VsYXRvci1tYXgtbWljcm92b2x0ID0gPDExOTM3NTA+Ow0KKwkJCQlyZWd1bGF0b3ItZW5h
YmxlLXJhbXAtZGVsYXkgPSA8MjAwPjsNCisJCQkJcmVndWxhdG9yLWFsd2F5cy1vbjsNCisJCQkJ
cmVndWxhdG9yLWFsbG93ZWQtbW9kZXMgPSA8MCAxIDI+Ow0KKwkJCX07DQorCQkJbXQ2MzU5X3Zh
dWQxOF9sZG9fcmVnOiBsZG9fdmF1ZDE4IHsNCisJCQkJcmVndWxhdG9yLW5hbWUgPSAidmF1ZDE4
IjsNCisJCQkJcmVndWxhdG9yLW1pbi1taWNyb3ZvbHQgPSA8MTgwMDAwMD47DQorCQkJCXJlZ3Vs
YXRvci1tYXgtbWljcm92b2x0ID0gPDE4MDAwMDA+Ow0KKwkJCQlyZWd1bGF0b3ItZW5hYmxlLXJh
bXAtZGVsYXkgPSA8MjQwPjsNCisJCQl9Ow0KKwkJCW10NjM1OV92c2ltMV9sZG9fcmVnOiBsZG9f
dnNpbTEgew0KKwkJCQlyZWd1bGF0b3ItbmFtZSA9ICJ2c2ltMSI7DQorCQkJCXJlZ3VsYXRvci1t
aW4tbWljcm92b2x0ID0gPDE3MDAwMDA+Ow0KKwkJCQlyZWd1bGF0b3ItbWF4LW1pY3Jvdm9sdCA9
IDwzMTAwMDAwPjsNCisJCQkJcmVndWxhdG9yLWVuYWJsZS1yYW1wLWRlbGF5ID0gPDQ4MD47DQor
CQkJfTsNCisJCX07DQorCX07DQorDQotLSANCjEuOS4xDQo=


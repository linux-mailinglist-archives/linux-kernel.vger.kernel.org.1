Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8AD2A2510
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 08:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbgKBHTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 02:19:25 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:45793 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727306AbgKBHTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 02:19:25 -0500
X-UUID: 9a98dd67755a4dcfa854f04c12e4bed8-20201102
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=kZvapf7pIFQLgezOg35dcW/H2iGzgefNvWKVVQEly1I=;
        b=nsZLsvQcckE23itrZnczCPTFpmeugos0n+XlbNRGCnr7DHYdLD3AfHOQzhyI5Y5mMtcscT+eJobaDCvHpRca9pLu1EZfEFf6wk/t+AsDxNBJC8tlOsnkBKUe0DTeC1sn2DOkXg+F6hm8rvKGpNVsSBXr0mFM5AQXYheor0z646E=;
X-UUID: 9a98dd67755a4dcfa854f04c12e4bed8-20201102
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <macpaul.lin@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1505547485; Mon, 02 Nov 2020 15:19:01 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 2 Nov 2020 15:18:59 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 2 Nov 2020 15:18:59 +0800
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
Subject: [PATCH 1/2] dt-bindings: usb: mediatek,mtk-xhci: add keep-clock-on
Date:   Mon, 2 Nov 2020 15:18:48 +0800
Message-ID: <1604301530-31546-1-git-send-email-macpaul.lin@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T3B0aW9uICJtZWRpYXRlayxrZWVwLWNsb2NrLW9uIiBtZWFucyB0byBrZWVwIGNsb2NrIG9uIGR1
cmluZyBzeXN0ZW0NCnN1c3BlbmQgYW5kIHJlc3VtZS4gU29tZSBwbGF0Zm9ybSB3aWxsIGZsdXNo
IHJlZ2lzdGVyIHNldHRpbmdzIGlmIGNsb2NrIGhhcw0KYmVlbiBkaXNhYmxlZCB3aGVuIHN5c3Rl
bSBpcyBzdXNwZW5kZWQuIFNldCB0aGlzIG9wdGlvbiB0byBhdm9pZCBjbG9jayBvZmYuDQoNClNp
Z25lZC1vZmYtYnk6IE1hY3BhdWwgTGluIDxtYWNwYXVsLmxpbkBtZWRpYXRlay5jb20+DQotLS0N
CiAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy91c2IvbWVkaWF0ZWssbXRrLXhoY2kueWFtbCB8ICAg
IDcgKysrKysrKw0KIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdp
dCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy91c2IvbWVkaWF0ZWssbXRrLXho
Y2kueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy91c2IvbWVkaWF0ZWss
bXRrLXhoY2kueWFtbA0KaW5kZXggZWE2OTZjOC4uYTk1NmRkZSAxMDA2NDQNCi0tLSBhL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy91c2IvbWVkaWF0ZWssbXRrLXhoY2kueWFtbA0K
KysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3VzYi9tZWRpYXRlayxtdGst
eGhjaS55YW1sDQpAQCAtMTA0LDYgKzEwNCwxMiBAQCBwcm9wZXJ0aWVzOg0KICAgICBkZXNjcmlw
dGlvbjogZW5hYmxlIFVTQiByZW1vdGUgd2FrZXVwLCBzZWUgcG93ZXIvd2FrZXVwLXNvdXJjZS50
eHQNCiAgICAgdHlwZTogYm9vbGVhbg0KIA0KKyAgbWVkaWF0ZWssa2VlcC1jbG9jay1vbjoNCisg
ICAgZGVzY3JpcHRpb246IHwNCisgICAgICBLZWVwIGNsb2NrIG9uIGR1cmluZyBzeXN0ZW0gc3Vz
cGVuZCBhbmQgcmVzdW1lLiBTb21lIHBsYXRmb3JtIHdpbGwgZmx1c2gNCisgICAgICByZWdpc3Rl
ciBzZXR0aW5ncyBpZiBjbG9jayBoYXMgYmVlbiBkaXNhYmxlZCB3aGVuIHN5c3RlbSBpcyBzdXNw
ZW5kZWQuDQorICAgIHR5cGU6IGJvb2xlYW4NCisNCiAgIG1lZGlhdGVrLHN5c2Nvbi13YWtldXA6
DQogICAgICRyZWY6IC9zY2hlbWFzL3R5cGVzLnlhbWwjL2RlZmluaXRpb25zL3BoYW5kbGUtYXJy
YXkNCiAgICAgbWF4SXRlbXM6IDENCkBAIC0xNzUsNiArMTgxLDcgQEAgZXhhbXBsZXM6DQogICAg
ICAgICBpbW9kLWludGVydmFsLW5zID0gPDEwMDAwPjsNCiAgICAgICAgIG1lZGlhdGVrLHN5c2Nv
bi13YWtldXAgPSA8JnBlcmljZmcgMHg0MDAgMT47DQogICAgICAgICB3YWtldXAtc291cmNlOw0K
KyAgICAgICAgbWVkaWF0ZWssa2VlcC1jbG9jay1vbjsNCiAgICAgICAgIHVzYjMtbHBtLWNhcGFi
bGU7DQogICAgIH07DQogLi4uDQotLSANCjEuNy45LjUNCg==


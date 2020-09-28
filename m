Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D658827A7BC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 08:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbgI1GkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 02:40:04 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:54687 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725290AbgI1GkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 02:40:03 -0400
X-UUID: e6c616e87d7f4171aa3467c6e9969704-20200928
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=+HdmJUlYIhIyB79Xpt5EornlfjSODCsjG1SM502RXk8=;
        b=g0OwGmWS+eD/xl3H2/+7A1y7nJJ0avrhHq1MB41kw8rfrb/J1JADPWeT7nl2NnnZVztVLtVpTClMc89BcjbtORY/S+eL4Jqhky2F5DHFYMIMXac4cJc9jTDn8t9ZL4HeMBjMQ+Ywt/oJpC0nf1RsgBOszK1GznEKawY5fOFd+/k=;
X-UUID: e6c616e87d7f4171aa3467c6e9969704-20200928
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1958731539; Mon, 28 Sep 2020 14:39:57 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 28 Sep 2020 14:39:51 +0800
Received: from mtkslt301.mediatek.inc (10.21.14.114) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 28 Sep 2020 14:39:51 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>
Subject: [PATCH] dt-bindings: usb: add properties for hard wired devices
Date:   Mon, 28 Sep 2020 14:39:50 +0800
Message-ID: <20200928063950.64722-1-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: C715C36883DF571B2943D3C2BC8449FA8642EE6F54243D31B2C87CA6628503F52000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIHNvbWUgb3B0aW9uYWwgcHJvcGVydGllcyB3aGljaCBhcmUgbmVlZGVkIGZvciBoYXJkIHdp
cmVkIGRldmljZXMNCg0KU2lnbmVkLW9mZi1ieTogQ2h1bmZlbmcgWXVuIDxjaHVuZmVuZy55dW5A
bWVkaWF0ZWsuY29tPg0KLS0tDQogRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Vz
Yi91c2ItaGNkLnlhbWwgfCAxMSArKysrKysrKysrKw0KIDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNl
cnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvdXNiL3VzYi1oY2QueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy91
c2IvdXNiLWhjZC55YW1sDQppbmRleCA3MjYzYjdmMmI1MTAuLjExOTRhODI4ODdlNyAxMDA2NDQN
Ci0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy91c2IvdXNiLWhjZC55YW1s
DQorKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdXNiL3VzYi1oY2QueWFt
bA0KQEAgLTIyLDYgKzIyLDE3IEBAIHByb3BlcnRpZXM6DQogICAgIGRlc2NyaXB0aW9uOg0KICAg
ICAgIE5hbWUgc3BlY2lmaWVyIGZvciB0aGUgVVNCIFBIWQ0KIA0KKyAgIiNhZGRyZXNzLWNlbGxz
IjoNCisgICAgY29uc3Q6IDENCisNCisgICIjc2l6ZS1jZWxscyI6DQorICAgIGNvbnN0OiAwDQor
DQorcGF0dGVyblByb3BlcnRpZXM6DQorICAiXmh1YnxkZXZpY2VAWzAtOWEtZl0rJCI6DQorICAg
IHR5cGU6IG9iamVjdA0KKyAgICBkZXNjcmlwdGlvbjogVGhlIGhhcmQgd2lyZWQgVVNCIGRldmlj
ZXMuIFNlZSB1c2IvdXNiLWRldmljZS50eHQNCisNCiBleGFtcGxlczoNCiAgIC0gfA0KICAgICB1
c2Igew0KLS0gDQoyLjE4LjANCg==


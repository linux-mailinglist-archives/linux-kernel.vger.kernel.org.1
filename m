Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0E812DBFD1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 12:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbgLPLwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 06:52:19 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:56129 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725985AbgLPLwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 06:52:19 -0500
X-UUID: 4e746c931437497693fca4c02774c325-20201216
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=glQsJ1J/DfuWCVTzMFf5Jfmjvr26uWbwpbrnKCDy90g=;
        b=nx98TZeH21zS5KD8tj675zKw/Y38oGmoby1HihkSR4JvKc4gziwwf1KxZMyQ7ZNUwusawbEzwWxl9kMbr8I9oURWUA5l7mgbVviZzK5xAbR+y4yTPYunVhMnMZ0pvv1uMGF2XBwYepfUCaiT0gJyqrFSI/NqP9ymL3rZQbcOvoM=;
X-UUID: 4e746c931437497693fca4c02774c325-20201216
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 323521070; Wed, 16 Dec 2020 19:51:28 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS31DR.mediatek.inc (172.27.6.102) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 16 Dec 2020 19:51:26 +0800
Received: from mtkslt301.mediatek.inc (10.21.14.114) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 16 Dec 2020 19:51:26 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>
CC:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Hsin-Yi Wang <hsinyi@chromium.org>,
        Ikjoon Jang <ikjn@chromium.org>
Subject: [PATCH 3/3] arm64: dts: mt8173: add a broken streams quirk property for xHCI node
Date:   Wed, 16 Dec 2020 19:51:25 +0800
Message-ID: <20201216115125.5886-3-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201216115125.5886-1-chunfeng.yun@mediatek.com>
References: <20201216115125.5886-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 43BBB7292D25986C7F85AC6189081C2D98985D0773E9EA9D6DC7BBD3F6AD08012000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RHVlIHRvIDAuOTYgeEhDSSBvbiBtdDgxNzMgZG9lc24ndCBzdXBwb3J0IGJ1bGsgc3RyZWFtIGJ1
dCBNYXhQU0FTaXplDQpzYXlzIHN1cHBvcnRpbmcsIGFkZCBhIG5ldyAibWVkaWF0ZWssYnJva2Vu
X3N0cmVhbXNfcXVpcmsiIHByb3BlcnR5IHRvDQpmaXggaXQuDQoNCkZpeGVzOiA5NGE2MzFkOTFh
ZDMgKCJ1c2I6IHhoY2ktbXRrOiBjaGVjayBoY2NfcGFyYW1zIGFmdGVyIGFkZGluZyBwcmltYXJ5
IGhjZCIpDQpTaWduZWQtb2ZmLWJ5OiBDaHVuZmVuZyBZdW4gPGNodW5mZW5nLnl1bkBtZWRpYXRl
ay5jb20+DQotLS0NCiBhcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210ODE3My5kdHNpIHwg
MSArDQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQoNCmRpZmYgLS1naXQgYS9hcmNo
L2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210ODE3My5kdHNpIGIvYXJjaC9hcm02NC9ib290L2R0
cy9tZWRpYXRlay9tdDgxNzMuZHRzaQ0KaW5kZXggZTg4YmJmYzFmYzU1Li5mMzA1ZmIwMzMwMjAg
MTAwNjQ0DQotLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210ODE3My5kdHNpDQor
KysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210ODE3My5kdHNpDQpAQCAtODg2LDYg
Kzg4Niw3IEBADQogCQkJCXBvd2VyLWRvbWFpbnMgPSA8JnNjcHN5cyBNVDgxNzNfUE9XRVJfRE9N
QUlOX1VTQj47DQogCQkJCWNsb2NrcyA9IDwmdG9wY2tnZW4gQ0xLX1RPUF9VU0IzMF9TRUw+LCA8
JmNsazI2bT47DQogCQkJCWNsb2NrLW5hbWVzID0gInN5c19jayIsICJyZWZfY2siOw0KKwkJCQlt
ZWRpYXRlayxicm9rZW5fc3RyZWFtc19xdWlyazsNCiAJCQkJc3RhdHVzID0gImRpc2FibGVkIjsN
CiAJCQl9Ow0KIAkJfTsNCi0tIA0KMi4xOC4wDQo=


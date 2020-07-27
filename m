Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 294CE22E64E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jul 2020 09:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbgG0HQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jul 2020 03:16:43 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:58453 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726984AbgG0HQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 03:16:39 -0400
X-UUID: 2ae9090ed0a3469da6d4ba3b16a6eba3-20200727
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=cT1WlsLUGadWMwBtxpHqluQ3CTv7OXKHJE51u/qqiR0=;
        b=ffJU8tt9gjO5ysNhJR0D0NOamzGGw6B6TJwIqkrtKGdKUQxeJ9Cp0ASmNcP8mHNpvzvLY9MUdeKj6bed/u2Ad4Q6xCQZD7zgDQBSHtKXnZC0GMKh9yT6E3FhppTdNcLg1hUiG84QtMtl5kNoya4uKJF8YPNXWaWAsvY9djN/9c4=;
X-UUID: 2ae9090ed0a3469da6d4ba3b16a6eba3-20200727
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1233878552; Mon, 27 Jul 2020 15:16:36 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 27 Jul 2020 15:16:32 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 27 Jul 2020 15:16:32 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Eddie Hung <eddie.hung@mediatek.com>
Subject: [PATCH 02/11] usb: mtu3: fix macro for maximum number of packets
Date:   Mon, 27 Jul 2020 15:14:51 +0800
Message-ID: <1595834101-13094-2-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1595834101-13094-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1595834101-13094-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: BFE475CE3B7308DA5BFF6C69C0D03ED50AC43C3E69D2EFCF840EA10C6840A9D72000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIGJpdHMgZmllbGQgZm9yIG1heGltdW0gbnVtYmVyIG9mIHBhY2tldHMgaXMgOCBiaXRzLg0K
DQpTaWduZWQtb2ZmLWJ5OiBDaHVuZmVuZyBZdW4gPGNodW5mZW5nLnl1bkBtZWRpYXRlay5jb20+
DQotLS0NCiBkcml2ZXJzL3VzYi9tdHUzL210dTNfaHdfcmVncy5oIHwgNCArKy0tDQogMSBmaWxl
IGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBh
L2RyaXZlcnMvdXNiL210dTMvbXR1M19od19yZWdzLmggYi9kcml2ZXJzL3VzYi9tdHUzL210dTNf
aHdfcmVncy5oDQppbmRleCBiZjM0Zjc4Li4wNzJkYjFmIDEwMDY0NA0KLS0tIGEvZHJpdmVycy91
c2IvbXR1My9tdHUzX2h3X3JlZ3MuaA0KKysrIGIvZHJpdmVycy91c2IvbXR1My9tdHUzX2h3X3Jl
Z3MuaA0KQEAgLTEzNCw3ICsxMzQsNyBAQA0KICNkZWZpbmUgVFhfVzFDX0JJVFMJCSh+KFRYX1NF
TlRTVEFMTCkpDQogDQogLyogVTNEX1RYMUNTUjEgKi8NCi0jZGVmaW5lIFRYX01BWF9QS1RfRzIo
eCkJKCgoeCkgJiAweDdmKSA8PCAyNCkNCisjZGVmaW5lIFRYX01BWF9QS1RfRzIoeCkJKCgoeCkg
JiAweGZmKSA8PCAyNCkNCiAjZGVmaW5lIFRYX01VTFRfRzIoeCkJCSgoKHgpICYgMHg3KSA8PCAy
MSkNCiAjZGVmaW5lIFRYX01VTFRfT0coeCkJCSgoKHgpICYgMHgzKSA8PCAyMikNCiAjZGVmaW5l
IFRYX01BWF9QS1RfT0coeCkJKCgoeCkgJiAweDNmKSA8PCAxNikNCkBAIC0xNzMsNyArMTczLDcg
QEANCiAjZGVmaW5lIFJYX1cxQ19CSVRTCQkofihSWF9TRU5UU1RBTEwgfCBSWF9SWFBLVFJEWSkp
DQogDQogLyogVTNEX1JYMUNTUjEgKi8NCi0jZGVmaW5lIFJYX01BWF9QS1RfRzIoeCkJKCgoeCkg
JiAweDdmKSA8PCAyNCkNCisjZGVmaW5lIFJYX01BWF9QS1RfRzIoeCkJKCgoeCkgJiAweGZmKSA8
PCAyNCkNCiAjZGVmaW5lIFJYX01VTFRfRzIoeCkJCSgoKHgpICYgMHg3KSA8PCAyMSkNCiAjZGVm
aW5lIFJYX01VTFRfT0coeCkJCSgoKHgpICYgMHgzKSA8PCAyMikNCiAjZGVmaW5lIFJYX01BWF9Q
S1RfT0coeCkJKCgoeCkgJiAweDNmKSA8PCAxNikNCi0tIA0KMS45LjENCg==


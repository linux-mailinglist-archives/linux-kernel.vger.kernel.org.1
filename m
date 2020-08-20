Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB73E24AEA8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Aug 2020 07:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbgHTFsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Aug 2020 01:48:10 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:37714 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726810AbgHTFrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 01:47:24 -0400
X-UUID: a6354b40d46941248bbc8c7252e3f256-20200820
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=rqOmr4s38lrwJ2dnPE2OC2HigLSqUSzxMmOy71PUjB0=;
        b=IRrqR/c7F1Ev6atsY2YyMKxIIOVo/HvFoUv2ngegoeNdIftfiysgNv4bJlFTQwLQnoL00ciqQI5k328APP/fqmFEOOObRF0NsMCGgP0SJ2wqs9hfp/BUeOCCApqD06LMx/XkmriV869Uh0/K3Pv4TnFopb8gux8ESa254MD80UI=;
X-UUID: a6354b40d46941248bbc8c7252e3f256-20200820
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 143234982; Thu, 20 Aug 2020 13:47:17 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 20 Aug 2020 13:47:16 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 20 Aug 2020 13:47:14 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Felipe Balbi <balbi@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v2 07/11] usb: isp1760-hcd: convert to readl_poll_timeout_atomic()
Date:   Thu, 20 Aug 2020 13:45:45 +0800
Message-ID: <1597902349-8998-7-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1597902349-8998-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1597902349-8998-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 85ABC731EDF3EF1F9BCD8FAEAA27DDA5881E5D28068DA5B9B742E90875CA65AA2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VXNlIHJlYWRsX3BvbGxfdGltZW91dF9hdG9taWMoKSB0byBzaW1wbGlmeSBjb2RlDQoNClNpZ25l
ZC1vZmYtYnk6IENodW5mZW5nIFl1biA8Y2h1bmZlbmcueXVuQG1lZGlhdGVrLmNvbT4NCi0tLQ0K
djI6IG5vIGNoYW5nZXMNCi0tLQ0KIGRyaXZlcnMvdXNiL2lzcDE3NjAvaXNwMTc2MC1oY2QuYyB8
IDIwICsrKysrKysrKy0tLS0tLS0tLS0tDQogMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygr
KSwgMTEgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9pc3AxNzYwL2lz
cDE3NjAtaGNkLmMgYi9kcml2ZXJzL3VzYi9pc3AxNzYwL2lzcDE3NjAtaGNkLmMNCmluZGV4IGRk
NzRhYjdhLi4zM2FlNjU2IDEwMDY0NA0KLS0tIGEvZHJpdmVycy91c2IvaXNwMTc2MC9pc3AxNzYw
LWhjZC5jDQorKysgYi9kcml2ZXJzL3VzYi9pc3AxNzYwL2lzcDE3NjAtaGNkLmMNCkBAIC0yMiw2
ICsyMiw3IEBADQogI2luY2x1ZGUgPGxpbnV4L2RlYnVnZnMuaD4NCiAjaW5jbHVkZSA8bGludXgv
dWFjY2Vzcy5oPg0KICNpbmNsdWRlIDxsaW51eC9pby5oPg0KKyNpbmNsdWRlIDxsaW51eC9pb3Bv
bGwuaD4NCiAjaW5jbHVkZSA8bGludXgvbW0uaD4NCiAjaW5jbHVkZSA8bGludXgvdGltZXIuaD4N
CiAjaW5jbHVkZSA8YXNtL3VuYWxpZ25lZC5oPg0KQEAgLTM4MCwxOCArMzgxLDE1IEBAIHN0YXRp
YyBpbnQgaGFuZHNoYWtlKHN0cnVjdCB1c2JfaGNkICpoY2QsIHUzMiByZWcsDQogCQkgICAgICB1
MzIgbWFzaywgdTMyIGRvbmUsIGludCB1c2VjKQ0KIHsNCiAJdTMyIHJlc3VsdDsNCisJaW50IHJl
dDsNCisNCisJcmV0ID0gcmVhZGxfcG9sbF90aW1lb3V0X2F0b21pYyhoY2QtPnJlZ3MgKyByZWcs
IHJlc3VsdCwNCisJCQkJCSgocmVzdWx0ICYgbWFzaykgPT0gZG9uZSB8fA0KKwkJCQkJIHJlc3Vs
dCA9PSBVMzJfTUFYKSwgMSwgdXNlYyk7DQorCWlmIChyZXN1bHQgPT0gVTMyX01BWCkNCisJCXJl
dHVybiAtRU5PREVWOw0KIA0KLQlkbyB7DQotCQlyZXN1bHQgPSByZWdfcmVhZDMyKGhjZC0+cmVn
cywgcmVnKTsNCi0JCWlmIChyZXN1bHQgPT0gfjApDQotCQkJcmV0dXJuIC1FTk9ERVY7DQotCQly
ZXN1bHQgJj0gbWFzazsNCi0JCWlmIChyZXN1bHQgPT0gZG9uZSkNCi0JCQlyZXR1cm4gMDsNCi0J
CXVkZWxheSgxKTsNCi0JCXVzZWMtLTsNCi0JfSB3aGlsZSAodXNlYyA+IDApOw0KLQlyZXR1cm4g
LUVUSU1FRE9VVDsNCisJcmV0dXJuIHJldDsNCiB9DQogDQogLyogcmVzZXQgYSBub24tcnVubmlu
ZyAoU1RTX0hBTFQgPT0gMSkgY29udHJvbGxlciAqLw0KLS0gDQoxLjkuMQ0K


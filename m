Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1B9624E647
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Aug 2020 10:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbgHVIJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Aug 2020 04:09:26 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:23490 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725877AbgHVIJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 04:09:20 -0400
X-UUID: 0700fcd758a1451bab937a628dfa4d54-20200822
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=glUu4ILa56NmCzEya+FLhC/5JYoRtBGd30upHM8qMX0=;
        b=AujKItQ0PtargzNMc5jD/YMWIhajEGDAnWAnb95Fy4XT6NIqYQr4xfI2EchdnWcXI7iJemaN5I3rTpDxqfbSP5qf6GPNsMWLWALuvKy/LyqLqbOM4+GWHEBxUVi1N3bbl1FNs8pY8sjIIekV1F81LhH7p/h4JznQmwh2xZPm0PY=;
X-UUID: 0700fcd758a1451bab937a628dfa4d54-20200822
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 396831244; Sat, 22 Aug 2020 16:09:13 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 MTKMBS31DR.mediatek.inc (172.27.6.102) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 22 Aug 2020 16:09:12 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 22 Aug 2020 16:09:10 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Felipe Balbi <balbi@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: [PATCH v3 05/11] usb: oxu210hp-hcd: convert to readl_poll_timeout_atomic()
Date:   Sat, 22 Aug 2020 16:05:47 +0800
Message-ID: <1598083553-31896-5-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1598083553-31896-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1598083553-31896-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 90167F4D4D50A24168BBC3B4AC9B44B4F7352DDF6393F3281A30FA7401C0BCE52000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VXNlIHJlYWRsX3BvbGxfdGltZW91dF9hdG9taWMoKSB0byBzaW1wbGlmeSBjb2RlDQoNClNpZ25l
ZC1vZmYtYnk6IENodW5mZW5nIFl1biA8Y2h1bmZlbmcueXVuQG1lZGlhdGVrLmNvbT4NCi0tLQ0K
djJ+djM6IG5vIGNoYW5nZXMNCi0tLQ0KIGRyaXZlcnMvdXNiL2hvc3Qvb3h1MjEwaHAtaGNkLmMg
fCAyMSArKysrKysrKysrLS0tLS0tLS0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9u
cygrKSwgMTEgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9ob3N0L294
dTIxMGhwLWhjZC5jIGIvZHJpdmVycy91c2IvaG9zdC9veHUyMTBocC1oY2QuYw0KaW5kZXggY2Zh
N2RkMi4uMjdkYmJlMSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvdXNiL2hvc3Qvb3h1MjEwaHAtaGNk
LmMNCisrKyBiL2RyaXZlcnMvdXNiL2hvc3Qvb3h1MjEwaHAtaGNkLmMNCkBAIC0yNCw2ICsyNCw3
IEBADQogI2luY2x1ZGUgPGxpbnV4L21vZHVsZXBhcmFtLmg+DQogI2luY2x1ZGUgPGxpbnV4L2Rt
YS1tYXBwaW5nLmg+DQogI2luY2x1ZGUgPGxpbnV4L2lvLmg+DQorI2luY2x1ZGUgPGxpbnV4L2lv
cG9sbC5oPg0KIA0KICNpbmNsdWRlIDxhc20vaXJxLmg+DQogI2luY2x1ZGUgPGFzbS91bmFsaWdu
ZWQuaD4NCkBAIC03NDgsMTggKzc0OSwxNiBAQCBzdGF0aWMgaW50IGhhbmRzaGFrZShzdHJ1Y3Qg
b3h1X2hjZCAqb3h1LCB2b2lkIF9faW9tZW0gKnB0ciwNCiAJCQkJCXUzMiBtYXNrLCB1MzIgZG9u
ZSwgaW50IHVzZWMpDQogew0KIAl1MzIgcmVzdWx0Ow0KKwlpbnQgcmV0Ow0KIA0KLQlkbyB7DQot
CQlyZXN1bHQgPSByZWFkbChwdHIpOw0KLQkJaWYgKHJlc3VsdCA9PSB+KHUzMikwKQkJLyogY2Fy
ZCByZW1vdmVkICovDQotCQkJcmV0dXJuIC1FTk9ERVY7DQotCQlyZXN1bHQgJj0gbWFzazsNCi0J
CWlmIChyZXN1bHQgPT0gZG9uZSkNCi0JCQlyZXR1cm4gMDsNCi0JCXVkZWxheSgxKTsNCi0JCXVz
ZWMtLTsNCi0JfSB3aGlsZSAodXNlYyA+IDApOw0KLQlyZXR1cm4gLUVUSU1FRE9VVDsNCisJcmV0
ID0gcmVhZGxfcG9sbF90aW1lb3V0X2F0b21pYyhwdHIsIHJlc3VsdCwNCisJCQkJCSgocmVzdWx0
ICYgbWFzaykgPT0gZG9uZSB8fA0KKwkJCQkJIHJlc3VsdCA9PSBVMzJfTUFYKSwNCisJCQkJCTEs
IHVzZWMpOw0KKwlpZiAocmVzdWx0ID09IFUzMl9NQVgpCQkvKiBjYXJkIHJlbW92ZWQgKi8NCisJ
CXJldHVybiAtRU5PREVWOw0KKw0KKwlyZXR1cm4gcmV0Ow0KIH0NCiANCiAvKiBGb3JjZSBIQyB0
byBoYWx0IHN0YXRlIGZyb20gdW5rbm93biAoRUhDSSBzcGVjIHNlY3Rpb24gMi4zKSAqLw0KLS0g
DQoxLjkuMQ0K


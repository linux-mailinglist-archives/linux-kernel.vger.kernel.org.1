Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2855826400C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Sep 2020 10:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729913AbgIJIdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Sep 2020 04:33:33 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:22870 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730381AbgIJIYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 04:24:34 -0400
X-UUID: 83d501ad5656476d869246c8f3a0fce2-20200910
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=glUu4ILa56NmCzEya+FLhC/5JYoRtBGd30upHM8qMX0=;
        b=kNTHCv3bsP1phVyVcMnw2YdaoXCHZqhRcfa9vrGnKg8IHatDrzKu+eqZuZL2iTvAwUQ+WaCowX71PJmp1XZQ3W1UJZ2MOUaXZ+sYw3NHV2u1r/Q/KrCfAnNSTiAu1e5l3Ra50mtnxTGWRaXEZWpdkm3lTbgyZRKYZF6xMIs+zAw=;
X-UUID: 83d501ad5656476d869246c8f3a0fce2-20200910
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 244888743; Thu, 10 Sep 2020 16:24:06 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS31DR.mediatek.inc (172.27.6.102) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 10 Sep 2020 16:24:05 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 10 Sep 2020 16:24:04 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Mathias Nyman <mathias.nyman@intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Jann Horn <jannh@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Jason Yan <yanaijie@huawei.com>,
        Chuhong Yuan <hslester96@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        Saurav Girepunje <saurav.girepunje@gmail.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH RESEND v3 05/11] usb: oxu210hp-hcd: convert to readl_poll_timeout_atomic()
Date:   Thu, 10 Sep 2020 16:21:46 +0800
Message-ID: <1599726112-4439-5-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1599726112-4439-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1599726112-4439-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: C5A2AC489B45A0F990228762FA8A7204B6D8C1A944092FAC6D1DCAFFC99CC7D52000:8
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


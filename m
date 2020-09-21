Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 190D2271AB7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 08:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbgIUGRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 02:17:12 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:42163 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726149AbgIUGRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 02:17:08 -0400
X-UUID: 8a75d16a3c1f4e118f9597f83e281977-20200921
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=iytLVyfwsqCD1g9UEuz02b2x3mx6gFmM96o8N8uXFCw=;
        b=nkPEa13Kx7DLe7rhGyBwYIL4BvhJ7xl68aY7+tcn/gPXaennJShaOnIOaikNLTrQSPieYcyyNEueRQsXicJ4bygdh1UE7WWag/tQyC+ARbfnUKe/IBSnYKnB/gmnDtBD2dJdLNpyBCyELFt3Opstqh41ZvPDaqldsrQwbXSmrog=;
X-UUID: 8a75d16a3c1f4e118f9597f83e281977-20200921
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2038064824; Mon, 21 Sep 2020 14:17:04 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 21 Sep 2020 14:17:04 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 21 Sep 2020 14:17:01 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>
CC:     Mathias Nyman <mathias.nyman@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Lee Jones <lee.jones@linaro.org>, Jann Horn <jannh@google.com>,
        Jason Yan <yanaijie@huawei.com>, Arnd Bergmann <arnd@arndb.de>,
        Chuhong Yuan <hslester96@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>,
        Saurav Girepunje <saurav.girepunje@gmail.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Subject: [PATCH v4 05/11] usb: oxu210hp-hcd: convert to readl_poll_timeout_atomic()
Date:   Mon, 21 Sep 2020 14:13:29 +0800
Message-ID: <1600668815-12135-5-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1600668815-12135-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1600668815-12135-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 980D8799D31CC841754718C45ED7A1AE8DFE241777DE81837D9B0AEB06BE52E02000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VXNlIHJlYWRsX3BvbGxfdGltZW91dF9hdG9taWMoKSB0byBzaW1wbGlmeSBjb2RlDQoNClNpZ25l
ZC1vZmYtYnk6IENodW5mZW5nIFl1biA8Y2h1bmZlbmcueXVuQG1lZGlhdGVrLmNvbT4NCi0tLQ0K
djJ+djQ6IG5vIGNoYW5nZXMNCi0tLQ0KIGRyaXZlcnMvdXNiL2hvc3Qvb3h1MjEwaHAtaGNkLmMg
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


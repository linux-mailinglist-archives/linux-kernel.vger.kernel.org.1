Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1664271ABD
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 08:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbgIUGRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 02:17:30 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:36361 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726415AbgIUGRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 02:17:18 -0400
X-UUID: c41bba5b92564aa6b15e6e98606b2327-20200921
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=oHk1JU2NeVe2tWWWIBxMvDXUuKUJJvTa4oJY401uQng=;
        b=kr3A7pHiT2VOl6Or4lFA26n1fJwuqNl7m5qs2BO/+L5WPM/YryCsUL31ahINuzxYGSRzMr0yt9KmeVGehCxus1dt+Q+wEXM4DTNZEYZCiNY+xqsz1qec0ZUnlpQyq7891IdlDW41hO02I4hbKKMqKaoIR26WQoqzcryrwZOwvnc=;
X-UUID: c41bba5b92564aa6b15e6e98606b2327-20200921
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1094818918; Mon, 21 Sep 2020 14:17:13 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 21 Sep 2020 14:17:13 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 21 Sep 2020 14:17:10 +0800
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
        Daniel Thompson <daniel.thompson@linaro.org>,
        Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH v4 10/11] usb: udc: net2280: convert to readl_poll_timeout_atomic()
Date:   Mon, 21 Sep 2020 14:13:34 +0800
Message-ID: <1600668815-12135-10-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1600668815-12135-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1600668815-12135-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: F315BAB8ED3B30B9B6DF2791A863E3E70DFCD786BE5E8679004EC738121DABED2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VXNlIHJlYWRsX3BvbGxfdGltZW91dF9hdG9taWMoKSB0byBzaW1wbGlmeSBjb2RlDQoNCkNjOiBB
bGFuIFN0ZXJuIDxzdGVybkByb3dsYW5kLmhhcnZhcmQuZWR1Pg0KQ2M6IEZlbGlwZSBCYWxiaSA8
YmFsYmlAa2VybmVsLm9yZz4NClNpZ25lZC1vZmYtYnk6IENodW5mZW5nIFl1biA8Y2h1bmZlbmcu
eXVuQG1lZGlhdGVrLmNvbT4NCkFja2VkLWJ5OiBBbGFuIFN0ZXJuIDxzdGVybkByb3dsYW5kLmhh
cnZhcmQuZWR1Pg0KLS0tDQp2M352NDogbm8gY2hhbmdlcw0KDQp2MjogYWRkIEFja2VkLWJ5IEFs
YW4NCi0tLQ0KIGRyaXZlcnMvdXNiL2dhZGdldC91ZGMvbmV0MjI4MC5jIHwgMjEgKysrKysrKysr
Ky0tLS0tLS0tLS0tDQogMSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDExIGRlbGV0
aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9uZXQyMjgwLmMg
Yi9kcml2ZXJzL3VzYi9nYWRnZXQvdWRjL25ldDIyODAuYw0KaW5kZXggNzUzMGJkOS4uZjFhMjFm
NCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvdXNiL2dhZGdldC91ZGMvbmV0MjI4MC5jDQorKysgYi9k
cml2ZXJzL3VzYi9nYWRnZXQvdWRjL25ldDIyODAuYw0KQEAgLTUyLDYgKzUyLDcgQEANCiAjaW5j
bHVkZSA8bGludXgvdXNiL2dhZGdldC5oPg0KICNpbmNsdWRlIDxsaW51eC9wcmVmZXRjaC5oPg0K
ICNpbmNsdWRlIDxsaW51eC9pby5oPg0KKyNpbmNsdWRlIDxsaW51eC9pb3BvbGwuaD4NCiANCiAj
aW5jbHVkZSA8YXNtL2J5dGVvcmRlci5oPg0KICNpbmNsdWRlIDxhc20vaXJxLmg+DQpAQCAtMzYw
LDE4ICszNjEsMTYgQEAgc3RhdGljIGlubGluZSB2b2lkIGVuYWJsZV9wY2lpcnFlbmIoc3RydWN0
IG5ldDIyODBfZXAgKmVwKQ0KIHN0YXRpYyBpbnQgaGFuZHNoYWtlKHUzMiBfX2lvbWVtICpwdHIs
IHUzMiBtYXNrLCB1MzIgZG9uZSwgaW50IHVzZWMpDQogew0KIAl1MzIJcmVzdWx0Ow0KKwlpbnQJ
cmV0Ow0KIA0KLQlkbyB7DQotCQlyZXN1bHQgPSByZWFkbChwdHIpOw0KLQkJaWYgKHJlc3VsdCA9
PSB+KHUzMikwKQkJLyogImRldmljZSB1bnBsdWdnZWQiICovDQotCQkJcmV0dXJuIC1FTk9ERVY7
DQotCQlyZXN1bHQgJj0gbWFzazsNCi0JCWlmIChyZXN1bHQgPT0gZG9uZSkNCi0JCQlyZXR1cm4g
MDsNCi0JCXVkZWxheSgxKTsNCi0JCXVzZWMtLTsNCi0JfSB3aGlsZSAodXNlYyA+IDApOw0KLQly
ZXR1cm4gLUVUSU1FRE9VVDsNCisJcmV0ID0gcmVhZGxfcG9sbF90aW1lb3V0X2F0b21pYyhwdHIs
IHJlc3VsdCwNCisJCQkJCSgocmVzdWx0ICYgbWFzaykgPT0gZG9uZSB8fA0KKwkJCQkJIHJlc3Vs
dCA9PSBVMzJfTUFYKSwNCisJCQkJCTEsIHVzZWMpOw0KKwlpZiAocmVzdWx0ID09IFUzMl9NQVgp
CQkvKiBkZXZpY2UgdW5wbHVnZ2VkICovDQorCQlyZXR1cm4gLUVOT0RFVjsNCisNCisJcmV0dXJu
IHJldDsNCiB9DQogDQogc3RhdGljIGNvbnN0IHN0cnVjdCB1c2JfZXBfb3BzIG5ldDIyODBfZXBf
b3BzOw0KLS0gDQoxLjkuMQ0K


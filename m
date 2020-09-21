Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65C9E271AC3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 08:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbgIUGRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 02:17:38 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:35367 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726427AbgIUGRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 02:17:22 -0400
X-UUID: 7f02da13606d4d42859f4c6eed9e5405-20200921
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=M+jMphpitAdQKmTgncue8DLUuiChzBueaSc64a9GuJ4=;
        b=oEKDVb1ynNUmgwwumG1tbZhg/AEzW8wczkOk5ummn+zbFmYHaL7LgRZ4yEHKhbCi+YaUZgnsbL0Geggub5OqdjPvF9cod1g+nXqyscNneMZhMQwOyfulLLbQQAHlINpvXCoMYYPFJAxjFhGpZgXi2dX5g+AVUCaJBZABrRYzeSM=;
X-UUID: 7f02da13606d4d42859f4c6eed9e5405-20200921
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1933687756; Mon, 21 Sep 2020 14:17:09 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS31DR.mediatek.inc (172.27.6.102) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 21 Sep 2020 14:17:08 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 21 Sep 2020 14:17:06 +0800
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
Subject: [PATCH v4 08/11] usb: phy-ulpi-viewport: convert to readl_poll_timeout_atomic()
Date:   Mon, 21 Sep 2020 14:13:32 +0800
Message-ID: <1600668815-12135-8-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1600668815-12135-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1600668815-12135-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: EEA5F66F385D1C22FDC9CCE0641F47060E3C27892C8F6ED0949B2FA6AC1DA61E2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VXNlIHJlYWRsX3BvbGxfdGltZW91dF9hdG9taWMoKSB0byBzaW1wbGlmeSBjb2RlDQoNClNpZ25l
ZC1vZmYtYnk6IENodW5mZW5nIFl1biA8Y2h1bmZlbmcueXVuQG1lZGlhdGVrLmNvbT4NCi0tLQ0K
djJ+djQ6IG5vIGNoYW5nZXMNCi0tLQ0KIGRyaXZlcnMvdXNiL3BoeS9waHktdWxwaS12aWV3cG9y
dC5jIHwgMTIgKysrLS0tLS0tLS0tDQogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwg
OSBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL3BoeS9waHktdWxwaS12
aWV3cG9ydC5jIGIvZHJpdmVycy91c2IvcGh5L3BoeS11bHBpLXZpZXdwb3J0LmMNCmluZGV4IDdh
MTRlMGUuLjBmNjFlMzIgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3VzYi9waHkvcGh5LXVscGktdmll
d3BvcnQuYw0KKysrIGIvZHJpdmVycy91c2IvcGh5L3BoeS11bHBpLXZpZXdwb3J0LmMNCkBAIC03
LDYgKzcsNyBAQA0KICNpbmNsdWRlIDxsaW51eC9rZXJuZWwuaD4NCiAjaW5jbHVkZSA8bGludXgv
dXNiLmg+DQogI2luY2x1ZGUgPGxpbnV4L2lvLmg+DQorI2luY2x1ZGUgPGxpbnV4L2lvcG9sbC5o
Pg0KICNpbmNsdWRlIDxsaW51eC91c2Ivb3RnLmg+DQogI2luY2x1ZGUgPGxpbnV4L3VzYi91bHBp
Lmg+DQogDQpAQCAtMjAsMTYgKzIxLDkgQEANCiANCiBzdGF0aWMgaW50IHVscGlfdmlld3BvcnRf
d2FpdCh2b2lkIF9faW9tZW0gKnZpZXcsIHUzMiBtYXNrKQ0KIHsNCi0JdW5zaWduZWQgbG9uZyB1
c2VjID0gMjAwMDsNCisJdTMyIHZhbDsNCiANCi0Jd2hpbGUgKHVzZWMtLSkgew0KLQkJaWYgKCEo
cmVhZGwodmlldykgJiBtYXNrKSkNCi0JCQlyZXR1cm4gMDsNCi0NCi0JCXVkZWxheSgxKTsNCi0J
fQ0KLQ0KLQlyZXR1cm4gLUVUSU1FRE9VVDsNCisJcmV0dXJuIHJlYWRsX3BvbGxfdGltZW91dF9h
dG9taWModmlldywgdmFsLCAhKHZhbCAmIG1hc2spLCAxLCAyMDAwKTsNCiB9DQogDQogc3RhdGlj
IGludCB1bHBpX3ZpZXdwb3J0X3JlYWQoc3RydWN0IHVzYl9waHkgKm90ZywgdTMyIHJlZykNCi0t
IA0KMS45LjENCg==


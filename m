Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B89F4271AB4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 08:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbgIUGRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 02:17:06 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:32638 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726011AbgIUGRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 02:17:05 -0400
X-UUID: cefb740919664e95868c211ba93a897d-20200921
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=qI3X9MwE9sMRTnQRdhPZhEZddjHAueHKnEny+Zk541Y=;
        b=kbJ4MNvsBOgJQ+AIltUz3w/dMmKx8/gWAgYwmGoOFMj4CJv5aGc6tMaLJ/80FMTgtRHZaQk/OLv4cUufCMfE8bHiBPtnat86dgJkSlgGNKfCKpu1GvjhrzJKtv8DUz8CUnYbFsHPFV8rWFHjaP1WECK6J9YheAKhtoUmXdqjPuI=;
X-UUID: cefb740919664e95868c211ba93a897d-20200921
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2077247481; Mon, 21 Sep 2020 14:17:00 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS31DR.mediatek.inc (172.27.6.102) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 21 Sep 2020 14:16:59 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 21 Sep 2020 14:16:57 +0800
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
        Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH v4 03/11] usb: pci-quirks: convert to readl_poll_timeout_atomic()
Date:   Mon, 21 Sep 2020 14:13:27 +0800
Message-ID: <1600668815-12135-3-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1600668815-12135-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1600668815-12135-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 421069FA6C9AA675FB54CB2DE9B79D16F9C9FB5D8FC8F7F833225D52AF36DAA72000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VXNlIHJlYWRsX3BvbGxfdGltZW91dF9hdG9taWMoKSB0byBzaW1wbGlmeSBjb2RlDQoNCkNjOiBN
YXRoaWFzIE55bWFuIDxtYXRoaWFzLm55bWFuQGxpbnV4LmludGVsLmNvbT4NClNpZ25lZC1vZmYt
Ynk6IENodW5mZW5nIFl1biA8Y2h1bmZlbmcueXVuQG1lZGlhdGVrLmNvbT4NCi0tLQ0KdjJ+djQ6
IG5vIGNoYW5nZXMNCi0tLQ0KIGRyaXZlcnMvdXNiL2hvc3QvcGNpLXF1aXJrcy5jIHwgMTMgKysr
Ky0tLS0tLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25z
KC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9ob3N0L3BjaS1xdWlya3MuYyBiL2RyaXZl
cnMvdXNiL2hvc3QvcGNpLXF1aXJrcy5jDQppbmRleCBiODk2MWMwLi44OTIwNTY2IDEwMDY0NA0K
LS0tIGEvZHJpdmVycy91c2IvaG9zdC9wY2ktcXVpcmtzLmMNCisrKyBiL2RyaXZlcnMvdXNiL2hv
c3QvcGNpLXF1aXJrcy5jDQpAQCAtMTYsNiArMTYsNyBAQA0KICNpbmNsdWRlIDxsaW51eC9leHBv
cnQuaD4NCiAjaW5jbHVkZSA8bGludXgvYWNwaS5oPg0KICNpbmNsdWRlIDxsaW51eC9kbWkuaD4N
CisjaW5jbHVkZSA8bGludXgvaW9wb2xsLmg+DQogDQogI2luY2x1ZGUgPHNvYy9iY20yODM1L3Jh
c3BiZXJyeXBpLWZpcm13YXJlLmg+DQogDQpAQCAtMTAxMiwxNSArMTAxMyw5IEBAIHN0YXRpYyBp
bnQgaGFuZHNoYWtlKHZvaWQgX19pb21lbSAqcHRyLCB1MzIgbWFzaywgdTMyIGRvbmUsDQogew0K
IAl1MzIJcmVzdWx0Ow0KIA0KLQlkbyB7DQotCQlyZXN1bHQgPSByZWFkbChwdHIpOw0KLQkJcmVz
dWx0ICY9IG1hc2s7DQotCQlpZiAocmVzdWx0ID09IGRvbmUpDQotCQkJcmV0dXJuIDA7DQotCQl1
ZGVsYXkoZGVsYXlfdXNlYyk7DQotCQl3YWl0X3VzZWMgLT0gZGVsYXlfdXNlYzsNCi0JfSB3aGls
ZSAod2FpdF91c2VjID4gMCk7DQotCXJldHVybiAtRVRJTUVET1VUOw0KKwlyZXR1cm4gcmVhZGxf
cG9sbF90aW1lb3V0X2F0b21pYyhwdHIsIHJlc3VsdCwNCisJCQkJCSAoKHJlc3VsdCAmIG1hc2sp
ID09IGRvbmUpLA0KKwkJCQkJIGRlbGF5X3VzZWMsIHdhaXRfdXNlYyk7DQogfQ0KIA0KIC8qDQot
LSANCjEuOS4xDQo=


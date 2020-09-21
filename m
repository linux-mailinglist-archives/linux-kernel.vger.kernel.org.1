Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F34C271AC9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 08:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbgIUGRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 02:17:19 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:31781 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726395AbgIUGRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 02:17:13 -0400
X-UUID: 1af28c60b7d143c0887bfb09408e1f3d-20200921
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=6ZOWN7ki1sN531xAD52X8GiFWf24OghgpbzynrNkwy8=;
        b=DO28peqW8B399qNluQEyUPGAjNa5QATl1rkGpuuGLhRKMsXwT1ihgN8MfXdXk/f4orOX+V6K1VjgFYBvJOVW8vkwAKZfAiIUIU4xNe/WHdeX321xyDFZMKmzZSqohYuuRsi3EyExdZ5zGqmVy8ve2vJeRlQb3w3JrytM+CrKj6Q=;
X-UUID: 1af28c60b7d143c0887bfb09408e1f3d-20200921
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 300474815; Mon, 21 Sep 2020 14:16:57 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 21 Sep 2020 14:16:56 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 21 Sep 2020 14:16:54 +0800
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
        Lu Baolu <baolu.lu@linux.intel.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH v4 01/11] usb: early: convert to readl_poll_timeout_atomic()
Date:   Mon, 21 Sep 2020 14:13:25 +0800
Message-ID: <1600668815-12135-1-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 2F03555C4872A9C51584CA060F9A514A5CB38BC9E5EB911970C0BACFA9D73A672000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VXNlIHJlYWRsX3BvbGxfdGltZW91dF9hdG9taWMoKSB0byBzaW1wbGlmeSBjb2RlDQoNCkNjOiBM
dSBCYW9sdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KQ2M6IE1hdGhpYXMgTnltYW4gPG1h
dGhpYXMubnltYW5AbGludXguaW50ZWwuY29tPg0KU2lnbmVkLW9mZi1ieTogQ2h1bmZlbmcgWXVu
IDxjaHVuZmVuZy55dW5AbWVkaWF0ZWsuY29tPg0KUmV2aWV3ZWQtYnk6IEphbm4gSG9ybiA8amFu
bmhAZ29vZ2xlLmNvbT4NCi0tLQ0KdjQ6IGFkZCByZXZpZXdlZC1ieSBKYW5uDQoNCnYyfnYzOiBu
byBjaGFuZ2VzDQotLS0NCiBkcml2ZXJzL3VzYi9lYXJseS94aGNpLWRiYy5jIHwgMTQgKysrKy0t
LS0tLS0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMo
LSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2Vhcmx5L3hoY2ktZGJjLmMgYi9kcml2ZXJz
L3VzYi9lYXJseS94aGNpLWRiYy5jDQppbmRleCBjMDUwNzc2Li5iZTRlY2JhIDEwMDY0NA0KLS0t
IGEvZHJpdmVycy91c2IvZWFybHkveGhjaS1kYmMuYw0KKysrIGIvZHJpdmVycy91c2IvZWFybHkv
eGhjaS1kYmMuYw0KQEAgLTE0LDYgKzE0LDcgQEANCiAjaW5jbHVkZSA8bGludXgvcGNpX2lkcy5o
Pg0KICNpbmNsdWRlIDxsaW51eC9tZW1ibG9jay5oPg0KICNpbmNsdWRlIDxsaW51eC9pby5oPg0K
KyNpbmNsdWRlIDxsaW51eC9pb3BvbGwuaD4NCiAjaW5jbHVkZSA8YXNtL3BjaS1kaXJlY3QuaD4N
CiAjaW5jbHVkZSA8YXNtL2ZpeG1hcC5oPg0KICNpbmNsdWRlIDxsaW51eC9iY2QuaD4NCkBAIC0x
MzUsMTYgKzEzNiw5IEBAIHN0YXRpYyBpbnQgaGFuZHNoYWtlKHZvaWQgX19pb21lbSAqcHRyLCB1
MzIgbWFzaywgdTMyIGRvbmUsIGludCB3YWl0LCBpbnQgZGVsYXkpDQogew0KIAl1MzIgcmVzdWx0
Ow0KIA0KLQlkbyB7DQotCQlyZXN1bHQgPSByZWFkbChwdHIpOw0KLQkJcmVzdWx0ICY9IG1hc2s7
DQotCQlpZiAocmVzdWx0ID09IGRvbmUpDQotCQkJcmV0dXJuIDA7DQotCQl1ZGVsYXkoZGVsYXkp
Ow0KLQkJd2FpdCAtPSBkZWxheTsNCi0JfSB3aGlsZSAod2FpdCA+IDApOw0KLQ0KLQlyZXR1cm4g
LUVUSU1FRE9VVDsNCisJcmV0dXJuIHJlYWRsX3BvbGxfdGltZW91dF9hdG9taWMocHRyLCByZXN1
bHQsDQorCQkJCQkgKChyZXN1bHQgJiBtYXNrKSA9PSBkb25lKSwNCisJCQkJCSBkZWxheSwgd2Fp
dCk7DQogfQ0KIA0KIHN0YXRpYyB2b2lkIF9faW5pdCB4ZGJjX2Jpb3NfaGFuZG9mZih2b2lkKQ0K
LS0gDQoxLjkuMQ0K


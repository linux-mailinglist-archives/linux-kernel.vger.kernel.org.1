Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAE8724E652
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Aug 2020 10:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbgHVIJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Aug 2020 04:09:21 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:14205 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726440AbgHVIJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 04:09:20 -0400
X-UUID: 4dd971b0b817432db02b395c5e376f68-20200822
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=J3BiqWxfV1+Z3aDvfR83RogHjSnqeDdQl3tqJBLcqsI=;
        b=hTFZ7bgdAHUy8AMgfNtKPxuUlbAPjzc2yMSNPgWvtEb+Cf0Cuw8XS6gK+ozDZmfPz/gjht5Qk8eE/IDmbsbwgBn80zEZAY+KbwD2BMRYHVkvfG1aUHFuZoIyGz0f5z+oRRYde4SftGAyxXIkUH8/o95N48iQLC9t/LwLXUPfsEo=;
X-UUID: 4dd971b0b817432db02b395c5e376f68-20200822
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1604317320; Sat, 22 Aug 2020 16:09:10 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 22 Aug 2020 16:09:09 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 22 Aug 2020 16:09:07 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Felipe Balbi <balbi@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH v3 02/11] usb: early: ehci-dbgp: convert to readl_poll_timeout_atomic()
Date:   Sat, 22 Aug 2020 16:05:44 +0800
Message-ID: <1598083553-31896-2-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1598083553-31896-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1598083553-31896-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 1AD602322C59DB4F16AA25D238C4AA114EFF3246AC1A34F1DAADE2B517D82AAD2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VXNlIHJlYWRsX3BvbGxfdGltZW91dF9hdG9taWMoKSB0byBzaW1wbGlmeSBjb2RlDQoNCkNjOiAi
RXJpYyBXLiBCaWVkZXJtYW4iIDxlYmllZGVybUB4bWlzc2lvbi5jb20+DQpDYzogUGV0ciBNbGFk
ZWsgPHBtbGFkZWtAc3VzZS5jb20+DQpTaWduZWQtb2ZmLWJ5OiBDaHVuZmVuZyBZdW4gPGNodW5m
ZW5nLnl1bkBtZWRpYXRlay5jb20+DQotLS0NCnYyfnYzOiBubyBjaGFuZ2VzDQotLS0NCiBkcml2
ZXJzL3VzYi9lYXJseS9laGNpLWRiZ3AuYyB8IDE1ICsrKysrLS0tLS0tLS0tLQ0KIDEgZmlsZSBj
aGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDEwIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy91c2IvZWFybHkvZWhjaS1kYmdwLmMgYi9kcml2ZXJzL3VzYi9lYXJseS9laGNpLWRi
Z3AuYw0KaW5kZXggYjA3NWRiZi4uNDViNDJkOCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvdXNiL2Vh
cmx5L2VoY2ktZGJncC5jDQorKysgYi9kcml2ZXJzL3VzYi9lYXJseS9laGNpLWRiZ3AuYw0KQEAg
LTE1LDYgKzE1LDcgQEANCiAjaW5jbHVkZSA8bGludXgvY29uc29sZS5oPg0KICNpbmNsdWRlIDxs
aW51eC9lcnJuby5oPg0KICNpbmNsdWRlIDxsaW51eC9pbml0Lmg+DQorI2luY2x1ZGUgPGxpbnV4
L2lvcG9sbC5oPg0KICNpbmNsdWRlIDxsaW51eC9wY2lfcmVncy5oPg0KICNpbmNsdWRlIDxsaW51
eC9wY2lfaWRzLmg+DQogI2luY2x1ZGUgPGxpbnV4L3VzYi9jaDkuaD4NCkBAIC0xNjEsMTcgKzE2
MiwxMSBAQCBzdGF0aWMgaW5saW5lIHUzMiBkYmdwX3BpZF9yZWFkX3VwZGF0ZSh1MzIgeCwgdTMy
IHRvaykNCiBzdGF0aWMgaW50IGRiZ3Bfd2FpdF91bnRpbF9jb21wbGV0ZSh2b2lkKQ0KIHsNCiAJ
dTMyIGN0cmw7DQotCWludCBsb29wID0gREJHUF9USU1FT1VUOw0KLQ0KLQlkbyB7DQotCQljdHJs
ID0gcmVhZGwoJmVoY2lfZGVidWctPmNvbnRyb2wpOw0KLQkJLyogU3RvcCB3aGVuIHRoZSB0cmFu
c2FjdGlvbiBpcyBmaW5pc2hlZCAqLw0KLQkJaWYgKGN0cmwgJiBEQkdQX0RPTkUpDQotCQkJYnJl
YWs7DQotCQl1ZGVsYXkoMSk7DQotCX0gd2hpbGUgKC0tbG9vcCA+IDApOw0KKwlpbnQgcmV0Ow0K
IA0KLQlpZiAoIWxvb3ApDQorCXJldCA9IHJlYWRsX3BvbGxfdGltZW91dF9hdG9taWMoJmVoY2lf
ZGVidWctPmNvbnRyb2wsIGN0cmwsDQorCQkJCShjdHJsICYgREJHUF9ET05FKSwgMSwgREJHUF9U
SU1FT1VUKTsNCisJaWYgKHJldCkNCiAJCXJldHVybiAtREJHUF9USU1FT1VUOw0KIA0KIAkvKg0K
LS0gDQoxLjkuMQ0K


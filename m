Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A052271AB3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 08:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbgIUGRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 02:17:06 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:63798 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726149AbgIUGRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 02:17:05 -0400
X-UUID: 76199e3959b24f03ba6d17f8da1ed900-20200921
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Xo5rf9xp9Q898V4NrJeKvL/NbIN1YvfdZlom51aDk10=;
        b=dMYOzZlAtRAPxAFM4lM+xpxev+mOaJjz8MoQcDuHI/7chEd3NHWJc94oR8awYOuaFRAR33A0PAeRtxI9X4sWfra+4Ed/fXeIgWNK3iSr/bEj1bVhAMvfwT2GogU4TuU8o++T5dyESf+0WXqFV4dLVYfxaGHo48GBdPaNTew9KnQ=;
X-UUID: 76199e3959b24f03ba6d17f8da1ed900-20200921
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1399888662; Mon, 21 Sep 2020 14:16:59 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS31DR.mediatek.inc (172.27.6.102) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 21 Sep 2020 14:16:57 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 21 Sep 2020 14:16:56 +0800
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
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH v4 02/11] usb: early: ehci-dbgp: convert to readl_poll_timeout_atomic()
Date:   Mon, 21 Sep 2020 14:13:26 +0800
Message-ID: <1600668815-12135-2-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1600668815-12135-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1600668815-12135-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 08E2723B77F099582DC762E959887646B7F9FDFF59FD8B41E444D08844B116772000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VXNlIHJlYWRsX3BvbGxfdGltZW91dF9hdG9taWMoKSB0byBzaW1wbGlmeSBjb2RlDQoNCkNjOiAi
RXJpYyBXLiBCaWVkZXJtYW4iIDxlYmllZGVybUB4bWlzc2lvbi5jb20+DQpDYzogUGV0ciBNbGFk
ZWsgPHBtbGFkZWtAc3VzZS5jb20+DQpTaWduZWQtb2ZmLWJ5OiBDaHVuZmVuZyBZdW4gPGNodW5m
ZW5nLnl1bkBtZWRpYXRlay5jb20+DQotLS0NCnYyfnY0OiBubyBjaGFuZ2VzDQotLS0NCiBkcml2
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


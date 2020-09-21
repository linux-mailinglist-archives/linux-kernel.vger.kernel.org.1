Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F15D271ABC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 08:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbgIUGR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 02:17:26 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:33827 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726360AbgIUGRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 02:17:10 -0400
X-UUID: a1b094b5ca854b2cbb26a0c061b1d1e1-20200921
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=U22axENSaSmKHtYTwm1iMGOTpOJkveZ+Ct8IXMXHsKI=;
        b=bnGMdywG97ACJCIzqKN4MCGrpDnMvG6eFt0ci/rD/fsFW/9uINbUeB1gVe7ra+ddOZfxJcZxO2RRbL88WUfQ1IA5KMkILOk1Lv7+YF8lttbgz0XmpKzY7QGqeEiTbuEREScnODGkqQ1LMhEI9jBvpH+MqvsvPyw44GjgVYOAzXY=;
X-UUID: a1b094b5ca854b2cbb26a0c061b1d1e1-20200921
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1774809618; Mon, 21 Sep 2020 14:17:02 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 21 Sep 2020 14:17:02 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 21 Sep 2020 14:16:59 +0800
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
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v4 04/11] usb: xhci-rcar: convert to readl_poll_timeout_atomic()
Date:   Mon, 21 Sep 2020 14:13:28 +0800
Message-ID: <1600668815-12135-4-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1600668815-12135-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1600668815-12135-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: F0016E84F75B6688BB13CF221D2E328E07E6887A003D1587A8EF7C2F36539F9F2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VXNlIHJlYWRsX3BvbGxfdGltZW91dF9hdG9taWMoKSB0byBzaW1wbGlmeSBjb2RlDQoNCkNjOiBN
YXRoaWFzIE55bWFuIDxtYXRoaWFzLm55bWFuQGxpbnV4LmludGVsLmNvbT4NCkNjOiBZb3NoaWhp
cm8gU2hpbW9kYSA8eW9zaGloaXJvLnNoaW1vZGEudWhAcmVuZXNhcy5jb20+DQpTaWduZWQtb2Zm
LWJ5OiBDaHVuZmVuZyBZdW4gPGNodW5mZW5nLnl1bkBtZWRpYXRlay5jb20+DQotLS0NCnY0OiBj
aGFuZ2VzDQogICAgMS4gcmVtb3ZlIHVubmVjZXNzYXJ5IHBhcmVudGhlc2VzIHN1Z2dlc3RlZCBi
eSBZb3NoaWhpcm8NCiAgICAyLiBmaXggdGhlIHdyb25nIHJldHVybiB2YWx1ZSBzdWdnZXN0ZWQg
YnkgWW9zaGloaXJvICYgRGFuaWVsDQoNCnYyfnYzOiBubyBjaGFuZ2VzDQotLS0NCiBkcml2ZXJz
L3VzYi9ob3N0L3hoY2ktcmNhci5jIHwgNDMgKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspLCAzMSBkZWxl
dGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2hvc3QveGhjaS1yY2FyLmMgYi9k
cml2ZXJzL3VzYi9ob3N0L3hoY2ktcmNhci5jDQppbmRleCBjMTAyNWQzLi4xYmM0ZmU3IDEwMDY0
NA0KLS0tIGEvZHJpdmVycy91c2IvaG9zdC94aGNpLXJjYXIuYw0KKysrIGIvZHJpdmVycy91c2Iv
aG9zdC94aGNpLXJjYXIuYw0KQEAgLTYsNiArNiw3IEBADQogICovDQogDQogI2luY2x1ZGUgPGxp
bnV4L2Zpcm13YXJlLmg+DQorI2luY2x1ZGUgPGxpbnV4L2lvcG9sbC5oPg0KICNpbmNsdWRlIDxs
aW51eC9tb2R1bGUuaD4NCiAjaW5jbHVkZSA8bGludXgvcGxhdGZvcm1fZGV2aWNlLmg+DQogI2lu
Y2x1ZGUgPGxpbnV4L29mLmg+DQpAQCAtMTI3LDggKzEyOCw3IEBAIHN0YXRpYyBpbnQgeGhjaV9y
Y2FyX2Rvd25sb2FkX2Zpcm13YXJlKHN0cnVjdCB1c2JfaGNkICpoY2QpDQogCXZvaWQgX19pb21l
bSAqcmVncyA9IGhjZC0+cmVnczsNCiAJc3RydWN0IHhoY2lfcGxhdF9wcml2ICpwcml2ID0gaGNk
X3RvX3hoY2lfcHJpdihoY2QpOw0KIAljb25zdCBzdHJ1Y3QgZmlybXdhcmUgKmZ3Ow0KLQlpbnQg
cmV0dmFsLCBpbmRleCwgaiwgdGltZTsNCi0JaW50IHRpbWVvdXQgPSAxMDAwMDsNCisJaW50IHJl
dHZhbCwgaW5kZXgsIGo7DQogCXUzMiBkYXRhLCB2YWwsIHRlbXA7DQogCXUzMiBxdWlya3MgPSAw
Ow0KIAljb25zdCBzdHJ1Y3Qgc29jX2RldmljZV9hdHRyaWJ1dGUgKmF0dHI7DQpAQCAtMTY2LDMy
ICsxNjYsMTkgQEAgc3RhdGljIGludCB4aGNpX3JjYXJfZG93bmxvYWRfZmlybXdhcmUoc3RydWN0
IHVzYl9oY2QgKmhjZCkNCiAJCXRlbXAgfD0gUkNBUl9VU0IzX0RMX0NUUkxfRldfU0VUX0RBVEEw
Ow0KIAkJd3JpdGVsKHRlbXAsIHJlZ3MgKyBSQ0FSX1VTQjNfRExfQ1RSTCk7DQogDQotCQlmb3Ig
KHRpbWUgPSAwOyB0aW1lIDwgdGltZW91dDsgdGltZSsrKSB7DQotCQkJdmFsID0gcmVhZGwocmVn
cyArIFJDQVJfVVNCM19ETF9DVFJMKTsNCi0JCQlpZiAoKHZhbCAmIFJDQVJfVVNCM19ETF9DVFJM
X0ZXX1NFVF9EQVRBMCkgPT0gMCkNCi0JCQkJYnJlYWs7DQotCQkJdWRlbGF5KDEpOw0KLQkJfQ0K
LQkJaWYgKHRpbWUgPT0gdGltZW91dCkgew0KLQkJCXJldHZhbCA9IC1FVElNRURPVVQ7DQorCQly
ZXR2YWwgPSByZWFkbF9wb2xsX3RpbWVvdXRfYXRvbWljKHJlZ3MgKyBSQ0FSX1VTQjNfRExfQ1RS
TCwNCisJCQkJdmFsLCAhKHZhbCAmIFJDQVJfVVNCM19ETF9DVFJMX0ZXX1NFVF9EQVRBMCksDQor
CQkJCTEsIDEwMDAwKTsNCisJCWlmIChyZXR2YWwgPCAwKQ0KIAkJCWJyZWFrOw0KLQkJfQ0KIAl9
DQogDQogCXRlbXAgPSByZWFkbChyZWdzICsgUkNBUl9VU0IzX0RMX0NUUkwpOw0KIAl0ZW1wICY9
IH5SQ0FSX1VTQjNfRExfQ1RSTF9FTkFCTEU7DQogCXdyaXRlbCh0ZW1wLCByZWdzICsgUkNBUl9V
U0IzX0RMX0NUUkwpOw0KIA0KLQlmb3IgKHRpbWUgPSAwOyB0aW1lIDwgdGltZW91dDsgdGltZSsr
KSB7DQotCQl2YWwgPSByZWFkbChyZWdzICsgUkNBUl9VU0IzX0RMX0NUUkwpOw0KLQkJaWYgKHZh
bCAmIFJDQVJfVVNCM19ETF9DVFJMX0ZXX1NVQ0NFU1MpIHsNCi0JCQlyZXR2YWwgPSAwOw0KLQkJ
CWJyZWFrOw0KLQkJfQ0KLQkJdWRlbGF5KDEpOw0KLQl9DQotCWlmICh0aW1lID09IHRpbWVvdXQp
DQotCQlyZXR2YWwgPSAtRVRJTUVET1VUOw0KKwlyZXR2YWwgPSByZWFkbF9wb2xsX3RpbWVvdXRf
YXRvbWljKChyZWdzICsgUkNBUl9VU0IzX0RMX0NUUkwpLA0KKwkJCXZhbCwgdmFsICYgUkNBUl9V
U0IzX0RMX0NUUkxfRldfU1VDQ0VTUywgMSwgMTAwMDApOw0KIA0KIAlyZWxlYXNlX2Zpcm13YXJl
KGZ3KTsNCiANCkBAIC0yMDAsMTggKzE4NywxMiBAQCBzdGF0aWMgaW50IHhoY2lfcmNhcl9kb3du
bG9hZF9maXJtd2FyZShzdHJ1Y3QgdXNiX2hjZCAqaGNkKQ0KIA0KIHN0YXRpYyBib29sIHhoY2lf
cmNhcl93YWl0X2Zvcl9wbGxfYWN0aXZlKHN0cnVjdCB1c2JfaGNkICpoY2QpDQogew0KLQlpbnQg
dGltZW91dCA9IDEwMDA7DQorCWludCByZXR2YWw7DQogCXUzMiB2YWwsIG1hc2sgPSBSQ0FSX1VT
QjNfQVhIX1NUQV9QTExfQUNUSVZFX01BU0s7DQogDQotCXdoaWxlICh0aW1lb3V0ID4gMCkgew0K
LQkJdmFsID0gcmVhZGwoaGNkLT5yZWdzICsgUkNBUl9VU0IzX0FYSF9TVEEpOw0KLQkJaWYgKCh2
YWwgJiBtYXNrKSA9PSBtYXNrKQ0KLQkJCXJldHVybiB0cnVlOw0KLQkJdWRlbGF5KDEpOw0KLQkJ
dGltZW91dC0tOw0KLQl9DQotDQotCXJldHVybiBmYWxzZTsNCisJcmV0dmFsID0gcmVhZGxfcG9s
bF90aW1lb3V0X2F0b21pYyhoY2QtPnJlZ3MgKyBSQ0FSX1VTQjNfQVhIX1NUQSwNCisJCQl2YWws
ICh2YWwgJiBtYXNrKSA9PSBtYXNrLCAxLCAxMDAwKTsNCisJcmV0dXJuICFyZXR2YWw7DQogfQ0K
IA0KIC8qIFRoaXMgZnVuY3Rpb24gbmVlZHMgdG8gaW5pdGlhbGl6ZSBhICJwaHkiIG9mIHVzYiBi
ZWZvcmUgKi8NCi0tIA0KMS45LjENCg==


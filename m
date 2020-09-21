Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E653271ABE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 08:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbgIUGR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 02:17:28 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:44379 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726149AbgIUGRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 02:17:16 -0400
X-UUID: 9b8aeb5f100842b88219cd125606aac5-20200921
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=fhoC7nd4R36M3issGh+SxVPkb1Qjg4iuhqpKgwaNaKE=;
        b=ar2WyMZzX2bOPL47+URojAsnd8qASu3pjqCCyQCTaqvuXRJMR+9fW7EXGUmn8P8ispWphQYabRcdzgtN70lqNH71mBtADueARgUzO5PTcmz+4IVjG4lXxVsm8fhu+OCsjJfSeM4kYC2rX2fOhAWGutJE6WdTwDi4NUmk61diOzg=;
X-UUID: 9b8aeb5f100842b88219cd125606aac5-20200921
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 50010507; Mon, 21 Sep 2020 14:17:11 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 21 Sep 2020 14:17:10 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 21 Sep 2020 14:17:08 +0800
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
Subject: [PATCH v4 09/11] usb: phy: phy-mv-usb: convert to readl_poll_timeout_atomic()
Date:   Mon, 21 Sep 2020 14:13:33 +0800
Message-ID: <1600668815-12135-9-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1600668815-12135-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1600668815-12135-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 2F9FBD9981B001EA895A14F6E8D251A0B594F6BC5073CA2F55F375A17B5E66502000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VXNlIHJlYWRsX3BvbGxfdGltZW91dF9hdG9taWMoKSB0byBzaW1wbGlmeSBjb2RlDQoNClNpZ25l
ZC1vZmYtYnk6IENodW5mZW5nIFl1biA8Y2h1bmZlbmcueXVuQG1lZGlhdGVrLmNvbT4NCi0tLQ0K
djQ6IG5vIGNoYW5nZXMNCg0KdjM6IHJlLWFsaWduIGFyZ3VtZW50IG9mIGxvZyBzdWdnZXN0ZWQg
YnkgU2VyZ2VpDQoNCnYyOiB1ZGVsYXkgMTB1cyBpbnN0ZWFkIG9mIDIwdXMgYWNjb3JkaW5nIHRv
IGtlcm5lbGRvYw0KLS0tDQogZHJpdmVycy91c2IvcGh5L3BoeS1tdi11c2IuYyB8IDE4ICsrKysr
KysrLS0tLS0tLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDEwIGRlbGV0
aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvcGh5L3BoeS1tdi11c2IuYyBiL2Ry
aXZlcnMvdXNiL3BoeS9waHktbXYtdXNiLmMNCmluZGV4IGNlNzY3ZWMuLjU3NmQ5MjUgMTAwNjQ0
DQotLS0gYS9kcml2ZXJzL3VzYi9waHkvcGh5LW12LXVzYi5jDQorKysgYi9kcml2ZXJzL3VzYi9w
aHkvcGh5LW12LXVzYi5jDQpAQCAtOCw2ICs4LDcgQEANCiAjaW5jbHVkZSA8bGludXgvbW9kdWxl
Lmg+DQogI2luY2x1ZGUgPGxpbnV4L2tlcm5lbC5oPg0KICNpbmNsdWRlIDxsaW51eC9pby5oPg0K
KyNpbmNsdWRlIDxsaW51eC9pb3BvbGwuaD4NCiAjaW5jbHVkZSA8bGludXgvdWFjY2Vzcy5oPg0K
ICNpbmNsdWRlIDxsaW51eC9kZXZpY2UuaD4NCiAjaW5jbHVkZSA8bGludXgvcHJvY19mcy5oPg0K
QEAgLTEzNSw4ICsxMzYsOCBAQCBzdGF0aWMgaW50IG12X290Z19zZXRfdGltZXIoc3RydWN0IG12
X290ZyAqbXZvdGcsIHVuc2lnbmVkIGludCBpZCwNCiANCiBzdGF0aWMgaW50IG12X290Z19yZXNl
dChzdHJ1Y3QgbXZfb3RnICptdm90ZykNCiB7DQotCXVuc2lnbmVkIGludCBsb29wczsNCiAJdTMy
IHRtcDsNCisJaW50IHJldDsNCiANCiAJLyogU3RvcCB0aGUgY29udHJvbGxlciAqLw0KIAl0bXAg
PSByZWFkbCgmbXZvdGctPm9wX3JlZ3MtPnVzYmNtZCk7DQpAQCAtMTQ2LDE1ICsxNDcsMTIgQEAg
c3RhdGljIGludCBtdl9vdGdfcmVzZXQoc3RydWN0IG12X290ZyAqbXZvdGcpDQogCS8qIFJlc2V0
IHRoZSBjb250cm9sbGVyIHRvIGdldCBkZWZhdWx0IHZhbHVlcyAqLw0KIAl3cml0ZWwoVVNCQ01E
X0NUUkxfUkVTRVQsICZtdm90Zy0+b3BfcmVncy0+dXNiY21kKTsNCiANCi0JbG9vcHMgPSA1MDA7
DQotCXdoaWxlIChyZWFkbCgmbXZvdGctPm9wX3JlZ3MtPnVzYmNtZCkgJiBVU0JDTURfQ1RSTF9S
RVNFVCkgew0KLQkJaWYgKGxvb3BzID09IDApIHsNCi0JCQlkZXZfZXJyKCZtdm90Zy0+cGRldi0+
ZGV2LA0KLQkJCQkiV2FpdCBmb3IgUkVTRVQgY29tcGxldGVkIFRJTUVPVVRcbiIpOw0KLQkJCXJl
dHVybiAtRVRJTUVET1VUOw0KLQkJfQ0KLQkJbG9vcHMtLTsNCi0JCXVkZWxheSgyMCk7DQorCXJl
dCA9IHJlYWRsX3BvbGxfdGltZW91dF9hdG9taWMoJm12b3RnLT5vcF9yZWdzLT51c2JjbWQsIHRt
cCwNCisJCQkJKHRtcCAmIFVTQkNNRF9DVFJMX1JFU0VUKSwgMTAsIDEwMDAwKTsNCisJaWYgKHJl
dCA8IDApIHsNCisJCWRldl9lcnIoJm12b3RnLT5wZGV2LT5kZXYsDQorCQkJIldhaXQgZm9yIFJF
U0VUIGNvbXBsZXRlZCBUSU1FT1VUXG4iKTsNCisJCXJldHVybiByZXQ7DQogCX0NCiANCiAJd3Jp
dGVsKDB4MCwgJm12b3RnLT5vcF9yZWdzLT51c2JpbnRyKTsNCi0tIA0KMS45LjENCg==


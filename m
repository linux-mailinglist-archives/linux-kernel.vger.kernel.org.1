Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB25624AE98
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Aug 2020 07:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbgHTFr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Aug 2020 01:47:27 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:30621 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725823AbgHTFrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 01:47:22 -0400
X-UUID: 73931937cb3541b59416a38361149ade-20200820
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=4S7+BDNc9UfPA46FfZlQ7kGKKyGhLtCvW8X6XUp2V4I=;
        b=aWiQEkD9LlIDOoUeBZt+/nvAssPceFJ+YBoK/ZcKkKDii6uYGWggrMYI4QY9VlBtvHV00gUcAjBlIy6W4cSMJrULWgAW4+2zzjSsYzUf9SVR3XGiL8fuwZvQb9iMuosCgZ6ShvyBNQGiYMN7iFhj5S5E3LzRn4zLmoac+8eUxws=;
X-UUID: 73931937cb3541b59416a38361149ade-20200820
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 275457571; Thu, 20 Aug 2020 13:47:18 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 20 Aug 2020 13:47:17 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 20 Aug 2020 13:47:15 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Felipe Balbi <balbi@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v2 08/11] usb: phy-ulpi-viewport: convert to readl_poll_timeout_atomic()
Date:   Thu, 20 Aug 2020 13:45:46 +0800
Message-ID: <1597902349-8998-8-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1597902349-8998-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1597902349-8998-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 5FF79E2C40089937E4F3079EE26A366EF54C3E81ED7A0B64866E9EA5FAAD95BF2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VXNlIHJlYWRsX3BvbGxfdGltZW91dF9hdG9taWMoKSB0byBzaW1wbGlmeSBjb2RlDQoNClNpZ25l
ZC1vZmYtYnk6IENodW5mZW5nIFl1biA8Y2h1bmZlbmcueXVuQG1lZGlhdGVrLmNvbT4NCi0tLQ0K
djI6IG5vIGNoYW5nZXMNCi0tLQ0KIGRyaXZlcnMvdXNiL3BoeS9waHktdWxwaS12aWV3cG9ydC5j
IHwgMTIgKysrLS0tLS0tLS0tDQogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgOSBk
ZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL3BoeS9waHktdWxwaS12aWV3
cG9ydC5jIGIvZHJpdmVycy91c2IvcGh5L3BoeS11bHBpLXZpZXdwb3J0LmMNCmluZGV4IDdhMTRl
MGUuLjBmNjFlMzIgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3VzYi9waHkvcGh5LXVscGktdmlld3Bv
cnQuYw0KKysrIGIvZHJpdmVycy91c2IvcGh5L3BoeS11bHBpLXZpZXdwb3J0LmMNCkBAIC03LDYg
KzcsNyBAQA0KICNpbmNsdWRlIDxsaW51eC9rZXJuZWwuaD4NCiAjaW5jbHVkZSA8bGludXgvdXNi
Lmg+DQogI2luY2x1ZGUgPGxpbnV4L2lvLmg+DQorI2luY2x1ZGUgPGxpbnV4L2lvcG9sbC5oPg0K
ICNpbmNsdWRlIDxsaW51eC91c2Ivb3RnLmg+DQogI2luY2x1ZGUgPGxpbnV4L3VzYi91bHBpLmg+
DQogDQpAQCAtMjAsMTYgKzIxLDkgQEANCiANCiBzdGF0aWMgaW50IHVscGlfdmlld3BvcnRfd2Fp
dCh2b2lkIF9faW9tZW0gKnZpZXcsIHUzMiBtYXNrKQ0KIHsNCi0JdW5zaWduZWQgbG9uZyB1c2Vj
ID0gMjAwMDsNCisJdTMyIHZhbDsNCiANCi0Jd2hpbGUgKHVzZWMtLSkgew0KLQkJaWYgKCEocmVh
ZGwodmlldykgJiBtYXNrKSkNCi0JCQlyZXR1cm4gMDsNCi0NCi0JCXVkZWxheSgxKTsNCi0JfQ0K
LQ0KLQlyZXR1cm4gLUVUSU1FRE9VVDsNCisJcmV0dXJuIHJlYWRsX3BvbGxfdGltZW91dF9hdG9t
aWModmlldywgdmFsLCAhKHZhbCAmIG1hc2spLCAxLCAyMDAwKTsNCiB9DQogDQogc3RhdGljIGlu
dCB1bHBpX3ZpZXdwb3J0X3JlYWQoc3RydWN0IHVzYl9waHkgKm90ZywgdTMyIHJlZykNCi0tIA0K
MS45LjENCg==


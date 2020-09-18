Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E19E26F9DD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 12:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbgIRKFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 06:05:42 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:10275 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725874AbgIRKFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 06:05:41 -0400
X-UUID: 71acfbe5a8ca4eda9afe2e1c83c49ae7-20200918
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=DTzHJ0x3J7AjDNKHrUyRTj2CRSv0RSJyT9HCWPEn1sY=;
        b=uYLROxXBCzgU0DUKwJTITwNdgQbPEt7g0lOwclFMaWCZg6HTSrc6ZUpaquAVcQnfJLLpbJACzTPi/fSsBt/yGLmYivEGwQe8hj19ezM2AdjTdGu4xEZ3bOrMyxpqf4RdYFUsXt0MQBdpWETq9Ge+9gjb1yALX7QdrmwFhtmwSLo=;
X-UUID: 71acfbe5a8ca4eda9afe2e1c83c49ae7-20200918
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <shane.chien@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 178364160; Fri, 18 Sep 2020 18:00:37 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 18 Sep 2020 18:00:35 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 18 Sep 2020 18:00:35 +0800
From:   Shane Chien <shane.chien@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Brown <broonie@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>, <jiaxin.yu@mediatek.com>,
        <eason.yen@mediatek.com>, <shane.chien@mediatek.com>
Subject: [PATCH] ASoC: Use memset_io to access I/O memory
Date:   Fri, 18 Sep 2020 18:00:19 +0800
Message-ID: <1600423219-29058-2-git-send-email-shane.chien@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1600423219-29058-1-git-send-email-shane.chien@mediatek.com>
References: <1600423219-29058-1-git-send-email-shane.chien@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogIlNoYW5lLkNoaWVuIiA8c2hhbmUuY2hpZW5AbWVkaWF0ZWsuY29tPg0KDQpVc2UgbWVt
c2V0X2lvIHRvIGFjY2VzcyBJL08gbWVtb3J5LCBpbnN0ZWFkIG9mDQptZW1zZXQuDQoNClNpZ25l
ZC1vZmYtYnk6IFNoYW5lLkNoaWVuIDxzaGFuZS5jaGllbkBtZWRpYXRlay5jb20+DQotLS0NCiBz
b3VuZC9jb3JlL3BjbV9uYXRpdmUuYyB8ICAgIDIgKy0NCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNl
cnRpb24oKyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL3NvdW5kL2NvcmUvcGNtX25h
dGl2ZS5jIGIvc291bmQvY29yZS9wY21fbmF0aXZlLmMNCmluZGV4IDllMGIyZDcuLmE0ZWZhODQg
MTAwNjQ0DQotLS0gYS9zb3VuZC9jb3JlL3BjbV9uYXRpdmUuYw0KKysrIGIvc291bmQvY29yZS9w
Y21fbmF0aXZlLmMNCkBAIC03NTYsNyArNzU2LDcgQEAgc3RhdGljIGludCBzbmRfcGNtX2h3X3Bh
cmFtcyhzdHJ1Y3Qgc25kX3BjbV9zdWJzdHJlYW0gKnN1YnN0cmVhbSwNCiANCiAJLyogY2xlYXIg
dGhlIGJ1ZmZlciBmb3IgYXZvaWRpbmcgcG9zc2libGUga2VybmVsIGluZm8gbGVha3MgKi8NCiAJ
aWYgKHJ1bnRpbWUtPmRtYV9hcmVhICYmICFzdWJzdHJlYW0tPm9wcy0+Y29weV91c2VyKQ0KLQkJ
bWVtc2V0KHJ1bnRpbWUtPmRtYV9hcmVhLCAwLCBydW50aW1lLT5kbWFfYnl0ZXMpOw0KKwkJbWVt
c2V0X2lvKHJ1bnRpbWUtPmRtYV9hcmVhLCAwLCBydW50aW1lLT5kbWFfYnl0ZXMpOw0KIA0KIAlz
bmRfcGNtX3RpbWVyX3Jlc29sdXRpb25fY2hhbmdlKHN1YnN0cmVhbSk7DQogCXNuZF9wY21fc2V0
X3N0YXRlKHN1YnN0cmVhbSwgU05EUlZfUENNX1NUQVRFX1NFVFVQKTsNCi0tIA0KMS43LjkuNQ0K


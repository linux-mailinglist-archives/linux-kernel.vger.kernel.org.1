Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7B5E282EE5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 04:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725888AbgJECkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Oct 2020 22:40:39 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:58291 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725845AbgJECkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Oct 2020 22:40:39 -0400
X-UUID: d754eb346f904c3a86eefd00914a9c3a-20201005
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=pg+khmuG6u6HusnQvdCtS6eE+aWPSmpAjaIW0MNmn6Y=;
        b=jbdD1eL6kZHasqBkAN8+Rdm7jPyWTvCLqQMFchUPG2wqDT4az4p7z1b2WoREDyq0WDTNnnQqO99+aESrVadtMRaeJX3QwDnFC1PVO8jZKAneeZmSdwTr0YjKoEdoMKhWu26nBa63iuCdrI7/Kc4Jds721bYfAwWeUbFd5GD2SLw=;
X-UUID: d754eb346f904c3a86eefd00914a9c3a-20201005
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <chinwen.chang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1586985325; Mon, 05 Oct 2020 10:40:36 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 5 Oct 2020 10:40:33 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 5 Oct 2020 10:40:33 +0800
From:   Chinwen Chang <chinwen.chang@mediatek.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Chinwen Chang <chinwen.chang@mediatek.com>
Subject: [RESEND, PATCH v4 1/3] mmap locking API: add mmap_lock_is_contended()
Date:   Mon, 5 Oct 2020 10:40:12 +0800
Message-ID: <1601865614-4918-2-git-send-email-chinwen.chang@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1601865614-4918-1-git-send-email-chinwen.chang@mediatek.com>
References: <1601865614-4918-1-git-send-email-chinwen.chang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: D30CA0596B5AD6F1FD606A51781A02C96D57DCE086B02B94315380DA50C8B9092000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIG5ldyBBUEkgdG8gcXVlcnkgaWYgc29tZW9uZSB3YW50cyB0byBhY3F1aXJlIG1tYXBfbG9j
aw0KZm9yIHdyaXRlIGF0dGVtcHRzLg0KDQpVc2luZyB0aGlzIGluc3RlYWQgb2YgcndzZW1faXNf
Y29udGVuZGVkIG1ha2VzIGl0IG1vcmUgdG9sZXJhbnQNCm9mIGZ1dHVyZSBjaGFuZ2VzIHRvIHRo
ZSBsb2NrIHR5cGUuDQoNCkNoYW5nZS1JZDogSWRiMjE0NzhiYjA1ODBiYTcyYjk5MjZhYmEzYmJj
NGIxZjc1ZGVlYzINClNpZ25lZC1vZmYtYnk6IENoaW53ZW4gQ2hhbmcgPGNoaW53ZW4uY2hhbmdA
bWVkaWF0ZWsuY29tPg0KUmV2aWV3ZWQtYnk6IFN0ZXZlbiBQcmljZSA8c3RldmVuLnByaWNlQGFy
bS5jb20+DQpBY2tlZC1ieTogTWljaGVsIExlc3BpbmFzc2UgPHdhbGtlbkBnb29nbGUuY29tPg0K
LS0tDQogaW5jbHVkZS9saW51eC9tbWFwX2xvY2suaCB8IDUgKysrKysNCiAxIGZpbGUgY2hhbmdl
ZCwgNSBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L21tYXBfbG9j
ay5oIGIvaW5jbHVkZS9saW51eC9tbWFwX2xvY2suaA0KaW5kZXggMDcwNzY3MS4uMThlN2VhZSAx
MDA2NDQNCi0tLSBhL2luY2x1ZGUvbGludXgvbW1hcF9sb2NrLmgNCisrKyBiL2luY2x1ZGUvbGlu
dXgvbW1hcF9sb2NrLmgNCkBAIC04Nyw0ICs4Nyw5IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBtbWFw
X2Fzc2VydF93cml0ZV9sb2NrZWQoc3RydWN0IG1tX3N0cnVjdCAqbW0pDQogCVZNX0JVR19PTl9N
TSghcndzZW1faXNfbG9ja2VkKCZtbS0+bW1hcF9sb2NrKSwgbW0pOw0KIH0NCiANCitzdGF0aWMg
aW5saW5lIGludCBtbWFwX2xvY2tfaXNfY29udGVuZGVkKHN0cnVjdCBtbV9zdHJ1Y3QgKm1tKQ0K
K3sNCisJcmV0dXJuIHJ3c2VtX2lzX2NvbnRlbmRlZCgmbW0tPm1tYXBfbG9jayk7DQorfQ0KKw0K
ICNlbmRpZiAvKiBfTElOVVhfTU1BUF9MT0NLX0ggKi8NCi0tIA0KMS45LjENCg==


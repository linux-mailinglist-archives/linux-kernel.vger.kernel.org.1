Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA41228F768
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 19:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390099AbgJORDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 13:03:07 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:43847 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2389893AbgJORDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 13:03:06 -0400
X-UUID: abc239abe2094d8e8bd9b9b6266d076d-20201016
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=G8rs2gCzhxbEma2709cmrK2Za0pKUpdbsxniLmNg3D8=;
        b=bxiaOgrZe1S1ZNAETuzinDmJmrNJIcokes+0Gt8pZj40msfYfT6fT2FZVkWh9K1tGkBhNWWUlQkiSJe2QAqDjlE/3xL/FmFJVkBBEuhLpa8thlG8hXxRaaVzDZeWaO1Ns5IIoyBgJkzUQTq3F2qF4u4dMHfl1n2PFxJGV3vJm04=;
X-UUID: abc239abe2094d8e8bd9b9b6266d076d-20201016
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <frankie.chang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1002238141; Fri, 16 Oct 2020 01:03:01 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 16 Oct 2020 01:02:58 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 16 Oct 2020 01:02:58 +0800
From:   Frankie Chang <Frankie.Chang@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Martijn Coenen <maco@android.com>,
        =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
        Christian Brauner <christian@brauner.io>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Jian-Min Liu <Jian-Min.Liu@mediatek.com>
Subject: [PATCH v10 3/3] binder: add transaction latency tracer
Date:   Fri, 16 Oct 2020 01:02:54 +0800
Message-ID: <1602781377-4278-1-git-send-email-Frankie.Chang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <20200916173845.GA3072065@kroah.com>
References: <20200916173845.GA3072065@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: AA346BA9F015F58D217AFA35FC30F4C5FE4712083E76C7D3ECDC1ED6BC4699A92000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Q2hhbmdlIGZyb20gdjEwOg0KICAtIHJlcGxhY2UgdGltZXNwZWM2NCB3aXRoIGt0aW1lX3QuDQog
IC0gZml4IGJ1aWxkIHdhcm5pbmcuDQoNCkNoYW5nZSBmcm9tIHY5Og0KICAtIHJlbmFtZSB0aW1l
c3RhbXAgdG8gdHMgaW4gYmluZGVyX2ludGVybmFsLmggZm9yIGNvbmNpc2VuZXNzLg0KICAtIGNo
YW5nZSB0aW1ldmFsIHRvIHRpbWVzcGVjNjQgaW4gYmluZGVyX2ludGVybmFsLmgNCg0KQ2hhbmdl
IGZyb20gdjg6DQogIC0gY2hhbmdlIHJ0Y190aW1lX3RvX3RtIHRvIHJ0Y190aW1lNjRfdG9fdG0u
DQogIC0gY2hhbmdlIHRpbWV2YWwgdG8gX19rZXJuZWxfb2xkX3RpbWV2YWwgZHVlIHRvIA0KICAg
IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRz
L2xpbnV4LmdpdC9jb21taXQvP2lkPWM3NjZkMTQ3MmM3MGQyNWFkNDc1Y2Y1NjA0MmFmMTY1MmU3
OTJiMjMNCiAgLSBleHBvcnQgdHJhY2Vwb2ludCBzeW1ib2wgZm9yIGJpbmRlcl90eG5fbGF0ZW5j
eV8qIHdoaWNoIGJpbmRlcl90cmFuc2FjdGlvbl9sYXRlbmN5X3RyYWNlciB0byBiZSBrbyBuZWVk
ZWQuDQoNCkNoYW5nZSBmcm9tIHY3Og0KICAtIFVzZSB0aGUgcGFzc2VkLWluIHZhbHVlcyBpbnN0
ZWFkIG9mIGFjY2Vzc2luZyB2aWEgdC0+ZnJvbS90b19wcm9jL3RvX3RocmVhZA0KICAgIGZvciB0
cmFjZV9iaW5kZXJfdHhuX2xhdGVuY3lfZnJlZSwgd2hlbiB0cmFjZV9iaW5kZXJfdHhuX2xhdGVu
Y3lfZnJlZV9lbmFibGUoKSByZXR1cm4gdHJ1ZS4NCiAgLSBtYWtlIGEgaGVscGVyIGZ1bmN0aW9u
IHRvIGRvIHRoZSBhYm92ZS4NCg0KQ2hhbmdlIGZyb20gdjY6DQogIC0gY2hhbmdlIENPTkZJR19C
SU5ERVJfVFJBTlNBQ1RJT05fTEFURU5DWV9UUkFDS0lORyB0eXBlIGZyb20gYm9vbCB0byB0cmlz
dGF0ZQ0KICAtIGFkZCBjb21tZW50cyB0byBAdGltZXN0YW1wIGFuZCBAdHYgdW5kZXIgc3RydWN0
IGJpbmRlcl90cmFuc2FjdGlvbg0KICAtIG1ha2UgYmluZGVyX3R4bl9sYXRlbmN5IHRocmVzaG9s
ZCBjb25maWd1cmFibGUNCiAgLSBlbmhhbmNlIGxvY2sgcHJvdGVjdGlvbg0KDQpDaGFuZ2UgZnJv
bSB2NToNCiAgLSBjaGFuZ2UgY29uZmlnIG5hbWUgdG8gdGhlIHByb3BlciBvbmUsIENPTkZJR19C
SU5ERVJfVFJBTlNBQ1RJT05fTEFURU5DWV9UUkFDS0lORy4NCiAgLSBjaGFuZ2UgdHJhY2Vwb2lu
dCBuYW1lIHRvIG1vcmUgZGVzY3JpcHRpdmUgb25lLCB0cmFjZV9iaW5kZXJfdHhuX2xhdGVuY3lf
KGFsbG9jfGluZm98ZnJlZSkNCiAgLSBlbmhhbmNlIHNvbWUgbG9jayBwcm90ZWN0aW9uLg0KDQpD
aGFuZ2UgZnJvbSB2NDoNCiAgLSBzcGxpdCB1cCBpbnRvIHBhdGNoIHNlcmllcy4NCg0KQ2hhbmdl
IGZyb20gdjM6DQogIC0gdXNlIHRyYWNlcG9pbnRzIGZvciBiaW5kZXJfdXBkYXRlX2luZm8gYW5k
IHByaW50X2JpbmRlcl90cmFuc2FjdGlvbl9leHQsDQogICAgaW5zdGVhZCBvZiBjdXN0b20gcmVn
aXN0cmF0aW9uIGZ1bmN0aW9ucy4NCg0KQ2hhbmdlIGZyb20gdjI6DQogIC0gY3JlYXRlIHRyYW5z
YWN0aW9uIGxhdGVuY3kgbW9kdWxlIHRvIG1vbml0b3Igc2xvdyB0cmFuc2FjdGlvbi4NCg0KQ2hh
bmdlIGZyb20gdjE6DQogIC0gZmlyc3QgcGF0Y2hzZXQuDQoNCg0KRnJhbmtpZS5DaGFuZyAoMyk6
DQogIGJpbmRlcjogbW92ZSBzdHJ1Y3RzIGZyb20gY29yZSBmaWxlIHRvIGhlYWRlciBmaWxlDQog
IGJpbmRlcjogYWRkIHRyYWNlIGF0IGZyZWUgdHJhbnNhY3Rpb24uDQogIGJpbmRlcjogYWRkIHRy
YW5zYWN0aW9uIGxhdGVuY3kgdHJhY2VyDQoNCiBkcml2ZXJzL2FuZHJvaWQvS2NvbmZpZyAgICAg
ICAgICAgICAgICAgfCAgIDggKw0KIGRyaXZlcnMvYW5kcm9pZC9NYWtlZmlsZSAgICAgICAgICAg
ICAgICB8ICAgMSArDQogZHJpdmVycy9hbmRyb2lkL2JpbmRlci5jICAgICAgICAgICAgICAgIHwg
NDMwICsrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KIGRyaXZlcnMvYW5kcm9pZC9iaW5kZXJfaW50
ZXJuYWwuaCAgICAgICB8IDQxOCArKysrKysrKysrKysrKysrKysrKysrKw0KIGRyaXZlcnMvYW5k
cm9pZC9iaW5kZXJfbGF0ZW5jeV90cmFjZXIuYyB8IDEwNyArKysrKysNCiBkcml2ZXJzL2FuZHJv
aWQvYmluZGVyX3RyYWNlLmggICAgICAgICAgfCAgNDkgKysrDQogNiBmaWxlcyBjaGFuZ2VkLCA2
MDcgaW5zZXJ0aW9ucygrKSwgNDA2IGRlbGV0aW9ucygtKSAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRy
aXZlcnMvYW5kcm9pZC9iaW5kZXJfbGF0ZW5jeV90cmFjZXIuYw==


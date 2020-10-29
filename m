Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73F7529F0CB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 17:09:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbgJ2QJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 12:09:18 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:58814 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725804AbgJ2QJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 12:09:18 -0400
X-UUID: 3e2fd9ffc93d4943bed5940f6515cf56-20201030
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=QAQNmhHtOheMU/ZFT0+MHH+Q18R1hfTiNfYbqOhng1M=;
        b=lTkT5sdcHubwnFcmh+Fct/4PN6oA8lWe/XTchWwIKNxELWGD4WZ3L09UaM9i/DHauwGa+3vniXqaIZmcap1au4a6dyddL8y5hF5wVfUsbm9N42c2hKA9Cta2e7XZJ2n5Nrg6rS+IQheqzOtb/DMQ+mlkhT6r2ia07r9OmxXVjto=;
X-UUID: 3e2fd9ffc93d4943bed5940f6515cf56-20201030
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <frankie.chang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1254586372; Fri, 30 Oct 2020 00:09:13 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 30 Oct 2020 00:09:08 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 30 Oct 2020 00:09:08 +0800
From:   Frankie Chang <Frankie.Chang@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Martijn Coenen <maco@android.com>,
        =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
        Christian Brauner <christian@brauner.io>,
        <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>,
        Jian-Min Liu <Jian-Min.Liu@mediatek.com>
Subject: binder: add transaction latency tracer
Date:   Fri, 30 Oct 2020 00:08:54 +0800
Message-ID: <1603987737-2763-1-git-send-email-Frankie.Chang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1602781377-4278-1-git-send-email-Frankie.Chang@mediatek.com>
References: <1602781377-4278-1-git-send-email-Frankie.Chang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Q2hhbmdlIGZyb20gdjExOg0KICAtIHJlYmFzZS4NCg0KQ2hhbmdlIGZyb20gdjEwOg0KICAtIHJl
cGxhY2UgdGltZXNwZWM2NCB3aXRoIGt0aW1lX3QuDQogIC0gZml4IGJ1aWxkIHdhcm5pbmcuDQoN
CkNoYW5nZSBmcm9tIHY5Og0KICAtIHJlbmFtZSB0aW1lc3RhbXAgdG8gdHMgaW4gYmluZGVyX2lu
dGVybmFsLmggZm9yIGNvbmNpc2VuZXNzLg0KICAtIGNoYW5nZSB0aW1ldmFsIHRvIHRpbWVzcGVj
NjQgaW4gYmluZGVyX2ludGVybmFsLmgNCg0KQ2hhbmdlIGZyb20gdjg6DQogIC0gY2hhbmdlIHJ0
Y190aW1lX3RvX3RtIHRvIHJ0Y190aW1lNjRfdG9fdG0uDQogIC0gY2hhbmdlIHRpbWV2YWwgdG8g
X19rZXJuZWxfb2xkX3RpbWV2YWwgZHVlIHRvIA0KICAgIGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcv
cHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4LmdpdC9jb21taXQvP2lkPWM3
NjZkMTQ3MmM3MGQyNWFkNDc1Y2Y1NjA0MmFmMTY1MmU3OTJiMjMNCiAgLSBleHBvcnQgdHJhY2Vw
b2ludCBzeW1ib2wgZm9yIGJpbmRlcl90eG5fbGF0ZW5jeV8qIHdoaWNoIGJpbmRlcl90cmFuc2Fj
dGlvbl9sYXRlbmN5X3RyYWNlciB0byBiZSBrbyBuZWVkZWQuDQoNCkNoYW5nZSBmcm9tIHY3Og0K
ICAtIFVzZSB0aGUgcGFzc2VkLWluIHZhbHVlcyBpbnN0ZWFkIG9mIGFjY2Vzc2luZyB2aWEgdC0+
ZnJvbS90b19wcm9jL3RvX3RocmVhZA0KICAgIGZvciB0cmFjZV9iaW5kZXJfdHhuX2xhdGVuY3lf
ZnJlZSwgd2hlbiB0cmFjZV9iaW5kZXJfdHhuX2xhdGVuY3lfZnJlZV9lbmFibGUoKSByZXR1cm4g
dHJ1ZS4NCiAgLSBtYWtlIGEgaGVscGVyIGZ1bmN0aW9uIHRvIGRvIHRoZSBhYm92ZS4NCg0KQ2hh
bmdlIGZyb20gdjY6DQogIC0gY2hhbmdlIENPTkZJR19CSU5ERVJfVFJBTlNBQ1RJT05fTEFURU5D
WV9UUkFDS0lORyB0eXBlIGZyb20gYm9vbCB0byB0cmlzdGF0ZQ0KICAtIGFkZCBjb21tZW50cyB0
byBAdGltZXN0YW1wIGFuZCBAdHYgdW5kZXIgc3RydWN0IGJpbmRlcl90cmFuc2FjdGlvbg0KICAt
IG1ha2UgYmluZGVyX3R4bl9sYXRlbmN5IHRocmVzaG9sZCBjb25maWd1cmFibGUNCiAgLSBlbmhh
bmNlIGxvY2sgcHJvdGVjdGlvbg0KDQpDaGFuZ2UgZnJvbSB2NToNCiAgLSBjaGFuZ2UgY29uZmln
IG5hbWUgdG8gdGhlIHByb3BlciBvbmUsIENPTkZJR19CSU5ERVJfVFJBTlNBQ1RJT05fTEFURU5D
WV9UUkFDS0lORy4NCiAgLSBjaGFuZ2UgdHJhY2Vwb2ludCBuYW1lIHRvIG1vcmUgZGVzY3JpcHRp
dmUgb25lLCB0cmFjZV9iaW5kZXJfdHhuX2xhdGVuY3lfKGFsbG9jfGluZm98ZnJlZSkNCiAgLSBl
bmhhbmNlIHNvbWUgbG9jayBwcm90ZWN0aW9uLg0KDQpDaGFuZ2UgZnJvbSB2NDoNCiAgLSBzcGxp
dCB1cCBpbnRvIHBhdGNoIHNlcmllcy4NCg0KQ2hhbmdlIGZyb20gdjM6DQogIC0gdXNlIHRyYWNl
cG9pbnRzIGZvciBiaW5kZXJfdXBkYXRlX2luZm8gYW5kIHByaW50X2JpbmRlcl90cmFuc2FjdGlv
bl9leHQsDQogICAgaW5zdGVhZCBvZiBjdXN0b20gcmVnaXN0cmF0aW9uIGZ1bmN0aW9ucy4NCg0K
Q2hhbmdlIGZyb20gdjI6DQogIC0gY3JlYXRlIHRyYW5zYWN0aW9uIGxhdGVuY3kgbW9kdWxlIHRv
IG1vbml0b3Igc2xvdyB0cmFuc2FjdGlvbi4NCg0KQ2hhbmdlIGZyb20gdjE6DQogIC0gZmlyc3Qg
cGF0Y2hzZXQuDQoNCg0KRnJhbmtpZS5DaGFuZyAoMyk6DQogIGJpbmRlcjogbW92ZSBzdHJ1Y3Rz
IGZyb20gY29yZSBmaWxlIHRvIGhlYWRlciBmaWxlDQogIGJpbmRlcjogYWRkIHRyYWNlIGF0IGZy
ZWUgdHJhbnNhY3Rpb24uDQogIGJpbmRlcjogYWRkIHRyYW5zYWN0aW9uIGxhdGVuY3kgdHJhY2Vy
DQoNCiBkcml2ZXJzL2FuZHJvaWQvS2NvbmZpZyAgICAgICAgICAgICAgICAgfCAgIDggKw0KIGRy
aXZlcnMvYW5kcm9pZC9NYWtlZmlsZSAgICAgICAgICAgICAgICB8ICAgMSArDQogZHJpdmVycy9h
bmRyb2lkL2JpbmRlci5jICAgICAgICAgICAgICAgIHwgNDMwICsrLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLQ0KIGRyaXZlcnMvYW5kcm9pZC9iaW5kZXJfaW50ZXJuYWwuaCAgICAgICB8IDQxOSArKysr
KysrKysrKysrKysrKysrKysrKw0KIGRyaXZlcnMvYW5kcm9pZC9iaW5kZXJfbGF0ZW5jeV90cmFj
ZXIuYyB8IDEwNyArKysrKysNCiBkcml2ZXJzL2FuZHJvaWQvYmluZGVyX3RyYWNlLmggICAgICAg
ICAgfCAgNDkgKysrDQogNiBmaWxlcyBjaGFuZ2VkLCA2MDggaW5zZXJ0aW9ucygrKSwgNDA2IGRl
bGV0aW9ucygtKQ0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2FuZHJvaWQvYmluZGVyX2xh
dGVuY3lfdHJhY2VyLmM=


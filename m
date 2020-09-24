Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69DAE27678D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 06:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbgIXEL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 00:11:59 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:47534 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726477AbgIXEL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 00:11:58 -0400
X-UUID: b2f4419533d24dd5a6cdbfe760e02c2e-20200924
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=kgEyV8GPi8LIdYi4bGI7Bw0WJs3ADwMNIObdnpyN9FA=;
        b=ZWXXixq7rSJUSraPKalbboCZ2cqPFkrDQGYHnAEn9+ewEcf0CdmtuG7f0Lpn79M6eyquXqhiU/JhfOYjBYDXLPqYVOuZ2SlGsaIX0QRF/3yOlohiR8ifiCNRn4HXhzIN0HyxVEZcx+WGUgzvSWokui2iiWDMfXkrmlydcEngxFA=;
X-UUID: b2f4419533d24dd5a6cdbfe760e02c2e-20200924
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1917049134; Thu, 24 Sep 2020 12:06:52 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 24 Sep 2020 12:06:49 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 24 Sep 2020 12:06:49 +0800
From:   Walter Wu <walter-zh.wu@mediatek.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Marco Elver <elver@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <kasan-dev@googlegroups.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        Walter Wu <walter-zh.wu@mediatek.com>
Subject: [PATCH v4 6/6] kasan: update documentation for generic kasan
Date:   Thu, 24 Sep 2020 12:06:49 +0800
Message-ID: <20200924040650.31221-1-walter-zh.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: CD7E561389D179394336201CEA174E7F8D7E06FE8F5E04C5B1D4AD0B5E80F0E02000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

R2VuZXJpYyBLQVNBTiBhbHNvIHN1cHBvcnRzIHRvIHJlY29yZCB0aGUgbGFzdCB0d28gdGltZXIg
YW5kIHdvcmtxdWV1ZQ0Kc3RhY2tzIGFuZCBwcmludCB0aGVtIGluIEtBU0FOIHJlcG9ydC4gU28g
dGhhdCBuZWVkIHRvIHVwZGF0ZQ0KZG9jdW1lbnRhdGlvbi4NCg0KU2lnbmVkLW9mZi1ieTogV2Fs
dGVyIFd1IDx3YWx0ZXItemgud3VAbWVkaWF0ZWsuY29tPg0KU3VnZ2VzdGVkLWJ5OiBNYXJjbyBF
bHZlciA8ZWx2ZXJAZ29vZ2xlLmNvbT4NCkFja2VkLWJ5OiBNYXJjbyBFbHZlciA8ZWx2ZXJAZ29v
Z2xlLmNvbT4NClJldmlld2VkLWJ5OiBEbWl0cnkgVnl1a292IDxkdnl1a292QGdvb2dsZS5jb20+
DQpSZXZpZXdlZC1ieTogQW5kcmV5IEtvbm92YWxvdiA8YW5kcmV5a252bEBnb29nbGUuY29tPg0K
Q2M6IEFuZHJleSBSeWFiaW5pbiA8YXJ5YWJpbmluQHZpcnR1b3p6by5jb20+DQpDYzogQWxleGFu
ZGVyIFBvdGFwZW5rbyA8Z2xpZGVyQGdvb2dsZS5jb20+DQpDYzogSm9uYXRoYW4gQ29yYmV0IDxj
b3JiZXRAbHduLm5ldD4NCi0tLQ0KDQp2MzoNCi0gVGhhbmtzIGZvciBNYXJjbyBzdWdnZXN0aW9u
DQoNCi0tLQ0KIERvY3VtZW50YXRpb24vZGV2LXRvb2xzL2thc2FuLnJzdCB8IDUgKysrLS0NCiAx
IGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0t
Z2l0IGEvRG9jdW1lbnRhdGlvbi9kZXYtdG9vbHMva2FzYW4ucnN0IGIvRG9jdW1lbnRhdGlvbi9k
ZXYtdG9vbHMva2FzYW4ucnN0DQppbmRleCAzOGZkNTY4MWZhZGUuLjY5OGNjYjY1ZTYzNCAxMDA2
NDQNCi0tLSBhL0RvY3VtZW50YXRpb24vZGV2LXRvb2xzL2thc2FuLnJzdA0KKysrIGIvRG9jdW1l
bnRhdGlvbi9kZXYtdG9vbHMva2FzYW4ucnN0DQpAQCAtMTkwLDggKzE5MCw5IEBAIGZ1bmN0aW9u
IGNhbGxzIEdDQyBkaXJlY3RseSBpbnNlcnRzIHRoZSBjb2RlIHRvIGNoZWNrIHRoZSBzaGFkb3cg
bWVtb3J5Lg0KIFRoaXMgb3B0aW9uIHNpZ25pZmljYW50bHkgZW5sYXJnZXMga2VybmVsIGJ1dCBp
dCBnaXZlcyB4MS4xLXgyIHBlcmZvcm1hbmNlDQogYm9vc3Qgb3ZlciBvdXRsaW5lIGluc3RydW1l
bnRlZCBrZXJuZWwuDQogDQotR2VuZXJpYyBLQVNBTiBwcmludHMgdXAgdG8gMiBjYWxsX3JjdSgp
IGNhbGwgc3RhY2tzIGluIHJlcG9ydHMsIHRoZSBsYXN0IG9uZQ0KLWFuZCB0aGUgc2Vjb25kIHRv
IGxhc3QuDQorR2VuZXJpYyBLQVNBTiBhbHNvIHJlcG9ydHMgdGhlIGxhc3QgMiBjYWxsIHN0YWNr
cyB0byBjcmVhdGlvbiBvZiB3b3JrIHRoYXQNCitwb3RlbnRpYWxseSBoYXMgYWNjZXNzIHRvIGFu
IG9iamVjdC4gQ2FsbCBzdGFja3MgZm9yIHRoZSBmb2xsb3dpbmcgYXJlIHNob3duOg0KK2NhbGxf
cmN1KCksIHRpbWVyIGFuZCB3b3JrcXVldWUgcXVldWluZy4NCiANCiBTb2Z0d2FyZSB0YWctYmFz
ZWQgS0FTQU4NCiB+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4NCi0tIA0KMi4xOC4wDQo=


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D37F27DE75
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 04:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729881AbgI3CWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 22:22:20 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:46604 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726689AbgI3CWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 22:22:09 -0400
X-UUID: e2a1b0067cf5458cbda2c768b1c566b6-20200930
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=JX7akOCDOz/KF/q9+MC39vGN4lTkjsgc3qGvCIP0NBE=;
        b=QojONukuqLYXzyZcFl8w7lN/UQO555tm9MOJlq7adBQZeSnMh8glX16ywwBAkMPmtEAy4WdmW2UOHJ4P+w4qs+1e4gXT2COoiRyEmd2J8iDJ5+RpQ1pkeQDAw71bDwwr93j/crv9swh9a4TRF2OGW3O/y41JE7bLZfThNCG9S6c=;
X-UUID: e2a1b0067cf5458cbda2c768b1c566b6-20200930
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <crystal.guo@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1755378119; Wed, 30 Sep 2020 10:22:02 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 30 Sep 2020 10:22:02 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 30 Sep 2020 10:22:01 +0800
From:   Crystal Guo <crystal.guo@mediatek.com>
To:     <p.zabel@pengutronix.de>, <robh+dt@kernel.org>,
        <matthias.bgg@gmail.com>
CC:     <srv_heupstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <s-anna@ti.com>, <seiya.wang@mediatek.com>,
        <stanley.chu@mediatek.com>, <yingjoe.chen@mediatek.com>,
        <fan.chen@mediatek.com>, <yong.liang@mediatek.com>
Subject: [v6,0/3] introduce TI reset controller for MT8192 SoC
Date:   Wed, 30 Sep 2020 10:21:56 +0800
Message-ID: <20200930022159.5559-1-crystal.guo@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

djY6DQpmaXggdGhlIGZvcm1hdCBlcnJvciBvZiBtZWRpYXRlay1zeXNjb24tcmVzZXQueWFtbA0K
DQp2NToNCjEuIHJldmVydCB0aS1zeXNjb24tcmVzZXQudHh0LCBhbmQgYWRkIGEgbmV3IG1lZGlh
dGVrIHJlc2V0IGJpbmRpbmcuDQoyLiBzcGxpdCB0aGUgcGF0Y2ggW3Y0LCAzLzRdIHdpdGggdGhl
IGNoYW5nZSB0byBmb3JjZSB3cml0ZSBhbmQgdGhlDQpjaGFuZ2UgdG8gaW50ZWdyYXRlIGFzc2Vy
dCBhbmQgZGVhc3NlcnQgdG9nZXRoZXIuDQozLiBzZXBhcmF0ZSB0aGUgZHRzIHBhdGNoIGZyb20g
dGhpcyBwYXRjaCBzZXRzDQoNCnY0Og0KZml4IHR5cG9zIG9uIHYzIGNvbW1pdCBtZXNzYWdlLg0K
DQp2MzoNCjEuIHJldmVydCB2MiBjaGFuZ2VzLg0KMi4gYWRkICdyZXNldC1kdXJhdGlvbi11cycg
cHJvcGVydHkgdG8gZGVjbGFyZSBhIG1pbmltdW0gZGVsYXksDQp3aGljaCBuZWVkcyB0byBiZSB3
YWl0ZWQgYmV0d2VlbiBhc3NlcnQgYW5kIGRlYXNzZXJ0Lg0KMy4gYWRkICdtZWRpYXRlayxpbmZy
YS1yZXNldCcgdG8gY29tcGF0aWJsZS4NCg0KdjIgY2hhbmdlczoNCmh0dHBzOi8vcGF0Y2h3b3Jr
Lmtlcm5lbC5vcmcvcGF0Y2gvMTE2OTczNzEvDQoxLiBhZGQgJ2Fzc2VydC1kZWFzc2VydC10b2dl
dGhlcicgcHJvcGVydHkgdG8gaW50cm9kdWNlIGEgbmV3IHJlc2V0IGhhbmRsZXIsDQp3aGljaCBh
bGxvd3MgZGV2aWNlIHRvIGRvIHNlcmlhbGl6ZWQgYXNzZXJ0IGFuZCBkZWFzc2VydCBvcGVyYXRp
b25zIGluIGEgc2luZ2xlDQpzdGVwIGJ5ICdyZXNldCcgbWV0aG9kLg0KMi4gYWRkICd1cGRhdGUt
Zm9yY2UnIHByb3BlcnR5IHRvIGludHJvZHVjZSBmb3JjZS11cGRhdGUgbWV0aG9kLCB3aGljaCBm
b3JjZXMNCnRoZSB3cml0ZSBvcGVyYXRpb24gaW4gY2FzZSB0aGUgcmVhZCBhbHJlYWR5IGhhcHBl
bnMgdG8gcmV0dXJuIHRoZSBjb3JyZWN0IHZhbHVlLg0KMy4gYWRkICdnZW5lcmljLXJlc2V0JyB0
byBjb21wYXRpYmxlDQoNCnYxIGNoYW5nZXM6DQpodHRwczovL3BhdGNod29yay5rZXJuZWwub3Jn
L3BhdGNoLzExNjkwNTIzLw0KaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wYXRjaC8xMTY5
MDUyNy8NCg0KQ3J5c3RhbCBHdW8gKDMpOg0KICBkdC1iaW5kaW5nOiByZXNldC1jb250cm9sbGVy
OiBtZWRpYXRlazogYWRkIFlBTUwgc2NoZW1hcw0KICByZXNldC1jb250cm9sbGVyOiB0aTogaW50
cm9kdWNlIGEgbmV3IHJlc2V0IGhhbmRsZXINCiAgcmVzZXQtY29udHJvbGxlcjogdGk6IGZvcmNl
IHRoZSB3cml0ZSBvcGVyYXRpb24gd2hlbiBhc3NlcnQgb3INCiAgICBkZWFzc2VydA0KDQogLi4u
L2JpbmRpbmdzL3Jlc2V0L21lZGlhdGVrLXN5c2Nvbi1yZXNldC55YW1sIHwgNTEgKysrKysrKysr
KysrKysrKysrKw0KIGRyaXZlcnMvcmVzZXQvcmVzZXQtdGktc3lzY29uLmMgICAgICAgICAgICAg
ICB8IDQ0ICsrKysrKysrKysrKysrLS0NCiAyIGZpbGVzIGNoYW5nZWQsIDkyIGluc2VydGlvbnMo
KyksIDMgZGVsZXRpb25zKC0pDQogY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9yZXNldC9tZWRpYXRlay1zeXNjb24tcmVzZXQueWFtbA0KDQoNCg==


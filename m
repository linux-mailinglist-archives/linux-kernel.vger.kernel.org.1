Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C992B292677
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 13:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728066AbgJSLhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 07:37:52 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:48619 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727952AbgJSLhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 07:37:42 -0400
X-UUID: 3db162901111401a8f74db9575dd5f25-20201019
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=m4LDAjGaY8ZCZimbpy7YBlmQc5CdSDMgpYOZp0zaqTc=;
        b=cSbnUDvcoLIIqhDkrICSDc8v54KNFL66XfhvlGZNctQUuuwgCqHAaVXfM7T9H1BKoCh2e5Cq8vcWPBvaSfbDPbuS5iUZ/Nm4RrAvIsIAs8c/oQ/jcWTaZ+JD999vPfbmOZjP8rXReuz1Zu4n2axQLu4DAIeWu53APFnH5PO4YJ4=;
X-UUID: 3db162901111401a8f74db9575dd5f25-20201019
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <chao.hao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1349989347; Mon, 19 Oct 2020 19:37:40 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 19 Oct 2020 19:37:37 +0800
Received: from localhost.localdomain (10.15.20.246) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 19 Oct 2020 19:37:36 +0800
From:   Chao Hao <chao.hao@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Yong Wu <yong.wu@mediatek.com>, FY Yang <fy.yang@mediatek.com>,
        Jun Wen <jun.wen@mediatek.com>,
        Mingyuan Ma <mingyuan.ma@mediatek.com>,
        Chao Hao <chao.hao@mediatek.com>
Subject: [PATCH 4/4] iommu/mediatek: Adjust iotlb_sync_range
Date:   Mon, 19 Oct 2020 19:31:00 +0800
Message-ID: <20201019113100.23661-5-chao.hao@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201019113100.23661-1-chao.hao@mediatek.com>
References: <20201019113100.23661-1-chao.hao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 45005679F3403F0A13FD86D253488C445AA63407230CD27F27E3DC72213A2D4D2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QXMgaXMgdGl0bGUsIHRoZSBwYXRjaCBvbmx5IGFkanVzdHMgdGhlIGFyY2hpdGVjdHVyZSBvZg0K
aW90bGJfc3luY19yYW5nZSgpLg0KDQpObyBmdW5jdGlvbmFsIGNoYW5nZS4NCg0KU2lnbmVkLW9m
Zi1ieTogQ2hhbyBIYW8gPGNoYW8uaGFvQG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGRyaXZlcnMvaW9t
bXUvbXRrX2lvbW11LmMgfCAxNCArKysrLS0tLS0tLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCA0IGlu
c2VydGlvbnMoKyksIDEwIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21t
dS9tdGtfaW9tbXUuYyBiL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMNCmluZGV4IGJjYTFmNTNj
MGFiOS4uNjZlNWI5ZDNjNTc1IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUu
Yw0KKysrIGIvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYw0KQEAgLTE5MSwxMCArMTkxLDkgQEAg
c3RhdGljIHZvaWQgbXRrX2lvbW11X3RsYl9mbHVzaF9hbGwodm9pZCAqY29va2llKQ0KIAl9DQog
fQ0KIA0KLXN0YXRpYyB2b2lkIG10a19pb21tdV90bGJfZmx1c2hfcmFuZ2Vfc3luYyh1bnNpZ25l
ZCBsb25nIGlvdmEsIHNpemVfdCBzaXplLA0KLQkJCQkJICAgc2l6ZV90IGdyYW51bGUsIHZvaWQg
KmNvb2tpZSkNCitzdGF0aWMgdm9pZCBtdGtfaW9tbXVfdGxiX2ZsdXNoX3JhbmdlX3N5bmModW5z
aWduZWQgbG9uZyBpb3ZhLCBzaXplX3Qgc2l6ZSkNCiB7DQotCXN0cnVjdCBtdGtfaW9tbXVfZGF0
YSAqZGF0YSA9IGNvb2tpZTsNCisJc3RydWN0IG10a19pb21tdV9kYXRhICpkYXRhOw0KIAl1bnNp
Z25lZCBsb25nIGZsYWdzOw0KIAlpbnQgcmV0Ow0KIAl1MzIgdG1wOw0KQEAgLTIxNiw3ICsyMTUs
NyBAQCBzdGF0aWMgdm9pZCBtdGtfaW9tbXVfdGxiX2ZsdXNoX3JhbmdlX3N5bmModW5zaWduZWQg
bG9uZyBpb3ZhLCBzaXplX3Qgc2l6ZSwNCiAJCWlmIChyZXQpIHsNCiAJCQlkZXZfd2FybihkYXRh
LT5kZXYsDQogCQkJCSAiUGFydGlhbCBUTEIgZmx1c2ggdGltZWQgb3V0LCBmYWxsaW5nIGJhY2sg
dG8gZnVsbCBmbHVzaFxuIik7DQotCQkJbXRrX2lvbW11X3RsYl9mbHVzaF9hbGwoY29va2llKTsN
CisJCQltdGtfaW9tbXVfdGxiX2ZsdXNoX2FsbChkYXRhKTsNCiAJCX0NCiAJCS8qIENsZWFyIHRo
ZSBDUEUgc3RhdHVzICovDQogCQl3cml0ZWxfcmVsYXhlZCgwLCBkYXRhLT5iYXNlICsgUkVHX01N
VV9DUEVfRE9ORSk7DQpAQCAtMjI0LDExICsyMjMsNiBAQCBzdGF0aWMgdm9pZCBtdGtfaW9tbXVf
dGxiX2ZsdXNoX3JhbmdlX3N5bmModW5zaWduZWQgbG9uZyBpb3ZhLCBzaXplX3Qgc2l6ZSwNCiAJ
fQ0KIH0NCiANCi1zdGF0aWMgdm9pZCBfX210a19pb21tdV90bGJfZmx1c2hfcmFuZ2Vfc3luYyh1
bnNpZ25lZCBsb25nIGlvdmEsIHNpemVfdCBzaXplKQ0KLXsNCi0JbXRrX2lvbW11X3RsYl9mbHVz
aF9yYW5nZV9zeW5jKGlvdmEsIHNpemUsIDAsIE5VTEwpDQotfQ0KLQ0KIHN0YXRpYyB2b2lkIG10
a19pb21tdV90bGJfZmx1c2hfc2tpcCh1bnNpZ25lZCBsb25nIGlvdmEsIHNpemVfdCBzaXplLA0K
IAkJCQkgICAgIHNpemVfdCBncmFudWxlLCB2b2lkICpjb29raWUpDQogew0KQEAgLTUyMiw3ICs1
MTYsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGlvbW11X29wcyBtdGtfaW9tbXVfb3BzID0gew0K
IAkubWFwCQk9IG10a19pb21tdV9tYXAsDQogCS51bm1hcAkJPSBtdGtfaW9tbXVfdW5tYXAsDQog
CS5mbHVzaF9pb3RsYl9hbGwgPSBtdGtfaW9tbXVfZmx1c2hfaW90bGJfYWxsLA0KLQkuaW90bGJf
c3luY19yYW5nZSA9IF9fbXRrX2lvbW11X3RsYl9mbHVzaF9yYW5nZV9zeW5jLA0KKwkuaW90bGJf
c3luY19yYW5nZSA9IG10a19pb21tdV90bGJfZmx1c2hfcmFuZ2Vfc3luYywNCiAJLmlvdmFfdG9f
cGh5cwk9IG10a19pb21tdV9pb3ZhX3RvX3BoeXMsDQogCS5wcm9iZV9kZXZpY2UJPSBtdGtfaW9t
bXVfcHJvYmVfZGV2aWNlLA0KIAkucmVsZWFzZV9kZXZpY2UJPSBtdGtfaW9tbXVfcmVsZWFzZV9k
ZXZpY2UsDQotLSANCjIuMTguMA0K


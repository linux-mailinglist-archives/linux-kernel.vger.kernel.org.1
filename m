Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDBA927801D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 08:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbgIYGBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 02:01:38 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:55139 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727183AbgIYGBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 02:01:30 -0400
X-UUID: fc13d7b47f2b48e795fb4116b55c3814-20200925
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=jJl4c1HMfg7jGvuvY2b59qJO8Tc6LdTsiL4Lq7k7/+c=;
        b=Yf6WifkQpRCcXcJllqomANn54aIjkUTBZ3k8eOD8pzW1hKkjC+H93ODO0EbhR9YI5VhhACwrxJGMvKbV2kGl7Vw+y/KVlVZCu3z2qa5LBLpwLhQlFwwLFRFLBGhJuElKSOotB+QZdaoa5g8gf9T5QFxHfneP9ctEcS/4yP8HWaU=;
X-UUID: fc13d7b47f2b48e795fb4116b55c3814-20200925
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 980980003; Fri, 25 Sep 2020 14:01:21 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 25 Sep 2020 14:01:19 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 25 Sep 2020 14:01:19 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Felipe Balbi <balbi@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Al Cooper <alcooperx@gmail.com>,
        Sasi Kumar <sasi.kumar@broadcom.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH 04/11] usb: gadget: bdc: fix warning of embedded function name
Date:   Fri, 25 Sep 2020 13:58:12 +0800
Message-ID: <1601013499-28920-4-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1601013499-28920-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1601013499-28920-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: FA747E64B343E8CA9CAD24E94226DD4E3A93C234BF70BA300271D8535912AE982000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VXNlICciJXMuLi4iLCBfX2Z1bmNfXycgdG8gcmVwbGFjZSBlbWJlZGRlZCBmdW5jdGlvbiBuYW1l
DQoNCkNoYW5nZS1JZDogSTUyZWRiY2NmMWFkNmU1M2RmOTc4NThhNWMxZjFmOTE4NDYwMzdhYWMN
CkNjOiBGbG9yaWFuIEZhaW5lbGxpIDxmLmZhaW5lbGxpQGdtYWlsLmNvbT4NClNpZ25lZC1vZmYt
Ynk6IENodW5mZW5nIFl1biA8Y2h1bmZlbmcueXVuQG1lZGlhdGVrLmNvbT4NCkFja2VkLWJ5OiBG
bG9yaWFuIEZhaW5lbGxpIDxmLmZhaW5lbGxpQGdtYWlsLmNvbT4NCi0tLQ0KIGRyaXZlcnMvdXNi
L2dhZGdldC91ZGMvYmRjL2JkY19kYmcuYyB8IDIgKy0NCiBkcml2ZXJzL3VzYi9nYWRnZXQvdWRj
L2JkYy9iZGNfZXAuYyAgfCA2ICsrKy0tLQ0KIDIgZmlsZXMgY2hhbmdlZCwgNCBpbnNlcnRpb25z
KCspLCA0IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZ2FkZ2V0L3Vk
Yy9iZGMvYmRjX2RiZy5jIGIvZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9iZGMvYmRjX2RiZy5jDQpp
bmRleCA3YmE3NDQ4Li45YzAzZTEzIDEwMDY0NA0KLS0tIGEvZHJpdmVycy91c2IvZ2FkZ2V0L3Vk
Yy9iZGMvYmRjX2RiZy5jDQorKysgYi9kcml2ZXJzL3VzYi9nYWRnZXQvdWRjL2JkYy9iZGNfZGJn
LmMNCkBAIC02OCw3ICs2OCw3IEBAIHZvaWQgYmRjX2RiZ19zcnIoc3RydWN0IGJkYyAqYmRjLCB1
MzIgc3JyX251bSkNCiANCiAJc3IgPSBiZGMtPnNyci5zcl9iZHM7DQogCWFkZHIgPSBiZGMtPnNy
ci5kbWFfYWRkcjsNCi0JZGV2X3ZkYmcoYmRjLT5kZXYsICJiZGNfZGJnX3NyciBzcjolcCBkcXBf
aW5kZXg6JWRcbiIsDQorCWRldl92ZGJnKGJkYy0+ZGV2LCAiJXMgc3I6JXAgZHFwX2luZGV4OiVk
XG4iLCBfX2Z1bmNfXywNCiAJCQkJCQlzciwgYmRjLT5zcnIuZHFwX2luZGV4KTsNCiAJZm9yIChp
ID0gMDsgaSA8IE5VTV9TUl9FTlRSSUVTOyBpKyspIHsNCiAJCXNyID0gJmJkYy0+c3JyLnNyX2Jk
c1tpXTsNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9nYWRnZXQvdWRjL2JkYy9iZGNfZXAuYyBi
L2RyaXZlcnMvdXNiL2dhZGdldC91ZGMvYmRjL2JkY19lcC5jDQppbmRleCA3NjQ2M2RlLi40NGYz
YTEyIDEwMDY0NA0KLS0tIGEvZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9iZGMvYmRjX2VwLmMNCisr
KyBiL2RyaXZlcnMvdXNiL2dhZGdldC91ZGMvYmRjL2JkY19lcC5jDQpAQCAtNzU2LDcgKzc1Niw3
IEBAIHN0YXRpYyBpbnQgZXBfZGVxdWV1ZShzdHJ1Y3QgYmRjX2VwICplcCwgc3RydWN0IGJkY19y
ZXEgKnJlcSkNCiANCiAJZGV2X2RiZyhiZGMtPmRldiwgIiVzIGVwOiVzIHN0YXJ0OiVkIGVuZDol
ZFxuIiwNCiAJCQkJCV9fZnVuY19fLCBlcC0+bmFtZSwgc3RhcnRfYmRpLCBlbmRfYmRpKTsNCi0J
ZGV2X2RiZyhiZGMtPmRldiwgImVwX2RlcXVldWUgZXA9JXAgZXAtPmRlc2M9JXBcbiIsDQorCWRl
dl9kYmcoYmRjLT5kZXYsICIlcyBlcD0lcCBlcC0+ZGVzYz0lcFxuIiwgX19mdW5jX18sDQogCQkJ
CQkJZXAsICh2b2lkICopZXAtPnVzYl9lcC5kZXNjKTsNCiAJLyogaWYgc3RpbGwgY29ubmVjdGVk
LCBzdG9wIHRoZSBlcCB0byBzZWUgd2hlcmUgdGhlIEhXIGlzID8gKi8NCiAJaWYgKCEoYmRjX3Jl
YWRsKGJkYy0+cmVncywgQkRDX1VTUEMpICYgQkRDX1BTVF9NQVNLKSkgew0KQEAgLTE4NTgsMTIg
KzE4NTgsMTIgQEAgc3RhdGljIGludCBiZGNfZ2FkZ2V0X2VwX2VuYWJsZShzdHJ1Y3QgdXNiX2Vw
ICpfZXAsDQogCWludCByZXQ7DQogDQogCWlmICghX2VwIHx8ICFkZXNjIHx8IGRlc2MtPmJEZXNj
cmlwdG9yVHlwZSAhPSBVU0JfRFRfRU5EUE9JTlQpIHsNCi0JCXByX2RlYnVnKCJiZGNfZ2FkZ2V0
X2VwX2VuYWJsZSBpbnZhbGlkIHBhcmFtZXRlcnNcbiIpOw0KKwkJcHJfZGVidWcoIiVzIGludmFs
aWQgcGFyYW1ldGVyc1xuIiwgX19mdW5jX18pOw0KIAkJcmV0dXJuIC1FSU5WQUw7DQogCX0NCiAN
CiAJaWYgKCFkZXNjLT53TWF4UGFja2V0U2l6ZSkgew0KLQkJcHJfZGVidWcoImJkY19nYWRnZXRf
ZXBfZW5hYmxlIG1pc3Npbmcgd01heFBhY2tldFNpemVcbiIpOw0KKwkJcHJfZGVidWcoIiVzIG1p
c3Npbmcgd01heFBhY2tldFNpemVcbiIsIF9fZnVuY19fKTsNCiAJCXJldHVybiAtRUlOVkFMOw0K
IAl9DQogDQotLSANCjEuOC4xLjEuZGlydHkNCg==


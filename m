Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A92EB296BE8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 11:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S461276AbgJWJPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 05:15:00 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:47696 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S461268AbgJWJO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 05:14:59 -0400
X-UUID: 800adff8558c42e58f8c1a4d18b40f97-20201023
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=2dEcXHhZj8uprz2I0uMtY19UYwJ6GtAv+ROdYVdiy4w=;
        b=oobJNg6CVASSBxsJH3+zrVLUTGumuVLl653SOnqBf4fI26b0N4vcHbQ6C4SPfdYH6jHI2SPSAvylHFFUNds3JdtBPGip8wMkVN/OmPF5FF4zrb7Um9K/I+U0ffEQlAlYxb6FNudZZs7975PTYn1tDxGG16eDAVYgbueYO4Mhf1E=;
X-UUID: 800adff8558c42e58f8c1a4d18b40f97-20201023
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1271865938; Fri, 23 Oct 2020 17:14:54 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 23 Oct 2020 17:14:51 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 23 Oct 2020 17:14:51 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Minchan Kim <minchan@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>
Subject: [PATCH v2 0/4] arm: support get_user_pages_fast
Date:   Fri, 23 Oct 2020 17:14:33 +0800
Message-ID: <20201023091437.8225-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: CA7FBCC7665B3CF7C9682EE1888B128867151BADC38FBCA27B3B4FD1D749640C2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Z2V0X3VzZXJfcGFnZXNfZmFzdCBoZWxwcyBhcHAncyBsYXVuY2hpbmcgdGltZSBiZWNhdXNlIGl0
IGNvdWxkIHJlZHVjZQ0KbW1hcF9zZW0gbG9jayBjb250ZW50aW9ucyB3aGVuIGFwcCBpcyBsYXVu
Y2hpbmcuDQoNCk1pbmNoYW4gcG9zdGVkIGEgUkZDIHBhdGNoIGFuZCBwYXRjaCB2MSBbMV0gaW4g
MjAxOCBhbmQgY3VycmVudGx5IGhlIGhhcyBubw0KYmFuZHdpZHRoIHRvIHJld29yayB0aGlzIHBh
dGNoLCBzbyBJIHJlYmFzZSBNaW5jaGFuJ3MgcGF0Y2gNCihhcm06IHN1cHBvcnQgZ2V0X3VzZXJf
cGFnZXNfZmFzdCkgYW5kIG1vZGlmeSB0aGUgcGF0Y2ggYWNjb3JkaW5nDQp0byBDYXRhbGluJ3Mg
Y29tbWVudCBhbmQgcmUtcG9zdCB0aGlzIHBhdGNoLg0KDQpGaXJzdCwgdG8gdXNlIGdlbmVyaWMg
Z2V0X3VzZXJfcGFnZXNfZmFzdCBjb2RlLCB1c2Ugc3RyaWN0IG1tIHR5cGUgaW4NCnBndGFibGUt
MmxldmVsLXR5cGVzLg0KDQoybmQgcGF0Y2g6IHJlb3JkZXIgbWVtb3J5IHR5cGUgdGFibGUgdG8g
dXNlIDV0aCBiaXQgb2YgdGhlIHBhZ2UgdGFibGUNCg0KM3JkIHBhdGNoOiBpbnRyb2R1Y2VzIExf
UFRFX1NQRUNJQUwgZm9yIGFybSBzbyB0aGF0IGxhc3QgcGF0Y2ggY2FuDQpzdXBwb3J0IGdldF91
c2VyX3BhZ3NfZmFzdC4NCg0KNHRoIHBhdGNoOiByZW1vdmUgTF9QVEVfTVRfVkVDVE9SUyBhbmQg
dXNlIHJlYWQtb25seSB0eXBlLg0KDQoNClsxXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9wYXRj
aHdvcmsvY292ZXIvOTg2NTczLw0KDQpDaGFuZ2Ugc2luY2UgdjE6DQoqIG1vZGlmeSBjb21tZW50
DQoqIHJlbW92ZSBMX1BURV9NVF9WRUNUT1JTIGFuZCB1c2UgcmVhZC1vbmx5IHR5cGUgDQoNCkNo
YW5nZSBzaW5jZSBSRkM6DQoqIFJlbW92ZSBDUFVfdjdNIC0gQ2F0YWxpbg0KKiBkZWZpbmUgREVW
X05PTlNIQVJFRCB0byBTSEFSRUQgLSBDYXRhbGluDQoqIGh0dHBzOi8vbGttbC5rZXJuZWwub3Jn
L3IvMjAxODA5MTAxNjUwMTEuemNpZ2h5dWFic2hzbXhqYkBhcm1hZ2VkZG9uLmNhbWJyaWRnZS5h
cm0uY29tDQoNCg0KTWlsZXMgQ2hlbiAoMik6DQogIGFybTogbW06IHVzZSBzdHJpY3QgcFtndW1d
ZCB0eXBlcw0KICBhcm06IHJlcGxhY2UgdmVjdG9yIG1lbSB0eXBlIHdpdGggcmVhZC1vbmx5IHR5
cGUNCg0KTWluY2hhbiBLaW0gKDIpOg0KICBhcm06IG1tOiByZW9yZGVyaW5nIG1lbW9yeSB0eXBl
IHRhYmxlDQogIGFybTogbW06IGludHJvZHVjZSBMX1BURV9TUEVDSUFMDQoNCiBhcmNoL2FybS9L
Y29uZmlnICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDQgKystLQ0KIGFyY2gvYXJtL2lu
Y2x1ZGUvYXNtL2ZpeG1hcC5oICAgICAgICAgICAgICAgfCAgNiArKy0tLQ0KIGFyY2gvYXJtL2lu
Y2x1ZGUvYXNtL3BndGFibGUtMmxldmVsLXR5cGVzLmggfCAyNiAtLS0tLS0tLS0tLS0tLS0tLS0t
LS0NCiBhcmNoL2FybS9pbmNsdWRlL2FzbS9wZ3RhYmxlLTJsZXZlbC5oICAgICAgIHwgMjIgKysr
KysrKysrKysrKy0tLS0NCiBhcmNoL2FybS9pbmNsdWRlL2FzbS9wZ3RhYmxlLTNsZXZlbC5oICAg
ICAgIHwgIDYgLS0tLS0NCiBhcmNoL2FybS9pbmNsdWRlL2FzbS9wZ3RhYmxlLmggICAgICAgICAg
ICAgIHwgMTMgKysrKysrKysrKysNCiBhcmNoL2FybS9tbS9tbXUuYyAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHwgIDcgKysrLS0tDQogYXJjaC9hcm0vbW0vcHJvYy1tYWNyb3MuUyAgICAgICAg
ICAgICAgICAgICB8ICAyICstDQogOCBmaWxlcyBjaGFuZ2VkLCA0MCBpbnNlcnRpb25zKCspLCA0
NiBkZWxldGlvbnMoLSkNCg0K


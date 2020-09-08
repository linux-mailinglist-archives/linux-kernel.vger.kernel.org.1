Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBF86262022
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Sep 2020 22:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731677AbgIHUJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Sep 2020 16:09:53 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:4303 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729457AbgIHPSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:18:37 -0400
X-UUID: 51970f2d630042fabf15de668d72185e-20200908
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=ZedMZfUFgLvexz8GKyj+hsZdPazQ9EjrZfeYaT0ZaBc=;
        b=h7N4rGvPg3n4HrBGWAOOsN+Y5SXtHE+F+IhfvmOdQ45i60texspG7e/jP7W7Vod49lsgfaTq9VXBFo24W8gPR+W7MMYF5bdB9ZnHGAfDTNrLYeiYO+ZlYCK/2R/ZcVPADF1mHnUYTkXAqhrdBnzK8/oA+yA2CPc3c9ips0asMfg=;
X-UUID: 51970f2d630042fabf15de668d72185e-20200908
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <fengping.yu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1609223649; Tue, 08 Sep 2020 20:08:27 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 8 Sep 2020 20:08:24 +0800
Received: from localhost.localdomain (10.15.20.246) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 8 Sep 2020 20:08:23 +0800
From:   Fengping Yu <fengping.yu@mediatek.com>
To:     Yingjoe Chen <yingjoe.chen@mediatek.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-input@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v18] Add matrix keypad driver support for Mediatek SoCs 
Date:   Tue, 8 Sep 2020 20:03:46 +0800
Message-ID: <20200908120349.1685-1-fengping.yu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpDaGFuZ2Ugc2luY2UgdjE3Og0KLSBtb2RpZnkgaG93IHRvIGdldCBrZXljb2RlIGluIGtleXBh
ZCBpbnRlcnJ1cHQgaGFuZGxlcg0KLSByZXBsYWNlIHZhcmlhYmxlIHJldCBhcyBlcnJvciBpbiBw
cm9iZSBmdW5jdGlvbg0KLSB1cGRhdGUga2V5cGFkLCBudW0tY29sdW1ucyBhbmQga2V5cGFkLCBu
dW0tcm93cyBkZXNjcmlwdGlvaW4NCg0KZmVuZ3BpbmcueXUgKDMpOg0KICBkdC1iaW5kaW5nczog
QWRkIGJpbmRpbmdzIGZvciBNZWRpYXRlayBtYXRyaXgga2V5cGFkDQogIGRyaXZlcnM6IGlucHV0
OmtleWJvYXJkOiBBZGQgbXRrIGtleXBhZCBkcml2ZXINCiAgY29uZmlnczogZGVmY29uZmlnOiBB
ZGQgQ09ORklHX0tFWUJPQVJEX01US19LUEQ9bQ0KDQogLi4uL2RldmljZXRyZWUvYmluZGluZ3Mv
aW5wdXQvbXRrLWtwZC55YW1sICAgIHwgIDgzICsrKysrKysNCiBhcmNoL2FybTY0L2NvbmZpZ3Mv
ZGVmY29uZmlnICAgICAgICAgICAgICAgICAgfCAgIDEgKw0KIGRyaXZlcnMvaW5wdXQva2V5Ym9h
cmQvS2NvbmZpZyAgICAgICAgICAgICAgICB8ICAxMSArDQogZHJpdmVycy9pbnB1dC9rZXlib2Fy
ZC9NYWtlZmlsZSAgICAgICAgICAgICAgIHwgICAxICsNCiBkcml2ZXJzL2lucHV0L2tleWJvYXJk
L210ay1rcGQuYyAgICAgICAgICAgICAgfCAyMTggKysrKysrKysrKysrKysrKysrDQogNSBmaWxl
cyBjaGFuZ2VkLCAzMTQgaW5zZXJ0aW9ucygrKQ0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaW5wdXQvbXRrLWtwZC55YW1sDQogY3JlYXRlIG1v
ZGUgMTAwNjQ0IGRyaXZlcnMvaW5wdXQva2V5Ym9hcmQvbXRrLWtwZC5jDQoNCi0tDQoyLjE4LjAN
Cg0K


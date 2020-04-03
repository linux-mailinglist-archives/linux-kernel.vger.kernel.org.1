Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 868E519D76D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Apr 2020 15:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403984AbgDCNRc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Apr 2020 09:17:32 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:51747 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728044AbgDCNRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 09:17:31 -0400
X-UUID: 5ffa3c17e6404c58a271e196b7e7b454-20200403
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=RWw7C/2TsuzJWYtwo/pc+O+f23J/XZ2uNIvbEeMLBzc=;
        b=MWJcVcfJ0LJInI2KGZJ0OWSjgUWaFrVYUSEzmJXoNKS5Z/7I4W/VJx4Yvzo/XyelPAl3RplaowMSbj6Ecnpa3bJglv5/OqGxixzyWhOWeIzj1sctR0iysg5bKgDTzFTyvcdVnQLdZ9yjZx0SkqSQPIM/dsDC9SUUDKf2ehBf+z0=;
X-UUID: 5ffa3c17e6404c58a271e196b7e7b454-20200403
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <fengping.yu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 572868818; Fri, 03 Apr 2020 21:17:25 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 3 Apr 2020 21:17:20 +0800
Received: from localhost.localdomain (10.15.20.246) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 3 Apr 2020 21:17:20 +0800
From:   Fengping yu <fengping.yu@mediatek.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>
CC:     <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>
Subject: [PATCH v3] Add support for MediaTek keypad 
Date:   Fri, 3 Apr 2020 21:14:18 +0800
Message-ID: <20200403131419.6555-1-fengping.yu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpUaGlzIHBhdGNoc2V0IGFkZCBzdXBwb3J0IHRvIE1lZGlhVGVrIG1hdHJpeCBrZXlwYWQuDQoN
CkNoYW5nZSBzaW5jZSB2MjoNCi0gcmVtb3ZlIGV4dHJhIHNwYWNlIGFuZCByZWR1bmRhbnQgbGlu
ZQ0KLSB1cGRhdGUga2V5cGFkIGRldmljZXRyZWUgZG9jdW1lbnQgZGVib3VuY2UgdGltZSB1bml0
DQotIGNoYW5nZSB0byB1c2UgZGV2bV9wbGF0Zm9ybV9pb3JlbWFwX3Jlc291cmNlKCkgdG8gc2lt
cGxpZnkgY29kZQ0KLSB1c2UgYml0bWFwIHRvIHN0b3JlIGFuZCBjaGVjayBrZXlwYWQgc3RhdGUN
Cg0KZmVuZ3BpbmcueXUgKDIpOg0KICBhZGQgZHQtYmluZGluZyBkb2N1bWVudCBmb3IgTWVkaWFU
ZWsgS2V5cGFkDQogIGFkZCBNZWRpYVRlayBrZXlwYWQgZHJpdmVyDQoNCiAuLi4vZGV2aWNldHJl
ZS9iaW5kaW5ncy9pbnB1dC9tdGsta3BkLnR4dCAgICAgfCAgNjEgKysrKysNCiBhcmNoL2FybTY0
L2NvbmZpZ3MvZGVmY29uZmlnICAgICAgICAgICAgICAgICAgfCAgIDEgKw0KIGRyaXZlcnMvaW5w
dXQva2V5Ym9hcmQvS2NvbmZpZyAgICAgICAgICAgICAgICB8ICAgNyArDQogZHJpdmVycy9pbnB1
dC9rZXlib2FyZC9NYWtlZmlsZSAgICAgICAgICAgICAgIHwgICAxICsNCiBkcml2ZXJzL2lucHV0
L2tleWJvYXJkL210ay1rcGQuYyAgICAgICAgICAgICAgfCAyNTggKysrKysrKysrKysrKysrKysr
DQogNSBmaWxlcyBjaGFuZ2VkLCAzMjggaW5zZXJ0aW9ucygrKQ0KIGNyZWF0ZSBtb2RlIDEwMDY0
NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaW5wdXQvbXRrLWtwZC50eHQNCiBj
cmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9pbnB1dC9rZXlib2FyZC9tdGsta3BkLmMNCg0KLS0N
CjIuMTguMA0KDQo=


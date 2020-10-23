Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2178296BEC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 11:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S461306AbgJWJPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 05:15:09 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:37059 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S461227AbgJWJPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 05:15:08 -0400
X-UUID: b2bdea63ec22431185b4e233b140bca0-20201023
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=NJ00D3ADH+TaQiR+vIP4cEWpTaYnE61vqjYFfO4icjA=;
        b=erwrWHQN9DIYmDmMLyKJXJVX6fR1fFbSe0DNHi/RXcbrn05LGP/TCEfeuLbnzYxTYmMxhNoEYu158CXlHuKUnvY6Smq6UvvLdZM4DXFMnoi81kF3B9CukEiKHQN55RKhtY+DW5ZjWINb+urcEELAiDlbTVA8JP/i2/IEYmvl01Y=;
X-UUID: b2bdea63ec22431185b4e233b140bca0-20201023
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 957610116; Fri, 23 Oct 2020 17:14:56 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 23 Oct 2020 17:14:54 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 23 Oct 2020 17:14:54 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Minchan Kim <minchan@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: [PATCH v2 1/4] arm: mm: use strict p[gum]d types
Date:   Fri, 23 Oct 2020 17:14:34 +0800
Message-ID: <20201023091437.8225-2-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201023091437.8225-1-miles.chen@mediatek.com>
References: <20201023091437.8225-1-miles.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V2hlbiB1c2UgbW0vZ3VwLmMsIGl0IGlzIG5lY2Vzc2FyeSB0byB1c2Ugc3RyaWN0IHAqZCB0eXBl
cy4NCk90aGVyd2lzZSwgd2Ugd2lsbCBnZXQgYnVpbGQgYnJlYWtzIHN1Y2ggYXM6DQoNCm1tL2d1
cC5jOjI1ODk6OTogZXJyb3I6IGluY29tcGF0aWJsZSBwb2ludGVyIHR5cGVzIHBhc3NpbmcgJ3Bt
ZHZhbF90ICoqJw0KKGFrYSAndW5zaWduZWQgaW50ICoqJykgdG8gcGFyYW1ldGVyIG9mIHR5cGUg
J3BnZF90IConDQooYWthICdwbWR2YWxfdCAoKilbMl0nKSBbLVdlcnJvciwtV2luY29tcGF0aWJs
ZS1wb2ludGVyLXR5cGVzXQ0KbW0vZ3VwLmM6MjYxNjo5OiBlcnJvcjogYXJyYXkgaW5pdGlhbGl6
ZXIgbXVzdCBiZSBhbiBpbml0aWFsaXplciBsaXN0DQoNCkZpeCBzb21lIHR5cGVzIGVycm9ycyBp
biBmaXhtYXAuaCBhZnRlciB1c2luZyBzdHJpY3QgdHlwZXMuDQoNCkNjOiBSdXNzZWxsIEtpbmcg
PGxpbnV4QGFybWxpbnV4Lm9yZy51az4NCkNjOiBDYXRhbGluIE1hcmluYXMgPGNhdGFsaW4ubWFy
aW5hc0Bhcm0uY29tPg0KQ2M6IE1pbmNoYW4gS2ltIDxtaW5jaGFuQGtlcm5lbC5vcmc+DQpDYzog
U3VyZW4gQmFnaGRhc2FyeWFuIDxzdXJlbmJAZ29vZ2xlLmNvbT4NClNpZ25lZC1vZmYtYnk6IE1p
bGVzIENoZW4gPG1pbGVzLmNoZW5AbWVkaWF0ZWsuY29tPg0KLS0tDQogYXJjaC9hcm0vaW5jbHVk
ZS9hc20vZml4bWFwLmggICAgICAgICAgICAgICB8ICA2ICsrLS0tDQogYXJjaC9hcm0vaW5jbHVk
ZS9hc20vcGd0YWJsZS0ybGV2ZWwtdHlwZXMuaCB8IDI2IC0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0K
IGFyY2gvYXJtL2luY2x1ZGUvYXNtL3BndGFibGUtMmxldmVsLmggICAgICAgfCAgMSArDQogMyBm
aWxlcyBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDI5IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0t
Z2l0IGEvYXJjaC9hcm0vaW5jbHVkZS9hc20vZml4bWFwLmggYi9hcmNoL2FybS9pbmNsdWRlL2Fz
bS9maXhtYXAuaA0KaW5kZXggZmM1NmZjM2UxOTMxLi4zZWExMmIyZGE3MDggMTAwNjQ0DQotLS0g
YS9hcmNoL2FybS9pbmNsdWRlL2FzbS9maXhtYXAuaA0KKysrIGIvYXJjaC9hcm0vaW5jbHVkZS9h
c20vZml4bWFwLmgNCkBAIC00MiwxMSArNDIsMTEgQEAgc3RhdGljIGNvbnN0IGVudW0gZml4ZWRf
YWRkcmVzc2VzIF9fZW5kX29mX2ZpeGVkX2FkZHJlc3NlcyA9DQogDQogI2RlZmluZSBGSVhNQVBf
UEFHRV9DT01NT04JKExfUFRFX1lPVU5HIHwgTF9QVEVfUFJFU0VOVCB8IExfUFRFX1hOIHwgTF9Q
VEVfRElSVFkpDQogDQotI2RlZmluZSBGSVhNQVBfUEFHRV9OT1JNQUwJKHBncHJvdF9rZXJuZWwg
fCBMX1BURV9YTikNCi0jZGVmaW5lIEZJWE1BUF9QQUdFX1JPCQkoRklYTUFQX1BBR0VfTk9STUFM
IHwgTF9QVEVfUkRPTkxZKQ0KKyNkZWZpbmUgRklYTUFQX1BBR0VfTk9STUFMCV9fcGdwcm90KHBn
cHJvdF92YWwocGdwcm90X2tlcm5lbCkgfCBMX1BURV9YTikNCisjZGVmaW5lIEZJWE1BUF9QQUdF
X1JPCQlfX3BncHJvdChwZ3Byb3RfdmFsKEZJWE1BUF9QQUdFX05PUk1BTCkgfCBMX1BURV9SRE9O
TFkpDQogDQogLyogVXNlZCBieSBzZXRfZml4bWFwXyhpb3xub2NhY2hlKSwgYm90aCBtZWFudCBm
b3IgbWFwcGluZyBhIGRldmljZSAqLw0KLSNkZWZpbmUgRklYTUFQX1BBR0VfSU8JCShGSVhNQVBf
UEFHRV9DT01NT04gfCBMX1BURV9NVF9ERVZfU0hBUkVEIHwgTF9QVEVfU0hBUkVEKQ0KKyNkZWZp
bmUgRklYTUFQX1BBR0VfSU8JCV9fcGdwcm90KEZJWE1BUF9QQUdFX0NPTU1PTiB8IExfUFRFX01U
X0RFVl9TSEFSRUQgfCBMX1BURV9TSEFSRUQpDQogI2RlZmluZSBGSVhNQVBfUEFHRV9OT0NBQ0hF
CUZJWE1BUF9QQUdFX0lPDQogDQogI2RlZmluZSBfX2Vhcmx5X3NldF9maXhtYXAJX19zZXRfZml4
bWFwDQpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vaW5jbHVkZS9hc20vcGd0YWJsZS0ybGV2ZWwtdHlw
ZXMuaCBiL2FyY2gvYXJtL2luY2x1ZGUvYXNtL3BndGFibGUtMmxldmVsLXR5cGVzLmgNCmluZGV4
IDY1MGU3OTNmNDE0Mi4uNjRmZDViOGQ5ZGMyIDEwMDY0NA0KLS0tIGEvYXJjaC9hcm0vaW5jbHVk
ZS9hc20vcGd0YWJsZS0ybGV2ZWwtdHlwZXMuaA0KKysrIGIvYXJjaC9hcm0vaW5jbHVkZS9hc20v
cGd0YWJsZS0ybGV2ZWwtdHlwZXMuaA0KQEAgLTEyLDEyICsxMiw2IEBADQogdHlwZWRlZiB1MzIg
cHRldmFsX3Q7DQogdHlwZWRlZiB1MzIgcG1kdmFsX3Q7DQogDQotI3VuZGVmIFNUUklDVF9NTV9U
WVBFQ0hFQ0tTDQotDQotI2lmZGVmIFNUUklDVF9NTV9UWVBFQ0hFQ0tTDQotLyoNCi0gKiBUaGVz
ZSBhcmUgdXNlZCB0byBtYWtlIHVzZSBvZiBDIHR5cGUtY2hlY2tpbmcuLg0KLSAqLw0KIHR5cGVk
ZWYgc3RydWN0IHsgcHRldmFsX3QgcHRlOyB9IHB0ZV90Ow0KIHR5cGVkZWYgc3RydWN0IHsgcG1k
dmFsX3QgcG1kOyB9IHBtZF90Ow0KIHR5cGVkZWYgc3RydWN0IHsgcG1kdmFsX3QgcGdkWzJdOyB9
IHBnZF90Ow0KQEAgLTMyLDI0ICsyNiw0IEBAIHR5cGVkZWYgc3RydWN0IHsgcHRldmFsX3QgcGdw
cm90OyB9IHBncHJvdF90Ow0KICNkZWZpbmUgX19wbWQoeCkgICAgICAgICgocG1kX3QpIHsgKHgp
IH0gKQ0KICNkZWZpbmUgX19wZ3Byb3QoeCkgICAgICgocGdwcm90X3QpIHsgKHgpIH0gKQ0KIA0K
LSNlbHNlDQotLyoNCi0gKiAuLiB3aGlsZSB0aGVzZSBtYWtlIGl0IGVhc2llciBvbiB0aGUgY29t
cGlsZXINCi0gKi8NCi10eXBlZGVmIHB0ZXZhbF90IHB0ZV90Ow0KLXR5cGVkZWYgcG1kdmFsX3Qg
cG1kX3Q7DQotdHlwZWRlZiBwbWR2YWxfdCBwZ2RfdFsyXTsNCi10eXBlZGVmIHB0ZXZhbF90IHBn
cHJvdF90Ow0KLQ0KLSNkZWZpbmUgcHRlX3ZhbCh4KSAgICAgICh4KQ0KLSNkZWZpbmUgcG1kX3Zh
bCh4KSAgICAgICh4KQ0KLSNkZWZpbmUgcGdkX3ZhbCh4KQkoKHgpWzBdKQ0KLSNkZWZpbmUgcGdw
cm90X3ZhbCh4KSAgICh4KQ0KLQ0KLSNkZWZpbmUgX19wdGUoeCkgICAgICAgICh4KQ0KLSNkZWZp
bmUgX19wbWQoeCkgICAgICAgICh4KQ0KLSNkZWZpbmUgX19wZ3Byb3QoeCkgICAgICh4KQ0KLQ0K
LSNlbmRpZiAvKiBTVFJJQ1RfTU1fVFlQRUNIRUNLUyAqLw0KLQ0KICNlbmRpZgkvKiBfQVNNX1BH
VEFCTEVfMkxFVkVMX1RZUEVTX0ggKi8NCmRpZmYgLS1naXQgYS9hcmNoL2FybS9pbmNsdWRlL2Fz
bS9wZ3RhYmxlLTJsZXZlbC5oIGIvYXJjaC9hcm0vaW5jbHVkZS9hc20vcGd0YWJsZS0ybGV2ZWwu
aA0KaW5kZXggMzUwMmMyZjc0NmNhLi4yN2E4NjM1YWJlYTAgMTAwNjQ0DQotLS0gYS9hcmNoL2Fy
bS9pbmNsdWRlL2FzbS9wZ3RhYmxlLTJsZXZlbC5oDQorKysgYi9hcmNoL2FybS9pbmNsdWRlL2Fz
bS9wZ3RhYmxlLTJsZXZlbC5oDQpAQCAtMTgwLDYgKzE4MCw3IEBADQogI2RlZmluZSBwdWRfbm9u
ZShwdWQpCQkoMCkNCiAjZGVmaW5lIHB1ZF9iYWQocHVkKQkJKDApDQogI2RlZmluZSBwdWRfcHJl
c2VudChwdWQpCSgxKQ0KKyNkZWZpbmUgcHVkX3BhZ2UocHVkKQkJcG1kX3BhZ2UoX19wbWQocHVk
X3ZhbChwdWQpKSkNCiAjZGVmaW5lIHB1ZF9jbGVhcihwdWRwKQkJZG8geyB9IHdoaWxlICgwKQ0K
ICNkZWZpbmUgc2V0X3B1ZChwdWQscHVkcCkJZG8geyB9IHdoaWxlICgwKQ0KIA0KLS0gDQoyLjE4
LjANCg==


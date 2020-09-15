Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 395A026B24A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 00:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727512AbgIOPyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 11:54:54 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:53714 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727390AbgIOPJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 11:09:06 -0400
X-UUID: 0a065e74896c4de8b3203126e03023b7-20200915
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=jhf6yLptTYEHUoTCMmm0pLT8bnD4HjopGFob8vx8D34=;
        b=r0H9WV05fqstPy5tnEhxxDtrkJe9nFEtQMIUMkfWVFxfl+s3E7CnRUaB3INALycochkhKlCEMT23bOrM93yVviQgLtRGtuCjIB84CHyI3anHbSPM2dTmwSeydXqxUbjB08vARaWhiIYlAyllm8tp46K9PpICE1jpvgepI8M8wfk=;
X-UUID: 0a065e74896c4de8b3203126e03023b7-20200915
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <phil.chang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 943115847; Tue, 15 Sep 2020 23:09:00 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 15 Sep 2020 23:08:59 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 15 Sep 2020 23:08:56 +0800
From:   Phil Chang <phil.chang@mediatek.com>
To:     <linux-arm-kernel@lists.infradead.org>
CC:     Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Phil Chang <phil.chang@mediatek.com>,
        YJ Chiang <yj.chiang@mediatek.com>,
        Alix Wu <alix.wu@mediatek.com>,
        Mike Rapoport <rppt@kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH] [PATCH] ARM64: Setup DMA32 zone size by bootargs
Date:   Tue, 15 Sep 2020 23:08:55 +0800
Message-ID: <20200915150855.24825-1-phil.chang@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWxsb3dpbmcgdGhlIERNQTMyIHpvbmUgYmUgY29uZmlndXJhYmxlIGluIEFSTTY0IGJ1dCBhdCBt
b3N0IDRHYi4NCg0KU2lnbmVkLW9mZi1ieTogQWxpeCBXdSA8YWxpeC53dUBtZWRpYXRlay5jb20+
DQpTaWduZWQtb2ZmLWJ5OiBZSiBDaGlhbmcgPHlqLmNoaWFuZ0BtZWRpYXRlay5jb20+DQpTaWdu
ZWQtb2ZmLWJ5OiBQaGlsIENoYW5nIDxwaGlsLmNoYW5nQG1lZGlhdGVrLmNvbT4NCi0tLQ0KDQog
Li4uL2FkbWluLWd1aWRlL2tlcm5lbC1wYXJhbWV0ZXJzLnR4dCAgICAgICAgIHwgIDMgKysNCiBh
cmNoL2FybTY0L2luY2x1ZGUvYXNtL21lbW9yeS5oICAgICAgICAgICAgICAgfCAgMiArDQogYXJj
aC9hcm02NC9tbS9pbml0LmMgICAgICAgICAgICAgICAgICAgICAgICAgIHwgMzkgKysrKysrKysr
KysrKysrKystLQ0KIDMgZmlsZXMgY2hhbmdlZCwgNDEgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlv
bnMoLSkNCg0KZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vYWRtaW4tZ3VpZGUva2VybmVsLXBh
cmFtZXRlcnMudHh0IGIvRG9jdW1lbnRhdGlvbi9hZG1pbi1ndWlkZS9rZXJuZWwtcGFyYW1ldGVy
cy50eHQNCmluZGV4IGJkYzFmMzNmZDNkMS4uNWJlNjI1OWU5YmE4IDEwMDY0NA0KLS0tIGEvRG9j
dW1lbnRhdGlvbi9hZG1pbi1ndWlkZS9rZXJuZWwtcGFyYW1ldGVycy50eHQNCisrKyBiL0RvY3Vt
ZW50YXRpb24vYWRtaW4tZ3VpZGUva2VybmVsLXBhcmFtZXRlcnMudHh0DQpAQCAtOTgwLDYgKzk4
MCw5IEBADQogCQkJVGhlIGZpbHRlciBjYW4gYmUgZGlzYWJsZWQgb3IgY2hhbmdlZCB0byBhbm90
aGVyDQogCQkJZHJpdmVyIGxhdGVyIHVzaW5nIHN5c2ZzLg0KIA0KKwlkbWEzMl9zaXplPW5uW01H
XSAgW0tOTCxCT09ULEFSTTY0XQ0KKwkJCUZvcmNlcyB0aGUgRE1BMzIgem9uZSBzaXplIG9mIDxu
bj4gaW4gTUIuDQorDQogCWRyaXZlcl9hc3luY19wcm9iZT0gIFtLTkxdDQogCQkJTGlzdCBvZiBk
cml2ZXIgbmFtZXMgdG8gYmUgcHJvYmVkIGFzeW5jaHJvbm91c2x5Lg0KIAkJCUZvcm1hdDogPGRy
aXZlcl9uYW1lMT4sPGRyaXZlcl9uYW1lMj4uLi4NCmRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2lu
Y2x1ZGUvYXNtL21lbW9yeS5oIGIvYXJjaC9hcm02NC9pbmNsdWRlL2FzbS9tZW1vcnkuaA0KaW5k
ZXggYWZhNzIyNTA0YmZkLi43MTBkZTA4YWU4YWUgMTAwNjQ0DQotLS0gYS9hcmNoL2FybTY0L2lu
Y2x1ZGUvYXNtL21lbW9yeS5oDQorKysgYi9hcmNoL2FybTY0L2luY2x1ZGUvYXNtL21lbW9yeS5o
DQpAQCAtMTc1LDYgKzE3NSw4IEBAIGV4dGVybiB1NjQJCQlraW1hZ2VfdmFkZHI7DQogLyogdGhl
IG9mZnNldCBiZXR3ZWVuIHRoZSBrZXJuZWwgdmlydHVhbCBhbmQgcGh5c2ljYWwgbWFwcGluZ3Mg
Ki8NCiBleHRlcm4gdTY0CQkJa2ltYWdlX3ZvZmZzZXQ7DQogDQorZXh0ZXJuIHBoeXNfYWRkcl90
CQlkbWEzMl96b25lX3NpemU7DQorDQogc3RhdGljIGlubGluZSB1bnNpZ25lZCBsb25nIGthc2xy
X29mZnNldCh2b2lkKQ0KIHsNCiAJcmV0dXJuIGtpbWFnZV92YWRkciAtIEtJTUFHRV9WQUREUjsN
CmRpZmYgLS1naXQgYS9hcmNoL2FybTY0L21tL2luaXQuYyBiL2FyY2gvYXJtNjQvbW0vaW5pdC5j
DQppbmRleCA0ODFkMjJjMzJhMmUuLmM4YWY1MzY4MGQ0NiAxMDA2NDQNCi0tLSBhL2FyY2gvYXJt
NjQvbW0vaW5pdC5jDQorKysgYi9hcmNoL2FybTY0L21tL2luaXQuYw0KQEAgLTYwLDYgKzYwLDkg
QEAgRVhQT1JUX1NZTUJPTChwaHlzdmlydF9vZmZzZXQpOw0KIHN0cnVjdCBwYWdlICp2bWVtbWFw
IF9fcm9fYWZ0ZXJfaW5pdDsNCiBFWFBPUlRfU1lNQk9MKHZtZW1tYXApOw0KIA0KK3BoeXNfYWRk
cl90IGRtYTMyX3pvbmVfc2l6ZSBfX3JvX2FmdGVyX2luaXQ7DQorRVhQT1JUX1NZTUJPTChkbWEz
Ml96b25lX3NpemUpOw0KKw0KIC8qDQogICogV2UgY3JlYXRlIGJvdGggWk9ORV9ETUEgYW5kIFpP
TkVfRE1BMzIuIFpPTkVfRE1BIGNvdmVycyB0aGUgZmlyc3QgMUcgb2YNCiAgKiBtZW1vcnkgYXMg
c29tZSBkZXZpY2VzLCBuYW1lbHkgdGhlIFJhc3BiZXJyeSBQaSA0LCBoYXZlIHBlcmlwaGVyYWxz
IHdpdGgNCkBAIC0yNDIsNiArMjQ1LDI5IEBAIHN0YXRpYyBpbnQgX19pbml0IGVhcmx5X21lbShj
aGFyICpwKQ0KIH0NCiBlYXJseV9wYXJhbSgibWVtIiwgZWFybHlfbWVtKTsNCiANCitzdGF0aWMg
aW50IF9faW5pdCBzZXR1cF9kbWEzMl96b25lKGNoYXIgKnApDQorew0KKwl1NjQgc2l6ZTsNCisN
CisJaWYgKCFwKQ0KKwkJcmV0dXJuIC1FSU5WQUw7DQorDQorCWlmIChrc3RydG91bGwocCwgMCwg
JnNpemUpKQ0KKwkJcmV0dXJuIC1FSU5WQUw7DQorDQorCS8qIERNQTMyIHpvbmUgc2l6ZSBzaG91
bGQgbmV2ZXIgZ3JhdGVyIHRoYW4gNEcgKi8NCisJaWYgKHNpemUgPiBtYXhfem9uZV9waHlzKDMy
KSAvIFNaXzFNKQ0KKwkJcmV0dXJuIC1FSU5WQUw7DQorDQorCXByX25vdGljZSgiU2V0dXAgZG1h
MzIgem9uZSBzaXplIHRvICVsbHUgTWJcbiIsIHNpemUpOw0KKw0KKwlkbWEzMl96b25lX3NpemUg
PSBzaXplICogU1pfMU07DQorDQorCXJldHVybiAwOw0KK30NCisNCitlYXJseV9wYXJhbSgiZG1h
MzJfc2l6ZSIsIHNldHVwX2RtYTMyX3pvbmUpOw0KKw0KIHN0YXRpYyBpbnQgX19pbml0IGVhcmx5
X2luaXRfZHRfc2Nhbl91c2FibGVtZW0odW5zaWduZWQgbG9uZyBub2RlLA0KIAkJY29uc3QgY2hh
ciAqdW5hbWUsIGludCBkZXB0aCwgdm9pZCAqZGF0YSkNCiB7DQpAQCAtMzkyLDEwICs0MTgsMTcg
QEAgdm9pZCBfX2luaXQgYXJtNjRfbWVtYmxvY2tfaW5pdCh2b2lkKQ0KIAkJYXJtNjRfZG1hX3Bo
eXNfbGltaXQgPSBtYXhfem9uZV9waHlzKEFSTTY0X1pPTkVfRE1BX0JJVFMpOw0KIAl9DQogDQot
CWlmIChJU19FTkFCTEVEKENPTkZJR19aT05FX0RNQTMyKSkNCi0JCWFybTY0X2RtYTMyX3BoeXNf
bGltaXQgPSBtYXhfem9uZV9waHlzKDMyKTsNCi0JZWxzZQ0KKwlpZiAoSVNfRU5BQkxFRChDT05G
SUdfWk9ORV9ETUEzMikpIHsNCisJCWlmIChkbWEzMl96b25lX3NpemUpIHsNCisJCQlhcm02NF9k
bWEzMl9waHlzX2xpbWl0ID0gbWluKG1heF96b25lX3BoeXMoMzIpLA0KKwkJCQlkbWEzMl96b25l
X3NpemUgKyBtZW1ibG9ja19zdGFydF9vZl9EUkFNKCkpOw0KKwkJfSBlbHNlIHsNCisJCQlhcm02
NF9kbWEzMl9waHlzX2xpbWl0ID0gbWF4X3pvbmVfcGh5cygzMik7DQorCQkJZG1hMzJfem9uZV9z
aXplID0gYXJtNjRfZG1hMzJfcGh5c19saW1pdDsNCisJCX0NCisJfSBlbHNlIHsNCiAJCWFybTY0
X2RtYTMyX3BoeXNfbGltaXQgPSBQSFlTX01BU0sgKyAxOw0KKwl9DQogDQogCXJlc2VydmVfY3Jh
c2hrZXJuZWwoKTsNCiANCi0tIA0KMi4xOC4wDQo=


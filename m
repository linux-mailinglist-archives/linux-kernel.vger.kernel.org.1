Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D22C61FC6B6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jun 2020 09:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726972AbgFQHGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jun 2020 03:06:10 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:48341 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725929AbgFQHFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 03:05:32 -0400
X-UUID: e9f94bcedf7641428b89275b1f55790a-20200617
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=oknxkN93lM10p7H+ZOPQmB3ANyUU8TNjZxsOq9hhIMc=;
        b=UQuFKEjhqAh7OKPmv4EzqpQgbAqDbCBfh8HRf+sHmkOvhP3U649f++4Lkfz+arz1GsS8pRFDFE0/FW8vIhURkcOWKs/9P9+kBmiyZz6h118K4xvA3crQ7lKsCFYd1rx7Xpvh0LaxaLqIf17jS97XWRaIc1+Oy+U5qMmiKI9QL1U=;
X-UUID: e9f94bcedf7641428b89275b1f55790a-20200617
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1095072231; Wed, 17 Jun 2020 15:05:25 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 17 Jun 2020 15:05:24 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 17 Jun 2020 15:05:23 +0800
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Enric Balletbo Serra <eballetbo@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        "Rob Herring" <robh@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>
CC:     James Liao <jamesjj.liao@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>,
        Wendell Lin <wendell.lin@mediatek.com>
Subject: [PATCH v16 06/11] soc: mediatek: Add subsys clock control for bus protection
Date:   Wed, 17 Jun 2020 15:05:12 +0800
Message-ID: <1592377517-14817-7-git-send-email-weiyi.lu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1592377517-14817-1-git-send-email-weiyi.lu@mediatek.com>
References: <1592377517-14817-1-git-send-email-weiyi.lu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rm9yIHRoZSBidXMgcHJvdGVjdGlvbiBvcGVyYXRpb25zLCBzb21lIHN1YnN5cyBjbG9ja3MgbmVl
ZCB0byBiZSBlbmFibGVkDQpiZWZvcmUgcmVsZWFzaW5nIHRoZSBwcm90ZWN0aW9uLCBhbmQgdmlj
ZSB2ZXJzYS4NCkJ1dCB0aG9zZSBzdWJzeXMgY2xvY2tzIGNvdWxkIG9ubHkgYmUgY29udHJvbGxl
ZCBvbmNlIGl0cyBjb3JyZXNwb25kaW5nDQpwb3dlciBkb21haW4gaXMgdHVybmVkIG9uIGZpcnN0
Lg0KSW4gdGhpcyBwYXRjaCwgd2UgYWRkIHRoZSBzdWJzeXMgY2xvY2sgY29udHJvbCBpbnRvIGl0
cyByZWxldmFudCBzdGVwcy4NCg0KU2lnbmVkLW9mZi1ieTogV2VpeWkgTHUgPHdlaXlpLmx1QG1l
ZGlhdGVrLmNvbT4NCi0tLQ0KIGRyaXZlcnMvc29jL21lZGlhdGVrL210ay1zY3BzeXMuYyB8IDU4
ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLQ0KIDEgZmlsZSBjaGFuZ2Vk
LCA1NiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9zb2MvbWVkaWF0ZWsvbXRrLXNjcHN5cy5jIGIvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLXNj
cHN5cy5jDQppbmRleCA1OWE1MjVhLi5hNTY3MzQ2IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9zb2Mv
bWVkaWF0ZWsvbXRrLXNjcHN5cy5jDQorKysgYi9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstc2Nw
c3lzLmMNCkBAIC05Nyw2ICs5Nyw3IEBADQogI2RlZmluZSBNVDgxNzNfVE9QX0FYSV9QUk9UX0VO
X01GR19TTk9PUF9PVVQJQklUKDIzKQ0KIA0KICNkZWZpbmUgTUFYX0NMS1MJMw0KKyNkZWZpbmUg
TUFYX1NVQlNZU19DTEtTIDEwDQogDQogI2RlZmluZSBNQVhfU1RFUFMJNA0KIA0KQEAgLTE0NSw2
ICsxNDYsOCBAQCBzdHJ1Y3QgYnVzX3Byb3Qgew0KICAqIEBzcmFtX3Bkbl9iaXRzOiBUaGUgbWFz
ayBmb3Igc3JhbSBwb3dlciBjb250cm9sIGJpdHMuDQogICogQHNyYW1fcGRuX2Fja19iaXRzOiBU
aGUgbWFzayBmb3Igc3JhbSBwb3dlciBjb250cm9sIGFja2VkIGJpdHMuDQogICogQGJhc2ljX2Ns
a19uYW1lOiBUaGUgYmFzaWMgY2xvY2tzIHJlcXVpcmVkIGJ5IHRoaXMgcG93ZXIgZG9tYWluLg0K
KyAqIEBzdWJzeXNfY2xrX3ByZWZpeDogVGhlIHByZWZpeCBuYW1lIG9mIHRoZSBjbG9ja3MgbmVl
ZCB0byBiZSBlbmFibGVkDQorICogICAgICAgICAgICAgICAgICAgICBiZWZvcmUgcmVsZWFzaW5n
IGJ1cyBwcm90ZWN0aW9uLg0KICAqIEBjYXBzOiBUaGUgZmxhZyBmb3IgYWN0aXZlIHdha2UtdXAg
YWN0aW9uLg0KICAqIEBicF90YWJsZTogVGhlIG1hc2sgdGFibGUgZm9yIG11bHRpcGxlIHN0ZXAg
YnVzIHByb3RlY3Rpb24uDQogICovDQpAQCAtMTU1LDYgKzE1OCw3IEBAIHN0cnVjdCBzY3BfZG9t
YWluX2RhdGEgew0KIAl1MzIgc3JhbV9wZG5fYml0czsNCiAJdTMyIHNyYW1fcGRuX2Fja19iaXRz
Ow0KIAljb25zdCBjaGFyICpiYXNpY19jbGtfbmFtZVtNQVhfQ0xLU107DQorCWNvbnN0IGNoYXIg
KnN1YnN5c19jbGtfcHJlZml4Ow0KIAl1OCBjYXBzOw0KIAlzdHJ1Y3QgYnVzX3Byb3QgYnBfdGFi
bGVbTUFYX1NURVBTXTsNCiB9Ow0KQEAgLTE2NSw2ICsxNjksNyBAQCBzdHJ1Y3Qgc2NwX2RvbWFp
biB7DQogCXN0cnVjdCBnZW5lcmljX3BtX2RvbWFpbiBnZW5wZDsNCiAJc3RydWN0IHNjcCAqc2Nw
Ow0KIAlzdHJ1Y3QgY2xrICpjbGtbTUFYX0NMS1NdOw0KKwlzdHJ1Y3QgY2xrICpzdWJzeXNfY2xr
W01BWF9TVUJTWVNfQ0xLU107DQogCWNvbnN0IHN0cnVjdCBzY3BfZG9tYWluX2RhdGEgKmRhdGE7
DQogCXN0cnVjdCByZWd1bGF0b3IgKnN1cHBseTsNCiB9Ow0KQEAgLTQyNSwxNiArNDMwLDIyIEBA
IHN0YXRpYyBpbnQgc2Nwc3lzX3Bvd2VyX29uKHN0cnVjdCBnZW5lcmljX3BtX2RvbWFpbiAqZ2Vu
cGQpDQogCXZhbCB8PSBQV1JfUlNUX0JfQklUOw0KIAl3cml0ZWwodmFsLCBjdGxfYWRkcik7DQog
DQotCXJldCA9IHNjcHN5c19zcmFtX2VuYWJsZShzY3BkLCBjdGxfYWRkcik7DQorCXJldCA9IHNj
cHN5c19jbGtfZW5hYmxlKHNjcGQtPnN1YnN5c19jbGssIE1BWF9TVUJTWVNfQ0xLUyk7DQogCWlm
IChyZXQgPCAwKQ0KIAkJZ290byBlcnJfcHdyX2FjazsNCiANCisJcmV0ID0gc2Nwc3lzX3NyYW1f
ZW5hYmxlKHNjcGQsIGN0bF9hZGRyKTsNCisJaWYgKHJldCA8IDApDQorCQlnb3RvIGVycl9zcmFt
Ow0KKw0KIAlyZXQgPSBzY3BzeXNfYnVzX3Byb3RlY3RfZGlzYWJsZShzY3BkKTsNCiAJaWYgKHJl
dCA8IDApDQotCQlnb3RvIGVycl9wd3JfYWNrOw0KKwkJZ290byBlcnJfc3JhbTsNCiANCiAJcmV0
dXJuIDA7DQogDQorZXJyX3NyYW06DQorCXNjcHN5c19jbGtfZGlzYWJsZShzY3BkLT5zdWJzeXNf
Y2xrLCBNQVhfU1VCU1lTX0NMS1MpOw0KIGVycl9wd3JfYWNrOg0KIAlzY3BzeXNfY2xrX2Rpc2Fi
bGUoc2NwZC0+Y2xrLCBNQVhfQ0xLUyk7DQogZXJyX2NsazoNCkBAIC00NjEsNiArNDcyLDggQEAg
c3RhdGljIGludCBzY3BzeXNfcG93ZXJfb2ZmKHN0cnVjdCBnZW5lcmljX3BtX2RvbWFpbiAqZ2Vu
cGQpDQogCWlmIChyZXQgPCAwKQ0KIAkJZ290byBvdXQ7DQogDQorCXNjcHN5c19jbGtfZGlzYWJs
ZShzY3BkLT5zdWJzeXNfY2xrLCBNQVhfU1VCU1lTX0NMS1MpOw0KKw0KIAkvKiBzdWJzeXMgcG93
ZXIgb2ZmICovDQogCXZhbCA9IHJlYWRsKGN0bF9hZGRyKTsNCiAJdmFsIHw9IFBXUl9JU09fQklU
Ow0KQEAgLTQ5OCw2ICs1MTEsMzkgQEAgc3RhdGljIGludCBzY3BzeXNfcG93ZXJfb2ZmKHN0cnVj
dCBnZW5lcmljX3BtX2RvbWFpbiAqZ2VucGQpDQogCXJldHVybiByZXQ7DQogfQ0KIA0KK3N0YXRp
YyBpbnQgaW5pdF9zdWJzeXNfY2xrcyhzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2LA0KKwkJ
Y29uc3QgY2hhciAqcHJlZml4LCBzdHJ1Y3QgY2xrICoqY2xrKQ0KK3sNCisJc3RydWN0IGRldmlj
ZV9ub2RlICpub2RlID0gcGRldi0+ZGV2Lm9mX25vZGU7DQorCXUzMiBwcmVmaXhfbGVuLCBzdWJf
Y2xrX2NudCA9IDA7DQorCXN0cnVjdCBwcm9wZXJ0eSAqcHJvcDsNCisJY29uc3QgY2hhciAqY2xr
X25hbWU7DQorDQorCXByZWZpeF9sZW4gPSBzdHJsZW4ocHJlZml4KTsNCisNCisJb2ZfcHJvcGVy
dHlfZm9yX2VhY2hfc3RyaW5nKG5vZGUsICJjbG9jay1uYW1lcyIsIHByb3AsIGNsa19uYW1lKSB7
DQorCQlpZiAoIXN0cm5jbXAoY2xrX25hbWUsIHByZWZpeCwgcHJlZml4X2xlbikgJiYNCisJCQkJ
KGNsa19uYW1lW3ByZWZpeF9sZW5dID09ICctJykpIHsNCisJCQlpZiAoc3ViX2Nsa19jbnQgPj0g
TUFYX1NVQlNZU19DTEtTKSB7DQorCQkJCWRldl9lcnIoJnBkZXYtPmRldiwNCisJCQkJCSJzdWJz
eXMgY2xrIG91dCBvZiByYW5nZSAlZFxuIiwNCisJCQkJCXN1Yl9jbGtfY250KTsNCisJCQkJcmV0
dXJuIC1FSU5WQUw7DQorCQkJfQ0KKw0KKwkJCWNsa1tzdWJfY2xrX2NudF0gPSBkZXZtX2Nsa19n
ZXQoJnBkZXYtPmRldiwNCisJCQkJCQljbGtfbmFtZSk7DQorDQorCQkJaWYgKElTX0VSUihjbGtb
c3ViX2Nsa19jbnRdKSkNCisJCQkJcmV0dXJuIFBUUl9FUlIoY2xrW3N1Yl9jbGtfY250XSk7DQor
DQorCQkJc3ViX2Nsa19jbnQrKzsNCisJCX0NCisJfQ0KKw0KKwlyZXR1cm4gc3ViX2Nsa19jbnQ7
DQorfQ0KKw0KIHN0YXRpYyBpbnQgaW5pdF9iYXNpY19jbGtzKHN0cnVjdCBwbGF0Zm9ybV9kZXZp
Y2UgKnBkZXYsIHN0cnVjdCBjbGsgKipjbGssDQogCQkJY29uc3QgY2hhciAqIGNvbnN0ICpuYW1l
KQ0KIHsNCkBAIC01OTYsNiArNjQyLDE0IEBAIHN0YXRpYyBzdHJ1Y3Qgc2NwICppbml0X3NjcChz
dHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2LA0KIAkJaWYgKHJldCkNCiAJCQlyZXR1cm4gRVJS
X1BUUihyZXQpOw0KIA0KKwkJaWYgKGRhdGEtPnN1YnN5c19jbGtfcHJlZml4KSB7DQorCQkJcmV0
ID0gaW5pdF9zdWJzeXNfY2xrcyhwZGV2LA0KKwkJCQkJZGF0YS0+c3Vic3lzX2Nsa19wcmVmaXgs
DQorCQkJCQlzY3BkLT5zdWJzeXNfY2xrKTsNCisJCQlpZiAocmV0IDwgMCkNCisJCQkJcmV0dXJu
IEVSUl9QVFIocmV0KTsNCisJCX0NCisNCiAJCWdlbnBkLT5uYW1lID0gZGF0YS0+bmFtZTsNCiAJ
CWdlbnBkLT5wb3dlcl9vZmYgPSBzY3BzeXNfcG93ZXJfb2ZmOw0KIAkJZ2VucGQtPnBvd2VyX29u
ID0gc2Nwc3lzX3Bvd2VyX29uOw0KLS0gDQoxLjguMS4xLmRpcnR5DQo=


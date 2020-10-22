Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63CAE295EF1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 14:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2898738AbgJVMrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 08:47:48 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:46600 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2506690AbgJVMrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 08:47:46 -0400
X-UUID: 182ec6c31f8846ecb1a63f4389a88b1b-20201022
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=aER/GLpe3/PEFF5UMv7R5fKpYWc9avuUM9COWVPQLn4=;
        b=h3jmaUbJ1s83nuy4hzllQmVSpOzY5c9TpN4U0UXjKIPGnHtv4hWYgfh7trK6TARGNTa90+2gHxG+P5OS7OPWnwo7YXrJgn3yrVTkjo0Hr8UY2tL1JRU5ITNrM7Qns2AdBdQ3qWz4YHHrfTt7YfbtRL43+pCF1ZalVSmd7Rb72ek=;
X-UUID: 182ec6c31f8846ecb1a63f4389a88b1b-20201022
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 883003489; Thu, 22 Oct 2020 20:47:41 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 22 Oct 2020 20:47:39 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 22 Oct 2020 20:47:39 +0800
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Enric Balletbo Serra <eballetbo@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>
Subject: [PATCH v2 2/4] soc: mediatek: pm-domains: Add default power off flag
Date:   Thu, 22 Oct 2020 20:47:35 +0800
Message-ID: <1603370857-30646-3-git-send-email-weiyi.lu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1603370857-30646-1-git-send-email-weiyi.lu@mediatek.com>
References: <1603370857-30646-1-git-send-email-weiyi.lu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rm9yIHNvbWUgcG93ZXIgZG9tYWluLCBsaWtlIGNvbm4gb24gTVQ4MTkyLCBpdCBzaG91bGQgYmUg
ZGVmYXVsdCBPRkYuDQpCZWNhdXNlIHRoZSBwb3dlciBvbi9vZmYgY29udHJvbCByZWxpZXMgdGhl
IGZ1bmN0aW9uIG9mIGNvbm5lY3Rpdml0eSBjaGlwDQphbmQgaXRzIGZpcm13YXJlLiBBbmQgaWYg
cHJvamVjdCBjaG9vc2Ugb3RoZXIgY2hpcCB2ZW5kb3Igc29sdXRpb24sDQp0aG9zZSBuZWNlc3Nh
cnkgY29ubmVjdGl2aXR5IGZ1bmN0aW9ucyB3aWxsIG5vdCBwcm92aWRlZC4NCg0KU2lnbmVkLW9m
Zi1ieTogV2VpeWkgTHUgPHdlaXlpLmx1QG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGRyaXZlcnMvc29j
L21lZGlhdGVrL210ay1wbS1kb21haW5zLmMgfCAyMyArKysrKysrKysrKysrKysrKy0tLS0tLQ0K
IDEgZmlsZSBjaGFuZ2VkLCAxNyBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQ0KDQpkaWZm
IC0tZ2l0IGEvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLXBtLWRvbWFpbnMuYyBiL2RyaXZlcnMv
c29jL21lZGlhdGVrL210ay1wbS1kb21haW5zLmMNCmluZGV4IGI3Y2NmOTQuLjUwYTdhZTEgMTAw
NjQ0DQotLS0gYS9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstcG0tZG9tYWlucy5jDQorKysgYi9k
cml2ZXJzL3NvYy9tZWRpYXRlay9tdGstcG0tZG9tYWlucy5jDQpAQCAtMjQsNiArMjQsNyBAQA0K
ICNkZWZpbmUgTVRLX1NDUERfQUNUSVZFX1dBS0VVUAkJQklUKDApDQogI2RlZmluZSBNVEtfU0NQ
RF9GV0FJVF9TUkFNCQlCSVQoMSkNCiAjZGVmaW5lIE1US19TQ1BEX1NSQU1fSVNPCQlCSVQoMikN
CisjZGVmaW5lIE1US19TQ1BEX0tFRVBfREVGQVVMVF9PRkYJQklUKDMpDQogI2RlZmluZSBNVEtf
U0NQRF9DQVBTKF9zY3BkLCBfeCkJKChfc2NwZCktPmRhdGEtPmNhcHMgJiAoX3gpKQ0KIA0KICNk
ZWZpbmUgU1BNX1ZERV9QV1JfQ09OCQkJMHgwMjEwDQpAQCAtNTA2LDE3ICs1MDcsMjYgQEAgc3Rh
dGljIGludCBzY3BzeXNfYWRkX29uZV9kb21haW4oc3RydWN0IHNjcHN5cyAqc2Nwc3lzLCBzdHJ1
Y3QgZGV2aWNlX25vZGUgKm5vZGUNCiAJICogc29mdHdhcmUuICBUaGUgdW51c2VkIGRvbWFpbnMg
d2lsbCBiZSBzd2l0Y2hlZCBvZmYgZHVyaW5nDQogCSAqIGxhdGVfaW5pdCB0aW1lLg0KIAkgKi8N
Ci0JcmV0ID0gc2Nwc3lzX3Bvd2VyX29uKCZwZC0+Z2VucGQpOw0KLQlpZiAocmV0IDwgMCkgew0K
LQkJZGV2X2Vycl9wcm9iZShzY3BzeXMtPmRldiwgcmV0LCAiZmFpbGVkIHRvIHBvd2VyIG9uIGRv
bWFpbiAlcE9GTlxuIiwgbm9kZSk7DQotCQlnb3RvIGVycl91bnByZXBhcmVfY2xvY2tzOw0KKwlp
ZiAoTVRLX1NDUERfQ0FQUyhwZCwgTVRLX1NDUERfS0VFUF9ERUZBVUxUX09GRikpIHsNCisJCWlm
IChzY3BzeXNfZG9tYWluX2lzX29uKHBkKSkNCisJCQlkZXZfd2FybihzY3BzeXMtPmRldiwNCisJ
CQkJICJBIGRlZmF1bHQgb2ZmIHBvd2VyIGRvbWFpbiAlcE9GTiBoYXMgYmVlbiBPTlxuIiwgbm9k
ZSk7DQorCX0gZWxzZSB7DQorCQlyZXQgPSBzY3BzeXNfcG93ZXJfb24oJnBkLT5nZW5wZCk7DQor
CQlpZiAocmV0IDwgMCkgew0KKwkJCWRldl9lcnJfcHJvYmUoc2Nwc3lzLT5kZXYsIHJldCwgImZh
aWxlZCB0byBwb3dlciBvbiBkb21haW4gJXBPRk5cbiIsIG5vZGUpOw0KKwkJCWdvdG8gZXJyX3Vu
cHJlcGFyZV9jbG9ja3M7DQorCQl9DQogCX0NCiANCiAJcGQtPmdlbnBkLm5hbWUgPSBub2RlLT5u
YW1lOw0KIAlwZC0+Z2VucGQucG93ZXJfb2ZmID0gc2Nwc3lzX3Bvd2VyX29mZjsNCiAJcGQtPmdl
bnBkLnBvd2VyX29uID0gc2Nwc3lzX3Bvd2VyX29uOw0KIA0KLQlwbV9nZW5wZF9pbml0KCZwZC0+
Z2VucGQsIE5VTEwsIGZhbHNlKTsNCisJaWYgKE1US19TQ1BEX0NBUFMocGQsIE1US19TQ1BEX0tF
RVBfREVGQVVMVF9PRkYpKQ0KKwkJcG1fZ2VucGRfaW5pdCgmcGQtPmdlbnBkLCBOVUxMLCB0cnVl
KTsNCisJZWxzZQ0KKwkJcG1fZ2VucGRfaW5pdCgmcGQtPmdlbnBkLCBOVUxMLCBmYWxzZSk7DQog
DQogCXNjcHN5cy0+ZG9tYWluc1tpZF0gPSAmcGQtPmdlbnBkOw0KIAlyZXR1cm4gMDsNCkBAIC02
MDMsNyArNjEzLDggQEAgc3RhdGljIHZvaWQgc2Nwc3lzX3JlbW92ZV9vbmVfZG9tYWluKHN0cnVj
dCBzY3BzeXNfZG9tYWluICpwZCkNCiAJCQkiZmFpbGVkIHRvIHJlbW92ZSBkb21haW4gJyVzJyA6
ICVkIC0gc3RhdGUgbWF5IGJlIGluY29uc2lzdGVudFxuIiwNCiAJCQlwZC0+Z2VucGQubmFtZSwg
cmV0KTsNCiANCi0Jc2Nwc3lzX3Bvd2VyX29mZigmcGQtPmdlbnBkKTsNCisJaWYgKCFNVEtfU0NQ
RF9DQVBTKHBkLCBNVEtfU0NQRF9LRUVQX0RFRkFVTFRfT0ZGKSkNCisJCXNjcHN5c19wb3dlcl9v
ZmYoJnBkLT5nZW5wZCk7DQogDQogCWNsa19idWxrX3VucHJlcGFyZShwZC0+bnVtX2Nsa3MsIHBk
LT5jbGtzKTsNCiAJY2xrX2J1bGtfcHV0KHBkLT5udW1fY2xrcywgcGQtPmNsa3MpOw0KLS0gDQox
LjguMS4xLmRpcnR5DQo=


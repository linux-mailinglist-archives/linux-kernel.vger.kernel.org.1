Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C40131FC6A4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jun 2020 09:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbgFQHFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jun 2020 03:05:35 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:11651 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726694AbgFQHFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 03:05:31 -0400
X-UUID: 8f2a5072ee2b4105897eef148c312773-20200617
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=ERBWBQKk5eOWSM1XMJj30bh4UNq1SbvG0GoU5eyQTK8=;
        b=rA0C9VDEPFBOKybp5KFrtF95vKNWErZgzHLHzQJ7NAydhw3rBAdJT5mv+9Sz8YjBHpRK21ord//N/lgG7zhepRvFVuoPCcgVL/1ftMkyNNVIdeUlPHEEqpV0b1isbYcIeXJvUFu2ysh+1t2ilTK56NOCd29mO3cogOYnwzMlRtc=;
X-UUID: 8f2a5072ee2b4105897eef148c312773-20200617
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 835948152; Wed, 17 Jun 2020 15:05:25 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 17 Jun 2020 15:05:22 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 17 Jun 2020 15:05:23 +0800
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Enric Balletbo Serra <eballetbo@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>
CC:     James Liao <jamesjj.liao@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>,
        Wendell Lin <wendell.lin@mediatek.com>
Subject: [PATCH v16 07/11] soc: mediatek: Add extra sram control
Date:   Wed, 17 Jun 2020 15:05:13 +0800
Message-ID: <1592377517-14817-8-git-send-email-weiyi.lu@mediatek.com>
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

Rm9yIHNvbWUgcG93ZXIgZG9tYWlucyBsaWtlIHZwdV9jb3JlIG9uIE1UODE4MyB3aG9zZSBzcmFt
IG5lZWQgdG8NCmRvIGNsb2NrIGFuZCBpbnRlcm5hbCBpc29sYXRpb24gd2hpbGUgcG93ZXIgb24v
b2ZmIHNyYW0uDQpXZSBhZGQgYSBjYXAgIk1US19TQ1BEX1NSQU1fSVNPIiB0byBqdWRnZSBpZiB3
ZSBuZWVkIHRvIGRvDQp0aGUgZXh0cmEgc3JhbSBpc29sYXRpb24gY29udHJvbCBvciBub3QuDQoN
ClNpZ25lZC1vZmYtYnk6IFdlaXlpIEx1IDx3ZWl5aS5sdUBtZWRpYXRlay5jb20+DQpSZXZpZXdl
ZC1ieTogTmljb2xhcyBCb2ljaGF0IDxkcmlua2NhdEBjaHJvbWl1bS5vcmc+DQotLS0NCiBkcml2
ZXJzL3NvYy9tZWRpYXRlay9tdGstc2Nwc3lzLmMgfCAyMiArKysrKysrKysrKysrKysrKysrKy0t
DQogMSBmaWxlIGNoYW5nZWQsIDIwIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQoNCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstc2Nwc3lzLmMgYi9kcml2ZXJzL3Nv
Yy9tZWRpYXRlay9tdGstc2Nwc3lzLmMNCmluZGV4IGE1NjczNDYuLjM2MGQ1NTkgMTAwNjQ0DQot
LS0gYS9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstc2Nwc3lzLmMNCisrKyBiL2RyaXZlcnMvc29j
L21lZGlhdGVrL210ay1zY3BzeXMuYw0KQEAgLTI1LDYgKzI1LDcgQEANCiANCiAjZGVmaW5lIE1U
S19TQ1BEX0FDVElWRV9XQUtFVVAJCUJJVCgwKQ0KICNkZWZpbmUgTVRLX1NDUERfRldBSVRfU1JB
TQkJQklUKDEpDQorI2RlZmluZSBNVEtfU0NQRF9TUkFNX0lTTwkJQklUKDIpDQogI2RlZmluZSBN
VEtfU0NQRF9DQVBTKF9zY3BkLCBfeCkJKChfc2NwZCktPmRhdGEtPmNhcHMgJiAoX3gpKQ0KIA0K
ICNkZWZpbmUgU1BNX1ZERV9QV1JfQ09OCQkJMHgwMjEwDQpAQCAtNTYsNiArNTcsOCBAQA0KICNk
ZWZpbmUgUFdSX09OX0JJVAkJCUJJVCgyKQ0KICNkZWZpbmUgUFdSX09OXzJORF9CSVQJCQlCSVQo
MykNCiAjZGVmaW5lIFBXUl9DTEtfRElTX0JJVAkJCUJJVCg0KQ0KKyNkZWZpbmUgUFdSX1NSQU1f
Q0xLSVNPX0JJVAkJQklUKDUpDQorI2RlZmluZSBQV1JfU1JBTV9JU09JTlRfQl9CSVQJCUJJVCg2
KQ0KIA0KICNkZWZpbmUgUFdSX1NUQVRVU19DT05OCQkJQklUKDEpDQogI2RlZmluZSBQV1JfU1RB
VFVTX0RJU1AJCQlCSVQoMykNCkBAIC0yOTAsNiArMjkzLDE0IEBAIHN0YXRpYyBpbnQgc2Nwc3lz
X3NyYW1fZW5hYmxlKHN0cnVjdCBzY3BfZG9tYWluICpzY3BkLCB2b2lkIF9faW9tZW0gKmN0bF9h
ZGRyKQ0KIAkJCXJldHVybiByZXQ7DQogCX0NCiANCisJaWYgKE1US19TQ1BEX0NBUFMoc2NwZCwg
TVRLX1NDUERfU1JBTV9JU08pKQl7DQorCQl2YWwgPSByZWFkbChjdGxfYWRkcikgfCBQV1JfU1JB
TV9JU09JTlRfQl9CSVQ7DQorCQl3cml0ZWwodmFsLCBjdGxfYWRkcik7DQorCQl1ZGVsYXkoMSk7
DQorCQl2YWwgJj0gflBXUl9TUkFNX0NMS0lTT19CSVQ7DQorCQl3cml0ZWwodmFsLCBjdGxfYWRk
cik7DQorCX0NCisNCiAJcmV0dXJuIDA7DQogfQ0KIA0KQEAgLTI5OSw4ICszMTAsMTUgQEAgc3Rh
dGljIGludCBzY3BzeXNfc3JhbV9kaXNhYmxlKHN0cnVjdCBzY3BfZG9tYWluICpzY3BkLCB2b2lk
IF9faW9tZW0gKmN0bF9hZGRyKQ0KIAl1MzIgcGRuX2FjayA9IHNjcGQtPmRhdGEtPnNyYW1fcGRu
X2Fja19iaXRzOw0KIAlpbnQgdG1wOw0KIA0KLQl2YWwgPSByZWFkbChjdGxfYWRkcik7DQotCXZh
bCB8PSBzY3BkLT5kYXRhLT5zcmFtX3Bkbl9iaXRzOw0KKwlpZiAoTVRLX1NDUERfQ0FQUyhzY3Bk
LCBNVEtfU0NQRF9TUkFNX0lTTykpCXsNCisJCXZhbCA9IHJlYWRsKGN0bF9hZGRyKSB8IFBXUl9T
UkFNX0NMS0lTT19CSVQ7DQorCQl3cml0ZWwodmFsLCBjdGxfYWRkcik7DQorCQl2YWwgJj0gflBX
Ul9TUkFNX0lTT0lOVF9CX0JJVDsNCisJCXdyaXRlbCh2YWwsIGN0bF9hZGRyKTsNCisJCXVkZWxh
eSgxKTsNCisJfQ0KKw0KKwl2YWwgPSByZWFkbChjdGxfYWRkcikgfCBzY3BkLT5kYXRhLT5zcmFt
X3Bkbl9iaXRzOw0KIAl3cml0ZWwodmFsLCBjdGxfYWRkcik7DQogDQogCS8qIEVpdGhlciB3YWl0
IHVudGlsIFNSQU1fUEROX0FDSyBhbGwgMSBvciAwICovDQotLSANCjEuOC4xLjEuZGlydHkNCg==


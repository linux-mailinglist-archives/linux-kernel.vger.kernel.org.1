Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C60E428EB6C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 05:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbgJODVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 23:21:04 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:40144 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727068AbgJODVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 23:21:04 -0400
X-UUID: 3d48116d62944f248749f8682ed8a4ac-20201015
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=2RA0I88lr0d0hGwKF//MrgxKAUGZdVtcyAh7Z0um5Ig=;
        b=HzZ+Dou9Ufrtmz+lqGPgPcFxh/4ut/deBN7Nga87UPMiM+FQ88g6zckrzEPO+XaN065Gfwq1jKEhmJk7qH81ScbhXJgRPZCdcHyBoFx0y+7mxajy56vP8xBLcRFLhT4Z2z/rg9h7N5iCp8hyX3XRP2Bp8GxdPEui3BY0lbqO6J8=;
X-UUID: 3d48116d62944f248749f8682ed8a4ac-20201015
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <neal.liu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1971189239; Thu, 15 Oct 2020 11:21:00 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 15 Oct 2020 11:20:46 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 15 Oct 2020 11:20:47 +0800
From:   Neal Liu <neal.liu@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
CC:     Neal Liu <neal.liu@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>
Subject: [PATCH v8 1/2] dt-bindings: devapc: add bindings for mtk-devapc
Date:   Thu, 15 Oct 2020 11:20:38 +0800
Message-ID: <1602732039-12179-2-git-send-email-neal.liu@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1602732039-12179-1-git-send-email-neal.liu@mediatek.com>
References: <1602732039-12179-1-git-send-email-neal.liu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIGJpbmRpbmdzIGZvciBtdGstZGV2YXBjLg0KDQpTaWduZWQtb2ZmLWJ5OiBOZWFsIExpdSA8
bmVhbC5saXVAbWVkaWF0ZWsuY29tPg0KLS0tDQogLi4uL2RldmljZXRyZWUvYmluZGluZ3Mvc29j
L21lZGlhdGVrL2RldmFwYy55YW1sICAgfCAgIDU4ICsrKysrKysrKysrKysrKysrKysrDQogMSBm
aWxlIGNoYW5nZWQsIDU4IGluc2VydGlvbnMoKykNCiBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvYy9tZWRpYXRlay9kZXZhcGMueWFtbA0KDQpk
aWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvYy9tZWRpYXRl
ay9kZXZhcGMueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb2MvbWVk
aWF0ZWsvZGV2YXBjLnlhbWwNCm5ldyBmaWxlIG1vZGUgMTAwNjQ0DQppbmRleCAwMDAwMDAwLi42
Yzc2M2Y4DQotLS0gL2Rldi9udWxsDQorKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3Mvc29jL21lZGlhdGVrL2RldmFwYy55YW1sDQpAQCAtMCwwICsxLDU4IEBADQorIyBTUERY
LUxpY2Vuc2UtSWRlbnRpZmllcjogKEdQTC0yLjAgT1IgQlNELTItQ2xhdXNlKQ0KKyMgIyBDb3B5
cmlnaHQgMjAyMCBNZWRpYVRlayBJbmMuDQorJVlBTUwgMS4yDQorLS0tDQorJGlkOiAiaHR0cDov
L2RldmljZXRyZWUub3JnL3NjaGVtYXMvc29jL21lZGlhdGVrL2RldmFwYy55YW1sIyINCiskc2No
ZW1hOiAiaHR0cDovL2RldmljZXRyZWUub3JnL21ldGEtc2NoZW1hcy9jb3JlLnlhbWwjIg0KKw0K
K3RpdGxlOiBNZWRpYVRlayBEZXZpY2UgQWNjZXNzIFBlcm1pc3Npb24gQ29udHJvbCBkcml2ZXIN
CisNCitkZXNjcmlwdGlvbjogfA0KKyAgTWVkaWFUZWsgYnVzIGZhYnJpYyBwcm92aWRlcyBUcnVz
dFpvbmUgc2VjdXJpdHkgc3VwcG9ydCBhbmQgZGF0YQ0KKyAgcHJvdGVjdGlvbiB0byBwcmV2ZW50
IHNsYXZlcyBmcm9tIGJlaW5nIGFjY2Vzc2VkIGJ5IHVuZXhwZWN0ZWQgbWFzdGVycy4NCisgIFRo
ZSBzZWN1cml0eSB2aW9sYXRpb24gaXMgbG9nZ2VkIGFuZCBzZW50IHRvIHRoZSBwcm9jZXNzb3Ig
Zm9yIGZ1cnRoZXINCisgIGFuYWx5c2lzIGFuZCBjb3VudGVybWVhc3VyZXMuDQorDQorbWFpbnRh
aW5lcnM6DQorICAtIE5lYWwgTGl1IDxuZWFsLmxpdUBtZWRpYXRlay5jb20+DQorDQorcHJvcGVy
dGllczoNCisgIGNvbXBhdGlibGU6DQorICAgIGVudW06DQorICAgICAgLSBtZWRpYXRlayxtdDY3
NzktZGV2YXBjDQorDQorICByZWc6DQorICAgIGRlc2NyaXB0aW9uOiBUaGUgYmFzZSBhZGRyZXNz
IG9mIGRldmFwYyByZWdpc3RlciBiYW5rDQorICAgIG1heEl0ZW1zOiAxDQorDQorICBpbnRlcnJ1
cHRzOg0KKyAgICBkZXNjcmlwdGlvbjogQSBzaW5nbGUgaW50ZXJydXB0IHNwZWNpZmllcg0KKyAg
ICBtYXhJdGVtczogMQ0KKw0KKyAgY2xvY2tzOg0KKyAgICBkZXNjcmlwdGlvbjogQ29udGFpbnMg
bW9kdWxlIGNsb2NrIHNvdXJjZSBhbmQgY2xvY2sgbmFtZXMNCisgICAgbWF4SXRlbXM6IDENCisN
CisgIGNsb2NrLW5hbWVzOg0KKyAgICBkZXNjcmlwdGlvbjogTmFtZXMgb2YgdGhlIGNsb2NrcyBs
aXN0IGluIGNsb2NrcyBwcm9wZXJ0eQ0KKyAgICBtYXhJdGVtczogMQ0KKw0KK3JlcXVpcmVkOg0K
KyAgLSBjb21wYXRpYmxlDQorICAtIHJlZw0KKyAgLSBpbnRlcnJ1cHRzDQorICAtIGNsb2Nrcw0K
KyAgLSBjbG9jay1uYW1lcw0KKw0KK2V4YW1wbGVzOg0KKyAgLSB8DQorICAgICNpbmNsdWRlIDxk
dC1iaW5kaW5ncy9pbnRlcnJ1cHQtY29udHJvbGxlci9hcm0tZ2ljLmg+DQorICAgICNpbmNsdWRl
IDxkdC1iaW5kaW5ncy9jbG9jay9tdDY3NzktY2xrLmg+DQorDQorICAgIGRldmFwYzogZGV2YXBj
QDEwMjA3MDAwIHsNCisgICAgICBjb21wYXRpYmxlID0gIm1lZGlhdGVrLG10Njc3OS1kZXZhcGMi
Ow0KKyAgICAgIHJlZyA9IDwweDEwMjA3MDAwIDB4MTAwMD47DQorICAgICAgaW50ZXJydXB0cyA9
IDxHSUNfU1BJIDE2OCBJUlFfVFlQRV9MRVZFTF9MT1c+Ow0KKyAgICAgIGNsb2NrcyA9IDwmaW5m
cmFjZmdfYW8gQ0xLX0lORlJBX0RFVklDRV9BUEM+Ow0KKyAgICAgIGNsb2NrLW5hbWVzID0gImRl
dmFwYy1pbmZyYS1jbG9jayI7DQorICAgIH07DQotLSANCjEuNy45LjUNCg==


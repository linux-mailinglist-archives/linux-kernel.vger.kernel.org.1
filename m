Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9A3C269E29
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 08:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbgIOGAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 02:00:55 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:13015 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726057AbgIOGAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 02:00:49 -0400
X-UUID: 7efd92434d7949d9a004ddacb481b448-20200915
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=iHk/Tb8hmYsRyxGTjsN+iuA08DZBLpkgjndj3Jtnz5o=;
        b=GGRcZNpT/LvqPJP2ElaNa822WvYBDcRhLbsBSY7L3aNQda1xPuI5ERHrA8E+UFdjcvm1MVW515CQtR3UqXcH8iwONBpPMan72nxXKgX+5xacyvga5ej3+fs4E9fB5mmj8HwLneIPL4T+4Y8xZbJMZ/kdHuFvtcyBxIgZas9JtGw=;
X-UUID: 7efd92434d7949d9a004ddacb481b448-20200915
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <wenbin.mei@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1933444950; Tue, 15 Sep 2020 14:00:46 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 15 Sep 2020 14:00:44 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 15 Sep 2020 14:00:43 +0800
From:   Wenbin Mei <wenbin.mei@mediatek.com>
CC:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        Wenbin Mei <wenbin.mei@mediatek.com>
Subject: [PATCH 1/3] mmc: dt-bindings: add support for MT8192 SoC
Date:   Tue, 15 Sep 2020 13:58:33 +0800
Message-ID: <20200915055835.25590-2-wenbin.mei@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200915055835.25590-1-wenbin.mei@mediatek.com>
References: <20200915055835.25590-1-wenbin.mei@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TVQ4MTkyIG1tYyBob3N0IGlwIGlzIGNvbXBhdGlibGUgd2l0aCBNVDgxODMuDQpBZGQgc3VwcG9y
dCBmb3IgdGhpcy4NCg0KU2lnbmVkLW9mZi1ieTogV2VuYmluIE1laSA8d2VuYmluLm1laUBtZWRp
YXRlay5jb20+DQotLS0NCiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbW1jL210
ay1zZC50eHQgfCA2ICsrKysrLQ0KIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDEg
ZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9tbWMvbXRrLXNkLnR4dCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9t
bWMvbXRrLXNkLnR4dA0KaW5kZXggMjZhOGYzMjBhMTU2Li42NDIyYWQ3ZDQzOWQgMTAwNjQ0DQot
LS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbW1jL210ay1zZC50eHQNCisr
KyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tbWMvbXRrLXNkLnR4dA0KQEAg
LTEwLDcgKzEwLDcgQEAgUmVxdWlyZWQgcHJvcGVydGllczoNCiAtIGNvbXBhdGlibGU6IHZhbHVl
IHNob3VsZCBiZSBlaXRoZXIgb2YgdGhlIGZvbGxvd2luZy4NCiAJIm1lZGlhdGVrLG10ODEzNS1t
bWMiOiBmb3IgbW1jIGhvc3QgaXAgY29tcGF0aWJsZSB3aXRoIG10ODEzNQ0KIAkibWVkaWF0ZWss
bXQ4MTczLW1tYyI6IGZvciBtbWMgaG9zdCBpcCBjb21wYXRpYmxlIHdpdGggbXQ4MTczDQotCSJt
ZWRpYXRlayxtdDgxODMtbW1jIjogZm9yIG1tYyBob3N0IGlwIGNvbXBhdGlibGUgd2l0aCBtdDgx
ODMNCisJIm1lZGlhdGVrLG10ODE5Mi1tbWMiLCAibWVkaWF0ZWssbXQ4MTgzLW1tYyI6IGZvciBt
bWMgaG9zdCBpcCBjb21wYXRpYmxlIHdpdGggbXQ4MTgzDQogCSJtZWRpYXRlayxtdDg1MTYtbW1j
IjogZm9yIG1tYyBob3N0IGlwIGNvbXBhdGlibGUgd2l0aCBtdDg1MTYNCiAJIm1lZGlhdGVrLG10
Njc3OS1tbWMiOiBmb3IgbW1jIGhvc3QgaXAgY29tcGF0aWJsZSB3aXRoIG10Njc3OQ0KIAkibWVk
aWF0ZWssbXQyNzAxLW1tYyI6IGZvciBtbWMgaG9zdCBpcCBjb21wYXRpYmxlIHdpdGggbXQyNzAx
DQpAQCAtMjcsNiArMjcsMTAgQEAgUmVxdWlyZWQgcHJvcGVydGllczoNCiAJImhjbGsiIC0gSENM
SyB3aGljaCB1c2VkIGZvciBob3N0IChyZXF1aXJlZCkNCiAJInNvdXJjZV9jZyIgLSBpbmRlcGVu
ZGVudCBzb3VyY2UgY2xvY2sgZ2F0ZSAocmVxdWlyZWQgZm9yIE1UMjcxMikNCiAJImJ1c19jbGsi
IC0gYnVzIGNsb2NrIHVzZWQgZm9yIGludGVybmFsIHJlZ2lzdGVyIGFjY2VzcyAocmVxdWlyZWQg
Zm9yIE1UMjcxMiBNU0RDMC8zKQ0KKwkic3lzX2NnIiAtIG1zZGMgc3Vic3lzIGNsb2NrIGdhdGUg
KHJlcXVpcmVkIGZvciBNVDgxOTIpDQorCSJwY2xrX2NnIiAtIHBlcmlwaGVyYWwgYnVzIGNsb2Nr
IGdhdGUgKHJlcXVpcmVkIGZvciBNVDgxOTIpDQorCSJheGlfY2ciIC0gQVhJIGJ1cyBjbG9jayBn
YXRlIChyZXF1aXJlZCBmb3IgTVQ4MTkyKQ0KKwkiYWhiX2NnIiAtIEFIQiBidXMgY2xvY2sgZ2F0
ZSAocmVxdWlyZWQgZm9yIE1UODE5MikNCiAtIHBpbmN0cmwtbmFtZXM6IHNob3VsZCBiZSAiZGVm
YXVsdCIsICJzdGF0ZV91aHMiDQogLSBwaW5jdHJsLTA6IHNob3VsZCBjb250YWluIGRlZmF1bHQv
aGlnaCBzcGVlZCBwaW4gY3RybA0KIC0gcGluY3RybC0xOiBzaG91bGQgY29udGFpbiB1aHMgbW9k
ZSBwaW4gY3RybA0KLS0gDQoyLjE4LjANCg==


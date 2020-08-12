Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAAF62427C5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Aug 2020 11:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727911AbgHLJio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Aug 2020 05:38:44 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:29638 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727017AbgHLJib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 05:38:31 -0400
X-UUID: 3c61768a41c345b8939f8af611591b97-20200812
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=ogFDjQCtEcopOszOYsMoc/JjscsAanywEY3yR0IlUMY=;
        b=csPrVxKCxTe5smr0IUeJCXH0eXxwjE4Gi1a0opIDhGIanfnvckAiYSEXULkadEVK2WTUB6mMl/t3CTWTrd2gZSaAHNshDpnOlLzE1mqmcslzErWAv0glO9RzBIi7maZTNyGabNB5aYVLVG2at2f2pqejHI6zZ5gX0Ixg2ZduhXs=;
X-UUID: 3c61768a41c345b8939f8af611591b97-20200812
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <wenbin.mei@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 178852734; Wed, 12 Aug 2020 17:38:27 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 12 Aug 2020 17:38:26 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 12 Aug 2020 17:38:25 +0800
From:   Wenbin Mei <wenbin.mei@mediatek.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        Wenbin Mei <wenbin.mei@mediatek.com>
Subject: [PATCH 2/3] arm64: dts: mt7622: add reset node for mmc device
Date:   Wed, 12 Aug 2020 17:37:25 +0800
Message-ID: <20200812093726.10123-3-wenbin.mei@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200812093726.10123-1-wenbin.mei@mediatek.com>
References: <20200812093726.10123-1-wenbin.mei@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBjb21taXQgYWRkcyByZXNldCBub2RlIGZvciBtbWMgZGV2aWNlLg0KDQpTaWduZWQtb2Zm
LWJ5OiBXZW5iaW4gTWVpIDx3ZW5iaW4ubWVpQG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGFyY2gvYXJt
NjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ3NjIyLmR0c2kgfCAyICsrDQogMSBmaWxlIGNoYW5nZWQs
IDIgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9tZWRp
YXRlay9tdDc2MjIuZHRzaSBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ3NjIyLmR0
c2kNCmluZGV4IDFhMzllMGVmNzc2Yi4uNWI5ZWMwMzJjZThkIDEwMDY0NA0KLS0tIGEvYXJjaC9h
cm02NC9ib290L2R0cy9tZWRpYXRlay9tdDc2MjIuZHRzaQ0KKysrIGIvYXJjaC9hcm02NC9ib290
L2R0cy9tZWRpYXRlay9tdDc2MjIuZHRzaQ0KQEAgLTY4Niw2ICs2ODYsOCBAQA0KIAkJY2xvY2tz
ID0gPCZwZXJpY2ZnIENMS19QRVJJX01TREMzMF8wX1BEPiwNCiAJCQkgPCZ0b3Bja2dlbiBDTEtf
VE9QX01TREM1MF8wX1NFTD47DQogCQljbG9jay1uYW1lcyA9ICJzb3VyY2UiLCAiaGNsayI7DQor
CQlyZXNldHMgPSA8JnBlcmljZmcgTVQ3NjIyX1BFUklfTVNEQzBfU1dfUlNUPjsNCisJCXJlc2V0
LW5hbWVzID0gImhyc3QiOw0KIAkJc3RhdHVzID0gImRpc2FibGVkIjsNCiAJfTsNCiANCi0tIA0K
Mi4xOC4wDQo=


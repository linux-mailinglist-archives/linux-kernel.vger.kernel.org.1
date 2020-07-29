Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE27231A6F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jul 2020 09:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbgG2Hjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jul 2020 03:39:49 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:2401 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726290AbgG2Hjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 03:39:49 -0400
X-UUID: 8659ffe249e3428e81cf13ed42f5532b-20200729
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=Ziu9RVkLC78aEOY1MEgT8/CO2GXVUt9odl7fiCsyBTo=;
        b=FPlMU8kTfLhxjtjievhmrVgqOJyCwxrUx1NxjyIbYOSi8b1tJDp/1fT6s1o/FzxhLA6VixgV0nFsf4bbtxYRGo9I2hJ6peSaU7GOlXhs12zscbqT7KQAhWBW9R2oroe8Q6PPmAITYqXsDOecPw/hbv8ARCp2JADEm9WN3MHRDNI=;
X-UUID: 8659ffe249e3428e81cf13ed42f5532b-20200729
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <crystal.guo@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 451770969; Wed, 29 Jul 2020 15:39:46 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 29 Jul 2020 15:39:44 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 29 Jul 2020 15:39:45 +0800
From:   Crystal Guo <crystal.guo@mediatek.com>
To:     <p.zabel@pengutronix.de>, <robh+dt@kernel.org>,
        <matthias.bgg@gmail.com>
CC:     <srv_heupstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <seiya.wang@mediatek.com>
Subject: [PATCH 0/2] adjust the reset assert and deassert interface 
Date:   Wed, 29 Jul 2020 15:39:15 +0800
Message-ID: <1596008357-11213-1-git-send-email-crystal.guo@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MS4gYWRqdXN0IHRoZSByZXNldCBhc3NlcnQgYW5kIGRlYXNzZXJ0IGludGVyZmFjZQ0KdG8gbWFr
ZSBpdCBtb3JlIGNvbXBhdGlibGUuDQoyLiBhZGQgaW5mcmFjZmdfcnN0IGRldmljZSBub2RlLg0K
DQpDcnlzdGFsIEd1byAoMik6DQogIHJlc2V0LWNvbnRyb2xsZXI6IHRpOiBhZGp1c3QgdGhlIHJl
c2V0IGFzc2VydCBhbmQgZGVhc3NlcnQgaW50ZXJmYWNlDQogIGFybTY0OiBkdHM6IG10ODE5Mjog
YWRkIGluZnJhY2ZnX3JzdCBub2RlDQoNCiBhcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210
ODE5Mi5kdHNpIHwgMTAgKysrKysrKysrLQ0KIGRyaXZlcnMvcmVzZXQvcmVzZXQtdGktc3lzY29u
LmMgICAgICAgICAgfCAxMyArKysrKysrKysrKy0tDQogMiBmaWxlcyBjaGFuZ2VkLCAyMCBpbnNl
cnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0K


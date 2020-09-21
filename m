Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE8152721DC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 13:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgIULJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 07:09:23 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:44164 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726436AbgIULJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 07:09:21 -0400
X-UUID: 8cd7bd493aff40a3883d106a3eebfeac-20200921
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=fpzOG0X71zzG1KUuoZmURiigMLk58k6qDYDOQDvWkFE=;
        b=KyOFN1+nuSaEARSiGzu0RLcrLZtbcQlog4tLnm79PdYauCVy8V0Hq/LLVeW2zB0jk5Q22dRL6k/rmKkoEe2TJI0sw7Esx7/LvMKh65KbSUNgFgfSuwJLtqo1FW5zsKTbw1b38AGmlS/ZAEzuBL4d49gGxrT6YPvHZoCYAuKcvWs=;
X-UUID: 8cd7bd493aff40a3883d106a3eebfeac-20200921
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <hsin-hsiung.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2112370116; Mon, 21 Sep 2020 19:04:13 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 21 Sep 2020 19:04:10 +0800
Received: from mtksdaap41.mediatek.inc (172.21.77.4) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 21 Sep 2020 19:04:12 +0800
From:   Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Argus Lin <argus.lin@mediatek.com>, <drinkcat@chromium.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Subject: [PATCH v3 1/4] soc: mediatek: pwrap: use BIT() macro
Date:   Mon, 21 Sep 2020 19:03:52 +0800
Message-ID: <1600686235-27979-2-git-send-email-hsin-hsiung.wang@mediatek.com>
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1600686235-27979-1-git-send-email-hsin-hsiung.wang@mediatek.com>
References: <1600686235-27979-1-git-send-email-hsin-hsiung.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VXNlIGEgYmV0dGVyIEJJVCgpIG1hcmNvIGZvciB0aGUgYml0IGRlZmluaXRpb24uDQpObyBmdW5j
dGlvbmFsIGNoYW5nZXMsIGNsZWFudXAgb25seS4NCg0KU2lnbmVkLW9mZi1ieTogSHNpbi1Ic2l1
bmcgV2FuZyA8aHNpbi1oc2l1bmcud2FuZ0BtZWRpYXRlay5jb20+DQotLS0NCiBkcml2ZXJzL3Nv
Yy9tZWRpYXRlay9tdGstcG1pYy13cmFwLmMgfCA0ICsrLS0NCiAxIGZpbGUgY2hhbmdlZCwgMiBp
bnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9zb2Mv
bWVkaWF0ZWsvbXRrLXBtaWMtd3JhcC5jIGIvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLXBtaWMt
d3JhcC5jDQppbmRleCA1ZDM0ZThiLi5jODk3MjA1IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9zb2Mv
bWVkaWF0ZWsvbXRrLXBtaWMtd3JhcC5jDQorKysgYi9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGst
cG1pYy13cmFwLmMNCkBAIC0yNyw4ICsyNyw4IEBADQogI2RlZmluZSBQV1JBUF9HRVRfV0FDU19S
REFUQSh4KQkJKCgoeCkgPj4gMCkgJiAweDAwMDBmZmZmKQ0KICNkZWZpbmUgUFdSQVBfR0VUX1dB
Q1NfRlNNKHgpCQkoKCh4KSA+PiAxNikgJiAweDAwMDAwMDA3KQ0KICNkZWZpbmUgUFdSQVBfR0VU
X1dBQ1NfUkVRKHgpCQkoKCh4KSA+PiAxOSkgJiAweDAwMDAwMDAxKQ0KLSNkZWZpbmUgUFdSQVBf
U1RBVEVfU1lOQ19JRExFMAkJKDEgPDwgMjApDQotI2RlZmluZSBQV1JBUF9TVEFURV9JTklUX0RP
TkUwCQkoMSA8PCAyMSkNCisjZGVmaW5lIFBXUkFQX1NUQVRFX1NZTkNfSURMRTAJCUJJVCgyMCkN
CisjZGVmaW5lIFBXUkFQX1NUQVRFX0lOSVRfRE9ORTAJCUJJVCgyMSkNCiANCiAvKiBtYWNybyBm
b3IgV0FDUyBGU00gKi8NCiAjZGVmaW5lIFBXUkFQX1dBQ1NfRlNNX0lETEUJCTB4MDANCi0tIA0K
Mi42LjQNCg==


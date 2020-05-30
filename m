Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BAD81E8F92
	for <lists+linux-kernel@lfdr.de>; Sat, 30 May 2020 10:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729076AbgE3IOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 May 2020 04:14:49 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:49567 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728714AbgE3IOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 04:14:49 -0400
X-UUID: 11797482bec04e01b6a966c3f3c81497-20200530
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=SWQLIAAgnR9ULkgQxorPTLK17ffBPPOrLx7kQhABhQE=;
        b=nknKiFnPJnofugrBiFTfr4X9mWknMm4siSXwaSunMGif6ps86b4/QYOIaJt+LNnkd7jkM+q9G9V9MjXiJ6gJE4/4oqKmVLHaeizsUYkx85GrUZGOjW2RXnFMXLKPfXiGd2wHz2G8bmthSSkKmxSpnF72ipUBGXtWlsUnvJZILJc=;
X-UUID: 11797482bec04e01b6a966c3f3c81497-20200530
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 128070; Sat, 30 May 2020 16:14:45 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 30 May 2020 16:14:42 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 30 May 2020 16:14:42 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Evan Green <evgreen@chromium.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Tomasz Figa <tfiga@google.com>,
        Will Deacon <will.deacon@arm.com>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <yong.wu@mediatek.com>,
        <youlin.pei@mediatek.com>, Nicolas Boichat <drinkcat@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>, <anan.sun@mediatek.com>,
        <cui.zhang@mediatek.com>, <chao.hao@mediatek.com>,
        <ming-fan.chen@mediatek.com>, <eizan@chromium.org>,
        <acourbot@chromium.org>
Subject: [PATCH v4 15/17] arm: dts: mediatek: Get rid of mediatek,larb for MM nodes
Date:   Sat, 30 May 2020 16:10:16 +0800
Message-ID: <1590826218-23653-16-git-send-email-yong.wu@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1590826218-23653-1-git-send-email-yong.wu@mediatek.com>
References: <1590826218-23653-1-git-send-email-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWZ0ZXIgYWRkaW5nIGRldmljZV9saW5rIGJldHdlZW4gdGhlIElPTU1VIGNvbnN1bWVyIGFuZCBz
bWksDQp0aGUgbWVkaWF0ZWssbGFyYiBpcyB1bm5lY2Vzc2FyeSBub3cuDQoNCkNDOiBNYXR0aGlh
cyBCcnVnZ2VyIDxtYXR0aGlhcy5iZ2dAZ21haWwuY29tPg0KU2lnbmVkLW9mZi1ieTogWW9uZyBX
dSA8eW9uZy53dUBtZWRpYXRlay5jb20+DQpSZXZpZXdlZC1ieTogRXZhbiBHcmVlbiA8ZXZncmVl
bkBjaHJvbWl1bS5vcmc+DQotLS0NCiBhcmNoL2FybS9ib290L2R0cy9tdDI3MDEuZHRzaSB8IDEg
LQ0KIGFyY2gvYXJtL2Jvb3QvZHRzL210NzYyMy5kdHNpIHwgMSAtDQogMiBmaWxlcyBjaGFuZ2Vk
LCAyIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvbXQyNzAx
LmR0c2kgYi9hcmNoL2FybS9ib290L2R0cy9tdDI3MDEuZHRzaQ0KaW5kZXggMjA5M2IzOC4uNzlk
YTk0YyAxMDA2NDQNCi0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL210MjcwMS5kdHNpDQorKysgYi9h
cmNoL2FybS9ib290L2R0cy9tdDI3MDEuZHRzaQ0KQEAgLTU2NCw3ICs1NjQsNiBAQA0KIAkJY2xv
Y2stbmFtZXMgPSAianBnZGVjLXNtaSIsDQogCQkJICAgICAgImpwZ2RlYyI7DQogCQlwb3dlci1k
b21haW5zID0gPCZzY3BzeXMgTVQyNzAxX1BPV0VSX0RPTUFJTl9JU1A+Ow0KLQkJbWVkaWF0ZWss
bGFyYiA9IDwmbGFyYjI+Ow0KIAkJaW9tbXVzID0gPCZpb21tdSBNVDI3MDFfTTRVX1BPUlRfSlBH
REVDX1dETUE+LA0KIAkJCSA8JmlvbW11IE1UMjcwMV9NNFVfUE9SVF9KUEdERUNfQlNETUE+Ow0K
IAl9Ow0KZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL210NzYyMy5kdHNpIGIvYXJjaC9h
cm0vYm9vdC9kdHMvbXQ3NjIzLmR0c2kNCmluZGV4IGY3NmI0YTMuLmYzMzQwMzkgMTAwNjQ0DQot
LS0gYS9hcmNoL2FybS9ib290L2R0cy9tdDc2MjMuZHRzaQ0KKysrIGIvYXJjaC9hcm0vYm9vdC9k
dHMvbXQ3NjIzLmR0c2kNCkBAIC03ODMsNyArNzgzLDYgQEANCiAJCWNsb2NrLW5hbWVzID0gImpw
Z2RlYy1zbWkiLA0KIAkJCSAgICAgICJqcGdkZWMiOw0KIAkJcG93ZXItZG9tYWlucyA9IDwmc2Nw
c3lzIE1UMjcwMV9QT1dFUl9ET01BSU5fSVNQPjsNCi0JCW1lZGlhdGVrLGxhcmIgPSA8JmxhcmIy
PjsNCiAJCWlvbW11cyA9IDwmaW9tbXUgTVQyNzAxX000VV9QT1JUX0pQR0RFQ19XRE1BPiwNCiAJ
CQkgPCZpb21tdSBNVDI3MDFfTTRVX1BPUlRfSlBHREVDX0JTRE1BPjsNCiAJfTsNCi0tIA0KMS45
LjENCg==


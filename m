Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8553B29266E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 13:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbgJSLhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 07:37:36 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:48503 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725799AbgJSLhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 07:37:35 -0400
X-UUID: c1b147055df648459a539ae96bd73431-20201019
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=aNtNGXeJLGDumINEjf9bWj2sEZwVw3nV2iDSgN4Ie4I=;
        b=mp2XzjekOuzWMA059D20L/sxhoiNY9V2AElGv9X5dTgtrDawc3SYTRZEWfXze9qEdYozfZuQaKTDwZUfQTH4Mas0z+RgDp4Hhhgpk+c5tLqs+HZS+swjcnimr6C/xUL3Y83t7Fks4VEbjekVZCqjvtNNG8Xxz4zuFwr3uOtE8Sg=;
X-UUID: c1b147055df648459a539ae96bd73431-20201019
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <chao.hao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1952249611; Mon, 19 Oct 2020 19:37:31 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 19 Oct 2020 19:37:28 +0800
Received: from localhost.localdomain (10.15.20.246) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 19 Oct 2020 19:37:27 +0800
From:   Chao Hao <chao.hao@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Yong Wu <yong.wu@mediatek.com>, FY Yang <fy.yang@mediatek.com>,
        Jun Wen <jun.wen@mediatek.com>,
        Mingyuan Ma <mingyuan.ma@mediatek.com>,
        Chao Hao <chao.hao@mediatek.com>
Subject: [PATCH 0/4] MTK_IOMMU: Optimize mapping / unmapping performance
Date:   Mon, 19 Oct 2020 19:30:56 +0800
Message-ID: <20201019113100.23661-1-chao.hao@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 15E5CB9EC7FD0FD48D83E2456A7D282C07A92B4951C0BD41AB454EE3475C52ED2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ICAgIEZvciBNVEsgcGxhdGZvcm1zLCBtdGtfaW9tbXUgaXMgdXNpbmcgaW90bGJfc3luYygpLCB0
bGJfYWRkX3JhbmdlKCkgYW5kIHRsYl9mbHVzaF93YWxrL2xlYWYoKQ0KdG8gZG8gdGxiIHN5bmMg
d2hlbiBpb21tdSBkcml2ZXIgcnVucyBpb3ZhIG1hcHBpbmcvdW5tYXBwaW5nLiBCdXQgaWYgYnVm
ZmVyIHNpemUgaXMgbGFyZ2UsDQppdCBtYXliZSBjb25zaXN0IG9mIG1hbnkgcGFnZXMoNEsvOEsv
NjRLLzFNQi4uLi4uLikuIFNvIGlvbW11IGRyaXZlciBtYXliZSBydW4gbWFueSB0aW1lcyB0bGIN
CnN5bmMgaW4gbWFwcGluZyBmb3IgdGhpcyBjYXNlIGFuZCBpdCB3aWxsIGRlZ3JhZGUgcGVyZm9y
bWFuY2Ugc2VyaW91c2x5LiBJbiBvcmRlciB0byByZXNvbHZlIHRoZQ0KaXNzdWUsIHdlIGhvcGUg
dG8gYWRkIGlvdGxiX3N5bmNfcmFuZ2UoKSBjYWxsYmFjayBpbiBpb21tdV9vcHMsIGl0IGNhbiBh
cHBpb250IGlvdmEgYW5kIHNpemUgdG8NCmRvIHRsYiBzeW5jLiBNVEtfSU9NTVUgd2lsbCB1c2Ug
aW90bGJfc3luY19yYW5nZSgpIGNhbGxiYWNrIHdoZW4gdGhlIHdob2xlIG1hcHBpbmcvdW5tYXBw
aW5nIGlzDQpjb21wbGV0ZWQgYW5kIHJlbW92ZSBpb3RsYl9zeW5jKCksIHRsYl9hZGRfcmFuZ2Uo
KSBhbmQgdGxiX2ZsdXNoX3dhbGsvbGVhZigpLg0KICAgIFNvIHRoaXMgcGF0Y2hzZXQgd2lsbCBy
ZXBsYWNlIGlvdGxiX3N5bmMoKSwgdGxiX2FkZF9yYW5nZSgpIGFuZCB0bGJfZmx1c2hfd2Fsay9s
ZWFmKCkgd2l0aA0KaW90bGJfc3luY19yYW5nZSgpIGNhbGxiYWNrLg0KDQpDaGFvIEhhbyAoNCk6
DQogIGlvbW11OiBJbnRyb2R1Y2UgaW90bGJfc3luY19yYW5nZSBjYWxsYmFjaw0KICBpb21tdS9t
ZWRpYXRlazogQWRkIGlvdGxiX3N5bmNfcmFuZ2UoKSBzdXBwb3J0DQogIGlvbW11L21lZGlhdGVr
OiBSZW1vdmUgdW5uZWNlc3NhcnkgdGxiIHN5bmMNCiAgaW9tbXUvbWVkaWF0ZWs6IEFkanVzdCBp
b3RsYl9zeW5jX3JhbmdlDQoNCiAgICBkcml2ZXJzL2lvbW11L2RtYS1pb21tdS5jIHwgIDkgKysr
KysrKysrDQogICAgZHJpdmVycy9pb21tdS9pb21tdS5jICAgICB8ICA3ICsrKysrKysNCiAgICBk
cml2ZXJzL2lvbW11L210a19pb21tdS5jIHwgMzYgKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tDQogICAgaW5jbHVkZS9saW51eC9pb21tdS5oICAgICB8ICAyICsrDQogICAgNCBm
aWxlcyBjaGFuZ2VkLCAyNiBpbnNlcnRpb25zKCspLCAyOCBkZWxldGlvbnMoLSkNCg0KLS0NCjIu
MTguMA0K


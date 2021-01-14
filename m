Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC0542F57E9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 04:01:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730129AbhANCLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 21:11:13 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:51583 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729290AbhANCLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 21:11:09 -0500
X-UUID: df674fde194541ecae0c9f7ea8dc16ed-20210114
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=NuaaCNSxyNSThWbdoMr70KINtL4T/OZl54vOvTQmmwg=;
        b=BXScZta3ncBRPC9X66QojVlwS4EJsagj+w02cNU/vpYwQMuzQ9WiU1gyOPDo63Wl9dbmm2pcNPvV2cjuVMT1oE3IRgzqDf1XxAtA3Nkk5ZASTp7rgKI7x60TXACl8e9ZMevNsGFeyucFYOHUaBau1Nahy7mosSUc78DpDebOhUk=;
X-UUID: df674fde194541ecae0c9f7ea8dc16ed-20210114
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1618630623; Thu, 14 Jan 2021 10:10:22 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 14 Jan
 2021 10:10:19 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 14 Jan 2021 10:10:18 +0800
Message-ID: <1610590218.30053.2.camel@mhfsdcap03>
Subject: Re: [PATCH -next] phy: mediatek: Mark mtk_mipi_tx_driver with
 static keyword
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Zou Wei <zou_wei@huawei.com>
CC:     <chunkuang.hu@kernel.org>, <p.zabel@pengutronix.de>,
        <kishon@ti.com>, <vkoul@kernel.org>, <matthias.bgg@gmail.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Date:   Thu, 14 Jan 2021 10:10:18 +0800
In-Reply-To: <1610415484-92497-1-git-send-email-zou_wei@huawei.com>
References: <1610415484-92497-1-git-send-email-zou_wei@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: FCE73643E55E92ED26370A94CFD667C3147589CB9C210729EA13CD4E6D5BFDB62000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIxLTAxLTEyIGF0IDA5OjM4ICswODAwLCBab3UgV2VpIHdyb3RlOg0KPiBGaXgg
dGhlIGZvbGxvd2luZyBzcGFyc2Ugd2FybmluZzoNCj4gDQo+IGRyaXZlcnMvcGh5L21lZGlhdGVr
L3BoeS1tdGstbWlwaS1kc2kuYzoyMzc6MjQ6IHdhcm5pbmc6IHN5bWJvbCAnbXRrX21pcGlfdHhf
ZHJpdmVyJyB3YXMgbm90IGRlY2xhcmVkLiBTaG91bGQgaXQgYmUgc3RhdGljPw0KPiANCj4gU2ln
bmVkLW9mZi1ieTogWm91IFdlaSA8em91X3dlaUBodWF3ZWkuY29tPg0KPiAtLS0NCj4gIGRyaXZl
cnMvcGh5L21lZGlhdGVrL3BoeS1tdGstbWlwaS1kc2kuYyB8IDIgKy0NCj4gIDEgZmlsZSBjaGFu
Z2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvcGh5L21lZGlhdGVrL3BoeS1tdGstbWlwaS1kc2kuYyBiL2RyaXZlcnMvcGh5L21lZGlh
dGVrL3BoeS1tdGstbWlwaS1kc2kuYw0KPiBpbmRleCAxOGM0ODEyLi5lZWIzNTdiIDEwMDY0NA0K
PiAtLS0gYS9kcml2ZXJzL3BoeS9tZWRpYXRlay9waHktbXRrLW1pcGktZHNpLmMNCj4gKysrIGIv
ZHJpdmVycy9waHkvbWVkaWF0ZWsvcGh5LW10ay1taXBpLWRzaS5jDQo+IEBAIC0yMzQsNyArMjM0
LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgbXRrX21pcGlfdHhfbWF0Y2hb
XSA9IHsNCj4gIAl7IH0sDQo+ICB9Ow0KPiAgDQo+IC1zdHJ1Y3QgcGxhdGZvcm1fZHJpdmVyIG10
a19taXBpX3R4X2RyaXZlciA9IHsNCj4gK3N0YXRpYyBzdHJ1Y3QgcGxhdGZvcm1fZHJpdmVyIG10
a19taXBpX3R4X2RyaXZlciA9IHsNCj4gIAkucHJvYmUgPSBtdGtfbWlwaV90eF9wcm9iZSwNCj4g
IAkucmVtb3ZlID0gbXRrX21pcGlfdHhfcmVtb3ZlLA0KPiAgCS5kcml2ZXIgPSB7DQoNCkFja2Vk
LWJ5OiBDaHVuZmVuZyBZdW4gPGNodW5mZW5nLnl1bkBtZWRpYXRlay5jb20+DQoNClRoYW5rcw0K
DQo=


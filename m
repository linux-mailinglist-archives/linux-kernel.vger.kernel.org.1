Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D49DA27805A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 08:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbgIYGMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 02:12:49 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:29696 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726925AbgIYGMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 02:12:49 -0400
X-UUID: ca91c8de334844188ba5b3e29ade168b-20200925
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=lCgaTSUPHWkgc/8WNh9JxAl73KwNmTV0GbbyUTGaT54=;
        b=J6mnUGz1e9K24qgubeFCUWDeUgaHlgClywkXoQTu1FoTr1XQi3w7qt0s7iOlgxLEHQfYreht65cUAgIb64Ur/jijly25/AHW9XI2FGXEGzfDv51lGSmm8nvJgrEqEtcz1DkQVhfdlaYrs2uAPR5XH/zF2XxZ4ompABryIifaSEs=;
X-UUID: ca91c8de334844188ba5b3e29ade168b-20200925
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 320742147; Fri, 25 Sep 2020 14:12:45 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS32N2.mediatek.inc
 (172.27.4.72) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 25 Sep
 2020 14:12:43 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 25 Sep 2020 14:12:44 +0800
Message-ID: <1601014218.29336.1.camel@mhfsdcap03>
Subject: Re: [PATCH 01/11] usb: gadget: bdc: fix improper SPDX comment style
 for header file
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Felipe Balbi <balbi@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "Al Cooper" <alcooperx@gmail.com>,
        Sasi Kumar <sasi.kumar@broadcom.com>,
        "Nathan Chancellor" <natechancellor@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Fri, 25 Sep 2020 14:10:18 +0800
In-Reply-To: <1601013499-28920-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1601013499-28920-1-git-send-email-chunfeng.yun@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 89EE0F742F0CA53589BE25D621EC5784B4073B641089054406C361DAE99296EC2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEZlbGlwZSwNCg0KICAgIFNvcnJ5LCBwbGVhc2UgaWdub3JlIHRoZSBzZXJpZXMhIGZvcmdl
dCB2ZXJzaW9uIGNoYW5nZXMgbG9nDQoNCk9uIEZyaSwgMjAyMC0wOS0yNSBhdCAxMzo1OCArMDgw
MCwgQ2h1bmZlbmcgWXVuIHdyb3RlOg0KPiBGb3IgQyBoZWFkZXIgZmlsZXMgRG9jdW1lbnRhdGlv
bi9wcm9jZXNzL2xpY2Vuc2UtcnVsZXMucnN0DQo+IG1hbmRhdGVzIEMtbGlrZSBjb21tZW50cyAo
b3Bwb3NlZCB0byBDIHNvdXJjZSBmaWxlcyB3aGVyZQ0KPiBDKysgc3R5bGUgc2hvdWxkIGJlIHVz
ZWQpLg0KPiANCj4gQ2hhbmdlLUlkOiBJNzBhZDIwMzhlMjBiYTkyNDk3MDI4ZDY4N2M2MmQ2M2M5
ZmY5Mzk5MQ0KPiBDYzogRmxvcmlhbiBGYWluZWxsaSA8Zi5mYWluZWxsaUBnbWFpbC5jb20+DQo+
IFNpZ25lZC1vZmYtYnk6IENodW5mZW5nIFl1biA8Y2h1bmZlbmcueXVuQG1lZGlhdGVrLmNvbT4N
Cj4gQWNrZWQtYnk6IEZsb3JpYW4gRmFpbmVsbGkgPGYuZmFpbmVsbGlAZ21haWwuY29tPg0KPiAt
LS0NCj4gIGRyaXZlcnMvdXNiL2dhZGdldC91ZGMvYmRjL2JkYy5oICAgICB8IDIgKy0NCj4gIGRy
aXZlcnMvdXNiL2dhZGdldC91ZGMvYmRjL2JkY19jbWQuaCB8IDIgKy0NCj4gIGRyaXZlcnMvdXNi
L2dhZGdldC91ZGMvYmRjL2JkY19kYmcuaCB8IDIgKy0NCj4gIGRyaXZlcnMvdXNiL2dhZGdldC91
ZGMvYmRjL2JkY19lcC5oICB8IDIgKy0NCj4gIDQgZmlsZXMgY2hhbmdlZCwgNCBpbnNlcnRpb25z
KCspLCA0IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2dhZGdl
dC91ZGMvYmRjL2JkYy5oIGIvZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9iZGMvYmRjLmgNCj4gaW5k
ZXggYWM3NWUyNS4uZmNiYTc3ZSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZ2FkZ2V0L3Vk
Yy9iZGMvYmRjLmgNCj4gKysrIGIvZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9iZGMvYmRjLmgNCj4g
QEAgLTEsNCArMSw0IEBADQo+IC0vLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMCsN
Cj4gKy8qIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wKyAqLw0KPiAgLyoNCj4gICAq
IGJkYy5oIC0gaGVhZGVyIGZvciB0aGUgQlJDTSBCREMgVVNCMy4wIGRldmljZSBjb250cm9sbGVy
DQo+ICAgKg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9iZGMvYmRjX2Nt
ZC5oIGIvZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9iZGMvYmRjX2NtZC5oDQo+IGluZGV4IDI5Y2M5
ODguLjM3M2U2NzQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2dhZGdldC91ZGMvYmRjL2Jk
Y19jbWQuaA0KPiArKysgYi9kcml2ZXJzL3VzYi9nYWRnZXQvdWRjL2JkYy9iZGNfY21kLmgNCj4g
QEAgLTEsNCArMSw0IEBADQo+IC0vLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMCsN
Cj4gKy8qIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wKyAqLw0KPiAgLyoNCj4gICAq
IGJkY19jbWQuaCAtIGhlYWRlciBmb3IgdGhlIEJEQyBkZWJ1ZyBmdW5jdGlvbnMNCj4gICAqDQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9nYWRnZXQvdWRjL2JkYy9iZGNfZGJnLmggYi9kcml2
ZXJzL3VzYi9nYWRnZXQvdWRjL2JkYy9iZGNfZGJnLmgNCj4gaW5kZXggMzczZDVhYi4uODU5ZDU4
OCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9iZGMvYmRjX2RiZy5oDQo+
ICsrKyBiL2RyaXZlcnMvdXNiL2dhZGdldC91ZGMvYmRjL2JkY19kYmcuaA0KPiBAQCAtMSw0ICsx
LDQgQEANCj4gLS8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wKw0KPiArLyogU1BE
WC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjArICovDQo+ICAvKg0KPiAgICogYmRjX2RiZy5o
IC0gaGVhZGVyIGZvciB0aGUgQkRDIGRlYnVnIGZ1bmN0aW9ucw0KPiAgICoNCj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvdXNiL2dhZGdldC91ZGMvYmRjL2JkY19lcC5oIGIvZHJpdmVycy91c2IvZ2Fk
Z2V0L3VkYy9iZGMvYmRjX2VwLmgNCj4gaW5kZXggYTM3ZmY4MDMuLjViYmQ3M2YgMTAwNjQ0DQo+
IC0tLSBhL2RyaXZlcnMvdXNiL2dhZGdldC91ZGMvYmRjL2JkY19lcC5oDQo+ICsrKyBiL2RyaXZl
cnMvdXNiL2dhZGdldC91ZGMvYmRjL2JkY19lcC5oDQo+IEBAIC0xLDQgKzEsNCBAQA0KPiAtLy8g
U1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjArDQo+ICsvKiBTUERYLUxpY2Vuc2UtSWRl
bnRpZmllcjogR1BMLTIuMCsgKi8NCj4gIC8qDQo+ICAgKiBiZGNfZXAuaCAtIGhlYWRlciBmb3Ig
dGhlIEJEQyBkZWJ1ZyBmdW5jdGlvbnMNCj4gICAqDQoNCg==


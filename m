Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7052D2051
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 02:52:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbgLHBus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 20:50:48 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:37151 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727075AbgLHBus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 20:50:48 -0500
X-UUID: fdbb80fd9bda4663a4dd7c600d47bb8f-20201208
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=dCzH311+U2RFvjPiv7C+GlVUPgKHpvOsRKaE8jAB0UM=;
        b=dAks2qEQ9ToMg60OeCOyZKIZs2vHSPVaZtFyg63SUZxre5J+IYe0U1+QO+yv1ePO/vFjjqU/SyP7MLSZZaCooHp4ruB658gHV+xp9vdN4SCpMhIqYRxEan8hqQf+B6Fnp6IGd8zktk8cW25wiYpPb0JDnroWJRsQBsnmEJCFsXc=;
X-UUID: fdbb80fd9bda4663a4dd7c600d47bb8f-20201208
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 630910657; Tue, 08 Dec 2020 09:50:04 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by mtkmbs05n2.mediatek.inc
 (172.21.101.140) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 8 Dec
 2020 09:49:59 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 8 Dec 2020 09:49:57 +0800
Message-ID: <1607392202.23328.1.camel@mhfsdcap03>
Subject: Re: [PATCH][next] drm/mediatek: avoid dereferencing a null hdmi_phy
 on an error message
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Colin King <colin.king@canonical.com>
CC:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        "Vinod Koul" <vkoul@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        CK Hu <ck.hu@mediatek.com>,
        chunhui dai <chunhui.dai@mediatek.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Date:   Tue, 8 Dec 2020 09:50:02 +0800
In-Reply-To: <20201207150937.170435-1-colin.king@canonical.com>
References: <20201207150937.170435-1-colin.king@canonical.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIwLTEyLTA3IGF0IDE1OjA5ICswMDAwLCBDb2xpbiBLaW5nIHdyb3RlOg0KPiBG
cm9tOiBDb2xpbiBJYW4gS2luZyA8Y29saW4ua2luZ0BjYW5vbmljYWwuY29tPg0KPiANCj4gQ3Vy
cmVudGx5IHRoZXJlIGlzIGEgbnVsbCBwb2ludGVyIGNoZWNrIGZvciBoZG1pX3BoeSB0aGF0IGlt
cGxpZXMgaXQNCj4gbWF5IGJlIG51bGwsIGhvd2V2ZXIgYSBkZXZfZXJyIG1lc3NhZ2VzIGRlcmVm
ZXJlbmNlcyB0aGlzIHBvdGVudGlhbCBudWxsDQo+IHBvaW50ZXIuICBBdm9pZCBhIG51bGwgcG9p
bnRlciBkZXJlZmVyZW5jZSBieSBvbmx5IGVtaXR0aW5nIHRoZSBkZXZfZXJyDQo+IG1lc3NhZ2Ug
aWYgaGRtaV9waHkgaXMgbm9uLW51bGwuICBJdCBpcyBhIG1vb3QgcG9pbnQgaWYgdGhlIGVycm9y
IG1lc3NhZ2UNCj4gbmVlZHMgdG8gYmUgcHJpbnRlZCBhdCBhbGwsIGJ1dCBzaW5jZSB0aGlzIGlz
IGEgcmVsYXRpdmVseSBuZXcgcGllY2Ugb2YNCj4gY29kZSBpdCBtYXkgYmUgdXNlZnVsIHRvIGtl
ZXAgdGhlIG1lc3NhZ2UgaW4gZm9yIHRoZSBtb21lbnQgaW4gY2FzZSB0aGVyZQ0KPiBhcmUgdW5m
b3JzZWVuIGVycm9ycyB0aGF0IG5lZWQgdG8gYmUgcmVwb3J0ZWQuDQo+IA0KPiBBZGRyZXNzZXMt
Q292ZXJpdHk6ICgiRGVyZWZlcmVuY2UgYWZ0ZXIgbnVsbCBjaGVjayIpDQo+IEZpeGVzOiBiZTI4
YjY1MDdjNDYgKCJkcm0vbWVkaWF0ZWs6IHNlcGFyYXRlIGhkbWkgcGh5IHRvIGRpZmZlcmVudCBm
aWxlIikNCj4gU2lnbmVkLW9mZi1ieTogQ29saW4gSWFuIEtpbmcgPGNvbGluLmtpbmdAY2Fub25p
Y2FsLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL3BoeS9tZWRpYXRlay9waHktbXRrLWhkbWkuYyB8
IDUgKysrLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25z
KC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9waHkvbWVkaWF0ZWsvcGh5LW10ay1oZG1p
LmMgYi9kcml2ZXJzL3BoeS9tZWRpYXRlay9waHktbXRrLWhkbWkuYw0KPiBpbmRleCBjNWM2MWY1
YTllYTAuLjUxODQwNTQ3ODNjNyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9waHkvbWVkaWF0ZWsv
cGh5LW10ay1oZG1pLmMNCj4gKysrIGIvZHJpdmVycy9waHkvbWVkaWF0ZWsvcGh5LW10ay1oZG1p
LmMNCj4gQEAgLTg0LDggKzg0LDkgQEAgbXRrX2hkbWlfcGh5X2Rldl9nZXRfb3BzKGNvbnN0IHN0
cnVjdCBtdGtfaGRtaV9waHkgKmhkbWlfcGh5KQ0KPiAgCSAgICBoZG1pX3BoeS0+Y29uZi0+aGRt
aV9waHlfZGlzYWJsZV90bWRzKQ0KPiAgCQlyZXR1cm4gJm10a19oZG1pX3BoeV9kZXZfb3BzOw0K
PiAgDQo+IC0JZGV2X2VycihoZG1pX3BoeS0+ZGV2LCAiRmFpbGVkIHRvIGdldCBkZXYgb3BzIG9m
IHBoeVxuIik7DQo+IC0JCXJldHVybiBOVUxMOw0KPiArCWlmIChoZG1pX3BoeSkNCj4gKwkJZGV2
X2VycihoZG1pX3BoeS0+ZGV2LCAiRmFpbGVkIHRvIGdldCBkZXYgb3BzIG9mIHBoeVxuIik7DQo+
ICsJCQlyZXR1cm4gTlVMTDsNCmluZGVudGF0aW9uOiBvbmUgdGFiIGJlZm9yZSByZXR1cm4NCg0K
VGhhbmtzDQoNCj4gIH0NCj4gIA0KPiAgc3RhdGljIHZvaWQgbXRrX2hkbWlfcGh5X2Nsa19nZXRf
ZGF0YShzdHJ1Y3QgbXRrX2hkbWlfcGh5ICpoZG1pX3BoeSwNCg0K


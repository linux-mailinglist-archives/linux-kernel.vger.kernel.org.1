Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3458327A7E8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 08:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbgI1Gvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 02:51:41 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:48894 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726500AbgI1Gvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 02:51:41 -0400
X-UUID: 238671beb2044579afeb92c29822c7ae-20200928
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=ZIUaceumbl3OuzrfVA/f+7ZBWsOjorzDG0TaTJcF+6w=;
        b=pnvLvjJ5pWd31E+G3gaeOr/RZlBFkYvVmX4J7/LQXHd3lfFIvvaKYlAHKTntcevon0NJ+yEDeai8Z4HS+Z0/sfPEQr+JcF6PzGUu2AQNtcEtNZ4iw2R+s4YJ/OMy9yMkzHiqC005sFF3EtOvJJ3mgD2Mt5QWnqQSX3Hwr3o/HSg=;
X-UUID: 238671beb2044579afeb92c29822c7ae-20200928
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1298793269; Mon, 28 Sep 2020 14:51:38 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 28 Sep
 2020 14:51:35 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 28 Sep 2020 14:51:35 +0800
Message-ID: <1601275744.29336.12.camel@mhfsdcap03>
Subject: Re: [PATCH] usb: bdc: Remove duplicate error message in bdc_probe()
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Tang Bin <tangbin@cmss.chinamobile.com>,
        Florian Fainelli <f.fainelli@gmail.com>
CC:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Date:   Mon, 28 Sep 2020 14:49:04 +0800
In-Reply-To: <20200927134218.20028-1-tangbin@cmss.chinamobile.com>
References: <20200927134218.20028-1-tangbin@cmss.chinamobile.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 0CC7E5F65798740D2F00DBE933E94735415EE091B9C774C61530EA3FA037D85D2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU3VuLCAyMDIwLTA5LTI3IGF0IDIxOjQyICswODAwLCBUYW5nIEJpbiB3cm90ZToNCj4gSW4g
dGhpcyBmdW5jdGlvbiwgd2UgZG9uJ3QgbmVlZCBkZXZfZXJyKCkgbWVzc2FnZSBiZWNhdXNlDQo+
IHdoZW4gc29tZXRoaW5nIGdvZXMgd3JvbmcsIGRldm1fcGxhdGZvcm1faW9yZW1hcF9yZXNvdXJj
ZSgpDQo+IGNhbiBwcmludCBhbiBlcnJvciBtZXNzYWdlIGl0c2VsZiwgc28gcmVtb3ZlIHRoZSBy
ZWR1bmRhbnQNCj4gb25lLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogWmhhbmcgU2hlbmdqdSA8emhh
bmdzaGVuZ2p1QGNtc3MuY2hpbmFtb2JpbGUuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBUYW5nIEJp
biA8dGFuZ2JpbkBjbXNzLmNoaW5hbW9iaWxlLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL3VzYi9n
YWRnZXQvdWRjL2JkYy9iZGNfY29yZS5jIHwgNCArLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBp
bnNlcnRpb24oKyksIDMgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91
c2IvZ2FkZ2V0L3VkYy9iZGMvYmRjX2NvcmUuYyBiL2RyaXZlcnMvdXNiL2dhZGdldC91ZGMvYmRj
L2JkY19jb3JlLmMNCj4gaW5kZXggMDJhM2E3NzQ2Li45NDU0ZjE3OWUgMTAwNjQ0DQo+IC0tLSBh
L2RyaXZlcnMvdXNiL2dhZGdldC91ZGMvYmRjL2JkY19jb3JlLmMNCj4gKysrIGIvZHJpdmVycy91
c2IvZ2FkZ2V0L3VkYy9iZGMvYmRjX2NvcmUuYw0KPiBAQCAtNTA4LDEwICs1MDgsOCBAQCBzdGF0
aWMgaW50IGJkY19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgCWJkYy0+
Y2xrID0gY2xrOw0KPiAgDQo+ICAJYmRjLT5yZWdzID0gZGV2bV9wbGF0Zm9ybV9pb3JlbWFwX3Jl
c291cmNlKHBkZXYsIDApOw0KPiAtCWlmIChJU19FUlIoYmRjLT5yZWdzKSkgew0KPiAtCQlkZXZf
ZXJyKGRldiwgImlvcmVtYXAgZXJyb3JcbiIpOw0KPiArCWlmIChJU19FUlIoYmRjLT5yZWdzKSkN
Cj4gIAkJcmV0dXJuIC1FTk9NRU07DQo+IC0JfQ0KPiAgCWlycSA9IHBsYXRmb3JtX2dldF9pcnEo
cGRldiwgMCk7DQo+ICAJaWYgKGlycSA8IDApDQo+ICAJCXJldHVybiBpcnE7DQoNCkNjIGJkYydz
IG1haW50YWluZXI6ICBGbG9yaWFuIEZhaW5lbGxpIDxmLmZhaW5lbGxpQGdtYWlsLmNvbT4NCg0K
DQo=


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27FC32AF59B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 16:59:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbgKKP7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 10:59:05 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:37941 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727192AbgKKP7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 10:59:04 -0500
X-UUID: fbfa9ce520b8440ba02a50fb1c484593-20201111
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=Ste1icU3DVNbnobIM6zMofzRAX/dGTbHxAlHO294JNA=;
        b=Cm47PrEEtoMCw+2opJKm7xN50jWct6i5oQmwyxbLoPFZUdr8cYFI6u5rOT0Dyd3adr1J3mWsnF6Wz7VMAeEADQyV7lE8oKMN2rAgzku4crFFJrJoJtI6KIzE7j+VAY3PDwmbT9Kg3/ZoAbLZCZY0MSWaGG1MI2f7tlvKk65xIiA=;
X-UUID: fbfa9ce520b8440ba02a50fb1c484593-20201111
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <frankie.chang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1229333882; Wed, 11 Nov 2020 23:59:01 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 11 Nov 2020 23:58:58 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 11 Nov 2020 23:58:58 +0800
Message-ID: <1605110339.11768.38.camel@mtkswgap22>
Subject: Re: [PATCH v14 1/3] binder: move structs from core file to header
 file
From:   Frankie Chang <Frankie.Chang@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Martijn Coenen <maco@android.com>,
        Arve =?ISO-8859-1?Q?Hj=F8nnev=E5g?= <arve@android.com>,
        Christian Brauner <christian@brauner.io>,
        <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>,
        Jian-Min Liu <Jian-Min.Liu@mediatek.com>
Date:   Wed, 11 Nov 2020 23:58:59 +0800
In-Reply-To: <X6v/b+uMi+GwyDAC@kroah.com>
References: <X6uT941IJ3uf/7aE@kroah.com>
         <1605106964-25838-1-git-send-email-Frankie.Chang@mediatek.com>
         <1605106964-25838-2-git-send-email-Frankie.Chang@mediatek.com>
         <X6v/b+uMi+GwyDAC@kroah.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIwLTExLTExIGF0IDE2OjEyICswMTAwLCBHcmVnIEtyb2FoLUhhcnRtYW4gd3Jv
dGU6DQo+IE9uIFdlZCwgTm92IDExLCAyMDIwIGF0IDExOjAyOjQyUE0gKzA4MDAsIEZyYW5raWUg
Q2hhbmcgd3JvdGU6DQo+ID4gRnJvbTogIkZyYW5raWUuQ2hhbmciIDxGcmFua2llLkNoYW5nQG1l
ZGlhdGVrLmNvbT4NCj4gPiANCj4gPiBNb3ZpbmcgYWxsIHN0cnVjdHMgdG8gaGVhZGVyIGZpbGUg
bWFrZXMgbW9kdWxlIG1vcmUNCj4gPiBleHRlbmRhYmxlLCBhbmQgbWFrZXMgYWxsIHRoZXNlIHN0
cnVjdHMgdG8gYmUgZGVmaW5lZA0KPiA+IGluIHRoZSBzYW1lIGZpbGUuDQo+ID4gDQo+ID4gU2ln
bmVkLW9mZi1ieTogRnJhbmtpZS5DaGFuZyA8RnJhbmtpZS5DaGFuZ0BtZWRpYXRlay5jb20+DQo+
ID4gQWNrZWQtYnk6IFRvZGQgS2pvcyA8dGtqb3NAZ29vZ2xlLmNvbT4NCj4gPiAtLS0NCj4gPiAg
ZHJpdmVycy9hbmRyb2lkL2JpbmRlci5jICAgICAgICAgIHwgIDQwNiAtLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ID4gIGRyaXZlcnMvYW5kcm9pZC9iaW5kZXJfaW50ZXJu
YWwuaCB8ICA0MDYgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ICAy
IGZpbGVzIGNoYW5nZWQsIDQwNiBpbnNlcnRpb25zKCspLCA0MDYgZGVsZXRpb25zKC0pDQo+IA0K
PiBUaGlzLCBhbmQgcGF0Y2ggMi8zIHdhcyBhbHJlYWR5IGFjY2VwdGVkLCByaWdodD8NCj4gDQo+
IEkgY2FuJ3QgZG8gYW55dGhpbmcgd2l0aCB0aGVtIGFnYWluIDopDQo+IA0KT2gsIG9rYXkgOikN
Cg0KbWFueSB0aGFua3MNCkZyYW5raWUgQ2hhbmcNCg0KDQo=


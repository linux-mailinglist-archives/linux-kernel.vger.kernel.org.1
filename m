Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD4E82AD084
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 08:33:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730198AbgKJHdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 02:33:10 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:46146 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727001AbgKJHdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 02:33:08 -0500
X-UUID: 05c074f14c3948ab8c43208c91891eaa-20201110
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=U9JPfHBGR2WvVwwvA92XGk3LKUs9KDklcKzR3vYxzLI=;
        b=V9Kdsh6NnNthQWlgKv6FqhGWS/8sw2Yf4iW94prY9kPNsGzDXEmFR1Olbk4xYqn+exgtiQSBdx+2pFpntMokaUUQ6BxnDnkRvyjyt70ruJelzxi34b5L346kOIfOGVjbkhHwxDuTpAhdF1stdi7/jjO2vg6pzvmSyBrlSbg9Kuw=;
X-UUID: 05c074f14c3948ab8c43208c91891eaa-20201110
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <frankie.chang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1381648892; Tue, 10 Nov 2020 15:33:02 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 10 Nov 2020 15:33:01 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 10 Nov 2020 15:33:01 +0800
Message-ID: <1604993580.14886.5.camel@mtkswgap22>
Subject: Re: binder: add transaction latency tracer
From:   Frankie Chang <Frankie.Chang@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Martijn Coenen <maco@android.com>,
        Arve =?ISO-8859-1?Q?Hj=F8nnev=E5g?= <arve@android.com>,
        Christian Brauner <christian@brauner.io>,
        <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>,
        Jian-Min Liu <Jian-Min.Liu@mediatek.com>
Date:   Tue, 10 Nov 2020 15:33:00 +0800
In-Reply-To: <20201109174605.GA2426739@kroah.com>
References: <1602781377-4278-1-git-send-email-Frankie.Chang@mediatek.com>
         <1603987737-2763-1-git-send-email-Frankie.Chang@mediatek.com>
         <20201109174605.GA2426739@kroah.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: D2AB75E8C3179218C34EE1323F174F5208CC03FD4132D950F7C409C4ED3434102000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIwLTExLTA5IGF0IDE4OjQ2ICswMTAwLCBHcmVnIEtyb2FoLUhhcnRtYW4gd3Jv
dGU6DQo+IE9uIEZyaSwgT2N0IDMwLCAyMDIwIGF0IDEyOjA4OjU0QU0gKzA4MDAsIEZyYW5raWUg
Q2hhbmcgd3JvdGU6DQo+ID4gQ2hhbmdlIGZyb20gdjExOg0KPiA+ICAgLSByZWJhc2UuDQo+IA0K
PiBUaGlzIHdob2xlIHBhdGNoIHNldCBpcyBzZW50IHdpdGggRE9TIGxpbmUtZW5kcywgd2hpY2gg
bWFrZXMgZ2l0IHJlYWxseQ0KPiB1bmhhcHB5IHdoZW4gaXQgdHJpZXMgdG8gYXBwbHkgaXQsIGFz
IHJpZ2h0ZnVsbHksIGl0IGRvZXNuJ3Qga25vdyBob3cgdG8NCj4gY29udmVydCB0aGluZ3MuDQo+
IA0KSG1tLi4sIGFjdHVhbGx5IEkgY2FuIHVzZSAnZ2l0IGFwcGx5JyBQQVRDSCB2MTEgZnJvbSB0
aGUgbWVzc2FnZQ0KZGlyZWN0bHkuDQoNCj4gUGxlYXNlIHJlc2VuZCB0aGlzIHBhdGNoIHNlcmll
cyBhcyBhIHBsYWluLXRleHQgcGF0Y2ggc2VyaWVzLiAgUGVyaGFwcw0KPiB1c2luZyBnaXQgc2Vu
ZC1lbWFpbD8gIFNvbWV0aGluZyBpcyBjb252ZXJ0aW5nIHRoZXNlIHBhdGNoZXMgdG8gYW4gb2Rk
DQo+IGVuY29kaW5nIHdoaWNoIG1ha2VzIHRoZW0gbm90IGFibGUgdG8gYmUgYXBwbGllZC4NCj4g
DQpBbmQgSSBzZW50IHRoZSBwYXRjaCBzZXQgdXNpbmcgZ2l0IHNlbmQtZW1haWwuIEhlbmNlLCBJ
IGFtIG5vdCBzdXJlIHdoYXQNCmhhcHBlbmVkIHdoZW4gdGhlIHBhdGNoIHNldCBzZW50IHRvIG90
aGVycy4NCg0KPiBUcnkgc2VuZGluZyB0aGVtIHRvIHlvdXJzZWxmIGZpcnN0LCBhbmQgc2VlaW5n
IGlmIHlvdSBjYW4gYXBwbHkgdGhlbQ0KPiBmcm9tIHRoZSBtZXNzYWdlcyBkaXJlY3RseSwgYW5k
IGlmIHNvLCB0aGVuIHJlc2VuZCB0aGVtLg0KPiANCkJ1dCBJIHdpbGwgc3RpbGwgdmVyaWZ5IGxv
Y2FsbHkgYW5kIHJlc2VuZCBhZ2Fpbi4NCg0KdGhhbmtzDQoNCkZyYW5raWUgQ2hhbmcNCg0K


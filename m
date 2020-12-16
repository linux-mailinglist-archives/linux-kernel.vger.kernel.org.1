Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B75222DB9A1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 04:26:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725771AbgLPDZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 22:25:04 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:54439 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725765AbgLPDZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 22:25:03 -0500
X-UUID: a95baaf95d9b45128311ad90be283fc6-20201216
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=IfRl0dkrWmGs552oR509pYEf+cV5Pv30Kj/jNbHmajw=;
        b=bYL7jj4OL/Hy/eq10Z0Qt5SpYZ5KGs9xA9Li5LSrM1AtvMvOnIrg7QCShNgvabFIai7GdY3nE5gxiyndppmETOxGt0RHRA0CtuZ11Bdyed8sj8t+1GR7PUJe7dNiGbTveb0AxGvjZXC7ySuxMbpfkTfAYqnuTp11f5vMq28EBfs=;
X-UUID: a95baaf95d9b45128311ad90be283fc6-20201216
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <hsin-hsiung.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1301583531; Wed, 16 Dec 2020 11:24:15 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 16 Dec 2020 11:24:15 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 16 Dec 2020 11:24:14 +0800
Message-ID: <1608089054.12432.1.camel@mtksdaap41>
Subject: Re: [PATCH v3 5/8] regulator: mt6359: Add support for MT6359
 regulator
From:   Hsin-hsiung Wang <hsin-hsiung.wang@mediatek.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        Wen Su <wen.su@mediatek.com>
Date:   Wed, 16 Dec 2020 11:24:14 +0800
In-Reply-To: <20201215115602.GA4738@sirena.org.uk>
References: <1606103290-15034-1-git-send-email-hsin-hsiung.wang@mediatek.com>
         <1606103290-15034-6-git-send-email-hsin-hsiung.wang@mediatek.com>
         <20201124170732.GI4933@sirena.org.uk> <1608024188.29527.2.camel@mtksdaap41>
         <20201215115602.GA4738@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQpPbiBUdWUsIDIwMjAtMTItMTUgYXQgMTE6NTYgKzAwMDAsIE1hcmsgQnJvd24gd3JvdGU6
DQo+IE9uIFR1ZSwgRGVjIDE1LCAyMDIwIGF0IDA1OjIzOjA4UE0gKzA4MDAsIEhzaW4taHNpdW5n
IFdhbmcgd3JvdGU6DQo+ID4gT24gVHVlLCAyMDIwLTExLTI0IGF0IDE3OjA3ICswMDAwLCBNYXJr
IEJyb3duIHdyb3RlOg0KPiANCj4gPiA+IFRoaXMgbG9va3MgbGlrZSBpdCBjb3VsZCBqdXN0IGJl
IHJlZ21hcF9nZXRfdm9sdGFnZV9zZWxfcmVnbWFwKCk/DQo+ID4gPiBPdGhlcndpc2UgdGhlIGRy
aXZlciBsb29rcyBnb29kLg0KPiANCj4gPiBUaGFua3MgZm9yIHRoZSByZXZpZXcuDQo+ID4gTVQ2
MzU5IHJlZ3VsYXRvciBoYXMgc2VsX3JlZyBhbmQgc3RhdHVzX3JlZywgc28gd2UgdXNlDQo+ID4g
bXQ2MzU5X2dldF9saW5lYXJfdm9sdGFnZV9zZWwgZm9yIHN0YXR1c19yZWcgaW5zdGVhZCBvZg0K
PiA+IHJlZ21hcF9nZXRfdm9sdGFnZV9zZWxfcmVnbWFwKCkgd2hpY2ggdXNlcyBzZWxfcmVnLg0K
PiANCj4gSXMgdGhlIHNlbGVjdG9yIHJlZ2lzdGVyIG5vdCByZWFkYWJsZT8gIEluIGdlbmVyYWwg
dGhlIHJ1bGUgaXMgdGhhdCB0aGUNCj4gZ2V0IHNob3VsZCBiZSByZXBvcnRpbmcgd2hhdCB3YXMg
Y29uZmlndXJlZCwgdGhlIGFjdHVhbCBzdGF0dXMgc2hvdWxkIGJlDQo+IHJlcG9ydGVkIHNlcGFy
YXRlbHkgaWYgaXQgY2FuIGJlIHJlYWQgc2VwYXJhdGVseS4gIFdlIGRvbid0IGN1cnJlbnRseQ0K
PiBoYXZlIGEgbWVjaGFuaXNtIGZvciBkb2luZyB0aGF0IHdpdGggdm9sdGFnZSBidXQgb25lIGNv
dWxkIGJlIGFkZGVkLg0KDQpUaGFua3MgZm9yIHlvdXIgY29tbWVudHMuIFRoZSBzZWxlY3QgcmVn
aXN0ZXIgaXMgcmVhZGFibGUsIGFuZCBJIHdpbGwNCnVwZGF0ZSBpdCBpbiBuZXh0IHBhdGNoLg0K


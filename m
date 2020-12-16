Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED362DBA26
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 05:36:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725865AbgLPEfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 23:35:09 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:49574 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725820AbgLPEfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 23:35:08 -0500
X-UUID: 612f3495170f4f59bf1ef0a07a052f7c-20201216
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=MbWUyAPZzTNL6x8OSUcYZnRyRZFOEMoj2KWEeYv8KIQ=;
        b=AzYllHLMi1rCNajcsGKOTIXAnIZYGnGy+mU+iC8t6CMiET0llRMYX3rmKyc75Xt2Nk3yklqczVItpKDQt/eN3HDTUUSdxG09g9IE7bCB9l4eAUgJVsShqaX2XxYXyZ+XDxR7s2OoFb7DGva3gPgIke/9fUmL1Yx1mCBZKDaj75c=;
X-UUID: 612f3495170f4f59bf1ef0a07a052f7c-20201216
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <hsin-hsiung.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1891120541; Wed, 16 Dec 2020 12:34:21 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 16 Dec 2020 12:34:20 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 16 Dec 2020 12:34:19 +0800
Message-ID: <1608093259.2412.1.camel@mtksdaap41>
Subject: Re: [PATCH v2 3/8] dt-bindings: regulator: Add document for MT6359
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
Date:   Wed, 16 Dec 2020 12:34:19 +0800
In-Reply-To: <20200923162458.GE5707@sirena.org.uk>
References: <1600688895-9238-1-git-send-email-hsin-hsiung.wang@mediatek.com>
         <1600688895-9238-4-git-send-email-hsin-hsiung.wang@mediatek.com>
         <20200923162458.GE5707@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCk9uIFdlZCwgMjAyMC0wOS0yMyBhdCAxNzoyNCArMDEwMCwgTWFyayBCcm93biB3cm90
ZToNCj4gT24gTW9uLCBTZXAgMjEsIDIwMjAgYXQgMDc6NDg6MTBQTSArMDgwMCwgSHNpbi1Ic2l1
bmcgV2FuZyB3cm90ZToNCj4gDQo+ID4gK1JlcXVpcmVkIHByb3BlcnRpZXM6DQo+ID4gKy0gY29t
cGF0aWJsZTogIm1lZGlhdGVrLG10NjM1OS1yZWd1bGF0b3IiDQo+IA0KPiBUaGUgY29tcGF0aWJs
ZSBpc24ndCB1c2VkIGJ5IHRoZSBkcml2ZXIgKHdoaWNoIGlzIGdvb2QhKSBzbyBzaG91bGQgYmUN
Cj4gZHJvcHBlZCBmcm9tIHRoZSBiaW5kaW5nIGRvY3VtZW50Lg0KVGhhbmtzIGZvciB5b3VyIGNv
bW1lbnRzLCBidXQgSSBoYXZlIGEgcXVlc3Rpb24gYWJvdXQgaXQuDQpXaGVuIEkgcmVtb3ZlIHRo
ZSBjb21wYXRpYmxlIG5hbWUgaW4gdGhlIGR0cywgdGhlcmUgd2lsbCBiZSBzb21lIGVycm9yDQpt
ZXNzYWdlOg0KWyAgICAwLjQzNzU2Ml0gbXQ2MzU5LXJlZ3VsYXRvcjogRmFpbGVkIHRvIGxvY2F0
ZSBvZl9ub2RlIFtpZDogLTFdDQpbICAgIDAuNDQwNjEyXSBtdDYzNTktc291bmQ6IEZhaWxlZCB0
byBsb2NhdGUgb2Zfbm9kZSBbaWQ6IC0xXQ0KDQpEbyB5b3UgbWVhbiB0aGF0IHdlIGRvbid0IG5l
ZWQgYW55IGNvbXBhdGlibGUgbmFtZSBpbiBkdHMsIG1mZCBhbmQNCnJlZ3VsYXRvciBkcml2ZXI/
DQo=


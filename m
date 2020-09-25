Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6AD2278065
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 08:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbgIYGPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 02:15:01 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:56303 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726925AbgIYGPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 02:15:01 -0400
X-UUID: b13cacc5227344c1aa3ba1dd50e38450-20200925
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=5m2HSwffSuI932K1En8gKb5kFERaGLGtuyzTCslXPfc=;
        b=jgeYgyNNiBcGA7vxuVF7jRR06cqBSuf5mHsIn+UBvA0iiQ7/sKblmfJ2cl72TNKMeyPAwtsm1/Pl+b7dJ9x0uEWz8Gl3Uja4S8Ek3kewahVqzIEoRLvLVNq9WmhaglYnMrtRS6mLcZ7Q22xIvN4PSOQXRQrTfTvf4DmA+qb5D5k=;
X-UUID: b13cacc5227344c1aa3ba1dd50e38450-20200925
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 763687701; Fri, 25 Sep 2020 14:14:56 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS33DR.mediatek.inc
 (172.27.6.106) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 25 Sep
 2020 14:14:55 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 25 Sep 2020 14:14:55 +0800
Message-ID: <1601014350.29336.3.camel@mhfsdcap03>
Subject: Re: [PATCH RESEND v3 02/11] usb: gadget: bdc: remove
 bdc_ep_set_halt() declaration
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
Date:   Fri, 25 Sep 2020 14:12:30 +0800
In-Reply-To: <1601013702-29079-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1601013702-29079-1-git-send-email-chunfeng.yun@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 0ED28E65ED35707369240D5F2A3D4650E2E08390086064CF86FD6E10BFE9FAFF2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEZlbGlwZSwNCg0KICAgU29ycnkgYWdhaW4sIHBsZWFzZSBpZ25vcmUgdGhlc2Ugb25lcywg
MDEvMTEgaXMgbG9zdCwgd2lsbCByZXNlbmQNCiAgDQpPbiBGcmksIDIwMjAtMDktMjUgYXQgMTQ6
MDEgKzA4MDAsIENodW5mZW5nIFl1biB3cm90ZToNCj4gTm8gZGVmaW5pdGlvbiBmb3IgYmRjX2Vw
X3NldF9oYWx0KCksIHNvIHJlbW92ZSBpdC4NCj4gDQo+IENjOiBGbG9yaWFuIEZhaW5lbGxpIDxm
LmZhaW5lbGxpQGdtYWlsLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogQ2h1bmZlbmcgWXVuIDxjaHVu
ZmVuZy55dW5AbWVkaWF0ZWsuY29tPg0KPiBBY2tlZC1ieTogRmxvcmlhbiBGYWluZWxsaSA8Zi5m
YWluZWxsaUBnbWFpbC5jb20+DQo+IC0tLQ0KPiB2MzogYWRkIGFja2VkLWJ5IEZsb3JpYW4NCj4g
DQo+IHYyOiBhZGQgQ2MgRmxvcmlhbg0KPiAtLS0NCj4gIGRyaXZlcnMvdXNiL2dhZGdldC91ZGMv
YmRjL2JkY19jbWQuaCB8IDEgLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgZGVsZXRpb24oLSkNCj4g
DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9nYWRnZXQvdWRjL2JkYy9iZGNfY21kLmggYi9k
cml2ZXJzL3VzYi9nYWRnZXQvdWRjL2JkYy9iZGNfY21kLmgNCj4gaW5kZXggMzczZTY3NC4uYTNh
NmRiZCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9iZGMvYmRjX2NtZC5o
DQo+ICsrKyBiL2RyaXZlcnMvdXNiL2dhZGdldC91ZGMvYmRjL2JkY19jbWQuaA0KPiBAQCAtMTYs
NyArMTYsNiBAQA0KPiAgaW50IGJkY19zdG9wX2VwKHN0cnVjdCBiZGMgKiwgaW50KTsNCj4gIGlu
dCBiZGNfZXBfc2V0X3N0YWxsKHN0cnVjdCBiZGMgKiwgaW50KTsNCj4gIGludCBiZGNfZXBfY2xl
YXJfc3RhbGwoc3RydWN0IGJkYyAqLCBpbnQpOw0KPiAtaW50IGJkY19lcF9zZXRfaGFsdChzdHJ1
Y3QgYmRjX2VwICosIHUzMiAsIGludCk7DQo+ICBpbnQgYmRjX2VwX2JsYShzdHJ1Y3QgYmRjICos
IHN0cnVjdCBiZGNfZXAgKiwgZG1hX2FkZHJfdCk7DQo+ICBpbnQgYmRjX2Z1bmN0aW9uX3dha2Uo
c3RydWN0IGJkYyosIHU4KTsNCj4gIGludCBiZGNfZnVuY3Rpb25fd2FrZV9maChzdHJ1Y3QgYmRj
KiwgdTgpOw0KDQo=


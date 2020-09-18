Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6168E26F4C5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 05:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbgIRDkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 23:40:53 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:56433 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726306AbgIRDkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 23:40:53 -0400
X-UUID: f2ccb9e2603145539f453257b96be52f-20200918
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=NJWqmI9Q+3XKGNwrqS5sBa+WygmHxvHtMA8oZ41d8Zk=;
        b=oZ81HU/VxH8I4jeR1gBS/Okajoz3Gyi8WPUJOZASUU9aVxXx8fyeJJXKcuJ33c+/8aOfKyA55a2O84NBxZYWV6DBcCfZwhy8DLfLMMlbURXlnQyH5opulRViRLsYvfrxP0EYt63Fu7XRbOM+5GsP2OK4KBgL5pAkobLXDSHzuXU=;
X-UUID: f2ccb9e2603145539f453257b96be52f-20200918
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 855648462; Fri, 18 Sep 2020 11:40:45 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33N1.mediatek.inc
 (172.27.4.75) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 18 Sep
 2020 11:40:43 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 18 Sep 2020 11:40:43 +0800
Message-ID: <1600400313.20602.4.camel@mhfsdcap03>
Subject: Re: [PATCH 1/7] usb: mtu3: convert to
 devm_platform_ioremap_resource_byname
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Felipe Balbi <balbi@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Fri, 18 Sep 2020 11:38:33 +0800
In-Reply-To: <87d02y1190.fsf@kernel.org>
References: <1595404275-8449-1-git-send-email-chunfeng.yun@mediatek.com>
         <87d02y1190.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 0CC168B5AFE69E193055849BE7B64D2C4E5C6D83B9F689EBFDF4440AAEA4FFC72000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRmVsaXAsDQoNCg0KT24gTW9uLCAyMDIwLTA5LTA3IGF0IDEwOjQyICswMzAwLCBGZWxpcGUg
QmFsYmkgd3JvdGU6DQo+IEhpLA0KPiANCj4gQ2h1bmZlbmcgWXVuIDxjaHVuZmVuZy55dW5AbWVk
aWF0ZWsuY29tPiB3cml0ZXM6DQo+ID4gVXNlIGRldm1fcGxhdGZvcm1faW9yZW1hcF9yZXNvdXJj
ZV9ieW5hbWUoKSB0byBzaW1wbGlmeSBjb2RlDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBDaHVu
ZmVuZyBZdW4gPGNodW5mZW5nLnl1bkBtZWRpYXRlay5jb20+DQo+IA0KPiB3aHkgaXMgaXQgc28g
dGhhdCB5b3VyIHBhdGNoZXMgYWx3YXlzIGNvbWUgYmFzZTY0IGVuY29kZWQ/IFRoZXkgbG9vaw0K
PiBmaW5lIG9uIHRoZSBlbWFpbCBjbGllbnQsIGJ1dCB3aGVuIEkgdHJ5IHRvIHBpcGUgdGhlIG1l
c3NhZ2UgdG8gZ2l0IGFtDQo+IGl0IGFsd2F5cyBnaXZlcyBtZSBhIGxvdCBvZiB0cm91YmxlIGFu
ZCBJIGhhdmUgdG8gbWFudWFsbHkgZGVjb2RlIHRoZQ0KPiBib2R5IG9mIHlvdXIgbWVzc2FnZXMg
YW5kIHJlY29tYmluZSB3aXRoIHRoZSBwYXRjaC4NCj4gDQo+IENhbiB5b3UgdHJ5IHRvIHNlbmQg
eW91ciBwYXRjaGVzIGFzIGFjdHVhbCBwbGFpbiB0ZXh0IHdpdGhvdXQgZW5jb2RpbmcNCj4gdGhl
IGJvZHkgd2l0aCBiYXNlNjQ/DQpNaXNzZWQgdGhlIGVtYWlsLg0KDQpTb3JyeSBmb3IgaW5jb252
ZW5pZW5jZSENCklzIG9ubHkgdGhlIGNvbW1pdCBtZXNzYWdlIGJhc2U2NCBlbmNvZGVkLCBvciBp
bmNsdWRlcyB0aGUgY29kZXM/DQoNCj4gDQoNCg==


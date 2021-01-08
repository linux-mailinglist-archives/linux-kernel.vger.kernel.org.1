Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB142EED7B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 07:35:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbhAHGe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 01:34:56 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:45451 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725308AbhAHGe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 01:34:56 -0500
X-UUID: 55c8912c73be4b9ebcb8bec3238891e7-20210108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=FMnLCnisKI4QJNM0w1sFZfQNsdLpDgJ5G65JySoATkI=;
        b=soUUJ1C6hznBgM+w3yueqmo+Q4tJAZo9zIOhxZDGIG7ubUvSMl7cPvmGXuN6C+8WERRV2s3ZCTodJG056kf8nwuLhyLJ1tvbRvGLYdeBXr4VO2nsRaEDoai6ljrib4+R0Mb2Y6ca1cr47P8Nl3Fbhuu8k/Q9HR7UQCG8ZZwi5QQ=;
X-UUID: 55c8912c73be4b9ebcb8bec3238891e7-20210108
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1488119658; Fri, 08 Jan 2021 14:34:12 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 8 Jan
 2021 14:34:09 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 8 Jan 2021 14:34:08 +0800
Message-ID: <1610087648.24856.41.camel@mhfsdcap03>
Subject: Re: [PATCH v5] usb: xhci-mtk: fix unreleased bandwidth data
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Ikjoon Jang <ikjn@chromium.org>
CC:     <linux-mediatek@lists.infradead.org>, <linux-usb@vger.kernel.org>,
        "Tianping Fang" <tianping.fang@mediatek.com>,
        Zhanyong Wang <zhanyong.wang@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Date:   Fri, 8 Jan 2021 14:34:08 +0800
In-Reply-To: <20201229142406.v5.1.Id0d31b5f3ddf5e734d2ab11161ac5821921b1e1e@changeid>
References: <20201229142406.v5.1.Id0d31b5f3ddf5e734d2ab11161ac5821921b1e1e@changeid>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 84426B80790F79195531223CD2A53D05FA1963BDE08E9CE47C2D172FE34682F02000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIwLTEyLTI5IGF0IDE0OjI0ICswODAwLCBJa2pvb24gSmFuZyB3cm90ZToNCj4g
eGhjaS1tdGsgaGFzIGhvb2tzIG9uIGFkZF9lbmRwb2ludCgpIGFuZCBkcm9wX2VuZHBvaW50KCkg
ZnJvbSB4aGNpDQo+IHRvIGhhbmRsZSBpdHMgb3duIHN3IGJhbmR3aWR0aCBtYW5hZ2VtZW50cyBh
bmQgc3RvcmVzIGJhbmR3aWR0aCBkYXRhDQo+IGludG8gaW50ZXJuYWwgdGFibGUgZXZlcnkgdGlt
ZSBhZGRfZW5kcG9pbnQoKSBpcyBjYWxsZWQsDQo+IHNvIHdoZW4gYmFuZHdpZHRoIGFsbG9jYXRp
b24gZmFpbHMgYXQgb25lIGVuZHBvaW50LCBhbGwgZWFybGllcg0KPiBhbGxvY2F0aW9uIGZyb20g
dGhlIHNhbWUgaW50ZXJmYWNlIGNvdWxkIHN0aWxsIHJlbWFpbiBhdCB0aGUgdGFibGUuDQpJZiBm
YWlsZWQgdG8gYWRkIGFuIGVuZHBvaW50LCB3aWxsIGNhdXNlIGZhaWx1cmUgb2YgaXRzIGludGVy
ZmFjZQ0KY29uZmlnLCB0aGVuIHRoZSBvdGhlciBlbmRwb2ludHMgaW4gdGhlIHNhbWUgaW50ZXJm
YWNlIHdpbGwgYmUgZHJvcHBlZA0KbGF0ZXI/IHlvdSBtZWFuIHNvbWUgZW5kcG9pbnRzIGluIGFu
IGludGVyZmFjZSBtYXkgZmFpbCBidXQgd2l0aG91dA0KYWZmZWN0aW5nIGl0cyBmdW5jdGlvbj8N
Cg0KPiANCj4gVGhpcyBwYXRjaCBhZGRzIHR3byBtb3JlIGhvb2tzIGZyb20gY2hlY2tfYmFuZHdp
ZHRoKCkgYW5kDQo+IHJlc2V0X2JhbmR3aWR0aCgpLCBhbmQgbWFrZSBtdGsteGhjaSB0byByZWxl
YXNlcyBhbGwgZmFpbGVkIGVuZHBvaW50cw0KPiBmcm9tIHJlc2V0X2JhbmR3aWR0aCgpLg0KPiAN
Cj4gRml4ZXM6IDA4ZTQ2OWRlODdhMiAoInVzYjogeGhjaS1tdGs6IHN1cHBvcnRzIGJhbmR3aWR0
aCBzY2hlZHVsaW5nIHdpdGggbXVsdGktVFQiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBJa2pvb24gSmFu
ZyA8aWtqbkBjaHJvbWl1bS5vcmc+DQoNCg==


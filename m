Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4C432FAEED
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 03:56:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394717AbhASC4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 21:56:39 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:58000 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387973AbhASC4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 21:56:13 -0500
X-UUID: ec5ee7bd1c6342a3ab926683d9160553-20210119
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=CiMAZ2leCHm8XOrAzh8HVdtQ7ukYUItVC28TwVzwG88=;
        b=NQ+unI0gWjZuxm0cELn1dN3ZUjRuXtFZ/IrXraGOHGnh40HtMHRlxt9gXBYCCyWMo4wF1SwC157tm6OA7YxfGMlC5x3QszL+k+njQZafGWCt8fYmpqi+qd93zIy3x1cBSO4jXYP+zwzezj4kbaaDiEFY6AaYcI9JetTL/m2xMj8=;
X-UUID: ec5ee7bd1c6342a3ab926683d9160553-20210119
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 432909497; Tue, 19 Jan 2021 10:55:24 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 19 Jan
 2021 10:55:23 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 19 Jan 2021 10:55:22 +0800
Message-ID: <1611024922.11995.18.camel@mhfsdcap03>
Subject: Re: [PATCH next 12/15] arm64: dts: mediatek: mt8183: fix dtbs_check
 warning
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Sergei Shtylyov <sergei.shtylyov@gmail.com>
CC:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Min Guo <min.guo@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-usb@vger.kernel.org>
Date:   Tue, 19 Jan 2021 10:55:22 +0800
In-Reply-To: <8973d175-441d-0b03-6763-6eeed8595b17@gmail.com>
References: <20210116090656.11752-1-chunfeng.yun@mediatek.com>
         <20210116090656.11752-12-chunfeng.yun@mediatek.com>
         <8973d175-441d-0b03-6763-6eeed8595b17@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 95197C9BA3827A74B5B4DCC86214B786907A7F334A130892260E4361115999232000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCAyMDIxLTAxLTE2IGF0IDEyOjQzICswMzAwLCBTZXJnZWkgU2h0eWx5b3Ygd3JvdGU6
DQo+IE9uIDE2LjAxLjIwMjEgMTI6MDYsIENodW5mZW5nIFl1biB3cm90ZToNCj4gDQo+ID4gSGFy
bW9uaXplIG5vZGUgbmFtZXMsIGNvbXBhdGlibGVzIGFuZCBwcm9wZXJ0aWVzLg0KPiA+IA0KPiA+
IFNpZ25lZC1vZmYtYnk6IENodW5mZW5nIFl1biA8Y2h1bmZlbmcueXVuQG1lZGlhdGVrLmNvbT4N
Cj4gPiAtLS0NCj4gPiAgIGFyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4MTgzLmR0c2kg
fCA5ICsrKystLS0tLQ0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgNSBk
ZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9t
ZWRpYXRlay9tdDgxODMuZHRzaSBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4MTgz
LmR0c2kNCj4gPiBpbmRleCA1Yjc4MmE0NzY5ZTcuLmE2OWEwMzNhNjhhYyAxMDA2NDQNCj4gPiAt
LS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210ODE4My5kdHNpDQo+ID4gKysrIGIv
YXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgxODMuZHRzaQ0KPiBbLi4uXQ0KPiA+IEBA
IC05MDgsMTEgKzkwOCwxMSBAQA0KPiA+ICAgCQkJc3RhdHVzID0gImRpc2FibGVkIjsNCj4gPiAg
IAkJfTsNCj4gPiAgIA0KPiA+IC0JCW1pcGlfdHgwOiBtaXBpLWRwaHlAMTFlNTAwMDAgew0KPiA+
ICsJCW1pcGlfdHgwOiBkc2ktcGh5QDExZTUwMDAwIHsNCj4gDQo+ICAgICBBZ2Fpbiwgd2h5IG5v
dCBqdXN0ICJwaHlALi4uIj8NClRoaXMgZm9sbG93aW5nIHRoZSBzdHlsZSBhcyB1c2ItcGh5LCBw
Y2llLXBoeSBldGMuDQpidXQgaXMgbm90IHlldCBhIHN0YW5kYXJkIHByZWZpeCBmb3IgRGlzcGxh
eSBzZXJpYWwgaW50ZXJmYWNlIFBIWQ0KDQo+IA0KPiBbLi4uXQ0KPiA+IEBAIC05MzEsMTEgKzkz
MSwxMCBAQA0KPiA+ICAgCQkJfTsNCj4gPiAgIAkJfTsNCj4gPiAgIA0KPiA+IC0JCXUzcGh5OiB1
c2ItcGh5QDExZjQwMDAwIHsNCj4gPiArCQl1M3BoeTogdC1waHlAMTFmNDAwMDAgew0KPiANCj4g
ICAgIEhlcmUgYXMgd2VsbC4uLg0KQWxyZWFkeSBleHBsYWluIGl0IGluIFsxMS8xNV0NCj4gDQo+
IFsuLi5dDQo+IA0KPiBNQlIsIFNlcmdlaQ0KDQo=


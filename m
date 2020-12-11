Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61C2D2D6DC6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 02:56:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391136AbgLKByg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 20:54:36 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:30392 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730515AbgLKByD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 20:54:03 -0500
X-UUID: e3d1f9c4893f47eab852db5f242f546c-20201211
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=qiCfZEZ3utNxxmHWGfGh34+yKs77RY7j+UgNQieD2iM=;
        b=C6kBJzdyuQ5mcA5+UBqctflTBQ30R1u/oPDcbVJiD5Rvosef2AyL6A1H7CdFhOwXneZKS1/rkL7QoLxK34X3hwf/Ka1l/ay+zVtROxr9H0xrnHQ0Xens9TGb9yZclM8XTrn+BEOyYnrnQHMbFAvkjDvMmshaEYi4Cdsxqq/DUto=;
X-UUID: e3d1f9c4893f47eab852db5f242f546c-20201211
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1771501145; Fri, 11 Dec 2020 09:53:06 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 11 Dec
 2020 09:53:03 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 11 Dec 2020 09:53:03 +0800
Message-ID: <1607651584.23328.20.camel@mhfsdcap03>
Subject: Re: [PATCH v2 0/3] Release allocated periodic bandwidth data from
 reset_bandwidth()
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Ikjoon Jang <ikjn@chromium.org>
CC:     <linux-mediatek@lists.infradead.org>, <linux-usb@vger.kernel.org>,
        "Zhanyong Wang" <zhanyong.wang@mediatek.com>,
        Tianping Fang <tianping.fang@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Date:   Fri, 11 Dec 2020 09:53:04 +0800
In-Reply-To: <20201210104747.3416781-1-ikjn@chromium.org>
References: <20201210104747.3416781-1-ikjn@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: BAE8BD74BBC1CF0448432855EAE02B439FBC9EF825838CBF95CE85B076B729932000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIwLTEyLTEwIGF0IDE4OjQ3ICswODAwLCBJa2pvb24gSmFuZyB3cm90ZToNCj4g
eGhjaS1tdGsgcmVsZWFzZXMgYWxsb2NhdGVkIFRUIGJhbmR3aWR0aCBkYXRhIG9ubHkgd2hlbiB3
aG9sZQ0KPiBlbmRwb2ludHMgb2YgYSBkZXZpY2UgYXJlIGRyb3BwZWQgYXMgdGhlcmUncmUgb25s
eSB7YWRkfGRyb3B9X2VuZHBvaW50KCkNCj4gaG9va3MgYXJlIGRlZmluZWQuIFRoaXMgcGF0Y2hz
ZXQgYWRkcyBtb3JlIGhvb2tzIGFuZCByZWxlYXNlcyBhbGwNCj4gYmFuZHdpZHRoIGRhdGEgZnJv
bSByZXNldF9iYW5kd2lkdGgoKSBwYXRoLCBub3QgZHJvcF9lbmRwb2ludCgpLg0KPiANCj4gDQo+
IENoYW5nZXMgaW4gdjI6DQo+IC0gZml4IGEgMC1kYXkgd2FybmluZyBmcm9tIHVudXNlZCB2YXJp
YWJsZQ0KPiAtIHNwbGl0IG9uZSBiaWcgcGF0Y2ggaW50byB0aHJlZSBwYXRjaGVzDQo+IC0gYnVn
Zml4IGluIGh3IGZsYWdzDQo+IA0KPiBJa2pvb24gSmFuZyAoMyk6DQo+ICAgdXNiOiB4aGNpLW10
azogY29kZSBjbGVhbnVwcyBpbiBnZXR0aW5nIGJhbmR3aWR0aCB0YWJsZQ0KPiAgIHVzYjogeGhj
aS1tdGs6IGRlbGF5IGFzc29jaWF0aW9uIG9mIHR0IGFuZCBlcA0KPiAgIHVzYjogeGhjaS1tdGs6
IGZpeCB1bnJlbGVhc2VkIGJhbmR3aWR0aCBkYXRhDQo+IA0KPiAgZHJpdmVycy91c2IvaG9zdC94
aGNpLW10ay1zY2guYyB8IDE4MCArKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLQ0KPiAg
ZHJpdmVycy91c2IvaG9zdC94aGNpLW10ay5oICAgICB8ICAxMyArKysNCj4gIGRyaXZlcnMvdXNi
L2hvc3QveGhjaS5jICAgICAgICAgfCAgIDkgKysNCj4gIDMgZmlsZXMgY2hhbmdlZCwgMTMzIGlu
c2VydGlvbnMoKyksIDY5IGRlbGV0aW9ucygtKQ0KVGhhbmtzIGZvciB5b3VyIHBhdGNoLCBJJ2xs
IHRlc3QgaXQgYW5kIGNoZWNrIGl0IHdpdGggb3VyIERFDQoNCj4gDQoNCg==


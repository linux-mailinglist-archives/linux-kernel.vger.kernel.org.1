Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4125303A88
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 11:41:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404120AbhAZKkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 05:40:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732020AbhAZCDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 21:03:32 -0500
X-Greylist: delayed 827 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 25 Jan 2021 16:52:56 PST
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E90C0611C0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 16:52:56 -0800 (PST)
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id DD59A891B0;
        Tue, 26 Jan 2021 13:33:21 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1611621201;
        bh=c2VQN3yGJUcZRIEn9Gqn0Veg7N1cQep6pkqN2/xRino=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=WqbrwvMiuWjsDg+vHcdznD+lzfLwLRIbvAdm7KdnSPcHLKM01OPEtipnybDGgV2dm
         DER2VYDk6ssqBIEZvGgRuJCOCzbwDirLvXoxMtqWacqqtvERHZzZLQtZKIMf6/6y49
         a7Dj32XPkBncS5YuDbnOOFwRPHgqR618oMA331V2Ckff3xQtRVL52VLEqqtxI4aJ3L
         KPqrwTrqCvNtxyK0eQ9tu5p9Sa6m1QpHgS6Ou1jSSD2SiVLTum/e/ejy3zDy4R8VnN
         cWsFOpPr4N6NY3i33zZychtDIuKG++AQmdJPdHfUSgycSw4Br/a5bg0hdVqGLib4YN
         pAOw5gDCJoBCg==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[10.32.16.77]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B600f63510001>; Tue, 26 Jan 2021 13:33:21 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Tue, 26 Jan 2021 13:33:21 +1300
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.010; Tue, 26 Jan 2021 13:33:21 +1300
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Qi Zheng <arch0.zheng@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "frowand.list@gmail.com" <frowand.list@gmail.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] of/fdt: Remove redundant kbasename function call
Thread-Topic: [PATCH v2] of/fdt: Remove redundant kbasename function call
Thread-Index: AQHW83rZib9EpB92fkGwiPfIm/1ogQ==
Date:   Tue, 26 Jan 2021 00:33:21 +0000
Message-ID: <ebbba4ac-ea65-472c-5a3a-201dfe59e402@alliedtelesis.co.nz>
References: <20200528132541.463300-1-arch0.zheng@gmail.com>
In-Reply-To: <20200528132541.463300-1-arch0.zheng@gmail.com>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.1.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <116F44733432FC48A5E52BD93D9E5306@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQWxsLA0KDQpPbiAyOS8wNS8yMCAxOjI1IGFtLCBRaSBaaGVuZyB3cm90ZToNCj4gRm9yIHZl
cnNpb24gMSB0byAzIG9mIHRoZSBkZXZpY2UgdHJlZSwgdGhpcyBpcyB0aGUgbm9kZSBmdWxsDQo+
IHBhdGggYXMgYSB6ZXJvIHRlcm1pbmF0ZWQgc3RyaW5nLCBzdGFydGluZyB3aXRoICIvIi4gVGhl
DQo+IGZvbGxvd2luZyBlcXVhdGlvbiB3aWxsIG5vdCBob2xkLCBzaW5jZSB0aGUgbm9kZSBuYW1l
IGhhcw0KPiBiZWVuIHByb2Nlc3NlZCBpbiB0aGUgZmR0X2dldF9uYW1lKCkuDQo+DQo+IAkqcGF0
aHAgPT0gJy8nDQo+DQo+IEZvciB2ZXJzaW9uIDE2IGFuZCBsYXRlciwgdGhpcyBpcyB0aGUgbm9k
ZSB1bml0IG5hbWUgb25seQ0KPiAob3IgYW4gZW1wdHkgc3RyaW5nIGZvciB0aGUgcm9vdCBub2Rl
KS4gU28gdGhlIGFib3ZlDQo+IGVxdWF0aW9uIHdpbGwgc3RpbGwgbm90IGhvbGQuDQo+DQo+IFNv
IHRoZSBrYmFzZW5hbWUoKSBpcyByZWR1bmRhbnQsIGp1c3QgcmVtb3ZlIGl0Lg0KPg0KPiBTaWdu
ZWQtb2ZmLWJ5OiBRaSBaaGVuZyA8YXJjaDAuemhlbmdAZ21haWwuY29tPg0KPiAtLS0NCj4NCj4g
Q2hhbmdlIGluIHYyOg0KPiAJcmVtb3ZlIGFub3RoZXIga2Jhc2VuYW1lKCkgYWxzby4NCj4NCj4g
ICBkcml2ZXJzL29mL2ZkdC5jIHwgNCAtLS0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDQgZGVsZXRp
b25zKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL29mL2ZkdC5jIGIvZHJpdmVycy9vZi9m
ZHQuYw0KPiBpbmRleCAzODYxOWU5ZWY2YjIuLjQ2MDJlNDY3Y2E4YiAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy9vZi9mZHQuYw0KPiArKysgYi9kcml2ZXJzL29mL2ZkdC5jDQo+IEBAIC02NDMsOCAr
NjQzLDYgQEAgaW50IF9faW5pdCBvZl9zY2FuX2ZsYXRfZHQoaW50ICgqaXQpKHVuc2lnbmVkIGxv
bmcgbm9kZSwNCj4gICAJICAgICBvZmZzZXQgPSBmZHRfbmV4dF9ub2RlKGJsb2IsIG9mZnNldCwg
JmRlcHRoKSkgew0KPiAgIA0KPiAgIAkJcGF0aHAgPSBmZHRfZ2V0X25hbWUoYmxvYiwgb2Zmc2V0
LCBOVUxMKTsNCj4gLQkJaWYgKCpwYXRocCA9PSAnLycpDQo+IC0JCQlwYXRocCA9IGtiYXNlbmFt
ZShwYXRocCk7DQo+ICAgCQlyYyA9IGl0KG9mZnNldCwgcGF0aHAsIGRlcHRoLCBkYXRhKTsNCj4g
ICAJfQ0KPiAgIAlyZXR1cm4gcmM7DQo+IEBAIC02NzEsOCArNjY5LDYgQEAgaW50IF9faW5pdCBv
Zl9zY2FuX2ZsYXRfZHRfc3Vibm9kZXModW5zaWduZWQgbG9uZyBwYXJlbnQsDQo+ICAgCQlpbnQg
cmM7DQo+ICAgDQo+ICAgCQlwYXRocCA9IGZkdF9nZXRfbmFtZShibG9iLCBub2RlLCBOVUxMKTsN
Cj4gLQkJaWYgKCpwYXRocCA9PSAnLycpDQo+IC0JCQlwYXRocCA9IGtiYXNlbmFtZShwYXRocCk7
DQo+ICAgCQlyYyA9IGl0KG5vZGUsIHBhdGhwLCBkYXRhKTsNCj4gICAJCWlmIChyYykNCj4gICAJ
CQlyZXR1cm4gcmM7DQoNCkknbSB0cnlpbmcgdG8ga2VlcCBvdXIgYm9hcmRzIHVwIHRvIGRhdGUg
d2l0aCBuZXdlciBrZXJuZWxzLg0KDQpJJ3ZlIGp1c3QgaGl0IGEgcHJvYmxlbSBvbiBhbiBvbGRl
ciBib2FyZCB0aGF0IHVzZXMgDQpDT05GSUdfQVJNX0FQUEVOREVEX0RUQiBhbmQgaGFzIGEgbnVt
YmVyIG9mIGNvbW1hbmQgbGluZSBhcmdzIHBhc3NlZCB1cCANCmZyb20gdGhlIGJvb3Rsb2FkZXIg
dGhhdCBhcmUgcmVxdWlyZWQgZm9yIGEgc3VjY2Vzc2Z1bCBib290Lg0KDQpJJ20gc3RlcHBpbmcg
dGhyb3VnaCBrZXJuZWwgdmVyc2lvbnMgaW4gdGhlIGhvcGUgdGhhdCBrZWVwaW5nIHRoaW5ncyAN
CnJ1bm5pbmcgaXMgZWFzaWVyIGluIHNtYWxsZXIgaW5jcmVtZW50cyBJJ20gdXAgdG8gdjUuOC4g
SSdtIG5vdCANCmN1cnJlbnRseSBhYmxlIHRvIGNoZWNrIGEgbmV3ZXIga2VybmVsIG9uIHRoaXMg
Ym9hcmQgYnV0IGxvb2tpbmcgYXQgdGhlIA0KY29kZSB0aGUgcHJvYmxlbSBzdGlsbCBzZWVtcyB0
byBleGlzdCBpbiB0aGUgbGF0ZXN0IHRyZWUuDQoNCmVhcmx5X2luaXRfZHRfc2Nhbl9jaG9zZW4o
KSBzZWFyY2hlcyBmb3IgImNob3NlbiIgcHJpb3IgdG8gdGhpcyBjaGFuZ2UgDQp0aGUgIi9jaG9z
ZW4iIG5vZGUgdGhhdCBnZXRzIGluc2VydGVkIGJ5IGF0YWdzX3RvX2ZkdC5jIGJ1dCB3aXRoIHRo
aXMgDQpjaGFuZ2UgaXQgY2FuJ3QgZmluZCBpdCBhbmQgZmFpbHMgdG8gYm9vdC4NCg0K

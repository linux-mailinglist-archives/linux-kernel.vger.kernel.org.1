Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E61CC303AC4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 11:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392032AbhAZKuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 05:50:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732016AbhAZCfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 21:35:10 -0500
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B27C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 18:34:29 -0800 (PST)
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 2ED91891AE;
        Tue, 26 Jan 2021 15:34:26 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1611628466;
        bh=m5uDdpbuJTSI/WPVlKJlXtE2RvNIiiR/S4ReZ69L8Vo=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=lyT70DihNk7PkqV5gna38Acod+BTwM7vlviESqaiTeqdaXLHUUOuBXuWgnQSj/6qI
         kCAMSwZ8Q/FoUNsenle6qDF1tk23jbZe1Swr6JrMU70Q3hZS7g5Ve8vSzoqthErWbG
         RuJxwJwrrQ37dBWbUA4Cc8A28iJnVH5o2t0DCgmLubpB17tQYv1qtd++ppv+mW1YQv
         5/GmA5O4X7Zp53hIYCcTR+VbE/1U6w0+KsgcPt73liaM9ELxg/gcJE679YVx//lPEO
         DrRRkRPTo3fJn+4byzxCm2GssT/CopRDa2m6wLVnU18w4lkrV/nR9QLKbvptTdFlzt
         rfCHHlO49WtJg==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[10.32.16.77]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B600f7fb10001>; Tue, 26 Jan 2021 15:34:25 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8)
 by svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with
 Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 26 Jan 2021 15:34:25 +1300
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.010; Tue, 26 Jan 2021 15:34:25 +1300
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Rob Herring <robh+dt@kernel.org>
CC:     Qi Zheng <arch0.zheng@gmail.com>,
        "frowand.list@gmail.com" <frowand.list@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2] of/fdt: Remove redundant kbasename function call
Thread-Topic: [PATCH v2] of/fdt: Remove redundant kbasename function call
Thread-Index: AQHW83rZib9EpB92fkGwiPfIm/1ogao4Tr0AgAAH5YA=
Date:   Tue, 26 Jan 2021 02:34:25 +0000
Message-ID: <2d09d5b7-b2b8-7526-df80-c87db92e608f@alliedtelesis.co.nz>
References: <20200528132541.463300-1-arch0.zheng@gmail.com>
 <ebbba4ac-ea65-472c-5a3a-201dfe59e402@alliedtelesis.co.nz>
 <CAL_Jsq+8TDagRWyxZHo+qeeV7zDok2mnq10B-B9-L2QoqMr=FQ@mail.gmail.com>
In-Reply-To: <CAL_Jsq+8TDagRWyxZHo+qeeV7zDok2mnq10B-B9-L2QoqMr=FQ@mail.gmail.com>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.1.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <9973956A99A31C4F83F579765CBDFF77@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAyNi8wMS8yMSAzOjA2IHBtLCBSb2IgSGVycmluZyB3cm90ZToNCj4gK0xBS01MIGdpdmVu
IGl0J3MgYW4gQXJtIGlzc3VlDQo+DQo+IE9uIE1vbiwgSmFuIDI1LCAyMDIxIGF0IDY6NDcgUE0g
Q2hyaXMgUGFja2hhbQ0KPiA8Q2hyaXMuUGFja2hhbUBhbGxpZWR0ZWxlc2lzLmNvLm56PiB3cm90
ZToNCj4+IEhpIEFsbCwNCj4+DQo+PiBPbiAyOS8wNS8yMCAxOjI1IGFtLCBRaSBaaGVuZyB3cm90
ZToNCj4+PiBGb3IgdmVyc2lvbiAxIHRvIDMgb2YgdGhlIGRldmljZSB0cmVlLCB0aGlzIGlzIHRo
ZSBub2RlIGZ1bGwNCj4+PiBwYXRoIGFzIGEgemVybyB0ZXJtaW5hdGVkIHN0cmluZywgc3RhcnRp
bmcgd2l0aCAiLyIuIFRoZQ0KPj4+IGZvbGxvd2luZyBlcXVhdGlvbiB3aWxsIG5vdCBob2xkLCBz
aW5jZSB0aGUgbm9kZSBuYW1lIGhhcw0KPj4+IGJlZW4gcHJvY2Vzc2VkIGluIHRoZSBmZHRfZ2V0
X25hbWUoKS4NCj4+Pg0KPj4+ICAgICAgICAqcGF0aHAgPT0gJy8nDQo+Pj4NCj4+PiBGb3IgdmVy
c2lvbiAxNiBhbmQgbGF0ZXIsIHRoaXMgaXMgdGhlIG5vZGUgdW5pdCBuYW1lIG9ubHkNCj4+PiAo
b3IgYW4gZW1wdHkgc3RyaW5nIGZvciB0aGUgcm9vdCBub2RlKS4gU28gdGhlIGFib3ZlDQo+Pj4g
ZXF1YXRpb24gd2lsbCBzdGlsbCBub3QgaG9sZC4NCj4+Pg0KPj4+IFNvIHRoZSBrYmFzZW5hbWUo
KSBpcyByZWR1bmRhbnQsIGp1c3QgcmVtb3ZlIGl0Lg0KPj4+DQo+Pj4gU2lnbmVkLW9mZi1ieTog
UWkgWmhlbmcgPGFyY2gwLnpoZW5nQGdtYWlsLmNvbT4NCj4+PiAtLS0NCj4+Pg0KPj4+IENoYW5n
ZSBpbiB2MjoNCj4+PiAgICAgICAgcmVtb3ZlIGFub3RoZXIga2Jhc2VuYW1lKCkgYWxzby4NCj4+
Pg0KPj4+ICAgIGRyaXZlcnMvb2YvZmR0LmMgfCA0IC0tLS0NCj4+PiAgICAxIGZpbGUgY2hhbmdl
ZCwgNCBkZWxldGlvbnMoLSkNCj4+Pg0KPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL29mL2ZkdC5j
IGIvZHJpdmVycy9vZi9mZHQuYw0KPj4+IGluZGV4IDM4NjE5ZTllZjZiMi4uNDYwMmU0NjdjYThi
IDEwMDY0NA0KPj4+IC0tLSBhL2RyaXZlcnMvb2YvZmR0LmMNCj4+PiArKysgYi9kcml2ZXJzL29m
L2ZkdC5jDQo+Pj4gQEAgLTY0Myw4ICs2NDMsNiBAQCBpbnQgX19pbml0IG9mX3NjYW5fZmxhdF9k
dChpbnQgKCppdCkodW5zaWduZWQgbG9uZyBub2RlLA0KPj4+ICAgICAgICAgICAgIG9mZnNldCA9
IGZkdF9uZXh0X25vZGUoYmxvYiwgb2Zmc2V0LCAmZGVwdGgpKSB7DQo+Pj4NCj4+PiAgICAgICAg
ICAgICAgICBwYXRocCA9IGZkdF9nZXRfbmFtZShibG9iLCBvZmZzZXQsIE5VTEwpOw0KPj4+IC0g
ICAgICAgICAgICAgaWYgKCpwYXRocCA9PSAnLycpDQo+Pj4gLSAgICAgICAgICAgICAgICAgICAg
IHBhdGhwID0ga2Jhc2VuYW1lKHBhdGhwKTsNCj4+PiAgICAgICAgICAgICAgICByYyA9IGl0KG9m
ZnNldCwgcGF0aHAsIGRlcHRoLCBkYXRhKTsNCj4+PiAgICAgICAgfQ0KPj4+ICAgICAgICByZXR1
cm4gcmM7DQo+Pj4gQEAgLTY3MSw4ICs2NjksNiBAQCBpbnQgX19pbml0IG9mX3NjYW5fZmxhdF9k
dF9zdWJub2Rlcyh1bnNpZ25lZCBsb25nIHBhcmVudCwNCj4+PiAgICAgICAgICAgICAgICBpbnQg
cmM7DQo+Pj4NCj4+PiAgICAgICAgICAgICAgICBwYXRocCA9IGZkdF9nZXRfbmFtZShibG9iLCBu
b2RlLCBOVUxMKTsNCj4+PiAtICAgICAgICAgICAgIGlmICgqcGF0aHAgPT0gJy8nKQ0KPj4+IC0g
ICAgICAgICAgICAgICAgICAgICBwYXRocCA9IGtiYXNlbmFtZShwYXRocCk7DQo+Pj4gICAgICAg
ICAgICAgICAgcmMgPSBpdChub2RlLCBwYXRocCwgZGF0YSk7DQo+Pj4gICAgICAgICAgICAgICAg
aWYgKHJjKQ0KPj4+ICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIHJjOw0KPj4gSSdtIHRy
eWluZyB0byBrZWVwIG91ciBib2FyZHMgdXAgdG8gZGF0ZSB3aXRoIG5ld2VyIGtlcm5lbHMuDQo+
Pg0KPj4gSSd2ZSBqdXN0IGhpdCBhIHByb2JsZW0gb24gYW4gb2xkZXIgYm9hcmQgdGhhdCB1c2Vz
DQo+PiBDT05GSUdfQVJNX0FQUEVOREVEX0RUQiBhbmQgaGFzIGEgbnVtYmVyIG9mIGNvbW1hbmQg
bGluZSBhcmdzIHBhc3NlZCB1cA0KPj4gZnJvbSB0aGUgYm9vdGxvYWRlciB0aGF0IGFyZSByZXF1
aXJlZCBmb3IgYSBzdWNjZXNzZnVsIGJvb3QuDQo+Pg0KPj4gSSdtIHN0ZXBwaW5nIHRocm91Z2gg
a2VybmVsIHZlcnNpb25zIGluIHRoZSBob3BlIHRoYXQga2VlcGluZyB0aGluZ3MNCj4+IHJ1bm5p
bmcgaXMgZWFzaWVyIGluIHNtYWxsZXIgaW5jcmVtZW50cyBJJ20gdXAgdG8gdjUuOC4gSSdtIG5v
dA0KPj4gY3VycmVudGx5IGFibGUgdG8gY2hlY2sgYSBuZXdlciBrZXJuZWwgb24gdGhpcyBib2Fy
ZCBidXQgbG9va2luZyBhdCB0aGUNCj4+IGNvZGUgdGhlIHByb2JsZW0gc3RpbGwgc2VlbXMgdG8g
ZXhpc3QgaW4gdGhlIGxhdGVzdCB0cmVlLg0KPj4NCj4+IGVhcmx5X2luaXRfZHRfc2Nhbl9jaG9z
ZW4oKSBzZWFyY2hlcyBmb3IgImNob3NlbiIgcHJpb3IgdG8gdGhpcyBjaGFuZ2UNCj4+IHRoZSAi
L2Nob3NlbiIgbm9kZSB0aGF0IGdldHMgaW5zZXJ0ZWQgYnkgYXRhZ3NfdG9fZmR0LmMgYnV0IHdp
dGggdGhpcw0KPj4gY2hhbmdlIGl0IGNhbid0IGZpbmQgaXQgYW5kIGZhaWxzIHRvIGJvb3QuDQo+
IEdpdmVuIHRoaXMgY29kZSB3b3JrcyBmb3Igbm9ybWFsIGNhc2VzLCBJJ20gZ3Vlc3NpbmcgdGhl
IHByb2JsZW0gaXMgaW4NCj4gYXRhZ3NfdG9fZmR0LmMgb3IgbGliZmR0Lg0KDQpJdCBtaWdodCBi
ZSByZWxhdGVkIHRvdCB0aGlzIHNuaXBwZXQgb2YgbGliZmR0DQoNCmNvbnN0IGNoYXIgKmZkdF9n
ZXRfbmFtZShjb25zdCB2b2lkICpmZHQsIGludCBub2Rlb2Zmc2V0LCBpbnQgKmxlbikNCnsNCg0K
Li4uDQoNCiDCoMKgwqDCoMKgwqDCoCBpZiAoIWNhbl9hc3N1bWUoTEFURVNUKSAmJiBmZHRfdmVy
c2lvbihmZHQpIDwgMHgxMCkgew0KIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAvKg0K
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICogRm9yIG9sZCBGRFQgdmVyc2lvbnMs
IG1hdGNoIHRoZSBuYW1pbmcgY29udmVudGlvbnMgDQpvZiBWMTY6DQogwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgKiBnaXZlIG9ubHkgdGhlIGxlYWYgbmFtZSAoYWZ0ZXIgYWxsIC8p
LiBUaGUgYWN0dWFsIHRyZWUNCiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIGNv
bnRlbnRzIGFyZSBsb29zZWx5IGNoZWNrZWQuDQogwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgKi8NCiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY29uc3QgY2hhciAqbGVh
ZjsNCiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbGVhZiA9IHN0cnJjaHIobmFtZXB0
ciwgJy8nKTsNCiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKGxlYWYgPT0gTlVM
TCkgew0KIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZXJy
ID0gLUZEVF9FUlJfQkFEU1RSVUNUVVJFOw0KIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgZ290byBmYWlsOw0KIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCB9DQogwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG5hbWVwdHIgPSBsZWFmKzE7
DQogwqDCoMKgwqDCoMKgwqAgfQ0KDQouLi4NCg0KfQ0KDQpPbiBteSBzeXN0ZW0gdGhhdCBpZiBl
dmFsdWF0ZXMgdG8gMA0KDQo+IElzIGl0IHBvc3NpYmxlIHRvIGFkZCBhbiBlbXB0eSBjaG9zZW4g
bm9kZQ0KPiB0byB0aGUgRFQgYW5kIHNlZSBpZiB0aGF0IG1ha2VzIGFueSBkaWZmZXJlbmNlLg0K
SSdsbCBnaXZlIHRoYXQgYSB0cnku

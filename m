Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23B2A2C9374
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 00:59:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730544AbgK3X6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 18:58:45 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:40706 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbgK3X6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 18:58:44 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 018FF806AC;
        Tue,  1 Dec 2020 12:58:01 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1606780681;
        bh=ccfymgGeYZ3pdK9TTrpFGhZ4gbukmOE2n7TkhvLgHjo=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=2cWjPGUaHOmsPJz+MC/B65eOGFi1HfWWmH+upD+rfNDQi43fulNWubsK/q3X/t4Hr
         8iGjsIAMdntU/cBYl2DNsRKg6Ytr0UlV5jMCem9AyfY+3N5x3azBnd34HGBYqNB/PT
         14XS3tXdVT2/39n1vHT+P0ZCwJoH0O1Cfq7v3Yyk6DkEaLi20U2rEvLKSF6lvJ7mUv
         LZ3N2LBnFKKYccNxDefZaMSV4Pwar4RHYTOKxf+JMSdteTcsoIuZf5nlMvMQYnyXZl
         tmaU7zFjD/JyCy7z3s+QrvnunvYyUX2eJ8YeBQ1U21XyvYrL4zLYWPQoaWe+YjPf+m
         BIcvtjgrT5RzQ==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[10.32.16.77]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5fc587070003>; Tue, 01 Dec 2020 12:57:59 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8)
 by svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with
 Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 1 Dec 2020 12:58:00 +1300
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.008; Tue, 1 Dec 2020 12:58:00 +1300
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Andrew Lunn <andrew@lunn.ch>,
        Aryan Srivastava <Aryan.Srivastava@alliedtelesis.co.nz>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2] ARM: dts: mvebu: Add device tree for ATL-x530 Board
Thread-Topic: [PATCH v2] ARM: dts: mvebu: Add device tree for ATL-x530 Board
Thread-Index: AQHWx2kQGCxRd6BcVkCfnQc+UL0F2qngcWyAgAAPFoA=
Date:   Mon, 30 Nov 2020 23:57:59 +0000
Message-ID: <3570cb6d-44e0-3ab5-b464-a013ba1007b1@alliedtelesis.co.nz>
References: <20201130223507.23571-1-aryan.srivastava@alliedtelesis.co.nz>
 <20201130230359.GH2073444@lunn.ch>
In-Reply-To: <20201130230359.GH2073444@lunn.ch>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.1.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <9A2F605EC80A4247AC07776013CA51C5@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAxLzEyLzIwIDEyOjAzIHBtLCBBbmRyZXcgTHVubiB3cm90ZToNCj4gT24gVHVlLCBEZWMg
MDEsIDIwMjAgYXQgMTE6MzU6MDdBTSArMTMwMCwgQXJ5YW4gU3JpdmFzdGF2YSB3cm90ZToNCj4+
IEFkZCBkZXZpY2UgdHJlZSBmaWxlIGZvciB4NTMwIGJvYXJkLiBUaGlzIGhhcyBhbiBBcm1hZGEg
Mzg1IFNvQy4gSGFzDQo+PiBOQU5ELWZsYXNoIGZvciB1c2VyIHN0b3JhZ2UgYW5kIFNQSSBmb3Ig
Ym9vdGluZy4gQ292ZXJzIG1ham9yaXR5IG9mIHg1MzANCj4+IGFuZCBHUzk4ME1YIHZhcmlhbnRz
Lg0KPiBIaSBBcnlhbg0KPg0KPiBXaGF0IGV4YWN0bHkgZG9lcyB0aGF0IG1lYW4sIGl0IGNvdmVy
cyBtb3N0IHZhcmlhbnRzPw0KDQpXZSB3ZXJlIHRyeWluZyB0byBhdm9pZCB0aGUgcGF0Y2ggc3Vi
bWlzc2lvbiBiZWNvbWluZyBtYXJrZXRpbmcgc3BhbSBhbmQgDQpoYXZlIHByb2JhYmx5IGJlZW4g
YSBsaXR0bGUgdG9vIHZhZ3VlLg0KDQpCZXR3ZWVuIHRoZSB4NTMwLCB4NTMwTCBhbmQgR1M5ODBN
WCB0aGVyZSBhcmUgMjQgZGlmZmVyZW50IG1vZGVscy4gVGhlIA0KZGlmZmVyZW5jZXMgYmV0d2Vl
biB0aGVtIGFyZSBpbiB0aGUgdHlwZSBhbmQgbnVtYmVyIG9mIHN3aXRjaCBBU0lDcywgdGhlIA0K
bnVtYmVyIG9mIFBTVXMgYW5kIHdoZXRoZXIgUG9FIGlzIHN1cHBvcnRlZC4gQnV0IHRoZSBDUFUg
YmxvY2sgaXMgDQpsYXJnZWx5IHRoZSBzYW1lIGJldHdlZW4gbW9kZWxzLg0KDQo+IEknbSBqdXN0
IHdvbmRlcmluZyBpZiB0aGlzIHNob3VsZCBiZSBhIC5kdHNpIGZpbGUsIGFuZCB0aGVuIGVhY2gN
Cj4gdmFyaWFudCBoYXMgYSAuZHRzIGZpbGUgc3BlY2lmaWMgdG8gaXQ/DQpUaGlzIGlzIHdoYXQg
d2UndmUgZG9uZSBpbiBvdXIga2VybmVsIGZvcmsuIEJ1dCBmb3IgdXBzdHJlYW1pbmcgd2UgDQp3
YW50ZWQgdG8gc3RhcnQgc2xvdyBhbmQgbWF5YmUgbW92ZSB0aGluZ3MgaW50byBvbmUgb3IgbW9y
ZSBjb21tb24gLmR0c2kgDQpmaWxlcyBpZi93aGVuIG5lZWRlZCAoaW4gcGFydGljdWxhciB0aGVy
ZSBhcmUgc29tZSBtb2RlbHMgaW4gZGV2ZWxvcG1lbnQgDQpub3cgdGhhdCB1c2UgZGlmZmVyZW50
IGkyYyBtdXggYW5kIGh3bW9uIGNoaXBzKS4NCj4gT3IgaXMgdGhlIGhhcmR3YXJlIGl0c2VsZiB0
aGUNCj4gc2FtZSwgYW5kIG9ubHkgdGhlIHNvZnR3YXJlIHZhcmllcyBiZXR3ZWVuIHRoZSB2YXJp
YW50cz8NCktpbmQgb2YgYm90aC4gVGhpcyBwYXRjaCBzdWJtaXNzaW9uIGJhc2ljYWxseSByZXBy
ZXNlbnRzIHRoZSBjb21tb24gDQppdGVtcyBhbW9uZyBhbGwgdGhlIChjdXJyZW50bHkgc2hpcHBp
bmcpIHZhcmlhbnRzLg==

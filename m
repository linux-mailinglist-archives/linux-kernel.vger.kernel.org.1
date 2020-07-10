Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3271421B0D4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jul 2020 09:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbgGJH5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jul 2020 03:57:33 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:44424 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbgGJH5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 03:57:33 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 06A7vMVs9001675, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 06A7vMVs9001675
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 10 Jul 2020 15:57:22 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 10 Jul 2020 15:57:22 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 10 Jul 2020 15:57:21 +0800
Received: from RTEXMB04.realtek.com.tw ([fe80::941:6388:7d34:5c44]) by
 RTEXMB04.realtek.com.tw ([fe80::941:6388:7d34:5c44%3]) with mapi id
 15.01.1779.005; Fri, 10 Jul 2020 15:57:21 +0800
From:   =?utf-8?B?U3RhbmxleSBDaGFuZ1vmmIzogrLlvrdd?= 
        <stanley_chang@realtek.com>
To:     =?utf-8?B?QW5kcmVhcyBGw6RyYmVy?= <afaerber@suse.de>,
        "linux-realtek-soc@lists.infradead.org" 
        <linux-realtek-soc@lists.infradead.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?SmFtZXMgVGFpIFvmiLTlv5fls7Bd?= <james.tai@realtek.com>,
        =?utf-8?B?RWRnYXIgTGVlIFvmnY7mib/oq61d?= <cylee12@realtek.com>,
        Rob Herring <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v2 04/29] ARM: dts: rtd1195: Add chip info node
Thread-Topic: [PATCH v2 04/29] ARM: dts: rtd1195: Add chip info node
Thread-Index: AQHWSQk2TT/boju1mUeYH+VuJZyHIakAjTQQ
Date:   Fri, 10 Jul 2020 07:57:21 +0000
Message-ID: <312be01bd09545f1b58d0df62ba08c0f@realtek.com>
References: <20200623025106.31273-1-afaerber@suse.de>
 <20200623025106.31273-5-afaerber@suse.de>
In-Reply-To: <20200623025106.31273-5-afaerber@suse.de>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.190.196]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5kcmVhcywNCg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEFu
ZHJlYXMgRsOkcmJlciBbbWFpbHRvOmFmYWVyYmVyQHN1c2UuZGVdDQo+IFNlbnQ6IFR1ZXNkYXks
IEp1bmUgMjMsIDIwMjAgMTA6NTEgQU0NCj4gVG86IGxpbnV4LXJlYWx0ZWstc29jQGxpc3RzLmlu
ZnJhZGVhZC5vcmcNCj4gQ2M6IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsg
bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgSmFtZXMNCj4gVGFpIFvmiLTlv5fls7BdOyBT
dGFubGV5IENoYW5nW+aYjOiCsuW+t107IEVkZ2FyIExlZSBb5p2O5om/6KutXTsgQW5kcmVhcyBG
w6RyYmVyOw0KPiBSb2IgSGVycmluZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmcNCj4gU3Vi
amVjdDogW1BBVENIIHYyIDA0LzI5XSBBUk06IGR0czogcnRkMTE5NTogQWRkIGNoaXAgaW5mbyBu
b2RlDQo+IA0KPiBBZGQgYSBEVCBub2RlIGZvciBjaGlwIGlkZW50aWZpY2F0aW9uLg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogQW5kcmVhcyBGw6RyYmVyIDxhZmFlcmJlckBzdXNlLmRlPg0KDQpSZXZp
ZXdlZC1ieTogU3RhbmxleSBDaGFuZyA8c3RhbmxleV9jaGFuZ0ByZWFsdGVrLmNvbT4NCg0KVGhh
bmtzLA0KU3RhbmxleQ0K

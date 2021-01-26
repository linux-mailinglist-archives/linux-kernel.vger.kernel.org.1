Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD936303A81
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 11:39:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404151AbhAZKha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 05:37:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730657AbhAZBtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 20:49:20 -0500
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA91C06121E
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 17:48:29 -0800 (PST)
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 404A4891AF;
        Tue, 26 Jan 2021 14:48:26 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1611625706;
        bh=qRRMqC8rH4XIRN3NtY3KqlRrQi0qUuy7wQM4OGfG+Hc=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=M0qLlBImd/iHTNw/4+bohr0tGftXc+tslr1huttjwqVJ54o231/VRMmtvAF8zg1ZF
         reczL+/zufcOm4Nv2D7xJSl78TY1abI8b3F7lbMNizSfE8UK0QEkhae8wYk/D9tDLY
         YgrSC2f1gRJf51mTkIzskIUuycmhWoV6gX/vwM6AZRk0/kkseDly1IHMAafWT00T3F
         LGCl5MMZkBcpDcmIiJMbhpdt8HZTepIUuD/si7CPMUJYupR4LSc5IVJMsMIrK5lpcu
         YBgDbQYgqfl/amxvsMoEOq5HumZpeZ8FsEsn+xIjbH7r6dHJCa4/jmeadN6Qm02K8S
         OhrcXXSPGY+0A==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[10.32.16.77]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B600f74e90000>; Tue, 26 Jan 2021 14:48:25 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8)
 by svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with
 Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 26 Jan 2021 14:48:23 +1300
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.010; Tue, 26 Jan 2021 14:48:23 +1300
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "rppt@kernel.org" <rppt@kernel.org>
CC:     "arnd@arndb.de" <arnd@arndb.de>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] bus: mvebu-mbus: make iounmap() symmetric with ioremap()
Thread-Topic: [PATCH] bus: mvebu-mbus: make iounmap() symmetric with ioremap()
Thread-Index: AQHWuKL2iPKD0qVnqEGumLlGMV5UHanDSQAAgHV2dYA=
Date:   Tue, 26 Jan 2021 01:48:23 +0000
Message-ID: <7c0fd747-3ea1-2aa1-0c05-12ae4477a860@alliedtelesis.co.nz>
References: <20201112032149.21906-1-chris.packham@alliedtelesis.co.nz>
 <20201112090202.638c0c13@windsurf>
In-Reply-To: <20201112090202.638c0c13@windsurf>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.1.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <2A59864F71506E4790ED7A419B83B533@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQWxsLA0KDQpPbiAxMi8xMS8yMCA5OjAyIHBtLCBUaG9tYXMgUGV0YXp6b25pIHdyb3RlOg0K
PiBPbiBUaHUsIDEyIE5vdiAyMDIwIDE2OjIxOjQ5ICsxMzAwDQo+IENocmlzIFBhY2toYW0gPGNo
cmlzLnBhY2toYW1AYWxsaWVkdGVsZXNpcy5jby5uej4gd3JvdGU6DQo+DQo+PiBtYWtlIGNvY2Np
Y2hlY2sgY29tcGxhaW5zOg0KPj4NCj4+ICAgIC4vZHJpdmVycy9idXMvbXZlYnUtbWJ1cy5jOjEx
MTM6Mi04OiBFUlJPUjogbWlzc2luZyBpb3VubWFwOyBpb3JlbWFwIG9uIGxpbmUgMTEwNiBhbmQg
ZXhlY3V0aW9uIHZpYSBjb25kaXRpb25hbCBvbiBsaW5lIDExMTENCj4+DQo+PiBJdCB0b29rIHNv
bWUgc3RhcmluZyBidXQgSSBkb24ndCB0aGluayB0aGVyZSBpcyBhIHByb2JsZW0gYmVjYXVzZSB0
aGUNCj4+IGZpbGUgZ2xvYmFsIGBtYnVzX3N0YXRlYCBpcyBwYXNzZWQgbXZlYnVfbWJ1c19jb21t
b25faW5pdCgpIGFzIHRoZQ0KPj4gYG1idXNgIHBhcmFtZXRlciBzbyBgbWJ1c19zdGF0ZS5tYnVz
d2luc19iYXNlYCBhbmQgYG1idXMtPm1idXN3aW5zX2Jhc2VgDQo+PiBhcmUgdGhlIHNhbWUgdGhp
bmcuIEJ1dCB0aGlzIGlzIGNvbmZ1c2luZyBmb3IgYW55b25lIHJlYWRpbmcgdGhlIGNvZGUNCj4+
IGFuZCBvbmUgbGVzcyBjb21wbGFpbnQgZnJvbSBjb2NjaWNoZWNrIHdvdWxkIGJlIG5pY2Ugc28g
bGV0cyBmaXggaXQuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogQ2hyaXMgUGFja2hhbSA8Y2hyaXMu
cGFja2hhbUBhbGxpZWR0ZWxlc2lzLmNvLm56Pg0KPiBBY2tlZC1ieTogVGhvbWFzIFBldGF6em9u
aSA8dGhvbWFzLnBldGF6em9uaUBib290bGluLmNvbT4NCg0KSnVzdCBnb2luZyB0aHJvdWdoIHNv
bWUgb2xkIGJyYW5jaGVzLiBUaGlzIGRvZXNuJ3Qgc2VlbSB0byBoYXZlIGJlZW4gDQpwaWNrZWQg
dXAuIEhhdmUgSSBtaXNzZWQgYSBtYWludGFpbmVyPw0KDQo=

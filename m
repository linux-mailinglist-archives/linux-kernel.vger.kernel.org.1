Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 658412AE73C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 04:57:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725898AbgKKD4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 22:56:46 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:39510 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725849AbgKKD4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 22:56:44 -0500
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id AA28BC0090;
        Wed, 11 Nov 2020 03:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1605067004; bh=z8HubOSXbqQaPi+NXseTo9n72Z9VUVVXc+N195koxZQ=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=UIhKQTh/zcdwoICisv35rOWrmmR6BO/SQRHbknwr13jXTv3+ZLxPOdwg5XVOGaMjO
         0hK7OEXiWgG3hWU2gGAyESiwUwrg0qAt+fdxDP9N+7z18m5XQL4RiPpaMJjDpNX7bv
         UMkj5IeiFj7ZSLYeKKcl8w0nA3kP46XuEh9a0DQc1JgZC37EoKdXcs26IZeki30pro
         Z5eQw1GzAeg9Cz8P++AHSWnNTDUoT1B40MK/PZlgra6NqyPWgrYAdN5q2zEBRm8DrP
         QeW908iSjBAORM/6H1OhRFM8bATy8+xYl6JGcBS3UztfJxaWehUUzRPNM0Nr7yCsad
         5EXJKpcPWxArg==
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 7A7C3A0099;
        Wed, 11 Nov 2020 03:56:41 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2053.outbound.protection.outlook.com [104.47.36.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "GlobalSign Organization Validation CA - SHA256 - G3" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 4636E80256;
        Wed, 11 Nov 2020 03:56:39 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=vgupta@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="N+Qo0CP1";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MXG8s02OdqKPEjnL3ZK3QsN45WUmzlBU8nawag2+cuM+Z1Fb0MkDsid2bf834jhUTM4LAXDdAEHUuTe4TxlocmxD65xW7c4a+IwlewFxMCesXGbCJQKsErsKLDWChCXbt7HLatBnBID4WDKrYUtrpW7M9aPHCxlpaw0v/bVMJwvJAySoksJRVqNFQKG74cUc9uPvhcvm/yL7k/fDCfIpDFTkYCDHiy4OXFazY0OcX5g/JGFbec+91mIbO1Ukc4Wvq1cW8lfRzBJYqMTS6wvEeK90j8pVKseiSKNLKG1XN6wkzB0eNPPa4ZqRPFO/2JYRQ+dEXkKX3YM1KlUDahI25Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z8HubOSXbqQaPi+NXseTo9n72Z9VUVVXc+N195koxZQ=;
 b=FUkIW28WSmEf3oHw4FF1bgoumt0K/3qhIRfPKgGa1UMi8mxJWSnwCr5NdK8zHJTeQleAobXDc+8HfQPlbC7umIi0jVZtU/cGI29CrrHLsKy93UwyYFpOxUUL1Yr+H34ne0t6I8M9oQtf54k8EwBUx1ZfOoC1d4fiACfpuU/aV8RbMeeIJHOw+skL3q6QM05JURNYcfDSRunFqeH/uiVh0RbM9YzIqu4pNUW3xCyRZRjgqrWl/2vGRJ5t/aY6Jd130GbDopsIZrHMxiwDohY/4NH5cvMDRPszY5rG+q7X0pYCsazpA9YAkyIxmluEhZLsiv9VyIKhvFodKsHTBpoh2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z8HubOSXbqQaPi+NXseTo9n72Z9VUVVXc+N195koxZQ=;
 b=N+Qo0CP1btQx7zMpK7QmPM6JoDmOCQEwnG9+SX2M/idZ2lBWBiUUavA70HsZVGxJrDa4x8QwEsx7416Z22W7pQpczjsHBybwVNJajCK6OFb8nFmUCxFlSDleFE7/kgxbhyenGLpWXMrpbfW3sJ0D/MVmVaYdLekDJQXzZESq/qo=
Received: from BYAPR12MB3479.namprd12.prod.outlook.com (2603:10b6:a03:dc::26)
 by BY5PR12MB4082.namprd12.prod.outlook.com (2603:10b6:a03:212::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.25; Wed, 11 Nov
 2020 03:56:38 +0000
Received: from BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::c562:e026:68d6:cd31]) by BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::c562:e026:68d6:cd31%6]) with mapi id 15.20.3541.025; Wed, 11 Nov 2020
 03:56:38 +0000
X-SNPS-Relay: synopsys.com
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Flavio Suligoi <f.suligoi@asem.it>
CC:     "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARC: mm: fix spelling mistakes
Thread-Topic: [PATCH] ARC: mm: fix spelling mistakes
Thread-Index: AQHWtptYkvqc3DTOMU+gcOmdAjskKanCUBYA
Date:   Wed, 11 Nov 2020 03:56:37 +0000
Message-ID: <79388ce9-f589-692e-1d8c-11cd7eb1b3a8@synopsys.com>
References: <20201109132130.34555-1-f.suligoi@asem.it>
In-Reply-To: <20201109132130.34555-1-f.suligoi@asem.it>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: asem.it; dkim=none (message not signed)
 header.d=none;asem.it; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [24.4.73.83]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 40791a5c-5e67-43c3-bba9-08d885f5ca60
x-ms-traffictypediagnostic: BY5PR12MB4082:
x-microsoft-antispam-prvs: <BY5PR12MB4082DE7432C33CD4F7C9E627B6E80@BY5PR12MB4082.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gqoaWK7J/6db6CpOjLL6AdMzFvEKIumIdLgW0XUhIp/7VDdlVTSfgEfBHgpwDo156mId5f/tSp+GtYrDWLujnZliG2yJ8W37S3KNJvpwgtSJ5WVfY9HRHmZj0k1jWokfBptwGoM6wbjvcoZH8hWGMpvBdxpVpUHIWavBlNvWcUJ+Yhh80J7LA8HOVdzJe+katJWfqGHJ2ziBqDTjjn9h3Ixp3cpsVlNZXc7SLZM47/k3KXk1JucEXtb7s6BMOudu87MqO56wEAJGv5ED2fclKZRIABaMAoy+R8guSQnMKOwJZzceu3D7g8sTEApbYZYgyqXlpZBXtYKqPqlBvVVsWLcbUnD8Qm8Cs9rxuPQYIEo+7ZDW8DaJzMrGIa5SQPLy
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3479.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(136003)(396003)(346002)(366004)(376002)(76116006)(2616005)(6486002)(316002)(4326008)(31686004)(478600001)(66556008)(66946007)(53546011)(8676002)(31696002)(186003)(54906003)(86362001)(5660300002)(66446008)(64756008)(26005)(6512007)(8936002)(36756003)(83380400001)(6506007)(6916009)(2906002)(71200400001)(66476007)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: THHvuQvQt8cPgjtcwNN0Yl7YF2oTKYj8aqPOtyfh7XFyLe+islokZLh4CRNcGeF2Dhg88aCOfyNzGJFJDIPpz1NQ8IIrWen0fckBiTjGaiZ+MJdkg5xo6BFUzzIciEupIY3WWa5aqVfinpGxPTRneb9LK8xdS4BFQgjsShub+y7w8Qv0evrJRDnHd0AMU/CcGP2/dY9O1a00DyKFnq4dt7+Rr0NfgVvtefRlHWjEM5ZEvwLVc0mhF3TDTJ8X7CezqxgJNuxNWmge/USkgZ7iVH+hjVh9exGuEvrwJCs1HCC556JjkgkNHqRbYzw2WElLrUj7KcEDQPevOgiSumTG7+Hg8Mfrk2kJLgLMGckBdc1PQurbTYb5ySUt0cUOMieymQOhkYedyVnJi9QR7Np0XigDyfwrRzmbbGANm5ZJTQifCJX8A8mrgzb4kXjT1pzCO1IEesSObVv2lz4mGvXRvr+b4g7PH7+B1jM8xkCxHNKpcxsp/NBB/0y7cnYyO6Yx1gBvVRYnm4yuaQysC8utnbFu4++1WLD4JUe7u068rRWHJle8/8heCX+EAu/KsTZGy4dWKSt+1ka3/trXEDn0Fz9/xO2ztIHZwQoLL4fqUxZ0gipRCXvfjy6VaQNYXLR5w5fHeV5mUwcZ/bfaYabeZw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <4B14257285AD7546BB1F4CC29EC2B8CE@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3479.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40791a5c-5e67-43c3-bba9-08d885f5ca60
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2020 03:56:38.0434
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B3k/l+f+DhE6APCqJUqlfHLonspq0XGJzL7EE1rCTXIKW0tiQYbKXlEsaObNP4jy0feZSPsrfavCZnGSwTmT8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4082
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTEvOS8yMCA1OjIxIEFNLCBGbGF2aW8gU3VsaWdvaSB3cm90ZToNCj4gU2lnbmVkLW9mZi1i
eTogRmxhdmlvIFN1bGlnb2kgPGYuc3VsaWdvaUBhc2VtLml0Pg0KDQpUaHgsIGFwcGxpZWQgdG8g
Zm9yLWN1cnIgIQ0KDQotVmluZWV0DQoNCj4gLS0tDQo+ICAgYXJjaC9hcmMvbW0vdGxiLmMgfCAy
NCArKysrKysrKysrKystLS0tLS0tLS0tLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMTIgaW5zZXJ0
aW9ucygrKSwgMTIgZGVsZXRpb25zKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9hcmNoL2FyYy9tbS90
bGIuYyBiL2FyY2gvYXJjL21tL3RsYi5jDQo+IGluZGV4IGMzNDBhY2Q5ODlhMC4uOWJiM2MyNGYz
Njc3IDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FyYy9tbS90bGIuYw0KPiArKysgYi9hcmNoL2FyYy9t
bS90bGIuYw0KPiBAQCAtMzAsMTQgKzMwLDE0IEBADQo+ICAgICogIC1DaGFuZ2VzIHJlbGF0ZWQg
dG8gTU1VIHYyIChSZWwgNC44KQ0KPiAgICAqDQo+ICAgICogVmluZWV0ZzogQXVnIDI5dGggMjAw
OA0KPiAtICogIC1JbiBUTEIgRmx1c2ggb3BlcmF0aW9ucyAoTWV0YWwgRml4IE1NVSkgdGhlcmUg
aXMgYSBleHBsaWN0IGNvbW1hbmQgdG8NCj4gKyAqICAtSW4gVExCIEZsdXNoIG9wZXJhdGlvbnMg
KE1ldGFsIEZpeCBNTVUpIHRoZXJlIGlzIGEgZXhwbGljaXQgY29tbWFuZCB0bw0KPiAgICAqICAg
IGZsdXNoIE1pY3JvLVRMQlMuIElmIFRMQiBJbmRleCBSZWcgaXMgaW52YWxpZCBwcmlvciB0byBU
TEJJVlVUTEIgY21kLA0KPiAgICAqICAgIGl0IGZhaWxzLiBUaHVzIG5lZWQgdG8gbG9hZCBpdCB3
aXRoIEFOWSB2YWxpZCB2YWx1ZSBiZWZvcmUgaW52b2tpbmcNCj4gICAgKiAgICBUTEJJVlVUTEIg
Y21kDQo+ICAgICoNCj4gICAgKiBWaW5lZXRnOiBBdWcgMjF0aCAyMDA4Og0KPiAgICAqICAtUmVk
dWNlZCB0aGUgZHVyYXRpb24gb2YgSVJRIGxvY2tvdXRzIGluIFRMQiBGbHVzaCByb3V0aW5lcw0K
PiAtICogIC1NdWx0aXBsZSBjb3BpZXMgb2YgVExCIGVyYXNlIGNvZGUgc2VwZXJhdGVkIGludG8g
YSAic2luZ2xlIiBmdW5jdGlvbg0KPiArICogIC1NdWx0aXBsZSBjb3BpZXMgb2YgVExCIGVyYXNl
IGNvZGUgc2VwYXJhdGVkIGludG8gYSAic2luZ2xlIiBmdW5jdGlvbg0KPiAgICAqICAtSW4gVExC
IEZsdXNoIHJvdXRpbmVzLCBpbnRlcnJ1cHQgZGlzYWJsaW5nIG1vdmVkIFVQIHRvIHJldHJpZXZl
IEFTSUQNCj4gICAgKiAgICAgICBpbiBpbnRlcnJ1cHQtc2FmZSByZWdpb24uDQo+ICAgICoNCj4g
QEAgLTY2LDcgKzY2LDcgQEANCj4gICAgKg0KPiAgICAqIEFsdGhvdWdoIEotVExCIGlzIDIgd2F5
IHNldCBhc3NvYywgQVJDNzAwIGNhY2hlcyBKLVRMQiBpbnRvIHVUTEJTIHdoaWNoIGhhcw0KPiAg
ICAqIG11Y2ggaGlnaGVyIGFzc29jaWF0aXZpdHkuIHUtRC1UTEIgaXMgOCB3YXlzLCB1LUktVExC
IGlzIDQgd2F5cy4NCj4gLSAqIEdpdmVuIHRoaXMsIHRoZSB0aHJhc2luZyBwcm9ibGVtIHNob3Vs
ZCBuZXZlciBoYXBwZW4gYmVjYXVzZSBvbmNlIHRoZSAzDQo+ICsgKiBHaXZlbiB0aGlzLCB0aGUg
dGhyYXNoaW5nIHByb2JsZW0gc2hvdWxkIG5ldmVyIGhhcHBlbiBiZWNhdXNlIG9uY2UgdGhlIDMN
Cj4gICAgKiBKLVRMQiBlbnRyaWVzIGFyZSBjcmVhdGVkIChldmVuIHRob3VnaCAzcmQgd2lsbCBr
bm9jayBvdXQgb25lIG9mIHRoZSBwcmV2DQo+ICAgICogdHdvKSwgdGhlIHUtRC1UTEIgYW5kIHUt
SS1UTEIgd2lsbCBoYXZlIHdoYXQgaXMgcmVxdWlyZWQgdG8gYWNjb21wbGlzaCBtZW1jcHkNCj4g
ICAgKg0KPiBAQCAtMTI3LDcgKzEyNyw3IEBAIHN0YXRpYyB2b2lkIHV0bGJfaW52YWxpZGF0ZSh2
b2lkKQ0KPiAgIAkgKiBUaGVyZSB3YXMgaG93ZXZlciBhbiBvYnNjdXJlIGhhcmR3YXJlIGJ1Zywg
d2hlcmUgdVRMQiBmbHVzaCB3b3VsZA0KPiAgIAkgKiBmYWlsIHdoZW4gYSBwcmlvciBwcm9iZSBm
b3IgSi1UTEIgKGJvdGggdG90YWxseSB1bnJlbGF0ZWQpIHdvdWxkDQo+ICAgCSAqIHJldHVybiBs
a3VwIGVyciAtIGJlY2F1c2UgdGhlIGVudHJ5IGRpZG4ndCBleGlzdCBpbiBNTVUuDQo+IC0JICog
VGhlIFdvcmtyb3VuZCB3YXMgdG8gc2V0IEluZGV4IHJlZyB3aXRoIHNvbWUgdmFsaWQgdmFsdWUs
IHByaW9yIHRvDQo+ICsJICogVGhlIFdvcmthcm91bmQgd2FzIHRvIHNldCBJbmRleCByZWcgd2l0
aCBzb21lIHZhbGlkIHZhbHVlLCBwcmlvciB0bw0KPiAgIAkgKiBmbHVzaC4gVGhpcyB3YXMgZml4
ZWQgaW4gTU1VIHYzDQo+ICAgCSAqLw0KPiAgIAl1bnNpZ25lZCBpbnQgaWR4Ow0KPiBAQCAtMjcy
LDcgKzI3Miw3IEBAIG5vaW5saW5lIHZvaWQgbG9jYWxfZmx1c2hfdGxiX2FsbCh2b2lkKQ0KPiAg
IH0NCj4gICANCj4gICAvKg0KPiAtICogRmx1c2ggdGhlIGVudHJpZSBNTSBmb3IgdXNlcmxhbmQu
IFRoZSBmYXN0ZXN0IHdheSBpcyB0byBtb3ZlIHRvIE5leHQgQVNJRA0KPiArICogRmx1c2ggdGhl
IGVudGlyZSBNTSBmb3IgdXNlcmxhbmQuIFRoZSBmYXN0ZXN0IHdheSBpcyB0byBtb3ZlIHRvIE5l
eHQgQVNJRA0KPiAgICAqLw0KPiAgIG5vaW5saW5lIHZvaWQgbG9jYWxfZmx1c2hfdGxiX21tKHN0
cnVjdCBtbV9zdHJ1Y3QgKm1tKQ0KPiAgIHsNCj4gQEAgLTMwMyw3ICszMDMsNyBAQCBub2lubGlu
ZSB2b2lkIGxvY2FsX2ZsdXNoX3RsYl9tbShzdHJ1Y3QgbW1fc3RydWN0ICptbSkNCj4gICAgKiBE
aWZmZXJlbmNlIGJldHdlZW4gdGhpcyBhbmQgS2VybmVsIFJhbmdlIEZsdXNoIGlzDQo+ICAgICog
IC1IZXJlIHRoZSBmYXN0ZXN0IHdheSAoaWYgcmFuZ2UgaXMgdG9vIGxhcmdlKSBpcyB0byBtb3Zl
IHRvIG5leHQgQVNJRA0KPiAgICAqICAgICAgd2l0aG91dCBkb2luZyBhbnkgZXhwbGljaXQgU2hv
b3Rkb3duDQo+IC0gKiAgLUluIGNhc2Ugb2Yga2VybmVsIEZsdXNoLCBlbnRyeSBoYXMgdG8gYmUg
c2hvdCBkb3duIGV4cGxpY3RseQ0KPiArICogIC1JbiBjYXNlIG9mIGtlcm5lbCBGbHVzaCwgZW50
cnkgaGFzIHRvIGJlIHNob3QgZG93biBleHBsaWNpdGx5DQo+ICAgICovDQo+ICAgdm9pZCBsb2Nh
bF9mbHVzaF90bGJfcmFuZ2Uoc3RydWN0IHZtX2FyZWFfc3RydWN0ICp2bWEsIHVuc2lnbmVkIGxv
bmcgc3RhcnQsDQo+ICAgCQkJICAgdW5zaWduZWQgbG9uZyBlbmQpDQo+IEBAIC02MjAsNyArNjIw
LDcgQEAgdm9pZCB1cGRhdGVfbW11X2NhY2hlKHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1hLCB1
bnNpZ25lZCBsb25nIHZhZGRyX3VuYWxpZ25lZCwNCj4gICAgKiBTdXBlciBQYWdlIHNpemUgaXMg
Y29uZmlndXJhYmxlIGluIGhhcmR3YXJlICg0SyB0byAxNk0pLCBidXQgZml4ZWQgb25jZQ0KPiAg
ICAqIFJUTCBidWlsZHMuDQo+ICAgICoNCj4gLSAqIFRoZSBleGFjdCBUSFAgc2l6ZSBhIExpbngg
Y29uZmlndXJhdGlvbiB3aWxsIHN1cHBvcnQgaXMgYSBmdW5jdGlvbiBvZjoNCj4gKyAqIFRoZSBl
eGFjdCBUSFAgc2l6ZSBhIExpbnV4IGNvbmZpZ3VyYXRpb24gd2lsbCBzdXBwb3J0IGlzIGEgZnVu
Y3Rpb24gb2Y6DQo+ICAgICogIC0gTU1VIHBhZ2Ugc2l6ZSAodHlwaWNhbCA4SywgUlRMIGZpeGVk
KQ0KPiAgICAqICAtIHNvZnR3YXJlIHBhZ2Ugd2Fsa2VyIGFkZHJlc3Mgc3BsaXQgYmV0d2VlbiBQ
R0Q6UFRFOlBGTiAodHlwaWNhbA0KPiAgICAqICAgIDExOjg6MTMsIGJ1dCBjYW4gYmUgY2hhbmdl
ZCB3aXRoIDEgbGluZSkNCj4gQEAgLTY5OCw3ICs2OTgsNyBAQCB2b2lkIGxvY2FsX2ZsdXNoX3Bt
ZF90bGJfcmFuZ2Uoc3RydWN0IHZtX2FyZWFfc3RydWN0ICp2bWEsIHVuc2lnbmVkIGxvbmcgc3Rh
cnQsDQo+ICAgDQo+ICAgI2VuZGlmDQo+ICAgDQo+IC0vKiBSZWFkIHRoZSBDYWNoZSBCdWlsZCBD
b25mdXJhdGlvbiBSZWdpc3RlcnMsIERlY29kZSB0aGVtIGFuZCBzYXZlIGludG8NCj4gKy8qIFJl
YWQgdGhlIENhY2hlIEJ1aWxkIENvbmZpZ3VyYXRpb24gUmVnaXN0ZXJzLCBEZWNvZGUgdGhlbSBh
bmQgc2F2ZSBpbnRvDQo+ICAgICogdGhlIGNwdWluZm8gc3RydWN0dXJlIGZvciBsYXRlciB1c2Uu
DQo+ICAgICogTm8gVmFsaWRhdGlvbiBpcyBkb25lIGhlcmUsIHNpbXBseSByZWFkL2NvbnZlcnQg
dGhlIEJDUnMNCj4gICAgKi8NCj4gQEAgLTgwMywxMyArODAzLDEzIEBAIHZvaWQgYXJjX21tdV9p
bml0KHZvaWQpDQo+ICAgCXByX2luZm8oIiVzIiwgYXJjX21tdV9tdW1ib2p1bWJvKDAsIHN0ciwg
c2l6ZW9mKHN0cikpKTsNCj4gICANCj4gICAJLyoNCj4gLQkgKiBDYW4ndCBiZSBkb25lIGluIHBy
b2Nlc3Nvci5oIGR1ZSB0byBoZWFkZXIgaW5jbHVkZSBkZXBlbmVkZW5jaWVzDQo+ICsJICogQ2Fu
J3QgYmUgZG9uZSBpbiBwcm9jZXNzb3IuaCBkdWUgdG8gaGVhZGVyIGluY2x1ZGUgZGVwZW5kZW5j
aWVzDQo+ICAgCSAqLw0KPiAgIAlCVUlMRF9CVUdfT04oIUlTX0FMSUdORUQoKENPTkZJR19BUkNf
S1ZBRERSX1NJWkUgPDwgMjApLCBQTURfU0laRSkpOw0KPiAgIA0KPiAgIAkvKg0KPiAgIAkgKiBz
dGFjayB0b3Agc2l6ZSBzYW5pdHkgY2hlY2ssDQo+IC0JICogQ2FuJ3QgYmUgZG9uZSBpbiBwcm9j
ZXNzb3IuaCBkdWUgdG8gaGVhZGVyIGluY2x1ZGUgZGVwZW5lZGVuY2llcw0KPiArCSAqIENhbid0
IGJlIGRvbmUgaW4gcHJvY2Vzc29yLmggZHVlIHRvIGhlYWRlciBpbmNsdWRlIGRlcGVuZGVuY2ll
cw0KPiAgIAkgKi8NCj4gICAJQlVJTERfQlVHX09OKCFJU19BTElHTkVEKFNUQUNLX1RPUCwgUE1E
X1NJWkUpKTsNCj4gICANCj4gQEAgLTg4MSw3ICs4ODEsNyBAQCB2b2lkIGFyY19tbXVfaW5pdCh2
b2lkKQ0KPiAgICAqICAgICAgdGhlIGR1cGxpY2F0ZSBvbmUuDQo+ICAgICogLUtub2IgdG8gYmUg
dmVyYm9zZSBhYnQgaXQuKFRPRE86IGhvb2sgdGhlbSB1cCB0byBkZWJ1Z2ZzKQ0KPiAgICAqLw0K
PiAtdm9sYXRpbGUgaW50IGR1cF9wZF9zaWxlbnQ7IC8qIEJlIHNsaWVudCBhYnQgaXQgb3IgY29t
cGxhaW4gKGRlZmF1bHQpICovDQo+ICt2b2xhdGlsZSBpbnQgZHVwX3BkX3NpbGVudDsgLyogQmUg
c2lsZW50IGFidCBpdCBvciBjb21wbGFpbiAoZGVmYXVsdCkgKi8NCj4gICANCj4gICB2b2lkIGRv
X3RsYl9vdmVybGFwX2ZhdWx0KHVuc2lnbmVkIGxvbmcgY2F1c2UsIHVuc2lnbmVkIGxvbmcgYWRk
cmVzcywNCj4gICAJCQkgIHN0cnVjdCBwdF9yZWdzICpyZWdzKQ0KPiBAQCAtOTQ4LDcgKzk0OCw3
IEBAIHZvaWQgZG9fdGxiX292ZXJsYXBfZmF1bHQodW5zaWduZWQgbG9uZyBjYXVzZSwgdW5zaWdu
ZWQgbG9uZyBhZGRyZXNzLA0KPiAgIA0KPiAgIC8qKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKg0KPiAgICAqIERpYWdu
b3N0aWMgUm91dGluZXMNCj4gLSAqICAtQ2FsbGVkIGZyb20gTG93IExldmVsIFRMQiBIYW5sZGVy
cyBpZiB0aGluZ3MgZG9uO3QgbG9vayBnb29kDQo+ICsgKiAgLUNhbGxlZCBmcm9tIExvdyBMZXZl
bCBUTEIgSGFuZGxlcnMgaWYgdGhpbmdzIGRvbjt0IGxvb2sgZ29vZA0KPiAgICAqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqLw0KPiAgIA0KPiAgICNpZmRlZiBDT05GSUdfQVJDX0RCR19UTEJfUEFSQU5PSUENCg0K

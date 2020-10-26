Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 377E92986B4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 07:01:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1770196AbgJZGBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 02:01:45 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:43764 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1770187AbgJZGBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 02:01:44 -0400
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 14919400E5;
        Mon, 26 Oct 2020 06:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1603692103; bh=FsdOm5gGR2/w5Kxh8y+nS0KonT4YOb+yUL867yxfZdA=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=JJFN/rqV9Y5ELkQJADyEa5Kgy5paPDuU/XgieA+nagXYu1N7D/Bam9rWC8Ty40bW0
         TMthNp6Nk4tsr5kMYD+8nfNMpGhvaTEFj5Z2wDY8WJhpi7zn8NlSKkkySsX08Lz0KM
         DzPzEWANvO6tInWxudyvDT+KEmHnoqMTVha5pU4KGTycw4gvcBbQeq+/fmBX8/NwHT
         4tikeBoI59gRdVxE0xfdOsbS20/llvRnt3aGmQIEAXHox1729BQcmzgq5o3EThAN10
         36V8A1DqVNNb1UtEtcp5bkPa7e/nEk/GGLdR3BabHll/vdR45DOY9ItwMSi+/Xd8qD
         /MoQrTAIU9Gsg==
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 0ECB7A0063;
        Mon, 26 Oct 2020 06:01:42 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "GlobalSign Organization Validation CA - SHA256 - G3" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id AA1A980192;
        Mon, 26 Oct 2020 06:01:40 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=hminas@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="mosSVG3O";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DdOFoFz9zShlT7580lew5KXPEvUrCQf204xR5D0/q5jwZklMokQwL2a5FI90hlTPnHTPNW2/RVpKp/uwDJUwHf/3eVlQEGOt0zEFlo08uCxa0flEiDxENfWjIUho1SmgqBs51W1LGw4O2+9EIJWSFORA0XzKvHrZi7oXJOI/5Ei6nMHx8951CKzAa6Xuww+aVRpl4GGPNYhC400jWNr3XpnCoS5DNSLgBCVpuAD3Rws/9HWeEEgbo5n3Q7TKTAbBmVaav/gS7m2kL+FQu12KDu/5G14ZdGJPvZEwKrinVDe+yvKXp8HMKA75CA0k0woN3jEBqX53HDze8BMVIvMkew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FsdOm5gGR2/w5Kxh8y+nS0KonT4YOb+yUL867yxfZdA=;
 b=FnBnmio4HdCEX/RHmipdwfzzA7FKnAar/0llUG+NcYxRg6NXXRp3q7tzKc53XEs23If34EXukHlvJEVMiwiCDMB1u4ZLCFc11uFQxP+fpqPgUtPhyCY+hRO1FFq87QSmc7JRiup7WPJ1Xsa+oy+Ki/Z7znQ2cSGjv8Thhk3lzj+WAcArEjZUSUIJKlg3thETkCcFjMe4dGRNT45qOT4G5tsJofGKu7NWnnGIzCQXf/TasmKAboxBX5fbmP04wY+6shk9wYAyF8oY7zT9A4tT06EujMOQ6FXhlSBqpVJdgDJ0BBTg4BImRungncC94V7zegjsAGUxt3SyZNbErRwdgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FsdOm5gGR2/w5Kxh8y+nS0KonT4YOb+yUL867yxfZdA=;
 b=mosSVG3OoS0gXBEh0m5IAs2o5OxsGprvBh5lGlxNDmNYLD/OfiTAb2V9R1Sm4cY16ubZKNTJlQxJATJAQT6xB35kwOxSS5mStQbM6oketNZSlquThx37kYlCOPXaE+FuqAiIzq/s/r7NmZH+72S+PnivkDkTQireo9UKkE4HdNg=
Received: from BY5PR12MB3777.namprd12.prod.outlook.com (2603:10b6:a03:1a9::14)
 by BYAPR12MB2789.namprd12.prod.outlook.com (2603:10b6:a03:72::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.28; Mon, 26 Oct
 2020 06:01:38 +0000
Received: from BY5PR12MB3777.namprd12.prod.outlook.com
 ([fe80::dce3:484b:db4f:c21b]) by BY5PR12MB3777.namprd12.prod.outlook.com
 ([fe80::dce3:484b:db4f:c21b%3]) with mapi id 15.20.3499.018; Mon, 26 Oct 2020
 06:01:38 +0000
X-SNPS-Relay: synopsys.com
From:   Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] usb: dwc2: Avoid leaving the error_debugfs label unused
Thread-Topic: [PATCH] usb: dwc2: Avoid leaving the error_debugfs label unused
Thread-Index: AQHWpKWdgynXZ63qEk2uCDp0fdh8B6mpcaKA
Date:   Mon, 26 Oct 2020 06:01:38 +0000
Message-ID: <d9ba8841-ec7a-d599-2036-30ab8a089f09@synopsys.com>
References: <20201017165012.546729-1-martin.blumenstingl@googlemail.com>
In-Reply-To: <20201017165012.546729-1-martin.blumenstingl@googlemail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
authentication-results: googlemail.com; dkim=none (message not signed)
 header.d=none;googlemail.com; dmarc=none action=none
 header.from=synopsys.com;
x-originating-ip: [37.252.81.52]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a561d833-9a34-46d3-538c-08d879749a87
x-ms-traffictypediagnostic: BYAPR12MB2789:
x-microsoft-antispam-prvs: <BYAPR12MB2789B0D0A6D9D338F0AF65DEA7190@BYAPR12MB2789.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EjbxF/hZgvanS15idANDEEZtQlUq3g/qO60PCZsOJl5x5Rt9bOkpARa3On6demjBvRHqOkrHpRD3kM3LGozr/wBPq8sp/XzWmTLabvVfiJiDq/ZLFtEPVTrQ0VwpysO5BC1ImCIpxBwA6YOEbya7/lzq+tBfi5UOo5Jt/EEyEaChWW/9fWaawY6IIfl7GwvOMtWY97d45ubCTd4ZtLOL9+cJQM8CiFlrvmgPIF8YAOiq3G6W+axEU/QtZOyUThQV8de6qCUfyD8cGmyhd/Gr0v7xhFVf0bKdWJVvhAewfNZfQrHSQChXX0QuO2a/TnaZWDB6PiP6X4G/ydHd0ixMisw6wNNluDNzvyCmfbjCY8mb0BHJ9lIhQn0CPnKpJwrF
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3777.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(366004)(396003)(376002)(39850400004)(71200400001)(6512007)(53546011)(110136005)(5660300002)(6506007)(31696002)(8936002)(83380400001)(54906003)(26005)(36756003)(186003)(2906002)(2616005)(478600001)(86362001)(6486002)(4326008)(66476007)(76116006)(66446008)(31686004)(316002)(66946007)(8676002)(91956017)(64756008)(66556008)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: dWcxps/VClxcCbdgYsTP2R7OkHstOGmqZufoq8pMFFYJH1thFNwCThJV7JNY+C9d4zjLIAk3g8BBExb5xlqAZT691C8UP9C1dKuGKijCBWm/ebe47wwXHABQhfA0ShnDbFf5R4PlwMTld0WE8yF4+S5LeKwEbPQnfkrdtja7V6c8JCXuP2U0Wnud3rv7zVWBCqO24EUN69bKs+ZLBnIlxwikCWQNAeosmeroxK+5ADhra7lSx7Njv7eQABlYnjZP1L53A8GSXqawMHJ8fQBoxj840+znPmXG39FJh8/HRrm5fi8zejR1AUvzVuVVAGp7Ht5rrWu5l9N3W0I47pAblNUTHn+zueNsEUHJrk/Zy8Bfa6NhbQkDen1jufLXlAOFrPXbS5nY2TsggF0oIxa9/SKdba2DHEqW8cPRXDPM//kS63q6ApX+ay5S1ofJ8xDlp0FSwd53X7fx3YgKAIJxG/+feDcQWGjEZLUuOOjBcssTeQBTIDSQWENlpRjVcjDv8Z8BJCodxfJgXGSKQQ+3ChTT7IzqmxGn9O6jblbGoIXIK9ENfDhIbi5HS678FaGsFd63EXtjpouV4MUCICdideHrw9t+O03SjhBZuIWkcKd232xyiWPfW9zzi6inN5E4WcFTuIFHGjjxvionYpv+XA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <5655993886AEC04483D0E5A8B9452742@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3777.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a561d833-9a34-46d3-538c-08d879749a87
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2020 06:01:38.8162
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tc97p82IevX0IbZwbrDQMSzPdR2Iu1O8HrSA20duGIdyL2QeOBo1Yy3uD+tNphR5T9TPSZtUxpina82BvS4/jQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2789
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTAvMTcvMjAyMCA4OjUwIFBNLCBNYXJ0aW4gQmx1bWVuc3RpbmdsIHdyb3RlOg0KPiBUaGUg
ZXJyb3JfZGVidWdmcyBsYWJlbCBpcyBvbmx5IHVzZWQgd2hlbiBlaXRoZXINCj4gQ09ORklHX1VT
Ql9EV0MyX1BFUklQSEVSQUwgb3IgQ09ORklHX1VTQl9EV0MyX0RVQUxfUk9MRSBpcyBlbmFibGVk
LiBBZGQNCj4gdGhlIHNhbWUgI2lmIHRvIHRoZSBlcnJvcl9kZWJ1Z2ZzIGxhYmVsIGl0c2VsZiBh
cyB0aGUgY29kZSB3aGljaCB1c2VzDQo+IHRoaXMgbGFiZWwgYWxyZWFkeSBoYXMuDQo+IA0KPiBU
aGlzIGF2b2lkcyB0aGUgZm9sbG93aW5nIGNvbXBpbGVyIHdhcm5pbmc6DQo+ICAgIHdhcm5pbmc6
IGxhYmVsIOKAmGVycm9yX2RlYnVnZnPigJkgZGVmaW5lZCBidXQgbm90IHVzZWQgWy1XdW51c2Vk
LWxhYmVsXQ0KPiANCj4gRml4ZXM6IGUxYzA4Y2YyMzE3MmVkICgidXNiOiBkd2MyOiBBZGQgbWlz
c2luZyBjbGVhbnVwcyB3aGVuIHVzYl9hZGRfZ2FkZ2V0X3VkYygpIGZhaWxzIikNCj4gUmVwb3J0
ZWQtYnk6IGtlcm5lbCB0ZXN0IHJvYm90IDxsa3BAaW50ZWwuY29tPg0KPiBSZXBvcnRlZC1ieTog
SmVucyBBeGJvZSA8YXhib2VAa2VybmVsLmRrPg0KPiBTaWduZWQtb2ZmLWJ5OiBNYXJ0aW4gQmx1
bWVuc3RpbmdsIDxtYXJ0aW4uYmx1bWVuc3RpbmdsQGdvb2dsZW1haWwuY29tPg0KPiAtLS0NCj4g
ICBkcml2ZXJzL3VzYi9kd2MyL3BsYXRmb3JtLmMgfCAzICsrKw0KPiAgIDEgZmlsZSBjaGFuZ2Vk
LCAzIGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MyL3Bs
YXRmb3JtLmMgYi9kcml2ZXJzL3VzYi9kd2MyL3BsYXRmb3JtLmMNCj4gaW5kZXggZTI4MjA2NzZi
ZWIxLi41ZjE4YWNhYzc0MDYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzIvcGxhdGZv
cm0uYw0KPiArKysgYi9kcml2ZXJzL3VzYi9kd2MyL3BsYXRmb3JtLmMNCj4gQEAgLTYwOCwxMCAr
NjA4LDEzIEBAIHN0YXRpYyBpbnQgZHdjMl9kcml2ZXJfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2Rl
dmljZSAqZGV2KQ0KPiAgICNlbmRpZiAvKiBDT05GSUdfVVNCX0RXQzJfUEVSSVBIRVJBTCB8fCBD
T05GSUdfVVNCX0RXQzJfRFVBTF9ST0xFICovDQo+ICAgCXJldHVybiAwOw0KPiAgIA0KPiArI2lm
IElTX0VOQUJMRUQoQ09ORklHX1VTQl9EV0MyX1BFUklQSEVSQUwpIHx8IFwNCj4gKwlJU19FTkFC
TEVEKENPTkZJR19VU0JfRFdDMl9EVUFMX1JPTEUpDQo+ICAgZXJyb3JfZGVidWdmczoNCj4gICAJ
ZHdjMl9kZWJ1Z2ZzX2V4aXQoaHNvdGcpOw0KPiAgIAlpZiAoaHNvdGctPmhjZF9lbmFibGVkKQ0K
PiAgIAkJZHdjMl9oY2RfcmVtb3ZlKGhzb3RnKTsNCj4gKyNlbmRpZg0KPiAgIGVycm9yX2RyZDoN
Cj4gICAJZHdjMl9kcmRfZXhpdChoc290Zyk7DQo+ICAgDQo+IA0KQWNrZWQtYnk6IE1pbmFzIEhh
cnV0eXVueWFuIDxNaW5hcy5IYXJ1dHl1bnlhbkBzeW5vcHN5cy5jb20+DQoNCg==

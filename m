Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1185C2856D8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 05:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbgJGDFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 23:05:42 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:43824 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726627AbgJGDFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 23:05:42 -0400
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id E0E3C401AD;
        Wed,  7 Oct 2020 03:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1602039942; bh=/4HxqTAHds4AYkNcJ1J7nTbokUvcJuKwy3KJ95VN1cQ=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=VgJqY7cN4Tr7nUxikVAk0v6byXsBSr6WC5bEwq3bXXmBvmQSIrtY3rOj3/u8iPQ+3
         2sHIOHUCZO8uFi3UOOd7dy+mPRctx6/X+XLwVJpaWvXbznUvBhYvW6jAiyRaUzG9Me
         ZsNYDstuJQmoNl3q/GQ55rb4LDLS4gsnwpBmiVL5PzP2H1Gublj0/TGAmDVvsmliw4
         kmsc/aCQrHEl0D3K/KuftDwwQFbsSUWUW+Dge9NDS/2a9CoKFlcqZFQxqXPZq1Kyrb
         ZJLwM+NU2KcPYw7JFgh9vzyWjHzzHi4aJxsMtv47NP6arGsLRyxMJJmLIH6lxFAWVU
         XgVTNH2EzEjEw==
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 2C72EA0072;
        Wed,  7 Oct 2020 03:05:40 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "GlobalSign Organization Validation CA - SHA256 - G3" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id E7706400A0;
        Wed,  7 Oct 2020 03:05:38 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=vgupta@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="sLkmUiHu";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HkbdO2pVjmqVE2dnWNKuC2tBDFDmiR6Mara0FbJrE/u+O2s9DtaDi7JHHqlY2m05uqLiVR6cB/RakLfr0/9Pacu7vWyngkH5StuZoH61IwrK67NOKDQheXZCR4051Noi79AGxXYuvKew+tiwsmPEu0S7Bdyqve7mgdgz7Q/iBUcGDBFD24oqbWL+IJcK0KncDY4NPXcMon2RfaNJd8f5y1zGqEHbLg4fafQk9y2Yn3lfpDZcYXM3T9hvKv2KdcALgTeia/NdL27bTPVK1Iks3NwJ7P7vanYjLD5t99uwDE30+F/HXxyVd8TOv6+eiIRtLQVj1D7oWajlMY0jzNpE9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/4HxqTAHds4AYkNcJ1J7nTbokUvcJuKwy3KJ95VN1cQ=;
 b=dhj+9qck2I4+EOupwT7V3oF/JEat5QwTyr7dVLe1b7WepA+f3fJTU8a8lH2JP+Rn8m82EGGs+7HgWpKXy5B9pTaU3FbQ2WmKpveIYxjTJ2wve+WcUGeT29G4/FGjR22hqrlvqYmr4AuM9Zz/MItLyngWQYXaAJ368Ve5SexqGw95ims1l+NnPs7eiR9VsKYBKZilvQVSqBtazAhb10fC6LCOtvWjHDtC68quSwhCjzLwHWVuyZjUfFDJp91MBckeN8VBaep5DKg/5Ceugx6PcHJcvg1RPJ975lW0lr/EEAOoK6UX8wyfrr8fq8C798bAQ/RZyVTnl7ce9GQb0tx7TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/4HxqTAHds4AYkNcJ1J7nTbokUvcJuKwy3KJ95VN1cQ=;
 b=sLkmUiHuBe2ucCKU1IgTNicqrAdQg9IxmwaDaMpJQ2IYeeq4J4YLLwriwnOHbyTgLEtKuHVcmc98YVchmeLR6nJY5W4yHxLx3fvbxjJWsvX7D7+FFUhRftl/DKye6d/AIRo1oTg9OA0TJvteOqIU9KUTE77pTwZoZ6mIBehkThs=
Received: from BYAPR12MB3479.namprd12.prod.outlook.com (2603:10b6:a03:dc::26)
 by BYAPR12MB2902.namprd12.prod.outlook.com (2603:10b6:a03:12f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.34; Wed, 7 Oct
 2020 03:05:36 +0000
Received: from BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::c962:6a42:6a0b:24e8]) by BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::c962:6a42:6a0b:24e8%5]) with mapi id 15.20.3433.045; Wed, 7 Oct 2020
 03:05:36 +0000
X-SNPS-Relay: synopsys.com
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        Dan Williams <dan.j.williams@intel.com>
CC:     kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] fs: dax: fix build error on ARC
Thread-Topic: [PATCH] fs: dax: fix build error on ARC
Thread-Index: AQHWnFU7PzDuJSEnVE6qtcjj9Ag3XamLdMiA
Date:   Wed, 7 Oct 2020 03:05:36 +0000
Message-ID: <b54c3124-5052-269e-cc03-8f0d6588fada@synopsys.com>
References: <6b5c6090-331d-7485-da4a-45e9c7f13be1@infradead.org>
In-Reply-To: <6b5c6090-331d-7485-da4a-45e9c7f13be1@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [24.4.73.83]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0d82e588-dd2d-4371-2d27-08d86a6ddd35
x-ms-traffictypediagnostic: BYAPR12MB2902:
x-microsoft-antispam-prvs: <BYAPR12MB290237EF4BD7DCB6C51255D9B60A0@BYAPR12MB2902.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7JV7rgNa6T2KC5CotcuFBHi4dTEppkYTfQuzG/dQ+ysUdLQW0+NKFUkljbEwv8UDnLXGQQNU0i+NEUOgK2ouqIBmhjvd5w9lM/cj6NFzMhxaxekY1+/At7wKXAkwvDRr4+OJU/tlfSPmt/OX4KWKJyzBQfew461rAwuP+K92VWto0m4Vlwg2n2u0RU53JMlY2MPL7xuPvl9SAaoetchaj+9UEa/nv0cTfE+ZoPojjMbxY2qyQcxH3aQanyYmvhUA4Hg6mH+gH1qj7b+sXiuYqyxpR5m12ptByjmOvdiu2ATxkaUxK+H/P1qTktP8CtuOYtaIL/AQn/WvlHwyqXO0P4mGjeERy2om4x2NR//1htkOqoXpyRAUDESnyyqdvflf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3479.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(366004)(346002)(376002)(396003)(26005)(2906002)(71200400001)(8936002)(31686004)(6486002)(83380400001)(110136005)(8676002)(4326008)(36756003)(76116006)(66446008)(6506007)(316002)(6512007)(64756008)(66556008)(66476007)(2616005)(31696002)(66946007)(186003)(53546011)(478600001)(86362001)(5660300002)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: J0ZidKyPW6ZNI5PivyWid6zwvsU3y8WTHRokKj3tAkGiqG6syNN1YglUhFkHRUrtYeAHOyxo7zQxogUfQ9+4MIxX1uTNzNAsWtij9zTMTGYSzimmsBvzFFAgNds7S80RbjoKAG2BpnhJvVBFUsv/jlAZzQyO344kQF29TKMQl0K6TwAli1j3bF956FnATzRH+ZGiGatbRYkJUz7oVmLUPIywOUlkRM01h10GRvK50OiSTs+XuVTn7kj0MXm2iQxt75L9q7DlV4A47i9ZcTpAgPiBeYq3oX7A+MCJFOoZU63vAA7FNkDvy6al5HMcfulsFay+miTMt/CH8m71UljTq4hoz462gMrhVDoO5d9x7a7/3urerQnBRoHltGvq2n/oY6W/G62Y7ldYiivQQrpB9uXy1+iYErlsihdzqte4STnrxEKEZw1zbl94Fnc6tMWELKvVzm9gCprXluSuUvPKaiYvmR0ecDWocrn9XgMMPPiLlMOJRpkTqoZHAdL6v6TQrJhaxxwseDL7zh88sPuQV4L5IogPEP9tr129s9RLD3pcaMp8DndcWJuQb1JFBcdzqe+lFnTZYgLcC1ldNQLnrAAFC3vt/6QTD/6gkdiDyeCSHTuua8Mi596pzMMDoqdyP+xc9Rl8wN0GjVeOGI0zJA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <AD4E279430298D4A8F639273E3ADEBF4@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3479.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d82e588-dd2d-4371-2d27-08d86a6ddd35
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2020 03:05:36.6605
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /KJdUSTpGFWbm79XwcL3rCygHlXrgLfazOJZFvo770vze03ZUJbtHaR5whs3wdxl8AiGEO+hz1zkqlPIE+puzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2902
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTAvNi8yMCA3OjU0IFBNLCBSYW5keSBEdW5sYXAgd3JvdGU6DQo+IEZyb206IFJhbmR5IER1
bmxhcCA8cmR1bmxhcEBpbmZyYWRlYWQub3JnPg0KPiANCj4gZnMvZGF4LmMgdXNlcyBjb3B5X3Vz
ZXJfcGFnZSgpIGJ1dCBBUkMgZG9lcyBub3QgcHJvdmlkZSB0aGF0IGludGVyZmFjZSwNCj4gcmVz
dWx0aW5nIGluIGEgYnVpbGQgZXJyb3IuDQo+IA0KPiBQcm92aWRlIGNvcHlfdXNlcl9wYWdlKCkg
aW4gPGFzbS9wYWdlLmg+IChiZXNpZGUgY29weV9wYWdlKCkpIGFuZA0KPiBhZGQgPGFzbS9wYWdl
Lmg+IHRvIGZzL2RheC5jIHRvIGZpeCB0aGUgYnVpbGQgZXJyb3IuDQo+IA0KPiAuLi9mcy9kYXgu
YzogSW4gZnVuY3Rpb24gJ2NvcHlfY293X3BhZ2VfZGF4JzoNCj4gLi4vZnMvZGF4LmM6NzAyOjI6
IGVycm9yOiBpbXBsaWNpdCBkZWNsYXJhdGlvbiBvZiBmdW5jdGlvbiAnY29weV91c2VyX3BhZ2Un
OyBkaWQgeW91IG1lYW4gJ2NvcHlfdG9fdXNlcl9wYWdlJz8gWy1XZXJyb3I9aW1wbGljaXQtZnVu
Y3Rpb24tZGVjbGFyYXRpb25dDQo+IA0KPiBGaXhlczogY2NjYmNlNjcxNTgyICgiZmlsZXN5c3Rl
bS1kYXg6IGNvbnZlcnQgdG8gZGF4X2RpcmVjdF9hY2Nlc3MoKSIpDQo+IFJlcG9ydGVkLWJ5OiBr
ZXJuZWwgdGVzdCByb2JvdCA8bGtwQGludGVsLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogUmFuZHkg
RHVubGFwIDxyZHVubGFwQGluZnJhZGVhZC5vcmc+DQo+IENjOiBWaW5lZXQgR3VwdGEgPHZndXB0
YUBzeW5vcHN5cy5jb20+DQo+IENjOiBsaW51eC1zbnBzLWFyY0BsaXN0cy5pbmZyYWRlYWQub3Jn
DQo+IENjOiBEYW4gV2lsbGlhbXMgPGRhbi5qLndpbGxpYW1zQGludGVsLmNvbT4NCj4gLS0tDQo+
IFZpbmVldCwgVGhpcyBwYXRjaCBmaXhlcyB0aGUgYnVpbGQgZXJyb3IgYnV0IGlzIGl0IGNvcnJl
Y3QgZm9yIEFSQz8NCg0KWWVwIHRoaXMgbG9va3MgZ29vZC4gTm90aGluZyBzcGVjaWFsIG5lZWRz
IHRvIGJlIGRvbmUgZm9yIHVzZXIgcGFnZXMgb24gQVJDLg0KDQpBY2tlZC1ieTogVmluZWV0IEd1
cHRhIDx2Z3VwdHNAc3lub3BzeXMuY29tPg0KDQpUaHgsDQotVmluZWV0DQoNCj4gDQo+ICBhcmNo
L2FyYy9pbmNsdWRlL2FzbS9wYWdlLmggfCAgICAxICsNCj4gIGZzL2RheC5jICAgICAgICAgICAg
ICAgICAgICB8ICAgIDEgKw0KPiAgMiBmaWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCj4g
DQo+IC0tLSBsbngtNTktcmM3Lm9yaWcvZnMvZGF4LmMNCj4gKysrIGxueC01OS1yYzcvZnMvZGF4
LmMNCj4gQEAgLTI1LDYgKzI1LDcgQEANCj4gICNpbmNsdWRlIDxsaW51eC9zaXplcy5oPg0KPiAg
I2luY2x1ZGUgPGxpbnV4L21tdV9ub3RpZmllci5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L2lvbWFw
Lmg+DQo+ICsjaW5jbHVkZSA8YXNtL3BhZ2UuaD4NCj4gICNpbmNsdWRlIDxhc20vcGdhbGxvYy5o
Pg0KPiAgDQo+ICAjZGVmaW5lIENSRUFURV9UUkFDRV9QT0lOVFMNCj4gLS0tIGxueC01OS1yYzcu
b3JpZy9hcmNoL2FyYy9pbmNsdWRlL2FzbS9wYWdlLmgNCj4gKysrIGxueC01OS1yYzcvYXJjaC9h
cmMvaW5jbHVkZS9hc20vcGFnZS5oDQo+IEBAIC0xMCw2ICsxMCw3IEBADQo+ICAjaWZuZGVmIF9f
QVNTRU1CTFlfXw0KPiAgDQo+ICAjZGVmaW5lIGNsZWFyX3BhZ2UocGFkZHIpCQltZW1zZXQoKHBh
ZGRyKSwgMCwgUEFHRV9TSVpFKQ0KPiArI2RlZmluZSBjb3B5X3VzZXJfcGFnZSh0bywgZnJvbSwg
dmFkZHIsIHBnKQljb3B5X3BhZ2UodG8sIGZyb20pDQo+ICAjZGVmaW5lIGNvcHlfcGFnZSh0bywg
ZnJvbSkJCW1lbWNweSgodG8pLCAoZnJvbSksIFBBR0VfU0laRSkNCj4gIA0KPiAgc3RydWN0IHZt
X2FyZWFfc3RydWN0Ow0KPiANCj4gDQoNCg==

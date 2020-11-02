Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF2A92A24FD
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 08:04:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbgKBHEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 02:04:34 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:33900 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727743AbgKBHEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 02:04:33 -0500
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id B65F1C00F5;
        Mon,  2 Nov 2020 07:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1604300673; bh=OfxxwfV7cFy/svZPY9Cg6D0VEQy7Jau/Jjgg0auD23U=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=OzTbcCoKYqghRZL8ONO+B6FHkvbHWjUJ8YnqcylUhKiM3SR+WR5WEypzTI1m1p9i2
         fJO+K233CuZ09ezq+MPAXJYRYKUVpqdOIi3yjkIfPEfzW0kMTSFYy5MdxZFB1zPOsS
         QOHJe+JSMu0W4ZczEq1UI5ElKKs3ryKk8uqzNYcZb7w+XpXKMWnTn2kOd5MAk/zEA1
         vqsKy7J+aPJe+sH/vn4w0P6p6K55N9cO0Nn7o28OqpBzo3n7g5TybEUIe7SLwBDC63
         KQDp2f4GgafGVsxW1AhgokeiILHyT4fcg/uzCCQitlkMT79mPBxtzKXr+ZvKQ0KmnK
         kywjkmhAiE6sA==
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 1015FA0096;
        Mon,  2 Nov 2020 07:04:31 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2042.outbound.protection.outlook.com [104.47.73.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "GlobalSign Organization Validation CA - SHA256 - G3" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id EBDB08000A;
        Mon,  2 Nov 2020 07:04:30 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=hminas@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="QkbuLl1y";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eN0WPRcuS9OjyiRtBAHWwH/hoZxr7LZQsjNIRZyBhqcuu0VplAD+fCr/htqSRIxo0HgbxXErcTHlvYhXcSOQ6dxPe0fQo8JAODirDQHHyrayXju7SFenN2uHz0rHCFZi+jbPdsS8pR4NFkMZuB24CyGh6WcnqIqEa6lCk6k9kynmaEImfWM2AX6isCPLQ5OMuWrcmTFmgWAbMpvJVZHgOBTh9G4Au2vv7zRyOcg6payh+44mwRkRP6riekcnPiLe7i2ANgX/vVhabQBVkiETqE/GTH5E+pBBpJgczMp+BikQFmYwOAXbQl23VOQMTuRuGFJ1DUEZzQDd+dXOKJrRQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OfxxwfV7cFy/svZPY9Cg6D0VEQy7Jau/Jjgg0auD23U=;
 b=ZimkZPT9oB+qvGwUJWS2AEi1Qahb4UXKQhgpGiS/JVp8swwQU0lILSll/BK7nFmp7vbJbeyV/yuS6esTuBOGGe5quYZH2UVBnDyF0uc6jlEbCer5HoQrjnLPWigRvLjNX6IHVPL2mnuI2eFFlw2MnIb1QCXdefAnAYvu7gccOd4/Q3+EZ8QOUCN8VO+AxfF3ZCz+Z/1MFTFaMhQ2a/voNRNZH+J2+0tMg7nhZpEPfufpHj2szg7qzxCKUbUbRxJIvU5vtbKyDCSzy0Zl9HiBaabY+FcCORszuqma6T6VCEZI4EME7n7Z9C30b967peV/Z0BafsZFh4YnSKDhgYcdLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OfxxwfV7cFy/svZPY9Cg6D0VEQy7Jau/Jjgg0auD23U=;
 b=QkbuLl1yHsN5ksjYuFUg3MRD9fGcjTU/+jf4BGEYXfaeVZzKlpdQT2nC+rGj81odzmYUO7NxBehc0umblSH+jhA0PPkLu8Q5V+PGqCHR8MzbpmQEGCrVPnwzmPh8A3xbw7+pi13eT3g0Ypkzn55anW0nb6kuUSn7vks0DmkqgEI=
Received: from BY5PR12MB3777.namprd12.prod.outlook.com (2603:10b6:a03:1a9::14)
 by BY5PR12MB4161.namprd12.prod.outlook.com (2603:10b6:a03:209::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19; Mon, 2 Nov
 2020 07:04:29 +0000
Received: from BY5PR12MB3777.namprd12.prod.outlook.com
 ([fe80::dce3:484b:db4f:c21b]) by BY5PR12MB3777.namprd12.prod.outlook.com
 ([fe80::dce3:484b:db4f:c21b%3]) with mapi id 15.20.3499.030; Mon, 2 Nov 2020
 07:04:29 +0000
X-SNPS-Relay: synopsys.com
From:   Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
To:     YueHaibing <yuehaibing@huawei.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc2: Fix unused label warning
Thread-Topic: [PATCH] usb: dwc2: Fix unused label warning
Thread-Index: AQHWr0uxMckH+CKXQk+bjA3zHhTWAam0bjcA
Date:   Mon, 2 Nov 2020 07:04:29 +0000
Message-ID: <d3249c9c-e937-7ba1-e21b-3c89a79cb184@synopsys.com>
References: <20201031060342.43384-1-yuehaibing@huawei.com>
In-Reply-To: <20201031060342.43384-1-yuehaibing@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [37.252.81.52]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 92ba6b98-0e34-42bb-8ce9-08d87efd8af6
x-ms-traffictypediagnostic: BY5PR12MB4161:
x-microsoft-antispam-prvs: <BY5PR12MB4161830F285E06A1EE9ED8F8A7100@BY5PR12MB4161.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SCHL0fjbPlPA/3dHezyACJfoo86coLn2pjn25ZsxLYawe3LTC/dZSr+OvEIDv9H53bH2Ch+5Z8JMBml2cktdtNdvEic10WS8zGmZgrL/pg5/Wuaqpzswy+HEA7Urq6sL9EJqIUPhmvx0x8KcUZd5iE0bjrR2pQesbMxd7/6xNXpkpjXr56sber9/CljhqbrtlvGWffakQ0MF/AFF51QHBeHc5LdaYMNdFWGNtgPRnrAGTtioJPAdPFIMsNhot7QTeX8ljv3r4j6SdQBY7sWLEZoir6lb3K7shN+rBx7l1EoLjL5Mgt2BrvxWvvf4Y/PA8RjcijCZJ4/e0MWJvCtRI3MrKB7yZJHBeTIlgacvtkzDd1TWhtfRJMWUcGm6zUrI
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3777.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(376002)(396003)(136003)(366004)(26005)(186003)(8676002)(478600001)(5660300002)(8936002)(6486002)(6506007)(53546011)(2906002)(66446008)(83380400001)(2616005)(91956017)(76116006)(36756003)(64756008)(110136005)(31696002)(66556008)(54906003)(66476007)(4326008)(6512007)(66946007)(316002)(86362001)(31686004)(71200400001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: t4TYHm9MYpYezgAC43Nvhli1GuftXurza5+fuztZZ8UHsP9DHSsDXAKnN/OlyrVG85VdWzWchEpX9J/P4A3mvBSIwiouPDpWElWDcK41JL6rhLdIRINhCbYP1pbWYKUzgNilWMFey3KP9ntHSMhRQOqVCztTnw2tGUTO2V/zkBHrMUMk6dgEbR4UpdTMnHLYgkyOlbOc7bekPksKz/eXjhN1LfIex/0bXVOBryWkBnezaQ8Yu+xbWOMfGjEKuRMLQtv3vxGOOfTFJ+McLEBrSxaa3ZLY1rw+sX8IkFNsTdE72Ix3IAYEx/x9HtQ6xe4pajrry7cwWOydIgCgz1+V52JetDtJ3RRR/iJu69D/W9Z2ZXgPlyMMBdIa+VN5CpH4VHdiCj3KfbyenH7ZaHi2WWDQiIUmnUclJSx4LyK8d3ztRO5CUh2guEHxrsuXtPcZB0NxceM4BXHPBprS4nyfdQtRAncyj8bG1On1EHnMdIPIlqP+f2EJVxUzDXPSOQhwCI4VYD+AeFIvUSeWItkhDetxsH+lrWlACR3K0sFEXvaYPIKqLupLztELAnrlVpQHAc5Hxv0L8MSUNR8mB735RD0xUOZBJEm9T4XbidJdb2cWA4AAoZls7o3mNP/3QqJ7XUMZAwjDoHQACqBlTGjSDQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <0E8ACA767970E540BEA67C5DE8E1E0D7@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3777.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92ba6b98-0e34-42bb-8ce9-08d87efd8af6
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2020 07:04:29.5175
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xWsN5eHG65KOURhRGg9TS+P8XTGsdywZN71dzrJaxMiG2HyMStK/TuHwNuJptKWk+9GB89fPS7fIVc3qpY1UaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4161
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTAvMzEvMjAyMCAxMDowMyBBTSwgWXVlSGFpYmluZyB3cm90ZToNCj4gZHJpdmVycy91c2Iv
ZHdjMi9wbGF0Zm9ybS5jOiBJbiBmdW5jdGlvbiDigJhkd2MyX2RyaXZlcl9wcm9iZeKAmToNCj4g
ZHJpdmVycy91c2IvZHdjMi9wbGF0Zm9ybS5jOjYxMToxOiB3YXJuaW5nOiBsYWJlbCDigJhlcnJv
cl9kZWJ1Z2Zz4oCZIGRlZmluZWQgYnV0IG5vdCB1c2VkIFstV3VudXNlZC1sYWJlbF0NCj4gICBl
cnJvcl9kZWJ1Z2ZzOg0KPiAgIF5+fn5+fn5+fn5+fn4NCj4gDQo+IE1vdmUgbGFiZWwgJ2Vycm9y
X2RlYnVnZnMnIHRvIGlmZGVmIGJsb2NrLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogWXVlSGFpYmlu
ZyA8eXVlaGFpYmluZ0BodWF3ZWkuY29tPg0KPiAtLS0NCj4gICBkcml2ZXJzL3VzYi9kd2MyL3Bs
YXRmb3JtLmMgfCAzICsrKw0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykNCj4g
DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MyL3BsYXRmb3JtLmMgYi9kcml2ZXJzL3Vz
Yi9kd2MyL3BsYXRmb3JtLmMNCj4gaW5kZXggZTI4MjA2NzZiZWIxLi41ZjE4YWNhYzc0MDYgMTAw
NjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzIvcGxhdGZvcm0uYw0KPiArKysgYi9kcml2ZXJz
L3VzYi9kd2MyL3BsYXRmb3JtLmMNCj4gQEAgLTYwOCwxMCArNjA4LDEzIEBAIHN0YXRpYyBpbnQg
ZHdjMl9kcml2ZXJfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqZGV2KQ0KPiAgICNlbmRp
ZiAvKiBDT05GSUdfVVNCX0RXQzJfUEVSSVBIRVJBTCB8fCBDT05GSUdfVVNCX0RXQzJfRFVBTF9S
T0xFICovDQo+ICAgCXJldHVybiAwOw0KPiAgIA0KPiArI2lmIElTX0VOQUJMRUQoQ09ORklHX1VT
Ql9EV0MyX1BFUklQSEVSQUwpIHx8IFwNCj4gKwlJU19FTkFCTEVEKENPTkZJR19VU0JfRFdDMl9E
VUFMX1JPTEUpDQo+ICAgZXJyb3JfZGVidWdmczoNCj4gICAJZHdjMl9kZWJ1Z2ZzX2V4aXQoaHNv
dGcpOw0KPiAgIAlpZiAoaHNvdGctPmhjZF9lbmFibGVkKQ0KPiAgIAkJZHdjMl9oY2RfcmVtb3Zl
KGhzb3RnKTsNCj4gKyNlbmRpZg0KPiAgIGVycm9yX2RyZDoNCj4gICAJZHdjMl9kcmRfZXhpdCho
c290Zyk7DQo+ICAgDQo+IA0KVGhhbmsgeW91IGZvciBwYXRjaC4gSWRlbnRpY2FsIHBhdGNoIHN1
Ym1pdHRlZCBieSBvbiAxMC8xNy8yMDIwIGJ5IA0KTWFydGluIEJsdW1lbnN0aW5nbDogW1BBVENI
XSB1c2I6IGR3YzI6IEF2b2lkIGxlYXZpbmcgdGhlIGVycm9yX2RlYnVnZnMgDQpsYWJlbCB1bnVz
ZWQuIEknbSBhbHJlYWR5IEFDS2VkIGl0Lg0KVGhhbmtzLA0KTWluYXMNCg0K

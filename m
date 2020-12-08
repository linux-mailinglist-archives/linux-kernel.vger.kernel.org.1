Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CDFA2D245F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 08:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbgLHHal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 02:30:41 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:46812 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725972AbgLHHak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 02:30:40 -0500
Received: from mailhost.synopsys.com (sv2-mailhost1.synopsys.com [10.205.2.133])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id E2AEB401F1;
        Tue,  8 Dec 2020 07:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1607412580; bh=wLdHXyPv6gAOaRi209/bH8Z4zY/UGJ5AaCAHvJsNpF8=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=TcyV9n2UgdLIpSwGcx1GhjZvyFAClDhEj2Ixa7OaoC6fm7A7X4LPc2gYrALuXnsl1
         77lhFUJ3hlklKaki/RS0i60zg9sTqUTkY71V7UXHuQ8zgBtCvWCrBBIO2hTTdFHY39
         yEpgVtw2mbHJXpMQSUGYSvuvzfxtcNrmTfrTZ82PZzBnrDMthZvWZAXPW+06HddC9O
         4ORGCUq0NZBup9PI0j3oonuUp9EzJR1ul1PsueixC7WuHm0iVOGlaXjzvTi1+A4hGc
         UNMzNkoLlG6l4tsiEV3IHQhQJ5MWGJPU9WKpWTa+aiwatyRaeRASusNP/ceclokGKd
         D72VBRMoD1n9A==
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id BD25BA0096;
        Tue,  8 Dec 2020 07:29:36 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (mail-bl2nam02lp2055.outbound.protection.outlook.com [104.47.38.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "GlobalSign Organization Validation CA - SHA256 - G3" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 6B2ED4009B;
        Tue,  8 Dec 2020 07:29:34 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=arturp@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="Xaizy1RW";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RewBJh0+PGcNTUXF4YZPKqdenWD0tKJNv16p8FkJwwPMa16b6wx8RzGpD/OWUZDcsu1EbgHOscYRbyNaXQO1RM8uv690w0cqjCMgTS0e6FVUdIAv9olu4PywUZTeV+a1WA3JnSSQG2FKQw2XlhWTDDP5p9Y4uWuTpok8e5Mgj0R7ONbAapj+NRyl7CtczBwKdB4Vb3jP808fQSUJnT+BVi+QqBkyZosKA0ICZfrY/UUu75trVJhGXKFAuRkrl+oIyHgL/MTwZTvKuKn7aJOpZpAikIcaziwDhPsWLa84OyBzL353nH1HeCYuDMvx0KLVqxshapyGcY2n5tOLLI/v7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wLdHXyPv6gAOaRi209/bH8Z4zY/UGJ5AaCAHvJsNpF8=;
 b=bQ/1cNqKzTfJHR5O1HzmZcciYg49sP+3LF01lRaKODlcw2RqZ4Utroqrak1abq9diuN0rAAXDa+VtlfKIfuNNr5YR1usTMlAVz1FblB38LUs8qf+5uwnoycM2rJfhiwr2LfaYtKwstDAq6D3s0gBmKybQChE/dkAQ+/AJ/2vWIr/5TTo4nX1mgTchD0XBxtTusE0cSAG60aUKaxxMMsooA04j0/D9A7a4qbqRGgWFSA0KniGinNbU9XUDTJtn7klshJ0r11R7fVqh6CF8m+3KWNN1CVhtz1lQC7uITDpuzXRcHEWgi50gB9S/K3Dn72BBrt0Vz6V/xupoyX9W1jFEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wLdHXyPv6gAOaRi209/bH8Z4zY/UGJ5AaCAHvJsNpF8=;
 b=Xaizy1RWn5yKJFXPXMtZkO/Ep55H64pc7/uZJVYBYaEwiLtY8KIFh3bv6oqosZBYaPD5O1mKECYMFpX8wh27TpUXRmwmKmt6LsTiVGzpfSViwIGEeZUDiys/5vbuES4fHY/e4skjVt2TCF/LaHYfMsYxwSgbc8f0K6YFFSyW4i4=
Received: from SA0PR12MB4431.namprd12.prod.outlook.com (2603:10b6:806:95::11)
 by SA0PR12MB4429.namprd12.prod.outlook.com (2603:10b6:806:73::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.19; Tue, 8 Dec
 2020 07:29:32 +0000
Received: from SA0PR12MB4431.namprd12.prod.outlook.com
 ([fe80::f5d2:8be1:5fa3:2b90]) by SA0PR12MB4431.namprd12.prod.outlook.com
 ([fe80::f5d2:8be1:5fa3:2b90%9]) with mapi id 15.20.3632.021; Tue, 8 Dec 2020
 07:29:32 +0000
X-SNPS-Relay: synopsys.com
From:   Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
To:     Xu Wang <vulab@iscas.ac.cn>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        Felipe Balbi <balbi@kernel.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc2: Remove redundant null check before
 clk_prepare_enable/clk_disable_unprepare
Thread-Topic: [PATCH] usb: dwc2: Remove redundant null check before
 clk_prepare_enable/clk_disable_unprepare
Thread-Index: AQHWyhnbF0z7r+GDKk+eLZNbSwNvrqns04iA
Date:   Tue, 8 Dec 2020 07:29:32 +0000
Message-ID: <2a1cdaa8-0582-6651-49e6-ee459e6a5f33@synopsys.com>
References: <20201204083644.2704-1-vulab@iscas.ac.cn>
In-Reply-To: <20201204083644.2704-1-vulab@iscas.ac.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: iscas.ac.cn; dkim=none (message not signed)
 header.d=none;iscas.ac.cn; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [176.32.192.178]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 82652668-1577-4060-202a-08d89b4b0192
x-ms-traffictypediagnostic: SA0PR12MB4429:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA0PR12MB44298F13721D414370F0D7E1A7CD0@SA0PR12MB4429.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:483;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q5qrOpZWDgAC51TfIth3V/U+K1zAFAnIS6Ta0gtEk5xpnz/7JphlE4hAsF54YWge+g5tgZojjxDJ9Ds/rzGZ3DJFsCCBQ1R9o1U6fv3BDhduokI4A7d+cIdNq/2txFokNSfNBcTwU0ZvCPibaRZOoUZwTrzez80YDoEGaxFaHT07MeKbMNUrVQx3DbDGXtV+XoxGvnGKTlcOXRfLQk2jRgAKTTAqcyIAV9BKx7yQce2yvsqBl0o/Jw6K1AJP72OU7jJCpuiF/7bHA9xC14487n6d8xzbQ+bN+PdmFzbOJsJuim9Cg4EbrkHq5/rtp/cwUBM9bqA6GUcTEuEaFt0/UqpClC9bauNEXCyugxDCQOVt60SFjoEonA872aKiYFuU
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4431.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(39860400002)(136003)(346002)(366004)(6512007)(8936002)(83380400001)(86362001)(64756008)(2616005)(66946007)(8676002)(66446008)(5660300002)(66476007)(2906002)(71200400001)(6486002)(66556008)(186003)(76116006)(55236004)(26005)(31696002)(91956017)(4326008)(316002)(31686004)(53546011)(478600001)(36756003)(110136005)(54906003)(6506007)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?RUVLOE5QYkU5Mit3Z0l1dXl2Y041OUUrWjN6TWhycUVzY0pDWllCOGUwZHkv?=
 =?utf-8?B?aDRvcFRVWlFjRzJIS055Q3U4T05TVzlFZmdPU3J5TWVubkFhaXdyTmsxUlNQ?=
 =?utf-8?B?R0JSeXN0K0x3cnM2SmFJRVVmQWFxWUNyNGNFNjRnUXAyTFpmK2xUWXlnUDI0?=
 =?utf-8?B?L1VmdUQvcjR4bks0aWZja01pU3VNRkp1VVpsZk0vSXg5UjdNdE10TkZFTlpl?=
 =?utf-8?B?N3NJZjU5aWdRYWpDWTNpN3dVaFUrUFllSEh1STM5UnpqN0VwS1Y0QjlqVldJ?=
 =?utf-8?B?M2wzcm16NjNRemlXeW9zOWZPd2p3OFpmOE9QTTV0bkdiU0JIUUN4aHd6Mmhu?=
 =?utf-8?B?RkQrNnpzRkVhTXNNUEh2b1BITGZOQlNsT2tCd3ltMHF5TExDSk5IWWVvcmpi?=
 =?utf-8?B?cWU5NnZSL0tFQUx6OEEyQ1hnQkc2dHgwSFQ0aSttaGxVQkNwSWU1YWZUWnRY?=
 =?utf-8?B?UGFoUEtwdVdIMm5xSlZPMVZZR2tNQlBGaEgzVit6MlBWK000Sk81YXNSVXdW?=
 =?utf-8?B?d3I5Q3hBeFY5YXQzWTJIL1pkRERCdXV3VVdMTkdLZG9qUnEwZjVQT0Z5MXA5?=
 =?utf-8?B?RjJNUDJySTlvVFdYVmhVdkdQMWNHTy9QMVpSM1puZjJyV0RwanJzUFlTNEJv?=
 =?utf-8?B?cnRSSnlhR2s4OW13OGpxR1QzTjZxV29mRFE1YkJCbU9kbXdybmx5a3lQcndt?=
 =?utf-8?B?YzUzRUZMby9FV1o4U3VrUDEvNUdqWTV5WlU3VXU2TkJkdzNSNkZ2aTZTdjkv?=
 =?utf-8?B?UXRGbXI3cFRpTFdBelV5R2JTaTdza1dJRkZxUHJscytlSVBKbTEwcFlFTlpP?=
 =?utf-8?B?dEdXNGFEOUcxVHhhaklmWFZlRlJLNE8zNkNHTStheVR0OG9TR01FQ2MwdnAz?=
 =?utf-8?B?dFBhNWh5QTYySGYyTXVYejdjM3FMYlNkcW44ZkhBZUJWTW5VNmpwTFg5eFNx?=
 =?utf-8?B?UTdnTEJEQjJ4S1dxcFR5eVloWkVtR3FKSk52RFBhNnlBQnNPUituMzRua0FF?=
 =?utf-8?B?dGI5ZmIzbmtiSkhocDE3MndiVVlFaTYvZGF5YmxZa3BwWDU1aExpbG1rYTlj?=
 =?utf-8?B?WEYzQnFlVU16ajMyZ0ZXK0FlM3JxTWlWaGUzL3VmUndSUXF3OE5mMk9WL0dh?=
 =?utf-8?B?clFsTGgza1JOc3p4c1NMd1E0YzNaQkZibHlXaWRwYzNDZ1hYSlgwVlNRcHh1?=
 =?utf-8?B?OWQ4eG50T0hTODErbW5mNTAxTVpUSWMvVWtFWmxVNmxIN3NZemtrQ2Y2QU5T?=
 =?utf-8?B?aFArb3BQSzJkRjFYZDRGZUYxaS9qcEo1TjJpQnNVTnYxSnhNRTFMcmlqSkMx?=
 =?utf-8?Q?93oZC1ggypiWQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <358ED385DA2C8F4BA28D76B641D33A6E@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4431.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82652668-1577-4060-202a-08d89b4b0192
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2020 07:29:32.3225
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z904gIa0FFBMqPCh/ohJAkbf1l6gp6R78bZQg1jjOGXK+TXiy2d2nsm6beXKpJ713IdROqbi+jNH0seR4Tlbsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4429
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTIvNC8yMDIwIDEyOjM2LCBYdSBXYW5nIHdyb3RlOg0KPiBCZWNhdXNlIGNsa19wcmVwYXJl
X2VuYWJsZSgpIGFuZCBjbGtfZGlzYWJsZV91bnByZXBhcmUoKSBhbHJlYWR5IGNoZWNrZWQNCj4g
TlVMTCBjbG9jayBwYXJhbWV0ZXIsIHNvIHRoZSBhZGRpdGlvbmFsIGNoZWNrcyBhcmUgdW5uZWNl
c3NhcnksIGp1c3QNCj4gcmVtb3ZlIHRoZW0uDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBYdSBXYW5n
IDx2dWxhYkBpc2Nhcy5hYy5jbj4NCg0KUmV2aWV3ZWQtYnk6IEFydHVyIFBldHJvc3lhbiA8QXJ0
aHVyLlBldHJvc3lhbkBzeW5vcHN5cy5jb20+DQoNCj4gLS0tDQo+ICAgZHJpdmVycy91c2IvZHdj
Mi9wbGF0Zm9ybS5jIHwgMTEgKysrKy0tLS0tLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNl
cnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNi
L2R3YzIvcGxhdGZvcm0uYyBiL2RyaXZlcnMvdXNiL2R3YzIvcGxhdGZvcm0uYw0KPiBpbmRleCA1
ZjE4YWNhYzc0MDYuLmJhMmI0OTFjN2Y4MiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZHdj
Mi9wbGF0Zm9ybS5jDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzIvcGxhdGZvcm0uYw0KPiBAQCAt
MTQzLDExICsxNDMsOSBAQCBzdGF0aWMgaW50IF9fZHdjMl9sb3dsZXZlbF9od19lbmFibGUoc3Ry
dWN0IGR3YzJfaHNvdGcgKmhzb3RnKQ0KPiAgIAlpZiAocmV0KQ0KPiAgIAkJcmV0dXJuIHJldDsN
Cj4gICANCj4gLQlpZiAoaHNvdGctPmNsaykgew0KPiAtCQlyZXQgPSBjbGtfcHJlcGFyZV9lbmFi
bGUoaHNvdGctPmNsayk7DQo+IC0JCWlmIChyZXQpDQo+IC0JCQlyZXR1cm4gcmV0Ow0KPiAtCX0N
Cj4gKwlyZXQgPSBjbGtfcHJlcGFyZV9lbmFibGUoaHNvdGctPmNsayk7DQo+ICsJaWYgKHJldCkN
Cj4gKwkJcmV0dXJuIHJldDsNCj4gICANCj4gICAJaWYgKGhzb3RnLT51cGh5KSB7DQo+ICAgCQly
ZXQgPSB1c2JfcGh5X2luaXQoaHNvdGctPnVwaHkpOw0KPiBAQCAtMTk1LDggKzE5Myw3IEBAIHN0
YXRpYyBpbnQgX19kd2MyX2xvd2xldmVsX2h3X2Rpc2FibGUoc3RydWN0IGR3YzJfaHNvdGcgKmhz
b3RnKQ0KPiAgIAlpZiAocmV0KQ0KPiAgIAkJcmV0dXJuIHJldDsNCj4gICANCj4gLQlpZiAoaHNv
dGctPmNsaykNCj4gLQkJY2xrX2Rpc2FibGVfdW5wcmVwYXJlKGhzb3RnLT5jbGspOw0KPiArCWNs
a19kaXNhYmxlX3VucHJlcGFyZShoc290Zy0+Y2xrKTsNCj4gICANCj4gICAJcmV0dXJuIDA7DQo+
ICAgfQ0KPiANCg==

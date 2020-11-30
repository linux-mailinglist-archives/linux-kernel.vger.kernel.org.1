Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E801A2C7E18
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 07:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbgK3GSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 01:18:11 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:56080 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725860AbgK3GSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 01:18:11 -0500
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 86021C04BD;
        Mon, 30 Nov 2020 06:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1606717030; bh=RNjmIEmD2XWWNpNp9rPRcUqsuYE4QH2wcJU7K9oR44U=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=F4Nd/wPu7xQ8sI1HVcpf3xDHikGbbEZalOAKzqUlSy/3HZCwYsKxZSOn6SVC1Y7n8
         RujNpSoeDWKLGRHuK3tXTHYgd6HYSex/wixalosV63ak475+uMDQOhaSZR1g+K/vYq
         cLbgrOsUrxKPk/tm8jidr3f0Pw7LZk6N3IIrnuDPhFxFnvi6S+dUSznsJi4cavlenw
         VYRjR7ChRrXvfXHTwuoheF+wpIvQEWxC9C4HYJsRqjvQ6z9yGVYmehvifbQ/ebl7Pu
         ge+5X30TpU4uHrraDimQbhx3BqCqTmddw6VkGnJW4IhRjysKbXN//dn3zDNHJ3dtHL
         w8th/HXIaTtwQ==
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 4EF9BA006F;
        Mon, 30 Nov 2020 06:17:10 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "GlobalSign Organization Validation CA - SHA256 - G3" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id DC08880214;
        Mon, 30 Nov 2020 06:17:09 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=hminas@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="c+v/qcyq";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HcpseSE66qqrkY2AWXWt7MJtW1WWZ9vkSryNJt8o2qvrXGYDUBATAAhzhvf0eLdZxEz9KNKzJyHBfw2m+3I02RoDKSMg2Bz3BuTSPQNinI2QzLKCtGXDBncJc7MwElmG/fPss13pYuLwbB7PEcZ+ZI31++Ta6e4wjtTaZ6mliN+TaakW+AGIDYkKuLEjw8QN704as3SE8WvAPpZ9wsSi03xaAdBF2TJBYqi/ipXHtZ5pVpEu4Jienn+m52V6+Amigm94VugvyUjzIvLKX/4Zzq59Kyu2LnoUo2q1rWnmRTDkie88jlZr8nR5Wf1vajV/UAAOQE7e6cw5hbgQU9rDVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RNjmIEmD2XWWNpNp9rPRcUqsuYE4QH2wcJU7K9oR44U=;
 b=kejWmXK0hlk/zSbwqb5EuFCimetRL/w0ngQUDANAHV6gMlMeQ86ENKd788j25jVLZ+Dq32Hi43B8SowxIn7VlmXHiRnCMt25XARWC7bXyiC9bgnnqQ0o72kTAKmHANIdnOGzVcycQ/HI6Ts4p9/mg14Tdni7YHMXmZ6lh41ZKEzMnogFm3F5glNx4d8hJshpqjh8UHkLxeDByLn44pRWRRX5kaLTDTY9Bpyfoq2Zps6+0SK/kc03M/sdOSxjLYtYHhbM5W9OeNBBR3sgJq4fGZDQR1fWCcY8eQZxGuPIiEnXpiFN5/RVT4FV+pYx7s7O7dIhJpvC5BARz+Xkwg+cQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RNjmIEmD2XWWNpNp9rPRcUqsuYE4QH2wcJU7K9oR44U=;
 b=c+v/qcyqZSsSG6WB9Ki4jshqY/jTGG54PCVl+F8UKu7D6YFLCGRc5XB7UJgM+iAB3VHNKzmKMs0E3HqLX4qTo8QVb0chiAhOjFqITAns1cbjHPoDze+WOPJqq4gg8kQNlsQuAQrSYTe4r/ac1CvbqDFk53vXz37QQRWzmUDV4KQ=
Received: from BY5PR12MB3777.namprd12.prod.outlook.com (2603:10b6:a03:1a9::14)
 by BY5PR12MB4997.namprd12.prod.outlook.com (2603:10b6:a03:1d6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.31; Mon, 30 Nov
 2020 06:17:08 +0000
Received: from BY5PR12MB3777.namprd12.prod.outlook.com
 ([fe80::f90b:950d:63c:37c2]) by BY5PR12MB3777.namprd12.prod.outlook.com
 ([fe80::f90b:950d:63c:37c2%7]) with mapi id 15.20.3611.023; Mon, 30 Nov 2020
 06:17:08 +0000
X-SNPS-Relay: synopsys.com
From:   Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
To:     Amelie Delaunay <amelie.delaunay@st.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: Re: [PATCH 2/3] usb: dwc2: enable FS/LS PHY clock select on STM32MP15
 FS OTG
Thread-Topic: [PATCH 2/3] usb: dwc2: enable FS/LS PHY clock select on
 STM32MP15 FS OTG
Thread-Index: AQHWwXdbd2QRFeEYbUCiIGZPpm8if6ngPeyA
Date:   Mon, 30 Nov 2020 06:17:08 +0000
Message-ID: <68f6bfab-e720-ecf6-9623-342da80f7f41@synopsys.com>
References: <20201123090114.12641-1-amelie.delaunay@st.com>
 <20201123090114.12641-3-amelie.delaunay@st.com>
In-Reply-To: <20201123090114.12641-3-amelie.delaunay@st.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
authentication-results: st.com; dkim=none (message not signed)
 header.d=none;st.com; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [37.252.92.220]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7786b924-07b2-4fd6-d5fd-08d894f7912a
x-ms-traffictypediagnostic: BY5PR12MB4997:
x-microsoft-antispam-prvs: <BY5PR12MB4997E1824E4627B8791FF17CA7F50@BY5PR12MB4997.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2089;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g9Tazb1vMWgAAD5YuIfY9YotF/sjoXiaE+U38MY3yCGH9gAwANzHAYKHLbhIvfhXR5KGL9+3X6ZJ/m4TtFns5VvKPs08Gw84CCJYX31hWxfeySNjOPQQzaHcJ1a31dYXDGEUAa5dHIcpIF1ZNTeYMHJo15+cJBVy6WJxN/dGXlhthiwCzjJYTV/CyPDykPdyert7yQOXjTWxurb3zqVr/2W5fA0yXFcP+tS1VTw9fulR3wPd+kGIMbaLTXYSb23qBWiXPAWkCAvccGOcXwkZ0AjXTbrx/jR1NAgiS0XvzD0LsSjIelxxqPCyg3F1a8hfVS6IzxDl6KzwrZfuCAFeFafIdw0xBerWHE+Yq6/j7DzsjoBv6AvuEfTl8oE3Pwjf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3777.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(396003)(136003)(346002)(366004)(376002)(54906003)(76116006)(91956017)(86362001)(5660300002)(4326008)(66476007)(83380400001)(110136005)(316002)(66946007)(66556008)(478600001)(64756008)(66446008)(8676002)(71200400001)(8936002)(31686004)(26005)(53546011)(6512007)(2616005)(36756003)(186003)(2906002)(6506007)(31696002)(6486002)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?N0k2eFhpd0U3am9lUTIwQnp6Yzd0dC9aeHFvQVZqOGM4RWsvR25hVGNPZ3Rr?=
 =?utf-8?B?UDJiUWhySTNQcUgrNGxsL2VURjUvc3BkUTZqTmRxZEdtWWVmU0prWTJyUTNG?=
 =?utf-8?B?SzhqcFdaMUZFWXFBQXN6VERkTk01eHhEd0N5MDBNMDhJTnZmdVVia2FwN1pm?=
 =?utf-8?B?UEhzVDI4bWdyQUJlM1lHS25uemtlNEN2RHNSa1E5WnBWVDlERUNMcWovelNh?=
 =?utf-8?B?dWd1Q0dVMlZwcXpRSXN1ZHhxaEs4OXFObCs3V1A3TU1ON2h5UlVuRWEvdnpl?=
 =?utf-8?B?MG44K3hoaStQVG1Fc0VONXBQVUg1REFrak8xM1pyRXhySk94cjlhaDVudENW?=
 =?utf-8?B?WVRCa25BVk1JTm42eS9KdjMySG9KZ2k3d2JFMlNQVVRyNDcwbWxScHpHWEsr?=
 =?utf-8?B?Tis2N3pqN2FlblZVZWV4Z1BRNGJHczRERXlDb1FDVmpSYm9yL0h6Sm1ZR24w?=
 =?utf-8?B?WDUreE1yUE1RbGVKVmVjc01yM0EwNmlqN2dLcjhVR2JkVUlvSW5IOUwwZmtO?=
 =?utf-8?B?OGE1TERxUU1UTEFlMVhZK0FVeEVwbk9zUmZWSFo3c2hxS05QaFdFVG1hY282?=
 =?utf-8?B?M1ZvM09rWG0ydktJN20zYms5QWM2OE1GN2FQU25HYnNrU2VSNTZZc1FsS29Q?=
 =?utf-8?B?T3NGYm1UWWpRV2gybnpScEVIeVlnSUtabnpqODFxcUpDOWF0SGZHcjRtRHZr?=
 =?utf-8?B?Wm5WZFpycy81QlhLRzdKQlBGdzhZQmQyemFlUE9JR2QrL1FibVY4bEJZL3lm?=
 =?utf-8?B?Si9CZEMrQjEzdkRROGYvU1kweHhoNWY3UWZHbkk0dUQ4TmlNNHRhNEczeFEv?=
 =?utf-8?B?UGg2OVN4TE8xUUcwTitZWUhYVXVvUlYxNUdRaFI1enh2M3Q5SDBUd0crck9S?=
 =?utf-8?B?YzRXenV5aHM3UE1PMzBIOWNlTUsyK3Y4QWNzWlFkaThTT2tjOGtQRGVaeWFN?=
 =?utf-8?B?SlpDNElqeWhPaEg0aEg1aElTbWZ6cTc3STBTVE8vNzF2R2xOYlFvK2w5UDRF?=
 =?utf-8?B?Y2RGOTBHeXphVTduM2orYjBLdm16UFdUYy9zUUM2UTI3dytDN3VuWUM2eVZM?=
 =?utf-8?B?cThQZGRlV1ZpYWllSjEwN1N6MjFOMm9oT0dpYkRleEdUR2dpdWJTNHBSbVBs?=
 =?utf-8?B?eTR4RmFXcWI5bkljcHZhTUdjYkJudWx2ZmNFbitvUEJCN3FHZDBoZ0x0U1p2?=
 =?utf-8?B?UFI3c1FaMUxOUUVJaFFpZFc0RWNNN1lHQ3BuZnRHM1VrekM0QWRVUnVpckx2?=
 =?utf-8?B?STg3M2xkSkFlSm8yY0xneW1yY1VQOFlTWXluSFZodFdQTTJ5ckZCckk2bFBN?=
 =?utf-8?Q?grJHyAX1WAkkc=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <06FDD8056B234E4AB083CAEF92ACF3B8@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3777.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7786b924-07b2-4fd6-d5fd-08d894f7912a
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2020 06:17:08.5172
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UFFChAodHL0Iow5KYoOSKfMpN0VL8GKge5zr4VClv9J7+xQzJgPctDSuju+sVBoDkRr9GnkzQPtyCGAg9AuIUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4997
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTEvMjMvMjAyMCAxOjAxIFBNLCBBbWVsaWUgRGVsYXVuYXkgd3JvdGU6DQo+IFdoZW4gdGhl
IGNvcmUgaXMgaW4gRlMgaG9zdCBtb2RlLCB1c2luZyB0aGUgRlMgdHJhbnNjZWl2ZXIsIGFuZCBh
IExvdy1TcGVlZA0KPiBkZXZpY2UgaXMgY29ubmVjdGVkLCB0cmFuc2NlaXZlciBjbG9jayBpcyA2
TWh6Lg0KPiBTbywgdG8gc3VwcG9ydCBMb3ctU3BlZWQgZGV2aWNlcywgZW5hYmxlIHN1cHBvcnQg
b2YgRlMvTFMgTG93IFBvd2VyIG1vZGUsDQo+IHNvIHRoYXQgdGhlIFBIWSBzdXBwbGllcyBhIDYg
TUh6IGNsb2NrIGR1cmluZyBMb3ctU3BlZWQgbW9kZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFt
ZWxpZSBEZWxhdW5heSA8YW1lbGllLmRlbGF1bmF5QHN0LmNvbT4NCg0KQWNrZWQtYnk6IE1pbmFz
IEhhcnV0eXVueWFuIDxNaW5hcy5IYXJ1dHl1bnlhbkBzeW5vcHN5cy5jb20+DQoNCj4gLS0tDQo+
ICAgZHJpdmVycy91c2IvZHdjMi9wYXJhbXMuYyB8IDIgKysNCj4gICAxIGZpbGUgY2hhbmdlZCwg
MiBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMi9wYXJh
bXMuYyBiL2RyaXZlcnMvdXNiL2R3YzIvcGFyYW1zLmMNCj4gaW5kZXggMGRmNjkzMzE5ZjBhLi45
ZTVkZDdmM2YyZjYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzIvcGFyYW1zLmMNCj4g
KysrIGIvZHJpdmVycy91c2IvZHdjMi9wYXJhbXMuYw0KPiBAQCAtMTc5LDYgKzE3OSw4IEBAIHN0
YXRpYyB2b2lkIGR3YzJfc2V0X3N0bTMybXAxNV9mc290Z19wYXJhbXMoc3RydWN0IGR3YzJfaHNv
dGcgKmhzb3RnKQ0KPiAgIAlwLT5hY3RpdmF0ZV9zdG1faWRfdmJfZGV0ZWN0aW9uID0gdHJ1ZTsN
Cj4gICAJcC0+YWhiY2ZnID0gR0FIQkNGR19IQlNUTEVOX0lOQ1IxNiA8PCBHQUhCQ0ZHX0hCU1RM
RU5fU0hJRlQ7DQo+ICAgCXAtPnBvd2VyX2Rvd24gPSBEV0MyX1BPV0VSX0RPV05fUEFSQU1fTk9O
RTsNCj4gKwlwLT5ob3N0X3N1cHBvcnRfZnNfbHNfbG93X3Bvd2VyID0gdHJ1ZTsNCj4gKwlwLT5o
b3N0X2xzX2xvd19wb3dlcl9waHlfY2xrID0gdHJ1ZTsNCj4gICB9DQo+ICAgDQo+ICAgc3RhdGlj
IHZvaWQgZHdjMl9zZXRfc3RtMzJtcDE1X2hzb3RnX3BhcmFtcyhzdHJ1Y3QgZHdjMl9oc290ZyAq
aHNvdGcpDQo+IA0KDQo=

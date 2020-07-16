Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B01922225B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jul 2020 14:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728412AbgGPMbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jul 2020 08:31:10 -0400
Received: from us-smtp-delivery-148.mimecast.com ([216.205.24.148]:56053 "EHLO
        us-smtp-delivery-148.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727081AbgGPMbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 08:31:09 -0400
X-Greylist: delayed 371 seconds by postgrey-1.27 at vger.kernel.org; Thu, 16 Jul 2020 08:31:08 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rambus.com;
        s=mimecast20161209; t=1594902667;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nhfQhc6aRzW+uHuJFfEtyF2WjQtJezgOMT8TofgsTdQ=;
        b=N7beBgHqGdEUHWKMA+NtFGV0qX3RsgbHu8ryucL/tOo2veZDqX0pOLg7GV2S3etoEr3ktJ
        P4Wko8laLdCuQLO199L1E6kzEtHdPwR5P7EeDfy2s+Ucg7RlqkiyD9o8feKkVUP/Oyq2hx
        7Ii0Gw2tFchqCtUOpalv2QHEM6hrzL0=
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
 (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-493-JODGKilENJ2kjy3pgwHPjg-1; Thu, 16 Jul 2020 08:24:54 -0400
X-MC-Unique: JODGKilENJ2kjy3pgwHPjg-1
Received: from CY4PR0401MB3652.namprd04.prod.outlook.com
 (2603:10b6:910:8a::27) by CY1PR04MB2363.namprd04.prod.outlook.com
 (2a01:111:e400:c617::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Thu, 16 Jul
 2020 12:24:51 +0000
Received: from CY4PR0401MB3652.namprd04.prod.outlook.com
 ([fe80::c5b1:ff88:4c39:34d8]) by CY4PR0401MB3652.namprd04.prod.outlook.com
 ([fe80::c5b1:ff88:4c39:34d8%3]) with mapi id 15.20.3174.026; Thu, 16 Jul 2020
 12:24:50 +0000
From:   "Van Leeuwen, Pascal" <pvanleeuwen@rambus.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        =?utf-8?B?SG9yaWEgR2VhbnTEgw==?= <horia.geanta@nxp.com>
CC:     Iuliana Prodan <iuliana.prodan@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Silvano Di Ninno <silvano.dininno@nxp.com>,
        Franck Lenormand <franck.lenormand@nxp.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 2/2] crypto: caam - support tagged keys for skcipher
 algorithms
Thread-Topic: [PATCH 2/2] crypto: caam - support tagged keys for skcipher
 algorithms
Thread-Index: AQHWWJjegJE1XH3+JEmZW6ZYWNYYq6kJ1loAgAAyNICAABWGgIAABC0AgAADRQCAAAGhIA==
Date:   Thu, 16 Jul 2020 12:24:49 +0000
Message-ID: <CY4PR0401MB36527396455B1AEE4A17CDB1C37F0@CY4PR0401MB3652.namprd04.prod.outlook.com>
References: <1594591536-531-1-git-send-email-iuliana.prodan@nxp.com>
 <1594591536-531-3-git-send-email-iuliana.prodan@nxp.com>
 <20200716073610.GA28215@gondor.apana.org.au>
 <0c818beb-05e5-a6c6-717d-782b32afff26@nxp.com>
 <20200716115253.GA25035@gondor.apana.org.au>
 <59436173-9891-b857-f36b-e97c0a3264c8@nxp.com>
 <20200716121932.GA31870@gondor.apana.org.au>
In-Reply-To: <20200716121932.GA31870@gondor.apana.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [159.100.118.162]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1e18d3bc-0fd7-4842-a715-08d829833c86
x-ms-traffictypediagnostic: CY1PR04MB2363:
x-microsoft-antispam-prvs: <CY1PR04MB23638D61FF7FBDBB34A6E7A6C37F0@CY1PR04MB2363.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Qkzq1tqdCoS1L2Uj+wBvU2dxJ3tozMJSBbDF8ryt4BfK1UmC5BLi6LEIE/TQABY5EgphZPfzLRLULngTrIDTY9u4cQPxsmSGDKxWDOdEwhJ4WBiGjb35hQ6mboNga7tt/oS+cn9FTrH9gvySdyaxW9NVXuce9gwoz8HFtWfZhFOYWQKQvuv+wQW4jIdkCg0WzOdhiBE3TkeYhf9RRADo1eLvu3VIguXpAihFc26yyTcrC1+eK1FD/h9igcsYoO8aSOCzqH3ZQt8LteOazhPmAZt9sn1BRkRtWA8xb8CNUuLvVM+GfBr1n525zJyveXBr/P+mUfAbCq1jrOFiGjzNFPqj5KuEum0uV3MhOntJHk9iD87b31yiWfexzDKyLN4Ytp5POAEGHW6rwGCMwRiQLQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR0401MB3652.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(39850400004)(396003)(376002)(346002)(366004)(478600001)(5660300002)(54906003)(53546011)(66476007)(2906002)(86362001)(8676002)(8936002)(6506007)(4326008)(66946007)(83380400001)(76116006)(110136005)(7416002)(66446008)(966005)(186003)(33656002)(71200400001)(64756008)(66556008)(83080400001)(9686003)(26005)(52536014)(55016002)(316002)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: hLpwAsZCGgY5UjupIOpIuE91XIcf63zTVHjT5Rocpfwj+dKC+bTGwOk/GTTwy/xK9b/a35Ufd0KMOEctSguBZtvwGy7LWzZ5d8nO57iZzNX3Mdeara58uXC9oMywYlJ8lFgYmCtHi38nYH3Bg2U3a3mWiby3sOjqIGn3g92ijd+jdJIWOG/GVpgJ3RP170t7DAyLIi0UfgOGHK0n8AII2GWJRTXYDPJoCYc9rhfGYu7TkhYzv0naiVmWWBcKyBz4vpmztpiFnxQ4baqbT6TZcJLVIew5gOjivtVGPk+faKsDgQ08ZIAxGeNufzsKRYIx+FOb58WxM4KN5pDm+sg48ULge0Qy0BB523J62WV/SqTwZVDHNYCsJ1bGTL5R0fuohmMhTjKu/y5MGu6CsNthLeFjcUlbjwBDvGxy7gMylXFtHG2mV0Bfcna7/Y0dTQXn2hBGxlwXvxoiZRie2/ZOWZz3BNhflfocDI+Ylnm2PxBXJZHYCgs+Vti0DcC2lh1u
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: rambus.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR0401MB3652.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e18d3bc-0fd7-4842-a715-08d829833c86
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2020 12:24:50.4398
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bd0ba799-c2b9-413c-9c56-5d1731c4827c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zxZ3v5MjUWGJlbd8ShstY+sLxucHtQimCJDVX5WQEiBkQ507LpM+pk+BhTabRoJUHWfuKVLwGzDWswgM3e329g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR04MB2363
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: rambus.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBsaW51eC1jcnlwdG8tb3duZXJA
dmdlci5rZXJuZWwub3JnIDxsaW51eC1jcnlwdG8tb3duZXJAdmdlci5rZXJuZWwub3JnPiBPbiBC
ZWhhbGYgT2YgSGVyYmVydCBYdQ0KPiBTZW50OiBUaHVyc2RheSwgSnVseSAxNiwgMjAyMCAyOjIw
IFBNDQo+IFRvOiBIb3JpYSBHZWFudMSDIDxob3JpYS5nZWFudGFAbnhwLmNvbT4NCj4gQ2M6IEl1
bGlhbmEgUHJvZGFuIDxpdWxpYW5hLnByb2RhbkBueHAuY29tPjsgQXltZW4gU2doYWllciA8YXlt
ZW4uc2doYWllckBueHAuY29tPjsgRGF2aWQgUy4gTWlsbGVyIDxkYXZlbUBkYXZlbWxvZnQubmV0
PjsNCj4gU2lsdmFubyBEaSBOaW5ubyA8c2lsdmFuby5kaW5pbm5vQG54cC5jb20+OyBGcmFuY2sg
TGVub3JtYW5kIDxmcmFuY2subGVub3JtYW5kQG54cC5jb20+OyBsaW51eC1jcnlwdG9Admdlci5r
ZXJuZWwub3JnOw0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBkbC1saW51eC1pbXgg
PGxpbnV4LWlteEBueHAuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDIvMl0gY3J5cHRvOiBj
YWFtIC0gc3VwcG9ydCB0YWdnZWQga2V5cyBmb3Igc2tjaXBoZXIgYWxnb3JpdGhtcw0KPg0KPiA8
PDwgRXh0ZXJuYWwgRW1haWwgPj4+DQo+IE9uIFRodSwgSnVsIDE2LCAyMDIwIGF0IDAzOjA3OjUw
UE0gKzAzMDAsIEhvcmlhIEdlYW50xIMgd3JvdGU6DQo+ID4NCj4gPiBTbyBpbnN0ZWFkIG9mIHRr
KGNiYyhhZXMpKSB1c2UgcGFlcyhjYmMoYWVzKSBvciBjYmMocGFlcyk/DQo+DQo+IFdlbGwgaWYg
d2UncmUgZm9sbG93aW5nIHRoZSBleGlzdGluZyBwYWVzIG1vZGVsIHRoZW4gaXQnZCBiZQ0KPiBj
YmMocGFlcykuDQo+DQo+ID4gSG93IHdvdWxkIHRoaXMgd29yayBmb3IgaG1hYyhzaGE1MTIpLA0K
PiA+IHBhZXMoaG1hYyhzaGE1MTIpKSBvciBobWFjKHBzaGE1MTIpLCBvciBldmVuIHBobWFjKHNo
YTUxMik/DQo+DQo+IFBlcmhhcHMgaG1hYyhwc2hhNTEyKS4NCj4NClRoYXQgd291bGQgbWFrZSBu
byBzZW5zZSB0aG91Z2gsIGFzIHNoYTUxMiBkb2VzIG5vdCBpbnZvbHZlIGFueSBrZXlzIC4uLg0K
SXQncyB0aGUgSE1BQyBwYXJ0IHRoYXQgbmVlZHMgdGhlIGtleXMuIFNvIHBobWFjKHNoYTUxMikg
dGhlbj8NCg0KPiBUaGUgcG9pbnQgaXMgd2hhdGV2ZXIgc2NoZW1lIHlvdSBjb21lIHVwIHdpdGgg
aGFzIHRvIGJlIGNvbnNpc3RlbnQNCj4gYWNyb3NzIGFsbCBkcml2ZXJzLg0KPg0KPiBDaGVlcnMs
DQo+IC0tDQo+IEVtYWlsOiBIZXJiZXJ0IFh1IDxoZXJiZXJ0QGdvbmRvci5hcGFuYS5vcmcuYXU+
DQo+IEhvbWUgUGFnZTogaHR0cDovL2dvbmRvci5hcGFuYS5vcmcuYXUvfmhlcmJlcnQvDQo+IFBH
UCBLZXk6IGh0dHA6Ly9nb25kb3IuYXBhbmEub3JnLmF1L35oZXJiZXJ0L3B1YmtleS50eHQNCg0K
UGFzY2FsIHZhbiBMZWV1d2VuDQpTaWxpY29uIElQIEFyY2hpdGVjdCBNdWx0aS1Qcm90b2NvbCBF
bmdpbmVzLCBSYW1idXMgU2VjdXJpdHkNClJhbWJ1cyBST1RXIEhvbGRpbmcgQlYNCiszMS03MyA2
NTgxOTUzDQoNCk5vdGU6IFRoZSBJbnNpZGUgU2VjdXJlL1ZlcmltYXRyaXggU2lsaWNvbiBJUCB0
ZWFtIHdhcyByZWNlbnRseSBhY3F1aXJlZCBieSBSYW1idXMuDQpQbGVhc2UgYmUgc28ga2luZCB0
byB1cGRhdGUgeW91ciBlLW1haWwgYWRkcmVzcyBib29rIHdpdGggbXkgbmV3IGUtbWFpbCBhZGRy
ZXNzLg0KDQoNCioqIFRoaXMgbWVzc2FnZSBhbmQgYW55IGF0dGFjaG1lbnRzIGFyZSBmb3IgdGhl
IHNvbGUgdXNlIG9mIHRoZSBpbnRlbmRlZCByZWNpcGllbnQocykuIEl0IG1heSBjb250YWluIGlu
Zm9ybWF0aW9uIHRoYXQgaXMgY29uZmlkZW50aWFsIGFuZCBwcml2aWxlZ2VkLiBJZiB5b3UgYXJl
IG5vdCB0aGUgaW50ZW5kZWQgcmVjaXBpZW50IG9mIHRoaXMgbWVzc2FnZSwgeW91IGFyZSBwcm9o
aWJpdGVkIGZyb20gcHJpbnRpbmcsIGNvcHlpbmcsIGZvcndhcmRpbmcgb3Igc2F2aW5nIGl0LiBQ
bGVhc2UgZGVsZXRlIHRoZSBtZXNzYWdlIGFuZCBhdHRhY2htZW50cyBhbmQgbm90aWZ5IHRoZSBz
ZW5kZXIgaW1tZWRpYXRlbHkuICoqDQoNClJhbWJ1cyBJbmMuPGh0dHA6Ly93d3cucmFtYnVzLmNv
bT4NCg==


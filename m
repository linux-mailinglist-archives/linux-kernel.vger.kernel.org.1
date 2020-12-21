Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A94762DF7AD
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 03:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727637AbgLUChK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Dec 2020 21:37:10 -0500
Received: from mail-eopbgr140040.outbound.protection.outlook.com ([40.107.14.40]:44855
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726641AbgLUChH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Dec 2020 21:37:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m8r/6oQCp8+SJNnHfKXsOg2cVbmmF6ktTSedzSX7cjYH8YPshZBHqcgn6Ha1Q+9L3CtFdsCXoTm8qwaQBzfLYvS8eqyhoYX9dun1h1wGbk6vdAZpZxF5ovV1j5Ju2m1zXNt5iPX1l9abKxXLqxMje6U/KpqAfRxWwkG2V4E5ESx+r+HzvWrJtln+GtbFJTy7SNByhPmadl4Bz3ZEiIPlNXjLEwGMKF8y2dD5p5+nuZACqouF+7ScNORzBETZF9RcfCdMCVJgq5/KEHZBavdyHJzN9KfMNSlB2G1TffueH+8tct7oYh+3uqE0SzhPfhVaWQbb6b6vvjvDMIK/kr7GJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vb3t8NnmIgW+I9wKhoa92KF7HCS5JQ14DvG9Nx+/yK8=;
 b=dbmuiHDBqRvs/iZaqGmnv21IO29oUxK9ImbbnrTa5juaxIKelwWjRQUP2MjSD/+MoshjY8TtNUQGUGd6jlRs+1NNPi7ad0WZ7LDbXhJ9zJZna6YJ0A1nfIYZs8Xwt9j+wdfOYCNf3LIdlAs3tAcYybfH7RE7fT/+DbTcvzGMEyxg4A41NAKF7B+AYErlkPKrmOnU67tBFIYuGuE1au4dNn3H6kAawbs2tGWlJb8spqKrwCdpoPi7Lw9L4IMmoP+jk9zwaaZR/BCC+phcAc+e/GUeeCkssXny+IM65n/1rPb8dJjWhG6pgXBo1S4fpjdOanmYomxD7wQODYP/WEE9gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vb3t8NnmIgW+I9wKhoa92KF7HCS5JQ14DvG9Nx+/yK8=;
 b=T1S76BHa6sUN8YJQ0e2nP6nxnM7213D+iOomT9EQs1U57h0Tcc6SAUs5YXk2m//hMzVkWBuh5BPNaYTstVbas59nB7z/4axWcfBSzi9YE+FaGyMWabuCktrZeN96n2PFGdtqsFVosj2pOFvrIPzBjYiqUQGDroY4fHmq0dVQ6ls=
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com (2603:10a6:20b:b9::10)
 by AM6PR04MB5943.eurprd04.prod.outlook.com (2603:10a6:20b:99::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.33; Mon, 21 Dec
 2020 02:36:15 +0000
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::78fe:9b7a:a2ac:9631]) by AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::78fe:9b7a:a2ac:9631%7]) with mapi id 15.20.3676.031; Mon, 21 Dec 2020
 02:36:15 +0000
From:   "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v8 4/4] soc: imx8m: change to use platform driver
Thread-Topic: [PATCH v8 4/4] soc: imx8m: change to use platform driver
Thread-Index: AQHW1RkaGk8BjtYu/Eah0g8x7x5Nran+V+uAgAKBuWA=
Date:   Mon, 21 Dec 2020 02:36:15 +0000
Message-ID: <AM6PR04MB6053FB066AE41C3DFE433E60E2C00@AM6PR04MB6053.eurprd04.prod.outlook.com>
References: <20201218083726.16427-1-alice.guo@oss.nxp.com>
 <20201218083726.16427-4-alice.guo@oss.nxp.com>
 <20201219121829.GB13886@kozik-lap>
In-Reply-To: <20201219121829.GB13886@kozik-lap>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b24ffabe-ee56-4c55-93b1-08d8a559308e
x-ms-traffictypediagnostic: AM6PR04MB5943:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB59437714C55556F2B0A86901A3C00@AM6PR04MB5943.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JrwXk6gCqw8UKW2vXfsefxHCfb8SJ2Z8zuWkPuBYXIR/riMxeTy4ARoHuy8sjfj8EBHzHYx5Esu+36G/gtQCkedaLE7/24BrkC0tSMaAnnSGnle9Lqt9LwYlbvcGOeinF0hQRTxvrxyGvjaOgDbrTO9Hz/BO6DqTQFjQh1GAtlSl1LeSFJl4iTbon84YBCcweEgvZlQRObW/7VzrwcOXIg3qhn+iMd/aZi1HhTZkWDEnwYgyHWg3GaZEadRp833QW5BGsGOcr9t4ugEk9y++s3/5jYnQMSHL6AO0nw5Q2ZzZWnRKGKZWVi2SMv77ULqZzvjRfZgOmpF8yysT6KPrZbfvkca2sGmg2Pv4A50H49MQti7wSp7xAgURCir7k4KiMUI9XXrfZpI36cnFmMYuSE5vQoILcSqLJvd53B5rVL7M8Go4nzLxnGNDU3Y074E3
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(136003)(346002)(396003)(39860400002)(55016002)(316002)(66476007)(66946007)(8676002)(66556008)(76116006)(71200400001)(8936002)(9686003)(4326008)(54906003)(66446008)(86362001)(110136005)(53546011)(6506007)(7696005)(64756008)(52536014)(478600001)(5660300002)(2906002)(83380400001)(33656002)(26005)(186003)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?eXRNbW1DSTJ0YUtUTzNZeFhSTzM1d1E1N0YrY25PQm1sRDdMNGFSN2JrZW01?=
 =?utf-8?B?VG1NbTFHZXNxdDNOcXRId1UybWNIYjc1dmxGOHA3WVFDalBTUzNwZWorODFy?=
 =?utf-8?B?V0RET1lsdG9PdzJvY1JmV1NpWTIrWlNwZmgyek9lbnFrVjlzU1RjS0xOdURK?=
 =?utf-8?B?WWFrTEI2N3VQQWJTL3B1M0V5MWJsNDBsbWl2eFl0SW9wc0dDck9zZnZ2cGN6?=
 =?utf-8?B?OFpSbE5ibk1aN0RQR1lNNFRpUFJBSCs3OVFyMGE1MVpaL0ZlMUxlUWJCQnFy?=
 =?utf-8?B?VWJsVFZYWVNOVnMwUGl0YVh3TGxpanFONFp6S3ZBYlNnQVord01kaGQ3bTgx?=
 =?utf-8?B?ZFVHcEcxUXdsLzQ5THNpMm5YSlFLWG9pa3VMUWdKN25wZmwzZGFoeXBSYjVj?=
 =?utf-8?B?Wk1FSDhUYWFtTEgxY2ZvNTAvbnF5Qnl4RXRsL2NOcXg3NXBBWjNJZVJWZTZ4?=
 =?utf-8?B?L2R2SW15b0xucGc5L0N4R2dQemJpRWMvdWpjNHJ0WHdBQmRKSFVJUTZ6MFdG?=
 =?utf-8?B?SjZZbGh3YU5hWExocGtvbWNVZzBFZy9ZR2tpU0Zxd3N2RHd2anJuc2pMcFZ1?=
 =?utf-8?B?WVNySkVUTmhWdnhqMWlNMHowVmVtdXAzMjB2NVpFUVhoUmhjUkcwYkNldlU0?=
 =?utf-8?B?VzV1UWxBbUN0Nkg1dk1ZUzZjU1lVTmRiRjhPUWcwWThWb00zcGVSZnhmQ0Ji?=
 =?utf-8?B?SzVwSWdiR2hkYkpPQWVHeFVXbndha3dKSHlIeEdPclJRcXAybWFqOVd3WWEx?=
 =?utf-8?B?OW83TDdibmlKRlFYeEQrWG54VmY3YkUrVUlPU1FFU0VJZi9odTFtNG5OVzVw?=
 =?utf-8?B?cVNGL2JaaDIzbjdna3BOdWIzZzdvbGRwMFA5VEUyWHRtZUNFcWZNZkRIWklF?=
 =?utf-8?B?NXJUb29GcUdhV3dCRSs4cllZUjU5eGU3UnZhVWthSE1IZWl0M01EVFc5SGIx?=
 =?utf-8?B?VTA1anIwcmFDVTR5OHRGVk1uUFFoa0tYckMwNDBxVjZJZ1RKQkR4THV5Qk1n?=
 =?utf-8?B?Nk8rSUh5dEdCV1Y3QlNQayswREErQ0F6TnAzZ3djek83cVE1SmdvUk13d1JI?=
 =?utf-8?B?SEFpOUlFRjJFSVptWVVZWC9TZ28vMjVwdlpWU3hEanNYRU1BL01BZHlMejB0?=
 =?utf-8?B?SW1nR0tuNGhWQ2YzWkx4ZVNFWkJuT056amlDQ1Q0UUJaYUxqVVFiYWlnUmpD?=
 =?utf-8?B?eUl0Z2hsNWpjSmVIM08wR0ZpeWR1c2RjVnF0Qk00YXdRZlU5NkNneUw0K3Bs?=
 =?utf-8?B?amQ5Y09QbkVWZUVXQXltQ3dZUWxzOHU0cE44anY1M1BXWmhmS3R6SFJ1Sy8z?=
 =?utf-8?Q?6eKy92s0r0alg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b24ffabe-ee56-4c55-93b1-08d8a559308e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2020 02:36:15.7388
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nFkMmH83mPhYD1VY6FSkBYLEd8AV9uIl3By4/yVmtMywfA4qtEdEHl6nNz88DsAcC3yFpJfZ/dJOgkPmcvWdTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5943
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6a0BrZXJuZWwub3JnPg0KPiBTZW50OiAyMDIw5bm0MTLmnIgxOeaXpSAyMDoxOA0K
PiBUbzogQWxpY2UgR3VvIChPU1MpIDxhbGljZS5ndW9Ab3NzLm54cC5jb20+DQo+IENjOiByb2Jo
K2R0QGtlcm5lbC5vcmc7IHNoYXduZ3VvQGtlcm5lbC5vcmc7IHMuaGF1ZXJAcGVuZ3V0cm9uaXgu
ZGU7DQo+IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgZmVzdGV2YW1AZ21haWwuY29tOyBkZXZpY2V0
cmVlQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQu
b3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBkbC1saW51eC1pbXgNCj4gPGxpbnV4
LWlteEBueHAuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY4IDQvNF0gc29jOiBpbXg4bTog
Y2hhbmdlIHRvIHVzZSBwbGF0Zm9ybSBkcml2ZXINCj4gDQo+IE9uIEZyaSwgRGVjIDE4LCAyMDIw
IGF0IDA0OjM3OjI2UE0gKzA4MDAsIEFsaWNlIEd1byAoT1NTKSB3cm90ZToNCj4gPiBGcm9tOiBB
bGljZSBHdW8gPGFsaWNlLmd1b0BueHAuY29tPg0KPiA+DQo+ID4gRGlyZWN0bHkgcmVhZGluZyBv
Y290cCByZWdpc3RlciBkZXBlbmRzIG9uIHRoYXQgYm9vdGxvYWRlciBlbmFibGVzDQo+ID4gb2Nv
dHAgY2xrLCB3aGljaCBpcyBub3QgYWx3YXlzIGVmZmVjdGl2ZSwgc28gY2hhbmdlIHRvIHVzZSBu
dm1lbSBBUEkuDQo+ID4gVXNpbmcgbnZtZW0gQVBJIHJlcXVpcmVzIHRvIHN1cHBvcnQgZHJpdmVy
IGRlZmVyIHByb2JlIGFuZCB0aHVzIGNoYW5nZQ0KPiA+IHNvYy1pbXg4bS5jIHRvIHVzZSBwbGF0
Zm9ybSBkcml2ZXIuDQo+ID4NCj4gPiBUaGUgb3RoZXIgcmVhc29uIGlzIHRoYXQgZGlyZWN0bHkg
cmVhZGluZyBvY290cCByZWdpc3RlciBjYXVzZXMga2V4ZWMNCj4gPiBrZXJuZWwgaGFuZyBiZWNh
dXNlIHRoZSAxc3Qga2VybmVsIHJ1bm5pbmcgd2lsbCBkaXNhYmxlIHVudXNlZCBjbGtzDQo+ID4g
YWZ0ZXIga2VybmVsIGJvb3RzIHVwLCBhbmQgdGhlbiBvY290cCBjbGsgd2lsbCBiZSBkaXNhYmxl
ZCBldmVuIGlmDQo+ID4gYm9vdGxvYWRlciBlbmFibGVzIGl0LiBXaGVuIGtleGVjIGtlcm5lbCwg
b2NvdHAgY2xrIG5lZWRzIHRvIGJlDQo+ID4gZW5hYmxlZCBiZWZvcmUgcmVhZGluZyBvY290cCBy
ZWdpc3RlcnMsIGFuZCBudm1lbSBBUEkgd2l0aCBwbGF0Zm9ybQ0KPiA+IGRyaXZlciBzdXBwb3J0
ZWQgY2FuIGFjY29tcGxpc2ggdGhpcy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEFsaWNlIEd1
byA8YWxpY2UuZ3VvQG54cC5jb20+DQo+ID4gLS0tDQo+ID4gQ2hhbmdlcyBmb3Igdjg6DQo+ID4g
IC0gbm9uZQ0KPiA+IENoYW5nZXMgZm9yIHY3Og0KPiA+ICAtIHNvbHZlIHRoZSBwcm9ibGVtICJk
cml2ZXJzL3NvYy9pbXgvc29jLWlteDhtLmM6MTc0OjM0OiB3YXJuaW5nOg0KPiA+ICAgIHVudXNl
ZCB2YXJpYWJsZSINCj4gDQo+IFRoZXJlIHdhcyBhIHJldmlld2VkLWJ5IHBhcnQgb2YgY2hhbmdl
bG9nLiBUaGUgdGFnIHdhcyBpbiB5b3VyIGNvbW1pdC4NCj4gSSBhbSBub3cgY29uZnVzZWQsIGFz
IGNoYW5nZXMgZm9yIHY4IHNheSAibm9uZSIuLi4gYnV0IHNoYWxsIEkgdHJ1c3QgaXQ/DQo+IA0K
PiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KDQpIaSwNCkkgZm9yZ290IHRvIGFkZCByZXZp
ZXdlZC1ieS4NCg0KQmVzdCByZWdhcmRzLA0KQWxpY2UNCg0K

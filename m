Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 256092C6234
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 10:49:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbgK0JsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 04:48:02 -0500
Received: from mail-eopbgr30040.outbound.protection.outlook.com ([40.107.3.40]:24197
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725854AbgK0JsB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 04:48:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZVoIdpoWeq2vXssiTMgVSxU5XLmWIgwwqPwtmxUmGB34zj977RipETQvgRuQ3uM2Qzo+xiUQVmxu8BiRTE8lCqFVOd2IHm9zLKiYIdQvD+fXzdes4sjyF7BAbw9w/E+L3e0QP5Ixw+g3dPoAt7y0h36xbSh568uwrs49513lRTaVhuCbyR0kgBqpD6EDDxdGa6VudbvrNA42X+o0mH0j3jW7GCVo2Vcnd58F4DmeucXO68t5PdbKbpnClbIrdOwD9ZugdJnUqumU1K7dIdG05U/fFfs9R1iD+Ry447gbUz64Hez4b7eMLP19a7/Aj5DwMKPtUgvsGFJLWaI0Fvk4WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W/mLuYP1YqmsWk04rjye4K8z+ws4vKsWhAZky3zam/s=;
 b=Yf1mXcNhBOcUSdIzPXYYwfk944gK0EAAWQEDYq0pHROkfGKI8K6RitGbC1zJVaKzyx0Q5AGG6O7dqGoMTvUsW1vbuYLV3GZxi9ikHwuqJn8oA5EIVEHqU9q2UanOlVHO8AebPnyyt8usFelSTU+eyQqOTy+sIllRYk54NIKv5ImfePjL9ihkHFmqqzxMaNlVQPBz1UzU38YyPuJFF25n+fsEZkPX9Juo0wJerPYcelVOuRf4nWcmwcUB2Vzxl9iCbfBV6TlaFvmKvrlb98XXZ0DSFgbj81AqC4+fM6leKhzopwoaDbjQpfLpERqWZDdRGZcXpEWW41dF89Z5CMtZ4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W/mLuYP1YqmsWk04rjye4K8z+ws4vKsWhAZky3zam/s=;
 b=ZTz1wbWAyrvvEs7uAwHuo6L0QsWyFKmtW6z7lTWCQKRGJCp/7rBKKAbxmsqwUr37zepC7dbvwjEp6YVpNMcNWpJksRj97IlM21mcGSIJfUvibpj5rhigz7qULnipY0/nYugnLvTfRtLluRkBLbJ6cP/rc56L3Mxf+FCXjFJxLyg=
Received: from DBBPR04MB7979.eurprd04.prod.outlook.com (2603:10a6:10:1ec::9)
 by DB7PR04MB4235.eurprd04.prod.outlook.com (2603:10a6:5:22::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.22; Fri, 27 Nov
 2020 09:47:53 +0000
Received: from DBBPR04MB7979.eurprd04.prod.outlook.com
 ([fe80::c8c:888f:3e0c:8d5c]) by DBBPR04MB7979.eurprd04.prod.outlook.com
 ([fe80::c8c:888f:3e0c:8d5c%5]) with mapi id 15.20.3611.025; Fri, 27 Nov 2020
 09:47:53 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Roger Quadros <rogerq@ti.com>,
        "pawell@cadence.com" <pawell@cadence.com>
CC:     "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] usb: cdns3: Fix hardware based role switch
Thread-Topic: [PATCH] usb: cdns3: Fix hardware based role switch
Thread-Index: AQHWwyl/2oNKkJaHaE64jPFyyE67kqnbuXiAgAAEW6A=
Date:   Fri, 27 Nov 2020 09:47:53 +0000
Message-ID: <DBBPR04MB7979103C23A8EE95187545608BF80@DBBPR04MB7979.eurprd04.prod.outlook.com>
References: <20201125124936.5929-1-rogerq@ti.com>
 <520dd6e0-d3d4-b471-6c65-143e094a4f74@ti.com>
In-Reply-To: <520dd6e0-d3d4-b471-6c65-143e094a4f74@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b888ab9a-ba91-43bd-a3ed-08d892b98305
x-ms-traffictypediagnostic: DB7PR04MB4235:
x-microsoft-antispam-prvs: <DB7PR04MB423590C063C5E817CCEA41078BF80@DB7PR04MB4235.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OM6yqiBgunIdCsdWdv2LKfo1oA8Pe/DAjui5kPqlADfBpSLw2ZiIy2Pds48xyw1bRD3mf8FynRN5xVHUKB6BWWzuMZSwa9yu338eGA2HOlXy4lYRkkTZkoNGXOpT+nsEQP6jMup0Cr5l/b7/tDiF2M3nd1bfbs7HC7G2m4KOzOE2Fc764HH/WxACo2jr53e1rs9ckXim5r7NM2ycK9f91uOeT6aVA/UB7uHfKrwm1GpVsUmFC2dDv5C82Cf3MNIpkD/ZYdfHXiamdnwEPMKszI394bwuYDGXDVFyImxICs2iUGLvbiQKHP9+gb7YOinOlv76mQD1gqjD9KN6XKzO5pOoYwlrbXeaX7oMKFvnHkvNBMotW8ZPIAu8sni4CdKW6RGNM4P3jUz4ZXzbw87BlA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7979.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(136003)(376002)(396003)(346002)(26005)(110136005)(52536014)(66946007)(5660300002)(86362001)(66476007)(76116006)(4326008)(9686003)(44832011)(316002)(55016002)(966005)(186003)(66446008)(53546011)(54906003)(7696005)(8936002)(478600001)(66556008)(33656002)(4744005)(71200400001)(6506007)(64756008)(8676002)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?dWtqbm05YVAxdlVpa0didjBVRm9sMm5KbnhaK1Z0ZnJLTU1lR0p3azVIdHNG?=
 =?utf-8?B?OGZ0Slkrd29GZmlia2d0ditoYVhXUVhzTGNySnFlY0VUVlV5WUpZQlRld2U2?=
 =?utf-8?B?QytGUkJMSGJOTFA5WVdaNEdSU0ZtKzJFN0NLQVJ1SGlZaGpHS1g4ZGRIVUdu?=
 =?utf-8?B?eSsvL21UZnRmQ0JjbHhqR2dWUFhEVlgyV2JSZk1ESHRwR1Y0V3lNeVhGaDBO?=
 =?utf-8?B?U1hXQWtsSEVVUjJTbThxZVdhK0VieDN3ZGh3K2h5T0VVRUIvemxrb2hidEJD?=
 =?utf-8?B?bThQYVVZWVNzbnQyTkhFc3E3MzM3UlR3Y3F5UEZrQVFBQ21tcVhmZFY5V3Zy?=
 =?utf-8?B?Qk9TS0lCa1ZPcTQvbk5CckVjZURlUm5MSy9MYXFLTWExTzlYWW5MZVQ0alUy?=
 =?utf-8?B?c0Z3N3J1UDNVWXV2REU5WFpGUXpxQm9zZCtCb01WWHYvaGF2UnJHWTRpOEFh?=
 =?utf-8?B?cXFYbW5vam5vKzh0V0FqR2krV3BmYTJkMW9mM0oyTnB2R1E5NUVHUWZMOFNh?=
 =?utf-8?B?anhiOGxSWEtEVnhhOEdZcjNUbCtCNEtsR21aRlJ0TEN0Q3BHaEpjTFc5UEJs?=
 =?utf-8?B?U0doMXV6WHUrMTYxaUtsME9KOU1PdDBNbDZlaTd2cEhSY21lNGxJdW9mWGlh?=
 =?utf-8?B?bGJ0S2V4cXJXalA0YjFiYjNSV2dxcEJqbm5XNm1ucW9ZM1J0ZHhQMFByb0Zm?=
 =?utf-8?B?TllZeDB0Y1dTd1FiUUkxU3BaaGFZNnZXN2pjOTdQK2FZZFJZY1BNVlpxRVU3?=
 =?utf-8?B?TjcyU0tIenVkUU5DTWtoa3ZNcUNBL0tRc05FWFFGcjE3SWJQYzNWOE92QjI5?=
 =?utf-8?B?RmpDVWdBYkxNVXFUa1VrM3JpZStqL0o2K3NQbjhyd1NLR3lSYUtLZURxZHZL?=
 =?utf-8?B?dEM5dkticDJhYjU1dEhRa3h2TWFPdjRnWFRjd2NnaWRjS3pxNC9td0w4UVdX?=
 =?utf-8?B?TXd4SDNxUGsrUHpkcW5rNFJrTTFkeHQ0VVlDUWd6cFRlQmx3NGRQKzV2Y3dS?=
 =?utf-8?B?K0M5Y2hHbUhVUUFER213anhHOWVLVXV3YlZ4NVhLa2d2VDdNZzRhTGpta1pz?=
 =?utf-8?B?UmtSY3UzSkd6VnVTbVNMNWx4MUl6cUZDNVlrbFUyRGZaZ25jREdlYXN6RllZ?=
 =?utf-8?B?L2VtcFMvamtnemxkYkcvYkw5a3U5T1VSWDZkTUxmWWlrWUthemVLZEd5Z295?=
 =?utf-8?B?ZFB4WUFWZEZZT0VGOTJqbisweVl6Ky9vNGxVdWIyWjNEZlFTZ0ZJWDI1VlJB?=
 =?utf-8?B?UTZwNlhwTGFmRmNHRnFRZElDUWkwTUZ3K3VWMXNlWmZWVVRLZ1dnZ2xOTWJx?=
 =?utf-8?Q?mboKyGH2TmTK4=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7979.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b888ab9a-ba91-43bd-a3ed-08d892b98305
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2020 09:47:53.7117
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eVzI0FfpSNUO1lEXohRIHszeGoZL5qzcDpMAch8NOPYwCRju32+b99HQoCa77lfxlGYI+QqSyBjlwt1gPoMxTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4235
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IA0KPiBIaSBQZXRlciwNCj4gDQo+IE9uIDI1LzExLzIwMjAgMTQ6NDksIFJvZ2VyIFF1YWRyb3Mg
d3JvdGU6DQo+ID4gSGFyZHdhcmUgYmFzZWQgcm9sZSBzd2l0Y2ggaXMgYnJva2VuIGFzIHRoZSBk
cml2ZXIgYWx3YXlzIHNraXBzIGl0Lg0KPiA+IEZpeCB0aGlzIGJ5IHJlZ2lzdGVyaW5nIGZvciAg
U1cgcm9sZSBzd2l0Y2ggb25seSBpZiAndXNiLXJvbGUtc3dpdGNoJw0KPiA+IHByb3BlcnR5IGlz
IHByZXNlbnQgaW4gdGhlIGRldmljZSB0cmVlLg0KPiA+DQo+ID4gRml4ZXM6IDUwNjQyNzA5ZjY1
OSAoInVzYjogY2RuczM6IGNvcmU6IHF1aXQgaWYgaXQgdXNlcyByb2xlIHN3aXRjaA0KPiA+IGNs
YXNzIikNCj4gPiBTaWduZWQtb2ZmLWJ5OiBSb2dlciBRdWFkcm9zIDxyb2dlcnFAdGkuY29tPg0K
PiANCj4gQ2FuIHlvdSBwbGVhc2UgcGljayB0aGlzIHVwIGZvciAtcmMgY3ljbGUsIGVsc2Ugb3Rn
IHdpbGwgYmUgYnJva2VuIGZvciB1cyBpbiB2NS4xMA0KPiByZWxlYXNlLg0KPiBUaGFua3MuDQo+
IA0KDQpJdCBpcyBhdCBteSAtZml4ZXMgdHJlZSBhbG9uZyB3aXRoIG15IHR3byBmaXhlc1sxXVsy
XS4gSWYgdGhlcmUgaXMgbm8gcmVwb3J0IGlzc3VlLA0KSSB3aWxsIHNlbmQgaXQgdG8gR3JlZyBu
ZXh0IE1vbmRheS4NCg0KWzFdIGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9s
aW51eC11c2IvcGF0Y2gvMjAyMDExMjYwNjU0MDkuNzUzMy0xLXBldGVyLmNoZW5Aa2VybmVsLm9y
Zy8NClsyXSBodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvbGludXgtdXNiL3Bh
dGNoLzIwMjAxMTI2MDY1NDA5Ljc1MzMtMi1wZXRlci5jaGVuQGtlcm5lbC5vcmcvDQoNClBldGVy
DQo=

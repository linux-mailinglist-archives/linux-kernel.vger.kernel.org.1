Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B553A2DF7F3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 04:11:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbgLUDLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Dec 2020 22:11:43 -0500
Received: from mail-eopbgr80042.outbound.protection.outlook.com ([40.107.8.42]:38626
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725497AbgLUDLm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Dec 2020 22:11:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A+2XN8SThlJlq+L28Gk+fmR+PD+ptaxJ0AEuOYJt2Jrb+Ib4TcPglSxkBHdJEAQ8ErcKKxJ7F3zYGZFw5QasZZoupNYF8SKNKslM66bubHKt9PRhPgtRS/c1X8mnt9q7XJioDRzVCWP8+VinOheTrPjiXMR5PdSWcdqoxIDFDpFkoF/vnjb3DIVzGHY+znxk7tI8Qb2/thJef3djIJVr5nva3Rdnt09GS3F7ajlmS1DibIL7HPKhjvIdimyvIFlZGoYFohcf7D7ddbADpAXJWB8v+lQQC2cHdijP6BflCvut6AhwYhFS61h2Bv4x1XCMD03Nla4rdQ4gNLHIX9W8dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i9G9LwncCURDgA4NamSKA4f0wmHa9bgxL0wio5ajX9M=;
 b=bX98fAmLDqf+Z4oZBJ4B+yL2u1omV+oz/YmIQe4ZvTya2NU9a6KZJliYD9fV9HguCAGLJx1ju6D09PyTTL+CV2KsyecDPcATXVrXlUGHbm3+GQotswb9KFC67J8KR9qQU9eF8UCWdTnSPLZJt2lZdePWCG8IHKUilJMmoOeWkA+u6vWKu8YfHexEvutOnUKLp8jCSCQL4nZr6kaA7sfsj5fr9mIR2dU9T75vPjn77G45If1WbV5hELuxff6oRy3Kv3yqvOr+6GXNxrDjcQE9cPI0ernxI23sZwtZgUgNdQ8J2K6Aml+RXKbm6gxkCrU9pHmEdof4Pny5Wvhcel6unw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i9G9LwncCURDgA4NamSKA4f0wmHa9bgxL0wio5ajX9M=;
 b=O7+NbSOkqqsKGvOAPRrDhTEft6leBhV6YxIlWOl7MJWQIjTYSgqkzypSKZ3O1MW2zaSe5oT6SRyJGyD1oK/KqncdTJSrlVXQuZUIZPN8lWRsDvn2wjqD/Keg1l919Jq1RJ3F2Tdai5ZkySXKDBz4om+ZJzvMoLHyRiB2rX2jf64=
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com (2603:10a6:20b:b9::10)
 by AM6PR0402MB3638.eurprd04.prod.outlook.com (2603:10a6:209:23::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.33; Mon, 21 Dec
 2020 03:10:52 +0000
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::78fe:9b7a:a2ac:9631]) by AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::78fe:9b7a:a2ac:9631%7]) with mapi id 15.20.3676.031; Mon, 21 Dec 2020
 03:10:52 +0000
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
Subject: RE: [PATCH v8 3/4] arm64: dts: imx8m: add NVMEM provider and consumer
 to read soc unique ID
Thread-Topic: [PATCH v8 3/4] arm64: dts: imx8m: add NVMEM provider and
 consumer to read soc unique ID
Thread-Index: AQHW1RkW1i0niF/JuUmT/2rSyLdybKn+V30AgAKL3iA=
Date:   Mon, 21 Dec 2020 03:10:52 +0000
Message-ID: <AM6PR04MB605316DAE14009BB28804AB3E2C00@AM6PR04MB6053.eurprd04.prod.outlook.com>
References: <20201218083726.16427-1-alice.guo@oss.nxp.com>
 <20201218083726.16427-3-alice.guo@oss.nxp.com>
 <20201219121656.GA13886@kozik-lap>
In-Reply-To: <20201219121656.GA13886@kozik-lap>
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
x-ms-office365-filtering-correlation-id: b33962b7-32c8-445c-06ae-08d8a55e065c
x-ms-traffictypediagnostic: AM6PR0402MB3638:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR0402MB3638A6880EC949005F8F9378A3C00@AM6PR0402MB3638.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: klaw9izt+nZaZwUIkkIa725uxbmTEl59/XoidISuJ0lxEYX9pywXX5kb9WT7eVGXH9R/yfsliGuIM8lGBEzxgurj+ALV+DKiMdnyLOgUYuYWzH2L6cF7tSNgx/6dSny2CsI4d4087q4cp6CqC7cTnHcZEY8XVEdp7bDhdK4IEkft4QPXgm61V+jz/jjetUEtuDOPfiiSLHiQtOflWDyKQaVdBLXUdeo47XMr4iv2VM22ABZEUO6GI3dWc+KJwhTJRkx9kyuDhVVv8ik4n6qRaO7L/BPLPO/Rsj3qfRFnEcIKWEB6rXcWpz7UCrJCDg6g84CK6qFdi0071906r9YW20wKd0l4htYSvHJnM3PVTFNmugs1UES9H5DP4C7WAqOMcmh+Za691hM0ffeONvgF+w9YUumh6o+jmEEKcsNpR3sdpsELZ+SExDarr7nTOtbd
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(39860400002)(376002)(396003)(136003)(55016002)(86362001)(76116006)(8676002)(83380400001)(54906003)(52536014)(4744005)(2906002)(316002)(64756008)(66946007)(66476007)(4326008)(66556008)(110136005)(66446008)(9686003)(186003)(26005)(5660300002)(33656002)(71200400001)(6506007)(7696005)(53546011)(8936002)(478600001)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?dUtVZXBHTlBmbHROK3dGa2xkQnNsbXBZR1N2T2Y5a1VQZDIvQUNMcHR1ekVP?=
 =?utf-8?B?cm1yejNlN1RZMXQ5ak9vN0xCT2ZxblowYzg4MzRJa3QxVm56c01QNERwb0JU?=
 =?utf-8?B?WFp1OStFbVlJd3NDemhmdnREZ09rTkhoTDFVVUwvcUJmNTROeWFwN2JqeHF1?=
 =?utf-8?B?Z1k2OU4ycmZ1NVpYTFE0YWdBeDJ4eWVOT0FINlA4YWtGQzk1d0JxbXB1ckR3?=
 =?utf-8?B?ZEdTbzYyRXNRMi9CYTNERXB3emUrOS9tcXl6bjh4ZFQ2dC9yT20xQlRMMG1Y?=
 =?utf-8?B?NjUvUnlnMjAwYmdxL2hkb0R2Yk9sN0hpbThYK2VPQ3R0QkYvYmZoMjlob2My?=
 =?utf-8?B?OGRPazlpS2owcC9TTGhKWXFJWEduY1NBVzdxMFhyb0U4N1AwZG8vdzAyS0pE?=
 =?utf-8?B?M29HTjIzK0d5MU1TTm1CeWFXZFN5cEhRRmpVZkUyeUNTSENJSFpSbHFpVUZi?=
 =?utf-8?B?c2lmSkxMZUZRS05hYWdZRDZ4U3FxRTNmQWtYQWE5Mjg4V1hKR0tISTlrRm1r?=
 =?utf-8?B?ay9aQVVWVE9JVi9pZFg1MXNzQTVhcENwaFlIVVM4bllxWC9TSGQ2RVZ4RnVv?=
 =?utf-8?B?YzZCdCt6S0F4ckptQU4yRE9CRitCODlwbHF6R1lHcjB2ZFNOQkQvUm1IVTJX?=
 =?utf-8?B?Y1A4a1FzZmFPbk9QcnF3VkFRTXJLdkpKei9nQmhmNmtDaGdQQzE0dkQvUHgw?=
 =?utf-8?B?SHE2cDdta1E2ZnJBR3lrcDU2NlJ0cUpOKzJoWW5lT1J3S3VxYkMvaUpyMk9S?=
 =?utf-8?B?S1dRRUxXdCtmWHlYaDZqeWs2cmV2UlB5RUVGS2kwTmdYRzhranFFeStQY1U2?=
 =?utf-8?B?dE9NSk5FeHRwamlSeVJzWFI2M2dTeWZxTTNzRDZremYreE9xSlVTcGNWTGhx?=
 =?utf-8?B?MzBqN0lLdWV6dUp2cDFDUXBIUDF3SEFobjJIcnlDVWN0dlRYTXlndDBOZ2F4?=
 =?utf-8?B?RjdnSW44dFhKajR6STlUMmdzbzBHblJ2TmNGVldiZXRTb0RsMEd1eEQ4QnZB?=
 =?utf-8?B?ZWlWUHErZEhWZTFkU3RXYll0MXdPYXNGdDdDZ1ErNXhwZTkwd25Yb1Q4R214?=
 =?utf-8?B?SDduN3orWFpMOXRJUlRhUlREMUlvSW4wREh5WU5NUi9SSUdSU3d4MU0xSWhz?=
 =?utf-8?B?TGYyREVpWHIxY1plTlMxcmRLdE5JbVRLTWhPb3lpRXVWQXAzTHIxWHp6MmRp?=
 =?utf-8?B?NzZqUERKN2FMd1ZIa1E4dFM1ckw3V1RvZ1p5QlEyL0REaTRvTEdWbzd4Ymwr?=
 =?utf-8?B?QnllajBGRFRrTVh1K0FCblJ6OUY5SE1FZXRHZXR2bHg1Z2ZzYkx1d0lwN2Rl?=
 =?utf-8?Q?MzD14AtfWhOqw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b33962b7-32c8-445c-06ae-08d8a55e065c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2020 03:10:52.3939
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vmx6VwTVAdAx1msZV6uorESEQeLC93UuO/Q+G/GVjlHhyNjhNziWCjEu7E3QlLVAg5PBbtTxOO66+vDAZD/nzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3638
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6a0BrZXJuZWwub3JnPg0KPiBTZW50OiAyMDIw5bm0MTLmnIgxOeaXpSAyMDoxNw0K
PiBUbzogQWxpY2UgR3VvIChPU1MpIDxhbGljZS5ndW9Ab3NzLm54cC5jb20+DQo+IENjOiByb2Jo
K2R0QGtlcm5lbC5vcmc7IHNoYXduZ3VvQGtlcm5lbC5vcmc7IHMuaGF1ZXJAcGVuZ3V0cm9uaXgu
ZGU7DQo+IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgZmVzdGV2YW1AZ21haWwuY29tOyBkZXZpY2V0
cmVlQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQu
b3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBkbC1saW51eC1pbXgNCj4gPGxpbnV4
LWlteEBueHAuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY4IDMvNF0gYXJtNjQ6IGR0czog
aW14OG06IGFkZCBOVk1FTSBwcm92aWRlciBhbmQNCj4gY29uc3VtZXIgdG8gcmVhZCBzb2MgdW5p
cXVlIElEDQo+IA0KPiBPbiBGcmksIERlYyAxOCwgMjAyMCBhdCAwNDozNzoyNVBNICswODAwLCBB
bGljZSBHdW8gKE9TUykgd3JvdGU6DQo+ID4gRnJvbTogQWxpY2UgR3VvIDxhbGljZS5ndW9Abnhw
LmNvbT4NCj4gPg0KPiA+IEluIG9yZGVyIHRvIGJlIGFibGUgdG8gdXNlIE5WTUVNIEFQSXMgdG8g
cmVhZCBzb2MgdW5pcXVlIElELCBhZGQgdGhlDQo+ID4gbnZtZW0gZGF0YSBjZWxsIGFuZCBuYW1l
IGZvciBudm1lbS1jZWxscyB0byB0aGUgInNvYyIgbm9kZSwgYW5kIGFkZCBhDQo+ID4gbnZtZW0g
bm9kZSB3aGljaCBwcm92aWRlcyBzb2MgdW5pcXVlIElEIHRvIGVmdXNlQDMwMzUwMDAwLg0KPiA+
DQo+ID4gU2lnbmVkLW9mZi1ieTogQWxpY2UgR3VvIDxhbGljZS5ndW9AbnhwLmNvbT4NCj4gPiAt
LS0NCj4gPiBDaGFuZ2VzIGZvciB2ODoNCj4gPiAgLSBub25lDQo+ID4gQ2hhbmdlcyBmb3Igdjc6
DQo+ID4gIC0gYWRkIFJldmlld2VkLWJ5DQo+IA0KPiBXaGF0IGhhcHBlbmVkIHdpdGggbXkgcmV2
aWV3ZWQtYnk/DQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KDQpIaSwNCkkgZm9y
Z290IHRvIGFkZCByZXZpZXdlZC1ieS4g4pi5DQoNCkJlc3QgcmVnYXJkcywNCkFsaWNlDQo=

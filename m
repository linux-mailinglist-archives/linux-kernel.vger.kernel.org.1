Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 139E12DFAA7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 10:58:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbgLUJ5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 04:57:55 -0500
Received: from mail-eopbgr20080.outbound.protection.outlook.com ([40.107.2.80]:37955
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726120AbgLUJ5y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 04:57:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I+EglisY9jtQvFNSLeomjdGGAHKdG+hX1rnXw8lpdOASWNIb9WRNEDxNgG8wxDWfzbcsI6HG22/pP9wVYm4YqdNWcujUrBxOo+uvRshoxL3yff/1ADxU7iNp/do+qFjN0GM3JUBW6g1QvJp9TND0lMneZm50+HCGJPCixwSK3YfELdTV7Tg2J4FmPqdFG3ws0ceJ/pGC/0fDWsKqoUzL5vUOBzVScdONsAQ+fRD9N3Fb09TVGJ3u/LC2/VM0xuen5OWVOVHEu8EvLVHd2B8iDWavnScBCMJjalwV8BRXKNMlckzi0+S925n+FfjX/9nXocfLC+2tP1bryLb23ye8mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dCcg60Y7gL3INcT4hIni8lvDR4G0iYcpwUSSLf5LaPA=;
 b=gq3mgy/VnLHsdbKKTPmA0CENkyzXOyK5e7zogIxUb3HpsPUlpMMvA6VA3VK6EkvaqSgrm0qlErojot0wqH9RxdAGgKdGNAsqCOiGGBv3ldAIjw8b7vRn2HTroaxK3NudQfSrPOMNDnMpescGEA1U8yIYsu2kIlC3jl7XNQJ2rp7DBHhF11bDySN/EInJtAvXX9/qLJz97rCaTUyA5iK16LSZ6L+dgtDioR244BwQ9I20J0cwts1lKUkPaVMLE3eKd8VYtEQ+RQNxWEQ1M7dtqKrMDyF/0UDCu6wRMa6LKcwAi8ReXppupJ2yHuF9YHtqkc7UYfbdzkEfcowJ6ewfWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dCcg60Y7gL3INcT4hIni8lvDR4G0iYcpwUSSLf5LaPA=;
 b=Yj7K15UNi0Ml0LBNklaUqzGCer7WOBZuaCltQZSQPGZoL1XSrNqL7XRH5zTbjlzFLd7QjXgau8AdDGnUHJkQLFenYBBTRmFsH+yk4BCh4PXa60qORjZamZ5qNVKbre6Na+3nGs/z7+NZj04HQKpnX+J5K0U9y+32b8ptGE72ksk=
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com (2603:10a6:20b:b9::10)
 by AS8PR04MB7943.eurprd04.prod.outlook.com (2603:10a6:20b:2a1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.25; Mon, 21 Dec
 2020 09:20:48 +0000
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::78fe:9b7a:a2ac:9631]) by AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::78fe:9b7a:a2ac:9631%7]) with mapi id 15.20.3676.033; Mon, 21 Dec 2020
 09:20:48 +0000
From:   "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To:     Rob Herring <robh+dt@kernel.org>,
        "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
CC:     Krzysztof Kozlowski <krzk@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v8 1/4] dt-bindings: soc: imx8m: add DT Binding doc for
 soc unique ID
Thread-Topic: [PATCH v8 1/4] dt-bindings: soc: imx8m: add DT Binding doc for
 soc unique ID
Thread-Index: AQHW1RkPpji9TbVGY0Ki90hKbr4yE6n8jAGAgAADhwCAAAjagIAACpeAgAA+2ICABGb/wA==
Date:   Mon, 21 Dec 2020 09:20:48 +0000
Message-ID: <AM6PR04MB6053DA4440458D9F9BDB1C08E2C00@AM6PR04MB6053.eurprd04.prod.outlook.com>
References: <20201218083726.16427-1-alice.guo@oss.nxp.com>
 <20201218085223.GA17306@kozik-lap>
 <AM6PR04MB6053A65F794B316659CDE638E2C30@AM6PR04MB6053.eurprd04.prod.outlook.com>
 <20201218093641.GA38684@kozik-lap>
 <AM6PR04MB60534C972777EED96FD105D2E2C30@AM6PR04MB6053.eurprd04.prod.outlook.com>
 <CAL_JsqLyPPpO5OVLa4baqaJ3MGjJe5p_100ULZSmuf4q8UjWGw@mail.gmail.com>
In-Reply-To: <CAL_JsqLyPPpO5OVLa4baqaJ3MGjJe5p_100ULZSmuf4q8UjWGw@mail.gmail.com>
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
x-ms-office365-filtering-correlation-id: 5b129c2a-5ff9-4564-3338-08d8a591b476
x-ms-traffictypediagnostic: AS8PR04MB7943:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AS8PR04MB794398F03E4638A210BDC489A3C00@AS8PR04MB7943.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1122;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XxgWpKV35jcCgfdeN86PTOhOfePck//3mWMudJ83g03FRzJldNUnvv9FkA3q0IHvsTqecl/Y7DTLU4j8gj/5gGjbTG8COhYVZa6y00bA0UcyauIK7UmXRHWo9WGQTLraArwmW933l9vhcy2ZMDlpaiSVY/gUShXMX8k1BupEycI9br1w/R2HUaVy3N6VuW31bpBPBOl4kFflB1P1iXn6JnFEYrt5Gt8SaU0UJEW8S78x/2etFEy6LE/aK8tCaajwWAbZQSRAvLe6cEMrs4ijou0fWl7K95jA3xXOUvODA15LYLKUnzURit1DHvCFdffFxLB1fMLxl3MfWzxE7w7vbgvM+S9esRon7aVOL1mS83+WPX8f+IB00hk0K1aD0Gj9e+w1hCSdbV5Ph+ODNVnZOJfmwXziJlyfiZ+PS2x3OvxaJtpkqD5+Hh0vJaU00io7pg/aEeoOJmnnxMjcwSiNTUDXV7NM+VXlcByrMlZZtSthZqOAUX/cEjKo9XR/zpNOXx2vFgpiillp9+m/s5QnZA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(366004)(396003)(39860400002)(136003)(66946007)(66556008)(316002)(54906003)(53546011)(66446008)(966005)(478600001)(110136005)(2906002)(64756008)(66476007)(83380400001)(4326008)(86362001)(52536014)(76116006)(8936002)(8676002)(9686003)(71200400001)(33656002)(55016002)(186003)(5660300002)(6506007)(26005)(7696005)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?bGE3VjhRV3lSMHZ6Q1pad2tmR3YxY3FKcUFDbWZOTFBleGhHLzFCeG9neWRD?=
 =?utf-8?B?eTE2WVZ3NC91YjMvM1hSUGE3TTNKZHVwN3VacWNSVjljaWM2RTViU1BqRndq?=
 =?utf-8?B?MFYxMVIxNUlzM0NuRUJGMjBCbENjWVBHTXpka0liU3VjU09aN0M5UjZpaDB2?=
 =?utf-8?B?Y3dPdmRLa3NkTWRXcWduQWJVdjV5Ly8rdkY3ZlU4dDJtQUZ5SGRCNFBQbnBh?=
 =?utf-8?B?ZVA2UjcreGloeS9SS3J4YWFUMGhpaHgzVk01VkhlbytTbHl6dWVKYVRxeTZD?=
 =?utf-8?B?U1dnTkR4dFRuaWFGZktla0RRb1JTVjlDVTRqWW1ydlBZTGNnYU1kTmdZTEpj?=
 =?utf-8?B?MDd0bVhBU0J3bVRtTy9nK3hYYXlzcS9zNHc3eGFNNjF2dUZ0UFBwV1JXQkNC?=
 =?utf-8?B?U3ZtbmxSU20xeUlOUmJmbktob3FhN0tMdlhSdUtKd1hqY2RXWi9xV2RaVkl1?=
 =?utf-8?B?czJjSFpuQ0FzRVZNVkZ5Q2lBdkhjc1p2MlM5cTR3NjBtWG5OWngyWDRHVnl0?=
 =?utf-8?B?bXJZWmJtSkFkdkhLaUIrZ0FEbFB6djlBZ1hJanFwUTdPb1Y1S3hWQnZwc0pS?=
 =?utf-8?B?SUswTVh2OEJVY0tPbXVmbUZCcXZoTHVBQng1MGRWQThPVFI0dXB6R3JOdDJr?=
 =?utf-8?B?Vm81ZVBFR3lxTGFobnNhSCswdzVndVYrTDkzWWdCU3JaTHZtUlZCdUZDMklM?=
 =?utf-8?B?TElTamxJTEFodnZHeUZSNlpwYjNDS0k1ZnlWYjNnUUVFQlF5czBwOERLb1Fv?=
 =?utf-8?B?LzJXQmhjMmh1ZXpjODZMek5HcFU5NzZqT1o5eXBEMUs0TldldW0wTzRSZVEx?=
 =?utf-8?B?WGsyS2l4NXVldEEzdlJTNzg3WXlMWEEycWNpSmpFSzVYb1dCajl0Nmw3MnVj?=
 =?utf-8?B?NTczcGFyTXpFMVRFOXlKQnl6VWNTRXY1OEpkazhxZmdHallsT1hLU3QweVBE?=
 =?utf-8?B?ZjhUT1d0TXFMZ0lXNzlsMGZ0SDBiYkNYbW96bkVTeHM2MEdwbllHMTlybXhh?=
 =?utf-8?B?YWhxVGtUQWl3RXljNDcrckRNQTh6d21BcTdOa2I5aHk5S3haZTMwQnJnVDh3?=
 =?utf-8?B?ZTVCcm1HUWNBdWVaOUIrTVFkdUlWYS92VXViK2RUQi9sMlREOVEwQVhuTHJQ?=
 =?utf-8?B?RGFDMW8wTTIyVTMwcGY3enBhY2FJRHdpTW1sK3F3bFQyOWxHMDRGM1dMU1VF?=
 =?utf-8?B?enVSU3V2Tk1XQXlLSFN6SElOMUhjcDdYVjJzZVh2NEJBK2xaY2dpZDZ1N0Vz?=
 =?utf-8?B?akloYUZNeE9DYmRmMGpETElvZnVZSEE2eFUvWXU1KzVrSUlwRVdxbnIvYk5t?=
 =?utf-8?Q?nht04XP79f8rc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b129c2a-5ff9-4564-3338-08d8a591b476
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2020 09:20:48.7422
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZAQ2d/lOCxtoOzV0lRk6zU7PQyd8tWiu56d3XdWBclhSQP4TrVvKUppa2eNFQZ1YR8CcfVKDyf1Bk2jalNKTnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7943
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUm9iIEhlcnJpbmcgPHJv
YmgrZHRAa2VybmVsLm9yZz4NCj4gU2VudDogMjAyMOW5tDEy5pyIMTjml6UgMjI6MDANCj4gVG86
IEFsaWNlIEd1byAoT1NTKSA8YWxpY2UuZ3VvQG9zcy5ueHAuY29tPg0KPiBDYzogS3J6eXN6dG9m
IEtvemxvd3NraSA8a3J6a0BrZXJuZWwub3JnPjsgc2hhd25ndW9Aa2VybmVsLm9yZzsNCj4gcy5o
YXVlckBwZW5ndXRyb25peC5kZTsga2VybmVsQHBlbmd1dHJvbml4LmRlOyBmZXN0ZXZhbUBnbWFp
bC5jb207DQo+IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxp
c3RzLmluZnJhZGVhZC5vcmc7DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGRsLWxp
bnV4LWlteCA8bGludXgtaW14QG54cC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjggMS80
XSBkdC1iaW5kaW5nczogc29jOiBpbXg4bTogYWRkIERUIEJpbmRpbmcgZG9jIGZvciBzb2MNCj4g
dW5pcXVlIElEDQo+IA0KPiBPbiBGcmksIERlYyAxOCwgMjAyMCBhdCA0OjE0IEFNIEFsaWNlIEd1
byAoT1NTKSA8YWxpY2UuZ3VvQG9zcy5ueHAuY29tPg0KPiB3cm90ZToNCj4gPg0KPiA+DQo+ID4N
Cj4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBLcnp5c3p0b2Yg
S296bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+DQo+ID4gPiBTZW50OiAyMDIw5bm0MTLmnIgxOOaX
pSAxNzozNw0KPiA+ID4gVG86IEFsaWNlIEd1byAoT1NTKSA8YWxpY2UuZ3VvQG9zcy5ueHAuY29t
Pg0KPiA+ID4gQ2M6IHJvYmgrZHRAa2VybmVsLm9yZzsgc2hhd25ndW9Aa2VybmVsLm9yZzsgcy5o
YXVlckBwZW5ndXRyb25peC5kZTsNCj4gPiA+IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgZmVzdGV2
YW1AZ21haWwuY29tOw0KPiA+ID4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFy
bS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4gPiA+IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmc7IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5jb20+DQo+ID4gPiBTdWJqZWN0
OiBSZTogW1BBVENIIHY4IDEvNF0gZHQtYmluZGluZ3M6IHNvYzogaW14OG06IGFkZCBEVCBCaW5k
aW5nDQo+ID4gPiBkb2MgZm9yIHNvYyB1bmlxdWUgSUQNCj4gPiA+DQo+ID4gPiBPbiBGcmksIERl
YyAxOCwgMjAyMCBhdCAwOTowNTowMEFNICswMDAwLCBBbGljZSBHdW8gKE9TUykgd3JvdGU6DQo+
ID4gPiAgPiA+ICsgICAgcmVxdWlyZWQ6DQo+ID4gPiA+ID4gPiArICAgICAgLSBjb21wYXRpYmxl
DQo+ID4gPiA+ID4gPiArICAgICAgLSBudm1lbS1jZWxscw0KPiA+ID4gPiA+ID4gKyAgICAgIC0g
bnZtZW0tY2VsbC1uYW1lcw0KPiA+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ID4gK2FkZGl0aW9uYWxQ
cm9wZXJ0aWVzOiB0cnVlDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBEb24ndCBsZWF2ZSBjb21tZW50
cyB1bnJlc29sdmVkIChvciByZXNvbHZlIHRoZW0gYWdhaW5zdCByZXZpZXcNCj4gPiA+ID4gPiB3
aXRob3V0IGRpc2N1c3Npb24pLiBSb2IgYXNrZWQgZm9yIGNoYW5naW5nIGl0LiBUaGUgc2FtZSBh
cyB3aXRoDQo+ID4gPiA+ID4gYWxsIHNjaGVtYXMgLSB5b3UgbmVlZCB0byBkZXNjcmliZSB0aGUg
bWlzc2luZyBwcm9wZXJ0aWVzLg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gQmVzdCByZWdhcmRzLA0K
PiA+ID4gPiA+IEtyenlzenRvZg0KPiA+ID4gPg0KPiA+ID4gPiBIaSwNCj4gPiA+ID4gVGhhbmsg
eW91IGZvciB5b3VyIGFkdmljZS4gSSByZXBsaWVkIHRvIGhpbSBhbmQgbGV0IGhpbSBrbm93IEkN
Cj4gPiA+ID4gcmVtYWluZWQgaGVyZQ0KPiA+ID4gdW5jaGFuZ2VkLiBUaGVyZSB3aWxsIGJlIGVy
cm9ycyBhY2NvcmRpbmcgdG8gaGlzIHN1Z2dlc3Rpb24uDQo+ID4gPg0KPiA+ID4gVGhlbiB0aGUg
c29sdXRpb24gaXMgdG8gY29ycmVjdCB0aGUgZXJyb3JzIC0gZGVzY3JpYmUgbWlzc2luZw0KPiA+
ID4gcHJvcGVydGllcw0KPiA+ID4gLSBpbnN0ZWFkIG9mIGlnbm9yaW5nIHRoZSBzdWdnZXN0aW9u
IGFuZCBtYWtpbmcgYSByZXN1Ym1pdCByaWdodCBhd2F5Lg0KPiA+ID4NCj4gPiA+IEJlc3QgcmVn
YXJkcywNCj4gPiA+IEtyenlzenRvZg0KPiA+DQo+ID4gSGksDQo+ID4gSSBhbSBzb3JyeSBJIGRv
IG5vdCBEVCBCaW5kaW5nIGRvYyB2ZXJ5IHdlbGwuDQo+ID4NCj4gPiBJIGNoZWNrZWQgdGhlIHVz
YWdlIG9mIHBhdHRlcm5Qcm9wZXJ0aWVzIGFuZCBhZGRpdGlvbmFsUHJvcGVydGllcyBpbg0KPiBo
dHRwczovL2pzb24tc2NoZW1hLm9yZy91bmRlcnN0YW5kaW5nLWpzb24tc2NoZW1hL3JlZmVyZW5j
ZS9vYmplY3QuaHRtbC4NCj4gPiBJIG5vdGljZWQgYSBzZW50ZW5jZSBvbiB0aGUgd2Vic2l0ZTog
IiBJZiBhZGRpdGlvbmFsUHJvcGVydGllcyBpcyBhDQo+ID4gYm9vbGVhbiBhbmQgc2V0IHRvIGZh
bHNlLCBubyBhZGRpdGlvbmFsIHByb3BlcnRpZXMgd2lsbCBiZSBhbGxvd2VkLiIsIHNvIEkgdGhp
bmsNCj4gdGhhdCBpZiBhZGRpdGlvbmFsUHJvcGVydGllcyBpcyBhIGJvb2xlYW4gYW5kIHNldCB0
byB0cnVlLCBhZGRpdGlvbmFsIHByb3BlcnRpZXMNCj4gd2lsbCBiZSBhbGxvd2VkLiBMZXR0aW5n
IGhlcmUgdW5jaGFuZ2VkIGlzIG15IHNvbHV0aW9uIHRvIGNvcnJlY3QgdGhlIGVycm9ycy4NCj4g
PiBJIGFtIG5vdCBzdXJlLCBJIGFza2VkIFJvYiBmb3IgYWR2aWNlIG9uIHRoZSB2NiBieSBlbWFp
bCwgYnV0IGhlIGRpZG4ndCByZXBseSB0bw0KPiBtZSwgc28gSSBtYWRlIGEgcmVzdWJtaXQuDQo+
IA0KPiBZb3Ugd2FpdGVkIGFuIGhvdXIgYW5kIEkgd2FzIHNsZWVwaW5nISBXYWl0aW5nIG1lYW5z
IHdhaXRpbmcgYSB3ZWVrLg0KPiANCj4gWW91IG5lZWQgdG8gYWRkICcjYWRkcmVzcy1jZWxscycg
YW5kICcjc2l6ZS1jZWxscycuDQo+IA0KPiBSb2INCkhpLCBSb2INCg0KQ2FuIGNoYW5nZSB0byB0
aGUgZm9sbG93aW5nIGNvZGU/DQpXaGVuIHVzZXMgImFkZGl0aW9uYWxQcm9wZXJ0aWVzOiB0eXBl
OiBvYmplY3QiLCBuZWVkIHRvIGFkZCBtb2RlbCwgY29tcGF0aWJsZSwgaW50ZXJydXB0LXBhcmVu
dCwgI2FkZHJlc3MtY2VsbHMgYW5kICNzaXplLWNlbGxzLg0KVGhlcmUgd2lsbCBiZSBlcnJvciB3
aXRoIGFkZGluZyBpbnRlcnJ1cHQtcGFyZW50IGJlY2F1c2UgImR0LWJpbmRpbmdzOiByZW1vdmUg
J2ludGVycnVwdC1wYXJlbnQnIGZyb20gYmluZGluZ3MiLg0KDQojIFNQRFgtTGljZW5zZS1JZGVu
dGlmaWVyOiAoR1BMLTIuMCBPUiBCU0QtMi1DbGF1c2UpDQolWUFNTCAxLjINCi0tLQ0KJGlkOiBo
dHRwOi8vZGV2aWNldHJlZS5vcmcvc2NoZW1hcy9zb2MvaW14L2lteDhtLXNvYy55YW1sIw0KJHNj
aGVtYTogaHR0cDovL2RldmljZXRyZWUub3JnL21ldGEtc2NoZW1hcy9jb3JlLnlhbWwjDQoNCnRp
dGxlOiBOWFAgaS5NWDhNIFNlcmllcyBTb0MNCg0KbWFpbnRhaW5lcnM6DQogIC0gQWxpY2UgR3Vv
IDxhbGljZS5ndW9AbnhwLmNvbT4NCg0KZGVzY3JpcHRpb246IHwNCiAgTlhQIGkuTVg4TSBzZXJp
ZXMgU29DcyBjb250YWluIGZ1c2UgZW50cmllcyBmcm9tIHdoaWNoIFNvQyBVbmlxdWUgSUQgY2Fu
IGJlDQogIG9idGFpbmVkLg0KDQpwcm9wZXJ0aWVzOg0KICAkbm9kZW5hbWU6DQogICAgY29uc3Q6
ICcvJw0KDQogIGNvbXBhdGlibGU6DQogICAgY29udGFpbnM6DQogICAgICBlbnVtOg0KICAgICAg
ICAtIGZzbCxpbXg4bW0NCiAgICAgICAgLSBmc2wsaW14OG1uDQogICAgICAgIC0gZnNsLGlteDht
cA0KICAgICAgICAtIGZzbCxpbXg4bXENCiANCiAgIiNhZGRyZXNzLWNlbGxzIjoNCiAgICBjb25z
dDogMg0KICAiI3NpemUtY2VsbHMiOg0KICAgIGNvbnN0OiAyDQoNCnBhdHRlcm5Qcm9wZXJ0aWVz
Og0KICAiXnNvY0BbMC05YS1mXSskIjoNCiAgICB0eXBlOiBvYmplY3QNCiAgICBwcm9wZXJ0aWVz
Og0KICAgICAgY29tcGF0aWJsZToNCiAgICAgICAgaXRlbXM6DQogICAgICAgICAgLSBlbnVtOg0K
ICAgICAgICAgICAgICAtIGZzbCxpbXg4bW0tc29jDQogICAgICAgICAgICAgIC0gZnNsLGlteDht
bi1zb2MNCiAgICAgICAgICAgICAgLSBmc2wsaW14OG1wLXNvYw0KICAgICAgICAgICAgICAtIGZz
bCxpbXg4bXEtc29jDQogICAgICAgICAgLSBjb25zdDogc2ltcGxlLWJ1cw0KDQogICAgICBudm1l
bS1jZWxsczoNCiAgICAgICAgbWF4SXRlbXM6IDENCiAgICAgICAgZGVzY3JpcHRpb246IFBoYW5k
bGUgdG8gdGhlIFNPQyBVbmlxdWUgSUQgcHJvdmlkZWQgYnkgYSBudm1lbSBub2RlDQoNCiAgICAg
IG52bWVtLWNlbGxzLW5hbWVzOg0KICAgICAgICBjb25zdDogc29jX3VuaXF1ZV9pZA0KDQogICAg
cmVxdWlyZWQ6DQogICAgICAtIGNvbXBhdGlibGUNCiAgICAgIC0gbnZtZW0tY2VsbHMNCiAgICAg
IC0gbnZtZW0tY2VsbC1uYW1lcw0KDQphZGRpdGlvbmFsUHJvcGVydGllczogdHJ1ZQ0KLi4uDQoN
CkJlc3QgcmVnYXJkcywNCkFsaWNlDQoNCg0K

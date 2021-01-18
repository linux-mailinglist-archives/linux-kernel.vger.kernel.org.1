Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1D52F98B8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 05:38:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731152AbhAREhu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jan 2021 23:37:50 -0500
Received: from mail-am6eur05on2049.outbound.protection.outlook.com ([40.107.22.49]:19744
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730001AbhAREho (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jan 2021 23:37:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V2bTUHv3u8aNPr8N61BjCcSltI3gxByJYtHKYSPdCbVuwE7U5iC7BpEqrJPh/TILTGVAZkZTnbONq9GeFj5avgJ9C2tSCaFPqN0sh3wI0DzZ+rXEN0NYjpvWQUVErIDmiafWRw4zUrk0AoKbIDTAop/hTgNAOTRKj5yeSTzXV61wRQD5l89ofTBi63DuRsN/T5+dC3YPx3LVezqrsdyqHrGTNBzriZHIRH49EQDCAaEpucgvU6++8vbKCl+PAdNGEdni6JYCRhJLgkQkWk0XvMh9EjpOi4WenD+R1fNMLRJ90t1NPC0BDwInQKI/ctFOqrT5aR8gE3AwIfSEFKnmfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U48vkF4a5teQYyMcqf4OwrPLr1R5o5Rw4Mg9NRx5O18=;
 b=aq533H0KPjEfXI3Xi38Zp1FVfvXPNv51RkeE7c6VAkGwBxD9aj6/Mzlrk291bNHkPNYBQuyGiB4TwBTfjsG1pHI2XY9Xmhb7It9jfPK3NEZ5mKRAxezzrrx5ACL8E4+BDkPwXb3IBBPxP4jXn4q+kg9Cav+k8rlOg5y23ocwhFIV0djqALCRiepzKsy6A8NyxAEFYNHNQyup0WkK5IzW8tbtbsHN4oN737Q9a8LsSbPSVwGJplSYrD5xmqL7CPmrG0fjZmYyxBxX03cfWJjMubWRgnXq9Zqvc5a7MIx7bULb0nZ19tlvXaJ4ckYYaLKcUeJKxP9LcnNrcW5BVbnsFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U48vkF4a5teQYyMcqf4OwrPLr1R5o5Rw4Mg9NRx5O18=;
 b=EBh53SWRa1VDhpx607cX5hN0YjZRJ0tTB5vHGoaqfZwL5NdpKppfmXYx67y9zFDkX+MI8qUTXLxjIXhI5WwQkt9R/G5C8+1k5LiAjJzhSuE3UswcjLVx9JubcdPy3tEGTsMdTQ+VRjlRLJHwIi1sMpcDI1OY/xdFM2mtPYUhwcM=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR0402MB3557.eurprd04.prod.outlook.com (2603:10a6:209:2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.14; Mon, 18 Jan
 2021 04:36:55 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::483:ee1e:eeee:df98]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::483:ee1e:eeee:df98%3]) with mapi id 15.20.3763.014; Mon, 18 Jan 2021
 04:36:55 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     kernel test robot <lkp@intel.com>,
        Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Anson Huang <anson.huang@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>
Subject: RE: [PATCH] imx: select SOC_BUS to fix firmware build
Thread-Topic: [PATCH] imx: select SOC_BUS to fix firmware build
Thread-Index: AQHW67hW5dj/zWAQUUatq4bMz3g2OKoszyHA
Date:   Mon, 18 Jan 2021 04:36:55 +0000
Message-ID: <AM6PR04MB49666F4A293420EF8E090E8B80A40@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <20210116033259.31941-1-rdunlap@infradead.org>
In-Reply-To: <20210116033259.31941-1-rdunlap@infradead.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7816b185-2263-4d98-5e3b-08d8bb6aaf28
x-ms-traffictypediagnostic: AM6PR0402MB3557:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR0402MB355757989A617CBCDD8DCF2380A40@AM6PR0402MB3557.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:983;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u7azO+vyJv2qthpdEKOf8QhKyQS1ghXVS4fEpbxyM1fOesshgylVPpp2AGM1FGP4msfXvw1jPhvi3FG7ymvhizMrxq8defNkC30DngpIDqH5hOFWEA4oQcr+Xp02tZZ2gyI9Vmj65ldYeB8oTDL4ggYLgKV/wk0otxevDVulf5qX7TNlrWVY7lO9rAu1iUzjiZ6oKLcuj6JCjfdoV2lV/PyTIkv048tH7onpV09sKtzoRallv7PTs4vVx8vpyr+TNForHiKDOwcrj1alphYrAGDVUdrMkc15vaEwxthZKYHhxgUrGoMTCQ2Eb6v28IQocOp+ihiV1wQ/VAWK2aW4mM5STZhba/xKHDbec2svSZbAXQProUb4cspl1ikg7lugtICXLXq5G7O7+4xj0NMuJQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(366004)(376002)(346002)(39860400002)(71200400001)(4326008)(2906002)(9686003)(55016002)(53546011)(6506007)(33656002)(83380400001)(8676002)(52536014)(478600001)(110136005)(44832011)(54906003)(316002)(26005)(186003)(8936002)(86362001)(7696005)(66446008)(76116006)(66476007)(66556008)(5660300002)(66946007)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?QURNV1FEV3B2NWJ0RGpNc2plb2JsQU5aWXlqb3hUSnNQZWt0dGc4eTRUNWt0?=
 =?utf-8?B?bGduSXFKVHo5bElkT2czelpiMUs3RytQTkplTVNvYzZyWmw4dmg4RWJ1VVEr?=
 =?utf-8?B?L0s4TmV2a1k0RTh6RGZHb3Y0cHpueDV2bzRUVTkyc3laRzF2QzRCMkh6MGtQ?=
 =?utf-8?B?OFU2M2xPMDVvWTNSN3JXaUZ4SWFaNTBMWmlJbjlMWmJrV0xkcDdqNjVYRkV2?=
 =?utf-8?B?M1NaZkF5ZWpIS25JcG42dmx4Qm9ySmxYemRpbEZGVEkrSXpON2lBQ2g4WkIv?=
 =?utf-8?B?bzdQSkpmN0hIenBFWjEzRlVBTUVBNGhXdW4yL3ZYTHViSVRGbFduUEhIaklX?=
 =?utf-8?B?QjlsT2FoRk41Z2VEM2dnUmlJd3BjMlp4OWkwTytnck8yMUQ0NWh3bFdUbTdw?=
 =?utf-8?B?Yms5dWNKTldYSXRxWDJuL01ZY2JLaTlKczdnbzhLVjBDY1hjQUFlQnFXalc2?=
 =?utf-8?B?Sjh1SDA0K3UvV0lTeDlVelpkK2FwTDNjV1Nqa09wMENKWTNjcitZNHNMSDda?=
 =?utf-8?B?eTJsUXdmK1RJM1dGaVJJMkl1TXNaUk1sYmRvWmtsK2tiNjlWendTSDB1QVlO?=
 =?utf-8?B?MGJYK0NYd21CemtNZjdQK3dLRGN4QnpHekRrdHBZcEdJQWM0N3hCbW8wWUNt?=
 =?utf-8?B?Z3BlZTZuM0VrVnYyTEdjSk13SFdZWWowMkVudkN2RnNGd3greUJEbEVvVnhP?=
 =?utf-8?B?NFRnaEpJalhYb2xpVkhBNVVUeFhZbGR4ajVkVFJJNzFFSjZHTkNWcnlsUi8r?=
 =?utf-8?B?aVpwYTlJOHphNkRZR1gxb0pnV3JjSGZVYlJ0b0F0dHUvdW1TVHdMMW1KMXNI?=
 =?utf-8?B?cmpHcGxuTURKNUtmckdSVFZ0RVhlOWJiamh6bkFKUWxUeEhpRGlYamFGZUNn?=
 =?utf-8?B?c2Q4UjUvaTFRcDVlZ1k4S3NEZlJqU0F5cW9iNjV1NlFGN3hjK0JaMUFES3RE?=
 =?utf-8?B?MjhoeEM0OFdBM1FDR1M3dXVnV01uSzA1RGZlazhNZGdGZkxydHFuWkZRUWRK?=
 =?utf-8?B?YnY0VTl5VFpqK1B6QlRYNUl5ZXRvcEg5MnVwR0NmdkJjVEEwWU9GS1ZIS3lm?=
 =?utf-8?B?OGttMGhZellaU3JYb1dVY3hkaW9idWxMNjRualpQWktsQXNwVlRRN3FWRmdU?=
 =?utf-8?B?UmtKSEJ6Q2VLUnhHQzQvMHVVbFR1V1NBM0lrMG9oa1ZNZDFndHlwMm15L2N4?=
 =?utf-8?B?OTViQXlDT2MyT0EwVUxJbWV2UXNCZUdOUTI0UkhKaEdGSlVBcFhkeUJoeEcw?=
 =?utf-8?B?eUFMdndiZ2NyNlNBSXJuS2h6WkRrVk1RRUhoRGxXOTRWMm5pNVRWYTNQczJ2?=
 =?utf-8?Q?MSky9YSCtfiEw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4966.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7816b185-2263-4d98-5e3b-08d8bb6aaf28
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2021 04:36:55.2161
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 82B6f55FJjejlF2eVcTgTm1MYJrMx3gPEAXtxSLRLXpnPr+mfQAIy2ACysViBCQgqY7YJ6F55fZ0FdjQIFVmVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3557
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBSYW5keSBEdW5sYXAgPHJkdW5sYXBAaW5mcmFkZWFkLm9yZz4NCj4gU2VudDogU2F0
dXJkYXksIEphbnVhcnkgMTYsIDIwMjEgMTE6MzMgQU0NCj4gU3ViamVjdDogW1BBVENIXSBpbXg6
IHNlbGVjdCBTT0NfQlVTIHRvIGZpeCBmaXJtd2FyZSBidWlsZA0KDQpQYXRjaCB0aXRsZSBwcm9i
YWJseSBpcyBiZXR0ZXIgdG8gYmU6DQpmaXJtd2FyZTogaW14OiB4eHh4eA0KDQpPdGhlcndpc2U6
DQpSZXZpZXdlZC1ieTogRG9uZyBBaXNoZW5nIDxhaXNoZW5nLmRvbmdAbnhwLmNvbT4NCg0KUmVn
YXJkcw0KQWlzaGVuZw0KDQo+IA0KPiBGaXggYnVpbGQgZXJyb3IgaW4gZmlybXdhcmUvaW14LyBz
ZWxlY3RpbmcgU09DX0JVUy4NCj4gDQo+IHJpc2N2MzItbGludXgtbGQ6IGRyaXZlcnMvZmlybXdh
cmUvaW14L2lteC1zY3Utc29jLm86IGluIGZ1bmN0aW9uIGAuTDknOg0KPiBpbXgtc2N1LXNvYy5j
OigudGV4dCsweDFiMCk6IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8gYHNvY19kZXZpY2VfcmVnaXN0
ZXInDQo+IA0KPiBGaXhlczogZWRiZWUwOTVmYWZiICgiZmlybXdhcmU6IGlteDogYWRkIFNDVSBm
aXJtd2FyZSBkcml2ZXIgc3VwcG9ydCIpDQo+IFNpZ25lZC1vZmYtYnk6IFJhbmR5IER1bmxhcCA8
cmR1bmxhcEBpbmZyYWRlYWQub3JnPg0KPiBSZXBvcnRlZC1ieToga2VybmVsIHRlc3Qgcm9ib3Qg
PGxrcEBpbnRlbC5jb20+DQo+IENjOiBBdGlzaCBQYXRyYSA8YXRpc2gucGF0cmFAd2RjLmNvbT4N
Cj4gQ2M6IFBhbG1lciBEYWJiZWx0IDxwYWxtZXJkYWJiZWx0QGdvb2dsZS5jb20+DQo+IENjOiBB
cmQgQmllc2hldXZlbCA8YXJkYkBrZXJuZWwub3JnPg0KPiBDYzogQW5zb24gSHVhbmcgPEFuc29u
Lkh1YW5nQG54cC5jb20+DQo+IENjOiBEYW5pZWwgQmFsdXRhIDxkYW5pZWwuYmFsdXRhQG54cC5j
b20+DQo+IENjOiBTaGF3biBHdW8gPHNoYXduZ3VvQGtlcm5lbC5vcmc+DQo+IENjOiBEb25nIEFp
c2hlbmcgPGFpc2hlbmcuZG9uZ0BueHAuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvZmlybXdhcmUv
aW14L0tjb25maWcgfCAgICAxICsNCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0K
PiANCj4gLS0tIGxpbnV4LW5leHQtMjAyMTAxMTUub3JpZy9kcml2ZXJzL2Zpcm13YXJlL2lteC9L
Y29uZmlnDQo+ICsrKyBsaW51eC1uZXh0LTIwMjEwMTE1L2RyaXZlcnMvZmlybXdhcmUvaW14L0tj
b25maWcNCj4gQEAgLTEzLDYgKzEzLDcgQEAgY29uZmlnIElNWF9EU1ANCj4gIGNvbmZpZyBJTVhf
U0NVDQo+ICAJYm9vbCAiSU1YIFNDVSBQcm90b2NvbCBkcml2ZXIiDQo+ICAJZGVwZW5kcyBvbiBJ
TVhfTUJPWA0KPiArCXNlbGVjdCBTT0NfQlVTDQo+ICAJaGVscA0KPiAgCSAgVGhlIFN5c3RlbSBD
b250cm9sbGVyIEZpcm13YXJlIChTQ0ZXKSBpcyBhIGxvdy1sZXZlbCBzeXN0ZW0gZnVuY3Rpb24N
Cj4gIAkgIHdoaWNoIHJ1bnMgb24gYSBkZWRpY2F0ZWQgQ29ydGV4LU0gY29yZSB0byBwcm92aWRl
IHBvd2VyLCBjbG9jaywgYW5kDQo=

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA6DD2F564E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 02:57:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbhANBp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 20:45:29 -0500
Received: from mail-vi1eur05on2056.outbound.protection.outlook.com ([40.107.21.56]:49600
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725870AbhANBFB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 20:05:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JUbX5R7czu5Hde0zv/L3gvGNubBXEk7hfWMb0DVQ34YMuS+WRoMfOnoKJo+2yuIFGvtF9KK6xVZh1bqtxsmMVvP0n56+BKP5us84m1ZN22XgvO4rHp3/2YguHioLtEHwss1nu61dsMkPz7XjeJTIzSyvKhM929OQig8srcr/SAlqbaV6YxFE9U5MNbH8AH6UIgAeCAxx3olF1QLyl9lYnwiWckcQ9VCL26R7Mq8XUyort13SwR+CRDjGnnPi3zu5q29/1PlS9LisahUqXaEWLkWIJuKvsYqk7cyFaSsI4FXwWV3mOJ5zOnTWI6N4BvInJ1R0empTRHruSXZpL1pT5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SM77lHLtSIUTaa5DacUo3iNCShCuMgU2Vs7NDQRbbPE=;
 b=gEHxw93wx6tMYRU9yz1VVVbntlv5rhfXb0V0Ps0vbdLFJOud8A7bWVbORFtaCl7sRJaf0VI+NcGPDbMcnkJe1iGHYgDJ1pawCuRIFoUnaqH6tCf3c+A8oePHi8mxGUAHiLj8bzfOKpB5s5CamGNnpnPzNboVWKXRr0zjDU7Z/MuCakRojiRqloanz1f4AZe1J8Gttp6CM7Wy2xljuPfuRBgbD06HSOPtDPDhV0jADQDUqMJiz5Qhp4uFT7JZvFPqyQFfS9iJWzEr2sYz8yqSTFSIcw59Gb+z/kFkarYhFBN8fsX+f/CKNkLtqccafzdIT7scF1nFuwDkRkEuhZHkXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SM77lHLtSIUTaa5DacUo3iNCShCuMgU2Vs7NDQRbbPE=;
 b=s/5GeX6d/bEBQExrbD+F9vVrHQp1i1/NfbrUwfFILhf5BLtsIM11yqrmsL3rsKO3N2t9B1pKp1ar5dJh8gAXGjO5Bcy3ISFYZv5QKqgEWi3uJ5WEAbcGNPAk5BYSg+Qx/Hfe0Xexj429fuN6eMlEKCwyyonb/e2z5U8lhiL5VHg=
Received: from DBBPR04MB7979.eurprd04.prod.outlook.com (2603:10a6:10:1ec::9)
 by DB7PR04MB4091.eurprd04.prod.outlook.com (2603:10a6:5:1e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9; Thu, 14 Jan
 2021 01:04:00 +0000
Received: from DBBPR04MB7979.eurprd04.prod.outlook.com
 ([fe80::89de:bd7c:7245:f139]) by DBBPR04MB7979.eurprd04.prod.outlook.com
 ([fe80::89de:bd7c:7245:f139%5]) with mapi id 15.20.3763.010; Thu, 14 Jan 2021
 01:04:00 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Pawel Laszczak <pawell@cadence.com>
CC:     "a-govindraju@ti.com" <a-govindraju@ti.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kurahul@cadence.com" <kurahul@cadence.com>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>
Subject: RE: [PATCH v2] usb: cdnsp: fixes undefined reference to cdns_remove
Thread-Topic: [PATCH v2] usb: cdnsp: fixes undefined reference to cdns_remove
Thread-Index: AQHW6baGevlp5hAHpkeSW8oX2fUV9aol1kwAgAB4ZZA=
Date:   Thu, 14 Jan 2021 01:04:00 +0000
Message-ID: <DBBPR04MB7979E99D1DC593758ABD2C8F8BA80@DBBPR04MB7979.eurprd04.prod.outlook.com>
References: <20210113141407.25473-1-pawell@cadence.com>
 <13f338f1-9ba9-c848-0b75-10e73e8c6a7d@infradead.org>
In-Reply-To: <13f338f1-9ba9-c848-0b75-10e73e8c6a7d@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 16d936a8-2884-4b75-e9fd-08d8b828471c
x-ms-traffictypediagnostic: DB7PR04MB4091:
x-microsoft-antispam-prvs: <DB7PR04MB4091DE5536831FA2944DA6558BA80@DB7PR04MB4091.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FmsdlADrNzu8r/lckjwmmNGbPQQptLJjj8S7Oq9pTiNedq/c6plJxpJASbe4C/0Q3lBrUHTSnGNxPKpLLAVBaKabJ36/uIXnYEpjojTpswlPXzLhPTcyCalKdEl+wuf3xTgsqL5VITggSAuW7HaRXurViqxktma5aG1LH6QnVm16w3njv0RfJlLvgBtD0r+xc/yXsDo1RmVrTKS/77ytfc7Qpy3YAbP4+q1VbpacY3kYCCyrDsSyjMfKTRw2aAaeOfZw3FbxjoUgumXVn/KbKf1UpW64scM7kQaAoVa88cVJCm1s+VLHwSSx24Tiv++U6pqN8oJPGEDioRUAyQFeVsEtxXpnCVgV0PUpkHR3ZR/5Sewt7h2et17pCIxQDT312KEPunn8xepSnHlc2dmouA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7979.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(366004)(136003)(346002)(39860400002)(66476007)(8676002)(52536014)(83380400001)(33656002)(9686003)(478600001)(66556008)(64756008)(26005)(6506007)(8936002)(110136005)(2906002)(86362001)(7696005)(54906003)(4326008)(316002)(71200400001)(5660300002)(186003)(76116006)(66946007)(66446008)(44832011)(55016002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?TUJlb0hKaS9mNkRVS25pbWNNWEcyN3BaL0RRV0VFSjg2bk5wM09COTRQTmdM?=
 =?utf-8?B?dzFZWHJ5Q3J5ZXIreSt3a0VyRHdtdStpNDFESlkxV3hMVFlYclRhTWhSWktm?=
 =?utf-8?B?WTVDOFlzbVpNTkZhUFhYZmp5TGVjQkFmSGxQc3ZBMjVMSU5MeTcyaVpZZ0ln?=
 =?utf-8?B?R1BEbkkyWnJ6SFo1dDZhUUNTY2pWdDZlVHJmUjlOZW11U056UGUzaHM0Sm15?=
 =?utf-8?B?NjRaeVpTb3c3VmVGRWhCMTNpdEVTd1ZLMDU4aDRwVkJLeEhGdGp1WGl6OFNu?=
 =?utf-8?B?YXZVdjBVY1FZdkUrN1hqUDlvMjExMUtQV1p3NTN2bzN1NDVRc245djlBeUZS?=
 =?utf-8?B?cVoyWXE2dnlWVlhyWk9KYlM1eEczWCt1bVd5QkwzQXpHa2xmdHlIK3MvdWZX?=
 =?utf-8?B?eEdlSkxiWWg2V0IxVUU4MFFzTitRRDFEaVpiOU56cGd3L3BGL3A4KzJHRjdx?=
 =?utf-8?B?Mkt6aTR5ckEvODZkWXdjeDRYUjdNZDkrRHZ1VnZPOFFQWXRTRUZzeFV2TVFi?=
 =?utf-8?B?S0xlSzdtMkJkcmlodmNQSFRIbCtpZis3YkpqVWZiaE45aTZyVE9kenJhdVUv?=
 =?utf-8?B?Vnl4NHM1a1BOM3R4ZEVuTmIvZ3psemdCTzVNZ1BvU3NWemh2V0dFYitQNkQz?=
 =?utf-8?B?MUNVR0FZNFhYbko4eldkbHdSY3grMmFOZHQyd01tL1Y0cWRFU1pGQmpKbVh5?=
 =?utf-8?B?djBxdFI5azJRcWRIMGpqNFd6azJ4NEhLcDUvSnE5M1lYT256K1U5aW1IWUhY?=
 =?utf-8?B?K0ZISXcrM29ZNG9wcVNRMko0SE1kSXRKUXBxcThzNktWbEVKYVRPWUFHTDhC?=
 =?utf-8?B?Qi9UUlFkTVpXRGxBSW9JYm1DZnJJV3pYb2pwcjhYRnBKZDhNZlROV3ZLSjJR?=
 =?utf-8?B?TlJTeVpTRmZEcUJTUnhqclNpY2o1SUFHcEpXTW9GNVlaRk5qeXVlRjJMMDFK?=
 =?utf-8?B?cGFEQzlONkhrT3Nwd0tvZHJ0Qi94dXQ0SW9RY3RmOVdGb3d5cGFlS2tscFpG?=
 =?utf-8?B?d3ZZS1hsbFdVMUVITnRRLzRpZzF0RWpJemhXOW5JYkI4OEROQ25ESGlJS0dp?=
 =?utf-8?B?YjRKVmFTNWJGeGNCcHNaNnE5Snp0NlJNSzgweGYvdFNVQnVmMnNuU1FrbGNs?=
 =?utf-8?B?a2MyLzFtU2hqV0VhL0VPeUdMYXFLLzVCSHRTQ015MHAxTHlSbWJuQVErMnNu?=
 =?utf-8?B?Tm95ekJFVExzVFN4MFgyL3BzNW8xeXpGVm9VMVVuRmY1TTBvOGRMd3BrcTB1?=
 =?utf-8?B?WmFvZTBRTlo1bjlSMktYRTJoRjQ0VEVpM2x5amNUQXhiL3gvWHBEckdJcmdl?=
 =?utf-8?Q?cJ23egQiFI6/0=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7979.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16d936a8-2884-4b75-e9fd-08d8b828471c
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2021 01:04:00.3139
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ekJqTkAVcTrjFQ1m8g4JrJSn1IwsrvaJuPkCbvJHE/dJ6XygUjof2Vur8fbiryN3P7Id4Y13iRkKsZaQlumcDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4091
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IA0KPiA+DQo+ID4gSXNzdWUgb2NjdXJzIGZvciBVU0IvQ0ROUzMvQ0ROU1Aga2VybmVsIGNvbmZp
Z3VyYXRpb246DQo+ID4gQ09ORklHX1VTQj1tDQo+ID4gQ09ORklHX1VTQl9DRE5TX1NVUFBPUlQ9
eQ0KPiA+IENPTkZJR19VU0JfQ0ROUzM9bQ0KPiA+IENPTkZJR19VU0JfQ0ROUzNfUENJX1dSQVA9
bQ0KPiA+IENPTkZJR19VU0JfQ0ROU1BfUENJPXkNCj4gPg0KPiA+IFJlcG9ydGVkLWJ5OiBSYW5k
eSBEdW5sYXAgPHJkdW5sYXBAaW5mcmFkZWFkLm9yZz4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBQYXdl
bCBMYXN6Y3phayA8cGF3ZWxsQGNhZGVuY2UuY29tPg0KPiANCj4gQWZ0ZXIgcmVtb3ZpbmcgdGhl
IHYxIHBhdGNoIGFuZCBhcHBseWluZyB0aGlzIG9uZSwgbXkgYnVpbGQgZXJyb3JzIGFyZSBnb25l
Lg0KPiBUaGFua3MuDQo+IA0KPiBBY2tlZC1ieTogUmFuZHkgRHVubGFwIDxyZHVubGFwQGluZnJh
ZGVhZC5vcmc+DQo+IA0KDQpGb3JjZSB1cGRhdGVkLCB0aGFua3MuDQoNClBldGVyDQoNCj4gPiAt
LS0NCj4gPiBjaGFuZ2Vsb2c6DQo+ID4gdjINCj4gPiAtIGFkZGVkIG1pc3NpbmcgY29uZGl0aW9u
DQo+ID4NCj4gPiAgZHJpdmVycy91c2IvY2RuczMvTWFrZWZpbGUgfCA4ICsrKysrKysrDQo+ID4g
IDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL3VzYi9jZG5zMy9NYWtlZmlsZSBiL2RyaXZlcnMvdXNiL2NkbnMzL01ha2VmaWxlDQo+
ID4gaW5kZXggM2Y5YjdmYThhNTk0Li42MWVkYjJmODkyNzYgMTAwNjQ0DQo+ID4gLS0tIGEvZHJp
dmVycy91c2IvY2RuczMvTWFrZWZpbGUNCj4gPiArKysgYi9kcml2ZXJzL3VzYi9jZG5zMy9NYWtl
ZmlsZQ0KPiA+IEBAIC0yNiw3ICsyNiwxNSBAQCBvYmotJChDT05GSUdfVVNCX0NETlMzX1RJKQkJ
CSs9DQo+IGNkbnMzLXRpLm8NCj4gPiAgb2JqLSQoQ09ORklHX1VTQl9DRE5TM19JTVgpCQkJKz0g
Y2RuczMtaW14Lm8NCj4gPg0KPiA+ICBjZG5zcC11ZGMtcGNpLXkJCQkJCTo9IGNkbnNwLXBjaS5v
DQo+ID4gKw0KPiA+ICtpZmRlZiBDT05GSUdfVVNCX0NETlNQX1BDSQ0KPiA+ICtpZmVxICgkKENP
TkZJR19VU0IpLG0pDQo+ID4gK29iai1tCQkJCQkJKz0gY2Ruc3AtdWRjLXBjaS5vDQo+ID4gK2Vs
c2UNCj4gPiAgb2JqLSQoQ09ORklHX1VTQl9DRE5TUF9QQ0kpIAkJCSs9IGNkbnNwLXVkYy1wY2ku
bw0KPiA+ICtlbmRpZg0KPiA+ICtlbmRpZg0KPiA+ICsNCj4gPiAgY2Ruc3AtdWRjLXBjaS0kKENP
TkZJR19VU0JfQ0ROU1BfR0FER0VUKQkrPSBjZG5zcC1yaW5nLm8NCj4gY2Ruc3AtZ2FkZ2V0Lm8g
XA0KPiA+ICAJCQkJCQkgICBjZG5zcC1tZW0ubyBjZG5zcC1lcDAubw0KPiA+DQo+ID4NCj4gDQo+
IA0KPiAtLQ0KPiB+UmFuZHkNCj4gWW91IGNhbid0IGRvIGFueXRoaW5nIHdpdGhvdXQgaGF2aW5n
IHRvIGRvIHNvbWV0aGluZyBlbHNlIGZpcnN0Lg0KPiAtLSBCZWxlZmFudCdzIExhdw0K

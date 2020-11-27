Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E42CA2C615B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 10:09:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbgK0JHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 04:07:41 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:52749 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726361AbgK0JHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 04:07:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1606468057; x=1638004057;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=KUnDNtMkhIej+pQvuCNNrp1cC5Fs77jO3/ywMb+JDkY=;
  b=ns/2LE9BtpmjnOqKYUzzODgP7pwt9X0WuvhtCb2rHKNLDcAPOKFS8uBS
   +azksBkse3M80bJEKDqNH5C87vscubNOZVXvsj3JZGAYN6G/QPNIlbX9z
   HN00Zna1ahDr6SUYWXh4FyquKwZsBJvLugXGLy3C4v3bSrktfkyFn8YAg
   dtdZ1x2Kv5d3R6szv+SM6mvb11XeGMxcZkivlL2bkkjqQDtwLJlPvF8Z9
   +LdgAq0Jlz03Fe0gm1xGA5fgZV9blGm/7kX4LhMxmRx9A/qMiezMFBK2k
   z7Mg0rC5d79DtEtko6Ex0uMd1j2ruvxhNmO5LR9rDMe3tkfo7g1RZvIhW
   Q==;
IronPort-SDR: qDXj8e4uI47FzfwrTZhYS0C5Hp/qG0xhSaEqOqPYm/vxds57HgCzBkdKODeKISj8bPyyNrhL1h
 LPF8SW/1Zw7EFg+NYyH9Ugmfob+vkBqEaUGSLFUri0i4Ycz8L7/W8YSTKDEgCgMbycBFjft/mo
 RZiwA3kH+wwbpQJi1J8NSsG1beOZXsQIgXS4w6ZxtidAoWSNM7wdBzvu6RrZ7puMfHDfbYS8bs
 OGjRKVFgi9dBA5ywnH3CECfD5i6Fgsk7VaT7RtNdSn1pVWEcJL86ElScmfk9nqBd0V8UPGONSh
 w+E=
X-IronPort-AV: E=Sophos;i="5.78,373,1599548400"; 
   d="scan'208";a="100577908"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Nov 2020 02:07:37 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 27 Nov 2020 02:07:36 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Fri, 27 Nov 2020 02:07:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mCIYYSztmQSlTtbZbH6+u+41WOqqJWqWjMdlpjyIlypy3k1JbJl9TNOAPHhMJeFot0W3oP2xxdoK6859A0/l1QRoLyEG7cKZ+1BIOLInC1s7HJzu8vL4/Seat7wXwvHOHq3QcWe2+pzheInMndqAqRfvJldHul/8M3UiRM9gbw+B0Y1uUrO02wDZ3VWj2oHtJqahmWOV5u1GNeD8XfeicX4JjT4guJgBYtpZXcvc2az70ET9rEF0Y9yqkIa15DK8lu7qhkyD2cBgPK6R3kZxTIHHyUR53R1Gg/GRWi737kTebiB5ptRr4C7Wz3SYRoxodGfi7NJhvZJARt2uqkETXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KUnDNtMkhIej+pQvuCNNrp1cC5Fs77jO3/ywMb+JDkY=;
 b=DsbxkhsYCYr+PJB5C8ypINajVeU+LqzRWmb9EIVmEsQu0gMmYgC57izLShsQRFM/WdjQEiTj2Zk2JDeSpf3bAm2kzS9kQsO8Cj+tcOYisLtPh91S1JsrYspbR7OHfWfay8QyLSBziGFAHO/9/qQoLhnIiI+fzviD+bRJ8Sxvz/jhLoLQ3z2V6S9+uxftH3mdOU3eILhNLHurTJinNMSw9FfRfiQCLkmydXiyTkCK2JJHr0aFbwB1NcW6NKvlEylg03gJXrgcDEiEUzpuDkmkeJbdICjsVDNfNazqvdf1V4FTkX8DG8R7sfqNwdJyUfctkoUTSUDVanWiHdBKF/7CMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KUnDNtMkhIej+pQvuCNNrp1cC5Fs77jO3/ywMb+JDkY=;
 b=MJWiHxPzr8BBEZTRgWBJObJFzBYgGLOLbvSuwhXDrLXbz7iXY2wwVSzc7FcFHlJjsgj4ANfuUTDQUPsnErmxas7XxQ+4z5DG8HlKriaa0jUSd5iXjyZ8kpET+cQOaLhd4GG5tMQFGOTfLBC0bjxKi56yy/0btnhv4oIhkqG0fPU=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by SN6PR11MB2621.namprd11.prod.outlook.com (2603:10b6:805:59::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25; Fri, 27 Nov
 2020 09:07:35 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::6903:3212:cc9e:761]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::6903:3212:cc9e:761%7]) with mapi id 15.20.3611.021; Fri, 27 Nov 2020
 09:07:35 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <michael@walle.cc>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <boris.brezillon@collabora.com>
Subject: Re: [PATCH v6 3/5] mtd: spi-nor: intel: remove global protection flag
Thread-Topic: [PATCH v6 3/5] mtd: spi-nor: intel: remove global protection
 flag
Thread-Index: AQHWxJy+3BSTSEli/0yZTXTsyojwLQ==
Date:   Fri, 27 Nov 2020 09:07:35 +0000
Message-ID: <8c908200-9350-ec54-d301-e95c7eedeb0b@microchip.com>
References: <20201126202614.5710-1-michael@walle.cc>
 <20201126202614.5710-4-michael@walle.cc>
In-Reply-To: <20201126202614.5710-4-michael@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: walle.cc; dkim=none (message not signed)
 header.d=none;walle.cc; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [79.115.63.172]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 50666787-cd63-44c7-901e-08d892b3e1ca
x-ms-traffictypediagnostic: SN6PR11MB2621:
x-microsoft-antispam-prvs: <SN6PR11MB2621798FA835BF6CEEE24983F0F80@SN6PR11MB2621.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QxQSCh6xLZg7JGOQ7Oh3wG3uI2FTHSx1A0Auv2gqi/RdInBntM5hOvJEhjW6jrxM835qOgHIYBVk5GCZJVWF3fQZDqkr5NNTZ4yuhEpFoa/3l4lRVvWVjfrErBL0JvOa7U8+h2R7T0ms9WteZyzCgPJvzx8A2J549SooUorJF0rwfRfufwijbQ4BhF/X/4eh31p1Nwur3jPBstnGXxlK1N9awu+sZhByh8ndysoiDhp3oPZFRWsoBRlp8DdwkrLvJW69WiXua75IqQyuG71BLAbrA3htxCqIwMfjd44tsNb595OqR8EdNkxntP8Y8zj3h/JovlqyLuvdkH1Ewj4EhBATejIEKeG5rePVMz/VSP5n7KtKfsT/CFN+FbLDVvw9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(136003)(376002)(396003)(346002)(4326008)(76116006)(2616005)(66446008)(64756008)(66556008)(66476007)(71200400001)(66946007)(186003)(36756003)(83380400001)(316002)(31686004)(478600001)(53546011)(8676002)(110136005)(54906003)(5660300002)(86362001)(6486002)(2906002)(6506007)(26005)(31696002)(6512007)(8936002)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?MTI2dFlkUGlYNkxESjN1N2RPQXp4Q0tyU2hZMWlMbGFZOTBaSklPR0xGN1Vp?=
 =?utf-8?B?bTFabUZ1djZnMWNUendZaFJZbjBzL0xsWmpselROMmlvSndGR3MyUTdySmpW?=
 =?utf-8?B?N1hwcEdERGdldlVLcUtxVDRxUGJlYWFrdnZqYndBWFVpSFhjOG9TT2kyb0N0?=
 =?utf-8?B?NnVjcUowK0xMOEVPZnB6czJxczJCMFVyY3ppajNWUHNCcnNxaTFmc01FWG9u?=
 =?utf-8?B?Z0llK1NZeWJsZ29xZVIrZmFMWUx4TFRwR2pzcm1CNHl4THhXdmpkT2RqdXNI?=
 =?utf-8?B?SjlVUHQ1VEZRa2R0REU0Qk01NEFQeGtGZ1J2dk5LdjlQdEphbnY3QUwyQ0NG?=
 =?utf-8?B?MW81UWxsdlFHYTZuMEh4ZnZHRXIxcDFaQkZUMW1tYnBNVWt2ZWI1dVVJL1Vh?=
 =?utf-8?B?UEJkSGhHYm1KN0JaZE1zdW5tMXpWdjY0UVZhQktkVjdkY09rU2hHbHkxVStM?=
 =?utf-8?B?ZlRDYnpuUnZJNDlUZC9MT3ZOTlZwYnpZaStFREcvNTk3U1BPcENTMzVtN1pU?=
 =?utf-8?B?WnlYWWhwQVNZcWJVV0E4RkIyUG5vSGIzNlFYdzhPUXVSc3hucXg3NnFtYkR0?=
 =?utf-8?B?S1QrUTlVOFZUU0RaZkRyaEwvd0JxUTBsQ2VYM3B4bm54bGNtU2hSb2gzUDlF?=
 =?utf-8?B?UGRuZDBTUktSdTc2R0o1VlkxRGVLVVJFeDB6WUJPZFYybWgwSWY4WElsU1p1?=
 =?utf-8?B?V2syQzZ5aVFuV0RwUkV5TU9idFp6UFZHdzl0UkhRQmNlL2xib3JQcDVMZEx0?=
 =?utf-8?B?NGFEVzMxTExvRU15RW03Y0E0R05GdGQwcTlWZFZMZ01PMkJ3dUtDaTEyUnNM?=
 =?utf-8?B?TkJTRlU0WHRUQTZoN2drSG1rTldpKzF4cVA3cUQ4bERqa282K2pRUE5QcEN6?=
 =?utf-8?B?N1BacjhJOUk1SjI0OXR3aVdjUitROEJZeThJaTV2RVhVbjhXWmo0NmQvdEFJ?=
 =?utf-8?B?bDU1S1lURFA5RlNiMEsvWXRzNkVqekhvMUpCRWplcjlhOXI5aXBLd2h2UERn?=
 =?utf-8?B?MzYvaWY0d1BTc29yQy8xd3BKT0RlcFdDcVVpa0FzeXRmbXE5cm5CK1RWQzha?=
 =?utf-8?B?d2doWG0vN1NySXNxZGduR1JQTXpqdThGYzJXeWlhUGNKTER6SWxDYktuTEQ1?=
 =?utf-8?B?czhsNFN5R0pkN0xKR25uTllLNjg0cC8rVDdVbG4xM1Jnb3IycmlnOWR6aThx?=
 =?utf-8?B?YldQcEwzYjJFWVVrOUV4SE85dllIdlpVZFlsdUY3MWVkWEJwSTJTTzdYVHVE?=
 =?utf-8?B?dks4SDhJZGo2Yi8vbXgrOVU0Vm93L29Dd05zdU41d0ZnN1hRUURQQVpXek9O?=
 =?utf-8?Q?vukjTpFYdStVI=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <F3C66649618331459C31AD5E8009A487@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50666787-cd63-44c7-901e-08d892b3e1ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2020 09:07:35.6371
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: InDWsyhZknkBahBU1TS3g8LJUeUtSXEr2rBmheH/DJ7lMTwJg8e49TMZGC2VeUMvU6iC48JAg+rjr5BDjJuL5XmmrST0PqxffJobvUQzlEc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2621
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTEvMjYvMjAgMTA6MjYgUE0sIE1pY2hhZWwgV2FsbGUgd3JvdGU6DQo+IEVYVEVSTkFMIEVN
QUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtu
b3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gRm9yIHRoZSBBdG1lbCBhbmQgU1NUIHBhcnRz
IHRoaXMgZmxhZyB3YXMgYWxyZWFkeSBtb3ZlZCB0byBpbmRpdmlkdWFsDQo+IGZsYXNoIHBhcnRz
IGJlY2F1c2UgaXQgaXMgY29uc2lkZXJlZCBiYWQgZXNwLiBiZWNhdXNlIG5ld2VyIGZsYXNoIGNo
aXBzDQo+IHdpbGwgYXV0b21hdGljYWxseSBpbmhlcml0IHRoZSAiaGFzIGxvY2tpbmciIHN1cHBv
cnQuIFdoaWxlIHRoaXMgd29uJ3QNCj4gbGlrZWx5IGJlIHRoZSBjYXNlIGZvciB0aGUgSW50ZWwg
cGFydHMsIHdlIGRvIGl0IGZvciBjb25zaXN0ZW5jeQ0KPiByZWFzb25zLg0KPiANCj4gU2lnbmVk
LW9mZi1ieTogTWljaGFlbCBXYWxsZSA8bWljaGFlbEB3YWxsZS5jYz4NCg0KUmV2aWV3ZWQtYnk6
IFR1ZG9yIEFtYmFydXMgPHR1ZG9yLmFtYmFydXNAbWljcm9jaGlwLmNvbT4NCg0KPiAtLS0NCj4g
Y2hhbmdlcyBzaW5jZSB2NQ0KPiAgLSBuZXcgcGF0Y2gNCj4gDQo+ICBkcml2ZXJzL210ZC9zcGkt
bm9yL2ludGVsLmMgfCAxNiArKystLS0tLS0tLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMyBp
bnNlcnRpb25zKCspLCAxMyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L210ZC9zcGktbm9yL2ludGVsLmMgYi9kcml2ZXJzL210ZC9zcGktbm9yL2ludGVsLmMNCj4gaW5k
ZXggZDgxOTZmMTAxMzY4Li42YzMxYmVmM2ZjNjAgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbXRk
L3NwaS1ub3IvaW50ZWwuYw0KPiArKysgYi9kcml2ZXJzL210ZC9zcGktbm9yL2ludGVsLmMNCj4g
QEAgLTEwLDIzICsxMCwxMyBAQA0KPiANCj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZmxhc2hfaW5m
byBpbnRlbF9wYXJ0c1tdID0gew0KPiAgICAgICAgIC8qIEludGVsL051bW9ueXggLS0geHh4czMz
YiAqLw0KPiAtICAgICAgIHsgIjE2MHMzM2IiLCAgSU5GTygweDg5ODkxMSwgMCwgNjQgKiAxMDI0
LCAgMzIsIDApIH0sDQo+IC0gICAgICAgeyAiMzIwczMzYiIsICBJTkZPKDB4ODk4OTEyLCAwLCA2
NCAqIDEwMjQsICA2NCwgMCkgfSwNCj4gLSAgICAgICB7ICI2NDBzMzNiIiwgIElORk8oMHg4OTg5
MTMsIDAsIDY0ICogMTAyNCwgMTI4LCAwKSB9LA0KPiAtfTsNCj4gLQ0KPiAtc3RhdGljIHZvaWQg
aW50ZWxfZGVmYXVsdF9pbml0KHN0cnVjdCBzcGlfbm9yICpub3IpDQo+IC17DQo+IC0gICAgICAg
bm9yLT5mbGFncyB8PSBTTk9SX0ZfSEFTX0xPQ0s7DQo+IC19DQo+IC0NCj4gLXN0YXRpYyBjb25z
dCBzdHJ1Y3Qgc3BpX25vcl9maXh1cHMgaW50ZWxfZml4dXBzID0gew0KPiAtICAgICAgIC5kZWZh
dWx0X2luaXQgPSBpbnRlbF9kZWZhdWx0X2luaXQsDQo+ICsgICAgICAgeyAiMTYwczMzYiIsICBJ
TkZPKDB4ODk4OTExLCAwLCA2NCAqIDEwMjQsICAzMiwgU1BJX05PUl9IQVNfTE9DSykgfSwNCj4g
KyAgICAgICB7ICIzMjBzMzNiIiwgIElORk8oMHg4OTg5MTIsIDAsIDY0ICogMTAyNCwgIDY0LCBT
UElfTk9SX0hBU19MT0NLKSB9LA0KPiArICAgICAgIHsgIjY0MHMzM2IiLCAgSU5GTygweDg5ODkx
MywgMCwgNjQgKiAxMDI0LCAxMjgsIFNQSV9OT1JfSEFTX0xPQ0spIH0sDQo+ICB9Ow0KPiANCj4g
IGNvbnN0IHN0cnVjdCBzcGlfbm9yX21hbnVmYWN0dXJlciBzcGlfbm9yX2ludGVsID0gew0KPiAg
ICAgICAgIC5uYW1lID0gImludGVsIiwNCj4gICAgICAgICAucGFydHMgPSBpbnRlbF9wYXJ0cywN
Cj4gICAgICAgICAubnBhcnRzID0gQVJSQVlfU0laRShpbnRlbF9wYXJ0cyksDQo+IC0gICAgICAg
LmZpeHVwcyA9ICZpbnRlbF9maXh1cHMsDQo+ICB9Ow0KPiAtLQ0KPiAyLjIwLjENCj4gDQoNCg==

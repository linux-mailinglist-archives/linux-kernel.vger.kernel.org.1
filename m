Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 940CD2F1029
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 11:35:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729245AbhAKKdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 05:33:10 -0500
Received: from mail-db8eur05on2059.outbound.protection.outlook.com ([40.107.20.59]:54528
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729189AbhAKKdJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 05:33:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EaazVKR9J1awu7YseOO8H345G+Rfid/EE2WKs0VEtxtAXohg+fp3/IK/ot7CvU9riD7/deNMfSKW4RsHAcfj9ggUTRGEiyFvtlkvVt0Vhy3RVQjqH1skKracJ0NnnC0ODmA+hpFHhZx3EEzz0/ZTuTltXjBg23BKYECslbPdUYSRk7qMTz+QIqeq+R/7PM/mS6sNMCHKPM8dEBlPmUpeUJcwM7jdVOzzKD7uqavK0w0xGFVRBH22bXA1ElnYsi5IaImjYHu96X0mtbD2NG/MHxCO+AAU0srLraloG3Wl5YTU0Vxip+gx2FFfXAZmQymkwp1MCzSsIXqcMGZiZYGuWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9B9IKtmwFDL2/DRJOqWgkK1PtQXPtTbo0kKyN0sb3ss=;
 b=WYSbbX0kFPEx1IwXB4KWb7kbWFjirSve4ksO03OVxTiNht6bAhVofdM5SffgJKbPpKapirbBl6m+ZOxO3g6zqvDKPEv9RJFYl9vC8PCRQWHpmLptv0hyE1bQ8LuPvbA8fFcuOD22vZN33HrloQV1pPuO2HEmX2AYwUBZ4QHK2KLFeDvmPIAzTEqk4sBv17zz6aniNxqkTTnXWagh3uTObqfz8cfvHFe6iH0JscKqW3XwiWCGr2OGffPFwtRAe8w5UxxF+bd6D4F19MXk15wW69ZED1iab78/66DzXQHJNDT7o+CPetBXVy+q14ItLxkcfuTIHrxUoC5/hfiqxsl6AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductoreurope.onmicrosoft.com;
 s=selector1-rohmsemiconductoreurope-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9B9IKtmwFDL2/DRJOqWgkK1PtQXPtTbo0kKyN0sb3ss=;
 b=ZDGj3jPbmc1vA8ArKXjoXymVEnXuAERRkup3cDZFV+0O7RG3WuDyVdNvuWmba8qXcsqErLzZ6WTUUaJZvL6j9KqJsub9uUHYPvnQr26DQOdjVQOIBoI8+B8KiitXvTxfD3eFQPwMPbmBv1C22C1bWVS5kmnJ2mbu/e+0J3IYu0E=
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com (2603:10a6:7:55::20) by
 HE1PR03MB3161.eurprd03.prod.outlook.com (2603:10a6:7:57::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3742.12; Mon, 11 Jan 2021 10:32:18 +0000
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::6558:57bb:5293:f3d3]) by HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::6558:57bb:5293:f3d3%3]) with mapi id 15.20.3742.012; Mon, 11 Jan 2021
 10:32:18 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     "matthias.bgg@kernel.org" <matthias.bgg@kernel.org>,
        "mbrugger@suse.com" <mbrugger@suse.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "gene_chen@richtek.com" <gene_chen@richtek.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "chen.zhong@mediatek.com" <chen.zhong@mediatek.com>,
        "axel.lin@ingics.com" <axel.lin@ingics.com>,
        "hsin-hsiung.wang@mediatek.com" <hsin-hsiung.wang@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH v2 1/3] regulator: mt6360: Add OF match table
Thread-Topic: [PATCH v2 1/3] regulator: mt6360: Add OF match table
Thread-Index: AQHW5npBTwyRx0TReE2Qd5sH2ElaIqohsy6AgACDMQCAAAa4gA==
Date:   Mon, 11 Jan 2021 10:32:18 +0000
Message-ID: <ef659bcf62c9bfcf68359f21a9c9cd0093b9b969.camel@fi.rohmeurope.com>
References: <20210109112612.1221-1-matthias.bgg@kernel.org>
         <b358179732f940f883c12dd1276f855a@richtek.com>
         <8a5b2d7a-cd31-ecbb-bdc2-35c881c9068d@suse.com>
In-Reply-To: <8a5b2d7a-cd31-ecbb-bdc2-35c881c9068d@suse.com>
Reply-To: "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Accept-Language: fi-FI, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 (3.34.4-1.fc31) 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none
 header.from=fi.rohmeurope.com;
x-originating-ip: [62.78.225.252]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f0c4f649-84a4-4474-a8a8-08d8b61c2be1
x-ms-traffictypediagnostic: HE1PR03MB3161:
x-microsoft-antispam-prvs: <HE1PR03MB3161AAF0AB1D13E9B42C9CDAADAB0@HE1PR03MB3161.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zXistEdh99mQwz68PEqvHKRtpjYu1mOqY0H9iqba4z2wZf+I679HQq4omRRn5/QCx8gWIKi8Zsdi3DVrH15wm3MK0/m1wMT0XL36+qrIWYzLCHtGFmrabY/J9ut57N0KXxkSOIqwn+aISlICiWwPFJ5AMcYPYxi+w1XpyeB2Agm4aXMLVeRtqRw5Hxjz2IIvKYQeQB/AHl+e+u5uV+LPolAbtOBzshF3wfFt6co6E6l+zMI+Rv0YtAzs5zu2Zm01QbLThYfMlgyZzC17FtFAMUuf7ZKpeim3tQmdFtpQa1C19jYRqNgplM2uhR3ePJejL/Skx+0ICkKjR5bqUIAi3EJnlssCLId4KMGop+UcWs1zOxbT79fECDX54viPhXL5/Fg2l55C5TzYcVqneHU5OA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR03MB3162.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(376002)(396003)(136003)(39840400004)(478600001)(71200400001)(8936002)(3450700001)(4326008)(66946007)(6512007)(6506007)(64756008)(26005)(66476007)(53546011)(66446008)(83380400001)(186003)(2616005)(54906003)(6486002)(8676002)(66556008)(110136005)(76116006)(5660300002)(7416002)(316002)(86362001)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?T3psb040SHJIa1pVQTFqQWJwRHU3dG01RUpURFNWOXVFb2tuRXNRV3Btakhq?=
 =?utf-8?B?aDZIU3AyTlNMajh0U1g1K3BtWEhLV0UxWVN3WEw1bDVPYWh4bDN4a2ZnOVkr?=
 =?utf-8?B?eXRRQzdjNmtOSnVwenRjeXlOTGhMQ1dLVldDeCtVcktYcXJhYmVWYjlDcVJ1?=
 =?utf-8?B?VTVvMThEWUhjeDB5Zm5sOCt2RThkRjdaemJaOUpzUGFkWWpCL0ZzbWcwUkJ2?=
 =?utf-8?B?Szc0bjA0UXhPWEgwTFp2UElzVTFVYXNNUEwza2FHWmJWVHdqTHc3L05vVVpY?=
 =?utf-8?B?Y0RHV3Z2SkJCdkV2aFArUDdkMjlDWWZOK2MybStlUExMMk5VUHNFV2ZXY2hy?=
 =?utf-8?B?N05Sc1Z6VDNmU1MwNFZKSllkZGhabFFpY1YyOHVZSUFhN0x2Y092WUpYajV3?=
 =?utf-8?B?SzVkWDhFMnMrQlB1Q0FLWnU2UVZISS91djJtSGtkVjFRM2NtV3VMaURxZGdD?=
 =?utf-8?B?SktjNXdjMVV6cDEwQWgyL1RPRktsNmk5Qjc2OVNXd0RNZ2lscWM0cEpvQ3FH?=
 =?utf-8?B?TXpvRWw0bW01d055enA0azUyUHBpQW4wYklkTzJMa0ZVU0doTm5jUDU1Mm8z?=
 =?utf-8?B?aU14L3Z4MVE4SG8vaStsQVoySTVPakRqb1JCYjRKaUlZa0g3d1ZJWHhoQlVU?=
 =?utf-8?B?VHRCdlBqL3NLeWt3bEVhZUJIUGljZEMrM3BRM2M3U3pCSlB0QWlHQUtTSXc5?=
 =?utf-8?B?YWFiWkJPUk9kWEluMWplNFZuVEpqbmVsWHdVczVJdVJjbVptWFUyTkpWU1JS?=
 =?utf-8?B?Rk5INVdqMUpJQXBEMnhjaUU4cTFyQ1E3THB6K0NFYS9CL0tFV21vcXVNOXFD?=
 =?utf-8?B?ZjlvdmFXZTVqYTNZVHJlWmpoZ2tPQ2VJd2RhU1FKM3ZVRUJSbWcwemUzQWNp?=
 =?utf-8?B?S2V1OW1xTGg4RTNFLzl5YTMxajJMVEd4STZ2Mmc4MTFDNkozSWtQQk9KWTVs?=
 =?utf-8?B?dUY3aFg0cEN1U0N2VkE5VzlucDNiVzd1eDRkdmI0RStTVkdhWGdhdzlnaGFH?=
 =?utf-8?B?dUZKOE1rMlNjTm1hV1FZUG01MmZFdVNqLzZ3WktkSXlyZkhxSHgxcFhrM1FF?=
 =?utf-8?B?Q1pkZzV3dU41M01jTDVxcGxwZlRjS1A1NHhaVkdZeExSNUN2ZUlmeTNxODFx?=
 =?utf-8?B?RlhWcm5SQ294bGl6bk04SERwYlpPSWNhUWgzeEg5a3NvSVNrZzFFV1JDaHpo?=
 =?utf-8?B?M0tRL0FOQ1M4aXRUc1NNdDVZOHJiU1plcndmTW1sUWx3L2lMb2hQUjkyTHB4?=
 =?utf-8?B?RjFDdG1GZ1VLamZ2QzQ1STlzM2IvOFRQVTBRQTF1cldNYkV3Yk9MOGxCanJF?=
 =?utf-8?Q?qGCaGxH6rRNUGpQxEVZXNqR4R0qX69DBBm?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <66DDBEFD6BD4F84B9FA7C0453E7A3B3F@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR03MB3162.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0c4f649-84a4-4474-a8a8-08d8b61c2be1
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2021 10:32:18.2994
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 94f2c475-a538-4112-b5dd-63f17273d67a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PMoTafwU68hmbJdREmxHet9mmWrJ3LOgUzV3IJuuxoQ+zh7Zhcpbu9gsGEg+YLNe2KLm87nsTCR4CI8kUZyRr5aqKAm2F+c6Kb+s1iFJtPcQM/UQRXrXsDcXKJG0Qh98
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR03MB3161
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpIZWxsbyBNYXR0aGlhcyAmIEFsbCwNCg0KT24gTW9uLCAyMDIxLTAxLTExIGF0IDExOjA4ICsw
MTAwLCBNYXR0aGlhcyBCcnVnZ2VyIHdyb3RlOg0KPiANCj4gT24gMTEvMDEvMjAyMSAwMzoxOCwg
Z2VuZV9jaGVuKOmZs+S/iuWuhykgd3JvdGU6DQo+ID4gWyBJbnRlcm5hbCBVc2UgLSBFeHRlcm5h
bCBdDQo+ID4gDQo+IA0KPiBQbGVhc2UgZG9uJ3QgdG9wLXBvc3QgaW4gdGhlIGZ1dHVyZS4NCj4g
DQo+ID4gSGkgTWF0dGhpYXMsDQo+ID4gDQo+ID4gSSBkaXNjdXNzZWQgT0YgbWF0Y2ggdGFibGUg
d2l0aCBNYXJrIGluIHByZXZpb3VzIG1haWwgaW4gb3VyIFBBVENIDQo+ID4gdjMsDQo+ID4gTUZE
IHNob3VsZCBqdXN0IGluc3RhbnRpYXRlIHRoZSBwbGF0Zm9ybSBkZXZpY2UuDQo+IA0KPiBEaWQg
eW91IGV2ZXIgdGVzdCB0aGF0PyBXaGljaCBNRkQgZHJpdmVyIHNob3VsZCBpbnN0YW50aWF0ZSB0
aGUNCj4gZGV2aWNlPw0KPiBJIGhhZCBhIGxvb2sgYXQgbXQ2MzYwLWNvcmUuYyAodGhlIG9idmlv
dXMgb25lKSBidXQgSSBkb24ndCBzZWUgYW55DQo+IHJlZmVyZW5jZSB0bw0KPiB0aGUgcmVndWxh
dG9yIFsxXS4gV2hhdCBhbSBJIG1pc3Npbmc/DQo+IA0KPiA+ID4gTWFyayBCcm93biA8YnJvb25p
ZUBrZXJuZWwub3JnPiDmlrwgMjAyMOW5tDjmnIgyMOaXpSDpgLHlm5sg5LiL5Y2INzo0NeWvq+mB
k++8mg0KPiA+ID4gPiBUaGlzIGRldmljZSBvbmx5IGV4aXN0cyBpbiB0aGUgY29udGV4dCBvZiBh
IHNpbmdsZSBwYXJlbnQNCj4gPiA+ID4gZGV2aWNlLCB0aGVyZQ0KPiA+ID4gPiBzaG91bGQgYmUg
bm8gbmVlZCBmb3IgYSBjb21wYXRpYmxlIHN0cmluZyBoZXJlIC0gdGhpcyBpcyBqdXN0IGENCj4g
PiA+ID4gZGV0YWlsDQo+ID4gPiA+IG9mIGhvdyBMaW51eCBkb2VzIHRoaW5ncy4gIFRoZSBNRkQg
c2hvdWxkIGp1c3QgaW5zdG50aWF0ZSB0aGUNCj4gPiA+ID4gcGxhdGZvcm0NCj4gPiA+ID4gZGV2
aWNlLg0KPiA+ID4gVHJ5aW5nIHRvIGF1dG9sb2FkIG1vZHVsZSB3aXRob3V0IG9mX2lkX3RhYmxl
IHdpbGwgY2F1c2UgcnVuLXRpbWUgDQo+ID4gPiBlcnJvcjoNCj4gPiA+IHVldmVudGQ6IExvYWRX
aXRoQWxpYXNlcyB3YXMgdW5hYmxlIHRvIGxvYWQNCj4gPiA+IG9mOk5yZWd1bGF0b3JUKG51bGwp
Q21lZGlhdGVrLG10NjM2MC1yZWd1bGF0b3INCj4gPiANCj4gPiBZb3Ugc2hvdWxkbid0IGhhdmUg
dGhpcyBkZXNjcmliZWQgaW4gdGhlIGRldmljZSB0cmVlIGF0IGFsbCwgbGlrZSBJDQo+ID4gc2F5
DQo+ID4gdGhlIE1GRCBzaG91bGQganVzdCBpbnN0YW50aWF0ZSB0aGUgcGxhdGZvcm0gZGV2aWNl
Lg0KPiA+IA0KPiANCj4gV2VsbCBmcm9tIG15IHVuZGVyc3RhbmRpbmcgdGhlIHJlZ3VsYXRvciBo
YXMgYSBkZXZpY2UtdHJlZSBlbnRyeSBbMl0sDQo+IHNvIGl0DQo+IG5lZWRzIHRvIG1hdGNoIGFn
YWluc3QgYSBkZXZpY2UtdHJlZSBub2RlLiBNeSB1bmRlcnN0YW5kaW5nIGlzLCB0aGF0DQo+IHlv
dSBuZWVkIGENCj4gdGhlIGRldmljZXRyZWUgbm9kZSB0byBkZXNjcmliZSB0aGUgcmVndWxhdG9y
cyBwcm92aWRlZCBieSB0aGUNCj4gZGV2aWNlLiBUQkggSSdtIGENCj4gYml0IHB1enpsZWQgYWJv
dXQgdGhlIGNvbW1lbnQgZnJvbSBNYXJrIGhlcmUuIEhvdyBkb2VzIGFub3RoZXIgRFQNCj4gbm9k
ZSBiZSBhYmxlDQo+IHRvIHJlZmVyZW5jZSBhIHJlZ3VsYXRvciBpZiB0aGlzIGlzIG5vdCBkZXNj
cmliZWQgaW4gRFQ/IEkgdGhpbmsgd2UNCj4gbmVlZCBhIERUDQo+IG5vZGUgaGVyZSBhbmQgdGhl
IG1hdGNoaW5nIGluIHRoZSByZWd1bGF0b3IgYW5kIE1GRCBkcml2ZXIgdG8gZ2V0IHRoZQ0KPiBy
ZWd1bGF0b3INCj4gbG9hZGVkIHZpYSB1ZGV2Lg0KDQpPdGhlcnMgYXJlIGJldHRlciB0byBhbnN3
ZXIgLSBidXQgYXMgSSBzcG90dGVkIHRoaXMgZnJvbSBteSBpbmJveCBJJ2xsDQpnaXZlIG15IDIg
Y2VudHMgOikgDQoNClRoaXMgY2FuIGJlIGRvbmUgVy9PIHJlZ3VsYXRvcnMgaGF2aW5nIG93biBj
b21wYXRpYmxlLiBQbGVhc2Ugc2VlDQpmb2xsb3dpbmc6DQoNCmRyaXZlcnMvbWZkL3JvaG0tYmQ3
MTh4Ny5jDQpkcml2ZXJzL3JlZ3VsYXRvci9iZDcxOHg3LXJlZ3VsYXRvci5jDQpEb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWZkL3JvaG0sYmQ3MTg0Ny1wbWljLnlhbWwNCkRvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9yZWd1bGF0b3Ivcm9obSxiZDcxODQ3LXJlZ3Vs
YXRvci55YW1sDQoNCmFzIGV4YW1wbGUuDQoNClRoZSBkZXZpY2UgbWF0Y2hpbmcgY2FuIGJlIGRv
bmUgdmlhIHBsYXRmb3JtX2RldmljZV9pZCB0YWJsZS4NCkkgdGhpbmsgdGhlIE1PRFVMRV9BTElB
UygpIGlzIG5lZWRlZCBmb3IgbW9kdWxlIG1hdGNoaW5nIC0gYnV0IEkgZG9uJ3QNCnJlbWVtYmVy
IHdpdGhvdXQgZnVydGhlciBjb2RlIGJyb3dzaW5nLg0KDQpBbnl3YXlzLCB0aGUgQkQ3MTgzNy80
Ny81MCBEVCBlbnRyeSB3aXRob3V0IGNvbXBhdGlibGUgZm9yDQpjbGsvcmVndWxhdG9ycyBkbyBw
cm9iZSBhbmQgbG9hZCB0aGUgc3ViLWRldmljZXMuDQoNCkFzIGEgInRyYWRlb2ZmIiBzdWJkZXZp
Y2VzIG11c3QgcmV0cmlldmUgdGhlIERUIG5vZGUgZnJvbSB0aGUgcGFyZW50DQpkZXZpY2UuDQoN
CkZvciBteSB1bmVkdWNhdGVkIGV5ZXMgdGhlIERUIGJpbmRpbmcgZm9yIHJlZ3VsYXRvcnMgc2hv
dWxkIGJlIGNoYW5nZWQuDQpDb21wYXRpYmxlIHNob3VsZCBub3QgYmUgcmVxdWlyZWQgYW5kIHRo
ZSBleGFtcGxlIG5vZGUgc2hvdWxkIGJlIG1vdmVkDQp0byBNRkQgYmluZGluZyBkb2N1bWVudCBp
biB0aGUgTUZEIG5vZGUuIEJ1dCB0aGF0J3MganVzdCBteSB2aWV3IG9uDQp0aGlzIC0gbm90IHdp
bGxpbmcgdG8gcHVzaCB0aGlzIHRvIGFueSBkaXJlY3Rpb24hDQoNCkJlc3QgUmVnYXJkcw0KCU1h
dHRpIFZhaXR0aW5lbg0KDQotLQ0KTWF0dGkgVmFpdHRpbmVuLCBMaW51eCBkZXZpY2UgZHJpdmVy
cw0KUk9ITSBTZW1pY29uZHVjdG9ycywgRmlubGFuZA0KU1dEQw0KS2l2aWhhcmp1bmxlbmtraSAx
RQ0KOTAyMjAgT1VMVQ0KRklOTEFORA0KDQp+fn4gIkkgZG9uJ3QgdGhpbmsgc28sIiBzYWlkIFJl
bmUgRGVzY2FydGVzLiBKdXN0IHRoZW4gaGUgdmFuaXNoZWQgfn5+DQoNClNpbW9uIHNheXMgLSBp
biBMYXRpbiBwbGVhc2UuDQoibm9uIGNvZ2l0byBtZSIgZGl4aXQgUmVuZSBEZXNjYXJ0ZSwgZGVp
bmRlIGV2YW5lc2Nhdml0DQoNCihUaGFua3MgZm9yIHRoZSB0cmFuc2xhdGlvbiBTaW1vbikNCg0K

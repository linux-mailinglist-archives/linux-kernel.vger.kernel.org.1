Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC3982F129B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 13:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbhAKMyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 07:54:54 -0500
Received: from mail-eopbgr00083.outbound.protection.outlook.com ([40.107.0.83]:33750
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726686AbhAKMyx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 07:54:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GCWcFUxTX2SVKOlCJpzRYEMpxJK0/loVHY70Wkkb7KqtkryU3UIP02dw1dECIi2EQgnSVbE4Isab6qgY/Js1Gr3NXUNNTqSYHmG87PvRo/UkbYfCfT/qfUL5s9zZ/FRG7Jn2Rv0dh5eTH4evsHSY9YxUXtY8uxXma6l5snaaow2ciF3gfVO0TGsHW98Z3XuP3IA6NQXHKhatputVs5gYAm1Wp8YLQh+TZGUWSQ8nRu35gnqaC0IQUBBQQLokbwO6iM9h3l8njJl9SD1Ed26myjNvdaHvbeVNtCPpHRAoRISkjVw7Vx4HXDkJANNiEuppv1bL7/QeBqoTntrutEpNBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iHLch4lcna1hyxqSdgdZlUEU8iRMWfQDT324w9s4YkE=;
 b=IifpMs8qD0n66zY/WX25UC45UxxVWzg+YH8nHbpL4A3tiX+GUQOtnyxDohSSWudo/hasvStTBmwdgVBh40HhQUX0j2olaW+9JFfw/4gp7ktD5qRbM9Dn/BP8EfzPzkqlk0kyRZsP0a9qoo2L9nc6x/elGhRjXFK5pM7n6Aonk5yL3J5mcwIYGAUPaih0A3y6EBjQ+JbadzLafhU0j8lWVj/lDptQRqj0tl/AQDFxkxhyyAv8iq57V0Lhdheci5uENDLyo5FZF9Tlhq0YcmsPXVlRfqni8JUBGio88hyGaRSr+OFFVVZCyR/HuLKThf8EUzM5d8wjdsBNUAnLRfz3zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductoreurope.onmicrosoft.com;
 s=selector1-rohmsemiconductoreurope-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iHLch4lcna1hyxqSdgdZlUEU8iRMWfQDT324w9s4YkE=;
 b=AF9lhRMCDqCfwdvNGWcOM620K/WINNH8JDHs2WJJH78kmlQTnL3oaFdgle+dpsA1o6M052IfHK2SdQgnYOrSu8/RwAi1z1xulGhVJKK9bblBHXbT5BZ06EckghZAwWSkBUR3eKY65iT3vBDbf7qlHaw9xkNwLk14X6hLzzzhqDc=
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com (2603:10a6:7:55::20) by
 HE1PR0302MB2764.eurprd03.prod.outlook.com (2603:10a6:3:ee::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3742.8; Mon, 11 Jan 2021 12:53:34 +0000
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::6558:57bb:5293:f3d3]) by HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::6558:57bb:5293:f3d3%3]) with mapi id 15.20.3742.012; Mon, 11 Jan 2021
 12:53:33 +0000
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
Thread-Index: AQHW5npBTwyRx0TReE2Qd5sH2ElaIqohsy6AgACDMQCAAAa4gIAAIz0AgAAEQIA=
Date:   Mon, 11 Jan 2021 12:53:33 +0000
Message-ID: <b3b57c9e393a4330f7430db490c8ef758b89bec6.camel@fi.rohmeurope.com>
References: <20210109112612.1221-1-matthias.bgg@kernel.org>
         <b358179732f940f883c12dd1276f855a@richtek.com>
         <8a5b2d7a-cd31-ecbb-bdc2-35c881c9068d@suse.com>
         <ef659bcf62c9bfcf68359f21a9c9cd0093b9b969.camel@fi.rohmeurope.com>
         <b1bfe40a-8d70-4177-8afc-e2c0dfe442a3@suse.com>
In-Reply-To: <b1bfe40a-8d70-4177-8afc-e2c0dfe442a3@suse.com>
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
x-ms-office365-filtering-correlation-id: 9e710e53-ab4e-4557-63be-08d8b62fe7ac
x-ms-traffictypediagnostic: HE1PR0302MB2764:
x-microsoft-antispam-prvs: <HE1PR0302MB2764AC18081F0E53DEA605F0ADAB0@HE1PR0302MB2764.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xrOSoTeMX5rgxtIjWp6j6dR2TF29N2aT8Mi7jmS9R+Grg+5dFae2KL80+94VRvrclZWOFfXAmKTkAWPDVeo5osdCx0wVo4ucTWIfS6S9Vq0+okdvOpIHhqulwz6SnMoDo1HeX0iFfCN0i0NGrYoWiyMZU9RmKEcNZ/xr+lx342/zvy4qk0BcMgViPky1HCfmy+bE/7C89On+4JdHIk5vkxu+Bxr5ED6sRkT7+XKn+4ff2BSIn7lE53EbySkfYYCO3CbMV4jh1E4Nkg6aB7B4rY7IdIEe7l8ow1MDTP9GytND49ma6yu0lJseZRSkr1OWPf52hpQYFQZxc4eN/tA/jLeCPQOwsLPjVOyq0Q3e8vE9BUkAUcMikKs1KgyOTCVQOoQ5uVrc19SMD6qHBELB2Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR03MB3162.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(66946007)(5660300002)(110136005)(53546011)(8676002)(6506007)(86362001)(71200400001)(66476007)(66556008)(54906003)(6486002)(76116006)(4326008)(2906002)(64756008)(66446008)(186003)(3450700001)(26005)(7416002)(2616005)(6512007)(498600001)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?SUY0LzBsdng2Uk9yZWtHWXJacFJ3T2o5N3REOXRBRFdhTWgyejBZUkJZMTAx?=
 =?utf-8?B?S1lBeWM3NnFCeGorMUNua2VUNVhlSklvY0daNVJQYmFYaElkWUpiVFFVaFl3?=
 =?utf-8?B?RzBKYkN0bUxLanNpeXJnczRJWHVQV29YQm5MWERjVG0yUWRjV3BSQnhleERW?=
 =?utf-8?B?NlZsc2FUT1ZQS28xd1YxamkrM0QySThDTGRqK2Zkb08wMHc0dm41bTQ5QnN2?=
 =?utf-8?B?SWlJM1dnengzNUpBQkMxR25EZnhGZjNSUmN5cGdsV3NBYWFmajlIZWRIL0pI?=
 =?utf-8?B?Mkc2MWd3bUhkaWtadUU4TG5zWUg4cVdINnNaSjd4L1kzL2FFRmU0MmVUT3BP?=
 =?utf-8?B?V3J4OXUzRTh5ekpkb0sxODgrSzkzQUtYK1ZOOC9MZEtPNXhlNVJMRFhuWXhB?=
 =?utf-8?B?NEZPdElhSExkL3JiNG8vOVltdzkzazdCcWlQUGh1Z1RMZkRrcWtlSkUvaDBv?=
 =?utf-8?B?UmVhbER5eThiV0h2U0Faa3diYU9UaHdtSVAyL0IrNXF4QkpyeXZHUGZmRlgw?=
 =?utf-8?B?NmlCNDlXT3hSYnhEcVVvc0JTRjduTmx1VUhEbHl5bHFLd2g2Yk5UZVBFZWZ5?=
 =?utf-8?B?V2tJcnlEUDNTL2tGMVU5NUdXTGFVMXFaM3NIdFNsRzlvZ0FQOWJJQ1d6d0tt?=
 =?utf-8?B?U0tRNkdZYTI5dnhyTnNRRVZQbnZPcnJtOW82RDU1a0x2NTY5WHhYeTdzTXh1?=
 =?utf-8?B?RWpvZDQvTlBoMWhCeThoV1dwaWhwaWp2TWhrSktPWW5RRTh0Q0hCNkRxYi90?=
 =?utf-8?B?TU5WcllWc29rL3VJU0lzVWY2QlRDODlEZ0w2Rlh1MTc2Z2VTdzBYZ01kYzBr?=
 =?utf-8?B?NVVnYVhkOUl6OEM2SjVySHNaQXdRamkraFBxaVRQVUs0bGpwSmV3b1hyMlpH?=
 =?utf-8?B?TFBjdWMwb28wUHIzM05WcVc3TzhYbnU2VHFvNWhWVmlNbSt2eG84ZmFCNzhI?=
 =?utf-8?B?LytlUHNHZmtVMUtLSlJiSFdJS2IyOHAzaVBLLy9nZWdBd0VBME5zbWcyaFp2?=
 =?utf-8?B?UjdTS1pSU3V1ZGV3WW1xVmtHV2ZnWWRUQ0FveGVQNk4xaTBGTEJQREsxT1h4?=
 =?utf-8?B?cFRuUUYrNkg0RWhFV0NYenFINVo0Uk1TeHhQekF2anZRSlNIdUw5cFp1dFBU?=
 =?utf-8?B?MkhWSHMvVmQxQ1NrTzZ5bFFLWnVndDlVZlpodEVXenovcE0yMXNPVXFQYjRB?=
 =?utf-8?B?QlZxS013Yk16VDlHWld6ZU1XeWpxSHZnVkZRbzNqeGlBMDJmVG1sb0treUpp?=
 =?utf-8?B?R1cvbVRZLzZ5N0s2RDB6a1NUR3c0dE0yNHZoSmxjQzA0VWcwR0wxdzg4aWRx?=
 =?utf-8?Q?zA8LDqzIt7vsn+eS7i7TiHMsyWmAXCjoU/?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <0C20A42CAFB64F48B69755C4EB81AC8A@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR03MB3162.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e710e53-ab4e-4557-63be-08d8b62fe7ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2021 12:53:33.8618
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 94f2c475-a538-4112-b5dd-63f17273d67a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fyrxjxrzsFSgkdIMrmVBfLAnGUH4sHQ43xn2LahJjR8M8lO8DpEzGWlYK9Utj/NCh20f4jmMIPrfXPvo1xSpLAVjWcnz/eYq6ASmMeXXT6iFEnNw5BXhhqkciSB+hvoB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0302MB2764
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiBNb24sIDIwMjEtMDEtMTEgYXQgMTM6MzggKzAxMDAsIE1hdHRoaWFzIEJydWdnZXIgd3Jv
dGU6DQo+IEhpIE1hdHRpLA0KPiANCj4gT24gMTEvMDEvMjAyMSAxMTozMiwgVmFpdHRpbmVuLCBN
YXR0aSB3cm90ZToNCj4gPiBIZWxsbyBNYXR0aGlhcyAmIEFsbCwNCj4gPiANCj4gPiBPbiBNb24s
IDIwMjEtMDEtMTEgYXQgMTE6MDggKzAxMDAsIE1hdHRoaWFzIEJydWdnZXIgd3JvdGU6DQo+ID4g
PiBPbiAxMS8wMS8yMDIxIDAzOjE4LCBnZW5lX2NoZW4o6Zmz5L+K5a6HKSB3cm90ZToNCj4gPiA+
ID4gWyBJbnRlcm5hbCBVc2UgLSBFeHRlcm5hbCBdDQo+ID4gPiA+IA0KPiA+ID4gDQo+ID4gPiBQ
bGVhc2UgZG9uJ3QgdG9wLXBvc3QgaW4gdGhlIGZ1dHVyZS4NCj4gPiA+IA0KPiA+ID4gPiBIaSBN
YXR0aGlhcywNCj4gPiA+ID4gDQo+ID4gPiA+IEkgZGlzY3Vzc2VkIE9GIG1hdGNoIHRhYmxlIHdp
dGggTWFyayBpbiBwcmV2aW91cyBtYWlsIGluIG91cg0KPiA+ID4gPiBQQVRDSA0KPiA+ID4gPiB2
MywNCj4gPiA+ID4gTUZEIHNob3VsZCBqdXN0IGluc3RhbnRpYXRlIHRoZSBwbGF0Zm9ybSBkZXZp
Y2UuDQo+ID4gPiANCj4gPiA+IERpZCB5b3UgZXZlciB0ZXN0IHRoYXQ/IFdoaWNoIE1GRCBkcml2
ZXIgc2hvdWxkIGluc3RhbnRpYXRlIHRoZQ0KPiA+ID4gZGV2aWNlPw0KPiA+ID4gSSBoYWQgYSBs
b29rIGF0IG10NjM2MC1jb3JlLmMgKHRoZSBvYnZpb3VzIG9uZSkgYnV0IEkgZG9uJ3Qgc2VlDQo+
ID4gPiBhbnkNCj4gPiA+IHJlZmVyZW5jZSB0bw0KPiA+ID4gdGhlIHJlZ3VsYXRvciBbMV0uIFdo
YXQgYW0gSSBtaXNzaW5nPw0KPiA+ID4gDQo+ID4gPiA+ID4gTWFyayBCcm93biA8YnJvb25pZUBr
ZXJuZWwub3JnPiDmlrwgMjAyMOW5tDjmnIgyMOaXpSDpgLHlm5sg5LiL5Y2INzo0NeWvq+mBk++8
mg0KPiA+ID4gPiA+ID4gVGhpcyBkZXZpY2Ugb25seSBleGlzdHMgaW4gdGhlIGNvbnRleHQgb2Yg
YSBzaW5nbGUgcGFyZW50DQo+ID4gPiA+ID4gPiBkZXZpY2UsIHRoZXJlDQo+ID4gPiA+ID4gPiBz
aG91bGQgYmUgbm8gbmVlZCBmb3IgYSBjb21wYXRpYmxlIHN0cmluZyBoZXJlIC0gdGhpcyBpcw0K
PiA+ID4gPiA+ID4ganVzdCBhDQo+ID4gPiA+ID4gPiBkZXRhaWwNCj4gPiA+ID4gPiA+IG9mIGhv
dyBMaW51eCBkb2VzIHRoaW5ncy4gIFRoZSBNRkQgc2hvdWxkIGp1c3QgaW5zdG50aWF0ZQ0KPiA+
ID4gPiA+ID4gdGhlDQo+ID4gPiA+ID4gPiBwbGF0Zm9ybQ0KPiA+ID4gPiA+ID4gZGV2aWNlLg0K
PiA+ID4gPiA+IFRyeWluZyB0byBhdXRvbG9hZCBtb2R1bGUgd2l0aG91dCBvZl9pZF90YWJsZSB3
aWxsIGNhdXNlIHJ1bi0NCj4gPiA+ID4gPiB0aW1lIA0KPiA+ID4gPiA+IGVycm9yOg0KPiA+ID4g
PiA+IHVldmVudGQ6IExvYWRXaXRoQWxpYXNlcyB3YXMgdW5hYmxlIHRvIGxvYWQNCj4gPiA+ID4g
PiBvZjpOcmVndWxhdG9yVChudWxsKUNtZWRpYXRlayxtdDYzNjAtcmVndWxhdG9yDQo+ID4gPiA+
IA0KPiA+ID4gPiBZb3Ugc2hvdWxkbid0IGhhdmUgdGhpcyBkZXNjcmliZWQgaW4gdGhlIGRldmlj
ZSB0cmVlIGF0IGFsbCwNCj4gPiA+ID4gbGlrZSBJDQo+ID4gPiA+IHNheQ0KPiA+ID4gPiB0aGUg
TUZEIHNob3VsZCBqdXN0IGluc3RhbnRpYXRlIHRoZSBwbGF0Zm9ybSBkZXZpY2UuDQo+ID4gPiA+
IA0KPiA+ID4gDQo+ID4gPiBXZWxsIGZyb20gbXkgdW5kZXJzdGFuZGluZyB0aGUgcmVndWxhdG9y
IGhhcyBhIGRldmljZS10cmVlIGVudHJ5DQo+ID4gPiBbMl0sDQo+ID4gPiBzbyBpdA0KPiA+ID4g
bmVlZHMgdG8gbWF0Y2ggYWdhaW5zdCBhIGRldmljZS10cmVlIG5vZGUuIE15IHVuZGVyc3RhbmRp
bmcgaXMsDQo+ID4gPiB0aGF0DQo+ID4gPiB5b3UgbmVlZCBhDQo+ID4gPiB0aGUgZGV2aWNldHJl
ZSBub2RlIHRvIGRlc2NyaWJlIHRoZSByZWd1bGF0b3JzIHByb3ZpZGVkIGJ5IHRoZQ0KPiA+ID4g
ZGV2aWNlLiBUQkggSSdtIGENCj4gPiA+IGJpdCBwdXp6bGVkIGFib3V0IHRoZSBjb21tZW50IGZy
b20gTWFyayBoZXJlLiBIb3cgZG9lcyBhbm90aGVyIERUDQo+ID4gPiBub2RlIGJlIGFibGUNCj4g
PiA+IHRvIHJlZmVyZW5jZSBhIHJlZ3VsYXRvciBpZiB0aGlzIGlzIG5vdCBkZXNjcmliZWQgaW4g
RFQ/IEkgdGhpbmsNCj4gPiA+IHdlDQo+ID4gPiBuZWVkIGEgRFQNCj4gPiA+IG5vZGUgaGVyZSBh
bmQgdGhlIG1hdGNoaW5nIGluIHRoZSByZWd1bGF0b3IgYW5kIE1GRCBkcml2ZXIgdG8gZ2V0DQo+
ID4gPiB0aGUNCj4gPiA+IHJlZ3VsYXRvcg0KPiA+ID4gbG9hZGVkIHZpYSB1ZGV2Lg0KPiA+IA0K
PiA+IE90aGVycyBhcmUgYmV0dGVyIHRvIGFuc3dlciAtIGJ1dCBhcyBJIHNwb3R0ZWQgdGhpcyBm
cm9tIG15IGluYm94DQo+ID4gSSdsbA0KPiA+IGdpdmUgbXkgMiBjZW50cyA6KSANCj4gPiANCj4g
PiBUaGlzIGNhbiBiZSBkb25lIFcvTyByZWd1bGF0b3JzIGhhdmluZyBvd24gY29tcGF0aWJsZS4g
UGxlYXNlIHNlZQ0KPiA+IGZvbGxvd2luZzoNCj4gPiANCj4gPiBkcml2ZXJzL21mZC9yb2htLWJk
NzE4eDcuYw0KPiA+IGRyaXZlcnMvcmVndWxhdG9yL2JkNzE4eDctcmVndWxhdG9yLmMNCj4gPiBE
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWZkL3JvaG0sYmQ3MTg0Ny1wbWljLnlh
bWwNCj4gPiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcmVndWxhdG9yL3JvaG0s
YmQ3MTg0Ny0NCj4gPiByZWd1bGF0b3IueWFtbA0KPiA+IA0KPiA+IGFzIGV4YW1wbGUuDQo+IA0K
PiBUaGFua3MgZm9yIHRoZSBsaW5rcy4gWWVzIHRoYXQncycgYSB3YXkgdG8gZ28sIGJ1dC4uLg0K
PiANCj4gPiBUaGUgZGV2aWNlIG1hdGNoaW5nIGNhbiBiZSBkb25lIHZpYSBwbGF0Zm9ybV9kZXZp
Y2VfaWQgdGFibGUuDQo+ID4gSSB0aGluayB0aGUgTU9EVUxFX0FMSUFTKCkgaXMgbmVlZGVkIGZv
ciBtb2R1bGUgbWF0Y2hpbmcgLSBidXQgSQ0KPiA+IGRvbid0DQo+ID4gcmVtZW1iZXIgd2l0aG91
dCBmdXJ0aGVyIGNvZGUgYnJvd3NpbmcuDQo+ID4gDQo+ID4gQW55d2F5cywgdGhlIEJENzE4Mzcv
NDcvNTAgRFQgZW50cnkgd2l0aG91dCBjb21wYXRpYmxlIGZvcg0KPiA+IGNsay9yZWd1bGF0b3Jz
IGRvIHByb2JlIGFuZCBsb2FkIHRoZSBzdWItZGV2aWNlcy4NCj4gPiANCj4gPiBBcyBhICJ0cmFk
ZW9mZiIgc3ViZGV2aWNlcyBtdXN0IHJldHJpZXZlIHRoZSBEVCBub2RlIGZyb20gdGhlDQo+ID4g
cGFyZW50DQo+ID4gZGV2aWNlLg0KPiA+IA0KPiA+IEZvciBteSB1bmVkdWNhdGVkIGV5ZXMgdGhl
IERUIGJpbmRpbmcgZm9yIHJlZ3VsYXRvcnMgc2hvdWxkIGJlDQo+ID4gY2hhbmdlZC4NCj4gPiBD
b21wYXRpYmxlIHNob3VsZCBub3QgYmUgcmVxdWlyZWQgYW5kIHRoZSBleGFtcGxlIG5vZGUgc2hv
dWxkIGJlDQo+ID4gbW92ZWQNCj4gPiB0byBNRkQgYmluZGluZyBkb2N1bWVudCBpbiB0aGUgTUZE
IG5vZGUuIEJ1dCB0aGF0J3MganVzdCBteSB2aWV3IG9uDQo+ID4gdGhpcyAtIG5vdCB3aWxsaW5n
IHRvIHB1c2ggdGhpcyB0byBhbnkgZGlyZWN0aW9uIQ0KPiA+IA0KPiANCj4gR2VuZXJhbGx5IHNw
ZWFraW5nLCBEVCBiaW5kaW5ncyBhcmUgc3RhYmxlIGFuZCBjYW4ndCBiZSBjaGFuZ2VkIGluIGEN
Cj4gbm9uZS1jb21wYXRpYmxlIHdheS4gV2UgY291bGQgYXJndWUgaWYgdGhlcmUgaXMgYW55IHVz
ZXIgb2YgdGhlDQo+IGNvbXBhdGlibGUgb3V0DQo+IHRoZXJlIChwcm9iYWJseSB0aGVyZSBpc24n
dCBhbnksIGFzIHRoZSBjb2RlIHNlZW1zIHRvIG5vdCBldmVuIGJlDQo+IHdvcmtpbmcpLg0KDQpJ
IHRoaW5rIHRoaXMgZGVwZW5kcyBvbiB0aGUgZGV2aWNlIHdoZXJlIGRyaXZlcihzKSBhcmUgdXNl
ZC4gUXVpdGUgYQ0KZmV3IGRldmljZXMgYWxsb3cgdXBkYXRpbmcgdGhlIGRldmljZS10cmVlIHdo
ZW4gU1cgaXMgdXBkYXRlZC4gQnV0IGFzIEkNCnNhaWQsIEkgZG9uJ3Qgd2FudCB0byB0cnkgcHVz
aGluZyB0aGlzIG9uZSBkaXJlY3Rpb24gb3Igb3RoZXIgLSBJIGxlYXZlDQppdCBmb3IgdGhvc2Ug
d2hvIGhhdmUgYnJvYWRlciBzaG91bGRlcnMgZm9yIHB1c2hpbmcgWEQuDQoNCkkgd2FzIG1lcmVs
eSB0cnlpbmcgdG8gYW5zd2VyIHlvdXIgcXVlc3Rpb24gOikNCg0KQmVzdCBSZWdhcmRzDQoJTWF0
dGkNCg==

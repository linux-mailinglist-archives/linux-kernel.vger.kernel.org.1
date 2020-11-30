Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E85B2C7C7A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 02:39:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbgK3BjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 20:39:08 -0500
Received: from mail-eopbgr80048.outbound.protection.outlook.com ([40.107.8.48]:25352
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726332AbgK3BjI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 20:39:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eBffqSfp9Iuj3hIEQtXD6eY/zQfJR/QDix5D3aT6MxZ5sjE/ojod2eHHJv5stXwNRW5EBJU1Ua6kBy/J+e5mItZw8kvvf30nRzSpsVYRV3DSLlujTQc35rg7uC+h8oDDQgBPOrxodBSBxE04oqMo5ZUqIt5gw4c14/bzRSJHL+Gf3YXM6HcbmTG1r1KT3l9iOAhXFL9VvSPhM6TbquoILdUhqH3u2P2/OLhwEmOtljDTCmM92Nkxo2AdE1cQiS1wV/RvgrMOEWbSshJPTjY6UZ0ar3tXUVKmiG1Zs2s/arGfDBkTN+IRN6AqvLwxktcr7PAOCmkVDk/udfsulnUe6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pJZFlbsTLshmVzs1GsVbgwyTUHF/f9HBPPAUyr9J03I=;
 b=gLVfBJ/0oXJWK5Y9UIIlPTIlsd7bRyae7N2f/BaOxJQ5gOyme8J/CU9wUQaC6JYrIAOB2MpH+QFaj4IjjiVwedHpeUAt8QdD6EvohwaaPq1jtavF9D4HYQtVV87Ng0CbAzLo1tXOcVBZHE+tEkMwb6MVEFJmFCFpNC04I+7XiFTO3W/PyQpwN/codKIZKObdfRroPcUrffWHvjjUR5e31E04SSVYdSnRpGW9NNIaZyVVyOLy77wP5ZSp3i1BwuOmvUCcDeXckau+D2y/AHUBhfyD30RBl6TNp3/ymvD0ST1V2IdjG4cdcCC2Q/V/Id2YSURp5FQ+/+cZF11QvG43VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pJZFlbsTLshmVzs1GsVbgwyTUHF/f9HBPPAUyr9J03I=;
 b=U98Ompas5NTkNu7gz3zf7/1WxzL9K+KeP05pYBI6uD2G/n6gwi3dKvD3wV5wM0etGzhaKElxioTUCSKkomdLYjkLaV2rQ8VOoR7m33yQ/MWSDWtYbUam+R1J35JssITlF+RVf7EKC4LT7xhdDcBlo4PDj/1r5eGckVT8rMQ5atA=
Received: from DB6PR0401MB2438.eurprd04.prod.outlook.com (2603:10a6:4:33::14)
 by DB8PR04MB6649.eurprd04.prod.outlook.com (2603:10a6:10:104::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.31; Mon, 30 Nov
 2020 01:38:18 +0000
Received: from DB6PR0401MB2438.eurprd04.prod.outlook.com
 ([fe80::f0c9:fd48:c8d1:5c22]) by DB6PR0401MB2438.eurprd04.prod.outlook.com
 ([fe80::f0c9:fd48:c8d1:5c22%11]) with mapi id 15.20.3611.025; Mon, 30 Nov
 2020 01:38:18 +0000
From:   "Biwen Li (OSS)" <biwen.li@oss.nxp.com>
To:     Leo Li <leoyang.li@nxp.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Biwen Li (OSS)" <biwen.li@oss.nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "Z.q. Hou" <zhiqiang.hou@nxp.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "maz@kernel.org" <maz@kernel.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jiafei Pan <jiafei.pan@nxp.com>,
        Xiaobo Xie <xiaobo.xie@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [EXT] Re: [v2 01/11] irqchip: ls-extirq: Add LS1043A, LS1088A
 external interrupt
Thread-Topic: [EXT] Re: [v2 01/11] irqchip: ls-extirq: Add LS1043A, LS1088A
 external interrupt
Thread-Index: AQHWrB1rT1rZT9wf3U6a6wH3dRQoQKmrEqeAgADlygCACG4gAIAA/ZAAgACy2ACABCB8gIAcc7QAgAlvKfA=
Date:   Mon, 30 Nov 2020 01:38:17 +0000
Message-ID: <DB6PR0401MB2438919F5B954B0FD6BA1B1E8FF50@DB6PR0401MB2438.eurprd04.prod.outlook.com>
References: <20201027044619.41879-1-biwen.li@oss.nxp.com>
 <5b1f2911-98b3-511f-404b-7d0fa44cc0c2@rasmusvillemoes.dk>
 <DB6PR0401MB2438ED1C8F629CA1E1F469768F160@DB6PR0401MB2438.eurprd04.prod.outlook.com>
 <VE1PR04MB668790304253EAEEBC1B79F48F160@VE1PR04MB6687.eurprd04.prod.outlook.com>
 <DB6PR0401MB2438DCABBF4892ECF599D4528F100@DB6PR0401MB2438.eurprd04.prod.outlook.com>
 <VE1PR04MB6687738526B56F3F0E6812C58F100@VE1PR04MB6687.eurprd04.prod.outlook.com>
 <03dc38bb-b83a-7926-60dc-61152a3ac967@rasmusvillemoes.dk>
 <VE1PR04MB66876B8AF6F0D3C5A583BBDF8FEE0@VE1PR04MB6687.eurprd04.prod.outlook.com>
 <CADRPPNTXnRrsRaAX-zBcU9vPo37u7BCKfAtzGG=2_Ut4syZwJA@mail.gmail.com>
In-Reply-To: <CADRPPNTXnRrsRaAX-zBcU9vPo37u7BCKfAtzGG=2_Ut4syZwJA@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 945aacad-c75e-4f87-e9a4-08d894d09d1d
x-ms-traffictypediagnostic: DB8PR04MB6649:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR04MB66498B9C716CFA3AC517D259CEF50@DB8PR04MB6649.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p/EwQw91XeCD3ht2vIHxIQVo/EQCbOb/TWjX1tgQZbl83F0n5x4+2qb21HFmqnHgpWjeAKLOFUZv0jDb2x4sxxr/XLTh/drYinYeNKUkC0M5Pkqil6uqgwOA46uBMuwT/2PZJBB37xukv7KrtAAi978jVeCNuqIL5CpXQDn3dR034njjSI62xnnJwXuTpFtLwzRSXEyl4huUDkG2QEY5SotCKSzLym+AAvAOjgGQFLVRx76AZDfIzcbdR+Je7t4eFPr/T/Y0vqvqfXkTQ6IexopKNRQyewaGTVac+rFMDwmWz4CpnyWUbtNscM0jsycx8Fh2RtgFYxoki/z1sMsxm6W28AYZzbVNnIdsLEOyWec2G6z0LjklcIPYkHBQqR7T
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0401MB2438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(376002)(346002)(39860400002)(366004)(7416002)(186003)(921005)(6506007)(478600001)(83380400001)(55016002)(9686003)(8676002)(71200400001)(5660300002)(86362001)(52536014)(4326008)(33656002)(26005)(2906002)(110136005)(7696005)(76116006)(316002)(66946007)(8936002)(54906003)(66476007)(66556008)(66446008)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?SjJJRU5JMVdRSk9WRDFSV1A1SmExaWc5RGtWelRoK29ZVzZjdyt1ZUk1enhz?=
 =?utf-8?B?OTl1U1RpNThONUYyZlg5QSs5UWNaU0Q4eSt0cWc2UUp4OGw3Slh2Y3NNYTNC?=
 =?utf-8?B?cmJ5ZjNpUU9CSWx5d1pScmYwejFqSjdSVjFOZlJlR2l3QVhFWHN3QzlwL3p4?=
 =?utf-8?B?bzR1MDZCRHRiL05DbkZ0ZWU1eXBreFc0bU0yMStWT1dERlc4M3VYZ3cxcGpF?=
 =?utf-8?B?Q0hEM2lqSHlKQTdjWFczME4rRXZkVGZldjB2ZHhldnFteGQ5ZjNPU1YvR0JT?=
 =?utf-8?B?N1NZTUJqSVhoK1NjZC92VzBTdjFiTklTUnZlTFVRc1VBSUNkMlpHY01GYUpi?=
 =?utf-8?B?TFF4N1ZWSmhVcUdqeDhSY2xJaFhxa0JpVll5N3lWZWY2ekZBclZyQzN0akFO?=
 =?utf-8?B?UisrSWFvajJGMzJ6VnVOWUdSM3FDRW96cm1yZ3U1TElhZklQR1YydXhJSSti?=
 =?utf-8?B?bUZmUlpqRUxVUWNITTlGaTh2Vjk5emZ4T2s3TW9ZS085VENCd3pKUVdJTVdv?=
 =?utf-8?B?SkthRUNZUW43aGlkd0wvd0FPTVVRNTFhMVY0Uy9Qa25MRTNEdklKd1lpNjNz?=
 =?utf-8?B?MGROMmNPTU1YMGhzcFlYSGZUeXFGUUQyTDZvampJeG00WndPKzIwZHZQNWFm?=
 =?utf-8?B?OUJwRlp5M3dRTEFSMmVzK3hRbHl4TXYrZi9ZRUdWZGZQK1ZoalRyUURNdGZJ?=
 =?utf-8?B?MHN5QTJSaTdvZFBxM3krTjhRb3ZkcFhnY1B3YkFMV3JmY2JHN29GY1htVW1v?=
 =?utf-8?B?NFBqS2puOGFORWJLaE1BeWRyYVdyYkZTRWpZOUZleGVkbFBHY3F3MGlZVnBU?=
 =?utf-8?B?ZHZMSlArY01aMjBPekY0WmN5cUpVL08zTWVEOS9MNU5PaTgrS1hOeWFJVHI4?=
 =?utf-8?B?ZkVJeEhCZytxenlPM1Z5T0UwT25DbGwzb0R1d0FRL0tMWHVSeE5tOHEzUUZv?=
 =?utf-8?B?Y2UxSkxDbXBkRVVBc1ZweW52dkdjZzBBT1BSOW5pbHY2Z1A2YndLVCtFVWVI?=
 =?utf-8?B?eXZvdUVZcThxTmcrL3grK0RYMWFUQXN2enVkd2VhZlRLSFg0MlFLYktqRlhJ?=
 =?utf-8?B?NEVUNHJuemlJTGJuc082c2N3c3hJTUNLSVY1TWd2WkRXck5IMTdveVBzd0JS?=
 =?utf-8?B?M2ZDT1hKN2lQVXRMano1cGRpOEpaSkNRb3FickxNcUVySDNWbC9peVF0OXVl?=
 =?utf-8?B?SXRIckhFTlZNYWRsSzNNN0ZKOGNCM2R1RGdiaGp4WWN4SjY1M3ZwdXpnQUNX?=
 =?utf-8?B?T3B2MjVoN2xTQVM1VytBWFBWNzBZVkQzZ0xPbENLWUY5eWlIMGtDbkVRbXZO?=
 =?utf-8?Q?fzlZ7O88BWMUg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0401MB2438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 945aacad-c75e-4f87-e9a4-08d894d09d1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2020 01:38:18.0727
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kdPhXe6gu8rt2iAjs996x6UrUQ5hlbrQe9F31i16GQLgwimWKPoN36E5SMCn2wlmzlpEkbaYdaIKEOMTpchc4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6649
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+ID4gPiA+Pj4gV2hlcmUgZGlkIHlvdSBnZXQgdGhpcyBpbmZvcm1hdGlvbiB0aGF0IHRoZSBy
ZWdpc3RlciBvbiBMUzEwNDMNCj4gPiA+ID4+PiBhbmQNCj4gPiA+ID4+PiBMUzEwNDYgaXMgYml0
IHJldmVyc2VkPyAgSSBjYW5ub3QgZmluZCBzdWNoIGluZm9ybWF0aW9uIGluIHRoZSBSTS4NCj4g
PiA+ID4+PiBBbmQgZG9lcyB0aGlzIG1lYW4gYWxsIG90aGVyIFNDRkcgcmVnaXN0ZXJzIGFyZSBh
bHNvIGJpdCByZXZlcnNlZD8NCj4gPiA+ID4+PiBJZiB0aGlzIGlzIHNvbWUgaW5mb3JtYXRpb24g
dGhhdCBpcyBub3QgY292ZXJlZCBieSB0aGUgUk0sIHdlDQo+ID4gPiA+Pj4gcHJvYmFibHkgc2hv
dWxkIGNsYXJpZnkgaXQgaW4gdGhlIGNvZGUgYW5kIHRoZSBjb21taXQgbWVzc2FnZS4NCj4gPiA+
ID4+IEhpIExlbywNCj4gPiA+ID4+DQo+ID4gPiA+PiBJIGRpcmVjdGx5IHVzZSB0aGUgc2FtZSBs
b2dpYyB0byB3cml0ZSB0aGUgYml0KGZpZWxkIElSUTB+MTFJTlRQKQ0KPiA+ID4gPj4gb2YgdGhl
IHJlZ2lzdGVyIFNDRkdfSU5UUENSIGluIExTMTA0M0EgYW5kIExTMTA0NkEuDQo+ID4gPiA+PiBT
dWNoIGFzLA0KPiA+ID4gPj4gaWYgSSB3YW50IHRvIGNvbnRyb2wgdGhlIHBvbGFyaXR5IG9mIElS
UTAoZmllbGQgSVJRMElOVFAsIElSUTAgaXMNCj4gPiA+ID4+IGFjdGl2ZSBsb3cpIG9mIExTMTA0
M0EvTFMxMDQ2QSwgdGhlbiBJIGp1c3QgbmVlZCB3cml0ZSBhIHZhbHVlIDENCj4gPiA+ID4+IDw8
ICgzMSAtIDApDQo+ID4gPiB0byBpdC4NCj4gPiA+ID4+IFRoZSBsb2dpYyBkZXBlbmRzIG9uIHJl
Z2lzdGVyJ3MgZGVmaW5pdGlvbiBpbiBMUzEwNDNBL0xTMTA0NkEncyBSTS4NCj4gPiA+ID4NCj4g
PiA+ID4gT2suICBUaGUgU0NGR19TQ0ZHUkVWQ1Igc2VlbXMgdG8gYmUgYSBvbmUtb2ZmIGZpeHVw
IG9ubHkgZXhpc3RlZA0KPiA+ID4gPiBvbg0KPiA+ID4gTFMxMDIxLiAgQW5kIGl0IGlzIG1hbmRh
dG9yeSB0byBiZSBiaXRfcmV2ZXJzZWQgYWNjb3JkaW5nIHRvIHRoZSBSTQ0KPiA+ID4gd2hpY2gg
aXMgYWxyZWFkeSB0YWtlbiBjYXJlIG9mIGluIHRoZSBSQ1cuICBTbyB0aGUgYml0IHJldmVyc2Vk
IGNhc2UNCj4gPiA+IHNob3VsZCBiZSB0aGUgb25seSBjYXNlIHN1cHBvcnRlZCBvdGhlcndpc2Ug
YSBsb3Qgb2Ygb3RoZXIgcGxhY2VzDQo+ID4gPiBmb3IgU0NGRyBhY2Nlc3Mgc2hvdWxkIGJlIGZh
aWxlZC4NCj4gPiA+ID4NCj4gPiA+ID4gSSB0aGluayB3ZSBzaG91bGQgcmVtb3ZlIHRoZSBiaXRf
cmV2ZXJzZSB0aGluZyBhbGwgdG9nZXRoZXIgZnJvbQ0KPiA+ID4gPiB0aGUgZHJpdmVyDQo+ID4g
PiBmb3IgZ29vZC4gIFRoaXMgd2lsbCBwcmV2ZW50IGZ1dHVyZSBjb25mdXNpb24uICBSYXNtdXMs
IHdoYXQgZG8geW91IHRoaW5rPw0KPiA+ID4NCj4gPiA+IFllcywgYWxsIHRoZSBsczEwMjFhLWRl
cml2ZWQgYm9hcmRzIEkga25vdyBvZiBkbyBoYXZlIHNvbWV0aGluZyBsaWtlDQo+ID4gPg0KPiA+
ID4gIyBJbml0aWFsaXplIGJpdCByZXZlcnNlIG9mIFNDRkcgcmVnaXN0ZXJzDQo+ID4gPiAwOTU3
MDIwMCBmZmZmZmZmZg0KPiA+ID4NCj4gPiA+IGluIHRoZWlyIHByZS1ib290LWxvYWRlciBjb25m
aWcgZmlsZS4gQW5kIHllcywgdGhlIFJNIGRvZXMgc2F5DQo+ID4gPg0KPiA+ID4gICBUaGlzIHJl
Z2lzdGVyIG11c3QgYmUgd3JpdHRlbiAweEZGRkZfRkZGRiBhcyBhIHBhcnQgb2YNCj4gPiA+ICAg
aW5pdGlhbGl6YXRpb24gc2VxdWVuY2UgYmVmb3JlIHdyaXRpbmcgdG8gYW55IG90aGVyIFNDRkcN
Cj4gPiA+ICAgcmVnaXN0ZXIuDQo+ID4gPg0KPiA+ID4gYnV0IG5vd2hlcmUgZG9lcyBpdCBzYXkg
Im9yIGVsc2UuLi4iLCBub3IgYSBsaXR0bGUgaG9uZXN0IGFkZGVuZHVtDQo+ID4gPiAiYmVjYXVz
ZSB3ZSBhY2NpZGVudGFsbHkgcmVsZWFzZWQgYnJva2VuIHNpbGljb24gd2l0aCB0aGlzDQo+ID4g
PiBtaXNmZWF0dXJlIF9hbmRfIHdyb25nIFBPUiB2YWx1ZSIuDQo+ID4NCj4gPiBZZWFoLiAgSSBk
byB0aGluayB0aGV5IG1lc3NlZCB1cCBhdCB0aGUgYmVnaW5uaW5nIHdoZW4gdHJ5aW5nIHRvIGlu
dGVncmF0ZQ0KPiB0aGUgYmlnIGVuZGlhbiByZWdpc3RlcnMgb24gbGl0dGxlIGVuZGlhbiBjb3Jl
LiAgSXQgaXMgZ29vZCB0aGF0IHdlIGFyZSBkb2luZyBpdA0KPiBjb3JyZWN0bHkgaW4gbGF0ZXIg
U29Dcy4NCj4gPg0KPiA+ID4NCj4gPiA+IENhbiB3ZSBoYXZlIGFuIG9mZmljaWFsIHN0YXRlbWVu
dCBmcm9tIE5YUCBzdGF0aW5nIHRoYXQgU0NGR1JFVkNSIGlzDQo+ID4gPiBhIGhhcmR3YXJlIGRl
c2lnbiBidWc/IEFuZCBjYW4geW91IHNlbmQgaXQgdGhyb3VnaCBhIHRpbWUtbWFjaGluZSBzbw0K
PiA+ID4gSSBoYWQgaXQgdGhyZWUgeWVhcnMgYWdvIGF2b2lkaW5nIHRoZSB3aG9sZSAiZnNsLGJp
dC1yZXZlcnNlDQo+ID4gPiBkZXZpY2UtdHJlZS1wcm9wZXJ0eSwgbm8sIHJlYWQgdGhlIHJlZ2lz
dGVyIGlmIHlvdSdyZSBvbiBhIGxzMTAyMWEgYW5kIGRlY2lkZSINCj4gaHVsbGFiYWxvby4NCj4g
Pg0KPiA+IEknbSBub3Qgc3VyZSBpZiBpdCBpcyBwb3NzaWJsZSB0byB1cGRhdGUgdGhlIHJlbGF0
ZWQgZG9jdW1lbnRzIHJpZ2h0IG5vdyBmb3IgdGhpcy4NCj4gQnV0IGRlZmluaXRlbHkgaXQgd2Fz
IG5vdCB5b3VyIGZhdWx0IHRvIGhhdmUgaW50cm9kdWNlZCB0aGlzIGluIHRoZSBkcml2ZXIgZHVl
IHRvDQo+IHRoZSBjb25mdXNpb24gZnJvbSBkb2N1bWVudC4gIE15IHN1Z2dlc3Rpb24gdG8gcmVt
b3ZlIGl0IGlzIGp1c3QgdG8gcHJldmVudA0KPiB0aGlzIGZyb20gY2F1c2luZyBtb3JlIGNvbmZ1
c2lvbnMgaW4gdGhlIGZ1dHVyZSBhcyB0aGlzIGRyaXZlciBpcyB1c2VkIG9uIG1vcmUNCj4gU29D
cy4NCj4gDQo+IEhpIEJpd2VuLA0KPiANCj4gV291bGQgeW91IHNlbmQgYSBuZXcgdmVyc2lvbiBv
ZiB0aGlzIHBhdGNoPyAgVGhhbmtzLg0KSGkgTGVvLCBzdXJlLCBucC4NCj4gDQo+IFJlZ2FyZHMs
DQo+IExlbw0K

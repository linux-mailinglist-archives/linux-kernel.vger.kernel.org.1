Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC539268340
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 05:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726010AbgINDoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Sep 2020 23:44:07 -0400
Received: from mail-eopbgr40046.outbound.protection.outlook.com ([40.107.4.46]:16642
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725973AbgINDn7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 23:43:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kmbZ+gcy52xi7ce/mhZ1ts18FUuWcm3gBGvJgQ0CRdakbPABSY9JxO49FzdP0oZCbptIxHQ4Xd9pV4MdhzuEyYzDBrH8O2ZodEqiXPqhXL8ThUQwq7o6SEqRTA1JTiPXJBR/FziTzraEGS424DSfE9WZ5r9ZEvjL65vTCOCp9BFREwGsiK+fHVY5+cU1Tfv44/LBp3k5VRKw62W5wU1ICPHEoyRnNI4RHVTp4Z1bSLy7jkg7i5d/PL+Kb6mr3ESWIqeVyv1IvSFphUU10u17lBC+z2QsL7adl3uTIQ8xHpxP2ye07UgtZyfuy6t3yFmZI753HpOIvxXJs+s35/KfOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pdVVn6Od3c9wAs9eOo8XWnXQwuizaKYbczMcGDpbUmg=;
 b=I78M9vG4RT8Qsv5CxSEliJVHLTn8EFu7+9ahaN9BRK7kVP/X7uZV+aFooXc5yG+fqiWW3bwe+ZFc6VVYAJSe0pkmBdPsqcdGxr8rFi0tVX8RB5T6Mu1m6SY1P4uBxThOvCbeejhNezGA9icOa+MA69OMFaFUOmXpH6aVJzi9Trff6egr71/pI2rrVG+sB9WpP7sEunaV4Bo7lUV35LtmHUbpFZ3ShMO5NGB8U1xdNI1vxWy9VPXDQgCEr1nQl1t3GbukE6AO4PvL1YmHs1ZaKsQUmwpEnydrySi0WkSXBb1l5FgQPVu0dGN6TN5C1DQV64samXF0goYKtohD8ToZLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pdVVn6Od3c9wAs9eOo8XWnXQwuizaKYbczMcGDpbUmg=;
 b=MNlj18cnn93fcfV1vy0slYvXgxGMKlh+O9+9IQGVizPXTuX02BpEkvLd2Tku8NluRCmqwDpYAFDmyUA5Gk07ntdtVacFQlogvMRWE45eQbke2dlIcPEzG4VyiyJ1ssY8mDl8GKITnFpShQYugZBBUPqLdcf1MA/kxDsDtCe2ACg=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR04MB5959.eurprd04.prod.outlook.com (2603:10a6:20b:9c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Mon, 14 Sep
 2020 03:43:54 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::99b5:145d:16cc:78ca]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::99b5:145d:16cc:78ca%3]) with mapi id 15.20.3370.019; Mon, 14 Sep 2020
 03:43:54 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        "Franck Lenormand (OSS)" <franck.lenormand@oss.nxp.com>
CC:     "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>, Abel Vesa <abel.vesa@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        "linux@rempel-privat.de" <linux@rempel-privat.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: RE: [PATCH v2 0/5] Add support of SECVIO from SNVS on iMX8q/x
Thread-Topic: [PATCH v2 0/5] Add support of SECVIO from SNVS on iMX8q/x
Thread-Index: AQHWX3J+1xpUtMqSvkqjt6wCaIeGsak9qgUAgAHu5ICAKDqcEA==
Date:   Mon, 14 Sep 2020 03:43:54 +0000
Message-ID: <AM6PR04MB4966164BC1ECC5119F2C2E7E80230@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <1595344835-67746-1-git-send-email-franck.lenormand@oss.nxp.com>
 <1597737122.73802.3.camel@oss.nxp.com> <20200819132317.GA7114@dragon>
In-Reply-To: <20200819132317.GA7114@dragon>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 17da4fa6-423a-4bbc-d070-08d85860673a
x-ms-traffictypediagnostic: AM6PR04MB5959:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB5959B7EC5CE8402C8DAAE07E80230@AM6PR04MB5959.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 61VBZQwG2CVWFyYf4c5uhd7iw/ro4B0b+TRbIez1EMcpfIOK7X8NBubyC+hoNIcCLmdy6b0KklCgEs0sBSFZlJhqjMH3QNekonjVZYzg5QI7Z7wtGJSB1ML9/vME+0+8UC0Y8z1LLY6UfQTEtKNmzpgz1M+jHjpvU2RoOVI4rR1M+PijF2y0SKFyE9SfyRx0PKF9LCjgHwtlwvyKU4DH20ai6xkxVzSIDNJChJMCBXId/z79JP+7dhQZYS3puL9T4iYy35+Wy0Gv76gzxuiETUlQnOagwdqKX0aQbsFyeYwILUA0c1pUZpDjrL57oSIHLNPxLpJ9uUTd1czQIAPEr7NT8tjlvAwhxQmNZkzzq0jXh3DpUQqINMyRF/9Z05DT
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(376002)(39860400002)(346002)(136003)(26005)(7696005)(2906002)(86362001)(478600001)(66946007)(66556008)(64756008)(66446008)(66476007)(8936002)(5660300002)(8676002)(316002)(52536014)(110136005)(54906003)(76116006)(4326008)(6506007)(55016002)(44832011)(186003)(83380400001)(71200400001)(9686003)(33656002)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 2Slw6REtCW4RLEXYLe/PdiJaURiHd1/Gzm8tIPtursvtr22455LstZH+REA++vQE4c8yQ3PGRLNOYbXrQ2V8kU0Gy0epvmcvk98Xnkpz7rSh2SSdGW5rE84afGetN2y9tidDdoc1SVLuEwDBo058FExuIrTi5FhJbQyw2oPBqQfHB1lYahkhmQ1NfRA+G+1SgUSsTnfulUyU2/6d+jyoGzzN+Q5G55d61gVa3SXUwJDTQ+w9KDkA5hU3sGpcBTDOsgFnZm1NtiEVmDy+65ECd+1vi0ZEhMDIy0k16z6izOAI4zisLy42NBrxPYOwRwpw7D0ASIeOyju3A2Cn40aDjCscWSsvVdeyOffUhvtVpK8DyuwETfBkHswW1uqL82ppMdSrlGq7KAinyFZjSxUR4vsR0Tk/IYv6nCmLJESMH7A3z54oRtpMmiWXwLwg/BziCSjxplB4dXlMABppmwA2yBKcU4KZsT61ZN6hcmkGTbXW3qVU6V2txf80AvWFWmCYV+wuG20OLUVvEH2ZYNjIs0BfIzWHfR2WpVvkGqS9kDkrWSFeAtPs/hdr61UuNYk7CqrpwElTFjTCw5CF/aGViG/grb0pgTwlXftlt4H/oHjMvCZqSTjqgq57HyCpAfR+Sa98DwVADkA+cEKXwr9igg==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4966.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17da4fa6-423a-4bbc-d070-08d85860673a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2020 03:43:54.4457
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: phPH43efYbnXoow2EKroc6GvEkBA36tPC0UuHEIIJWM+KyX3bRF+ypAMjT+6yfs1db5ZchpAumX4PtVoME1Utg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5959
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBTaGF3biBHdW8gPHNoYXduZ3VvQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IFdlZG5lc2Rh
eSwgQXVndXN0IDE5LCAyMDIwIDk6MjMgUE0NCj4gDQo+IE9uIFR1ZSwgQXVnIDE4LCAyMDIwIGF0
IDA5OjUyOjAyQU0gKzAyMDAsIEZyYW5jayBMRU5PUk1BTkQgKE9TUykgd3JvdGU6DQo+ID4gSGVs
bG8sDQo+ID4NCj4gPiBQZW5nIHdhcyBhYmxlIHRvIGRvIGEgZmlydCBwYXNzIG9mIHJldmlldyBv
biBteSBwYXRjaHNldCB3aGljaCBsZWQgdG8NCj4gPiB0aGlzIHNlY29uZCB2ZXJzaW9uLiBJIGhv
cGUgYSBtYWludGFpbmVyIHdpbGwgYmUgYWJsZSB0byB0YWtlIGEgbG9vaw0KPiA+IGF0IHRoaXMg
cGF0Y2hzZXQgb25jZSByZXN0ZWQgYWZ0ZXIgYWxsIHRoZSB3b3JrIHRoZXkgZGlkIGZvciA1Ljku
DQo+IA0KPiBAUGVuZywgYXJlIHlvdSBva2F5IHdpdGggdGhpcyB2ZXJzaW9uPw0KPiANCj4gQEFp
c2hlbmcsIGhhdmUgYSByZXZpZXcgb24gdGhpcz8NCg0KU29ycnksIGp1c3Qgbm90aWNlZCB0aGlz
Lg0KV2lsbCBmaW5kIGEgdGltZSB0byByZXZpZXcgdGhlc2UgdHdvIGRheXMuDQoNClJlZ2FyZHMN
CkFpc2hlbmcNCg0KPiANCj4gU2hhd24NCj4gDQo+ID4NCj4gPiBPbiBtYXIuLCAyMDIwLTA3LTIx
IGF0IDE3OjIwICswMjAwLCBmcmFuY2subGVub3JtYW5kQG9zcy5ueHAuY29tIHdyb3RlOg0KPiA+
ID4gRnJvbTogRnJhbmNrIExFTk9STUFORCA8ZnJhbmNrLmxlbm9ybWFuZEBvc3MubnhwLmNvbT4N
Cj4gPiA+DQo+ID4gPiBUaGlzIHBhdGNoc2V0IGFpbXMgdG8gYWRkIHN1cHBvcnQgZm9yIHRoZSBT
RUN1cml0eSBWSU9sYXRpb24NCj4gPiA+IChTRUNWSU8pIG9mIHRoZSBTTlZTLiBBIHNlY3ZpbyBp
cyBhIHNpZ25hbCBlbWl0dGVkIGJ5IHRoZSBTTlZTIHdoZW4NCj4gPiA+IGEgaGFyZHdhcmUgYXR0
YWNrIGlzIGRldGVjdGVkLiBPbiBpbXg4eCBhbmQgaW14OHEgU29DLCB0aGUgU05WUyBpcw0KPiA+
ID4gY29udHJvbGxlZCBieSB0aGUgU0VDTyBhbmQgaXQgaXMgcG9zc2libGUgdG8gaW50ZXJhY3Qg
d2l0aCBpdCB1c2luZyB0aGUgU0NVDQo+IHVzaW5nIHRoZSBTQyBBUElzLg0KPiA+ID4NCj4gPiA+
IEZvciB0aGUgZHJpdmVyIHRvIGNvbW11bmljYXRlIHdpdGggdGhlIFNOVlMgdmlhIHRoZSBTQ1Ug
YW5kIHRoZSBTRUNPLCBJDQo+IGhhZCB0bzoNCj4gPiA+IMKgLSBBZGQgc3VwcG9ydCBmb3IgZXhj
aGFuZ2Ugb2YgYmlnIG1lc3NhZ2Ugd2l0aCB0aGUgU0NVIChuZWVkZWQgZm9yDQo+ID4gPiBpbXhf
c2N1X2lycV9nZXRfc3RhdHVzKQ0KPiA+ID4gwqAtIEFkZCBBUEkgdG8gY2hlY2sgbGludXggY2Fu
IGNvbnRyb2wgdGhlIFNFQ1ZJTw0KPiA+ID4gKGlteF9zY19ybV9pc19yZXNvdXJjZV9vd25lZCkN
Cj4gPiA+IMKgLSBBZGQgQVBJcyBmb3IgdGhlIGRyaXZlciB0byByZWFkIHRoZSBzdGF0ZSBvZiB0
aGUgU0VDVklPIHJlZ2lzdGVycw0KPiA+ID4gb2YgdGhlIFNOVlMgYW5kIERHTyAoaW14X3NjX3Nl
Y29fc2VjdmlvX2VuYWJsZSBhbmQNCj4gaW14X3NjX3NlY29fc2VjdmlvX2VuYWJsZSkuDQo+ID4g
Pg0KPiA+ID4gVG8gY2hlY2sgdGhlIHN0YXRlIG9mIHRoZSBTRUNWSU8gSVJRIGluIHRoZSBTQ1Us
IEkgYWRkZWQgdGhlDQo+ID4gPiBpbXhfc2N1X2lycV9nZXRfc3RhdHVzIEFQSS4NCj4gPiA+DQo+
ID4gPiBUaGUgc2VjdmlvIGRyaXZlciBpcyBkZXNpZ25lZCB0byByZWNlaXZlIHRoZSBJUlEgcHJv
ZHVjZWQgYnkgdGhlDQo+ID4gPiBTTlZTIGluIGNhc2Ugb2YgaGFyZHdhcmUgYXR0YWNrIGFuZCBu
b3RpZnkgdGhlIHN0YXR1cyB0byB0aGUgYXVkaXQNCj4gPiA+IGZyYW1ld29yayB3aGljaCBjYW4g
YmUgdXNlZCBieSB0aGUgdXNlci4NCj4gPiA+DQo+ID4gPiBUaGUgZ29hbCBvZiB0aGUgZHJpdmVy
IGlzIHRvIGJlIHNlbGYgc3VmaWNpZW50IGJ1dCBjYW4gYmUgZXh0ZW5kZWQNCj4gPiA+IGJ5IHRo
ZSB1c2VyIHRvIHBlcmZvcm0gY3VzdG9tIG9wZXJhdGlvbnMgb24gdmFsdWVzIHJlYWQNCj4gPiA+
IChpbXhfc2Nfc2Vjb19zZWN2aW9fZW5hYmxlKQ0KPiA+ID4NCj4gPiA+IHYyOg0KPiA+ID4gwqAt
IFJlbW92ZWQgKGZpcm13YXJlOiBpbXg6IHNjdS1ybTogQWRkIFJlc291cmNlIE1hbmFnZW1lbnQg
QVBJcykNCj4gPiA+IAktPiBDb2RlIHJlcXVpcmVkIGlzIGFscmVhZHkgcHJlc2VudA0KPiA+ID4g
wqAtIFJlbW92ZWQgKGZpcm13YXJlOiBpbXg6IHNjdTogU3VwcG9ydCByZWNlcHRpb24gb2YgbWVz
c2FnZXMgb2YgYW55IHNpemUpDQo+ID4gPiAJLT4gVGhlIGlteC1zY3UgaXMgYWxyZWFkeSB3b3Jr
aW5nIGluIGZhc3QtaXBjIG1vZGUNCj4gPiA+IMKgLSAoc29jOiBpbXg4OiBBZGQgdGhlIFNDIFNF
Q1ZJTyBkcml2ZXIpOg0KPiA+ID4gCS0gRml4ZWQgdGhlIHdhcm5pbmdzIHJlcG9ydGVkIGJ5IGtl
cm5lbCB0ZXN0IHJvYm90DQo+ID4gPg0KPiA+ID4gRnJhbmNrIExFTk9STUFORCAoNSk6DQo+ID4g
PiDCoCBmaXJtd2FyZTogaW14OiBzY3Utc2VjbzogQWRkIFNFY3VyZSBDb250cm9sbGVyIEFQSVMN
Cj4gPiA+IMKgIGZpcm13YXJlOiBpbXg6IHNjdS1pcnE6IEFkZCBBUEkgdG8gcmV0cmlldmUgc3Rh
dHVzIG9mIElSUQ0KPiA+ID4gwqAgZHQtYmluZGluZ3M6IGZpcm13YXJlOiBpbXgtc2N1OiBBZGQg
U0VDVklPIHJlc291cmNlDQo+ID4gPiDCoCBkdC1iaW5kaW5nczogYXJtOiBpbXg6IERvY3VtZW50
YXRpb24gb2YgdGhlIFNDIHNlY3ZpbyBkcml2ZXINCj4gPiA+IMKgIHNvYzogaW14ODogQWRkIHRo
ZSBTQyBTRUNWSU8gZHJpdmVyDQo+ID4gPg0KPiA+ID4gwqAuLi4vYmluZGluZ3MvYXJtL2ZyZWVz
Y2FsZS9mc2wsaW14LXNjLXNlY3Zpby55YW1swqDCoHzCoMKgMzQgKw0KPiA+ID4gwqBkcml2ZXJz
L2Zpcm13YXJlL2lteC9NYWtlZmlsZcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgfMKgwqDCoDIgKy0NCj4gPiA+IMKgZHJpdmVycy9maXJtd2FyZS9pbXgvaW14LXNj
dS1pcnEuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB8wqDCoDM3ICstDQo+ID4g
PiDCoGRyaXZlcnMvZmlybXdhcmUvaW14L2lteC1zY3UuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoHzCoMKgwqAzICsNCj4gPiA+IMKgZHJpdmVycy9maXJtd2FyZS9p
bXgvc2Vjby5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
fCAyNzUNCj4gKysrKysrKw0KPiA+ID4gwqBkcml2ZXJzL3NvYy9pbXgvS2NvbmZpZ8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfMKgwqAxMCAr
DQo+ID4gPiDCoGRyaXZlcnMvc29jL2lteC9NYWtlZmlsZcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHzCoMKgwqAxICsNCj4gPiA+IMKgZHJpdmVy
cy9zb2MvaW14L3NlY3Zpby9LY29uZmlnwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgfMKgwqAxMCArDQo+ID4gPiDCoGRyaXZlcnMvc29jL2lteC9zZWN2aW8vTWFrZWZp
bGXCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfMKgwqDCoDMgKw0KPiA+
ID4gwqBkcml2ZXJzL3NvYy9pbXgvc2VjdmlvL2lteC1zZWN2aW8tYXVkaXQuY8KgwqDCoMKgwqDC
oMKgwqDCoMKgfMKgwqAzOSArDQo+ID4gPiDCoGRyaXZlcnMvc29jL2lteC9zZWN2aW8vaW14LXNl
Y3Zpby1kZWJ1Z2ZzLmPCoMKgwqDCoMKgwqDCoMKgfCAzNzkgKysrKysrKysrDQo+ID4gPiDCoGRy
aXZlcnMvc29jL2lteC9zZWN2aW8vaW14LXNlY3Zpby1zYy1pbnQuaMKgwqDCoMKgwqDCoMKgwqDC
oHzCoMKgODQgKysNCj4gPiA+IMKgZHJpdmVycy9zb2MvaW14L3NlY3Zpby9pbXgtc2VjdmlvLXNj
LmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHwgODU4DQo+ID4gPiArKysrKysrKysrKysrKysr
KysrKysNCj4gPiA+IMKgaW5jbHVkZS9kdC1iaW5kaW5ncy9maXJtd2FyZS9pbXgvcnNyYy5owqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgfMKgwqDCoDMgKy0NCj4gPiA+IMKgaW5jbHVkZS9saW51eC9m
aXJtd2FyZS9pbXgvaXBjLmjCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHzC
oMKgwqAxICsNCj4gPiA+IMKgaW5jbHVkZS9saW51eC9maXJtd2FyZS9pbXgvc2NpLmjCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHzCoMKgwqA1ICsNCj4gPiA+IMKgaW5jbHVk
ZS9saW51eC9maXJtd2FyZS9pbXgvc3ZjL3NlY28uaMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqB8wqDCoDczICsrDQo+ID4gPiDCoGluY2x1ZGUvc29jL2lteC9pbXgtc2VjdmlvLXNjLmjCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfCAxNzcgKysrKysNCj4gPiA+IMKg
MTggZmlsZXMgY2hhbmdlZCwgMTk5MSBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiA+
ID4gwqBjcmVhdGUgbW9kZSAxMDA2NDQNCj4gPiA+IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9hcm0vZnJlZXNjYWxlL2ZzbCxpbXgtc2MtDQo+ID4gPiBzZWN2aW8ueWFtbA0KPiA+
ID4gwqBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9maXJtd2FyZS9pbXgvc2Vjby5jDQo+ID4g
PiDCoGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3NvYy9pbXgvc2VjdmlvL0tjb25maWcNCj4g
PiA+IMKgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvc29jL2lteC9zZWN2aW8vTWFrZWZpbGUN
Cj4gPiA+IMKgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvc29jL2lteC9zZWN2aW8vaW14LXNl
Y3Zpby1hdWRpdC5jDQo+ID4gPiDCoGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3NvYy9pbXgv
c2VjdmlvL2lteC1zZWN2aW8tZGVidWdmcy5jDQo+ID4gPiDCoGNyZWF0ZSBtb2RlIDEwMDY0NCBk
cml2ZXJzL3NvYy9pbXgvc2VjdmlvL2lteC1zZWN2aW8tc2MtaW50LmgNCj4gPiA+IMKgY3JlYXRl
IG1vZGUgMTAwNjQ0IGRyaXZlcnMvc29jL2lteC9zZWN2aW8vaW14LXNlY3Zpby1zYy5jDQo+ID4g
PiDCoGNyZWF0ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL2xpbnV4L2Zpcm13YXJlL2lteC9zdmMvc2Vj
by5oDQo+ID4gPiDCoGNyZWF0ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL3NvYy9pbXgvaW14LXNlY3Zp
by1zYy5oDQo+ID4gPg0KPiA+DQo=

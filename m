Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEC6D2915F0
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Oct 2020 06:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbgJREuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Oct 2020 00:50:16 -0400
Received: from mail-eopbgr10059.outbound.protection.outlook.com ([40.107.1.59]:35577
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725306AbgJREuP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Oct 2020 00:50:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BL1TU4sB7h3a7lq3iT8ZEVc0Zch3M/2ZxVGCrgJEOiJqJiXfc1k+mjET/dnQDB3GFj1ETVKrYeMV4WtxWEypKatB42/1XtyfCxoDQaYcOmme6D2ZF2aEE1lbreiFC6QcD4n3DGZQiwTgJFO/5TxvlcRXL2Aa4rutXyljEmz0gYXhS4oJnKhv9VBNChsU0yJu66vXlbJsoG7CTIkLb4BM1x9junCRDj7BGnc81d3BCVQ/pBi9whB6zQuv0T2FcKPwuBfGml/S3cZELtSXBillbGd4owa+7zUp1EJ/A/muBT8NpAuDJB7uB1l1+2jnbekuDBUAyFb8TXFJydXRW7Jmhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iw8jQszFPDUulRJ8cHZQP9wUBHzcIfTLjbXP6w1yuS4=;
 b=YqCZcb3BwkKUV4R+ynE6wVvLms2c+ARdfuR+rtkHQX35BQHpfLjYjHj078xG6W2f0Gd7NMciBrhtHFRAIXHjnKhONyumHSEKX9fh3utWyNy8rTI3ynZy4yzBGXEBauLhArx1YajKj4VcrYkHywE4luxY9aZbxDqByFDxFeWd2niAL+dfVhwKyZVl/2X8WPCajhX06Udv8a+v5yUGagIqBBgv2TLCNU/uBt09H+Ac/0Q5QM3zihmCQvUNiFi0Rlx90P0yPXo9qAU0NdC63AxUlUbYUZsShcC5UlSQrmGXYHJN1t2soEOB5vvet2awPgdYcfcGUNY7KKhQpeRS3Tz2tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iw8jQszFPDUulRJ8cHZQP9wUBHzcIfTLjbXP6w1yuS4=;
 b=SVQIxIsELS0jcS7jma22qjCGnxHbT5TGkAxsDl5rWKb/1pRmbZ+Xln3xa0Xanl0TpM2KfqOoPI5AR/MtUG8PO2hkIMsAyoJWh7pb2q7ozcESntFu+RE8n0P4/lvt0Xdqari89U6XwNrV+CBfAhmeHjzflx/YsZfmoduDycip3Tk=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR04MB4039.eurprd04.prod.outlook.com (2603:10a6:209:4d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21; Sun, 18 Oct
 2020 04:50:11 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::546f:92f0:f3c5:a148]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::546f:92f0:f3c5:a148%7]) with mapi id 15.20.3477.028; Sun, 18 Oct 2020
 04:50:11 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     "Franck Lenormand (OSS)" <franck.lenormand@oss.nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
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
Subject: RE: [PATCH v2 3/5] dt-bindings: firmware: imx-scu: Add SECVIO
 resource
Thread-Topic: [PATCH v2 3/5] dt-bindings: firmware: imx-scu: Add SECVIO
 resource
Thread-Index: AQHWX3J/3Dzoo2xys0eFqqWxSTHg/qmdVSaA
Date:   Sun, 18 Oct 2020 04:50:11 +0000
Message-ID: <AM6PR04MB496609987D66264026D49DAE80010@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <1595344835-67746-1-git-send-email-franck.lenormand@oss.nxp.com>
 <1595344835-67746-4-git-send-email-franck.lenormand@oss.nxp.com>
In-Reply-To: <1595344835-67746-4-git-send-email-franck.lenormand@oss.nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oss.nxp.com; dkim=none (message not signed)
 header.d=none;oss.nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c527df53-42d7-4559-e380-08d873214b8f
x-ms-traffictypediagnostic: AM6PR04MB4039:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB4039DFF08B3D7A70139F90A280010@AM6PR04MB4039.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eu4/XZsKW3qGp+zRxT4PzrwQ7IruM32QeFOPQuuNEdwGxKH1Qpb+NwrWGQPGrQRKUadtJUW6vth37LCHtE/KIOQ+vX3aJrIVXgAbnjyKnQRBPUgt4l7VfpHeHr/Hl9ocqeh52pvi4agOMLw3Fr63oMrx4ycbwtovQdfVqwck6RcwL+B2MFoIH2bGVP0VozLILrywX2ktrzoy5ofls8/7QbVatRSRVrPMLCG0WbJk8zcXh3JmeFdDtTPImE+D0AozJDf628Rja//Uk6GBfD0HxY/YZIEDKzXpxDvXTelu9u5IeH7VdC4HYuIhkCNeMiGJCdYNJpfJaW5UtZKvKtiC7w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(396003)(39850400004)(376002)(136003)(52536014)(83380400001)(5660300002)(86362001)(9686003)(4326008)(478600001)(54906003)(44832011)(110136005)(8936002)(66946007)(66476007)(76116006)(33656002)(186003)(8676002)(316002)(66556008)(64756008)(66446008)(6506007)(55016002)(71200400001)(2906002)(7696005)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: ngetb8t1FI8dH6yfWay+WxkxU7WOKmQrpwkF710rnsz1T7wT4v0Ex6isOGnrPNLycd03KxkPoU/l7QeKyuKhgEBMVnPzAJ+1FvnWuwUW3Q8dMMYqL6kI/AEpFIVR/q4q2yX4mkfL9WqDjePFQDePQULHxgmxI5InE7A544kLbLc0LlsBQTDTeTanySsZLa/ZtUAEQ5ZypeCCvaDKpKP+H3L/UDuMpf1kKGbSFb+YX+m9TItWJJ2daccDFpe30vfl4vX3zL5KPdDHZQ221sG2bRRM1SUr2YUaT5jDcuOZpprQdHDxYANGZwuJTXQUdgiPBxK1KsUuVj+vd1+Mjt9vnXrC2A4xcXNM+UkwnDbJ6V/QUbneEcpahhX0Vip66O8lET/g7b2lubpvPVMC3TYHXIiV2ZI8WCNF8rnkjYpDq3vN8I63xH6lWnxdOTDYFW/7I3maYnPMCO405++WeuEMUKt4d0aKjexR/jITOlLhPlrN0bfCS5rANKlo3S26lJp8aiV0HqyLOSjKERIK2j39Y6gLEoj9waTeWR73eTYJrGDY+zspNtdDIs4wEDAsm4JDcpJXYRFnQ0NPWQHQr3NQynGoTwtx4+fs80O0nwQcAMKL8Jworq1BGcPUFQPrRVnuYeH2c1efmccYKeBGLxk+4g==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4966.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c527df53-42d7-4559-e380-08d873214b8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2020 04:50:11.0372
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U1fSVDj/h3ECOMiMbAF3lj2M88Gs3BSFLet9fXIwihmYNiQ7RcSww73fApRZBupeBtLmQY83U0UpnaeU4EAagw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4039
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBGcmFuY2sgTGVub3JtYW5kIChPU1MpIDxmcmFuY2subGVub3JtYW5kQG9zcy5ueHAu
Y29tPg0KPiBTZW50OiBUdWVzZGF5LCBKdWx5IDIxLCAyMDIwIDExOjIxIFBNDQo+IA0KPiBUaGUg
U05WUyBjYW4gdHJpZ2dlciBpbnRlcnJ1cHRpb24gd2hlbiBkZXRlY3RpbmcgYSBTRUN1cml0eSBW
SU9sYXRpb24uDQo+IFRoaXMgcGF0Y2ggYWRkcyB0aGUgZGVmaW5pdGlvbiBvZiB0aGUgcmVzb3Vy
Y2UuDQo+IA0KDQpOb3Qgc3VyZSBpZiB0aGUgdXBwZXJjYXNlIG9mICdTRUN1cml0eSBWSU9sYXRp
b24nIGlzIGludGVuZGVkIGJlY2F1c2UgaXQgbG9va3Mgc3RyYW5nZS4NCk90aGVyd2lzZSwgSSdt
IG9rYXkgd2l0aCB0aGlzIHBhdGNoLg0KDQpSZWdhcmRzDQpBaXNoZW5nDQoNCj4gU2lnbmVkLW9m
Zi1ieTogRnJhbmNrIExFTk9STUFORCA8ZnJhbmNrLmxlbm9ybWFuZEBvc3MubnhwLmNvbT4NCj4g
LS0tDQo+ICBpbmNsdWRlL2R0LWJpbmRpbmdzL2Zpcm13YXJlL2lteC9yc3JjLmggfCAzICsrLQ0K
PiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4g
ZGlmZiAtLWdpdCBhL2luY2x1ZGUvZHQtYmluZGluZ3MvZmlybXdhcmUvaW14L3JzcmMuaA0KPiBi
L2luY2x1ZGUvZHQtYmluZGluZ3MvZmlybXdhcmUvaW14L3JzcmMuaA0KPiBpbmRleCA1NDI3OGQ1
Li5mZTVmMjVmIDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL2R0LWJpbmRpbmdzL2Zpcm13YXJlL2lt
eC9yc3JjLmgNCj4gKysrIGIvaW5jbHVkZS9kdC1iaW5kaW5ncy9maXJtd2FyZS9pbXgvcnNyYy5o
DQo+IEBAIC0xLDcgKzEsNyBAQA0KPiAgLyogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0y
LjArICovDQo+ICAvKg0KPiAgICogQ29weXJpZ2h0IChDKSAyMDE2IEZyZWVzY2FsZSBTZW1pY29u
ZHVjdG9yLCBJbmMuDQo+IC0gKiBDb3B5cmlnaHQgMjAxNy0yMDE4IE5YUA0KPiArICogQ29weXJp
Z2h0IDIwMTctMjAxOCwgMjAyMCBOWFANCj4gICAqLw0KPiANCj4gICNpZm5kZWYgX19EVF9CSU5E
SU5HU19SU0NSQ19JTVhfSA0KPiBAQCAtNTAsNiArNTAsNyBAQA0KPiAgI2RlZmluZSBJTVhfU0Nf
Ul9EQ18xX0JMSVQyCQkzOA0KPiAgI2RlZmluZSBJTVhfU0NfUl9EQ18xX0JMSVRfT1VUCQkzOQ0K
PiAgI2RlZmluZSBJTVhfU0NfUl9EQ18xX1dBUlAJCTQyDQo+ICsjZGVmaW5lIElNWF9TQ19SX1NF
Q1ZJTwkJCTQ0DQo+ICAjZGVmaW5lIElNWF9TQ19SX0RDXzFfVklERU8wCQk0NQ0KPiAgI2RlZmlu
ZSBJTVhfU0NfUl9EQ18xX1ZJREVPMQkJNDYNCj4gICNkZWZpbmUgSU1YX1NDX1JfRENfMV9GUkFD
MAkJNDcNCj4gLS0NCj4gMi43LjQNCg0K

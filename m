Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF9B2915EF
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Oct 2020 06:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbgJREsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Oct 2020 00:48:50 -0400
Received: from mail-eopbgr80052.outbound.protection.outlook.com ([40.107.8.52]:61374
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725306AbgJREsu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Oct 2020 00:48:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M60N0mE7mN9kp+Ox1Z1xBpx999bwBHaBSWifRp/oJbH3UVIX0FDSzb8mg1WoMnfnzDVN3383lDaE5pCaYUouxzwg1Z+Gu4dO7+6DFzeJr7Viosqkum2gt9OnSZNkNW1X501K6OD3jNbFosl2qDTnLjFumGfbEks1ZFmqNtSaZ2b+EWJfX0wkYvTLCpyD4VYs7ywvtj77UTF+DGGvXY/yUj0QQFxsPBtL1XN1/wPcqcRl5JkLL18AGsJUMKCAMKHJ/X4VuTqLUpn7ypua4YLV2fj10+iiCwf35n0KSf0MpTjVoFevOeE9oU1Qn2UkMtQ3oZF2Vchv3lEbPViGTzPT5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tTk4PusRGNTeJSJIFdZdMFTJxsNJqn+4hf6bhWNWQ5Q=;
 b=WbBeij0Yo0kPiSbhXdDbcm/emQGJG3LhaHnkK5b//kdzet8attNSVRySeAsxFTrDVGWXMp5cttJI2glagX7/vfrxvicYMG0GsoMi70KFMJOA/dtd2DrxEUpxO2mmOPr28kpQCzo6gkbK031aK0CLHXaPrgvlB0RXkVjikeu/bc3rOq5/Tuy21XufhhHz507BVH9f/eUXxijqXMTn56y/IaWXKdMID7Frk/tqq81xBhDyLxwyOILYI9NNakEJevkxgetYZsrGP5emCK2hDWwJi9+/mtdZNzuhHq+8AOz31IKXWGfs6cdwtPY+j/MdZdvpcB6xd7eFuQNP+DXKKXFufg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tTk4PusRGNTeJSJIFdZdMFTJxsNJqn+4hf6bhWNWQ5Q=;
 b=I0EVZkuqWCwUn2idq85BaWbu36aiLvjvSHpGbxKU1H2sd2S04tr/bKNl+0hzIh8Q+fn49mctdonidU6ljP6C5VAy3tt5YIbE9gTHRtVLX3V0OAUs3XTi1P6oNoJYD46bxRZNe6HIVV5bBu/+Q3StgALzrQuJk7tOfz66wSqj/cA=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR04MB4743.eurprd04.prod.outlook.com (2603:10a6:20b:2::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.28; Sun, 18 Oct
 2020 04:48:44 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::546f:92f0:f3c5:a148]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::546f:92f0:f3c5:a148%7]) with mapi id 15.20.3477.028; Sun, 18 Oct 2020
 04:48:44 +0000
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
Subject: RE: [PATCH v2 2/5] firmware: imx: scu-irq: Add API to retrieve status
 of IRQ
Thread-Topic: [PATCH v2 2/5] firmware: imx: scu-irq: Add API to retrieve
 status of IRQ
Thread-Index: AQHWX3J+c65JmmpOO0GL4uPYN5ipXKmdVC0w
Date:   Sun, 18 Oct 2020 04:48:44 +0000
Message-ID: <AM6PR04MB4966953E346F9C0BF9BC581780010@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <1595344835-67746-1-git-send-email-franck.lenormand@oss.nxp.com>
 <1595344835-67746-3-git-send-email-franck.lenormand@oss.nxp.com>
In-Reply-To: <1595344835-67746-3-git-send-email-franck.lenormand@oss.nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oss.nxp.com; dkim=none (message not signed)
 header.d=none;oss.nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d6d17bc8-1946-4ed3-5f74-08d8732117c6
x-ms-traffictypediagnostic: AM6PR04MB4743:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB47430ED5CA2F8B315F00BF6880010@AM6PR04MB4743.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:499;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MRR1BXDJTPKCfRFa5EOeEqSGsmLS6Z6AstTN7OIjmFCAjd8kqpVdfIVCcyp9yUuCaCtH4/LCtMkYpXGovd73kuZSPHLH5i0w30z7m500Ey/V23wPRaf5L1I3bGMOTpeREVa8NMMbGnNKpFgfDqdhPZeDbY+fDRQrtNNFbRARvmoGgzaFh2erof7usL+EWovYdOgNmPkDTJZXFzgKM4FSrGxleq1oXXCSvg3/+b2xxlQWDslyA/wt1C0WgnwgCNvBAHiPf2IMBqF0fe4H1pw/b8cwFG72OIgWIAHJF9puwaCefJHqhmikSz43BjXxrywWRhgIVRFFjdbtkOXjSPYt5Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39850400004)(346002)(376002)(366004)(396003)(26005)(9686003)(186003)(4326008)(6506007)(66476007)(33656002)(2906002)(83380400001)(55016002)(52536014)(66556008)(8936002)(66946007)(66446008)(7696005)(86362001)(64756008)(44832011)(54906003)(110136005)(71200400001)(76116006)(316002)(8676002)(478600001)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 6vJBDlmikL0axUMD6JVPuZdZSjvJTu5mGPGwWTQQdXtLLVytQguKm78GJQXV1jGoxhnoSGRYEF7yY8TYyU1DcvolDA/HaA/yh6ekolWWTKDfHqijpuWGdGY9Ls2HBSJ9EkcASggVCHG8DjUyy+dVI+1Hn8uawGmpv/+0UbEBZVQAxgL9a5r5OfS1fonFzNMv63iRCXDF/muxrLggVy5HND/RfIDkhM1dLKD3LWYnt3AglauSsV+qRxy7CutW9m4Z5M3zzOGJ9OEBDSJFYbpVsgYaPVuNGsFMYze0T9sFIk52G4VRoeP+OhQabypCWfCBXkjM8jlPXTA6mLYwsflFALmCG7sKa19eBTmWj7YY6C2iY7g/hj/Gle0QcFX3HCLQWS90j2Nq2wVpnposLzlGRL5Q1bYOZgQoIUtEe5uFyOvd1x2qzOBeiT5S7OUeCVy5utNHee0qgJmgQ1UVIPZB4vlxCMGQ996bjUZOx8P7FQuJiISvwCZ/AVLo4h1HFHgMCYTnTQN7dEOa5JCSwRJattoDKz1Q9WXJ10jp+q5r/zbAuX4FMu2HaGOogd196lINudAqLqvwI5ihlnKgGuLudQt6d+cKbvY/Cwr5zqAOPsUSu/02iDc/fOQ11pk7HEpCMmOCfqWbGwSmDcZ3eIdiuA==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4966.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6d17bc8-1946-4ed3-5f74-08d8732117c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2020 04:48:44.0997
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KXS1vXgkEd+wd15hCqArCd3IEFmyM1HDzzmX8ukA1rLKSTth9Dq6t+IMSl5MvpDtQ0oiXxvgFMf3NSHavxXPPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4743
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBGcmFuY2sgTGVub3JtYW5kIChPU1MpIDxmcmFuY2subGVub3JtYW5kQG9zcy5ueHAu
Y29tPg0KPiBTZW50OiBUdWVzZGF5LCBKdWx5IDIxLCAyMDIwIDExOjIxIFBNDQo+IA0KPiBUaGlz
IHBhdGNoIGFkZHMgdGhlIEFQSSB0byByZXRyaWV2ZSB0aGUgc3RhdHVzIG9mIGFuIElSUS4NCj4g
DQo+IEl0IGFsc28gYWRkcyB2YWx1ZXMgdXNlZCB0byBwcm9jZXNzIFNFQ1ZJTyBJUlEgZnJvbSB0
aGUgU0NVLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogRnJhbmNrIExFTk9STUFORCA8ZnJhbmNrLmxl
bm9ybWFuZEBvc3MubnhwLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2Zpcm13YXJlL2lteC9pbXgt
c2N1LWlycS5jIHwgMzcNCj4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLQ0K
PiAgaW5jbHVkZS9saW51eC9maXJtd2FyZS9pbXgvc2NpLmggICB8ICA0ICsrKysNCj4gIDIgZmls
ZXMgY2hhbmdlZCwgNDAgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvZmlybXdhcmUvaW14L2lteC1zY3UtaXJxLmMNCj4gYi9kcml2ZXJzL2Zp
cm13YXJlL2lteC9pbXgtc2N1LWlycS5jDQo+IGluZGV4IGQ5ZGNjMjAuLmQzMWQ2MDAgMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvZmlybXdhcmUvaW14L2lteC1zY3UtaXJxLmMNCj4gKysrIGIvZHJp
dmVycy9maXJtd2FyZS9pbXgvaW14LXNjdS1pcnEuYw0KPiBAQCAtMSw2ICsxLDYgQEANCj4gIC8v
IFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wKw0KPiAgLyoNCj4gLSAqIENvcHlyaWdo
dCAyMDE5IE5YUA0KPiArICogQ29weXJpZ2h0IDIwMTktMjAyMCBOWFANCj4gICAqDQo+ICAgKiBJ
bXBsZW1lbnRhdGlvbiBvZiB0aGUgU0NVIElSUSBmdW5jdGlvbnMgdXNpbmcgTVUuDQo+ICAgKg0K
PiBAQCAtOTcsNiArOTcsNDEgQEAgc3RhdGljIHZvaWQgaW14X3NjdV9pcnFfd29ya19oYW5kbGVy
KHN0cnVjdA0KPiB3b3JrX3N0cnVjdCAqd29yaykNCj4gIAl9DQo+ICB9DQo+IA0KPiArLyoqDQo+
ICsgKiBpbXhfc2N1X2lycV9nZXRfc3RhdHVzKCkgLSBHZXQgdGhlIHN0YXR1cyBvZiB0aGUgSVJR
cyBvZiBhIGdyb3VwDQoNClRoaXMgQVBJIGlzIGEgbGl0dGxlIGR1cGxpY2F0ZWQgd2l0aCB0aGUg
ZXhpc3QgaW14X3NjdV9pcnFfd29ya19oYW5kbGVyLg0KQ2FuIHdlIHJlZmFjdG9yIHRoZSBleGlz
dCBjb2RlIGludG8gdGhpcyBBUEk/DQoNClJlZ2FyZHMNCkFpc2hlbmcNCg0KPiArICoNCj4gKyAq
IEBncm91cDogVGhlIGdyb3VwIG9mIElSUSB0byByZXRyaWV2ZSBzdGF0dXMNCj4gKyAqIEBpcnFf
c3RhdHVzOiBTdGF0dXMgb2YgdGhlIElSUXMgcmV0cmlldmVkDQo+ICsgKg0KPiArICogUmV0dXJu
Og0KPiArICogMCAtIE9LDQo+ICsgKiA8IDAgLSBlcnJvci4NCj4gKyAqLw0KPiAraW50IGlteF9z
Y3VfaXJxX2dldF9zdGF0dXModTggZ3JvdXAsIHUzMiAqaXJxX3N0YXR1cykgew0KPiArCXN0cnVj
dCBpbXhfc2NfbXNnX2lycV9nZXRfc3RhdHVzIG1zZzsNCj4gKwlzdHJ1Y3QgaW14X3NjX3JwY19t
c2cgKmhkciA9ICZtc2cuaGRyOw0KPiArCWludCByZXQ7DQo+ICsNCj4gKwloZHItPnZlciA9IElN
WF9TQ19SUENfVkVSU0lPTjsNCj4gKwloZHItPnN2YyA9IElNWF9TQ19SUENfU1ZDX0lSUTsNCj4g
KwloZHItPmZ1bmMgPSBJTVhfU0NfSVJRX0ZVTkNfU1RBVFVTOw0KPiArCWhkci0+c2l6ZSA9IDI7
DQo+ICsNCj4gKwltc2cuZGF0YS5yZXEucmVzb3VyY2UgPSBtdV9yZXNvdXJjZV9pZDsNCj4gKwlt
c2cuZGF0YS5yZXEuZ3JvdXAgPSBncm91cDsNCj4gKw0KPiArCXJldCA9IGlteF9zY3VfY2FsbF9y
cGMoaW14X3NjX2lycV9pcGNfaGFuZGxlLCAmbXNnLCB0cnVlKTsNCj4gKwlpZiAocmV0KQ0KPiAr
CQlyZXR1cm4gcmV0Ow0KPiArDQo+ICsJaWYgKGlycV9zdGF0dXMpDQo+ICsJCSppcnFfc3RhdHVz
ID0gbXNnLmRhdGEucmVzcC5zdGF0dXM7DQo+ICsNCj4gKwlyZXR1cm4gMDsNCj4gK30NCj4gK0VY
UE9SVF9TWU1CT0woaW14X3NjdV9pcnFfZ2V0X3N0YXR1cyk7DQo+ICsNCj4gIGludCBpbXhfc2N1
X2lycV9ncm91cF9lbmFibGUodTggZ3JvdXAsIHUzMiBtYXNrLCB1OCBlbmFibGUpICB7DQo+ICAJ
c3RydWN0IGlteF9zY19tc2dfaXJxX2VuYWJsZSBtc2c7DQo+IGRpZmYgLS1naXQgYS9pbmNsdWRl
L2xpbnV4L2Zpcm13YXJlL2lteC9zY2kuaCBiL2luY2x1ZGUvbGludXgvZmlybXdhcmUvaW14L3Nj
aS5oDQo+IGluZGV4IDkxNGRjZTEuLjIwYTE2YTcgMTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUvbGlu
dXgvZmlybXdhcmUvaW14L3NjaS5oDQo+ICsrKyBiL2luY2x1ZGUvbGludXgvZmlybXdhcmUvaW14
L3NjaS5oDQo+IEBAIC0xNyw5ICsxNywxMyBAQA0KPiAgI2luY2x1ZGUgPGxpbnV4L2Zpcm13YXJl
L2lteC9zdmMvcm0uaD4NCj4gICNpbmNsdWRlIDxsaW51eC9maXJtd2FyZS9pbXgvc3ZjL3NlY28u
aD4NCj4gDQo+ICsjZGVmaW5lIElNWF9TQ19JUlFfR1JPVVBfV0FLRSAgICAgICAzVSAvKiBXYWtl
dXAgaW50ZXJydXB0cyAqLw0KPiArI2RlZmluZSBJTVhfU0NfSVJRX1NFQ1ZJTyAgICAgICAgICAg
IEJJVCg2KSAgICAvKiBTZWN1cml0eSB2aW9sYXRpb24gKi8NCj4gKw0KPiAgaW50IGlteF9zY3Vf
ZW5hYmxlX2dlbmVyYWxfaXJxX2NoYW5uZWwoc3RydWN0IGRldmljZSAqZGV2KTsgIGludA0KPiBp
bXhfc2N1X2lycV9yZWdpc3Rlcl9ub3RpZmllcihzdHJ1Y3Qgbm90aWZpZXJfYmxvY2sgKm5iKTsg
IGludA0KPiBpbXhfc2N1X2lycV91bnJlZ2lzdGVyX25vdGlmaWVyKHN0cnVjdCBub3RpZmllcl9i
bG9jayAqbmIpOyAgaW50DQo+IGlteF9zY3VfaXJxX2dyb3VwX2VuYWJsZSh1OCBncm91cCwgdTMy
IG1hc2ssIHU4IGVuYWJsZSk7ICBpbnQNCj4gaW14X3NjdV9zb2NfaW5pdChzdHJ1Y3QgZGV2aWNl
ICpkZXYpOw0KPiAraW50IGlteF9zY3VfaXJxX2dldF9zdGF0dXModTggZ3JvdXAsIHUzMiAqaXJx
X3N0YXR1cyk7DQo+ICAjZW5kaWYgLyogX1NDX1NDSV9IICovDQo+IC0tDQo+IDIuNy40DQoNCg==

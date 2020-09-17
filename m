Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00E6F26D162
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 05:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgIQDB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 23:01:29 -0400
Received: from mail-eopbgr130075.outbound.protection.outlook.com ([40.107.13.75]:19766
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725886AbgIQDBR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 23:01:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lroE9DtWzcj8G+l6xubZ0GFIquudIPhL8HeITmukbW9wQfPR6ZDqQF4uR6n35ZQVQr0w0R7/iS5iNILB3q3+NlfWQW/DsOWJzkyctkCQMSO1C+aVLInroG41rAUnl8wEh5KubdwSaldmLq8ISHzkAbJqUQKQKfgsPPZFSasAkPd7N3CjhHiCGdGCZmplrIrypjoJmaS2HbRsnfRYTBS5QAIKFeWPK2vWJal7qJBEw1mI+afuIUi6ibg23hA28KZisP31JwuL0JX9sxPMxP+Laa6cEDDZBUPC4eN9rFSBzsyZk7/rgxkJgXSQ81mWUFGya7/QTPYyEwUhFMKd5HLJWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eLyrN9vJGl9/jrvp0tF+mS23RoNLJdJAXJJilca2Puc=;
 b=LNgMt3dGYDh99vo4COC5gJiNptxrzojLpEcuadIfMKJJx2UH0KX1fjy+aVuERw5YshtpUB+t6hZ0g9bDyjpPFotbBIHbJs64iFGlAX7hHUE2QVnGtk0ac41q8IttOxw9pCIDSGDj2dBv+5IarpiQR49aCMrWLlXvMY76s9V1ZhKCwDe8GCCfzLonXbEF2dAqQpE8XpfS1SKnXOU935bn+afMoz8b3KngrEu+x0+VWzkrPN2KLoGHVTxxbBbV/z4CPiMOlNMqaKqFUpCFnmJuwnhJklfVgvGLbQwBCDXnKWYO/3Z1elfHEkrGBhGroLrsaaHf4PmrEfyT088k5ND+jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eLyrN9vJGl9/jrvp0tF+mS23RoNLJdJAXJJilca2Puc=;
 b=OdprTIIjflsB6UqinUmpONAU855W9t1SDhOGoJz9ekeXXuyabES4qNmrn6kFT+iSWzpdpCfcLG6Huma7FJKV9PpgFoS4BmzPdF9nALGvvKQ053fXG8TSpekFvNmS8QHJKx9KdgvIOeG4nn8q56UMuLVCNx52hEwpmDW2EDj2wF4=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR04MB5078.eurprd04.prod.outlook.com (2603:10a6:20b:5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Thu, 17 Sep
 2020 03:01:12 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::99b5:145d:16cc:78ca]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::99b5:145d:16cc:78ca%3]) with mapi id 15.20.3370.019; Thu, 17 Sep 2020
 03:01:12 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Peng Fan <peng.fan@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH V2 1/4] dt-bindings: fsl: add i.MX7ULP PMC
Thread-Topic: [PATCH V2 1/4] dt-bindings: fsl: add i.MX7ULP PMC
Thread-Index: AQHWi9TbeXHyJ06ir0KaWquGGXBEbKlsJcqw
Date:   Thu, 17 Sep 2020 03:01:12 +0000
Message-ID: <AM6PR04MB4966A1F9CD6CFC7188C891E8803E0@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <1600224517-31465-1-git-send-email-peng.fan@nxp.com>
 <1600224517-31465-2-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1600224517-31465-2-git-send-email-peng.fan@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e0c67564-8a06-46a6-c272-08d85ab5ef4e
x-ms-traffictypediagnostic: AM6PR04MB5078:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB507866FFFC2DDCA82499BBD7803E0@AM6PR04MB5078.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:525;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: upLxaGlUaMLIAzy4nLgQ10A4wIMmM6f0gL2OmD1Ayo1YUwzGXSj3pBrR9KWzogQDpjB8Vd8GuZ1m3Z63BkSZyc88rWxqY0oYoKllKSOlxGESHrKLArZuc127qR/yyQ3klmuxX/+gXU2mvAQnlRmOnot5MM/2+cdukFBBaX2DizDEwZps+SNj91d7GaVSt6aB0uJfmwY3lizyRx8ENF7uJJ+ihhZXZHzJy2U81aAKK6EKMFBdpjRDn+Oe1JhtoF3ZJdmOTOkVxQXFSc6MkZs3FLwtiHbjyOCr78pEhYjXUXAGNGx4fkdCA3+ftqpmTfJ2v2Gj8XTYaH7knfW2/aNvj9nI3qbNIrEnuwL1orYue+FS9i7bk4n3OgmRz9Mc1Tgi
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(376002)(396003)(136003)(39860400002)(64756008)(186003)(7696005)(66556008)(66476007)(66446008)(71200400001)(76116006)(33656002)(66946007)(86362001)(4744005)(6506007)(55016002)(8676002)(26005)(54906003)(8936002)(2906002)(110136005)(83380400001)(5660300002)(4326008)(44832011)(478600001)(9686003)(316002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: v/0qA3wfDSeQ+9Vc8rtrcGKeFk+ejJKuEzgpiJK2rMiXmCqMs8TnBdhDvh3FT/df4JgvQR7bsokRnTMGhNuA9t21DfY+oDwUQfggq3NUPtMjpA2EQKbAe/TazSI7QOpOZR32ElLIT9c+s8/5DDoeXgsPm9pSliRpHx4VkcxQbyazpOkang/tMMNvEajizxm2VKSwi6Hib9Q7fXZM6V5wVNvVk0bDdGkXBYaRnKwD5btswP4cQBJe3sujm1RvgF7bfXG7SGOnw+VueCieiaxbuKZMGvcN2tuhf0QCRNw3vi0h/upKih25q9yzOV01Qwu+ZSgZ785Q7GJH4njCHK1R5UH/3+99ih2LNNSq25T62kWx11BS/p/6WobtKk7XQTx42CxPDrjx6prLd6o7d9kHxg6VUfhfJ097TDFprMth6Q5O+2buB2XRCKrQYP2apxhjtpVbiqJzOuv2EBZWg63U8aaYjR2qoItz3E+H5KQCE2zClCOgZniYXPJ2mK2D6KJhJnMdgIO2iNmlfb4E38M6t650lovhp4Q/Zu/GLYmzSpGimMkEC/3u8O1x4HvUezfeE0kUUTw6vAJVz82eYNFi38nox14PCGv7B+M470zWMXBebsj7rkcDMPfpixGR2RqxvIYphjChZzE5GuuCZTvLZQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4966.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0c67564-8a06-46a6-c272-08d85ab5ef4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2020 03:01:12.2162
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XxAMHA8mI/9VesS6sU/rWcckpZH2NkQ7u8ZATzYxFpr4iJeqdQgSSEp1ZPadhb5eEBfe0/UtVrAVhidpc5BVeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5078
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBT
ZXB0ZW1iZXIgMTYsIDIwMjAgMTA6NDkgQU0NCj4gDQo+IFVwZGF0ZSBmc2wsaW14N3VscC1wbS55
YW1sIHRvIGluY2x1ZGUgcG1jDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBQZW5nIEZhbiA8cGVuZy5m
YW5AbnhwLmNvbT4NCj4gLS0tDQo+ICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vZnJlZXNj
YWxlL2ZzbCxpbXg3dWxwLXBtLnlhbWwgICB8IDYgKysrKystDQo+ICAxIGZpbGUgY2hhbmdlZCwg
NSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0DQo+IGEvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9mcmVlc2NhbGUvZnNsLGlteDd1bHAt
cG0ueWFtbA0KPiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vZnJlZXNj
YWxlL2ZzbCxpbXg3dWxwLXBtLnlhbWwNCj4gaW5kZXggM2IyNjA0MGY4ZjE4Li4yOGViYWE4YjFk
MWUgMTAwNjQ0DQo+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0v
ZnJlZXNjYWxlL2ZzbCxpbXg3dWxwLXBtLnlhbWwNCj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL2FybS9mcmVlc2NhbGUvZnNsLGlteDd1bHAtcG0ueWFtbA0KPiBAQCAt
MjMsNyArMjMsMTEgQEAgZGVzY3JpcHRpb246IHwNCj4gDQo+ICBwcm9wZXJ0aWVzOg0KPiAgICBj
b21wYXRpYmxlOg0KPiAtICAgIGNvbnN0OiBmc2wsaW14N3VscC1zbWMxDQo+ICsgICAgaXRlbXM6
DQo+ICsgICAgICAtIGVudW06DQo+ICsgICAgICAgICAgLSBmc2wsaW14N3VscC1zbWMxDQo+ICsg
ICAgICAgICAgLSBmc2wsaW14N3VscC1wbWMwDQo+ICsgICAgICAgICAgLSBmc2wsaW14N3VscC1w
bWMxDQoNCkNvdWxkIHlvdSBhZGQgRGVzY3JpcHRpb24gZm9yIGVhY2ggb2YgdGhlbT8NCg0KUmVn
YXJkcw0KQWlzaGVuZw0KDQo+IA0KPiAgICByZWc6DQo+ICAgICAgbWF4SXRlbXM6IDENCj4gLS0N
Cj4gMi4yOC4wDQoNCg==

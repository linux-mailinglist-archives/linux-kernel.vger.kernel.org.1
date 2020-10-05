Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6CE282EB4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 03:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725885AbgJEB4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Oct 2020 21:56:00 -0400
Received: from mail-eopbgr1320109.outbound.protection.outlook.com ([40.107.132.109]:4672
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725841AbgJEB4A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Oct 2020 21:56:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jcnqwi8E+12kQByuZqcNEQd9Un/Mde1FyfrFldLibIuFbaF/h72/HXJ2eNGkUdUVnromA9YfWh7jjcTtYyN2NeCEMG2elGz+yygypRU147KL/5R4Er19gvcn8tkaNStoWgf9ir3qQubN/dIMvgSHbCqC+oKxxC3rgm5gy3k7OwlM1pYxtuxUbCB0yNshIsKbFpQaZ30r0xqkbIqS7XcB2gEXnMv+F07dybfTPiofbxi5Gn2h05FNP/sezUyP68qB8DtggKcnfNLkZDX5ReEDZFcZ9tCK3PbzRLP3ZvT+6rDsQevx7Cqs0eRexjgr+ag2uR4TurpCEeKysVH+JRP6DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p36OExTPVT4THcu5ACziKUABzbFZVQuZbRC+SNaCBXI=;
 b=kUHDqzbFxxDkYmLfVNsftbIom82oDFIh6xa1h22qDcjK8U2fLMjMX8+qwsU7Ec3+dI+xM+c+mrjqRTXa3dKk+P26ygxR8dR8ttfsNzGKhnHlhGUPbjHx9KwhZBvjOlsVFTVdWCH1dOCB99+GU1w1hdsNwOq3l4av+R9J3wgG5B4h7eAQzv+9aPvI6GWpDKqCZNpewQzGgqYHYT+ctR5aGUKgHiIiqLmb6jTw4tl40f/7gEP3GzGn01F3xYx3HXFA+j/MdTd43azqMOVhb4vn74B6t8ZTTbikdciFIsz2D3g4SRClV093BWhOjKTOmc0ff/tOB06CDFE0uhKnz1kLkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
Received: from PU1PR06MB2167.apcprd06.prod.outlook.com (2603:1096:803:39::19)
 by PS1PR0601MB3739.apcprd06.prod.outlook.com (2603:1096:300:83::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.38; Mon, 5 Oct
 2020 01:55:55 +0000
Received: from PU1PR06MB2167.apcprd06.prod.outlook.com
 ([fe80::3023:8294:4f07:1b52]) by PU1PR06MB2167.apcprd06.prod.outlook.com
 ([fe80::3023:8294:4f07:1b52%4]) with mapi id 15.20.3433.043; Mon, 5 Oct 2020
 01:55:55 +0000
From:   Billy Tsai <billy_tsai@aspeedtech.com>
To:     Andrew Jeffery <andrew@aj.id.au>, Rob Herring <robh+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     BMC-SW <BMC-SW@aspeedtech.com>
Subject: Re: [PATCH] ARM: dts: aspeed-g6: Add sgpiom/sgpios node
Thread-Topic: [PATCH] ARM: dts: aspeed-g6: Add sgpiom/sgpios node
Thread-Index: AQHWlugj0FL+DNe4WEGnU/ZKZX+KwqmB5/IAgAblqwA=
Date:   Mon, 5 Oct 2020 01:55:54 +0000
Message-ID: <C4E8563D-DF4D-4BCE-97B3-F6396AD99020@aspeedtech.com>
References: <20200930051113.32465-1-billy_tsai@aspeedtech.com>
 <6bc40a50-8c21-4642-ad9e-e92f756aac25@www.fastmail.com>
In-Reply-To: <6bc40a50-8c21-4642-ad9e-e92f756aac25@www.fastmail.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: aj.id.au; dkim=none (message not signed)
 header.d=none;aj.id.au; dmarc=none action=none header.from=aspeedtech.com;
x-originating-ip: [211.20.114.70]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 63445a5e-9d95-492a-429e-08d868d1cbeb
x-ms-traffictypediagnostic: PS1PR0601MB3739:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PS1PR0601MB373970F27A820ABE2CEC25588B0C0@PS1PR0601MB3739.apcprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:281;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FVvuCOy+tEXL1ldSprL4MTEisKQUIL2ksik1EVffJ8AcFmUPCbK8w85cbsc4SN3N4i2L2oktXzz/gO7KBkuMRRAxb0gpQeWhH3QimpdUIj4YCk4VbxGRWkbTJ1OC9jF/1rRna0kW3+Iqog09/c5gMoBlDxcU2kMBAsJZuvRtZBq8xVwFOIJoFztcjfTKkL+Hi1xV2zlv79s3nWVKKuETtXudZNABkDe2Z6QUJj/VLpLdUekkA84kKNcmRkso3mv29hrKvNRTqHh1KfE8e/dNACCZ/X5ttt5s9ZXyK6br2P99XtNWkGLpZYV7BWpOC+iW
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PU1PR06MB2167.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(376002)(346002)(396003)(39830400003)(4326008)(86362001)(5660300002)(316002)(33656002)(8936002)(8676002)(478600001)(2616005)(6486002)(36756003)(71200400001)(2906002)(110136005)(107886003)(6506007)(66946007)(83380400001)(186003)(55236004)(66476007)(66446008)(66556008)(76116006)(91956017)(64756008)(6512007)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: yX6R/Rysb0c+Bf7LP6bxNS9Xjs+JpxQZ0x6hiTQTofnQi0+e3oH2DUbrl1ZZwDJ12xlyZWo5EcDsEtqe46p2qvEu9oa+EHqWAO2t3epdMrJHdqxlCjTTSRcbE1goIFN8TTbPofydwCvJKNVs+nFuTY5ORLivxDJ7b+958/T0jPnrBO/Od8IxEC2RBz5ynLhRAKt4tqohrukWsRecB+2A/Y9Ext8tM8go8fuQjgO5LLSKJwm73TSFWFo6kwOlUPQdybuLurLi0/6akfLYxvAh1MFS0ajAUMtiC3dTzDryuX+6xOtmEGcXIskG3oua0zeDz+SOBBLfq5hUGUJax2JiQpLs25wK01qKWLf05o8mukcBWUW8OJ5npcoUucqIvXpQusil3Yb2Ahw04kIO9RdGgfpvisdVUNXollwcTIX/BMsgZabSR1RsGl1JAsDJbCWEAfxGkuY9ensEyB7XMiwyYR2OY3nGSp7Gu7baJRoYFszc2OIC27X6btzp0R2zefSrLEN8cfpfDekZ1vurJ4d+vj1A1w9rZDPELKVfIIHFzm8DOt7BhGTDhcnq6onjee2eeuC3oEPDDPzWsUjsHe4VZ2ABpVWOsTxA7f7EEOyW/V5qwGh4r/JfdBM7jFHcbxPMxjDrhwyrmK6+Ugczky8bpg==
Content-Type: text/plain; charset="utf-8"
Content-ID: <B6A3EEB83A2641488834DD7A9955E418@apcprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PU1PR06MB2167.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63445a5e-9d95-492a-429e-08d868d1cbeb
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2020 01:55:54.7983
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ME69sFxCaXR1gAceKgK6KHQVS3taCbUo7uyXwZ4GgvZQxl74aEMvuDeFDPmh2Hr58m/O1Rhjya15fCsZMlrGnqdJKBRmYDpd+oDbWKQ7Evg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS1PR0601MB3739
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5kcmV3LA0KDQrvu79PbiAyMDIwLzEwLzEsIDg6MzYgQU0sIEFuZHJldyBKZWZmZXJ5IHdy
b3RlOg0KDQogICAgSGkgQmlsbHksDQogICAgDQogICAgT24gV2VkLCAzMCBTZXAgMjAyMCwgYXQg
MTQ6NDEsIEJpbGx5IFRzYWkgd3JvdGU6DQogICAgPiBUaGlzIGNvbW1pdCBhZGQgdHdvIHNncGlv
bSBhbmQgdHdvIHNncGlvcyBub2RlIGludG8gYXNwZWVkLWc2LmR0c2kNCiAgICA+IGFuZCBjaGFu
Z2UgdGhlIHJlZ2lzdGVyIHJhbmdlIG9mIGdwaW8wIHRvIGZpeCB0aGUgaGFyZHdhcmUgZGVzaWdu
Lg0KICAgID4gDQogICAgPiBTaWduZWQtb2ZmLWJ5OiBCaWxseSBUc2FpIDxiaWxseV90c2FpQGFz
cGVlZHRlY2guY29tPg0KICAgID4gLS0tDQogICAgPiAgYXJjaC9hcm0vYm9vdC9kdHMvYXNwZWVk
LWc2LmR0c2kgfCA1MSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLQ0KICAgID4gIDEg
ZmlsZSBjaGFuZ2VkLCA1MCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQogICAgPiANCiAg
ICA+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9hc3BlZWQtZzYuZHRzaSBiL2FyY2gv
YXJtL2Jvb3QvZHRzL2FzcGVlZC1nNi5kdHNpDQogICAgPiBpbmRleCA5N2NhNzQzMzYzZDcuLjAw
MjM3ZGFlYzJhMSAxMDA2NDQNCiAgICA+IC0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL2FzcGVlZC1n
Ni5kdHNpDQogICAgPiArKysgYi9hcmNoL2FybS9ib290L2R0cy9hc3BlZWQtZzYuZHRzaQ0KICAg
ID4gQEAgLTM1Nyw3ICszNTcsNyBAQA0KICAgID4gIAkJCQkjZ3Bpby1jZWxscyA9IDwyPjsNCiAg
ICA+ICAJCQkJZ3Bpby1jb250cm9sbGVyOw0KICAgID4gIAkJCQljb21wYXRpYmxlID0gImFzcGVl
ZCxhc3QyNjAwLWdwaW8iOw0KICAgID4gLQkJCQlyZWcgPSA8MHgxZTc4MDAwMCAweDgwMD47DQog
ICAgPiArCQkJCXJlZyA9IDwweDFlNzgwMDAwIDB4NTAwPjsNCiAgICA+ICAJCQkJaW50ZXJydXB0
cyA9IDxHSUNfU1BJIDQwIElSUV9UWVBFX0xFVkVMX0hJR0g+Ow0KICAgID4gIAkJCQlncGlvLXJh
bmdlcyA9IDwmcGluY3RybCAwIDAgMjA4PjsNCiAgICA+ICAJCQkJbmdwaW9zID0gPDIwOD47DQog
ICAgPiBAQCAtMzY1LDYgKzM2NSw1NSBAQA0KICAgID4gIAkJCQlpbnRlcnJ1cHQtY29udHJvbGxl
cjsNCiAgICA+ICAJCQkJI2ludGVycnVwdC1jZWxscyA9IDwyPjsNCiAgICA+ICAJCQl9Ow0KICAg
ID4gKwkJCXNncGlvbTA6IHNncGlvbUAxZTc4MDUwMCB7DQogICAgPiArCQkJCSNncGlvLWNlbGxz
ID0gPDI+Ow0KICAgID4gKwkJCQlncGlvLWNvbnRyb2xsZXI7DQogICAgPiArCQkJCWNvbXBhdGli
bGUgPSAiYXNwZWVkLGFzdDI2MDAtc2dwaW9tIjsNCiAgICA+ICsJCQkJcmVnID0gPDB4MWU3ODA1
MDAgMHgxMDA+Ow0KICAgID4gKwkJCQlpbnRlcnJ1cHRzID0gPEdJQ19TUEkgNTEgSVJRX1RZUEVf
TEVWRUxfSElHSD47DQogICAgPiArCQkJCW5ncGlvcyA9IDwxMjg+Ow0KICAgID4gKwkJCQljbG9j
a3MgPSA8JnN5c2NvbiBBU1BFRURfQ0xLX0FQQjI+Ow0KICAgID4gKwkJCQlpbnRlcnJ1cHQtY29u
dHJvbGxlcjsNCiAgICA+ICsJCQkJYnVzLWZyZXF1ZW5jeSA9IDwxMjAwMDAwMD47DQogICAgPiAr
DQogICAgPiArCQkJCXBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7DQogICAgPiArCQkJCXBpbmN0
cmwtMCA9IDwmcGluY3RybF9zZ3BtMV9kZWZhdWx0PjsNCiAgICA+ICsJCQkJc3RhdHVzID0gImRp
c2FibGVkIjsNCiAgICA+ICsJCQl9Ow0KICAgID4gKw0KICAgID4gKwkJCXNncGlvbTE6IHNncGlv
bUAxZTc4MDYwMCB7DQogICAgPiArCQkJCSNncGlvLWNlbGxzID0gPDI+Ow0KICAgID4gKwkJCQln
cGlvLWNvbnRyb2xsZXI7DQogICAgPiArCQkJCWNvbXBhdGlibGUgPSAiYXNwZWVkLGFzdDI2MDAt
c2dwaW9tIjsNCiAgICA+ICsJCQkJcmVnID0gPDB4MWU3ODA2MDAgMHgxMDA+Ow0KICAgID4gKwkJ
CQlpbnRlcnJ1cHRzID0gPEdJQ19TUEkgNzAgSVJRX1RZUEVfTEVWRUxfSElHSD47DQogICAgPiAr
CQkJCW5ncGlvcyA9IDw4MD47DQogICAgPiArCQkJCWNsb2NrcyA9IDwmc3lzY29uIEFTUEVFRF9D
TEtfQVBCMj47DQogICAgPiArCQkJCWludGVycnVwdC1jb250cm9sbGVyOw0KICAgID4gKwkJCQli
dXMtZnJlcXVlbmN5ID0gPDEyMDAwMDAwPjsNCiAgICA+ICsNCiAgICA+ICsJCQkJcGluY3RybC1u
YW1lcyA9ICJkZWZhdWx0IjsNCiAgICA+ICsJCQkJcGluY3RybC0wID0gPCZwaW5jdHJsX3NncG0y
X2RlZmF1bHQ+Ow0KICAgIA0KICAgPiBIYXZlIHlvdSB0cmllZCBidWlsZGluZyB0aGlzIG9uIHRv
cCBvZiB1cHN0cmVhbT8gQmVjYXVzZSBuZWl0aGVyIHNncG0yIG5vciANCiAgID4gc2dwczIgYXJl
IHN1cHBvcnRlZCBieSB0aGUgcGluY3RybCBkcml2ZXIuIElmIHlvdSBoYXZlIHBhdGNoZXMgdGhh
dCBpbXBsZW1lbnQgDQogICA+IGJvdGggbXV4IGNvbmZpZ3VyYXRpb25zLCBjYW4geW91IHBvc3Qg
dGhlbSB0b28/DQogICAgDQogICA+IEFuZHJldw0KDQpTb3JyeSBmb3IgdGhhdC4NCg0KSSB3aWxs
IHJlc2VuZCBhbm90aGVyIHBhdGNoIHdoaWNoIGluY2x1ZGVzIHBpbmN0cmwgaW5mb3JtYXRpb24g
dG8gZml4IHRoaXMgZXJyb3IuDQogIA0KQmVzdCBSZWdhcmRzLA0KQmlsbHkgVHNhaQ0KIA0KDQoN
Cg==

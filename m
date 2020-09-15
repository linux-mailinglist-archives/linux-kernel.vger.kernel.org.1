Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97856269F45
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 09:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbgIOHIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 03:08:18 -0400
Received: from mail-eopbgr40068.outbound.protection.outlook.com ([40.107.4.68]:54497
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726186AbgIOHGQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 03:06:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QA2tN+W0wNwBdwJSGKagdOMnnuzrhv3Jh6B4BVSn96WczkylalUutdhxQuMqeGcXoew+UFv8S6Wzy3oFuBs/J8kkC55xc/5V2aMcDUTXoDLLHYdTs5rz7bkvrg/zaKvIVltPlfCv/gE01MLPRMyDmMD03PCFjvnL8mGLHKZ1rAl7Dth7FRz3XWPy/yXthP0/1Pe/ydQJBpMZQqZ/LaahXcA2cJ00LtU8eIprlfVelRz+/aWVz4AbN9DwBS7pQMMhCZGg4WSN5x3sYjXXVFiuBS3UrskN9rIcCVoID1AdFBP88SgCzbGWL2ZQxMuwQ+G6iL78CF8yJP0FkcrEQpJkNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FfMpvduonQ0BDfDklM04v9AaSm4h94w0214lV/lhEQ0=;
 b=WxpCbiFXbEplDDafb0uNizpSTTz2YG6GpfbAuW0NP2prlo224oGGcXSl9Dwz+Xs2XGhdGSS1HR5zSbpokLaKtjksHuyA9/UzQFFi7TDmVHkP09LmYXu4GyuDSKWj0XlAIi8MtjqAZXwcaSbAfHFxrWL6v0oe/RCvU19SYLOkRcqaxPdokHdydfEiqoa8uH2oLe8u4Bp23aBGRuzvHXHqTu/Zw4srTkHt/dw6oJz+VmRQVSBIQE+MqzP1b0tzjg3zlJAViWjNmGeMEij9uL0/BUimtOVhQf4IgKKBM1l/JVCZpS8EL/XTvR9Z5+uOj5EfoNU7W33jIVQ4ChU82oEYrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FfMpvduonQ0BDfDklM04v9AaSm4h94w0214lV/lhEQ0=;
 b=pqxbVeuveZsM8A95NQmqIIhU76DA+tZ96HLd5AS0yFxpxIS/jWx4ZvWBU7FK+MVVZwu6lhC4FPCNCFH79x2ctpFTqCK8MqKjEqh5ttSHFGwJ7Hx/v7H2As5Ymsk9iXFMxZdyaUC01vMSHH9rZbr6n+hIDXCzR4wvpUYINk1w00w=
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com (2603:10a6:20b:118::20)
 by AM6PR04MB6712.eurprd04.prod.outlook.com (2603:10a6:20b:d9::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.17; Tue, 15 Sep
 2020 07:05:39 +0000
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::1023:be8d:40c:efe1]) by AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::1023:be8d:40c:efe1%3]) with mapi id 15.20.3370.019; Tue, 15 Sep 2020
 07:05:38 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Matthias Kaehlcke <mka@chromium.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: RE: [PATCH 2/2] USB: misc: Add onboard_usb_hub driver
Thread-Topic: [PATCH 2/2] USB: misc: Add onboard_usb_hub driver
Thread-Index: AQHWisa8s1Sayn6UyUeJIx1ZNmduw6lpAX4AgAAjrICAAB3x4A==
Date:   Tue, 15 Sep 2020 07:05:38 +0000
Message-ID: <AM7PR04MB715735A8A102F3EC9041EA328B200@AM7PR04MB7157.eurprd04.prod.outlook.com>
References: <20200914112716.1.I248292623d3d0f6a4f0c5bc58478ca3c0062b49a@changeid>
 <20200914112716.2.I7c9a1f1d6ced41dd8310e8a03da666a32364e790@changeid>
 <20200915025426.GA17450@b29397-desktop> <20200915050207.GF2022397@google.com>
In-Reply-To: <20200915050207.GF2022397@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 128f8ed7-bac9-4f29-8f52-08d85945c07d
x-ms-traffictypediagnostic: AM6PR04MB6712:
x-microsoft-antispam-prvs: <AM6PR04MB6712F456A3F92EA2705A15378B200@AM6PR04MB6712.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UfHRIOZQKIBXrh1Gk+WIaIzq8edpodl4AKumO6Wo79EFpp5r7+OugwWC4ce62Ah3eSmEcTyO3a5xwnYrL8sXG1NO4NTTodrnK7+AeQjD2PXhgKfXMyfYfR2/iH0qNp+0Ep6D/d6TTuGU/RDfX6u6PN8ugQhCR+/OwTZCYekyBKBk68765TGYiuPVjvQHHhCXUMCvdVIFKPTvoNxkzJoiXrwkQfTFEooDk1LPqLfsGlu7rWIpeqxsgbY19Uyksf9pYvgwWyZJKdmh1CfdcqeAViFkROS+hZDL5FnvQtHu58uS7rlVLukFZNexGils5sh7LYF4ZF11jTLX6jPSpPgjWA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7157.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(346002)(376002)(366004)(136003)(7696005)(55016002)(66446008)(64756008)(66556008)(66476007)(9686003)(66946007)(8676002)(26005)(6916009)(186003)(8936002)(71200400001)(6506007)(478600001)(5660300002)(52536014)(316002)(44832011)(4326008)(7416002)(54906003)(83380400001)(86362001)(33656002)(76116006)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 0fzsdEEiz6z47FDtRBKlH0s/k9E/zhkdQIjZuwBYbfX5GxYwsIpMcFbw0o2H6usVOK8+jSGtEF554ttCJPjKRx3Hlx5CQlzWCCMgLVR3eZYWTTMWzc6fsQyISrQJygStJhHLryWz+EiWGJNHHaq8c7y59gGX6liJ7J2KDDSMG5OGdtt9bs7wnwABBJjkKniLreGcXiwJhOO2M84wE7vRDR6aZwFxC8QvEueOtgwNIloboTQRAzjkqYzPh8aPGf7fpJ6ZsgBLHq6stqdcVZfQmgfh8mwDeH0uHFA069ztOXwYi3z3OvdM13jNOijhS2aHrcde6JQFKKZ+qR8n8vICSpcipeAJENaqdCLDvy/vTySOsdyN+OrUKMgZ51GKDifFrEQqVChTmVXB3GClUkNHD/duJMpuzUXTMv55r3XEnTLZf5Sy5DCI9czBFqwtNsH19oTZ7gNK/O+nrXCxJKsxoKt5xQ77O6Zsl/QIKjZepSGW/MjWUT5PFxaiYLQEW++BqSoW+lUg19bHZVWVw54F/Pv3ewdozbzZmmuFFQHlefPIbp6NCP4vzXL3HT+JyNmT8eOeMYFwacqutHsXqpW5+UBHTwS6soj0uKw7CT/wOGYgm1uS6l0QCnDgS+4KmPETGURxdmcv665X/PNJqiIvsQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7157.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 128f8ed7-bac9-4f29-8f52-08d85945c07d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2020 07:05:38.8660
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xC8HpVz80je9CFssijMrTm7ABaiFtsGiL9mgqLwlSNo4OLEvFjD22CbhXSFmYJ8yyBQkR45wIDuiHJPmTnmlXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6712
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ICANCj4gPiA+ICsJaHViLT5jZmcucG93ZXJfb2ZmX2luX3N1c3BlbmQgPQ0KPiBvZl9wcm9wZXJ0
eV9yZWFkX2Jvb2woZGV2LT5vZl9ub2RlLCAicG93ZXItb2ZmLWluLXN1c3BlbmQiKTsNCj4gPiA+
ICsJaHViLT5jZmcud2FrZXVwX3NvdXJjZSA9IG9mX3Byb3BlcnR5X3JlYWRfYm9vbChkZXYtPm9m
X25vZGUsDQo+ID4gPiArIndha2V1cC1zb3VyY2UiKTsNCj4gPg0KPiA+IERvIHlvdSByZWFsbHkg
bmVlZCB0aGVzZSB0d28gcHJvcGVydGllcz8gSWYgdGhlIGRldmljZSAoYW5kIGl0cw0KPiA+IGNo
aWxkcmVuIGlmIGV4aXN0ZWQpIGhhcyB3YWtldXAgZW5hYmxlZCwgeW91IGtlZXAgcG93ZXIgaW4g
c3VzcGVuZCwNCj4gPiBvdGhlcndpc2UsIHlvdSBjb3VsZCBjbG9zZSBpdCwgYW55IGV4Y2VwdGlv
bnM/DQo+IA0KPiBUaGF0IHdvdWxkIHdvcmsgZm9yIG15IHVzZSBjYXNlLCBidXQgSSdtIG5vdCBz
dXJlIGl0J3MgYSB1bml2ZXJzYWxseSBnb29kDQo+IGNvbmZpZ3VyYXRpb24uDQo+IA0KPiBJIGRv
bid0IGhhdmUgYSBzcGVjaWZpYyBVU0IgZGV2aWNlIGluIG1pbmQsIGJ1dCB5b3UgY291bGQgaGF2
ZSBhIGRldmljZSB0aGF0DQo+IHNob3VsZG4ndCBsb3NlIGl0J3MgY29udGV4dCBkdXJpbmcgc3Vz
cGVuZCBvciBrZWVwIG9wZXJhdGluZyBhdXRvbm9tb3VzbHkgKGUuZy4NCj4gYSBzZW5zb3Igd2l0
aCBhIGxhcmdlIGJ1ZmZlciBjb2xsZWN0aW5nIHNhbXBsZXMpLiBOb3Qgc3VyZSBpZiBzb21ldGhp
bmcgbGlrZSB0aGlzDQo+IGV4aXN0cyBpbiB0aGUgcmVhbCB0aG91Z2guDQo+IA0KPiBJJ20gbm90
IGFuIGV4cGVydCwgYnV0IGl0IHNlZW1zIHRoZXJlIGFyZSBVU0IgY29udHJvbGxlcnMgd2l0aCB3
YWtldXAgc3VwcG9ydA0KPiB3aGljaCBpcyBhbHdheXMgZW5hYmxlZC4gQSBib2FyZCB3aXRoIHN1
Y2ggYSBjb250cm9sbGVyIHRoZW4gY291bGRuJ3QgaGF2ZSBhDQo+IHBvbGljeSB0byBwb3dlciBk
b3duIHRoZSBodWIgcmVnYXJkbGVzcyBvZiB3YWtldXAgY2FwYWJsZSBkZXZpY2VzIGJlaW5nDQo+
IGNvbm5lY3RlZC4NCj4gDQoNCldoZXRoZXIgb3Igbm90IGl0IGlzIGEgd2FrZXVwX3NvdXJjZSwg
aXQgY291bGQgZ2V0IHRocm91Z2ggaXRzIG9yIGl0cyBjaGlsZHJlbidzIC9zeXMvLi4vcG93ZXIv
d2FrZXVwDQp2YWx1ZSwgeW91IGhhdmUgYWxyZWFkeSB1c2VkIHVzYl93YWtldXBfZW5hYmxlZF9k
ZXNjZW5kYW50cyB0byBrbm93IGl0LiBJZiB0aGUgb25ib2FyZCBIVUINCm5lZWRzIHRvIHJlZmxl
Y3Qgd2FrZXVwIHNpZ25hbCwgaXQgc2hvdWxkIG5vdCBwb3dlciBvZmYgaXRzIHJlZ3VsYXRvci4N
Cg0KRm9yIGFub3RoZXIgcHJvcGVydHkgcG93ZXItb2ZmLWluLXN1c3BlbmQsIEkgdGhpbmsgaXQg
aXMgYWxzbyBhIHVzZXIgb3B0aW9uLCBidXQgbm90IGEgaGFyZHdhcmUgZmVhdHVyZS4NCg0KSWYg
KHdha2V1cC1zb3VyY2UgfHwgISBwb3dlci1vZmYtaW4tc3VzcGVuZCkNCglwb3dlciBvZmY7DQpl
bHNlDQoJa2VlcCBwb3dlcjsNCg0KUGV0ZXINCg0K

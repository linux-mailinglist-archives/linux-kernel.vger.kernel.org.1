Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1A1A26D090
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 03:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726022AbgIQBYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 21:24:42 -0400
Received: from mail-eopbgr40078.outbound.protection.outlook.com ([40.107.4.78]:42913
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725858AbgIQBYf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 21:24:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oFXTatEeR3Cn5nEvH0U92pMvbuG7L5v/A9Pp5mUjASVwy9n+08aivvlWmxIzKeeqj87MohMTTGI/uYE1mrYRI5/7o7r18O1uFEseTW/FVWXtUfI5Wji4viY1zHW4eGa2tZCZTacue+ETER13NhwLReHj0fmLuBDHPSiR9fib7KG6NA0d1BzkceUL6UQqnRw/pmEYS6upXkuGYXVX1Uhgircri19DlMVCNsOKgvWIv11WGrjXtaXodW96eYuz+wTLrPRNE18OrhsOpzqFebWObs9XeCpQRcoK5r2X5mfxPQ5bQZQ7/M+g0VEjJ6pJTffXlpkClTugodyc3Fjd861jyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KqeZrWtPyvvRz7CD6spZhdrQUa8cmzkzp5WhJiGaC1c=;
 b=FP4jYsQlYbsGFt1d/AdX5r6+znKrltv/e+M6PmlTw5X8WiZuY+iE8dX9bpNNqsb1XnomX8bnwKYV0OYScXZa/fzCL/1BZ8QfPnSSc+i7Of219lRgZNItDC4I51MiaD24EZnd4XBlJxPudi62HdyUecWEuXX+jc/JprcETYmYgy8Q36L9FU1t/kwVtK2zZtRSW40WwTyVhYjNlXwExjo2En+LEu+KgklERoRXBedmiEGOY9b9CP+EGI7gvydWzd0Yj/UrVdymsddJMcMvB8KIGoZxtQkpsVoUVr/5qf9Ov8fow+bCuxNGf6WTu/32DKXUTe5tG17Z4Idfl+qemUaiSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KqeZrWtPyvvRz7CD6spZhdrQUa8cmzkzp5WhJiGaC1c=;
 b=QLpHFa8m/kSsXWct3xlZ6y+j8PcBNKm5lg7pU0+3N3xdUQ+tqRhyVtAE7mDlXawd7vpAZ2W8JY8p+zohm1AEYGVZ2zmWncRDL48rv5D/XD00g405eTW2h6zbteAfjjggzBLPMwWOykihvMd/gPVcb/LHibtTMAndxHFNETTyiqE=
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com (2603:10a6:20b:118::20)
 by AM5PR0401MB2481.eurprd04.prod.outlook.com (2603:10a6:203:39::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14; Thu, 17 Sep
 2020 01:24:30 +0000
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::1023:be8d:40c:efe1]) by AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::1023:be8d:40c:efe1%3]) with mapi id 15.20.3391.013; Thu, 17 Sep 2020
 01:24:30 +0000
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
Thread-Index: AQHWisa8s1Sayn6UyUeJIx1ZNmduw6lpAX4AgAAjrICAAB3x4IABEESAgACa9ICAALfHgIAAVssAgAAF7QCAAAESkA==
Date:   Thu, 17 Sep 2020 01:24:30 +0000
Message-ID: <AM7PR04MB7157872B1019B748119B7DBA8B3E0@AM7PR04MB7157.eurprd04.prod.outlook.com>
References: <20200914112716.1.I248292623d3d0f6a4f0c5bc58478ca3c0062b49a@changeid>
 <20200914112716.2.I7c9a1f1d6ced41dd8310e8a03da666a32364e790@changeid>
 <20200915025426.GA17450@b29397-desktop> <20200915050207.GF2022397@google.com>
 <AM7PR04MB715735A8A102F3EC9041EA328B200@AM7PR04MB7157.eurprd04.prod.outlook.com>
 <20200915230345.GF2771744@google.com> <20200916081821.GA14376@b29397-desktop>
 <20200916191607.GB3560556@google.com> <20200917002646.GA23310@b29397-desktop>
 <20200917004758.GD3560556@google.com>
In-Reply-To: <20200917004758.GD3560556@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [180.164.158.209]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e6e754db-2dcb-488a-4f21-08d85aa86d11
x-ms-traffictypediagnostic: AM5PR0401MB2481:
x-microsoft-antispam-prvs: <AM5PR0401MB24811D502FB68FE2313FF0578B3E0@AM5PR0401MB2481.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MVhy3kiwnvdfrolWyIW6gj0Ty5uSnRq8CyKajdbHYvI2ZkA2/gRvCCQA7Ac14AxeeqxU2f+QKctqv5jQUi3Q6PB0cMUlxYU+eZyhoasDF36Kc6jTlj9p15MhGxsu8TkX2Ju8FpgvJ0ZYZCQj0UBEAfhsr0jLN8QkRpQytWsMmyr8JCGCi8FpkxUsSKmzON33dwVTywCiDxG2Bl6mw+vpVYLWqX20cFrwTDpN7AHZTjRj3sDJ9fznZdRK5HjEuLWtMbfefjKaqVhbHJNJxm277GqjfHa09Vjn9YGvkcW+hBvyFwV/x+Ep5D0+oZj5s1amL6OZ/xSj03bOfv6gS88HTUp2A/6GvRngEpuFGlguyVPh3lZMugbMD195QmK+5W6B
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7157.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(39850400004)(136003)(376002)(346002)(316002)(76116006)(7416002)(8676002)(33656002)(5660300002)(6916009)(9686003)(64756008)(54906003)(66446008)(478600001)(66476007)(52536014)(66556008)(66946007)(6506007)(4326008)(83380400001)(7696005)(86362001)(44832011)(55016002)(71200400001)(26005)(2906002)(186003)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: nFyc4QoBHWT7SLM9ogQKd+quhbeljGF4IMuQKUEBVk8jgDxGxcIr4DwE5ulJvxVNnNxkMEhd3Fx2HePLOhHJot+TXOeDFpzTRds5bViwGCn7zV4E6A6Tm00ydBqxJtmwPuPkb67ERR5GQCDUsT/TomiRqIkAIssJz+OYW1yKzyvWRZCzkYd4jqV6vFPi3oZIl72eysiZBMWDul3UjK6Ea4S2ZFN6aApDHFT0QXuQaJ/fJis94dsORsEA3hUa7utd/fJHzOtQYGXHqp/sftgACGjgIic6lph8bUXpW+mqI4bjN94o9H+B6ck0ngxf8kAdPILZtDsdTqwOlLrfpJ8JdudoIvwHIT2MxXPiX7CC/1jMEHwVOlag31yOa8cAbLri4eAWsEWh7Al+OFx6ye/QUr5c1y/bOsqE3PuRGKkIsr2Cvnfs+v99i5Iia7jCGnNr/B+d8ITbWztjujbg+Yz9LCrPtabIZR/Wh5RaG2hmL1m9uXixYfyse3+n2W8NXf7vdHNvuGRIHkSgt1iA71ir06L7jcBIyL45UmQiKbEuM2w2cIzfLt9G461Ht3CrryKaRRN4/sDhVtR4CffFb2cyl4l7lEYxOzonkYKE2r9cBZbYHlKP2a+MqZYW7gOgzMxZJy6JJUXzQDYabJLHi1GRsA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7157.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6e754db-2dcb-488a-4f21-08d85aa86d11
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2020 01:24:30.3263
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6YpO1AlNo6Bs08s9RNeXLqKghJacTNWGwI1JxKf2DX+9X9WfLRXhF3gLHBmplS9w3vAPdx9jYtidf+dX7wBlhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0401MB2481
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+ID4NCj4gPg0KPiA+IFlvdSBtYXkgbmVlZCBib3RoIChnbHVlICYgeGhjaSksIGl0IGRlcGVu
ZHMgb24gc3lzdGVtIGRlc2lnbiwgYW5kDQo+ID4gdXN1YWxseSwgdGhlc2UgdHdvIGtpbmRzIG9m
IHdha2V1cCBzZXR0aW5nIGlzbid0IGNvbmZsaWN0Lg0KPiANCj4gT2ssIHRoYW5rcy4gU28gaWYg
SSB1bmRlcnN0YW5kIGNvcnJlY3RseSB0aGUgb25ib2FyZCBodWIgZHJpdmVyIHNob3VsZCBjaGVj
ayB0aGUNCj4gd2FrZXVwIHN0YXRlIG9mIHRoZSB4SENJIHRvIGRldGVybWluZSBpZiByZW1vdGUg
d2FrZXVwIGlzIGVuYWJsZWQgZm9yIHRoZQ0KPiBjb250cm9sbGVyIChhZnRlciBhbGwgaXQgZG9l
c24ndCBrbm93IGFueXRoaW5nIGFib3V0IHRoZSBwbGF0Zm9ybSBkZXZpY2UpLg0KPiBXYWtldXAg
bWlnaHQgbm90IHdvcmsgcHJvcGVybHkgaWYgaXQgaXMgZGlzYWJsZWQgZm9yIHRoZSBwbGF0Zm9y
bSBkZXZpY2UsIGJ1dCBpdCdzDQo+IHRoZSByZXNwb25zYWJpbGl0eSBvZiB0aGUgYm9hcmQgc29m
dHdhcmUvY29uZmlnIHRvIG1ha2Ugc3VyZSBpdCBpcyBlbmFibGVkDQo+IChwb3NzaWJseSB0aGlz
IGNvdWxkIGJlIGRvbmUgYnkgbWFraW5nIHRoZSBkd2MzLXFjb20gZHJpdmVyIHVuZGVyc3RhbmQg
dGhlDQo+ICd3YWtldXAtc291cmNlJyBwcm9wZXJ0eSwgYXMgdGhlIHhoY2ktbXRrIGRyaXZlciBk
b2VzKS4NCg0KTm8sIGV2ZXJ5IGxldmVsIHNob3VsZCBoYW5kbGUgaXRzIG93biB3YWtldXAgc2V0
dGluZy4gWW91IG1heSBoYXZlIHRvIGRvIHRoaXMgc2luY2UgdGhlIFVTQiBidXMgYW5kIHBsYXRm
b3JtIGJ1cw0KYXJlIHR3byBkaWZmZXJlbnQgYnVzZXMsIHlvdSBzaG91bGQgbm90IHZpc2l0IGRl
dmljZSBzdHJ1Y3R1cmUgYWNyb3NzIHRoZSBidXMuIEFuZCB5b3UgZG9uJ3QgbmVlZCBhIGRldmlj
ZSB0cmVlIHByb3BlcnR5DQp0byBkbyBpdC4gRm9yIHBsYXRmb3JtIGRyaXZlciwgeW91IGNvdWxk
IHVzZSBkZXZpY2VfbWF5X3dha2V1cCwgZm9yIG9uYm9hcmQgaHViIHBvd2VyIGRyaXZlciwgeW91
IGNvdWxkIHVzZQ0KdXNiX3dha2V1cF9lbmFibGVkX2Rlc2NlbmRhbnRzIHNpbmNlIHlvdSBuZWVk
IHRvIGNvdmVyIGRlc2NlbmRhbnRzLg0KDQpUaGUgcHVycG9zZSBvZiB0aGVzZSB0d28gd2FrZXVw
IGxvZ2ljIGlzIGRpZmZlcmVudCwgZm9yIFVTQiBidXMsIGl0IGlzIHVzZWQgdG8gdGVsbCBVU0Ig
ZGV2aWNlcyB0byBlbmFibGUgcmVtb3RlIHdha2V1cA0KYW5kIGRvIG5vdCBwb3dlciBvZmYgaXRz
IHJlZ3VsYXRvcjsgZm9yIHBsYXRmb3JtIGJ1cywgaXQgaXMgdXNlZCB0byB0ZWxsIHRoZSBjb250
cm9sbGVyIHRvIGVuYWJsZSBpdHMgd2FrZXVwIHNldHRpbmcgYW5kIGtlZXANCnRoZSByZWd1bGF0
b3IgZm9yIGl0cyBVU0IgY29udHJvbGxlciBhbmQgVVNCIFBIWSAoaWYgbmVlZGVkKS4NCg0KUGV0
ZXINCg0K

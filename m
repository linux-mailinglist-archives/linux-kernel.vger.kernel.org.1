Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF4D61D6FE1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 May 2020 06:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbgEREjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 May 2020 00:39:02 -0400
Received: from mga03.intel.com ([134.134.136.65]:37521 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725280AbgEREjB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 00:39:01 -0400
IronPort-SDR: dWz33poSuhwF1t1Hzihw/r1XuLur+dJlx+X2uyrZftw5RhakEE0qPoRoOt3AXDbuBsoKnRfY3c
 fBbwVSqWOqqQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2020 21:39:00 -0700
IronPort-SDR: ojHfNxEtEdBCvxZGx10bRVT8WCJ83ZHOjNC5IiiLuDq3cGXrnLSrIEgtJIWAbYIznjqhIHukDk
 KYAi4LXVO8Xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,406,1583222400"; 
   d="scan'208";a="252771277"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by orsmga007.jf.intel.com with ESMTP; 17 May 2020 21:38:59 -0700
Received: from fmsmsx151.amr.corp.intel.com (10.18.125.4) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 17 May 2020 21:38:59 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 FMSMSX151.amr.corp.intel.com (10.18.125.4) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 17 May 2020 21:38:53 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.108)
 by edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Sun, 17 May 2020 21:38:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FNq/ljlmJfzweU+61al4lWpJvoEWRuJ4KcxIzRQSJTICJt2hxhkqnhUCUnLnAWrYJe4WOCIbUWvRq+e/8GwkKY38mn/FdlGBAyQkqZs5NENPkJ9Zu2u8kXk9idoFOF2a9WamdYOnejOS7uwLizw/4S2MqXuv16kOWI4/zkyMIQJYwZK1HitYo9UT1uiIkVmxjyHzHjYk9XVsyQ286yIvyr/WbQD1gJsbRAJ9EBvIxaXiqXFHDzISQ0ocNBGFiVNmEBb94XH3Fr2chlVk7M6Jre8DdSKvBZW3Uj3IgVDauG7Kt7YpFlEEUdh9CXyi2moS9ss7NEiLXS80ZkBmtL1HwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uXgcHrwGMEV7mi/qJEuHwGgVuH7trXTdhrE+3BobzUI=;
 b=OuDWvEP49hZEtmwWvZ3AXfwuQTuhG4WsWEn8t6blJcBgQeSBlC/pg5mdJ3DdQgIS9BabFNNBiRXdDD9IN9v1NToP0j/5TtYFYtNWyy0oIRj3q+ZLTDozNT2kDNhWkXB4mWGhjQ0GUiiPBIk9t3ykk8dFrO7unxA2qm6b7l8zKruJ6bKvp6fnTbqCcBDf+4bi7iAhyYERxprcgT3zEhhdizv+fa8jTOqckOEEyO/VikOQLKqynIkJhOy1BXGVw3Cdvafn4Hi8SNb2eDiZLqC1FKZ6K9QfkXhaaZkorzS+/ZOWPOuybWyNJ4LBBj21hW6hXIHG9G73jYSzQfc17q8nxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uXgcHrwGMEV7mi/qJEuHwGgVuH7trXTdhrE+3BobzUI=;
 b=CExweJZA9uxecDXu60fzqrmsUdiVPPf6GfqMx7x/Ex1FtiT0JEl/2Gtr9oONxEGYmbZ7dBVBNcdBVesTSSnaS6z6m17xTmVS4fF+m4rA8WhiHmYSrk0fnxiyOxXTMZSOj4ChssTsketf9f7Tt9jodnlqEJW0CZXkwwR4w0AK61k=
Received: from BN6PR1101MB2132.namprd11.prod.outlook.com
 (2603:10b6:405:5b::22) by BN6PR1101MB2082.namprd11.prod.outlook.com
 (2603:10b6:405:51::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20; Mon, 18 May
 2020 04:38:51 +0000
Received: from BN6PR1101MB2132.namprd11.prod.outlook.com
 ([fe80::5419:a938:2a3:ee27]) by BN6PR1101MB2132.namprd11.prod.outlook.com
 ([fe80::5419:a938:2a3:ee27%5]) with mapi id 15.20.3000.034; Mon, 18 May 2020
 04:38:51 +0000
From:   "Lu, Brent" <brent.lu@intel.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        Takashi Iwai <tiwai@suse.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Richard Fontana <rfontana@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        paulhsia <paulhsia@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] ALSA: pcm: fix incorrect hw_base increase
Thread-Topic: [PATCH] ALSA: pcm: fix incorrect hw_base increase
Thread-Index: AQHWKm+bGJ7M/VYc4UytQzlLp6XFraiouVwAgAAfc8CAAAlhAIAAEy0AgAAXB4CABDqDwA==
Date:   Mon, 18 May 2020 04:38:51 +0000
Message-ID: <BN6PR1101MB21326D0D9002FFDA60A2204F97B80@BN6PR1101MB2132.namprd11.prod.outlook.com>
References: <1589515779-20987-1-git-send-email-brent.lu@intel.com>
 <20200515070446.GA1226131@kroah.com>
 <BN6PR1101MB21327687327440F1DB7CB75F97BD0@BN6PR1101MB2132.namprd11.prod.outlook.com>
 <ce215f76-89c3-3543-c6ed-bc9b81af50a0@perex.cz>
 <s5hk11dmqhn.wl-tiwai@suse.de>
 <6f98358d-99f1-3b54-ae1a-5e938d383c32@perex.cz>
In-Reply-To: <6f98358d-99f1-3b54-ae1a-5e938d383c32@perex.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: perex.cz; dkim=none (message not signed)
 header.d=none;perex.cz; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.199]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e72cc5b0-c05f-4e83-9d53-08d7fae55d3b
x-ms-traffictypediagnostic: BN6PR1101MB2082:
x-microsoft-antispam-prvs: <BN6PR1101MB2082894FF74524FAC905EC8A97B80@BN6PR1101MB2082.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 04073E895A
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oAxtccJOoxh3hXBacwweP0ckmI2wRiuWBfAstfmffmEDf283F4vNhcbw5g1U9avyKBVfc9UgCoHsEqAXv9jXaeWV84xt9sgkxIdho3Q9sqQXqxLXhQZnheLWatt8RchldqjN8qyDqGEQvgqhBfit7ytDJVmlBbWsGvhScpF9oqbKniv4jpvFCCIY+p0TrcN1Vxj9kYKn4f9NAF2gJFVEs+xWq0bIKKind18wkrE1Mm4X/MjwvE/wMuc8ZKO1ZW/swHNK5orMlteisGNqCiaK+8p7LqCIdGY03SddzYTSEwrFPMxtV4wUk95GQzT1tPghRQtIbmwl64XtJeUKdk5Ltb+RojGuEZuliknKtBX6JmLUylbZ1x87utenzIXTx66jhb6I6FHxf1XJPMcvE25dXxeMlCnT0QF+kS5oT/JcJUQctjIdzROyuElNEflImRh/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR1101MB2132.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(346002)(376002)(136003)(366004)(396003)(6506007)(8676002)(33656002)(2906002)(9686003)(66946007)(4326008)(66476007)(66556008)(76116006)(66446008)(64756008)(4744005)(54906003)(7696005)(316002)(52536014)(478600001)(26005)(86362001)(55016002)(8936002)(5660300002)(71200400001)(110136005)(7416002)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: MCpowOWE4njXoublbgFYIRYe5ONftP/EgfUzxgKDBWXUB7ZydkbNizqRnskZmkEz3nZEOjZ1PmaUT5YwZqIazwTs94FXBaMF3mmV56WR1jDeJx7zR5arP4YPXunDTXp1NJVTjbYWCJ6DKUk/inzBeBVTf2SG01iiHXgjvIXqdX3KhC9OHrd0YD/AA/4Efy5QcW/jm+l568VZ5KmXx/auDdHPr4gPMnUnoJs0Bh1ODpi7lyfR2NS7JY9jkZdipAyw6J3HUff5ssHIA4lro8SHvAX0Ql7RAc5Y9ID9KXXGcTRTbO2XK075L96ANKP68kvcs9NrOBspTSjAQnoz4oG8Q0T+WPAhbJC9SWniXARiuWsC8UkAT3ZSewt0J1CnkhVq/+f7GQuRZ3MlwNATwbAz44zy+vV+4IV2I9LYTNxPIrR4Y1ZRgdf740W0DLMLgezP9ygGHDwZ4EX6rxR+SirynRV8zOVwHI0nL2W4hyGrpUsNeI2PVjcdImsgVVWc7HTp
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e72cc5b0-c05f-4e83-9d53-08d7fae55d3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2020 04:38:51.4087
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pCL6+VQYMqAaEo+nLGBFXlSI8+hBAVk7le+Zmm4/3H590fNlp4zMAjRYfXQ+f07TFO/LCAyXqxgOmMuYN4MoTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2082
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiANCj4gSSB0cmllZCB0byBpbWFnaW5lIGEgbmVnYXRpdmUgaW1wYWN0IGZvciB0aGlzIGh3X3B0
cl9qaWZmaWVzIHVwZGF0ZSB3aGVuIHRoZQ0KPiBETUEgcG9zaXRpb24gaXMgbm90IHVwZGF0ZWQg
ZnJvbSB0aGUgZHJpdmVyIGFuZCBJIGhhdmVuJ3QgZm91bmQgYW55IHNvIGZhci4NCj4gDQo+IExl
dCdzIGFwcGx5IHRoaXMgYW5kIHdlJ2xsIHNlZSBpbiBmdXR1cmUgOi0pDQo+IA0KPiBBbmQgeWVz
LCB0aGUgcGF0Y2ggZGVzY3JpcHRpb24gc2hvdWxkIGJlIGltcHJvdmVkIChETUEgcHRyIGlzIG5v
dCB1cGRhdGVkIC8NCj4gc3RyZWFtaW5nIGlzIGluYWN0aXZlKS4NCj4gDQo+IFJldmlld2VkLWJ5
OiBKYXJvc2xhdiBLeXNlbGEgPHBlcmV4QHBlcmV4LmN6Pg0KDQpIaSBKYXJvc2xhdiBhbmQgVGFr
YXNoaSwNCg0KVGhhbmsgeW91IGZvciB0aGUgcmV2aWV3LiBQYXRjaCBWMiBoYXMgYmVlbiB1cGxv
YWRlZC4NCg0KDQpSZWdhcmRzLA0KQnJlbnQNCj4gDQo+ID4NCj4gPg0KPiA+IHRoYW5rcywNCj4g
Pg0KPiA+IFRha2FzaGkNCj4gPg0KPiANCj4gDQo+IC0tDQo+IEphcm9zbGF2IEt5c2VsYSA8cGVy
ZXhAcGVyZXguY3o+DQo+IExpbnV4IFNvdW5kIE1haW50YWluZXI7IEFMU0EgUHJvamVjdDsgUmVk
IEhhdCwgSW5jLg0K

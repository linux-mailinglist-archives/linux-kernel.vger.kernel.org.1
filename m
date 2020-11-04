Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBFE12A62DF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 12:07:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729437AbgKDLHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 06:07:01 -0500
Received: from mail1.bemta23.messagelabs.com ([67.219.246.4]:33838 "EHLO
        mail1.bemta23.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729263AbgKDLG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 06:06:58 -0500
Received: from [100.112.1.203] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-4.bemta.az-b.us-east-1.aws.symcld.net id 68/AB-54728-F4B82AF5; Wed, 04 Nov 2020 11:06:55 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIJsWRWlGSWpSXmKPExsWS8eIht65/96J
  4g/b9YhYzOi+wW0xdu5vJ4vKuOWwWv5YfZXRg8dg56y67x6ZVnWwenzfJBTBHsWbmJeVXJLBm
  /Hn7g7XgoXzF9e75LA2Ma+S7GLk4hAQamCTmr3/HCOG8ZJR4cvoGC1xmxcHnUJlfjBJvJjwGc
  xgFljJLrGpvBCrjBHKOsUg87lSCSGxglOj+9RmsikVgN7NE++R3bBD985gkju2YzQ7hPGCUeH
  9hD1CGg4NNQEvi7KZEkFEiAqESv2/uYwexmQWcJI5vnsoEYgsLBEjMn/OCDaImUGLdyj2sELa
  RxLX3L8DqWQRUJI5euQJWzyuQILFqywuoL5oZJU5fnQzWzAnUvO80zN1iEt9PrWGCWCYucevJ
  fDBbQkBAYsme88wQtqjEy8f/WCF+62KU2P9yNwtEQlHi18qVbBC2rMSl+d2MELavxNMbZ6Cat
  SQ2LdgNVZMtcWjXGnYIW03ixpsOqBo5iVW9D1kmMBrNQnLHLGC4MAtoSqzfpQ8RVpSY0v2QfR
  bYb4ISJ2c+YVnAyLKK0SSpKDM9oyQ3MTNH19DAQNfQ0EjXSNdCL7FKN0mvtFg3NbG4RNdQL7G
  8WK+4Mjc5J0UvL7VkEyMwHaUUMHHsYLzz+oPeIUZJDiYlUd6WpkXxQnxJ+SmVGYnFGfFFpTmp
  xYcYZTg4lCR4kzuBcoJFqempFWmZOcDUCJOW4OBREuHd2wWU5i0uSMwtzkyHSJ1iNOaY8HLuI
  maOI3OXLmIWYsnLz0uVEue9DlIqAFKaUZoHNwiWsi8xykoJ8zIyMDAI8RSkFuVmlqDKv2IU52
  BUEuaNApnCk5lXArfvFdApTECnRIQvADmlJBEhJdXA1PrRyvcFy97lyTNW8pxLa5rK0V2WGeJ
  mKdocLpeg9/b3q/shYdrH5ePKmbZf8whUORTLOnejv3xQ5U+TVw8UbW72NyguW2qVOc3z2a+Z
  bdNrXbPCXlYYTpLw/bRxY/VlK59cjrCH1zoe9UUq6fyZ/pnZkf/qsv6Wawc5HT37PpRdf1hxx
  9S0tX1W0D+OeJXZe14/yN0mYyreJLVmQ2Fa1EPB3zIhG4yagyVfPnOqnLGS4+MmvpjGYEPtQ8
  zHVuXf1rqxhK2pr4jjT3mIeNhyXqdOmVvu4e2nc9cI77r6Y5p4WKYS/5rA6kmTiw+JWrbofWz
  nj//m9lt41eP1Hx/tut2s+5aH27LrQ8duTy0lluKMREMt5qLiRABChsUBVAQAAA==
X-Env-Sender: ahuang12@lenovo.com
X-Msg-Ref: server-20.tower-396.messagelabs.com!1604488015!5936!1
X-Originating-IP: [104.232.225.11]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.60.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 20376 invoked from network); 4 Nov 2020 11:06:55 -0000
Received: from unknown (HELO lenovo.com) (104.232.225.11)
  by server-20.tower-396.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 4 Nov 2020 11:06:55 -0000
Received: from HKGWPEMAIL02.lenovo.com (unknown [10.128.3.70])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by Forcepoint Email with ESMTPS id 33D9545D44A54D3882DF;
        Wed,  4 Nov 2020 06:06:54 -0500 (EST)
Received: from HKGWPEMAIL04.lenovo.com (10.128.3.72) by
 HKGWPEMAIL02.lenovo.com (10.128.3.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2044.4; Wed, 4 Nov 2020 19:07:36 +0800
Received: from HKGWPEXCH01.lenovo.com (10.128.62.30) by
 HKGWPEMAIL04.lenovo.com (10.128.3.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2044.4
 via Frontend Transport; Wed, 4 Nov 2020 19:07:36 +0800
Received: from APC01-PU1-obe.outbound.protection.outlook.com (104.47.126.57)
 by mail.lenovo.com (10.128.62.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2044.4; Wed, 4 Nov 2020
 19:07:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ckooy83gN31cvMa+BEEGXPQm2HXcbHllOmwlSzONNvoBd1SDd7rUvaMYzcEjU6vAh8dZAtx6ghi+qHkZUDXwqroA6AwbtViL+uEfQxSvUAJeTsqOhTGalTT87rXx783dozhb1vEvQwVZPWRdsIJBXRJvbYBYx+J8fM1m0+x0hFxi8ZZXRXdhK/tGH4jxlRNeSCIcDTw317/xCr8UW8S+FF1GeoOkFWAnI22CuqRU8KFZ+HFzWvdM+Q4urpp56myxMTfj7hysmqHYvRuP4zMNMPerKalRTnp93x75QY8Qpw8GXmWOxP1VteSKmRzELuy4e0+wsc4b9l3lrAE8BtNByA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YjgB5cC4ugCB+dNvc/dH3dWDoKJJ8H2ieMlrgkTquME=;
 b=gZHhUXqYgqOXTWrqK9Xv2jJeyZTyfRTUYRtL91Mso9eB0aSsbrTU22uldMnp13seLlhiPvuxGom6V1mF0VcR39BqH1LxOSWLQwhqihL9yQYl1k+Lv/DV3p9mCCVUJOC5RVOxMi4OZA77N9jELg2VZ3rWLaCR7jhGlV59tTC1IYp4543OmQkvnpZmskWLIDbdal68R/K6GQsInSw6zmRzryMtXkEvMzWVZtREfFWQ4e4CIjEVAnxySdILYC8CyTz0EPTJ1wXPCFq3Bbq8QvrbL7qsmbSuz2UufN6pOAi45YuJuh6d9XpOj2EtbcOn9czACXELATldEMnVO2eT1YjNfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lenovo.com; dmarc=pass action=none header.from=lenovo.com;
 dkim=pass header.d=lenovo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=LenovoBeijing.onmicrosoft.com; s=selector2-LenovoBeijing-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YjgB5cC4ugCB+dNvc/dH3dWDoKJJ8H2ieMlrgkTquME=;
 b=U4GVcF8l5YDEE9UBrlblJaeCUk/NUXmvSuH4fhD6pT4AxatB+owenvvDN5yN0WDQYyG19uxYSUqLuQU5yPl5zd5xbm0M5nm1NKlqdmdmWBLOe1rIrFAFbZ6hWJbjj6hBe8MpS3dlF/1QCXJYW3HniB6EM4tta9od6KuhbhjGVDo=
Received: from HK2PR0302MB2594.apcprd03.prod.outlook.com (2603:1096:202:c::8)
 by HK0PR03MB4948.apcprd03.prod.outlook.com (2603:1096:203:bc::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.10; Wed, 4 Nov
 2020 11:06:49 +0000
Received: from HK2PR0302MB2594.apcprd03.prod.outlook.com
 ([fe80::cf3:6e67:e2c8:4cb0]) by HK2PR0302MB2594.apcprd03.prod.outlook.com
 ([fe80::cf3:6e67:e2c8:4cb0%6]) with mapi id 15.20.3541.015; Wed, 4 Nov 2020
 11:06:49 +0000
From:   Adrian Huang12 <ahuang12@lenovo.com>
To:     Lai Jiangshan <jiangshanlai@gmail.com>,
        Adrian Huang <adrianhuang0701@gmail.com>
CC:     Tejun Heo <tj@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: RE: [External]  Re: [PATCH 1/1] workqueue: Remove redundant
 assignment
Thread-Topic: [External]  Re: [PATCH 1/1] workqueue: Remove redundant
 assignment
Thread-Index: AQHWsZrDjpr56bY60E6UErMcYgauCam3mE9A
Date:   Wed, 4 Nov 2020 11:06:48 +0000
Message-ID: <HK2PR0302MB2594DAC4323A14A5652C153EB3EF0@HK2PR0302MB2594.apcprd03.prod.outlook.com>
References: <20201101122124.1185-1-adrianhuang0701@gmail.com>
 <CAJhGHyAQPGnF1rkeeNEHSmqFBS0Ku2h3rEc5tLfm-rEs1A=MhA@mail.gmail.com>
In-Reply-To: <CAJhGHyAQPGnF1rkeeNEHSmqFBS0Ku2h3rEc5tLfm-rEs1A=MhA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [118.171.49.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0c99d2b6-1bb6-471d-5c56-08d880b1b9f3
x-ms-traffictypediagnostic: HK0PR03MB4948:
x-microsoft-antispam-prvs: <HK0PR03MB494801D3AF27A18472EB5317B3EF0@HK0PR03MB4948.apcprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kixhyo0NaU2MCuyTzPbJ2QoGVoBI2AB2RDooJV5RXBs74QC0Y2BEYwacJerjxUIYoReriXarmh9/WVec2PsTe1h3bHKRM04Nk0nnYlmYAyOhDlaYuBm13ego5cAvelc2Ryn1yVkEPBX3SiHulw5CATWD2Z0PtNks+RMdd8hDLd2oPFgp9928TEnDllF+Giz6hCcr8X4cUJn4ANLjkuAlVdD0hCIUE5b7ZAnZaUjiB21Yy8tw/SbpgyHnUdarC6c9MIeimu82n1pxluUO1gAOM+tY183MF14rGksG5XuEt0QKQ/Hc8r2dRmVbYYB+bgAvsM8+LWv1rOYZDIwVj6E9vA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK2PR0302MB2594.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(346002)(376002)(396003)(39860400002)(26005)(478600001)(6506007)(53546011)(8676002)(5660300002)(55016002)(316002)(66556008)(52536014)(4326008)(7696005)(86362001)(186003)(66946007)(64756008)(66446008)(76116006)(66476007)(83380400001)(33656002)(71200400001)(110136005)(54906003)(8936002)(2906002)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: aEY4TQCCRu406Ee4emyr6lXfLwqg2/gjFa7FaY3cjEfMlmaYTj7Xup2SVo8nTeRVijEwVfJTur62oXzw0ONFwNofGt5Za19RKAO8+om9tD8dtZdPeDjp/+8EzcejWwP+jniVApZi4miZNg2dogROlwgTfWo34MN5Af+YRwXMhqkdCRoE9pkt5UhqH59597ennJvh1uHl0GFz62Fpz+YWTHt/9bNHEzSQ9WaH7Gu3roALPalnOPQZW+VXeCrjtMD2Lz7cmc05N5xA4K3HkNB61/hXoLaUbzm3mhIoTPWVXsquVpmrtMAPHceEbql2EZq3z4NscRQAZZonIs1V+I9Z/crMy04Qfk0WBF3Cz/i9Ns7+ux5uKU9hi4A4THyCmh6ilZK/L6dF2TGgitFEtyJFVBi0VOOwJ4FsaJ5/g1UAgJHWYv8y1qhXMM7yhSPLTyignemDnpSjnAhC0fbbFS46ETFjh+zqjCr/6hcjZE3xCBTEMxeXHNaoPIQ2ciAA+tcfDGmxP9BC8PF87Jkfku26wXqfzzorynhM5pkntOcKv4vUeETv4rf9ttqoGr1VS4h/Ysom3IRcNnTAWvT+hyEaCIVxVfUgIiYvZzByQzeQDLASCTyGZ24tpP/Z6mfA11dbiAr88fuYTygvnsrZlK8tiQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK2PR0302MB2594.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c99d2b6-1bb6-471d-5c56-08d880b1b9f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2020 11:06:48.9436
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2U5zu7Du6xFJk7PrC0ORlJqDoFSQYCFGF4EFIWIFnD5lpB3erJqvtHMvugf6u3e8SaeIL2IIRmwR1raDdV6P+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR03MB4948
X-OriginatorOrg: lenovo.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSmlhbmdzaGFuLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IExh
aSBKaWFuZ3NoYW4gPGppYW5nc2hhbmxhaUBnbWFpbC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIE5v
dmVtYmVyIDMsIDIwMjAgMTI6MzUgUE0NCj4gVG86IEFkcmlhbiBIdWFuZyA8YWRyaWFuaHVhbmcw
NzAxQGdtYWlsLmNvbT4NCj4gQ2M6IFRlanVuIEhlbyA8dGpAa2VybmVsLm9yZz47IExLTUwgPGxp
bnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+OyBBZHJpYW4NCj4gSHVhbmcxMiA8YWh1YW5nMTJA
bGVub3ZvLmNvbT4NCj4gU3ViamVjdDogW0V4dGVybmFsXSBSZTogW1BBVENIIDEvMV0gd29ya3F1
ZXVlOiBSZW1vdmUgcmVkdW5kYW50IGFzc2lnbm1lbnQNCj4gDQo+IEhlbGxvLCBBZHJpYW4NCj4g
DQo+IEkgYmVsaWV2ZSB0aGUgcG9vbC0+bm9kZSBpcyBiZWluZyB1c2VkIGFzIGEgbm9kZSBoaW50
IGJlZm9yZSB3b3JrcXVldWVfaW5pdCgpIGZvcg0KPiBhbGxvY2F0aW5nIG1lbW9yeS4gSXQgaXMg
dXNlZnVsIHdoZW4gaXQgaXMgY29ycmVjdC4NCg0KVGhhbmtzIGZvciB0aGUgY29tbWVudHMuIEkg
aGFkIHRoZSBzYW1lIGNvbmNlcm4gaW4gbXkgbWluZCBiZWZvcmUNCnN1Ym1pdHRpbmcgdGhpcyBw
YXRjaC4gTXkgdW5kZXJzdGFuZGluZyBpcyB0aGF0IHRoZSB3b3JrZXJfcG9vbC5ub2RlDQptZW1i
ZXIgaXMgdXNlZCB0byBwcm92aWRlIGEgbm9kZSBoaW50IHdoZW4gYWxsb2NhdGluZyB0aGUgJ3dv
cmtlcicNCnN0cnVjdHVyZSBvciBhbGxvY2F0aW5nIHRoZSB3b2tlcl9wb29sIHN0cnVjdHVyZSAo
Zm9yIHVuYm91bmQgd29ya3F1ZXVlDQpvbmx5KS4NCg0KLS0gQm91bmQgd29ya3F1ZXVlIC0tDQpU
aGUgd29ya2VyIHN0cnVjdHVyZSBpcyBhbGxvY2F0ZWQgd2hlbiBpbnZva2luZyBjcmVhdGVfd29y
a2VyKCkgaW4NCnRoZSBlbmQgb2Ygd29ya3F1ZXVlX2luaXQoKSwgc28gdGhpcyB3b24ndCBsZWFk
IHRvIHRoZSBwb3RlbnRpYWwNCnByb2JsZW0gYnkgcmVtb3ZpbmcgdGhlIHBvb2wtPm5vZGUgYXNz
aWdubWVudCBpbiB3b3JrcXVldWVfaW5pdF9lYXJseSgpLg0KDQotLSBVbmJvdW5kIHdvcmtxdWV1
ZSAtLQ0KVGhlIHdvcmtlcl9wb29sIHN0cnVjdHVyZSBpcyBhbGxvY2F0ZWQgaW4gZ2V0X3VuYm91
bmRfcG9vbCgpLg0KVGhlIGZ1bmN0aW9uIGdldHMgdGhlIGNvcnJlc3BvbmRpbmcgbm9kZSBpZCBi
eSBjaGVja2luZyB0aGUNCmdsb2JhbCB2YXJpYWJsZSAnd3FfbnVtYV9wb3NzaWJsZV9jcHVtYXNr
JyAob2YgY291cnNlLCBpdCBkZXBlbmRzDQpvbiBpZiB0aGUgZ2xvYmFsIHZhcmlhYmxlICd3cV9u
dW1hX2VuYWJsZWQnIGlzIHRydWUpLg0KVGhpcyBpcyBub3QgcmVsYXRlZCB0byAncGVyX2NwdSB3
b3JrZXJfcG9vbC5ub2RlJyAoZ2xvYmFsIHZhcmlhYmxlDQonY3B1X3dvcmtlcl9wb29scycpLg0K
DQpQbGVhc2UgY29ycmVjdCBtZSBpZiBJIG1pc3Mgc29tZXRoaW5nLiBUaGFua3MuDQogDQo+IA0K
PiBJIHRoaW5rIGl0IGlzIGJldHRlciB0byBpbml0IGl0IGVhcmx5IHVubGVzcyB0aGVyZSBpcyBh
IGJ1ZyBhYm91dCBpdCBpbiB0aGlzIGVhcmx5IHN0YWdlDQo+IHJlcG9ydGVkIChvbiBzYW1lIGFy
Y2hzKS4NCg0KT0ssIHBsZWFzZSBpZ25vcmUgdGhpcyBwYXRjaCBzaW5jZSB0aGUgcGF0Y2ggaXMg
bm90IGNyZWF0ZWQgZm9yIGEgYnVnIHJlcG9ydC4NCg0KPiBUaGFua3MNCj4gTGFpLi0NCj4gDQo+
IE9uIFN1biwgTm92IDEsIDIwMjAgYXQgODoyMSBQTSBBZHJpYW4gSHVhbmcgPGFkcmlhbmh1YW5n
MDcwMUBnbWFpbC5jb20+DQo+IHdyb3RlOg0KPiA+DQo+ID4gRnJvbTogQWRyaWFuIEh1YW5nIDxh
aHVhbmcxMkBsZW5vdm8uY29tPg0KPiA+DQo+ID4gVGhlIG1lbWJlciAnbm9kZScgb2Ygd29ya2Vy
X3Bvb2wgc3RydWN0IChwZXJfY3B1IHdvcmtlcl9wb29sKSBpcw0KPiA+IGFzc2lnbmVkIGluIHdv
cmtxdWV1ZV9pbml0X2Vhcmx5KCkgYW5kIHdvcmtxdWV1ZV9pbml0KCkuDQo+ID4gQ29tbWl0IDIx
ODZkOWY5NDBiNiAoIndvcmtxdWV1ZTogbW92ZSB3cV9udW1hX2luaXQoKSB0bw0KPiA+IHdvcmtx
dWV1ZV9pbml0KCkiKSBmaXhlcyBhbiBpc3N1ZSBieSBtb3Zpbmcgd3FfbnVtYV9pbml0KCkgdG8N
Cj4gPiB3b3JrcXVldWVfaW5pdCgpIGluIG9yZGVyIHRvIGdldCB0aGUgdmFsaWQgJ2NwdSB0byBu
b2RlJyBtYXBwaW5nLiBTbywNCj4gPiByZW1vdmUgdGhlIHJlZHVuZGFudCBhc3NpZ25tZW50IGlu
IHdvcmtxdWV1ZV9pbml0X2Vhcmx5KCkuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBBZHJpYW4g
SHVhbmcgPGFodWFuZzEyQGxlbm92by5jb20+DQo+ID4gLS0tDQo+ID4gIGtlcm5lbC93b3JrcXVl
dWUuYyB8IDEgLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBkZWxldGlvbigtKQ0KPiA+DQo+ID4g
ZGlmZiAtLWdpdCBhL2tlcm5lbC93b3JrcXVldWUuYyBiL2tlcm5lbC93b3JrcXVldWUuYyBpbmRl
eA0KPiA+IDQzNzkzNWU3YTE5OS4uY2Y4YzBkZjI0MTBlIDEwMDY0NA0KPiA+IC0tLSBhL2tlcm5l
bC93b3JrcXVldWUuYw0KPiA+ICsrKyBiL2tlcm5lbC93b3JrcXVldWUuYw0KPiA+IEBAIC01OTM3
LDcgKzU5MzcsNiBAQCB2b2lkIF9faW5pdCB3b3JrcXVldWVfaW5pdF9lYXJseSh2b2lkKQ0KPiA+
ICAgICAgICAgICAgICAgICAgICAgICAgIHBvb2wtPmNwdSA9IGNwdTsNCj4gPiAgICAgICAgICAg
ICAgICAgICAgICAgICBjcHVtYXNrX2NvcHkocG9vbC0+YXR0cnMtPmNwdW1hc2ssIGNwdW1hc2tf
b2YoY3B1KSk7DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgcG9vbC0+YXR0cnMtPm5pY2Ug
PSBzdGRfbmljZVtpKytdOw0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAgIHBvb2wtPm5vZGUg
PSBjcHVfdG9fbm9kZShjcHUpOw0KPiA+DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgLyog
YWxsb2MgcG9vbCBJRCAqLw0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIG11dGV4X2xvY2so
JndxX3Bvb2xfbXV0ZXgpOw0KPiA+IC0tDQo+ID4gMi4xNy4xDQo+ID4NCg==

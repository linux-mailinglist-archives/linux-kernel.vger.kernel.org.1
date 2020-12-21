Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D17952DFAC1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 11:08:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbgLUKHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 05:07:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbgLUKHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 05:07:17 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2061d.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e1b::61d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB741C0611CA
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 01:09:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WqkxJu+HJKxMDC4hLrnwwNHyItIkkO638C60c6p1Xex0aH9Qk10n3e4WcQzXNPIGDXg6c2Aqb0igGXvfK8UanTPIY20nydTC+jQlYCuuh7HuxRdzWnGHO+Pfwtrv13nSQ7vmvCIkE6u0NEpNRC7C7GMSHCone+B9OGVb8Nc8n8YQynFNDswm2JLI4Yj3UMCSM6f/j7i5QAmMOLr2Z42qq2rg+T+lGEfWB+JEaedmp5r/ORndJxwtOP1nzhGlbEyYd9kc5R25lPDfEDV7ZXvtpmLrX/wCjycM+euIKJ417tkmVzRmZUS9f4JCSGRYBvlFu9G7egs/J+d/ZnqVIHYO1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EkW7FGuFLxxoTQpyZ+Alyib9nmVWZ1lMzyjJt3AaDdI=;
 b=KrAv5GZOL1EKC7dG2OCvHIJHLIAPzKCjLUo6S7jgVCgw1tiGv2LoWb3s2dU10s/Tdb0cubLJDHWDLV8i8SewFbi66h6N+Zz3z3H4fMaspIRPVAUSEuFkx9WH/YY8L7Yje2MTuvYiGC5f5YKi/v7uIz9XkoVsFvFL9+DJnSMqAb0tTSqEeBZ1uGajk7bx1YE2hnFNc9Ilr/sCcTxZm75Kp1MyjNXt8qXKypYp+i7omU+ThppF6NkOuCOF7Hni3spgaSdM9Dr6a7dv46h4e4Z5RTv58U6V7BG6rOfTQlvViGWeLBNtQaRqtH1m3XyJ/cWkvs4C5Ac2qu3ejYPcM8svwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductoreurope.onmicrosoft.com;
 s=selector1-rohmsemiconductoreurope-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EkW7FGuFLxxoTQpyZ+Alyib9nmVWZ1lMzyjJt3AaDdI=;
 b=CxGRo9OWKzoLmD8orecdwTY9/hyyQn2oUeA6qSNyQDzXAjI/rlYZADLqzwkxTCXLEZobS3D9WuI5oGHVyUak5WRY581zCF27smcCHJ7hplbU5intycw4xnZBWDqwUZXXNkm5MIGjOarf1GtXrhsjTjhimTXK6KZlIWiEJz6VOXU=
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com (2603:10a6:7:55::20) by
 HE1PR03MB3164.eurprd03.prod.outlook.com (2603:10a6:7:5d::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3676.25; Mon, 21 Dec 2020 08:58:28 +0000
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::f1f1:eb1d:2bf5:eb87]) by HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::f1f1:eb1d:2bf5:eb87%7]) with mapi id 15.20.3676.033; Mon, 21 Dec 2020
 08:58:28 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "broonie@kernel.org" <broonie@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [PATCH] lib/linear_ranges: fix repeated words & one typo
Thread-Topic: [PATCH] lib/linear_ranges: fix repeated words & one typo
Thread-Index: AQHW106lPZPY+K/AhEKjwF6yLMUSKaoBQEaA
Date:   Mon, 21 Dec 2020 08:58:27 +0000
Message-ID: <f931932a47f9617e2179d9dd395a75fbcff9c3a9.camel@fi.rohmeurope.com>
References: <20201221040610.12809-1-rdunlap@infradead.org>
In-Reply-To: <20201221040610.12809-1-rdunlap@infradead.org>
Reply-To: "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Accept-Language: fi-FI, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 (3.34.4-1.fc31) 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none
 header.from=fi.rohmeurope.com;
x-originating-ip: [62.78.225.252]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2af7b76a-ad44-47d8-2acb-08d8a58e9546
x-ms-traffictypediagnostic: HE1PR03MB3164:
x-microsoft-antispam-prvs: <HE1PR03MB31648475AE86B7ECE186E612ADC00@HE1PR03MB3164.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9/OG5gfNiWyAsSK80zHjG3AM+oqeYg1peULUxFR/zvnjtV1AVokwzDKCce+uur+8XoFvEIKACS3XgCGyMsIpgjE+Wb+13yyzFs9M+YFnrh1fZh5uKlJYgRISwfW875eyPAWsUB5/JGuQH3HNGRRdKLK0RzGlc/tVpi6nt3uEntgk6oQuv0gdaN88NpW39LD0MtlsbM+Cb64FCzsuLYBC6dkDH8MeoJWiVqIAhOnYSaMSeDP4t/qaYMUJY/5wUWvo6tOzdDKCDSqDfLAchmw2z7CZdZ71yqrFmmmEL0ePhG51lJnVYucK8XNxGlipDJLmKNwsxBPRgUkKOWA7Toa7uOW1dQw1gS70qE7CMp/LTFWDSQ1WxIDYn8kV31e/8IoZP8Asj780IEMt8V4kgFuzNQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR03MB3162.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(366004)(136003)(39840400004)(346002)(76116006)(186003)(66476007)(478600001)(66556008)(66946007)(64756008)(66446008)(8936002)(86362001)(316002)(110136005)(4326008)(54906003)(71200400001)(5660300002)(6512007)(3450700001)(8676002)(2906002)(6486002)(4001150100001)(2616005)(4744005)(26005)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?SmtRL29keTA0eXlxMGs4SEsrZmFLNHcvYlFXeUxOTHdKSlR5cEZhR2V0NmZw?=
 =?utf-8?B?MW0rQ2s2T2krZURkcDBBek9zbVhCRWE5SVZDOGtybkNHUWx0azBmZXFwUDB2?=
 =?utf-8?B?VDB0NUltZkVTbEx0aWFaVS8xdU5rRkdaWC82cWNxZ1R1Ni83Yk0xUG5YQUNQ?=
 =?utf-8?B?cnVtdEVtVEdnUU5sa2ZtakpmWnkrYWJqU3l1eXByMnpyYW5BRno5anpNaHdC?=
 =?utf-8?B?dWI0eWYxSEl0NlBReEZqeWVZOEVRN1BrZitCYjh1K1k4TU5jM0tYblUvd2lV?=
 =?utf-8?B?eDVnckZyUkRNdWVNbWpZSVdibTNzRlc1YXlKMWtHMTBxckNSL2pXUDEvaTMr?=
 =?utf-8?B?cW5uYkx1dTMzdzUvSTlFbDRnL1YxNWx6My8wVmxiTVhtV2lqY0RQZ3Focnls?=
 =?utf-8?B?c05sc0NmbTdWREE3YjlqazY0V0wyMkRoamlnZUdmcm1rODB6V0xXOUdtN2pQ?=
 =?utf-8?B?SzgvUTkrUjQzdTVxZERSbDZaWFRvVTcxb21JQ2NiTFZZNmY0WDNwWUg3cWlw?=
 =?utf-8?B?SktCT0xYS1FzNXNMdDBUcUltOVlOTGNlUDF5VmtoRWhmbHBabmNOUGNOYjc0?=
 =?utf-8?B?TmZnVGRMTzVjNndVUVVXVnQvcGlzRWdxai82ekVWQ3VNUFZyOGNha2htOWpq?=
 =?utf-8?B?NGs2U0ZHdzYvclF6VzhOYS82eStyY0JFK2M0T1gxOWlEcHRCVUtHUldDQ084?=
 =?utf-8?B?TnJYRjJ4NWxNU0hqU0cwVSt6d1o2UmNzSUJVdWIrcjVBOHZERDE4c090VWh1?=
 =?utf-8?B?azRsVkhKREdhY3E3WU9PYm4xU2ZETUVTTzZTZHRkek4wWHFEQ1VjNlBSU1cr?=
 =?utf-8?B?bHRkYlU1M3lnU1RRNHYrOTdkLzNOQTFJbmU0WEUzZWdlQVFRQi9mV0hNdi9I?=
 =?utf-8?B?TEVacHJHNWxyUkZwdTBmUUhRZXJZdDFtQW5PVVFuaEt0VXluYlhJcURnNCtP?=
 =?utf-8?B?ek9CZXMvd24vSzZiWDRMZVN2TTRkSkhVNGJ0b1BWcFdHR1FvTkZSRzNTUGcz?=
 =?utf-8?B?TVNzdmhKWmJMaXBxWkIrUFJFci81RUdmRTFSVWxobEMzVExNTVROTy9VRHZ3?=
 =?utf-8?B?Sld2R042Q0FpWmVSYkJHNnN4aDJEYnZjMTZONW5QTGIvUzJVcFo5RmpIUlFp?=
 =?utf-8?B?UjJNbWVjWUNiQjJUSXU5OTBPYUhUdEwzaVdQQXZLMVZUNU8yQkRONHhienpO?=
 =?utf-8?B?TitUaEdwQytDUE1EQXo0elZ2RjVXTEZVUjNycDYrd1NmcWU0eFcrbmMvUTJO?=
 =?utf-8?B?WC9rMjV1Q3dVVkpxYW9XS3R6NEVsQTlrTEtoVWZIMVdYSzJKYk5uTTVEQWRn?=
 =?utf-8?Q?8CWfuX0w717mbNxDGGSUQVstnHobmBcXbc?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <555F6D14D952FC49A6415B57FF00AD46@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR03MB3162.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2af7b76a-ad44-47d8-2acb-08d8a58e9546
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2020 08:58:28.0438
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 94f2c475-a538-4112-b5dd-63f17273d67a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hiZJfCJY+4KoKoNqSj65XjcH9AmoSgjiLL9cubvVDUweikdVZ73PRYPN58LpS30YySZfZ4YDggfsGKADKvpzt6POzXng0+NJELpVf8/rEsOh+Nfq5e3uqxSRyYGRvSw5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR03MB3164
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhhbmtzIGZvciBjb3JyZWN0aW9ucyENCg0KT24gU3VuLCAyMDIwLTEyLTIwIGF0IDIwOjA2IC0w
ODAwLCBSYW5keSBEdW5sYXAgd3JvdGU6DQo+IENoYW5nZSAid2hpY2ggd2hpY2giIHRvICJmb3Ig
d2hpY2giIGluIDMgcGxhY2VzLg0KPiBDaGFuZ2UgInJhbmdlcyIgdG8gcG9zc2Vzc2l2ZSAicmFu
Z2UncyIgaW4gMSBwbGFjZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFJhbmR5IER1bmxhcCA8cmR1
bmxhcEBpbmZyYWRlYWQub3JnPg0KPiBDYzogQW5kcmV3IE1vcnRvbiA8YWtwbUBsaW51eC1mb3Vu
ZGF0aW9uLm9yZz4NCj4gQ2M6IE1hcmsgQnJvd24gPGJyb29uaWVAa2VybmVsLm9yZz4NCj4gQ2M6
IE1hdHRpIFZhaXR0aW5lbiA8bWF0dGkudmFpdHRpbmVuQGZpLnJvaG1ldXJvcGUuY29tPg0KDQpS
ZXZpZXdlZC1ieTogTWF0dGkgVmFpdHRpbmVuIDxtYXR0aS52YWl0dGluZW5AZmkucm9obWV1cm9w
ZS5jb20+DQoNCkJlc3QgUmVnYXJkcw0KCU1hdHRpDQo=

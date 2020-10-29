Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15BB429E4D6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 08:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387817AbgJ2Hrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 03:47:46 -0400
Received: from mail-eopbgr700054.outbound.protection.outlook.com ([40.107.70.54]:12768
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387744AbgJ2Hri (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 03:47:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X8mSqPUNAi8wNasGO3itcMHca+FjxFgsMFc4CaWkIxNu3BvXZ4Qr/WEZDF/sZDmNgVCB2esWOjydBRL6w3lDHpmkfv5Em6Ue+8cfUr6+WOZn4LzVh2QqwCSN5NimQlM0w1RjuIOl8XTQhyiQf2ogup03+jMgZefiCBUgow5LZ7hY1b9zd+a2tPzsDvSBP31cZy9hYnWdDbhToZBIkpj+qaxdnL4VulKoeE59DyfEynwadwfiSCYerjscxEgogO/bZNOD+2GEjBFne/RVt0zBQnVOGPkZFLrVX8E1AHy/gUYyVkZVh2AQ/Z2Jsz6h7x1yeIw+XnnDCZTFUH45PRpbew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s9TcI5zwQbfOjheVhhbmMmc+JJEvzxc3REsh9og0d7g=;
 b=lYFVO3MC4taxPxG7eTGrXTLpAr7YJP0lFHnefEYo8uXn57553Xt2Utj2CWde5IoUxFH1GSlIn5UMJatI4dTvWklP8jIjC0Bi7WZqsxseYTWN4lQp/+s0KrT/IT+V+BxvVoAQ2frOwlId3MoEn+LcnD2Ooo103yyvZ23p57I/U7sCLzepd/ZZUe5SRBEyKFiuoFkbpNqrCNrNONzPorFlx4dPg+VT2QYgNDKRNljh5JWkSuyo7BQz+K1uVsIqCviu6o61qEIEwyer56oLt3Rt9FK6fshhWF2TRumJVVzst/onh4Izhj8uWv3tjX9eXlP47DRMsguTf+Znllewu4689w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s9TcI5zwQbfOjheVhhbmMmc+JJEvzxc3REsh9og0d7g=;
 b=O5RNjzR31B2fmdFfeHRIgYJV2azrCx+WXZZd17oxtV5RO+3wdXIsaFwROT30EjJ1sm/6/sYRchOJs+OlGsUOClM+804nCmBbh3qY6hYTSFE19MNt6cRJZIGomvjXZBJA5w5khJEkUJzxNA86PUtIVkLdw+QrAGydnGWDVVss6D0=
Received: from BYAPR11MB2632.namprd11.prod.outlook.com (2603:10b6:a02:c4::17)
 by BY5PR11MB4242.namprd11.prod.outlook.com (2603:10b6:a03:1c1::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Thu, 29 Oct
 2020 03:14:48 +0000
Received: from BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::80e9:e002:eeff:4d05]) by BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::80e9:e002:eeff:4d05%3]) with mapi id 15.20.3455.037; Thu, 29 Oct 2020
 03:14:48 +0000
From:   "Zhang, Qiang" <Qiang.Zhang@windriver.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        "pmladek@suse.com" <pmladek@suse.com>,
        "tj@kernel.org" <tj@kernel.org>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?gb2312?B?u9i4tDogu9i4tDogW1BBVENIIHYyXSBrdGhyZWFkX3dvcmtlcjogcmUtc2V0?=
 =?gb2312?Q?_CPU_affinities_if_CPU_come_online?=
Thread-Topic: =?gb2312?B?u9i4tDogW1BBVENIIHYyXSBrdGhyZWFkX3dvcmtlcjogcmUtc2V0IENQVSBh?=
 =?gb2312?Q?ffinities_if_CPU_come_online?=
Thread-Index: AQHWrPw9OwuDy1fQzkmcP0zoeTZ8vamsryIAgAADXxaAAAtwAIABGviN
Date:   Thu, 29 Oct 2020 03:14:48 +0000
Message-ID: <BYAPR11MB2632B18DF7C02B68E758932BFF140@BYAPR11MB2632.namprd11.prod.outlook.com>
References: <20201028073031.4536-1-qiang.zhang@windriver.com>
 <874kme21nv.fsf@nanos.tec.linutronix.de>
 <BYAPR11MB263255ED056CED38285FC95BFF170@BYAPR11MB2632.namprd11.prod.outlook.com>,<871rhi1z7j.fsf@nanos.tec.linutronix.de>
In-Reply-To: <871rhi1z7j.fsf@nanos.tec.linutronix.de>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none
 header.from=windriver.com;
x-originating-ip: [60.247.85.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 09cc969c-c97a-4884-0288-08d87bb8cb18
x-ms-traffictypediagnostic: BY5PR11MB4242:
x-microsoft-antispam-prvs: <BY5PR11MB424213612BDB6E0C1F127BB9FF140@BY5PR11MB4242.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LX9OQDfbxpZj1NBsvcObhNmNAZHpLdmauj9RhBbzgUgBqUgQnk8MhWW26+xMDQnphRH0FPV5GDZji1aUm9XVFx4WydZ5SdbJ/nPbgnmWmEol0UsuV67PnEDa1kIWD7Dz/O/TebnjlfyuBezK0o7Gt/YDGHi3lXIkyUiC5rvJ5Y/K1bp165UzrBGBArUrgalo+igePp1N4zbcELzrx/aCRkLr8zYRQyL9waLfY7fbHcYUJMHHYnOO4//DndkE0SHwwr+at+M+1d1/rUN8H62tyWArCfjM5AWAg8CQye6cDtS1eM+EKbL/ln5EwuCHB4K3J4bFJPb+X6BcFH+5Wn4/Lw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2632.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(136003)(366004)(346002)(376002)(396003)(2906002)(316002)(54906003)(110136005)(26005)(4326008)(6506007)(186003)(9686003)(478600001)(55016002)(7696005)(71200400001)(8936002)(5660300002)(66946007)(91956017)(76116006)(52536014)(66476007)(66446008)(66556008)(64756008)(86362001)(33656002)(224303003)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: Ak2SIv3fvcmxp6BOAGUBmp4Xmx4azyA5F1+sik1LrOC85pz5Ldxv2r4kvd25B5DJvWfoxyB0sjB5Ib+KVlz76RUfcmfH9JuUU3QJk3965AAoCuUzuLab6xn6SZrruoUsZPFeT+8k6df3GwFJgpGyDrOVOUR5dIHzy+QxdDOsup35muX2lXIT6Tm1Oqz7Bz6RyyidDjS+SLi9VWDL2DT2OEAMQVdmJ2H63u0scA6jb+mlSGvwu8tSqPE1HENIAN9th44DU5Drk5y3OZrTk21D4jEX7xEYHm1ZEaucwp3IClHpgtCShUv1sSjiUNyun6bf4kpSCsDwwzxWapENCKkuxFA/j31QTJeQgJOvFOjnMrhNYYW/AnXgVoRGIZDkh6cY6EHtAY/fWm0zfEZxRPoJQqEdujkTwq4zktv+voW1Q9YUHNGyp220lUJLRJ9b4guogOLe0UmOpF2ZbgN5iXTG909yS1goO32OUimSb3/f2R9U9LHKw9ZDbbt3HdPkeeIlugHX8TluE4P3Y+k7LLdZU3e7Xk4Cou0Tmxb2U7rkVPZxXNJkKvdm3OIToxTrgLzPbSYP3x9SOvDwB4nERETdCtJzyAdFyt7QttzFNKbscmPZk9URxHBVwMVXh+AibiihIjAkEip1mY1widwFZPQwRw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2632.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09cc969c-c97a-4884-0288-08d87bb8cb18
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2020 03:14:48.3283
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cvaWR4dLQP10Vzhu1P02sRIau1PAp7hBvQn4zr59bnaQfWc1z7S+zCG6s3+O/5GouPy5LPr7A2smkuzQNjP8sgrQ/nFIuwoGGszZscIIkSI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4242
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCreivP7IyzogVGhvbWFz
IEdsZWl4bmVyIDx0Z2x4QGxpbnV0cm9uaXguZGU+Creiy83KsbzkOiAyMDIwxOoxMNTCMjjI1SAx
NzoyMwrK1bz+yMs6IFpoYW5nLCBRaWFuZzsgcG1sYWRla0BzdXNlLmNvbTsgdGpAa2VybmVsLm9y
ZwqzrcvNOiBha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnOyBsaW51eC1tbUBrdmFjay5vcmc7IGxp
bnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcK1vfM4jogUmU6ILvYuLQ6IFtQQVRDSCB2Ml0ga3Ro
cmVhZF93b3JrZXI6IHJlLXNldCBDUFUgYWZmaW5pdGllcyBpZiBDUFUgY29tZSBvbmxpbmUKCj4g
W1BsZWFzZSBub3RlIHRoaXMgZS1tYWlsIGlzIGZyb20gYW4gRVhURVJOQUwgZS1tYWlsIGFkZHJl
c3NdCj4KPiBPbiBXZWQsIE9jdCAyOCAyMDIwIGF0IDE1OjMwLCBxaWFuZyB6aGFuZyB3cm90ZToK
Pgo+PkhvdyBpcyB0aGF0IGFkZHJlc3NpbmcgYW55IG9mIHRoZSBjb21tZW50cyBJIG1hZGUgb24g
VjEgb2YgdGhpcz8KPgo+IERvIHlvdSBtZWFuIHRoZSBmb2xsb3dpbmcgcHJvYmxlbToKPgo+ICJU
aGUgZHluYW1pYyBob3RwbHVnIHN0YXRlcyBydW4gbGF0ZS4gV2hhdCdzIHByZXZlbnRpbmcgd29y
ayB0byBiZSBxdWV1ZWQKPiBvbiBzdWNoIGEgd29ya2VyIGJlZm9yZSBpdCBpcyBib3VuZCB0byB0
aGUgQ1BVIGFnYWluPyIKPgo+VGhpcyBpcyBvbmUgcHJvYmxlbSwgYnV0IHRoZXJlIGFyZSBtb3Jl
IGFuZCBJIGV4cGxhaW5lZCB0aGVtIGluIGdyZWF0Cj5sZW5ndGguIElmIHRoZXJlIGlzIGFueXRo
aW5nIHVuY2xlYXIsIHRoZW4gcGxlYXNlIGFzay4KClJlYWxseSwgdGhpcyBwYXRjaCBpcyBub3Qg
Y29uc2lkZXJlZCB0aGF0IHdvcmsgbWF5IGJlIHB1dCBpbnRvIHRoZSBxdWV1ZSBhZnRlciB0aGUg
Ym91bmQgQ1BVIGlzIG9mZmxpbmUuICAgaW4gYWRkaXRpb24sIHdoZW4gdGhlIGJvdW5kIENQVSBn
b2VzIG9ubGluZSBhZ2FpbiwgYmVmb3JlIHJlc3RvcmluZyB0aGUgd29ya2VyJ3MgQ1BVIGFmZmlu
aXR5LCB3b3JrIG1heSBiZSBwdXQgaW50byB0aGUgcXVldWUuCgpBbHRob3VnaCAgaW50IHRoaXMg
KHBvd2VyY2xhbXApIHdheaOsdGhhdCdzIG5vdCBhIHByb2JsZW0sIHRoYXQgaXQgaXMgc29sdmVk
IGJ5IGRlc3Ryb3lpbmcgYW5kIGNyZWF0aW5nICB0YXNrcyB3aGVuIHRoZSBDUFUgaG90cGx1Zywg
IGluIGFkZGl0aW9uLCAgd2hlbiBDUFUgZ29pbmcgZG93biAsIHRoaXMgbmVlZCBjYWxsICdjYW5j
ZWxfd29ya19zeW5jJyBmdW5jIGluIG9mZmxpbmUgY2FsbGJhY2ssICB0aGlzIG1heSBiZSBibG9j
a2VkIGxvbmcgdGltZS4gdGhlc2Ugb3BlcmF0aW9uIGlzIGV4cGVuc2l2ZS4KCnRoaXMgcGF0Y2gg
b25seSBqdXN0IHRvIHJlY292ZXIgIHRoZSB3b3JrZXIgdGFzaydzIGFmZmluaXR5IHdoZW4gQ1BV
IGdvIHRvIG9ubGluZSBhZ2FpbiB0aGF0IGNyZWF0ZSBieSAia3RocmVhZF9jcmVhdGVfd29ya2Vy
X29uX2NwdSIgZnVuYyAsICBsaWtlbHkgcGVyLUNQVSB3b3JrZXIgbWV0aG9kIHdoZW4gQ1BVIGhv
dHBsdWcgaW4gIndvcmtxdWV1ZSIgYW5kICJpby13cSIuCgpUaGFua3MKClFpYW5nCgo+Cj5UaGFu
a3MsCj4KPiAgICAgICAgdGdseAo=

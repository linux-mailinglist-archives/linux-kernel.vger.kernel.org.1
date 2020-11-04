Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 452512A5D46
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 05:07:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728499AbgKDEHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 23:07:38 -0500
Received: from mail-bn8nam11on2052.outbound.protection.outlook.com ([40.107.236.52]:27424
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727688AbgKDEHh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 23:07:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E3cPEfBqiM+Ngxw5iwM7vj4inU9KuQepW/wMlftx6avha2C31WwB24EkZAzkceS7J8QH8gP6vHUZ3y7ccZYqrZrwl05OdiItOy6H34n5Pa9hOQGhX/kcvP71Pdu3n50kIcINHydQyjhOi6OF3QhLlQnzL+dLzCcRxCYdTufi4A6wJqdD6IZB91KtN1xB5Yw5WwqWgRT5ozd4CWmruGC0xXmV4rB3RQX4ZBxM619fhIqRPhHmLhMnSoZ50JCN1TRacvwxbktorKQGjZAx/UX/J6p+NgRrDEYFGbX2ubheRvZx+L+3ogf8Fta8CwqUiovTyGnyL2nbC5Ler72pWS1pEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rkwa7RWO7PI5UKeJvkHpPcHHBEofRvq7NbAw2gWgLPU=;
 b=gOwOVU+W5se6KISRD9Ge4vbM5aRCnfZ9D+XJm0K5Pn9zjdGv/HHqTR/HW1uqBr9f+u6izFm5vtJ0xvJtRql7vU3LFP8OAQOefVq4X0/zygn/L4N80zyTPAzciB1jnq5I4so2XvjUiUFmrSsggP6UU1uiTt77cMvPlOrGXHB6P+42tHJ2eXJo6FhO18eh+q/fIrCjfG+j8+Ljc6p4A6apkGTubirU7r/aorabLVUO/qNQIf4/ZnaXgFZrVYkS8JZU8geJAiCuQuWh0uMI2vM+gXBPnETl3Y7ABSQSZnuM5moAmY8HiFm3jhzdGpTZQbH+gxjyg0vqlCVfnFu2A8E1Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rkwa7RWO7PI5UKeJvkHpPcHHBEofRvq7NbAw2gWgLPU=;
 b=bHwbiwIU8RQK6i/ADiAVvnp86cIA+u2SCTGA9SXI8SuL18P24J5PfHRgoR7AMIX+wRn+dabo6k+w+hqVpt5mnKJQ3V/FBXcWM6Ag4XhoRkgj1uUs09ry4ufCrisSJVgUT/+sGthDs74ZaQAk0m31jgsKu2OVXjQfQ1eRP5BNppM=
Received: from SN6PR02MB4381.namprd02.prod.outlook.com (2603:10b6:805:b3::32)
 by SN4PR0201MB3502.namprd02.prod.outlook.com (2603:10b6:803:4c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Wed, 4 Nov
 2020 04:07:33 +0000
Received: from SN6PR02MB4381.namprd02.prod.outlook.com
 ([fe80::3db0:8c28:e501:be1d]) by SN6PR02MB4381.namprd02.prod.outlook.com
 ([fe80::3db0:8c28:e501:be1d%5]) with mapi id 15.20.3499.030; Wed, 4 Nov 2020
 04:07:33 +0000
From:   Shubhrajyoti Datta <shubhraj@xilinx.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>
Subject: RE: [PATCH v6 2/8] clk: clock-wizard: Add the clockwizard to clk
 directory
Thread-Topic: [PATCH v6 2/8] clk: clock-wizard: Add the clockwizard to clk
 directory
Thread-Index: AQHWfUDIdC9/DTAeFki/8dKbUVv6v6lzv2qAgAAAfICARARV0A==
Date:   Wed, 4 Nov 2020 04:07:33 +0000
Message-ID: <SN6PR02MB438146090F4AD67F0BD7580CAAEF0@SN6PR02MB4381.namprd02.prod.outlook.com>
References: <1598621996-31040-1-git-send-email-shubhrajyoti.datta@xilinx.com>
 <1598621996-31040-3-git-send-email-shubhrajyoti.datta@xilinx.com>
 <160072319955.310579.4256832010356165092@swboyd.mtv.corp.google.com>
 <160072330324.310579.14466423524100614935@swboyd.mtv.corp.google.com>
In-Reply-To: <160072330324.310579.14466423524100614935@swboyd.mtv.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [157.45.18.94]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6ffd6393-2f67-43cc-eb45-08d8807727ef
x-ms-traffictypediagnostic: SN4PR0201MB3502:
x-microsoft-antispam-prvs: <SN4PR0201MB350226C8959A95D271AB48DEAAEF0@SN4PR0201MB3502.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OXF2EVKl45x5MwIqusVO+dZ5QY9OcQO9VK3x9634kC5WJj8QHteRtS20a37Y480PQNts6OWkirrSK40jXJQloGTLDuopNnS4dPtRKKyJlx9uJMP6jmwXWyAN2/MfUlx4N1n8A+Pr/LK+5j8uk+k5LVxs/bAmlSOX9Y+TG84BiSk/bL7uxYWIxq845LylPWNceQXQfHgtk598UM2O3NnHfadto/l4mmkAwWJCgEJ/jy8fSCIEvi6cf7FJuSPhjb3qRi7USM4VI2zZQxiBZw3ykF/rPlU4f/qPN0RqcLXugDPBYQsbzDeER0h6EB3nVQz7h7zcjPvcUFBA8Wzd2+KVxA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR02MB4381.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(366004)(136003)(39850400004)(376002)(76116006)(53546011)(66946007)(66446008)(478600001)(8676002)(4744005)(86362001)(64756008)(66476007)(66556008)(316002)(6506007)(26005)(8936002)(2906002)(110136005)(71200400001)(33656002)(54906003)(52536014)(9686003)(83380400001)(4326008)(7696005)(186003)(55016002)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: kf0MjQiUYnHLR8HAFfnmhp5fPcTViZdWYAs+s0PTF0brMJK7514lHmsev72FBi+8YK/8K9/h1vFzGEYuz07Bhw5/AthWvs9NKaVipS4RdmHlbvjpuipNlp+cofhE62Y/4dbSOiQKgXsgj231e6YXSV39z514qR/HxKoUV6Iec12P3GeAc6IFzCaQGuWpGbW9AQbvsWoVMYQWZwdYx56r2Ef9dBMKQOpkYAJU+KZpWV9zBa7cINSpDp4mK09AQt58J1xJahmEeXRq/7qtHwxZVqKH9SznVXufhQMZs3eml/Drw/izJUGajSYMqK6+/QSj8SypX84ssaXXhMdmIN9DQomy09mgpYpcIDQQs39hdkTTGJQD5ueY+QnGG+S5+OemZT4KgDncw5qATp8T/VzcqwpSVXgLeEnGX4qe1Tw5kO+NrRMRmkvfa4YQnsQfXfhmz3bve5YDm0bfy5KhKSs1lOm8LrQyjMQl1frxEvDNNKUXndsyB19FRSyqHqoeJi5lebEp5vM02g2FMMWCFJRQ/LrW/SOii5XX7kF2q17lCkL/2UqoZrlYSqNoy8+aw8sFojykhfUBQiB2CLTXy4Z1jCvPnBm0yZQDP+5nIjnypdh6THrqHnOZsYst9C7bMsvIPxDBL/oKj/AuzLw+Y7tItA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4381.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ffd6393-2f67-43cc-eb45-08d8807727ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2020 04:07:33.1214
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xCZLJfmh+fFV15n1ZYddmnw9xrwrKMKDbGjXJzn3CEEZfepWvXietuZUqDcyEgdwcqLiOHEGx4393ko8L1tt4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0201MB3502
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgU3RlcGhlbiwNCg0KVGhhbmtzIGZvciB0aGUgcmV2aWV3Lg0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IFN0ZXBoZW4gQm95ZCA8c2JveWRAa2VybmVsLm9yZz4NCj4g
U2VudDogVHVlc2RheSwgU2VwdGVtYmVyIDIyLCAyMDIwIDI6NTIgQU0NCj4gVG86IFNodWJocmFq
eW90aSBEYXR0YSA8c2h1YmhyYWpAeGlsaW54LmNvbT47IGxpbnV4LWNsa0B2Z2VyLmtlcm5lbC5v
cmcNCj4gQ2M6IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5r
ZXJuZWwub3JnOw0KPiBkZXZlbEBkcml2ZXJkZXYub3N1b3NsLm9yZzsgcm9iaCtkdEBrZXJuZWwu
b3JnOw0KPiBncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZzsgbXR1cnF1ZXR0ZUBiYXlsaWJyZS5j
b207IFNodWJocmFqeW90aQ0KPiBEYXR0YSA8c2h1YmhyYWpAeGlsaW54LmNvbT4NCj4gU3ViamVj
dDogUmU6IFtQQVRDSCB2NiAyLzhdIGNsazogY2xvY2std2l6YXJkOiBBZGQgdGhlIGNsb2Nrd2l6
YXJkIHRvIGNsaw0KPiBkaXJlY3RvcnkNCj4gDQo+IFF1b3RpbmcgU3RlcGhlbiBCb3lkICgyMDIw
LTA5LTIxIDE0OjE5OjU5KQ0KPiA+IFF1b3RpbmcgU2h1YmhyYWp5b3RpIERhdHRhICgyMDIwLTA4
LTI4IDA2OjM5OjUwKQ0KPiA+ID4gQWRkIGNsb2NraW5nIHdpemFyZCBkcml2ZXIgdG8gY2xrLg0K
PiA+ID4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IFNodWJocmFqeW90aSBEYXR0YSA8c2h1YmhyYWp5
b3RpLmRhdHRhQHhpbGlueC5jb20+DQo+ID4gPiAtLS0NCj4gPg0KPiA+IENhbiB0aGlzIGJlIGNv
bWJpbmVkIHdpdGggcGF0Y2ggIzY/DQo+IA0KPiBTb3JyeSwgSSBtZWFudCBwYXRjaCAjOC4NCkRp
ZCBub3QgZ2V0IHRoZSBjb21tZW50Lg0KRG8geW91IHdhbnQgdG8gc3BsaXQgdGhlIG1ha2VmaWxl
IGFuZCB0aGUgZHJpdmVyIHBhcnRzIG9mIHRoZSBwYXRjaC4NCk9yIHRoZSB3aG9sZSBvZiB0aGUg
cGF0Y2ggdG8gYmUgbWVyZ2VkLg0KDQpPciBkbyB5b3Ugd2FudCB0aGUgc3RhZ2luZyBwYXRjaCBt
ZXJnZWQgd2l0aCAgaGVyZT8NCg0KW1BBVENIIHY2IDgvOF0gc3RhZ2luZzogY2xvY2tpbmctd2l6
YXJkOiBEZWxldGUgdGhlIGRyaXZlciBmcm9tIHRoZSBzdGFnaW5nDQoNCg0K

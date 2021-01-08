Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C51912EEB3B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 03:21:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbhAHCUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 21:20:37 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:46660 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726099AbhAHCUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 21:20:37 -0500
Received: from mailhost.synopsys.com (sv2-mailhost1.synopsys.com [10.205.2.133])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 5BA2DC00E2;
        Fri,  8 Jan 2021 02:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1610072376; bh=zlQTpxAGMCV3dQ/z5IBuDdrTIZ2S49giDSFDb/QWfb8=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=i8l8HLLRnmCUabcev/dFfhvlchv67uNMOqVEIzfzyeNOaAVjZ1xy9HKQUjR4F70Qs
         9qNyNRv3qSJxJpi6Q+nwS18iC34YEUzzms1EnfWRQQyFfabRrZzWoFhjRlvyMC6VQl
         Em6sqGacsvs2z+2qi/bnQLobdBlhnwLrUIdKXkjY/g5n9RnQplU1nNSFjvi7a3ctQR
         m5j1QCw5s5Q34UY/703eN84epO/q4tr2oFzS8S4SZiFOHEEoa6pnI2xQ6KOA4R+0My
         q6+XYQ6cVENoWBWzo7SDfWGiQkG07UvyqiIzoiWcM8uTkVzNuDGg6Lc0v13VkOSfnT
         +Vjq8Hyz+nQhA==
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 21DC9A0096;
        Fri,  8 Jan 2021 02:19:34 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "GlobalSign Organization Validation CA - SHA256 - G3" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 174AC81002;
        Fri,  8 Jan 2021 02:19:32 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="QsLcn3nx";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dH3eAHenGbEPnFH7BdErUUBLytRhjASbFxwjcvENt9oWmDGqXCKCqjSE19Wrijh881fZxBcicw/GmRc9KsDw2BCndbTqHS13avbi8qv1bDO3mGexF4SlDwrOGUOkHbRnh9K1CQpQ4ERLYhCddcGPnWMAaLHU8Q6vHd0CXxwlSEwHxenGzllnZFlBqrpNmRi7S5hjTaqSuh4qlMMSxxdqKlim1z3/wz2+Ux1XENqMf4fj7yC80sjUp8AfUl3NW4UAn9Cd9nLF6wCU4tcyxi/OdKeDkBq632yjW5ELHAvNgICEoH5RrFoOyoxbhlixRox+A/nbIJ2ZodiHTZ3MM556/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zlQTpxAGMCV3dQ/z5IBuDdrTIZ2S49giDSFDb/QWfb8=;
 b=TUtIpvCQNGfaCPDy3VJjbdkXfLcrAdTt3w8KsvaDvVPPYt/4WoGAybMjyjFSUxrLqYAWMLlL/+ZJwlF7B//DxVTiFd+9Cv2Udpue+CKSkLpy6CkaLgTZLzqwdjAPSiDDwLikR1dIBNKxoChnAmEIzllkO1HLKPvCSwhb9+2e8ExP1y83sEonDsgyX75mfSQYAvv3thiPcTYlL8FKOxDmA5orP2DEwadIh9Jl6bBd2er4p8IdwSLiJN1Vb6hMPdUSbcq8whevrSrEL2XFcjvGMQkDZmE1RqR6Hv0UsFqkdRbDCsMhlOmTaJlEQPPE/devNkRcgBFPHtqnsGBPq4FsAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zlQTpxAGMCV3dQ/z5IBuDdrTIZ2S49giDSFDb/QWfb8=;
 b=QsLcn3nxTHhjVpr82aBCaLP8Eed3F7mICr7OKpMCig6JcSa4mNpc676JD0L8Mr9yV7NXYHRX6Gmbdcz9HckqCyPLTcyUr4PPNrqiexMSbTAPUaqlagqn/nL5E9lnufqdKPGuyLkD7EouzAHJxfBipnFzliETzy8Xipu9FYNy4kA=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by BYAPR12MB2949.namprd12.prod.outlook.com (2603:10b6:a03:12f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Fri, 8 Jan
 2021 02:19:30 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::895b:620d:8f20:c4d6]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::895b:620d:8f20:c4d6%6]) with mapi id 15.20.3721.024; Fri, 8 Jan 2021
 02:19:30 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Wesley Cheng <wcheng@codeaurora.org>,
        "peter.chen@nxp.com" <peter.chen@nxp.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH 2/3] usb: gadget: composite: Split composite reset and
 disconnect
Thread-Topic: [PATCH 2/3] usb: gadget: composite: Split composite reset and
 disconnect
Thread-Index: AQHW3jcavZZjl2yfjUafWGuOXYrMeaoZDPEAgAQAA4A=
Date:   Fri, 8 Jan 2021 02:19:30 +0000
Message-ID: <37f3412c-9e91-eb1e-3974-bb16546b4b39@synopsys.com>
References: <1609283011-21997-1-git-send-email-wcheng@codeaurora.org>
 <1609283011-21997-3-git-send-email-wcheng@codeaurora.org>
 <87k0srcyq7.fsf@kernel.org>
In-Reply-To: <87k0srcyq7.fsf@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [98.248.94.126]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fd10552e-532f-40eb-63da-08d8b37bd4ec
x-ms-traffictypediagnostic: BYAPR12MB2949:
x-microsoft-antispam-prvs: <BYAPR12MB294912390C81E2A7650398A5AAAE0@BYAPR12MB2949.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hQFxwWNDKoSWNMiCJ1MZ8B/yoDBORCL0vO8WnPdwwKiRwSara33KExQ+aOWPQbd7GaSZWBqccbeMkOYd1BjTtvD1DNEJ1LEmjV3++3IrQBrhNGBS8bJ8x3SA8qUWUwA/2ggURLyq/jXZw4uTJhMeyvQTCF6e8W0QEn6+hlOEfZqB/k1DkqEIT3z0AUaDB0UT9ZQD3izKsNxqSqfL6z7rIME5k+n79CHsBxmzr4bcFqbMvt0K4Uo4pjIbKD5q+m/I9VRkVMMFHQZlG8Wwmp5zMYKcuVd2a5Up4HyfxU7EcAIOwCNbdQWZsB3ZahdvJh5Kao563PzTOB/FOijQrM6eoCaBeGwtJBrf7HtOxRUQgQgjvgZfJSOblC56fh3a9LLRazBopJOPCD3tEdMB0PjY6rp6Go8lNqhBuQJqA/YbxXevkcSe5CAwfbX4CNmvGOXJ4/lOn4Xr6CtfU7L/daXNPDmufkq6ojvZ2SwYnaWrEiE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(396003)(136003)(346002)(366004)(66446008)(83380400001)(64756008)(66946007)(66556008)(66476007)(5660300002)(4326008)(76116006)(186003)(4744005)(31686004)(8936002)(26005)(2616005)(36756003)(54906003)(110136005)(71200400001)(8676002)(6486002)(316002)(31696002)(2906002)(86362001)(478600001)(6512007)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?cXhnc1gyaTdtL1R0WWxpM1RIMnJ1bGdJVERRZ2FaWHRIUzdLalJCaFlOZTZo?=
 =?utf-8?B?ZUMrZnVOcVU0eGJzeTFMSXFETUpQVFUvY08xVTF1aldRNEhHVmE0dUVRTUE5?=
 =?utf-8?B?M2dYYndmOEh1MTRZUmQ0eWNMQ3c3dHpBYVI5NW1YaXYraTAydmhBeHdsMngw?=
 =?utf-8?B?Qm5SZlBvZTFFcTJMeVpoeUVBalZhSi8vdHBFcjc0eWsyWFQrckhOd2JIN0NZ?=
 =?utf-8?B?SXd3SDBjOWhUc2xoTlBWcUxrL1Z0OEpNRmlZaThwc1pjWkdQQ2krcStZVVkv?=
 =?utf-8?B?T2JtT3hIWVlrNzlPdmlYcGQ5VUREYkxPZ1MzK2ZVNEZrYjVDNDMzbnZjNXJy?=
 =?utf-8?B?b0NyeElmU290ZU5XU0pmREZCYk1Yek9Qazd2UGJTaHFrTnFicG5qS2VzUW9s?=
 =?utf-8?B?YWlmU1BiSEZURG0vYjA0WjFYWUlEL3JpOEtDVzRKMCs1c25JN2wwU3NCNmg4?=
 =?utf-8?B?aEtZY0o2Z2VXeFNxRWxURmNCWlA3U3FMKzBjb3BUUFFxT2NhVnllMnlkaWtt?=
 =?utf-8?B?dlhYV04zbUtLNWVQbnd1VjA0UDVyV21RN3lIN3dINkRGR0NMcUFNZHVuMzQ4?=
 =?utf-8?B?WTV2SUEyb1hMWGNUcW0yZDZQQnNDN0tnamk5VkRTVzBYSGhvYytjMUlTUzNp?=
 =?utf-8?B?bjFyNFNENE1hTm14UlVzYmRqVmNNQTRaZ3VJVnhhcUIzRkJiU2dpbWY2QzZR?=
 =?utf-8?B?Mm5aN1R1ZkVpZUxJY3d0Zlc0ZFJGNU9TTnd0TThWSXJKMyswU05Nd0lETkta?=
 =?utf-8?B?Nks0dUlxYXpaYjZnNEdON0xtckhrcUoralNQUjRkQ1hCNGtqZmNlKy9aV2Vp?=
 =?utf-8?B?YThWdWwvYWN4MXowOVRmRzRBZFk5aFBOQmxjdERaeHNJYkVWRUFva1BZbXJq?=
 =?utf-8?B?aVJqOVAzdjQybDloUUZQYWxFZ3d2UksyK3FZcGZIUlFCdi9yb2kyaDE5a21p?=
 =?utf-8?B?MTVYVmdvUFFaSzRwZ2U4bW0wUHFJV3hEK0t1TzFDM2RhR3hlT1BJSm9RQXlh?=
 =?utf-8?B?MWJod1Y1K0kvZi9NUnRwZERZUTlaWTJVVWZicDFOWE51T1Q1L213a2lzSFJl?=
 =?utf-8?B?SG4rRlBRL0FwMm1Dc2RMR2tSOXN1eG5TUW5RZ0VDSU9saXZCNktxNzhLVS9O?=
 =?utf-8?B?M3orWDdRV2h6VlRrWXJCWmpVaEZoK2JLS2llVWM1ckcxeFE5T21Ibkl4dmxV?=
 =?utf-8?B?dkpSbVRKamRUcks2WEdtcjVTaGxya1ZXcEtKUUZJRWFCaVNjTSthQUZzZklC?=
 =?utf-8?B?MHdTVFBSODR4b25lZGNwN0JWVCtZWnlPWVV6bTN6MUtNSlFPTHYzbEQ5NlM2?=
 =?utf-8?Q?dZpu/BnM1p+yk=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <0156D544F1A52E44B591444DBB8E3103@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd10552e-532f-40eb-63da-08d8b37bd4ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2021 02:19:30.6576
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nMhh+FlsV0fB413kgtyoQ9EB3RpjfCKS9u26thsS+DmAhLs2BB9UrpCxAcOV6MdqSbxd24i14/wTvd13r+fRgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2949
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgV2VzbGV5LA0KDQpGZWxpcGUgQmFsYmkgd3JvdGU6DQo+IEhpLA0KPg0KPiBXZXNsZXkgQ2hl
bmcgPHdjaGVuZ0Bjb2RlYXVyb3JhLm9yZz4gd3JpdGVzOg0KPj4gK3ZvaWQgY29tcG9zaXRlX3Jl
c2V0KHN0cnVjdCB1c2JfZ2FkZ2V0ICpnYWRnZXQpDQo+PiArew0KPj4gKwkvKg0KPj4gKwkgKiBT
ZWN0aW9uIDEuNC4xMyBTdGFuZGFyZCBEb3duc3RyZWFtIFBvcnQgb2YgdGhlIFVTQiBiYXR0ZXJ5
IGNoYXJnaW5nDQo+PiArCSAqIHNwZWNpZmljYXRpb24gdjEuMiBzdGF0ZXMgdGhhdCBhIGRldmlj
ZSBjb25uZWN0ZWQgb24gYSBTRFAgc2hhbGwgb25seQ0KPj4gKwkgKiBkcmF3IGF0IG1heCAxMDBt
QSB3aGlsZSBpbiBhIGNvbm5lY3RlZCwgYnV0IHVuY29uZmlndXJlZCBzdGF0ZS4NCj4gVGhlIHJl
cXVpcmVtZW50cyBhcmUgZGlmZmVyZW50LCB0aG91Z2guIEkgdGhpbmsgT1RHIHNwZWMgaGFzIHNv
bWUgZXh0cmENCj4gcmVxdWlyZW1lbnRzIHdoZXJlIG9ubHkgOG1BIGNhbiBiZSBkcmF3biBtYXgu
IFlvdSBuZWVkIHRvIGNoZWNrIGZvciB0aGUNCj4gb3RnIGZsYWcuIE1vcmVvdmVyLCBVU0IzKyBz
cGVjIGhhcyB1bml0cyBvZiAxNTBtQSBtZWFuaW5nIHRoZSBkZXZpY2UNCj4gY2FuJ3QgZHJhdyAx
MDBtQSAoSUlSQykuDQo+DQoNCldlIHNlZSBpc3N1ZSB3aXRoIHRoaXMgcGF0Y2ggc2VyaWVzLiBG
b3Igb3VyIGRldmljZSBydW5uaW5nIGF0IFNTUCwgdGhlDQpkZXZpY2UgY291bGRuJ3QgcmVjb3Zl
ciBmcm9tIGEgcG9ydCByZXNldCBhbmQgcmVtYWluZWQgaW4gZVNTLkluYWN0aXZlDQpzdGF0ZS4N
Cg0KVGhpcyBwYXRjaCBzZXJpZXMgaXMgYWxyZWFkeSBpbiBHcmVnJ3MgdXNiLXRlc3RpbmcuIFBs
ZWFzZSByZXZpZXcgYW5kDQpoZWxwIGZpeCBpdC4NCg0KV2UgY2FuIHNlZSB0aGUgZmFpbHVyZSBv
bmNlIHRoZSBwYXRjaCAidXNiOiBnYWRnZXQ6IGNvbmZpZ2ZzOiBBZGQgYQ0Kc3BlY2lmaWMgY29u
ZmlnRlMgcmVzZXQgY2FsbGJhY2siIGlzIGludHJvZHVjZWQuDQoNClRoYW5rcywNClRoaW5oDQo=

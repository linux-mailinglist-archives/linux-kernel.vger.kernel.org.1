Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8D902C5455
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 14:00:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389434AbgKZM7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 07:59:31 -0500
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:42516 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388748AbgKZM7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 07:59:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1606395569; x=1637931569;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=+QjB4xGEF7sXkweY3Q2QnfXwoiYJTyKF2q1BAjax658=;
  b=pp/1/G/P9LPxIjldL3X/geM6bUyQ5DH1ABgvBjNQ5y2T2k07X0Y6E6O4
   pu3HIM/8KhQl+4nlmo7FS3t9NbRo9KhMhPuR+6ZdEZ2nQFWIlSz4YqrUA
   6cQSuFwCVchNyVzkKA5cIfChPEr6MonG1ZWlRnY1VeJrJfanzsdROa68N
   DZzWrMz7Um4FEUvHsBVxIpyicBKJ4p6de9C2gN1qNgb+EYTEwvr2KV7O2
   vnlMJdxXfyzDKm3DBedlzYxr0/DvgMsgm3YR+ElyXJdWZKgbBaiLu7JP7
   lZ+CzjRllqBxaIwdJZlR65hlGld+9Ox+uQUcqMtJr1qdgFIRV3HTqCFf0
   w==;
IronPort-SDR: 1AxdaLdUmOgBBJukonVW0OwOfoyehYCi/0LFSPySKIX4f7mP48N30crQsxp1aVeWJh4P+wrjUI
 oFRWBQmZZroJMaKUfv2vDsQ5s2H6tdn5WR3QX9RXbsXnpfvyQvhmE/Nixrev4TmWMEfMmd+H+g
 1Qk5zNkZq0JA8Ue2iANVwrx0C9zOHTyxysHWlOLPkm5wmNK131vtwcuh+jubHc+x8w/FR/BOu/
 L1kj9FefIx0uWmaXPZiLnhSyD5+kf80x9qN1Q/0M1hEDjzAdaK+OQFhscQAtfYb6PMc6ufXXp2
 XlA=
X-IronPort-AV: E=Sophos;i="5.78,372,1599548400"; 
   d="scan'208";a="94963595"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Nov 2020 05:59:28 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 26 Nov 2020 05:59:28 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3
 via Frontend Transport; Thu, 26 Nov 2020 05:59:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B3lePO9T1Fgo9gtpEcTNKR7eNS2jpkefbznPYIIBjKmKNxxqeMcaUuttlIvJ7LpQclMVFzVPtfrotRbKIgXWx8p0aBPV/FS+CLrBYLz3sIu7MiT/dV1F86LfG+IKnXBen8g67qk2WKmQoLq0pVATQ4p/JroHllz6MImM1Q2fpov7ZJLJ0K4c8ERs47/6zKlo5U5dgwpFxVA4z1tG0fd9foZcOu/0Dp6fem8QSjb8FVGPBZlIiZO0/EfhDkp47cfTk20SEdKAFrNbaFuzfLYAJEc8DpuD4t0VNjY3ETUc6Wd9cO+bwdZz41RC5dCqN7NJGMeRxbTlQuDodpjchSC4QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+QjB4xGEF7sXkweY3Q2QnfXwoiYJTyKF2q1BAjax658=;
 b=QnURxi5SkbpCHBjyjZGtjVHIfOhwKHrXHobwtW4HIR+ZSrhnj+LoOD9OqqnjzeyCbLcZAMh17rFq39DrCx67YNhqgsmtbaKU6Z8G8YnTfYoEZ0h6iu+vdJGSPvTf9870C0fM8YZFd1yDLr4O8YcZU3ueSXDcL9DoKHjMHhSErLlt0gWwr6h0VPT3YAjSA7g2zoPaZ9uR4Ln+wIHMTMaYeHW2CY2nR9f9+uaR2LnhBDlrgkVwE7oZWfNXEUNZAfRlS2ur7oZpJ0uBV8Ubusg7gs8gFM3iX4su8r+jhngy8wcVmzShFmXVunZQ8IWejM26gk2wrNeYv3UpDiBMX6foQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+QjB4xGEF7sXkweY3Q2QnfXwoiYJTyKF2q1BAjax658=;
 b=sOTOfVygDdDZy6brVxbo6cilF/iFhBqK07llLovR948RW2VyRKA2IYR2nvF+1Yr5PR0vaCjoT1RyxKr5YBZSX8JkbuXoQySK608RSfa7sXFpSIclS6yQCDmSUNQtVSdx1c2IvmPLtD/xCo6lYbuM4IWAqAUuncRaWSJlLv1ir1w=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by SA2PR11MB4937.namprd11.prod.outlook.com (2603:10b6:806:118::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.22; Thu, 26 Nov
 2020 12:59:25 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::6903:3212:cc9e:761]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::6903:3212:cc9e:761%7]) with mapi id 15.20.3611.021; Thu, 26 Nov 2020
 12:59:25 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <michael@walle.cc>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <boris.brezillon@collabora.com>
Subject: Re: [PATCH v5 1/3] mtd: spi-nor: atmel: remove global protection flag
Thread-Topic: [PATCH v5 1/3] mtd: spi-nor: atmel: remove global protection
 flag
Thread-Index: AQHWwpVIheOE53CDUkK+sIaiGLI1UqnaYsMA
Date:   Thu, 26 Nov 2020 12:59:25 +0000
Message-ID: <ae6f0c14-591e-2c98-33f1-fe5ee1e603c4@microchip.com>
References: <20201003153235.29762-1-michael@walle.cc>
 <20201003153235.29762-2-michael@walle.cc>
 <7b5159c1-5457-b43c-2bf2-1a17ed6df34a@microchip.com>
 <f9724ff71809557283beb7c8c4d4b356@walle.cc>
 <a8e086ac-a5f8-f422-82e1-758c7da794b4@microchip.com>
In-Reply-To: <a8e086ac-a5f8-f422-82e1-758c7da794b4@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: walle.cc; dkim=none (message not signed)
 header.d=none;walle.cc; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [79.115.63.172]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c197cf6f-076d-443e-54dd-08d8920b1a63
x-ms-traffictypediagnostic: SA2PR11MB4937:
x-microsoft-antispam-prvs: <SA2PR11MB49372203F74044C06ADFE287F0F90@SA2PR11MB4937.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PvMNgv0h2qdEIxAwH/cvhrVsmGTixHRO3KGzE7YOyvMYIqy5zmWcSOlEZhmkyWWlOXwJjYxGsPrmJvaaMGElvO9YJANRNCJKuJ3jN7dC1H5o7uceok24YdSFPNsh3YBUl7Wxaj0ACu4iAq4KLFBz76UhwEJ/7q+PcKbACfsBGRcAl6wcmV1cUygi6LjcOJx1q6F/Kfk3VNeY25SXpypRPLA+rF/BtBmZEpQwOPaiCCQmzNHuHx7AD33l28EfKfmm7BHk1+FRTC3KbDhbIIC4VcHOQqZUB7itZs5UUHbCpbpwC3xY7VoMe75fLHbX7f1YW0b7kpj6I3g4WFlUGFVb7FzxigbX116Dw6kgOJW466bgbQoEkN0RmP+z9huTPruefUi4h1G7tavArOXrC3bLMOsPhWW9OwgyCRZi39ByrSBbAMsLnkNDPKDmyyKn37AdgNs0DLRsyrtPg9QwW57XcQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(376002)(396003)(39860400002)(136003)(4326008)(2616005)(31696002)(186003)(66946007)(6486002)(31686004)(316002)(53546011)(54906003)(2906002)(6512007)(966005)(6506007)(36756003)(6916009)(26005)(478600001)(71200400001)(66476007)(76116006)(64756008)(66446008)(5660300002)(86362001)(83380400001)(8936002)(8676002)(66556008)(4001150100001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?VXhpcjFGSklNOHFQQTBhUXlMRVczZldKcG9oRGIwcFQrZzNmTzQ2UWc0bW5F?=
 =?utf-8?B?emtFUXBhMTZia3dCT1MvSmpPS3JjV2Y4UkRaU294ZnY5Um5lam1mMW8zMndi?=
 =?utf-8?B?bU8vYTdmbi9LaTZGRDM2dTJMa3czSUJoSU12UG43K1oxaUdaaW9xQnJUOVpV?=
 =?utf-8?B?dlhuNlRmMGdFc1RNQ3g3UG0waHRCV0dyM3U2OXpJNWI5WTF0U1N3a21SNCtk?=
 =?utf-8?B?SXYrWGNOWHpYZkI1elZXbXlKTnRleVdzcTF2dXUvL0prekdtL2xLbmwyd2Mv?=
 =?utf-8?B?YktGMitlVGVuWTVSN0FhTHJ4YWlOcmZDR21DWU00VUlqcGxMSjg5T0FZK25k?=
 =?utf-8?B?cTF2bEZPYTBqK3c2WUV0dDkzMnNWRzJSUk4yenYzMkZ6N0swbVc5NFV4Nmli?=
 =?utf-8?B?aHBTWEx2SElYaGFqRzhVdytPaVQ5M2VsZUk5TE1OTCtid3VxRVNRVkprMXlN?=
 =?utf-8?B?Q0l3Rk1NcThyQlp5K0NndTlrYjBFNlIrU2dEUlpNOTZTbisvaVlURVhlb0hj?=
 =?utf-8?B?SHdreURNMWRMQTlsNmZMK09XSGdpV2k5dHRxNmdzcm5BVUdhdEVxL3hYTGR3?=
 =?utf-8?B?YWZBVEZ6VktjaXJ3M2FORnRIV2x1YW5wRDZBendLQjJtVmpaMkFiVVNGU1Rx?=
 =?utf-8?B?ZS9PdXh5TDdyWFNCclQ5ZzNIbExkVlRGbC9GVW5RYkM1WTRad25IR1ZyNGxK?=
 =?utf-8?B?aTlsd1N1Wldhc041RjdCVVR4eWtyRUZjTzM1ZFhWVkx1V21BbE5Ld1AvT3Mw?=
 =?utf-8?B?Qnc4eERJQjA4ZTdjZUJJOXFJa2EzRGNuMURhY25EMSt4YVJMelloeGJuSkx2?=
 =?utf-8?B?dXZPcG9iUnlRckpBM2ZLSWc0d0NlSURjTUl0ci9RRFFiWWdaUG9Dbjk0YUJP?=
 =?utf-8?B?U0dXQVJZbVR5N2owSTFkYys1OS94cUVHR1RlSkt1NUJ1bDhKbmFDbHpuUnJS?=
 =?utf-8?B?VEMwV0Iwc1Z2eklVMXArWFJsTCsyVTBUMm13ODcyRk5ueWt0N0RVeHg0NEVB?=
 =?utf-8?B?cFlUazlLYmlOdkowanMvaHE3c0xOVjY4ZzQ5cmtKOW05bWNCTHNHc2VJbnZl?=
 =?utf-8?B?RHBuYW1nbkZ5RzNhTW9QdEpBZStqZzd1ZmZ4SDhQV2ROaVErdmxxWjJXczk4?=
 =?utf-8?B?NFZtVExybHFDVEJNdU9ZY2dTSmNHdUlLK0djY3ZNekFPVGNuNWRmeTdyZk13?=
 =?utf-8?B?QnVkUE8rWWtQTmhtTDhINDJTbXpNV2g5Q0IrcTEzWVc0amp1bXdiS3ZmeVpZ?=
 =?utf-8?B?Y252L3NDTTU0RDd0dXN3SDE4Y3B0WTVIM2dCVUhhR1lSUFF1Nk9PcS9yN3B1?=
 =?utf-8?Q?X8z02m9mZGdOE=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <1CAEF96A1D8AD54BA1BA27E6E9C1A27B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c197cf6f-076d-443e-54dd-08d8920b1a63
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2020 12:59:25.6962
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9ipiY5CyVNchtH916UBYcGg3gBxcIE/14Rsj/AMYerDfDKuLMq2oYUJvYgiBqgIF9EjQE+pzgzaO1aoFVzuXlGRwyPyk0V246/y76b7sazM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4937
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTEvMjYvMjAgMjo0NSBQTSwgVHVkb3IgQW1iYXJ1cyAtIE0xODA2NCB3cm90ZToNCj4gT24g
MTEvMjUvMjAgODoxNyBQTSwgTWljaGFlbCBXYWxsZSB3cm90ZToNCj4+IEVYVEVSTkFMIEVNQUlM
OiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cg
dGhlIGNvbnRlbnQgaXMgc2FmZQ0KPj4NCj4+IEFtIDIwMjAtMTEtMjQgMjA6MDksIHNjaHJpZWIg
VHVkb3IuQW1iYXJ1c0BtaWNyb2NoaXAuY29tOg0KPj4+IE9uIDEwLzMvMjAgNjozMiBQTSwgTWlj
aGFlbCBXYWxsZSB3cm90ZToNCj4+Pj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5r
cyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdw0KPj4+PiB0aGUgY29udGVudCBp
cyBzYWZlDQo+Pj4+DQo+Pj4+IFRoaXMgaXMgY29uc2lkZXJlZCBiYWQgZm9yIHRoZSBmb2xsb3dp
bmcgcmVhc29uczoNCj4+Pj4gwqAoMSkgV2Ugb25seSBzdXBwb3J0IHRoZSBibG9jayBwcm90ZWN0
aW9uIHdpdGggQlBuIGJpdHMgZm9yIHdyaXRlDQo+Pj4+IMKgwqDCoMKgIHByb3RlY3Rpb24uIE5v
dCBhbGwgQXRtZWwgcGFydHMgc3VwcG9ydCB0aGlzLg0KPj4+PiDCoCgyKSBOZXdseSBhZGRlZCBm
bGFzaCBjaGlwIHdpbGwgYXV0b21hdGljYWxseSBpbmhlcml0IHRoZSAiaGFzDQo+Pj4+IMKgwqDC
oMKgIGxvY2tpbmciIHN1cHBvcnQgYW5kIHRodXMgbmVlZHMgdG8gZXhwbGljaXRseSB0ZXN0ZWQu
IEJldHRlcg0KPj4+PiDCoMKgwqDCoCBiZSBvcHQtaW4gaW5zdGVhZCBvZiBvcHQtb3V0Lg0KPj4+
PiDCoCgzKSBUaGVyZSBhcmUgYWxyZWFkeSBzdXBwb3J0ZWQgZmxhc2hlcyB3aGljaCBkb2Vzbid0
IHN1cHBvcnQNCj4+Pj4gwqDCoMKgwqAgdGhlIGxvY2tpbmcgc2NoZW1lLiBTbyBJIGFzc3VtZSB0
aGlzIHdhc24ndCBwcm9wZXJseSB0ZXN0ZWQNCj4+Pj4gwqDCoMKgwqAgYmVmb3JlIGFkZGluZyB0
aGF0IGNoaXA7IHdoaWNoIGVuZm9yY2VzIG15IHByZXZpb3VzIGFyZ3VtZW50DQo+Pj4+IMKgwqDC
oMKgIHRoYXQgbG9ja2luZyBzdXBwb3J0IHNob3VsZCBiZSBhbiBvcHQtaW4uDQo+Pj4+DQo+Pj4+
IFJlbW92ZSB0aGUgZ2xvYmFsIGZsYWcgYW5kIGFkZCBpbmRpdmlkdWFsIGZsYWdzIHRvIGFsbCBm
bGFzaGVzIHdoaWNoDQo+Pj4+IHN1cHBvcnRzIEJQIGxvY2tpbmcuIEluIHBhcnRpY3VsYXIgdGhl
IGZvbGxvd2luZyBmbGFzaGVzIGRvbid0IHN1cHBvcnQNCj4+Pj4gdGhlIEJQIHNjaGVtZToNCj4+
Pj4gwqAtIEFUMjZGMDA0DQo+Pj4+IMKgLSBBVDI1U0wzMjENCj4+Pj4gwqAtIEFUNDVEQjA4MUQN
Cj4+Pj4NCj4+Pj4gUGxlYXNlIG5vdGUsIHRoYXQgc29tZSBmbGFzaGVzIHdoaWNoIGFyZSBtYXJr
ZWQgYXMgU1BJX05PUl9IQVNfTE9DSw0KPj4+PiBqdXN0DQo+Pj4+IHN1cHBvcnQgR2xvYmFsIFBy
b3RlY3Rpb24sIGkuZS4gbm90IG91ciBzdXBwb3J0ZWQgYmxvY2sgcHJvdGVjdGlvbg0KPj4+PiBs
b2NraW5nIHNjaGVtZS4gVGhpcyBpcyB0byBrZWVwIGJhY2t3YXJkcyBjb21wYXRpYmlsaXR5IHdp
dGggdGhlDQo+Pj4+IGN1cnJlbnQgInVubG9jayBhbGwgYXQgYm9vdCIgbWVjaGFuaXNtLiBJbiBw
YXJ0aWN1bGFyIHRoZSBmb2xsb3dpbmcNCj4+Pj4gZmxhc2hlcyBkb2Vzbid0IGhhdmUgQlAgYml0
czoNCj4+Pj4gwqAtIEFUMjVERjA0MUENCj4+Pj4gwqAtIEFUMjVERjMyMQ0KPj4+PiDCoC0gQVQy
NURGMzIxQQ0KPj4+PiDCoC0gQVQyNURGNjQxDQo+Pj4+IMKgLSBBVDI2REYwODFBDQo+Pj4+IMKg
LSBBVDI2REYxNjFBDQo+Pj4+IMKgLSBBVDI2REYzMjENCj4+Pj4NCj4+Pj4gU2lnbmVkLW9mZi1i
eTogTWljaGFlbCBXYWxsZSA8bWljaGFlbEB3YWxsZS5jYz4NCj4+Pg0KPj4+IFJldmlld2VkLWJ5
OiBUdWRvciBBbWJhcnVzIDx0dWRvci5hbWJhcnVzQG1pY3JvY2hpcC5jb20+DQo+Pj4NCj4+Pj4g
LS0tDQo+Pj4+IGNoYW5nZXMgc2luY2UgdjQ6DQo+Pj4+IMKgLSBub25lDQo+Pj4+DQo+Pj4+IGNo
YW5nZXMgc2luY2UgdjMvdjIvdjE6DQo+Pj4+IMKgLSB0aGVyZSB3YXMgbm8gc3VjaCB2ZXJzaW9u
IGJlY2F1c2UgdGhpcyBwYXRjaCB3YXMgYnVuZGxlZCB3aXRoDQo+Pj4+IGFub3RoZXINCj4+Pj4g
wqDCoCBwYXRjaA0KPj4+Pg0KPj4+PiBjaGFuZ2VzIHNpbmNlIFJGQzoNCj4+Pj4gwqAtIG1lbnRp
b24gdGhlIGZsYXNoZXMgd2hpY2gganVzdCBzdXBwb3J0IHRoZSAiR2xvYmFsIFVucHJvdGVjdCIg
aW4NCj4+Pj4gdGhlDQo+Pj4+IMKgwqAgY29tbWl0IG1lc3NhZ2UNCj4+Pj4NCj4+Pj4gwqBkcml2
ZXJzL210ZC9zcGktbm9yL2F0bWVsLmMgfCAyOCArKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0t
DQo+Pj4+IMKgMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgMTkgZGVsZXRpb25zKC0p
DQo+Pj4+DQo+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL210ZC9zcGktbm9yL2F0bWVsLmMgYi9k
cml2ZXJzL210ZC9zcGktbm9yL2F0bWVsLmMNCj4+Pj4gaW5kZXggM2Y1ZjIxYTQ3M2E2Li40OWQz
OTJjNmM4YmMgMTAwNjQ0DQo+Pj4+IC0tLSBhL2RyaXZlcnMvbXRkL3NwaS1ub3IvYXRtZWwuYw0K
Pj4+PiArKysgYi9kcml2ZXJzL210ZC9zcGktbm9yL2F0bWVsLmMNCj4+Pj4gQEAgLTEwLDM3ICsx
MCwyNyBAQA0KPj4+Pg0KPj4+PiDCoHN0YXRpYyBjb25zdCBzdHJ1Y3QgZmxhc2hfaW5mbyBhdG1l
bF9wYXJ0c1tdID0gew0KPj4+PiDCoMKgwqDCoMKgwqDCoCAvKiBBdG1lbCAtLSBzb21lIGFyZSAo
Y29uZnVzaW5nbHkpIG1hcmtldGVkIGFzICJEYXRhRmxhc2giICovDQo+Pj4+IC3CoMKgwqDCoMKg
wqAgeyAiYXQyNWZzMDEwIizCoCBJTkZPKDB4MWY2NjAxLCAwLCAzMiAqIDEwMjQswqDCoCA0LCBT
RUNUXzRLKSB9LA0KPj4+PiAtwqDCoMKgwqDCoMKgIHsgImF0MjVmczA0MCIswqAgSU5GTygweDFm
NjYwNCwgMCwgNjQgKiAxMDI0LMKgwqAgOCwgU0VDVF80SykgfSwNCj4+Pj4gK8KgwqDCoMKgwqDC
oCB7ICJhdDI1ZnMwMTAiLMKgIElORk8oMHgxZjY2MDEsIDAsIDMyICogMTAyNCzCoMKgIDQsIFNF
Q1RfNEsgfA0KPj4+PiBTUElfTk9SX0hBU19MT0NLKSB9LA0KPj4+DQo+Pj4gaHR0cHM6Ly9kYXRh
c2hlZXRzcGRmLmNvbS9wZGYtZmlsZS81ODcxNjQvQVRNRUxDb3Jwb3JhdGlvbi9BVDI1RlMwMTAv
MQ0KPj4+IEJQIGJpdHMgYXJlIGF0IGJpdCAyLCAzLCA1IGFuZCA2Lg0KPj4+IEJQMCwgQlAxLCBC
UDMsIEJQNCBhbmQgV1BFTiwgYXJlIG5vbnZvbGF0aWxlIGNlbGxzDQo+Pj4NCj4+Pj4gK8KgwqDC
oMKgwqDCoCB7ICJhdDI1ZnMwNDAiLMKgIElORk8oMHgxZjY2MDQsIDAsIDY0ICogMTAyNCzCoMKg
IDgsIFNFQ1RfNEsgfA0KPj4+PiBTUElfTk9SX0hBU19MT0NLKSB9LA0KPj4+DQo+Pj4gaHR0cHM6
Ly9kYXRhc2hlZXRzcGRmLmNvbS9wZGYtZmlsZS81ODcxNjUvQVRNRUxDb3Jwb3JhdGlvbi9BVDI1
RlMwNDAvMQ0KPj4+IEJQIGJpdHMgYXJlIGF0IGJpdCAyLCAzLCA0LCA1LCBhbmQgNi4NCj4+PiBC
UDAsIEJQMSwgQlAyLCBCUDMsIEJQNCBhcmUgbm9udm9sYXRpbGUgY2VsbHMNCj4+Pg0KPj4+Pg0K
Pj4+PiAtwqDCoMKgwqDCoMKgIHsgImF0MjVkZjA0MWEiLCBJTkZPKDB4MWY0NDAxLCAwLCA2NCAq
IDEwMjQswqDCoCA4LCBTRUNUXzRLKSB9LA0KPj4+PiAtwqDCoMKgwqDCoMKgIHsgImF0MjVkZjMy
MSIswqAgSU5GTygweDFmNDcwMCwgMCwgNjQgKiAxMDI0LMKgIDY0LCBTRUNUXzRLKSB9LA0KPj4+
PiAtwqDCoMKgwqDCoMKgIHsgImF0MjVkZjMyMWEiLCBJTkZPKDB4MWY0NzAxLCAwLCA2NCAqIDEw
MjQswqAgNjQsIFNFQ1RfNEspIH0sDQo+Pj4+IC3CoMKgwqDCoMKgwqAgeyAiYXQyNWRmNjQxIizC
oCBJTkZPKDB4MWY0ODAwLCAwLCA2NCAqIDEwMjQsIDEyOCwgU0VDVF80SykgfSwNCj4+Pj4gK8Kg
wqDCoMKgwqDCoCB7ICJhdDI1ZGYwNDFhIiwgSU5GTygweDFmNDQwMSwgMCwgNjQgKiAxMDI0LMKg
wqAgOCwgU0VDVF80SyB8DQo+Pj4+IFNQSV9OT1JfSEFTX0xPQ0spIH0sDQo+Pj4NCj4+PiBodHRw
czovL2RhdGFzaGVldHNwZGYuY29tL3BkZi1maWxlLzk3NTMzMS9BZGVzdG8vQVQyNURGMDQxQS8x
DQo+Pj4gR2xvYmFsIFByb3RlY3QvVW5wcm90ZWN0IHVzaW5nIFdyaXRlIFNSIGNvbW1hbmQ6DQo+
Pj4gR2xvYmFsIFVubG9jazogd3JpdGUgMHgwMCB0byBTUg0KPj4+IEdsb2JhbCBMb2NrOiBSZWFk
IFNSLiBJZiBTUi5TUFJMIGlzIDEgd3JpdGUgMHhmZiB0byBTUiwgZWxzZSB3cml0ZQ0KPj4+IDB4
N2YuDQo+Pg0KPj4gVGhhdCBpcyBub3QgbXkgdW5kZXJzdGFuZGluZy4gUXVvdGU6DQo+PiDCoCBU
byBwZXJmb3JtIGEgR2xvYmFsIFByb3RlY3QsIHRoZSBhcHByb3ByaWF0ZSBXUCBwaW4gYW5kIFNQ
UkwNCj4+IMKgIGNvbmRpdGlvbnMgbXVzdCBiZSBtZXQsIGFuZCB0aGUgc3lzdGVtIG11c3Qgd3Jp
dGUgYSBsb2dpY2FsIOKAnDHigJ0NCj4+IMKgIHRvIGJpdHMgNSwgNCwgMywgYW5kIDIgb2YgdGhl
IFN0YXR1cyBSZWdpc3Rlci4NCj4+DQo+PiBBbmQNCj4+IMKgIENvbnZlcnNlbHksIHRvIHBlci1m
b3JtIGEgR2xvYmFsIFVucHJvdGVjdCwgdGhlIHNhbWUgV1AgYW5kIFNQUkwNCj4+IMKgIGNvbmRp
dGlvbnMgbXVzdCBiZSBtZXQgYnV0IHRoZSBzeXN0ZW0gbXVzdCB3cml0ZSBhIGxvZ2ljYWwg4oCc
MOKAnSB0bw0KPj4gwqAgYml0cyA1LCA0LCAzLCBhbmQgMiBvZiB0aGUgU3RhdHVzIFJlZ2lzdGVy
DQo+Pg0KPiANCj4gUmlnaHQuIEkgdGhpbmsgd2UgYXJlIGJvdGggY29ycmVjdCwgYW5kIHdlIHNo
b3VsZCBjaG9vc2Ugb25lIG1ldGhvZA0KPiBvciB0aGUgb3RoZXIgZGVwZW5kaW5nIG9uIHRoZSBs
ZXZlbCBvZiBzdXBwb3J0IHdlIHdhbnQgdG8gaW50cm9kdWNlLg0KPiBJZiB3ZSB3YW50ICJsb2Nr
aW5nIG9wcyIsIGkuZS4gcGFydGlhbCBvciBmdWxsIGxvY2sgYW5kIHVubG9jayBvZiB0aGUNCj4g
Zmxhc2gsIHdlJ2xsIGdvIHlvdXIgd2F5LiBJZiB3ZSB3YW50IHRvIGtlZXAgdGhpbmdzIGFzIHRo
ZXkgd2VyZSBiZWZvcmUNCj4gM2UwOTMwZjEwOWU3Niwgd2UnbGwganVzdCBzdXBwb3J0IHRoZSBn
bG9iYWwgdW5sb2NrIGJ5IHdyaXRpbmcgMHgwMCB0byBTUi4NCg0KSSdtIHdyb25nLCBwbGVhc2Ug
aWdub3JlLiBJIG1peGVkIEJQIGxvY2tpbmcgd2l0aCBpbmRpdmlkdWFsIHNlY3RvciBwcm90ZWN0
aW9uLg0KTGV0IG1lIHJlYWQgYWdhaW4uDQo=

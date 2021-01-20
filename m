Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF162FD27A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 15:21:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbhATOQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 09:16:46 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:38069 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733278AbhATNDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 08:03:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1611147788; x=1642683788;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Ko7QCuwmq9bNdGreJfT++lxR6TP9DRj7cL/m9AN3qQ4=;
  b=xaZk6tmKDJrzVCEZkMISU63Jjkd1PUmYVJqhvAqGTNUbIR7xO3xY1D5M
   QS4ZFbKL+30KoPTdJROHHWj7QGchOVLdLbt4nTYvb5OMK9OYICnG83cm0
   tgy6fyVr6t1rN4aSN09COXkwgMfinXfsmHVnNohFHPUHJm3fGfdNnMsBA
   J4P9dHK6fwARsf6ABrH2vbU7n8y5e/n+EB/XS5bjw4ip66x2ak+YZZGYz
   JU17fvl70Ys3W/bYGryRWS5knBSmUMrxV50WlEgEser8up6UhgLTnMExQ
   zg1wsBssKnRy11Cxje0YWzc/lJ7D0yURd8AtJPTTEW8GYblol21/055gU
   g==;
IronPort-SDR: GfRStNoqip+WWDGv0tepRfhfp/5z7s0dYFWX/064Mp0S+SIAjfm8rTrfrBZUK0rPucqNNFciMh
 8tqsRk80KWkTROzMyJM0WUgT/pOmkWePo45/VvWDntyJZv+7QmxETTM9vZJBrv8gNOwpRqSbZR
 AhS1Qpkakuu+XbZvle785BpetOoDjboZtTxcDdEIsJ7MmkRNzyIN7JSUypHvlDeS549AWQ0eZW
 32FO5paPVKKwni+NTJvO6CTmQArz63lAaPu/TtGDVRjCiQSM+WjF8Eek1dkmHpwQ2u+Ylf6P2y
 9Mk=
X-IronPort-AV: E=Sophos;i="5.79,361,1602572400"; 
   d="scan'208";a="41084717"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Jan 2021 06:01:15 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 20 Jan 2021 06:01:15 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Wed, 20 Jan 2021 06:01:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xbv+tAo/gXXl5kecF5NTAzu741BatR6d7fc3eKo4Ear+zjXjwvt4IKXB+mQRccxr//9aZzWNwlyCZNuDY6DsHOziUW1yj9gNeAZpVDFqOX9/fCaCj/EP1YBLa5vHu5xiwh2e7Xw8Ql65Ylyvb8vWAe7yAqa/CArYawhigIpYU4irQP+YbHlGX7EdyE+murlNjlK433tD0RAL6Kt7vICmoLTbX+kOGiIkkvfds2tgsZ8P2LHVrerHaKUvFu+6erfCi+Sbu0VU3DfSCDbJE+HkYhOkw7zTtBwQHnlxnQUoX8owAxaFJW+NiUoQG305pazqCvJgebgMBDdDtHDFD4ZArQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ko7QCuwmq9bNdGreJfT++lxR6TP9DRj7cL/m9AN3qQ4=;
 b=WpSpfBDj2vupp6YoGj4PMW2rrYLifTWR5FhtxCl2M3a1pHXah2Hbj3y3zwpPG/tfl+knriwYSrxaS0nWPMEs+LiZbcagCdULsL2M5rSlcEk2j7S+s1GbVljDDLO8Il9J8GI1kaMXfr/AfZj020Ya6nYdqFkboCaGZjibISUiPp8MlX0WimpJyFhIDMZd4WC++GTwlyDhDqCwDfO9xNuxmHltxm+PLsQwN4XGCOjvheb2cULVByxeDcoisM3O9AKQUC9oMlCYxY4ba/QTfuIGm6lRTeEk9zO8ucnIlyv/MIjTIcha9wQjYJV7g0HyMyTg6eiQAoAejN8IBGFyWB61Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ko7QCuwmq9bNdGreJfT++lxR6TP9DRj7cL/m9AN3qQ4=;
 b=RxKXYxDMPZ3xXQ4wTMwaJwluD4h+UqBJPkRZ6+CoyabwgQNqO5LDom2S++v6gFCWnT2IO+PB8EenxbPc+wizvaxvsDg48PISsmoZRAfZXSe7cDlb5yFlhc+mQRYHTQVPBqpCOF8K5rUQCpI3Ix0NYDAbHahT+HowAKxJ1UL34UA=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by SN6PR11MB3022.namprd11.prod.outlook.com (2603:10b6:805:d8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Wed, 20 Jan
 2021 13:01:13 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::f4e3:108c:4222:7dab]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::f4e3:108c:4222:7dab%3]) with mapi id 15.20.3784.011; Wed, 20 Jan 2021
 13:01:13 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <p.yadav@ti.com>
CC:     <michael@walle.cc>, <vigneshr@ti.com>, <richard@nod.at>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <Kavyasree.Kotagiri@microchip.com>, <miquel.raynal@bootlin.com>
Subject: Re: [PATCH 1/2] mtd: spi-nor: Add Global Block Unlock command
Thread-Topic: [PATCH 1/2] mtd: spi-nor: Add Global Block Unlock command
Thread-Index: AQHW7yxU3WhLNs6mLUyHYoFQKCUecQ==
Date:   Wed, 20 Jan 2021 13:01:13 +0000
Message-ID: <f7577368-9466-b9f8-6f18-5be6fb9c3859@microchip.com>
References: <20210120105411.254890-1-tudor.ambarus@microchip.com>
 <20210120122431.csvnwlb4ihqbuvoq@ti.com>
In-Reply-To: <20210120122431.csvnwlb4ihqbuvoq@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [5.13.1.111]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a6d72a93-ebb1-42a9-d9c0-08d8bd437735
x-ms-traffictypediagnostic: SN6PR11MB3022:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR11MB302261AF2BAF84D9753D8129F0A20@SN6PR11MB3022.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s1+mTMSVlfj9+g9jFBviBRPvxViUkO0R0Sj3J9VMGeq0AXADXqxvJWpKHSXCJGy3rBJ1vCD6lSAr0TW4VdGkP0BN0TZ00jO+r5fHghjMS2Ay3+S2+Vs0ElQtpv2gbKECdI3TR0iKFXSRxlnPh66QDw44RsvpWNARruaq6wXemQaclgqI4+D6A9CcizxGN3pGvnWWC/6yUf7o/R+WxxENx2Pbxz26DeDKKWB89Mgaw+vjRMpZKhJbz9HTiZgAJ9I5Qkdu4t0DS8VEyWZ46bkKwl/6xtv3RUlaZMGzYPcbviYMBDxCoh7iWhftg81H3ORLnJjKlpnxsoCKQXvpWAgsRtoIOzJJ1pPW0PVrrYNd9+PoeoWEw7cN1jKhq7CAAD3G9WePaS1286uodYgOYbWB0BfNIp3EPeoH8gFGI5Ll0tmnrIgnrTAqibAkZ8gUwcPC7vrUlM7YMvf1ofK66jA62YNe01ErfrLMAs8ETPz034g=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(346002)(366004)(376002)(136003)(396003)(26005)(2906002)(71200400001)(91956017)(86362001)(8936002)(53546011)(76116006)(316002)(66556008)(66946007)(64756008)(66476007)(54906003)(6506007)(36756003)(6512007)(31696002)(186003)(31686004)(6486002)(83380400001)(66446008)(8676002)(5660300002)(4326008)(478600001)(2616005)(6916009)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?cFhKN3hGZ1ZNdGUyZjRpUW9GNXZqcjFYUU5BU1A0Zy82YjhocWxHNFM0VGpm?=
 =?utf-8?B?REgwY0pmaFBVdmhuVnpYay90R01IbTh2MFdTNS8vOHpIaHM3Nmp5aDlCV1Nx?=
 =?utf-8?B?czR1bFpRRnJnYlI5Q0YrNHZld2ZrRU9QM0taemJFMldWSWNMMkdPb2wrRmN1?=
 =?utf-8?B?YTYvaUN1NGxNYmZISFRZamg4RGlYYlpnUXlGbTd2bkhjZWRraWU2UlBvOEFp?=
 =?utf-8?B?Tm5RaTh4YXJqSkdJdm0ycWNnajFkVVZLQmVUNWtLZUsrNFM5L2l2T2xSV09X?=
 =?utf-8?B?S1JqUlFvY3lZK3Z2RFprWlo5b0R4UHV2M2xMd0pXL2VxOUx0N0hLVDd4Yk9D?=
 =?utf-8?B?V0JHUFNvS3loM28zRm1rV25pK0FzZCtKMHV5QnlWMnVnVFZsTVo2L0VKNFJZ?=
 =?utf-8?B?NmpaZk8xamZKMGhjaTB6bHI0WUI2d0NBeU1jSjkrb2VmdWdQUllxcVpIRVN5?=
 =?utf-8?B?M1RLdVYzWjU2R1BJaVczY0pPT0pFeEZsMnFMc05MNDBuY3dIbnpyamFaZklN?=
 =?utf-8?B?VWRCRjIvZ2ZCYVpzeTBMaDZvVmpRdGVFSk1BNDl4ck54Nk9QMzFpbzQzWEM5?=
 =?utf-8?B?WjZlWlJGVU9WRCtMUGR0SHRuQXo1bVpkSlVCdk93K3F5TVZDTG1lL1hmMG9v?=
 =?utf-8?B?UXc5QkFLd2ZPRWFUeCtIMG1FcXh3c01tWjkxSjkxTGthNzNSQnVsMVB4aXR1?=
 =?utf-8?B?RG1TVStSMk00UFBWYjQ5VDZ1UjBpYkRSaE5NTlJvUkJ2V0toNTFTWWNvN3pp?=
 =?utf-8?B?TGhscnJRYUQvWUxURjVzSnBWM0VMRjV3NHZnWXp1UjVNYjVaby9Za1VkVE9i?=
 =?utf-8?B?Vm5VdWlYYXc2RFlyMy9VVTBGbzdRR2dMU0taRXhkQ2JxeDFDVlhleDM0OG5l?=
 =?utf-8?B?clZjS2EwYjJ5MTgzczdtcGFicUl6MEhpdjJtU1c4d2RKTnZqK2M0SWNXWk0y?=
 =?utf-8?B?WG5NQ0NoNVQvWHpHcTU0RnhZSXBCQ25XdUR1ZS9seDR1NmxZWU1BMm9aVHpa?=
 =?utf-8?B?WTIwWVNuQ251cFpIc3o5b1pNMFBLVWkrdWE3S0cvbloyem5LOTVxMFlxR1VO?=
 =?utf-8?B?VlY3eTAyd2phVzFOdHZmakVUdGJzY20xQXRpUDFJSFQvdVoxYkxnMmE0aE5M?=
 =?utf-8?B?OEZzaE9udUp0Zm5HTEd4L3FrSlNWY1pDMGQySm5Fa2JHY1BnUnY1YXpYNGZI?=
 =?utf-8?B?eVBtd2pyWFNid2orMXhtYnVJNmhuSTFwOElhNXZPZDZLdDJ6QUxseXhBQU9y?=
 =?utf-8?B?b3VLU1lZV3lleFlzQW5ieU5XclJUN3dRVS96Mm5KeGhVM0dST1BvTmd0dER3?=
 =?utf-8?B?cnhEenhURU0vOXp0cjdGcVVMY0JwS3ZQZkhUTENrcFZhTkM4eStSN25sVVlm?=
 =?utf-8?Q?AJQTSoVf8vX+sqwTmOROiTL+s3OYQURA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FEAEC17F428E534CB88DE8DA30154724@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6d72a93-ebb1-42a9-d9c0-08d8bd437735
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2021 13:01:13.2684
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LXJ12syHxiFXWH6IvzivUOKW1d9uDqyeQriNs2YyVmu2gf3I8x2zl6eBBrDx85xf0lL5Wlo16FmWUX1P1cR8brkJ11lVtbBHS2ZCL2nnUqA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3022
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMS8yMC8yMSAyOjI5IFBNLCBQcmF0eXVzaCBZYWRhdiB3cm90ZToNCj4gRVhURVJOQUwgRU1B
SUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25v
dyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBIaSBUdWRvciwNCg0KSGksIFByYXR5dXNoLA0K
DQpUaGFua3MgZm9yIHJldmlld2luZyB0aGlzLg0KDQo+IA0KPiBPbiAyMC8wMS8yMSAxMjo1NFBN
LCBUdWRvciBBbWJhcnVzIHdyb3RlOg0KPj4gVGhlIEdsb2JhbCBCbG9jayBVbmxvY2sgY29tbWFu
ZCBoYXMgZGlmZmVyZW50IG5hbWVzIGRlcGVuZGluZw0KPj4gb24gdGhlIG1hbnVmYWN0dXJlciwg
YnV0IGFsd2F5cyB0aGUgc2FtZSBjb21tYW5kIHZhbHVlOiAweDk4Lg0KPj4gTWFjcm9uaXgncyBN
WDI1VTEyODM1RiBuYW1lcyBpdCBHYW5nIEJsb2NrIFVubG9jaywgV2luYm91bmQncw0KPj4gVzI1
UTEyOEZWIG5hbWVzIGl0IEdsb2JhbCBCbG9jayBVbmxvY2sgYW5kIE1pY3JvY2hpcCdzDQo+PiBT
U1QyNlZGMDY0QiBuYW1lcyBpdCBHbG9iYWwgQmxvY2sgUHJvdGVjdGlvbiBVbmxvY2suDQo+Pg0K
Pj4gVXNlZCBpbiB0aGUgSW5kaXZpZHVhbCBCbG9jayBQcm90ZWN0aW9uIG1vZGUsIHdoaWNoIGlz
IG11dHVhbA0KPiANCj4gTml0cGljazogcy9tdXR1YWwvbXV0dWFsbHkvDQo+IA0KPj4gZXhjbHVz
aXZlIHdpdGggdGhlIEJsb2NrIFByb3RlY3Rpb24gbW9kZSAoQlAwLTMpLg0KPj4NCj4+IFNpZ25l
ZC1vZmYtYnk6IFR1ZG9yIEFtYmFydXMgPHR1ZG9yLmFtYmFydXNAbWljcm9jaGlwLmNvbT4NCj4+
IC0tLQ0KPj4gIGRyaXZlcnMvbXRkL3NwaS1ub3IvY29yZS5jICB8IDM1ICsrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrDQo+PiAgZHJpdmVycy9tdGQvc3BpLW5vci9jb3JlLmggIHwg
IDEgKw0KPj4gIGluY2x1ZGUvbGludXgvbXRkL3NwaS1ub3IuaCB8ICAxICsNCj4+ICAzIGZpbGVz
IGNoYW5nZWQsIDM3IGluc2VydGlvbnMoKykNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9t
dGQvc3BpLW5vci9jb3JlLmMgYi9kcml2ZXJzL210ZC9zcGktbm9yL2NvcmUuYw0KPj4gaW5kZXgg
MjBkZjQ0Yjc1M2RhLi5jYjI3NTYwOGNiN2YgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL210ZC9z
cGktbm9yL2NvcmUuYw0KPj4gKysrIGIvZHJpdmVycy9tdGQvc3BpLW5vci9jb3JlLmMNCj4+IEBA
IC04NTMsNiArODUzLDQxIEBAIGludCBzcGlfbm9yX3dhaXRfdGlsbF9yZWFkeShzdHJ1Y3Qgc3Bp
X25vciAqbm9yKQ0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBERUZBVUxUX1JFQURZX1dBSVRfSklGRklFUyk7DQo+PiAgfQ0KPj4NCj4+ICsvKioN
Cj4+ICsgKiBzcGlfbm9yX2dsb2JhbF9ibG9ja191bmxvY2soKSAtIFVubG9jayBHbG9iYWwgQmxv
Y2sgUHJvdGVjdGlvbi4NCj4+ICsgKiBAbm9yOiAgICAgcG9pbnRlciB0byAnc3RydWN0IHNwaV9u
b3InLg0KPj4gKyAqDQo+PiArICogUmV0dXJuOiAwIG9uIHN1Y2Nlc3MsIC1lcnJubyBvdGhlcndp
c2UuDQo+PiArICovDQo+PiAraW50IHNwaV9ub3JfZ2xvYmFsX2Jsb2NrX3VubG9jayhzdHJ1Y3Qg
c3BpX25vciAqbm9yKQ0KPj4gK3sNCj4+ICsgICAgIGludCByZXQ7DQo+PiArDQo+PiArICAgICBy
ZXQgPSBzcGlfbm9yX3dyaXRlX2VuYWJsZShub3IpOw0KPj4gKyAgICAgaWYgKHJldCkNCj4+ICsg
ICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4+ICsNCj4+ICsgICAgIGlmIChub3ItPnNwaW1lbSkg
ew0KPj4gKyAgICAgICAgICAgICBzdHJ1Y3Qgc3BpX21lbV9vcCBvcCA9DQo+PiArICAgICAgICAg
ICAgICAgICAgICAgU1BJX01FTV9PUChTUElfTUVNX09QX0NNRChTUElOT1JfT1BfR0JVTEssIDEp
LA0KPiANCj4gU2V0IHRoZSBidXN3aWR0aCB0byAwLi4uDQo+IA0KPj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgU1BJX01FTV9PUF9OT19BRERSLA0KPj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgU1BJX01FTV9PUF9OT19EVU1NWSwNCj4+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIFNQSV9NRU1fT1BfTk9fREFUQSk7DQo+IA0KPiAuLi4gYW5kIHJ1
biB0aGUgb3AgdGhyb3VnaCBzcGlfbm9yX3NwaW1lbV9zZXR1cF9vcCgpLg0KDQpSaWdodCwgSSB0
aG91Z2h0IHRoYXQgU1BJTk9SX09QX0dCVUxLIGlzIGF2YWlsYWJsZSBqdXN0IGluIHNpbmdsZSBT
UEkNCm1vZGUsIGJ1dCBJIHNlZSBpdCBjYW4gYmUgaXNzdWVkIGluIFFQSSBtb2RlIGFzIHdlbGwu
IFdpbGwgY2hhbmdlLg0KDQpDaGVlcnMsDQp0YQ0KPiANCj4gV2l0aCB0aGlzIGZpeGVkLA0KPiAN
Cj4gUmV2aWV3ZWQtYnk6IFByYXR5dXNoIFlhZGF2IDxwLnlhZGF2QHRpLmNvbT4NCj4gDQo+PiAr
DQo+PiArICAgICAgICAgICAgIHJldCA9IHNwaV9tZW1fZXhlY19vcChub3ItPnNwaW1lbSwgJm9w
KTsNCj4+ICsgICAgIH0gZWxzZSB7DQo+PiArICAgICAgICAgICAgIHJldCA9IHNwaV9ub3JfY29u
dHJvbGxlcl9vcHNfd3JpdGVfcmVnKG5vciwgU1BJTk9SX09QX0dCVUxLLA0KPj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBOVUxMLCAwKTsNCj4+
ICsgICAgIH0NCj4+ICsNCj4+ICsgICAgIGlmIChyZXQpIHsNCj4+ICsgICAgICAgICAgICAgZGV2
X2RiZyhub3ItPmRldiwgImVycm9yICVkIG9uIEdsb2JhbCBCbG9jayBVbmxvY2tcbiIsIHJldCk7
DQo+PiArICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+PiArICAgICB9DQo+PiArDQo+PiArICAg
ICByZXR1cm4gc3BpX25vcl93YWl0X3RpbGxfcmVhZHkobm9yKTsNCj4+ICt9DQo+PiArDQo+PiAg
LyoqDQo+PiAgICogc3BpX25vcl93cml0ZV9zcigpIC0gV3JpdGUgdGhlIFN0YXR1cyBSZWdpc3Rl
ci4NCj4+ICAgKiBAbm9yOiAgICAgcG9pbnRlciB0byAnc3RydWN0IHNwaV9ub3InLg0KPj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvbXRkL3NwaS1ub3IvY29yZS5oIGIvZHJpdmVycy9tdGQvc3BpLW5v
ci9jb3JlLmgNCj4+IGluZGV4IGQ2MzFlZTI5OWRlMy4uZWIyNjc5NmRiMDI2IDEwMDY0NA0KPj4g
LS0tIGEvZHJpdmVycy9tdGQvc3BpLW5vci9jb3JlLmgNCj4+ICsrKyBiL2RyaXZlcnMvbXRkL3Nw
aS1ub3IvY29yZS5oDQo+PiBAQCAtNDM0LDYgKzQzNCw3IEBAIGludCBzcGlfbm9yX3dyaXRlX2Rp
c2FibGUoc3RydWN0IHNwaV9ub3IgKm5vcik7DQo+PiAgaW50IHNwaV9ub3Jfc2V0XzRieXRlX2Fk
ZHJfbW9kZShzdHJ1Y3Qgc3BpX25vciAqbm9yLCBib29sIGVuYWJsZSk7DQo+PiAgaW50IHNwaV9u
b3Jfd3JpdGVfZWFyKHN0cnVjdCBzcGlfbm9yICpub3IsIHU4IGVhcik7DQo+PiAgaW50IHNwaV9u
b3Jfd2FpdF90aWxsX3JlYWR5KHN0cnVjdCBzcGlfbm9yICpub3IpOw0KPj4gK2ludCBzcGlfbm9y
X2dsb2JhbF9ibG9ja191bmxvY2soc3RydWN0IHNwaV9ub3IgKm5vcik7DQo+PiAgaW50IHNwaV9u
b3JfbG9ja19hbmRfcHJlcChzdHJ1Y3Qgc3BpX25vciAqbm9yKTsNCj4+ICB2b2lkIHNwaV9ub3Jf
dW5sb2NrX2FuZF91bnByZXAoc3RydWN0IHNwaV9ub3IgKm5vcik7DQo+PiAgaW50IHNwaV9ub3Jf
c3IxX2JpdDZfcXVhZF9lbmFibGUoc3RydWN0IHNwaV9ub3IgKm5vcik7DQo+PiBkaWZmIC0tZ2l0
IGEvaW5jbHVkZS9saW51eC9tdGQvc3BpLW5vci5oIGIvaW5jbHVkZS9saW51eC9tdGQvc3BpLW5v
ci5oDQo+PiBpbmRleCBkMTM5NThkZTZkOGEuLmEwZDU3Mjg1NTQ0NCAxMDA2NDQNCj4+IC0tLSBh
L2luY2x1ZGUvbGludXgvbXRkL3NwaS1ub3IuaA0KPj4gKysrIGIvaW5jbHVkZS9saW51eC9tdGQv
c3BpLW5vci5oDQo+PiBAQCAtNTMsNiArNTMsNyBAQA0KPj4gICNkZWZpbmUgU1BJTk9SX09QX1dS
RUFSICAgICAgICAgICAgICAweGM1ICAgIC8qIFdyaXRlIEV4dGVuZGVkIEFkZHJlc3MgUmVnaXN0
ZXIgKi8NCj4+ICAjZGVmaW5lIFNQSU5PUl9PUF9TUlNURU4gICAgIDB4NjYgICAgLyogU29mdHdh
cmUgUmVzZXQgRW5hYmxlICovDQo+PiAgI2RlZmluZSBTUElOT1JfT1BfU1JTVCAgICAgICAgICAg
ICAgIDB4OTkgICAgLyogU29mdHdhcmUgUmVzZXQgKi8NCj4+ICsjZGVmaW5lIFNQSU5PUl9PUF9H
QlVMSyAgICAgICAgICAgICAgMHg5OCAgICAvKiBHbG9iYWwgQmxvY2sgVW5sb2NrICovDQo+Pg0K
Pj4gIC8qIDQtYnl0ZSBhZGRyZXNzIG9wY29kZXMgLSB1c2VkIG9uIFNwYW5zaW9uIGFuZCBzb21l
IE1hY3Jvbml4IGZsYXNoZXMuICovDQo+PiAgI2RlZmluZSBTUElOT1JfT1BfUkVBRF80QiAgICAw
eDEzICAgIC8qIFJlYWQgZGF0YSBieXRlcyAobG93IGZyZXF1ZW5jeSkgKi8NCj4gDQo+IC0tDQo+
IFJlZ2FyZHMsDQo+IFByYXR5dXNoIFlhZGF2DQo+IFRleGFzIEluc3RydW1lbnRzIEluZGlhDQo+
IA0KDQo=

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF5052C42AF
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 16:12:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730057AbgKYPKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 10:10:10 -0500
Received: from mail-dm6nam10on2048.outbound.protection.outlook.com ([40.107.93.48]:37281
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726295AbgKYPKI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 10:10:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gr+7N/fxS/yvcxTrkKic3kJDqPCmWzQAtqLvXg5nOcCVXf7YdrkAZnI64p9KNNWD0MMpqf2z95nq0d9cuxxgsIg9INMQxI+nRobnZffikbZGE7ji4xrGOEx/aVRIB1hjzafKGvKuVVC1p6EcWyf+nLiOceXp1/w24dZ9udv3C9haKPU2zaPEr34gGHuTi78zFXZKFb3YXpr2VFdqXg42+A8aCWIIamfNOr2/9BGJF8Au5KTdIO7hONzeKYUCcY6+dg5PVAvfvNQGG/wUhd/SgMJxFQkvypZk55j42sugr1cpkxjZZoAel5Wkl2s1j7Dquj8ZxmRUyjYP+eFwxQ7fiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9WFVwIFFBmyMIWVF4pGMcbvGYm3/LoCSaElpvwte1/E=;
 b=avkKD2ViFl3L4am44P7sanQFV7D7LTonjkD6jsmhYdkog9P9mbVde9CYOf0EP6aCZqiB0XG1w2RDNuVU+rQ+6+FTiAit1HG2zYRnZYOud8DekQZweFLimStl+0YM+6568ysKHxd3zuDZA4An1kcxRhBL5DFLCM9gh8c8jqYLEm8gjMJE9VyJIDWhb7CktD6ZTE9lCNeQBmPUYoQbEGeKThDnPu1fbnhUMBRxilVX6+AeRGoSSBwQR1mKxuIs7cqz22E/TBzVcQfLEsscY7nDKz+oS4kwuMcgS6Ot8Sj93mGOl4ot7ZG7xqcIGK/4ZJI9t8rBHphbJbqATxYFWnT8xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9WFVwIFFBmyMIWVF4pGMcbvGYm3/LoCSaElpvwte1/E=;
 b=BVazK6IwnigNme/Akk6zBUL6ERFJGu1R4jPxDFeQd8kvm6MkFLjHjoMHTNiQzAuCvhiNIhjt4GUsgfEyLMbOnaHliJ2uH70kR5DgkCDFZAGzMkXM7jQpALqhHWH6phnrPWz5jTJGgy+rIfH6+7DGpb9nLWrHpfqpXU5Vhz1h7C8=
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR1201MB0118.namprd12.prod.outlook.com (2603:10b6:910:20::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.30; Wed, 25 Nov
 2020 15:10:03 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::ad96:acee:5c1c:d92c]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::ad96:acee:5c1c:d92c%4]) with mapi id 15.20.3589.030; Wed, 25 Nov 2020
 15:10:03 +0000
From:   "Chen, Guchun" <Guchun.Chen@amd.com>
To:     Colin King <colin.king@canonical.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Zhou1, Tao" <Tao.Zhou1@amd.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC:     "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH][next] drm/amdgpu: Fix sizeof() mismatch in bps_bo
 kmalloc_array creation
Thread-Topic: [PATCH][next] drm/amdgpu: Fix sizeof() mismatch in bps_bo
 kmalloc_array creation
Thread-Index: AQHWwzXNElH2swxXSkStHSh1azb5iqnY85KQ
Date:   Wed, 25 Nov 2020 15:10:03 +0000
Message-ID: <CY4PR12MB128722A6BE94EFC4739FB964F1FA0@CY4PR12MB1287.namprd12.prod.outlook.com>
References: <20201125141806.1881036-1-colin.king@canonical.com>
In-Reply-To: <20201125141806.1881036-1-colin.king@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-11-25T15:09:50Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=567aad7a-49ee-4de5-aae1-000055e066cf;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-11-25T15:09:59Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: a6aa367b-0fe9-4e69-a512-0000f6767ea3
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: canonical.com; dkim=none (message not signed)
 header.d=none;canonical.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.158.166.36]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 781b5a1a-f263-46fa-0390-08d891542f9d
x-ms-traffictypediagnostic: CY4PR1201MB0118:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR1201MB01184DE8054FAF00564AAF79F1FA0@CY4PR1201MB0118.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t+cYq76mipxytphBp7mRTx/SwGKfuxfW+H9rrkxXUSHPm3vgMr/njy6Nk/uKGps1Z6zpYZ/zd87rhbs0ib8vGnGSEqVi1BbkldYKBN5kEEHMd832WDZA9TA+sWq7CaCJycEppohnEBkEhM7xGYnbhnncdEYhuIgdz+wDDQohuPTtKjxG+qw4TkXy8mPkpYnSd/F1zE3OIN3QYSeewK5FlhT+FxEfUMGobJxxMO3lF65i7IRpW6fvF/pWLQNMspqzStjDEJIGkhvvUhCW9fmb6xUNhESq1HdgOWokPVmkPLacIBgtDYTUlvnkNv+ajeK7PTNdFnX6JqSgUHgP3/UDMIi8aEgnhH5FnexJ0RO/amo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR12MB1287.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(346002)(376002)(39860400002)(396003)(9686003)(4326008)(2906002)(64756008)(316002)(53546011)(8676002)(71200400001)(6506007)(8936002)(54906003)(5660300002)(186003)(110136005)(7696005)(52536014)(26005)(76116006)(66476007)(66446008)(478600001)(83380400001)(66946007)(33656002)(66556008)(55016002)(921005)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?QklQUDd1Mk9GQ0h1OTI1VERlS2JlZFNUNEtPVmJvTHQ1QXdTUlpzcFRLWC82?=
 =?utf-8?B?b3ZXQmhMejNOMENlUC8vNHJKUitxUWJVVXd6dXpjMWRzbTNCSWdRU0VDREc3?=
 =?utf-8?B?aVpsY3FxYmxhS00zYTFCUXhWbEVQZ3RVdi81TkFaTG9uNi9hRHlaMHh0d0Zs?=
 =?utf-8?B?cmM0S25hQzhzZEFEQnZVYXc1ZXZYRUNMRU1BRVVNaGVQVFRobU10Vm10QUJa?=
 =?utf-8?B?Nmw5dE9Pb1E1NEZKMG5Sd2ZiWXBDeHdieERtOVNkVStsOW01U1FqTE9FZDJI?=
 =?utf-8?B?bFp4RUZiSVlKbk5CNTEweXNTNDZpWW05bE9ESE9YU3NQMDJad0VISzJFWGQz?=
 =?utf-8?B?VENLMURSbm01ZGJKVjljd25KSEV5OTVPWS9LOEt0c05CK2Nrd1g3QitRTWtW?=
 =?utf-8?B?ZVVDQkhKZkpMKzRHeFp5UkRpbHl2RWIwK0NZakx5V3pLMEZqby8vWUdqTk5v?=
 =?utf-8?B?dEhVQW02Z0R3ZjREODZKWmlPc2JNeVlNYmNSd081Mjg4akVnblBvTk8vOUlo?=
 =?utf-8?B?ZnYvNWhKT0pPSUUwYW5FUzdrSkUzYngzMTU3dW03bU40aWFOOWRCNVN0UnZJ?=
 =?utf-8?B?UE5EMWNaY2d1Q2JqQ3ozYzNpdk5oemZWNWZNd2N0WXNGVHVwYjdodkZjNlFV?=
 =?utf-8?B?NXpoV1pDcENrbXUwRFkwK0Fteko1aVd4eDdvVHg2MlBCQ0RHcG1lSmQ1b2ZU?=
 =?utf-8?B?UFcxd1NSdjhZejlJOUNEbitqTjNPZ0diZ1h1ZUVCYTFQd0h0QWFnbjdPU3ZM?=
 =?utf-8?B?a1RVY0xMb0dVZEU3aWgzSUpCNjF5TnVhNzZRNm5LR1BWMmF0dktwWmFHbmJK?=
 =?utf-8?B?RVE3aFJxV3hubmJjSXhDdWZmYy9DamlUQS9SeEtkN29BRVh0R0lwVktFVXlP?=
 =?utf-8?B?OE9YUFdoY2xhMEdWdGF4dlVmL0JkVlQvaGlobEliYmU2VHhneGZKbGJ1b0ll?=
 =?utf-8?B?Z2FQTktMb0xIZmRobzFZT2wyaUM2MzdNRzhOdFNEM3NycXhTWkh1STBmOXJ2?=
 =?utf-8?B?Q0l2TkdzbDZYTTl2U2gweVRrSmR2ZldURFdvQmRVWlRlZk9rMVN0THFycjMx?=
 =?utf-8?B?b2J1ekpxRnhCeVdNYXlrZUo5WHAxTnpiYTZIL2ZNbjV5OWFiVEs1UFpWVFo5?=
 =?utf-8?B?TVVIckVGRzhjemR1MVorMkIvUlIybk1JRTRORkg3SWxvc0NyajVyK05GM0or?=
 =?utf-8?B?Qi9xcm9pZnVmd3dRQXkrMWNDOVpTS2hxcDNwVElPeWswQStDNW4wS1JpczRt?=
 =?utf-8?B?ampyYng4cExZUHBSSVQ2MytEdVFoaXg3aE94Y2VCRUsrZWwvak5hNVIwOGZN?=
 =?utf-8?Q?r2j73Ko21NzFY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 781b5a1a-f263-46fa-0390-08d891542f9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2020 15:10:03.3885
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p/HsmKmXmh8TpjT4D9wtUh53QYTONtI0wTuugTrxV2k0QYoJmtHnSUO+BWvOLEsD+iwEO+0uWqBuvaRvVmKDQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0118
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W0FNRCBQdWJsaWMgVXNlXQ0KDQpSZXZpZXdlZC1ieTogR3VjaHVuIENoZW4gPGd1Y2h1bi5jaGVu
QGFtZC5jb20+DQoNClJlZ2FyZHMsDQpHdWNodW4NCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCkZyb206IENvbGluIEtpbmcgPGNvbGluLmtpbmdAY2Fub25pY2FsLmNvbT4gDQpTZW50OiBX
ZWRuZXNkYXksIE5vdmVtYmVyIDI1LCAyMDIwIDEwOjE4IFBNDQpUbzogRGV1Y2hlciwgQWxleGFu
ZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgS29lbmlnLCBDaHJpc3RpYW4gPENocmlz
dGlhbi5Lb2VuaWdAYW1kLmNvbT47IERhdmlkIEFpcmxpZSA8YWlybGllZEBsaW51eC5pZT47IERh
bmllbCBWZXR0ZXIgPGRhbmllbEBmZndsbC5jaD47IFpob3UxLCBUYW8gPFRhby5aaG91MUBhbWQu
Y29tPjsgQ2hlbiwgR3VjaHVuIDxHdWNodW4uQ2hlbkBhbWQuY29tPjsgYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmc7IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCkNjOiBrZXJu
ZWwtamFuaXRvcnNAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3Jn
DQpTdWJqZWN0OiBbUEFUQ0hdW25leHRdIGRybS9hbWRncHU6IEZpeCBzaXplb2YoKSBtaXNtYXRj
aCBpbiBicHNfYm8ga21hbGxvY19hcnJheSBjcmVhdGlvbg0KDQpGcm9tOiBDb2xpbiBJYW4gS2lu
ZyA8Y29saW4ua2luZ0BjYW5vbmljYWwuY29tPg0KDQpBbiBpbmNvcnJlY3Qgc2l6ZW9mKCkgaXMg
YmVpbmcgdXNlZCwgc2l6ZW9mKCgqZGF0YSktPmJwc19ibykgaXMgbm90IGNvcnJlY3QsIGl0IHNo
b3VsZCBiZSBzaXplb2YoKigqZGF0YSktPmJwc19ibykuICBJdCBqdXN0IHNvIGhhcHBlbnMgdG8g
d29yayBiZWNhdXNlIHRoZSBzaXplcyBhcmUgdGhlIHNhbWUuICBGaXggaXQuDQoNCkFkZHJlc3Nl
cy1Db3Zlcml0eTogKCJTaXplb2Ygbm90IHBvcnRhYmxlIChTSVpFT0ZfTUlTTUFUQ0gpIikNCkZp
eGVzOiA1Mjc4YTE1OWNmMzUgKCJkcm0vYW1kZ3B1OiBzdXBwb3J0IHJlc2VydmUgYmFkIHBhZ2Ug
Zm9yIHZpcnQgKHYzKSIpDQpTaWduZWQtb2ZmLWJ5OiBDb2xpbiBJYW4gS2luZyA8Y29saW4ua2lu
Z0BjYW5vbmljYWwuY29tPg0KLS0tDQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X3ZpcnQuYyB8IDIgKy0NCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRp
b24oLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92
aXJ0LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmlydC5jDQppbmRleCAy
ZDUxYjc2OTRkMWYuLmRmMTVkMzNlM2M1YyAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV92aXJ0LmMNCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV92aXJ0LmMNCkBAIC0yODMsNyArMjgzLDcgQEAgc3RhdGljIGludCBhbWRncHVfdmly
dF9pbml0X3Jhc19lcnJfaGFuZGxlcl9kYXRhKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQ0K
IAkJcmV0dXJuIC1FTk9NRU07DQogDQogCWJwcyA9IGttYWxsb2NfYXJyYXkoYWxpZ25fc3BhY2Us
IHNpemVvZigoKmRhdGEpLT5icHMpLCBHRlBfS0VSTkVMKTsNCi0JYnBzX2JvID0ga21hbGxvY19h
cnJheShhbGlnbl9zcGFjZSwgc2l6ZW9mKCgqZGF0YSktPmJwc19ibyksIEdGUF9LRVJORUwpOw0K
KwlicHNfYm8gPSBrbWFsbG9jX2FycmF5KGFsaWduX3NwYWNlLCBzaXplb2YoKigqZGF0YSktPmJw
c19ibyksIA0KK0dGUF9LRVJORUwpOw0KIA0KIAlpZiAoIWJwcyB8fCAhYnBzX2JvKSB7DQogCQlr
ZnJlZShicHMpOw0KLS0NCjIuMjkuMg0K

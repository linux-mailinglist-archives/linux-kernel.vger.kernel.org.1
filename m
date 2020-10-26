Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B55E298F6F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 15:34:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1781587AbgJZOe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 10:34:26 -0400
Received: from mail-bn7nam10on2073.outbound.protection.outlook.com ([40.107.92.73]:3889
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1781502AbgJZOeY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 10:34:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IziudNIfuOOJ6JN5ono2vI3iJjlofrJI1KYT5/xx+5t8rmcTUP3/ktllLqlJsRmOmLVddrVm0N5dJfMsLC9E6NAYHky2GvQAcqYpHRljHDVZE1I4KBUut24W2PiZXM3avMewp5ziFD29bu/iZnbG7yLuZTL0hem+G6FSOA2wK4T0S4I+9L/yOmK5pPx8jMAduAC5JxOjDrrYXZ9Y9h0XZG9aBZHX52RXMH6O8oej/jRLSc0kke/wOnY44hCwl+JRHm7xhyoYe6x9uWKDwOvWUSEq5lNLJBtMlCMotEaiHZMljrbd/J74Y1CorlCzanYZ6JmkTdjL9R3IG/ZIc5DPjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fO5yRWjkt1V2ENGxsHcc9ZjhfKCcAx8m1y3p2K3T0Dw=;
 b=X5GZYZI+qJqu9IPnZDawSspAAx6T18RiL6C3hyOFc6+PGL8slPJE5ZMBPwpl9fAFHkmR/iss9b6FC/0dfeCdF16ghMU3mTwl25E3fQabwd+cvG3PwlRpYb6MXPCMpgBNyis8SZ6x+fHowXs+B1xadrY8sRap3X0qBt/P5QYPPCvWfUwx6oFMdP6HufEUQo7lLjMxiZb9WMfL6dlXeLSP2ePEoZ1VDLMVsCYmsb5xIyiOqPXK/AsaY74tWetiqUKNxRXdm1nrNlOjr4xeal9m47CZL3+j0El6HyMATWb5PMKVhq0z4ELJYpJiJENk5pd/NF3FyTGMPYbd3c6GJmTfVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fO5yRWjkt1V2ENGxsHcc9ZjhfKCcAx8m1y3p2K3T0Dw=;
 b=VCE09kIhFLNcIvxBaJveHHvidUhPb1dN/fDy/Ma/uO1yryRpukv+8ALpKj9aYEhOcz3I1VmonLk4xDTwQ6unRwpnz/MIsVDnGT+dzQxvnSnRX2QGvKMuFAspDash7/+mSKD0Kw/cNe6/wMEUJp58NZy9K0cksxTlGnugzv8z+rc=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB2499.namprd12.prod.outlook.com (2603:10b6:207:43::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.28; Mon, 26 Oct
 2020 14:34:20 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::99dd:ff77:1ffd:d96a]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::99dd:ff77:1ffd:d96a%3]) with mapi id 15.20.3477.028; Mon, 26 Oct 2020
 14:34:20 +0000
From:   "Deucher, Alexander" <Alexander.Deucher@amd.com>
To:     =?utf-8?B?TWljaGVsIETDpG56ZXI=?= <michel@daenzer.net>,
        "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>,
        "Kazlauskas, Nicholas" <Nicholas.Kazlauskas@amd.com>,
        "Wentland, Harry" <Harry.Wentland@amd.com>,
        "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: amdgpu crashes on OOM
Thread-Topic: amdgpu crashes on OOM
Thread-Index: AQHWq1CPAUgvsk97L0C5gKrAhQfx8KmpuLgAgAA6frA=
Date:   Mon, 26 Oct 2020 14:34:20 +0000
Message-ID: <MN2PR12MB448824F6E08D1498206EFFE6F7190@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <1603684905.h43s1t0y05.none.ref@localhost>
 <1603684905.h43s1t0y05.none@localhost>
 <81568253-518f-43b7-6b20-432f7dbd6c2b@daenzer.net>
In-Reply-To: <81568253-518f-43b7-6b20-432f7dbd6c2b@daenzer.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-10-26T14:34:13Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=c154fb7f-5516-4e46-9225-00008ad8c0fd;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-10-26T14:34:06Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 9e8178ec-a71b-459b-a1ea-0000601496f1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-10-26T14:34:15Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: a86ee1f9-112c-4994-b01a-0000e5fec7d3
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: daenzer.net; dkim=none (message not signed)
 header.d=none;daenzer.net; dmarc=none action=none header.from=amd.com;
x-originating-ip: [71.219.66.138]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d9d7983a-e8c4-456f-bae1-08d879bc39e7
x-ms-traffictypediagnostic: BL0PR12MB2499:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB249957FC4BE35914C4C13925F7190@BL0PR12MB2499.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:626;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PoXp4vc4uV7YNZIVts/5YOcG1rB5WNyO4auxZlj8NQ5KKs2e+YAGUYnti+Jvsl906TVj9JQ3xKV72fdE4N6j/m/3yLqpiFIGLnaZqTxLdt7NbqQY4gqlMOJaue0Cv/juQ4tSkklUDO0ZQnlacM/g0YevnYF4+Da7146aFk/FrbQ5s9/NzYncaOYGOlMP/cgXsX74uwAe3aJmNHSHP8mgEGd+iSlosnFjmUJG6SaYps72gj1HAQ3R/ZZFDttvMEj9SpdKGm0EIybgFnnNJvtsZwzFgB3l9SclVmetMQQNwzBWwOLmnNz0tWjHTF6WtO5Z/QTn5FBGJ6+fuib9aRkGVmyyAWvMzUeB7yXqnGrFR1RBsdzlVjireh/Xqe8PuRpwareJgOu3ZUe6Oz1zSRNskw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4488.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(346002)(366004)(396003)(376002)(8936002)(316002)(66446008)(52536014)(66574015)(4326008)(9686003)(110136005)(71200400001)(2906002)(66476007)(45080400002)(5660300002)(76116006)(66946007)(7696005)(64756008)(3480700007)(66556008)(6506007)(478600001)(966005)(186003)(53546011)(86362001)(26005)(55016002)(83380400001)(4001150100001)(33656002)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: tZ26cwXnoS656ldShWcGbaiVdYNuPCmftaju2Z893pJPbO5QzNCG8FMsO3itU7TjN7Ay6nbeTYtlPOoOG/M/No+IXXdBbLIx0pJBW6O6/5inOOphvSUKbIsl4iiztbcDGjU66ujdDDvWWMriH79+kglpGKGLM55PJYfyFoqGJeAI6gy+Ratev1umQHrgAV/wHOR6nHKuVD+kkXfgVlZeK8BwUE7zf7bb+ehs8rRf5oAG1gTkd+Bn7H4P57GjKAs+YtStHMO/GzZewK0D6y33J0hTNtlqWAIP4/nlpWmP3bj18kt1SFCX3LT1yB+SN9fpMIgKHV02E9bRHFf8to/e0vSum1Q1cgLz60p1sHqozrc8Pc5B4mqkRwWCUbyDQHr9RQaI+oV6prYpYpjLYyOKxAb3LIKtuWLW8FItuocVmQSx+k0c8Cvx0to+gcMTCIcrcsHtOv4+bgOE6g/0jW6oec0Olcsg4KMqznzRoAXo4ZRshmwfjvruVUhG7qadfn3DFQdx79x/owLEa6H5EPjHviwQ+UQ6i3Rc343Giy+Pnl+Z0XDf40LOQtF8rHpi6U7Q9dSGzbekJkZL6/BcQXRzEPIaL0xol5XqscUYb3cRhQSLof9EVN22BYxMfZTVWv78P+vmLditaGR/9axqHOjhYA==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9d7983a-e8c4-456f-bae1-08d879bc39e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2020 14:34:20.4011
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2nIyWR/Bkjc/cerhdWT0LyoB7XJgz6kjj7sQZKQ7o5h+G7LccUHQa58FqRLmCkdhIgzF/BLf1f0j7rsVcetR4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2499
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W0FNRCBQdWJsaWMgVXNlXQ0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206
IE1pY2hlbCBEw6RuemVyIDxtaWNoZWxAZGFlbnplci5uZXQ+DQo+IFNlbnQ6IE1vbmRheSwgT2N0
b2JlciAyNiwgMjAyMCA3OjA0IEFNDQo+IFRvOiBBbGV4IFh1IChIZWxsbzcxKSA8YWxleF95X3h1
QHlhaG9vLmNhPjsgS2F6bGF1c2thcywgTmljaG9sYXMNCj4gPE5pY2hvbGFzLkthemxhdXNrYXNA
YW1kLmNvbT47IERldWNoZXIsIEFsZXhhbmRlcg0KPiA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNv
bT47IFdlbnRsYW5kLCBIYXJyeQ0KPiA8SGFycnkuV2VudGxhbmRAYW1kLmNvbT47IExpLCBTdW4g
cGVuZyAoTGVvKSA8U3VucGVuZy5MaUBhbWQuY29tPjsNCj4gYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcNCj4gQ2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDog
UmU6IGFtZGdwdSBjcmFzaGVzIG9uIE9PTQ0KPiANCj4gT24gMjAyMC0xMC0yNiA1OjI5IGEubS4s
IEFsZXggWHUgKEhlbGxvNzEpIHdyb3RlOg0KPiA+IEhpLA0KPiA+DQo+ID4gSSBmcmVxdWVudGx5
IGVuY291bnRlciBPT00gb24gbXkgc3lzdGVtLCBtb3N0bHkgZHVlIHRvIG15IG93biBmYXVsdC4N
Cj4gPiBSZWNlbnRseSwgSSBub3RpY2VkIHRoYXQgbm90IG9ubHkgZG9lcyBhIHN3YXAgc3Rvcm0g
aGFwcGVuIGFuZCBPT00NCj4gPiBraWxsZXIgZ2V0cyBpbnZva2VkLCBidXQgdGhlIGdyYXBoaWNz
IG91dHB1dCBmcmVlemVzIHBlcm1hbmVudGx5Lg0KPiA+IENoZWNraW5nIHRoZSBrZXJuZWwgbWVz
c2FnZXMsIEkgc2VlOg0KPiA+DQo+ID4ga3dvcmtlci91MjQ6NDogcGFnZSBhbGxvY2F0aW9uIGZh
aWx1cmU6IG9yZGVyOjUsDQo+IG1vZGU6MHg0MGRjMChHRlBfS0VSTkVMfF9fR0ZQX0NPTVB8X19H
RlBfWkVSTyksDQo+IG5vZGVtYXNrPShudWxsKQ0KPiA+IENQVTogNiBQSUQ6IDI3OTQ2OSBDb21t
OiBrd29ya2VyL3UyNDo0IFRhaW50ZWQ6IEcgICAgICAgIFcgICAgICAgICA1LjkuMC0xNDczMi0N
Cj4gZzIwYjFhZGI2MGNmNiAjMg0KPiA+IEhhcmR3YXJlIG5hbWU6IFRvIEJlIEZpbGxlZCBCeSBP
LkUuTS4gVG8gQmUgRmlsbGVkIEJ5IE8uRS5NLi9CNDUwDQo+ID4gUHJvNCwgQklPUyBQNC4yMCAw
Ni8xOC8yMDIwDQo+ID4gV29ya3F1ZXVlOiBldmVudHNfdW5ib3VuZCBjb21taXRfd29yaw0KPiA+
IENhbGwgVHJhY2U6DQo+ID4gICA/IGR1bXBfc3RhY2srMHg1Ny8weDZhDQo+ID4gICA/IHdhcm5f
YWxsb2MuY29sZCsweDY5LzB4Y2QNCj4gPiAgID8gX19hbGxvY19wYWdlc19kaXJlY3RfY29tcGFj
dCsweGZiLzB4MTE2DQo+ID4gICA/IF9fYWxsb2NfcGFnZXNfc2xvd3BhdGguY29uc3Rwcm9wLjAr
MHg5YzIvMHhjMTQNCj4gPiAgID8gX19hbGxvY19wYWdlc19ub2RlbWFzaysweDE0My8weDE2Nw0K
PiA+ICAgPyBrbWFsbG9jX29yZGVyKzB4MjQvMHg2NA0KPiA+ICAgPyBkY19jcmVhdGVfc3RhdGUr
MHgxYS8weDRkDQo+ID4gICA/IGFtZGdwdV9kbV9hdG9taWNfY29tbWl0X3RhaWwrMHgxYjE5LzB4
MjI3ZA0KPiANCj4gTG9va3MgbGlrZSBkY19jcmVhdGVfc3RhdGUgc2hvdWxkIHVzZSBrdnphbGxv
YyBpbnN0ZWFkIG9mIGt6YWxsb2MNCj4gKGRjX3N0YXRlX2ZyZWUgYWxyZWFkeSB1c2VzIGt2ZnJl
ZSkuDQo+IA0KPiBvcmRlcjo1IG1lYW5zIGl0J3MgdHJ5aW5nIHRvIGFsbG9jYXRlIDMyIHBoeXNp
Y2FsbHkgY29udGlndW91cyBwYWdlcywgd2hpY2ggY2FuDQo+IGJlIGhhcmQgdG8gZnVsZmlsbCBl
dmVuIHdpdGggbG93ZXIgbWVtb3J5IHByZXNzdXJlLg0KPiANCg0KSXQgd2FzIHVzaW5nIGt2emFs
bG9jLCBidXQgd2FzIGFjY2lkZW50bHkgZHJvcHBlZCB3aGVuIHRoYXQgY29kZSB3YXMgcmVmYWN0
b3JlZC4gIEkganVzdCBzZW50IGEgcGF0Y2ggdG8gZml4IGl0Lg0KDQpBbGV4DQoNCj4gDQo+IC0t
DQo+IEVhcnRobGluZyBNaWNoZWwgRMOkbnplciAgICAgICAgICAgICAgIHwNCj4gaHR0cHM6Ly9u
YW0xMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJG
cmVkaA0KPiBhdC5jb20lMkYmYW1wO2RhdGE9MDQlN0MwMSU3Q2FsZXhhbmRlci5kZXVjaGVyJTQw
YW1kLmNvbSU3Q2M2MA0KPiA1NjU1MWRkNGQ0MjNiZGMwNTA4ZDg3OTllZDE4OSU3QzNkZDg5NjFm
ZTQ4ODRlNjA4ZTExYTgyZDk5NGUxODNkDQo+ICU3QzAlN0MwJTdDNjM3MzkzMDcwMzMzNjQ4NjYz
JTdDVW5rbm93biU3Q1RXRnBiR1pzYjNkOGV5SldJag0KPiBvaU1DNHdMakF3TURBaUxDSlFJam9p
VjJsdU16SWlMQ0pCVGlJNklrMWhhV3dpTENKWFZDSTZNbjAlM0QlN0MxDQo+IDAwMCZhbXA7c2Rh
dGE9YTdMcHUwNEtucHNGUXBDTzd5NVdPTEpTTVBwQSUyQmUxcyUyRnVmZ1lUREhzMmsNCj4gJTNE
JmFtcDtyZXNlcnZlZD0wDQo+IExpYnJlIHNvZnR3YXJlIGVudGh1c2lhc3QgICAgICAgICAgICAg
fCAgICAgICAgICAgICBNZXNhIGFuZCBYIGRldmVsb3Blcg0K

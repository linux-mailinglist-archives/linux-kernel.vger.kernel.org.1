Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D89B2C21FB
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 10:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731685AbgKXJnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 04:43:46 -0500
Received: from mail-bn7nam10on2089.outbound.protection.outlook.com ([40.107.92.89]:46625
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729704AbgKXJnn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 04:43:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kV4nPYXX5ZeHm2my3ArYJOb0/3DEzg5aCFSVbXvPZlX9LO4mHUzaUDOsWMmivllkgWuSHomYjZCQcSrCR0KikMSR7if+gNr/GVc2YxJsTIF2zBdgRVoYxSddVkUEm48h406V3uUmx7DPEiIcc4U9y20c7jBfdV2OkZfERbcEDyUnzCrXdmWIyM0QYdTPOD3LGeUOEiNxZayjwR5mivVT2bYVzM23fOD7pYLLjh8p3k03dgA4fBGScgPYxbN9ZSXvnkUIUR5s2lCuOaSKMmX6GCQht8z6AhMubPIMDmLHO3ImesjhD8i5z1n4IaX1b7eqFbGGiLa2RA6B6FlDi9ecoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SNBt6T0e0de//ILJI+Sd/+GOW7iM14uUIFUntPiu4G4=;
 b=VH76PcZuw0ZgDRa2NOzRjb6b8x8X293JAaYWI+fgZhHitySq/TkiWjDBQXSGSEq/uOWbXKe9JRN8raTfn8IKkS/DEbBy1GzCfuWWTX3my3gsJ6N1qUtS+7ZqnjigHIZRc2JHmftXE0HSTyjDyR/vTXy4cxi6xBMMnL6MYPIfbMdamDBkueg5rj1Scl7GZriXOCGRmTWQpS99FwyUZQYFL6jKarp3XWFZs9YTa5E1x6Mek4G2X4ApfOUyNxcMlQBVUCb9QsfxnM/55tiyOTqr7OzLxjiYNbvtERYH8HC8QOTHb3Zh1l53siFKpwDESvjeokXnNGL5cBwMIdDxqNwg4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SNBt6T0e0de//ILJI+Sd/+GOW7iM14uUIFUntPiu4G4=;
 b=SRoWA0Kp31pd4NZitk+lqxUAOHVPqcJMBWqdFcJTCsiWdjzgbUwZSAa+jMVIXDHhtpUOOncC6a4yO6PT4n0xgekstMecjyLLfGUef+Nf3kR+yq2VjY88KE55w0S0Ro8tAx8CqGuj1zk+LfK3x03pLw5USObniYT5R1vocCGGZ/E=
Received: from SN6PR12MB2767.namprd12.prod.outlook.com (2603:10b6:805:75::23)
 by SN1PR12MB2413.namprd12.prod.outlook.com (2603:10b6:802:2b::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.22; Tue, 24 Nov
 2020 09:43:37 +0000
Received: from SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::d8f2:fde4:5e1d:afec]) by SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::d8f2:fde4:5e1d:afec%3]) with mapi id 15.20.3541.025; Tue, 24 Nov 2020
 09:43:37 +0000
From:   "Kalra, Ashish" <Ashish.Kalra@amd.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        "hch@lst.de" <hch@lst.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "luto@kernel.org" <luto@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "dave.hansen@linux-intel.com" <dave.hansen@linux-intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Singh, Brijesh" <brijesh.singh@amd.com>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "Grimm, Jon" <Jon.Grimm@amd.com>,
        "rientjes@google.com" <rientjes@google.com>
Subject: Re: [PATCH v6] swiotlb: Adjust SWIOTBL bounce buffer size for SEV
 guests.
Thread-Topic: [PATCH v6] swiotlb: Adjust SWIOTBL bounce buffer size for SEV
 guests.
Thread-Index: AQHWvrzaxkxw3OuD2kOZmqVqDk7+x6nV+JOAgAAN5wCAAFPQgIAAqeCAgAAFwPOAAAPHgIAAAWVL
Date:   Tue, 24 Nov 2020 09:43:37 +0000
Message-ID: <69A79870-3822-44AA-8A5D-DC329828CF64@amd.com>
References: <20201119214205.11062-1-Ashish.Kalra@amd.com>
 <20201123170647.GE15044@zn.tnic> <20201123175632.GA21539@char.us.oracle.com>
 <20201123225631.GA16055@ashkalra_ubuntu_server>
 <20201124090431.GC4009@zn.tnic>
 <EF13C80C-42DC-4B51-8AF8-2C1D3859B490@amd.com>,<20201124093837.GD4009@zn.tnic>
In-Reply-To: <20201124093837.GD4009@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [136.49.12.8]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f3cffeeb-bc3d-4372-fe1e-08d8905d6b24
x-ms-traffictypediagnostic: SN1PR12MB2413:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN1PR12MB2413B713E505242FC72E60F38EFB0@SN1PR12MB2413.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bw9pYDN9zl9CGOTRuFOGWh8SN0Ne5We14ScPUi0viN1rakEWkoFRfRfUAI6xLVWWOuDYNfQdqQQFrt+UV4kYT/tJZUntj3MoQHqrPwi6CZn+Ur37ZQ1i7z+l08kbUnym9Ag+fCc1oi4Y9ENqnityiqFDtb/jbsdUMmjZO3QXf/hRYLs+IY5Iw7uI/h9/cnUUzuxA59ODjNehplVAaU0XkEr1r6ZTpbRaZA7lubaDLJ/HCM8lNJdW8Bnnbv4C92u+7Oi4rLdUV6M6otX4FWoyhTY5Gavs80vaknQKGS+F1fOQT94cvQASIHQIVGqW1WgsjYRWNqfUTcHoHBDKC21vUBcvKAYLIBhlyfgiDA0BmbxOhfgXKhtADb9tR9BtlGWNY0mk9/4OFG7MqbCtTNhRIg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2767.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(396003)(376002)(346002)(366004)(7416002)(71200400001)(4326008)(64756008)(6512007)(33656002)(76116006)(186003)(966005)(36756003)(66446008)(66556008)(6916009)(66476007)(66946007)(26005)(478600001)(5660300002)(316002)(8936002)(2616005)(54906003)(8676002)(86362001)(6486002)(53546011)(2906002)(6506007)(45080400002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: LB/DgCRFFxY5lwIOluaRKRCUUyQBqp+VBD3A7b0DTKLPQ9Lukzr4AIEBdlsAJpEkkvZuB0CVUfc4IK8wgnkUDh/aUiEMbDRQnHiCKYFnyWwI5qfe0MG7ISsiL2ZblMfp/trTwOOcn88gvAwkWelRnJD6wq6wa+b6uyfoPu7M+fdm70dM7c7wGH4KWcpKAZ2zHowqklcImMavjzrJXk2cJlHfea86X63XT33ohxaX8bnN8kyXFOMY6awSZndGqaAEFSxkF8dsFacJArXi2ndn4q3FT+AOn6dvgai2hCod5MpvxMaSTknb2r05QUw7tlbeNYD9X45WwR/RD4JHPtOl/IE77JoWCKpm8q9t0I3/BxAZmQ02pyMlZM210S3XnNQxqs+AqryuGBK5OiBYCZ92UZpHi0YE6QzmJATltLl1qyBpsLLQfG+mUHqCoJQDSA6qfJLKQ6jlPWOUhnfSnvcW0+54jGs/7NDKBw5X37Bd4gy3hwKyJ+0s6Xkltq/3kOUM7XJHPDUiaPPGGhDXjRdgSrOsZPyGCyRaerpfuaA/gkb7r+hUArkUVS9cAMymi9B5Y6npyF/GMk8BLUyv5qCFjf3ecKtxqtU5bPEThQCXHaepTZwORpTTec3ykCbHFpsQGig5Zz5i17OjzA+tXcH6I+0UD591m5ekR9yqv6kGnzqXqocYkwAhf2KqByJqQw8AHWcdxjmZ/NXv/3MLxQ1NJB3IF7LYMbsUcFwagQOxXqSVqInzXYeRD0HySw5fRivg1XIrPbxfXDUovx+NEKxItEyYgiKjmL6uC9mnY4D4tUqGnH7sXqf/ckRbk7AZWMAjQqqlJsYybhtDOxtZ+OhDnxQv6i3qMK8Wlpq7TxOTpKNtL2BXuGS2JHJzklWvE0XMWM6z0fhMYAUQTD1ms3TfeA==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3cffeeb-bc3d-4372-fe1e-08d8905d6b24
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2020 09:43:37.6150
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gmj+ELgmy7itJJnh2Hst5e/tm9KVZkbWPm2i2KZGctxokNmmogyo7bVcmxGhn20uIyy+kqlQ5+X/mI+St6xb3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2413
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gTm92IDI0LCAyMDIwLCBhdCAzOjM4IEFNLCBCb3Jpc2xhdiBQZXRrb3YgPGJwQGFs
aWVuOC5kZT4gd3JvdGU6DQo+IA0KPiDvu79PbiBUdWUsIE5vdiAyNCwgMjAyMCBhdCAwOToyNTow
NkFNICswMDAwLCBLYWxyYSwgQXNoaXNoIHdyb3RlOg0KPj4gQnV0IHdoYXQgd2lsbCBiZSB0aGUg
Y3JpdGVyaWEgdG8gZmlndXJlIG91dCB0aGlzIHBlcmNlbnRhZ2U/DQo+PiANCj4+IEFzIEkgbWVu
dGlvbmVkIGVhcmxpZXIsIHRoaXMgY2FuIGJlIG1hZGUgYXMgY29tcGxpY2F0ZWQgYXMgcG9zc2li
bGUgYnkNCj4+IGFkZGluZyBhbGwga2luZCBvZiBoZXVyaXN0aWNzIGJ1dCB3aXRob3V0IGFueSBw
cmVkaWN0YWJsZSBwZXJmb3JtYW5jZQ0KPj4gZ2Fpbi4NCj4+IA0KPj4gT3IgaXQgY2FuIGJlIGtl
cHQgc2ltcGxlIGJ5IHVzaW5nIGEgc3RhdGljIHBlcmNlbnRhZ2UgdmFsdWUuDQo+IA0KPiBZZXMs
IHN0YXRpYyBwZXJjZW50YWdlIG51bWJlciBiYXNlZCBvbiB0aGUgZ3Vlc3QgbWVtb3J5LiBYJSBv
ZiB0aGUgZ3Vlc3QNCj4gbWVtb3J5IGlzIHVzZWQgZm9yIFNXSU9UTEIuDQo+IA0KPiBTaW5jZSB5
b3UgdXNlIHNldl9hY3RpdmUoKSwgaXQgbWVhbnMgdGhlIHNpemUgY29tcHV0YXRpb24gaXMgZG9u
ZSBpbiB0aGUNCj4gZ3Vlc3Qgc28gdGhhdCBTV0lPVExCIHNpemUgaXMgcGVyLWd1ZXN0LiBZZXM/
DQoNClllcw0KDQo+IA0KPiBJZiBzbywgeW91IGNhbiBzaW1wbHkgdGFrZSwgc2F5LCA1JSBvZiB0
aGUgZ3Vlc3QgbWVtb3J5J3Mgc2l6ZSBhbmQgdXNlDQo+IHRoYXQgZm9yIFNXSU9UTEIgYnVmZmVy
cy4gT3IgNiBvciBYIG9yIHdoYXRldmVyLg0KPiANCj4gTWFrZXMgc2Vuc2U/DQoNClN1cmUgaXQg
ZG9lcy4NCg0KVGhhbmtzLA0KQXNoaXNoDQoNCj4gDQo+IC0tIA0KPiBSZWdhcmRzL0dydXNzLA0K
PiAgICBCb3Jpcy4NCj4gDQo+IGh0dHBzOi8vbmFtMTEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0
bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRnBlb3BsZS5rZXJuZWwub3JnJTJGdGdseCUyRm5v
dGVzLWFib3V0LW5ldGlxdWV0dGUmYW1wO2RhdGE9MDQlN0MwMSU3Q0FzaGlzaC5LYWxyYSU0MGFt
ZC5jb20lN0M5MWI2MTFiMjFkMzA0OWQ3MGNhOTA4ZDg5MDVjYmMzNyU3QzNkZDg5NjFmZTQ4ODRl
NjA4ZTExYTgyZDk5NGUxODNkJTdDMCU3QzAlN0M2Mzc0MTgwNzUyODQwMDA1NjQlN0NVbmtub3du
JTdDVFdGcGJHWnNiM2Q4ZXlKV0lqb2lNQzR3TGpBd01EQWlMQ0pRSWpvaVYybHVNeklpTENKQlRp
STZJazFoYVd3aUxDSlhWQ0k2TW4wJTNEJTdDMTAwMCZhbXA7c2RhdGE9SnZuVWZza3lkOXhkc2Fs
NG9Za1NZVzVvdUwyYjRjcyUyRm8yb1lpOUtya0ZvJTNEJmFtcDtyZXNlcnZlZD0wDQo=

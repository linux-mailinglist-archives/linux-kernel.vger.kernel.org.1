Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6108F2EA50B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 06:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726053AbhAEFvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 00:51:15 -0500
Received: from mga03.intel.com ([134.134.136.65]:17159 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725768AbhAEFvP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 00:51:15 -0500
IronPort-SDR: 6BbfzZIlEv4h4OAAEWSMURi/XEZRfKqrxgesYZCwFZcsazMFAeDGm2eWReDyYYDiNqMlb4I2xH
 His27lqnoIPA==
X-IronPort-AV: E=McAfee;i="6000,8403,9854"; a="177157111"
X-IronPort-AV: E=Sophos;i="5.78,476,1599548400"; 
   d="scan'208";a="177157111"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2021 21:50:34 -0800
IronPort-SDR: /8bCxFx/XldcHSmU1EmN1Pu46B0dJq2JapnEgT08snDTWPp3BfRe7KOTFpyIUJU9s5toosEFhV
 k7DXRUoP9mcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,476,1599548400"; 
   d="scan'208";a="361041813"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga002.jf.intel.com with ESMTP; 04 Jan 2021 21:50:33 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 4 Jan 2021 21:50:33 -0800
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 4 Jan 2021 21:50:32 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 4 Jan 2021 21:50:32 -0800
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (104.47.46.54) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Mon, 4 Jan 2021 21:50:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ntJuIk/GUA6FrNSZjVY4+uSrM1PrWobYGP9SZwSx9YqVnmai+B3X0MhUhpGdTqEh62DTkRMj8X7XvKoXhb0HauSttvwiHL9wuvjiqac1gGD/CdSttsTIZEJCs4Cg2Pr8FPfLp0AU5xNeXC/Odvc/ylDdeh7ATLvXW/DJT7efBGcyXgJpNqHf7YMqQpoG4WWjJ32VQc80YMC6cMK2bM1BEYQWNZEqfMiHU9dLaFJsYjK42OFzRyno0zN4uCP8zd0Wt6OLbEJvRPoLJ0aipLYOKe/UO1C41KV2F7OHHz21mUmiOieEIUDj6SJU79ZPfDNBcpmweT8fE1sAfGEU2+ITww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/mouPT8yTrGRenUZkLP66MA7kWaIshXJwoDrDE2rrok=;
 b=frrqm7nCmJ4UhtGf1i5v99z1Cw31PHq1cDmvyQoaYgVOvtqwJmd0nPs2cMv9fprPYsbdwxrfo6j551mG1INDbNOoyqr8DpdiNOK+wyVENY4tKlIJeLHI08rD1kRFkLRe9UBSrGDENsdrckL2yXeTfxuk2xC2i+1TvSIYEKEHsweySOeGwYIKVYwUSAhxZSBURqGmbzwENU/pOGWnHKFbx/iCJ7iqXpA+X2iMEopIgaHuA1ZtqII2DiNvlGS3msmum1Sa96kv8d816fMV75I7cO4mf7Kh5Lc8CNerpO/ohUwN5Q7fIENARoohg8aWL/iMizt8fPYe3uDpxmtDFp3Rgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/mouPT8yTrGRenUZkLP66MA7kWaIshXJwoDrDE2rrok=;
 b=mqvFW/W5Tk8hI+3JHc1T29NRkfaBXKwO0zyZDib9AJ/10/Oisd/Nqdd+JU0EVm6MfRioUY7LJq8sB/7n7N2b9oXKU9xFOQST6g/kd5GMJ+RRc3soQ55M2TvRjZuiHbJe7zG8GNZgnOe0NbntFp1AT/cZNC6Dwnm6RG8ddN1ThCw=
Received: from DM5PR11MB1435.namprd11.prod.outlook.com (2603:10b6:4:7::18) by
 DM6PR11MB2538.namprd11.prod.outlook.com (2603:10b6:5:be::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3721.21; Tue, 5 Jan 2021 05:50:22 +0000
Received: from DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::649c:8aff:2053:e93]) by DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::649c:8aff:2053:e93%3]) with mapi id 15.20.3721.024; Tue, 5 Jan 2021
 05:50:22 +0000
From:   "Liu, Yi L" <yi.l.liu@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>
CC:     "Tian, Kevin" <kevin.tian@intel.com>,
        "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Tian, Jun J" <jun.j.tian@intel.com>,
        "Sun, Yi Y" <yi.y.sun@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 3/3] iommu/vt-d: Fix ineffective devTLB invalidation
 for subdevices
Thread-Topic: [PATCH v3 3/3] iommu/vt-d: Fix ineffective devTLB invalidation
 for subdevices
Thread-Index: AQHW3ZLDHAgDEwjOUE+qCmcDR/T80qoNwakAgArQO+A=
Date:   Tue, 5 Jan 2021 05:50:22 +0000
Message-ID: <DM5PR11MB1435E814408F19A947263C07C3D10@DM5PR11MB1435.namprd11.prod.outlook.com>
References: <20201229032513.486395-1-yi.l.liu@intel.com>
 <20201229032513.486395-4-yi.l.liu@intel.com>
 <c109eb64-2805-5e87-2283-b52c5704a31f@linux.intel.com>
In-Reply-To: <c109eb64-2805-5e87-2283-b52c5704a31f@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.207]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 19eb9c1e-3537-40fc-5d68-08d8b13dca80
x-ms-traffictypediagnostic: DM6PR11MB2538:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB2538896C6130DD2DACF484D8C3D10@DM6PR11MB2538.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 522FIpoumCKcuxMetgPKCCTyBF7pvZZrHYO/Rs0txuA1P0uXYGnf2I1bv7Uwj69c6HJGD7H1s3RKKrn5CYa2vGGv/P1A2GOCy3QnrlhilNj2oH8evyWcRmouRpx6saazSe4Qf7nAq3y5xFCkKCsDRYUaZN1CnlHKW+bZCiYOHE27XqPOW41ydXGS5W2GdL9giaymXprgYjiqIEi+FRTKNdHR7l/RAdLt7Yx7xa3gKTXYKx6jweAPbfPHJRwcsCoEkqNBxTo3/e/hz4gyC+XstEvezVFEz0KOx7OCOg14dZ6svYLw8QikKH26rvCrLuEiOoDLdptHivR2mTpG2ozU3rn/bqgdLlHqrwDusciNg4Ho5d1dVmCrZSqPob7r1POlIJqoZa7FdpblLHr/PAG/Xw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(136003)(39860400002)(346002)(366004)(110136005)(316002)(83380400001)(54906003)(33656002)(8676002)(478600001)(186003)(55016002)(71200400001)(76116006)(53546011)(6506007)(66946007)(26005)(7696005)(86362001)(4326008)(9686003)(66476007)(52536014)(2906002)(66446008)(8936002)(64756008)(5660300002)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?VHdXcWphS1lLSFpZMmtBUVJPK28zanp4Q2piQmU4aFhyNW02UStoVldEbGJM?=
 =?utf-8?B?c1MzTmxKUVd1QVJtRVdydHJGOEJoMlJLdVgrclZ3SmJBeFR1R3VsNkp5YXps?=
 =?utf-8?B?OVVCM1dHKzdpWmQ3TDBPelUxWTZnYnR5VWhpMlYxeXBWTUVmL3crNGVUeVFy?=
 =?utf-8?B?RUxmMEorMTdZSys0THRTWlZtQjE2VnVQMDZ3YmVxTGNQZ2tXNkdXYlFZMHlO?=
 =?utf-8?B?VHJXK2hnRHVkcW1EVmE5Uk1qbzVxcHc0Z3ZnZHRrWDBrUjBSMkN1MGtsZ0t4?=
 =?utf-8?B?dlJjNkN6NFBVR2dlN2hGNDRqbi9zTnhWei92QzViTmpZYXBVR1MyYVVTdy8z?=
 =?utf-8?B?VXBHWWE1c0ZCVDU5d09ic2RwN0syRDlCR0hMU2RzVU9SS0VWMHFnd05SVXdY?=
 =?utf-8?B?QTAvYWs2ZURqRFhhYjVCWWllM09uQk5QdGp1OFJLRzM1bXdkanhMQ3YyTjNy?=
 =?utf-8?B?Tk1jQkNLajNBWDhaRGpvTndBZ2J5ekNkM3RYSTNubEdlMWZvcW15WnhueVFy?=
 =?utf-8?B?RFI1ZUlDNlZLTmpuS0ZtUUFiS29HbFhjbXl0NFZYY2t2dVA0d0tJMG5sZE9z?=
 =?utf-8?B?L1Y1N20rVFNtMTlJUERvL1pMb3BoNlhxUHkxeHZ1SmJMV2o4cFk5aXJJQ09Y?=
 =?utf-8?B?Mmt1NFBnWXkrV1pRY0kwMWlGTGNpeFJ1OWZYT2FQUUtsNGczS0xVd1c4MU1N?=
 =?utf-8?B?NWxqTkRpL1BoQ1I0MDdkWkJVdER6bFYrSGNha3pZYzZFeEtjcG1yYW5wanlo?=
 =?utf-8?B?SnJWNWZTcXV3UC9RT2Q5eFpodmVxOXl5ZDNlMXF3ZXg4dXpxWUV0U0YrVTBx?=
 =?utf-8?B?Z2pFcS9PL3A5YjdpYXJhU0JKZjJwbW9IUXhCNHFYOElqcjU4czdZMzNwcFBa?=
 =?utf-8?B?OHF5R3Vock5hY09lbjhXVHlHcU4rTVVUSHg1dVRaVEZlOFY0WFloMGNza09U?=
 =?utf-8?B?b0c1Nnh6SHdtcnFkV2w4YnRHZ1BFQVdOK3kyaGE2dStBcWlPM3FEUnJGNWNJ?=
 =?utf-8?B?bzZsOXVwd2NldXhxakVpV2JzZWU0a2diTkk2MEczdGxqRm9jN0NCSUt6WHZP?=
 =?utf-8?B?cG1scmlzZExSTmExRGpoaCtkUmQreG02dkxyV0ZkSWZQaUdBRXFxL09HSDdJ?=
 =?utf-8?B?UmYwbXlFZWZxNG1YQUZtL21RL2hrN2dyaHIrbUthT0xVNm0vNnhvMHQ5RlFE?=
 =?utf-8?B?dFNEdzNYbGJPQ2wvdVFITFJMNWtVZEdtdVFqN2tuZlhpbnhMUUFZeFFoWkNi?=
 =?utf-8?B?RUh1K2ZxemttZVo5Z1I1Ym4xejY2ZjQxenpUWm1TODBvVUtCc01HR1o5NG8v?=
 =?utf-8?Q?F/wZXPo+iOi8U=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19eb9c1e-3537-40fc-5d68-08d8b13dca80
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2021 05:50:22.0227
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G7Agvkc3ZD8aa1AfimB20/v6Rt/ZNu0FbTA02SNGsr3wSY7JR7XGDxv7gH4nw8Dq9rQI6UAkp6HToTYUUEHC+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2538
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQmFvbHUsDQoNCj4gRnJvbTogTHUgQmFvbHUgPGJhb2x1Lmx1QGxpbnV4LmludGVsLmNvbT4N
Cj4gU2VudDogVHVlc2RheSwgRGVjZW1iZXIgMjksIDIwMjAgNDo0MiBQTQ0KPiANCj4gSGkgWWks
DQo+IA0KPiBPbiAyMDIwLzEyLzI5IDExOjI1LCBMaXUgWWkgTCB3cm90ZToNCj4gPiBpb21tdV9m
bHVzaF9kZXZfaW90bGIoKSBpcyBjYWxsZWQgdG8gaW52YWxpZGF0ZSBjYWNoZXMgb24gZGV2aWNl
LiBJdCBvbmx5DQo+ID4gbG9vcHMgdGhlIGRldmljZXMgd2hpY2ggYXJlIGZ1bGwtYXR0YWNoZWQg
dG8gdGhlIGRvbWFpbi4gRm9yIHN1Yi1kZXZpY2VzLA0KPiA+IHRoaXMgaXMgaW5lZmZlY3RpdmUu
IFRoaXMgcmVzdWx0cyBpbiBpbnZhbGlkIGNhY2hpbmcgZW50cmllcyBsZWZ0IG9uIHRoZQ0KPiA+
IGRldmljZS4gRml4IGl0IGJ5IGFkZGluZyBsb29wIGZvciBzdWJkZXZpY2VzIGFzIHdlbGwuIEFs
c28sIHRoZSBkb21haW4tPg0KPiA+IGhhc19pb3RsYl9kZXZpY2UgbmVlZHMgdG8gYmUgdXBkYXRl
ZCB3aGVuIGF0dGFjaGluZyB0byBzdWJkZXZpY2VzLg0KPiA+DQo+ID4gRml4ZXM6IDY3YjhlMDJi
NWU3NjEgKCJpb21tdS92dC1kOiBBdXgtZG9tYWluIHNwZWNpZmljIGRvbWFpbg0KPiBhdHRhY2gv
ZGV0YWNoIikNCj4gPiBTaWduZWQtb2ZmLWJ5OiBMaXUgWWkgTCA8eWkubC5saXVAaW50ZWwuY29t
Pg0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVycy9pb21tdS9pbnRlbC9pb21tdS5jIHwgNTMgKysrKysr
KysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0NCj4gLS0NCj4gPiAgIDEgZmlsZSBjaGFuZ2Vk
LCAzNyBpbnNlcnRpb25zKCspLCAxNiBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2lvbW11L2ludGVsL2lvbW11LmMgYi9kcml2ZXJzL2lvbW11L2ludGVsL2lvbW11
LmMNCj4gPiBpbmRleCBkNzcyMGE4MzYyNjguLmQ0OGE2MGI2MWJhNiAxMDA2NDQNCj4gPiAtLS0g
YS9kcml2ZXJzL2lvbW11L2ludGVsL2lvbW11LmMNCj4gPiArKysgYi9kcml2ZXJzL2lvbW11L2lu
dGVsL2lvbW11LmMNCj4gPiBAQCAtNzE5LDYgKzcxOSw4IEBAIHN0YXRpYyBpbnQgZG9tYWluX3Vw
ZGF0ZV9kZXZpY2Vfbm9kZShzdHJ1Y3QNCj4gZG1hcl9kb21haW4gKmRvbWFpbikNCj4gPiAgIAly
ZXR1cm4gbmlkOw0KPiA+ICAgfQ0KPiA+DQo+ID4gK3N0YXRpYyB2b2lkIGRvbWFpbl91cGRhdGVf
aW90bGIoc3RydWN0IGRtYXJfZG9tYWluICpkb21haW4pOw0KPiA+ICsNCj4gPiAgIC8qIFNvbWUg
Y2FwYWJpbGl0aWVzIG1heSBiZSBkaWZmZXJlbnQgYWNyb3NzIGlvbW11cyAqLw0KPiA+ICAgc3Rh
dGljIHZvaWQgZG9tYWluX3VwZGF0ZV9pb21tdV9jYXAoc3RydWN0IGRtYXJfZG9tYWluICpkb21h
aW4pDQo+ID4gICB7DQo+ID4gQEAgLTc0NCw2ICs3NDYsOCBAQCBzdGF0aWMgdm9pZCBkb21haW5f
dXBkYXRlX2lvbW11X2NhcChzdHJ1Y3QNCj4gZG1hcl9kb21haW4gKmRvbWFpbikNCj4gPiAgIAkJ
ZG9tYWluLT5kb21haW4uZ2VvbWV0cnkuYXBlcnR1cmVfZW5kID0NCj4gX19ET01BSU5fTUFYX0FE
RFIoZG9tYWluLT5nYXcgLSAxKTsNCj4gPiAgIAllbHNlDQo+ID4gICAJCWRvbWFpbi0+ZG9tYWlu
Lmdlb21ldHJ5LmFwZXJ0dXJlX2VuZCA9DQo+IF9fRE9NQUlOX01BWF9BRERSKGRvbWFpbi0+Z2F3
KTsNCj4gPiArDQo+ID4gKwlkb21haW5fdXBkYXRlX2lvdGxiKGRvbWFpbik7DQo+ID4gICB9DQo+
ID4NCj4gPiAgIHN0cnVjdCBjb250ZXh0X2VudHJ5ICppb21tdV9jb250ZXh0X2FkZHIoc3RydWN0
IGludGVsX2lvbW11ICppb21tdSwNCj4gdTggYnVzLA0KPiA+IEBAIC0xNDY0LDE3ICsxNDY4LDIy
IEBAIHN0YXRpYyB2b2lkIGRvbWFpbl91cGRhdGVfaW90bGIoc3RydWN0DQo+IGRtYXJfZG9tYWlu
ICpkb21haW4pDQo+ID4NCj4gPiAgIAlhc3NlcnRfc3Bpbl9sb2NrZWQoJmRldmljZV9kb21haW5f
bG9jayk7DQo+ID4NCj4gPiAtCWxpc3RfZm9yX2VhY2hfZW50cnkoaW5mbywgJmRvbWFpbi0+ZGV2
aWNlcywgbGluaykgew0KPiA+IC0JCXN0cnVjdCBwY2lfZGV2ICpwZGV2Ow0KPiA+IC0NCj4gPiAt
CQlpZiAoIWluZm8tPmRldiB8fCAhZGV2X2lzX3BjaShpbmZvLT5kZXYpKQ0KPiA+IC0JCQljb250
aW51ZTsNCj4gPiAtDQo+ID4gLQkJcGRldiA9IHRvX3BjaV9kZXYoaW5mby0+ZGV2KTsNCj4gPiAt
CQlpZiAocGRldi0+YXRzX2VuYWJsZWQpIHsNCj4gPiArCWxpc3RfZm9yX2VhY2hfZW50cnkoaW5m
bywgJmRvbWFpbi0+ZGV2aWNlcywgbGluaykNCj4gPiArCQlpZiAoaW5mbyAmJiBpbmZvLT5hdHNf
ZW5hYmxlZCkgew0KPiA+ICAgCQkJaGFzX2lvdGxiX2RldmljZSA9IHRydWU7DQo+ID4gICAJCQli
cmVhazsNCj4gPiAgIAkJfQ0KPiA+ICsNCj4gPiArCWlmICghaGFzX2lvdGxiX2RldmljZSkgew0K
PiA+ICsJCXN0cnVjdCBzdWJkZXZfZG9tYWluX2luZm8gKnNpbmZvOw0KPiA+ICsNCj4gPiArCQls
aXN0X2Zvcl9lYWNoX2VudHJ5KHNpbmZvLCAmZG9tYWluLT5zdWJkZXZpY2VzLA0KPiBsaW5rX2Rv
bWFpbikgew0KPiA+ICsJCQlpbmZvID0gZ2V0X2RvbWFpbl9pbmZvKHNpbmZvLT5wZGV2KTsNCj4g
PiArCQkJaWYgKGluZm8gJiYgaW5mby0+YXRzX2VuYWJsZWQpIHsNCj4gPiArCQkJCWhhc19pb3Rs
Yl9kZXZpY2UgPSB0cnVlOw0KPiA+ICsJCQkJYnJlYWs7DQo+ID4gKwkJCX0NCj4gPiArCQl9DQo+
ID4gICAJfQ0KPiA+DQo+ID4gICAJZG9tYWluLT5oYXNfaW90bGJfZGV2aWNlID0gaGFzX2lvdGxi
X2RldmljZTsNCj4gPiBAQCAtMTU1NSwyNSArMTU2NCwzNyBAQCBzdGF0aWMgdm9pZCBpb21tdV9k
aXNhYmxlX2Rldl9pb3RsYihzdHJ1Y3QNCj4gZGV2aWNlX2RvbWFpbl9pbmZvICppbmZvKQ0KPiA+
ICAgI2VuZGlmDQo+ID4gICB9DQo+ID4NCj4gPiArc3RhdGljIHZvaWQgX19pb21tdV9mbHVzaF9k
ZXZfaW90bGIoc3RydWN0IGRldmljZV9kb21haW5faW5mbyAqaW5mbywNCj4gPiArCQkJCSAgICB1
NjQgYWRkciwgdW5zaWduZWQgaW50IG1hc2spDQo+ID4gK3sNCj4gPiArCXUxNiBzaWQsIHFkZXA7
DQo+ID4gKw0KPiA+ICsJaWYgKCFpbmZvIHx8ICFpbmZvLT5hdHNfZW5hYmxlZCkNCj4gPiArCQly
ZXR1cm47DQo+ID4gKw0KPiA+ICsJc2lkID0gaW5mby0+YnVzIDw8IDggfCBpbmZvLT5kZXZmbjsN
Cj4gPiArCXFkZXAgPSBpbmZvLT5hdHNfcWRlcDsNCj4gPiArCXFpX2ZsdXNoX2Rldl9pb3RsYihp
bmZvLT5pb21tdSwgc2lkLCBpbmZvLT5wZnNpZCwNCj4gPiArCQkJICAgcWRlcCwgYWRkciwgbWFz
ayk7DQo+ID4gK30NCj4gPiArDQo+ID4gICBzdGF0aWMgdm9pZCBpb21tdV9mbHVzaF9kZXZfaW90
bGIoc3RydWN0IGRtYXJfZG9tYWluICpkb21haW4sDQo+ID4gICAJCQkJICB1NjQgYWRkciwgdW5z
aWduZWQgbWFzaykNCj4gPiAgIHsNCj4gPiAtCXUxNiBzaWQsIHFkZXA7DQo+ID4gICAJdW5zaWdu
ZWQgbG9uZyBmbGFnczsNCj4gPiAgIAlzdHJ1Y3QgZGV2aWNlX2RvbWFpbl9pbmZvICppbmZvOw0K
PiA+ICsJc3RydWN0IHN1YmRldl9kb21haW5faW5mbyAqc2luZm87DQo+ID4NCj4gPiAgIAlpZiAo
IWRvbWFpbi0+aGFzX2lvdGxiX2RldmljZSkNCj4gPiAgIAkJcmV0dXJuOw0KPiA+DQo+ID4gICAJ
c3Bpbl9sb2NrX2lycXNhdmUoJmRldmljZV9kb21haW5fbG9jaywgZmxhZ3MpOw0KPiA+IC0JbGlz
dF9mb3JfZWFjaF9lbnRyeShpbmZvLCAmZG9tYWluLT5kZXZpY2VzLCBsaW5rKSB7DQo+ID4gLQkJ
aWYgKCFpbmZvLT5hdHNfZW5hYmxlZCkNCj4gPiAtCQkJY29udGludWU7DQo+ID4gKwlsaXN0X2Zv
cl9lYWNoX2VudHJ5KGluZm8sICZkb21haW4tPmRldmljZXMsIGxpbmspDQo+ID4gKwkJX19pb21t
dV9mbHVzaF9kZXZfaW90bGIoaW5mbywgYWRkciwgbWFzayk7DQo+ID4NCj4gPiAtCQlzaWQgPSBp
bmZvLT5idXMgPDwgOCB8IGluZm8tPmRldmZuOw0KPiA+IC0JCXFkZXAgPSBpbmZvLT5hdHNfcWRl
cDsNCj4gPiAtCQlxaV9mbHVzaF9kZXZfaW90bGIoaW5mby0+aW9tbXUsIHNpZCwgaW5mby0+cGZz
aWQsDQo+ID4gLQkJCQlxZGVwLCBhZGRyLCBtYXNrKTsNCj4gPiArCWxpc3RfZm9yX2VhY2hfZW50
cnkoc2luZm8sICZkb21haW4tPnN1YmRldmljZXMsIGxpbmtfZG9tYWluKSB7DQo+ID4gKwkJX19p
b21tdV9mbHVzaF9kZXZfaW90bGIoZ2V0X2RvbWFpbl9pbmZvKHNpbmZvLT5wZGV2KSwNCj4gPiAr
CQkJCQlhZGRyLCBtYXNrKTsNCj4gPiAgIAl9DQo+IA0KPiBOaXQ6DQo+IAlsaXN0X2Zvcl9lYWNo
X2VudHJ5KHNpbmZvLCAmZG9tYWluLT5zdWJkZXZpY2VzLCBsaW5rX2RvbWFpbikgew0KPiAJCWlu
Zm8gPSBnZXRfZG9tYWluX2luZm8oc2luZm8tPnBkZXYpOw0KPiAJCV9faW9tbXVfZmx1c2hfZGV2
X2lvdGxiKGluZm8sIGFkZHIsIG1hc2spOw0KPiAJfQ0KDQp5b3UgYXJlIHJpZ2h0LiB0aGlzIHNo
b3VsZCBiZSBiZXR0ZXIuDQoNCj4gT3RoZXJzIGxvb2sgZ29vZCB0byBtZS4NCj4NCj4gQWNrZWQt
Ynk6IEx1IEJhb2x1IDxiYW9sdS5sdUBsaW51eC5pbnRlbC5jb20+DQo+IA0KPiBCZXN0IHJlZ2Fy
ZHMsDQo+IGJhb2x1DQoNClJlZ2FyZHMsDQpZaSBMaXUNCg0KPiA+ICAgCXNwaW5fdW5sb2NrX2ly
cXJlc3RvcmUoJmRldmljZV9kb21haW5fbG9jaywgZmxhZ3MpOw0KPiA+ICAgfQ0KPiA+DQo=

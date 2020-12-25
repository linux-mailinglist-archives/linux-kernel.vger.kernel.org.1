Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45CE42E2A68
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Dec 2020 09:29:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbgLYIYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Dec 2020 03:24:43 -0500
Received: from mga06.intel.com ([134.134.136.31]:10497 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725774AbgLYIYn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Dec 2020 03:24:43 -0500
IronPort-SDR: mVEJ8Xs6p7pN5GkXv17W8sHCifTlz5x2JCjGwDSdatmzGB3MSuO/DiLcVbzEcLmVQ+wnts0XGc
 FSMN+inPPKqw==
X-IronPort-AV: E=McAfee;i="6000,8403,9845"; a="237762916"
X-IronPort-AV: E=Sophos;i="5.78,447,1599548400"; 
   d="scan'208";a="237762916"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2020 00:23:56 -0800
IronPort-SDR: mDIR/pdjEQNHYUFGp30rCV4Tg0kJaQPdjaGtDE7D+LKKfI16COpx9d6YHoM7Y2XSOMU1noCdNr
 lFumnU2TauuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,447,1599548400"; 
   d="scan'208";a="357696890"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga002.jf.intel.com with ESMTP; 25 Dec 2020 00:23:56 -0800
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 25 Dec 2020 00:23:56 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 25 Dec 2020 00:23:56 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Fri, 25 Dec 2020 00:23:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iSU+pssSLlFqNF8eg3+pIJvtts1Yp/HlWoZReHGauGTzdMSTUZ1aXFWkjEbY9Q7pAUbmXFqptLEjbnpUMSjkC/SkakfXC28bn/EGQT0zIDYfcNdjFPalsLR5649CfqDCqXdQ35a10l3PxeKdpPVbZwHhyrPfefsTpWv9grvGZJ8CZAaYZDJm+6deSajEox2wjbJAyoaw2j/1WIN9ED4euSQ11W8oYno5Q9IF1MYftWndezy11E+2zJyg5pQU+xuSlIfqHWmPe/7EFIxaTKPwJBGTFCRdnvQzBOymC9fm8L9RBgyuYL/nn/dd1Mtziq9BX3Ks3UsqxOdU/ObVa3EH7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X4BdURSI3rBPJScRPQyji/V9CmIoKIk7GX0bZjdkf2s=;
 b=L+VRUPNxLH9rQE3Ngk2yQ8LcmD4nwwhqQIawVPdUjBTNTGr7YAaYGnWq18tr6nXCWWvG/qhlmLtwjE2nnfV7TurQUlm8zp5E0KLaHFam7AX0teQhKlqMdrqACliJX4DlAdkPz37l6rHCTSjHDpF+fTxB5JChZ2pxBm25SHSRWaUC3WUNbnzIWjEmAAKK9jMskQ4/nAHq9XncH32XAIhhzwSjS6V9xYbxe+TtPBSwvKoU+ybecpeUc+T+/TFPBL/xi8EcvOjWWnSJvLmf+13Iyce+5YPTI9topTt519W9X8tQZ3mSh7jtQc1mhvjQ1gELUiz9lNjKaRxoiiVAJyrpNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X4BdURSI3rBPJScRPQyji/V9CmIoKIk7GX0bZjdkf2s=;
 b=XKoUvXMH1f4dFWg4Rlq6W/Pq0fBk55ZXbrW1rTEq6XpX8FEolBlR2sOacMdRYz/1kJdqgQElioCFezM+M42UKee6dKPxEykkVjxW4Mw8EmT3s8TB2c8gXV4Fw8hDmYw1KQnTSN270dgTyz/VJLLOEq308EnrOVVj8TrPj69txQQ=
Received: from DM5PR11MB1435.namprd11.prod.outlook.com (2603:10b6:4:7::18) by
 DM5PR11MB1692.namprd11.prod.outlook.com (2603:10b6:3:d::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3700.27; Fri, 25 Dec 2020 08:23:52 +0000
Received: from DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::649c:8aff:2053:e93]) by DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::649c:8aff:2053:e93%3]) with mapi id 15.20.3676.033; Fri, 25 Dec 2020
 08:23:51 +0000
From:   "Liu, Yi L" <yi.l.liu@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
        "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>
CC:     "Tian, Kevin" <kevin.tian@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Tian, Jun J" <jun.j.tian@intel.com>,
        "Sun, Yi Y" <yi.y.sun@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 3/3] iommu/vt-d: Fix ineffective devTLB invalidation
 for subdevices
Thread-Topic: [PATCH v2 3/3] iommu/vt-d: Fix ineffective devTLB invalidation
 for subdevices
Thread-Index: AQHW2PTKeeH7EpKUS0qYrKOxA9H4gqoEdZmAgAMG3UA=
Date:   Fri, 25 Dec 2020 08:23:51 +0000
Message-ID: <DM5PR11MB1435370E436A7C6FA0F29614C3DC0@DM5PR11MB1435.namprd11.prod.outlook.com>
References: <20201223062720.29364-1-yi.l.liu@intel.com>
 <20201223062720.29364-4-yi.l.liu@intel.com>
 <176f7835-a5cf-e049-22b7-724636f74af0@linux.intel.com>
In-Reply-To: <176f7835-a5cf-e049-22b7-724636f74af0@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.46.36]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3c0d6584-33e4-4d29-e906-08d8a8ae694a
x-ms-traffictypediagnostic: DM5PR11MB1692:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB16925303AB4EA2B7426025D5C3DC0@DM5PR11MB1692.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a1kXYzbOOp423mAcs/9qDqFc5oGwrzzmqpWH2ji/IJGia3Px0U0mWXt7AuN/VP+b07Z2qB7w8YJRxjhL5Ix6vSYXBL6Gsbejg33Ezg4k6rwiRyQWy+ZQVakuuRYOaGPUnqDc3wJx9UUG8AFoaeofjDShBbgdgfsifluy2SadY1yfw0UzacnxJ/nqb3Pqj7K8d68ZwuhI+dgXGS6RL8tG51WJP3cCQ7lyJK6WBkWLAWrWoMczUtCOdjBii5A3c7REl0rDB7+YWC6FD3sMwwGeRIi04RqRFlclsB1tvtuP+KcLyXuccrvOIya3PxbjU7EBr2thfsu4dP5eZQal9y/a/56wK1pE1xD39A04jmcEQCr7xCc3pE5ORz5+Fhpb0uinMFjNLmZSj8VUiKGotDr3eSKdD+Dx3hjPfjAezTnDvzrfPuSqt8d9QYlcB0OGc+4+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(396003)(136003)(346002)(39860400002)(66446008)(64756008)(54906003)(86362001)(66476007)(7696005)(52536014)(66556008)(8676002)(186003)(6506007)(110136005)(55016002)(66946007)(53546011)(5660300002)(2906002)(8936002)(71200400001)(9686003)(316002)(33656002)(478600001)(83380400001)(76116006)(26005)(4326008)(309714004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?ZkVETGpnYjlwUUY1YWxnRy9WRzJ5S1ZsWjVDUjJ1eVdZQXFVV3l5ZDVMQWxL?=
 =?utf-8?B?TTlBeVgwTXVJR1pXS0tBYXVDZTVGZ3h1eUNCY3gxOU5yN0ZTYWszTUUzY1dy?=
 =?utf-8?B?V3pORGJWVzR5a3hvUENVZzFiVHpIL0ZJWU50ZThRRzhFd2kyaGV4V2oxdm5X?=
 =?utf-8?B?UDJ4NlhDOHJaRVZDU2FaOWwxb1NhUTMvQzdRRmFtNm5TeFZOTzN1cDFJWVRu?=
 =?utf-8?B?dlFETUhCeXpidHVzMmtRMmxXZWNJVS9kRTlMNU5uc2o4LzdiK2oyTGd3Nzly?=
 =?utf-8?B?VUpaU012cTcyRExsV05KOHZVSU5YaERYSWNLT0ZRdll3Q3NtaFI3UDkvV2Ix?=
 =?utf-8?B?QmRzS0wrbXk5UlF4NWt1Sm44QTIzd2pNTHZtZUc0R2k5TDlabVEzWTZna0hp?=
 =?utf-8?B?Ym8xd05zVmdEYjJwdmR4MitPVEJWVzZUbEQwNnVRYk50OTZaVlhYaVB0QnRp?=
 =?utf-8?B?U2NaMDd4UllFWVFZYWtQdWJyT0NBdHdyVWtxMWJZZUcrU2dJTVh1N1lGZStt?=
 =?utf-8?B?MWQ0U2dlQlNkLy9HTHU5ODdMdjZ0MGZFVFdoQlhuZEJEYTlTUEM4enhSaGtO?=
 =?utf-8?B?SitwYUhPdHVnVE8zN3ZKQzU3bWVMVDN5UWN2bFN2c0w1NUFDdFJoSVZ4UUtU?=
 =?utf-8?B?ZEFBN3B6OE5WRHQxUVF3WllaeUtKeXd0clRnODdOeDZrVE1tY2pkM0hqUGg3?=
 =?utf-8?B?cDdieW5BT2RDMHdLZ3k1bzBZUnVyRGt4UWM4YkdCMlVHM1UvT0RhZURlRzhr?=
 =?utf-8?B?ZnhRaG9OS2FZM1hFem5CVEtHK0JXYXBvaHRzR3lHZ0taZmwxbEJqU3d0V3N2?=
 =?utf-8?B?cnNkRE9XdGQ2dUlEb3I1eHR0UHVWUG5nTmlPK2FjVkNMck5Nak1YU2J0U3Yr?=
 =?utf-8?B?U3d5Yy84SHhwVThuVFluRjl1ejVVT0pUdUVTK1BmMHJCZjdSNFJTd1NUY3ZM?=
 =?utf-8?B?MTBPYWVUOU9VSHBlc2JORkZBRGZ6YllXQ09lQzlBdHJhanI3aDIwWDRQNE1B?=
 =?utf-8?B?MERlNVBPZHhHNGpGMllwdFZuQm4rV1FKdk1BL1BOb2EvRXVORk00eXM2WFlq?=
 =?utf-8?B?QlBGSDVnNUgwYUN4ZDdyTGxoOC9MU01hQXZrTGtwWDFxRnBJbkpSOUlqSmRm?=
 =?utf-8?B?S2tXdnlpc3Ixak9kdmpma1hYU25VQm9YMVJNeUh0NG1tVnZZajJxUFV3cjZV?=
 =?utf-8?B?TmtzL1gwckdPYUxNd3R4NU1MclJuejNmMXNUdS80UGE1RTUyZ3dmaGZGWlBJ?=
 =?utf-8?B?SExmZm5sdW00Vlc0ckdoM0pINDIyMnVGSmtzMFNFZW5OWE1WSXJPRmI5VEZC?=
 =?utf-8?Q?xChnGMGy2RNu0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c0d6584-33e4-4d29-e906-08d8a8ae694a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Dec 2020 08:23:51.3839
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KqmeJZhevu7Ev3udozEGkDKi4ODRcisyRlcmwPVgJnULJ7PkidoO26Zlmynz5DOGczpRCzhUKIi+EOTp05Yilg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1692
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQmFvbHUsDQoNCldlbGwgcmVjZWl2ZWQsIGFsbCBjb21tZW50cyBhY2NlcHRlZC4gdGhhbmtz
Lg0KDQpSZWdhcmRzLA0KWWkgTGl1DQoNCj4gRnJvbTogTHUgQmFvbHUgPGJhb2x1Lmx1QGxpbnV4
LmludGVsLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBEZWNlbWJlciAyMywgMjAyMCA2OjEwIFBN
DQo+IA0KPiBIaSBZaSwNCj4gDQo+IE9uIDIwMjAvMTIvMjMgMTQ6MjcsIExpdSBZaSBMIHdyb3Rl
Og0KPiA+IGlvbW11X2ZsdXNoX2Rldl9pb3RsYigpIGlzIGNhbGxlZCB0byBpbnZhbGlkYXRlIGNh
Y2hlcyBvbiBkZXZpY2UuIEl0IG9ubHkNCj4gPiBsb29wcyB0aGUgZGV2aWNlcyB3aGljaCBhcmUg
ZnVsbC1hdHRhY2hlZCB0byB0aGUgZG9tYWluLiBGb3Igc3ViLWRldmljZXMsDQo+ID4gdGhpcyBp
cyBpbmVmZmVjdGl2ZS4gVGhpcyByZXN1bHRzIGluIGludmFsaWQgY2FjaGluZyBlbnRyaWVzIGxl
ZnQgb24gdGhlDQo+ID4gZGV2aWNlLiBGaXggaXQgYnkgYWRkaW5nIGxvb3AgZm9yIHN1YmRldmlj
ZXMgYXMgd2VsbC4gQWxzbywgdGhlIGRvbWFpbi0+DQo+ID4gaGFzX2lvdGxiX2RldmljZSBuZWVk
cyB0byBiZSB1cGRhdGVkIHdoZW4gYXR0YWNoaW5nIHRvIHN1YmRldmljZXMuDQo+ID4NCj4gPiBG
aXhlczogNjdiOGUwMmI1ZTc2MSAoImlvbW11L3Z0LWQ6IEF1eC1kb21haW4gc3BlY2lmaWMgZG9t
YWluDQo+IGF0dGFjaC9kZXRhY2giKQ0KPiA+IFNpZ25lZC1vZmYtYnk6IExpdSBZaSBMIDx5aS5s
LmxpdUBpbnRlbC5jb20+DQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL2lvbW11L2ludGVsL2lvbW11
LmMgfCA2MyArKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0NCj4gLQ0KPiA+ICAg
MSBmaWxlIGNoYW5nZWQsIDQ3IGluc2VydGlvbnMoKyksIDE2IGRlbGV0aW9ucygtKQ0KPiA+DQo+
ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvaW50ZWwvaW9tbXUuYyBiL2RyaXZlcnMvaW9t
bXUvaW50ZWwvaW9tbXUuYw0KPiA+IGluZGV4IGFjZmUwYTViOTU1ZS4uZTk3YzVhYzFkN2ZjIDEw
MDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvaW9tbXUvaW50ZWwvaW9tbXUuYw0KPiA+ICsrKyBiL2Ry
aXZlcnMvaW9tbXUvaW50ZWwvaW9tbXUuYw0KPiA+IEBAIC03MjYsNiArNzI2LDggQEAgc3RhdGlj
IGludCBkb21haW5fdXBkYXRlX2RldmljZV9ub2RlKHN0cnVjdA0KPiBkbWFyX2RvbWFpbiAqZG9t
YWluKQ0KPiA+ICAgCXJldHVybiBuaWQ7DQo+ID4gICB9DQo+ID4NCj4gPiArc3RhdGljIHZvaWQg
ZG9tYWluX3VwZGF0ZV9pb3RsYihzdHJ1Y3QgZG1hcl9kb21haW4gKmRvbWFpbik7DQo+ID4gKw0K
PiA+ICAgLyogU29tZSBjYXBhYmlsaXRpZXMgbWF5IGJlIGRpZmZlcmVudCBhY3Jvc3MgaW9tbXVz
ICovDQo+ID4gICBzdGF0aWMgdm9pZCBkb21haW5fdXBkYXRlX2lvbW11X2NhcChzdHJ1Y3QgZG1h
cl9kb21haW4gKmRvbWFpbikNCj4gPiAgIHsNCj4gPiBAQCAtNzM5LDYgKzc0MSw4IEBAIHN0YXRp
YyB2b2lkIGRvbWFpbl91cGRhdGVfaW9tbXVfY2FwKHN0cnVjdA0KPiBkbWFyX2RvbWFpbiAqZG9t
YWluKQ0KPiA+ICAgCSAqLw0KPiA+ICAgCWlmIChkb21haW4tPm5pZCA9PSBOVU1BX05PX05PREUp
DQo+ID4gICAJCWRvbWFpbi0+bmlkID0gZG9tYWluX3VwZGF0ZV9kZXZpY2Vfbm9kZShkb21haW4p
Ow0KPiA+ICsNCj4gPiArCWRvbWFpbl91cGRhdGVfaW90bGIoZG9tYWluKTsNCj4gPiAgIH0NCj4g
Pg0KPiA+ICAgc3RydWN0IGNvbnRleHRfZW50cnkgKmlvbW11X2NvbnRleHRfYWRkcihzdHJ1Y3Qg
aW50ZWxfaW9tbXUgKmlvbW11LA0KPiB1OCBidXMsDQo+ID4gQEAgLTE0NTksNiArMTQ2MywxOCBA
QCBpb21tdV9zdXBwb3J0X2Rldl9pb3RsYiAoc3RydWN0IGRtYXJfZG9tYWluDQo+ICpkb21haW4s
IHN0cnVjdCBpbnRlbF9pb21tdSAqaW9tbXUsDQo+ID4gICAJcmV0dXJuIE5VTEw7DQo+ID4gICB9
DQo+ID4NCj4gPiArc3RhdGljIGJvb2wgZGV2X2lvdGxiX2VuYWJsZWQoc3RydWN0IGRldmljZV9k
b21haW5faW5mbyAqaW5mbykNCj4gPiArew0KPiA+ICsJc3RydWN0IHBjaV9kZXYgKnBkZXY7DQo+
ID4gKw0KPiA+ICsJaWYgKCFpbmZvLT5kZXYgfHwgIWRldl9pc19wY2koaW5mby0+ZGV2KSkNCj4g
PiArCQlyZXR1cm4gZmFsc2U7DQo+ID4gKw0KPiA+ICsJcGRldiA9IHRvX3BjaV9kZXYoaW5mby0+
ZGV2KTsNCj4gPiArDQo+ID4gKwlyZXR1cm4gISFwZGV2LT5hdHNfZW5hYmxlZDsNCj4gPiArfQ0K
PiANCj4gSSBrbm93IHRoaXMgaXMganVzdCBzZXBhcmF0ZWQgZnJvbSBiZWxvdyBmdW5jdGlvbi4g
QnV0IGlzbid0ICIoaW5mbyAmJg0KPiBpbmZvLT5hdHNfZW5hYmxlZCkiIGlzIGVub3VnaD8NCj4g
DQo+ID4gKw0KPiA+ICAgc3RhdGljIHZvaWQgZG9tYWluX3VwZGF0ZV9pb3RsYihzdHJ1Y3QgZG1h
cl9kb21haW4gKmRvbWFpbikNCj4gPiAgIHsNCj4gPiAgIAlzdHJ1Y3QgZGV2aWNlX2RvbWFpbl9p
bmZvICppbmZvOw0KPiA+IEBAIC0xNDY2LDE3ICsxNDgyLDIwIEBAIHN0YXRpYyB2b2lkIGRvbWFp
bl91cGRhdGVfaW90bGIoc3RydWN0DQo+IGRtYXJfZG9tYWluICpkb21haW4pDQo+ID4NCj4gPiAg
IAlhc3NlcnRfc3Bpbl9sb2NrZWQoJmRldmljZV9kb21haW5fbG9jayk7DQo+ID4NCj4gPiAtCWxp
c3RfZm9yX2VhY2hfZW50cnkoaW5mbywgJmRvbWFpbi0+ZGV2aWNlcywgbGluaykgew0KPiA+IC0J
CXN0cnVjdCBwY2lfZGV2ICpwZGV2Ow0KPiA+IC0NCj4gPiAtCQlpZiAoIWluZm8tPmRldiB8fCAh
ZGV2X2lzX3BjaShpbmZvLT5kZXYpKQ0KPiA+IC0JCQljb250aW51ZTsNCj4gPiAtDQo+ID4gLQkJ
cGRldiA9IHRvX3BjaV9kZXYoaW5mby0+ZGV2KTsNCj4gPiAtCQlpZiAocGRldi0+YXRzX2VuYWJs
ZWQpIHsNCj4gPiArCWxpc3RfZm9yX2VhY2hfZW50cnkoaW5mbywgJmRvbWFpbi0+ZGV2aWNlcywg
bGluaykNCj4gPiArCQlpZiAoZGV2X2lvdGxiX2VuYWJsZWQoaW5mbykpIHsNCj4gPiAgIAkJCWhh
c19pb3RsYl9kZXZpY2UgPSB0cnVlOw0KPiA+ICAgCQkJYnJlYWs7DQo+ID4gICAJCX0NCj4gPiAr
DQo+ID4gKwlpZiAoIWhhc19pb3RsYl9kZXZpY2UpIHsNCj4gPiArCQlzdHJ1Y3Qgc3ViZGV2X2Rv
bWFpbl9pbmZvICpzaW5mbzsNCj4gPiArDQo+ID4gKwkJbGlzdF9mb3JfZWFjaF9lbnRyeShzaW5m
bywgJmRvbWFpbi0+c3ViZGV2aWNlcywgbGlua19kb21haW4pDQo+ID4gKwkJCWlmIChkZXZfaW90
bGJfZW5hYmxlZChnZXRfZG9tYWluX2luZm8oc2luZm8tPnBkZXYpKSkNCj4gew0KPiANCj4gUGxl
YXNlIG1ha2UgdGhlIGNvZGUgZWFzaWVyIGZvciByZWFkaW5nIGJ5Og0KPiANCj4gCQkJaW5mbyA9
IGdldF9kb21haW5faW5mbyhzaW5mby0+cGRldik7DQo+IAkJCWlmIChkZXZfaW90bGJfZW5hYmxl
ZChpbmZvKSkNCj4gCQkJCS4uLi4NCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gYmFvbHUNCj4gDQo+
ID4gKwkJCQloYXNfaW90bGJfZGV2aWNlID0gdHJ1ZTsNCj4gPiArCQkJCWJyZWFrOw0KPiA+ICsJ
CQl9DQo+ID4gICAJfQ0KPiA+DQo+ID4gICAJZG9tYWluLT5oYXNfaW90bGJfZGV2aWNlID0gaGFz
X2lvdGxiX2RldmljZTsNCj4gPiBAQCAtMTU1NywyNSArMTU3NiwzNyBAQCBzdGF0aWMgdm9pZCBp
b21tdV9kaXNhYmxlX2Rldl9pb3RsYihzdHJ1Y3QNCj4gZGV2aWNlX2RvbWFpbl9pbmZvICppbmZv
KQ0KPiA+ICAgI2VuZGlmDQo+ID4gICB9DQo+ID4NCj4gPiArc3RhdGljIHZvaWQgX19pb21tdV9m
bHVzaF9kZXZfaW90bGIoc3RydWN0IGRldmljZV9kb21haW5faW5mbyAqaW5mbywNCj4gPiArCQkJ
CSAgICB1NjQgYWRkciwgdW5zaWduZWQgaW50IG1hc2spDQo+ID4gK3sNCj4gPiArCXUxNiBzaWQs
IHFkZXA7DQo+ID4gKw0KPiA+ICsJaWYgKCFpbmZvIHx8ICFpbmZvLT5hdHNfZW5hYmxlZCkNCj4g
PiArCQlyZXR1cm47DQo+ID4gKw0KPiA+ICsJc2lkID0gaW5mby0+YnVzIDw8IDggfCBpbmZvLT5k
ZXZmbjsNCj4gPiArCXFkZXAgPSBpbmZvLT5hdHNfcWRlcDsNCj4gPiArCXFpX2ZsdXNoX2Rldl9p
b3RsYihpbmZvLT5pb21tdSwgc2lkLCBpbmZvLT5wZnNpZCwNCj4gPiArCQkJICAgcWRlcCwgYWRk
ciwgbWFzayk7DQo+ID4gK30NCj4gPiArDQo+ID4gICBzdGF0aWMgdm9pZCBpb21tdV9mbHVzaF9k
ZXZfaW90bGIoc3RydWN0IGRtYXJfZG9tYWluICpkb21haW4sDQo+ID4gICAJCQkJICB1NjQgYWRk
ciwgdW5zaWduZWQgbWFzaykNCj4gPiAgIHsNCj4gPiAtCXUxNiBzaWQsIHFkZXA7DQo+ID4gICAJ
dW5zaWduZWQgbG9uZyBmbGFnczsNCj4gPiAgIAlzdHJ1Y3QgZGV2aWNlX2RvbWFpbl9pbmZvICpp
bmZvOw0KPiA+ICsJc3RydWN0IHN1YmRldl9kb21haW5faW5mbyAqc2luZm87DQo+ID4NCj4gPiAg
IAlpZiAoIWRvbWFpbi0+aGFzX2lvdGxiX2RldmljZSkNCj4gPiAgIAkJcmV0dXJuOw0KPiA+DQo+
ID4gICAJc3Bpbl9sb2NrX2lycXNhdmUoJmRldmljZV9kb21haW5fbG9jaywgZmxhZ3MpOw0KPiA+
IC0JbGlzdF9mb3JfZWFjaF9lbnRyeShpbmZvLCAmZG9tYWluLT5kZXZpY2VzLCBsaW5rKSB7DQo+
ID4gLQkJaWYgKCFpbmZvLT5hdHNfZW5hYmxlZCkNCj4gPiAtCQkJY29udGludWU7DQo+ID4gKwls
aXN0X2Zvcl9lYWNoX2VudHJ5KGluZm8sICZkb21haW4tPmRldmljZXMsIGxpbmspDQo+ID4gKwkJ
X19pb21tdV9mbHVzaF9kZXZfaW90bGIoaW5mbywgYWRkciwgbWFzayk7DQo+ID4NCj4gPiAtCQlz
aWQgPSBpbmZvLT5idXMgPDwgOCB8IGluZm8tPmRldmZuOw0KPiA+IC0JCXFkZXAgPSBpbmZvLT5h
dHNfcWRlcDsNCj4gPiAtCQlxaV9mbHVzaF9kZXZfaW90bGIoaW5mby0+aW9tbXUsIHNpZCwgaW5m
by0+cGZzaWQsDQo+ID4gLQkJCQlxZGVwLCBhZGRyLCBtYXNrKTsNCj4gPiArCWxpc3RfZm9yX2Vh
Y2hfZW50cnkoc2luZm8sICZkb21haW4tPnN1YmRldmljZXMsIGxpbmtfZG9tYWluKSB7DQo+ID4g
KwkJX19pb21tdV9mbHVzaF9kZXZfaW90bGIoZ2V0X2RvbWFpbl9pbmZvKHNpbmZvLT5wZGV2KSwN
Cj4gPiArCQkJCQlhZGRyLCBtYXNrKTsNCj4gPiAgIAl9DQo+ID4gICAJc3Bpbl91bmxvY2tfaXJx
cmVzdG9yZSgmZGV2aWNlX2RvbWFpbl9sb2NrLCBmbGFncyk7DQo+ID4gICB9DQo+ID4NCg==

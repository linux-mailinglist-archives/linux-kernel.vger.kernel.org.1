Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77F832C2118
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 10:25:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731160AbgKXJZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 04:25:10 -0500
Received: from mail-mw2nam12on2088.outbound.protection.outlook.com ([40.107.244.88]:33344
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730978AbgKXJZJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 04:25:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nRvyW0Bj3qqQactMbo5wZLIXWd+f3RFJNOIQO0B/rmQUyQ7EnMg91H3AQJ+iqx4vNv13y3XGBZU+SLcWm2njtS687zgbYdkjIh0PwKCobWEQKkIuhP1lPeTeTW+GOTpbbt3PP5rJGyC63RfymDIIbeR/ucy5sG6COXx276b7pMo6eoWdidrgJr3OPf74bJseg+lY81DZlbPq3Vnmq8bia9nCJ1LQqhKDO7vb3WKPYLOufXZg6cXpU299trnxeNkNHdvd/2dBYOj3rq22EQeFeZXBcxBJ6BXfH+hURNXcCpEn69xIOwMaYltx1ZrQkwMogW4v0NCtz+zhB10n4fjoMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fECDOE9WVaWnaSkgKEr0epnRuxdnMmt7Uaoip8210pA=;
 b=Su5NMCDfBnbcC3n2Ju1wqX4Sq/vfbxSDBktna0CsW8UkYq0OGt5OMuS3F+XCc8w1PTgpjeaRPDOEWFt1YwDLja0PB8sWdEoVdSHcea/D2+UV/22L+L9sq6HCCiGPGXSVv6mO2huhImS51kmi+mEwevM94EcWu6LaqBk+PycJV7TLEyr6HFJ7lNm23OcJ0p2Ow4/AUxyvLiUyPCIQNAeTb23k/YgoC+uHaD9k0/L15hM11BRvAXaI+vTi4yiux9zEo9y7uvi+sRaW5XCoCldytI1tHl1Nta19riF8A336bSzhfL4KXMp3/BEKypuo1Bo9H/eoVofCS/ImLkmGUjkyNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fECDOE9WVaWnaSkgKEr0epnRuxdnMmt7Uaoip8210pA=;
 b=3qQF9eQ+R8Ct8NKEGdox9Z/TQfX9hwTRUtsgoe2nf2C2Fr9IQV4yJxdUh18BbX88gxCSttgFmiWvBz8ISNL6Wg4dl3qKs+BX7AfHXiyWxDQMwmt03t1IcY2WiVgkJ+DhHYtASrPVguj2ZFFGv1j5iGDGULq97GVb0cElULF4vkI=
Received: from SN6PR12MB2767.namprd12.prod.outlook.com (2603:10b6:805:75::23)
 by SN1PR12MB2542.namprd12.prod.outlook.com (2603:10b6:802:26::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.30; Tue, 24 Nov
 2020 09:25:06 +0000
Received: from SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::d8f2:fde4:5e1d:afec]) by SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::d8f2:fde4:5e1d:afec%3]) with mapi id 15.20.3541.025; Tue, 24 Nov 2020
 09:25:06 +0000
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
Thread-Index: AQHWvrzaxkxw3OuD2kOZmqVqDk7+x6nV+JOAgAAN5wCAAFPQgIAAqeCAgAAFwPM=
Date:   Tue, 24 Nov 2020 09:25:06 +0000
Message-ID: <EF13C80C-42DC-4B51-8AF8-2C1D3859B490@amd.com>
References: <20201119214205.11062-1-Ashish.Kalra@amd.com>
 <20201123170647.GE15044@zn.tnic> <20201123175632.GA21539@char.us.oracle.com>
 <20201123225631.GA16055@ashkalra_ubuntu_server>,<20201124090431.GC4009@zn.tnic>
In-Reply-To: <20201124090431.GC4009@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [136.49.12.8]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 54db38f4-5272-49af-992a-08d8905ad4a4
x-ms-traffictypediagnostic: SN1PR12MB2542:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN1PR12MB2542921DF8EC51E11FADD7B38EFB0@SN1PR12MB2542.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y8UvaaVMoWaaJCd5E97k7OGHRovKCZJOv9CP03DoI7P3sCE4pXL3le5sGil2KZI1/MPrmnkXxYVT5+JAbvyHQEGAfEU1/knEWA0sWHiUAFrbG2uAPVKAsnJgy+OUHRqta6yXsGhpgQd9/IiRAsytAXEhP+S7WZ/G8VbZ4TF90zg25HzNLqCJfRtZXXtWz7nKNDrvMKasDG7Mh7AvmqEzTBKlG2VqkXU6YFl3N1c00Cr2zsHXgb3466uwVKpw8VeaSrEpOS7sdHa0oMRU5mzk1I9fPhEV7dwyAClA5uR8Qsk0V5lp26elvp6nponNqp1do5K4ZIAvtACHN3y39SSPLZkfy8AA99CQRIoA1Y4gLdWziEigYwnWG3LZ7YPIEogbrhpnhCcZPyjsc3nT+sJe7g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2767.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(376002)(396003)(366004)(346002)(478600001)(64756008)(5660300002)(7416002)(6916009)(91956017)(45080400002)(76116006)(66556008)(966005)(66946007)(4326008)(66446008)(66476007)(316002)(54906003)(2906002)(8676002)(86362001)(53546011)(26005)(6512007)(36756003)(6486002)(6506007)(71200400001)(2616005)(186003)(33656002)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 8i2D/iHfen/0KAey27UuY3/DDRJ4TW1R2lboUQM6cPbA2r+Ou3zaS0q/VAstV9hjv33peOlXk/1lM6AhHxIAAemHMvo5mAKNjFy5096/n6KFFZCfQS/fGnbQuHQy8cErIobEdLoa8ujIScpwgCN8EJmxP5/7/YQu/8BE3bj0EUhASZoOrv20FjxJTycGjs4dML32oVIiRnFlCag1LqiAd+4FGtfF2n8K2gdVBh8KXDm3X9T1/Z2l1TxKsYjH6FuAysEb9NeQHNPG2+m5BO1bf1bQHAXOPvsellKbB7HWnmSlOwk0v3v3OL+Knthi+WuzRo3X21+xYcoOLySqfQgQtLOWgHnIQEyOJ7gWg9KFxNMrExf6L/Zh9MdkNGUMcMkYB/NY4fI1IHVntQKgVB4NFPalh8JujVc3Ju+bn77ecZulkQCEy+HDIHxloJ/AJRFWLPVZp49wdk0b+E7v5JES2f6oS6YBiYcble++dL3D0HfL0V3J3jL4iWiq5wqLF/KRUx1RqfsPSoQ/1rgxCb0cwoTmLAIHarBNh2wakh8J/855vNdB1vVVgLYjIU/iFVfz+fV1cq5JA7PwisthQ17PSxIM+Cs9Ox5M7Uh33Y0m71epEtxZ+Au/8egODqewW01VZpb0H2RFClh/j0BSxv8IGEZarqIdoz2nTwCruucKSVFViblFvW4BRTQBqL5XsXlfXkaDzFLW/LtE/tBoCeifri34SitVoJ4WlJ3G6XS4ZXb9Yq2EqudUyAF6eLpECIC/S56/q5aEubVji9Cs5kwBgQe203JgSPRbrtba2AOntRKcOSQvZG+s1poeZhWvNlBCD6jGLCmgqmhowJjAf6n1jnylCTFsJPIuN2schReQLAVRwZgY/vanNfL7RydHtHng
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54db38f4-5272-49af-992a-08d8905ad4a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2020 09:25:06.0819
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t7VzYFQ+DKvY+qQwk7XsDfH9o0rY1yBiAvfvObb5dxGaT8gaZJKYv8Z/q6j9VfCZ6IjlyO0kjXfEeBlzjItjvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2542
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gTm92IDI0LCAyMDIwLCBhdCAzOjA0IEFNLCBCb3Jpc2xhdiBQZXRrb3YgPGJwQGFs
aWVuOC5kZT4gd3JvdGU6DQo+IA0KPiDvu79PbiBNb24sIE5vdiAyMywgMjAyMCBhdCAxMDo1Njoz
MVBNICswMDAwLCBBc2hpc2ggS2FscmEgd3JvdGU6DQo+PiBBcyBpIG1lbnRpb25lZCBlYXJsaWVy
LCB0aGUgcGF0Y2ggd2FzIGluaXRpYWxseSBiYXNlZCBvbiB1c2luZyBhICUgb2YNCj4+IGd1ZXN0
IG1lbW9yeSwNCj4gDQo+IENhbiB5b3UgZmlndXJlIG91dCBob3cgbXVjaCB0aGUgZ3Vlc3QgbWVt
b3J5IGlzIGFuZCB0aGVuIGFsbG9jYXRlIGENCj4gcGVyY2VudGFnZT8NCg0KQnV0IHdoYXQgd2ls
bCBiZSB0aGUgY3JpdGVyaWEgdG8gZmlndXJlIG91dCB0aGlzIHBlcmNlbnRhZ2U/DQoNCkFzIEkg
bWVudGlvbmVkIGVhcmxpZXIsIHRoaXMgY2FuIGJlIG1hZGUgYXMgY29tcGxpY2F0ZWQgYXMgcG9z
c2libGUgYnkgYWRkaW5nIGFsbCBraW5kIG9mIGhldXJpc3RpY3MgYnV0IHdpdGhvdXQgYW55IHBy
ZWRpY3RhYmxlIHBlcmZvcm1hbmNlIGdhaW4uDQoNCk9yIGl0IGNhbiBiZSBrZXB0IHNpbXBsZSBi
eSB1c2luZyBhIHN0YXRpYyBwZXJjZW50YWdlIHZhbHVlLg0KDQpUaGFua3MsDQpBc2hpc2gNCg0K
PiAtLSANCj4gUmVnYXJkcy9HcnVzcywNCj4gICAgQm9yaXMuDQo+IA0KPiBodHRwczovL25hbTEx
LnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZwZW9w
bGUua2VybmVsLm9yZyUyRnRnbHglMkZub3Rlcy1hYm91dC1uZXRpcXVldHRlJmFtcDtkYXRhPTA0
JTdDMDElN0Nhc2hpc2gua2FscmElNDBhbWQuY29tJTdDMDc2NjQyMmJjZWU2NGQyZWI1NzIwOGQ4
OTA1N2Y2MjAlN0MzZGQ4OTYxZmU0ODg0ZTYwOGUxMWE4MmQ5OTRlMTgzZCU3QzAlN0MwJTdDNjM3
NDE4MDU0Nzk3OTUwNjk0JTdDVW5rbm93biU3Q1RXRnBiR1pzYjNkOGV5SldJam9pTUM0d0xqQXdN
REFpTENKUUlqb2lWMmx1TXpJaUxDSkJUaUk2SWsxaGFXd2lMQ0pYVkNJNk1uMCUzRCU3QzEwMDAm
YW1wO3NkYXRhPSUyRkVGdVJHT01PdTRCWlVrUE9kOXJ4YW0lMkJCQTNuWGo0dGRSRkZqM25RNDdV
JTNEJmFtcDtyZXNlcnZlZD0wDQo=

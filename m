Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 331B22F5BF7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 09:07:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbhANIEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 03:04:38 -0500
Received: from mail-bn7nam10on2063.outbound.protection.outlook.com ([40.107.92.63]:46458
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725989AbhANIEh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 03:04:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WKRi8eM8/e7SyNg/e/fJ6dq66Eo9m16O0ZUzgUB0HT9Gxp9PATNZgJ5xgyRjXDriAbwoMbks4T58ZFrYqHn7dMJP3i9lua3O3kMWYSQqb8bVNM/9sj6v52zJ2tRTWR6GfDdxUEUEOFx1VNLxu40gYt5pwcEMjxoHdIw4uHoyjlNm6C54q0l3cET/xqze5NlsYlK1IEwwZPq9zGadFoCVXud1rbK6TygaC9FzAJFj7DoBdyacs+YHYwmE89NJdPq1qu01L41kfkEYs26BcBXZazys55wgaGjaPQaAhpEU+F+4BvpwldFrn6kOmTK8H/L2qQUUQOI5Dl+huZGADFvIiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O9SDqM4cotKSibC4ruYGH1IL/pK4Yg6IQhsyH1TL+2c=;
 b=DEbPWOPPDJ8TjZMPzxWKb/VmdYP5NBHnMnipk1F4+dDVwmRMm64Qh7WjBtELzOFAkoz5Y+g2J7BsJ7jCZ2REGT0DcXC/KDJoHhBf1Ni+kppXZB89Q+cgLgWGvorXsf9tfAQsISzTLmBwFya6AH150Gy8uw8+EdwAMDXznDVTbNDCvmJx5725f1rch6EWn4tJSr5jrMST00bTwxAuf6oYyvEVGKm5L/MZNY3eO4OOOHOA6pqYpkNttaIQljRheojWu4dYtFh59KXyzrQkoVoKEMyrp/2DwSoj0GgK/0EoGvtkvCO/5ebIn9hOx/ER94kCXOm20rdxN22zHgzFMP+j+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O9SDqM4cotKSibC4ruYGH1IL/pK4Yg6IQhsyH1TL+2c=;
 b=n5rEqqADcwu9Aj5d3Zm++xgV07Cpr0XJpK5uN0BLVOrWim4huRuh8i9D6QVs9Gzp0d447yDvP0dIy4XIbk5COGmXf3zNRYXcyS0rpkt9hOe9QVpGIrXsRMYmbYZpgkmO6aOgZBTzdhfbPyzeC+IDVFL+awWZgnFaZDebRHmqQJ4=
Received: from BYAPR11MB2632.namprd11.prod.outlook.com (2603:10b6:a02:c4::17)
 by BY5PR11MB4307.namprd11.prod.outlook.com (2603:10b6:a03:1bd::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Thu, 14 Jan
 2021 08:03:24 +0000
Received: from BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::94a4:4e15:ab64:5006]) by BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::94a4:4e15:ab64:5006%5]) with mapi id 15.20.3742.012; Thu, 14 Jan 2021
 08:03:23 +0000
From:   "Zhang, Qiang" <Qiang.Zhang@windriver.com>
To:     "peterz@infradead.org" <peterz@infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Question on   workqueue: Manually break affinity on hotplug
Thread-Topic: Question on   workqueue: Manually break affinity on hotplug
Thread-Index: AQHW6kaGanHzOLWWlkGf08xC7Dod6w==
Date:   Thu, 14 Jan 2021 08:03:23 +0000
Message-ID: <BYAPR11MB2632FC41FF64133708F4537FFFA80@BYAPR11MB2632.namprd11.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none
 header.from=windriver.com;
x-originating-ip: [60.247.85.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9d6e0380-b8f7-4ee8-e855-08d8b862ddbe
x-ms-traffictypediagnostic: BY5PR11MB4307:
x-microsoft-antispam-prvs: <BY5PR11MB4307482AD76332206521FF9CFFA80@BY5PR11MB4307.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /m7YlMI7ScvtMH2qaXfOU7Ae7lqPVY9qPDjqQE5F7v/0Fn0OKFohioxVbI+eR1noLG27R00DTPEkFbKsekWJno6Eb8dTo28bZuVUrm4iQcSjNFnXUemnRCROVYGLgEFNhKOCPdmrsXaRJV2MaGLF6WbegTwU7h4bj04n0M4KjoIYNIrFYNoWcoqji1wS6BdFzMvCK63hJ/1UjvKEVETJjbC0G3QzLN4UgkQpDaTGQonydbfn9fmzXQpZ1ZC8G9tJFsAaT0v28jFKio9oPlQdh/qM75kCdIsfFPL577Qr03xSCjs2oSCv9mlX1xEUUuMusowlFoEqdt1keHPERdzrblODJEhjy+TDgrnebu11Kaa/iukpLq2hEpYUhl3uDN0ID/JvvQlM6lzddtAvgN7N6w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2632.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39850400004)(346002)(396003)(136003)(376002)(6916009)(316002)(6506007)(66446008)(52536014)(66476007)(26005)(478600001)(8936002)(186003)(33656002)(7696005)(9686003)(2906002)(66556008)(71200400001)(55016002)(4326008)(64756008)(4744005)(91956017)(5660300002)(8676002)(76116006)(86362001)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?gb2312?B?MkFkNEUrWHJJa1FySkVtQjlaWVdIS2YzblBRTkJ4R1lxRXN4R0dpNDV1bTBH?=
 =?gb2312?B?a3hqeEwrZHBPTjNIT2p2ODFLSW55V09SREY2cmFLUE1ycEk3QzF3d0VYQzQ3?=
 =?gb2312?B?NGwwNVNURkdSaDN6bXg2M08yTldadGxKbnNRVEh1VVF4YUE1Z2xYQmx0VnlE?=
 =?gb2312?B?bkIycW9kSGhXTEJEeEtaR3M0cS9JK2ZmQU5NckN1RHFFeW13dnd6SDNHRDkz?=
 =?gb2312?B?bTNYTTFlNUFUb3FUNkRNemp6bTkwR3gyRURKNlIzU3djMTJ1cUIyam5mK1Vj?=
 =?gb2312?B?T29xWkRqdlRFNjluVE9IVG9BWTBiYWdja2pONHRVVUZxTmVnWVppZzJMUG11?=
 =?gb2312?B?Z2w2eExtdXB2RUVoejBmdEFzcDlUOUVkeUZYaFJXOC9zMzN0dWthZW9qN3hk?=
 =?gb2312?B?VFRoMi9LMUt5dEc0cFltcGZ2NFRQR1BQb0Y4bHoxdG5weGJrajhmRDNXOGQ0?=
 =?gb2312?B?V3hOczZIckNTMy94TXpIekw4bnkvL0ZSZmkzNU5sbWUva25jbTE0SFFxK21K?=
 =?gb2312?B?TUk3aE1xZTB0dGhRSlVRQ1NtZkVSRkpjdG03VE1WM2VVRnFZMkZkMDYvNVBN?=
 =?gb2312?B?TXhmL2RzWnBsZ2w0SldWREJEc2gwYU9vdjYvdFJUL0Znelc2K2IvRU83K2JU?=
 =?gb2312?B?OEdWRlhKRThNRWVlQkpuc2N3bS9qVjM4bGU4eXNjQWZSWStGdXFJYXQxcVQ5?=
 =?gb2312?B?OTJyN1lqR0pnQmNXYldDcnMwVkx4ME4yM2RFVFEvOTVZNkZXM1JhR1Z0RWJu?=
 =?gb2312?B?ZVMwUFN4Q3l6YUNWSGVKajQ5Z1VjY3Q0UlVlaVdRMUNSWjB0Q0ZzY3cvbDdt?=
 =?gb2312?B?NEpvcHFRYVJkK2Q0MkJvWnV6bmR6ZTFHdzdpTjlDVzkvSk1kdWhzalBOMC90?=
 =?gb2312?B?bFJZaGoxVUU5M2VnUDZJcitVeDByblhyWjNlZTRSU3lVY21QZm84Z3duR0Uy?=
 =?gb2312?B?N2Fjakg0TGlpRFN4azlLaHMxblNZbXA1VHc4bEliK3Z4cExYTWNNc3JIcjVE?=
 =?gb2312?B?VkUvR1FXZUtnQk9lOHgwYVpyd2NLTHp0VDI3TzI5ZHpjQkx2NFBDNWtyRmVW?=
 =?gb2312?B?UkJSWGdtUlZnbXVuWHZxTlBRbzBLK2VXK05obk1iaDFZbXNFMjRHZjBMWDlh?=
 =?gb2312?B?ZUxsNnRtNTg3UHRLSnVsbEh0R0FYTjBWd2VHa0RNMlgrTmJLZGtrejlWZTJo?=
 =?gb2312?B?N0Y2NWhhYjJyWllEaDE2b2JBam9xS210TmtXTWk0T3hEbGlGZWZLVVlQZ21B?=
 =?gb2312?B?Uy9tQk9mSnpJbE5xSythcHFiNGRBRWh6TlByOHdySFVtSEdoS2ZvanFoMmN4?=
 =?gb2312?Q?MFV9NCEyDhywY=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2632.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d6e0380-b8f7-4ee8-e855-08d8b862ddbe
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2021 08:03:23.7897
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QgP0La5Ngx2wUAcZqedL+95LTlyGp/XY57mhnrz4NjiE7CRugNtKqFyc0dCFtYRROjrnotEluABcGIQ0F3QUIUZ1wFSK/PuYRZAVpA0xsMA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4307
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gUGV0ZXIKCkV4Y3VzZSBtZSwgSSBoYXZlIHNvbWUgcXVlc3Rpb25zIGZvciB5b3UsIGFi
b3V0IGEgZGVzY3JpcHRpb24gb2YgdGhpcyBjaGFuZ2U6CgonJ0Rvbid0IHJlbHkgb24gdGhlIHNj
aGVkdWxlciB0byBmb3JjZSBicmVhayBhZmZpbml0eSBmb3IgdXMgLS0gaXQgd2lsbApzdG9wIGRv
aW5nIHRoYXQgZm9yIHBlci1jcHUta3RocmVhZHMuIgoKdGhpcyBtZWFuIHdoZW4gY3B1aG90cGx1
Zywgc2NoZWR1bGVyIGRvIG5vdCAgY2hhbmdlICBhZmZpbml0eSBmb3IgcGVyLWNwdS1rdGhyZWFk
J3MgdGFzaywgaWYgd2Ugbm90IGFjdGl2ZSBzZXR0aW5nIGFmZmluaXR5PwpidXQgaWYgcGVyLWNw
dS1rdGhyZWFkJ3MgdGFzayBpcyBub3QgcnVuIHN0YXRlLCB3aGVuIHdha2UgdXAsICB3aWxsIHJl
c2V0IGl0J3MgYWZmaW5pdHksIHRoaXMgIGlzIGRvbmUgYXV0b21hdGljYWxseS4KCm9yIGlzIGl0
LCAgdGhpcyBwbGFjZSBtb2RpZmllZCB0byBmaXQgdGhlIG5ldyBvbmUgaG90cGx1ZyBtZWNoYW5p
c20gd2hpY2gKKCJzY2hlZC9ob3RwbHVnOiBDb25zb2xpZGF0ZSB0YXNrIG1pZ3JhdGlvbiBvbiBD
UFUgdW5wbHVnIik/CgpUaGFua3MKUWlhbmcKCiAKCiAKCgo=

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19F132CE476
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 01:32:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728178AbgLDAbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 19:31:42 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:37596 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727077AbgLDAbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 19:31:41 -0500
Received: from mailhost.synopsys.com (badc-mailhost2.synopsys.com [10.192.0.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 185A640E76;
        Fri,  4 Dec 2020 00:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1607041841; bh=ToyLqeIeaJ349UAuujsUeiScQI3/ci2tBZErTh7ZynU=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=XYzm0gqNU1Bp/SXt88c4guTsjbSwqeYRGFLBt+H9EsK5Dq8V8JpPHpUFPyQV2xMaM
         AKjQtB98RdLXVomSKVf2S9w78NInnAhyzVv63fXX46mLO3NqjrPtJPYOyGl9BC5WkJ
         JfRFZFlIBZED8S2k7BF4/H2bDx3nMVS+uNnTLD2w28jAjWXd/qpX0nDJt4yVO6BBr+
         rY7cmfMON3cubCITlGAfir2N6owEYyV9sodrKewH/SdYzYAnH3SMnHsMyY1+kMxyiL
         fyWSCCggGrksAJ3H3ZzOgKSeuItejWtcp2oKyR3vbs8iedpEDxzfPAqxj+uuozzv6l
         k7mTsaWcNhmjQ==
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 7BAEDA0067;
        Fri,  4 Dec 2020 00:30:37 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2043.outbound.protection.outlook.com [104.47.74.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "GlobalSign Organization Validation CA - SHA256 - G3" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id D579080214;
        Fri,  4 Dec 2020 00:30:34 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=vgupta@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="mqDQAXwE";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IlF9Oc78PBOSF0EmumyB8nxnrfA8yjVkVt+17Nv0vgN3l9/+SomMDWelypeUX1knBfNgqzfyneLFg1bLLciS5oHdER2Io6RKCwJ5WbKnIRrBSzU2OPw28j8LxWqh5nn+ldoftfrFrFvy7OiUZQI9u6nPf0fCrwfGzVtx6Hn3wIobfpCcKtL/phMjFLLvfi86q9XDJNts1cycT4rr3jMllqY3wFlOtDt5w7f2QmJKmUVrkSWANME7JSFnO+pIw7I/08V+FTgxz0t7sR1Qo0HtDNpy6Z+pdxQzULZjw1whtTTqhUwyaAS71fbb79WDLRPM1OPHsZRKdh0Q5N6hUmEmUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ToyLqeIeaJ349UAuujsUeiScQI3/ci2tBZErTh7ZynU=;
 b=f+QRQQKaMjq+TdtoFzldDCtauNrV+wOuc4j3gEm1LLhSFuIxglBe++7PcGyl4vuZ2+wyA6H5SfUGlYEO3INdd8yuCN7ck/PWFdi9qGEGfQ4iOl5PXLofFFkWkVk48qUbl9lXxlaNSSxGqYw1rzO1YBWPGa37Fqs84cjAr9RA25hUtoC9uT6hTdQgp2zM8AzhIbHnI4oKPszWZAvldMv6Ot6TJLEcQLRb3GNXQMcJDWU5MSqxBxFmW+mQgT8SnWQBnZ/nvwosFHjJKLU/Q869UALTSGRCdHFTYn77eknac2VT1+J2it+9iA/dTb5+7G9RSAP6jgViKIMbz5P4uPcG/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ToyLqeIeaJ349UAuujsUeiScQI3/ci2tBZErTh7ZynU=;
 b=mqDQAXwEHGYbxVcLV0nxVlyQF4MB6hK5RvOsWlm80pDZIHECyaGAD/UfR/xWKfOWRVjpevDoABgJtVew1Kvam9P6Yn0j+mx4POFJ25tNG9eLoyGrmwq/mVPOyBCx4eU1lr7lIlXWYdvERWJn8fIlxqJvy8oqRDKZWbsrA1GP6j4=
Received: from BYAPR12MB3479.namprd12.prod.outlook.com (2603:10b6:a03:dc::26)
 by BYAPR12MB3254.namprd12.prod.outlook.com (2603:10b6:a03:137::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.19; Fri, 4 Dec
 2020 00:30:32 +0000
Received: from BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::c562:e026:68d6:cd31]) by BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::c562:e026:68d6:cd31%6]) with mapi id 15.20.3611.031; Fri, 4 Dec 2020
 00:30:32 +0000
X-SNPS-Relay: synopsys.com
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH 2/3] drivers/irqchip: Remove EZChip NPS interrupt
 controller
Thread-Topic: [PATCH 2/3] drivers/irqchip: Remove EZChip NPS interrupt
 controller
Thread-Index: AQHWydSsYldq4gnw00SliHhXITN1Bg==
Date:   Fri, 4 Dec 2020 00:30:32 +0000
Message-ID: <04e1075d-77a4-9144-f96f-319c3b84ef85@synopsys.com>
References: <20201105212210.1891598-1-vgupta@synopsys.com>
 <20201105212210.1891598-3-vgupta@synopsys.com>
In-Reply-To: <20201105212210.1891598-3-vgupta@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=synopsys.com;
x-originating-ip: [24.4.73.83]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9d65f892-abfc-41bd-5346-08d897ebcf5a
x-ms-traffictypediagnostic: BYAPR12MB3254:
x-microsoft-antispam-prvs: <BYAPR12MB3254736F6BC679C4AFC26390B6F10@BYAPR12MB3254.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lP/Kz1UFwFeyjq0d8LR4bCWixITB0B0+jF8t/7ZDXfBIqEf/lkzELdKZoMRiqjJnpC3gmtoJOCK2K8BIcVUcL3dwHlAXtP26LBMbEZfalZ6s+hmtyudKFOzFoRfpOrHZJ1KI0WUVR6KmRor7xFyoXnONYJlk3/2CJpn5fI0mg9bwgNw3t31HCXWJeoQeKirOC3s4afEBFMMbvQvVJfH8hJWC+Vag1/6mFKrDCFCdl8yoh5j+V684PEQwUEZEvmh+Bek5jogzgWEWtDI/vQWaYjJmx0P7VxfFeEKJoIxVZ5OPvmYRher8K7zvY8KdAU6RppABwr9bXMYKE5x5XHIakXkHQ7BTo6xc3KbHzQGvgEiSE6lkIFsI96Q3SkJyaJV9iDL7m0dZ8HkSCQhQNoPCk4edJWHpKV0qmLMrsUamwlY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3479.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(346002)(136003)(39860400002)(396003)(83380400001)(66446008)(26005)(64756008)(31696002)(66556008)(66476007)(110136005)(76116006)(54906003)(31686004)(478600001)(8676002)(5660300002)(186003)(66946007)(36756003)(2906002)(8936002)(316002)(2616005)(86362001)(71200400001)(6506007)(6512007)(53546011)(6486002)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?MGVwY2dhRjdPNnE0eFNzSlIxZjhyekdzV2U5RzNQOXRrazFqSFdldWdGMlhu?=
 =?utf-8?B?eEdIZk9DWEppSVVNTGwvalA0Y3ZvUFRTbTNEQkpIOW1mejk1YjcrWDBrbzJ6?=
 =?utf-8?B?L2VEUnA0dUg3bEJRZ1VBQVprbTV4ZUk2MGphQ3VvRlhjZmtIT2tJN1Fwb0Vu?=
 =?utf-8?B?bjBYcTVUQVhSOCtXMnZhYXFhMDBHS1RUYm0xSnFOV1YyM1FqYTFOVkVlNWRJ?=
 =?utf-8?B?L1N2U29HcGlVZDFQRVlmZ0phN2pCMzB5cWU4T3pob2hYZHMzVHNXMGhrVXVD?=
 =?utf-8?B?S014TzJnVnUxY2I5QU9BVWhnQlc3SXU0eXdyQzNOMHU3d2xGZ0lRcXl4Nytn?=
 =?utf-8?B?RXVVdkJEdDU1Z20yYTRXRThDcXJ6bmtJMStTMURkbGxiZDRVVjhEMUc3dVZO?=
 =?utf-8?B?QUl1dExkK3dqRFBDQUo0YjlpdUZrMTNMem43aTkrcFNjMjYrU3BTYlRPSTVw?=
 =?utf-8?B?aGc5RXE2WnFPdlArQ1pWMVJMakJTdXNvcTZUMkRQdzFqUFlQL2x3QXhKZnZM?=
 =?utf-8?B?cGxhWE5jTUdvN3R3Zi9pWGFPNGR2TVBMSFFIbTVpaEd0a0xvalNqRllqQjJM?=
 =?utf-8?B?K3RqVmNpdHVQWmRTWlg3NVBvMzlqMTduSVFzazA3eVhzbGtSM3hNc1QxV0Ey?=
 =?utf-8?B?emsxM3lLbDhaVFZUYm9iT3RoOEV6MHlDQjFmU3hDb05ub20vcnI5QW1ya2dO?=
 =?utf-8?B?RTB4K1BqYlprU1VqV0Z5OWcybnoxUmVYVlpsYldhUzdQNzdmbllOWDl1dGg4?=
 =?utf-8?B?eWltUTJHYUlrQ2dQWVVjZ05JNS95QzZQQXByZXVWdWZrbStGOGpMRDZEM0dz?=
 =?utf-8?B?bjNYaHA3V0VlTDVMYTVZOXpKelVYemhyR0NtNFdXUjdyQWd0RmRXdVpYcFpT?=
 =?utf-8?B?eEZ0M0ZmNHQvMk5XbnJvZkFBYXdXWGFwVkhkeHZXam9mTXVTRGNTd2dWVnVi?=
 =?utf-8?B?M3ZiU0dzUDNHZGlXM3l4Zi9NVUVKUEc4UFZaRmdDdEdydzFuSVlLUEQ5SlJq?=
 =?utf-8?B?UTk4amVsTFM2TVJIdmNYSUp0eEY0NE50enl0ZkRZVnM0WnNONUV3ejBaVjFy?=
 =?utf-8?B?NWlWODlIVGZMOFRvV21nQ3RNeVZyVDhlaDNQNzBJcTJHZHBoaHJReEVJNVRG?=
 =?utf-8?B?V2xrUGFoOTg4bWdETEpkMGxaNlg2WlVNTVNpNkZ3cjgrQlpvcHJmaDlaem8x?=
 =?utf-8?B?WU5QMnBJRURhRmdTR3VFMkM3amJVWXNyMXJRemNObXpvaGFLcUxoRFhKVUx2?=
 =?utf-8?B?RDVEVzU3ZUlTamw1SHFyRVZNT2tsNVg3Q0dSMVBQNFhhUVRhc1AyZmNQT1Zr?=
 =?utf-8?Q?qPY6iY47JIkgI=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <A333E7463D44A747B1FFD52821F677CD@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3479.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d65f892-abfc-41bd-5346-08d897ebcf5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2020 00:30:32.3148
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GYJpPufO8VKljwaGmqzqYf13eUCJYgFW9MNbRwFtUG1PjZlvpEmrnpgIEF5WDSC80hvIDYyNg2d3xNqw2sCsxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3254
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTEvNS8yMCAxOjIyIFBNLCBWaW5lZXQgR3VwdGEgd3JvdGU6DQo+IE5QUyBwbGF0Zm9ybSBo
YXMgYmVlbiByZW1vdmVkIGZyb20gQVJDIHBvcnQgYW5kIHRoZXJlIGFyZSBubyBpbi10cmVlDQo+
IHVzZXJzIG9mIGl0IG5vdy4gU28gUklQICENCj4gDQo+IENjOiBUaG9tYXMgR2xlaXhuZXIgPHRn
bHhAbGludXRyb25peC5kZT4NCj4gQ2M6IEphc29uIENvb3BlciA8amFzb25AbGFrZWRhZW1vbi5u
ZXQ+DQo+IENjOiBNYXJjIFp5bmdpZXIgPG1hekBrZXJuZWwub3JnPg0KPiBDYzogbGludXgta2Vy
bmVsQHZnZXIua2VybmVsLm9yZw0KPiBTaWduZWQtb2ZmLWJ5OiBWaW5lZXQgR3VwdGEgPHZndXB0
YUBzeW5vcHN5cy5jb20+DQoNClBpbmcgIQ0KDQo+IC0tLQ0KPiAgIGRyaXZlcnMvaXJxY2hpcC9L
Y29uZmlnICAgICB8ICAgNyAtLQ0KPiAgIGRyaXZlcnMvaXJxY2hpcC9NYWtlZmlsZSAgICB8ICAg
MSAtDQo+ICAgZHJpdmVycy9pcnFjaGlwL2lycS1lem5wcy5jIHwgMTY1IC0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAgIDMgZmlsZXMgY2hhbmdlZCwgMTczIGRlbGV0aW9u
cygtKQ0KPiAgIGRlbGV0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2lycWNoaXAvaXJxLWV6bnBzLmMN
Cj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lycWNoaXAvS2NvbmZpZyBiL2RyaXZlcnMvaXJx
Y2hpcC9LY29uZmlnDQo+IGluZGV4IGM2MDk4ZWVlMGM3Yy4uNzkyMGMzYTMwMTdkIDEwMDY0NA0K
PiAtLS0gYS9kcml2ZXJzL2lycWNoaXAvS2NvbmZpZw0KPiArKysgYi9kcml2ZXJzL2lycWNoaXAv
S2NvbmZpZw0KPiBAQCAtMzg5LDEzICszODksNiBAQCBjb25maWcgTFNfU0NGR19NU0kNCj4gICBj
b25maWcgUEFSVElUSU9OX1BFUkNQVQ0KPiAgIAlib29sDQo+ICAgDQo+IC1jb25maWcgRVpOUFNf
R0lDDQo+IC0JYm9vbCAiTlBTNDAwIEdsb2JhbCBJbnRlcnJ1cHQgTWFuYWdlciAoR0lNKSINCj4g
LQlkZXBlbmRzIG9uIEFSQyB8fCAoQ09NUElMRV9URVNUICYmICE2NEJJVCkNCj4gLQlzZWxlY3Qg
SVJRX0RPTUFJTg0KPiAtCWhlbHANCj4gLQkgIFN1cHBvcnQgdGhlIEVaY2hpcCBOUFM0MDAgZ2xv
YmFsIGludGVycnVwdCBjb250cm9sbGVyDQo+IC0NCj4gICBjb25maWcgU1RNMzJfRVhUSQ0KPiAg
IAlib29sDQo+ICAgCXNlbGVjdCBJUlFfRE9NQUlODQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2ly
cWNoaXAvTWFrZWZpbGUgYi9kcml2ZXJzL2lycWNoaXAvTWFrZWZpbGUNCj4gaW5kZXggOTRjMjg4
NTg4MmVlLi4wYWM5M2JmYWVjNjEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaXJxY2hpcC9NYWtl
ZmlsZQ0KPiArKysgYi9kcml2ZXJzL2lycWNoaXAvTWFrZWZpbGUNCj4gQEAgLTg2LDcgKzg2LDYg
QEAgb2JqLSQoQ09ORklHX01WRUJVX1BJQykJCQkrPSBpcnEtbXZlYnUtcGljLm8NCj4gICBvYmot
JChDT05GSUdfTVZFQlVfU0VJKQkJCSs9IGlycS1tdmVidS1zZWkubw0KPiAgIG9iai0kKENPTkZJ
R19MU19FWFRJUlEpCQkJKz0gaXJxLWxzLWV4dGlycS5vDQo+ICAgb2JqLSQoQ09ORklHX0xTX1ND
RkdfTVNJKQkJKz0gaXJxLWxzLXNjZmctbXNpLm8NCj4gLW9iai0kKENPTkZJR19FWk5QU19HSUMp
CQkJKz0gaXJxLWV6bnBzLm8NCj4gICBvYmotJChDT05GSUdfQVJDSF9BU1BFRUQpCQkrPSBpcnEt
YXNwZWVkLXZpYy5vIGlycS1hc3BlZWQtaTJjLWljLm8gaXJxLWFzcGVlZC1zY3UtaWMubw0KPiAg
IG9iai0kKENPTkZJR19TVE0zMl9FWFRJKSAJCSs9IGlycS1zdG0zMi1leHRpLm8NCj4gICBvYmot
JChDT05GSUdfUUNPTV9JUlFfQ09NQklORVIpCQkrPSBxY29tLWlycS1jb21iaW5lci5vDQo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2lycWNoaXAvaXJxLWV6bnBzLmMgYi9kcml2ZXJzL2lycWNoaXAv
aXJxLWV6bnBzLmMNCj4gZGVsZXRlZCBmaWxlIG1vZGUgMTAwNjQ0DQo+IGluZGV4IDJhN2EzODgz
MGE4ZC4uMDAwMDAwMDAwMDAwDQo+IC0tLSBhL2RyaXZlcnMvaXJxY2hpcC9pcnEtZXpucHMuYw0K
PiArKysgL2Rldi9udWxsDQo+IEBAIC0xLDE2NSArMCwwIEBADQo+IC0vKg0KPiAtICogQ29weXJp
Z2h0IChjKSAyMDE2LCBNZWxsYW5veCBUZWNobm9sb2dpZXMuIEFsbCByaWdodHMgcmVzZXJ2ZWQu
DQo+IC0gKg0KPiAtICogVGhpcyBzb2Z0d2FyZSBpcyBhdmFpbGFibGUgdG8geW91IHVuZGVyIGEg
Y2hvaWNlIG9mIG9uZSBvZiB0d28NCj4gLSAqIGxpY2Vuc2VzLiAgWW91IG1heSBjaG9vc2UgdG8g
YmUgbGljZW5zZWQgdW5kZXIgdGhlIHRlcm1zIG9mIHRoZSBHTlUNCj4gLSAqIEdlbmVyYWwgUHVi
bGljIExpY2Vuc2UgKEdQTCkgVmVyc2lvbiAyLCBhdmFpbGFibGUgZnJvbSB0aGUgZmlsZQ0KPiAt
ICogQ09QWUlORyBpbiB0aGUgbWFpbiBkaXJlY3Rvcnkgb2YgdGhpcyBzb3VyY2UgdHJlZSwgb3Ig
dGhlDQo+IC0gKiBPcGVuSUIub3JnIEJTRCBsaWNlbnNlIGJlbG93Og0KPiAtICoNCj4gLSAqICAg
ICBSZWRpc3RyaWJ1dGlvbiBhbmQgdXNlIGluIHNvdXJjZSBhbmQgYmluYXJ5IGZvcm1zLCB3aXRo
IG9yDQo+IC0gKiAgICAgd2l0aG91dCBtb2RpZmljYXRpb24sIGFyZSBwZXJtaXR0ZWQgcHJvdmlk
ZWQgdGhhdCB0aGUgZm9sbG93aW5nDQo+IC0gKiAgICAgY29uZGl0aW9ucyBhcmUgbWV0Og0KPiAt
ICoNCj4gLSAqICAgICAgLSBSZWRpc3RyaWJ1dGlvbnMgb2Ygc291cmNlIGNvZGUgbXVzdCByZXRh
aW4gdGhlIGFib3ZlDQo+IC0gKiAgICAgICAgY29weXJpZ2h0IG5vdGljZSwgdGhpcyBsaXN0IG9m
IGNvbmRpdGlvbnMgYW5kIHRoZSBmb2xsb3dpbmcNCj4gLSAqICAgICAgICBkaXNjbGFpbWVyLg0K
PiAtICoNCj4gLSAqICAgICAgLSBSZWRpc3RyaWJ1dGlvbnMgaW4gYmluYXJ5IGZvcm0gbXVzdCBy
ZXByb2R1Y2UgdGhlIGFib3ZlDQo+IC0gKiAgICAgICAgY29weXJpZ2h0IG5vdGljZSwgdGhpcyBs
aXN0IG9mIGNvbmRpdGlvbnMgYW5kIHRoZSBmb2xsb3dpbmcNCj4gLSAqICAgICAgICBkaXNjbGFp
bWVyIGluIHRoZSBkb2N1bWVudGF0aW9uIGFuZC9vciBvdGhlciBtYXRlcmlhbHMNCj4gLSAqICAg
ICAgICBwcm92aWRlZCB3aXRoIHRoZSBkaXN0cmlidXRpb24uDQo+IC0gKg0KPiAtICogVEhFIFNP
RlRXQVJFIElTIFBST1ZJREVEICJBUyBJUyIsIFdJVEhPVVQgV0FSUkFOVFkgT0YgQU5ZIEtJTkQs
DQo+IC0gKiBFWFBSRVNTIE9SIElNUExJRUQsIElOQ0xVRElORyBCVVQgTk9UIExJTUlURUQgVE8g
VEhFIFdBUlJBTlRJRVMgT0YNCj4gLSAqIE1FUkNIQU5UQUJJTElUWSwgRklUTkVTUyBGT1IgQSBQ
QVJUSUNVTEFSIFBVUlBPU0UgQU5EDQo+IC0gKiBOT05JTkZSSU5HRU1FTlQuIElOIE5PIEVWRU5U
IFNIQUxMIFRIRSBBVVRIT1JTIE9SIENPUFlSSUdIVCBIT0xERVJTDQo+IC0gKiBCRSBMSUFCTEUg
Rk9SIEFOWSBDTEFJTSwgREFNQUdFUyBPUiBPVEhFUiBMSUFCSUxJVFksIFdIRVRIRVIgSU4gQU4N
Cj4gLSAqIEFDVElPTiBPRiBDT05UUkFDVCwgVE9SVCBPUiBPVEhFUldJU0UsIEFSSVNJTkcgRlJP
TSwgT1VUIE9GIE9SIElODQo+IC0gKiBDT05ORUNUSU9OIFdJVEggVEhFIFNPRlRXQVJFIE9SIFRI
RSBVU0UgT1IgT1RIRVIgREVBTElOR1MgSU4gVEhFDQo+IC0gKiBTT0ZUV0FSRS4NCj4gLSAqLw0K
PiAtDQo+IC0jaW5jbHVkZSA8bGludXgvaW50ZXJydXB0Lmg+DQo+IC0jaW5jbHVkZSA8bGludXgv
bW9kdWxlLmg+DQo+IC0jaW5jbHVkZSA8bGludXgvb2YuaD4NCj4gLSNpbmNsdWRlIDxsaW51eC9p
cnEuaD4NCj4gLSNpbmNsdWRlIDxsaW51eC9pcnFkb21haW4uaD4NCj4gLSNpbmNsdWRlIDxsaW51
eC9pcnFjaGlwLmg+DQo+IC0jaW5jbHVkZSA8c29jL25wcy9jb21tb24uaD4NCj4gLQ0KPiAtI2Rl
ZmluZSBOUFNfTlJfQ1BVX0lSUVMgOCAgLyogbnVtYmVyIG9mIGludGVycnVwdCBsaW5lcyBvZiBO
UFM0MDAgQ1BVICovDQo+IC0jZGVmaW5lIE5QU19USU1FUjBfSVJRICAzDQo+IC0NCj4gLS8qDQo+
IC0gKiBOUFM0MDAgY29yZSBpbmNsdWRlcyBhbiBJbnRlcnJ1cHQgQ29udHJvbGxlciAoSUMpIHN1
cHBvcnQuDQo+IC0gKiBBbGwgY29yZXMgY2FuIGRlYWN0aXZhdGUgbGV2ZWwgaXJxcyBhdCBmaXJz
dCBsZXZlbCBjb250cm9sDQo+IC0gKiBhdCBjb3JlcyBtZXNoIGxheWVyIGNhbGxlZCBNVE0uDQo+
IC0gKiBGb3IgZGV2aWNlcyBvdXQgc2lkZSBjaGlwIGUuZy4gdWFydCwgbmV0d29yayB0aGVyZSBp
cyBhbm90aGVyDQo+IC0gKiBsZXZlbCBjYWxsZWQgR2xvYmFsIEludGVycnVwdCBNYW5hZ2VyIChH
SU0pLg0KPiAtICogVGhpcyBzZWNvbmQgbGV2ZWwgY2FuIGNvbnRyb2wgbGV2ZWwgYW5kIGVkZ2Ug
aW50ZXJydXB0Lg0KPiAtICoNCj4gLSAqIE5PVEU6IEFVWF9JRU5BQkxFIGFuZCBDVE9QX0FVWF9J
QUNLIGFyZSBhdXhpbGlhcnkgcmVnaXN0ZXJzDQo+IC0gKiB3aXRoIHByaXZhdGUgSFcgY29weSBw
ZXIgQ1BVLg0KPiAtICovDQo+IC0NCj4gLXN0YXRpYyB2b2lkIG5wczQwMF9pcnFfbWFzayhzdHJ1
Y3QgaXJxX2RhdGEgKmlycWQpDQo+IC17DQo+IC0JdW5zaWduZWQgaW50IGllbmI7DQo+IC0JdW5z
aWduZWQgaW50IGlycSA9IGlycWRfdG9faHdpcnEoaXJxZCk7DQo+IC0NCj4gLQlpZW5iID0gcmVh
ZF9hdXhfcmVnKEFVWF9JRU5BQkxFKTsNCj4gLQlpZW5iICY9IH4oMSA8PCBpcnEpOw0KPiAtCXdy
aXRlX2F1eF9yZWcoQVVYX0lFTkFCTEUsIGllbmIpOw0KPiAtfQ0KPiAtDQo+IC1zdGF0aWMgdm9p
ZCBucHM0MDBfaXJxX3VubWFzayhzdHJ1Y3QgaXJxX2RhdGEgKmlycWQpDQo+IC17DQo+IC0JdW5z
aWduZWQgaW50IGllbmI7DQo+IC0JdW5zaWduZWQgaW50IGlycSA9IGlycWRfdG9faHdpcnEoaXJx
ZCk7DQo+IC0NCj4gLQlpZW5iID0gcmVhZF9hdXhfcmVnKEFVWF9JRU5BQkxFKTsNCj4gLQlpZW5i
IHw9ICgxIDw8IGlycSk7DQo+IC0Jd3JpdGVfYXV4X3JlZyhBVVhfSUVOQUJMRSwgaWVuYik7DQo+
IC19DQo+IC0NCj4gLXN0YXRpYyB2b2lkIG5wczQwMF9pcnFfZW9pX2dsb2JhbChzdHJ1Y3QgaXJx
X2RhdGEgKmlycWQpDQo+IC17DQo+IC0JdW5zaWduZWQgaW50IF9fbWF5YmVfdW51c2VkIGlycSA9
IGlycWRfdG9faHdpcnEoaXJxZCk7DQo+IC0NCj4gLQl3cml0ZV9hdXhfcmVnKENUT1BfQVVYX0lB
Q0ssIDEgPDwgaXJxKTsNCj4gLQ0KPiAtCS8qIERvbid0IGFjayBHSUMgYmVmb3JlIGFsbCBkZXZp
Y2UgYWNjZXNzIGF0dGVtcHRzIGFyZSBkb25lICovDQo+IC0JbWIoKTsNCj4gLQ0KPiAtCW5wc19h
Y2tfZ2ljKCk7DQo+IC19DQo+IC0NCj4gLXN0YXRpYyB2b2lkIG5wczQwMF9pcnFfYWNrKHN0cnVj
dCBpcnFfZGF0YSAqaXJxZCkNCj4gLXsNCj4gLQl1bnNpZ25lZCBpbnQgX19tYXliZV91bnVzZWQg
aXJxID0gaXJxZF90b19od2lycShpcnFkKTsNCj4gLQ0KPiAtCXdyaXRlX2F1eF9yZWcoQ1RPUF9B
VVhfSUFDSywgMSA8PCBpcnEpOw0KPiAtfQ0KPiAtDQo+IC1zdGF0aWMgc3RydWN0IGlycV9jaGlw
IG5wczQwMF9pcnFfY2hpcF9mYXN0ZW9pID0gew0KPiAtCS5uYW1lCQk9ICJOUFM0MDAgSUMgR2xv
YmFsIiwNCj4gLQkuaXJxX21hc2sJPSBucHM0MDBfaXJxX21hc2ssDQo+IC0JLmlycV91bm1hc2sJ
PSBucHM0MDBfaXJxX3VubWFzaywNCj4gLQkuaXJxX2VvaQk9IG5wczQwMF9pcnFfZW9pX2dsb2Jh
bCwNCj4gLX07DQo+IC0NCj4gLXN0YXRpYyBzdHJ1Y3QgaXJxX2NoaXAgbnBzNDAwX2lycV9jaGlw
X3BlcmNwdSA9IHsNCj4gLQkubmFtZQkJPSAiTlBTNDAwIElDIiwNCj4gLQkuaXJxX21hc2sJPSBu
cHM0MDBfaXJxX21hc2ssDQo+IC0JLmlycV91bm1hc2sJPSBucHM0MDBfaXJxX3VubWFzaywNCj4g
LQkuaXJxX2Fjawk9IG5wczQwMF9pcnFfYWNrLA0KPiAtfTsNCj4gLQ0KPiAtc3RhdGljIGludCBu
cHM0MDBfaXJxX21hcChzdHJ1Y3QgaXJxX2RvbWFpbiAqZCwgdW5zaWduZWQgaW50IHZpcnEsDQo+
IC0JCQkgIGlycV9od19udW1iZXJfdCBodykNCj4gLXsNCj4gLQlzd2l0Y2ggKGh3KSB7DQo+IC0J
Y2FzZSBOUFNfVElNRVIwX0lSUToNCj4gLSNpZmRlZiBDT05GSUdfU01QDQo+IC0JY2FzZSBOUFNf
SVBJX0lSUToNCj4gLSNlbmRpZg0KPiAtCQlpcnFfc2V0X3BlcmNwdV9kZXZpZCh2aXJxKTsNCj4g
LQkJaXJxX3NldF9jaGlwX2FuZF9oYW5kbGVyKHZpcnEsICZucHM0MDBfaXJxX2NoaXBfcGVyY3B1
LA0KPiAtCQkJCQkgaGFuZGxlX3BlcmNwdV9kZXZpZF9pcnEpOw0KPiAtCQlicmVhazsNCj4gLQlk
ZWZhdWx0Og0KPiAtCQlpcnFfc2V0X2NoaXBfYW5kX2hhbmRsZXIodmlycSwgJm5wczQwMF9pcnFf
Y2hpcF9mYXN0ZW9pLA0KPiAtCQkJCQkgaGFuZGxlX2Zhc3Rlb2lfaXJxKTsNCj4gLQkJYnJlYWs7
DQo+IC0JfQ0KPiAtDQo+IC0JcmV0dXJuIDA7DQo+IC19DQo+IC0NCj4gLXN0YXRpYyBjb25zdCBz
dHJ1Y3QgaXJxX2RvbWFpbl9vcHMgbnBzNDAwX2lycV9vcHMgPSB7DQo+IC0JLnhsYXRlID0gaXJx
X2RvbWFpbl94bGF0ZV9vbmVjZWxsLA0KPiAtCS5tYXAgPSBucHM0MDBfaXJxX21hcCwNCj4gLX07
DQo+IC0NCj4gLXN0YXRpYyBpbnQgX19pbml0IG5wczQwMF9vZl9pbml0KHN0cnVjdCBkZXZpY2Vf
bm9kZSAqbm9kZSwNCj4gLQkJCQkgc3RydWN0IGRldmljZV9ub2RlICpwYXJlbnQpDQo+IC17DQo+
IC0Jc3RydWN0IGlycV9kb21haW4gKm5wczQwMF9yb290X2RvbWFpbjsNCj4gLQ0KPiAtCWlmIChw
YXJlbnQpIHsNCj4gLQkJcHJfZXJyKCJEZXZpY2VUcmVlIGluY29yZSBpYyBub3QgYSByb290IGly
cSBjb250cm9sbGVyXG4iKTsNCj4gLQkJcmV0dXJuIC1FSU5WQUw7DQo+IC0JfQ0KPiAtDQo+IC0J
bnBzNDAwX3Jvb3RfZG9tYWluID0gaXJxX2RvbWFpbl9hZGRfbGluZWFyKG5vZGUsIE5QU19OUl9D
UFVfSVJRUywNCj4gLQkJCQkJCSAgICZucHM0MDBfaXJxX29wcywgTlVMTCk7DQo+IC0NCj4gLQlp
ZiAoIW5wczQwMF9yb290X2RvbWFpbikgew0KPiAtCQlwcl9lcnIoIm5wczQwMCByb290IGlycSBk
b21haW4gbm90IGF2YWlsXG4iKTsNCj4gLQkJcmV0dXJuIC1FTk9NRU07DQo+IC0JfQ0KPiAtDQo+
IC0JLyoNCj4gLQkgKiBOZWVkZWQgZm9yIHByaW1hcnkgZG9tYWluIGxvb2t1cCB0byBzdWNjZWVk
DQo+IC0JICogVGhpcyBpcyBhIHByaW1hcnkgaXJxY2hpcCwgYW5kIGNhbiBuZXZlciBoYXZlIGEg
cGFyZW50DQo+IC0JICovDQo+IC0JaXJxX3NldF9kZWZhdWx0X2hvc3QobnBzNDAwX3Jvb3RfZG9t
YWluKTsNCj4gLQ0KPiAtI2lmZGVmIENPTkZJR19TTVANCj4gLQlpcnFfY3JlYXRlX21hcHBpbmco
bnBzNDAwX3Jvb3RfZG9tYWluLCBOUFNfSVBJX0lSUSk7DQo+IC0jZW5kaWYNCj4gLQ0KPiAtCXJl
dHVybiAwOw0KPiAtfQ0KPiAtSVJRQ0hJUF9ERUNMQVJFKGV6Y2hpcF9ucHM0MDBfaWMsICJlemNo
aXAsbnBzNDAwLWljIiwgbnBzNDAwX29mX2luaXQpOw0KPiANCg0K

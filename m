Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7AF22E6EE1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 09:22:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbgL2ISg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 03:18:36 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:60052 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725979AbgL2ISg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 03:18:36 -0500
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 8ECB3C09FC;
        Tue, 29 Dec 2020 08:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1609229855; bh=ClAT3Jw4hp7Vm80kzMgaWWjBqdYp5RDuPxAAOcPs8N0=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=HcYMXfV9W/clC/KwDtiamBpVgZMQrRT/6Sp0cWZokp0dlU1NCQYA5Ij8GLe+xuGG5
         ivU/MjLkWaM6gKyH6EHaVAzWt4TdYyLPyG+TdbKkBQhht4IHk30f9cUsPNHNU97+2e
         xvRB2Po6PcEjd6J1WgS0zFSx5/FcMQaqjnUtAcVSjCkp/YtqMGql6TSxJ/fAJQRjJ0
         nLp/AckWtUCJsbNE/9idwYgkSCM3JeJLC/C6DBbO4OhERzvoBe10K0RwDOb0lu3pVY
         nlNdTePA207ZNgQ7XKTtNpkGlWtnIUpxkHyFg4Q4RUbFxYmulEqjon3yt6BsaBpcy5
         P9DEoL0kLBn1Q==
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 95CD4A0082;
        Tue, 29 Dec 2020 08:17:33 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (mail-bn3nam04lp2053.outbound.protection.outlook.com [104.47.46.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "GlobalSign Organization Validation CA - SHA256 - G3" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 53114811AD;
        Tue, 29 Dec 2020 08:17:31 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=arturp@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="rOxV7MdE";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mCU8b0lQQGrPLv2kbP+do8BAt9hDcEO+on/nqU3lJkDRdiVa9wDy9sG/zPlTr6bf7IkxcPovfNGOwSRSB01ds7cKbrBxUb96DwlIs1Xu9FQhOx30MEcR2G8sE6DYWhMnX8ASfbhLx+bCUxcW89R9EEAPt3A0hQWXhAUsd7O4rufP3AJRjK532xIYGQ7I6/JrU56PSfa4w/bDqzaYQeSAhPFDzroHhK1Sfgd8GPUKLwb7n6R0EpdtmJC61mklxn8PnsJmH7DH6AM85xrpB5WpJyJLiBjEevKpUa1EIVgDMcSU7jhGxkBYTGp1Tmdz5FCpBmRNDP7znPSPddihDZM+qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ClAT3Jw4hp7Vm80kzMgaWWjBqdYp5RDuPxAAOcPs8N0=;
 b=D1dxnU3XxX8j83ccVkhyP2pK7ZWG6BS7L4PrENkYZdcPXaSNo0x9xV3Q3jd7F3WQXLgG+/sQ0tmRT3yzFZSOFbwXsLBj9aGZqo4EHxFzbFjc+qNQyk9uTYNt6Tc1CXEJvhnEmuzevGVfS+4pDfLPfeDrs4pKfOattOW4B6jKdBa1gzPsW+dqLD5rIR5/GUQa3yIZwl8/wo5FJ2uSwdH+D7Vu+bdIBUb2W/HdbBehYIVyeAuln84WiE+nPgJdDKDN4KuLeR6MIquI9Nvbp0MSETH6tThPsPO0rIMC2a1tUg52W6iv6QdX4ypj6CIVcEF7vgK+CGlfi86MLN9Hg3aZxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ClAT3Jw4hp7Vm80kzMgaWWjBqdYp5RDuPxAAOcPs8N0=;
 b=rOxV7MdEfdtLIp4TymgAKfIwsvWlXzNEl4NeMjnc1lcSFZlmbIEc2Iwnj2ncHTpLXmH8VRm2Ie7IRqwnZoaJdNconAEaQMxuqExeyN4Sx5AOEdrrUWRQzn++xh+29Ul6x/+ZKZemJbqGb+D3fYW8R4N4QJ+v+TPBMn1r6PrR3tk=
Received: from MW3PR12MB4428.namprd12.prod.outlook.com (2603:10b6:303:57::15)
 by MW3PR12MB4364.namprd12.prod.outlook.com (2603:10b6:303:5c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.28; Tue, 29 Dec
 2020 08:17:28 +0000
Received: from MW3PR12MB4428.namprd12.prod.outlook.com
 ([fe80::19f6:62ef:1691:1cdb]) by MW3PR12MB4428.namprd12.prod.outlook.com
 ([fe80::19f6:62ef:1691:1cdb%4]) with mapi id 15.20.3700.031; Tue, 29 Dec 2020
 08:17:28 +0000
X-SNPS-Relay: synopsys.com
From:   Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
To:     Jules Maselbas <jmaselbas@kalray.eu>
CC:     Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] usb: dwc2: Try usb_get_phy_by_phandle instead of
 usb_get_phy
Thread-Topic: [RFC PATCH] usb: dwc2: Try usb_get_phy_by_phandle instead of
 usb_get_phy
Thread-Index: AQHW0831HugLL1c3YUuR94LsBoehPqoHvgmAgAG1KwCABFtGgA==
Date:   Tue, 29 Dec 2020 08:17:28 +0000
Message-ID: <6c840fda-c897-1306-160b-9e9c14fb8340@synopsys.com>
References: <20201216165935.9149-1-jmaselbas@kalray.eu>
 <d753fafc-a50a-d19b-d872-78f34dfa01ca@synopsys.com>
 <20201226134522.fqpsd2fzlri2rcni@tellis.lin.mbt.kalray.eu>
In-Reply-To: <20201226134522.fqpsd2fzlri2rcni@tellis.lin.mbt.kalray.eu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kalray.eu; dkim=none (message not signed)
 header.d=none;kalray.eu; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [176.32.192.179]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4ee8ba54-60d5-42cc-80ad-08d8abd22e9d
x-ms-traffictypediagnostic: MW3PR12MB4364:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR12MB436447E06C9323471AD6E083A7D80@MW3PR12MB4364.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2KKiNQFrBmKPGPXLrvzQWoebquPQQaM2Werjlm3pNdiYSfqUkUmIAA15CTEMcMmavk7jbqa4yIo1gJYIe77HJBICA8MZZCl46cHHUxz6KdWX+xG6oy5G6D0ZSxW7NpsAGVukQ9SZtJD52542xcLwxQnil7s8mSis2nQUyo8yjrLJGFhvunH55OXQLPla2pf5gQUoVn4/szK/NfEzlOw/iBEdKErBBaVu/TBQy80EMKfXcH+kn/lnOiVyRPjLK3UofLDNp/m1+buCt+5iofdGNFuMrBDL2lALzD7HfhxwxORPVVPlesZfpldXqroRaBnRFhxz8ZRtM0Q1EnXLxxKF6Qvflf79iLbCN7rKKKbqJdsYkaG1VNlf2XVPcEUG1p+rMDraXFg+lbWax+CDit3r0GyMoZZ7YvJ97Rn0gqVxQAp8aAAnOitgRMDw7gnMQPiP
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4428.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39850400004)(346002)(366004)(136003)(376002)(2906002)(31696002)(186003)(91956017)(478600001)(66946007)(76116006)(66556008)(66446008)(8936002)(8676002)(55236004)(64756008)(6512007)(53546011)(86362001)(31686004)(54906003)(66476007)(6506007)(2616005)(36756003)(26005)(83380400001)(6916009)(4326008)(71200400001)(6486002)(316002)(5660300002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?NTZ1cG5DZ2JxMU9NZ1pReEVmZ3RxbkNhVGRuMlpZeU9rS2RTamhXQStBQVNB?=
 =?utf-8?B?ZDgwSFRnR3BlOGRpbzlpUkNydy8zT1NOd1pFMGs0dFFXWjNsSzg4U0sxQXJq?=
 =?utf-8?B?U1JBOHBaZ0FtMHVIaUd3aHFhTUlPT1pjVXVDYW1KTXoxNVErcE1BYjBkMXVS?=
 =?utf-8?B?RlY0UzRPcEcxbFpjYlUvNUNmOUxwcGI5Q3hKdm4yRmw2YW1yN3Brd0VDeXRR?=
 =?utf-8?B?VWxIVE5YMUEzMEFYNUpLeDRFMVpiRHEvNjhtaFBoclp0cUh0dU1neEI1QXYy?=
 =?utf-8?B?SmYxN0YwQXlFR29yd3ZUSEVUMVV0K2RBM2E3ZmFpSjBQUklLeXh4bTViM0Fr?=
 =?utf-8?B?d2U4WjJKWS9kZ2JFR1dOQjZPU0syWUJ0alZobHhvZlJkVG1Jd2tJaXRmOGFD?=
 =?utf-8?B?QVpvcEJPQUQ1Z25sbHhybDVtZWZYLzNTWVdQSmNmRU93QXVwSDMySFBzSzBG?=
 =?utf-8?B?OFV4aEJUd0x4T3VWYUgzMlFvMjFaNzRzRVFZUTF2aU15Y3dZdjNUdjlqTXJM?=
 =?utf-8?B?a3M0TWhRMWp2eFI1YVpYVFJheUgrcG9qR2diUWtJYmRWSFNzd20yTmdyMHRh?=
 =?utf-8?B?b1hyRlIrY2RKVk9jU0dMZlNhZGxLN2ZreGtXT2RmS3VOQlhjc3p6Sk83L250?=
 =?utf-8?B?N0laVkZhbXBPQTVHa2xxMDUyNDF6SW1iUlFHSEJKTTc2V25jYzFqNWw5dHBz?=
 =?utf-8?B?a2prKzl1R0VsUVkxSjFacllNUXNBeGk5RHI1Y0dZUlVFeHdtZVdEZ1VwUmFG?=
 =?utf-8?B?UGxaSTNTRXFmbVkvVStCcVExQlY1Z0ZhVjVEbmlHYlNzTnhVWjcwZE56cEov?=
 =?utf-8?B?Z3VNRUYzZW1GRHpyNDE4dHN3cG54ZDA1NTVWM1ZqYVdjamlSTUhrTlkzeWdY?=
 =?utf-8?B?QzRhRjEreVhKWkw5RGY0cHlqb09hQXdTb3U1bTBhTStTeWxpK0p2RDRiZVBE?=
 =?utf-8?B?TW1pNnl0Q05pRXoxZ3prYkJTSktDeGJSRHhMbHJucjVZNWVHZUJaYi80NnR0?=
 =?utf-8?B?NWREb2k2Z0k4NUpYUFdKR0hCaXRhemNmMy9pcHU2eGVndXFMY3ducDJpSmtV?=
 =?utf-8?B?bE5pQ0YwMEw4REhGUDJJeTF1V29MVFRWQ0RjS3BQVEtjYmNLVmhhQkpicEZo?=
 =?utf-8?B?bnF1R0ttS2VkeGEzZ094TkRUOWNKRjB3RjVWc2Uzc1FEYXRBNzFId1ptbDBz?=
 =?utf-8?B?Z2JXYzIyTFFKYzc1c1ZsZlYxTDQ1dnV0VFY1Yk9HZDFqc3dIcjRiTWFDVTdN?=
 =?utf-8?B?eGFncitrd085NVFGanA5elEweVFiTkozTkg2TnJRbzJYT2hOVkt1aHRqZDNT?=
 =?utf-8?Q?3zdUYr3NEzwXk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E2549ED4C9C49443B1B82BF9325AB138@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4428.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ee8ba54-60d5-42cc-80ad-08d8abd22e9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Dec 2020 08:17:28.5176
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0DPQ7GcrtwJiEFsPPWnaNd6Hmsw3XghbbwUggRhewUdR8FtNkBv68GCaNhNcmMNlallaa+pOZPcrKGSsO/VZOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4364
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSnVsZXMsDQoNCk9uIDEyLzI2LzIwMjAgMTc6NDUsIEp1bGVzIE1hc2VsYmFzIHdyb3RlOg0K
PiBIaSBBcnR1ciwNCj4gDQo+IE9uIEZyaSwgRGVjIDI1LCAyMDIwIGF0IDExOjQxOjA0QU0gKzAw
MDAsIEFydHVyIFBldHJvc3lhbiB3cm90ZToNCj4+PiBAQCAtMjUxLDcgKzI1MSwxMiBAQCBzdGF0
aWMgaW50IGR3YzJfbG93bGV2ZWxfaHdfaW5pdChzdHJ1Y3QgZHdjMl9oc290ZyAqaHNvdGcpDQo+
Pj4gICAgCX0NCj4+PiAgICANCj4+PiAgICAJaWYgKCFoc290Zy0+cGh5KSB7DQo+Pj4gLQkJaHNv
dGctPnVwaHkgPSBkZXZtX3VzYl9nZXRfcGh5KGhzb3RnLT5kZXYsIFVTQl9QSFlfVFlQRV9VU0Iy
KTsNCj4+PiArCQlpZiAoaHNvdGctPmRldi0+b2Zfbm9kZSkNCj4+PiArCQkJaSA9IG9mX3Byb3Bl
cnR5X21hdGNoX3N0cmluZyhoc290Zy0+ZGV2LT5vZl9ub2RlLCAicGh5LW5hbWVzIiwgInVzYjIt
cGh5Iik7DQo+Pg0KPj4gQWNjb3JkaW5nIHRoZSBkZXZpY2UgdHJlZSB5b3UgaGF2ZSBwcm92aWRl
ZCB0aGUgdmFsdWUgb2YgImkiIHdpbGwgYWx3YXlzDQo+PiBiZSAiMCIuDQo+IFllcw0KPiANCj4+
PiArCQlpZiAoaHNvdGctPmRldi0+b2Zfbm9kZSAmJiBpID49IDApDQo+Pj4gKwkJCWhzb3RnLT51
cGh5ID0gZGV2bV91c2JfZ2V0X3BoeV9ieV9waGFuZGxlKGhzb3RnLT5kZXYsICJwaHlzIiwgaSk7
DQo+Pg0KPj4gV2h5IGRvIHlvdSB1c2UgdGhlIHZhbHVlIG9mICJpIiB3aGlsZSBpbiAiPCZ1c2Jf
cGh5MD4iIHlvdSBoYXZlIG9ubHkgb25lDQo+PiBwaHkuIElmIHlvdSBoYWQgc2V2ZXJhbCBwaHkt
bmFtZXMgYW5kIHRoZSB2YWx1ZSBvZiAiaSIgZ2V0cyBtb3JlIHRoYW4gMCwNCj4+IHRoZW4gYmFz
ZWQgb24geW91ciB1c2JfcGh5MCAiZGV2bV91c2JfZ2V0X3BoeV9ieV9waGFuZGxlIiBmdW5jdGlv
biB3aWxsDQo+PiByZXR1cm4gZXJyb3IuIFNvLCBtYXliZSBpdCB3b3VsZCBiZSBtb3JlIGNvcnJl
Y3QgKGJhc2VkIG9uIHlvdXIgZGV2aWNlDQo+PiB0cmVlKSwgdG8gdXNlIGJlbG93IGNvbW1hbmQN
Cj4+IGhzb3RnLT51cGh5ID0gZGV2bV91c2JfZ2V0X3BoeV9ieV9waGFuZGxlKGhzb3RnLT5kZXYs
ICJwaHlzIiwgMCk7DQo+IFllcyBJIGNvdWxkIHVzZSAwIGluc3RlYWQgb2YgaSwgYnV0IEkgd291
bGQgbGlrZSB0aGlzIHRvIHdvcmsgbm90IG9ubHkNCj4gZm9yIG15IGNhc2Ugd2hlcmUgdGhlICJ1
c2IyLXBoeSIgcGhhbmRsZSBjb21lcyBmaXJzdC4NCj4gDQo+IEkndmUgdHJpZWQgdG8gZm9sbG93
IHdoYXQncyBkb25lIGluIHBoeS1jb3JlLmMsIGFzIGRvbmUgYnkgdGhlIGZ1bmN0aW9uDQo+IHBo
eV9nZXQuIFdoZXJlIGl0IGZpcnN0IGNhbGwgIm9mX3Byb3BlcnR5X21hdGNoX3N0cmluZyIgYW5k
IHRoZW4gZ2V0IHRoZQ0KPiBwaHkgd2l0aCB0aGUgbWF0Y2hlZCBpbmRleC4NCj4gDQo+IEkgZG9u
J3Qgc2VlIGhvdywgaW4gbXkgY2FzZSwgdGhlIGZ1bmN0aW9uICJkZXZtX3VzYl9nZXRfcGh5X2J5
X3BoYW5kbGUiIGNhbg0KPiBiZSBjYWxsZWQgd2l0aCBpIGdyZWF0ZXIgdGhhbiAwLCBhbmQgcmV0
dXJuaW5nIGFuIGVycm9yLg0KDQpJIGhhdmUgbm90aWNlZCB0aGF0IHRoZXJlIG1pZ2h0IGJlIG5v
IG5lZWQgdG8gY2hlY2sgZm9yICJpID49IDAiIGF0IGFsbCANCmJlY2F1c2UgIm9mX3BhcnNlX3Bo
YW5kbGUoKSIgZnVuY3Rpb24gaGFzIGEgY2hlY2sgZm9yIGluZGV4IHRvIG5vdCBiZSANCmxlc3Mg
dGhlbiAwLg0KDQo+IA0KPiBCZXN0LA0KPiBKdWxlcw0KPiANCg0KUmVnYXJkcywNCkFydHVyDQo=

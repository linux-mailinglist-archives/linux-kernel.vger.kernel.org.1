Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1996E29E4C3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 08:47:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387512AbgJ2Hqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 03:46:47 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:55810 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387409AbgJ2HqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 03:46:25 -0400
Received: from mailhost.synopsys.com (sv2-mailhost1.synopsys.com [10.205.2.133])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 42DE5401D8;
        Thu, 29 Oct 2020 06:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1603952953; bh=fUTP8ICGqviRvtXyj4k50RsVQSQ5bbEvPcwAsMl08zA=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=kYdH7aLDXNYQeQmx6qi+mVDRvuFI/ajSjwWS3PVUXLeHd/ERUEkWl6WH7EalZWfYT
         ViBb6QiALX1h0+yNJgvOFdSTwRzeT6cj4TXvYYdv+Q02r1+XkgLOXECOpuPXDnofZW
         oe125vuyRRZEBuoxg/yfl3RYmueiEr5BdF4ChGoXKuXtogS7R0AhawOPw1ok+IA7hI
         EH5xQUlFG/LHkWZDR4tHXBSpzIm/p/TYdCWPtqP1tL7PKWyvlUmsBJyEu7jG/3N4zk
         YHP5HeDNfzd4FVeaELaXWWqpQrVtW27n7x4Xwh8pNFoZR1o6Djh2KozePNR/m4xCRC
         tyNWr+ImSSSSw==
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id D9DD8A007C;
        Thu, 29 Oct 2020 06:29:12 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "GlobalSign Organization Validation CA - SHA256 - G3" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 59CF44004A;
        Thu, 29 Oct 2020 06:29:12 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="bqqz0QoP";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gtHapyjem8cfAQ2buQiqfWUm6By3e9a3PFZnBkU77DJCFx5FButleZ2Il6lNy21dXmok9QMd+PsSwl/cwFiLqBc1YFT/LdjP9djMWNaCIEgQfXppOm6lfqw9NXijoY90QQI8rNJDXkCDqg5IPHHq/tRpfLjo+gTQHHWob4q4JrAguu3rmDb8RS8Felpcgx9kHn+HgbvNiCVsN8T0CiiU3wKXReEGxE9nDJcAh0bwJ8Q4tIP2AMVXmlWLSZRV95lAxQlp+PE0apVGasFJNkvUu6JVIqGQvcZzgqSoUc2UXBfyeFPgyD1j2/2duCTR+55dnnVF0+AGbntEKf8edcYclA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fUTP8ICGqviRvtXyj4k50RsVQSQ5bbEvPcwAsMl08zA=;
 b=T+9/MnOoS9HjfZ4FWgX9lXHEr8B9/npjqk5U0TK4fRusY4xZtL5bc46BTacWq56tNYp11BbYv3EPdyoN7jxPyG5w72vQwCSk5gmnNE5qQEXa7r+nQ9cx9KUt/wO/sUVpcEi0bw+psb2X4OnK8U02dKYUsCZaZcMQar9fr8A+Lj7FVZk4VPMS81BlHncoey9jGUuiTKOIo1Vi0qVJf9ioPIKE5W3cScGb3P7GWoInOVNeM7rzJL7dSqYhb3HN3dyadIq/Fex6U5GpzKMucdNcDcJZ0LBumAu+hB9AXp7L0P+logu+1SIZQOrSEsI1uVCOJQjlvO1tEJywvfu2b7lbYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fUTP8ICGqviRvtXyj4k50RsVQSQ5bbEvPcwAsMl08zA=;
 b=bqqz0QoP34aJb772Xpkv31wl005V23f00AQmAlkrmCXZt0khX29u0m7S6FlporuTVFtI4bLI6qUcVRqg0XHvjNrmUWQFBtYoKnnxKACnqkc8vZJUQqnScggOUhdR4X8mWpf48UFtbMaGWL5Xqmt2eyanT4Vji9yDv3mYkzAW+MI=
Received: from BYAPR12MB2917.namprd12.prod.outlook.com (2603:10b6:a03:130::14)
 by BY5PR12MB4871.namprd12.prod.outlook.com (2603:10b6:a03:1d1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Thu, 29 Oct
 2020 06:29:10 +0000
Received: from BYAPR12MB2917.namprd12.prod.outlook.com
 ([fe80::c17e:c3dd:7cda:e2dc]) by BYAPR12MB2917.namprd12.prod.outlook.com
 ([fe80::c17e:c3dd:7cda:e2dc%4]) with mapi id 15.20.3499.027; Thu, 29 Oct 2020
 06:29:10 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Wesley Cheng <wcheng@codeaurora.org>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "jackp@codeaurora.org" <jackp@codeaurora.org>
Subject: Re: [PATCH 2/2] usb: dwc3: gadget: Preserve UDC max speed setting
Thread-Topic: [PATCH 2/2] usb: dwc3: gadget: Preserve UDC max speed setting
Thread-Index: AQHWrYQp6E6V+/WtykWb6sC7DY3jqamtvfeAgAAVsYCAAA/YgIAAOxWA
Date:   Thu, 29 Oct 2020 06:29:10 +0000
Message-ID: <14e6d4ac-cf33-311f-1858-b4d9ec4cf549@synopsys.com>
References: <20201028234311.6464-1-wcheng@codeaurora.org>
 <20201028234311.6464-3-wcheng@codeaurora.org>
 <e6faade6-7c4c-5966-3afd-63be2deefa01@synopsys.com>
 <6748f727-db76-b51c-4333-57467ae3013f@codeaurora.org>
 <902d2180-cae0-6cc9-1549-a3f711198a2b@synopsys.com>
In-Reply-To: <902d2180-cae0-6cc9-1549-a3f711198a2b@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
authentication-results: codeaurora.org; dkim=none (message not signed)
 header.d=none;codeaurora.org; dmarc=none action=none
 header.from=synopsys.com;
x-originating-ip: [98.248.94.126]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f97d7535-e875-4d73-16d3-08d87bd3f270
x-ms-traffictypediagnostic: BY5PR12MB4871:
x-microsoft-antispam-prvs: <BY5PR12MB48717B809111F29F97F25C22AA140@BY5PR12MB4871.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pa7s8t1UaLIc2FU4p8jtNK/bmQHkwHg9EaQtqX/LehtP9+tisDgQ4hZNzvxUgHXlbuhxAj2/Yu7lmZYTOVQ7cDzk4eObJePQaKBRqj9xXSOqtwWRxMxpL+DRVUycsIt3kdeQhl9Hj50HUAgpQbkDHb3/fWI6gx2Gtv66BN8+M0VG7ZabZ4umiWt4WLA7ba6mZHXsGrSOhl0IUuQwErwZnrJeoOwXphaf7ZL015OQpmTtSD0ZcZhnsXk3TSdQTkazB5mxI3wyzSBmCaUMjQEphebTtZh8WsYT6/ZUFCx2JxB9QPxY+J1A+OPahU/ap0OcCv4nPNnnkHPl3kEYYtJ8s1RIDhJBUtaV+bQ3DtPjHoCAqtvl2Tol0YvoId2eVKXB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2917.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(396003)(346002)(376002)(136003)(2906002)(4326008)(110136005)(86362001)(71200400001)(2616005)(186003)(26005)(54906003)(83380400001)(8936002)(31696002)(6512007)(36756003)(6506007)(316002)(8676002)(478600001)(53546011)(6486002)(66476007)(5660300002)(66946007)(76116006)(64756008)(66446008)(31686004)(66556008)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: RNwWjXtTINs0ilieToiGP6c7uMW0SfnmqgCm60L3HgdEhNTrBruZ+1n2YB9ZrsM3kPLuRqJoJEggrn28PDNDFbwi51P2P+M5g4O1wGjFEvcIpK1njuVd0g+K2AsD2FU9I9tRl9Up2V7hPlBTL7fPRh0J/BO5NQGQNBBAzysZiMMk6/kGKJTiN01dF3Wi3yKIScLOvdJYCYaxFvoI0YSfyQAk8RHvD4BU4+8vdS4g94MAm7ijG783Yb475FkbpVqM2rSwHfXiTssHF1q7OV00cXAqp9GQX6pCtlZ0QF55waL5ZaCuQmojJfkzCeX+Eqw1TWBdEa2FaHajc1Jy8CfcsiA7irJrbpg7NMuzjp2fseX26n9Q7EXtf6l0BXaXPYlvHB4EMSsOv3CZDVEEfivNU3FcFF0a3u4ozvb8+nqCPEV3SFqXaTMc+cwa0jy5I/ebCmskEUBEf4B1bWhsNzgx6bgjavIRl+inX4Kk0gJfulzdsojK+9XWsMayBHc9syGm6J3pmlORrAVheoOuOB88TaKJ+/etKa3yp67iyYNt14Q7ElcUjz9D2GrjJAuDYp9Dn4f3Jd5odPHWNbE12Q8z5iBq32+PwSBIgvDQ7IE8ZHMtAn/dQAUUlQjFeo3LmSZK980eAjCM5FFNXpVs2wMv9A==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <06292D6B507F8044B5FC64B9776A8907@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2917.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f97d7535-e875-4d73-16d3-08d87bd3f270
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2020 06:29:10.7423
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XptuP+jqXK80waxr/eW1U/cFUVGtC4/n0yam25fUM8n/BeYHBZc6RGaUu0S2mEK2nrkPWWMDyrbq+TCpyAhyZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4871
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpbmggTmd1eWVuIHdyb3RlOg0KPiBXZXNsZXkgQ2hlbmcgd3JvdGU6DQo+PiBPbiAxMC8yOC8y
MDIwIDU6NDMgUE0sIFRoaW5oIE5ndXllbiB3cm90ZToNCj4+PiBIaSwNCj4+Pg0KPj4+IFdlc2xl
eSBDaGVuZyB3cm90ZToNCj4+Pj4gVGhlIFVTQiBnYWRnZXQvVURDIGRyaXZlciBjYW4gcmVzdHJp
Y3QgdGhlIERXQzMgY29udHJvbGxlciBzcGVlZCB1c2luZw0KPj4+PiBkd2MzX2dhZGdldF9zZXRf
c3BlZWQoKS4gIFN0b3JlIHRoaXMgc2V0dGluZyBpbnRvIGEgdmFyaWFibGUsIGluIG9yZGVyIGZv
cg0KPj4+PiB0aGlzIHNldHRpbmcgdG8gcGVyc2lzdCBhY3Jvc3MgY29udHJvbGxlciByZXNldHMg
ZHVlIHRvIHJ1bnRpbWUgUE0uDQo+Pj4gV2h5IGRvIHdlIG5lZWQgdG8gZG8gdGhpcz8gRENGRyBz
aG91bGQgcGVyc2lzdCB1bmxlc3Mgd2Ugb3ZlcndyaXRlIGl0Lg0KPj4+IFRoZSBjdXJyZW50IFBN
IHNob3VsZG4ndCB1cGRhdGUgdGhlIGN1cnJlbnQgc3BlZWQgc2V0dGluZy4NCj4+Pg0KPj4+IEJS
LA0KPj4+IFRoaW5oDQo+Pj4NCj4+IEhpIFRoaW5oLA0KPj4NCj4+IER1cmluZyBydW50aW1lIFBN
IHN1c3BlbmQsIHRoZSBkd2MzX3N1c3BlbmRfY29tbW9uKCkgd2lsbCBjYWxsDQo+PiBkd2MzX2Nv
cmVfZXhpdCgpLiAgT24gc29tZSBwbGF0Zm9ybXMgdGhleSByZWdpc3RlciB0aGUgRFdDMyByZXNl
dA0KPj4gY29udHJvbCB0byB0aGUgRFdDMyBjb3JlIGRyaXZlciAob3RoZXJ3aXNlIGNvdWxkIGJl
IGhhbmRsZWQgaW4gdGhlIERXQzMNCj4+IGdsdWUgZHJpdmVycyksIHdoaWNoIHdpbGwgYmUgYXNz
ZXJ0ZWQgaGVyZToNCj4+DQo+PiBzdGF0aWMgdm9pZCBkd2MzX2NvcmVfZXhpdChzdHJ1Y3QgZHdj
MyAqZHdjKQ0KPj4gew0KPj4gLi4uDQo+PiAJcmVzZXRfY29udHJvbF9hc3NlcnQoZHdjLT5yZXNl
dCk7DQo+Pg0KPj4gRnJvbSB0aGUgU05QUyBkYXRhYm9vayAoVGFibGUgMi0yIFJlc2V0cyBmb3Ig
UmVnaXN0ZXJzKSBpdCBtZW50aW9ucyB0aGF0DQo+PiBhc3NlcnRpb24gb2YgdGhlIHJlc2V0IHNp
Z25hbCB3aWxsIHJlc2V0IHRoZSBEQ0ZHIHJlZ2lzdGVyLg0KPiBJIHNlZS4gVGhlcmUncyBhIGhh
cmQgcmVzZXQgb24gc29tZSBwbGF0Zm9ybXMuDQo+DQo+PiBJbiBhZGRpdGlvbiB0byB0aGUgYWJv
dmUsIHdpdGggdGhlIGNoYW5nZSB0byBhbGxvdyBydW50aW1lIFBNIHN1c3BlbmQNCj4+IGR1cmlu
ZyBVREMgdW5iaW5kLCB3ZSBuZWVkIGEgd2F5IHRvIGF2b2lkIHdyaXRpbmcgdG8gdGhlIERDRkcg
ZHVyaW5nIHRoZQ0KPj4gVURDIGJpbmQgcGF0aC4gKGlmIHdlIGVudGVyZWQgc3VzcGVuZCBiZWZv
cmUgcmUtYmluZGluZyB0aGUgVURDKSAgSWYgd2UNCj4+IGFkZCBhbiBlYXJseSBleGl0IGJhc2Vk
IG9uIHRoZSBQTSBzdGF0ZSAoaW4NCj4+IGR3YzNfZ2FkZ2V0X3NldF91ZGNfc3BlZWQoKSksIHRo
ZW4gd2UgYmFzaWNhbGx5IGlnbm9yZSB0aGUgbWF4IHNwZWVkDQo+PiByZXF1ZXN0IGZyb20gdGhl
IFVEQy9nYWRnZXQgbGF5ZXIuDQo+IFRoZW4gc2hvdWxkbid0IHdlIHJlc3RvcmUgdGhlIHNwZWVk
IHNldHRpbmcgd2hlbiBkd2MzX2dhZGdldF9yZXN1bWUoKQ0KPiBpbnN0ZWFkIG9mIGluIGR3YzNf
Z2FkZ2V0X3J1bl9zdG9wKCk/DQoNCkFjdHVhbGx5LCBpZ25vcmUgdGhpcyBjb21tZW50LiBUaGlz
IGlzIGZpbmUsIGFuZCBpdCBtYXkgc2F2ZSBzb21lDQpyZWdpc3RlciByZWFkL3dyaXRlIG9wZXJh
dGlvbnMuIEkgd2FzIHRoaW5raW5nIG9mIHNhdmUvcmVzdG9yZSBmcm9tDQpzdXNwZW5kIGFuZCBy
ZXN1bWUgc2ltaWxhciB0byBoaWJlcm5hdGlvbi4NCg0KVGhhbmtzLA0KVGhpbmgNCg0KPg0KPj4g
U2luY2UgaXQgbG9va3MgbGlrZSB0aGUgRFdDMyBnYWRnZXQgZHJpdmVyIGRvZXNuJ3QgbGlrZSB1
c2luZw0KPj4gc3luY2hyb25vdXMgUE0gcnVudGltZSByZXN1bWVzLCBieSBnb2luZyB0aGlzIHJv
dXRlLCB3ZSBjYW4gYWxsb3cgdGhlDQo+PiBhc3luYyBydW50aW1lIHJlc3VtZSBoYW5kbGVyIHRv
IGRvIGV2ZXJ5dGhpbmcsIHN1Y2ggYXMgd3JpdGluZyB0aGUgc3BlZWQNCj4+IGNvbmZpZyBhbmQg
cmUtZW5hYmxpbmcgdGhlIGNvbnRyb2xsZXIuDQo+Pg0KPj4gVGhhbmtzDQo+Pg0KPj4gUmVnYXJk
cywNCj4+IFdlc2xleSBDaGVuZw0KPiBUaGFua3MsDQo+IFRoaW5oDQoNCg==

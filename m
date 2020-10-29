Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F66829E4D4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 08:49:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387736AbgJ2Hrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 03:47:35 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:45494 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387668AbgJ2Hr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 03:47:27 -0400
Received: from mailhost.synopsys.com (sv2-mailhost1.synopsys.com [10.205.2.133])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 4CD6BC00AD;
        Thu, 29 Oct 2020 02:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1603940265; bh=NqoEaA4/yBKjITf8Vkds72JMZPZj4p2AHiP7UIZ0Ebw=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=MhodJnk2t+cdHmaMcHOYtFQKSa/Q8SSOov6lmlVzo2Fvm1b1Y5j6dOzED1Ua21Efg
         94U1MGWdmSc4QIj4D0eTili+0xMXBCugy6YzTBpfkcsVAYlySuiFKfNSZJ/isbNwRq
         4bgWEHhs+qxRyG7RJw6uPKoermCJIH3yWoKstvoSY94aYW7O6dtn+ozVFF+k0E6+Pt
         CJZI5pgltSGaSBoe861kAaZ995/+Brg6klczoZ8L7N0tmv6IPXtS8/bId053Rj61Gy
         C32c2O6Odg684OiwEQX22YHilRRvRwzef3YHZvZgnRz3YkHx9xMb3Oe45WaGK6Hkc9
         kKN4nRrvRUhCw==
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id C62CFA007C;
        Thu, 29 Oct 2020 02:57:44 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "GlobalSign Organization Validation CA - SHA256 - G3" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id D7EF480276;
        Thu, 29 Oct 2020 02:57:43 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="GSFm3Vu6";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YS5cuQ4e+M/MJeMdrc1v4zlci4rXNXLqneuaXYdyaCe7I6iODRycFtynzyjj3JK9V4pSK4a+GXMy9WlT9X5Bml/0hd7mvnrBtJOJwpcdYH3Fe5CsslDTgXO/kvAmZKI1z7vLHhm4BJh3yq60TbV/2H31dvx9YgSXaC9fNNzMp0BNv97aXg5k98JSyPn+VF+6atGWuQ1GReFzFyeuJNp70y/YLS1u5lqsdr9SJT5T+Ha1V8Ma1LRopFHVR9inEIfp5flPaTQ9ZaJCdsHpg3PNiFnOx2qPqoXc+Ne6BOosegWjjSnZwnCyAAhwSYY5f7XuBbjtNmxfUPXRzfF1cdfusg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NqoEaA4/yBKjITf8Vkds72JMZPZj4p2AHiP7UIZ0Ebw=;
 b=M7FdB7+2UM1L8Q8ONY86ovW8aWgSsKnP5Y/osdkUxJUKTIju9d6ndr+cvhiD4cA3ClAHg68Jiyxr9TtIYxCZFS3oqTJwocPLO8g/3soPcssQjL9IVJrzoc/1Z8dEgpR7eCu3mKrjMvm2Z8MrFkUF0s32eT61zv0gUqMllLrpcctJMHBNvkb6cOu0BAJrZFYX0+Mq6GeVWKd9jIInbmEbuMimQGlmkzDlTPCjWDP7rhwkvV7MJNWoHF9HS/DlU8ovvm5nXfcqZ2g800FVclioPbcykh1xgoebZUVgQ3+btVpI9OEr2ITmENzBgJfo/ktw3yFcS4OSYd3s/qA71gm6qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NqoEaA4/yBKjITf8Vkds72JMZPZj4p2AHiP7UIZ0Ebw=;
 b=GSFm3Vu6VJq+K+wsKplL425omc/r6sgz45FsTdtzDjQ/g5WMqvmhF5DFEjBegsfiR59it/nPZKMZ1dFaT6wCz06Hk9SRtTAEz/CweTmWuPpVK4/wa69ZJpV/jTIb9MQ6leuFDIV5YHyOe+svjVoJw5XXctuGXUeTv+fcucqoxW4=
Received: from BYAPR12MB2917.namprd12.prod.outlook.com (2603:10b6:a03:130::14)
 by BYAPR12MB3240.namprd12.prod.outlook.com (2603:10b6:a03:136::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19; Thu, 29 Oct
 2020 02:57:42 +0000
Received: from BYAPR12MB2917.namprd12.prod.outlook.com
 ([fe80::c17e:c3dd:7cda:e2dc]) by BYAPR12MB2917.namprd12.prod.outlook.com
 ([fe80::c17e:c3dd:7cda:e2dc%4]) with mapi id 15.20.3499.027; Thu, 29 Oct 2020
 02:57:42 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Wesley Cheng <wcheng@codeaurora.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "jackp@codeaurora.org" <jackp@codeaurora.org>
Subject: Re: [PATCH 2/2] usb: dwc3: gadget: Preserve UDC max speed setting
Thread-Topic: [PATCH 2/2] usb: dwc3: gadget: Preserve UDC max speed setting
Thread-Index: AQHWrYQp6E6V+/WtykWb6sC7DY3jqamtvfeAgAAVsYCAAA/YgA==
Date:   Thu, 29 Oct 2020 02:57:42 +0000
Message-ID: <902d2180-cae0-6cc9-1549-a3f711198a2b@synopsys.com>
References: <20201028234311.6464-1-wcheng@codeaurora.org>
 <20201028234311.6464-3-wcheng@codeaurora.org>
 <e6faade6-7c4c-5966-3afd-63be2deefa01@synopsys.com>
 <6748f727-db76-b51c-4333-57467ae3013f@codeaurora.org>
In-Reply-To: <6748f727-db76-b51c-4333-57467ae3013f@codeaurora.org>
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
x-ms-office365-filtering-correlation-id: b5b285cd-4e6e-4791-b011-08d87bb6676b
x-ms-traffictypediagnostic: BYAPR12MB3240:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB32404C67C1742911B229973DAA140@BYAPR12MB3240.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ouM/b1Uh97pjCd3fMpzjezQBTyX7MYWT+B8JchhwptzMa1bCxUfAIluLB/Kfl0fwsc3nFdA2PQolKlHosM+WkuUxPr5Fy6WMb4kQkcoeOXOAkrSRXeEqZYN80xXSqY476PiiUdeMKJ97XnzLhXUlsVwI62+hZX3BaYIMNIX0IzqItRBjLNVOAB+KdjZzU0CEHpUMpcU/5wfM6XjGQ5bpGHHEO2XMi+0jqFLHEs3zHTcCt8DLRz6AIJVHbczsHLHZPW3jbnkQcAy/h1Mofqc9e7pxnwtKUTqQJRphBOhcKq5aTL4dPtFodfecUbdrYxbX9xbYPYuKl7+nOUVtQSJY0xl/mDAdymery3MtggZINkCNsA1xJQuxVh8+Ywzyt9x3
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2917.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(366004)(39860400002)(136003)(346002)(26005)(8676002)(4326008)(186003)(53546011)(31686004)(6506007)(83380400001)(2616005)(6512007)(31696002)(76116006)(8936002)(6486002)(478600001)(54906003)(66556008)(316002)(110136005)(66946007)(71200400001)(2906002)(66446008)(66476007)(36756003)(64756008)(86362001)(5660300002)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: H0yINztze/B0RffttGWPmUG3nKSwL/TCXXftFU6OL8UTB7r6s04kUlDgArEa6v1o6PWTzL0khcHGGli3emmeYvnfFfU1nhvK65WnSySG8R2kmY9IaG7/7NJnGWTfLHCYmeVnvwHlRJceZfG2A1fMDFx/M2L/5CY3d5qenV2qWPC6BD8o3pMbbAE1dUKnbc84+3namltkMhn4FbjGd+dw08fIJ1XR9JPa13ENgGZk78YRz+GYcYSxhz8OdahXyo5d3J8PHksF2GMfqcds5rWDtKtO3KCi6duMj/8Of+s5OgpDLVoWcWif+rX4X/ElDKhf8hVBAE6nUYii3nlDq6TcJJH16sWMx9tj8oMCc7Vn1wHiQ/EhHNplSo2drAphCLQNwPuPZeFX3R/ndhiDNOU8K3oU8LPSdTGHXX1hyLNAXqxXkN/ZAMt9eF3ZUVEA56JIbB1mmV5h90MbajAmOdXz23/X/6IouFk9eLhRbLbGRzRRz6JxDQoidqy8bewf8vX5CjFZ2TPDKTZsN8r9ZPNjEcIJKHLRXNy0i5jQytJpSOneUJQ/RjvtfN96tkN1+8NUco3chNUXiKfT/bC6jGGZGGbit3afTwPnnFrPtwCjbqZVTft8+UfmNDgCRXsYAzX2wi0/BlodI0R9HHxgcCHM+w==
Content-Type: text/plain; charset="utf-8"
Content-ID: <5C44B9DB047598438F9139519221829F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2917.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5b285cd-4e6e-4791-b011-08d87bb6676b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2020 02:57:42.1080
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3t5e0mALzB5Dx23YuE79mryiU7+laWq1bUE/pG0+vwL67izjnB9dYZg9FfbpazunluQTPXsbwPDKeA7WhC06fA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3240
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V2VzbGV5IENoZW5nIHdyb3RlOg0KPg0KPiBPbiAxMC8yOC8yMDIwIDU6NDMgUE0sIFRoaW5oIE5n
dXllbiB3cm90ZToNCj4+IEhpLA0KPj4NCj4+IFdlc2xleSBDaGVuZyB3cm90ZToNCj4+PiBUaGUg
VVNCIGdhZGdldC9VREMgZHJpdmVyIGNhbiByZXN0cmljdCB0aGUgRFdDMyBjb250cm9sbGVyIHNw
ZWVkIHVzaW5nDQo+Pj4gZHdjM19nYWRnZXRfc2V0X3NwZWVkKCkuICBTdG9yZSB0aGlzIHNldHRp
bmcgaW50byBhIHZhcmlhYmxlLCBpbiBvcmRlciBmb3INCj4+PiB0aGlzIHNldHRpbmcgdG8gcGVy
c2lzdCBhY3Jvc3MgY29udHJvbGxlciByZXNldHMgZHVlIHRvIHJ1bnRpbWUgUE0uDQo+PiBXaHkg
ZG8gd2UgbmVlZCB0byBkbyB0aGlzPyBEQ0ZHIHNob3VsZCBwZXJzaXN0IHVubGVzcyB3ZSBvdmVy
d3JpdGUgaXQuDQo+PiBUaGUgY3VycmVudCBQTSBzaG91bGRuJ3QgdXBkYXRlIHRoZSBjdXJyZW50
IHNwZWVkIHNldHRpbmcuDQo+Pg0KPj4gQlIsDQo+PiBUaGluaA0KPj4NCj4gSGkgVGhpbmgsDQo+
DQo+IER1cmluZyBydW50aW1lIFBNIHN1c3BlbmQsIHRoZSBkd2MzX3N1c3BlbmRfY29tbW9uKCkg
d2lsbCBjYWxsDQo+IGR3YzNfY29yZV9leGl0KCkuICBPbiBzb21lIHBsYXRmb3JtcyB0aGV5IHJl
Z2lzdGVyIHRoZSBEV0MzIHJlc2V0DQo+IGNvbnRyb2wgdG8gdGhlIERXQzMgY29yZSBkcml2ZXIg
KG90aGVyd2lzZSBjb3VsZCBiZSBoYW5kbGVkIGluIHRoZSBEV0MzDQo+IGdsdWUgZHJpdmVycyks
IHdoaWNoIHdpbGwgYmUgYXNzZXJ0ZWQgaGVyZToNCj4NCj4gc3RhdGljIHZvaWQgZHdjM19jb3Jl
X2V4aXQoc3RydWN0IGR3YzMgKmR3YykNCj4gew0KPiAuLi4NCj4gCXJlc2V0X2NvbnRyb2xfYXNz
ZXJ0KGR3Yy0+cmVzZXQpOw0KPg0KPiBGcm9tIHRoZSBTTlBTIGRhdGFib29rIChUYWJsZSAyLTIg
UmVzZXRzIGZvciBSZWdpc3RlcnMpIGl0IG1lbnRpb25zIHRoYXQNCj4gYXNzZXJ0aW9uIG9mIHRo
ZSByZXNldCBzaWduYWwgd2lsbCByZXNldCB0aGUgRENGRyByZWdpc3Rlci4NCg0KSSBzZWUuIFRo
ZXJlJ3MgYSBoYXJkIHJlc2V0IG9uIHNvbWUgcGxhdGZvcm1zLg0KDQo+DQo+IEluIGFkZGl0aW9u
IHRvIHRoZSBhYm92ZSwgd2l0aCB0aGUgY2hhbmdlIHRvIGFsbG93IHJ1bnRpbWUgUE0gc3VzcGVu
ZA0KPiBkdXJpbmcgVURDIHVuYmluZCwgd2UgbmVlZCBhIHdheSB0byBhdm9pZCB3cml0aW5nIHRv
IHRoZSBEQ0ZHIGR1cmluZyB0aGUNCj4gVURDIGJpbmQgcGF0aC4gKGlmIHdlIGVudGVyZWQgc3Vz
cGVuZCBiZWZvcmUgcmUtYmluZGluZyB0aGUgVURDKSAgSWYgd2UNCj4gYWRkIGFuIGVhcmx5IGV4
aXQgYmFzZWQgb24gdGhlIFBNIHN0YXRlIChpbg0KPiBkd2MzX2dhZGdldF9zZXRfdWRjX3NwZWVk
KCkpLCB0aGVuIHdlIGJhc2ljYWxseSBpZ25vcmUgdGhlIG1heCBzcGVlZA0KPiByZXF1ZXN0IGZy
b20gdGhlIFVEQy9nYWRnZXQgbGF5ZXIuDQoNClRoZW4gc2hvdWxkbid0IHdlIHJlc3RvcmUgdGhl
IHNwZWVkIHNldHRpbmcgd2hlbiBkd2MzX2dhZGdldF9yZXN1bWUoKQ0KaW5zdGVhZCBvZiBpbiBk
d2MzX2dhZGdldF9ydW5fc3RvcCgpPw0KDQo+DQo+IFNpbmNlIGl0IGxvb2tzIGxpa2UgdGhlIERX
QzMgZ2FkZ2V0IGRyaXZlciBkb2Vzbid0IGxpa2UgdXNpbmcNCj4gc3luY2hyb25vdXMgUE0gcnVu
dGltZSByZXN1bWVzLCBieSBnb2luZyB0aGlzIHJvdXRlLCB3ZSBjYW4gYWxsb3cgdGhlDQo+IGFz
eW5jIHJ1bnRpbWUgcmVzdW1lIGhhbmRsZXIgdG8gZG8gZXZlcnl0aGluZywgc3VjaCBhcyB3cml0
aW5nIHRoZSBzcGVlZA0KPiBjb25maWcgYW5kIHJlLWVuYWJsaW5nIHRoZSBjb250cm9sbGVyLg0K
Pg0KPiBUaGFua3MNCj4NCj4gUmVnYXJkcywNCj4gV2VzbGV5IENoZW5nDQoNClRoYW5rcywNClRo
aW5oDQo=

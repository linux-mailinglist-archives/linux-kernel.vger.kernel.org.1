Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 204DD2E2B60
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Dec 2020 12:43:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729243AbgLYLmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Dec 2020 06:42:12 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:43784 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725873AbgLYLmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Dec 2020 06:42:11 -0500
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 820FA4046A;
        Fri, 25 Dec 2020 11:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1608896470; bh=OVakGNARrWwBoOVhcxWOThBRufbS9z4GTKUudUh3Ulw=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=MmtuQmTyNWuOgXYvYIarwY7qDlW745QNBrFZBzFRU2pi1DS2x6HqX9GAfDrpGOAGk
         a1kgLM4R0Rib6Vn+mYLXXPz5peWVr0eHEKxNngK8d6n5ynuEVWKWNH5VyUv+PIHrzS
         Xnw0/2YAiv2lWixng/aIsUqRJW+5rwJdHpDa9XNh7brx/zDakRgLrQzaes8OPvquK3
         IC40X1sxd35MEQ4gMCoFOizKsd/VtAhXyWi3TXGjEB1wKcXNYa/KHROLgBC3hMtikf
         DxVYEWtPWPGNr3dxd6kYUQV0Xvl5QIGRr3tOrXd5s8xTNk7z0VWtAzan2Fn1anDXs2
         ASnpWqiYCLzdQ==
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id C073DA0070;
        Fri, 25 Dec 2020 11:41:09 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "GlobalSign Organization Validation CA - SHA256 - G3" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 633FC400C6;
        Fri, 25 Dec 2020 11:41:08 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=arturp@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="EDg6JSa9";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jGdXn0k8KE7GPVOwpbZclXBgKbMua4me4WG70tyVn6LAFg3P4k93t6WnqKgnrnkj62WUvbZOe+SJn9GCEcKyG5k4od5HE0OAxVV4qjZOQEFL+5mCnje9gboOzAnCSaVdhv/XKQ1EaA7+F9S9kvKijdyRJa9VIauDZhfz2bB3z7qJFApxRDUWJ0Qy9GnF+6iZ2PiYQZ+nJZGomzyV8VUOvy9PAFQduOANRsNG02qvvjThDPyNEmmnTww1sv4BkR4saCqFNF/Eyo8yuweAs8HkjfJPbtpY12DZsxJK0p5MBlOUiNi8NUsW3s4gu/OqLNSqNtGcYsrSl+98ikEq+4RWUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OVakGNARrWwBoOVhcxWOThBRufbS9z4GTKUudUh3Ulw=;
 b=b88iNgmAlVZHaCQYUqzEl2NKV2Mz5LSrA+7s1mfrtXBw5jdsm90dbk5y2g1VmBwWSHqR56KEVCGt01VEPMU/RRjHHzQM44vyBEKLmKkXjgx0N5BjvSjaSEee9R5JwUQPUd1T3TPUJDmeMO1yYqnEh3S0PTMj4X2TTWWPVCkwsrkwyPiotQ4KYO5tY33bl2Lt8Hxl2YOzTp5g6ghtCMrKN1U+7zMVEEWOZVlypI3Ky+1rmxMisRSiDQ9sT1LDMD9eRSxt3fTiSyMThGMYRyL2+gy6t73Qt+PsPsgR7EpB8KveMzl9cB4gCl1KtF6R4HDAcnOFnemT2swXfyEB1Gveig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OVakGNARrWwBoOVhcxWOThBRufbS9z4GTKUudUh3Ulw=;
 b=EDg6JSa9/CjOCa6O3j82gX88F3h/GaJuyF2/N5HAB8T3YEqH0ewSY2t9V9Mvi6ad1gyinWbf4B07dNDQE6n6tQ0nFSkxuXXKebCFC/pASL1/tgEyJ7X8DbOrf4jH/n8p0PWW0GWrpvE5iPV5ylOrFQj19SV3Kz9q6XMoHze932s=
Received: from MW3PR12MB4428.namprd12.prod.outlook.com (2603:10b6:303:57::15)
 by MWHPR12MB1951.namprd12.prod.outlook.com (2603:10b6:300:113::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.28; Fri, 25 Dec
 2020 11:41:04 +0000
Received: from MW3PR12MB4428.namprd12.prod.outlook.com
 ([fe80::19f6:62ef:1691:1cdb]) by MW3PR12MB4428.namprd12.prod.outlook.com
 ([fe80::19f6:62ef:1691:1cdb%4]) with mapi id 15.20.3700.028; Fri, 25 Dec 2020
 11:41:04 +0000
X-SNPS-Relay: synopsys.com
From:   Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
To:     Jules Maselbas <jmaselbas@kalray.eu>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] usb: dwc2: Try usb_get_phy_by_phandle instead of
 usb_get_phy
Thread-Topic: [RFC PATCH] usb: dwc2: Try usb_get_phy_by_phandle instead of
 usb_get_phy
Thread-Index: AQHW0831HugLL1c3YUuR94LsBoehPqoHvgmA
Date:   Fri, 25 Dec 2020 11:41:04 +0000
Message-ID: <d753fafc-a50a-d19b-d872-78f34dfa01ca@synopsys.com>
References: <20201216165935.9149-1-jmaselbas@kalray.eu>
In-Reply-To: <20201216165935.9149-1-jmaselbas@kalray.eu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kalray.eu; dkim=none (message not signed)
 header.d=none;kalray.eu; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [176.32.192.178]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ec7b048d-37f2-4b56-e34b-08d8a8c9f605
x-ms-traffictypediagnostic: MWHPR12MB1951:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR12MB195103C008E50AFDE9407EACA7DC0@MWHPR12MB1951.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O/iCmz5MOEVOAPhg6z+SVxYUbVQqzvqSVS4IPYg8F0IwaPxS43xq2c8+nbll2ejLwKpLcnvX91hKinUZF/eTca7N9yFWyUPOn6uIcCifJbvEiTFnBUk8gCthSo5fW8CquI0JxZl5i+d8KT5ZktV88jAUlTdu9y781DS38eI0zdhu7mVK7+RNsLSSyGiqh1RKrXqpu+OjyCDkvE1IUBLM+aaBTfjKOSmnY0CsfJhU7kXcV+yJF7Pqluj1z8pzI+V0LHGyb9qc/s0+5+tOZlMYc8Vt6JS/+aX1Td+NVj60GKb22at0SeSvz/xT1KGAgy2NiRBU+BdfGacB0Rn4ZfDmKYmPMlp/feqRYnNebLuz56pGeDjf2yICSah2AJaMb52407ba8rI2qsFGjGeRhlNYp1P2P9uP7kgiiyFRsbrlBDgq8l66UrYvU2hJGDy89orQ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4428.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39850400004)(396003)(376002)(366004)(346002)(6636002)(36756003)(5660300002)(4326008)(83380400001)(8676002)(478600001)(2906002)(71200400001)(66476007)(86362001)(66946007)(53546011)(55236004)(66556008)(6506007)(64756008)(316002)(6486002)(54906003)(26005)(6512007)(110136005)(76116006)(186003)(31686004)(91956017)(66446008)(8936002)(31696002)(2616005)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?Ky80RW9MTjVjUUorTHY0akJKM0l1VHkzNGF5Tjd3VmVzTS9yL3BIUlc5dWMz?=
 =?utf-8?B?SGhQbUQzY3lGdUVpVTBDM1A5c3NsMnZMV3cxcGl4LzltQ2hWQkIzUGZSR1RD?=
 =?utf-8?B?WVJUUXEvcVR0bmdzVUVmUWY2ei92QkluQ1JQNzJLVnZhN2tqRyt0eFhBZkx1?=
 =?utf-8?B?N0EvcU4rKzgwT2ViL3RtclA4elBURkhjZDk5YWUxYnJZdUFnSTF3b2lGSGpv?=
 =?utf-8?B?NTh4cGdQVEM4emg0MHdOR1Z3UTJxV2RLSTZWVCtuRlJnZG96Ui9Uay90RGVa?=
 =?utf-8?B?bG9PYWFRM3ZOTlhGZGMzZG56UHd2WEpVR2JYeVQrRko0WWt5YklqSWQxUWZM?=
 =?utf-8?B?NDRkbmxIY0ZKYnZmeU5NY2ZrdFloT2YwbFFGV1dUUlVZa0hnN1hzSFVjemRr?=
 =?utf-8?B?bVlqUXQ1MzNyR1hndkRocU5NZDJqbWIwRFdDZ2YzV2ZwZzgwMnY0Uzg5Y0xS?=
 =?utf-8?B?Z005MkV4Ti93RnlqSmpFVmNaQXlsZHpOS3o0V2ZQUFJBTnhvbEY1OVE2aVJx?=
 =?utf-8?B?TkJVWHBWSGZWUGJYNVR3UWxRaUZSUzVuZEdGaUV6NnJSWXlaSytHYWxzT3R4?=
 =?utf-8?B?S3FBWEF0U3RGUXU3Yy8wVXA1RmpoK3FkRlBlQk1tWk1xWDRnZ2E1Z0ZkQVp4?=
 =?utf-8?B?bzVkbXdvZjJyZlFsUE1OTUhkM1FZSzJsL0hZRWxBYUpqSkZjdFVnQWhJMC9n?=
 =?utf-8?B?UGZ1dTJ4WlVKL2JaQy8vV2dxS1A1WGo0U0hDNk11cmt4Y1VHUU9yaGFNYlUw?=
 =?utf-8?B?VXF3bkJNYnhCcFFXQ01Pc0lRTWFnMzZkcXJ3NDE5dm5zQkhNZ01lNDZnWG1M?=
 =?utf-8?B?V3puTzA5Ym9sNEVNZ3BwQXBieW0rbnI1aFozY2RrVnNmcVJ2T1A1Skx3b0Zy?=
 =?utf-8?B?SFFPSzh3TXVBYXFSWEhEd0FDbVRhYXl6Vm4wUVNNaW44aTFjT3dVallpNjhH?=
 =?utf-8?B?UjR3TUk2bk1VamJDMmIwelBhOWZBSG90cnBPcVRwSzJLL3NDOHVIWnM5S1hN?=
 =?utf-8?B?ZFlFbmNXODlIZHZiR245TkVkUFZrTlN0NmRPRkhGZDBWNWJKMVFicHRjTFJu?=
 =?utf-8?B?b0tNT1NQNE9uazdsYlBnVDFlTEY4dW4zM2xGVlhhb09wcGV4MlNsTnU0aExE?=
 =?utf-8?B?RGpsR1VhYldmWWRaOGc3NUg4NDdtM2FVNWtiVkppSnh6VmpFdHJCVWIyaGsr?=
 =?utf-8?B?RUNSNEZLdGNybktScHZ2U01PSHd0NDdRUWZibCttdVN6VHFiNVJyYk0yWisz?=
 =?utf-8?B?V2phbDNReEZOSnBGOGhSWXhaa0ErT2lwVmJIUXRkZzdIZzF3ZVV5SGlxbTdq?=
 =?utf-8?Q?WzfUeqTTN2Y/g=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C9F5226A8F0B6F4CA2D5E8BA78B876D9@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4428.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec7b048d-37f2-4b56-e34b-08d8a8c9f605
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Dec 2020 11:41:04.1174
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LFyWZLKghYcctjmSr2BOPEGidJ5E0qXXOVkC0MkeSIp+YVKtP9CDe0O5c2i/qHEHs1a9WHkOLKWgey2V8evAEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1951
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSnVsZXMsDQoNCk9uIDEyLzE2LzIwMjAgMjA6NTksIEp1bGVzIE1hc2VsYmFzIHdyb3RlOg0K
PiBPbiBwcm9iZSB0aGUgZHdjMiBkcml2ZXIgdHJpZXMgdHdvIHBhdGggdG8gZ2V0IGFuIHVzYiBw
aHksIGZpcnN0IGNhbGxpbmcNCj4gZGV2bV9waHlfZ2V0KCkgYW5kIHNlY29uZGx5IHdpdGggZGV2
bV91c2JfZ2V0X3BoeSgpLg0KPiANCj4gSG93ZXZlciB0aGUgY3VycmVudCBpbXBsZW1lbnRhdGlv
biBvZiBkZXZtX3BoeV9nZXQoKSBuZXZlciByZXR1cm4gYSB2YWxpZA0KPiBwaHkgZm9yIHVzYi1u
b3AteGNlaXYuIEFuZCB0aGUgY3VycmVudCBpbXBsZW1lbnRhdGlvbiBvZiBkZXZtX3VzYl9nZXRf
cGh5DQo+IG9ubHkgY2hlY2sgZm9yIHBoeSB0aGF0J3MgaGFzIGFscmVhZHkgYmVlbiByZWdpc3Rl
cmVkLg0KPiANCj4gRHVyaW5nIGJvb3QsIEkgc2VlIHRoZSBkd2MyIGRyaXZlciBiZWluZyBwcm9i
ZWQgYmVmb3JlIHRoZSB1c2Itbm9wLXhjZWl2DQo+IHByb2JlLCB0aGlzIG1lYW5zIHRoYXQgZHVy
aW5nIHRoZSBkd2MyIHByb2JlIHRoZSBmdW5jdGlvbiBkZXZtX3VzYl9nZXRfcGh5DQo+IG5ldmVy
IGZpbmRzIHRoZSBhIHBoeSAoYmVjYXVzZSBpdCBoYXNuJ3QgYmVlbiByZWdpc3RlcmVkIHlldCkg
YnV0IG5ldmVyDQo+IGNhdXNlIHRoZSBkd2MyIHByb2JlIHRvIGRlZmVyLg0KPiANCj4gSSB0cmll
ZCB0byBmb2xsb3cgd2hhdCBpcyBkb25lIGJ5IGR3YzNfY29yZV9nZXRfcGh5KCk6IGlmIHRoZSBj
dXJyZW50DQo+IGRldmljZSBoYXMgYW4gb2Zfbm9kZSB0aGVuIHRyeSB0byBnZXQgdGhlIHVzYl9w
aHkgYnkgcGhhbmRsZSBpbnN0ZWFkIG9mDQo+IHVzaW5nIGRldm1fdXNiX2dldF9waHkoKS4gVGhp
cyB3YXkgd2hlbiB0aGUgcHJvYmUgb3JkZXIgaXMgbm90IGdvb2QgdGhlDQo+IGRldm1fdXNiX2dl
dF9waHlfYnlfcGhhbmRsZSgpIGZ1bmN0aW9uIHdpbGwgcmV0dXJuIC1FUFJPQkVfREVGRVIuDQo+
IA0KPiBTaWduZWQtb2ZmLWJ5OiBKdWxlcyBNYXNlbGJhcyA8am1hc2VsYmFzQGthbHJheS5ldT4N
Cj4gLS0tIDg8IC0tLQ0KPiANCj4gQSBzbmlwcGV0IG9mIHRoZSBkZXZpY2UtdHJlZSBzb3VyY2Ug
SSBhbSB1c2luZzoNCj4gICAgICAgICAgJnVzYjAgew0KPiAgICAgICAgICAgICAgICAgIHBoeXMg
PSA8JnVzYl9waHkwPjsNCj4gICAgICAgICAgICAgICAgICBwaHktbmFtZXMgPSAidXNiMi1waHki
Ow0KPiAgICAgICAgICB9Ow0KPiAgICAgICAgICAmdXNiX3BoeTAgew0KPiAgICAgICAgICAgICAg
ICAgICNwaHktY2VsbHMgPSA8MD47DQo+ICAgICAgICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJ1
c2Itbm9wLXhjZWl2IjsNCj4gICAgICAgICAgICAgICAgICByZXNldC1ncGlvcyA9IDwmZ3BpbyAw
IEdQSU9fQUNUSVZFX0xPVz47DQo+ICAgICAgICAgIH07DQo+IC0tLQ0KPiAgIGRyaXZlcnMvdXNi
L2R3YzIvcGxhdGZvcm0uYyB8IDcgKysrKysrLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2Vy
dGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9k
d2MyL3BsYXRmb3JtLmMgYi9kcml2ZXJzL3VzYi9kd2MyL3BsYXRmb3JtLmMNCj4gaW5kZXggZGI5
ZmQ0YmQxYTM4Li5iNThjZTk5NmFkZDcgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzIv
cGxhdGZvcm0uYw0KPiArKysgYi9kcml2ZXJzL3VzYi9kd2MyL3BsYXRmb3JtLmMNCj4gQEAgLTI1
MSw3ICsyNTEsMTIgQEAgc3RhdGljIGludCBkd2MyX2xvd2xldmVsX2h3X2luaXQoc3RydWN0IGR3
YzJfaHNvdGcgKmhzb3RnKQ0KPiAgIAl9DQo+ICAgDQo+ICAgCWlmICghaHNvdGctPnBoeSkgew0K
PiAtCQloc290Zy0+dXBoeSA9IGRldm1fdXNiX2dldF9waHkoaHNvdGctPmRldiwgVVNCX1BIWV9U
WVBFX1VTQjIpOw0KPiArCQlpZiAoaHNvdGctPmRldi0+b2Zfbm9kZSkNCj4gKwkJCWkgPSBvZl9w
cm9wZXJ0eV9tYXRjaF9zdHJpbmcoaHNvdGctPmRldi0+b2Zfbm9kZSwgInBoeS1uYW1lcyIsICJ1
c2IyLXBoeSIpOw0KDQpBY2NvcmRpbmcgdGhlIGRldmljZSB0cmVlIHlvdSBoYXZlIHByb3ZpZGVk
IHRoZSB2YWx1ZSBvZiAiaSIgd2lsbCBhbHdheXMgDQpiZSAiMCIuDQoNCj4gKwkJaWYgKGhzb3Rn
LT5kZXYtPm9mX25vZGUgJiYgaSA+PSAwKQ0KPiArCQkJaHNvdGctPnVwaHkgPSBkZXZtX3VzYl9n
ZXRfcGh5X2J5X3BoYW5kbGUoaHNvdGctPmRldiwgInBoeXMiLCBpKTsNCg0KV2h5IGRvIHlvdSB1
c2UgdGhlIHZhbHVlIG9mICJpIiB3aGlsZSBpbiAiPCZ1c2JfcGh5MD4iIHlvdSBoYXZlIG9ubHkg
b25lIA0KcGh5LiBJZiB5b3UgaGFkIHNldmVyYWwgcGh5LW5hbWVzIGFuZCB0aGUgdmFsdWUgb2Yg
ImkiIGdldHMgbW9yZSB0aGFuIDAsIA0KdGhlbiBiYXNlZCBvbiB5b3VyIHVzYl9waHkwICJkZXZt
X3VzYl9nZXRfcGh5X2J5X3BoYW5kbGUiIGZ1bmN0aW9uIHdpbGwgDQpyZXR1cm4gZXJyb3IuIFNv
LCBtYXliZSBpdCB3b3VsZCBiZSBtb3JlIGNvcnJlY3QgKGJhc2VkIG9uIHlvdXIgZGV2aWNlIA0K
dHJlZSksIHRvIHVzZSBiZWxvdyBjb21tYW5kDQpoc290Zy0+dXBoeSA9IGRldm1fdXNiX2dldF9w
aHlfYnlfcGhhbmRsZShoc290Zy0+ZGV2LCAicGh5cyIsIDApOw0KDQo+ICsJCWVsc2UNCj4gKwkJ
CWhzb3RnLT51cGh5ID0gZGV2bV91c2JfZ2V0X3BoeShoc290Zy0+ZGV2LCBVU0JfUEhZX1RZUEVf
VVNCMik7DQo+ICAgCQlpZiAoSVNfRVJSKGhzb3RnLT51cGh5KSkgew0KPiAgIAkJCXJldCA9IFBU
Ul9FUlIoaHNvdGctPnVwaHkpOw0KPiAgIAkJCXN3aXRjaCAocmV0KSB7DQo+IA0KDQpSZWdhcmRz
LA0KQXJ0dXINCg==

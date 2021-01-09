Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 750102EFC4C
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 01:46:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbhAIAps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 19:45:48 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:58542 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725815AbhAIAps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 19:45:48 -0500
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 4217AC00DC;
        Sat,  9 Jan 2021 00:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1610153087; bh=JzX3e+BBxDM8cfpgovARSmdrWpNeD/5j8JLW9yqrZis=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=f/4H2z2RegG+78Qzv/NE/ChEH+ragbN3u/mqzjyux6if/2zw8VAqiotcRa98tsrni
         9Xne1mSQNPWLIe2E684nLfqXgbNYclwxhXpAGkkcha7aa+FSDRwFAb1DFACnBbHFiK
         JFLnxYLy/ThC8dXquTWBReYcMVxT10r9av+0yP1PeJBjfrUPNcmE6owRCZIpD84TUf
         Y+MVLdVAg3FRpkZQt9L/wN040BqMPQdX4+Hzyuj7iS9pK4nezFQdDOrEy9PfPTZX0d
         3JG/KmrWGrO/B1iP6hAOjOQi3MhTFs3379EU30Y802jefcz4/y6wOL5BLOFsTl2qDx
         YOpCFWdeNNMAA==
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id C4BC4A0071;
        Sat,  9 Jan 2021 00:44:44 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "GlobalSign Organization Validation CA - SHA256 - G3" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 5679580240;
        Sat,  9 Jan 2021 00:44:43 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="dYGhP3NE";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H/Drzl8w5JYevX0qho8cukeI8ZE0mgO2BS53H6M1usjn17CJljZbZh8lCBzkcUoeiHE2jdBbYjUdW98i7GgNM/SB/Q6ZJXtgbVOn958oB9bXIgrngCpyuK/sQap1/ylD6mUViqekKEOhbpkRDXBkXDfrmGAGtdGjYtIb17SOYkw6/TsO77WuaWB3MG1DatZIPmcP7yjTNJC5iANKoOokusN7D6zmlI2y6gsS+dKLq7u3m4W1q1hmdjWMCgqtS2Mp/Fru7/KbTtw0U+scRAw2z6Hd/GJ31Ejq4IXNoZeCJMn++S4nzO4PP9V0Rp11cwgq3cWiqV8KQ5jdRF7gH7IrGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JzX3e+BBxDM8cfpgovARSmdrWpNeD/5j8JLW9yqrZis=;
 b=DqEv9NoYoJJEUcA88CKyu9/cIMO7LfEV6heF7qhPMYX6CJ41W8vVHYyvLiHBT1kxo+odmkwquqpwrlT+oNwG7O6YsqlKpHBnQbu2wL9vAQjG/RslvtG9Af2+vSCoLmO81HRVX14EFVKNuq7QVS9OgspiZDIWOIRkdf+uv8xDcr1TJvPdi1buAW8TkQrh9+e0+rANKZ2eoX33p69KWqVDRZXvJHKiltt7kUrMd/clU9VOOUd8HX4EyzPtVRGX6zy/L9rFHG+X/Vv+YjoAlJrGfhVs98vV5Jd/bUN/XNN2yAjEPymcm2df/pHDp8HAmZRKrCSM1jZc8r75SoesSkd0cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JzX3e+BBxDM8cfpgovARSmdrWpNeD/5j8JLW9yqrZis=;
 b=dYGhP3NEIAQnUOmT+S8dAHy1Ws/aC7bnsKFtZjsj5j9uwxmPk6UFuGP3q1IcJtXSCtt/F9J0vOF4ohW/AZgQtMlOgUwrPRwgtywISICakmvBwMY8PbRQRd/P/L3m4l8IfNyn/aXu8DLI3L5AR7sLusKn6XCA0rjby5ca5O+nq5U=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by BY5PR12MB4017.namprd12.prod.outlook.com (2603:10b6:a03:1ac::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.9; Sat, 9 Jan
 2021 00:44:41 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::895b:620d:8f20:c4d6]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::895b:620d:8f20:c4d6%6]) with mapi id 15.20.3742.009; Sat, 9 Jan 2021
 00:44:41 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     John Stultz <john.stultz@linaro.org>,
        Felipe Balbi <balbi@kernel.org>
CC:     lkml <linux-kernel@vger.kernel.org>, Yu Chen <chenyu56@huawei.com>,
        Tejas Joglekar <Tejas.Joglekar@synopsys.com>,
        Yang Fei <fei.yang@intel.com>,
        YongQin Liu <yongqin.liu@linaro.org>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Jun Li <lijun.kernel@gmail.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v3 1/2] usb: dwc3: Trigger a GCTL soft reset when
 switching modes in DRD
Thread-Topic: [PATCH v3 1/2] usb: dwc3: Trigger a GCTL soft reset when
 switching modes in DRD
Thread-Index: AQHW5WDHaQXdezZAr06Yos1UmLp1A6odqBQAgABzRQCAAFsegA==
Date:   Sat, 9 Jan 2021 00:44:40 +0000
Message-ID: <d95d0971-624e-a0e6-ac72-6ee3b1fb1106@synopsys.com>
References: <20210108015115.27920-1-john.stultz@linaro.org>
 <87bldzwr6x.fsf@kernel.org>
 <CALAqxLWdWj9=a-7NGDzJyrfyRABwKnJM7EQo3Zm+k9JqAhPz+g@mail.gmail.com>
In-Reply-To: <CALAqxLWdWj9=a-7NGDzJyrfyRABwKnJM7EQo3Zm+k9JqAhPz+g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [98.248.94.126]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9d08397f-5e95-4a3d-6f33-08d8b437c03f
x-ms-traffictypediagnostic: BY5PR12MB4017:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB4017FB86EF490CE52AA73295AAAD0@BY5PR12MB4017.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /vQ7q5p1ukza6fY33WZHJFBdSIsMBrpmxngqFfW8CbEb7kwK/VkEqYfZmwO5b+tifnW00cee+ZNE/NpWECkD51YoQlTVDOvKEhbJEXK99/MoL5xtgTyPiH8O9c78dGQXlmexL6VC8Y6z7ab3+TjMOzQlowEo8PhSJdzTumP4/0kfeMEtD13nk0YLi35blPdz8Y/UdZzUdBvFR8J1hMGUAs5C7c+kjpJ0Gahzroh9xBN7ZKu2MblqUJyRaZvTH/FyG2aFRnqn3YhTu8du5jM/CrXAWowZ6bt6hKF0wj4JRSPjOk/MjRbGQHDo62k0CN3Gi93OVlYsGtpO0X9IJAdiHaUI/RFLCk1FaG04I3u6xs+ud8tzc5iwXWumCTvxN8Crcxv/mA5okanDkY2K8H4sNzAyXbrijamjvKeD1K27fkTZU0ouLNOD3C1LlDtqsw99+v0ukodRlutASJhd99MeffbDMc8K5dSsGktR3G443Yk1AUu7nskT7b/+UlYTjSUd9j5npF2DC/66OkpI1+TPd9P0RrL2TXnWW1QXTzBWuJNS+28TExy+6lIPcnWXQLfN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(346002)(376002)(136003)(366004)(83380400001)(76116006)(2906002)(6506007)(66476007)(66946007)(66446008)(6512007)(6486002)(53546011)(7416002)(966005)(36756003)(26005)(31696002)(478600001)(66556008)(64756008)(31686004)(186003)(110136005)(8936002)(86362001)(71200400001)(54906003)(2616005)(5660300002)(316002)(4326008)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?b2ptaEZSc0VzOFM5cWtFaXVCbEowenA4WE1RdGwxVHM3Q3RkNkVsY3praGYx?=
 =?utf-8?B?cVBXN2tPcFlhZmptbXI0bGFmLzZlMEJIdXY5WGlqVGtSVldONldDSitQU3FU?=
 =?utf-8?B?RmMvZ2VmSElpZHQzdFVqNDcrblFxckwxUEcrTHRXUTJyNjArZzdZNEU0OSs5?=
 =?utf-8?B?NnRsRlhScXBHK1BkTmN1cmpPRTlabnJ4dWNFYUVrVDJaOXlWY3NwcHBreEZl?=
 =?utf-8?B?Y2NrTFVRQkVtMVRDOEtCWTNzdjZwUS92OVJvUlYyZy9ZdFh6VEVWeWJOazM5?=
 =?utf-8?B?aE8wVUhiK2VGcmU0NlFCYVpkc3prU0RhUlpoNlBkaTZkV1BSWFJPVHk1S1d0?=
 =?utf-8?B?SnFFeUUxcW9sME5keU9lWjVsT0t1SVJOc3FvNUxHWU14TllzZ2JsMXBHR0tu?=
 =?utf-8?B?WFNNZzhRNEZYM2Q2NkFxenllbWROMjlwbm5vcUNaSWxFQkpIQ2dyc3VxTFUx?=
 =?utf-8?B?TDM4MmJMSHlHTW5LQll0Ulh4T1dleXliT0RJSUpBWFduOGVoYktoRzRtcC9q?=
 =?utf-8?B?YVVrRWM4dFBsM0crc1huY2ZTaU8vb1NsOHpPeGdQbnI2dWd4cXBvK2NnREl0?=
 =?utf-8?B?NnRCVTV2S2YzWG51TkJZOEJaMTJaQTlqUjBKcUxpbWlESWlzL1hReldGN1Nu?=
 =?utf-8?B?eFVMWkVpQXpPRFRDUEg5NjRZVG9mUG9Fa0Ura0xXV2tPMDc0bU9vY1M3S3or?=
 =?utf-8?B?dkx5NkZZR2N0TjZkUmpUdHplQTdoanJHUnBONURVdUVuak96Q0ZWRGlFTnhH?=
 =?utf-8?B?OXFoU3doMURjaXhSMnZ5MEY5QWJrRjVkR2g0dE5wOXNLQ2I0NHhPNDZnY0Qy?=
 =?utf-8?B?K3VPODJnajNZMjh5NVI4TmFybmM3SFM0ZmxWc2lLenlPTFVWZ3NNN0ZCVlRq?=
 =?utf-8?B?bVJLU0FsS0JCNGZlSkFxZXV4RlJTaVRxQ3V4NVFOb2xDa1lMcmtZenZvOWpo?=
 =?utf-8?B?TnAwV3hQK0NVNmJnODFrWmIwejNqUzl4em1lYXJ1eGdVQS9NV0x2cGdEaGNo?=
 =?utf-8?B?cCt5a3dXUHhBYXpvb29sZ1paR2w0N0s1cFJMYTB0NnlCNFVKNnFhS1BnTXFi?=
 =?utf-8?B?a1B4c0R4Uit4d0tSWDRqN1hiU3RxSEY4TS9tTDA4d0tyN2FxWktwMWcrMDhm?=
 =?utf-8?B?TzI0NnpFZ0E1OVlLRUxvUWVvbnBFVFZCVUp0d283YlppOTNKa2UwakV4cW9n?=
 =?utf-8?B?OHB0VUtZMW5rajRKNlk5c1RsNTFGSFdmcmlKK2lhbzZ5cXh5dHdJblVKc2F3?=
 =?utf-8?B?N1Z1ZHUrYTZyWldUaGJmSjBRZGxEK2MvMU02dXl4aTl2NjJYUmxQdVMrUlg0?=
 =?utf-8?Q?xqFq/Z4bv/tVE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A8D5CE31557F094FAF7B7B61B6C138BC@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d08397f-5e95-4a3d-6f33-08d8b437c03f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2021 00:44:41.1890
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 10QTt6PReX3dEwBL9SeuDs+NaQQe87+GGky+Z9lNOeZ8aNwof9Z3HwUxw1C9El0Y64jDfyTusAvlsOF+7lvy4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4017
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCkpvaG4gU3R1bHR6IHdyb3RlOg0KPiBPbiBGcmksIEphbiA4LCAyMDIxIGF0IDQ6MjYg
QU0gRmVsaXBlIEJhbGJpIDxiYWxiaUBrZXJuZWwub3JnPiB3cm90ZToNCj4+DQo+PiBIaSwNCj4+
DQo+PiBKb2huIFN0dWx0eiA8am9obi5zdHVsdHpAbGluYXJvLm9yZz4gd3JpdGVzOg0KPj4+IEZy
b206IFl1IENoZW4gPGNoZW55dTU2QGh1YXdlaS5jb20+DQo+Pj4NCj4+PiBKdXN0IHJlc2VuZGlu
ZyB0aGlzLCBhcyBkaXNjdXNzaW9uIGRpZWQgb3V0IGEgYml0IGFuZCBJJ20gbm90DQo+Pj4gc3Vy
ZSBob3cgdG8gbWFrZSBmdXJ0aGVyIHByb2dyZXNzLiBTZWUgaGVyZSBmb3IgZGVidWcgZGF0YSB0
aGF0DQo+Pj4gd2FzIHJlcXVlc3RlZCBsYXN0IHRpbWUgYXJvdW5kOg0KPj4+ICAgaHR0cHM6Ly91
cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvQ0FMQXF4TFhk
bmFVZkpLeDBhTjl4V3d0ZldWak1XaWdQcHkyYXFzTmo1Nnl2bmJVODBnQG1haWwuZ21haWwuY29t
L19fOyEhQTRGMlI5R19wZyFMTnp1cHJBZWctTzgwU2dvbFlrSWtXNC1uZS1NLXlMV0NEVVk5TXln
QUlyUUMzOThaNmdSSjl3bnNubHFkM3ckIA0KPj4+DQo+Pj4gV2l0aCB0aGUgY3VycmVudCBkd2Mz
IGNvZGUgb24gdGhlIEhpS2V5OTYwIHdlIG9mdGVuIHNlZSB0aGUNCj4+PiBDT1JFSURMRSBmbGFn
IGdldCBzdHVjayBvZmYgaW4gX19kd2MzX2dhZGdldF9zdGFydCgpLCB3aGljaA0KPj4+IHNlZW1z
IHRvIHByZXZlbnQgdGhlIHJlc2V0IGlycSBhbmQgY2F1c2VzIHRoZSBVU0IgZ2FkZ2V0IHRvDQo+
Pj4gZmFpbCB0byBpbml0aWFsaXplLg0KPj4+DQo+Pj4gV2UgaGFkIHNlZW4gb2NjYXNpb25hbCBp
bml0aWFsaXphdGlvbiBmYWlsdXJlcyB3aXRoIG9sZGVyDQo+Pj4ga2VybmVscyBidXQgd2l0aCBy
ZWNlbnQgNS54IGVyYSBrZXJuZWxzIGl0IHNlZW1lZCB0byBiZSBiZWNvbWluZw0KPj4+IG11Y2gg
bW9yZSBjb21tb24sIHNvIEkgZHVnIGJhY2sgdGhyb3VnaCBzb21lIG9sZGVyIHRyZWVzIGFuZA0K
Pj4+IHJlYWxpemVkIEkgZHJvcHBlZCB0aGlzIHF1aXJrIGZyb20gWXUgQ2hlbiBkdXJpbmcgdXBz
dHJlYW1pbmcNCj4+PiBhcyBJIGNvdWxkbid0IHByb3ZpZGUgYSBwcm9wZXIgcmF0aW9uYWwgZm9y
IGl0IGFuZCBpdCBkaWRuJ3QNCj4+PiBzZWVtIHRvIGJlIG5lY2Vzc2FyeS4gSSBub3cgcmVhbGl6
ZSBJIHdhcyB3cm9uZy4NCj4+Pg0KPj4+IEFmdGVyIHJlc3VibWl0dGluZyB0aGUgcXVpcmssIFRo
aW5oIE5ndXllbiBwb2ludGVkIG91dCB0aGF0IGl0DQo+Pj4gc2hvdWxkbid0IGJlIGEgcXVpcmsg
YXQgYWxsIGFuZCBpdCBpcyBhY3R1YWxseSBtZW50aW9uZWQgaW4gdGhlDQo+Pj4gcHJvZ3JhbW1p
bmcgZ3VpZGUgdGhhdCBpdCBzaG91bGQgYmUgZG9uZSB3aGVuIHN3aXRjaGluZyBtb2Rlcw0KPj4+
IGluIERSRC4NCj4+Pg0KPj4+IFNvLCB0byBhdm9pZCB0aGVzZSAhQ09SRUlETEUgbG9ja3VwcyBz
ZWVuIG9uIEhpS2V5OTYwLCB0aGlzDQo+Pj4gcGF0Y2ggaXNzdWVzIEdDVEwgc29mdCByZXNldCB3
aGVuIHN3aXRjaGluZyBtb2RlcyBpZiB0aGUNCj4+PiBjb250cm9sbGVyIGlzIGluIERSRCBtb2Rl
Lg0KPj4+DQo+Pj4gQ2M6IEZlbGlwZSBCYWxiaSA8YmFsYmlAa2VybmVsLm9yZz4NCj4+PiBDYzog
VGVqYXMgSm9nbGVrYXIgPHRlamFzLmpvZ2xla2FyQHN5bm9wc3lzLmNvbT4NCj4+PiBDYzogWWFu
ZyBGZWkgPGZlaS55YW5nQGludGVsLmNvbT4NCj4+PiBDYzogWW9uZ1FpbiBMaXUgPHlvbmdxaW4u
bGl1QGxpbmFyby5vcmc+DQo+Pj4gQ2M6IEFuZHJ6ZWogUGlldHJhc2lld2ljeiA8YW5kcnplai5w
QGNvbGxhYm9yYS5jb20+DQo+Pj4gQ2M6IFRoaW5oIE5ndXllbiA8dGhpbmhuQHN5bm9wc3lzLmNv
bT4NCj4+PiBDYzogSnVuIExpIDxsaWp1bi5rZXJuZWxAZ21haWwuY29tPg0KPj4+IENjOiBNYXVy
byBDYXJ2YWxobyBDaGVoYWIgPG1jaGVoYWIraHVhd2VpQGtlcm5lbC5vcmc+DQo+Pj4gQ2M6IEdy
ZWcgS3JvYWgtSGFydG1hbiA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+DQo+Pj4gQ2M6IGxp
bnV4LXVzYkB2Z2VyLmtlcm5lbC5vcmcNCj4+PiBTaWduZWQtb2ZmLWJ5OiBZdSBDaGVuIDxjaGVu
eXU1NkBodWF3ZWkuY29tPg0KPj4+IFNpZ25lZC1vZmYtYnk6IEpvaG4gU3R1bHR6IDxqb2huLnN0
dWx0ekBsaW5hcm8ub3JnPg0KPj4+IC0tLQ0KPj4+IHYyOg0KPj4+ICogUmV3b3JrIHRvIGFsd2F5
cyBjYWxsIHRoZSBHQ1RMIHNvZnQgcmVzZXQgaW4gRFJEIG1vZGUsDQo+Pj4gICByYXRoZXIgdGhl
biB1c2luZyBhIHF1aXJrIGFzIHN1Z2dlc3RlZCBieSBUaGluaCBOZ3V5ZW4NCj4+Pg0KPj4+IHYz
Og0KPj4+ICogTW92ZSBHQ1RMIHNvZnQgcmVzZXQgdW5kZXIgdGhlIHNwaW5sb2NrIGFzIHN1Z2dl
c3RlZCBieQ0KPj4+ICAgVGhpbmggTmd1eWVuDQo+PiBCZWNhdXNlIHRoaXMgaXMgc3VjaCBhbiBp
bnZhc2l2ZSBjaGFuZ2UsIEkgd291bGQgcHJlZmVyIHRoYXQgd2UgZ2V0DQo+PiBUZXN0ZWQtQnkg
dGFncyBmcm9tIGEgZ29vZCBmcmFjdGlvbiBvZiB0aGUgdXNlcnMgYmVmb3JlIGFwcGx5aW5nIHRo
ZXNlDQo+PiB0d28gY2hhbmdlcy4NCj4gSSdtIGhhcHB5IHRvIHJlYWNoIG91dCB0byBmb2xrcyB0
byB0cnkgdG8gZ2V0IHRoYXQuIFRob3VnaCBJJ20NCj4gd29uZGVyaW5nIGlmIGl0IHdvdWxkIGJl
IGJldHRlciB0byBwdXQgaXQgYmVoaW5kIGEgZHRzIHF1aXJrIGZsYWcsIGFzDQo+IG9yaWdpbmFs
bHkgcHJvcG9zZWQ/DQo+ICAgIGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwczovL2xv
cmUua2VybmVsLm9yZy9sa21sLzIwMjAxMDIxMTgxODAzLjc5NjUwLTEtam9obi5zdHVsdHpAbGlu
YXJvLm9yZy9fXzshIUE0RjJSOUdfcGchTE56dXByQWVnLU84MFNnb2xZa0lrVzQtbmUtTS15TFdD
RFVZOU15Z0FJclFDMzk4WjZnUko5d25SV0lUWmZjJCANCj4NCj4gVGhhdCB3YXkgZm9sa3MgY2Fu
IGVuYWJsZSBpdCBmb3IgZGV2aWNlcyBhcyB0aGV5IG5lZWQ/DQo+DQo+IEFnYWluLCBJJ20gbm90
IHRyeWluZyB0byBmb3JjZSB0aGlzIGluIGFzLWlzLCBqdXN0IG1vc3RseSBzZW5kaW5nIGl0DQo+
IG91dCBhZ2FpbiBmb3IgZGlzY3Vzc2lvbiB0byB1bmRlcnN0YW5kIHdoYXQgb3RoZXIgYXBwcm9h
Y2ggbWlnaHQgd29yay4NCj4NCj4gdGhhbmtzDQo+IC1qb2huDQoNCkEgcXVpcmsgd291bGQgaW1w
bHkgc29tZXRoaW5nIGlzIGJyb2tlbi9kaXZlcmdlZCBmcm9tIHRoZSBkZXNpZ24gcmlnaHQ/DQpC
dXQgaXQncyBub3QgdGhlIGNhc2UgaGVyZSwgYW5kIGF0IGxlYXN0IHRoaXMgaXMgbmVlZGVkIGZv
ciBIaUtleTk2MC4NCkFsc28sIEkgdGhpbmsgUm9iIHdpbGwgYmUgb2sgd2l0aCBub3QgYWRkaW5n
IDEgbW9yZSBxdWlyayB0byB0aGUgZHdjMw0KZGV2aWNldHJlZS4gOikNCg0KQlIsDQpUaGluaA0K
DQo=

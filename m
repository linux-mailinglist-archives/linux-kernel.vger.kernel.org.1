Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 403282FDE89
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 02:12:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731959AbhAUBLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 20:11:12 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:48462 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390628AbhAUBB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 20:01:56 -0500
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id E701AC00B5;
        Thu, 21 Jan 2021 01:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1611190838; bh=9qfGxGlI+VLIfs/OGV+2u9ZwFdt0UJCRIj99jYJK7/0=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=C9x5EShNdMRFOVL8N4Et7YI56rqyPEq3QlRMs0LuKTuyuTTAPiXN2tKwWJUUNi3LJ
         GrnSe+EpZnn5ReJnP61zl+34XEhyHiPZDAUEFys4EqKRdC/2M1WhdOiRQkkS7qTDGh
         7/SDcIn9ofj1j/lXk6O4AOp1k7SRtnyQ39bx0NTXL66oyC0MUeHudYKmxhK7BQ+9lH
         MTyNVJ2/mVtWyW2Ai1ZYfG8LNC1qegM+stwlD8OMLVnGWmKLD6rWRGKIacPlpTTva2
         a6HszpaJbzGdPdE6dU5Yx3LNyLolUjniBGXtVSKhczmVVCoREkeI8Z/NDbc+p9rB/n
         JNUpoBhakYz9g==
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id B8D14A009C;
        Thu, 21 Jan 2021 01:00:36 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "GlobalSign Organization Validation CA - SHA256 - G3" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id C7E6240032;
        Thu, 21 Jan 2021 01:00:35 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="c3n+Nsqe";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GNyFpF57Set1NGMvoW+pd+uH18Yqo8Sv8Okap2h5ke8ce97VC3CTKCN1o7g5cAZSZ0yl3bi6de3eoaOmvL3F4EZaQEe/t8T1Ea+gklATdckeVhD5pBuYOk2jovrDK3LW9JPdfNIWf0RTK3x0Ehr6CfxVg2+tTRM8nozXxgugLptJclDuUHsvwKksRhpg87jdV6ab+BtLavP5CxUjiDGOG5Av9oNuQpbuXzfkOmgPZnZLdnSMvnxmKjH3+Cgw+DxeiC9mJxsrFvhs4Uq6AwsEFp3xpMMPdSdnqkF1KYWUJ5WSPEWfSWTqW15/xaHz/vDupt1y2qvWPPsjkbnTzmTn3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9qfGxGlI+VLIfs/OGV+2u9ZwFdt0UJCRIj99jYJK7/0=;
 b=ITfN7yBHYt5B8aQG6Ef+7gxXap7FaIwdxvRAGQWWLSgZHOiVJZ+BJb41/LvgDmfje2cCWmypLMNuyYGSqW3VTdWwtsXpbWbDAzZBo6PfW1ttdeEVN2tae4pxkHRxQQU5XsFtEQ0WlBksFd1TEMeZPW4xDfPgXHgFIFdMu7p1Qy6iJTN9Gi3XcGCIYGxQYpL1ETiglRtM5Ws2bW9A/8S8BYR16DG3Fd1LWolrOo26RtUEUmeYnRIfSEHe1y2OVsjdNBMJefr6s33wAqvXpyEpW3qG5RpflDy4RgsM1+9XupaEtuwvx/m9vWxMwJr83VSRxFlqYslO84lPMsbyEKfz+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9qfGxGlI+VLIfs/OGV+2u9ZwFdt0UJCRIj99jYJK7/0=;
 b=c3n+NsqeLpRiJxKSvSOqVxMheHLtn9YfMkEVCJpkDsTp1QRMcPdCwE4/PqiUnX9d9YvsLlOIBV3JjaDayJMed83vje8H4SRQl1jZPk2juqP450EHcuKUsmcX/5tAR4LyLC6yQ6elxRpcyXd/1I6c9CzWaqX8JaFwDBH3ikZUsXU=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by BYAPR12MB4598.namprd12.prod.outlook.com (2603:10b6:a03:10d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12; Thu, 21 Jan
 2021 01:00:32 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::895b:620d:8f20:c4d6]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::895b:620d:8f20:c4d6%6]) with mapi id 15.20.3763.014; Thu, 21 Jan 2021
 01:00:32 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Daehwan Jung <dh10.jung@samsung.com>,
        Felipe Balbi <balbi@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: usb: dwc3: gadget: skip pullup and set_speed after suspend
Thread-Topic: usb: dwc3: gadget: skip pullup and set_speed after suspend
Thread-Index: AQHW7uAMwMad0LOTNkG9Sahz41re36oxQ+IA
Date:   Thu, 21 Jan 2021 01:00:32 +0000
Message-ID: <fbde7781-8eef-ab3a-a339-8a2f61ca83be@synopsys.com>
References: <CGME20210120035123epcas2p2048f6d9896bd21f19d939a56fe0b6610@epcas2p2.samsung.com>
 <1611113968-102424-1-git-send-email-dh10.jung@samsung.com>
In-Reply-To: <1611113968-102424-1-git-send-email-dh10.jung@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
authentication-results: samsung.com; dkim=none (message not signed)
 header.d=none;samsung.com; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [98.248.94.126]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 76271f9c-6325-4716-40eb-08d8bda7f446
x-ms-traffictypediagnostic: BYAPR12MB4598:
x-microsoft-antispam-prvs: <BYAPR12MB4598BD916C16D92C2DBB024EAAA19@BYAPR12MB4598.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TENiU94pp+cayM5vZlHBocL8kXrr0Ztl65L+vrJ+bFK4l4FkT7vCd0aHktQqIjA5w9k0RGt8sluDf94diIiwYx3dI+su0doFEwpArCVCNbAn88Q1gLIM00A56ZVDIma2dt0lhAji3bstjjLm84VMyLZSzHq0vkHPgQ8R4IP95DNuBA08gZN7ASqolunXMXXD6fmQUaqH/TRDFxYsMIP7Inwxgh6k9fabP31yt/t5IihZ5U/rRgqIXVIeL90E0nhNHdTiHG/6zcjgAw7v6o05VXxYXIwzsbP073rlJQW8wL/w8RRyjrt6oUs/FBHB8opnp6lykdIABmjKw+eBVp0Zv1f6r0mr8lrIL8wwe7kcth/uwgaoiw9l/nK9Ecyr1mK7lulu05YIw7ePIHtWxKf2oBOEczFsvzH2TuCijiwMnfDzJf1B4Y/j2blpzWdGxQ64j7ZftoGGE+t0o3VGGIOHNtMBe3d0dWKB/6ZoEPLIJu4etwMbrI/v6e42wO3M5WlX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(136003)(366004)(346002)(376002)(36756003)(71200400001)(8936002)(66556008)(2616005)(316002)(110136005)(54906003)(4326008)(8676002)(5660300002)(26005)(66946007)(64756008)(186003)(76116006)(66476007)(66446008)(86362001)(478600001)(31696002)(15650500001)(6486002)(31686004)(2906002)(83380400001)(6512007)(6506007)(43740500002)(45980500001)(309714004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?Yy9TYVVLemMwRGcrRHFrcWhhdEZFWk96WHpaYk13REhjZDBkMGcyd2p0RVhI?=
 =?utf-8?B?WW5zY2V0YzM5QzBqMVNEUWpnYkM1Y3RsQlo5S3ZwREdMbThvNmhrQi9VM0Rq?=
 =?utf-8?B?Q2YzK2tvTVYxWTlvYWNQZHRjb1BLWnFCOGNPd1p5Rnd3ejlBWUFBdzc4d1Fy?=
 =?utf-8?B?cWtMLzV4bUVXQ2hidy9ueXNwVDlIamY0dkFONnY1UTJQYThsYjFMOHlRSzhX?=
 =?utf-8?B?NzN1Q1o4c3pYaGlMNXdMaG0wYzQyV2xsZ1o5Uk5QSENuV0pJZUd0ZkxRSzl5?=
 =?utf-8?B?VmxoMkJoa2Z5UEliMWFmQ1BsMzN3THZaNmNZck9NYnZsNFpKNDArb3ZsRWFq?=
 =?utf-8?B?NExyUHBnS3BocVpiRThlNlQzZjNOa0F0ZHZiRGh3S0NaQklvbkE3N21hNlY3?=
 =?utf-8?B?MTlFclA2NUs5UkUzbGEzL3ZVQUU1SXhwSDNScFVZMkl6Z3kyVXRxSjJwT1l1?=
 =?utf-8?B?QkZ2dVFWTURpTlRIdDE5S2liMndJWCtyVzdncnphRzRBWVFVNzd6T3VoL3Jm?=
 =?utf-8?B?L2pVd1ZtN1ZNd3NBSmF1cFRFVU8rK3EwdXFnd2tZVmJvcVZrNEdha2ZPUFVn?=
 =?utf-8?B?ekNNSG5vN0pXckRNeU5pWGNNUmUxbmFnRnRzcHFpbDRMaVMyVjl4eVByaHdI?=
 =?utf-8?B?SFc3TDdmSXVtaUI3TGczVXJnWTV0L0VLMWNXeC9XNzN5VXVXcC82Zk5uOG5p?=
 =?utf-8?B?WWNEVDE4U25oUmhnU1B0MEw0YmdCTysxK0VDYm13UWV0ck8xS25IU2JnaXI5?=
 =?utf-8?B?cWduL3FXaHorc2ZldkFoQnM2dWJMcDF6K3c3WnMwS3h6aEczaFdsbnU0c0ZT?=
 =?utf-8?B?ZGVaaDFKaVRZbGhTUEhUTDFqUnBQUkYzUE0vMDlVdUdGaEhsSzdnYk5mWEpu?=
 =?utf-8?B?Rk92L0JkRzBwc09IdHdlWlo2eWFTRk82V2ROUUM1SnpTUGdlWk5ZaitYbWxT?=
 =?utf-8?B?Y3FZbDBPR09hb2VWN2ZPQ2NDb3NXOWxHa2NjUmZCZnlkSXFPbkpjN1hMUzUx?=
 =?utf-8?B?Sm9FanplclJUbmxUZ2dod1doY2FLT0hXQ3gzTVdERVNBdktWTC9pdlRCTU45?=
 =?utf-8?B?Z0J0TnFYcGF0czNBbUQvc1lFdzllQ21CNVYyTzhtK1pQclorNDVLU3piU3J1?=
 =?utf-8?B?cHlIc0JmdVkwdk1YcFZoVWU5ZnNCbUo4T04wYnNyclNhNDRQSnZtRHM2bTRv?=
 =?utf-8?B?UVR0VW5KZ0gyNWZUQ2Q3WWZVbFU5RzNOZ0pLbm1zcDk4c1FLMXNhOWNjb2pC?=
 =?utf-8?B?TlE5VlJzL212SUdNNFhZc3RXUDdMWk5pZ0o2ZW1rS3NpazdOK284SGtXaEhJ?=
 =?utf-8?Q?5cgzwh1a5ArLQ=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <BFDCA8BF32BD374DBF9093381F5620D3@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76271f9c-6325-4716-40eb-08d8bda7f446
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2021 01:00:32.7758
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iMMY2PxzmpHUKJOb2uol3OMFlPoH0KBUw8/WxSYBV+fSLjAXvWz8i1mIxiT1LdY/a7ZgMZLfdFroMI1wrS0Xnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4598
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCkRhZWh3YW4gSnVuZyB3cm90ZToNCj4gU29tZXRpbWVzIGR3YzNfZ2FkZ2V0X3B1bGx1
cCBhbmQgZHdjM19nYWRnZXRfc2V0X3NwZWVkIGFyZSBjYWxsZWQgYWZ0ZXINCj4gZW50ZXJpbmcg
c3VzcGVuZC4gVGhhdCdzIHdoeSBpdCBuZWVkcyB0byBjaGVjayB3aGV0aGVyIHN1c3BlbmQNCj4N
Cj4gMS4gZHdjMyBzZW5kcyBkaXNjb25uZWN0IHVldmVudCBhbmQgdHVybiBvZmYuIChzdXNwZW5k
KQ0KPiAyLiBQbGF0Zm9ybSBzaWRlIGNhdXNlcyBwdWxsdXAgb3Igc2V0X3NwZWVkKGUuZy4sIGFk
YmQgY2xvc2VzIGZmcyBub2RlKQ0KPiAzLiBJdCBjYXVzZXMgdW5leHBlY3RlZCBiZWhhdmlvciBs
aWtlIElUTU9OIGVycm9yLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBEYWVod2FuIEp1bmcgPGRoMTAu
anVuZ0BzYW1zdW5nLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jIHwg
NiArKysrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKykNCj4NCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMgYi9kcml2ZXJzL3VzYi9kd2MzL2dhZGdl
dC5jDQo+IGluZGV4IGVlNDQzMjEuLmQ3ZDQyMDIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNi
L2R3YzMvZ2FkZ2V0LmMNCj4gKysrIGIvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KPiBAQCAt
MjA5Myw2ICsyMDkzLDkgQEAgc3RhdGljIGludCBkd2MzX2dhZGdldF9wdWxsdXAoc3RydWN0IHVz
Yl9nYWRnZXQgKmcsIGludCBpc19vbikNCj4gIAl1bnNpZ25lZCBsb25nCQlmbGFnczsNCj4gIAlp
bnQJCQlyZXQ7DQo+ICANCj4gKwlpZiAocG1fcnVudGltZV9zdXNwZW5kZWQoZHdjLT5kZXYpKQ0K
PiArCQlyZXR1cm4gMDsNCj4gKw0KPiAgCWlzX29uID0gISFpc19vbjsNCj4gIA0KPiAgCS8qDQo+
IEBAIC0yNDAzLDYgKzI0MDYsOSBAQCBzdGF0aWMgdm9pZCBkd2MzX2dhZGdldF9zZXRfc3BlZWQo
c3RydWN0IHVzYl9nYWRnZXQgKmcsDQo+ICAJdW5zaWduZWQgbG9uZwkJZmxhZ3M7DQo+ICAJdTMy
CQkJcmVnOw0KPiAgDQo+ICsJaWYgKHBtX3J1bnRpbWVfc3VzcGVuZGVkKGR3Yy0+ZGV2KSkNCj4g
KwkJcmV0dXJuOw0KPiArDQo+ICAJc3Bpbl9sb2NrX2lycXNhdmUoJmR3Yy0+bG9jaywgZmxhZ3Mp
Ow0KPiAgCXJlZyA9IGR3YzNfcmVhZGwoZHdjLT5yZWdzLCBEV0MzX0RDRkcpOw0KPiAgCXJlZyAm
PSB+KERXQzNfRENGR19TUEVFRF9NQVNLKTsNCg0KVGhpcyBpcyBhbHJlYWR5IGFkZHJlc3NlZCBp
biBXZXNsZXkgQ2hlbmcncyBwYXRjaGVzLiBDYW4geW91IHRyeSB0aGUNCmxhdGVzdCBjaGFuZ2Vz
IG9mIERXQzMgaW4gR3JlZydzIHVzYi1uZXh0IGJyYW5jaD8NCg0KVGhhbmtzLA0KVGhpbmgNCg==

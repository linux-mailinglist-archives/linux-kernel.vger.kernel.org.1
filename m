Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F08B12EFAED
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 23:15:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbhAHWO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 17:14:59 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:53858 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725763AbhAHWO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 17:14:58 -0500
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 52F25C00D3;
        Fri,  8 Jan 2021 22:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1610144037; bh=MvJXiy9JCSI/sduVG+fGkirdfvvpYKy4GM5oKJ2QyjE=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=ktV3B/Vd60j29nP9hxiWlq1FtKOABS5+t3B9/0hwvdSM1wIqnVn1BQ2O/FovkURId
         ZN5rttI+GR3bOA16lUkaL3prDGCpDYI7dCDWWuRbiIvie25U3ZCjrd3EPmOYYEm54r
         OUSMwt6i7DJVIijMNgfpTPsvfkp3dUUppNtFyjJinmEVomdza8KWgHamW1QzcOD1gC
         OnULv3iOoOqLaZPk0eoByJ1Y2N8SsFVvqFyIQM9XGjQI/SuIqf6p//v5oLanRABzpf
         nrsmjNzHae55XQTBPXKlKXz+C6bJRTczqrBkAO480rCHbbqKPW6wK13IcWgvrnWWcT
         T2Lq2TbFyiVKQ==
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 63F75A005E;
        Fri,  8 Jan 2021 22:13:56 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "GlobalSign Organization Validation CA - SHA256 - G3" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 0DC39400BB;
        Fri,  8 Jan 2021 22:13:56 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="Hlo0ABrL";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TMft7kQCZru8Qt9UeJyjmZSLEO0Oam4tLDqF4MsAOYoQbDOZ3ifxefQm86SJW1TlNx2U7+g15vUJg0EyCVVufJCEp/cqd6/DSSo1HzsSZtqbkLcbWM1u+tsBPPnE5xKjtnkitmzYmZ7aqm5augNnorybCpG+NSWcLW6lHd63nY9Y860E2SexTaLc4r9yaFJTNHWxJbSdgURm9gSMq62P4cIUBJq4rMSDdoW3xvcdLAysi6m46GuWRofXZqs+YYTf2mAvSAI/LbQP5JsLrOJhmAQR8D4Qfi0wV/c/0da1gPf1HDUaxu+pT99SUcTKyFC6munXjW5kE/PHA4RvKRePdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MvJXiy9JCSI/sduVG+fGkirdfvvpYKy4GM5oKJ2QyjE=;
 b=Ynw320ms7CVicWUWqzo6qsYzPgZIwyiRpUfmrwWk2FcgbQ/4s8pmb8BavOV79Izr5hC1YEempgtawdIsT33IrCIotKoFzfIRag9JbGOlY0Whos0P7nkVlOREdcdPjahEgcdjQO60I4WfM59B/tXDGmInHG1PPKYlWeMopkITg6MrVq4aHyGx/hsH7teMMYdzKvqIOyXNRu4rtwQtXifPFMakSFWJxwNvPZJE0QgeUi/jv2ao9bfs2tQdausQGLiCVDqMAtLN2w794kdTJKRMvDzAlvTRSj6DJBPBUuva7EXXRJ3CR5xA7UFe5+mX6ylMczFagviRA0fe7EIJjzznaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MvJXiy9JCSI/sduVG+fGkirdfvvpYKy4GM5oKJ2QyjE=;
 b=Hlo0ABrLDP7twckvrGNTs/QE+REjTmQDbG1yhXqwnZn4jgQ1VOAy/HcZVACyeIHWOJxX/T5VUbQBDY4upE2MnvtyHmh/u5FT1Iq1lo1RjLlp3JpsndXpGvooet4QURbkjcqraA4/Qei87NCM5+Zz1VQzmUSP7Bh4XnPAnq/JP9I=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by BY5PR12MB4178.namprd12.prod.outlook.com (2603:10b6:a03:20e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Fri, 8 Jan
 2021 22:13:54 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::895b:620d:8f20:c4d6]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::895b:620d:8f20:c4d6%6]) with mapi id 15.20.3742.009; Fri, 8 Jan 2021
 22:13:54 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC:     Felipe Balbi <balbi@kernel.org>,
        Wesley Cheng <wcheng@codeaurora.org>,
        "peter.chen@nxp.com" <peter.chen@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH 2/3] usb: gadget: composite: Split composite reset and
 disconnect
Thread-Topic: [PATCH 2/3] usb: gadget: composite: Split composite reset and
 disconnect
Thread-Index: AQHW3jcavZZjl2yfjUafWGuOXYrMeaoZDPEAgAQAA4CAAHOrAIAA2guA
Date:   Fri, 8 Jan 2021 22:13:54 +0000
Message-ID: <407e745e-8747-2fe7-3ffc-8a123398bd3e@synopsys.com>
References: <1609283011-21997-1-git-send-email-wcheng@codeaurora.org>
 <1609283011-21997-3-git-send-email-wcheng@codeaurora.org>
 <87k0srcyq7.fsf@kernel.org>
 <37f3412c-9e91-eb1e-3974-bb16546b4b39@synopsys.com>
 <X/giOFJLsx2E3krg@kroah.com>
In-Reply-To: <X/giOFJLsx2E3krg@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=synopsys.com;
x-originating-ip: [98.248.94.126]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f67d72e9-ff88-4dc1-03bc-08d8b422afe8
x-ms-traffictypediagnostic: BY5PR12MB4178:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB4178F444FBDACEBB1BFC2B79AAAE0@BY5PR12MB4178.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vGqqaY/5kBM5l6xiLwK+dZqBsH+4AioGIQrtxPJ46MCEsuDOqEihyLDeisVfrcNEXtG/vbaKH9s0j9Mr3/DX9cITzY4eDeCZLnVST3EQXgaEzC/4yDXYfaE7B4WunF9Ji11RiD1oEICCLg7hj1hZzu36+iib6sKLKFSGvhjzKF2dsUb7tyBch3CsCtO6WT+25gzkMH8q7L/1yYngGfwI2McOf0zgRMzborzqgy1Q6T2Zddku3iqpBB/MK5RHEM//mkQYH2mwqN+bWYklCr4h2+rRpKKrcJUfT0KnXQu8h183rN5zIAebnNWOJy1ohKSsPHzSGM3M78/+FQ/GzmUdzUvspVGM0x+5g8mfndyyMEEF2tw8mHJmTa//hynbU4WYSb7lcLT3ds9iVJNrWXWiv+/Lwd7rbFGlxkmrPaq48IwcF1Yb6HoM6iqUMFo0FlPexy+IjYpSrz7Vpw7xbYXyyOxI0F6i2RX41F2IFEsCWmg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(346002)(136003)(396003)(39860400002)(2616005)(66556008)(66476007)(64756008)(66446008)(31696002)(76116006)(66946007)(2906002)(186003)(478600001)(6486002)(54906003)(71200400001)(6506007)(26005)(8936002)(86362001)(8676002)(110136005)(4326008)(316002)(31686004)(6512007)(5660300002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?a0YrajAyMlh2NFFidHpPUVhuQmE2RDVYL2FPbHZRQmtiYUYxTUkyenl6clBE?=
 =?utf-8?B?bTFjU3Z0djZNa1Q4L3h5NnRvZkJoZFdTVWFxWkxkNFppdHduWm5UekN3M0dm?=
 =?utf-8?B?OHQ2a0lHd290MXp3THdPMmc3Ym1MbHZlaUVBaHBEVHNqclNKTTJGTlFaWXY5?=
 =?utf-8?B?ckNnZ2t4ZHQrbmUvMFZ6cWFSOHBkcHZJMkdHc1UzdDdMYWxCMTVkTGVscGJa?=
 =?utf-8?B?dmJkSjVhN2JGOHV2UHZkNVV5VEh4VjFSTzhmY1BibWNSRm5TNGxka0ZnUGJS?=
 =?utf-8?B?U01hWEg2eVNoc0FFR2M5b1huZGZxVjVEdDU2c0c2SjFqV2dwQWQ0REdDNHZy?=
 =?utf-8?B?cjFmUWlwWVZ5SlVDQVFvMGZ2ZUV6cTdhanQ0Mk1nRCtlQjdaaEFRK1VrYzZZ?=
 =?utf-8?B?WjZyNUtWTEJyaExoV054ZmlyVUlwMTJkOU1oYnY3VEFmU1dzL1UwTHBGTWxS?=
 =?utf-8?B?RCtibXl2NjYzUFhIaHVnUTFCajk5Vnhxb1dIbElIWWtrTGtreDZhWXF5ZFBG?=
 =?utf-8?B?eEVJOFVLTmhiblJHOXF5ellXaUUvNmlncG9KV1hqaVJDZWdrUmh2NjVXVW5W?=
 =?utf-8?B?cXB6MlJUdFZqUkdjQWQ1QUFyN0JTVzNvclRSajRyeHdFZDMwcngzWjRIVE9Y?=
 =?utf-8?B?dENNQkZjTGpaaklXakxGSjh0UUtRK2p6Vlh5Q1BJa252UnVGM0pJcm5VOHFL?=
 =?utf-8?B?RXJTazVoL3JROHlCMjJHbXYrL0N0RkQxRkE1NHZhWHprcW0za2xkSkVaZ0Rx?=
 =?utf-8?B?dndFMFBKZzhhdFJEQUVjZ3JURHFkZjF1eUNRQWMrUFpBL0d1N2VYeTVabE5z?=
 =?utf-8?B?UmF1VkZMMzA0Vm9BVEVuczdLemptY2tKQXlWRUxKRm9kNGFaTXdIMi9ZNXlP?=
 =?utf-8?B?VGkvYkczUGVuOTRpalgrUjNLcm1VRGFNb2daU3RFcDdLbFoyQy9MOVBlMDdE?=
 =?utf-8?B?alBZNkdEZlRkSHhZaGhtaDUwSVhUTElNVEhJWnJMajhFb0NGWWprNEdmcVRC?=
 =?utf-8?B?QktFRjlJY0xmNjFVWUZuS0tTWnBDYXIyVksxdHEybG42dzlKOUtJNTRBOWpt?=
 =?utf-8?B?dmEvNlR3eXZmL0xEK2xUdGVmOVlzdEk1L3YxV0NwbEx5K1FNM09Rc1RKbG92?=
 =?utf-8?B?RmJUS3NsZnhFUkxXekFZcmE3WDQrNjBNbytxcUFyYXpFSHp4Sm1yRFFxZ1VU?=
 =?utf-8?B?WTE4TmhOUmFCUUJabjFNS0FUZ3hmQVJqdXBFamNxQnNUNWpjYmtpVUhFR1NE?=
 =?utf-8?B?VGFUVkZhcG9xRFdhN25ZcnMvcmtSaGQ1MkxodWhsVCtrM0ZRWEpEa0xIT3lY?=
 =?utf-8?Q?DOG2aTnB5lc0Q=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B54B97A344A3A64099D46C939D3E8251@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f67d72e9-ff88-4dc1-03bc-08d8b422afe8
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2021 22:13:54.4691
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pIhTXYIdJ57mMbidyKzRvtIwTN4e9cYSjqkeVHQgFBAwxqb3cyuylfxpzswdjzCyKfF2jz/XmvWxJyg8pLN1aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4178
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmcgd3JvdGU6DQo+IE9uIEZyaSwgSmFuIDA4LCAyMDIx
IGF0IDAyOjE5OjMwQU0gKzAwMDAsIFRoaW5oIE5ndXllbiB3cm90ZToNCj4+IEhpIFdlc2xleSwN
Cj4+DQo+PiBGZWxpcGUgQmFsYmkgd3JvdGU6DQo+Pj4gSGksDQo+Pj4NCj4+PiBXZXNsZXkgQ2hl
bmcgPHdjaGVuZ0Bjb2RlYXVyb3JhLm9yZz4gd3JpdGVzOg0KPj4+PiArdm9pZCBjb21wb3NpdGVf
cmVzZXQoc3RydWN0IHVzYl9nYWRnZXQgKmdhZGdldCkNCj4+Pj4gK3sNCj4+Pj4gKwkvKg0KPj4+
PiArCSAqIFNlY3Rpb24gMS40LjEzIFN0YW5kYXJkIERvd25zdHJlYW0gUG9ydCBvZiB0aGUgVVNC
IGJhdHRlcnkgY2hhcmdpbmcNCj4+Pj4gKwkgKiBzcGVjaWZpY2F0aW9uIHYxLjIgc3RhdGVzIHRo
YXQgYSBkZXZpY2UgY29ubmVjdGVkIG9uIGEgU0RQIHNoYWxsIG9ubHkNCj4+Pj4gKwkgKiBkcmF3
IGF0IG1heCAxMDBtQSB3aGlsZSBpbiBhIGNvbm5lY3RlZCwgYnV0IHVuY29uZmlndXJlZCBzdGF0
ZS4NCj4+PiBUaGUgcmVxdWlyZW1lbnRzIGFyZSBkaWZmZXJlbnQsIHRob3VnaC4gSSB0aGluayBP
VEcgc3BlYyBoYXMgc29tZSBleHRyYQ0KPj4+IHJlcXVpcmVtZW50cyB3aGVyZSBvbmx5IDhtQSBj
YW4gYmUgZHJhd24gbWF4LiBZb3UgbmVlZCB0byBjaGVjayBmb3IgdGhlDQo+Pj4gb3RnIGZsYWcu
IE1vcmVvdmVyLCBVU0IzKyBzcGVjIGhhcyB1bml0cyBvZiAxNTBtQSBtZWFuaW5nIHRoZSBkZXZp
Y2UNCj4+PiBjYW4ndCBkcmF3IDEwMG1BIChJSVJDKS4NCj4+Pg0KPj4gV2Ugc2VlIGlzc3VlIHdp
dGggdGhpcyBwYXRjaCBzZXJpZXMuIEZvciBvdXIgZGV2aWNlIHJ1bm5pbmcgYXQgU1NQLCB0aGUN
Cj4+IGRldmljZSBjb3VsZG4ndCByZWNvdmVyIGZyb20gYSBwb3J0IHJlc2V0IGFuZCByZW1haW5l
ZCBpbiBlU1MuSW5hY3RpdmUNCj4+IHN0YXRlLg0KPj4NCj4+IFRoaXMgcGF0Y2ggc2VyaWVzIGlz
IGFscmVhZHkgaW4gR3JlZydzIHVzYi10ZXN0aW5nLiBQbGVhc2UgcmV2aWV3IGFuZA0KPj4gaGVs
cCBmaXggaXQuDQo+IFNob3VsZCBJIGp1c3QgcmV2ZXJ0IHRoaXM/ICBJJ2xsIGJlIGdsYWQgdG8g
ZHJvcCBpdC4NCj4NCj4gdGhhbmtzLA0KPg0KPiBncmVnIGstaA0KDQpVbmxlc3MgdGhlcmUncyBz
b21lIG90aGVyIGlzc3VlLCBsZXQncyBub3QgZG8gc28gYXMgaXQgc2VlbXMgdG8gYmUNCnJlbGF0
ZWQgdG8gbXkgSFcgc3RhYmlsaXR5IHRoYW4gYW55IFNXIGlzc3VlLiBTb3JyeSBmb3IgdGhlIG5v
aXNlLg0KDQpCUiwNClRoaW5oDQo=

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BEE02EA4A3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 06:04:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725838AbhAEFCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 00:02:54 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:37696 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725768AbhAEFCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 00:02:54 -0500
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id BB085C0099;
        Tue,  5 Jan 2021 05:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1609822913; bh=VY2Ir/l95n053dK2gs0RVVSFiAgd6WoZ01fen89dTKs=;
        h=From:To:CC:Subject:Date:From;
        b=Kf0xxUSEv1MYBylbT0lmMH+GwvphTpt8pr/EZj9E/KBD/oHC/vcuU4bz3TgGtIrYI
         7RU2mot92dsjSf95eS0fHFz8iZRBWcL9RPJEDwAPHIBdda4hGkurplHRpWN/TgERMJ
         5+AbkKwpeLycbjg0QrqbJlWt4Esp2uk+1gtk1Ke0SMy7VCNLxYMgMdyjXlnar1gxLU
         X4/mE4kZECqMWBuo5cfEuQkVVClZ/wNU6YezAewaBPr0cii+ZeSXDtdU67geLBBV0C
         WrUpmV23zO22lofw5B6yu5iFvH9Vh5UNsggjA3Y5+Y6qte8faXBdPVkMRj7gEbu63f
         gNUkvF5xbIRwA==
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 32B8EA0086;
        Tue,  5 Jan 2021 05:01:50 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "GlobalSign Organization Validation CA - SHA256 - G3" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 0CE17800C1;
        Tue,  5 Jan 2021 05:01:47 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=vgupta@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="KZ9gNFcs";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J+oqM8nSYNZ3xACLX7GyR5Bz52MBuDUpDOSsxpfTHGzNq1MgzDyiUT7N/cFdBTO0+vlxKcFryeAhmYSbG36TNSf1dd3QsRb8ey07VzDh/5D7yT87gMRj/D1PZZRg/MyX6ZLPtOkNbM++GoGGAdcEn6UNDNx9j+ftKM2c6ocixmU4zS0JzK4vdC+2gCpTrs+LwGAwiC9cODQSfy+t7QazNEKfhBf4Lwh/jZND6QJfQYKrS83d5oHPauYVnnOT53QnOSd1SazQU4rQAlzDlscdM6xHvRPwXlV/HBEg6Mwhz+p8jNC6QNmXna1Vpn6CrP6khONIIhw2Az6+F24+/HZOKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VY2Ir/l95n053dK2gs0RVVSFiAgd6WoZ01fen89dTKs=;
 b=SgrVGQEzqlPYzmDnH4ewlTi3dt7UIhdGPoQmFxd2nVXJzFyWwNmizT2RwNlQUNVbn4Bft+Go2XHX3uQSvyKoF3LjXTkdzQTShz2+qoepXShClWb7GjAyLvB/JFdbF4Yjlo+OGVwVNqRiGE5T4dG5s4m58urmCMwJxuwmWxOu38Q19DZOyRunt3qp7ypTIYmz/dUSzOaB0cTVxszKKTnyfD5/6QKd1ScE3YT4eWCF7OGEcueCUgE4erhK7RAr5WyGf1d8bIS60aJXkqsZIsLIBdmtveedkTCnfklF6HfnDGGs4flzigebOVnTrox3nb35ksAds3dK7G+l6jbFzmGjdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VY2Ir/l95n053dK2gs0RVVSFiAgd6WoZ01fen89dTKs=;
 b=KZ9gNFcsUi/iPBcO7THNYZzqHJAEHP+SyLGQ1VoJW1tKWn5M0jxVHTm0+4Mq7OsjIPdTVv0vkWA5L8d7dgptqST+NWPK78715Ih/GC/7G7reVMvimWr6d2UenDLE5QOH4OmHraeGTajccw4WuXuV+bXHk+a9OKCj4DKnfIs6ogo=
Received: from BYAPR12MB3479.namprd12.prod.outlook.com (2603:10b6:a03:dc::26)
 by BY5PR12MB3747.namprd12.prod.outlook.com (2603:10b6:a03:1ac::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.20; Tue, 5 Jan
 2021 05:01:46 +0000
Received: from BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::c0e3:82e9:33d2:9981]) by BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::c0e3:82e9:33d2:9981%6]) with mapi id 15.20.3721.024; Tue, 5 Jan 2021
 05:01:46 +0000
X-SNPS-Relay: synopsys.com
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     lkml <linux-kernel@vger.kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [GIT PULL] ARC updates for 5.11-rc3
Thread-Topic: [GIT PULL] ARC updates for 5.11-rc3
Thread-Index: AQHW4x/dHM0ejFsM6ECjA0VN0drGbQ==
Date:   Tue, 5 Jan 2021 05:01:45 +0000
Message-ID: <59b97fef-41fe-f520-6e3a-2d96958cc744@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
authentication-results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=synopsys.com;
x-originating-ip: [24.4.73.83]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e7e132b5-6486-4dda-bc91-08d8b1370071
x-ms-traffictypediagnostic: BY5PR12MB3747:
x-microsoft-antispam-prvs: <BY5PR12MB3747EE1696937B006E236D20B6D10@BY5PR12MB3747.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9qlbFKHiK/opkCXrKcGJAOaUB1/TaNGXEGN5TaELzD2fCyJlSOeElraaBa1fYM2xvTX/7Ov+n7MR9mX/xwqnsLfwHyLimZXFmK2ABAj7kp7NrjjT/qY+pDdhok3zPrxL9fXcGrTiCnRbPy+QT7w14WtJJUImMrRV1ygC4w66jfYuU8lv2QQX7Y6bxpUyLXP7J+7VUkqRgwFzrdGHIlCD1vOMvtG0RkJjFm1bhcrOhdteXiJk/Zjo6dy7XPNLgkXXx3dLFaMlKQuF8Sgm5bN9PfONvk1AqsLE4z+1yJ9CvgrwNh+5dHvkyvHZG9mi2DWDqoFcPdxJKjrgJPE27Fp28jgpCKF3PN8hkd80i25j0SNyRT0/u8xTJXxnuR8jXhZe04HITvHO3mVlEQJfh6r6Re5ON06ib524iu/RzrrPLzQOohMCWpsAdl7dVbd7Ka9NYTAPfBAjZ5N/KqQ8enUC9tl/4jC+ZcDoIr1IX0zTHC8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3479.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(39860400002)(136003)(366004)(346002)(76116006)(66946007)(66476007)(66556008)(8676002)(478600001)(86362001)(66446008)(15650500001)(2906002)(8936002)(54906003)(6512007)(316002)(4001150100001)(64756008)(6486002)(6506007)(2616005)(36756003)(6916009)(83380400001)(5660300002)(186003)(31686004)(4326008)(26005)(31696002)(71200400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?YVVraFE1WHZRM1pLUzkvV0YvYmFPTk5iNGVYWG9YSW9nTnluZWI1K3Fudkxh?=
 =?utf-8?B?VEZnLzByMmdFa3gxYm1scktmb3ZtSDdQM1Z6d2Q4QURyc0pJeTNETjNrenhG?=
 =?utf-8?B?SW9vTElKbFY1YTNwWXBsbDhKSWpwN01mTER6T28zRS93TVZrdUM3UTMxTVZw?=
 =?utf-8?B?SVZ3OVhlRVh2SWVuYlNPTnRKTE40NWtEWDdsY0E1ZFlEWXBiQVE5b05EUVpo?=
 =?utf-8?B?TWJta3RmdldyZWx3SkI1NElBRHFVMVlwSVM5OW4wbjVLbXJhRHVzTy82NmFx?=
 =?utf-8?B?Q2grWVN5TjM2bHppWW1yWktSR0hrcnZVcEZ6eEZRbkdyVjdoaEdqTXNTemNm?=
 =?utf-8?B?WWxYUnRpVEJGRm16UFgyeHBoMGJIditqYkQxdFNzaUZzak1mSmFpbzYxVXZo?=
 =?utf-8?B?OGlITjV6OC9jOGYxeGRuT1RxK1k2eG0xM3FMNnhGQUV4K1lBd242Sis1MVps?=
 =?utf-8?B?bThKejBxVElJSmRYbzA3eWJOWGRVWDR1cW4vR3cyUEhDUzBFbnkxNjlYSzdG?=
 =?utf-8?B?d2VReEt3c0JXZE5JcTQwbk9lQWdTVFlKOVc2aGJ5ZU1lb0p0enpjcnBVL2tk?=
 =?utf-8?B?elRIU0NJd0NiUlhteG5wNjNBc3ZoZnNmb1hMaEc0cHhLNHJTL2dOSk1sYndV?=
 =?utf-8?B?R2NNUVFnalJMRWd4ZzlpbnQ2WXMyaGpvZG5KbWtwb3RIRXhFQklIWmpaRm5I?=
 =?utf-8?B?SndxakZQVlByZG1tVUVCY2hGSW03RGVzenowaFdPZksrd283MnhmV21tb1hU?=
 =?utf-8?B?QmZwK0VIRlZya0c5ZDluQkVsWGFkY3V0K3ZJN1UzMHNEdExyQ2gwRHVkU1M0?=
 =?utf-8?B?NXZMa0hmSnZxbGk1RWQ3bktqbnY4RkNzMkd4OW0wcTc1NFVDS0o2ZUF5ckJE?=
 =?utf-8?B?SFdKUW9jdEEwMVNmUGYxRlZKVzE1UmpPbVN5NkZNdllhUzZneUZIbkxOcWRj?=
 =?utf-8?B?REF5UnlCbSthRGFQd1hEZFRWYUExd1FtR2pYai96cWtMRm9zMzVHdXhXYVBp?=
 =?utf-8?B?SG9NQTBLMlBiOFduMnRvcy80R0pCYWNia0dzT0R4cmFKS1p1NVBnejVMek5C?=
 =?utf-8?B?VHZwZFRvNGwrYmpTVmNMTkx3MTVsZWg5dTRVNjlIM2pSd1grdkVnbTl4azg1?=
 =?utf-8?B?KzRxL2dhbFo0WW1ONUt0dlo0K1NKWHFHTXJ6dHdWcm9WK0hyVUl6YXRZejBa?=
 =?utf-8?B?VWtyTldmNE1ZMEg5cmxXVlhqM2U0ZHVEdTYzWHZYYzFHb3NwVUE0UTJDVzJv?=
 =?utf-8?B?cS9kbSt3UnF5WUhLbENOYTlZRjY3RGRXQzI2clNYck9TTkZvRXhHemF1TXlv?=
 =?utf-8?Q?mpKYhCoDRKiig=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <8E4B8F99CF75E745AA52457DBC7704BD@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3479.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7e132b5-6486-4dda-bc91-08d8b1370071
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2021 05:01:46.0077
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WXVnyFP8EIk/QchNgCEfk7/SfHXdXXz30GXvP0zBwtvMPhaLGk2FLKIpy6X+GOQbE2+6bNz7J9XcJZx/B1ZuyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3747
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTGludXMsDQoNCkhhcHB5IE5ldyBZZWFyLiBTb3JyeSBmb3IgdGhlIGRlbGF5ZWQgbWVyZ2Ug
d2luZG93IG1hdGVyaWFsIC0gaG9saWRheXMgDQpnb3QgaW4gdGhlIHdheS4NCg0KVGhpbmdzIGFy
ZSBxdWlldGVyIG9uIHVwc3RyZWFtaW5nIGZyb250IGFzIHdlIGFyZSBtb3N0bHkgZm9jdXNpbmcg
b24gDQpBUkN2My9BUkM2NCBwb3J0Lg0KDQpQbGVhc2UgcHVsbC4NCg0KVGh4LA0KLVZpbmVldA0K
LS0tLS0tLS0tLS0tLS0tPg0KVGhlIGZvbGxvd2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdCBiNjUw
NTQ1OTc4NzJjZTNhZWZiYzZhNjY2Mzg1ZWFiZGY5ZTI4OGRhOg0KDQogICBMaW51eCA1LjEwLXJj
NiAoMjAyMC0xMS0yOSAxNTo1MDo1MCAtMDgwMCkNCg0KYXJlIGF2YWlsYWJsZSBpbiB0aGUgR2l0
IHJlcG9zaXRvcnkgYXQ6DQoNCiAgIGdpdDovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgv
a2VybmVsL2dpdC92Z3VwdGEvYXJjLmdpdC8gDQp0YWdzL2FyYy01LjExLXJjMw0KDQpmb3IgeW91
IHRvIGZldGNoIGNoYW5nZXMgdXAgdG8gM2E3MWU0MjMxMzNhNGIxMTY2ZmZhZmNiNGE3Y2ZhODdk
ZGVjYjkxMDoNCg0KICAgQVJDOiBidWlsZDogdXNlICQoUkVBREVMRikgaW5zdGVhZCBvZiBoYXJk
LWNvZGVkIHJlYWRlbGYgKDIwMjAtMTItMDEgDQoxNzoyNDowNSAtMDgwMCkNCg0KLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0K
QVJDIHVwZGF0ZXMgZm9yIDUuMTEtcmMzDQoNCiAgLSBidWlsZCBzeXN0ZW0gdXBkYXRlcyBmcm9t
IE1hc2FoaXJvIFlhbWFkYQ0KDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQpNYXNhaGlybyBZYW1hZGEgKDYpOg0KICAgICAg
IEFSQzogYnVpbGQ6IHJlbW92ZSBub24tZXhpc3RpbmcgYm9vdHBJbWFnZSBmcm9tIEtCVUlMRF9J
TUFHRQ0KICAgICAgIEFSQzogYnVpbGQ6IGFkZCB1SW1hZ2UubHptYSB0byB0aGUgdG9wLWxldmVs
IHRhcmdldA0KICAgICAgIEFSQzogYnVpbGQ6IGFkZCBib290X3RhcmdldHMgdG8gUEhPTlkNCiAg
ICAgICBBUkM6IGJ1aWxkOiBtb3ZlIHN5bWxpbmsgY3JlYXRpb24gdG8gYXJjaC9hcmMvTWFrZWZp
bGUgdG8gYXZvaWQgcmFjZQ0KICAgICAgIEFSQzogYnVpbGQ6IHJlbW92ZSB1bm5lZWRlZCBleHRy
YS15DQogICAgICAgQVJDOiBidWlsZDogdXNlICQoUkVBREVMRikgaW5zdGVhZCBvZiBoYXJkLWNv
ZGVkIHJlYWRlbGYNCg0KICBhcmNoL2FyYy9NYWtlZmlsZSAgICAgIHwgMjAgKysrKysrKysrKysr
Ky0tLS0tLS0NCiAgYXJjaC9hcmMvYm9vdC9NYWtlZmlsZSB8IDE4ICsrKystLS0tLS0tLS0tLS0t
LQ0KICAyIGZpbGVzIGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKyksIDIxIGRlbGV0aW9ucygtKQ0K

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A10D62F091B
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 19:52:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbhAJSuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 13:50:32 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:51234 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726263AbhAJSub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 13:50:31 -0500
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 0E3C0C0340;
        Sun, 10 Jan 2021 18:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1610304570; bh=0GvwsWHuAYSc1+yytyOLQwOV5MZdBXCPPwxSZrpCcRY=;
        h=From:To:CC:Subject:Date:From;
        b=Ce3kxgSQiKP1U4q50uqyHjmZiO15y6l//bpx9WEx0aahvEuvYdEDHvbfW6OGqwYfc
         hAAkzRkWAkLi1cdj5VSriof6ceZmhhhIKd/6VQ18RoB/WT09Hj/1Fv6F172YBqEjRC
         OExJTvvJpBo2kk7TH3THPoNWY3AzPZ7ofRd2zSmJRRqKOdqYaT2ixo4OFuardat7NC
         QVP2XEqvAQ5KTIpVTb+dIUQos7cB90IAmP39UZRCk1cTWgcCyGh+nOQTVqV25X4Nip
         SzkmNIxcfFPS8r3i4cx4Nthz2w+CZPJnbKp9VHPioUJK/ZoeAn0GBESz+nSEW9Mb5w
         lRadnEcoOk00A==
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id BB484A0081;
        Sun, 10 Jan 2021 18:49:25 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "GlobalSign Organization Validation CA - SHA256 - G3" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id BFBC440143;
        Sun, 10 Jan 2021 18:49:23 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=vgupta@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="IhGsZKYG";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eJeZPhXComzFSXr8dw1A2Xk2RCo+EGa7juA5r5K00N4BkRbqJbk9p6kj/TLTZxfQoQhDeZtac/VkSDAQRMPl2Ug63vUMg7X7VbjWl+F06gNP2i4jjpSiKZs+wThWXnNQgTtYv7JfWiHKsdnk2QDeWP7UYhoeRwKjNRFqsVk/wiXQvV+8q4SBfgTNuWpJ9PvnGqleB+fTGGVio90TMADRofrsE9YC2/viSpCs/pIucqu3/lvWJ9vizxqurq2imAQOEN8h/GsUvYBaHzt9OlEkS+ccehW5zIR+GLkhzLipa2lRFAHMllAckJZ1Zt55c0puXxjEaKkpfkcCIgfpVR/wUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0GvwsWHuAYSc1+yytyOLQwOV5MZdBXCPPwxSZrpCcRY=;
 b=DqJy4W/FtT3g6Gv1fZ5kvaKtXoUajawpyciQU2EhxHivTQiJmFIB6bUv290peRgTnhnnheSQMeDNuBaf3gDnVrvrSVJOpsZYOCXP8/46g/BP5MuCDLZp/+J1bUcTTDGu3TBXs/O0JDpL2q3oTMYnXY8MUrJAG/giJhuNlaEClzbMjpvYmgE9rRGleWJb2Le3FyWiLzphwojwfcbJU+WWadxH+AC786EZiCaQxkgXXR4T+ZrhH4DqWWIOthlHVpo/VmlOmmkvUw/aSdNO3BlltrCpb3FekTno2dCJgEGWf165WBHn57JW840yHpCVU5R6Ov4Fju8GI6kavMi6VejfhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0GvwsWHuAYSc1+yytyOLQwOV5MZdBXCPPwxSZrpCcRY=;
 b=IhGsZKYGlI8MVC0g9pXBAwfkIb6k35oG/x8ZxGZ0MwVEOhNV/snrNfzZaYARZsGLetmoL5Sd7a7F6AqVA1XQF/4X7BCDzdtn/+Ni+Yhu5ENVBVmblUPwd6fSU0iYrJ0hqiVMqJPazLaobwFetg6rnF2qV0/J7Ji07VANh/7AlHU=
Received: from BYAPR12MB3479.namprd12.prod.outlook.com (2603:10b6:a03:dc::26)
 by BY5PR12MB4019.namprd12.prod.outlook.com (2603:10b6:a03:1a8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Sun, 10 Jan
 2021 18:49:21 +0000
Received: from BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::c0e3:82e9:33d2:9981]) by BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::c0e3:82e9:33d2:9981%6]) with mapi id 15.20.3742.012; Sun, 10 Jan 2021
 18:49:21 +0000
X-SNPS-Relay: synopsys.com
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] ARC fixes for 5.11-rc3
Thread-Topic: [GIT PULL] ARC fixes for 5.11-rc3
Thread-Index: AQHW54FOC9sYkPbEdUqwJe8J8rsWEw==
Date:   Sun, 10 Jan 2021 18:49:21 +0000
Message-ID: <0d1b3ae6-2a67-9531-7a41-a4d5d00793ea@synopsys.com>
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
x-ms-office365-filtering-correlation-id: a53bd864-b4cb-40fb-f0b2-08d8b5987136
x-ms-traffictypediagnostic: BY5PR12MB4019:
x-microsoft-antispam-prvs: <BY5PR12MB4019AB10CF7D4C90021EDB63B6AC0@BY5PR12MB4019.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1107;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pO7YdNcocSZhDbLkqixnyoZAEumGOrXUAtIOigxwVYgeRwvY2NXs8HHLT2fY+sKbLHq8QG7fhZqxV015KlqVNy+rIvQQjwRxxAha2QkgCT3oFTIVyeOpCivJNVrnf5q52s9SsLwNLUWU4EMD5gdciwQjENBFMR83cNu/epYPOtgm2fVijyX3o4AbuvxcEWHPIUkma2Fgvn/jcbWyQl75JQYJeDXFn7rFG2bCscSW8HdgTNDnDm90ONCTHxIlXLMA0uAFvUTP8e0SxIWoIg1qPblmJX4F9LAngCw+SOg9uu0W/zQY933EX/W/B2Slwukc8gGRmZbK7QDi6DewLrbdTRx7jold1qHvenKKym/y2Apr3aEQnHrWGY0EfVOa6J9mZ76J2O0liHnSpoChQA+WHjybQi2slfn05HzH8L4om4Ni10/o5gvbdyAJVpCdcP2hjguX/y1CyEMcv40JoZKgeR+FUSSmykcUkjlk2DHblpM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3479.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39850400004)(366004)(376002)(346002)(396003)(6512007)(31696002)(6916009)(186003)(5660300002)(6486002)(26005)(4326008)(316002)(83380400001)(2906002)(8676002)(2616005)(71200400001)(54906003)(6506007)(36756003)(478600001)(64756008)(86362001)(76116006)(66476007)(66556008)(31686004)(8936002)(66446008)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?ZDBodWw1SlQwQTg2OGZjK2ZpbUdPLzBPSmdkNXFZU3pXZS9ET0Yxa1dDTTQ4?=
 =?utf-8?B?ZjdheCtzMHlGVHFxakRreCtQdHFRY1FHUU5BNHk5bnQ5NTFESmZreFltQUFx?=
 =?utf-8?B?ZWZQT3dVRGIzSjcwVzJKVVIzNlpBZytRbjZGNXgwTTFieUdEdEFOWUIxK3hi?=
 =?utf-8?B?TVBEWkRyS1ZNTE12cFIzTDRYL1BjWThUY2luN1VqbnFaQ2x0REUvSUUrWlg5?=
 =?utf-8?B?bmMxekMrSnYvN1dDeC9jK3U0eUJHWTFzQkExSTczZHBZWDV3d2FrcFJIamZn?=
 =?utf-8?B?QWNzK01FOG9XazRvSng1d2xIMVVBSlByQ1lGL0poaGJSS0s3L0lBclNyWExt?=
 =?utf-8?B?Z2laak1kRHV5WkQ3VGFHbDNvWWJZVGRBcHNndFNpMUphT1pyL3ArWUNyamRT?=
 =?utf-8?B?QjNaRjE2VUlHZkFENmlKV3Y1YXkzWGxWSlREZ0d3OEQ0OTZoeFFwalNtSlBC?=
 =?utf-8?B?cU5PZHIxOWZqZkNsNi9DTkgzYm9DOTNwb0tTREQ3WGxubHBVbytvNUE0NXJz?=
 =?utf-8?B?RGtvVm40cHRNYjgrc1J0QlZIQjlDS0d6S1ZSYWRPVFFrc3F3YzlJMlpxdklY?=
 =?utf-8?B?bEFkTDBiMHYrMy8wbUh4NXM4aWlmNXIzd3ZaaTBDSUs4Vi95bDA5ajg3bFox?=
 =?utf-8?B?dnkySGRkc0NDTVgrOHdvMGtVcFB3WlRYOXFqSUNoTy9lQjl3QjFTRDlYSVRp?=
 =?utf-8?B?TXhldlpqbytKWWh2bEN2VmE3dURaNERxcU1NN0lZamZCcFpOY2QrdVlpRTVV?=
 =?utf-8?B?VVJBY1A5UDhDcFAzV1p0SjdIYkNyOU14a0FDOGk4SldWTkxJcktxMm1wMjd1?=
 =?utf-8?B?RU5QV3Y4eXVsWmRhVGsrRjhKUmFXc2NuVVF2QVhHdmM4cjd2SUF5azB3OFM5?=
 =?utf-8?B?ZStuaVF1SXZBQ2FXL1FlSzMvdm03L1RXVE9ZYlEwNVl5aXBDWkZlUm0zb055?=
 =?utf-8?B?aVNaTnJ5cy90Rm95RjVEVktZd1ZIU0pKQms0NTN5ZjQzRFUvZUQ3elU0TUs4?=
 =?utf-8?B?T0ZXWUdYSUg1TkxwLy9UcnJGa3FQYVdDQUtFemtHU0RhNHZsMDNwSG9VaXBl?=
 =?utf-8?B?YzM2SjBsVVF5am9hTWZmNUpPZVIvWENBRGhmQkNOelVNTnVXWDdCL1BXd0FU?=
 =?utf-8?B?anlHcUdueGtBRXhSN3N1NGNUSjl3WTNmemhkcDR4UjRZMWkwdzVBMWhmTFd1?=
 =?utf-8?B?MnBEdVBseHhSSXZlRTR3TXY1RXpKT0hzc0VKRTdpWGhtV3FpKzZxbzlLM2pD?=
 =?utf-8?B?QndONGdNLzdoTmE4clU1bWV2bWNrcHlhQXlIWEgwemF3S3N6Uy9jc2h4cTRY?=
 =?utf-8?Q?J0aTfZ7Bl/YaA=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <A54D5ECB68A10A4AB9B8F0A7A14D4DB3@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3479.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a53bd864-b4cb-40fb-f0b2-08d8b5987136
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2021 18:49:21.0908
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fkuPJ8Y9tVKD48yjsqibwZrVq2kJcpcfy5V4OAt8pZ15GuIhkZ/fNZHK+PN5UszsWs/dul2zadz4pDR78uMk9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4019
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTGludXMsDQoNCkkgcmFuIGludG8gYm9vdCBmYWlsdXJlcyBvbiBBUkMsIHdoaWNoIHdlbnQg
dW5ub3RpY2VkLiBUaGlzIHB1bGwgcmVxdWVzdCANCmFkZHJlc3NlcyB0aGF0Lg0KDQpUaHgsDQot
VmluZWV0DQotLS0tLS0tLS0tLS0tLS0tLS0+DQpUaGUgZm9sbG93aW5nIGNoYW5nZXMgc2luY2Ug
Y29tbWl0IGY2ZTdhMDI0YmZlNWUxMWQ5MWNjZmY0NmJiNTc2ZTNmYjVhNTE2ZWE6DQoNCiAgIE1l
cmdlIHRhZyAnYXJjLTUuMTEtcmMzJyBvZiANCmdpdDovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20v
bGludXgva2VybmVsL2dpdC92Z3VwdGEvYXJjICgyMDIxLTAxLTA1IA0KMTI6NDY6MjcgLTA4MDAp
DQoNCmFyZSBhdmFpbGFibGUgaW4gdGhlIEdpdCByZXBvc2l0b3J5IGF0Og0KDQogICBnaXQ6Ly9n
aXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdmd1cHRhL2FyYy5naXQvIA0K
dGFncy9hcmMtNS4xMS1yYzMtZml4ZXMNCg0KZm9yIHlvdSB0byBmZXRjaCBjaGFuZ2VzIHVwIHRv
IGU4ZGVlZTRmMTU0M2VkYTliNzUyNzhmNjMzMjJmNDEyY2FkNTJmNmE6DQoNCiAgIEFSQzogW2hz
ZGtdOiBFbmFibGUgRlBVX1NBVkVfUkVTVE9SRSAoMjAyMS0wMS0wOCAxMzo0Njo1OCAtMDgwMCkN
Cg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLQ0KQVJDIGZpeGVzIGZvciA1LjExLXJjMw0KDQogIC0gQWRkcmVzcyB0aGUgMm5k
IGJvb3QgZmFpbHVyZSBkdWUgdG8gc25hZnUgaW4gc2lnbmFsIGhhbmRsaW5nIGNvZGUNCiAgICAo
Zmlyc3Qgd2FzIGdlbmVyaWMgY29uc29sZSB0dHludWxsIGlzc3VlKQ0KDQogIC0gbWlzY2xsIG90
aGVyIGZpeGVzDQoNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0NClJhbmR5IER1bmxhcCAoMSk6DQogICAgICAgYXJjaC9hcmM6
IGFkZCBjb3B5X3VzZXJfcGFnZSgpIHRvIDxhc20vcGFnZS5oPiB0byBmaXggYnVpbGQgZXJyb3Ig
DQpvbiBBUkMNCg0KVmluZWV0IEd1cHRhICgzKToNCiAgICAgICBpbmNsdWRlL3NvYzogcmVtb3Zl
IGhlYWRlcnMgZm9yIEVaQ2hpcCBOUFMNCiAgICAgICBBUkM6IHVuYm9yayA1LjExIGJvb3R1cDog
Zml4IHNuYWZ1IGluIF9USUZfTk9USUZZX1NJR05BTCBoYW5kbGluZw0KICAgICAgIEFSQzogW2hz
ZGtdOiBFbmFibGUgRlBVX1NBVkVfUkVTVE9SRQ0KDQogIGFyY2gvYXJjL2luY2x1ZGUvYXNtL3Bh
Z2UuaCB8ICAgMSArDQogIGFyY2gvYXJjL2tlcm5lbC9lbnRyeS5TICAgICB8ICAgMiArLQ0KICBh
cmNoL2FyYy9wbGF0LWhzZGsvS2NvbmZpZyAgfCAgIDEgKw0KICBpbmNsdWRlL3NvYy9ucHMvY29t
bW9uLmggICAgfCAxNzIgDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLQ0KICBpbmNsdWRlL3NvYy9ucHMvbXRtLmggICAgICAgfCAgNTkgLS0tLS0tLS0tLS0tLS0t
DQogIDUgZmlsZXMgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAyMzIgZGVsZXRpb25zKC0pDQog
IGRlbGV0ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL3NvYy9ucHMvY29tbW9uLmgNCiAgZGVsZXRlIG1v
ZGUgMTAwNjQ0IGluY2x1ZGUvc29jL25wcy9tdG0uaA0K
